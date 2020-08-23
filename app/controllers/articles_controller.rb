class ArticlesController < ApplicationController
	before_action :logged_in_user, only: [:index, :new, :create, :destroy]
	before_action :correct_user, only: :destroy

	def index
		@articles = Article.paginate(page: params[:page])
	end

	def new
		if logged_in?
		@article = current_user.articles.build
		@feed_items = current_user.feed.paginate(page: params[:page])
		end
	end

	def create
		@article = current_user.articles.build(article_params)
		if @article.save
			flash[:success] = "Article created!"
			redirect_to root_url
		else
			@feed_items = current_user.feed.paginate(page: params[:page])
			render 'articles#new'
		end
	end

	def destroy
		@article.destroy
		flash[:success] = "Article deleted"
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
