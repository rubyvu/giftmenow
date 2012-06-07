class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    @auth = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])

    if @auth
      user = User.find @auth.user_id
      sign_in_and_redirect :user, user
      flash[:notice] = "You have signed in by #{omniauth['provider']} account - #{omniauth['user_info']['email']}"
    elsif current_user
      flash[:notice] = "Successfully added #{omniauth['provider']} authentication"
      current_user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      redirect_to root_url
    elsif (user = User.find_by_email(omniauth['user_info']['email']))
      user.authentications.create(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "You have signed in by #{omniauth['provider']} account - #{omniauth['user_info']['email']}"
      sign_in_and_redirect :user, user
    else
       user = Authentication.create_from_hash omniauth
       flash[:notice] = "You have signed in by #{omniauth['provider']} account - #{omniauth['user_info']['email']}"
       sign_in_and_redirect :user, user
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
  
  def passthru
    if params[:message]
      GiftMeNow.logger.error params[:message]
      flash[:notice] = "You should share your account information to login to EZLaw"
      redirect_to new_registrations_path
    else
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end
end
