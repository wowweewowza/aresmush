module AresMUSH
  module FS3Skills
    class FocusResetCmd
      include CommandHandler
      
      attr_accessor :name, :focus

      def parse_args
        args = cmd.parse_args(ArgParser.arg1)
        self.focus = integer_arg(args.arg1)
      end

      def required_args
        [ self.name ]
      end
      
      def check_focus
        return t('fs3skills.invalid_focus_points') if self.focus == 0
        return nil
      end
      
      def handle
        ClassTargetFinder.with_a_character(client, enactor) do |model|
          model.reset_focus(self.focus)
          Global.logger.info "Focus Points Reset to #{self.focus} ."
          
          message = t('fs3skills.focus_reset', :name => model.name, :focus => model.focus)
          client.emit_success message      
          
        end
      end
    end
  end
end
