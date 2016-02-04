require 'nokogiri'

module GnSDK
  extend FFI::Library
  ffi_lib "/Users/cmckenzie/Perforce/cm_mavericks1/cddb-gnqa/devel/csdk_video/v2/acr/acr_c/bin/libgnsdk_video.dylib"

  FFI.add_typedef(:pointer, :gnsdk_video_query_handle_t)

  typedef :pointer, :callbacks
  typedef :pointer, :callback_data
  typedef :pointer, :gnsdk_video_query_handle_t_pointer
  typedef :pointer, :gnsdk_manager_handle_t
  typedef :pointer, :gnsdk_user_handle_t
  typedef :uint, :gnsdk_error_t
  typedef :uint, :gnsdk_uint32_t
  typedef :int, :gnsdk_int32_t
  typedef :float, :gnsdk_flt32_t
  typedef :pointer, :gnsdk_str_t
  typedef :string, :gnsdk_cstr_t


#******************************************************************************
#* Initialization APIs
#******************************************************************************/
    attach_function :gnsdk_video_initialize, [:gnsdk_manager_handle_t], :gnsdk_error_t
    attach_function :gnsdk_video_shutdown, [], :gnsdk_error_t
    attach_function :gnsdk_video_get_version, [], :gnsdk_error_t
    attach_function :gnsdk_video_get_build_date, [], :gnsdk_error_t

