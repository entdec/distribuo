Mensa.setup do |config|
  config.verifier_context = ->(_table) { {user: User.first} }
end
