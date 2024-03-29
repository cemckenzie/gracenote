module GnSDK

    typedef :int, :gnsdk_video_search_type_t

        gnsdk_video_search_type_unknown = 0
        gnsdk_video_search_type_anchored = 1
        gnsdk_video_search_type_default = 2


    GNSDK_VIDEO_EXTERNAL_ID_TYPE_UPC                = "gnsdk_video_xid_type_upc"

    GNSDK_VIDEO_EXTERNAL_ID_SOURCE_DEFAULT          = "gnsdk_video_xid_source_gn"

    GNSDK_VIDEO_FILTER_KEY_SEASON_NUM				= "gnsdk_video_key_season_num"
    GNSDK_VIDEO_FILTER_KEY_SEASON_EPISODE_NUM		= "gnsdk_video_key_season_episode_num"
    GNSDK_VIDEO_FILTER_KEY_SERIES_EPISODE_NUM		= "gnsdk_video_key_series_episode_num"
    GNSDK_VIDEO_FILTER_KEY_GENRE_INCLUDE			= "gnsdk_video_key_genre_include"
    GNSDK_VIDEO_FILTER_KEY_GENRE_EXCLUDE			= "gnsdk_video_key_genre_exclude"
    GNSDK_VIDEO_FILTER_KEY_PRODUCTION_TYPE_INCLUDE	= "gnsdk_video_key_production_type_include"
    GNSDK_VIDEO_FILTER_KEY_PRODUCTION_TYPE_EXCLUDE	= "gnsdk_video_key_production_type_exclude"
    GNSDK_VIDEO_FILTER_KEY_SERIAL_TYPE_INCLUDE		= "gnsdk_video_key_serial_type_include"
    GNSDK_VIDEO_FILTER_KEY_SERIAL_TYPE_EXCLUDE		= "gnsdk_video_key_serial_type_exclude"
    GNSDK_VIDEO_FILTER_KEY_ORIGIN_INCLUDE			= "gnsdk_video_key_origin_include"
    GNSDK_VIDEO_FILTER_KEY_ORIGIN_EXCLUDE			= "gnsdk_video_key_origin_exclude"

    GNSDK_VIDEO_SEARCH_FIELD_CONTRIBUTOR_NAME		= "gnsdk_video_search_field_contributor_name"
    GNSDK_VIDEO_SEARCH_FIELD_CHARACTER_NAME			= "gnsdk_video_search_field_character_name"
    GNSDK_VIDEO_SEARCH_FIELD_WORK_FRANCHISE			= "gnsdk_video_search_field_work_franchise"
    GNSDK_VIDEO_SEARCH_FIELD_WORK_SERIES			= "gnsdk_video_search_field_work_series"
    GNSDK_VIDEO_SEARCH_FIELD_WORK_TITLE				= "gnsdk_video_search_field_work_title"
    GNSDK_VIDEO_SEARCH_FIELD_PRODUCT_TITLE			= "gnsdk_video_search_field_product_title"
    GNSDK_VIDEO_SEARCH_FIELD_SERIES_TITLE			= "gnsdk_video_search_field_series_title"
    GNSDK_VIDEO_SEARCH_FIELD_ALL					= "gnsdk_video_search_field_all"

    GNSDK_VIDEO_OPTION_ENABLE_LINK_DATA				= "gnsdk_video_option_enable_link"
    GNSDK_VIDEO_OPTION_ENABLE_EXTERNAL_IDS			= "gnsdk_video_option_enable_xids"
    GNSDK_VIDEO_OPTION_ENABLE_CONTENT_DATA			= "gnsdk_video_option_enable_content"
    GNSDK_VIDEO_OPTION_ENABLE_MINIMAL_DATA			= "gnsdk_video_option_enable_minimal"
    GNSDK_VIDEO_OPTION_PREFERRED_LANG				= "gnsdk_video_preferred_lang"
    GNSDK_VIDEO_OPTION_RESULT_RANGE_START			= "gnsdk_video_result_range_start"
    GNSDK_VIDEO_OPTION_RESULT_RANGE_SIZE			= "gnsdk_video_result_range_size"
    GNSDK_VIDEO_OPTION_QUERY_NOCACHE				= "gnsdk_video_option_query_nocache"
    GNSDK_VIDEO_OPTION_QUERY_ENABLE_COMMERCE_TYPE	= "gnsdk_video_option_query_enable_commerce_type"

