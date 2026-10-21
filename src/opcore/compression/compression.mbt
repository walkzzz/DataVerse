///|
/// # opcore/compression 压缩算子 / Compression Operators
///
/// 压缩算法算子契约 + 简化实现。
/// RLE / Huffman / LZ77 / LZSS / LZW / BWT / Delta / Deflate。
///
/// # Compression operators

// ============================================================
// 类型定义 / Type definitions
// ============================================================

/// 频率表条目 / Frequency table entry.
pub struct FreqEntry {
  symbol : Int
  count : Int
} derive(Debug, Eq)

pub extend FreqEntry with Eq::{equal, not_equal}
pub extend FreqEntry with Debug::{to_repr}

/// Huffman 节点 / Huffman node.
pub struct HuffmanNode {
  symbol : Int
  freq : Int
  left : Int
  right : Int
} derive(Debug, Eq)

pub extend HuffmanNode with Eq::{equal, not_equal}
pub extend HuffmanNode with Debug::{to_repr}

/// 字典条目 / Dictionary entry.
pub struct DictEntry {
  index : Int
  data : Array[Int]
} derive(Debug, Eq)

pub extend DictEntry with Eq::{equal, not_equal}
pub extend DictEntry with Debug::{to_repr}

/// 位写入器 / Bit writer.
pub struct BitWriter {
  bits : Array[Int]
  buffer : Int
  count : Int
} derive(Debug, Eq)

pub extend BitWriter with Eq::{equal, not_equal}
pub extend BitWriter with Debug::{to_repr}

/// 压缩统计 / Compression statistics.
pub struct CompressionStats {
  original_size : Int
  compressed_size : Int
  ratio : Double
  algorithm : String
} derive(Debug, Eq)

pub extend CompressionStats with Eq::{equal, not_equal}
pub extend CompressionStats with Debug::{to_repr}

/// 压缩级别 / Compression level.
pub(all) enum CompressionLevel {
  NoCompression
  Fast
  DefaultLevel
  Best
} derive(Debug, Eq)

pub extend CompressionLevel with Eq::{equal, not_equal}
pub extend CompressionLevel with Debug::{to_repr}

/// RLE 条目 / RLE entry (value, count).
pub struct RleEntry {
  value : Int
  count : Int
} derive(Debug, Eq)

pub extend RleEntry with Eq::{equal, not_equal}
pub extend RleEntry with Debug::{to_repr}

/// LZ77 三元组 / LZ77 triple (offset, length, next).
pub struct Lz77Triple {
  offset : Int
  length : Int
  next : Int
} derive(Debug, Eq)

pub extend Lz77Triple with Eq::{equal, not_equal}
pub extend Lz77Triple with Debug::{to_repr}

/// LZSS 标记 / LZSS token (flag, offset, length).
pub struct LzssToken {
  flag : Int
  offset : Int
  length : Int
} derive(Debug, Eq)

pub extend LzssToken with Eq::{equal, not_equal}
pub extend LzssToken with Debug::{to_repr}

// ============================================================
// RLE 编码 / Run-Length Encoding
// ============================================================

/// RLE 编码 / RLE encode.
pub fn rle_encode(data : Array[Int]) -> Array[RleEntry] {
  let result : Array[RleEntry] = []
  let n = data.length()
  if n == 0 {
    return result
  }
  let mut current = data[0]
  let mut count = 1
  for i in 1..<n {
    if data[i] == current {
      count = count + 1
    } else {
      result.push(RleEntry::{value: current, count})
      current = data[i]
      count = 1
    }
  }
  result.push(RleEntry::{value: current, count})
  result
}

/// RLE 解码 / RLE decode.
pub fn rle_decode(entries : Array[RleEntry]) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<entries.length() {
    for _j in 0..<entries[i].count {
      result.push(entries[i].value)
    }
  }
  result
}

/// 游程长度检查 / Run-length check (true if data has long runs).
pub fn run_length_check(data : Array[Int]) -> Bool {
  let n = data.length()
  if n < 4 {
    return false
  }
  let mut run = 1
  for i in 1..<n {
    if data[i] == data[i - 1] {
      run = run + 1
      if run >= 4 {
        return true
      }
    } else {
      run = 1
    }
  }
  false
}

// ============================================================
// 频率表与 Huffman / Frequency table & Huffman
// ============================================================

