class DayEight
  def initialize(test: true)
    input_file = test ? "test_input.txt" : "input.txt"
    @input = File.readlines(input_file, chomp: true)
  end
end

DayEight.new()