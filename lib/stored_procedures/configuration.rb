module StoredProcedures
  module Configuration
    extend ActiveSupport::Concern

    included do
      add_config :mongo_connection
      add_config :riak_connection
    end

    module ClassMethods
      def configure &block
        instance_exec &block
      end

      private
      def add_config name, options = {}
        options[:with] ||= "@@#{name}"

        class_eval <<-RUBY
          class << self
            def #{name} new_#{name} #{'= nil' unless options[:setter]}
              #{options[:with]} = new_#{name} #{"unless new_#{name}.nil?" unless options[:setter]}
              #{options[:with] unless options[:setter]}
            end

            def #{name}= new_#{name}
              #{options[:with]} = new_#{name}
            end
          end
        RUBY

        send "#{name}=", nil
      end

      def add_setter name, options = {}
        add_config name, {:setter => true}.merge(options)
      end
    end
  end
end