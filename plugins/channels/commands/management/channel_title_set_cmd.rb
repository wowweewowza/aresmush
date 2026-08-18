module AresMUSH
  module Channels
    class ChannelTitleSetCmd
      include CommandHandler
           
      attr_accessor :char_name, :channel_name, :title
      
      def parse_args
        args = cmd.parse_args(ArgParser.arg1_slash_arg2_equals_optional_arg3)
        self.char_name = titlecase_arg(args.arg1)
        self.channel_name = titlecase_arg(args.arg2)
        self.title = trim_arg(args.arg3)
      end
      
      def required_args
        [ self.char_name, self.channel_name ]
      end
      
      def check_permission
        return t('dispatcher.not_allowed') if !Channels.can_manage_channels?(enactor)
        return nil
      end
      
      def handle
        Channels.with_an_enabled_channel(self.channel_name, client, enactor) do |channel|
          options = Channels.get_channel_options(enactor, channel)
          options.update(title: self.title)
          client.emit_success t('channels.title_set')
        end
      end
    end  
  end
end