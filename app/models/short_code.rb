class ShortCode
  ALPLHABET="0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".freeze
  BASE=ALPLHABET.length

  def self.encode(number)
    return ALPLHABET.first if number.zero? || number.nil?
    result = ""

    while number > 0 do
      index = number % BASE
      char = ALPLHABET[index]
      result.prepend char
      number = number / BASE
    end

    result
  end
end