/// 构建频率表 / Make frequency table.
pub fn make_frequency_table(data : Array[Int]) -> Array[FreqEntry] {
  let symbols : Array[Int] = []
  let counts : Array[Int] = []
  for i in 0..<data.length() {
    let s = data[i]
    let mut found = false
    for j in 0..<symbols.length() {
      if symbols[j] == s {
        counts[j] = counts[j] + 1
        found = true
      }
    }
    if !(found) {
      symbols.push(s)
      counts.push(1)
    }
  }
  let result : Array[FreqEntry] = []
  for k in 0..<symbols.length() {
    result.push(FreqEntry::{symbol: symbols[k], count: counts[k]})
  }
  result
}

/// 构建 Huffman 树 / Build Huffman tree (returns array of nodes, root is last).
pub fn build_huffman_tree(freq_table : Array[FreqEntry]) -> Array[HuffmanNode] {
  let nodes : Array[HuffmanNode] = []
  let active : Array[Int] = []
  for i in 0..<freq_table.length() {
    nodes.push(HuffmanNode::{symbol: freq_table[i].symbol, freq: freq_table[i].count, left: -1, right: -1})
    active.push(i)
  }
  while active.length() > 1 {
    let mut min1 = 0
    let mut min2 = 1
    for i in 0..<active.length() {
      if nodes[active[i]].freq < nodes[active[min1]].freq {
        min2 = min1
        min1 = i
      } else if i != min1 && nodes[active[i]].freq < nodes[active[min2]].freq {
        min2 = i
      }
    }
    let idx1 = active[min1]
    let idx2 = active[min2]
    let combined_freq = nodes[idx1].freq + nodes[idx2].freq
    let new_node = HuffmanNode::{symbol: -1, freq: combined_freq, left: idx1, right: idx2}
    nodes.push(new_node)
    let new_idx = nodes.length() - 1
    let new_active : Array[Int] = []
    for i in 0..<active.length() {
      if i != min1 && i != min2 {
        new_active.push(active[i])
      }
    }
    new_active.push(new_idx)
    for i in 0..<new_active.length() {
      active[i] = new_active[i]
    }
    while active.length() > new_active.length() {
      ignore(active.pop())
    }
  }
  nodes
}

/// 生成 Huffman 编码 / Generate Huffman codes (symbol, code string).
pub fn huffman_code(nodes : Array[HuffmanNode]) -> Array[(Int, String)] {
  let result : Array[(Int, String)] = []
  if nodes.length() == 0 {
    return result
  }
  let root = nodes.length() - 1
  let stack : Array[(Int, String)] = [(root, "")]
  while stack.length() > 0 {
    let top = stack.pop().unwrap()
    let idx = top.0
    let code = top.1
    if nodes[idx].symbol >= 0 {
      result.push((nodes[idx].symbol, code))
    } else {
      if nodes[idx].right >= 0 {
        stack.push((nodes[idx].right, code + "1"))
      }
      if nodes[idx].left >= 0 {
        stack.push((nodes[idx].left, code + "0"))
      }
    }
  }
  result
}

/// Huffman 编码 / Huffman encode (returns bit string).
pub fn huffman_encode(data : Array[Int]) -> String {
  let freq_table = make_frequency_table(data)
  let nodes = build_huffman_tree(freq_table)
  let codes = huffman_code(nodes)
  let mut result = ""
  for i in 0..<data.length() {
    let mut found = ""
    for j in 0..<codes.length() {
      if codes[j].0 == data[i] {
        found = codes[j].1
      }
    }
    result = result + found
  }
  result
}

/// Huffman 解码 / Huffman decode (bit string, nodes array).
pub fn huffman_decode(bit_string : String, nodes : Array[HuffmanNode]) -> Array[Int] {
  let result : Array[Int] = []
  if nodes.length() == 0 {
    return result
  }
  let root = nodes.length() - 1
  let mut current = root
  for i in 0..<bit_string.length() {
    let bit = bit_string[i].to_int() - 48
    if bit == 0 {
      current = nodes[current].left
    } else {
      current = nodes[current].right
    }
    if nodes[current].symbol >= 0 {
      result.push(nodes[current].symbol)
      current = root
    }
  }
  result
}

// ============================================================
// LZ77 / LZSS
// ============================================================

