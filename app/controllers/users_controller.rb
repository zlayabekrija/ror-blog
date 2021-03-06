class UsersController < ApplicationController
  include UsersHelper
  
  def index
    if only_admin?
      @users = User.paginate(page: params[:page],per_page: 10)
    else
      flash[:danger] = 'Not authorized'
      redirect_to articles_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if User.all.count == 0
      @user.user_level = 0
    end
    if @user.save
      @user.send_activation_email
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
     

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
    if @user.name == current_user.name
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
    else
      flash[:danger] = 'Not yours'
      redirect_to articles_path
    end
  end

  def destroy
    @user = User.find(params[:id]).destroy
    flash[:success] = 'User has been killed'
    redirect_to users_path
  end
  
 

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,:password_confirmation,:picture)
  end
end
