class NoFileUploaded < StandardError

  def error
    puts 'Error: No file uploaded'
    exit 1
  end
end
