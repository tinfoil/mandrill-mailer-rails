class Notifier < ActionMailer::Base
  TO = 'to@example.org'
  MANY_TO = [TO, 'to2@example.org']
  FROM = 'from@example.org'
  FROM_NAME = 'From Name'
  FROM_EMAIL_WITH_NAME = "#{FROM_NAME} <#{FROM}>"
  SUBJECT = 'Test Subject'
  REPLY_TO = 'reply@example.org'
  BCC = 'bcc@example.org'

  default to: TO, from: FROM, subject: SUBJECT

  def test
    mail
  end

  def test_reply_to
    mail reply_to: REPLY_TO, template_name: 'test'
  end

  def test_bcc
    mail bcc: BCC, template_name: 'test'
  end

  def test_from_name
    mail from_name: FROM_NAME, template_name: 'test'
  end

  def test_from_email_with_name
    mail from_email: FROM_EMAIL_WITH_NAME, template_name: 'test'
  end

  def to_many
    mail to: MANY_TO, template_name: 'test'
  end

  def multipart
    mail
  end

end
