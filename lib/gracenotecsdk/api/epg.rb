module GnSDK
  extend FFI::Library
  ffi_lib "/Users/cmckenzie/Perforce/cm_mavericks1/cddb-gnqa/devel/csdk_video/v2/gracenotecsdk/libgnsdk_epg.dylib"

typedef :pointer, :callbacks
typedef :pointer, :callback_data
typedef :pointer, :gnsdk_gdo_handle_t
typedef :pointer, :gnsdk_epg_query_handle_t
typedef :pointer, :gnsdk_epg_query_handle_t_pointer
typedef :pointer, :gnsdk_manager_handle
typedef :pointer, :gnsdk_user_handle_t
typedef :pointer, :gnsdk_cstr_t
typedef :uint, :gnsdk_uint32_t
typedef :double, :gnsdk_flt32_t
typedef :size_t, :gnsdk_size_t
typedef :long, :gnsdk_time_us_t

    attach_function :"gnsdk_epg_initialize", [ :gnsdk_manager_handle_t ], :gnsdk_error_t
    attach_function :"gnsdk_epg_shutdown", [  ], :gnsdk_error_t
    attach_function :"gnsdk_epg_get_version", [  ], :gnsdk_cstr_t
    attach_function :"gnsdk_epg_get_build_date", [  ], :gnsdk_cstr_t

    attach_function :"gnsdk_epg_query_create", [ :gnsdk_user_handle_t, :callbacks, :callback_data, :gnsdk_epg_query_handle_t_pointer ], :gnsdk_error_t
    attach_function :"gnsdk_epg_query_release", [ :gnsdk_epg_query_handle_t ], :gnsdk_error_t
    attach_function :"gnsdk_epg_query_option_set", [ :gnsdk_epg_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t ], :gnsdk_error_t
    attach_function :"gnsdk_epg_query_option_get", [ :gnsdk_epg_query_handle_t, :gnsdk_cstr_t, :pointer ], :gnsdk_error_t

    attach_function :"gnsdk_epg_query_add_channel_id", [ :gnsdk_epg_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t, :gnsdk_cstr_t ], :gnsdk_error_t
    attach_function :"gnsdk_epg_query_add_tvchannel_gdo", [ :gnsdk_epg_query_handle_t, :gnsdk_gdo_handle_t, :gnsdk_cstr_t ], :gnsdk_error_t

    attach_function :"gnsdk_epg_query_set_gdo", [ :gnsdk_epg_query_handle_t, :gnsdk_gdo_handle_t ], :gnsdk_error_t
    attach_function :"gnsdk_epg_query_set_text", [ :gnsdk_epg_query_handle_t, :gnsdk_str_t, :gnsdk_str_t ], :gnsdk_error_t
    attach_function :"gnsdk_epg_query_set_time_start", [ :gnsdk_epg_query_handle_t, :gnsdk_uint32_t, :gnsdk_uint32_t, :gnsdk_uint32_t, :gnsdk_uint32_t, :gnsdk_uint32_t ], :gnsdk_error_t
    attach_function :"gnsdk_epg_query_set_time_end", [ :gnsdk_epg_query_handle_t, :gnsdk_uint32_t, :gnsdk_uint32_t, :gnsdk_uint32_t, :gnsdk_uint32_t, :gnsdk_uint32_t ], :gnsdk_error_t
    attach_function :"gnsdk_epg_query_set_postalcode", [ :gnsdk_epg_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t ], :gnsdk_error_t

    attach_function :"gnsdk_epg_query_find_programs", [ :gnsdk_epg_query_handle_t, :pointer ], :gnsdk_error_t
    attach_function :"gnsdk_epg_query_find_tvproviders", [ :gnsdk_epg_query_handle_t, :pointer ], :gnsdk_error_t
    attach_function :"gnsdk_epg_query_find_channels", [ :gnsdk_epg_query_handle_t, :pointer ], :gnsdk_error_t
    attach_function :"gnsdk_epg_query_find_tvairings", [ :gnsdk_epg_query_handle_t, :pointer ], :gnsdk_error_t

end
