require 'active_support/configurable'
require 'mandrill'

module MandrillActionMailer
  include ActiveSupport::Configurable

  def self.client
    Mandrill::API.new(config.api_key)
  end
end
