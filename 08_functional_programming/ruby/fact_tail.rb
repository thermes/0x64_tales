#! /usr/bin/env ruby

def fact_tail(n, acc = 1)
  if n == 0
    acc
  else
    fact_tail(n - 1, n * acc)
  end
end

fact_tail(10)
