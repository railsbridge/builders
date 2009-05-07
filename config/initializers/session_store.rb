# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_builders_session',
  :secret      => 'e35bfd9947c4c991451c87ae5d888a6b04f2fdec8ea7fdb8f7c0bd165497226b64e5ad81d692b8b3f5651e3da13d7a7036cbf4f52ffff3dda79282b5eedc3b4c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
