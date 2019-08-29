class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  def not_found
    render json: { :error => 'Not found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { :message => e.message }, :status => :unauthorized
    rescue JWT::DecodeError => e
      render json: { :message => e.message }, :status => :unauthorized
    end
  end

  private

  def record_not_found(error)
    render :json => { :message => error.message }, :status => 404
  end
end