/// LZ77 编码 / LZ77 encode.
pub fn lz77_encode(data : Array[Int]) -> Array[Lz77Triple] {
  let result : Array[Lz77Triple] = []
  let n = data.length()
  let window = 16
  let lookahead = 8
  let mut pos = 0
  while pos < n {
    let mut best_offset = 0
    let mut best_length = 0
    let start = if pos - window > 0 { pos - window } else { 0 }
    let end = if pos + lookahead < n { pos + lookahead } else { n }
    for sp in start..<pos {
      let mut match_len = 0
      while pos + match_len < end && data[sp + match_len] == data[pos + match_len] {
        match_len = match_len + 1
      }
      if match_len > best_length {
        best_length = match_len
        best_offset = pos - sp
      }
    }
    let next = if pos + best_length < n { data[pos + best_length] } else { 0 }
    result.push(Lz77Triple::{offset: best_offset, length: best_length, next})
    pos = pos + best_length + 1
  }
  result
}

/// LZ77 解码 / LZ77 decode.
pub fn lz77_decode(triples : Array[Lz77Triple]) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<triples.length() {
    let offset = triples[i].offset
    let length = triples[i].length
    let next = triples[i].next
    if offset > 0 && length > 0 {
      let start = result.length() - offset
      for j in 0..<length {
        if start + j < result.length() {
          result.push(result[start + j])
        }
      }
    }
    result.push(next)
  }
  result
}

/// LZSS 编码 / LZSS encode.
pub fn lzss_encode(data : Array[Int]) -> Array[LzssToken] {
  let result : Array[LzssToken] = []
  let n = data.length()
  let window = 16
  let min_match = 3
  let mut pos = 0
  while pos < n {
    let mut best_offset = 0
    let mut best_length = 0
    let start = if pos - window > 0 { pos - window } else { 0 }
    for sp in start..<pos {
      let mut match_len = 0
      while pos + match_len < n && data[sp + match_len] == data[pos + match_len] {
        match_len = match_len + 1
      }
      if match_len > best_length {
        best_length = match_len
        best_offset = pos - sp
      }
    }
    if best_length >= min_match {
      result.push(LzssToken::{flag: 1, offset: best_offset, length: best_length})
      pos = pos + best_length
    } else {
      result.push(LzssToken::{flag: 0, offset: data[pos], length: 1})
      pos = pos + 1
    }
  }
  result
}

/// LZSS 解码 / LZSS decode.
pub fn lzss_decode(tokens : Array[LzssToken]) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<tokens.length() {
    if tokens[i].flag == 1 {
      let offset = tokens[i].offset
      let length = tokens[i].length
      let start = result.length() - offset
      for j in 0..<length {
        if start + j < result.length() {
          result.push(result[start + j])
        }
      }
    } else {
      result.push(tokens[i].offset)
    }
  }
  result
}

// ============================================================
// LZW
// ============================================================

/// LZW 编码 / LZW encode.
pub fn lzw_encode(data : Array[Int]) -> Array[Int] {
  let result : Array[Int] = []
  let n = data.length()
  if n == 0 {
    return result
  }
  let dict_keys : Array[Array[Int]] = []
  let dict_vals : Array[Int] = []
  for i in 0..<256 {
    dict_keys.push([i])
    dict_vals.push(i)
  }
  let mut next_code = 256
  let mut w : Array[Int] = [data[0]]
  for i in 1..<n {
    let wc : Array[Int] = []
    for j in 0..<w.length() {
      wc.push(w[j])
    }
    wc.push(data[i])
    let mut found = -1
    for k in 0..<dict_keys.length() {
      if dict_keys[k].length() == wc.length() {
        let mut eq = true
        for m in 0..<wc.length() {
          if dict_keys[k][m] != wc[m] {
            eq = false
          }
        }
        if eq {
          found = dict_vals[k]
        }
      }
    }
    if found >= 0 {
      w = wc
    } else {
      let mut code_w = -1
      for k in 0..<dict_keys.length() {
        if dict_keys[k].length() == w.length() {
          let mut eq = true
          for m in 0..<w.length() {
            if dict_keys[k][m] != w[m] {
              eq = false
            }
          }
          if eq {
            code_w = dict_vals[k]
          }
        }
      }
      if code_w >= 0 {
        result.push(code_w)
      }
      dict_keys.push(wc)
      dict_vals.push(next_code)
      next_code = next_code + 1
      w = [data[i]]
    }
  }
  let mut code_w = -1
  for k in 0..<dict_keys.length() {
    if dict_keys[k].length() == w.length() {
      let mut eq = true
      for m in 0..<w.length() {
        if dict_keys[k][m] != w[m] {
          eq = false
        }
      }
      if eq {
        code_w = dict_vals[k]
      }
    }
  }
  if code_w >= 0 {
    result.push(code_w)
  }
  result
}

