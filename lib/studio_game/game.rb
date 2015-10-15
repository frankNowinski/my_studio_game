require_relative 'player'
require_relative 'die'
require_relative 'game_turn'
require_relative 'treasure_trove'
require 'csv'

module StudioGame
	class Game
		attr_reader :title
		attr_accessor :players

		def initialize(title)
			@title, @players = title, []
		end

		def load_players(from_file)
			CSV.foreach(from_file) do |row|	
				player = Player.new(row[0], Integer(row[1]))
				add_player(player)
			end
		end

		def add_player(player)
			@players << player
		end

		def print_name_and_health(player)
			puts "#{player.name} (#{player.health})"
		end

		def sort_by_health(players)
			players.sort {|a,b| b.health <=> a.health}
		end

		def high_scores(player)
      formatted_name = player.name.ljust(20, '.')
      "#{formatted_name} #{player.score}"
    end

		def first_place
			first = @players.sort {|a,b| b.score <=> a.score}
			winner = first[0]
			puts "#{winner.name} has the highest score!"
		end

		def total_points
			@players.reduce(0) {|sum, player| sum + player.points}
		end

		def print_stats
			strong_players, whimpy_players = @players.partition{|player| player.strong?}

			puts "\n***#{title} Statistics***"

			puts "\n#{strong_players.size} strong players:"
			sort_by_health(strong_players).each do |player|
				print_name_and_health(player)
			end

			puts "\n#{whimpy_players.size} whimpy players:"
			sort_by_health(whimpy_players).each do |player|
				print_name_and_health(player)
			end

			puts "\n#{@title} High Scores:"
      @players.sort.each do |player|
        puts high_scores(player)
      end
      puts
      puts first_place

			puts "TOTAL TREASURE POINTS FOUND: #{total_points} "

			@players.sort.each do |player|
				puts "\n#{player.name}'s total treasure points:"
				player.each_found_treasure do |treasure|
					puts "#{treasure.points} total #{treasure.name} points"
				end
				puts "#{player.points} grand total points"
			end
		end

		def play(rounds)
			puts "\nThere are #{@players.size} players in #{@title}:"
			@players.each {|player| puts player}

			treasures = TreasureTrove::TREASURES 

			puts "\nThere are #{treasures.size} treasures to be found:"
			treasures.each do |treasure|
				puts "A #{treasure.name} is worth #{treasure.points} points."
			end
			puts

			1.upto(rounds) do |round|
				break if yield if block_given?
				
				@players.each do |player|
					puts "Round #{round}".center(33)
					GameTurn.take_turn(player)
					puts player
					puts
				end
			end
		end

		def save_high_scores(filename="bin/high_scores.txt")
			File.open(filename, "w") do |file|
				file.puts "#{title}'s High Scores:"
					@players.sort.each do |player|
					file.puts high_scores(player)
				end
			end
		end
	end
end
