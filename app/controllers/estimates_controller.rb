class EstimatesController < ApplicationController
  def index
    @estimate = current_user.estimate_users.all
  end

  def new
    @estimate = Estimate.new
    @estimate.citicize_id = params[:citicize_id]
    @estimate.user_id = current_user.id
  end

  def create
    @estimate = Estimate.new(estimate_params)
    estimate = Estimate.create(user_id: @estimate.user_id,citicize_id: @estimate.citicize_id, rate: @estimate.rate)
    @citicize = Citicize.find(@estimate.citicize_id)
    @citicize = @citicize.user
    redirect_to citicizes_url, notice: "#{@citicize.name}さんのレビューを評価しました"
  end

  def destroy
    estimate = current_user.estimates.find_by(citicize_id: params[:id]).destroy
    @citicize = Citicize.find(params[:id])
    @citicize = @citicize.user
    redirect_to citicizes_url, notice: "#{@citicize.name}さんのレビューの評価を削除しました"
  end

  private
  def estimate_params
    params.require(:estimate).permit(:citicize_id,:user_id, :rate, :id)
  end
end
