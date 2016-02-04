module AcrLib
  extend FFI::Library
  ffi_lib "/Users/cmckenzie/Perforce/cm_mavericks1/cddb-gnqa/devel/csdk_video/v2/gracenotecsdk/libgnsdk_acr.dylib"

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

end #Module AcrLib
