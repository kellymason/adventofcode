CORRECT_ANSWER = 6297
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

# get input as array of group submission strings
def get_input
  IO.read('input.txt').split("\n\n").each { |group_string| group_string.delete!("\n") }
  # TEST_INPUT.split("\n\n").each { |group_string| group_string.delete!("\n") }
end

# for each group, count the uniq values
# sum the counts
def sum_uniq_group_counts
  groups = get_input
  puts groups.sum{ |group| group.chars.to_a.uniq.count }
end

sum_uniq_group_counts
