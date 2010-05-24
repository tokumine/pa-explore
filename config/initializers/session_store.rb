# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pa-explorer_session',
  :secret      => '8e045635b1dad0b5cf56480f6cafc4d68c316a93df719e9f63a319a5391fc7dffdb5debfec7f20801967d7807c823ea7312061c71ee8ccec2bf0c40c9f7b5c37'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
