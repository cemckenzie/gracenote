require 'ffi'

module GnSDK
    extend FFI::Library
    ffi_lib "/Users/cmckenzie/Perforce/cm_mavericks1/cddb-gnqa/devel/csdk_video/v2/gracenotecsdk/libgnsdk_manager.dylib"

    FFI.add_typedef(:pointer, :gnsdk_handle_t)
    FFI.add_typedef(:gnsdk_handle_t, :gnsdk_gdo_handle_t)
    FFI.add_typedef(:gnsdk_handle_t, :gnsdk_manager_handle_t)

    typedef :pointer, :callback_data
    typedef :gnsdk_handle_t, :gnsdk_manager_handle_t
    typedef :gnsdk_handle_t, :gnsdk_user_handle_t
    typedef :gnsdk_handle_t, :gnsdk_locale_handle_t
    typedef :gnsdk_handle_t, :gnsdk_user_handle_t
    typedef :uint, :gnsdk_error_t
    typedef :string, :gnsdk_cstr_t
    typedef :pointer, :gnsdk_str_t
    typedef :ushort, :gnsdk_uint16_t
    typedef :uint, :gnsdk_uint32_t
    typedef :int, :gnsdk_int32_t
    typedef :float, :gnsdk_flt32_t
    typedef :ulong_long, :gnsdk_uint64_t
    typedef :size_t, :gnsdk_size_t
    typedef :char, :gnsdk_bool_t

    callback :gnsdk_user_callback, [:pointer, :gnsdk_cstr_t], :void
    callback :gnsdk_status_callback, [:pointer, :int, :gnsdk_uint32_t, :gnsdk_size_t, :gnsdk_size_t, :pointer], :void

#******************************************************************************

    # Basic functions
    attach_function :gnsdk_manager_initialize, [ :gnsdk_manager_handle_t, :gnsdk_cstr_t, :gnsdk_size_t ], :gnsdk_error_t
    attach_function :gnsdk_manager_shutdown, [], :gnsdk_error_t
    attach_function :gnsdk_manager_get_version, [], :gnsdk_cstr_t
    attach_function :gnsdk_manager_get_version, [], :gnsdk_cstr_t
    attach_function :"gnsdk_manager_get_build_date", [], :string
    attach_function :gnsdk_manager_get_globalid_magic, [], :gnsdk_cstr_t
    attach_function :gnsdk_manager_test_gracenote_connection, [:gnsdk_user_handle_t, :pointer], :gnsdk_error_t
    attach_function :gnsdk_manager_string_free, [ :gnsdk_str_t ], :gnsdk_error_t
    attach_function :gnsdk_manager_user_create, [ :gnsdk_cstr_t, :gnsdk_cstr_t,:pointer ], :gnsdk_error_t

