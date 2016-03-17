module DoubleTranspositionCipher
  def self.generate_mapping(document, key)
    str = document.to_s
    doc_len = str.length
    sqr_len = Math.sqrt(doc_len).ceil


    mtx = str.ljust(sqr_len ** 2, "\t").chars.each_slice(sqr_len).to_a
    # generate map
    sqr1_map = (0...sqr_len).to_a.shuffle(random: Random.new(key))
    sqr2_map = (0...sqr_len).to_a.shuffle(random: Random.new(key + 1))

    [mtx, sqr1_map, sqr2_map]
  end

  def self.encrypt(document, key)
    # generate matrix and map
    mtx, sqr1_map, sqr2_map = generate_mapping(document, key)
    # row permutation
    mtx = mtx.map.with_index { |_, index| mtx[sqr1_map[index]] }
    mtx.map do |row|
      row.map.with_index { |_, i| row[sqr2_map[i]] }
    end.join
  end

  def self.decrypt(ciphertext, key)
    # generate matrix and map
    de_mtx, sqr1_map, sqr2_map = generate_mapping(ciphertext, key)
    # row permutation
    row = de_mtx.map.with_index { |_, index| de_mtx[sqr1_map.index(index)] }
    row.map do |col|
      col.map.with_index { |_, index| col[sqr2_map.index(index)] }
    end.join.delete("\t")
  end
end
