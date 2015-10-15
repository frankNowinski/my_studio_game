require_relative 'player'

module StudioGame
  class BerserkPlayer < Player
    def initialize(name, health=100)
      super(name, health)
      @w00t_count = 0
    end
    
    def berserk?
      @w00t_count > 5
    end

    def blam
      berserk? ? w00t : super
    end

    def w00t
      super
      @w00t_count += 1
      puts "#{@name} is going BIZZZERK!" if berserk?
    end
  end
end
