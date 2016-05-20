#! /usr/bin/env ruby

require 'benchmark'

# factorial (Ruby / direct style / recursion)

def fact(n)
  if n == 0
    1
  else
    n * fact(n - 1)
  end
end

# factorial (Ruby / CPS)

def fact_cps(n, cont)
  if n == 0
    cont.call 1
  else
    fact_cps(n - 1, -> (x) { cont.call(n * x) })
  end
end

# factorial (Ruby / direct style / tail recursion)

def fact_tail(n, acc = 1)
  if n == 0
    acc
  else
    fact_tail(n - 1, n * acc)
  end
end

TIMES = 1
FACT  = 100000

Benchmark.bm 16 do |r|
  r.report 'non tail call' do
    TIMES.times do
#      fact(FACT)
    end
  end

  r.report 'cps' do
    TIMES.times do
#      fact_cps(FACT, -> (x) { x })
    end
  end

  r.report 'tail call' do
    TIMES.times do
#      fact_tail(FACT)
    end
  end


  r.report 'tail call' do
    TIMES.times do
      1.upto(FACT).inject(:*)
    end
  end
end
