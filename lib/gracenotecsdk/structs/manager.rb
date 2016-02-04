module GnSDK
  extend FFI::Library
  class GnSDK_error_info_t < FFI::Struct
      layout :error_code, :gnsdk_error_t,
             :src_error_code, :gnsdk_error_t,
             :error_description, :gnsdk_cstr_t,
             :src_error_description, :gnsdk_cstr_t
  end
end
