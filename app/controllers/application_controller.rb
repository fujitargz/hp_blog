class ApplicationController < ActionController::Base
  include SessionsHelper

	private

		# ユーザのログインを確認する
		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "ログインが必要なコンテンツです。"
				redirect_to login_url
			end
		end

		# 管理者かどうか確認
		def admin_user
			redirect_to(root_url) unless current_user.admin?
		end
end
