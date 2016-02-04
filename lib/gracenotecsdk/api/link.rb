require 'nokogiri'

require 'ffi'

module GnSDK
  extend FFI::Library
  ffi_lib "/Users/cmckenzie/Perforce/cm_mavericks1/cddb-gnqa/devel/csdk_video/v2/gracenotecsdk/libgnsdk_link.dylib"

  FFI.add_typedef(:pointer, :gnsdk_link_query_handle_t)

  typedef :pointer, :callbacks
  typedef :pointer, :callback_data
  typedef :pointer, :gnsdk_link_query_handle_t_pointer
  typedef :pointer, :gnsdk_list_element_handle_t
  typedef :pointer, :gnsdk_link_content_type_t
  typedef :pointer, :gnsdk_link_data_type_t_ptr
  typedef :pointer, :gnsdk_byte_t_ptr_ptr 
  typedef :pointer, :gnsdk_size_t_ptr
  typedef :pointer, :gnsdk_user_handle_t
  typedef :uint, :gnsdk_error_t
  typedef :pointer, :gnsdk_manager_handle_t
  typedef :pointer, :gnsdk_user_handle_t
  typedef :uint, :gnsdk_uint32_t
  typedef :int, :gnsdk_int32_t
  typedef :pointer, :gnsdk_str_t
  typedef :string, :gnsdk_cstr_t

#******************************************************************************
#* Initialization APIs
#******************************************************************************/
    attach_function :gnsdk_link_initialize, [:gnsdk_manager_handle_t], :gnsdk_error_t
    attach_function :gnsdk_link_shutdown, [], :gnsdk_error_t
    attach_function :gnsdk_link_get_version, [], :gnsdk_error_t
    attach_function :gnsdk_link_get_build_date, [], :gnsdk_error_t

#******************************************************************************
#* Initialization APIs
#******************************************************************************/
    attach_function :"gnsdk_link_query_create", [ :gnsdk_user_handle_t,  :callbacks,  :callback_data,  :gnsdk_link_query_handle_t_pointer], :gnsdk_error_t
    attach_function :"gnsdk_link_query_release", [ :gnsdk_link_query_handle_t], :gnsdk_error_t

#******************************************************************************
#* Link Query Input - each Link query needs one input - GDO.
#******************************************************************************/
    attach_function :gnsdk_link_query_set_gdo, [ :gnsdk_link_query_handle_t, :gnsdk_gdo_handle_t], :gnsdk_error_t
    attach_function :gnsdk_link_query_set_list_element, [ :gnsdk_link_query_handle_t, :gnsdk_list_element_handle_t], :gnsdk_error_t
    attach_function :gnsdk_link_query_option_set, [ :gnsdk_link_query_handle_t, :gnsdk_cstr_t, :gnsdk_cstr_t], :gnsdk_error_t
    attach_function :gnsdk_link_query_options_clear, [ :gnsdk_link_query_handle_t], :gnsdk_error_t

    attach_function :gnsdk_link_query_content_count, [ :gnsdk_link_query_handle_t, :gnsdk_link_content_type_t, :gnsdk_uint32_t], :gnsdk_error_t
    attach_function :gnsdk_link_query_content_retrieve, [ :gnsdk_link_query_handle_t, :gnsdk_link_content_type_t, :gnsdk_uint32_t, :gnsdk_link_data_type_t_ptr, :gnsdk_byte_t_ptr_ptr, :gnsdk_size_t_ptr], :gnsdk_error_t
    attach_function :gnsdk_link_query_content_free, [ :gnsdk_byte_t_ptr], :gnsdk_error_t

#******************************************************************************
#* VIDEO Find
#******************************************************************************/
end # module GnSDK
