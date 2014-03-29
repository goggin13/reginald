require "spec_helper"

module Reginald
  describe TwilioMessage do
    it "creates a message from twilio params" do
      twilio_params = {
        :MessageSid => "1",
        :SmsSid => "1",
        :AccountSid => "1",
        :From => "6072555555",
        :To => "1",
        :Body => "hello world",
        :NumMedia => 0
      }

      twilio_message = TwilioMessage.new(twilio_params, nil, nil)

      twilio_message.username.should == "6072555555"
      twilio_message.text.should == "hello world"
    end

    it "sends a reply to the twilio API" do
      twilio_params = {
        :From => "1234567890",
        :Body => "hello world",
      }
      client = Twilio::REST::Client.new "test_sid", "test_token"
      twilio_message = TwilioMessage.new(twilio_params, client, "6073912287")

      VCR.use_cassette("successful_twilio_text_response") do
        message = twilio_message.reply("goodbye world")
        message.from.should == "+16073912287"
        message.to.should == "+11234567890"
        message.body.should == "goodbye world"
      end
    end
  end
end
