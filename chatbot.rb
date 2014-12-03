require 'CSV'


def get_response(input)
  key = @RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = @RESPONSES[key]
  response.nil? ? 'sorry?' : response % { c1: $1, c2: $2, c3: $3}
end

@RESPONSES = { 'sayonara' => 'sayonara', 
              'the weather is (.*)' => 'I hate it when it\'s %{c1}', 
              'I love (.*)' => 'I love %{c1} too', 
              'I groove to (.*) and (.*)' => 'I love %{c1} but I hate %{c2}',
              'How are you?' => "I'm very well, how are you?",
              'I\'m well' => 'Well that\'s nice',
              'My favourite film is (.*)' => 'No way, %{c1} is a rubbish movie',
              'It was nice speaking to you' => 'And the same to you',
              'Can you tell me a joke?' => 'Horse walks into a bar, barman says why the long face!',
              'Haha' => 'Lol',
              "What's yours?" => 'Jimbob Letters, pleased to make your acquaintance',
              "My favourite animal is a (.*)" => "Nice, my favourite is also %{c1}",
              "You heard" => "I heard, but I didn't understand",
              "What day is it?" => "Your lucky day"
          }


def header
  system "clear"
  puts "WELCOME TO CHATBOT 5.0".center(50)
  puts "======================".center(50)
  puts "When you've finished talking just say 'goodbye' to leave!".center(50)
  puts ""
end


def intro
  puts "\e[34m++bot++ Hello, what's your name?\e[0m"
  print "...>"
  name = gets.chomp 
  puts "\e[34m++bot++ Hello #{name}\e[0m"
end


def convo
  print "...>"
  input = gets.chomp
  while input != ( "goodbye" || "bye" ) #bye does not work, not sure why
    if "#{get_response(input)}" == "sorry?"
      puts "\e[34m++bot++ That's not in my repotoire, would you like to add a response?\e[0m"
      puts ""
      puts "Please enter what the bot should reply to this phrase in future?".center(50)
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
  # open the file for writing
  CSV.open(filename, "w") do |file|
  # iterate over the array of responses
    @RESPONSES.each do |k, v|
      response_data = ["#{k}", "#{v}"]
      file << response_data
    end
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
