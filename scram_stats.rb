require 'yaml'
##################################################

tribes = YAML.load(File.open('tribes.yml'))


def scram_strats(tribes)
	
#	puts "How many tribes in the valley?"
	pop = tribes.length	
	pop.times do |i|

		this_tribe = tribes[i]

		strategies = ["Hx", "Do", "Rt", "By", "Pr"]
		
		strat = strategies[rand(5)]

#		if i > pop/2
#			strat = "Do"
#		else
#			strat = "Do"
#		end
		this_tribe[:strat] = strat

		case this_tribe[:strat] 
		when "Hx"
			this_tribe[:name] = "\e[31m" + this_tribe[:name][5...-4] + "\e[0m"
		when "Do"
			this_tribe[:name] = "\e[36m" + this_tribe[:name][5...-4] + "\e[0m"
		when "Rt"
			this_tribe[:name] = "\e[32m" + this_tribe[:name][5...-4] + "\e[0m"
		when "By"
			this_tribe[:name] = "\e[33m" + this_tribe[:name][5...-4] + "\e[0m"
		else
			this_tribe[:name] = "\e[35m" + this_tribe[:name][5...-4] + "\e[0m"
			
		end
		
#		puts "Good luck, #{this_tribe[:strat]}"
		
	
		
		tribes[i] = this_tribe
		
	end
    return tribes
end

stuff = scram_strats(tribes)
#puts stuff
File.open('tribes.yml', 'w') {|f| f.puts(stuff.to_yaml) }
