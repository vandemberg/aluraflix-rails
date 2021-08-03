class ApplicationController < ActionController::API
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header

    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => _e
      render json: "Credenciais inválidas", status: :unauthorized
    rescue JWT::DecodeError => _e
      render json: "Credenciais inválidas", status: :unauthorized
    end
  end
end
