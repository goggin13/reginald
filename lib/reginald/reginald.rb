module Reginald
  class Reginald
    def initialize(options)
      XMPPListener.setup options[:xmpp_user], options[:xmpp_password]
      @twilio_listener = TwilioListener.new(
        options[:twilio_account_id],
        options[:twilio_auth_token],
        self
      )
      @router = Router.new
    end

    def run
      XMPPListener.register_listener(self)
      XMPPListener.run
      @twilio_listener.run
    end

    def process_message(message)
      @router.route(message)
    end

    def listen(regex, action)
      @router.listen(regex, action)
    end
  end
end
