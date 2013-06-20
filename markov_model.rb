
'''
make markov chain 
'''

def clean_string(astr, first)
    '''
    remove characters from the string
    '''
    if first == 1
        chars = Regexp.escape("()[]-_,:\"*;")
        return astr.gsub(/[#{chars}]/, "")        
    else
        #remove characters from the string
        end_chars = Regexp.escape(".?!")
        clean_val = astr.gsub(/[#{end_chars}]/, "")

    end
end

def make_dict(astr)
    '''
    takes in a string and returns dict of markov chains
    '''
    #clean string of characters and change to list
    word_list = clean_string(astr, 1).split

    #create new dict to hold word pairings
    # a: word_dict = Hash.new
    word_dict = Hash.new { |hash, key| hash[key] = [] }
    cap_dict = Hash.new { |hash, key| hash[key] = [] }

    #loop through string and generate word dict
    word_list.each_with_index do |word, num|
        next if num > word_list.length - 1

        key = word

        val = word_list[num+1]

        next if val.nil?

        #assign key value pair for all words not capitalized
        if (key[0] =~ /[A-Z]{1}/) == nil
            #a: word_dict[key] ||= []
            word_dict[key] << val
        else # assign to cap dict
            #clean val of characters
            clean_val = clean_string(val.to_s, 0)
            #a: cap_dict[key] ||= []
            
            cap_dict[key] << clean_val
        end
    end

    #return word dict as the model to pull random words
    [word_dict, cap_dict]

end