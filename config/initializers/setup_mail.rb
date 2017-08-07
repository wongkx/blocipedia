if Rails.env.development? || Rails.env.production?
    ActionMailer::Base.delivery_method = :smtp
    #config.action_mailer.perform_deliveries = true
    ActionMailer::Base.smtp_settings = {
        address:        'smtp.gmail.com',
        port:           587,
        authentication: 'plain',
        user_name:      'kevinwong6175@gmail.com',
        password:       'nkfnke10',
        domain:         'gmail.com',
        enable_starttls_auto: true
    }
end