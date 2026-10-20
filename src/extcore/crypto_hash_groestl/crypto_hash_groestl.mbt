///===
/// extcore/crypto_hash_groestl

pub(all) struct CryptohashgroestlPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_hash_groestl_make_point(x : Double, y : Double) -> CryptohashgroestlPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_hash_groestl_make_point3(x : Double, y : Double, z : Double) -> CryptohashgroestlPoint {
  { x, y, z, label: 0 }
}

pub fn CryptohashgroestlPoint::x(self : CryptohashgroestlPoint) -> Double { self.x }

pub fn CryptohashgroestlPoint::y(self : CryptohashgroestlPoint) -> Double { self.y }

pub fn CryptohashgroestlPoint::z(self : CryptohashgroestlPoint) -> Double { self.z }

pub fn CryptohashgroestlPoint::label(self : CryptohashgroestlPoint) -> Int { self.label }

pub fn CryptohashgroestlPoint::dist(self : CryptohashgroestlPoint, other : CryptohashgroestlPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptohashgroestlPoint::add(self : CryptohashgroestlPoint, other : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptohashgroestlPoint::sub(self : CryptohashgroestlPoint, other : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptohashgroestlPoint::scale(self : CryptohashgroestlPoint, s : Double) -> CryptohashgroestlPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptohashgroestlPoint::dot(self : CryptohashgroestlPoint, other : CryptohashgroestlPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptohashgroestlPoint::cross(self : CryptohashgroestlPoint, other : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptohashgroestlPoint::norm(self : CryptohashgroestlPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptohashgroestlPoint::normalize(self : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptohashgroestlPoint::negate(self : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptohashgroestlPoint::mid(self : CryptohashgroestlPoint, other : CryptohashgroestlPoint) -> CryptohashgroestlPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptohashgroestlPoint::lerp(self : CryptohashgroestlPoint, other : CryptohashgroestlPoint, t : Double) -> CryptohashgroestlPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptohashgroestlPoint::to_string(self : CryptohashgroestlPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptohashgroestlSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_hash_groestl_make_series(vals : Array[Double], name : String) -> CryptohashgroestlSeries {
  { vals, name, meta: 0 }
}

pub fn CryptohashgroestlSeries::len(self : CryptohashgroestlSeries) -> Int { self.vals.length() }

pub fn CryptohashgroestlSeries::sum(self : CryptohashgroestlSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptohashgroestlSeries::mean(self : CryptohashgroestlSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptohashgroestlSeries::min(self : CryptohashgroestlSeries) -> Double { @_common.min(self.vals) }

pub fn CryptohashgroestlSeries::max(self : CryptohashgroestlSeries) -> Double { @_common.max(self.vals) }

pub fn CryptohashgroestlSeries::range(self : CryptohashgroestlSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptohashgroestlSeries::variance(self : CryptohashgroestlSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptohashgroestlSeries::std(self : CryptohashgroestlSeries) -> Double { @_common.std(self.vals) }

pub fn CryptohashgroestlSeries::median(self : CryptohashgroestlSeries) -> Double { @_common.median(self.vals) }

pub fn CryptohashgroestlSeries::scale(self : CryptohashgroestlSeries, f : Double) -> CryptohashgroestlSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptohashgroestlSeries::add(self : CryptohashgroestlSeries, other : CryptohashgroestlSeries) -> CryptohashgroestlSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptohashgroestlSeries::sub(self : CryptohashgroestlSeries, other : CryptohashgroestlSeries) -> CryptohashgroestlSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptohashgroestlSeries::normalize(self : CryptohashgroestlSeries) -> CryptohashgroestlSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptohashgroestlSeries::cumsum(self : CryptohashgroestlSeries) -> CryptohashgroestlSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptohashgroestlSeries::to_string(self : CryptohashgroestlSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptohashgroestlMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_hash_groestl_make_matrix(rows : Int, cols : Int, val : Double) -> CryptohashgroestlMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_hash_groestl_matrix_identity(n : Int) -> CryptohashgroestlMatrix {
  let m = crypto_hash_groestl_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptohashgroestlMatrix::get(self : CryptohashgroestlMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptohashgroestlMatrix::transpose(self : CryptohashgroestlMatrix) -> CryptohashgroestlMatrix {
  let result = crypto_hash_groestl_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptohashgroestlMatrix::add(self : CryptohashgroestlMatrix, other : CryptohashgroestlMatrix) -> CryptohashgroestlMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_hash_groestl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptohashgroestlMatrix::scale(self : CryptohashgroestlMatrix, s : Double) -> CryptohashgroestlMatrix {
  let result = crypto_hash_groestl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptohashgroestlMatrix::multiply(self : CryptohashgroestlMatrix, other : CryptohashgroestlMatrix) -> CryptohashgroestlMatrix {
  if self.cols != other.rows { return crypto_hash_groestl_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_hash_groestl_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptohashgroestlMatrix::trace(self : CryptohashgroestlMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptohashgroestlMatrix::det(self : CryptohashgroestlMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptohashgroestlMatrix::norm(self : CryptohashgroestlMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptohashgroestlMatrix::to_string(self : CryptohashgroestlMatrix) -> String {
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

pub(all) struct CryptohashgroestlVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_hash_groestl_make_vector(comps : Array[Double]) -> CryptohashgroestlVector {
  { comps, dim: comps.length() }
}

pub fn crypto_hash_groestl_vector_zero(dim : Int) -> CryptohashgroestlVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptohashgroestlVector::add(self : CryptohashgroestlVector, other : CryptohashgroestlVector) -> CryptohashgroestlVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptohashgroestlVector::sub(self : CryptohashgroestlVector, other : CryptohashgroestlVector) -> CryptohashgroestlVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptohashgroestlVector::scale(self : CryptohashgroestlVector, s : Double) -> CryptohashgroestlVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptohashgroestlVector::dot(self : CryptohashgroestlVector, other : CryptohashgroestlVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptohashgroestlVector::norm(self : CryptohashgroestlVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptohashgroestlVector::normalize(self : CryptohashgroestlVector) -> CryptohashgroestlVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptohashgroestlVector::dist(self : CryptohashgroestlVector, other : CryptohashgroestlVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptohashgroestlVector::to_string(self : CryptohashgroestlVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_hash_groestl_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_hash_groestl_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_hash_groestl_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_hash_groestl_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_hash_groestl_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_hash_groestl_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_hash_groestl_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_hash_groestl_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_hash_groestl_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_hash_groestl_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_hash_groestl_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_hash_groestl_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_hash_groestl_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_hash_groestl_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_hash_groestl_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_hash_groestl_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_hash_groestl_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_hash_groestl_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_hash_groestl_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_hash_groestl_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_hash_groestl_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_hash_groestl_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_hash_groestl_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_hash_groestl_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_hash_groestl_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_hash_groestl_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_hash_groestl_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_hash_groestl_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_hash_groestl_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptohashgroestlFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_frame_make(size : Int) -> CryptohashgroestlFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_frame_len(s : CryptohashgroestlFrame) -> Int { s.size }

pub fn crypto_hash_groestl_frame_get(s : CryptohashgroestlFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_frame_set(s : CryptohashgroestlFrame, i : Int, v : Double) -> CryptohashgroestlFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_frame_sum(s : CryptohashgroestlFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_frame_mean(s : CryptohashgroestlFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_frame_scale(s : CryptohashgroestlFrame, f : Double) -> CryptohashgroestlFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_frame_add(a : CryptohashgroestlFrame, b : CryptohashgroestlFrame) -> CryptohashgroestlFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_groestl_frame_copy(s : CryptohashgroestlFrame) -> CryptohashgroestlFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_frame_fill(s : CryptohashgroestlFrame, v : Double) -> CryptohashgroestlFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_frame_min(s : CryptohashgroestlFrame) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_frame_max(s : CryptohashgroestlFrame) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_frame_to_string(s : CryptohashgroestlFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_table_make(size : Int) -> CryptohashgroestlTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_table_len(s : CryptohashgroestlTable) -> Int { s.size }

pub fn crypto_hash_groestl_table_get(s : CryptohashgroestlTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_table_set(s : CryptohashgroestlTable, i : Int, v : Double) -> CryptohashgroestlTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_table_sum(s : CryptohashgroestlTable) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_table_mean(s : CryptohashgroestlTable) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_table_scale(s : CryptohashgroestlTable, f : Double) -> CryptohashgroestlTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_table_add(a : CryptohashgroestlTable, b : CryptohashgroestlTable) -> CryptohashgroestlTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_groestl_table_copy(s : CryptohashgroestlTable) -> CryptohashgroestlTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_table_fill(s : CryptohashgroestlTable, v : Double) -> CryptohashgroestlTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_table_min(s : CryptohashgroestlTable) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_table_max(s : CryptohashgroestlTable) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_table_to_string(s : CryptohashgroestlTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_graphn_make(size : Int) -> CryptohashgroestlGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_graphn_len(s : CryptohashgroestlGraphN) -> Int { s.size }

pub fn crypto_hash_groestl_graphn_get(s : CryptohashgroestlGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_graphn_set(s : CryptohashgroestlGraphN, i : Int, v : Double) -> CryptohashgroestlGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_graphn_sum(s : CryptohashgroestlGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_graphn_mean(s : CryptohashgroestlGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_graphn_scale(s : CryptohashgroestlGraphN, f : Double) -> CryptohashgroestlGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_graphn_add(a : CryptohashgroestlGraphN, b : CryptohashgroestlGraphN) -> CryptohashgroestlGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_groestl_graphn_copy(s : CryptohashgroestlGraphN) -> CryptohashgroestlGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_graphn_fill(s : CryptohashgroestlGraphN, v : Double) -> CryptohashgroestlGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_graphn_min(s : CryptohashgroestlGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_graphn_max(s : CryptohashgroestlGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_graphn_to_string(s : CryptohashgroestlGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_node_make(size : Int) -> CryptohashgroestlNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_node_len(s : CryptohashgroestlNode) -> Int { s.size }

pub fn crypto_hash_groestl_node_get(s : CryptohashgroestlNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_node_set(s : CryptohashgroestlNode, i : Int, v : Double) -> CryptohashgroestlNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_node_sum(s : CryptohashgroestlNode) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_node_mean(s : CryptohashgroestlNode) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_node_scale(s : CryptohashgroestlNode, f : Double) -> CryptohashgroestlNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_node_add(a : CryptohashgroestlNode, b : CryptohashgroestlNode) -> CryptohashgroestlNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_groestl_node_copy(s : CryptohashgroestlNode) -> CryptohashgroestlNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_node_fill(s : CryptohashgroestlNode, v : Double) -> CryptohashgroestlNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_node_min(s : CryptohashgroestlNode) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_node_max(s : CryptohashgroestlNode) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_node_to_string(s : CryptohashgroestlNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_edge_make(size : Int) -> CryptohashgroestlEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_edge_len(s : CryptohashgroestlEdge) -> Int { s.size }

pub fn crypto_hash_groestl_edge_get(s : CryptohashgroestlEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_edge_set(s : CryptohashgroestlEdge, i : Int, v : Double) -> CryptohashgroestlEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_edge_sum(s : CryptohashgroestlEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_edge_mean(s : CryptohashgroestlEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_edge_scale(s : CryptohashgroestlEdge, f : Double) -> CryptohashgroestlEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_edge_add(a : CryptohashgroestlEdge, b : CryptohashgroestlEdge) -> CryptohashgroestlEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_groestl_edge_copy(s : CryptohashgroestlEdge) -> CryptohashgroestlEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_edge_fill(s : CryptohashgroestlEdge, v : Double) -> CryptohashgroestlEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_edge_min(s : CryptohashgroestlEdge) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_edge_max(s : CryptohashgroestlEdge) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_edge_to_string(s : CryptohashgroestlEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_path_make(size : Int) -> CryptohashgroestlPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_path_len(s : CryptohashgroestlPath) -> Int { s.size }

pub fn crypto_hash_groestl_path_get(s : CryptohashgroestlPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_path_set(s : CryptohashgroestlPath, i : Int, v : Double) -> CryptohashgroestlPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_path_sum(s : CryptohashgroestlPath) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_path_mean(s : CryptohashgroestlPath) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_path_scale(s : CryptohashgroestlPath, f : Double) -> CryptohashgroestlPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_path_add(a : CryptohashgroestlPath, b : CryptohashgroestlPath) -> CryptohashgroestlPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_groestl_path_copy(s : CryptohashgroestlPath) -> CryptohashgroestlPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_path_fill(s : CryptohashgroestlPath, v : Double) -> CryptohashgroestlPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_path_min(s : CryptohashgroestlPath) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_path_max(s : CryptohashgroestlPath) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_path_to_string(s : CryptohashgroestlPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_cluster_make(size : Int) -> CryptohashgroestlCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_cluster_len(s : CryptohashgroestlCluster) -> Int { s.size }

pub fn crypto_hash_groestl_cluster_get(s : CryptohashgroestlCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_cluster_set(s : CryptohashgroestlCluster, i : Int, v : Double) -> CryptohashgroestlCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_cluster_sum(s : CryptohashgroestlCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_cluster_mean(s : CryptohashgroestlCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_cluster_scale(s : CryptohashgroestlCluster, f : Double) -> CryptohashgroestlCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_cluster_add(a : CryptohashgroestlCluster, b : CryptohashgroestlCluster) -> CryptohashgroestlCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_groestl_cluster_copy(s : CryptohashgroestlCluster) -> CryptohashgroestlCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_cluster_fill(s : CryptohashgroestlCluster, v : Double) -> CryptohashgroestlCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_cluster_min(s : CryptohashgroestlCluster) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_cluster_max(s : CryptohashgroestlCluster) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_cluster_to_string(s : CryptohashgroestlCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_model_make(size : Int) -> CryptohashgroestlModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_model_len(s : CryptohashgroestlModel) -> Int { s.size }

pub fn crypto_hash_groestl_model_get(s : CryptohashgroestlModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_model_set(s : CryptohashgroestlModel, i : Int, v : Double) -> CryptohashgroestlModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_model_sum(s : CryptohashgroestlModel) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_model_mean(s : CryptohashgroestlModel) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_model_scale(s : CryptohashgroestlModel, f : Double) -> CryptohashgroestlModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_model_add(a : CryptohashgroestlModel, b : CryptohashgroestlModel) -> CryptohashgroestlModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_groestl_model_copy(s : CryptohashgroestlModel) -> CryptohashgroestlModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_model_fill(s : CryptohashgroestlModel, v : Double) -> CryptohashgroestlModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_model_min(s : CryptohashgroestlModel) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_model_max(s : CryptohashgroestlModel) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_model_to_string(s : CryptohashgroestlModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_layer_make(size : Int) -> CryptohashgroestlLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_layer_len(s : CryptohashgroestlLayer) -> Int { s.size }

pub fn crypto_hash_groestl_layer_get(s : CryptohashgroestlLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_layer_set(s : CryptohashgroestlLayer, i : Int, v : Double) -> CryptohashgroestlLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_layer_sum(s : CryptohashgroestlLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_layer_mean(s : CryptohashgroestlLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_layer_scale(s : CryptohashgroestlLayer, f : Double) -> CryptohashgroestlLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_layer_add(a : CryptohashgroestlLayer, b : CryptohashgroestlLayer) -> CryptohashgroestlLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_groestl_layer_copy(s : CryptohashgroestlLayer) -> CryptohashgroestlLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_layer_fill(s : CryptohashgroestlLayer, v : Double) -> CryptohashgroestlLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_layer_min(s : CryptohashgroestlLayer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_layer_max(s : CryptohashgroestlLayer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_layer_to_string(s : CryptohashgroestlLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_buffer_make(size : Int) -> CryptohashgroestlBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_buffer_len(s : CryptohashgroestlBuffer) -> Int { s.size }

pub fn crypto_hash_groestl_buffer_get(s : CryptohashgroestlBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_buffer_set(s : CryptohashgroestlBuffer, i : Int, v : Double) -> CryptohashgroestlBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_buffer_sum(s : CryptohashgroestlBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_buffer_mean(s : CryptohashgroestlBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_buffer_scale(s : CryptohashgroestlBuffer, f : Double) -> CryptohashgroestlBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_buffer_add(a : CryptohashgroestlBuffer, b : CryptohashgroestlBuffer) -> CryptohashgroestlBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_groestl_buffer_copy(s : CryptohashgroestlBuffer) -> CryptohashgroestlBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_buffer_fill(s : CryptohashgroestlBuffer, v : Double) -> CryptohashgroestlBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_buffer_min(s : CryptohashgroestlBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_buffer_max(s : CryptohashgroestlBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_buffer_to_string(s : CryptohashgroestlBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_cursor_make(size : Int) -> CryptohashgroestlCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_cursor_len(s : CryptohashgroestlCursor) -> Int { s.size }

pub fn crypto_hash_groestl_cursor_get(s : CryptohashgroestlCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_cursor_set(s : CryptohashgroestlCursor, i : Int, v : Double) -> CryptohashgroestlCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_cursor_sum(s : CryptohashgroestlCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_cursor_mean(s : CryptohashgroestlCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_cursor_scale(s : CryptohashgroestlCursor, f : Double) -> CryptohashgroestlCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_cursor_add(a : CryptohashgroestlCursor, b : CryptohashgroestlCursor) -> CryptohashgroestlCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_groestl_cursor_copy(s : CryptohashgroestlCursor) -> CryptohashgroestlCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_cursor_fill(s : CryptohashgroestlCursor, v : Double) -> CryptohashgroestlCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_cursor_min(s : CryptohashgroestlCursor) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_cursor_max(s : CryptohashgroestlCursor) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_cursor_to_string(s : CryptohashgroestlCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_view_make(size : Int) -> CryptohashgroestlView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_view_len(s : CryptohashgroestlView) -> Int { s.size }

pub fn crypto_hash_groestl_view_get(s : CryptohashgroestlView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_view_set(s : CryptohashgroestlView, i : Int, v : Double) -> CryptohashgroestlView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_view_sum(s : CryptohashgroestlView) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_view_mean(s : CryptohashgroestlView) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_view_scale(s : CryptohashgroestlView, f : Double) -> CryptohashgroestlView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_view_add(a : CryptohashgroestlView, b : CryptohashgroestlView) -> CryptohashgroestlView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_groestl_view_copy(s : CryptohashgroestlView) -> CryptohashgroestlView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_view_fill(s : CryptohashgroestlView, v : Double) -> CryptohashgroestlView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_view_min(s : CryptohashgroestlView) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_view_max(s : CryptohashgroestlView) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_view_to_string(s : CryptohashgroestlView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_range_make(size : Int) -> CryptohashgroestlRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_range_len(s : CryptohashgroestlRange) -> Int { s.size }

pub fn crypto_hash_groestl_range_get(s : CryptohashgroestlRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_range_set(s : CryptohashgroestlRange, i : Int, v : Double) -> CryptohashgroestlRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_range_sum(s : CryptohashgroestlRange) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_range_mean(s : CryptohashgroestlRange) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_range_scale(s : CryptohashgroestlRange, f : Double) -> CryptohashgroestlRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_range_add(a : CryptohashgroestlRange, b : CryptohashgroestlRange) -> CryptohashgroestlRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_groestl_range_copy(s : CryptohashgroestlRange) -> CryptohashgroestlRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_range_fill(s : CryptohashgroestlRange, v : Double) -> CryptohashgroestlRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_range_min(s : CryptohashgroestlRange) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_range_max(s : CryptohashgroestlRange) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_range_to_string(s : CryptohashgroestlRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptohashgroestlSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_hash_groestl_slice_make(size : Int) -> CryptohashgroestlSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_hash_groestl_slice_len(s : CryptohashgroestlSlice) -> Int { s.size }

pub fn crypto_hash_groestl_slice_get(s : CryptohashgroestlSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_hash_groestl_slice_set(s : CryptohashgroestlSlice, i : Int, v : Double) -> CryptohashgroestlSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_slice_sum(s : CryptohashgroestlSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_hash_groestl_slice_mean(s : CryptohashgroestlSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_hash_groestl_slice_scale(s : CryptohashgroestlSlice, f : Double) -> CryptohashgroestlSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_slice_add(a : CryptohashgroestlSlice, b : CryptohashgroestlSlice) -> CryptohashgroestlSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_hash_groestl_slice_copy(s : CryptohashgroestlSlice) -> CryptohashgroestlSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_slice_fill(s : CryptohashgroestlSlice, v : Double) -> CryptohashgroestlSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_hash_groestl_slice_min(s : CryptohashgroestlSlice) -> Double { @_common.min(s.data) }

pub fn crypto_hash_groestl_slice_max(s : CryptohashgroestlSlice) -> Double { @_common.max(s.data) }

pub fn crypto_hash_groestl_slice_to_string(s : CryptohashgroestlSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

