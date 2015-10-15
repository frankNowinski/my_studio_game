require_relative 'die'
require_relative 'playable'
require_relative 'loaded_die'

module StudioGame	
	module GameTurn
		def self.take_turn(player)
			die = Die.new

			case die.roll
			when 5..6
				player.w00t
				puts "#{player.name} rolled a #{die.number} and got w00ted!"
			when 1..2
				player.blam
				puts "#{player.name} rolled a #{die.number} and got blammed!"
			else
				puts "#{player.name} rolled a #{die.number} and got skipped"
			end
			treasure = TreasureTrove.random
			player.found_treasure(treasure)
		end
	end
end



