module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    current_user == user
  end

  def sign_out
    current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def signed_in_user
    unless signed_in?
      store_location
      flash[:info] = 'Please sign in.'
      redirect_to signin_path
    end
  end

  def correct_user(user = nil)
    user ||= User.find(params[:id])
    unless current_user?(user)
      redirect_to root_path
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:info] = t(:tutor_warning)
      redirect_to user_path(current_user)
    end
  end

  def tutor_user
    unless current_user.tutor?
      flash[:info] = t(:tutor_warning)
      redirect_to user_path(current_user)
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
