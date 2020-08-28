class UsersController < ApplicationController
	include SessionsHelper

	before_action :logged_in_user
  before_action :admin_user

  def index
    @users =User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
		@articles = @user.articles.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザを作成しました。"
      redirect_to users_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィールを変更しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザを削除しました。"
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :admin)
    end

		#ユーザのログインを確認する
		def logged_in_user
			unless logged_in?
				store_location
				flash[:danger] = "ログインが必要なコンテンツです。"
				redirect_to login_url
			end
		end

    # 正しいユーザかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
