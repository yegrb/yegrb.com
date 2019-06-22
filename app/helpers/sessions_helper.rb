# typed: true
module SessionsHelper
  extend T::Sig

  # Logs in the given user.
  sig { params(user: User).void }
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  sig { returns(T.nilable(User)) }
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  sig { params(user: User).void }
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  sig { params(user: User).void }
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  sig { void }
  def log_out
    return unless current_user

    forget(T.must(current_user))
    session.delete(:user_id)
    @current_user = nil
  end
end
