class Reply < ActiveRecord::Base
  belongs_to :tweet

  validates :tweet, presence: true
end
