require 'log4r'

require 'sud/logger'
require 'sud/shared_helpers'

require 'rubygems'

require 'i18n'

# Always make the version available
require 'sud/version'
logger = Sud::Logger.new('sud')
Sud.logger = logger
logger.debug("Sud version: #{Sud::VERSION}")
logger.debug("Ruby version: #{RUBY_VERSION}")
logger.debug("RubyGems version: #{Gem::VERSION}")

module Sud
    autoload :Errors, 'sud/errors'

    def self.version?(*requirements)
        req = Gem::Requirement.new(*requirements)
        req.satisfied_by?(Gem::Version.new(VERSION))
    end

    def self.require_version(*requirements)
        logger = Sud::Logger.new('sud::root')
        logger.info("Version requirements from Sudfile: #{requirements.inspect}")

        if version?(*requirements)
            logger.info("\t- Version requirements satisfied!")
            return
        end

        raise Errors::SudVersionBad, requirements: requirements.join(', '), version: VERSION
    end
end

I18n.load_path << File.expand_path('templates/locales/en.yml', Sud.source_root)
