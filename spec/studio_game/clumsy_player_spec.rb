require 'studio_game/clumsy_player'

module StudioGame

	describe ClumsyPlayer do
		before do 
			$stdout = StringIO.new
		end

		before do
			@player = ClumsyPlayer.new("klutz")
		end

		it "only gets half the point value for each treasure" do
			expect(@player.points).to eq 0

			hammer = Treasure.new(:hammer, 50)
			@player.found_treasure(hammer)
			@player.found_treasure(hammer)

			expect(@player.points).to eq 50

			crowbar = Treasure.new(:crowbar, 400)
			@player.found_treasure(crowbar)

			expect(@player.points).to eq 250

			yielded = []

			@player.each_found_treasure do |treasure|
				yielded << treasure
			end

			expect(yielded).to eq [Treasure.new(:hammer, 50), Treasure.new(:crowbar, 200)]
		end

		context "with a boost_factor" do
			before do
				@boost_factor = 3
				@initial_health = 100
				@player = ClumsyPlayer.new("buster", @initial_health, @boost_factor)
			end

			it "it is not empty" do 
				expect(@player.boost_factor).to eq 3
			end

			it "boost_factor is multiplied by health when w00ted" do
				@player.w00t

				expect(@player.health).to eq @initial_health + (@boost_factor * 15)
			end
		end
	end
end
