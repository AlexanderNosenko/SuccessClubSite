Rails.application.config.middleware.use OmniAuth::Builder do
  provider :vkontakte, '5585689', 'kboToQ2MPYLy8qqvzA5T'
  provider :facebook, '670009683153743', 'd33bae4d99d6fd325d295364078121bf'
end
