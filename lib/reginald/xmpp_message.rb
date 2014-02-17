module Reginald
  class XMPPMessage < Message
    def initialize(xmpp_message)
      email = "#{xmpp_message.from.node}@#{xmpp_message.from.domain}"
      super(xmpp_message.body, email)
    end
  end
end
