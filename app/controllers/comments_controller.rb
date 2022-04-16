class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(text: comment_parameters[:text], author_id: current_user.id,
                                     post_id: @post.id)

    respond_to do |format|
      format.html do
        if @comment.save
          redirect_to user_post_path(@post.author.id, @post.id),
                      notice: 'Comment created successfully'
        else
          redirect_to user_post_path(@post.author.id, @post.id),
                      alert: 'Comment not created, try again!'
        end
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    post = Post.find_by(id: @comment.post_id)
    post.comments_counter -= 1
    @comment.destroy!
    post.save
    flash[:success] = 'Comment Deleted!'
    redirect_to user_post_path(post.author_id, post.id)
  end

  private

  def comment_parameters
    params.require(:comment).permit(:text)
  end
end
