require 'log4r'
require 'sud/shared_helpers'

module Sud
    class Logger < Log4r::Logger
        def initialize(_fullname, _level=nil, _additive=true, _trace=false)
            super(_fullname, _level || Sud.log_level, _additive, _trace)

            @outputters << Log4r::Outputter.stdout
        end
    end
end
