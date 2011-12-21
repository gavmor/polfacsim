require 'yaml' #to save #{tribes}, later.

#Load the tribes data from 'tribes.yml'
tribes = YAML.load(File.open('tribes.yml'))

def clear(tribes)
	tribes.length.times do |i|
		tribes[i][:status] = 5000
	end
end

#Have the tribes EACH take 5 turn as the agressor.
clear(tribes)

puts tribes[0][:status]

#puts leaderboard(tribes)
File.open('tribes.yml', 'w')  {|f| f.puts(tribes.to_yaml) }
