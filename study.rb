#!/usr/bin/ruby
load 'trollop.rb'
abort("Please provide one file of vocabulary terms") if ARGV.count < 1

class Hash
   def get_rand_pair
     key = self.keys[rand(self.length)]
     [key, self[key]]
   end
end

opts = Trollop::options do
    opt :repetitions, "Number of repetitions for each vocabulary term", :default => 5
    opt :file, "File containing your vocabulary terms", :type => :string
end
Trollop::die :repetitions, "must be greater than or equal to 1" if opts[:repetitions] <= 0
Trollop::die :file, "must exist" unless File.exist?(opts[:file]) if opts[:file]

vocab = {}
right_count = {}
File.open(opts[:file], "r") do |file|
    file.each_line do |line|
        definition_term = line.split('--').map { |e| e.chomp }
        vocab[definition_term[0]] = definition_term[1]
        right_count[definition_term[0]] = -1
    end
end

score = 0
total = 0
mru = [] # Queue used to increase variety of which terms are shown
begin
    puts 'Press Ctrl-C whenever you are done studying.'
    loop {
        term = vocab.get_rand_pair

        # Skip current term if user has already gotten it right several times or
        # if the queue still includes that term
        next if right_count[term[0]] >= opts[:repetitions] || mru.include?(term[0])

        mru.push(term[0]) # Add term to most recently seen queue
        print "#{term[0]}? "

        # Ignore white space and case
        answer = STDIN.gets.chomp.downcase.gsub(/\s/, '')
        if answer == term[1]
            score += 1
            right_count[term[0]] += 1
            puts "Correct! (only #{opts[:repetitions] - right_count[term[0]]} more times to go)\n\n"
        else
            puts "Incorrect, the correct answer is \"#{term[1]}\"."
            new_answer = ''
            until new_answer == term[1] do
                print 'Type the correct answer: '
                new_answer = STDIN.gets.chomp.downcase.gsub(/\s/, '')
            end
            puts
        end
        total += 1

        # TODO: Fix bug where all that remains to study is what's already in the
        # "recently seen" queue
        mru.shift if mru.size > 10 # Keep queue size at 10

        # End the loop if the user has finished all vocab terms
        if right_count.all? { |key,val| val >= 5 }
            puts "All done!"
            break
        end
    }
rescue Interrupt => e
    unless total == 0
        puts "\nYour final score is #{score}/#{n}"
    else
        puts # Print an empty line if user did not play
    end
end
