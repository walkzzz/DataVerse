///|
/// # opcore/encryption 加密算子 / Encryption Operators
///
/// 加密算法算子契约 + 简化实现。
/// XOR / Caesar / Vigenere / AES / DES / RSA / SHA256 / MD5 / CRC32 / Base64 / Hex。
///
/// # Encryption operators

// ============================================================
// 类型定义 / Type definitions
// ============================================================

///|
/// 哈希表条目 / Hash table entry.
pub struct HashEntry {
  key : String
  value : Int32
} derive(Debug, Eq)

///|
pub extend HashEntry with Eq::{equal, not_equal}

///|
pub extend HashEntry with Debug::{to_repr}

///|
/// 加密配置 / Crypto config.
pub struct CryptoConfig {
  algorithm : String
  key_size : Int32
  mode : String
  iv : Array[Int32]
} derive(Debug, Eq)

///|
pub extend CryptoConfig with Eq::{equal, not_equal}

///|
pub extend CryptoConfig with Debug::{to_repr}

///|
/// 密钥对 / Key pair.
pub struct KeyPair {
  public_key : Int32
  private_key : Int32
  modulus : Int32
} derive(Debug, Eq)

///|
pub extend KeyPair with Eq::{equal, not_equal}

///|
pub extend KeyPair with Debug::{to_repr}

///|
/// 数字签名 / Digital signature.
pub struct Signature {
  sign : Int32
  hash : Int32
} derive(Debug, Eq)

///|
pub extend Signature with Eq::{equal, not_equal}

///|
pub extend Signature with Debug::{to_repr}

///|
/// 文件元数据 / File metadata.
pub struct FileMeta {
  name : String
  size : Int32
  checksum : Int32
} derive(Debug, Eq)

///|
pub extend FileMeta with Eq::{equal, not_equal}

///|
pub extend FileMeta with Debug::{to_repr}

// ============================================================
// 辅助函数 / Helper functions
// ============================================================

///|
fn mod_pow(base : Int32, exp : Int32, m : Int32) -> Int32 {
  if m == 1 {
    return 0
  }
  let mut result = 1
  let mut b = base % m
  let mut e = exp
  while e > 0 {
    if e % 2 == 1 {
      result = result * b % m
    }
    e = e / 2
    b = b * b % m
  }
  result
}

///|
fn gcd_(a : Int32, b : Int32) -> Int32 {
  let mut x = a
  let mut y = b
  while y != 0 {
    let t = y
    y = x % y
    x = t
  }
  if x < 0 {
    -x
  } else {
    x
  }
}

///|
fn mod_inverse(a : Int32, m : Int32) -> Int32 {
  let mut old_r = a
  let mut r = m
  let mut old_s = 1
  let mut s = 0
  while r != 0 {
    let q = old_r / r
    let t = r
    r = old_r - q * r
    old_r = t
    let t2 = s
    s = old_s - q * s
    old_s = t2
  }
  (old_s % m + m) % m
}

// ============================================================
// XOR / Caesar / Vigenere / Atbash
// ============================================================

///|
/// XOR 加密 / XOR encrypt.
pub fn xor_encrypt(data : Array[Int32], key : Array[Int32]) -> Array[Int32] {
  let result : Array[Int32] = []
  let kl = key.length()
  if kl == 0 {
    return data
  }
  for i in 0..<data.length() {
    result.push(data[i] ^ key[i % kl])
  }
  result
}

///|
/// XOR 解密 / XOR decrypt.
pub fn xor_decrypt(data : Array[Int32], key : Array[Int32]) -> Array[Int32] {
  xor_encrypt(data, key)
}

///|
/// Caesar 加密 / Caesar encrypt.
pub fn caesar_encrypt(data : Array[Int32], shift : Int32) -> Array[Int32] {
  let result : Array[Int32] = []
  let s = (shift % 256 + 256) % 256
  for i in 0..<data.length() {
    result.push((data[i] + s) % 256)
  }
  result
}

///|
/// Caesar 解密 / Caesar decrypt.
pub fn caesar_decrypt(data : Array[Int32], shift : Int32) -> Array[Int32] {
  caesar_encrypt(data, -shift)
}

