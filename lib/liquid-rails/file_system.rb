require 'liquid/file_system'

module Liquid
  module Rails
    class FileSystem < ::Liquid::LocalFileSystem
      def initialize(root, pattern = "_%s.#{::Liquid::Rails.file_ext}".freeze)
        super
      end
      
      def read_template_file(template_path, context)
        controller_path = context.registers[:controller].controller_path
        template_path   = "#{controller_path}/#{template_path}" unless template_path.include?('/')
        super
      end
    end
  end
end
