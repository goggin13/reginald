require "spec_helper"
require_relative "integration_spec_helper"
require "blather/client/dsl"

module Reginald

  class TestMessageHandler
    attr_reader :message

    def process_message(message)
      @message = message
    end
  end

  module App
    extend Blather::DSL

    def self.run
      EM.run { client.run }
    end

    setup TEST_ACCOUNTS["account_2"]["email"], TEST_ACCOUNTS["account_2"]["password"]
  end

  describe XMPPListener do
    it "calls the message handler when a message is received" do
      test_message_handler = TestMessageHandler.new
      XMPPListener.register_listener(test_message_handler)
      XMPPListener.setup TEST_ACCOUNTS["account_1"]["email"], TEST_ACCOUNTS["account_1"]["password"]

      t2 = Thread.new { App.run }
      t1 = Thread.new { XMPPListener.run }

      tries = 0
      while tries < 3 && test_message_handler.message.nil?
        sleep 2
        App.say TEST_ACCOUNTS["account_1"]["email"], "hello world"
        tries += 1
      end

      test_message_handler.message.should_not be_nil
      test_message_handler.message.text.should == "hello world"
      test_message_handler.message.username.should == "goggin132@gmail.com"

      Thread.kill(t1)
      Thread.kill(t2)
    end
  end
end
