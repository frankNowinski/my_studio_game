module StudioGame
  class LoadedDie
    attr_reader :number

    def roll 
      numbers = [1, 1, 2, 5, 6, 6]
      @number = numbers.sample
    end
  end
end