#GNSDK_VIDEO_FILTER_VALUE_PRODUCTION_TYPE_EDUCATIONAL            GNSDK_LIST_PRODUCTION_TYPE_EDUCATIONAL
#GNSDK_VIDEO_FILTER_VALUE_PRODUCTION_TYPE_GAME_SHOW              GNSDK_LIST_PRODUCTION_TYPE_GAME_SHOW
#GNSDK_VIDEO_FILTER_VALUE_PRODUCTION_TYPE_INSTRUCTIONAL          GNSDK_LIST_PRODUCTION_TYPE_INSTRUCTIONAL
#GNSDK_VIDEO_FILTER_VALUE_PRODUCTION_TYPE_KARAOKE	            GNSDK_LIST_PRODUCTION_TYPE_KARAOKE
#GNSDK_VIDEO_FILTER_VALUE_PRODUCTION_TYPE_LIVE_PERFORMANCE       GNSDK_LIST_PRODUCTION_TYPE_LIVE_PERFORMANCE
#GNSDK_VIDEO_FILTER_VALUE_PRODUCTION_TYPE_MINI_SERIES		    GNSDK_LIST_PRODUCTION_TYPE_MINI_SERIES
#GNSDK_VIDEO_FILTER_VALUE_PRODUCTION_TYPE_MOTION_PICTURE	        GNSDK_LIST_PRODUCTION_TYPE_MOTION_PICTURE
#GNSDK_VIDEO_FILTER_VALUE_PRODUCTION_TYPE_MUSIC_VIDEO		    GNSDK_LIST_PRODUCTION_TYPE_MUSIC_VIDEO
#GNSDK_VIDEO_FILTER_VALUE_PRODUCTION_TYPE_SERIAL			        GNSDK_LIST_PRODUCTION_TYPE_SERIAL
#GNSDK_VIDEO_FILTER_VALUE_PRODUCTION_TYPE_SHORT_FEATURE		    GNSDK_LIST_PRODUCTION_TYPE_SHORT_FEATURE
#GNSDK_VIDEO_FILTER_VALUE_PRODUCTION_TYPE_SPORTING_EVENT	        GNSDK_LIST_PRODUCTION_TYPE_SPORTING_EVENT
#GNSDK_VIDEO_FILTER_VALUE_PRODUCTION_TYPE_STAGE_PRODUCTION	    GNSDK_LIST_PRODUCTION_TYPE_STAGE_PRODUCTION
#GNSDK_VIDEO_FILTER_VALUE_PRODUCTION_TYPE_TV_SERIES			    GNSDK_LIST_PRODUCTION_TYPE_TV_SERIES
#GNSDK_VIDEO_FILTER_VALUE_PRODUCTION_TYPE_VARIETY_SHOW		    GNSDK_LIST_PRODUCTION_TYPE_VARIETY_SHOW
#GNSDK_VIDEO_FILTER_VALUE_GENRE_ACTION_ADVENTURE	                GNSDK_LIST_VIDEO_GENRE_ACTION_ADVENTURE
#GNSDK_VIDEO_FILTER_VALUE_GENRE_ADULT				            GNSDK_LIST_VIDEO_GENRE_ADULT
#GNSDK_VIDEO_FILTER_VALUE_GENRE_ANIMATION			            GNSDK_LIST_VIDEO_GENRE_ANIMATION
#GNSDK_VIDEO_FILTER_VALUE_GENRE_CHILDREN			                GNSDK_LIST_VIDEO_GENRE_CHILDREN
#GNSDK_VIDEO_FILTER_VALUE_GENRE_COMEDY			                GNSDK_LIST_VIDEO_GENRE_COMEDY
#GNSDK_VIDEO_FILTER_VALUE_GENRE_DOCUMENTARY		                GNSDK_LIST_VIDEO_GENRE_DOCUMENTARY
#GNSDK_VIDEO_FILTER_VALUE_GENRE_DRAMA				            GNSDK_LIST_VIDEO_GENRE_DRAMA
#GNSDK_VIDEO_FILTER_VALUE_GENRE_HORROR			                GNSDK_LIST_VIDEO_GENRE_HORROR
#GNSDK_VIDEO_FILTER_VALUE_GENRE_MUSICAL			                GNSDK_LIST_VIDEO_GENRE_MUSICAL
#GNSDK_VIDEO_FILTER_VALUE_GENRE_MYSTERY_AND_SUSPENSE	 	        GNSDK_LIST_VIDEO_GENRE_MYSTERY_AND_SUSPENSE
#GNSDK_VIDEO_FILTER_VALUE_GENRE_ART_AND_EXPERIMENTAL 		    GNSDK_LIST_VIDEO_GENRE_ART_AND_EXPERIMENTAL
#GNSDK_VIDEO_FILTER_VALUE_GENRE_OTHER						    GNSDK_LIST_VIDEO_GENRE_OTHER
#GNSDK_VIDEO_FILTER_VALUE_GENRE_ROMANCE					        GNSDK_LIST_VIDEO_GENRE_ROMANCE
#GNSDK_VIDEO_FILTER_VALUE_GENRE_SCIFI_FANTASY				    GNSDK_LIST_VIDEO_GENRE_SCIFI_FANTASY
#GNSDK_VIDEO_FILTER_VALUE_GENRE_SPECIAL_INTEREST_EDUCATION	    GNSDK_LIST_VIDEO_GENRE_SPECIAL_INTEREST_EDUCATION
#GNSDK_VIDEO_FILTER_VALUE_GENRE_MUSIC_AND_PERFORMING_ARTS		GNSDK_LIST_VIDEO_GENRE_MUSIC_AND_PERFORMING_ARTS
#GNSDK_VIDEO_FILTER_VALUE_GENRE_SPORTS						    GNSDK_LIST_VIDEO_GENRE_SPORTS
#GNSDK_VIDEO_FILTER_VALUE_GENRE_TELEVISION_AND_INTERNET		    GNSDK_LIST_VIDEO_GENRE_TELEVISION_AND_INTERNET
#GNSDK_VIDEO_FILTER_VALUE_GENRE_MILITARY_AND_WAR				    GNSDK_LIST_VIDEO_GENRE_MILITARY_AND_WAR
#GNSDK_VIDEO_FILTER_VALUE_GENRE_WESTERN							GNSDK_LIST_VIDEO_GENRE_WESTERN
end
