module GnSDK
  extend FFI::Library
  ffi_lib "/Users/cmckenzie/Perforce/cm_mavericks1/cddb-gnqa/devel/csdk_video/v2/acr/acr_c/bin/libgnsdk_acr.dylib"

FFI.add_typedef(:pointer, :gnsdk_acr_query_handle_t)

typedef :pointer, :callbacks
typedef :pointer, :callback_data
typedef :pointer, :gnsdk_acr_query_handle_t
typedef :pointer, :gnsdk_acr_query_handle_t_pointer
typedef :pointer, :gnsdk_manager_handle
typedef :pointer, :gnsdk_user_handle_t
typedef :uint, :gnsdk_error_t
typedef :uint, :gnsdk_uint32_t
typedef :float, :gnsdk_flt32_t
typedef :size_t, :gnsdk_size_t
typedef :ulong_long, :gnsdk_time_us_t
typedef :pointer, :gnsdk_str_t
typedef :string, :gnsdk_cstr_t

callback :gnsdk_acr_callback_status_fn, [ :pointer, :gnsdk_acr_query_handle_t, :int, :gnsdk_size_t, :gnsdk_size_t, :gnsdk_flt32_t, :gnsdk_error_t, :gnsdk_cstr_t ], :pointer
callback :gnsdk_acr_callback_result_fn, [ :pointer, :gnsdk_acr_query_handle_t, :pointer, :int, :gnsdk_uint32_t, :gnsdk_flt32_t ], :pointer

class AcrCallbacks < FFI::Struct
    layout(
        :callback_status, :gnsdk_acr_callback_status_fn,
        :callback_result, :gnsdk_acr_callback_result_fn
    )
end

#******************************************************************************
#* Initialization APIs
#******************************************************************************/
attach_function :gnsdk_acr_initialize, [:gnsdk_manager_handle], :gnsdk_error_t
attach_function :gnsdk_acr_shutdown, [], :gnsdk_error_t
attach_function :gnsdk_acr_get_version, [], :gnsdk_error_t
attach_function :gnsdk_acr_get_build_date, [], :gnsdk_error_t

#******************************************************************************
#* ACR Instance Handles
#******************************************************************************/
attach_function :gnsdk_acr_query_create, [:gnsdk_user_handle_t, :callbacks, :callback_data, :gnsdk_acr_query_handle_t_pointer ], :gnsdk_error_t
attach_function :gnsdk_acr_query_wait_for_complete, [ :gnsdk_acr_query_handle_t, :uint ], :gnsdk_error_t
attach_function :gnsdk_acr_query_release, [ :gnsdk_acr_query_handle_t ], :gnsdk_error_t

#******************************************************************************
#* ACR Option APIs
#******************************************************************************/
attach_function :gnsdk_acr_query_option_set, [ :gnsdk_acr_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t ], :gnsdk_error_t
attach_function :gnsdk_acr_query_option_get, [ :gnsdk_acr_query_handle_t, :gnsdk_cstr_t, :pointer ], :gnsdk_error_t

#******************************************************************************
#* ACR Streaming Inputs APIs
#******************************************************************************/
attach_function :gnsdk_acr_query_init_audio_stream, [ :gnsdk_acr_query_handle_t, :int, :int, :int, :int ], :gnsdk_error_t
attach_function :gnsdk_acr_query_write_audio_data, [ :gnsdk_acr_query_handle_t, :pointer, :gnsdk_size_t, :gnsdk_time_us_t ], :gnsdk_error_t
attach_function :gnsdk_acr_query_write_complete, [ :gnsdk_acr_query_handle_t ], :gnsdk_error_t

#******************************************************************************
#* ACR Additional Queries APIs
#******************************************************************************/
attach_function :gnsdk_acr_query_manual_lookup, [ :gnsdk_acr_query_handle_t ], :gnsdk_error_t
attach_function :gnsdk_acr_query_music_lookup, [ :gnsdk_acr_query_handle_t ], :gnsdk_error_t

