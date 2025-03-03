require_relative 'base'

require 'pry'

class ClientSearcher
  def initialize(file_obj)
    @clients = client_data(file_obj)
  end

  def search(query_type, word)
    @clients.find_all { |client| client_exists?(client[query_type.to_s], word.downcase) }
  end

  def duplicates
    grouped_clients = @clients.group_by { |client| client['email'] }
    dupes = grouped_clients.select { |_, dupes| dupes.size > 1 }.values.flatten
    puts dupes
    puts "Duplicate email count: #{dupes.count}"
  end

  private
    def client_data(file_obj)
      FileNotFound.new.error unless file_obj

      FileReader.load_file(file_obj)
    end

    def client_exists?(query_type, word)
      query_type&.downcase&.include?(word.downcase)
    end
end