require 'spec_helper'

module Reginald
  describe Route do
    describe "listen" do
      it "routes messages that match a regular expression" do
        message = Message.new("hello world")

        reggie = Reginald.new
        reggie.listen(/hello world/, "string#include")

        String.should receive("include").with(message, [])
        reggie.route(message)
      end

      it "does not route messages that don't match" do
        reggie = Reginald.new
        reggie.listen(/hello world/, "string#include")

        String.should_not receive("include")
        reggie.route(Message.new("goodbye world"))
      end

      it "chooses the correct route from multiple" do
        message = Message.new("hello world")

        reggie = Reginald.new

        reggie.listen(/goodbye world/, "integer#tap")
        reggie.listen(/hello world/, "string#include")
        reggie.listen(/farewell world/, "integer#taint")

        Integer.should_not receive("tap")
        Integer.should_not receive("taint")
        String.should receive("include").with(message, [])

        reggie.route(message)
      end

      it "passes on the matches from the regular expression" do
        message = Message.new("hello world goodbye")

        reggie = Reginald.new
        reggie.listen(/hello (\w+) (\w+)/, "string#include")

        String.should receive("include").with(message, ["world", "goodbye"])
        reggie.route(message)
      end
    end
  end
end