class Acr
    include ManagerLib
    include Logging
    include ErrorReporting
    attr_accessor :acr_responses, :result, :acr_result, :ffi_ptr, :child_ptr, :title_ptr

    def initialize algo, sample_rate, format, channel_type 
        @session = Session.new()
        @inputData = Hash.new()
        @qOptions = Hash.new()
        $acr_responses = Array.new
        $ffi_ptr = FFI::MemoryPointer.new(:pointer, 1)
        $child_ptr = FFI::MemoryPointer.new(:pointer, 1)
        $title_ptr = FFI::MemoryPointer.new(:pointer, 1)
        @@acr_match_done = 0

        @audio_algo = algo                  # eg GNSDK_ACR_AUDIO_ALG_1_3SVLQ
        @audio_sample_rate = sample_rate    # eg GNSDK_ACR_AUDIO_SAMPLE_RATE_48000
        @audio_sample_format = format       # eg GNSDK_ACR_AUDIO_SAMPLE_FORMAT_PCM16
        @audio_channel_type = channel_type  # eg GNSDK_ACR_AUDIO_CHANNEL_TYPE_STEREO
    end

    # add locale changes or separate (better)
    def gnsdk_init license_path, client_id, client_id_tag, user_path, user_type
        @session.gnsdk_init license_path, client_id, client_id_tag, user_path, user_type
        # finish inits for ACR
        catch(:error_gnsdk) do
            $error_gnsdk = GnSDK::gnsdk_dsp_initialize $managr_handle
            error_processing() unless $error_gnsdk == 0

            $error_gnsdk = GnSDK::gnsdk_lookup_fplocal_initialize $managr_handle
            error_processing() unless $error_gnsdk == 0

            $error_gnsdk = GnSDK::gnsdk_acr_initialize $managr_handle
            error_processing() unless $error_gnsdk == 0
        end
        locale = GnSDK::Locale.new()
        locale.hello
        locale.setLocale
        locale.loadLocale $user_handle
    end

    def setInput type, value
        if @inputData[type] != nil
            @inputData[type].delete
        end
        @inputData[type] = value
        logger.debug type
        logger.debug value
    end

    def setInputData
        if @inputData.count
            @inputData.each do | key, value |
                case key
                  when :acr_algorithm
                    @audio_algo = @inputData[:acr_algorithm].to_i
                  when :acr_sample_rate
                    @audio_sample_rate = @inputData[:acr_sample_rate].to_i
                  when :acr_sample_rate
                    @audio_sample_format = @inputData[:acr_sample_format].to_i
                  when :acr_channel_type
                    @audio_channel_type = @inputData[:acr_channel_type].to_i
                end
            end
        end
        logger.debug @audio_algo
        logger.debug @audio_sample_rate
        logger.debug @audio_sample_format
        logger.debug @audio_channel_type
    end

    #
    #:cancel_query to_bool
    #:no_match_count to_int32
    #:max_time_between_lookups to_uint32
    #:no_match_time_increment to_uint32
    #:no_match_max_time to_uint32
    #:external_ids to_uint32
    #:content to_bool
    #:prefer_cover_art to_bool       #music option
    #:prefer_external_id             #music option
    #:single_result to_bool          #music option
    #
    def setQueryOptions(option, value)
        if @qOptions[option] != nil
            @qOptions.delete(option)
        end
        @qOptions[option] = value
    end

    def hello
      puts "HelloAcr, world"
    end

    def acrQuery audio_file
        @acr_query= FFI::MemoryPointer.new(:pointer, 1)

        cbacks = AcrCallbacks.new
        cbacks[:callback_status] = Acr_status_callback
        cbacks[:callback_result] = Acr_result_callback

        catch(:error_gnsdk) do
            error_gnsdk = GnSDK::gnsdk_acr_query_create($user_handle, cbacks, nil, @acr_query);
            error_processing() unless $error_gnsdk == 0
            @acr_query= @acr_query.get_pointer(0)

            @qOptions.each do | key, value | # set query options
                error_gnsdk = GnSDK::gnsdk_acr_query_option_set(@acr_query, key, value)
                logger.debug "gnsdk_acr_query_option_set #{key} to #{value}"
            end

            logger.debug "gnsdk_acr_query_init_audio_stream"
            logger.debug @acr_query
            logger.debug @audio_algo
            logger.debug @audio_sample_rate
            logger.debug @audio_sample_format
            logger.debug @audio_channel_type
            $error_gnsdk = GnSDK::gnsdk_acr_query_init_audio_stream(@acr_query, @audio_algo, @audio_sample_rate, @audio_sample_format, @audio_channel_type)
            error_processing() unless $error_gnsdk == 0

            # feed in the file
            if File.exists?(audio_file)
              size = File.size(audio_file) # - 44
              bytes_to_read = 20480 #bytes
              logger.debug "Audio file: #{audio_file}"
              open(audio_file, 'rb') do |io|
                  read = 0
                  while read < size #-44
                    left = size - read
                    cur = left < bytes_to_read ? left : bytes_to_read
                    data = io.read(cur)
                    read += data.size
                    begin
                        $error_gnsdk = GnSDK::gnsdk_acr_query_write_audio_data(@acr_query, data, cur, 0)
                        error_processing() unless $error_gnsdk == 0
                        sleep(0.010)
                    end
                    if @audio_feed_end == 0
                        puts "break out of audio write loop"
                        break
                    end
                end
                logger.debug "calling write_complete"
                $error_gnsdk = GnSDK::gnsdk_acr_query_write_complete(@acr_query)
                io.close
                error_processing() unless $error_gnsdk == 0
            end
            logger.debug "sleep for 5"
            sleep(5)
        else
            logger.info "file not found #{audio_file}"
        end
            puts "return responses"
            return $video_result
        end
    end 

    def get_acr_response_child_count response
        catch(:error_gnsdk) do
            puts "get_acr_response_child_count #{response}"
            STDOUT.flush
            error_gnsdk = GnSDK::gnsdk_manager_gdo_child_count(response, GNSDK_GDO_CHILD_MATCH_ACR, $ffi_ptr);
            error_processing() unless $error_gnsdk == 0
            $count = $ffi_ptr.read_int()
        end
    end


    def get_acr_response_type response
        catch(:error_gnsdk) do
            puts "get_acr_response_type #{response}"
            STDOUT.flush
            error_gnsdk = GnSDK::gnsdk_manager_gdo_get_type(response, $ffi_ptr)
            error_processing() unless $error_gnsdk == 0
            $type = $ffi_ptr.read_int()
            puts "type is #{$type}"
            return $type
        end
    end

    def get_acr_child_responses response, match_count
        catch(:error_gnsdk) do
            for i in 1..match_count
                error_gnsdk = GnSDK::gnsdk_manager_gdo_child_get(response, GNSDK_GDO_CHILD_MATCH_ACR, i, $ffi_ptr)
                error_processing() unless $error_gnsdk == 0
                next
            end
            match_gdo = $ffi_ptr.get_pointer(0)
            match_detail = AcrResponse.new(match_gdo)
            @@responses.push match_detail
            error_processing() unless $error_gnsdk == 0
        end
    end

