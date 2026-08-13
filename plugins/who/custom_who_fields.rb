module AresMUSH
  module Who
  
    def self.custom_who_field(char, field_type, value, width)
      case field_type
      when 'lookingforrp'
        looking_for_rp = char.looking_for_rp
        case char.looking_for_rp_type
          when "scene"
            flag = "%xgRP%xn"
          when "text"
            flag = "%xmTXT%xn"
        end
        return looking_for_rp ? flag.ljust(width+6) : ""
      else 
        return nil
    end
  end
end