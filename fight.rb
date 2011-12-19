require 'yaml'

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


#names = ["John", "Vana", "Alton", "Norcia", "Samus", "M'dee", "Fuller", "Annie", "Chloe", "lxpk"]

#tribes = {0=>{:name=>"Alpha", :strat=>"Hx", :status=>0}, 1=>{:name=>"Beta", :strat=>"Hx", :status=>0}, 2=>{:name=>"Gamma", :strat=>"Hx", :status=>0}, 3=>{:name=>"Delta", :strat=>"Hx", :status=>0}, 4=>{:name=>"Epsilon", :strat=>"Hx", :status=>0}}



# This function iterates through ever member of the names list, giving each a turn as the argument for take_turn.
def one_round(tribes, turns)
	#Give ever tribe a turn
	tribes.length.times do |i|
		puts "#{i}. Tribe #{tribes[i][:name]}, #{tribes[i][:strat]} has #{tribes[i][:status]}."
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
		puts "#{tribes[i][:name]} fights #{contestants}"
		puts "Now, tribe #{tribes[0][:name]} has #{tribes[0][:status]}."
	end
end

#Load the tribes data from 'tribes.yml'
tribes = YAML.load(File.open('tribes.yml'))

#Have the tribes EACH take 5 turn as the agressor.
one_round(tribes, 5)

File.open('tribes.yml', 'w')  {|f| f.puts(tribes.to_yaml) }
