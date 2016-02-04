module GnSDK
  extend FFI::Library
  ffi_lib "/Users/cmckenzie/Perforce/cm_mavericks1/cddb-gnqa/devel/csdk_video/v2/gracenotecsdk/libgnsdk_lookup_fplocal.dylib"

    typedef :pointer, :callback_data
    typedef :pointer, :gnsdk_dsp_feature_handle_t
    typedef :pointer, :gnsdk_dsp_feature_handle_t_pointer
    typedef :pointer, :gnsdk_manager_handle_t
    typedef :pointer, :gnsdk_user_handle_t
    typedef :pointer, :gnsdk_byte_t_ptr
    typedef :pointer, :gnsdk_size_t_ptr
    typedef :pointer, :gnsdk_bool_t_ptr
    typedef :pointer, :gnsdk_cstr_t
    typedef :uint,    :gnsdk_error_t
    typedef :uint,    :gnsdk_uint32_t #32 bit
    typedef :size_t,  :gnsdk_size_t #64 bit

    attach_function :"gnsdk_lookup_fplocal_initialize", [ :gnsdk_manager_handle_t ], :gnsdk_error_t
    attach_function :"gnsdk_lookup_fplocal_shutdown", [], :gnsdk_error_t
    attach_function :"gnsdk_lookup_fplocal_get_version", [], :gnsdk_error_t
    attach_function :"gnsdk_lookup_fplocal_get_build_date", [], :gnsdk_error_t

end
