#! /usr/bin/env ruby

def fact(n)
  if n == 0
    1
  else
    n * fact(n - 1)
  end
end

fact(10)
