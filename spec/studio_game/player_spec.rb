require 'studio_game/player'

module StudioGame
	
	describe Player do
		before do
			$stdout = StringIO.new
		end

		before do
			@health = 150
			@player = Player.new("frank", @health)
		end

		it "has a capitalized name" do
			expect(@player.name).to eq("Frank")
		end

		it "has an inital health" do
			expect(@player.health).to_not eq(0)
		end

		it "string" do
			expect(@player.to_s).to eq "#{@player.name} has a health of #{@health}, points value of #{@player.points}, and score of #{@player.score}."
		end

		it "computes a score as the sum of its health and treasures found" do
			@player.found_treasure(Treasure.new(:hammer, 50))
			@player.found_treasure(Treasure.new(:hammer, 50))

			expect(@player.score).to eq 250
		end

		it "should decrease their health when blammed" do
			@player.blam
			expect(@player.health).to eq(@health -= 10)
		end

		it "should increase their health when they get w00t" do
			@player.w00t
			expect(@player.health).to eq(@health += 15)
		end

		context "with a health greater than 100" do
			before do 
				@initial_health = 150
				@player = Player.new("Frank", @initial_health)
			end

			it "is strong" do
				expect(@player).to be_strong
			end
		end

		context "with a health of 100 or less" do
			before do 
				@initial_health = 100
				@player = Player.new("Frank", @initial_health)
			end

			it "is whimpy" do
				expect(@player).not_to be_strong
			end
		end

		context "in a collection of players" do 
			before do 
				@player1 = Player.new("Frank", 100)
				@player2 = Player.new("Tina", 200)
				@player3 = Player.new("Tommy", 300)

				@players = [@player1, @player2, @player3]
			end

			it "is sorted by highest score to lowest score" do
				expect(@players.sort).to eq([@player3, @player2, @player1])
			end
		end

		it "computes points as the sum of all treasure points" do
			expect(@player.points).to eq 0

			@player.found_treasure(Treasure.new(:hammer, 50))

			expect(@player.points).to eq 50

			@player.found_treasure(Treasure.new(:crowbar, 400))

			expect(@player.points).to eq 450

			@player.found_treasure(Treasure.new(:hammer, 50))

			expect(@player.points).to eq 500
		end

		it "yields each found treasure and its total points" do
		  @player.found_treasure(Treasure.new(:skillet, 100))
		  @player.found_treasure(Treasure.new(:skillet, 100))
		  @player.found_treasure(Treasure.new(:hammer, 50))
		  @player.found_treasure(Treasure.new(:bottle, 5))

		  yielded = []
		  @player.each_found_treasure do |treasure|
		    yielded << treasure
		  end

		  expect(yielded).to eq [
		    Treasure.new(:skillet, 200),
		    Treasure.new(:hammer, 50),
		    Treasure.new(:bottle, 5)
		 	]
		end
	end
end


