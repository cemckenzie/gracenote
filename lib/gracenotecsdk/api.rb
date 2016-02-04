module GnSDK
extend FFI::Library

  require './lib/gracenotecsdk/api/manager.rb'
  require './lib/gracenotecsdk/api/manager_lib.rb'
  require './lib/gracenotecsdk/api/storage_sqlite.rb'
  require './lib/gracenotecsdk/api/dsp.rb'
  require './lib/gracenotecsdk/api/lookup_fplocal.rb'
  require './lib/gracenotecsdk/api/acr.rb'
  require './lib/gracenotecsdk/api/epg.rb'
  require './lib/gracenotecsdk/api/link.rb'
  require './lib/gracenotecsdk/api/musicid.rb'
  require './lib/gracenotecsdk/api/video.rb'

end
