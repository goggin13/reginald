require 'spec_helper'

module Reginald
  describe Message do
    it "has a text accessor" do
      Message.new("hello world", "jim").text.should == "hello world"
    end

    it "has a username accessor" do
      Message.new("hello world", "jim").username.should == "jim"
    end
  end
end
