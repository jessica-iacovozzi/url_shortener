class ShortCode
  ALPLHABET = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".freeze
  BASE = ALPLHABET.length

  def self.encode(number)
    return ALPLHABET.first if number.zero? || number.nil?

    result = ""

    while number.positive?
      index = number % BASE
      char = ALPLHABET[index]
      result.prepend char
      number /= BASE
    end

    result
  end

  def self.decode(string)
    result = 0

    string.reverse.each_char.with_index do |char, index|
      power = BASE**index
      alphabet_index = ALPLHABET.index(char)
      result += alphabet_index * power
    end

    result
  end
end
