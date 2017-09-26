

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid_connect, {
    name: :azure_ad,

    issuer: "https://sts.windows.net/#{ENV['AZURE_TENANT_ID']}/",

    scope: [:openid],

    # ドキュメントでは, Azure ADは, 'id_token' を含めなければならないことになっている;
    # https://docs.microsoft.com/en-us/azure/active-directory/develop/active-directory-protocols-openid-connect-code
    # 実際には, ['code', 'id_token'] はレスポンスが不正. フラグメントになる.
    # ['code', 'id_token', 'token'] では unsupported_response_type
    # => 結局, 'code' のみでよい.
    response_type: ['code'],

    # Azure ADのみ.
    send_client_secret_to_token_endpoint: true,

    discovery: true,

    client_options: {
      scheme: "https",
      host: "login.windows.net", # issuer のホストと違う!
      port: 443,  # 省略不可.

      identifier: ENV['AZURE_CLIENT_ID'],
      secret: ENV['AZURE_CLIENT_SECRET'],
      redirect_uri: ENV['AZURE_REDIRECT_URI'],
    },
  }
end
