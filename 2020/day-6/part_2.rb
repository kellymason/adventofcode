CORRECT_ANSWER = nil
TEST_INPUT = "lqhksfnerg
negsc
snage
engs
sneg

ctfzrdbsapql
srldfatzqcpb
qsntlprfdbza
ldptswouqbxzafr

ncjolhqfbp
gphonqbflxj
jepdmfhsqtonz
cqpihonjbgf

abytu
ayu
ayu
uhodlay
uay

kzx
xjwk
kxfhsdc
xjk
jkx"

# get input as array of arrays of group submission strings
# ex: [
  #     ["lqhksfnerg", "negsc", "snage", "engs", "sneg"],
  #     ["ctfzrdbsapql", "srldfatzqcpb", "qsntlprfdbza", "ldptswouqbxzafr"]
#     ]
def get_input
  IO.read('input.txt').split("\n\n").map { |raw_group_string| raw_group_string.split("\n")}
end

# count the number values that every member answered yes to
def count_unanimous_responses(group)
  unanimous_responses = group[0].chars.filter do |char|
    group.every?{ |submission| submission.includes?(char)}
  end
  unanimous_responses.count
end

# for each group array, count the number of chars that occur in every element
# return the sum of all group counts
def sum_unanimous_yesses
  groups = get_input
  unanimous_answer_counts = []
  groups.each do |group|
    unanimous_answer_count = 0
    nested_submission_array = group.each{|s| s.split('')}
    group[0].each_char do |char| 
      char_count = 1
      1.upto(group.length - 1) do |i|
        char_count += 1 if group[i].include?(char)
      end
      unanimous_answer_count +=1 if char_count == group.length
    end
    unanimous_answer_counts.push(unanimous_answer_count)
  end
  puts unanimous_answer_counts.sum
end

sum_unanimous_yesses