/// LZW 解码 / LZW decode.
pub fn lzw_decode(codes : Array[Int]) -> Array[Int] {
  let result : Array[Int] = []
  let n = codes.length()
  if n == 0 {
    return result
  }
  let dict_keys : Array[Int] = []
  let dict_vals : Array[Array[Int]] = []
  for i in 0..<256 {
    dict_keys.push(i)
    dict_vals.push([i])
  }
  let mut next_code = 256
  let mut prev : Array[Int] = [codes[0]]
  result.push(codes[0])
  for i in 1..<n {
    let code = codes[i]
    let entry : Array[Int] = []
    let mut found = false
    for k in 0..<dict_keys.length() {
      if dict_keys[k] == code {
        for m in 0..<dict_vals[k].length() {
          entry.push(dict_vals[k][m])
        }
        found = true
      }
    }
    if !(found) {
      for m in 0..<prev.length() {
        entry.push(prev[m])
      }
      entry.push(prev[0])
    }
    for m in 0..<entry.length() {
      result.push(entry[m])
    }
    let new_entry : Array[Int] = []
    for m in 0..<prev.length() {
      new_entry.push(prev[m])
    }
    new_entry.push(entry[0])
    dict_keys.push(next_code)
    dict_vals.push(new_entry)
    next_code = next_code + 1
    prev = entry
  }
  result
}

// ============================================================
// B!T
// ============================================================

/// BWT 编码 / BWT encode (returns last column and primary index).
pub fn bwt_encode(data : Array[Int]) -> (Array[Int], Int) {
  let n = data.length()
  if n == 0 {
    return ([], 0)
  }
  let rotations : Array[Array[Int]] = []
  for i in 0..<n {
    let rot : Array[Int] = []
    for j in 0..<n {
      rot.push(data[(i + j) % n])
    }
    rotations.push(rot)
  }
  let indices : Array[Int] = []
  for i in 0..<n {
    indices.push(i)
  }
  for i in 0..<n {
    let mut min_idx = i
    for j in (i + 1)..<n {
      let a = indices[j]
      let b = indices[min_idx]
      let mut less = false
      for k in 0..<n {
        if rotations[a][k] < rotations[b][k] {
          less = true
          break
        } else if rotations[a][k] > rotations[b][k] {
          break
        }
      }
      if less {
        min_idx = j
      }
    }
    let tmp = indices[i]
    indices[i] = indices[min_idx]
    indices[min_idx] = tmp
  }
  let last : Array[Int] = []
  let mut primary = 0
  for i in 0..<n {
    let orig_idx = indices[i]
    last.push(rotations[orig_idx][n - 1])
    if orig_idx == 0 {
      primary = i
    }
  }
  (last, primary)
}

/// BWT 解码 / BWT decode.
pub fn bwt_decode(last : Array[Int], primary : Int) -> Array[Int] {
  let n = last.length()
  if n == 0 {
    return []
  }
  let pairs : Array[(Int, Int)] = []
  for i in 0..<n {
    pairs.push((last[i], i))
  }
  for i in 0..<n {
    let mut min_idx = i
    for j in (i + 1)..<n {
      if pairs[j].0 < pairs[min_idx].0 || (pairs[j].0 == pairs[min_idx].0 && pairs[j].1 < pairs[min_idx].1) {
        min_idx = j
      }
    }
    let tmp = pairs[i]
    pairs[i] = pairs[min_idx]
    pairs[min_idx] = tmp
  }
  let result : Array[Int] = []
  let mut idx = primary
  for _i in 0..<n {
    result.push(pairs[idx].0)
    idx = pairs[idx].1
  }
  result
}

// ============================================================
// 字典 / Dictionary
// ============================================================

/// 创建字典 / Make dictionary.
pub fn make_dictionary() -> Array[DictEntry] {
  []
}

/// 字典查找 / Dictionary lookup (returns index or -1).
pub fn dictionary_lookup(dict : Array[DictEntry], key : Array[Int]) -> Int {
  for i in 0..<dict.length() {
    if dict[i].data.length() == key.length() {
      let mut eq = true
      for j in 0..<key.length() {
        if dict[i].data[j] != key[j] {
          eq = false
        }
      }
      if eq {
        return dict[i].index
      }
    }
  }
  -1
}

