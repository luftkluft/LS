class CryptPostService
  attr_reader :errors

  def initialize
    @errors = []
  end

  def encrypted_data(user_data)
    saved_user_data = user_data
    user_data[:title] = set_crypt.encrypt_and_sign(user_data[:title])
    user_data[:summary] = set_crypt.encrypt_and_sign(user_data[:summary])
    user_data[:body] = set_crypt.encrypt_and_sign(user_data[:body])
    user_data # <= it is encrypted
  rescue StandardError
    @errors.push(I18n.t('crypt.encrypt_error'))
    saved_user_data
  end

  def decrypted_back(encrypted_data)
    saved_encrypted_data = encrypted_data
    encrypted_data[:title] = set_crypt.decrypt_and_verify(encrypted_data[:title])
    encrypted_data[:summary] = set_crypt.decrypt_and_verify(encrypted_data[:summary])
    encrypted_data[:body] = set_crypt.decrypt_and_verify(encrypted_data[:body])
    encrypted_data # <= it is decrypted
  rescue StandardError
    @errors.push(I18n.t('crypt.decrypt_error'))
    saved_encrypted_data
  end

  def decypted_posts(posts)
    saved_decrypted_posts = posts
    posts.map do |post|
      post[:title] = set_crypt.decrypt_and_verify(post[:title])
      post[:summary] = set_crypt.decrypt_and_verify(post[:summary])
      post[:body] = set_crypt.decrypt_and_verify(post[:body])
    end
    posts
  rescue StandardError
    @errors.push(I18n.t('crypt.articles_decrypt_error'))
    saved_decrypted_posts
  end

  private

  def set_crypt
    key = Rails.application.credentials.cryptkey
    ActiveSupport::MessageEncryptor.new(key)
  end
end
