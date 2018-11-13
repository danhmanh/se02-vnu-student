module SessionsHelper
  def log_in_vnu
    agent = Mechanize.new
    page = agent.get Settings.base_url
    form = page.forms.first
    form["LoginName"] = params[:session][:str_id]
    form["Password"] = params[:session][:password]
    form.submit
  end

  def get_student_name page
    student_info = page.search("span.user-name").text.strip
    student_info[10..40].strip
  end

  def log_in page
    str_id = params[:session][:str_id]
    name = get_student_name page
    user = User.find_by_str_id str_id
    user = User.create str_id: str_id, name: name if user.nil?
    session[:str_id] = user.str_id
  end

  def log_out
    session.delete :str_id
  end

  def logged_in?
    session[:str_id].present?
  end

  def current_user
    User.find_by_str_id session[:str_id]
  end
end
