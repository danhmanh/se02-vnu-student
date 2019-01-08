class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like, only: [:destroy]

  def create
    respond_to do |format|
      if already_liked?
        format.html {
          flash[:danger] = "You can't like more than once"
          redirect_to root_path
        }
      else
        @like = @post.likes.build user_id: current_user.id
        
        if @like.save
          format.html { redirect_back fallback_location: root_path }
          format.json { render json: { likes: @post.likes.count } }
        else
          format.html { redirect_back fallback_location: root_path  }
        end
      end
    end
  end

  def destroy
    respond_to do |format|
      if !(already_liked?)
        format.html {
          flash.now[:danger] = "Cannot unlike"
          redirect_to root_path
        }
      else
        @like.destroy
        format.html { redirect_back fallback_location: root_path }
        format.json { head :no_content }
      end
    end
  end

  private

  def find_post
    @post = Post.find_by id: params[:post_id]
  end

  def find_like
    @like = @post.likes.find_by id: params[:id]
  end

  def already_liked?
    Like.where(user_id: current_user.id, post_id:
      params[:post_id]).exists?
  end
end
