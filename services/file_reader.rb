require 'JSON'
require_relative '../errors/file_not_found'

class FileReader
  def initialize(file_obj)
    @file_obj = file_object(file_obj)
  end

  def self.load_file(file_obj)
    new(file_obj).load_file
  end

  def load_file
    begin 
      JSON.parse(File.read(@file_obj))
    rescue Errno::ENOENT
      FileNotFound.new.error
    end
  end

  private

    def file_object(file_obj)
      return file_obj if file_obj

      raise NoFileUploaded.new.api_error
    end

end