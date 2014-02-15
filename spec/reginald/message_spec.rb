require 'spec_helper'

module Reginald
  describe Message do
    it "has a text accessor" do
      Message.new("hello world").text.should == "hello world"
    end
  end
end
