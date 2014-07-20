module MandrillActionMailer
  class DeliveryHandler
    attr_accessor :settings

    MIME_TYPES = {
      :html => "text/html",
      :text => "text/plain"
    }.freeze

    def initialize(options={})
      self.settings = { :track_opens => MandrillActionMailer.config.track_opens, :track_clicks => MandrillActionMailer.config.track_clicks }.merge(options)
    end

    def deliver!(message)
      message_payload = {
        :track_opens => settings[:track_opens],
        :track_clicks => settings[:track_clicks],
        :subject => message.subject,
        :from_name => (message[:from_name].nil? || message[:from_name].value.blank?) ? nil : message[:from_name].value,
        :from_email => message.from.first,
        :to => message.to.map { |email| { :email => email, :name => email } },
        :headers => { 'Reply-To' => message.reply_to.blank? ? nil : message.reply_to },
        :bcc_address  => message.bcc ? message.bcc.first : nil,
      }

      MIME_TYPES.keys.each do |format|
        content = content_for(message, format)
        message_payload[format] = content.to_s if content
      end

      MandrillActionMailer.client.messages.send(message_payload)
    end

    private

    def content_for(message, format)
      content = message.send(:"#{format.to_s}_part")
      content = content.body if content && content.respond_to?(:body)

      content ||= message.body if message.mime_type == MIME_TYPES.fetch(format)
      content
    end
  end
end
