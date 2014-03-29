module Reginald
  class TwilioMessage < Message
    def initialize(twilio_params, twilio_client, twilio_from_number)
      @client = twilio_client
      @twilio_from_number = twilio_from_number
      super(twilio_params[:Body], twilio_params[:From])
    end

    def reply(body)
      @client.account.messages.create(
        :from => @twilio_from_number,
        :to => username,
        :body => body
      )
    end
  end
end
