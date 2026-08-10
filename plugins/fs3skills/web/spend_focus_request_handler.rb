module AresMUSH
  module FS3Skills
    class SpendFocusRequestHandler
      def handle(request)
        scene = Scene[request.args['scene_id']]
        enactor = request.enactor
        sender_name = request.args['sender']
        reason = request.args['reason']
        amount = request.args['amount'].to_i
        
        request.log_request
        
        error = Website.check_login(request)
        return error if error
        
        if (!scene)
          return { error: t('webportal.not_found') }
        end
        
        sender = Character.named(sender_name)
        if (!sender)
          return { error: t('webportal.not_found') }
        end
        
        if (!AresCentral.is_alt?(sender, enactor))
          return { error: t('dispatcher.not_allowed') }
        end
        
        if (!Scenes.can_read_scene?(enactor, scene))
          return { error: t('scenes.access_not_allowed') }
        end
        
        if (scene.completed)
          return { error: t('scenes.scene_already_completed') }
        end
        
        if (sender.focus < 1)
          return { error: t('fs3skills.no_focus') }
        elsif (sender.focus < amount)
          Global.logger.error "focus is less than the amount yet the error is not appearing"
          return { error: t('fs3skills.not_enough_focus') }
        end
        FS3Skills.spend_focus(sender, amount, reason, scene)
       
        {
        }
      end
    end
  end
end