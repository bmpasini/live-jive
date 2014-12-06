module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    if user.class.to_s == "User"
      session[:user_id] = user.id
      puts session[:user_id]
      user.update(penultimate_login_at: user.last_login_at, last_login_at: Time.now())
    elsif user.class.to_s == "Band"
      session[:band_id] = user.id
    end
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    if user.class.to_s == "User"
      cookies.permanent.signed[:user_id] = user.id
    elsif user.class.to_s == "Band"
      cookies.permanent.signed[:band_id] = user.id
    end
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find(user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find(user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
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
      if band && band.authenticated?(:remember, cookies[:remember_token])
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
    if user.class.to_s == "User"
      cookies.delete(:user_id)
    elsif user.class.to_s == "Band"
      cookies.delete(:band_id)
    end
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
    if session[:user_id]
      forget(current_user)
      session.delete(:user_id)
      @current_user = nil
    elsif session[:band_id]
      forget(current_band)
      session.delete(:band_id)
      @current_band = nil
    end
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end

  # Returns true if the given band is the current band.
  def current_band?(band)
    band == current_band
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
end