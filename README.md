# Reginald

## Installation

Add this line to your application's Gemfile:

    gem 'reginald'

## Usage

```
require 'reginald'

class Dictionary
  def define(message, word)
    definition = DictionaryService.lookup(word)
    message.reply("The definition of #{word} is #{definition}"
  end
end

reggie = Reginald.new(
  :xmpp_user => "XMPP_USER",
  :xmpp_password => "XMPP_PASSWORD",
  :twilo_account_id => "YOUR_TWILIO_ACCOUNT_ID",
  :twilio_auth_token => "YOUR_TWILIO_AUTH_TOKEN" 
)

reggie.route(/define (\w+)$/, "dictionary#define")

reggie.listen

```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/reginald/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
