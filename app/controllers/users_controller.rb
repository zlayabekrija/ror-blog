class UsersController < ApplicationController
  
  def index
    redirect_to articles_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
 
    if @user.save
        log_in @user
        flash[:success] = 'Welcome'
        redirect_to articles_path
      else
        render 'new'
    end
  end

  def edit
    if logged_in?
    @user = User.find(params[:id])
    else
      flash[:danger] = 'No no no no'
      redirect_to articles_path
    end
  end

  def show
    if logged_in?
    @user = User.find(params[:id])
    @articles = Article.where(user: @user.name)
    else
      flash[:danger] = 'Get ouuuuuut'
      redirect_to articles_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation)
  end

end
