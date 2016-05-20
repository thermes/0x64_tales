#! /usr/bin/env ruby

# def fact_cps(n)
#   if n == 0
#     yield 1
#   else
#     fact_cps(n - 1) do |result|
#       yield(n * result)
#     end
#   end
# end

def fact_cps(n, cont)
  if n == 0
    cont.call 1
  else
    fact_cps(n - 1, -> (x) { cont.call(n * x) })
  end
end

fact_cps(10, -> (x) { x })
