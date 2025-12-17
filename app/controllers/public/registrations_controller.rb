class Public::RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, if: :devise_controller?


    protected

    def configure_permitted_parameters
      # sign_up（新規登録）の時に許可するカラムを指定
      devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :post_code, :address, :telephone_number])
    end
end