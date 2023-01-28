class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

    def passthru
        puts "===="
        puts request.env.inspect
        puts "===="
    end
    def github
        
        # request.env['omniauth_auth']
        
    end
    def facebook
        @user = User.from_facebook(request.env['omniauth_auth'])
        if @user.persisted?
            sign_in_and_redirect @user, event: :authentication
        else
            session['devise.facebook'] = request.env['omniauth_auth']
            redirect_to new_user_registration_path
        end
    end
    def google
        puts "====google"
        puts request.env['omniauth_auth'].inspect
        puts "====google"
    end
end 


