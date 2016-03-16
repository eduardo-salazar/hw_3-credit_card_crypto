module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    sum = 0
    number.reverse.to_s.chars.map.with_index do |str, i|
      d = str.to_i
      if i.odd?
        value = d * 2
        sum += value >= 10 ? value - 9 : value
      else
        sum += d
      end
    end
    (sum % 10) == 0
  end
end
