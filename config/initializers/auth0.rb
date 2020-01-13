Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'S8wIVZtr5dH3B4ljb91226YSE6eSnN0N',
    'Q_vqvcTDNUyJ8N6nRNxMC1ZL7EXK1eYTqDmd_A39hSvBDJGDFvOFOQ25_dyR02dO',
    'froggodoggo-staging.eu.auth0.com',
    callback_path: '/auth/auth0/callback',
    authorize_params: {
      scope: 'openid email profile'
    }
  )
end