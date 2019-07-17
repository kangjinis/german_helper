genders = ['그 남자', '그 개', '그 여자', '그 사람들']
components = ['가(이)', '를(을)', '에게', '의']

subjects 	= ['Mann', 'Hund', 'Frau', 'Leute']
answers 	= [
				['der', 'den', 'dem', 'des'],
				['das', 'das', 'dem', 'des'],
				['die', 'die', 'der', 'der'],
				['die', 'die', 'den', 'der']
			   ]

definte_idx = (rand * 100 % 4).to_i 
subject_idx = ARGV[0].to_i - 1 || (rand * 100 % 4).to_i

puts genders[subject_idx] + components[definte_idx]	
ARGV.clear
input = gets 
puts answers[subject_idx][definte_idx] + ' ' + subjects[subject_idx]
