require 'ffi'

module LinkLib
  extend FFI::Library
  ffi_lib "/Users/cmckenzie/Perforce/cm_mavericks1/cddb-gnqa/devel/csdk_video/v2/gracenotecsdk/libgnsdk_link.dylib"

typedef :pointer, :callbacks
typedef :pointer, :callback_data
typedef :pointer, :gnsdk_link_query_handle_t
typedef :pointer, :gnsdk_link_query_handle_t_pointer
typedef :pointer, :gnsdk_list_element_handle_t
typedef :pointer, :gnsdk_user_handle_t
typedef :uint, :gnsdk_error_t
typedef :uint, :gnsdk_uint32_t
typedef :string, :gnsdk_cstr_t

#******************************************************************************
#* Initialization APIs
#******************************************************************************/
    attach_function :"gnsdk_link_query_create", [ :gnsdk_user_handle_t,  :callbacks,  :callback_data,  :gnsdk_link_query_handle_t_pointer], :gnsdk_error_t
    attach_function :"gnsdk_link_query_release", [ :gnsdk_link_query_handle_t], :gnsdk_error_t

#******************************************************************************
#* Link Query Input - each Link query needs one input - GDO.
#******************************************************************************/
    attach_function :"gnsdk_link_query_set_gdo", [ :gnsdk_link_query_handle_t, :gnsdk_gdo_handle_t], :gnsdk_error_t
    attach_function :"gnsdk_link_query_set_list_element", [ :gnsdk_link_query_handle_t, :gnsdk_list_element_handle_t], :gnsdk_error_t
    attach_function :"gnsdk_link_query_option_set", [ :gnsdk_link_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t], :gnsdk_error_t
    attach_function :"gnsdk_link_query_options_clear", [ :gnsdk_link_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t], :gnsdk_error_t
    attach_function :"gnsdk_link_query_options_clear", [ :gnsdk_link_query_handle_t], :gnsdk_error_t

end
