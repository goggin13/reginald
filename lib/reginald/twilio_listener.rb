require "sinatra/base"
require "twilio-ruby"

module Reginald
  class TwilioListener
    attr_reader :listener, :from, :sid, :token, :port

    def initialize(params)
      @listener = params[:listener]
      @from = params[:from]
      @port = params[:port] || 3002
      @sid = params[:sid]
      @token = params[:token]
    end

    def _client
      @client ||= Twilio::REST::Client.new(sid, token)
    end

    def listen_for_chats
      TwilioListenerApp.set :listener, self
      TwilioListenerApp.set :server, "thin"
      TwilioListenerApp.set :bind, "0.0.0.0"
      TwilioListenerApp.run!(:port => port)
    end

    def run
      @thread = Thread.new { listen_for_chats }
      sleep 2
    end

    def stop
      Thread.kill(@thread)
      sleep 2
    end

    def process_message(params)
      message = TwilioMessage.new(params, _client, from)
      listener.process_message(message)
    end

    class TwilioListenerApp < Sinatra::Base
      post '/twilio_listener' do
        settings.listener.process_message(params)
      end
    end
  end
end