///|
/// Vigenere 加密 / Vigenere encrypt.
pub fn vigenere_encrypt(
  data : Array[Int32],
  key : Array[Int32],
) -> Array[Int32] {
  let result : Array[Int32] = []
  let kl = key.length()
  if kl == 0 {
    return data
  }
  for i in 0..<data.length() {
    let k = (key[i % kl] % 256 + 256) % 256
    result.push((data[i] + k) % 256)
  }
  result
}

///|
/// Vigenere 解密 / Vigenere decrypt.
pub fn vigenere_decrypt(
  data : Array[Int32],
  key : Array[Int32],
) -> Array[Int32] {
  let result : Array[Int32] = []
  let kl = key.length()
  if kl == 0 {
    return data
  }
  for i in 0..<data.length() {
    let k = (key[i % kl] % 256 + 256) % 256
    result.push(((data[i] - k) % 256 + 256) % 256)
  }
  result
}

///|
/// Atbash 加密 / Atbash encrypt.
pub fn atbash_encrypt(data : Array[Int32]) -> Array[Int32] {
  let result : Array[Int32] = []
  for i in 0..<data.length() {
    result.push(255 - data[i])
  }
  result
}

///|
/// Atbash 解密 / Atbash decrypt.
pub fn atbash_decrypt(data : Array[Int32]) -> Array[Int32] {
  atbash_encrypt(data)
}

// ============================================================
// AES / DES (simplified)
// ============================================================

///|
/// 创建 AES 密钥 / Make AES key (16 bytes).
pub fn make_aes_key(seed : Int32) -> Array[Int32] {
  let key : Array[Int32] = []
  let mut s = seed
  for _i in 0..<16 {
    s = (s * 1103515245 + 12345) & 0x7FFFFFFF
    key.push(s % 256)
  }
  key
}

///|
/// AES 简化加密 / AES simple encrypt (XOR-based simplified).
pub fn aes_encrypt_simple(
  data : Array[Int32],
  key : Array[Int32],
) -> Array[Int32] {
  let result : Array[Int32] = []
  let kl = key.length()
  if kl == 0 {
    return data
  }
  for i in 0..<data.length() {
    let k = key[i % kl]
    result.push((data[i] ^ k) + 17 % 256)
  }
  result
}

///|
/// AES 简化解密 / AES simple decrypt.
pub fn aes_decrypt_simple(
  data : Array[Int32],
  key : Array[Int32],
) -> Array[Int32] {
  let result : Array[Int32] = []
  let kl = key.length()
  if kl == 0 {
    return data
  }
  for i in 0..<data.length() {
    let k = key[i % kl]
    result.push((((data[i] - 17 % 256) % 256 + 256) % 256) ^ k)
  }
  result
}

///|
/// 创建 DES 密钥 / Make DES key (8 bytes).
pub fn make_des_key(seed : Int32) -> Array[Int32] {
  let key : Array[Int32] = []
  let mut s = seed
  for _i in 0..<8 {
    s = (s * 214013 + 2531011) & 0x7FFFFFFF
    key.push(s % 256)
  }
  key
}

///|
/// DES 简化加密 / DES simple encrypt.
pub fn des_encrypt_simple(
  data : Array[Int32],
  key : Array[Int32],
) -> Array[Int32] {
  let result : Array[Int32] = []
  let kl = key.length()
  if kl == 0 {
    return data
  }
  for i in 0..<data.length() {
    let k = key[i % kl]
    result.push((data[i] + k * 3 + 7) % 256)
  }
  result
}

///|
/// DES 简化解密 / DES simple decrypt.
pub fn des_decrypt_simple(
  data : Array[Int32],
  key : Array[Int32],
) -> Array[Int32] {
  let result : Array[Int32] = []
  let kl = key.length()
  if kl == 0 {
    return data
  }
  for i in 0..<data.length() {
    let k = key[i % kl]
    result.push(((data[i] - k * 3 - 7) % 256 + 256) % 256)
  }
  result
}

// ============================================================
// RSA (simplified)
// ============================================================

///|
/// RSA 简化密钥生成 / RSA simple keygen.
pub fn rsa_keygen_simple(p : Int32, q : Int32) -> KeyPair {
  let n = p * q
  let phi = (p - 1) * (q - 1)
  let mut e = 3
  while gcd_(e, phi) != 1 {
    e = e + 2
  }
  let d = mod_inverse(e, n)
  KeyPair::{ public_key: e, private_key: d, modulus: n, }
}

