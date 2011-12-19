

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
	b_act = actions[ b[:strat] ]

	#Players with act of 0 is Docile, 1 is Hxing.  Whomever wins gets the gold.
	case a_act <=> b_act
	when -1; a[:status] -= 100 && b[:status] += 50
	
	#If they're the same, and Hx, aka 1, they fight, and their odds are even.
	when  0; if a_act.odd? == true
				var = rand(2)        	 	
				if var.odd? == true				
					a[:status] -= 100 && b[:status] += 50
	#If they're the same, and Do, aka 0, they flee.
   		 else a[:status] += 50 && b[:status] -= 100
				end
			else a[:status] += 0
			end
	when +1; a[:status] += 100 && b[:status] -= 100
	end

    adjustments = [a[:status], b[:status]]
	return adjustments
end


names = ["John", "Vana", "Alton", "Norcia", "Samus", "M'dee", "Fuller", "Annie", "Chloe", "lxpk"]

tribes = {0=>{:name=>"Alpha", :strat=>"Hx", :status=>0}, 1=>{:name=>"Beta", :strat=>"Hx", :status=>0}, 2=>{:name=>"Gamma", :strat=>"Hx", :status=>0}, 3=>{:name=>"Delta", :strat=>"Hx", :status=>0}, 4=>{:name=>"Epsilon", :strat=>"Hx", :status=>0}}



# This function iterates through ever member of the names list, giving each a turn as the argument for take_turn.
def one_round(tribes)

	tribes.length.times do |i|
		5.times do
			stuff = encounter(tribes[i], tribes[rand(tribes.length)], tribes)

			tribes[i][:status] = stuff[0]
			tribes[1][:status] = stuff[1]
		end
	puts "Tribe #{tribes[i][:name]} has #{tribes[i][:status]}"
	
	end
end

puts tribes
tribes = IO.read('tribes.txt')
puts tribes

one_round(tribes)
puts "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA"

File.open('tribes.txt', 'w') {|f| f.write(tribes) }
