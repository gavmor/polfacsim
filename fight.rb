require 'yaml' #to save #{tribes}, later.


#This function takes a list, and a desired number of contenders and returns a list of randomly selected members of the hat.
def from_a_hat(hat, contenders)
	output = []
	contenders.times do
		output.concat( [hat[rand(hat.length)]] )
	end
	return output
end

# Here is where current_player takes a turn facing off.
def encounter(a, b, group)

	actions = {"Hx" => 1, "Do" => 0, "Rt" => 0, "By" => 1, "Pr" => rand(2)}
	
	a_act = actions[ a[:strat] ]  
	
	if a_act == 1
		actions = {"Hx" => 1, "Do" => 0, "Rt" => 1, "By" => 0, "Pr" => 1}
	else actions = {"Hx" => 1, "Do" => 0, "Rt" => 0, "By" => 1, "Pr" => rand(2)}
	end

	b_act = actions[ b[:strat] ]

	case a_act <=> b_act

	#Players with act of 0 is Docile, 1 is Hxing.  No fight. Whomever wins gets the gold.
	when -1; a[:status] -= 0
		b[:status] += 50
	
	#If they're the same, and Hx, aka _act 1, they fight, and their odds are even.
	when  0; if a_act.odd? == true
			var = rand(2)        	 	
			if var.odd? == true
			#Heads, I get injured.				
				a[:status] -= 110
				b[:status] += 40

			#Tails the other guy gets injured.
			else a[:status] += 40 
				b[:status] -= 110
			end
			
	#If they're the same, and Do, aka _act 0, they flee
		else var = rand(2)
			if var.odd? == true
				a[:status] += 50
				b[:status] += 0
			else
				a[:status] += 0
				b[:status] += 50
			end
		end
	
	when +1; a[:status] += 50 
		b[:status] -= 0
		
	end

    adjustments = [a[:status], b[:status]]
	return adjustments
end



# This function iterates through ever member of the names list, giving each a turn as the argument for take_turn.
def one_round(tribes, turns)
	#Give every tribe a turn
	tribes.length.times do |i|
#		puts "#{i}. Tribe #{tribes[i][:name]}, #{tribes[i][:strat]} has #{tribes[i][:status]}."
		contestants = ""
		#Current tribe gets an encounter against five random opponents.
		turns.times do |r|
			who_next = rand(tribes.length)

			#We're looking for status changes, so we run an encounter between tribes[i], whose turn it is,
			#and tribes[whos_next], the current of #{times} randomly selected opponents.
			win_loss_adjustments = encounter(tribes[i], tribes[who_next], tribes)
		
			tribes[i][:status] = win_loss_adjustments[0]
			tribes[who_next][:status] = win_loss_adjustments[1]
			
			contestants <<  "#{tribes[who_next][:name]}, "

		end
#		puts "#{tribes[i][:name]} fights #{contestants}"
#		puts "Now, tribe #{tribes[0][:name]} has #{tribes[0][:status]}."
	end
end

def recolor(this_tribe)

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
end

# If a tribe stays at the bottom too long, a new strategy is in order.
def mutation(this_tribe)

	strategies = ["Hx", "Do", "Rt", "By", "Pr"]
	
	new_strat = strategies[rand(5)]
	if this_tribe[:is_last] > 10
		this_tribe[:strat] = new_strat
		this_tribe[:is_last] = -500
	else this_tribe[:is_last] += 1
	end
	puts this_tribe[:is_last]
	recolor(this_tribe)
	
	return this_tribe
end

def leaderboard(tribes)
	#This function takes {tribes}, and outputs a list of tribes[n][:names], sorted by tribes[n][:status].
	
	board = []
	tribes.length.times do	|i|
		board[i] = [tribes[i][:name], tribes[i][:status], i]
	end
	sorted_board = board.sort_by { |a| a[1] }
	sorted_board = sorted_board.reverse()

	board.length.times do |i|
		puts "#{sorted_board[i][0]}: #{sorted_board[i][1]}"
	end
	
	puts "#{sorted_board[-1][0]} is tribe number... #{sorted_board[-1][2]}"
	
	tribes[sorted_board[-1][2]] = mutation(tribes[sorted_board[-1][2]])
	
	return tribes

end


#Load the tribes data from 'tribes.yml'
tribes = YAML.load(File.open('tribes.yml'))

#Have the tribes EACH take 5 turn as the agressor.
one_round(tribes, 1)

tribes = leaderboard(tribes)
#puts leaderboard(tribes)
File.open('tribes.yml', 'w')  {|f| f.puts(tribes.to_yaml) }

puts "\e[5m ------------------------------------------------------------------------------------ \e[0m"