///|
/// RSA 简化加密 / RSA simple encrypt.
pub fn rsa_encrypt_simple(
  data : Array[Int32],
  public_key : Int32,
  modulus : Int32,
) -> Array[Int32] {
  let result : Array[Int32] = []
  for i in 0..<data.length() {
    result.push(mod_pow(data[i], public_key, modulus))
  }
  result
}

///|
/// RSA 简化解密 / RSA simple decrypt.
pub fn rsa_decrypt_simple(
  data : Array[Int32],
  private_key : Int32,
  modulus : Int32,
) -> Array[Int32] {
  let result : Array[Int32] = []
  for i in 0..<data.length() {
    result.push(mod_pow(data[i], private_key, modulus))
  }
  result
}

// ============================================================
// 哈希 / Hash functions
// ============================================================

///|
/// SHA256 简化 / SHA256 simple (simplified hash).
pub fn sha256_simple(data : Array[Int32]) -> Array[Int32] {
  let h : Array[Int32] = [
    0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a, 0x510e527f, 0x9b05688c, 0x1f83d9ab,
    0x5be0cd19,
  ]
  let k : Array[Int32] = [
    0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4,
    0xab1c5ed5,
  ]
  let state : Array[Int32] = []
  for i in 0..<8 {
    state.push(h[i])
  }
  for i in 0..<data.length() {
    let idx = i % 8
    state[idx] = (state[idx] + data[i] * k[i % 8]) & 0xFFFFFFFF
    state[(idx + 1) % 8] = (state[(idx + 1) % 8] ^ state[idx]) & 0xFFFFFFFF
  }
  state
}

///|
/// MD5 简化 / MD5 simple (simplified hash).
pub fn md5_simple(data : Array[Int32]) -> Array[Int32] {
  let mut a = 0x67452301
  let mut b = 0xefcdab89
  let mut c = 0x98badcfe
  let mut d = 0x10325476
  for i in 0..<data.length() {
    a = (a + data[i]) & 0xFFFFFFFF
    b = (b + a * 7) & 0xFFFFFFFF
    c = (c + b * 11) & 0xFFFFFFFF
    d = (d + c * 13) & 0xFFFFFFFF
    a = (a ^ d) & 0xFFFFFFFF
    b = (b ^ a) & 0xFFFFFFFF
    c = (c ^ b) & 0xFFFFFFFF
    d = (d ^ c) & 0xFFFFFFFF
  }
  [a, b, c, d]
}

///|
/// CRC32 / CRC32 checksum.
pub fn crc32(data : Array[Int32]) -> Int32 {
  let mut crc = 0xFFFFFFFF
  for i in 0..<data.length() {
    crc = crc ^ data[i]
    for _j in 0..<8 {
      if (crc & 1) == 1 {
        crc = (crc >> 1) ^ 0xEDB88320
      } else {
        crc = crc >> 1
      }
    }
  }
  crc ^ 0xFFFFFFFF
}

///|
/// 校验和 / Checksum (simple sum).
pub fn checksum(data : Array[Int32]) -> Int32 {
  let mut sum = 0
  for i in 0..<data.length() {
    sum = sum + data[i]
  }
  sum & 0xFFFF
}

// ============================================================
// 哈希表 / Hash table
// ============================================================

///|
/// 创建哈希表 / Make hash table.
pub fn make_hash_table() -> Array[HashEntry] {
  []
}

///|
/// 哈希查找 / Hash lookup (returns value or -1).
pub fn hash_lookup(table : Array[HashEntry], key : String) -> Int32 {
  for i in 0..<table.length() {
    if table[i].key == key {
      return table[i].value
    }
  }
  -1
}

///|
/// 哈希插入 / Hash insert.
pub fn hash_insert(
  table : Array[HashEntry],
  key : String,
  value : Int32,
) -> Array[HashEntry] {
  let new_table : Array[HashEntry] = []
  let mut found = false
  for i in 0..<table.length() {
    if table[i].key == key {
      new_table.push(HashEntry::{ key, value, })
      found = true
    } else {
      new_table.push(table[i])
    }
  }
  if !found {
    new_table.push(HashEntry::{ key, value, })
  }
  new_table
}

// ============================================================
// Base64 / Hex
// ============================================================

