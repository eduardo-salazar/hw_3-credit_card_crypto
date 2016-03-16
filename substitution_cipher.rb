module SubstitutionCipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      document.to_s.chars.map { |c| (c.ord + key).chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      document.chars.map { |c| (c.ord - key).chr }.join
    end
  end

  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      permutation_map = (32..126).to_a.shuffle(random: Random.new(key))
      document.to_s.chars.map { |e| permutation_map[e.ord - 32].chr }.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      permutation_map = (32..126).to_a.shuffle(random: Random.new(key))
      document.chars.map { |e| (permutation_map.index(e.ord) + 32).chr }.join
    end
  end
end
