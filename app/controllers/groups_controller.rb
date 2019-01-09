class GroupsController < ApplicationController
  before_action :logged_in_user
  before_action :find_group, only: :show
  def index
    @groups = current_user.groups.includes(:course, :users)
  end

  def show
    @posts = @group.posts.includes(:user)
    @post = current_user.posts.build
  end

  private

  def find_group
    @group = current_user.groups.find_by(id: params[:id])
  end
end
