module GnSDK
  extend FFI::Library
  ffi_lib "/Users/cmckenzie/Perforce/cm_mavericks1/cddb-gnqa/devel/csdk_video/v2/gracenotecsdk/libgnsdk_dsp.dylib"

    typedef :pointer, :gnsdk_dsp_feature_handle_t
    typedef :pointer, :gnsdk_dsp_feature_handle_t_pointer
    typedef :pointer, :gnsdk_manager_handle_t
    typedef :pointer, :gnsdk_user_handle_t
    typedef :uint,    :gnsdk_error_t
    typedef :uint, :gnsdk_uint32_t #32 bit
    typedef :int, :gnsdk_size_t #64 bit

    attach_function :"gnsdk_dsp_initialize", [ :gnsdk_manager_handle_t ], :gnsdk_error_t
    attach_function :"gnsdk_dsp_shutdown", [  ], :gnsdk_error_t
    attach_function :"gnsdk_dsp_get_version", [  ], :gnsdk_cstr_t
    attach_function :"gnsdk_dsp_get_build_date", [  ], :gnsdk_cstr_t
    attach_function :"gnsdk_dsp_feature_audio_begin", [ :gnsdk_user_handle_t, :gnsdk_cstr_t, :gnsdk_uint32_t, :gnsdk_uint32_t, :gnsdk_uint32_t, :gnsdk_dsp_feature_handle_t_pointer ], :gnsdk_error_t
    attach_function :"gnsdk_dsp_feature_audio_write", [ :gnsdk_dsp_feature_handle_t_pointer, :pointer, :gnsdk_size_t, :pointer ], :gnsdk_error_t
    attach_function :"gnsdk_dsp_feature_end_of_write", [ :gnsdk_dsp_feature_handle_t_pointer ], :gnsdk_error_t
    attach_function :"gnsdk_dsp_feature_retrieve_data", [ :gnsdk_dsp_feature_handle_t_pointer, :pointer, :pointer ], :gnsdk_error_t
    attach_function :"gnsdk_dsp_feature_release", [ :gnsdk_dsp_feature_handle_t_pointer ], :gnsdk_error_t
end
