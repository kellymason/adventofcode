# Each line is a report
# Each number is a level
# A safe report:
#  Contains levels that gradually increase or decrease
#  Contains levels that increment/decrement by 1, 2, or 3


TEST_INPUT = [
   "7 6 4 2 1",
   "1 2 7 8 9",
   "9 7 6 2 1",
   "1 3 2 4 5",
   "8 6 4 4 1",
   "1 3 6 7 9"
]

def get_input
  puts "getting input"
  reports = []
  File.readlines("input.txt", chomp: true).each do |line|
    # puts "line: #{line}"
    # parse each line from a string into an array of ints
    levels = line.split(" ").map(&:to_i)
    reports << levels
  end
  reports
end

def get_test_input
  puts "getting test input"
  reports = []
  TEST_INPUT.each do |line|
    # parse each line from a string into an array of ints
    levels = line.split(" ").map(&:to_i)
    reports << levels  
  end
  reports
end

# Part 1 safety checker
# Return true in the following cases:
#   report is increasing consistently and increment is between 0 and 4
#   report is decreasing consistently and decrement is between 0 and -4
# else return false
def is_safe(report)
  report_direction = report[1] - report[0] > 0 ? "increasing" : "decreasing"
  # mark false if any criteria not met
  report.each_with_index do |level, level_index|
    next if level_index == 0
    increment_value = level - report[level_index-1]
    if report_direction == "increasing" && (increment_value >= 1 && increment_value <= 3)
      next
    elsif report_direction == "decreasing" && (increment_value <= -1 && increment_value >= -3)
       next
    else
      return false
    end
  end
  return true
end

# Part 2 safety checker
# Determines whether report is increasing or decreasing baserd on first two numbers
# TODO: set the appropriate is_safe and return/next values
def is_somewhat_safe(report)
  is_safe = false
  for i in 0...report.length 
    current_report = report[0...i] + report[i+1...report.length]
    report_direction = if current_report == current_report.sort
      "increasing"
    elsif current_report == current_report.sort.reverse
      "decreasing"
    else
      puts "report #{current_report} isnt safe, moving to next one"
      next
    end
    # iterate through each item in the current permutation of the report
      # skip the first item because we have nothing to compare it back to
      # if the level checks out, move to the next
      # if it doesn't, keep is_safe at false and move to the next report
      # if we're at the end, return true
    for j in 1...current_report.length
      increment_value = current_report[j] - current_report[j-1]
      if report_direction == "increasing" && (increment_value >= 1 && increment_value <= 3)
        puts "report #{current_report} is safe so far"
      elsif report_direction == "decreasing" && (increment_value <= -1 && increment_value >= -3)
        puts "report #{current_report} is safe so far"
      else
        puts "report #{current_report} is unsafe"
      end
    end
  end
  puts "done with is_somewhat_safe"
end

# Set a safe report counter
# Increment safe report counter if safe == true
def count_safe_reports
  # reports = get_input
  reports = get_test_input
  safe_report_count = 0
  reports = reports.drop_while do |report|
    puts "checking if report #{report} is safe"
    if is_safe(report)
      safe_report_count += 1
      puts "report #{report} is safe, moving to next one"
      true
    else
      false
    end
  end
  # Iterate through the remaining reports (not safe on the first pass)
  # Try removing each item until either it's safe or the end is reached.
  reports.each do |report|
    puts "checking if report #{report} is SOMEWHAT safe"
    if is_somewhat_safe(report)
      puts "report #{report} is safe"
      safe_report_count += 1
    end
  end
  safe_report_count
end

puts count_safe_reports