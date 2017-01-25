class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def validate_user
      if user_signed_in? == false
        flash[:notice] = "Sign in or Join us to continue!"
        redirect_to '/users/sign_in'
    end
  end
end
