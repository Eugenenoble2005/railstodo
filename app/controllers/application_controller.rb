class ApplicationController < ActionController::Base
    def auth_guard
        redirect_to controller:'users', action: 'login' unless session[:user_id]
    end

    def is_auth
        true if session[:user_id]
    end

    def signed_in_user
        User.find_by(id: session[:user_id])
    end
    helper_method :is_auth,:auth_guard,:signed_in_user
end
