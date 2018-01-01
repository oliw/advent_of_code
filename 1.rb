file = File.open("1-input.txt", "r")
captcha = file.read.to_i
count = 0
digits = captcha.to_s.split('').map(&:to_i)
digits.each_with_index{|digit, idx| count+= digit if digits[(idx+1)%digits.length] == digit}
puts count