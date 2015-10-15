module StudioGame
  module Playable
    attr_accessor :health

    def blam
      self.health -= 10
    end

    def w00t
      self.health += 15
    end

    def strong?
      health > 100 ? true : false
    end
  end
end
