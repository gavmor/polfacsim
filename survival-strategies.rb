# Then print that round's statuses.  A single execution of this function should print starting status, and resulting status.
# OR, what would be cooler, just a leaderboard. Retaliators SHOULD rise to the top.

#[Hx] "Hawks"		[Do] "Doves"		[Rt] "Retaliator"	[By] "Bully"		[Pr] "Prober-retaliator"
#[Hx] to [Hx]		[Do] to [Hx]		[Do->Hx][Hx]		[Do] to [Hx]		[Do->Hx][Hx]
#[Hx] to [Do]		[Do] to [Do]		[Do] to [Do]		[Hx] to [Do]		[Do] to [Do]
#[Hx] to [Rt]		[Do] to [Rt]		[Do] to [Rt]		[Hx->Do][Rt]		[Do] to [Rt]
#[Hx] to [By]		[Do] to [By]		[Hx] to [By]		[Hx->Do][By]		[Do->Hx][By]
#[Hx] to [Pr]		[Do] to [Pr]		[Do->Hx][Pr]		[Hx->Do][Pr]		[Do] to [Pr]

# If Hx == true, run hawk
Def bully (other_strategy, other_stats, own_strategy, own_stats)
	if other_strategy == "Do"
		attack(own_stats, other_stats)
	else flee and flip_status
Hx = 2
Do = 1

if my_strategy > ur_strategy == true
	my_status += 50	
	ur_status += 0
elsif my_strategy == ur_strategy and my_strategy == Do
	
if win 	status += 50
if lose status += 0
if inj	status -= 100
if time status -= 10

Hawk 	= 	{"default_state" => "Hx"}
Dove 	= 	{"default_state" => "Do"}
Retaliator = 	{"default_state" => "Do"}
Bully	=	{"default_state" => "Hx"}
Prober	=	{"default_state" => mostly_Do}