/// 字典添加 / Dictionary add.
pub fn dictionary_add(dict : Array[DictEntry], data : Array[Int]) -> Array[DictEntry] {
  let new_dict : Array[DictEntry] = []
  for i in 0..<dict.length() {
    new_dict.push(dict[i])
  }
  new_dict.push(DictEntry::{index: dict.length(), data})
  new_dict
}

// ============================================================
// 字符串压缩 / String compress
// ============================================================

/// 字符串压缩 / Compress string (to RLE entries as string).
pub fn compress_string(s : String) -> String {
  let data : Array[Int] = []
  for i in 0..<s.length() {
    data.push(s[i].to_int())
  }
  let encoded = rle_encode(data)
  let mut result = ""
  for i in 0..<encoded.length() {
    result = result + encoded[i].value.to_string() + ":" + encoded[i].count.to_string()
    if i < encoded.length() - 1 {
      result = result + ","
    }
  }
  result
}

/// 字符串解压 / Decompress string.
pub fn decompress_string(s : String) -> String {
  let entries : Array[RleEntry] = []
  let mut i = 0
  let mut current_value = 0
  let mut current_count = 0
  let mut in_value = true
  let mut num = 0
  while i < s.length() {
    let c = s[i].to_int()
    if c >= 48 && c <= 57 {
      num = num * 10 + (c - 48)
    } else if c == 58 {
      current_value = num
      num = 0
      in_value = false
    } else if c == 44 {
      current_count = num
      num = 0
      in_value = true
      entries.push(RleEntry::{value: current_value, count: current_count})
    }
    i = i + 1
  }
  current_count = num
  if !(in_value) {
    entries.push(RleEntry::{value: current_value, count: current_count})
  }
  let decoded = rle_decode(entries)
  let mut result = ""
  for j in 0..<decoded.length() {
    result = result + String::from_array([Int::unsafe_to_char(decoded[j])])
  }
  result
}

/// 压缩比率 / Compression ratio.
pub fn compression_ratio(original_size : Int, compressed_size : Int) -> Double {
  if original_size == 0 {
    return 0.0
  }
  compressed_size.to_double() / original_size.to_double()
}

// ============================================================
// 位写入器 / Bit writer
// ============================================================

/// 创建位写入器 / Make bit writer.
pub fn make_bit_writer() -> BitWriter {
  BitWriter::{bits: [], buffer: 0, count: 0}
}

/// 写入位 / Write bits (value, n_bits).
pub fn write_bits(writer : BitWriter, value : Int, n_bits : Int) -> BitWriter {
  let new_bits : Array[Int] = []
  for i in 0..<writer.bits.length() {
    new_bits.push(writer.bits[i])
  }
  for i in 0..<n_bits {
    new_bits.push((value >> (n_bits - 1 - i)) & 1)
  }
  BitWriter::{bits: new_bits, buffer: writer.buffer, count: writer.count + n_bits}
}

/// 读取位 / Read bits (bit string, n_bits) -> (value, remaining).
pub fn read_bits(bit_string : String, n_bits : Int) -> (Int, String) {
  if n_bits <= 0 || n_bits > bit_string.length() {
    return (0, bit_string)
  }
  let mut value = 0
  for i in 0..<n_bits {
    value = value * 2 + (bit_string[i].to_int() - 48)
  }
  let mut remaining = ""
  for i in n_bits..<bit_string.length() {
    remaining = remaining + String::from_array([Int::unsafe_to_char(bit_string[i].to_int())])
  }
  (value, remaining)
}

/// 刷新位 / Flush bits to string.
pub fn flush_bits(writer : BitWriter) -> String {
  let mut result = ""
  for i in 0..<writer.bits.length() {
    result = result + (if writer.bits[i] == 1 { "1" } else { "0" })
  }
  result
}

// ============================================================
// Delta 编码 / Delta encoding
// ============================================================

/// Delta 编码 / Delta encode.
pub fn delta_encode(data : Array[Int]) -> Array[Int] {
  let result : Array[Int] = []
  let n = data.length()
  if n == 0 {
    return result
  }
  result.push(data[0])
  for i in 1..<n {
    result.push(data[i] - data[i - 1])
  }
  result
}

/// Delta 解码 / Delta decode.
pub fn delta_decode(data : Array[Int]) -> Array[Int] {
  let result : Array[Int] = []
  let n = data.length()
  if n == 0 {
    return result
  }
  result.push(data[0])
  let mut sum = data[0]
  for i in 1..<n {
    sum = sum + data[i]
    result.push(sum)
  }
  result
}

