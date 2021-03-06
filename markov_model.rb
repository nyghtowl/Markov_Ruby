
'''
make markov chain 

create two hashes to hold markov chains
upper case keys hash
lower case keys hash 
both can hold values with upper and lower
values stripped of all characters except end characters
keys stripped of all characters

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
    word_array = clean_string(astr, 1).split

    #create hash with word pairings
    lower_hash = Hash.new { |hash, key| hash[key] = [] } #lower case keys
    cap_hash = Hash.new { |hash, key| hash[key] = [] } #upper case keys

    #loop through string and generate word dict
    word_array.each_with_index do |word, num|
        next if num > word_array.length - 1

        key = word

        val = word_array[num+1]

        next if val.nil?

        #assign key value pair to either lower or cap hash
        if (key[0] =~ /[A-Z]{1}/) == nil
            lower_hash[key] << val
        else
            #strip end marks off capital words
            clean_key = clean_string(key.to_s, 0)
            
            cap_hash[clean_key] << val
        end
    end

    #return two dictionaries to pull words
    [lower_hash, cap_hash]


end