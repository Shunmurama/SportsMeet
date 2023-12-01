class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index, :show, :result, :home]
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
   def after_sign_up_path_for(resource)
    　root_path
   end

   def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
       admin_index_path
    else
       user_mypage_path
    end
   end

   def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope ==:admin
       root_path
    else
       root_path
    end
   end


  protected
   def configure_permitted_parameters

    # サインアップ時にストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [
     :last_name, :first_name, :image,
     :group, :phone_number, :postal_code, :address, :birthday, :gender, :prefecture_id,
     category_ids: []
     ])

    # アカウント編集の時のストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:last_name, :first_name, :image, :group, :phone_number, :postal_code, :address, :birthday, :gender, :prefecture_id, :user_interest_id])
   end
end
