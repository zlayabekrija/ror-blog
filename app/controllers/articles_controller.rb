class ArticlesController < ApplicationController
   

    def index
        @articles = Article.all
    end

    def new
      if logged_in?
        @article = Article.new
        else
          flash[:danger] = 'Please Login'
          redirect_to articles_path
        end
        @article = Article.new
    end
    def edit
        if logged_in?
        @article = Article.find(params[:id])
        else
          flash[:danger] = 'Please Login'
          redirect_to articles_path
        end
    end
    def create
        @article = Article.new(article_params)
 
        if @article.save
            redirect_to @article
          else
            render 'new'
        end
    end

    def show
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
       if owner? @article.user
        if @article.update(article_params)
          flash[:success] = 'Updated'
          redirect_to @article
        else
          render 'edit'
        end
       else
        flash[:danger] = 'Unauthorized'
        redirect_to articles_path
      end
    end

      def destroy
        @article = Article.find(params[:id])
        if owner? @article.user
        @article.destroy
        flash[:success] = 'Article Deleted'
        else
          flash[:danger] = 'You are not an author'
        end
        redirect_to articles_path
      end

    private
  def article_params
    params.require(:article).permit(:title, :text,:user)
  end
end
