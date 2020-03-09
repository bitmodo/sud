require 'pathname'

module Sud
    def self.log_level=(level)
        if level.is_a?(String)
            require 'log4r/config'
            Log4r.define_levels(*Log4r::Log4rConfig::LogLevels)

            old_level = level
            begin
                level = Log4r.const_get(level.upcase)
            rescue NameError
                level = nil
            end

            level = nil if !level.is_a?(Integer)

            if !level
                $stderr.puts "Invalid log level is set: #{old_level}"
                $stderr.puts ''
                $stderr.puts 'Please use one of the standard log levels: debug, info, warn, or error'
                exit 1
            end
        end

        @_log_level = level
    end

    def self.log_level
        if @_log_level.nil?
            require 'log4r/config'
            Log4r.define_levels(*Log4r::Log4rConfig::LogLevels)

            level = nil
            begin
                level = Log4r.const_get((ENV['SUD_LOG'] || 'info').upcase)
            rescue NameError
                level = nil
            end

            level = nil if !level.is_a?(Integer)

            if !level
                $stderr.puts "Invalid SUD_LOG level is set: #{ENV['SUD_LOG']}"
                $stderr.puts ''
                $stderr.puts 'Please use one of the standard log levels: debug, info, warn, or error'
                exit 1
            end

            @_log_level = level
        end

        @_log_level
    end

    def self.source_root
        @source_root ||= Pathname.new(File.expand_path('../../../', __FILE__))
    end

    def self.logger=(log)
        @_logger = log
    end

    def self.logger
        if @_logger.nil?
            require 'logger'
            @_logger = Sud::Logger.new('sud')
        end
        @_logger
    end
end
