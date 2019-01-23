require 'set'
  
  INCREMENTS = []
  File.open('input.txt').each do |line|
    INCREMENTS << line.to_i
  end

def check_repeat_frequencies
  frequencies = Set.new([0])
  currentFrequency = 0
  y = 0
  until y == 1
    INCREMENTS.each do |change|
      currentFrequency += change

      if frequencies.include?(currentFrequency)
        puts "found it! #{currentFrequency}"
        y = 1
        exit
      else
        frequencies << currentFrequency
      end
    end
  end
end

check_repeat_frequencies