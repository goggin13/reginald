module Reginald
  class Reginald
    def initialize(options)
      XMPPListener.setup options[:xmpp_user], options[:xmpp_password]
      @twilio_listener = TwilioListener.new(
        :sid => options[:twilio_account_id],
        :token => options[:twilio_auth_token],
        :listener => self,
        :from => options[:twilio_from_number]
      )
      @router = Router.new
    end

    def run
      @twilio_listener.run
      XMPPListener.register_listener(self)
      XMPPListener.run
    end

    def process_message(message)
      @router.route(message)
    end

    def listen(regex, action)
      @router.listen(regex, action)
    end
  end
end
