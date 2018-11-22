class SessionsController < ApplicationController
  def new
    redirect_to root_url if logged_in?
  end

  def create
    result = log_in_vnu
    if result.uri.to_s == "#{Settings.base_url}dang-nhap"
      flash.now[:danger] = "Invalid username/password combination"
      render :new
    elsif result.uri.to_s.eql? Settings.base_url
      flash[:success] = "Login successfully!"
      log_in result
      redirect_to root_url
    else
      flash[:danger] = "Something went wrong."
      redirect_to root_url
    end
  end

  def destroy
    log_out
    flash[:success] = "Logout successfully!"
    redirect_to root_url
  end
end
