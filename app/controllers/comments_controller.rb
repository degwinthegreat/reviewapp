class CommentsController < ApplicationController
  def create
    @citicize = Citicize.find(params[:citicize_id])
    @comment = @citicize.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to citicize_path(@citicize), notice: '投稿できませんでした...'}
      end
    end
  end

  def destroy
    @citicize = Citicize.find(params[:citicize_id])
    @comment = @citicize.comments.find(params[:id])
    @comment.destroy
    redirect_to citicize_path(@citicize)
  end

  private
  def comment_params
    params.require(:comment).permit(:citicize_id, :content)
  end
end
