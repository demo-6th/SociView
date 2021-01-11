# Fixing Protocol Mismatch for redirect_uri in Rails（下面這條最後該是可以拿掉的。）
OmniAuth.config.full_host = Rails.env.production? ? 'https://domain.com' : 'http://localhost:3000'