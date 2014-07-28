require 'spec_helper'

describe 'MandrillActionMailer::DeliverHandler' do
  let(:client) { double('Mandrill::API') }
  let(:sender) { double('Mandrill::Messages') }

  before do
    allow(MandrillActionMailer).to receive(:client).and_return(client)
    allow(client).to receive(:messages).and_return(sender)
  end

  context 'when an API key is missing' do
    before do
      allow(MandrillActionMailer).to receive(:client).and_call_original
    end

    it 'should raise an error' do
      expect { Notifier.test.deliver! }.to raise_error
    end
  end

  context 'when the delivery fails' do
    it 'should raise an error' do
      allow(sender).to receive(:send).and_raise(RuntimeError.new)

      expect { Notifier.test.deliver! }.to raise_error
    end
  end

  context 'when the delivery is best effort' do
    it 'should not raise an error' do
      allow(sender).to receive(:send)

      expect { Notifier.test.deliver }.to_not raise_error
    end
  end

  it 'should send the email through the Mandrill client' do
    expect(sender).to receive(:send)

    Notifier.test.deliver
  end

  it 'should set the subject' do
    expect(sender).to receive(:send).with(
      hash_including(
        :subject => Notifier::SUBJECT
      )
    )

    Notifier.test.deliver
  end

  it 'should set the from field' do
    expect(sender).to receive(:send).with(
      hash_including(
        :from_email => Notifier::FROM
      )
    )

    Notifier.test.deliver
  end

  it 'should not set the from_name field' do
    expect(sender).to receive(:send).with(
      hash_excluding(:from_name)
    )

    Notifier.test.deliver
  end

  context 'when the from_name is set' do
    it 'should set the from_name field' do
      expect(sender).to receive(:send).with(
        hash_including(
          :from_name => Notifier::FROM
        )
      )

      Notifier.test_from_name.deliver
    end
  end

  it 'should set the to field' do
    expect(sender).to receive(:send).with(
      hash_including(
        :to => [
          {
            :email => Notifier::TO,
            :name => Notifier::TO
          }
        ]
      )
    )

    Notifier.test.deliver
  end

  it 'should not set the reply-to field' do
    expect(sender).to receive(:send).with(
      hash_excluding(
        :headers => hash_including('Reply-To')
      )
    )

    Notifier.test.deliver
  end

  context 'when the reply-to field is set' do
    it 'should set the reply-to field' do
      expect(sender).to receive(:send).with(
        hash_including(
          :headers => { 'Reply-To' => Notifier::REPLY_TO }
        )
      )

      Notifier.test_reply_to.deliver
    end
  end

  it 'should not set the bcc field' do
    expect(sender).to receive(:send).with(
      hash_excluding(:bcc)
    )

    Notifier.test.deliver
  end

  context 'when the bcc is set' do
    it 'should set the bcc_address field' do
      expect(sender).to receive(:send).with(
        hash_including(
          :bcc_address => Notifier::BCC
        )
      )

      Notifier.test_bcc.deliver
    end
  end

  it 'should render multipart messages' do
    expect(sender).to receive(:send).with(
      hash_including(
        :html,
        :text
      )
    )

    Notifier.multipart.deliver
  end

  it 'should set many to recipients' do
    expect(sender).to receive(:send).with(
      hash_including(
          :to => Notifier::MANY_TO.map do |email|
            {
              :email => email,
              :name => email
            }
          end
      )
    )

    Notifier.to_many.deliver
  end
end
