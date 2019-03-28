#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

cn_0 = lambda { |f, x| x }
cn_1 = lambda { |f, x| f.call(x) }
cn_2 = lambda { |f, x| f.call(f.call(x)) }
cn_3 = lambda { |f, x| f.call(f.call(f.call(x))) }

puts "cn"
puts "cn_0: #{cn_0}"

def cn_to_i(cn)
  cn.call(lambda { |x| x + 1 }, 0)
end

puts
puts '# cn_to_i'
puts "cn_to_i(cn_0): #{cn_to_i(cn_0)}"
puts "cn_to_i(cn_1): #{cn_to_i(cn_1)}"
puts "cn_to_i(cn_2): #{cn_to_i(cn_2)}"
puts "cn_to_i(cn_3): #{cn_to_i(cn_3)}"

# SUCC := λn f x. f (n f x)

succ = lambda { |n|
         lambda { |f, x| f.call(n.call(f, x)) }
       }

puts
puts '# succ'
puts "cn_to_i(succ.call(cn_0)): #{cn_to_i(succ.call(cn_0))}"
puts "cn_to_i(succ.call(cn_1)): #{cn_to_i(succ.call(cn_1))}"
puts "cn_to_i(succ.call(cn_2)): #{cn_to_i(succ.call(cn_2))}"
puts "cn_to_i(succ.call(cn_3)): #{cn_to_i(succ.call(cn_3))}"

# PLUS := λm n f x. m f (n f x)

plus = lambda { |m, n|
    lambda { |f, x| m.call(f, (n.call(f, x))) }
}

puts
puts '# plus'
puts "cn_to_i(plus.call(cn_2, cn_3)): #{cn_to_i(plus.call(cn_2, cn_3))}"
puts "cn_to_i(plus.call(cn_2, cn_1)): #{cn_to_i(plus.call(cn_2, cn_1))}"
puts "cn_to_i(plus.call(cn_1, plus.call(cn_2, cn_3))): #{cn_to_i(plus.call(cn_1, plus.call(cn_2, cn_3)))}"

