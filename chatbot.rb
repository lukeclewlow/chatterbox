require "CSV"
@RESPONSES = {}

class String
  def blue
    "\e[34m#{self}\e[0m"
  end
end


def get_response(input)
  key = @RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = @RESPONSES[key]
  response.nil? ? 'sorry?' : response % { c1: $1, c2: $2, c3: $3}
end


def header
  system "clear"
  puts "WELCOME TO CHATBOT 5.0".center(50)
  puts "======================".center(50)
  puts "When you've finished talking just say 'goodbye' to leave!".center(50)
  puts ""
end


def intro
  puts "++bot++ Hello, what's your name?".blue
  print "...>"
  name = gets.chomp 
  puts "++bot++ Hello #{name}".blue
end


def convo
  print "...>"
  input = gets.chomp
  while input !=  ( "goodbye" )
    if "#{get_response(input)}" == "sorry?"
      puts "\e[34m++bot++ That's not in my repotoire, would you like to add a response?\e[0m\n"
      puts "----Please enter what \e[34m++bot++\e[0m should reply to this phrase in future?----".center(50)
      puts ""
      print "...>"
      new_response = gets.chomp   
      add_response(input, new_response) 
      puts "\e[34m++bot++ Added...\e[0m"
      print "...>"
      input = gets.chomp
    else
      puts "\e[34m++bot++ #{get_response(input)}\e[0m"
      print "...>"
      input = gets.chomp
    end
  end
end

def add_response(input, new_response)
  @RESPONSES["#{input}"] = "#{new_response}"
end


def save_responses(filename = 'responses.csv')
  CSV.open(filename, "w") do |file|
    @RESPONSES.each {|k, v| file << ["#{k}", "#{v}"]}
  end
  puts "Responses saved........." 
end


def load_responses(filename = 'responses.csv')
  CSV.foreach(filename, "r") do |row|
      add_response(row[0], row[1])
  end
end


load_responses
header
intro
convo
puts "\e[34m++bot++Bye for now!\e[0m"
puts ""
save_responses
