module Reginald
  class Reginald
    def initialize(options)
      XMPPListener.setup options[:xmpp_user], options[:xmpp_password]
      @router = Router.new
    end

    def run
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
