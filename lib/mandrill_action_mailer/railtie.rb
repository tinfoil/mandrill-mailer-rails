require 'rails/railtie'
require 'mandrill_action_mailer/delivery_handler'

module MandrillActionMailer
  class Railtie < Rails::Railtie
    config.mandrill_action_mailer = MandrillActionMailer.config

    initializer 'mandrill_action_mailer.add_delivery_method' do
      ActionMailer::Base.add_delivery_method(:mandrill, MandrillActionMailer::DeliveryHandler)
    end
  end
end
