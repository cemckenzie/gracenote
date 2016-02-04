require 'nokogiri'

module GnSDK
  extend FFI::Library
  ffi_lib "/Users/cmckenzie/Perforce/cm_mavericks1/cddb-gnqa/devel/csdk_video/v2/gracenotecsdk/libgnsdk_musicid.dylib"

FFI.add_typedef(:pointer, :gnsdk_video_query_handle_t)

typedef :pointer, :callbacks
typedef :pointer, :callback_data
typedef :pointer, :gnsdk_musicid_query_handle_t
typedef :pointer, :gnsdk_musicid_query_handle_t_pointer
typedef :pointer, :gnsdk_manager_handle_t
typedef :pointer, :gnsdk_user_handle_t
typedef :pointer, :gnsdk_user_handle_t
typedef :uint, :gnsdk_error_t
typedef :uint, :gnsdk_uint32_t
typedef :int, :gnsdk_int32_t
typedef :float, :gnsdk_flt32_t
typedef :pointer, :gnsdk_str_t
typedef :string, :gnsdk_cstr_t

attach_function :gnsdk_musicid_initialize, [ :gnsdk_manager_handle_t ], :gnsdk_error_t
attach_function :gnsdk_musicid_shutdown, [  ], :gnsdk_error_t
attach_function :gnsdk_musicid_get_version, [  ], :gnsdk_cstr_t
attach_function :gnsdk_musicid_get_build_date, [  ], :gnsdk_cstr_t
attach_function :gnsdk_musicid_query_create, [ :gnsdk_user_handle_t, :callbacks, :callback_data, :gnsdk_musicid_query_handle_t_pointer ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_release, [ :gnsdk_musicid_query_handle_t ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_set_toc_string, [ :gnsdk_musicid_query_handle_t, :gnsdk_cstr_t ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_add_toc_offset, [ :gnsdk_musicid_query_handle_t, :gnsdk_uint32_t ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_set_text, [ :gnsdk_musicid_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_set_fp_data, [ :gnsdk_musicid_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_get_fp_data, [ :gnsdk_musicid_query_handle_t, :pointer ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_set_gdo, [ :gnsdk_musicid_query_handle_t, :gnsdk_gdo_handle_t ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_fingerprint_begin, [ :gnsdk_musicid_query_handle_t, :gnsdk_cstr_t, :gnsdk_uint32_t, :gnsdk_uint32_t, :gnsdk_uint32_t ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_fingerprint_write, [ :gnsdk_musicid_query_handle_t, :pointer, :gnsdk_size_t, :pointer ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_fingerprint_end, [ :gnsdk_musicid_query_handle_t ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_option_set, [ :gnsdk_musicid_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_option_get, [ :gnsdk_musicid_query_handle_t, :gnsdk_cstr_t, :pointer ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_find_albums, [ :gnsdk_musicid_query_handle_t, :pointer ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_find_tracks, [ :gnsdk_musicid_query_handle_t, :pointer ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_find_lyrics, [ :gnsdk_musicid_query_handle_t, :pointer ], :gnsdk_error_t
attach_function :gnsdk_musicid_query_find_matches, [ :gnsdk_musicid_query_handle_t,:pointer ], :gnsdk_error_t
end #GNSDK module

class Musicid
    include ManagerLib
    include Logging
    include ErrorReporting
    attr_accessor :musicid_query, :query_gdo, :musicid_gdo, :seasons_gdo, :value, :rendered_xml_ptr

    def initialize
        @session = Session.new()
        @qOptions = Hash.new()
        @tOptions = Hash.new()
        String @queryTui = nil
        String @queryTag = nil
        String @queryType = nil
        $musicid_responses = Array.new
        $query_gdo= FFI::MemoryPointer.new(:pointer, 1)
        $musicid_query= FFI::MemoryPointer.new(:pointer, 1)
        $musicid_gdo= FFI::MemoryPointer.new(:pointer, 1)
        $seasons_gdo= FFI::MemoryPointer.new(:pointer, 1)
        @musicid_match_done = 0
        $rendered_xml_ptr = FFI::MemoryPointer.new(:pointer, 1)
    end

    def gnsdk_init license_path, client_id, client_id_tag, user_path, user_type
        p license_path
        p client_id
        p client_id_tag
        p user_path
        p user_type
        @session.gnsdk_init license_path, client_id, client_id_tag, user_path, user_type
        # finish inits for Musicid
        catch(:error_gnsdk) do
            $error_gnsdk = GnSDK::gnsdk_musicid_initialize $managr_handle
            error_processing() unless $error_gnsdk == 0
        end
        locale = GnSDK::Locale.new()
        locale.setLocale # VIDEO-DETAILED-US-ENG is default
        locale.loadLocale $user_handle

        error_gnsdk = GnSDK::gnsdk_musicid_query_create($user_handle, nil, nil, $musicid_query);
        error_processing() unless $error_gnsdk == 0
        $musicid_query= $musicid_query.get_pointer(0)
    end

    # for gnsdk_musicid_query_option_set()
    def setQueryOptions(option, value)
        if @qOptions[option] != nil
            @qOptions.delete(option)
        end
        @qOptions[option] = value
    end

    # for gnsdk_musicid_query_set_gdo()
    def setGdoTuiTag(tui, tag, type)
        logger.debug "#{tui} #{tag} #{type}"
        catch(:error_gnsdk) do
            $error_gnsdk = GnSDK::gnsdk_manager_gdo_create_from_id( tui, tag, type, $query_gdo)
            error_processing() unless $error_gnsdk == 0
            $query_gdo = $query_gdo.get_pointer(0)
            $error_gnsdk = GnSDK::gnsdk_musicid_query_set_gdo($musicid_query, $query_gdo )
            error_processing() unless $error_gnsdk == 0

            @qOptions.each do | key, value | # set query options
                $error_gnsdk = GnSDK::gnsdk_musicid_query_option_set($musicid_query, key, value)
                #logger.debug "gnsdk_musicid_query_option_set #{$musicid_query} for #{key} to #{value}"
            end

        end
    end

    # for gnsdk_musicid_text_option_set()
    def setTextOptions(option, value)
        if @tOptions[option] != nil
            @tOptions.delete(option)
        end
        @tOptions[option] = value
    end

    def hello
      puts "HelloMusicid, world"
    end

    def musicidQuery type

        catch(:error_gnsdk) do
            @qOptions.each do | key, value | # set query options
                $error_gnsdk = GnSDK::gnsdk_musicid_query_option_set($musicid_query, key, value)
                #logger.debug "gnsdk_musicid_query_option_set #{$musicid_query} for #{key} to #{value}"
            end

            case type
                when "albums" 
                    $error_gnsdk = GnSDK::gnsdk_musicid_query_find_albums($musicid_query, $musicid_gdo)
                    error_processing() unless $error_gnsdk == 0
                    $musicid_gdo = $musicid_gdo.get_pointer(0)
                when "tracks" 
                    $error_gnsdk = GnSDK::gnsdk_musicid_query_find_tracks($musicid_query, $musicid_gdo)
                    error_processing() unless $error_gnsdk == 0
                    $musicid_gdo = $musicid_gdo.get_pointer(0)
                when "lyrics" 
                    $error_gnsdk = GnSDK::gnsdk_musicid_query_find_lyrics($musicid_query, $musicid_gdo)
                    error_processing() unless $error_gnsdk == 0
                    $musicid_gdo = $musicid_gdo.get_pointer(0)
                when "matches" 
                    $error_gnsdk = GnSDK::gnsdk_musicid_query_find_matches($musicid_query, $musicid_gdo)
                    error_processing() unless $error_gnsdk == 0
                    $musicid_gdo = $musicid_gdo.get_pointer(0)
                else 
                    logger.debug "I don't know type #{type} of musicid query"
            end

            error_gnsdk = GnSDK::gnsdk_manager_gdo_render_to_xml($musicid_gdo, -1, $rendered_xml_ptr)
            error_processing() unless $error_gnsdk == 0
            $rendered_xml_ptr = $rendered_xml_ptr.get_pointer(0)
            #return rendered_xml_ptr.read_string
            return 
        end #catch
    end #musicidQuery
end #musidid class
