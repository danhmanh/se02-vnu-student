module UserCoursesHelper
  def crawl_data_from_list
    agent = Mechanize.new
    cookies = session[:login_cookies]
    agent.cookie_jar.load StringIO.new(cookies)
    result = agent.get "#{Settings.base_url}xem-va-in-ket-qua-dang-ky-hoc/1?layout=main"
    crawl_courses result
    crawl_class_details result
  end

  def crawl_courses(page)
    return if page.search("table").empty?
    rows = page.search("table")[2].search("tr")
    1.upto(rows.size - 2) do |index|
      str_id = rows[index].search("td")[6].text.strip
      course = Course.find_by_str_id str_id
      if course.nil?
        name = rows[index].search("td")[2].text.strip
        amount = rows[index].search("td")[3].text.strip.to_i
        Course.find_or_create_by(str_id: str_id, name: name, amount: amount)
      end
    end
  end

  def crawl_class_details(page)
    return if page.search("table").empty?
    rows = page.search("table")[2].search("tr")
    1.upto(rows.size - 2) do |index|
      str_id = rows[index].search("td")[6].text.strip
      course = Course.find_by_str_id str_id
      # Day of week
      day_of_week = rows[index].search("td")[7].text.strip
      # Thoi gian mon hoc bat dau
      time = get_time rows[index]
      # Thoi luong cua tiet hoc
      duration = get_duration rows[index]
      # Giang duong
      place = get_place rows[index]
      course.course_details.find_or_create_by!(
        day_of_week: day_of_week[1].to_i,
        room_name: place[0],
        start_time: time[0],
        duration: duration[0],
        course_id: course.id,
      )
      course.user_courses.find_or_create_by!(user_id: current_user.id)

      # Neu mon hoc hoc trong 2 ngay
      if day_of_week.include? ","
        course.course_details.find_or_create_by!(
          day_of_week: day_of_week[4].to_i,
          room_name: place[1],
          start_time: time[1],
          duration: duration[1],
          course_id: course.id,
        )
        course.user_courses.find_or_create_by!(user_id: current_user.id)
      end
    end
  end

  private

  def get_time(row)
    time = row.search("td")[8].text.strip
    time.gsub!(/\s+/, "")
    [time[0].to_i] if time.count("-").eql? 1
    [time[0].to_i, time[4].to_i]
  end

  def get_duration(row)
    time = row.search("td")[8].text.strip
    time.gsub!(/\s+/, "")
    duration1 = (time[0].to_i - time[2].to_i).abs + 1
    return [duration1] if time.count("-").eql? 1

    duration2 = (time[4].to_i - time[6..time.size].to_i).abs + 1
    [duration1, duration2]
  end

  def get_place(row)
    str = row.search("td")[9].text.strip
    if !has_two_place? str
      [str]
      # VD: 202T4103T3
    elsif str.count("T").eql?(2)
      [str[0..4], str[5, 10]]
      # VD: Phongmay203T4
    elsif str.include?("Phòng máy") && str.include?("T")
      # Phong may nam sau
      return [str[0..4], "Phòng máy"] if str.index("T").eql? 3
      ["Phòng máy", str[9..(str.size - 1)]]
    end
  end

  def has_two_place?(str)
    if str.count("T").eql?(2) || (str.include?("Phòng máy") && str.include?("T"))
      return true
    end
    false
  end
end
