#! /usr/bin/env ruby

RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}

require './benchmark.rb'
