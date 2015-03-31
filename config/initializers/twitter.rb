class TwitterClient
  def self.connect
    twitter_client = Twitter::REST::Client.new do |config|
      # Credentials...
    end
  end
end

Futebol::Application.config.twitter = TwitterClient.connect
