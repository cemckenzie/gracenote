require 'ffi'
require 'logger'
require './lib/gracenotecsdk/util'

module GnSDK

  class Session
    include Logging
    include ErrorReporting

    attr_accessor :managr_handle, :user_handle, :new_user, :nw_user, :count, :type

    def initialize
        logger.level = Logger::DEBUG
        $managr_handle = FFI::MemoryPointer.new(:pointer, 1)
        $user_handle = FFI::MemoryPointer.new(:pointer, 1)

        $error_gnsdk = 0
        $count = 0
        $type = 0
        uOptions = {}
    end

    def hello
      puts "HelloSession, world"
    end

    def start_session_logging
        catch(:error) do
            $error_gnsdk = GnSDK::gnsdk_manager_logging_enable('session'+ '.log', 0xFF, 0x0000000F, 0xFF000000, 0, 0)
            error_processing() unless $error_gnsdk == 0
        end
    end

    def stop_session_logging
        catch(:error) do
            $error_gnsdk = GnSDK::gnsdk_manager_logging_disable('session' + '.log', 0x80+0x5F+0x01+0x01)
            error_processing() unless $error_gnsdk == 0
        end
    end

    #Function to specify User options.
    def setUserOptions option, value
        uOptions[option].delete
        uOptions[option] = value
    end

    def gnsdk_init license_path, client_id, client_id_tag, user_path, user_type
        #initialize manager

        catch(:error) do
        if File.file?( license_path ) 
            $error_gnsdk = GnSDK::gnsdk_manager_initialize($managr_handle, license_path, GNSDK_MANAGER_LICENSEDATA_FILENAME)
            $managr_handle = $managr_handle.get_pointer(0)
            error_processing() unless $error_gnsdk == 0
        end
        start_session_logging

        $error_gnsdk = GnSDK::gnsdk_storage_sqlite_initialize $managr_handle
        error_processing() unless $error_gnsdk == 0

        logger.debug "gnsdk is initialized"

        #initialize user
        if File.file?(user_path)
            seruser = File.open("user.txt", "r")
            user = seruser.read
            seruser.close
            $error_gnsdk = GnSDK::gnsdk_manager_user_create(user, client_id, $user_handle)
            error_processing() unless $error_gnsdk == 0
            $user_handle = $user_handle.get_pointer(0) unless $user_handle == nil
        end

        logger.debug "gnsdk saved user is initialized"
        logger.debug $user_handle

        # if we didn't have a saved user or that user was not the one
        if $user_handle == nil
            @new_user = FFI::MemoryPointer.new(:pointer, 1)

            if user_type == "online"
                utype = gnsdk_user_register_mode_online
            elsif user_type == "local"
                utype = gnsdk_user_register_mode_local
            end

            $error_gnsdk = GnSDK::gnsdk_manager_user_register( utype, client_id, client_id_tag, "1.0", @new_user)
            error_processing() unless $error_gnsdk == 0


            @new_user = @new_user.get_pointer(0)
            $error_gnsdk = GnSDK::gnsdk_manager_user_create(@new_user, client_id, $user_handle)
            error_processing() unless $error_gnsdk == 0

            if $user_handle != nil
                $user_handle = $user_handle.get_pointer(0)
            end

            # save the user
            userfile = File.open("user.txt", "w")
            userfile.puts @new_user.get_array_of_string(0, 1)
            userfile.close
        end

        logger.debug "user is registered"
        return $user_handle
        end
    end # def gnsdk_init

    def cleanUp
    end

    def shutdown
        stop_session_logging
    end

    end # Class Session
end # Module GnSDK
