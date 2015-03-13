module MandrillActionMailer
  class DeliveryHandler
    attr_accessor :settings, :result

    MIME_TYPES = {
      :html => "text/html",
      :text => "text/plain"
    }.freeze

    FULL_EMAIL_REGEX = /\A\s*(.+?)\s*<\s*(?:[^>]+)\s*>\s*\z/

    def initialize(options={})
      self.settings = {
        :track_opens => MandrillActionMailer.config.track_opens,
        :track_clicks => MandrillActionMailer.config.track_clicks
      }.merge(options)
    end

    def deliver!(message)
      message_payload = {
        :track_opens => settings[:track_opens],
        :track_clicks => settings[:track_clicks],
        :subject => message.subject,
        :from_email => message.from.first,
        :to => message.to.map { |email| { :email => email, :name => email } },
      }

      if !(message[:from_name].nil? || message[:from_name].value.blank?)
        # If a from name is set, use it.
        message_payload[:from_name] = message[:from_name].value
      elsif !(message[:from_email].nil?) && (m = FULL_EMAIL_REGEX.match(message[:from_email].value))
        # If no from name is set, check to see if they set it in the email field.
        message_payload[:from_name] = m[1]
      end

      if !message.reply_to.blank?
        message_payload[:headers] ||= {}
        message_payload[:headers]['Reply-To'] = message.reply_to.first
      end

      if !message.bcc.blank?
        message_payload[:bcc_address] = message.bcc.first
      end

      MIME_TYPES.keys.each do |format|
        content = content_for(message, format)
        message_payload[format] = content.to_s unless content.blank?
      end

      self.result = MandrillActionMailer.client.messages.send(message_payload)
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
