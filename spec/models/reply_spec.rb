require 'spec_helper'
require 'rails_helper'

describe Reply do

	subject(:reply) { Reply.create(fulltext: "hilo") }

	it 'should not be valid without a corresponding Tweet' do
		expect(reply).not_to be_valid
	end

  context 'with a corresponding tweet' do
  	let(:tweet) { Tweet.create(fulltext: 'oy') }
  	subject(:reply) { Reply.create(fulltext: 'what', tweet_id: tweet.id) }

  	it 'should be valid' do
  		expect(reply).to be_valid
  	end
  end


end