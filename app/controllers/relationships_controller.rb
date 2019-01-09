class RelationshipsController < ApplicationController
  attr_reader :user

  before_action :logged_in_user

  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    @destroy_relationship =
      current_user.active_relationships.find_by followed_id: @user.id

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    @create_relationship = current_user.active_relationships.build

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
