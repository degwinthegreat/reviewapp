class CiticizesController < ApplicationController
  before_action :set_citicize, only: [:show, :edit, :update, :destroy]
  before_action :login_check, only: [:new, :edit, :show, :index]
  def index
    @citicizes = Citicize.all
  end

  def new
    if params[:back]
      @citicize = Citicize.new(citicize_params)
      @citicize.artwork.retrieve_from_cache! params[:cache][:artwork]
    else
      @citicize = Citicize.new
    end
  end

  def create
    @citicize = Citicize.new(citicize_params)
    @citicize.user_id = current_user.id
    @citicize.artwork.retrieve_from_cache! params[:cache][:artwork] if params[:cache][:artwork].present?
    respond_to do |format|
      if @citicize.save
        ConfirmMailer.confirm_mailer(@current_user, @citicize).deliver
        format.html { redirect_to @citicize, notice: '投稿しました！'}
        format.json { render :show, status: :created, location: @citicize }
      else
        format.html { render :new }
        format.json { render json: @citicize.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    @citicize = Citicize.new(citicize_params)
    render :new if @citicize.invalid?
  end

  def show
    @estimates = current_user.estimates
    @estimate = @estimates.where(citicize_id: @citicize.id)
    @comment = @citicize.comments.build
    @comments = @citicize.comments
  end

  def edit
  end

  def update
    if @citicize.update(citicize_params)
      redirect_to citicizes_path, notice: "レビューを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @citicize.destroy
    redirect_to citicizes_path, notice:"レビューを削除しました"
  end

  private
  def citicize_params
    params.require(:citicize).permit(:title,:content,:album,:artist,:user_id, :artwork, :artwork_cache)
  end

  def set_citicize
    @citicize = Citicize.find(params[:id])
  end

  def login_check
    unless user_signed_in?
      flash[:notice] = "権限がありません"
      redirect_to root_path
    end
  end
end
