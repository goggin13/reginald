require 'spec_helper'

module Reginald
  describe Router do
    describe "listen" do
      it "routes messages that match a regular expression" do
        message = Message.new("hello world", "jim")

        router = Router.new
        router.listen(/hello world/, "string#include")

        String.should receive("include").with(message, [])
        router.route(message)
      end

      it "does not route messages that don't match" do
        router = Router.new
        router.listen(/hello world/, "string#include")

        String.should_not receive("include")
        router.route(Message.new("goodbye world", "jim"))
      end

      it "chooses the correct route from multiple" do
        message = Message.new("hello world", "jim")

        router = Router.new

        router.listen(/goodbye world/, "integer#tap")
        router.listen(/hello world/, "string#include")
        router.listen(/farewell world/, "integer#taint")

        Integer.should_not receive("tap")
        Integer.should_not receive("taint")
        String.should receive("include").with(message, [])

        router.route(message)
      end

      it "passes on the matches from the regular expression" do
        message = Message.new("hello world goodbye", "jim")

        router = Router.new
        router.listen(/hello (\w+) (\w+)/, "string#include")

        String.should receive("include").with(message, ["world", "goodbye"])
        router.route(message)
      end
    end
  end

  describe "_classify" do
    it "turns a snake case class name into a class object" do
      Router.new._classify("basic_object").should == BasicObject
    end
  end
end
