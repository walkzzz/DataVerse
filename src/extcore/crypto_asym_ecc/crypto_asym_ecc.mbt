///===
/// extcore/crypto_asym_ecc

pub(all) struct CryptoasymeccPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_ecc_make_point(x : Double, y : Double) -> CryptoasymeccPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_ecc_make_point3(x : Double, y : Double, z : Double) -> CryptoasymeccPoint {
  { x, y, z, label: 0 }
}

pub fn CryptoasymeccPoint::x(self : CryptoasymeccPoint) -> Double { self.x }

pub fn CryptoasymeccPoint::y(self : CryptoasymeccPoint) -> Double { self.y }

pub fn CryptoasymeccPoint::z(self : CryptoasymeccPoint) -> Double { self.z }

pub fn CryptoasymeccPoint::label(self : CryptoasymeccPoint) -> Int { self.label }

pub fn CryptoasymeccPoint::dist(self : CryptoasymeccPoint, other : CryptoasymeccPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptoasymeccPoint::add(self : CryptoasymeccPoint, other : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptoasymeccPoint::sub(self : CryptoasymeccPoint, other : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptoasymeccPoint::scale(self : CryptoasymeccPoint, s : Double) -> CryptoasymeccPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptoasymeccPoint::dot(self : CryptoasymeccPoint, other : CryptoasymeccPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptoasymeccPoint::cross(self : CryptoasymeccPoint, other : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptoasymeccPoint::norm(self : CryptoasymeccPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptoasymeccPoint::normalize(self : CryptoasymeccPoint) -> CryptoasymeccPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymeccPoint::negate(self : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptoasymeccPoint::mid(self : CryptoasymeccPoint, other : CryptoasymeccPoint) -> CryptoasymeccPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptoasymeccPoint::lerp(self : CryptoasymeccPoint, other : CryptoasymeccPoint, t : Double) -> CryptoasymeccPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptoasymeccPoint::to_string(self : CryptoasymeccPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptoasymeccSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_ecc_make_series(vals : Array[Double], name : String) -> CryptoasymeccSeries {
  { vals, name, meta: 0 }
}

pub fn CryptoasymeccSeries::len(self : CryptoasymeccSeries) -> Int { self.vals.length() }

pub fn CryptoasymeccSeries::sum(self : CryptoasymeccSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptoasymeccSeries::mean(self : CryptoasymeccSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptoasymeccSeries::min(self : CryptoasymeccSeries) -> Double { @_common.min(self.vals) }

pub fn CryptoasymeccSeries::max(self : CryptoasymeccSeries) -> Double { @_common.max(self.vals) }

pub fn CryptoasymeccSeries::range(self : CryptoasymeccSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptoasymeccSeries::variance(self : CryptoasymeccSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptoasymeccSeries::std(self : CryptoasymeccSeries) -> Double { @_common.std(self.vals) }

pub fn CryptoasymeccSeries::median(self : CryptoasymeccSeries) -> Double { @_common.median(self.vals) }

pub fn CryptoasymeccSeries::scale(self : CryptoasymeccSeries, f : Double) -> CryptoasymeccSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptoasymeccSeries::add(self : CryptoasymeccSeries, other : CryptoasymeccSeries) -> CryptoasymeccSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptoasymeccSeries::sub(self : CryptoasymeccSeries, other : CryptoasymeccSeries) -> CryptoasymeccSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptoasymeccSeries::normalize(self : CryptoasymeccSeries) -> CryptoasymeccSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptoasymeccSeries::cumsum(self : CryptoasymeccSeries) -> CryptoasymeccSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptoasymeccSeries::to_string(self : CryptoasymeccSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymeccMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_ecc_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymeccMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_ecc_matrix_identity(n : Int) -> CryptoasymeccMatrix {
  let m = crypto_asym_ecc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptoasymeccMatrix::get(self : CryptoasymeccMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptoasymeccMatrix::transpose(self : CryptoasymeccMatrix) -> CryptoasymeccMatrix {
  let result = crypto_asym_ecc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptoasymeccMatrix::add(self : CryptoasymeccMatrix, other : CryptoasymeccMatrix) -> CryptoasymeccMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_ecc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptoasymeccMatrix::scale(self : CryptoasymeccMatrix, s : Double) -> CryptoasymeccMatrix {
  let result = crypto_asym_ecc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptoasymeccMatrix::multiply(self : CryptoasymeccMatrix, other : CryptoasymeccMatrix) -> CryptoasymeccMatrix {
  if self.cols != other.rows { return crypto_asym_ecc_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_ecc_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptoasymeccMatrix::trace(self : CryptoasymeccMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptoasymeccMatrix::det(self : CryptoasymeccMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptoasymeccMatrix::norm(self : CryptoasymeccMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptoasymeccMatrix::to_string(self : CryptoasymeccMatrix) -> String {
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

pub(all) struct CryptoasymeccVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_ecc_make_vector(comps : Array[Double]) -> CryptoasymeccVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_ecc_vector_zero(dim : Int) -> CryptoasymeccVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptoasymeccVector::add(self : CryptoasymeccVector, other : CryptoasymeccVector) -> CryptoasymeccVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymeccVector::sub(self : CryptoasymeccVector, other : CryptoasymeccVector) -> CryptoasymeccVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymeccVector::scale(self : CryptoasymeccVector, s : Double) -> CryptoasymeccVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptoasymeccVector::dot(self : CryptoasymeccVector, other : CryptoasymeccVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptoasymeccVector::norm(self : CryptoasymeccVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptoasymeccVector::normalize(self : CryptoasymeccVector) -> CryptoasymeccVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymeccVector::dist(self : CryptoasymeccVector, other : CryptoasymeccVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptoasymeccVector::to_string(self : CryptoasymeccVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_ecc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_ecc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_ecc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_ecc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_ecc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_ecc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_ecc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_ecc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_ecc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_ecc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_ecc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_ecc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_ecc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_ecc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_ecc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_ecc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_ecc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_ecc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_ecc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_ecc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_ecc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_ecc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_ecc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_ecc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_ecc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_ecc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_ecc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_ecc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_ecc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymeccFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_frame_make(size : Int) -> CryptoasymeccFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeccFrame::len(self : CryptoasymeccFrame) -> Int { self.size }

pub fn CryptoasymeccFrame::get(self : CryptoasymeccFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeccFrame::set(self : CryptoasymeccFrame, i : Int, v : Double) -> CryptoasymeccFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeccFrame::sum(self : CryptoasymeccFrame) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeccFrame::mean(self : CryptoasymeccFrame) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeccFrame::scale(self : CryptoasymeccFrame, f : Double) -> CryptoasymeccFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccFrame::add(self : CryptoasymeccFrame, other : CryptoasymeccFrame) -> CryptoasymeccFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeccFrame::copy(self : CryptoasymeccFrame) -> CryptoasymeccFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccFrame::fill(self : CryptoasymeccFrame, v : Double) -> CryptoasymeccFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccFrame::min(self : CryptoasymeccFrame) -> Double { @_common.min(self.data) }

pub fn CryptoasymeccFrame::max(self : CryptoasymeccFrame) -> Double { @_common.max(self.data) }

pub fn CryptoasymeccFrame::to_string(self : CryptoasymeccFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_table_make(size : Int) -> CryptoasymeccTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeccTable::len(self : CryptoasymeccTable) -> Int { self.size }

pub fn CryptoasymeccTable::get(self : CryptoasymeccTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeccTable::set(self : CryptoasymeccTable, i : Int, v : Double) -> CryptoasymeccTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeccTable::sum(self : CryptoasymeccTable) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeccTable::mean(self : CryptoasymeccTable) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeccTable::scale(self : CryptoasymeccTable, f : Double) -> CryptoasymeccTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccTable::add(self : CryptoasymeccTable, other : CryptoasymeccTable) -> CryptoasymeccTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeccTable::copy(self : CryptoasymeccTable) -> CryptoasymeccTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccTable::fill(self : CryptoasymeccTable, v : Double) -> CryptoasymeccTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccTable::min(self : CryptoasymeccTable) -> Double { @_common.min(self.data) }

pub fn CryptoasymeccTable::max(self : CryptoasymeccTable) -> Double { @_common.max(self.data) }

pub fn CryptoasymeccTable::to_string(self : CryptoasymeccTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_graphn_make(size : Int) -> CryptoasymeccGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeccGraphN::len(self : CryptoasymeccGraphN) -> Int { self.size }

pub fn CryptoasymeccGraphN::get(self : CryptoasymeccGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeccGraphN::set(self : CryptoasymeccGraphN, i : Int, v : Double) -> CryptoasymeccGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeccGraphN::sum(self : CryptoasymeccGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeccGraphN::mean(self : CryptoasymeccGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeccGraphN::scale(self : CryptoasymeccGraphN, f : Double) -> CryptoasymeccGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccGraphN::add(self : CryptoasymeccGraphN, other : CryptoasymeccGraphN) -> CryptoasymeccGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeccGraphN::copy(self : CryptoasymeccGraphN) -> CryptoasymeccGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccGraphN::fill(self : CryptoasymeccGraphN, v : Double) -> CryptoasymeccGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccGraphN::min(self : CryptoasymeccGraphN) -> Double { @_common.min(self.data) }

pub fn CryptoasymeccGraphN::max(self : CryptoasymeccGraphN) -> Double { @_common.max(self.data) }

pub fn CryptoasymeccGraphN::to_string(self : CryptoasymeccGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_node_make(size : Int) -> CryptoasymeccNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeccNode::len(self : CryptoasymeccNode) -> Int { self.size }

pub fn CryptoasymeccNode::get(self : CryptoasymeccNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeccNode::set(self : CryptoasymeccNode, i : Int, v : Double) -> CryptoasymeccNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeccNode::sum(self : CryptoasymeccNode) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeccNode::mean(self : CryptoasymeccNode) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeccNode::scale(self : CryptoasymeccNode, f : Double) -> CryptoasymeccNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccNode::add(self : CryptoasymeccNode, other : CryptoasymeccNode) -> CryptoasymeccNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeccNode::copy(self : CryptoasymeccNode) -> CryptoasymeccNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccNode::fill(self : CryptoasymeccNode, v : Double) -> CryptoasymeccNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccNode::min(self : CryptoasymeccNode) -> Double { @_common.min(self.data) }

pub fn CryptoasymeccNode::max(self : CryptoasymeccNode) -> Double { @_common.max(self.data) }

pub fn CryptoasymeccNode::to_string(self : CryptoasymeccNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_edge_make(size : Int) -> CryptoasymeccEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeccEdge::len(self : CryptoasymeccEdge) -> Int { self.size }

pub fn CryptoasymeccEdge::get(self : CryptoasymeccEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeccEdge::set(self : CryptoasymeccEdge, i : Int, v : Double) -> CryptoasymeccEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeccEdge::sum(self : CryptoasymeccEdge) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeccEdge::mean(self : CryptoasymeccEdge) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeccEdge::scale(self : CryptoasymeccEdge, f : Double) -> CryptoasymeccEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccEdge::add(self : CryptoasymeccEdge, other : CryptoasymeccEdge) -> CryptoasymeccEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeccEdge::copy(self : CryptoasymeccEdge) -> CryptoasymeccEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccEdge::fill(self : CryptoasymeccEdge, v : Double) -> CryptoasymeccEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccEdge::min(self : CryptoasymeccEdge) -> Double { @_common.min(self.data) }

pub fn CryptoasymeccEdge::max(self : CryptoasymeccEdge) -> Double { @_common.max(self.data) }

pub fn CryptoasymeccEdge::to_string(self : CryptoasymeccEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_path_make(size : Int) -> CryptoasymeccPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeccPath::len(self : CryptoasymeccPath) -> Int { self.size }

pub fn CryptoasymeccPath::get(self : CryptoasymeccPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeccPath::set(self : CryptoasymeccPath, i : Int, v : Double) -> CryptoasymeccPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeccPath::sum(self : CryptoasymeccPath) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeccPath::mean(self : CryptoasymeccPath) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeccPath::scale(self : CryptoasymeccPath, f : Double) -> CryptoasymeccPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccPath::add(self : CryptoasymeccPath, other : CryptoasymeccPath) -> CryptoasymeccPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeccPath::copy(self : CryptoasymeccPath) -> CryptoasymeccPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccPath::fill(self : CryptoasymeccPath, v : Double) -> CryptoasymeccPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccPath::min(self : CryptoasymeccPath) -> Double { @_common.min(self.data) }

pub fn CryptoasymeccPath::max(self : CryptoasymeccPath) -> Double { @_common.max(self.data) }

pub fn CryptoasymeccPath::to_string(self : CryptoasymeccPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_cluster_make(size : Int) -> CryptoasymeccCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeccCluster::len(self : CryptoasymeccCluster) -> Int { self.size }

pub fn CryptoasymeccCluster::get(self : CryptoasymeccCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeccCluster::set(self : CryptoasymeccCluster, i : Int, v : Double) -> CryptoasymeccCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeccCluster::sum(self : CryptoasymeccCluster) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeccCluster::mean(self : CryptoasymeccCluster) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeccCluster::scale(self : CryptoasymeccCluster, f : Double) -> CryptoasymeccCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccCluster::add(self : CryptoasymeccCluster, other : CryptoasymeccCluster) -> CryptoasymeccCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeccCluster::copy(self : CryptoasymeccCluster) -> CryptoasymeccCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccCluster::fill(self : CryptoasymeccCluster, v : Double) -> CryptoasymeccCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccCluster::min(self : CryptoasymeccCluster) -> Double { @_common.min(self.data) }

pub fn CryptoasymeccCluster::max(self : CryptoasymeccCluster) -> Double { @_common.max(self.data) }

pub fn CryptoasymeccCluster::to_string(self : CryptoasymeccCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_model_make(size : Int) -> CryptoasymeccModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeccModel::len(self : CryptoasymeccModel) -> Int { self.size }

pub fn CryptoasymeccModel::get(self : CryptoasymeccModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeccModel::set(self : CryptoasymeccModel, i : Int, v : Double) -> CryptoasymeccModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeccModel::sum(self : CryptoasymeccModel) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeccModel::mean(self : CryptoasymeccModel) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeccModel::scale(self : CryptoasymeccModel, f : Double) -> CryptoasymeccModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccModel::add(self : CryptoasymeccModel, other : CryptoasymeccModel) -> CryptoasymeccModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeccModel::copy(self : CryptoasymeccModel) -> CryptoasymeccModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccModel::fill(self : CryptoasymeccModel, v : Double) -> CryptoasymeccModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccModel::min(self : CryptoasymeccModel) -> Double { @_common.min(self.data) }

pub fn CryptoasymeccModel::max(self : CryptoasymeccModel) -> Double { @_common.max(self.data) }

pub fn CryptoasymeccModel::to_string(self : CryptoasymeccModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_layer_make(size : Int) -> CryptoasymeccLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeccLayer::len(self : CryptoasymeccLayer) -> Int { self.size }

pub fn CryptoasymeccLayer::get(self : CryptoasymeccLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeccLayer::set(self : CryptoasymeccLayer, i : Int, v : Double) -> CryptoasymeccLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeccLayer::sum(self : CryptoasymeccLayer) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeccLayer::mean(self : CryptoasymeccLayer) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeccLayer::scale(self : CryptoasymeccLayer, f : Double) -> CryptoasymeccLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccLayer::add(self : CryptoasymeccLayer, other : CryptoasymeccLayer) -> CryptoasymeccLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeccLayer::copy(self : CryptoasymeccLayer) -> CryptoasymeccLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccLayer::fill(self : CryptoasymeccLayer, v : Double) -> CryptoasymeccLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccLayer::min(self : CryptoasymeccLayer) -> Double { @_common.min(self.data) }

pub fn CryptoasymeccLayer::max(self : CryptoasymeccLayer) -> Double { @_common.max(self.data) }

pub fn CryptoasymeccLayer::to_string(self : CryptoasymeccLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_buffer_make(size : Int) -> CryptoasymeccBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeccBuffer::len(self : CryptoasymeccBuffer) -> Int { self.size }

pub fn CryptoasymeccBuffer::get(self : CryptoasymeccBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeccBuffer::set(self : CryptoasymeccBuffer, i : Int, v : Double) -> CryptoasymeccBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeccBuffer::sum(self : CryptoasymeccBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeccBuffer::mean(self : CryptoasymeccBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeccBuffer::scale(self : CryptoasymeccBuffer, f : Double) -> CryptoasymeccBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccBuffer::add(self : CryptoasymeccBuffer, other : CryptoasymeccBuffer) -> CryptoasymeccBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeccBuffer::copy(self : CryptoasymeccBuffer) -> CryptoasymeccBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccBuffer::fill(self : CryptoasymeccBuffer, v : Double) -> CryptoasymeccBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccBuffer::min(self : CryptoasymeccBuffer) -> Double { @_common.min(self.data) }

pub fn CryptoasymeccBuffer::max(self : CryptoasymeccBuffer) -> Double { @_common.max(self.data) }

pub fn CryptoasymeccBuffer::to_string(self : CryptoasymeccBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_cursor_make(size : Int) -> CryptoasymeccCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeccCursor::len(self : CryptoasymeccCursor) -> Int { self.size }

pub fn CryptoasymeccCursor::get(self : CryptoasymeccCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeccCursor::set(self : CryptoasymeccCursor, i : Int, v : Double) -> CryptoasymeccCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeccCursor::sum(self : CryptoasymeccCursor) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeccCursor::mean(self : CryptoasymeccCursor) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeccCursor::scale(self : CryptoasymeccCursor, f : Double) -> CryptoasymeccCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccCursor::add(self : CryptoasymeccCursor, other : CryptoasymeccCursor) -> CryptoasymeccCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeccCursor::copy(self : CryptoasymeccCursor) -> CryptoasymeccCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccCursor::fill(self : CryptoasymeccCursor, v : Double) -> CryptoasymeccCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccCursor::min(self : CryptoasymeccCursor) -> Double { @_common.min(self.data) }

pub fn CryptoasymeccCursor::max(self : CryptoasymeccCursor) -> Double { @_common.max(self.data) }

pub fn CryptoasymeccCursor::to_string(self : CryptoasymeccCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_view_make(size : Int) -> CryptoasymeccView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeccView::len(self : CryptoasymeccView) -> Int { self.size }

pub fn CryptoasymeccView::get(self : CryptoasymeccView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeccView::set(self : CryptoasymeccView, i : Int, v : Double) -> CryptoasymeccView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeccView::sum(self : CryptoasymeccView) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeccView::mean(self : CryptoasymeccView) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeccView::scale(self : CryptoasymeccView, f : Double) -> CryptoasymeccView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccView::add(self : CryptoasymeccView, other : CryptoasymeccView) -> CryptoasymeccView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeccView::copy(self : CryptoasymeccView) -> CryptoasymeccView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccView::fill(self : CryptoasymeccView, v : Double) -> CryptoasymeccView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccView::min(self : CryptoasymeccView) -> Double { @_common.min(self.data) }

pub fn CryptoasymeccView::max(self : CryptoasymeccView) -> Double { @_common.max(self.data) }

pub fn CryptoasymeccView::to_string(self : CryptoasymeccView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_range_make(size : Int) -> CryptoasymeccRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeccRange::len(self : CryptoasymeccRange) -> Int { self.size }

pub fn CryptoasymeccRange::get(self : CryptoasymeccRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeccRange::set(self : CryptoasymeccRange, i : Int, v : Double) -> CryptoasymeccRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeccRange::sum(self : CryptoasymeccRange) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeccRange::mean(self : CryptoasymeccRange) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeccRange::scale(self : CryptoasymeccRange, f : Double) -> CryptoasymeccRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccRange::add(self : CryptoasymeccRange, other : CryptoasymeccRange) -> CryptoasymeccRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeccRange::copy(self : CryptoasymeccRange) -> CryptoasymeccRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccRange::fill(self : CryptoasymeccRange, v : Double) -> CryptoasymeccRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccRange::min(self : CryptoasymeccRange) -> Double { @_common.min(self.data) }

pub fn CryptoasymeccRange::max(self : CryptoasymeccRange) -> Double { @_common.max(self.data) }

pub fn CryptoasymeccRange::to_string(self : CryptoasymeccRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymeccSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_ecc_slice_make(size : Int) -> CryptoasymeccSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymeccSlice::len(self : CryptoasymeccSlice) -> Int { self.size }

pub fn CryptoasymeccSlice::get(self : CryptoasymeccSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymeccSlice::set(self : CryptoasymeccSlice, i : Int, v : Double) -> CryptoasymeccSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymeccSlice::sum(self : CryptoasymeccSlice) -> Double { @_common.sum(self.data) }

pub fn CryptoasymeccSlice::mean(self : CryptoasymeccSlice) -> Double { @_common.mean(self.data) }

pub fn CryptoasymeccSlice::scale(self : CryptoasymeccSlice, f : Double) -> CryptoasymeccSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccSlice::add(self : CryptoasymeccSlice, other : CryptoasymeccSlice) -> CryptoasymeccSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymeccSlice::copy(self : CryptoasymeccSlice) -> CryptoasymeccSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccSlice::fill(self : CryptoasymeccSlice, v : Double) -> CryptoasymeccSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymeccSlice::min(self : CryptoasymeccSlice) -> Double { @_common.min(self.data) }

pub fn CryptoasymeccSlice::max(self : CryptoasymeccSlice) -> Double { @_common.max(self.data) }

pub fn CryptoasymeccSlice::to_string(self : CryptoasymeccSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

