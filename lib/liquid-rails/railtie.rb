module Liquid
  module Rails
    class Railtie < ::Rails::Railtie
      config.app_generators.template_engine :liquid
      
      initializer "liquid-rails.load_app_instance_data" do |app|
        Liquid::Rails.setup do |config|
          config.file_ext = ::Rails.application.config.template_file_ext if ::Rails.application.config.respond_to?(:template_file_ext, true)
        end
      end
      
      initializer 'liquid-rails.register_template_handler' do |app|
        ActiveSupport.on_load(:action_view) do
          ActionView::Template.register_template_handler(::Liquid::Rails.file_ext.to_sym, Liquid::Rails::TemplateHandler)
        end
      end

      initializer 'liquid-rails.include_partial' do |app|
        template_path = ::Rails.root.join('app/views')
        Liquid::Template.file_system = Liquid::Rails::FileSystem.new(template_path)
      end

      initializer 'liquid-rails.setup_drop' do |app|
        [:active_record, :mongoid].each do |orm|
          ActiveSupport.on_load orm do
            Liquid::Rails.setup_drop self
          end
        end
      end
    end
  end
end