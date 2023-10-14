class Public::CommentsController < ApplicationController

  def create
    event = Event.find(params[:event_id])
    comment = current_user.comments.new(comment_params)
    comment.event_id = event.id
    comment.save
    flash[:notice] = "コメントを投稿しました。"
    redirect_to event_path(event)
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:alert] = "コメントを削除しました。"
    redirect_to event_path(params[:event_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
