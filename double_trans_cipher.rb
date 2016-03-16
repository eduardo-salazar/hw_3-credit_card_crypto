module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    str = document.to_s
    doc_len = str.length
    row_len = Math.sqrt(doc_len).ceil
    col_len = (doc_len / row_len.to_f).ceil
    mtx = str.ljust(row_len * col_len,"\t").chars.each_slice(row_len).to_a
    row_map = (0...row_len).to_a.shuffle(random: Random.new(key))
    col_map = (0...col_len).to_a.shuffle(random: Random.new(key))
    mtx = mtx.map.with_index { |element, index| mtx[col_map[index]]}
    mtx.map do |col|
      col.map.with_index {|ele, index| col[row_map[index]]} 
    end.join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    doc_len = ciphertext.size
    row_len = Math.sqrt(doc_len).ceil
    col_len = (doc_len / row_len.to_f).ceil
    row_map = (0...row_len).to_a.shuffle(random: Random.new(key))
    col_map = (0...col_len).to_a.shuffle(random: Random.new(key))
    de_mtx = ciphertext.chars.each_slice(row_len).to_a 
    row = de_mtx.map.with_index { |element, index| de_mtx[col_map.index(index)]} 
    row.map do |col| 
      col.map.with_index { |ele,index| col[row_map.index(index)].delete("\t")}  
    end.join
  end
end
