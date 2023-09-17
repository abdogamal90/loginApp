class ArticlesController < ApplicationController
  # before_action :authenticate_user!
  # load_and_authorize_resource

  def index
    render json: Article.all
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      render json: @article
    else
      render json: { message: 'Article not created.' }, status: 422
    end
  end

  def show
    render json: Article.find(params[:id])
  end

  def update
    article = Article.find(params[:id])
    if article.update(article_params)
      render json: article
    else
      render json: { message: 'Article not updated.' }, status: 422
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy
    render json: { message: 'Article deleted.' }
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def current_user
    @current_user
  end

  def must_be_admin
    render json: { message: 'You are not authorized to do that.' }, status: 403 unless current_user.admin?
  end


end
