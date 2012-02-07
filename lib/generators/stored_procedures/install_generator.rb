module StoredProcedures
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)

      desc 'Installs Stored Procedures'
      def copy_initializer
        template "stored_procedures.rb", "config/initializers/stored_procedures.rb"
      end

      def create_directory_structure
        empty_directory "app/stored_procedures"

        [Mongo, Riak].each do |klass|
          empty_directory "app/stored_procedures/#{klass.name.downcase}" if defined? klass
        end
      end
    end
  end
end