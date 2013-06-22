'''
make markov chain and then generate random text to tweet
'''
require './markov_model.rb'
require './tweet.rb'

def main()

    #read open and read file as a string 
    astr = open("raw_combo.txt").read()

    #create markov models
    markov_chain = make_dict(astr)

    #generate random text and tweet
    random_txt = make_text(markov_chain[0], markov_chain[1]) #pass lower and cap hash
    tweet_post(random_txt)
    
    print "#{random_txt}\n" #test and return value

end

if __FILE__ == $0
    main()
end