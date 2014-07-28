class Notifier < ActionMailer::Base
  TO = 'to@example.org'
  MANY_TO = [TO, 'to2@example.org']
  FROM = 'from@example.org'
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
    mail from_name: FROM, template_name: 'test'
  end

  def to_many
    mail to: MANY_TO, template_name: 'test'
  end

  def multipart
    mail
  end

end
