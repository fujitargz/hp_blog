class ArticlesController < ApplicationController
	before_action :logged_in_user
	before_action :correct_user, only: [:edit, :destroy]
	before_action :admin_user, only: [:create, :new, :edit, :destroy]

	def index
		@articles = Article.paginate(page: params[:page])
	end

	def create
		@article = current_user.articles.build(article_params)
		if @article.save
			flash[:success] = "記事を投稿しました。"
			redirect_to root_url
		else
			@feed_items = current_user.feed.paginate(page: params[:page])
			render 'articles#new'
		end
	end

	def new
		if logged_in?
		@article = current_user.articles.build
		@feed_items = current_user.feed.paginate(page: params[:page])
		end
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			flash[:success] = "記事を更新しました。"
			redirect_to root_url
		else
			render 'edit'
		end
	end

	def show
		@article = Article.find(params[:id])
	end

	def destroy
		@article.destroy
		flash[:success] = "記事を削除しました。"
		redirect_to request.referrer || roor_url
	end

	private

		def article_params
			params.require(:article).permit(:subject, :content)
		end

		def correct_user
			@article = current_user.articles.find_by(id: params[:id])
			redirect_to root_url if @article.nil?
		end
end
