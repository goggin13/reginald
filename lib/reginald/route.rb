module Reginald
  module Route
    def initialize
      @routes = []
    end

    def listen(regex, action)
      @routes << [regex, action]
    end

    def route(message)
      @routes.each do |route|
        regex, action_string = route
        matches = regex.match(message.text)
        next unless matches

        class_name, method = action_string.split("#")
        klass = _classify(class_name)
        klass.send(method, message, matches[1..matches.length])
      end
    end

    def _classify(str)
      Object.const_get(str.split(/(\W)/).map(&:capitalize).join)
    end
  end
end