///|
/// Base64 编码 / Base64 encode.
pub fn base64_encode_enc(data : Array[Int32]) -> String {
  let base64_str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  let chars : Array[Char] = []
  for i in 0..<base64_str.length() {
    chars.push(Int32::unsafe_to_char(base64_str[i].to_int()))
  }
  let mut result = ""
  let n = data.length()
  let mut i = 0
  while i + 2 < n {
    let v = (data[i] << 16) | (data[i + 1] << 8) | data[i + 2]
    result = result + String::from_array([chars[(v >> 18) & 63]])
    result = result + String::from_array([chars[(v >> 12) & 63]])
    result = result + String::from_array([chars[(v >> 6) & 63]])
    result = result + String::from_array([chars[v & 63]])
    i = i + 3
  }
  if i < n {
    let v = data[i] << 16
    if i + 1 < n {
      ignore(v)
      let v2 = (data[i] << 16) | (data[i + 1] << 8)
      result = result + String::from_array([chars[(v2 >> 18) & 63]])
      result = result + String::from_array([chars[(v2 >> 12) & 63]])
      result = result + String::from_array([chars[(v2 >> 6) & 63]])
      result = result + "="
    } else {
      result = result + String::from_array([chars[(v >> 18) & 63]])
      result = result + String::from_array([chars[(v >> 12) & 63]])
      result = result + "=="
    }
  }
  result
}

///|
/// Base64 解码 / Base64 decode.
pub fn base64_decode_enc(s : String) -> Array[Int32] {
  let result : Array[Int32] = []
  let n = s.length()
  let mut i = 0
  while i + 3 < n + 1 {
    let mut v = 0
    let mut pad = 0
    for j in 0..<4 {
      if i + j < n {
        let c = s[i + j].to_int()
        if c == 61 {
          pad = pad + 1
          v = v << 6
        } else if c >= 65 && c <= 90 {
          v = (v << 6) | (c - 65)
        } else if c >= 97 && c <= 122 {
          v = (v << 6) | (c - 71)
        } else if c >= 48 && c <= 57 {
          v = (v << 6) | (c + 4)
        } else if c == 43 {
          v = (v << 6) | 62
        } else if c == 47 {
          v = (v << 6) | 63
        } else {
          v = v << 6
        }
      }
    }
    if pad < 2 {
      result.push((v >> 16) & 255)
    }
    if pad < 1 {
      result.push((v >> 8) & 255)
    }
    if pad == 0 {
      result.push(v & 255)
    }
    i = i + 4
    if i >= n {
      break
    }
  }
  result
}

///|
/// Hex 编码 / Hex encode.
pub fn hex_encode_enc(data : Array[Int32]) -> String {
  let hex_str = "0123456789abcdef"
  let hex_chars : Array[Char] = []
  for i in 0..<hex_str.length() {
    hex_chars.push(Int32::unsafe_to_char(hex_str[i].to_int()))
  }
  let mut result = ""
  for i in 0..<data.length() {
    let b = data[i] & 255
    result = result + String::from_array([hex_chars[(b >> 4) & 15]])
    result = result + String::from_array([hex_chars[b & 15]])
  }
  result
}

///|
/// Hex 解码 / Hex decode.
pub fn hex_decode_enc(s : String) -> Array[Int32] {
  let result : Array[Int32] = []
  let n = s.length()
  let mut i = 0
  while i + 1 < n + 1 {
    let mut hi = 0
    let mut lo = 0
    if i < n {
      let c = s[i].to_int()
      if c >= 48 && c <= 57 {
        hi = c - 48
      } else if c >= 97 && c <= 102 {
        hi = c - 87
      } else if c >= 65 && c <= 70 {
        hi = c - 55
      }
    }
    if i + 1 < n {
      let c = s[i + 1].to_int()
      if c >= 48 && c <= 57 {
        lo = c - 48
      } else if c >= 97 && c <= 102 {
        lo = c - 87
      } else if c >= 65 && c <= 70 {
        lo = c - 55
      }
    }
    result.push((hi << 4) | lo)
    i = i + 2
    if i >= n {
      break
    }
  }
  result
}

// ============================================================
// 盐 / Salt
// ============================================================

///|
/// 创建盐 / Make salt.
pub fn make_salt(seed : Int32) -> Array[Int32] {
  let salt : Array[Int32] = []
  let mut s = seed
  for _i in 0..<16 {
    s = (s * 1103515245 + 12345) & 0x7FFFFFFF
    salt.push(s % 256)
  }
  salt
}

