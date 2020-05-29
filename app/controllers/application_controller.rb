class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
# デバイス機能実行前にconfigure_permitted_parametersの実行をする。
  protect_from_forgery with: :exception
  before_action :set_host


  protected

def set_host
  Rails.application.routes.default_url_options[:host] = request.host_with_port
end

def after_sign_in_path_for(resource)
  # NotificationMailer.send_confirm_to_user(resource).deliver
  completed_path
end

# sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
def after_sign_up_path_for(resource)
  # NotificationMailer.send_confirm_to_user(resource).deliver
  completed_path
end

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: %i[sur_name,name, email, password, password_confirmation, remember_me])
  devise_parameter_sanitizer.permit(:sign_in, keys: %i[sur_name,name:login, email, password, remember_me])
  devise_parameter_sanitizer.permit(:account_update, keys: %i[sur_name,name, :email, :password, :password_confirmation, :current_password])
end

end
