module GnSDK

    GNSDK_EPG_POSTALCODE_COUNTRY_USA		= "usa"
    GNSDK_EPG_POSTALCODE_COUNTRY_CANADA		= "can"
    GNSDK_EPG_CHANNEL_ID_TYPE_DVB			= "dvb"
    GNSDK_EPG_SEARCH_FIELD_PROGRAM_TITLE	= "epg_search_program_title"
    GNSDK_EPG_OPTION_RESULT_RANGE_START		= "epg_option_range_start"
    GNSDK_EPG_OPTION_RESULT_RANGE_SIZE		= "epg_option_range_size"
    GNSDK_EPG_OPTION_ENABLE_EXTERNAL_IDS	= "gnsdk_epg_option_enable_xids"
    GNSDK_EPG_OPTION_ENABLE_CONTENT_DATA	= "gnsdk_epg_option_enable_content"

#gnsdk_error_t	GNSDK_API	gnsdk_epg_query_set_postalcode(
#gnsdk_error_t	GNSDK_API	gnsdk_epg_query_add_channel_id(
#gnsdk_error_t	GNSDK_API	gnsdk_epg_query_add_tvchannel_gdo(
#gnsdk_error_t	GNSDK_API	gnsdk_epg_query_set_gdo(
#gnsdk_error_t	GNSDK_API	gnsdk_epg_query_set_text(
#gnsdk_error_t	GNSDK_API	gnsdk_epg_query_set_time_start(
#gnsdk_error_t	GNSDK_API	gnsdk_epg_query_set_time_end(

#gnsdk_error_t	GNSDK_API	gnsdk_epg_query_find_programs( gnsdk_epg_query_handle_t	query_handle, gnsdk_gdo_handle_t*			p_response_gdo);
#gnsdk_error_t	GNSDK_API	gnsdk_epg_query_find_tvproviders( gnsdk_epg_query_handle_t	query_handle, gnsdk_gdo_handle_t*			p_response_gdo);
#gnsdk_error_t	GNSDK_API	gnsdk_epg_query_find_channels( gnsdk_epg_query_handle_t	query_handle, gnsdk_gdo_handle_t*			p_response_gdo);
#gnsdk_error_t	GNSDK_API	gnsdk_epg_query_find_tvairings( gnsdk_epg_query_handle_t	query_handle, gnsdk_gdo_handle_t*			p_response_gdo);

end
