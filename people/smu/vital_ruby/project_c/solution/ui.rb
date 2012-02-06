#!/usr/bin/env ruby

class ConsoleUi
  def ask(prompt)
    print prompt + " "
    answer = gets
    answer ? answer.chomp : nil
  end
  
  def ask_if(prompt)
    answer = ask(prompt)
    answer =~ /^\s*[Yy]/
  end
  
  def say(*msg)
    puts msg
  end
end
