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
        tooltip = matches[1]
        
        return "" if !tooltip 
       
        template = CollapsibleExtensionTemplate.new(tooltip)
        template.render
      end
    end
  end
end
