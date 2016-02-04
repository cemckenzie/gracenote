module GnSDK
  extend FFI::Library

  typedef :int, :gnsdk_acr_status_t
  typedef :pointer, :gnsdk_acr_query_handle_t

   class Gnsdk_acr_callback_status_fn < GnSDK::Struct
     layout :callback_data => :pointer,
            :acr_query_handle => :pointer,
            :acr_status => :int,
            :value1 => :int,
            :value2 => :int,
            :value3 => :int,
            :error => :int,
            :message => :int
   end
 
   class Gnsdk_acr_callback_result_fn < FFI::Struct
     layout :callback_data => :pointer,
            :acr_query_handle => :int,
            :acr_status => :int,
            :value1 => :int,
            :value2 => :int,
            :value3 => :int,
            :error => :int,
            :message => :int
   end
 
   class Gnsdk_acr_callback_result_lock_fn < FFI::Struct
     layout :callback_data => :pointer,
            :acr_query_handle => :pointer,
            :result_gdo => :pointer,
            :match_source => :pointer,
            :match_count => :uint,
            :no_match_duration => :double,
            :match_type => :uint,
            :match_confidence_val => :uint,
            :locked_match_index => :uint,
            :locked_count => :uint,
            :locked_duration => :double
     end 
 
   class Gnsdk_acr_callbacks_s < FFI::Struct
     layout :callback_status => :pointer,
            :callback_result => :pointer,
            :callback_result_lock => :pointer 
 
     end
 end
