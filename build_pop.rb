##################################################
def build_pop()
	tribes = {}
	puts "How many tribes in the valley?"
	pop = gets.to_i	
	pop.times do |i|
		this_tribe = {}
		puts "Name?"
		name = gets.chomp()
		this_tribe[:name] = name
		puts "Got it; the honorable #{this_tribe[:name]}"
		
		puts "Strategy?"
		strat = gets.chomp()
		this_tribe[:strat] = strat
		puts "Good luck, #{this_tribe[:strat]}"
		
		this_tribe[:status] = 0
		
		tribes[i] = this_tribe
		
	end
    return tribes
end

stuff = build_pop()
puts stuff
File.open('tribes.yml', 'w') {|f| f.puts(stuff.to_yaml) }
