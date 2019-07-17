#!/usr/bin/env ruby
genders = ['그 남자', '그 아이', '그 여자', '그 사람들']
components = ['가(이)', '를(을)', '에게', '의']

subjects 	= ['Mann', 'Kind', 'Frau', 'Leute']
answers 	= [
				['der', 'den', 'dem', 'des'],
				['das', 'das', 'dem', 'des'],
				['die', 'die', 'der', 'der'],
				['die', 'die', 'den', 'der']
			   ]

definte_idx = (rand * 100 % 4).to_i 
subject_idx = (rand * 100 % 4).to_i 

if ARGV[0] == 'help' and !ARGV[1].nil?
  ['Nom(가)', 'Akk(를)', 'Dat(에게)', 'Gen(의)'].zip(answers[ARGV[1].to_i - 1]).each{|x|
	  puts "#{x[0]} : #{x[1]}"
  }
  exit
end

if ARGV.nil? == false and ARGV[0].nil? == false
  subject_idx = ARGV[0].to_i - 1
end

puts genders[subject_idx] + components[definte_idx]	
ARGV.clear
input = gets 
puts answers[subject_idx][definte_idx] + ' ' + subjects[subject_idx]
