require './data_loader.rb'
require './search_engine.rb'

user_input = nil
until user_input == '\q'
  puts "Please input search params (start param with '--' for search exclusion) type('\q') for exit: "
  user_input = gets.chomp

  exit if user_input == '\q'

  data = DataLoader.load
  searcher = SearchEngine.new(data)

  p searcher.perform_search(user_input)
end

