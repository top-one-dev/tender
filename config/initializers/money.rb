require 'money/bank/google_currency'

Money::Bank::GoogleCurrency.ttl_in_seconds = 86400

# set default bank to instance of GoogleCurrency
Money.default_bank = Money::Bank::GoogleCurrency.new
