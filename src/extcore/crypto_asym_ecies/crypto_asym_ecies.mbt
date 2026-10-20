///===
/// extcore/crypto_asym_ecies

pub(all) struct CryptoasymeciesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_ecies_make_point(x : Double, y : Double) -> CryptoasymeciesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_ecies_make_point3(x : Double, y : Double, z : Double) -> CryptoasymeciesPoint {
  { x, y, z, label: 0 }
}

pub fn CryptoasymeciesPoint::x(self : CryptoasymeciesPoint) -> Double { self.x }

pub fn CryptoasymeciesPoint::y(self : CryptoasymeciesPoint) -> Double { self.y }

pub fn CryptoasymeciesPoint::z(self : CryptoasymeciesPoint) -> Double { self.z }

pub fn CryptoasymeciesPoint::label(self : CryptoasymeciesPoint) -> Int { self.label }

pub fn CryptoasymeciesPoint::dist(self : CryptoasymeciesPoint, other : CryptoasymeciesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptoasymeciesPoint::add(self : CryptoasymeciesPoint, other : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptoasymeciesPoint::sub(self : CryptoasymeciesPoint, other : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptoasymeciesPoint::scale(self : CryptoasymeciesPoint, s : Double) -> CryptoasymeciesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptoasymeciesPoint::dot(self : CryptoasymeciesPoint, other : CryptoasymeciesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptoasymeciesPoint::cross(self : CryptoasymeciesPoint, other : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptoasymeciesPoint::norm(self : CryptoasymeciesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptoasymeciesPoint::normalize(self : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymeciesPoint::negate(self : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptoasymeciesPoint::mid(self : CryptoasymeciesPoint, other : CryptoasymeciesPoint) -> CryptoasymeciesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptoasymeciesPoint::lerp(self : CryptoasymeciesPoint, other : CryptoasymeciesPoint, t : Double) -> CryptoasymeciesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptoasymeciesPoint::to_string(self : CryptoasymeciesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptoasymeciesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_ecies_make_series(vals : Array[Double], name : String) -> CryptoasymeciesSeries {
  { vals, name, meta: 0 }
}

pub fn CryptoasymeciesSeries::len(self : CryptoasymeciesSeries) -> Int { self.vals.length() }

pub fn CryptoasymeciesSeries::sum(self : CryptoasymeciesSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptoasymeciesSeries::mean(self : CryptoasymeciesSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptoasymeciesSeries::min(self : CryptoasymeciesSeries) -> Double { @_common.min(self.vals) }

pub fn CryptoasymeciesSeries::max(self : CryptoasymeciesSeries) -> Double { @_common.max(self.vals) }

pub fn CryptoasymeciesSeries::range(self : CryptoasymeciesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptoasymeciesSeries::variance(self : CryptoasymeciesSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptoasymeciesSeries::std(self : CryptoasymeciesSeries) -> Double { @_common.std(self.vals) }

pub fn CryptoasymeciesSeries::median(self : CryptoasymeciesSeries) -> Double { @_common.median(self.vals) }

pub fn CryptoasymeciesSeries::scale(self : CryptoasymeciesSeries, f : Double) -> CryptoasymeciesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptoasymeciesSeries::add(self : CryptoasymeciesSeries, other : CryptoasymeciesSeries) -> CryptoasymeciesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptoasymeciesSeries::sub(self : CryptoasymeciesSeries, other : CryptoasymeciesSeries) -> CryptoasymeciesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptoasymeciesSeries::normalize(self : CryptoasymeciesSeries) -> CryptoasymeciesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptoasymeciesSeries::cumsum(self : CryptoasymeciesSeries) -> CryptoasymeciesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptoasymeciesSeries::to_string(self : CryptoasymeciesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymeciesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_ecies_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymeciesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_ecies_matrix_identity(n : Int) -> CryptoasymeciesMatrix {
  let m = crypto_asym_ecies_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptoasymeciesMatrix::get(self : CryptoasymeciesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptoasymeciesMatrix::transpose(self : CryptoasymeciesMatrix) -> CryptoasymeciesMatrix {
  let result = crypto_asym_ecies_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptoasymeciesMatrix::add(self : CryptoasymeciesMatrix, other : CryptoasymeciesMatrix) -> CryptoasymeciesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_ecies_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptoasymeciesMatrix::scale(self : CryptoasymeciesMatrix, s : Double) -> CryptoasymeciesMatrix {
  let result = crypto_asym_ecies_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptoasymeciesMatrix::multiply(self : CryptoasymeciesMatrix, other : CryptoasymeciesMatrix) -> CryptoasymeciesMatrix {
  if self.cols != other.rows { return crypto_asym_ecies_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_ecies_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptoasymeciesMatrix::trace(self : CryptoasymeciesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptoasymeciesMatrix::det(self : CryptoasymeciesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptoasymeciesMatrix::norm(self : CryptoasymeciesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptoasymeciesMatrix::to_string(self : CryptoasymeciesMatrix) -> String {
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

pub(all) struct CryptoasymeciesVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_ecies_make_vector(comps : Array[Double]) -> CryptoasymeciesVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_ecies_vector_zero(dim : Int) -> CryptoasymeciesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptoasymeciesVector::add(self : CryptoasymeciesVector, other : CryptoasymeciesVector) -> CryptoasymeciesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymeciesVector::sub(self : CryptoasymeciesVector, other : CryptoasymeciesVector) -> CryptoasymeciesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymeciesVector::scale(self : CryptoasymeciesVector, s : Double) -> CryptoasymeciesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptoasymeciesVector::dot(self : CryptoasymeciesVector, other : CryptoasymeciesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptoasymeciesVector::norm(self : CryptoasymeciesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptoasymeciesVector::normalize(self : CryptoasymeciesVector) -> CryptoasymeciesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymeciesVector::dist(self : CryptoasymeciesVector, other : CryptoasymeciesVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptoasymeciesVector::to_string(self : CryptoasymeciesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_ecies_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_ecies_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_ecies_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_ecies_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_ecies_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_ecies_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_ecies_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_ecies_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_ecies_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_ecies_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_ecies_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_ecies_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_ecies_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_ecies_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_ecies_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_ecies_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_ecies_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_ecies_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_ecies_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_ecies_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_ecies_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_ecies_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_ecies_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_ecies_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_ecies_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_ecies_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_ecies_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_ecies_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_ecies_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymeciesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_frame_make(size : Int) -> CryptoasymeciesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_frame_len(s : CryptoasymeciesFrame) -> Int { s.size }

pub fn crypto_asym_ecies_frame_get(s : CryptoasymeciesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_frame_set(s : CryptoasymeciesFrame, i : Int, v : Double) -> CryptoasymeciesFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_frame_sum(s : CryptoasymeciesFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_frame_mean(s : CryptoasymeciesFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_frame_scale(s : CryptoasymeciesFrame, f : Double) -> CryptoasymeciesFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_frame_add(a : CryptoasymeciesFrame, b : CryptoasymeciesFrame) -> CryptoasymeciesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecies_frame_copy(s : CryptoasymeciesFrame) -> CryptoasymeciesFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_frame_fill(s : CryptoasymeciesFrame, v : Double) -> CryptoasymeciesFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_frame_min(s : CryptoasymeciesFrame) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_frame_max(s : CryptoasymeciesFrame) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_frame_to_string(s : CryptoasymeciesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_table_make(size : Int) -> CryptoasymeciesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_table_len(s : CryptoasymeciesTable) -> Int { s.size }

pub fn crypto_asym_ecies_table_get(s : CryptoasymeciesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_table_set(s : CryptoasymeciesTable, i : Int, v : Double) -> CryptoasymeciesTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_table_sum(s : CryptoasymeciesTable) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_table_mean(s : CryptoasymeciesTable) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_table_scale(s : CryptoasymeciesTable, f : Double) -> CryptoasymeciesTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_table_add(a : CryptoasymeciesTable, b : CryptoasymeciesTable) -> CryptoasymeciesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecies_table_copy(s : CryptoasymeciesTable) -> CryptoasymeciesTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_table_fill(s : CryptoasymeciesTable, v : Double) -> CryptoasymeciesTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_table_min(s : CryptoasymeciesTable) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_table_max(s : CryptoasymeciesTable) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_table_to_string(s : CryptoasymeciesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_graphn_make(size : Int) -> CryptoasymeciesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_graphn_len(s : CryptoasymeciesGraphN) -> Int { s.size }

pub fn crypto_asym_ecies_graphn_get(s : CryptoasymeciesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_graphn_set(s : CryptoasymeciesGraphN, i : Int, v : Double) -> CryptoasymeciesGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_graphn_sum(s : CryptoasymeciesGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_graphn_mean(s : CryptoasymeciesGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_graphn_scale(s : CryptoasymeciesGraphN, f : Double) -> CryptoasymeciesGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_graphn_add(a : CryptoasymeciesGraphN, b : CryptoasymeciesGraphN) -> CryptoasymeciesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecies_graphn_copy(s : CryptoasymeciesGraphN) -> CryptoasymeciesGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_graphn_fill(s : CryptoasymeciesGraphN, v : Double) -> CryptoasymeciesGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_graphn_min(s : CryptoasymeciesGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_graphn_max(s : CryptoasymeciesGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_graphn_to_string(s : CryptoasymeciesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_node_make(size : Int) -> CryptoasymeciesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_node_len(s : CryptoasymeciesNode) -> Int { s.size }

pub fn crypto_asym_ecies_node_get(s : CryptoasymeciesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_node_set(s : CryptoasymeciesNode, i : Int, v : Double) -> CryptoasymeciesNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_node_sum(s : CryptoasymeciesNode) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_node_mean(s : CryptoasymeciesNode) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_node_scale(s : CryptoasymeciesNode, f : Double) -> CryptoasymeciesNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_node_add(a : CryptoasymeciesNode, b : CryptoasymeciesNode) -> CryptoasymeciesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecies_node_copy(s : CryptoasymeciesNode) -> CryptoasymeciesNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_node_fill(s : CryptoasymeciesNode, v : Double) -> CryptoasymeciesNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_node_min(s : CryptoasymeciesNode) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_node_max(s : CryptoasymeciesNode) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_node_to_string(s : CryptoasymeciesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_edge_make(size : Int) -> CryptoasymeciesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_edge_len(s : CryptoasymeciesEdge) -> Int { s.size }

pub fn crypto_asym_ecies_edge_get(s : CryptoasymeciesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_edge_set(s : CryptoasymeciesEdge, i : Int, v : Double) -> CryptoasymeciesEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_edge_sum(s : CryptoasymeciesEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_edge_mean(s : CryptoasymeciesEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_edge_scale(s : CryptoasymeciesEdge, f : Double) -> CryptoasymeciesEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_edge_add(a : CryptoasymeciesEdge, b : CryptoasymeciesEdge) -> CryptoasymeciesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecies_edge_copy(s : CryptoasymeciesEdge) -> CryptoasymeciesEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_edge_fill(s : CryptoasymeciesEdge, v : Double) -> CryptoasymeciesEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_edge_min(s : CryptoasymeciesEdge) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_edge_max(s : CryptoasymeciesEdge) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_edge_to_string(s : CryptoasymeciesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_path_make(size : Int) -> CryptoasymeciesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_path_len(s : CryptoasymeciesPath) -> Int { s.size }

pub fn crypto_asym_ecies_path_get(s : CryptoasymeciesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_path_set(s : CryptoasymeciesPath, i : Int, v : Double) -> CryptoasymeciesPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_path_sum(s : CryptoasymeciesPath) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_path_mean(s : CryptoasymeciesPath) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_path_scale(s : CryptoasymeciesPath, f : Double) -> CryptoasymeciesPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_path_add(a : CryptoasymeciesPath, b : CryptoasymeciesPath) -> CryptoasymeciesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecies_path_copy(s : CryptoasymeciesPath) -> CryptoasymeciesPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_path_fill(s : CryptoasymeciesPath, v : Double) -> CryptoasymeciesPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_path_min(s : CryptoasymeciesPath) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_path_max(s : CryptoasymeciesPath) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_path_to_string(s : CryptoasymeciesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_cluster_make(size : Int) -> CryptoasymeciesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_cluster_len(s : CryptoasymeciesCluster) -> Int { s.size }

pub fn crypto_asym_ecies_cluster_get(s : CryptoasymeciesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_cluster_set(s : CryptoasymeciesCluster, i : Int, v : Double) -> CryptoasymeciesCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_cluster_sum(s : CryptoasymeciesCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_cluster_mean(s : CryptoasymeciesCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_cluster_scale(s : CryptoasymeciesCluster, f : Double) -> CryptoasymeciesCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_cluster_add(a : CryptoasymeciesCluster, b : CryptoasymeciesCluster) -> CryptoasymeciesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecies_cluster_copy(s : CryptoasymeciesCluster) -> CryptoasymeciesCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_cluster_fill(s : CryptoasymeciesCluster, v : Double) -> CryptoasymeciesCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_cluster_min(s : CryptoasymeciesCluster) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_cluster_max(s : CryptoasymeciesCluster) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_cluster_to_string(s : CryptoasymeciesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_model_make(size : Int) -> CryptoasymeciesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_model_len(s : CryptoasymeciesModel) -> Int { s.size }

pub fn crypto_asym_ecies_model_get(s : CryptoasymeciesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_model_set(s : CryptoasymeciesModel, i : Int, v : Double) -> CryptoasymeciesModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_model_sum(s : CryptoasymeciesModel) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_model_mean(s : CryptoasymeciesModel) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_model_scale(s : CryptoasymeciesModel, f : Double) -> CryptoasymeciesModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_model_add(a : CryptoasymeciesModel, b : CryptoasymeciesModel) -> CryptoasymeciesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecies_model_copy(s : CryptoasymeciesModel) -> CryptoasymeciesModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_model_fill(s : CryptoasymeciesModel, v : Double) -> CryptoasymeciesModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_model_min(s : CryptoasymeciesModel) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_model_max(s : CryptoasymeciesModel) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_model_to_string(s : CryptoasymeciesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_layer_make(size : Int) -> CryptoasymeciesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_layer_len(s : CryptoasymeciesLayer) -> Int { s.size }

pub fn crypto_asym_ecies_layer_get(s : CryptoasymeciesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_layer_set(s : CryptoasymeciesLayer, i : Int, v : Double) -> CryptoasymeciesLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_layer_sum(s : CryptoasymeciesLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_layer_mean(s : CryptoasymeciesLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_layer_scale(s : CryptoasymeciesLayer, f : Double) -> CryptoasymeciesLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_layer_add(a : CryptoasymeciesLayer, b : CryptoasymeciesLayer) -> CryptoasymeciesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecies_layer_copy(s : CryptoasymeciesLayer) -> CryptoasymeciesLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_layer_fill(s : CryptoasymeciesLayer, v : Double) -> CryptoasymeciesLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_layer_min(s : CryptoasymeciesLayer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_layer_max(s : CryptoasymeciesLayer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_layer_to_string(s : CryptoasymeciesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_buffer_make(size : Int) -> CryptoasymeciesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_buffer_len(s : CryptoasymeciesBuffer) -> Int { s.size }

pub fn crypto_asym_ecies_buffer_get(s : CryptoasymeciesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_buffer_set(s : CryptoasymeciesBuffer, i : Int, v : Double) -> CryptoasymeciesBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_buffer_sum(s : CryptoasymeciesBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_buffer_mean(s : CryptoasymeciesBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_buffer_scale(s : CryptoasymeciesBuffer, f : Double) -> CryptoasymeciesBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_buffer_add(a : CryptoasymeciesBuffer, b : CryptoasymeciesBuffer) -> CryptoasymeciesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecies_buffer_copy(s : CryptoasymeciesBuffer) -> CryptoasymeciesBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_buffer_fill(s : CryptoasymeciesBuffer, v : Double) -> CryptoasymeciesBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_buffer_min(s : CryptoasymeciesBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_buffer_max(s : CryptoasymeciesBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_buffer_to_string(s : CryptoasymeciesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_cursor_make(size : Int) -> CryptoasymeciesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_cursor_len(s : CryptoasymeciesCursor) -> Int { s.size }

pub fn crypto_asym_ecies_cursor_get(s : CryptoasymeciesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_cursor_set(s : CryptoasymeciesCursor, i : Int, v : Double) -> CryptoasymeciesCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_cursor_sum(s : CryptoasymeciesCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_cursor_mean(s : CryptoasymeciesCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_cursor_scale(s : CryptoasymeciesCursor, f : Double) -> CryptoasymeciesCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_cursor_add(a : CryptoasymeciesCursor, b : CryptoasymeciesCursor) -> CryptoasymeciesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecies_cursor_copy(s : CryptoasymeciesCursor) -> CryptoasymeciesCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_cursor_fill(s : CryptoasymeciesCursor, v : Double) -> CryptoasymeciesCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_cursor_min(s : CryptoasymeciesCursor) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_cursor_max(s : CryptoasymeciesCursor) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_cursor_to_string(s : CryptoasymeciesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_view_make(size : Int) -> CryptoasymeciesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_view_len(s : CryptoasymeciesView) -> Int { s.size }

pub fn crypto_asym_ecies_view_get(s : CryptoasymeciesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_view_set(s : CryptoasymeciesView, i : Int, v : Double) -> CryptoasymeciesView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_view_sum(s : CryptoasymeciesView) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_view_mean(s : CryptoasymeciesView) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_view_scale(s : CryptoasymeciesView, f : Double) -> CryptoasymeciesView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_view_add(a : CryptoasymeciesView, b : CryptoasymeciesView) -> CryptoasymeciesView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecies_view_copy(s : CryptoasymeciesView) -> CryptoasymeciesView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_view_fill(s : CryptoasymeciesView, v : Double) -> CryptoasymeciesView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_view_min(s : CryptoasymeciesView) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_view_max(s : CryptoasymeciesView) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_view_to_string(s : CryptoasymeciesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_range_make(size : Int) -> CryptoasymeciesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_range_len(s : CryptoasymeciesRange) -> Int { s.size }

pub fn crypto_asym_ecies_range_get(s : CryptoasymeciesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_range_set(s : CryptoasymeciesRange, i : Int, v : Double) -> CryptoasymeciesRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_range_sum(s : CryptoasymeciesRange) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_range_mean(s : CryptoasymeciesRange) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_range_scale(s : CryptoasymeciesRange, f : Double) -> CryptoasymeciesRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_range_add(a : CryptoasymeciesRange, b : CryptoasymeciesRange) -> CryptoasymeciesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecies_range_copy(s : CryptoasymeciesRange) -> CryptoasymeciesRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_range_fill(s : CryptoasymeciesRange, v : Double) -> CryptoasymeciesRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_range_min(s : CryptoasymeciesRange) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_range_max(s : CryptoasymeciesRange) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_range_to_string(s : CryptoasymeciesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymeciesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecies_slice_make(size : Int) -> CryptoasymeciesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_ecies_slice_len(s : CryptoasymeciesSlice) -> Int { s.size }

pub fn crypto_asym_ecies_slice_get(s : CryptoasymeciesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_ecies_slice_set(s : CryptoasymeciesSlice, i : Int, v : Double) -> CryptoasymeciesSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_slice_sum(s : CryptoasymeciesSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_ecies_slice_mean(s : CryptoasymeciesSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_ecies_slice_scale(s : CryptoasymeciesSlice, f : Double) -> CryptoasymeciesSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_slice_add(a : CryptoasymeciesSlice, b : CryptoasymeciesSlice) -> CryptoasymeciesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_ecies_slice_copy(s : CryptoasymeciesSlice) -> CryptoasymeciesSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_slice_fill(s : CryptoasymeciesSlice, v : Double) -> CryptoasymeciesSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_ecies_slice_min(s : CryptoasymeciesSlice) -> Double { @_common.min(s.data) }

pub fn crypto_asym_ecies_slice_max(s : CryptoasymeciesSlice) -> Double { @_common.max(s.data) }

pub fn crypto_asym_ecies_slice_to_string(s : CryptoasymeciesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

