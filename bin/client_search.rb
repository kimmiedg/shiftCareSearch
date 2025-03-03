require 'optparse'
require_relative '../lib/base'

class ClientSearch 
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: ruby client_search.rb [options]"
    opts.on("-f FILE", "include the file path") { |file| options[:file] = file }
    opts.on("-s SEARCH", "search name") { |query| options[:search] = query }
    opts.on("-t FIELD TYPE", "field name") { |field_type| options[:field_type] = field_type }
    opts.on("-d", "search duplicate emails") { options[:duplicates] = true }
  end.parse!

  if options[:file]
    app = ClientSearcher.new(options[:file])
    app.search(options[:field_type], options[:search]) if options[:search]
    app.duplicates if options[:duplicates]
  else
    puts "Error: Provide a JSON file using -f option."
    exit 1
  end
end
