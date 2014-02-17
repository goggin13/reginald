require "reginald/version"

require "reginald/message"
require "reginald/xmpp_message"
require "reginald/xmpp_listener"

require "reginald/route"

require "reginald/reginald"

module Reginald
  class Reginald
    include Route
  end
end
