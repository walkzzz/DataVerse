///===
/// extcore/crypto_hash_ripemd

pub(all) struct CryptohashripemdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_ripemd_make_point(x : Double, y : Double) -> CryptohashripemdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_ripemd_make_point3(x : Double, y : Double, z : Double) -> CryptohashripemdPoint {
  { x, y, z, label: 0 }
}

pub fn CryptohashripemdPoint::x(self : CryptohashripemdPoint) -> Double { self.x }

pub fn CryptohashripemdPoint::y(self : CryptohashripemdPoint) -> Double { self.y }

pub fn CryptohashripemdPoint::z(self : CryptohashripemdPoint) -> Double { self.z }

pub fn CryptohashripemdPoint::label(self : CryptohashripemdPoint) -> Int { self.label }

pub fn CryptohashripemdPoint::dist(self : CryptohashripemdPoint, other : CryptohashripemdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptohashripemdPoint::add(self : CryptohashripemdPoint, other : CryptohashripemdPoint) -> CryptohashripemdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptohashripemdPoint::sub(self : CryptohashripemdPoint, other : CryptohashripemdPoint) -> CryptohashripemdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptohashripemdPoint::scale(self : CryptohashripemdPoint, s : Double) -> CryptohashripemdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptohashripemdPoint::dot(self : CryptohashripemdPoint, other : CryptohashripemdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptohashripemdPoint::cross(self : CryptohashripemdPoint, other : CryptohashripemdPoint) -> CryptohashripemdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptohashripemdPoint::norm(self : CryptohashripemdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptohashripemdPoint::normalize(self : CryptohashripemdPoint) -> CryptohashripemdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptohashripemdPoint::negate(self : CryptohashripemdPoint) -> CryptohashripemdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptohashripemdPoint::mid(self : CryptohashripemdPoint, other : CryptohashripemdPoint) -> CryptohashripemdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptohashripemdPoint::lerp(self : CryptohashripemdPoint, other : CryptohashripemdPoint, t : Double) -> CryptohashripemdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptohashripemdPoint::to_string(self : CryptohashripemdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptohashripemdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_ripemd_make_series(vals : Array[Double], name : String) -> CryptohashripemdSeries {
  { vals, name, meta: 0 }
}

pub fn CryptohashripemdSeries::len(self : CryptohashripemdSeries) -> Int { self.vals.length() }

pub fn CryptohashripemdSeries::sum(self : CryptohashripemdSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptohashripemdSeries::mean(self : CryptohashripemdSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptohashripemdSeries::min(self : CryptohashripemdSeries) -> Double { @_common.min(self.vals) }

pub fn CryptohashripemdSeries::max(self : CryptohashripemdSeries) -> Double { @_common.max(self.vals) }

pub fn CryptohashripemdSeries::range(self : CryptohashripemdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptohashripemdSeries::variance(self : CryptohashripemdSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptohashripemdSeries::std(self : CryptohashripemdSeries) -> Double { @_common.std(self.vals) }

pub fn CryptohashripemdSeries::median(self : CryptohashripemdSeries) -> Double { @_common.median(self.vals) }

pub fn CryptohashripemdSeries::scale(self : CryptohashripemdSeries, f : Double) -> CryptohashripemdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptohashripemdSeries::add(self : CryptohashripemdSeries, other : CryptohashripemdSeries) -> CryptohashripemdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptohashripemdSeries::sub(self : CryptohashripemdSeries, other : CryptohashripemdSeries) -> CryptohashripemdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptohashripemdSeries::normalize(self : CryptohashripemdSeries) -> CryptohashripemdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptohashripemdSeries::cumsum(self : CryptohashripemdSeries) -> CryptohashripemdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptohashripemdSeries::to_string(self : CryptohashripemdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptohashripemdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_ripemd_make_matrix(rows : Int, cols : Int, val : Double) -> CryptohashripemdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_ripemd_matrix_identity(n : Int) -> CryptohashripemdMatrix {
  let m = crypto_hash_ripemd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptohashripemdMatrix::get(self : CryptohashripemdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptohashripemdMatrix::transpose(self : CryptohashripemdMatrix) -> CryptohashripemdMatrix {
  let result = crypto_hash_ripemd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptohashripemdMatrix::add(self : CryptohashripemdMatrix, other : CryptohashripemdMatrix) -> CryptohashripemdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_ripemd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptohashripemdMatrix::scale(self : CryptohashripemdMatrix, s : Double) -> CryptohashripemdMatrix {
  let result = crypto_hash_ripemd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptohashripemdMatrix::multiply(self : CryptohashripemdMatrix, other : CryptohashripemdMatrix) -> CryptohashripemdMatrix {
  if self.cols != other.rows { return crypto_hash_ripemd_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_ripemd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptohashripemdMatrix::trace(self : CryptohashripemdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptohashripemdMatrix::det(self : CryptohashripemdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptohashripemdMatrix::norm(self : CryptohashripemdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptohashripemdMatrix::to_string(self : CryptohashripemdMatrix) -> String {
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

pub(all) struct CryptohashripemdVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_ripemd_make_vector(comps : Array[Double]) -> CryptohashripemdVector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_ripemd_vector_zero(dim : Int) -> CryptohashripemdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptohashripemdVector::add(self : CryptohashripemdVector, other : CryptohashripemdVector) -> CryptohashripemdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptohashripemdVector::sub(self : CryptohashripemdVector, other : CryptohashripemdVector) -> CryptohashripemdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptohashripemdVector::scale(self : CryptohashripemdVector, s : Double) -> CryptohashripemdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptohashripemdVector::dot(self : CryptohashripemdVector, other : CryptohashripemdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptohashripemdVector::norm(self : CryptohashripemdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptohashripemdVector::normalize(self : CryptohashripemdVector) -> CryptohashripemdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptohashripemdVector::dist(self : CryptohashripemdVector, other : CryptohashripemdVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptohashripemdVector::to_string(self : CryptohashripemdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_ripemd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_ripemd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_ripemd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_ripemd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_ripemd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_ripemd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_ripemd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_ripemd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_ripemd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_ripemd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_ripemd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_ripemd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_ripemd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_ripemd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_ripemd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_ripemd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_ripemd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_ripemd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_ripemd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_ripemd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_ripemd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_ripemd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_ripemd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_ripemd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_ripemd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_ripemd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_ripemd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_ripemd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_ripemd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptohashripemdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_frame_make(size : Int) -> CryptohashripemdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_frame_len(s : CryptohashripemdFrame) -> Int { s.size }

pub fn crypto_hash_ripemd_frame_get(s : CryptohashripemdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_frame_set(s : CryptohashripemdFrame, i : Int, v : Double) -> CryptohashripemdFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_frame_sum(s : CryptohashripemdFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_frame_mean(s : CryptohashripemdFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_frame_scale(s : CryptohashripemdFrame, f : Double) -> CryptohashripemdFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_frame_add(a : CryptohashripemdFrame, b : CryptohashripemdFrame) -> CryptohashripemdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_ripemd_frame_copy(s : CryptohashripemdFrame) -> CryptohashripemdFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_frame_fill(s : CryptohashripemdFrame, v : Double) -> CryptohashripemdFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_frame_min(s : CryptohashripemdFrame) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_frame_max(s : CryptohashripemdFrame) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_frame_to_string(s : CryptohashripemdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_table_make(size : Int) -> CryptohashripemdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_table_len(s : CryptohashripemdTable) -> Int { s.size }

pub fn crypto_hash_ripemd_table_get(s : CryptohashripemdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_table_set(s : CryptohashripemdTable, i : Int, v : Double) -> CryptohashripemdTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_table_sum(s : CryptohashripemdTable) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_table_mean(s : CryptohashripemdTable) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_table_scale(s : CryptohashripemdTable, f : Double) -> CryptohashripemdTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_table_add(a : CryptohashripemdTable, b : CryptohashripemdTable) -> CryptohashripemdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_ripemd_table_copy(s : CryptohashripemdTable) -> CryptohashripemdTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_table_fill(s : CryptohashripemdTable, v : Double) -> CryptohashripemdTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_table_min(s : CryptohashripemdTable) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_table_max(s : CryptohashripemdTable) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_table_to_string(s : CryptohashripemdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_graphn_make(size : Int) -> CryptohashripemdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_graphn_len(s : CryptohashripemdGraphN) -> Int { s.size }

pub fn crypto_hash_ripemd_graphn_get(s : CryptohashripemdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_graphn_set(s : CryptohashripemdGraphN, i : Int, v : Double) -> CryptohashripemdGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_graphn_sum(s : CryptohashripemdGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_graphn_mean(s : CryptohashripemdGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_graphn_scale(s : CryptohashripemdGraphN, f : Double) -> CryptohashripemdGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_graphn_add(a : CryptohashripemdGraphN, b : CryptohashripemdGraphN) -> CryptohashripemdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_ripemd_graphn_copy(s : CryptohashripemdGraphN) -> CryptohashripemdGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_graphn_fill(s : CryptohashripemdGraphN, v : Double) -> CryptohashripemdGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_graphn_min(s : CryptohashripemdGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_graphn_max(s : CryptohashripemdGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_graphn_to_string(s : CryptohashripemdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_node_make(size : Int) -> CryptohashripemdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_node_len(s : CryptohashripemdNode) -> Int { s.size }

pub fn crypto_hash_ripemd_node_get(s : CryptohashripemdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_node_set(s : CryptohashripemdNode, i : Int, v : Double) -> CryptohashripemdNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_node_sum(s : CryptohashripemdNode) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_node_mean(s : CryptohashripemdNode) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_node_scale(s : CryptohashripemdNode, f : Double) -> CryptohashripemdNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_node_add(a : CryptohashripemdNode, b : CryptohashripemdNode) -> CryptohashripemdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_ripemd_node_copy(s : CryptohashripemdNode) -> CryptohashripemdNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_node_fill(s : CryptohashripemdNode, v : Double) -> CryptohashripemdNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_node_min(s : CryptohashripemdNode) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_node_max(s : CryptohashripemdNode) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_node_to_string(s : CryptohashripemdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_edge_make(size : Int) -> CryptohashripemdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_edge_len(s : CryptohashripemdEdge) -> Int { s.size }

pub fn crypto_hash_ripemd_edge_get(s : CryptohashripemdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_edge_set(s : CryptohashripemdEdge, i : Int, v : Double) -> CryptohashripemdEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_edge_sum(s : CryptohashripemdEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_edge_mean(s : CryptohashripemdEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_edge_scale(s : CryptohashripemdEdge, f : Double) -> CryptohashripemdEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_edge_add(a : CryptohashripemdEdge, b : CryptohashripemdEdge) -> CryptohashripemdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_ripemd_edge_copy(s : CryptohashripemdEdge) -> CryptohashripemdEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_edge_fill(s : CryptohashripemdEdge, v : Double) -> CryptohashripemdEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_edge_min(s : CryptohashripemdEdge) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_edge_max(s : CryptohashripemdEdge) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_edge_to_string(s : CryptohashripemdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_path_make(size : Int) -> CryptohashripemdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_path_len(s : CryptohashripemdPath) -> Int { s.size }

pub fn crypto_hash_ripemd_path_get(s : CryptohashripemdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_path_set(s : CryptohashripemdPath, i : Int, v : Double) -> CryptohashripemdPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_path_sum(s : CryptohashripemdPath) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_path_mean(s : CryptohashripemdPath) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_path_scale(s : CryptohashripemdPath, f : Double) -> CryptohashripemdPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_path_add(a : CryptohashripemdPath, b : CryptohashripemdPath) -> CryptohashripemdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_ripemd_path_copy(s : CryptohashripemdPath) -> CryptohashripemdPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_path_fill(s : CryptohashripemdPath, v : Double) -> CryptohashripemdPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_path_min(s : CryptohashripemdPath) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_path_max(s : CryptohashripemdPath) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_path_to_string(s : CryptohashripemdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_cluster_make(size : Int) -> CryptohashripemdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_cluster_len(s : CryptohashripemdCluster) -> Int { s.size }

pub fn crypto_hash_ripemd_cluster_get(s : CryptohashripemdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_cluster_set(s : CryptohashripemdCluster, i : Int, v : Double) -> CryptohashripemdCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_cluster_sum(s : CryptohashripemdCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_cluster_mean(s : CryptohashripemdCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_cluster_scale(s : CryptohashripemdCluster, f : Double) -> CryptohashripemdCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_cluster_add(a : CryptohashripemdCluster, b : CryptohashripemdCluster) -> CryptohashripemdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_ripemd_cluster_copy(s : CryptohashripemdCluster) -> CryptohashripemdCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_cluster_fill(s : CryptohashripemdCluster, v : Double) -> CryptohashripemdCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_cluster_min(s : CryptohashripemdCluster) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_cluster_max(s : CryptohashripemdCluster) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_cluster_to_string(s : CryptohashripemdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_model_make(size : Int) -> CryptohashripemdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_model_len(s : CryptohashripemdModel) -> Int { s.size }

pub fn crypto_hash_ripemd_model_get(s : CryptohashripemdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_model_set(s : CryptohashripemdModel, i : Int, v : Double) -> CryptohashripemdModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_model_sum(s : CryptohashripemdModel) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_model_mean(s : CryptohashripemdModel) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_model_scale(s : CryptohashripemdModel, f : Double) -> CryptohashripemdModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_model_add(a : CryptohashripemdModel, b : CryptohashripemdModel) -> CryptohashripemdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_ripemd_model_copy(s : CryptohashripemdModel) -> CryptohashripemdModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_model_fill(s : CryptohashripemdModel, v : Double) -> CryptohashripemdModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_model_min(s : CryptohashripemdModel) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_model_max(s : CryptohashripemdModel) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_model_to_string(s : CryptohashripemdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_layer_make(size : Int) -> CryptohashripemdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_layer_len(s : CryptohashripemdLayer) -> Int { s.size }

pub fn crypto_hash_ripemd_layer_get(s : CryptohashripemdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_layer_set(s : CryptohashripemdLayer, i : Int, v : Double) -> CryptohashripemdLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_layer_sum(s : CryptohashripemdLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_layer_mean(s : CryptohashripemdLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_layer_scale(s : CryptohashripemdLayer, f : Double) -> CryptohashripemdLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_layer_add(a : CryptohashripemdLayer, b : CryptohashripemdLayer) -> CryptohashripemdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_ripemd_layer_copy(s : CryptohashripemdLayer) -> CryptohashripemdLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_layer_fill(s : CryptohashripemdLayer, v : Double) -> CryptohashripemdLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_layer_min(s : CryptohashripemdLayer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_layer_max(s : CryptohashripemdLayer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_layer_to_string(s : CryptohashripemdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_buffer_make(size : Int) -> CryptohashripemdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_buffer_len(s : CryptohashripemdBuffer) -> Int { s.size }

pub fn crypto_hash_ripemd_buffer_get(s : CryptohashripemdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_buffer_set(s : CryptohashripemdBuffer, i : Int, v : Double) -> CryptohashripemdBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_buffer_sum(s : CryptohashripemdBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_buffer_mean(s : CryptohashripemdBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_buffer_scale(s : CryptohashripemdBuffer, f : Double) -> CryptohashripemdBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_buffer_add(a : CryptohashripemdBuffer, b : CryptohashripemdBuffer) -> CryptohashripemdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_ripemd_buffer_copy(s : CryptohashripemdBuffer) -> CryptohashripemdBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_buffer_fill(s : CryptohashripemdBuffer, v : Double) -> CryptohashripemdBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_buffer_min(s : CryptohashripemdBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_buffer_max(s : CryptohashripemdBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_buffer_to_string(s : CryptohashripemdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_cursor_make(size : Int) -> CryptohashripemdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_cursor_len(s : CryptohashripemdCursor) -> Int { s.size }

pub fn crypto_hash_ripemd_cursor_get(s : CryptohashripemdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_cursor_set(s : CryptohashripemdCursor, i : Int, v : Double) -> CryptohashripemdCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_cursor_sum(s : CryptohashripemdCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_cursor_mean(s : CryptohashripemdCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_cursor_scale(s : CryptohashripemdCursor, f : Double) -> CryptohashripemdCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_cursor_add(a : CryptohashripemdCursor, b : CryptohashripemdCursor) -> CryptohashripemdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_ripemd_cursor_copy(s : CryptohashripemdCursor) -> CryptohashripemdCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_cursor_fill(s : CryptohashripemdCursor, v : Double) -> CryptohashripemdCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_cursor_min(s : CryptohashripemdCursor) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_cursor_max(s : CryptohashripemdCursor) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_cursor_to_string(s : CryptohashripemdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_view_make(size : Int) -> CryptohashripemdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_view_len(s : CryptohashripemdView) -> Int { s.size }

pub fn crypto_hash_ripemd_view_get(s : CryptohashripemdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_view_set(s : CryptohashripemdView, i : Int, v : Double) -> CryptohashripemdView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_view_sum(s : CryptohashripemdView) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_view_mean(s : CryptohashripemdView) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_view_scale(s : CryptohashripemdView, f : Double) -> CryptohashripemdView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_view_add(a : CryptohashripemdView, b : CryptohashripemdView) -> CryptohashripemdView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_ripemd_view_copy(s : CryptohashripemdView) -> CryptohashripemdView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_view_fill(s : CryptohashripemdView, v : Double) -> CryptohashripemdView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_view_min(s : CryptohashripemdView) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_view_max(s : CryptohashripemdView) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_view_to_string(s : CryptohashripemdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_range_make(size : Int) -> CryptohashripemdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_range_len(s : CryptohashripemdRange) -> Int { s.size }

pub fn crypto_hash_ripemd_range_get(s : CryptohashripemdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_range_set(s : CryptohashripemdRange, i : Int, v : Double) -> CryptohashripemdRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_range_sum(s : CryptohashripemdRange) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_range_mean(s : CryptohashripemdRange) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_range_scale(s : CryptohashripemdRange, f : Double) -> CryptohashripemdRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_range_add(a : CryptohashripemdRange, b : CryptohashripemdRange) -> CryptohashripemdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_ripemd_range_copy(s : CryptohashripemdRange) -> CryptohashripemdRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_range_fill(s : CryptohashripemdRange, v : Double) -> CryptohashripemdRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_range_min(s : CryptohashripemdRange) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_range_max(s : CryptohashripemdRange) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_range_to_string(s : CryptohashripemdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashripemdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_ripemd_slice_make(size : Int) -> CryptohashripemdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_ripemd_slice_len(s : CryptohashripemdSlice) -> Int { s.size }

pub fn crypto_hash_ripemd_slice_get(s : CryptohashripemdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_ripemd_slice_set(s : CryptohashripemdSlice, i : Int, v : Double) -> CryptohashripemdSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_slice_sum(s : CryptohashripemdSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_ripemd_slice_mean(s : CryptohashripemdSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_ripemd_slice_scale(s : CryptohashripemdSlice, f : Double) -> CryptohashripemdSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_slice_add(a : CryptohashripemdSlice, b : CryptohashripemdSlice) -> CryptohashripemdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_ripemd_slice_copy(s : CryptohashripemdSlice) -> CryptohashripemdSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_slice_fill(s : CryptohashripemdSlice, v : Double) -> CryptohashripemdSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_ripemd_slice_min(s : CryptohashripemdSlice) -> Double { @_common.min(s.data) }

pub fn crypto_hash_ripemd_slice_max(s : CryptohashripemdSlice) -> Double { @_common.max(s.data) }

pub fn crypto_hash_ripemd_slice_to_string(s : CryptohashripemdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

