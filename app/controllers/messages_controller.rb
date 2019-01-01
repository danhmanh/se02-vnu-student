class MessagesController < ApplicationController
  before_action :logged_in_user

  def index
    session[:conversations] ||= []
    @users = User.all.where("id != ?", current_user.id)
    @conversations = Conversation.includes(:recipient, :messages)
      .find(session[:conversations])
  end
end
