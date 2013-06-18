# Sample ruby file

'''
either markov or dashboard

pull in data from api
parse data from api
post onto a page that lists a couple summary points

'''

consumer_key = ENV['KEY']
consumer_secret = ENV['SECRET']
access_token_key = ENV['TOKEN_KEY'] 
access_token_secret = ['TOKEN_SECRET']

def make_dict(astr)
    '''
    takes in a string and returns dict of markov chains
    '''
    #remove characters from the string
    chars = Regexp.escape("()[]-_,:\"*;")
    clean_result = astr.gsub(/[#{chars}]/, "")

    #split the submitted text
    word_list = clean_result.split()

    #create new dict to hold word pairings
    word_dict = Hash.new 
    cap_dict = Hash.new

    #loop through string and generate word dict
    word_list.each_with_index do |word, num|

        if num < word_list.length - 1
            key = "" #create placeholder for key value
            val = [] #create empty list to hold value

            #define key
            key = word_list[num]

            #define value
            if word_list[num+1]
                val = word_list[num+1]
            else
                break
            end

            #assign key value pair for all words not capitalized
            if word_dict.has_key? key
                word_dict[key] << val
            else
                if (key[0] =~ /[A-Z]{1}/) == nil
                    word_dict[key] = [val]
                end
            end

            # create dict for capitalized words
            if (key[0] =~ /[A-Z]{1}/) != nil

                #remove characters from the string
                chars = Regexp.escape(".?!")
                val = val.gsub(/[#{chars}]/, "")

                if cap_dict.has_key? key
                    cap_dict[key] << val
                else
                    cap_dict[key] = [val]
                end
            end

        end

    end
    #return word dict as the model to pull random words
    [word_dict, cap_dict]

end

def sentence_start(cap_dict)
    '''
    choose random key from cap dict model to start response
    '''
    cap_dict.keys[rand(cap_dict.length)]
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
        return word + endmarks[rand(endmarks.length)]
    end
end

def make_text(markov, cap_dict)
    '''
    take in the markov dict and return random text
    '''
    response_list = [] # list to capture values

    #choose the start of the sentence
    start_key = sentence_start(cap_dict)

    response_list << start_key << cap_dict[start_key].sample.to_s

    # build sentence response
    begin
        x = response_list[-1]

        if endmark(x[-1]) != 0
            if markov[x]
                response_list << markov[x].sample
            else
                #if previous key has no value, choose a random capitalized word
                response_list[-1] = endmark(response_list[-1])
                response_list << sentence_start(cap_dict)
            end
        else
            response_list << sentence_start(cap_dict)
        end

        if response_list.join(' ').length != nil
            len = response_list.join(' ').length
        end
    
    
    #change up length of response with limit to 120 char
    end while len < rand(120)  
    
    #add final endmark
    if endmark(response_list[-1]) != 0
        response_list << endmark(response_list[-1])
    end

    # return the respons
    response_list.join(' ') + "\n" 
end

# def tweet_post(randomtxt)
    '''
    function to post random text on twitter
    '''
    #placeholder for twitter link
    #if random_txt.length < 140
        # Twitter.configure do |config|
        #     config.consumer_key= , consumer_key = ENV['KEY']
        #     config.consumer_secret= , consumer_secret = ENV['SECRET']
        #     config.access_token_key= , access_token_key = ENV['TOKEN_KEY'] 
        #     config.access_token_secret=  access_token_secret = ['TOKEN_SECRET']
        # end
        #Twitter.update(random_txt)
    #else:
        #random_txt = random_txt[0...139] + endmark()
        #Twitter.update(random_txt)

    #end


def main()
    '''
    pull in file, apply to dictionary and then pull random text
    '''
    # key_len = 1
   
    #read open and read file as a string 
    astr = open("raw_combo.txt").read()

    #create markov model
    markov_chain = make_dict(astr)

    #generate random text to post
    random_txt = make_text(markov_chain[0], markov_chain[1])

    # tweet_post(randomtxt)

    
    print random_txt #test and return value

end

if __FILE__ == $0
    main()
end