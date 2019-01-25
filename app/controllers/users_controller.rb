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
        login @user
        flash[:success] = 'Welcome'
        redirect_to @user
      else
        render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
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
