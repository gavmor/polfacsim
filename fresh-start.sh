#!/bin/bash

clear

echo "Ages pass, and strong families become whole tribes."

ruby build_pop.rb

ruby fight.rb; sleep 1
ruby fight.rb; sleep 1
ruby fight.rb; sleep 1
ruby fight.rb; sleep 1
ruby fight.rb; sleep 1

while (true) do ruby fight.rb; sleep .25; done;