///|
/// 盐哈希 / Salt hash.
pub fn salt_hash(data : Array[Int32], salt : Array[Int32]) -> Array[Int32] {
  let combined : Array[Int32] = []
  for i in 0..<salt.length() {
    combined.push(salt[i])
  }
  for i in 0..<data.length() {
    combined.push(data[i])
  }
  sha256_simple(combined)
}

///|
/// 验证哈希 / Verify hash.
pub fn verify_hash(
  data : Array[Int32],
  salt : Array[Int32],
  expected : Array[Int32],
) -> Bool {
  let h = salt_hash(data, salt)
  if h.length() != expected.length() {
    return false
  }
  for i in 0..<h.length() {
    if h[i] != expected[i] {
      return false
    }
  }
  true
}

///|
/// PBKDF2 简化 / PBKDF2 simple.
pub fn pbkdf2_simple(
  password : Array[Int32],
  salt : Array[Int32],
  iterations : Int32,
) -> Array[Int32] {
  let mut result = salt_hash(password, salt)
  for _i in 1..<iterations {
    result = salt_hash(result, salt)
  }
  result
}

// ============================================================
// 文件元数据 / File metadata
// ============================================================

///|
/// 加密文件元数据 / Encrypt file metadata.
pub fn encrypt_file_meta(meta : FileMeta, key : Array[Int32]) -> Array[Int32] {
  let data : Array[Int32] = []
  for i in 0..<meta.name.length() {
    data.push(meta.name[i].to_int())
  }
  data.push(0)
  data.push(meta.size)
  data.push(meta.checksum)
  xor_encrypt(data, key)
}

///|
/// 解密文件元数据 / Decrypt file metadata.
pub fn decrypt_file_meta(
  encrypted : Array[Int32],
  key : Array[Int32],
) -> FileMeta {
  let data = xor_decrypt(encrypted, key)
  let mut name = ""
  let mut i = 0
  while i < data.length() && data[i] != 0 {
    name = name + String::from_array([Int32::unsafe_to_char(data[i])])
    i = i + 1
  }
  i = i + 1
  let size = if i < data.length() { data[i] } else { 0 }
  let cs = if i + 1 < data.length() { data[i + 1] } else { 0 }
  FileMeta::{ name, size, checksum: cs, }
}

///|
/// 创建加密配置 / Make crypto config.
pub fn make_crypto_config(
  algorithm : String,
  key_size : Int32,
  mode : String,
) -> CryptoConfig {
  let iv : Array[Int32] = []
  let mut s = key_size
  for _i in 0..<16 {
    s = (s * 1103515245 + 12345) & 0x7FFFFFFF
    iv.push(s % 256)
  }
  CryptoConfig::{ algorithm, key_size, mode, iv, }
}

// ============================================================
// 数字签名 / Digital signature
// ============================================================

///|
/// 数字签名 / Digital sign simple.
pub fn digital_sign_simple(
  data : Array[Int32],
  private_key : Int32,
  modulus : Int32,
) -> Signature {
  let h = crc32(data)
  let sign = mod_pow(h, private_key, modulus)
  Signature::{ sign, hash: h, }
}

///|
/// 验证签名 / Verify sign simple.
pub fn verify_sign_simple(
  sig : Signature,
  public_key : Int32,
  modulus : Int32,
) -> Bool {
  mod_pow(sig.sign, public_key, modulus) == sig.hash
}

// ============================================================
// 密钥对 / Key pair operations
// ============================================================

///|
/// 创建密钥对 / Make key pair.
pub fn make_key_pair(
  public_key : Int32,
  private_key : Int32,
  modulus : Int32,
) -> KeyPair {
  KeyPair::{ public_key, private_key, modulus, }
}

///|
/// 公钥加密 / Public key encrypt.
pub fn public_key_encrypt(
  data : Array[Int32],
  key_pair : KeyPair,
) -> Array[Int32] {
  rsa_encrypt_simple(data, key_pair.public_key, key_pair.modulus)
}

///|
/// 私钥解密 / Private key decrypt.
pub fn private_key_decrypt(
  data : Array[Int32],
  key_pair : KeyPair,
) -> Array[Int32] {
  rsa_decrypt_simple(data, key_pair.private_key, key_pair.modulus)
}

// ============================================================
// ID
// ============================================================

///|
/// 加密算子 ID / Encryption operator ID.
pub fn encryption_id() -> String {
  "opcore/encryption"
}
