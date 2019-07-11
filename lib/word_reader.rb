class WordReader # читает слова из файла и выводит одно из них

  def read_from_file(file_name)
    if File.exist?(file_name)
      f = File.new(file_name, 'r:UTF-8')
      lines = f.readlines.map(&:chomp)
      f.close
      return lines.sample
    else
      nil
    end
  end
end
