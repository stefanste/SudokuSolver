module PositionResetter
  extend ActiveSupport::Concern

  included do
    before_action :reset_position_database!, only: :solve
      
    def self.what
      puts "What"
    end
  end
    
  def reset_position_database!
    #PositionDatabase.all.clear
  end

end
