module GnSDK
  extend FFI::Library
    #enum_acr_status
    
    typedef :int, :gnsdk_acr_status_t

        GNSDK_ACR_STATUS_DEBUG				    = 0
        GNSDK_ACR_STATUS_QUERY_BEGIN			= 10
        GNSDK_ACR_STATUS_CONNECTING				= 20
        GNSDK_ACR_STATUS_SENDING				= 30
        GNSDK_ACR_STATUS_RECEIVING				= 40
        GNSDK_ACR_STATUS_AUDIO_FP_STARTED		= 45
        GNSDK_ACR_STATUS_AUDIO_FP_GENERATED		= 50
        GNSDK_ACR_STATUS_AUDIO_SILENT			= 70
        GNSDK_ACR_STATUS_SILENCE_RATIO			= 80
        GNSDK_ACR_STATUS_NON_PITCHED			= 81
        GNSDK_ACR_STATUS_MUSIC					= 82
        GNSDK_ACR_STATUS_SPEECH		        	= 83
        GNSDK_ACR_STATUS_QUERY_COMPLETE_LOCAL	= 100
        GNSDK_ACR_STATUS_QUERY_COMPLETE_ONLINE	= 110
        GNSDK_ACR_STATUS_NORMAL_MATCH_MODE		= 200
        GNSDK_ACR_STATUS_NO_MATCH_MODE			= 210
        GNSDK_ACR_STATUS_ERROR					= 600
        GNSDK_ACR_STATUS_TRANSITION				= 700
        GNSDK_ACR_STATUS_LOW_CONTRAST			= 800

    typedef :int, :gnsdk_acr_audio_alg_t

        GNSDK_ACR_AUDIO_ALG_1_3SVLQ             = 1
        GNSDK_ACR_AUDIO_ALG_1_3SMQ              = 2

    typedef :int, :gnsdk_acr_channel_type_t

        GNSDK_ACR_AUDIO_CHANNEL_TYPE_MONO       = 1
        GNSDK_ACR_AUDIO_CHANNEL_TYPE_STEREO     = 2

    typedef :int, :gnsdk_acr_audio_sample_rate_t
    
        GNSDK_ACR_AUDIO_SAMPLE_RATE_44100       = 44100
        GNSDK_ACR_AUDIO_SAMPLE_RATE_48000       = 48000

    typedef :int, :gnsdk_acr_audio_sample_format_t
    
        GNSDK_ACR_AUDIO_SAMPLE_FORMAT_PCM8      = 0
        GNSDK_ACR_AUDIO_SAMPLE_FORMAT_PCM16     = 1

    typedef :int, :gnsdk_acr_match_source_t
    
        GNSDK_ACR_MATCH_SOURCE_NONE             = 1
        GNSDK_ACR_MATCH_SOURCE_ONLINE           = 2
        GNSDK_ACR_MATCH_SOURCE_ONLINE_MUSIC     = 3
        GNSDK_ACR_MATCH_SOURCE_LOCAL            = 4

    typedef :int, :gnsdk_acr_result_lock_match_type_t

        NO_MATCH                                = 1
        NEW_MATCH                               = 2
        SINGLE_MATCH                            = 3
        MULTI_MATCH                             = 4

end
