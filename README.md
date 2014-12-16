#Chatterbox Challenge
==========

##The Brief
========

First place the chatbot below in a file such as 'chatbot.rb', run it from the command line and then experiment chatting with it:

```ruby
def get_response(input)
  key = RESPONSES.keys.select {|k| /#{k}/ =~ input }.sample
  /#{key}/ =~ input
  response = RESPONSES[key]
  response.nil? ? 'sorry?' : response % { c1: $1, c2: $2}
end

RESPONSES = { 'goodbye' => 'bye', 
              'sayonara' => 'sayonara', 
              'the weather is (.*)' => 'I hate it when it\'s %{c1}', 
              'I love (.*)' => 'I love %{c1} too', 
              'I groove to (.*) and (.*)' => 'I love %{c1} but I hate %{c2}'}

puts "Hello, what's your name?"
name = gets.chomp
puts "Hello #{name}"
while(input = gets.chomp) do
  puts get_response(input)
end
```

It should go something like this:

```
→ ruby chatbot.rb 
Hello, what's your name?
Dan
Hello Dan
the weather is clement
I hate it when it's clement
I love noodles
I love noodles too
I groove to funk and soul
I love funk but I hate soul
goodbye
bye
```


1. add at least five more responses so that the bot has a bigger range of conversation
2. add at least another two more responses that use regex capture groups - that's the `%{c1}` being replaced with whatever matched the brackets `(.*)` in the regular expression.  In Ruby regex capture groups are stored in `$1`, `$2` etc after a regex match takes place
3. extend the bot so that there is a key word, e.g. "quit" that will end the session
4. add a prompt in front of each sentence to indicate if either the person or the bot is talking
5. make the bot and the person's chat different colours
6. extend the bot so that it can handle more than two regular expression capture groups
7. extend the bot to that the user can add new kinds of responses through the chat interaction
8. extend the bot so that the set of responses is saved to a file and reloaded when the bot restarts


###My Approach
===========

I went off on tangents as per and wanted the bot to interact in what I considered the most interactive way possible. This meant that rather than inputting new responses in a formal manner I incorporated it into the chat. If the bot didnt know what to respond to one of your statements or questions it would ask you what it should respond in future. This response would be added to the hash and then saved when leaving the program. In this way the responses of the bot should gradually build over time and hopefully become more accurate and useful.

If I had longer to work on this project I'd certainly add more advanced functionality for the bot to understand part sentences and other statments that are close to what it had in it's repetoire. This interests me greatly so might return to it at some point!

