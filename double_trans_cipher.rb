module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # generate matrix and map
    mtx, row_map, col_map = generate_mapping(document, key)
    # row permutation
    mtx = mtx.map.with_index { |_, index| mtx[row_map[index]] }
    mtx.map do |row|
      row.map.with_index { |_, i| row[col_map[i]] }
    end.join
  end

  def self.decrypt(ciphertext, key)
    # generate matrix and map
    de_mtx, row_map, col_map = generate_mapping(ciphertext, key)
    # row permutation
    row = de_mtx.map.with_index { |_, index| de_mtx[row_map.index(index)] }
    row.map do |col|
      col.map.with_index { |_, index| col[col_map.index(index)] }
    end.join.delete("\t")
  end

  def self.generate_mapping(document, key)
    str = document.to_s
    doc_len = str.length
    sqr_len = Math.sqrt(doc_len).ceil
    mtx = matrix_resizing(str, sqr_len)

    # generate map
    row_map = (0...sqr_len).to_a.shuffle(random: Random.new(key))
    col_map = (0...sqr_len).to_a.shuffle(random: Random.new(key + 1))

    [mtx, row_map, col_map]
  end

  def self.matrix_resizing(matrix, row_len)
    matrix.ljust(row_len**2, "\t").chars.each_slice(row_len).to_a
  end
end
