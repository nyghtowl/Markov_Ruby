
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

                #clean val of characters
                clean_val = clean_string(val.to_s, 0)

                if cap_dict.has_key? key
                    cap_dict[key] << clean_val
                else
                    cap_dict[key] = [clean_val]
                end
            end

        end

    end
    # puts cap_dict

    #return word dict as the model to pull random words
    [word_dict, cap_dict]

end