// ============================================================
// 压缩统计 / Compression stats
// ============================================================

/// 创建压缩统计 / Make compression stats.
pub fn make_compression_stats(
  original_size : Int,
  compressed_size : Int,
  algorithm : String
) -> CompressionStats {
  let r = compression_ratio(original_size, compressed_size)
  CompressionStats::{original_size, compressed_size, ratio: r, algorithm}
}

/// 统计压缩大小 / Stats compressed size.
pub fn stats_compressed_size(stats : CompressionStats) -> Int {
  stats.compressed_size
}

/// 统计原始大小 / Stats original size.
pub fn stats_original_size(stats : CompressionStats) -> Int {
  stats.original_size
}

// ============================================================
// GZIP / ZLIB / Deflate
// ============================================================

/// GZIP 头部 / GZIP header (10 bytes).
pub fn gzip_header() -> Array[Int] {
  [31, 139, 8, 0, 0, 0, 0, 0, 0, 255]
}

/// ZLIB 头部 / ZLIB header (2 bytes).
pub fn zlib_header() -> Array[Int] {
  [120, 156]
}

/// 简化 Deflate / Simple deflate (LZ77 + header).
pub fn deflate_simple(data : Array[Int]) -> Array[Int] {
  let result : Array[Int] = []
  for i in 0..<2 {
    result.push(zlib_header()[i])
  }
  let encoded = lz77_encode(data)
  for i in 0..<encoded.length() {
    result.push(encoded[i].offset)
    result.push(encoded[i].length)
    result.push(encoded[i].next)
  }
  result
}

/// 简化 Inflate / Simple inflate.
pub fn inflate_simple(data : Array[Int]) -> Array[Int] {
  if data.length() <= 2 {
    return []
  }
  let triples : Array[Lz77Triple] = []
  let mut i = 2
  while i + 2 < data.length() {
    triples.push(Lz77Triple::{offset: data[i], length: data[i + 1], next: data[i + 2]})
    i = i + 3
  }
  lz77_decode(triples)
}

// ============================================================
// 压缩级别 / Compression level
// ============================================================

/// 按级别压缩 / Compress with level.
pub fn compress_level(data : Array[Int], level : CompressionLevel) -> Array[Int] {
  match level {
    NoCompression => {
      let result : Array[Int] = []
      for i in 0..<data.length() {
        result.push(data[i])
      }
      result
    }
    Fast => {
      let encoded = rle_encode(data)
      let result : Array[Int] = []
      for i in 0..<encoded.length() {
        result.push(encoded[i].value)
        result.push(encoded[i].count)
      }
      result
    }
    DefaultLevel => {
      let encoded = lz77_encode(data)
      let result : Array[Int] = []
      for i in 0..<encoded.length() {
        result.push(encoded[i].offset)
        result.push(encoded[i].length)
        result.push(encoded[i].next)
      }
      result
    }
    Best => {
      let encoded = lzw_encode(data)
      encoded
    }
  }
}

/// 自适应压缩 / Adaptive compress (choose algorithm by data characteristics).
pub fn adaptive_compress(data : Array[Int]) -> Array[Int] {
  if run_length_check(data) {
    let encoded = rle_encode(data)
    let result : Array[Int] = []
    for i in 0..<encoded.length() {
      result.push(encoded[i].value)
      result.push(encoded[i].count)
    }
    result
  } else {
    lzw_encode(data)
  }
}

/// 并行压缩 / Parallel compress (split data into chunks, compress each).
pub fn parallel_compress(data : Array[Int], n_chunks : Int) -> Array[Int] {
  if n_chunks <= 0 {
    return lzw_encode(data)
  }
  let n = data.length()
  let chunk_size = (n + n_chunks - 1) / n_chunks
  let result : Array[Int] = []
  let mut pos = 0
  while pos < n {
    let end = if pos + chunk_size < n { pos + chunk_size } else { n }
    let chunk : Array[Int] = []
    for i in pos..<end {
      chunk.push(data[i])
    }
    let encoded = lzw_encode(chunk)
    result.push(encoded.length())
    for i in 0..<encoded.length() {
      result.push(encoded[i])
    }
    pos = pos + chunk_size
  }
  result
}

// ============================================================
// ID
// ============================================================

/// 压缩统计比率 / Stats ratio.
pub fn stats_ratio(stats : CompressionStats) -> Double {
  stats.ratio
}

/// 压缩算子 ID / Compression operator ID.
pub fn compression_id() -> String {
  "opcore/compression"
}