def get_masses_array
  return File.readlines('input.txt', chomp: true).map{|l| l.to_i}
end

def fuel_needed_for_mass(module_mass)
  # TODO: FIX ME
  # (module_mass / 3).floor - 2
end

def sum_fuel_needed(masses)
  # pass each mass through fuel_needed_for_mass
  total_fuel_needed = 0
  masses.each do |mass|
    total_fuel_needed += fuel_needed_for_mass(mass)
  end
  puts total_fuel_needed
end

def solve_part_2
  module_masses = get_masses_array
  return sum_fuel_needed(module_masses)
end

solve_part_2