require 'ffi'

module GnSDK
  extend FFI::Library
  ffi_lib "/Users/cmckenzie/Perforce/cm_mavericks1/cddb-gnqa/devel/csdk_video/v2/gracenotecsdk/libgnsdk_storage_sqlite.dylib"

    attach_function :gnsdk_storage_sqlite_initialize, [ :gnsdk_manager_handle_t ], :gnsdk_error_t
    attach_function :gnsdk_storage_sqlite_shutdown, [  ], :gnsdk_error_t
    attach_function :gnsdk_storage_sqlite_get_version, [  ], :gnsdk_cstr_t
    attach_function :gnsdk_storage_sqlite_get_build_date, [  ], :gnsdk_cstr_t
    attach_function :gnsdk_storage_sqlite_get_sqlite_version, [  ], :gnsdk_cstr_t
    attach_function :gnsdk_storage_sqlite_option_set, [ :gnsdk_cstr_t, :gnsdk_cstr_t ], :gnsdk_error_t
    attach_function :gnsdk_storage_sqlite_option_get, [ :gnsdk_cstr_t, :pointer ], :gnsdk_error_t
end
