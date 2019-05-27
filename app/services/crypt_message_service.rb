class CryptMessageService
  attr_reader :errors

  def initialize
    @errors = []
  end

  def encrypted_data(user_data)
    saved_user_data = user_data
    user_data = set_crypt.encrypt_and_sign(user_data)
    user_data # <= it is encrypted
  rescue StandardError
    @errors.push(I18n.t('crypt.encrypt_error'))
    saved_user_data
  end

  def decrypted_back(encrypted_data)
    saved_encrypted_data = encrypted_data
    encrypted_data[:message] = set_crypt.decrypt_and_verify(encrypted_data[:message])
    encrypted_data # <= it is decrypted
  rescue StandardError
    @errors.push(I18n.t('crypt.decrypt_error'))
    saved_encrypted_data
  end

  def decypted_messages(messages)
    saved_decrypted_messages = messages
    messages.map do |message|
      message[:message] = set_crypt.decrypt_and_verify(message[:message])
    end
    messages
  rescue StandardError
    @errors.push(I18n.t('crypt.messages_decrypt_error'))
    saved_decrypted_messages
  end

  private

  def set_crypt
    key = Rails.application.credentials.cryptkey
    ActiveSupport::MessageEncryptor.new(key)
  end
end
