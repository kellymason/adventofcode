class DaySix
  def initialize(test: true)
    input_file = test ? "test_input.txt" : "input.txt"
    @lanternfish = File.readlines(input_file, chomp: true).first.split(",").map(&:to_i)
  end

  def update_fish_timers
    new_fish_count = @timer_counts[0]
    0.upto(5) do |i|
      @timer_counts[i] = @timer_counts[i+1]
    end
    @timer_counts[6] = new_fish_count + @timer_counts[7]
    @timer_counts[7] = @timer_counts[8]
    @timer_counts[8] = new_fish_count
  end

  def convert_to_hash_of_counts
    @timer_counts = Hash[(0..8).map { |num| [num, 0] }]
    puts @timer_counts
    @lanternfish.each do |fish_timer|
      @timer_counts[fish_timer] += 1
    end
    @timer_counts
  end

  def lanternfish_count_at_day_x(day_number)
    convert_to_hash_of_counts
    day_number.times do
      update_fish_timers
    end
    puts @timer_counts.values.sum
  end
end

# DaySix.new().lanternfish_count_at_day_x(80)
# DaySix.new(test: false).lanternfish_count_at_day_x(256)