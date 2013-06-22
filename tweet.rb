'''
generate random text to tweet
'''
require 'rubygems'
require 'twitter'


def sentence_start(cap_hash)
    '''
    choose random key from cap hash model to start response
    '''

    #random.choice(l) -> l.sample
    # start_key = cap_hash.keys.sample.to_s
    # next_key = nil

    # while next_key.nil? do
    #     next_key = cap_hash[start_key].sample.to_s
    # end

    start_key = cap_hash.keys.sample.to_s
    
    if cap_hash[start_key]
        next_key = cap_hash[start_key].sample.to_s
    else
        next_key = []
    end

# if there is no value after capital - need to pull another random word into the sentence

    [start_key, next_key]
end


def endmark(word)
    '''
    generate random end marks to apply to sentence
    '''
    # check for endmark 
    endmarks = [".", "?", "!"]

    if endmarks.include?(word[-1])
        return 0
    else    
        return word + endmarks[rand(endmarks.length)] #apply random endmark
    end
end

def make_text(markov, cap_hash)
    '''
    take in the markov hash and return random text
    '''
    response_list = [] # list to capture values

    #start of the sentence
    first = sentence_start(cap_hash)
    response_list << first[0] << first[1]

    # build sentence response
    begin
        #confirm last word doesn't have endmark
        last_word = response_list[-1]

        if endmark(last_word) != 0

            if markov[last_word]
                response_list << markov[last_word].sample
            else
                #if previous key has no value, choose a random capitalized word
                response_list[-1] = endmark(response_list[-1])
                first = sentence_start(cap_hash)
                response_list << first[0] << first[1]

            end

        #if last word has endmark, start new sentence
        else
            first = sentence_start(cap_hash)
            response_list << first[0] << first[1]
        end

        if response_list.join(' ').length != nil
            len = response_list.join(' ').length
        end
    
    #change up length of response with limit to 120 char
    end while len < rand(140)  
    
    #add final endmark
    if endmark(response_list[-1]) != 0
        response_list[-1] = endmark(response_list[-1])
    end

    # return the respons
    response_list.join(' ') 

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

    #submits tweet
    if random_txt.length < 140
        Twitter.update(random_txt)
    else
        #cuts off end of string and submits tweet
        random_txt = random_txt[0...139] + endmark()
        Twitter.update(random_txt)

    end
end