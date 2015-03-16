OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "1392586531057897", "298b16bf0dc5597eb2c143dc8578f7bf"
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "2piBf8UAgv4xtZxgpNE8paxSj", "t5w86U4A4uFStC7tFZ7LSUcWfpyI9AUXOrHO6eYwZNV3BvUB65"
end