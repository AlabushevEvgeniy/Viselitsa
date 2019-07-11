# require "unicode"

class  Game
  attr_reader :letters, :good_letters, :bad_letters, :errors, :status

  MAX_ERRORS = 7

  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(slovo)
    if slovo.nil? || slovo == ''
      abort 'Задано пустое слово, не о чем играть.'
    else
      slovo.split("")
    end
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  def max_errors
    MAX_ERRORS
  end

  def lost?
    @status == :lost || @errors >= MAX_ERRORS
  end

  def in_progress?
    @status == :in_progress
  end

  def won?
    @status == :won
  end

  def solved?
    @good_letters.uniq.size == @letters.uniq.size
  end

  def letter_is_repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def next_step(letter)
    return if @status == :lost || @status == :won

    return if letter_is_repeated?(letter)

    if @letters.include?(letter)
      @good_letters << letter

      @status = :won if solved?
    elsif (letter == "e" && @letters.include?("ё"))
      @good_letters << "ё"
    elsif (letter == "ё" && @letters.include?("е"))
      @good_letters << "е"
    elsif (letter == "и" && @letters.include?("й"))
      @good_letters << "й"
    elsif (letter == "й" && @letters.include?("и"))
      @good_letters << "и"
    else
      if (@bad_letters.include?("ё") && letter == "е") ||
        (@bad_letters.include?("е") && letter == "ё") ||
        (@bad_letters.include?("й") && letter == "и") ||
        (@bad_letters.include?("и") && letter == "й")
        return
      else @bad_letters << letter
      end

      @errors += 1

      @status = :lost if lost?
    end
  end
  # 1. берет букву с консоли
  # 2. проверяет результат
  def ask_next_letter
    puts "\nВведите следующую букву:"
    letter = ""
    letter = STDIN.gets.encode("UTF-8").downcase.chomp while letter == ""
    # letter = Unicode::downcase(letter)

    next_step(letter)
  end
end
