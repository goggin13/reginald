require "spec_helper"
require "rest_client"

module Reginald

  class TestMessageHandler
    attr_reader :message

    def process_message(message)
      @message = message
    end
  end

  describe TwilioListener do
    it "calls the message handler when a message is received" do
      test_message_handler = TestMessageHandler.new
      twilio_listener = TwilioListener.new(
        :sid => "test_sid",
        :token => "test_token",
        :from => "1234567890",
        :listener => test_message_handler,
        :port => 3001
      )
      twilio_listener.run

      twilio_params = {
        :MessageSid => "1",
        :SmsSid => "1",
        :AccountSid => "1",
        :From => "6072555555",
        :To => "1",
        :Body => "hello world",
        :NumMedia => 0
      }

      result = RestClient.post "http://localhost:3001/twilio_listener", twilio_params
      result.code.should == 200

      twilio_listener.stop

      test_message_handler.message.should_not be_nil
      test_message_handler.message.text.should == "hello world"
      test_message_handler.message.username.should == "6072555555"
    end

    it "creates a message that can be replied to" do
      test_message_handler = TestMessageHandler.new
      twilio_listener = TwilioListener.new(
        :sid => "test_sid",
        :token => "test_token",
        :from => "1234567890",
        :listener => test_message_handler,
        :port => 3001
      )
      twilio_listener.run

      twilio_params = {
        :From => "6072555555",
        :Body => "hello world"
      }

      RestClient.post "http://localhost:3001/twilio_listener", twilio_params

      twilio_listener.stop

      VCR.use_cassette("successful_twilio_text_response") do
        message = test_message_handler.message.reply("goodbye world")
        message.from.should == "+16073912287"
        message.to.should == "+11234567890"
        message.body.should == "goodbye world"
      end
    end

    it "calls the message handler when a message is received" do
      test_message_handler = TestMessageHandler.new
      twilio_listener = TwilioListener.new(
        :sid => "test_sid",
        :token => "test_token",
        :from => "1234567890",
        :listener => test_message_handler,
        :port => 3001
      )
      listeners = `lsof -iTCP -i :3001 | wc -l`.to_i

      twilio_listener.run
      twilio_listener.stop

     `lsof -iTCP -i :3001 | wc -l`.to_i.should == listeners
    end
  end
end