end #class Acr

class AcrResponse 
    include Logging
    include ErrorReporting

def initialize match_gdo

    @match_hash = Hash.new

    catch(:error_gnsdk) do

        @match_hash = {"match_gdo" => match_gdo}

        $error_gnsdk = gnsdk_manager_gdo_value_get(match_gdo, GNSDK_GDO_VALUE_RESPONSE_RANGE_START, 1, ffi_ptr)
        error_processing() unless $error_gnsdk == 0
        key = ffi_ptr.get_pointer(0).read_string unless error != 0
        @match_hash = {GNSDK_GDO_VALUE_RESPONSE_RANGE_START => value}

        $error_gnsdk = gnsdk_manager_gdo_value_get(match_gdo, GNSDK_GDO_VALUE_RESPONSE_RANGE_END, 1, ffi_ptr)
        error_processing() unless $error_gnsdk == 0
        key = ffi_ptr.get_pointer(0).read_string unless error != 0
        @match_hash = {GNSDK_GDO_VALUE_RESPONSE_RANGE_END => value}

        $error_gnsdk = gnsdk_manager_gdo_value_get(match_gdo, GNSDK_GDO_VALUE_RESPONSE_RANGE_TOTAL, 1, ffi_ptr)
        error_processing() unless $error_gnsdk == 0
        key = ffi_ptr.get_pointer(0).read_string unless error != 0
        @match_hash = {GNSDK_GDO_VALUE_RESPONSE_RANGE_TOTAL => value}

        $error_gnsdk = gnsdk_manager_gdo_value_get(match_gdo, GNSDK_GDO_VALUE_RESPONSE_RANGE_COUNT, 1, ffi_ptr)
        error_processing() unless $error_gnsdk == 0
        key = ffi_ptr.get_pointer(0).read_string unless error != 0
        @match_hash = {GNSDK_GDO_VALUE_RESPONSE_RANGE_COUNT => value}
    end
    return @match_hash
end

def cleanup
end
end #class AcrResponse

end #Module GnSDK
