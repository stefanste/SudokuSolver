class PositionDatabase

  attr_accessor :positions

  def initialize
    @positions = []
  end

  @@instance = PositionDatabase.new

  def self.instance
    @@instance
  end

  def known_positions
    @@instance.positions.select{|position|
      position.known?
    }
  end

  private_class_method :new
end
