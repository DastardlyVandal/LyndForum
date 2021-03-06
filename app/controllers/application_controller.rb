class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def validate_user
    if user_signed_in? == false
      flash[:notice] = "Sign in or Join us to continue!"
      redirect_to '/users/sign_in' and return false
    end
    return true
  end

  def validate_mod
      if validate_user
          if current_user.role > 1
              flash[:notice] = "You are not authorized to perform this action"
              redirect_to '/board/' and return false
          end
          return true
      end
      return false
  end

  def validate_admin
      if validate_user
          if current_user.role != 0
              flash[:notice] = "Sign in or Join us to continue!"
              redirect_to '/board/' and return false
          end
          return true
      end
      return false
  end

  # saves the location before loading each page so we can return to the
  # right page. If we're on a devise page, we don't want to store that as the
  # place to return to (for example, we don't want to return to the sign in page
  # after signing in), which is what the :unless prevents
  before_filter :store_current_location, :unless => :devise_controller?

  private
    # override the devise helper to store the current location so we can
    # redirect to it after loggin in or out. This override makes signing in
    # and signing up work automatically.
    def store_current_location
      store_location_for(:user, request.url)
    end

end
