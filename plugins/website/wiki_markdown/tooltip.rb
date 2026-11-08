module AresMUSH
  module Website
    
    class TooltipExtensionTemplate < ErbTemplateRenderer
                                  
      def initialize(tooltip)
        @tooltip = tooltip
        super File.dirname(__FILE__) + "/tooltip.erb"        
      end      
    end

    class TooltipMarkdownExtension
      def self.regex
        /\[\[tooltip ([^\]]*)\]\]/i
      end
      
      def self.parse(matches)
        input = matches[1]
        
        return "" if !input

        tooltip_name = input.before("|") || input
        tooltip_text = input.after("|") || ""


        tooltip = [tooltip_name, tooltip_text]
       
        template = TooltipExtensionTemplate.new(tooltip)
        template.render
      end
    end
  end
end
