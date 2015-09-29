module Liquid
  module Rails
    class LayoutTag < ::Liquid::Tag
      def initialize(tag_name, layout, context)
        super
      end
      
      def render(context)
        ""
      end
      
      def self.extract_layout_tag(file)
        content = File.read(file)
        puts content
      end
      
    end
  end
end

Liquid::Template.register_tag('layout', Liquid::Rails::LayoutTag)