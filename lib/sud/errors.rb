module Sud
    module Errors
        class SudError < StandardError
            attr_accessor :extra_data

            def self.error_key(key=nil, namespace=nil)
                define_method(:error_key) { key }
                error_namespace(namespace) if namespace
            end

            def self.error_message(message)
                define_method(:error_message) { message }
            end
            
            def self.error_namespace(namespace)
                define_method(:error_namespace) { namespace }
            end

            def initialize(*args)
                key     = args.shift if args.first.is_a?(Symbol)
                message = args.shift if args.first.is_a?(Hash)
                message ||= {}
                @extra_data    = message.dup
                message[:_key] ||= error_key
                message[:_namespace] ||= error_namespace
                message[:_key] = key if key

                if message[:_key]
                    message = translate_error(message)
                else
                    message = error_message
                end

                super(message)
            end

            def error_message; 'No error message'; end

            def error_namespace; 'sud.errors'; end

            def error_key; nil; end

            def status_code; 1; end

            protected

            def translate_error(opts)
                return nil if !opts[:_key]
                I18n.t("#{opts[:_namespace]}.#{opts[:_key]}", opts)
            end
        end

        class SudVersionBad < SudError
            error_key(:sud_version_bad)
        end
    end
end
