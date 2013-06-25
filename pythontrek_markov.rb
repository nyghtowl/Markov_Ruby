'''
make markov chain and then generate random text to tweet
'''
require './markov_model.rb'
require './markov_model2.rb'
require './tweet.rb'
require 'rubygems'
require 'twitter'

def main_functional()

    #read open and read file as a string 
    astr = open("raw_combo.txt").read()

    #create markov models
    markov_chain = make_dict(astr)

    #generate random text and tweet
    random_txt = make_text(markov_chain[0], markov_chain[1]) #pass lower and cap hash
    tweet_post(random_txt)
    
    print "#{random_txt}\n" #test and return value

end


def tweet_post(random_txt)
    '''
    function to post random text on twitter
    '''
    #pull Twitter keys
    Twitter.configure do |config|
        config.consumer_key = ENV['KEY']
        config.consumer_secret = ENV['SECRET']
        config.oauth_token = ENV['TOKEN_KEY'] 
        config.oauth_token_secret =  ENV['TOKEN_SECRET']
    end

    #cuts off end of string if too long
    if random_txt.length > 140
        random_txt = random_txt[0...139] + endmark()
    end

    #submits tweet
    Twitter.update(random_txt)

end


def main_object()
    sample_text = open("raw_combo.txt").read()
    generator = TwitterMarkov.new sample_text
    random_txt = generator.generate()
    puts random_txt
    tweet_post(random_txt)
end

if __FILE__ == $0
    main_object()
end