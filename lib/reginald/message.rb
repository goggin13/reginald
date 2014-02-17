module Reginald
  class Message
    attr_accessor :text, :username

    def initialize(text, username)
      @text = text
      @username = username
    end
  end
end
