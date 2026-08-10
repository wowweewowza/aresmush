module AresMUSH
  module FS3Skills
    class FocusAwardCmd
      include CommandHandler
      
      attr_accessor :name, :focus

      def parse_args
        args = cmd.parse_args(ArgParser.arg1_equals_arg2)
        self.name = trim_arg(args.arg1)
        self.focus = integer_arg(args.arg2)
      end

      def required_args
        [ self.name, self.focus ]
      end
      
      def check_focus
        return t('fs3skills.invalid_focus_points') if self.focus == 0
        return nil
      end
      
      def check_can_award
        return nil if FS3Skills.can_manage_focus?(enactor)
        return t('dispatcher.not_allowed')
      end
      
      def handle
        ClassTargetFinder.with_a_character(self.name, client, enactor) do |model|
          model.award_focus(self.focus)
          Global.logger.info "#{self.focus} Focus Points Added by #{enactor_name} to #{model.name}."
          
          message = t('fs3skills.focus_awarded', :name => model.name, :focus => self.focus)
          client.emit_success message      
          
        end
      end
    end
  end
end
