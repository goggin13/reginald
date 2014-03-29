require "reginald"
require "webmock/rspec"
require "vcr"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = "random"
end


VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr_cassettes"
  c.hook_into :webmock
  c.ignore_localhost = true
end

WebMock.disable_net_connect!(:allow_localhost => true)
