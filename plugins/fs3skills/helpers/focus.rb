module AresMUSH
  module FS3Skills
    def self.can_manage_focus?(actor)
      actor && actor.has_permission?("manage_abilities")
    end
    
    def self.modify_focus(char, amount)
      willpower_attr = char.fs3_attributes.detect { |a| a.name == "Willpower" }
      willpower_rating = target_attr&.rating
      max_focus = willpower_rating * 2
      focus = char.focus + amount
      focus = [max_focus, focus].min
      focus = [0, focus].max
      char.update(wow_focus: focus)
    end

    def self.reset_focus(char)
      willpower_attr = char.fs3_attributes.detect { |a| a.name == "Willpower" }
      willpower_rating = target_attr&.rating
      max_focus = willpower_rating * 2
      char.update(wow_focus: max_focus)
    end
    
    def self.spend_focus(char, amount, reason, scene)
      char.spend_focus(amount)
      message = t('fs3skills.focus_point_spent', :name => char.name, :reason => reason)

      if (scene)
        scene.room.emit_ooc message
        Scenes.add_to_scene(scene, message)
      else
        char.room.emit_ooc message
      end
      
      # Achievements.award_achievement(char, "fs3_luck_spent")
      
      Global.logger.info "#{char.name} spent focus on #{reason}."
    end
  end
end
