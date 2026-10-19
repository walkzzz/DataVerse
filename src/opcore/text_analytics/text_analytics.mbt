///|
/// # opcore/text_analytics 文本分析 / Text Analytics
///
/// 分词 / 相似度 / 情感 / 主题 / 嵌入 / 分类。对标 NLTK + spaCy + gensim。
/// S12.2 新建：60+ pub fn 文本分析算子。
///
/// # Text analytics
///
/// Tokenize / similarity / sentiment / topic / embedding / classification.

const TA_LARGE_DOUBLE : Double = 999999999999999.0
const TA_E_EULER : Double = 2.718281828459045

// ============================================================
// 辅助数学函数 / Helper math functions (private)
// ============================================================

fn ta_sqrt(x : Double) -> Double {
  if x < 0.0 {
    return 0.0
  }
  if x == 0.0 {
    return 0.0
  }
  let mut guess = x / 2.0
  if guess == 0.0 {
    guess = 1.0
  }
  for _ in 0..<60 {
    guess = (guess + x / guess) / 2.0
  }
  guess
}

fn ta_abs(x : Double) -> Double {
  if x < 0.0 {
    -x
  } else {
    x
  }
}

fn ta_exp(x : Double) -> Double {
  if x > 700.0 {
    return TA_LARGE_DOUBLE
  }
  if x < -700.0 {
    return 0.0
  }
  let mut n = 0
  let mut y = x
  while y > 0.5 {
    y = y / 2.0
    n = n + 1
  }
  while y < -0.5 {
    y = y / 2.0
    n = n + 1
  }
  let mut result = 1.0
  let mut term = 1.0
  for i in 1..<40 {
    term = term * y / i.to_double()
    result = result + term
    if ta_abs(term) < 0.0000000000000001 {
      break
    }
  }
  for _ in 0..<n {
    result = result * result
  }
  result
}

fn ta_ln(x : Double) -> Double {
  if x <= 0.0 {
    return -TA_LARGE_DOUBLE
  }
  if x == 1.0 {
    return 0.0
  }
  let mut m = 0
  let mut y = x
  while y > 2.0 {
    y = y / TA_E_EULER
    m = m + 1
  }
  while y < 0.5 {
    y = y * TA_E_EULER
    m = m - 1
  }
  let t = (y - 1.0) / (y + 1.0)
  let mut result = 0.0
  let mut t_pow = t
  for k in 0..<80 {
    let term = t_pow / (2 * k + 1).to_double()
    result = result + term
    t_pow = t_pow * t * t
    if ta_abs(term) < 0.0000000000000001 {
      break
    }
  }
  result * 2.0 + m.to_double()
}

fn ta_pow(base : Double, exp : Double) -> Double {
  if base < 0.0 {
    let rounded = exp.to_int().to_double()
    if rounded == exp {
      let n = exp.to_int()
      let mut result = 1.0
      let mut abs_n = if n < 0 { -n } else { n }
      let b = if n < 0 { 1.0 / base } else { base }
      while abs_n > 0 {
        result = result * b
        abs_n = abs_n - 1
      }
      result
    } else {
      0.0
    }
  } else if base == 0.0 {
    if exp > 0.0 { 0.0 } else { TA_LARGE_DOUBLE }
  } else {
    ta_exp(exp * ta_ln(base))
  }
}

// ============================================================
// 辅助字符函数 / Helper char functions (private)
// ============================================================

