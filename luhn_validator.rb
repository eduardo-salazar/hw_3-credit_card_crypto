module LuhnValidator
  # Validates credit card number using Luhn Algorithm
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum

    nums_a = number.to_s.chars.map(&:to_i)
    sum = 0
    nums_a.reverse.map.with_index do |d, i|
    	if i.odd?
    		sum += (d * 2).to_s.chars.map!(&:to_i).reduce(:+)
    	else
    		sum += d
    	end
    end
    (sum % 10) == 0
  end
end
