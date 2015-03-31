class Tweet < ActiveRecord::Base
  belongs_to :user
  has_one :reply

  def self.chop(target, collection)
  	current_index = (collection.size)/2
  	current_value = collection[current_index]

  	return current_index if current_value == target

  	if collection.size <= 2
  		# Doing collection.index(target).presence in a method which finds index feels like cheating...
  		return 0 if collection[0] == target		
  		return 1 if collection[1] == target
      raise Exception, "Value not present in collection!"
  	end

  	if target > current_value
  		current_index + chop(target, collection[current_index..collection.size])
  	else
  		chop(target, collection[0..current_index])
  	end
  end

  def self.basic_chop(target, collection)
    return -1 if collection.empty?

    lower = 0
    upper = collection.size

    loop do
      current_index = (lower + upper) / 2
  	  current_value = collection[current_index]
      
      return current_index if current_value == target

      if (upper - lower).abs <= 1
        return lower if collection[lower] == target
        return upper if collection[upper] == target
        return -1
      end
      
      if target > current_value
        lower = current_index
      else
        upper = current_index    
      end
    end
  end
end
