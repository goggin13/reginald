require "blather/client/dsl"

module Reginald
  class XMPPListener
    extend Blather::DSL

    @listener = nil
    def self.register_listener(listener)
      @listener = listener
    end

    def self.listener
      @listener
    end

    def self.listen_for_chats
      message :chat?, :body do |m|
        message = XMPPMessage.new(m)
        self.listener.process_message(message)
      end
    end

    def self.run
      Thread.new { EM.run { client.run } }
      listen_for_chats
    end
  end
end
