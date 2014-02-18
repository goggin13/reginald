module Reginald
  class XMPPMessage < Message
    def initialize(xmpp_message)
      email = "#{xmpp_message.from.node}@#{xmpp_message.from.domain}"
      @xmpp_message = xmpp_message
      super(xmpp_message.body, email)
    end

    def reply(body)
      @xmpp_message.body = body
      XMPPListener.write_to_stream @xmpp_message.reply
    end
  end
end
