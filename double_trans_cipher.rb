module DoubleTranspositionCipher
  def self.generate_mapping(document, key)
    str = document.to_s
    doc_len = str.length
    row_len = Math.sqrt(doc_len).ceil
    col_len = (doc_len / row_len.to_f).ceil

    mtx = str.ljust(row_len * col_len, "\t").chars.each_slice(row_len).to_a
    # generate map
    row_map = (0...row_len).to_a.shuffle(random: Random.new(key))
    col_map = (0...col_len).to_a.shuffle(random: Random.new(key + 1))
    [mtx, row_map, col_map]
  end

  def self.encrypt(document, key)
    # generate matrix and map
    mtx, row_map, col_map = generate_mapping(document, key)
    # row permutation
    mtx = mtx.map.with_index { |_, index| mtx[col_map[index]] }
    mtx.map do |row|
      row.map.with_index { |_, i| row[row_map[i]] }
    end.join
  end

  def self.decrypt(ciphertext, key)
    # generate matrix and map
    de_mtx, row_map, col_map = generate_mapping(ciphertext, key)
    # row permutation
    row = de_mtx.map.with_index { |_, index| de_mtx[col_map.index(index)] }
    row.map do |col|
      col.map.with_index { |_, index| col[row_map.index(index)] }
    end.join.delete("\t")
  end
end
