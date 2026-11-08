module AresMUSH
  module Website
    
    class TooltipExtensionTemplate < ErbTemplateRenderer
                                  
      def initialize()
        super File.dirname(__FILE__) + "/tooltip.erb"        
      end      
    end

    class TooltipMarkdownExtension
      def self.regex
        /\[\[tooltip ([^\]]*)\]\]/i
      end
      
      def self.parse(matches)
        tooltip = matches[1]
        
        return "" if !tooltip 
       
        template = TooltipExtensionTemplate.new(tooltip)
        template.render
      end
    end
  end
end
