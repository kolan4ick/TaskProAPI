module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.id
    end

    private

    def find_verified_user
      if token = request.headers['Authorization'].to_s.split(' ').last
        begin
          decoded_token = JWT.decode(token, Rails.application.credentials.dig(Rails.env.to_sym, :secret_key_base), true, { algorithm: 'HS256' })
          User.find(decoded_token[0]['id'])
        rescue JWT::DecodeError
          reject_unauthorized_connection
        end
      else
        reject_unauthorized_connection
      end
    end
  end
end
