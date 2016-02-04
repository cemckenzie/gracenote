
module GnSDK
    extend FFI::Library
        typedef :int, :gnsdk_acr_status_t
        typedef :pointer, :gnsdk_acr_query_handle_t

  # See {ManagedPointer} for documentation.
  class Acr < ManagedPointer
    end
end
