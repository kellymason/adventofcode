def checksums
  box_ids = []

  File.open('input.txt').each do |line|
    box_ids << line
  end

  two_matches = 0
  three_matches = 0

  box_ids.each do |box_id|
    char_counts = Hash.new{}
    box_id.chars.each do |char|
      char_counts.has_key?(char) ? char_counts[char] += 1 : char_counts[char] = 1
    end
    if char_counts.select {|k,v| v == 3}.length > 0
        three_matches += 1
      end
      if char_counts.select {|k,v| v == 2}.to_a.length > 0
        two_matches += 1
      end
  end
  puts "checksum: #{two_matches} times #{three_matches} equals #{two_matches*three_matches}"
end

checksums