#******************************************************************************
#* VIDEO Query
#******************************************************************************/
    attach_function :gnsdk_video_query_create, [ :gnsdk_user_handle_t, :callbacks, :callback_data, :gnsdk_video_query_handle_t_pointer], :gnsdk_error_t
    attach_function :gnsdk_video_query_option_set, [ :gnsdk_video_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t ], :gnsdk_error_t
    attach_function :gnsdk_video_query_option_get, [ :gnsdk_video_query_handle_t, :gnsdk_cstr_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_video_query_set_toc_string, [ :gnsdk_video_query_handle_t, :gnsdk_cstr_t, :gnsdk_uint32_t], :gnsdk_error_t
    attach_function :gnsdk_video_query_set_external_id, [ :gnsdk_video_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t, :gnsdk_cstr_t], :gnsdk_error_t
    attach_function :gnsdk_video_query_release, [ :gnsdk_video_query_handle_t ], :gnsdk_error_t
    attach_function :gnsdk_video_query_set_toc_string, [ :gnsdk_video_query_handle_t, :gnsdk_cstr_t, :gnsdk_uint32_t ], :gnsdk_error_t
    attach_function :gnsdk_video_query_set_external_id, [ :gnsdk_video_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t, :gnsdk_cstr_t ], :gnsdk_error_t
    attach_function :gnsdk_video_query_set_filter_by_list_element, [ :gnsdk_video_query_handle_t, :gnsdk_cstr_t, :gnsdk_list_element_handle_t ], :gnsdk_error_t
    attach_function :gnsdk_video_query_set_filter, [ :gnsdk_video_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t ], :gnsdk_error_t
    attach_function :gnsdk_video_query_set_text, [ :gnsdk_video_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t, :int ], :gnsdk_error_t
    attach_function :gnsdk_video_query_set_gdo, [ :gnsdk_video_query_handle_t, :gnsdk_gdo_handle_t ], :gnsdk_error_t

#******************************************************************************
#* VIDEO Find
#******************************************************************************/

    attach_function :gnsdk_video_query_find_products, [ :gnsdk_video_query_handle_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_video_query_find_works, [ :gnsdk_video_query_handle_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_video_query_find_seasons, [ :gnsdk_video_query_handle_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_video_query_find_series, [ :gnsdk_video_query_handle_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_video_query_find_contributors, [ :gnsdk_video_query_handle_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_video_query_find_objects, [ :gnsdk_video_query_handle_t, :pointer ], :gnsdk_error_t
    attach_function :gnsdk_video_query_find_suggestions, [ :gnsdk_video_query_handle_t, :pointer ], :gnsdk_error_t
end

class Video
    include ManagerLib
    include Logging
    include ErrorReporting
    attr_accessor :video_query, :query_gdo, :video_gdo, :seasons_gdo, :value

    def initialize
        @session = Session.new()
        @qOptions = Hash.new()
        @tOptions = Hash.new()
        String @queryTui = nil
        String @queryTag = nil
        String @queryType = nil
        $video_responses = Array.new
        $query_gdo= FFI::MemoryPointer.new(:pointer, 1)
        $video_query= FFI::MemoryPointer.new(:pointer, 1)
        $video_gdo= FFI::MemoryPointer.new(:pointer, 1)
        $seasons_gdo= FFI::MemoryPointer.new(:pointer, 1)
        @video_match_done = 0
    end

    def gnsdk_init license_path, client_id, client_id_tag, user_path, user_type
        @session.gnsdk_init license_path, client_id, client_id_tag, user_path, user_type
        # finish inits for Video
        catch(:error_gnsdk) do
            $error_gnsdk = GnSDK::gnsdk_video_initialize $managr_handle
            error_processing() unless $error_gnsdk == 0
        end
        locale = GnSDK::Locale.new()
        locale.hello
        locale.setLocale # VIDEO-DETAILED-US-ENG is default
        locale.loadLocale $user_handle

        error_gnsdk = GnSDK::gnsdk_video_query_create($user_handle, nil, nil, $video_query);
        error_processing() unless $error_gnsdk == 0
        $video_query= $video_query.get_pointer(0)
    end

    # for gnsdk_video_query_option_set()
    def setQueryOptions(option, value)
        if @qOptions[option] != nil
            @qOptions.delete(option)
        end
        @qOptions[option] = value
    end

    # for gnsdk_video_query_set_gdo()
    def setGdoTuiTag(tui, tag, type)
        logger.debug "#{tui} #{tag} #{type}"
        catch(:error_gnsdk) do
            $error_gnsdk = GnSDK::gnsdk_manager_gdo_create_from_id( tui, tag, type, $query_gdo)
            error_processing() unless $error_gnsdk == 0
            $query_gdo = $query_gdo.get_pointer(0)
            $error_gnsdk = GnSDK::gnsdk_video_query_set_gdo($video_query, $query_gdo )
            error_processing() unless $error_gnsdk == 0

            @qOptions.each do | key, value | # set query options
                $error_gnsdk = GnSDK::gnsdk_video_query_option_set($video_query, key, value)
                #logger.debug "gnsdk_video_query_option_set #{$video_query} for #{key} to #{value}"
            end

        end
    end

    # for gnsdk_video_text_option_set()
    def setTextOptions(option, value)
        if @tOptions[option] != nil
            @tOptions.delete(option)
        end
        @tOptions[option] = value
    end

    def hello
      puts "HelloVideo, world"
    end

    def videoQuery type

        catch(:error_gnsdk) do
            @qOptions.each do | key, value | # set query options
                $error_gnsdk = GnSDK::gnsdk_video_query_option_set($video_query, key, value)
                #logger.debug "gnsdk_video_query_option_set #{$video_query} for #{key} to #{value}"
            end

            case type
                when "series" 
                    $error_gnsdk = GnSDK::gnsdk_video_query_find_series($video_query, $video_gdo)
                    error_processing() unless $error_gnsdk == 0
                    $video_gdo = $video_gdo.get_pointer(0)
                when "seasons" 
                    $error_gnsdk = GnSDK::gnsdk_video_query_find_seasons($video_query, $video_gdo)
                    error_processing() unless $error_gnsdk == 0
                    $video_gdo = $video_gdo.get_pointer(0)
                when "products" 
                    $error_gnsdk = GnSDK::gnsdk_video_query_find_products($video_query, $video_gdo)
                    error_processing() unless $error_gnsdk == 0
                    $video_gdo = $video_gdo.get_pointer(0)
                when "works" 
                    $error_gnsdk = GnSDK::gnsdk_video_query_find_works($video_query, $video_gdo)
                    error_processing() unless $error_gnsdk == 0
                    $video_gdo = $video_gdo.get_pointer(0)
                when "contributors" 
                    $error_gnsdk = GnSDK::gnsdk_video_query_find_contributors($video_query, $video_gdo)
                    error_processing() unless $error_gnsdk == 0
                    $video_gdo = $video_gdo.get_pointer(0)
                when "objects" 
                    $error_gnsdk = GnSDK::gnsdk_video_query_find_objects($video_query, $video_gdo)
                    error_processing() unless $error_gnsdk == 0
                    $video_gdo = $video_gdo.get_pointer(0)
                when "suggestions" 
                    $error_gnsdk = GnSDK::gnsdk_video_query_find_suggestions($video_query, $video_gdo)
                    error_processing() unless $error_gnsdk == 0
                    $video_gdo = $video_gdo.get_pointer(0)
                else 
                    logger.debug "I don't know type #{type} of video query"
            end

            rendered_xml_ptr = FFI::MemoryPointer.new(:pointer, 1)
            error_gnsdk = GnSDK::gnsdk_manager_gdo_render_to_xml($video_gdo, -1, rendered_xml_ptr)
            error_processing() unless $error_gnsdk == 0
            rendered_xml_ptr = rendered_xml_ptr.get_pointer(0)
            return rendered_xml_ptr.read_string
        end #catch
    end #videoQuery
end #class Video
