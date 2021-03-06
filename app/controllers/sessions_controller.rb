class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: session_params[:session][:email])
    if user && user.authenticate(session_params[:session][:password])
      log_in user
      rediredt_to root_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに成功しました'
      render:new
    end
  end  
  
  def destroy
    log_out
    rediredt_to root_url, info: 'ログアウトしました'
  end
  
  private
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
