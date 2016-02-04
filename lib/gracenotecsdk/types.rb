module GnSDK
        typedef :int, :gnsdk_error_t
        typedef :string, :gnsdk_cstr_t
end

require './lib/gracenotecsdk/managed_pointer'
require './lib/gracenotecsdk/types/manager'
require './lib/gracenotecsdk/types/acr'
require './lib/gracenotecsdk/types/dsp'
require './lib/gracenotecsdk/types/epg'
require './lib/gracenotecsdk/types/link'
require './lib/gracenotecsdk/types/musicid'
require './lib/gracenotecsdk/types/storage_sqlite'
require './lib/gracenotecsdk/types/video'

