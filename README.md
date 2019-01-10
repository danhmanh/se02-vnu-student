# VNU - STUDENT HELPER
[![Build Status](https://travis-ci.org/danhmanh/se02-vnu-student.svg?branch=master)](https://travis-ci.org/danhmanh/se02-vnu-student)

![VNU LOGO](http://vacd.vn/upload/7980/20131010/Logo_vnu.PNG)

## Mục đích

> VNU-StudentHelper là ứng dụng web được sinh ra nhằm mục đích hỗ trợ sinh viên đang học tập trong nhóm các trường thuộc Đại học Quốc Gia Hà Nội, giúp các bạn sinh viên có thể dễ dàng theo dõi được điểm số. thời khoá biểu và các thông báo quan trọng từ lớp tín chỉ hoặc từ nhà trường.

## Công nghệ sử dụng

* Ruby 2.5.3p105 (https://www.ruby-lang.org/)

* Rails 5.2.1 (https://rubyonrails.org/)

* SQLite3 (https://www.sqlite.org/)

* RSpec - testing framework (http://rspec.info/)

## Chức năng chính

* __Đăng nhập__ : Sinh viên sẽ dùng chính tài khoản VNU mà nhà trường cấp để
đăng nhập vào hệ thống, sau khi đăng nhập sẽ trả về thông tin cơ bản như họ và tên,
mã số sinh viên, .... (Chúng tôi xin cam đoan __không lấy cắp dữ liệu__ của người dùng
và __không lưu mật khẩu__ vào cơ sở dữ liệu)

* __Tạo Post và Comment post__ : Chức năng cơ bản tương tự như mạng xã hội: người dùng
có thể tạo post và mọi người có thể để lại bình luận.

* __Like Post__ : Để lại lượt "thích" nếu người dùng cảm thấy thích thú với bài viết

* __Thời khoá biểu__ : Sắp xếp thời khoá biểu dựa theo danh sách
đăng kí môn có sẵn

* __Tạo nhóm học tín chỉ__ : Tự động tập hợp các sinh viên học cùng
một lớp tín chỉ vào 1 nhóm (group như Facebook) để mọi người có thể dễ dàng chia sẻ
thông báo cũng như tài liệu học tập, ...

* __Tổng hợp kết quả học tập__ (đang phát triển): Tổng hợp lại điểm số, số tín chỉ
của sinh viên và trình bày trực quan (biểu đồ, ...)


## Thành viên đóng góp

* Đặng Xuân Phúc (https://github.com/dangxuanphuc)

* Nguyễn Danh Mạnh (https://github.com/danhmanh)

* Ngô Công Hoan (https://github.com/conghoan0604)
