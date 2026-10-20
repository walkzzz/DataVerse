///===
/// extcore/crypto_sym_chacha

pub(all) struct CryptosymchachaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_chacha_make_point(x : Double, y : Double) -> CryptosymchachaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_chacha_make_point3(x : Double, y : Double, z : Double) -> CryptosymchachaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosymchachaPoint::x(self : CryptosymchachaPoint) -> Double { self.x }

pub fn CryptosymchachaPoint::y(self : CryptosymchachaPoint) -> Double { self.y }

pub fn CryptosymchachaPoint::z(self : CryptosymchachaPoint) -> Double { self.z }

pub fn CryptosymchachaPoint::label(self : CryptosymchachaPoint) -> Int { self.label }

pub fn CryptosymchachaPoint::dist(self : CryptosymchachaPoint, other : CryptosymchachaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosymchachaPoint::add(self : CryptosymchachaPoint, other : CryptosymchachaPoint) -> CryptosymchachaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosymchachaPoint::sub(self : CryptosymchachaPoint, other : CryptosymchachaPoint) -> CryptosymchachaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosymchachaPoint::scale(self : CryptosymchachaPoint, s : Double) -> CryptosymchachaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosymchachaPoint::dot(self : CryptosymchachaPoint, other : CryptosymchachaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosymchachaPoint::cross(self : CryptosymchachaPoint, other : CryptosymchachaPoint) -> CryptosymchachaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosymchachaPoint::norm(self : CryptosymchachaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosymchachaPoint::normalize(self : CryptosymchachaPoint) -> CryptosymchachaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymchachaPoint::negate(self : CryptosymchachaPoint) -> CryptosymchachaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosymchachaPoint::mid(self : CryptosymchachaPoint, other : CryptosymchachaPoint) -> CryptosymchachaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosymchachaPoint::lerp(self : CryptosymchachaPoint, other : CryptosymchachaPoint, t : Double) -> CryptosymchachaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosymchachaPoint::to_string(self : CryptosymchachaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosymchachaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_chacha_make_series(vals : Array[Double], name : String) -> CryptosymchachaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosymchachaSeries::len(self : CryptosymchachaSeries) -> Int { self.vals.length() }

pub fn CryptosymchachaSeries::sum(self : CryptosymchachaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosymchachaSeries::mean(self : CryptosymchachaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosymchachaSeries::min(self : CryptosymchachaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosymchachaSeries::max(self : CryptosymchachaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosymchachaSeries::range(self : CryptosymchachaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosymchachaSeries::variance(self : CryptosymchachaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosymchachaSeries::std(self : CryptosymchachaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosymchachaSeries::median(self : CryptosymchachaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosymchachaSeries::scale(self : CryptosymchachaSeries, f : Double) -> CryptosymchachaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosymchachaSeries::add(self : CryptosymchachaSeries, other : CryptosymchachaSeries) -> CryptosymchachaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosymchachaSeries::sub(self : CryptosymchachaSeries, other : CryptosymchachaSeries) -> CryptosymchachaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosymchachaSeries::normalize(self : CryptosymchachaSeries) -> CryptosymchachaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosymchachaSeries::cumsum(self : CryptosymchachaSeries) -> CryptosymchachaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosymchachaSeries::to_string(self : CryptosymchachaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymchachaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_chacha_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymchachaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_chacha_matrix_identity(n : Int) -> CryptosymchachaMatrix {
  let m = crypto_sym_chacha_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosymchachaMatrix::get(self : CryptosymchachaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosymchachaMatrix::transpose(self : CryptosymchachaMatrix) -> CryptosymchachaMatrix {
  let result = crypto_sym_chacha_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosymchachaMatrix::add(self : CryptosymchachaMatrix, other : CryptosymchachaMatrix) -> CryptosymchachaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_chacha_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosymchachaMatrix::scale(self : CryptosymchachaMatrix, s : Double) -> CryptosymchachaMatrix {
  let result = crypto_sym_chacha_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosymchachaMatrix::multiply(self : CryptosymchachaMatrix, other : CryptosymchachaMatrix) -> CryptosymchachaMatrix {
  if self.cols != other.rows { return crypto_sym_chacha_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_chacha_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosymchachaMatrix::trace(self : CryptosymchachaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosymchachaMatrix::det(self : CryptosymchachaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosymchachaMatrix::norm(self : CryptosymchachaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosymchachaMatrix::to_string(self : CryptosymchachaMatrix) -> String {
  let mut result = "Mat(" + self.rows.to_string() + "x" + self.cols.to_string() + ")\n"
  let rl = if self.rows < 5 { self.rows } else { 5 }
  let cl = if self.cols < 5 { self.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + @_common.dbl(self.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct CryptosymchachaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_chacha_make_vector(comps : Array[Double]) -> CryptosymchachaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_chacha_vector_zero(dim : Int) -> CryptosymchachaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosymchachaVector::add(self : CryptosymchachaVector, other : CryptosymchachaVector) -> CryptosymchachaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymchachaVector::sub(self : CryptosymchachaVector, other : CryptosymchachaVector) -> CryptosymchachaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymchachaVector::scale(self : CryptosymchachaVector, s : Double) -> CryptosymchachaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosymchachaVector::dot(self : CryptosymchachaVector, other : CryptosymchachaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosymchachaVector::norm(self : CryptosymchachaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosymchachaVector::normalize(self : CryptosymchachaVector) -> CryptosymchachaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymchachaVector::dist(self : CryptosymchachaVector, other : CryptosymchachaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosymchachaVector::to_string(self : CryptosymchachaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_chacha_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_chacha_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_chacha_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_chacha_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_chacha_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_chacha_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_chacha_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_chacha_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_chacha_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_chacha_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_chacha_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_chacha_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_chacha_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_chacha_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_chacha_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_chacha_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_chacha_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_chacha_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_chacha_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_chacha_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_chacha_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_chacha_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_chacha_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_chacha_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_chacha_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_chacha_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_chacha_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_chacha_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_chacha_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosymchachaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_frame_make(size : Int) -> CryptosymchachaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_frame_len(s : CryptosymchachaFrame) -> Int { s.size }

pub fn crypto_sym_chacha_frame_get(s : CryptosymchachaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_frame_set(s : CryptosymchachaFrame, i : Int, v : Double) -> CryptosymchachaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_frame_sum(s : CryptosymchachaFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_frame_mean(s : CryptosymchachaFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_frame_scale(s : CryptosymchachaFrame, f : Double) -> CryptosymchachaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_frame_add(a : CryptosymchachaFrame, b : CryptosymchachaFrame) -> CryptosymchachaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_frame_copy(s : CryptosymchachaFrame) -> CryptosymchachaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_frame_fill(s : CryptosymchachaFrame, v : Double) -> CryptosymchachaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_frame_min(s : CryptosymchachaFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_frame_max(s : CryptosymchachaFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_frame_to_string(s : CryptosymchachaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_table_make(size : Int) -> CryptosymchachaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_table_len(s : CryptosymchachaTable) -> Int { s.size }

pub fn crypto_sym_chacha_table_get(s : CryptosymchachaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_table_set(s : CryptosymchachaTable, i : Int, v : Double) -> CryptosymchachaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_table_sum(s : CryptosymchachaTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_table_mean(s : CryptosymchachaTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_table_scale(s : CryptosymchachaTable, f : Double) -> CryptosymchachaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_table_add(a : CryptosymchachaTable, b : CryptosymchachaTable) -> CryptosymchachaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_table_copy(s : CryptosymchachaTable) -> CryptosymchachaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_table_fill(s : CryptosymchachaTable, v : Double) -> CryptosymchachaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_table_min(s : CryptosymchachaTable) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_table_max(s : CryptosymchachaTable) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_table_to_string(s : CryptosymchachaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_graphn_make(size : Int) -> CryptosymchachaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_graphn_len(s : CryptosymchachaGraphN) -> Int { s.size }

pub fn crypto_sym_chacha_graphn_get(s : CryptosymchachaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_graphn_set(s : CryptosymchachaGraphN, i : Int, v : Double) -> CryptosymchachaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_graphn_sum(s : CryptosymchachaGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_graphn_mean(s : CryptosymchachaGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_graphn_scale(s : CryptosymchachaGraphN, f : Double) -> CryptosymchachaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_graphn_add(a : CryptosymchachaGraphN, b : CryptosymchachaGraphN) -> CryptosymchachaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_graphn_copy(s : CryptosymchachaGraphN) -> CryptosymchachaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_graphn_fill(s : CryptosymchachaGraphN, v : Double) -> CryptosymchachaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_graphn_min(s : CryptosymchachaGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_graphn_max(s : CryptosymchachaGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_graphn_to_string(s : CryptosymchachaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_node_make(size : Int) -> CryptosymchachaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_node_len(s : CryptosymchachaNode) -> Int { s.size }

pub fn crypto_sym_chacha_node_get(s : CryptosymchachaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_node_set(s : CryptosymchachaNode, i : Int, v : Double) -> CryptosymchachaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_node_sum(s : CryptosymchachaNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_node_mean(s : CryptosymchachaNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_node_scale(s : CryptosymchachaNode, f : Double) -> CryptosymchachaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_node_add(a : CryptosymchachaNode, b : CryptosymchachaNode) -> CryptosymchachaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_node_copy(s : CryptosymchachaNode) -> CryptosymchachaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_node_fill(s : CryptosymchachaNode, v : Double) -> CryptosymchachaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_node_min(s : CryptosymchachaNode) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_node_max(s : CryptosymchachaNode) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_node_to_string(s : CryptosymchachaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_edge_make(size : Int) -> CryptosymchachaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_edge_len(s : CryptosymchachaEdge) -> Int { s.size }

pub fn crypto_sym_chacha_edge_get(s : CryptosymchachaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_edge_set(s : CryptosymchachaEdge, i : Int, v : Double) -> CryptosymchachaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_edge_sum(s : CryptosymchachaEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_edge_mean(s : CryptosymchachaEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_edge_scale(s : CryptosymchachaEdge, f : Double) -> CryptosymchachaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_edge_add(a : CryptosymchachaEdge, b : CryptosymchachaEdge) -> CryptosymchachaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_edge_copy(s : CryptosymchachaEdge) -> CryptosymchachaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_edge_fill(s : CryptosymchachaEdge, v : Double) -> CryptosymchachaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_edge_min(s : CryptosymchachaEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_edge_max(s : CryptosymchachaEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_edge_to_string(s : CryptosymchachaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_path_make(size : Int) -> CryptosymchachaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_path_len(s : CryptosymchachaPath) -> Int { s.size }

pub fn crypto_sym_chacha_path_get(s : CryptosymchachaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_path_set(s : CryptosymchachaPath, i : Int, v : Double) -> CryptosymchachaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_path_sum(s : CryptosymchachaPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_path_mean(s : CryptosymchachaPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_path_scale(s : CryptosymchachaPath, f : Double) -> CryptosymchachaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_path_add(a : CryptosymchachaPath, b : CryptosymchachaPath) -> CryptosymchachaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_path_copy(s : CryptosymchachaPath) -> CryptosymchachaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_path_fill(s : CryptosymchachaPath, v : Double) -> CryptosymchachaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_path_min(s : CryptosymchachaPath) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_path_max(s : CryptosymchachaPath) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_path_to_string(s : CryptosymchachaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_cluster_make(size : Int) -> CryptosymchachaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_cluster_len(s : CryptosymchachaCluster) -> Int { s.size }

pub fn crypto_sym_chacha_cluster_get(s : CryptosymchachaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_cluster_set(s : CryptosymchachaCluster, i : Int, v : Double) -> CryptosymchachaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_cluster_sum(s : CryptosymchachaCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_cluster_mean(s : CryptosymchachaCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_cluster_scale(s : CryptosymchachaCluster, f : Double) -> CryptosymchachaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_cluster_add(a : CryptosymchachaCluster, b : CryptosymchachaCluster) -> CryptosymchachaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_cluster_copy(s : CryptosymchachaCluster) -> CryptosymchachaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_cluster_fill(s : CryptosymchachaCluster, v : Double) -> CryptosymchachaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_cluster_min(s : CryptosymchachaCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_cluster_max(s : CryptosymchachaCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_cluster_to_string(s : CryptosymchachaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_model_make(size : Int) -> CryptosymchachaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_model_len(s : CryptosymchachaModel) -> Int { s.size }

pub fn crypto_sym_chacha_model_get(s : CryptosymchachaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_model_set(s : CryptosymchachaModel, i : Int, v : Double) -> CryptosymchachaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_model_sum(s : CryptosymchachaModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_model_mean(s : CryptosymchachaModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_model_scale(s : CryptosymchachaModel, f : Double) -> CryptosymchachaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_model_add(a : CryptosymchachaModel, b : CryptosymchachaModel) -> CryptosymchachaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_model_copy(s : CryptosymchachaModel) -> CryptosymchachaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_model_fill(s : CryptosymchachaModel, v : Double) -> CryptosymchachaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_model_min(s : CryptosymchachaModel) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_model_max(s : CryptosymchachaModel) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_model_to_string(s : CryptosymchachaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_layer_make(size : Int) -> CryptosymchachaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_layer_len(s : CryptosymchachaLayer) -> Int { s.size }

pub fn crypto_sym_chacha_layer_get(s : CryptosymchachaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_layer_set(s : CryptosymchachaLayer, i : Int, v : Double) -> CryptosymchachaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_layer_sum(s : CryptosymchachaLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_layer_mean(s : CryptosymchachaLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_layer_scale(s : CryptosymchachaLayer, f : Double) -> CryptosymchachaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_layer_add(a : CryptosymchachaLayer, b : CryptosymchachaLayer) -> CryptosymchachaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_layer_copy(s : CryptosymchachaLayer) -> CryptosymchachaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_layer_fill(s : CryptosymchachaLayer, v : Double) -> CryptosymchachaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_layer_min(s : CryptosymchachaLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_layer_max(s : CryptosymchachaLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_layer_to_string(s : CryptosymchachaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_buffer_make(size : Int) -> CryptosymchachaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_buffer_len(s : CryptosymchachaBuffer) -> Int { s.size }

pub fn crypto_sym_chacha_buffer_get(s : CryptosymchachaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_buffer_set(s : CryptosymchachaBuffer, i : Int, v : Double) -> CryptosymchachaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_buffer_sum(s : CryptosymchachaBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_buffer_mean(s : CryptosymchachaBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_buffer_scale(s : CryptosymchachaBuffer, f : Double) -> CryptosymchachaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_buffer_add(a : CryptosymchachaBuffer, b : CryptosymchachaBuffer) -> CryptosymchachaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_buffer_copy(s : CryptosymchachaBuffer) -> CryptosymchachaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_buffer_fill(s : CryptosymchachaBuffer, v : Double) -> CryptosymchachaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_buffer_min(s : CryptosymchachaBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_buffer_max(s : CryptosymchachaBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_buffer_to_string(s : CryptosymchachaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_cursor_make(size : Int) -> CryptosymchachaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_cursor_len(s : CryptosymchachaCursor) -> Int { s.size }

pub fn crypto_sym_chacha_cursor_get(s : CryptosymchachaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_cursor_set(s : CryptosymchachaCursor, i : Int, v : Double) -> CryptosymchachaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_cursor_sum(s : CryptosymchachaCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_cursor_mean(s : CryptosymchachaCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_cursor_scale(s : CryptosymchachaCursor, f : Double) -> CryptosymchachaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_cursor_add(a : CryptosymchachaCursor, b : CryptosymchachaCursor) -> CryptosymchachaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_cursor_copy(s : CryptosymchachaCursor) -> CryptosymchachaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_cursor_fill(s : CryptosymchachaCursor, v : Double) -> CryptosymchachaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_cursor_min(s : CryptosymchachaCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_cursor_max(s : CryptosymchachaCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_cursor_to_string(s : CryptosymchachaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_view_make(size : Int) -> CryptosymchachaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_view_len(s : CryptosymchachaView) -> Int { s.size }

pub fn crypto_sym_chacha_view_get(s : CryptosymchachaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_view_set(s : CryptosymchachaView, i : Int, v : Double) -> CryptosymchachaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_view_sum(s : CryptosymchachaView) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_view_mean(s : CryptosymchachaView) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_view_scale(s : CryptosymchachaView, f : Double) -> CryptosymchachaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_view_add(a : CryptosymchachaView, b : CryptosymchachaView) -> CryptosymchachaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_view_copy(s : CryptosymchachaView) -> CryptosymchachaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_view_fill(s : CryptosymchachaView, v : Double) -> CryptosymchachaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_view_min(s : CryptosymchachaView) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_view_max(s : CryptosymchachaView) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_view_to_string(s : CryptosymchachaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_range_make(size : Int) -> CryptosymchachaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_range_len(s : CryptosymchachaRange) -> Int { s.size }

pub fn crypto_sym_chacha_range_get(s : CryptosymchachaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_range_set(s : CryptosymchachaRange, i : Int, v : Double) -> CryptosymchachaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_range_sum(s : CryptosymchachaRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_range_mean(s : CryptosymchachaRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_range_scale(s : CryptosymchachaRange, f : Double) -> CryptosymchachaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_range_add(a : CryptosymchachaRange, b : CryptosymchachaRange) -> CryptosymchachaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_range_copy(s : CryptosymchachaRange) -> CryptosymchachaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_range_fill(s : CryptosymchachaRange, v : Double) -> CryptosymchachaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_range_min(s : CryptosymchachaRange) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_range_max(s : CryptosymchachaRange) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_range_to_string(s : CryptosymchachaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymchachaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_chacha_slice_make(size : Int) -> CryptosymchachaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_chacha_slice_len(s : CryptosymchachaSlice) -> Int { s.size }

pub fn crypto_sym_chacha_slice_get(s : CryptosymchachaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_chacha_slice_set(s : CryptosymchachaSlice, i : Int, v : Double) -> CryptosymchachaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_slice_sum(s : CryptosymchachaSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_chacha_slice_mean(s : CryptosymchachaSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_chacha_slice_scale(s : CryptosymchachaSlice, f : Double) -> CryptosymchachaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_slice_add(a : CryptosymchachaSlice, b : CryptosymchachaSlice) -> CryptosymchachaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_chacha_slice_copy(s : CryptosymchachaSlice) -> CryptosymchachaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_slice_fill(s : CryptosymchachaSlice, v : Double) -> CryptosymchachaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_chacha_slice_min(s : CryptosymchachaSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sym_chacha_slice_max(s : CryptosymchachaSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sym_chacha_slice_to_string(s : CryptosymchachaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

