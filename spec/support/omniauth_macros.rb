module OmniauthMacros
  def auth_hash(provider, email)
    request.env['devise.mapping'] = Devise.mappings[:user] # If using Devise
    request.env['omniauth.auth'] = send("#{provider}_auth_hash_with", email)
  end

  def facebook_auth_hash_with(email)
    OmniAuth.config.add_mock(:facebook, uid: '0987654321', info: { email: email })
  end

  def set_invalid_omniauth
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
  end
end
