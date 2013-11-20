class TweetsController < ApplicationController
  require 'tweetstream'
  def new
    @tweet = Tweet.new
  end
  def home
    TweetStream.configure do |config|
      config.consumer_key       = VvLgP2YlmkiSFpnCRvK4g
      config.consumer_secret    = F6VPrj3R1AEedkt4XUNisAWlkqdMVaHI1LzufsNIc
      config.oauth_token        = 1371269942-gbooJXPmcB9vjPKQkx8q5MUWCYjXHbhajFdsNuW
      config.oauth_token_secret = 8u3eDgVt4uJeHuaBhQ3tJ8P2bpOt4foYEWdn0KYXk6qDj
      config.auth_method        = :oauth
    end
  end
  def track
    Thread.new do
      puts "in thread"
      TweetStream::Client.new.track(@tweet) do |tweet|
        puts "tracking"
        if tweet.geo
          geoTweet = {
            :tweets => [
              :text => tweet.text,
              :coordinates => tweet.geo.coordinates
            ]
          }
          File.open("public/data/data.json","w") do |f|
            f.write(geoTweet.to_json)
          end
          puts "New Tweet"
        end
      end
    end
  end
end
