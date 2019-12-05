def get_raw_claims
  raw_claims = []
  File.open('input.txt').each do |line|
    raw_claims << line
  end
  return raw_claims
end

# takes in raw claims in this format:
  # "1 @ 755,138: 26x19"
# returns an array of claims in this format:
  # { "id": id, 
  #   "dist_from_left": dist_from_left, 
  #   "dist_from_top": dist_from_top, 
  #   "width": width, 
  #   "height": height}
def get_formatted_claims(raw_claims)
  formatted_claims = raw_claims.map do |raw_claim|
    formatted_claim = {}
    formatted_claim["id"] = raw_claim[/^\d+/].to_i
    formatted_claim["dist_from_left"] = raw_claim[/\s\d+/].to_i
    formatted_claim["dist_from_top"] = raw_claim[/\,\d+/][/\d+/].to_i
    formatted_claim["width"] = raw_claim[/#{': '}(\d+?)#{'x'}/m, 1].to_i
    formatted_claim["height"] = raw_claim[/\d+$/].to_i
    formatted_claim
  end
  return formatted_claims
end

# takes in claims
# increments through claims
# returns the nested array representing fabric marked with the number of claims on each square inch
def mark_claims_on_fabric(claims)
  fabric = []
  claims.each do |claim|
    # iterate through each row from dist_from_top to dist_from_top + length
    claim["dist_from_top"].upto(claim["dist_from_top"] + claim["height"] - 1) do |y|
      fabric[y] ||= []
      # iterate through each index in that row from dist_from_left to dist_from_left to width
      claim["dist_from_left"].upto(claim["dist_from_left"] + claim["width"] - 1) do |x|
        fabric[y][x] ||= 0
        fabric[y][x] += 1
      end
    end
  end
  return fabric
end

def print_single_claimed_squares(fabric)
  uniquely_claimed_squares = []
  # instead of flattening, go through each y array, and inside, each x array
  # multi_claimed_squares = fabric.flatten.select{ |square| square && square > 1 }
  # instead of returning the number of squares that meet the requirements, print the fabric indeces
  # return multi_claimed_squares.length
  # for now, just return all coordinates until I make this better
  fabric.compact.each do |y|
    y.compact.each_with_index do |x,y|
      if fabric[y][x].is_a?(Integer) && fabric[y][x] == 1
        uniquely_claimed_squares << "x: #{x}, y: #{y}"
      end
    end
  end
  puts uniquely_claimed_squares
end

def get_part_2_solution
  puts "starting!"
  raw_claims = get_raw_claims
  formatted_claims = get_formatted_claims(raw_claims)
  marked_fabric = mark_claims_on_fabric(formatted_claims)
  print_single_claimed_squares(marked_fabric)
end

get_part_2_solution

# think about how to represent the data better to avoid loops
# perhaps there's a counter in mark_fabric?