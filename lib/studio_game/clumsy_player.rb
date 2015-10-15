require_relative 'player'

module StudioGame
  class ClumsyPlayer < Player
    attr_reader :boost_factor
    
    def initialize(name, health=100, boost_factor=1)
      super(name, health)
      @boost_factor = boost_factor
    end

    def found_treasure(treasure)
      damaged_treasure = Treasure.new(treasure.name, treasure.points/2.0)
      super(damaged_treasure)
    end

    def w00t
      @boost_factor.times {super}
    end
  end
end
