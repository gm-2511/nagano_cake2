class Admin::BaseController < ApplicationController
  before_action :authenticate_admin!

  # 管理者ログイン後の遷移先を保証
  def after_sign_in_path_for(resource)
    admin_root_path
  end
end
