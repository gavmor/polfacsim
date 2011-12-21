#!/bin/bash

clear

echo "Ages pass, and nations grow older."

ruby clear.rb
ruby scram_stats.rb

while (true) do ruby fight.rb; sleep .5; done;
