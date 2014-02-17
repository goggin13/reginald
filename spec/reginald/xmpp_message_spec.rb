require 'spec_helper'

module Reginald
  describe XMPPMessage do
    it "creates a message from an xmpp message" do
      node = double("Blather::JID", :node => "goggin13", :domain => "gmail.com")
      raw_xmpp_message = double(
        "Blather::Stanza::Message",
        :from => node,
        :body => "hello world"
      )

      xmpp_message = XMPPMessage.new(raw_xmpp_message)

      xmpp_message.text.should == "hello world"
      xmpp_message.username.should == "goggin13@gmail.com"
    end
  end
end
