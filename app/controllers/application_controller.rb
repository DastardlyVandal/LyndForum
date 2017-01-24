class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def validate_user
      if user_signed_in? == false
        redirect_to '/users/sign_in'
    end
  end
end
