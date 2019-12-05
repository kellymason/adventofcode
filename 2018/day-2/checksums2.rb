

def checksums
  box_ids = []

  File.open('input.txt').each do |line|
    box_ids << line
  end

  box_ids.sort!
  box_id_length = box_ids.length
  0.upto(box_id_length - 1) do |first_box_index|
    diff_count = 0
    (first_box_index +1).upto(box_id_length - 1) do |second_box_index|
      0.upto(box_ids[first_box_index].length - 1) do |char_index|
        if box_ids[first_box_index][char_index] != box_ids[second_box_index][char_index]
          diff_count += 1
          break if diff_count >= 2
        end
      end
      if diff_count < 2
        puts "index1: #{first_box_index} box_id1: #{box_ids[first_box_index]}\nindex2: #{second_box_index} box_id2: #{box_ids[second_box_index]}"
      end
    end
  end
end

checksums