require'studio_game/berserk_player'

module StudioGame
	
	describe BerserkPlayer do
		before do 
			$stdout = StringIO.new
		end

		before do
			@initial_health = 50
			@player = BerserkPlayer.new("berserk", @initial_health)
		end

		it "does not go berserk when w00ted under 5 times" do
			1.upto(5) {@player.w00t}

			expect(@player.berserk?).to be_falsey
		end

		it "goes berserk when w00ted more than 5 times" do
			1.upto(6) {@player.w00t}

			expect(@player.berserk?).to be_truthy
		end

		it "gets w00ted instead of blammed when in berserk mode" do
			1.upto(6) {@player.w00t}
			1.upto(3) {@player.blam}

			expect(@player.health).to eq @initial_health + (9 * 15)
		end
	end
end