fn ta_is_letter(c : Char) -> Bool {
  (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')
}

fn ta_is_digit(c : Char) -> Bool {
  c >= '0' && c <= '9'
}

fn ta_is_whitespace(c : Char) -> Bool {
  c == ' ' || c == '\t' || c == '\n' || c == '\r'
}

fn ta_is_punctuation(c : Char) -> Bool {
  !ta_is_letter(c) && !ta_is_digit(c) && !ta_is_whitespace(c)
}

fn ta_is_vowel(c : Char) -> Bool {
  c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' || c == 'y' ||
  c == 'A' || c == 'E' || c == 'I' || c == 'O' || c == 'U' || c == 'Y'
}

fn ta_ends_with(s : String, suffix : String) -> Bool {
  let slen = s.length()
  let flen = suffix.length()
  if slen < flen {
    return false
  }
  let s_chars = s.to_array()
  let f_chars = suffix.to_array()
  for i in 0..<flen {
    if s_chars[slen - flen + i] != f_chars[i] {
      return false
    }
  }
  true
}

fn ta_starts_with(s : String, prefix : String) -> Bool {
  let slen = s.length()
  let plen = prefix.length()
  if slen < plen {
    return false
  }
  let s_chars = s.to_array()
  let p_chars = prefix.to_array()
  for i in 0..<plen {
    if s_chars[i] != p_chars[i] {
      return false
    }
  }
  true
}

fn ta_substring(s : String, start : Int, length : Int) -> String {
  let chars = s.to_array()
  let slen = chars.length()
  if start < 0 || start >= slen || length <= 0 {
    return ""
  }
  let end = if start + length < slen { start + length } else { slen }
  String::from_array(chars[start:end])
}

fn ta_count_syllables(word : String) -> Int {
  let w = word.to_lower()
  let chars = w.to_array()
  if chars.length() == 0 {
    return 0
  }
  let mut count = 0
  let mut prev_vowel = false
  for i in 0..<chars.length() {
    let c = chars[i]
    let is_v = ta_is_vowel(c)
    if is_v && !prev_vowel {
      count = count + 1
    }
    prev_vowel = is_v
  }
  if count == 0 {
    count = 1
  }
  if chars[chars.length() - 1] == 'e' && count > 1 {
    count = count - 1
  }
  if count == 0 {
    count = 1
  }
  count
}

fn ta_contains(arr : Array[String], s : String) -> Bool {
  for i in 0..<arr.length() {
    if arr[i] == s {
      return true
    }
  }
  false
}

fn ta_pos_words() -> Array[String] {
  ["good", "great", "excellent", "happy", "love", "wonderful", "amazing", "best", "beautiful", "perfect", "nice", "awesome", "fantastic", "brilliant", "superb"]
}

fn ta_neg_words() -> Array[String] {
  ["bad", "terrible", "awful", "sad", "hate", "horrible", "worst", "ugly", "wrong", "poor", "nasty", "dreadful", "appalling", "atrocious", "inferior"]
}

fn ta_stop_words() -> Array[String] {
  ["the", "a", "an", "is", "are", "was", "were", "be", "been", "being", "have", "has", "had", "do", "does", "did", "will", "would", "could", "should", "may", "might", "must", "can", "of", "in", "on", "at", "to", "for", "with", "by", "from", "as", "and", "or", "not", "but", "if", "then", "else", "this", "that", "these", "those", "i", "you", "he", "she", "it", "we", "they"]
}

fn ta_soundex_code(c : Char) -> Char {
  match c {
    'B' | 'F' | 'P' | 'V' => '1'
    'C' | 'G' | 'J' | 'K' | 'Q' | 'S' | 'X' | 'Z' => '2'
    'D' | 'T' => '3'
    'L' => '4'
    'M' | 'N' => '5'
    'R' => '6'
    _ => '0'
  }
}

// ============================================================
// 类型定义 / Type definitions
// ============================================================

/// 语言模型 / Language model (n-gram).
pub(all) struct LanguageModel {
  n : Int
  ngrams : Array[(String, Int)]
  total : Int
} derive(Debug, Eq)

pub extend LanguageModel with Eq::{equal, not_equal}
pub extend LanguageModel with Debug::{to_repr}

/// 主题模型 / Topic model.
pub(all) struct TopicModel {
  k : Int
  words : Array[String]
  distributions : Array[Array[Double]]
} derive(Debug, Eq)

pub extend TopicModel with Eq::{equal, not_equal}
pub extend TopicModel with Debug::{to_repr}

/// 语料库 / Corpus.
pub(all) struct Corpus {
  docs : Array[Array[String]]
  vocabulary : Array[String]
} derive(Debug, Eq)

pub extend Corpus with Eq::{equal, not_equal}
pub extend Corpus with Debug::{to_repr}

/// 语料库统计 / Corpus statistics.
pub(all) struct CorpusStats {
  doc_count : Int
  total_words : Int
  avg_doc_length : Double
  vocab_size : Int
} derive(Debug, Eq)

pub extend CorpusStats with Eq::{equal, not_equal}
pub extend CorpusStats with Debug::{to_repr}

// ============================================================
// 基础文本操作 / Basic text operations
// ============================================================

/// 分词 / Tokenize text into words (split on whitespace and punctuation).
pub fn tokenize(s : String) -> Array[String] {
  let chars = s.to_array()
  let result : Array[String] = []
  let mut current : Array[Char] = []
  for i in 0..<chars.length() {
    let c = chars[i]
    if ta_is_whitespace(c) || ta_is_punctuation(c) {
      if current.length() > 0 {
        result.push(String::from_array(current))
        current = []
      }
    } else {
      current.push(c)
    }
  }
  if current.length() > 0 {
    result.push(String::from_array(current))
  }
  result
}

/// 按空格分词 / Split words by whitespace.
pub fn split_words(s : String) -> Array[String] {
  let chars = s.to_array()
  let result : Array[String] = []
  let mut current : Array[Char] = []
  for i in 0..<chars.length() {
    let c = chars[i]
    if ta_is_whitespace(c) {
      if current.length() > 0 {
        result.push(String::from_array(current))
        current = []
      }
    } else {
      current.push(c)
    }
  }
  if current.length() > 0 {
    result.push(String::from_array(current))
  }
  result
}

/// 分句 / Split text into sentences.
pub fn split_sentences(s : String) -> Array[String] {
  let chars = s.to_array()
  let result : Array[String] = []
  let mut current : Array[Char] = []
  for i in 0..<chars.length() {
    let c = chars[i]
    current.push(c)
    if c == '.' || c == '!' || c == '?' {
      let sent = String::from_array(current).trim().to_owned()
      if sent.length() > 0 {
        result.push(sent)
      }
      current = []
    }
  }
  if current.length() > 0 {
    let sent = String::from_array(current).trim().to_owned()
    if sent.length() > 0 {
      result.push(sent)
    }
  }
  result
}

/// 文本归一化 / Normalize text (collapse whitespace, trim).
pub fn normalize_text(s : String) -> String {
  let chars = s.to_array()
  let result : Array[Char] = []
  let mut prev_space = false
  for i in 0..<chars.length() {
    let c = chars[i]
    if ta_is_whitespace(c) {
      if !prev_space {
        result.push(' ')
        prev_space = true
      }
    } else {
      result.push(c)
      prev_space = false
    }
  }
  String::from_array(result).trim().to_owned()
}

/// 转小写 / Convert to lowercase.
pub fn lowercase(s : String) -> String {
  s.to_lower()
}

/// 转大写 / Convert to uppercase.
pub fn uppercase(s : String) -> String {
  s.to_upper()
}

/// 首字母大写 / Capitalize first letter.
pub fn capitalize(s : String) -> String {
  if s.length() == 0 {
    return ""
  }
  let chars = s.to_array()
  let result : Array[Char] = []
  let first = chars[0]
  if first >= 'a' && first <= 'z' {
    result.push(Char::from_int(first.to_int() - 32))
  } else {
    result.push(first)
  }
  for i in 1..<chars.length() {
    result.push(chars[i])
  }
  String::from_array(result)
}

/// 去除标点 / Strip punctuation from text.
pub fn strip_punctuation(s : String) -> String {
  let chars = s.to_array()
  let result : Array[Char] = []
  for i in 0..<chars.length() {
    let c = chars[i]
    if !ta_is_punctuation(c) {
      result.push(c)
    }
  }
  String::from_array(result)
}

// ============================================================
// 统计 / Statistics
// ============================================================

/// 词数 / Word count.
pub fn word_count(s : String) -> Int {
  split_words(s).length()
}

/// 字符数 / Character count (excluding whitespace).
pub fn char_count(s : String) -> Int {
  let chars = s.to_array()
  let mut count = 0
  for i in 0..<chars.length() {
    if !ta_is_whitespace(chars[i]) {
      count = count + 1
    }
  }
  count
}

/// 句数 / Sentence count.
pub fn sentence_count(s : String) -> Int {
  split_sentences(s).length()
}

/// 平均词长 / Average word length.
pub fn avg_word_length(s : String) -> Double {
  let words = split_words(s)
  let n = words.length()
  if n == 0 {
    return 0.0
  }
  let mut total = 0
  for i in 0..<n {
    total = total + words[i].length()
  }
  total.to_double() / n.to_double()
}

/// 词频 / Term frequency (TF).
pub fn term_frequency(term : String, doc : String) -> Double {
  let words = tokenize(doc)
  let n = words.length()
  if n == 0 {
    return 0.0
  }
  let mut count = 0
  for i in 0..<n {
    if words[i] == term {
      count = count + 1
    }
  }
  count.to_double() / n.to_double()
}

/// 文档频率 / Document frequency (DF).
pub fn document_frequency(term : String, corpus : Array[String]) -> Int {
  let mut count = 0
  for i in 0..<corpus.length() {
    let words = tokenize(corpus[i])
    let mut found = false
    for j in 0..<words.length() {
      if words[j] == term {
        found = true
        break
      }
    }
    if found {
      count = count + 1
    }
  }
  count
}

/// TF-IDF / TF-IDF score.
pub fn tf_idf(term : String, doc : String, corpus : Array[String]) -> Double {
  let tf = term_frequency(term, doc)
  let df = document_frequency(term, corpus)
  let n = corpus.length()
  if df == 0 || n == 0 {
    return 0.0
  }
  let idf = ta_ln(n.to_double() / df.to_double()) + 1.0
  tf * idf
}

// ============================================================
// N-grams
// ============================================================

/// N-grams / Generate n-grams from word array.
pub fn ngrams(words : Array[String], n : Int) -> Array[String] {
  let result : Array[String] = []
  let len = words.length()
  if n <= 0 || len < n {
    return result
  }
  let upper = len - n + 1
  for i in 0..<upper {
    let mut gram = words[i]
    for j in 1..<n {
      gram = gram + " " + words[i + j]
    }
    result.push(gram)
  }
  result
}

/// 二元组 / Bigrams.
pub fn bigrams(words : Array[String]) -> Array[String] {
  ngrams(words, 2)
}

/// 三元组 / Trigrams.
pub fn trigrams(words : Array[String]) -> Array[String] {
  ngrams(words, 3)
}

/// 跳跃元组 / Skip-grams with skip distance k.
pub fn skip_grams(words : Array[String], k : Int) -> Array[String] {
  let result : Array[String] = []
  let len = words.length()
  if k <= 0 || len < 2 {
    return result
  }
  for i in 0..<len {
    let j = i + k
    if j < len {
      result.push(words[i] + " " + words[j])
    }
  }
  result
}

// ============================================================
// 相似度与距离 / Similarity and distance
// ============================================================

/// 编辑距离 / Levenshtein edit distance.
pub fn levenshtein_distance(s1 : String, s2 : String) -> Int {
  let chars1 = s1.to_array()
  let chars2 = s2.to_array()
  let m = chars1.length()
  let n = chars2.length()
  if m == 0 {
    return n
  }
  if n == 0 {
    return m
  }
  let dp : Array[Array[Int]] = []
  let rows = m + 1
  let cols = n + 1
  for i in 0..<rows {
    let row : Array[Int] = []
    for j in 0..<cols {
      if i == 0 {
        row.push(j)
      } else if j == 0 {
        row.push(i)
      } else {
        let cost = if chars1[i - 1] == chars2[j - 1] { 0 } else { 1 }
        let del = dp[i - 1][j] + 1
        let ins = row[j - 1] + 1
        let sub = dp[i - 1][j - 1] + cost
        let m1 = if del < ins { del } else { ins }
        row.push(if m1 < sub { m1 } else { sub })
      }
    }
    dp.push(row)
  }
  dp[m][n]
}

/// Jaccard 相似度 / Jaccard similarity (word sets).
pub fn jaccard_similarity(s1 : String, s2 : String) -> Double {
  let w1 = tokenize(s1)
  let w2 = tokenize(s2)
  let set1 : Array[String] = []
  for i in 0..<w1.length() {
    if !ta_contains(set1, w1[i]) {
      set1.push(w1[i])
    }
  }
  let set2 : Array[String] = []
  for i in 0..<w2.length() {
    if !ta_contains(set2, w2[i]) {
      set2.push(w2[i])
    }
  }
  let mut inter = 0
  for i in 0..<set1.length() {
    if ta_contains(set2, set1[i]) {
      inter = inter + 1
    }
  }
  let union_count = set1.length() + set2.length() - inter
  if union_count == 0 {
    return 0.0
  }
  inter.to_double() / union_count.to_double()
}

/// 余弦文本相似度 / Cosine text similarity (word frequency vectors).
pub fn cosine_text_similarity(s1 : String, s2 : String) -> Double {
  let words1 = tokenize(s1)
  let words2 = tokenize(s2)
  let vocab : Array[String] = []
  for i in 0..<words1.length() {
    if !ta_contains(vocab, words1[i]) {
      vocab.push(words1[i])
    }
  }
  for i in 0..<words2.length() {
    if !ta_contains(vocab, words2[i]) {
      vocab.push(words2[i])
    }
  }
  let mut dot = 0.0
  let mut norm1 = 0.0
  let mut norm2 = 0.0
  for i in 0..<vocab.length() {
    let mut c1 = 0
    for j in 0..<words1.length() {
      if words1[j] == vocab[i] {
        c1 = c1 + 1
      }
    }
    let mut c2 = 0
    for j in 0..<words2.length() {
      if words2[j] == vocab[i] {
        c2 = c2 + 1
      }
    }
    dot = dot + c1.to_double() * c2.to_double()
    norm1 = norm1 + c1.to_double() * c1.to_double()
    norm2 = norm2 + c2.to_double() * c2.to_double()
  }
  if norm1 == 0.0 || norm2 == 0.0 {
    return 0.0
  }
  dot / (ta_sqrt(norm1) * ta_sqrt(norm2))
}

/// Jaro 距离 / Jaro similarity.
pub fn jaro_distance(s1 : String, s2 : String) -> Double {
  if s1 == s2 {
    return 1.0
  }
  let chars1 = s1.to_array()
  let chars2 = s2.to_array()
  let len1 = chars1.length()
  let len2 = chars2.length()
  if len1 == 0 || len2 == 0 {
    return 0.0
  }
  let max_len = if len1 > len2 { len1 } else { len2 }
  let match_dist = if max_len / 2 > 0 { max_len / 2 - 1 } else { 0 }
  let s1_matches : Array[Bool] = []
  let s2_matches : Array[Bool] = []
  for _ in 0..<len1 {
    s1_matches.push(false)
  }
  for _ in 0..<len2 {
    s2_matches.push(false)
  }
  let mut matches = 0
  for i in 0..<len1 {
    let start = if i - match_dist > 0 { i - match_dist } else { 0 }
    let end = if i + match_dist + 1 < len2 { i + match_dist + 1 } else { len2 }
    for j in start..<end {
      if !s2_matches[j] && chars1[i] == chars2[j] {
        s1_matches[i] = true
        s2_matches[j] = true
        matches = matches + 1
        break
      }
    }
  }
  if matches == 0 {
    return 0.0
  }
  let mut transpositions = 0
  let mut k = 0
  for i in 0..<len1 {
    if s1_matches[i] {
      while k < len2 && !s2_matches[k] {
        k = k + 1
      }
      if k < len2 && chars1[i] != chars2[k] {
        transpositions = transpositions + 1
      }
      k = k + 1
    }
  }
  let m = matches.to_double()
  let t = transpositions.to_double() / 2.0
  (m / len1.to_double() + m / len2.to_double() + (m - t) / m) / 3.0
}

/// Jaro-Winkler 距离 / Jaro-Winkler similarity.
pub fn jaro_winkler(s1 : String, s2 : String) -> Double {
  let jaro = jaro_distance(s1, s2)
  let chars1 = s1.to_array()
  let chars2 = s2.to_array()
  let mut prefix = 0
  let max_prefix = if chars1.length() < 4 { chars1.length() } else { 4 }
  for i in 0..<max_prefix {
    if i < chars2.length() && chars1[i] == chars2[i] {
      prefix = prefix + 1
    } else {
      break
    }
  }
  jaro + prefix.to_double() * 0.1 * (1.0 - jaro)
}

/// Soundex 编码 / Soundex phonetic code.
pub fn soundex(s : String) -> String {
  if s.length() == 0 {
    return ""
  }
  let chars = s.to_upper().to_array()
  let mut result = chars[0].to_string()
  let mut prev_code = ta_soundex_code(chars[0])
  for i in 1..<chars.length() {
    let code = ta_soundex_code(chars[i])
    if code != '0' && code != prev_code {
      result = result + code.to_string()
      if result.length() >= 4 {
        return result
      }
    }
    if code != '0' {
      prev_code = code
    }
  }
  while result.length() < 4 {
    result = result + "0"
  }
  result
}

/// Metaphone 编码 / Metaphone phonetic code (simplified).
pub fn metaphone(s : String) -> String {
  if s.length() == 0 {
    return ""
  }
  let chars = s.to_upper().to_array()
  let result : Array[Char] = []
  for i in 0..<chars.length() {
    let c = chars[i]
    if ta_is_letter(c) {
      if c == 'C' {
        result.push('K')
      } else if c == 'Q' {
        result.push('K')
      } else if c == 'X' {
        result.push('K')
        result.push('S')
      } else if c == 'P' && i + 1 < chars.length() && chars[i + 1] == 'H' {
        result.push('F')
      } else if c == 'T' && i + 1 < chars.length() && chars[i + 1] == 'H' {
        result.push('0')
      } else if c == 'S' && i + 1 < chars.length() && chars[i + 1] == 'H' {
        result.push('X')
      } else if c == 'G' && i + 1 < chars.length() && chars[i + 1] == 'H' {
        result.push('F')
      } else if c != 'H' && c != 'W' && c != 'Y' {
        result.push(c)
      }
    }
  }
  String::from_array(result)
}

// ============================================================
// 词形处理 / Stemming and lemmatization
// ============================================================

/// Porter 词干提取 / Porter stemmer (simplified).
pub fn stem_porter(word : String) -> String {
  let w = word.to_lower()
  if w.length() <= 2 {
    return w
  }
  let mut result = w
  if ta_ends_with(result, "sses") {
    result = ta_substring(result, 0, result.length() - 2)
  } else if ta_ends_with(result, "ies") {
    result = ta_substring(result, 0, result.length() - 2)
  } else if ta_ends_with(result, "s") && !ta_ends_with(result, "ss") {
    result = ta_substring(result, 0, result.length() - 1)
  }
  if ta_ends_with(result, "eed") {
    result = ta_substring(result, 0, result.length() - 1)
  } else if ta_ends_with(result, "ed") && result.length() > 3 {
    result = ta_substring(result, 0, result.length() - 2)
  } else if ta_ends_with(result, "ing") && result.length() > 4 {
    result = ta_substring(result, 0, result.length() - 3)
  }
  if ta_ends_with(result, "ly") {
    result = ta_substring(result, 0, result.length() - 2)
  }
  result
}

/// 简单词形归并 / Simple lemmatization.
pub fn lemmatize_simple(word : String) -> String {
  let w = word.to_lower()
  let irregular : Array[(String, String)] = [
    ("went", "go"), ("gone", "go"), ("going", "go"),
    ("was", "be"), ("were", "be"), ("been", "be"), ("being", "be"),
    ("had", "have"), ("has", "have"), ("having", "have"),
    ("did", "do"), ("done", "do"), ("doing", "do"),
    ("ate", "eat"), ("eaten", "eat"), ("eating", "eat"),
    ("ran", "run"), ("running", "run"),
    ("sat", "sit"), ("sitting", "sit"),
    ("met", "meet"), ("meeting", "meet"),
    ("children", "child"), ("men", "man"), ("women", "woman"),
    ("feet", "foot"), ("teeth", "tooth"),
  ]
  for i in 0..<irregular.length() {
    if irregular[i].0 == w {
      return irregular[i].1
    }
  }
  stem_porter(w)
}

/// 去停用词 / Remove stop words.
pub fn remove_stopwords(words : Array[String]) -> Array[String] {
  let stops = ta_stop_words()
  let result : Array[String] = []
  for i in 0..<words.length() {
    let w = words[i].to_lower()
    if !ta_contains(stops, w) {
      result.push(words[i])
    }
  }
  result
}

// ============================================================
// 语言模型 / Language model
// ============================================================

/// 构建语言模型 / Make n-gram language model.
pub fn make_language_model(corpus : Array[String], n : Int) -> LanguageModel {
  let all_ngrams : Array[String] = []
  for i in 0..<corpus.length() {
    let words = tokenize(corpus[i])
    let grams = ngrams(words, n)
    for j in 0..<grams.length() {
      all_ngrams.push(grams[j])
    }
  }
  let counts : Array[(String, Int)] = []
  for i in 0..<all_ngrams.length() {
    let g = all_ngrams[i]
    let mut found = false
    for j in 0..<counts.length() {
      if counts[j].0 == g {
        let cnt = counts[j].1
        counts[j] = (g, cnt + 1)
        found = true
        break
      }
    }
    if !found {
      counts.push((g, 1))
    }
  }
  { n, ngrams: counts, total: all_ngrams.length() }
}

/// N-gram 概率 / N-gram probability.
pub fn ngram_probability(
  model : LanguageModel,
  context : Array[String],
  word : String
) -> Double {
  let mut gram = ""
  for i in 0..<context.length() {
    if i == 0 {
      gram = context[i]
    } else {
      gram = gram + " " + context[i]
    }
  }
  if gram.length() > 0 {
    gram = gram + " " + word
  } else {
    gram = word
  }
  let mut count = 0
  for i in 0..<model.ngrams.length() {
    if model.ngrams[i].0 == gram {
      count = model.ngrams[i].1
      break
    }
  }
  if model.total == 0 {
    return 0.0
  }
  count.to_double() / model.total.to_double()
}

/// 困惑度 / Perplexity of text given model.
pub fn perplexity(model : LanguageModel, text : Array[String]) -> Double {
  let grams = ngrams(text, model.n)
  let len = grams.length()
  if len == 0 {
    return 0.0
  }
  let mut log_sum = 0.0
  for i in 0..<len {
    let mut count = 0
    for j in 0..<model.ngrams.length() {
      if model.ngrams[j].0 == grams[i] {
        count = model.ngrams[j].1
        break
      }
    }
    let prob = if model.total == 0 {
      0.0
    } else {
      count.to_double() / model.total.to_double()
    }
    if prob > 0.0 {
      log_sum = log_sum + ta_ln(prob)
    } else {
      log_sum = log_sum + ta_ln(0.0000001)
    }
  }
  let avg = log_sum / len.to_double()
  ta_exp(-avg)
}

// ============================================================
// 情感分析 / Sentiment analysis
// ============================================================

/// 正面情感分数 / Positive sentiment score.
pub fn sentiment_positive(text : String) -> Double {
  let words = tokenize(text.to_lower())
  let pos = ta_pos_words()
  let n = words.length()
  if n == 0 {
    return 0.0
  }
  let mut count = 0
  for i in 0..<n {
    if ta_contains(pos, words[i]) {
      count = count + 1
    }
  }
  count.to_double() / n.to_double()
}

/// 负面情感分数 / Negative sentiment score.
pub fn sentiment_negative(text : String) -> Double {
  let words = tokenize(text.to_lower())
  let neg = ta_neg_words()
  let n = words.length()
  if n == 0 {
    return 0.0
  }
  let mut count = 0
  for i in 0..<n {
    if ta_contains(neg, words[i]) {
      count = count + 1
    }
  }
  count.to_double() / n.to_double()
}

/// 中性情感分数 / Neutral sentiment score.
pub fn sentiment_neutral(text : String) -> Double {
  let pos = sentiment_positive(text)
  let neg = sentiment_negative(text)
  1.0 - pos - neg
}

// ============================================================
// 信息抽取 / Information extraction
// ============================================================

/// 关键词抽取 / Extract top-k keywords by TF.
pub fn extract_keywords(text : String, k : Int) -> Array[String] {
  let words = tokenize(text.to_lower())
  let stops = ta_stop_words()
  let candidates : Array[String] = []
  for i in 0..<words.length() {
    if !ta_contains(stops, words[i]) && !ta_contains(candidates, words[i]) {
      candidates.push(words[i])
    }
  }
  let counts : Array[(String, Int)] = []
  for i in 0..<candidates.length() {
    let mut cnt = 0
    for j in 0..<words.length() {
      if words[j] == candidates[i] {
        cnt = cnt + 1
      }
    }
    counts.push((candidates[i], cnt))
  }
  let sorted : Array[(String, Int)] = []
  for i in 0..<counts.length() {
    sorted.push(counts[i])
  }
  sorted.sort_by(fn(a, b) {
    if a.1 > b.1 {
      -1
    } else if a.1 < b.1 {
      1
    } else {
      0
    }
  })
  let result : Array[String] = []
  let limit = if k < sorted.length() { k } else { sorted.length() }
  for i in 0..<limit {
    result.push(sorted[i].0)
  }
  result
}

/// 实体抽取 / Extract named entities (capitalized words).
pub fn extract_entities(text : String) -> Array[String] {
  let words = split_words(text)
  let result : Array[String] = []
  for i in 0..<words.length() {
    let w = words[i]
    if w.length() > 0 {
      let chars = w.to_array()
      let c = chars[0]
      if c >= 'A' && c <= 'Z' {
        if !ta_contains(result, w) {
          result.push(w)
        }
      }
    }
  }
  result
}

/// 日期抽取 / Extract date-like patterns.
pub fn extract_dates(text : String) -> Array[String] {
  let chars = text.to_array()
  let result : Array[String] = []
  let mut i = 0
  while i < chars.length() {
    if ta_is_digit(chars[i]) {
      let mut j = i
      let mut has_sep = false
      while j < chars.length() && (ta_is_digit(chars[j]) || chars[j] == '/' || chars[j] == '-') {
        if chars[j] == '/' || chars[j] == '-' {
          has_sep = true
        }
        j = j + 1
      }
      if has_sep && j - i >= 5 {
        result.push(String::from_array(chars[i:j]))
      }
      i = j
    } else {
      i = i + 1
    }
  }
  result
}

// ============================================================
// 主题模型 / Topic model
// ============================================================

/// 构建主题模型 / Make simple topic model.
pub fn make_topic_model(corpus : Array[String], k : Int) -> TopicModel {
  let vocab : Array[String] = []
  for i in 0..<corpus.length() {
    let words = tokenize(corpus[i].to_lower())
    for j in 0..<words.length() {
      if !ta_contains(vocab, words[j]) {
        vocab.push(words[j])
      }
    }
  }
  let distributions : Array[Array[Double]] = []
  for i in 0..<vocab.length() {
    let dist : Array[Double] = []
    for t in 0..<k {
      let mut hash = 0.0
      let chars = vocab[i].to_array()
      for c in 0..<chars.length() {
        hash = hash + chars[c].to_int().to_double() * ta_pow(2.0, ((c + 1) % 7).to_double())
      }
      let val = ta_abs(ta_ln(1.0 + ta_abs(hash + t.to_double() * 3.7))) / 10.0
      dist.push(val)
    }
    let mut sum = 0.0
    for t in 0..<k {
      sum = sum + dist[t]
    }
    if sum > 0.0 {
      for t in 0..<k {
        dist[t] = dist[t] / sum
      }
    }
    distributions.push(dist)
  }
  { k, words: vocab, distributions }
}

/// 主题分布 / Topic distribution for a document.
pub fn topic_distribution(model : TopicModel, doc : String) -> Array[Double] {
  let words = tokenize(doc.to_lower())
  let result : Array[Double] = []
  for t in 0..<model.k {
    result.push(0.0)
  }
  let mut total = 0.0
  for i in 0..<words.length() {
    let mut idx = -1
    for j in 0..<model.words.length() {
      if model.words[j] == words[i] {
        idx = j
        break
      }
    }
    if idx >= 0 {
      for t in 0..<model.k {
        result[t] = result[t] + model.distributions[idx][t]
      }
      total = total + 1.0
    }
  }
  if total > 0.0 {
    for t in 0..<model.k {
      result[t] = result[t] / total
    }
  }
  result
}

/// 主题一致性 / Topic coherence (simplified).
pub fn topic_coherence(model : TopicModel) -> Double {
  let mut coherence = 0.0
  for t in 0..<model.k {
    let mut sum = 0.0
    let mut count = 0
    for i in 0..<model.words.length() {
      if model.distributions[i][t] > 0.01 {
        sum = sum + model.distributions[i][t]
        count = count + 1
      }
    }
    if count > 0 {
      coherence = coherence + sum / count.to_double()
    }
  }
  if model.k == 0 {
    return 0.0
  }
  coherence / model.k.to_double()
}

// ============================================================
// 分类 / Classification
// ============================================================

/// 文本分类 / Classify text into categories (keyword matching).
pub fn text_classify(text : String, categories : Array[String]) -> String {
  if categories.length() == 0 {
    return ""
  }
  let words = tokenize(text.to_lower())
  let mut best_cat = categories[0]
  let mut best_score = 0
  for i in 0..<categories.length() {
    let cat_words = tokenize(categories[i].to_lower())
    let mut score = 0
    for j in 0..<words.length() {
      for kk in 0..<cat_words.length() {
        if words[j] == cat_words[kk] {
          score = score + 1
        }
      }
    }
    if score > best_score {
      best_score = score
      best_cat = categories[i]
    }
  }
  best_cat
}

/// 语言检测 / Detect language (simplified).
pub fn language_detect(text : String) -> String {
  let en_words = ["the", "and", "is", "are", "was", "were", "have", "has"]
  let zh_chars = ['的', '是', '在', '了', '有', '和', '不']
  let chars = text.to_array()
  let mut en_count = 0
  let mut zh_count = 0
  let words = tokenize(text.to_lower())
  for i in 0..<words.length() {
    for j in 0..<en_words.length() {
      if words[i] == en_words[j] {
        en_count = en_count + 1
      }
    }
  }
  for i in 0..<chars.length() {
    for j in 0..<zh_chars.length() {
      if chars[i] == zh_chars[j] {
        zh_count = zh_count + 1
      }
    }
  }
  if zh_count > en_count {
    "chinese"
  } else if en_count > 0 {
    "english"
  } else {
    "unknown"
  }
}

/// 拼写纠正 / Spelling correction (edit distance based).
pub fn spelling_correct(word : String) -> String {
  let dictionary = ["the", "and", "is", "are", "was", "were", "have", "has", "had", "will", "would", "could", "should", "good", "great", "best", "make", "made", "time", "like", "just", "know", "take", "come", "year", "give", "think", "look", "want", "need", "use", "find", "tell", "work", "call", "try", "ask", "help", "play", "move", "live", "believe", "bring", "happen", "write", "provide", "sit", "stand", "lose", "pay", "meet", "include", "continue", "set", "learn", "change", "lead", "understand", "watch", "follow", "stop", "create", "speak", "read", "allow", "add", "spend", "grow", "open", "walk", "win", "offer", "remember", "love", "consider", "appear", "buy", "wait", "serve", "die", "send", "expect", "build", "stay", "fall", "cut", "reach", "kill", "remain"]
  if ta_contains(dictionary, word.to_lower()) {
    return word
  }
  let mut best = word
  let mut best_dist = 100
  for i in 0..<dictionary.length() {
    let d = levenshtein_distance(word.to_lower(), dictionary[i])
    if d < best_dist {
      best_dist = d
      best = dictionary[i]
    }
  }
  if best_dist <= 2 {
    best
  } else {
    word
  }
}

// ============================================================
// 词嵌入 / Word embedding
// ============================================================

/// 简单词嵌入 / Simple word embedding (hash-based).
pub fn word_embedding_simple(word : String) -> Array[Double] {
  let result : Array[Double] = []
  let chars = word.to_lower().to_array()
  let dim = 16
  for d in 0..<dim {
    let mut v = 0.0
    for i in 0..<chars.length() {
      let shift = (i + d) % dim
      v = v + chars[i].to_int().to_double() * ta_pow(2.0, shift.to_double() / 4.0)
    }
    result.push(ta_ln(1.0 + ta_abs(v)) / 10.0)
  }
  result
}

/// 类比推理 / Analogy (a:b :: c:?) simplified.
pub fn analogy_simple(a : String, b : String, c : String) -> String {
  let ea = word_embedding_simple(a)
  let eb = word_embedding_simple(b)
  let ec = word_embedding_simple(c)
  let target : Array[Double] = []
  let dim = ea.length()
  for i in 0..<dim {
    target.push(eb[i] - ea[i] + ec[i])
  }
  let dictionary = ["king", "queen", "man", "woman", "boy", "girl", "father", "mother", "son", "daughter", "brother", "sister", "uncle", "aunt", "nephew", "niece"]
  let mut best = c
  let mut best_sim = -1.0
  for i in 0..<dictionary.length() {
    let ed = word_embedding_simple(dictionary[i])
    let sim = similarity_embedding(target, ed)
    if sim > best_sim {
      best_sim = sim
      best = dictionary[i]
    }
  }
  best
}

/// 嵌入相似度 / Cosine similarity between embeddings.
pub fn similarity_embedding(e1 : Array[Double], e2 : Array[Double]) -> Double {
  let n = e1.length()
  if n == 0 || e2.length() != n {
    return 0.0
  }
  let mut dot = 0.0
  let mut n1 = 0.0
  let mut n2 = 0.0
  for i in 0..<n {
    dot = dot + e1[i] * e2[i]
    n1 = n1 + e1[i] * e1[i]
    n2 = n2 + e2[i] * e2[i]
  }
  if n1 == 0.0 || n2 == 0.0 {
    return 0.0
  }
  dot / (ta_sqrt(n1) * ta_sqrt(n2))
}

// ============================================================
// 语料库 / Corpus
// ============================================================

/// 构建语料库 / Make corpus from documents.
pub fn make_corpus(docs : Array[String]) -> Corpus {
  let tokenized : Array[Array[String]] = []
  let vocab : Array[String] = []
  for i in 0..<docs.length() {
    let words = tokenize(docs[i].to_lower())
    tokenized.push(words)
    for j in 0..<words.length() {
      if !ta_contains(vocab, words[j]) {
        vocab.push(words[j])
      }
    }
  }
  { docs: tokenized, vocabulary: vocab }
}

/// 语料库统计 / Corpus statistics.
pub fn corpus_stats(corpus : Corpus) -> CorpusStats {
  let doc_count = corpus.docs.length()
  let mut total_words = 0
  for i in 0..<doc_count {
    total_words = total_words + corpus.docs[i].length()
  }
  let avg = if doc_count == 0 {
    0.0
  } else {
    total_words.to_double() / doc_count.to_double()
  }
  { doc_count, total_words, avg_doc_length: avg, vocab_size: corpus.vocabulary.length() }
}

/// 词汇表大小 / Vocabulary size.
pub fn vocabulary_size(corpus : Corpus) -> Int {
  corpus.vocabulary.length()
}

// ============================================================
// 可读性 / Readability
// ============================================================

/// 可读性分数 / Flesch reading ease score.
pub fn readibility_score(text : String) -> Double {
  let words = split_words(text)
  let sentences = split_sentences(text)
  let wc = words.length()
  let sc = sentences.length()
  if wc == 0 || sc == 0 {
    return 0.0
  }
  let mut syllable_count = 0
  for i in 0..<wc {
    syllable_count = syllable_count + ta_count_syllables(words[i])
  }
  206.835 - 1.015 * wc.to_double() / sc.to_double() - 84.6 * syllable_count.to_double() / wc.to_double()
}

/// 词汇多样性 / Lexical diversity (unique/total).
pub fn lexical_diversity(text : String) -> Double {
  let words = tokenize(text)
  let n = words.length()
  if n == 0 {
    return 0.0
  }
  let unique : Array[String] = []
  for i in 0..<n {
    if !ta_contains(unique, words[i]) {
      unique.push(words[i])
    }
  }
  unique.length().to_double() / n.to_double()
}

/// 只出现一次的词数 / Hapax legomena count.
pub fn hapax_legomena(corpus : Corpus) -> Int {
  let mut count = 0
  for i in 0..<corpus.vocabulary.length() {
    let word = corpus.vocabulary[i]
    let mut freq = 0
    for j in 0..<corpus.docs.length() {
      for kk in 0..<corpus.docs[j].length() {
        if corpus.docs[j][kk] == word {
          freq = freq + 1
        }
      }
    }
    if freq == 1 {
      count = count + 1
    }
  }
  count
}

// ============================================================
// 额外统计函数 / Additional statistics
// ============================================================

/// 字符频率 / Character frequency.
pub fn char_frequency(text : String) -> Array[(Char, Int)] {
  let chars = text.to_array()
  let result : Array[(Char, Int)] = []
  for i in 0..<chars.length() {
    let c = chars[i]
    let mut found = false
    for j in 0..<result.length() {
      if result[j].0 == c {
        let cnt = result[j].1
        result[j] = (c, cnt + 1)
        found = true
        break
      }
    }
    if !found {
      result.push((c, 1))
    }
  }
  result
}

/// 词频率 / Word frequency.
pub fn word_frequency(text : String) -> Array[(String, Int)] {
  let words = tokenize(text.to_lower())
  let result : Array[(String, Int)] = []
  for i in 0..<words.length() {
    let w = words[i]
    let mut found = false
    for j in 0..<result.length() {
      if result[j].0 == w {
        let cnt = result[j].1
        result[j] = (w, cnt + 1)
        found = true
        break
      }
    }
    if !found {
      result.push((w, 1))
    }
  }
  result
}

/// 最长词 / Longest word.
pub fn longest_word(text : String) -> String {
  let words = split_words(text)
  if words.length() == 0 {
    return ""
  }
  let mut best = words[0]
  for i in 1..<words.length() {
    if words[i].length() > best.length() {
      best = words[i]
    }
  }
  best
}

/// 最短词 / Shortest word.
pub fn shortest_word(text : String) -> String {
  let words = split_words(text)
  if words.length() == 0 {
    return ""
  }
  let mut best = words[0]
  for i in 1..<words.length() {
    if words[i].length() < best.length() {
      best = words[i]
    }
  }
  best
}

/// 唯一词 / Unique words.
pub fn unique_words(text : String) -> Array[String] {
  let words = tokenize(text)
  let result : Array[String] = []
  for i in 0..<words.length() {
    if !ta_contains(result, words[i]) {
      result.push(words[i])
    }
  }
  result
}

/// N-gram 计数 / N-gram count.
pub fn ngram_count(words : Array[String], n : Int) -> Int {
  ngrams(words, n).length()
}

/// 文本相似度 / Text similarity (combined metric).
pub fn text_similarity(s1 : String, s2 : String) -> Double {
  let jaro = jaro_winkler(s1, s2)
  let jaccard = jaccard_similarity(s1, s2)
  let cosine = cosine_text_similarity(s1, s2)
  (jaro + jaccard + cosine) / 3.0
}

// ============================================================
// ID
// ============================================================

/// 模块标识 / Module identifier.
pub fn text_analytics_id() -> String {
  "opcore/text_analytics"
}
