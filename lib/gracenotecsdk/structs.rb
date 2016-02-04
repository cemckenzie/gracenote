module GnSDK
  class Struct < FFI::Struct
  end
end
require './lib/gracenotecsdk/structs/manager'
require './lib/gracenotecsdk/structs/acr.rb'
require './lib/gracenotecsdk/structs/dsp.rb'
require './lib/gracenotecsdk/structs/epg.rb'
require './lib/gracenotecsdk/structs/storage_sqlite.rb'
require './lib/gracenotecsdk/structs/video.rb'
