def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = RESPONSES[key]
  response.nil? ? 'sorry?' : response % { c1: $1, c2: $2, c3: $3}
end

RESPONSES = { 'sayonara' => 'sayonara', 
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
              "My favourite animal is (.*)" => "Nice, my favourite is also %{c1}"
              "You heard" => "I heard, but I didn't understand"
          }

system "clear"
puts "WELCOME TO CHATBOT 5.0".center(50)
puts "======================".center(50)
puts "When you've finished talking just say 'goodbye' to leave!".center(50)

puts "\e[34m++bot++ Hello, what's your name?\e[0m"
print "...>"
name = gets.chomp 
puts "\e[34m++bot++ Hello #{name}\e[0m"

print "...>"
input = gets.chomp
while input != ( "goodbye" || "bye" )
puts "\e[34m++bot++ #{get_response(input)}\e[0m"
print "...>"
input = gets.chomp
end