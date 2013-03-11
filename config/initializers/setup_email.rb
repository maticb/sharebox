ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :domain => 'sharebox.com',
    :user_name => "seenluka@gmail.com",
    :password => "mutav123",
    :authentication => 'plain',
    :enable_starttls_auto => true
}