# User functions
    attach_function :gnsdk_manager_user_register, [ :gnsdk_cstr_t, :gnsdk_cstr_t, :gnsdk_cstr_t, :gnsdk_cstr_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_user_set_autoregister, [:gnsdk_user_handle_t, :gnsdk_user_callback, :pointer], :gnsdk_error_t
    attach_function :gnsdk_manager_user_is_localonly, [:gnsdk_user_handle_t, :pointer], :gnsdk_error_t
    attach_function :gnsdk_manager_user_release, [ :gnsdk_user_handle_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_user_option_set, [ :gnsdk_user_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t ], :gnsdk_error_t
    attach_function :gnsdk_manager_user_option_get, [ :gnsdk_user_handle_t, :gnsdk_cstr_t, :pointer ], :gnsdk_error_t

# Logging functions
    attach_function :gnsdk_manager_logging_register_package, [ :gnsdk_uint16_t, :gnsdk_cstr_t ], :gnsdk_error_t
    attach_function :gnsdk_manager_logging_enable, [ :gnsdk_cstr_t, :gnsdk_uint16_t, :gnsdk_uint32_t, :gnsdk_uint32_t, :gnsdk_uint64_t, :gnsdk_bool_t ], :gnsdk_error_t
    attach_function :gnsdk_manager_logging_disable, [ :gnsdk_cstr_t, :gnsdk_uint16_t ], :gnsdk_error_t
    attach_function :gnsdk_manager_logging_write, [ :gnsdk_int32_t, :gnsdk_cstr_t, :gnsdk_uint16_t, :gnsdk_uint32_t, :gnsdk_cstr_t, :varargs ], :gnsdk_error_t
    attach_function :gnsdk_manager_logging_vwrite, [ :gnsdk_int32_t, :gnsdk_cstr_t, :gnsdk_uint16_t, :gnsdk_uint32_t, :gnsdk_cstr_t, :string ], :gnsdk_error_t

#Locale functions
    attach_function :gnsdk_manager_locale_load, [ :gnsdk_cstr_t, :gnsdk_cstr_t, :gnsdk_cstr_t, :gnsdk_cstr_t, :gnsdk_user_handle_t, :gnsdk_status_callback, :callback_data, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_locale_set_group_default, [ :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_locale_unset_group_default, [ :gnsdk_cstr_t ], :gnsdk_error_t
    attach_function :gnsdk_manager_locale_info, [ :gnsdk_locale_handle_t, :pointer, :pointer, :pointer, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_locale_deserialize, [ :gnsdk_cstr_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_locale_serialize, [ :gnsdk_locale_handle_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_locale_release, [ :gnsdk_locale_handle_t ], :gnsdk_error_t
    attach_function :gnsdk_manager_locale_update, [ :gnsdk_locale_handle_t, :gnsdk_user_handle_t, :gnsdk_status_callback, :callback_data, :pointer ], :gnsdk_error_t

# Misc functions
    attach_function :gnsdk_manager_internals, [ :gnsdk_uint32_t, :pointer, :pointer, :gnsdk_bool_t ], :gnsdk_error_t
    attach_function :gnsdk_manager_memory_warn, [ :gnsdk_status_callback, :callback_data, :gnsdk_size_t ], :gnsdk_error_t

# GDO functions
    attach_function :gnsdk_manager_gdo_get_type, [ :pointer, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_gdo_is_type, [ :pointer, :string ], :gnsdk_error_t
    attach_function :gnsdk_manager_gdo_value_count, [ :pointer, :string, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_gdo_value_get, [ :pointer, :string, :gnsdk_uint32_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_gdo_child_count, [ :pointer, :string, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_gdo_child_get, [ :pointer, :string, :gnsdk_uint32_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_gdo_serialize, [ :pointer, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_gdo_deserialize, [ :pointer, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_gdo_render, [ :pointer, :gnsdk_uint32_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_gdo_render_to_xml, [ :pointer, :gnsdk_uint32_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_gdo_set_locale, [ :pointer, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_gdo_addref, [ :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_gdo_release, [ :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_gdo_create_from_xml, [ :string, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_manager_gdo_create_from_id, [ :string, :string, :string, :pointer ], :gnsdk_error_t

    class GnsdkErrorInfoT < FFI::Struct
        layout(
        :error_code, :gnsdk_error_t,
        :source_error_code, :gnsdk_error_t,
        :error_description, :string,
        :error_api, :string,
        :error_module, :string,
        :source_error_module, :string
        )
    end

    attach_function :gnsdk_manager_error_info, [ ], :pointer

    class Locale
        include Logging
        include ErrorReporting

        def initialize
            @lOptions = Hash.new()
            $locale_handle = FFI::MemoryPointer.new(:pointer, 1)
            @lgrp = GnSDK::GNSDK_LOCALE_GROUP_ACR
            @lang = GnSDK::GNSDK_LANG_ENGLISH
            @ctry = GnSDK::GNSDK_REGION_US
            @desc = GnSDK::GNSDK_DESCRIPTOR_DETAILED
        end

        def hello
          puts "HelloLocale, world"
        end

        #Function to specify locale options.
        def setLocaleOptions(option, value)
            @lOptions[option].delete
            @lOptions[option] = value
        end

        def cleanUp
        end

        #Function to set locale properties.
        def setLocale
            if @lOptions.count
                @lOptions.each do | key, value |
                    case key
                      when :locale_group
                        @lgrp = @@lOptions[:locale_group]
                      when :locale_language
                        @lang = @lOptions[:locale_language]
                      when :locale_country
                        @ctry = @lOptions[:locale_country]
                      when :locale_descriptor
                        @desc = @lOptions[:locale_descriptor]
                    end
                end
            end
        end

        def loadLocale(user_handle)
            catch(:error) do
                logger.debug @lgrp
                logger.debug @lang
                logger.debug @ctry
                logger.debug @desc
                logger.debug user_handle
                logger.debug $locale_handle
                $error_gnsdk = GnSDK::gnsdk_manager_locale_load( @lgrp, @lang, @ctry, @desc, user_handle, nil, nil, $locale_handle)

                $locale_handle = $locale_handle.get_pointer(0)
                error_processing() unless $error_gnsdk == 0

                $error_gnsdk = GnSDK::gnsdk_manager_locale_set_group_default($locale_handle)
                error_processing() unless $error_gnsdk == 0

                $error_gnsdk = GnSDK::gnsdk_manager_locale_release($locale_handle)
                error_processing() unless $error_gnsdk == 0

                return $error_gnsdk
            end
        end

        def error_processing_no_throw
            peinfo = GnSDK::gnsdk_manager_error_info
            einfo = GnSDK::GnsdkErrorInfoT.new peinfo
            
            logger.error einfo[:error_api]
            logger.error einfo[:error_description]
            logger.error einfo[:error_code].to_s(16)
            logger.debug einfo[:error_module]
            logger.debug einfo[:source_error_code]
            logger.debug einfo[:source_error_module]
        end

        def error_processing
            error_processing_no_throw
            throw(:error)
        end

        def shutdown
            GnSDK::gnsdk_manager_locale_release($locale_handle);
        end
    end
end
