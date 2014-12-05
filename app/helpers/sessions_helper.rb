module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    if user.class == "User"
      session[:user_id] = user.id
    elsif user.class == "Band"
      session[:band_id] = user.id
    end
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    if user.class == "User"
      cookies.permanent.signed[:user_id] = user.id
    elsif user.class == "Band"
      cookies.permanent.signed[:band_id] = user.id
    end
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns the band corresponding to the remember token cookie.
  def current_band
    if (band_id = session[:band_id])
      @current_band ||= Band.find_by(id: band_id)
    elsif (band_id = cookies.signed[:band_id])
      band = Band.find_by(id: band_id)
      if band && band.authenticated?(cookies[:remember_token])
        log_in band
        @current_band = band
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil? || !current_band.nil?
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    if user.class == "User"
      cookies.delete(:user_id)
    elsif user.class == "Band"
      cookies.delete(:band_id)
    end
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
    forget(current_user)
    forget(current_band)
    session.delete(:user_id)
    session.delete(:band_id)
    @current_user = nil
    @current_band = nil
  end
end