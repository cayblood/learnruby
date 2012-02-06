#!/usr/bin/env ruby

require 'presentation'

def read_presentations(ins)
  result = {}
  ins.each do |line|
    id, title, presenter, category = line.strip.split(/:/)
    p = Presentation.new(title, presenter, category)
    result[id.to_i] = p
  end
  result
end

presentations = open("../presentations.txt") { |f| read_presentations(f) }

open("../votes.txt") do |votes|
  votes.each do |line|
    id, score = line.split
    p = presentations[id.to_i]
    if p
      p.add_score(score.to_i)
    end
  end
end

presentations.values.sort_by { |p| p.average_score }.each do |p|
  printf "%5.2f: %s\n", p.average_score, p.title
end
