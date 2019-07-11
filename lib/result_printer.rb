class ResultPrinter

  def initialize(slovo)
    @slovo = slovo
    @status_image = []

    current_path = File.dirname(__FILE__)
    files_quantity = Dir[current_path + "/../image/*"].length
    counter = 0

    while counter <= files_quantity
      file_name = current_path + "/../image/#{counter}.txt"

      if File.exist?(file_name)
        f = File.new(file_name, 'r:UTF-8')
        @status_image << f.read
        f.close
      else
        @status_image << "\n[ Изображение не найдено ]\n"
      end

      counter += 1
  end

  def print_status(game)
    cls
    puts
    puts "Это игра \'Виселица\'. Угадай слово, или умри."
    puts "\nСлово: " + get_word_for_print(game.letters, game.good_letters)
    puts "Ошибки (#{game.errors}): #{game.bad_letters.join(", ")}"

    print_viselitsa(game.errors)

    #errors >= 7
    if game.status == :lost
      puts "Вы проиграли!!!"
      puts "Было загадано слово \"#{slovo}\""

    #(game.letters.uniq == game.good_letters)
    elsif game.status == :won
      puts "Вы выиграли!!!\n\n"
    else
      puts "У Вас осталось ошибок: #{(game.errors_left)}"
      end
    end
  end

  def slovo
    @slovo
  end

  def get_word_for_print(letters, good_letters)
    result = ""

    for item in letters do
      if good_letters.include?(item)
        result += item + " "
      else
        result += "__ "
      end
    end

    return result
  end

  def cls
   system "clear" or system "cls"
  end

  def print_viselitsa(errors)
    puts @status_image[errors]
  end
end
