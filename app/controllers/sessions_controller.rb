class SessionsController < ApplicationController
  def new
    redirect_to root_url if logged_in?
  end

  def create
    result = log_in_vnu
    if result.uri.to_s == "#{Settings.base_url}dang-nhap"
      flash.now[:danger] = "Tên người dùng / mật khẩu không chính xác"
      render :new
    elsif result.uri.to_s.eql? Settings.base_url
      flash[:success] = "Đăng nhập thành công !"
      log_in result
      redirect_to root_url
    else
      flash[:danger] = "Đã có sự cố xảy ra."
      redirect_to root_url
    end
  end

  def destroy
    log_out
    flash[:success] = "Bạn đã đăng xuất thành công"
    redirect_to root_url
  end
end
