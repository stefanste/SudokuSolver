class TweetsController < ApplicationController
  
  def index
    @timeline = twitter.user_timeline('madcanard')
  end
  
  private
  
  def twitter
    Futebol::Application.config.twitter
  end
end