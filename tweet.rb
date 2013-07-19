'''
generate random text to tweet

'''
require 'rubygems'
require 'twitter'


def sentence_start(hash)
    '''
    choose random key from cap hash model to start response
    '''
    hash.keys.sample

end

def check_cap(word)
    '''
    check if word is capitalized to determine which hash to use
    '''
    (word[0] =~ /[A-Z]{1}/)
end

def word_sample(val, hash)
    '''
    pull word sample from submitted hash
    '''
    hash[val].sample


end

def val_exists(val, hash)
    '''
    checks if there is a matching value to the key
    if not then requires an endmark to be added to the last value
    '''

    if hash[val] != []
        next_word = word_sample(val, hash)
        end_sent = 'no'
    else
        next_word = sentence_start(hash)
        #capitalize word when it pulls from lower_hash to start sentence
        unless check_cap(next_word)
            next_word = next_word.capitalize
        end
        end_sent = 'yes'
    end

    [next_word, end_sent]

end

def check_endmark(word)
    '''
    check if endmarks exist end of sentence
    '''
    endmarks = [".", "?", "!"]
    endmarks.include?(word[-1])
end

def add_endmark()
    '''
    generate random end marks to apply to sentence
    '''
    endmarks = [".", "?", "!"]

    endmarks[rand(endmarks.length)]
end

def make_text(lower_hash, cap_hash)
    '''
    take in the lower_hash hash and return random text
    '''
    result_array = Array.new([]) # list to capture values
    len = rand(140)  

    # build sentence response
    begin

        #add first capital word of a sentence
        if result_array == []
            result_array << sentence_start(cap_hash)
        end

        # print 1, result_array
        # puts ""

        #adds from capital hash if there's an endmark or last result word is capital
        if check_endmark(result_array[-1]) or check_cap(result_array[-1]) != nil

            #add next_word - confirm val exists or use cap
            next_word, end_sent = val_exists(result_array[-1], cap_hash)

            # print 1.2, result_array[-1]
            # puts ""

            # print 1.3, cap_hash[result_array[-1]]
            # puts ""

            # print 1.4, next_word
            # puts ""

            # print 1.5, check_endmark(result_array[-1])
            # puts ""

            if end_sent == 'yes' and !check_endmark(result_array[-1])
                result_array[-1][-1] += add_endmark()
                # print 2, result_array
                # puts ""
            end

            result_array << next_word
            # print 3, next_word[0]
            # puts ""

        #adds from lower case hash otherwise
        else

            next_word, end_sent = val_exists(result_array[-1], lower_hash)

            if end_sent == 'yes' and !check_endmark(result_array[-1])
                result_array[-1][-1] += add_endmark()
                print 4, result_array
                puts ""
            end

            result_array << next_word

            # print 5, result_array
            # puts ""
        end


    #randomize length of sentence
    end while result_array.join(' ').length < rand(140)
    
    # print 6, result_array

    last_word = result_array[-1]

    #if word is a frozen key, duplicate to unfreeze
    if last_word.frozen? 
        last_word = last_word.dup
    end

    # add final endmark
    if !check_endmark(last_word)
        last_word[-1] += add_endmark()
    end

    # return the respons
    result_array.join(' ') 

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