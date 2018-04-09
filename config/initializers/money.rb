# require 'money/bank/google_currency'

# Money::Bank::GoogleCurrency.ttl_in_seconds = 86400

# # set default bank to instance of GoogleCurrency
# Money.default_bank = Money::Bank::GoogleCurrency.new

require 'money/bank/openexchangerates_bank'
moxb = Money::Bank::OpenexchangeratesBank.new
moxb.access_key = ENV['OPEN_EXCHANGE_APP_ID']

# Update rates (get new rates from remote if expired or access rates from cache)
moxb.update_rates
# Set money default bank to Openexchangerates bank
Money.default_bank = moxb