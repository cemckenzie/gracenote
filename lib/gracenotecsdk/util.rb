require 'logger'

module Logging
  def logger
        @logger ||= Logging.logger_for(self.class.name)
    end

    # Use a hash class-ivar to cache a unique Logger per class:
    @loggers = {}

    class << self
        def logger_for(classname)
            @loggers[classname] ||= configure_logger_for(classname)
        end

    def configure_logger_for(classname)
        logger = Logger.new(STDOUT)
        logger.progname = classname
        logger
        end
    end
end

module ErrorReporting
  def error_processing
    peinfo = GnSDK::gnsdk_manager_error_info
    einfo = GnSDK::GnsdkErrorInfoT.new peinfo
    
    logger.error einfo[:error_api]
    logger.error einfo[:error_description]
    logger.error einfo[:error_code].to_s(16)
    logger.debug einfo[:error_module]
    logger.debug einfo[:source_error_code]
    logger.debug einfo[:source_error_module]
  end

end

module LibC
    extend FFI::Library
    ffi_lib FFI::Library::LIBC

    # call #attach_function to attach to malloc, free, memcpy, bcopy, etc.
    # For example
    attach_function :malloc, [:size_t], :pointer
    attach_function :free, [:pointer], :void
end
