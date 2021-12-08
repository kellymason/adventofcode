  # determine how to save:
    # a representation of marks on the bingo board (keep bingo numbers as strings, convert that spot to an x?)
    # cards = [
    #   [ [ 1, 2, 3, 4, 5]  <---- card 0
    #     [ 6, 7, 8, 9,10]
    #     [11,12,13,14,15]
    #     [16,17,18,19,20]
    #     [21,22,23,24,25] ],
    #   [ [ 1, 2, 3, 4, 5]  <---- card 1
    #     [ 6, 7, 8, 9,10]
    #     [11,12,13,14,15]
    #     [16,17,18,19,20]
    #     [21,22,23,24,25] ],
    # ]
    # the current bingo_number
  # check if any board has 5 in a row
    # if yes, sum all unmarked numbers (.to_i) and multiply by current bingo_number

class DayFour
  def initialize(test: false)
    input_file = test ? "test_input.txt" : "input.txt"
    input = File.readlines(input_file, chomp: true)
    @bingo_numbers = input.shift.split(",").map(&:to_i)
    @bingo_cards = input.reject{|item| item.empty?}.each_slice(5).map{|card_array| card_array.map{ |line| line.split(" ").map{ |item| {value: item.to_i, marked: false} } }}.to_a
  end

  def mark_card(card, number)
    card.each do |row|
      row.each do |space|
        if space[:value] == number
          space[:marked] = true
        end
      end
    end
  end

  # iterate through cards, check for full row (array) or column (each row[i]) of x's
  # if bingo, return card number
  def check_for_bingo
    winning_card = nil
    @bingo_cards.each do |card|
      # puts "card # #{card_id}:", card.inspect
      card.each do |row|
        winning_card = card if row.all?{ |space| space[:marked] }
      end
      card.transpose.each do |column|
        winning_card = card if column.all?{ |space| space[:marked] }
      end
    end
    winning_card
  end

  def card_has_bingo(card)
    bingo = false
    card.each do |row|
      if row.all?{ |space| space[:marked] == true }
        bingo = true
      end
    end
    card.transpose.each do |column|
      if column.all?{ |space| space[:marked] == true }
        bingo = true 
      end
    end
    bingo
  end

  # sum all non-marked spaces on the winning card
  # multiply this sum by the current bing_number
  def perform_final_calculation(bingo_number, card)
    unmarked_spaces = card.flatten.filter{ |space| space[:marked] == false }
    sum = unmarked_spaces.sum{ |space| space[:value] }
    puts "sum: #{sum}, losing_number: #{bingo_number}"
    puts sum * bingo_number
  end

  # iterate through @bingo_numbers
    # mark all cards with that number
    # check for 5 in a row or column 
  def solve_part_1
    @bingo_numbers.each do |current_number|
      @bingo_cards.each do |card|
        mark_card(card, current_number)
      end
      return perform_final_calculation(current_number, check_for_bingo) if !check_for_bingo.nil?
    end
  end

  # iterate through @bingo_numbers, keeping track of the last bingo_number called and a losing bingo card
    # set a losing bingo card (there may be multiple, but we just want 1)
    # set the last bingo_number called
    # once all cards have bingo (you need to score the losing card when it has bingo),
      # perform the final calculation with the losing card and last bingo_number called 
  def solve_part_2
    loser, last_number = nil
    @bingo_numbers.each do |current_number|
      break if @bingo_cards.all?{ |card| card_has_bingo(card) }
      loser = @bingo_cards.detect{ |card| !card_has_bingo(card) }
      last_number = current_number
      @bingo_cards.each do |card|
        mark_card(card, current_number)
      end
    end
    puts "last number: #{last_number}, loser: #{loser}"
    perform_final_calculation(last_number, loser)
  end
end

DayFour.new().solve_part_1