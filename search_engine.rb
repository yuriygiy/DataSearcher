class SearchEngine

  NEG_SEARCH_ARG = '--'.freeze

  def initialize(data)
    @data = data
  end

  def perform_search(search_args)
    searched_elements = process_params(search_args)
    result = []

    searched_elements.each do |entry|
      # Define bitwise operator for perform include/exclude param for search
      operator = entry.start_with?(NEG_SEARCH_ARG) ? :- : :&
      entry.slice!(NEG_SEARCH_ARG)
      result << { operator => get_match_data(entry) }
    end
    # Combines all data blocs with specific option
    # used send for use operator dynamically
    result.reduce(@data) do |product, n|
      search_type = n.keys[0]
      product.send(search_type, n[search_type])
    end
  end

  private

  def process_params(search_args)
    search_args.split(' ').map { |e| e.strip.upcase }
  end

  def get_match_data(entry)
    # Getting all elements for searching argument for matching pattern
    match_regexp = /\b#{Regexp.escape("#{entry}")}/
    @data.select do |elem|
      elem.values.flatten.select { |el| el.strip.upcase.match(match_regexp) }.any?
    end
  end
end
