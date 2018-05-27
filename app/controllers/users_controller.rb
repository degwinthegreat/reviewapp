class UsersController < ApplicationController
  def new
    if params[:back]
      @user = User.new
      @user.icon.retrieve_from_cache! params[:cache][:icon]
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    @user.icon.retrieve_from_cache! params[:cache][:icon] if params[:cache][:icon].present?
    if @user.save
      redirect_to user_path(@user.id), notice: 'ユーザーを追加しました！'
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon, :icon_cache)
  end
end
