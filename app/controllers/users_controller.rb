class UsersController < ApplicationController
  before_action :set_user, only: [ :update, :destroy ]
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
    if @user.id != current_user.id
      redirect_to root_path, notice: '権限がありません'
    end
  end

  def edit
  end

  def update
    if @user.update( user_params )
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to root_path
      else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon, :icon_cache)
  end

  def set_user
    @user = User.find( params[:id] )
  end
end
