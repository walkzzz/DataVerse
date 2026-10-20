///===
/// extcore/crypto_asym_dsa

pub(all) struct CryptoasymdsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_dsa_make_point(x : Double, y : Double) -> CryptoasymdsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_dsa_make_point3(x : Double, y : Double, z : Double) -> CryptoasymdsaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptoasymdsaPoint::x(self : CryptoasymdsaPoint) -> Double { self.x }

pub fn CryptoasymdsaPoint::y(self : CryptoasymdsaPoint) -> Double { self.y }

pub fn CryptoasymdsaPoint::z(self : CryptoasymdsaPoint) -> Double { self.z }

pub fn CryptoasymdsaPoint::label(self : CryptoasymdsaPoint) -> Int { self.label }

pub fn CryptoasymdsaPoint::dist(self : CryptoasymdsaPoint, other : CryptoasymdsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptoasymdsaPoint::add(self : CryptoasymdsaPoint, other : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptoasymdsaPoint::sub(self : CryptoasymdsaPoint, other : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptoasymdsaPoint::scale(self : CryptoasymdsaPoint, s : Double) -> CryptoasymdsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptoasymdsaPoint::dot(self : CryptoasymdsaPoint, other : CryptoasymdsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptoasymdsaPoint::cross(self : CryptoasymdsaPoint, other : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptoasymdsaPoint::norm(self : CryptoasymdsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptoasymdsaPoint::normalize(self : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymdsaPoint::negate(self : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptoasymdsaPoint::mid(self : CryptoasymdsaPoint, other : CryptoasymdsaPoint) -> CryptoasymdsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptoasymdsaPoint::lerp(self : CryptoasymdsaPoint, other : CryptoasymdsaPoint, t : Double) -> CryptoasymdsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptoasymdsaPoint::to_string(self : CryptoasymdsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptoasymdsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_dsa_make_series(vals : Array[Double], name : String) -> CryptoasymdsaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptoasymdsaSeries::len(self : CryptoasymdsaSeries) -> Int { self.vals.length() }

pub fn CryptoasymdsaSeries::sum(self : CryptoasymdsaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptoasymdsaSeries::mean(self : CryptoasymdsaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptoasymdsaSeries::min(self : CryptoasymdsaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptoasymdsaSeries::max(self : CryptoasymdsaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptoasymdsaSeries::range(self : CryptoasymdsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptoasymdsaSeries::variance(self : CryptoasymdsaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptoasymdsaSeries::std(self : CryptoasymdsaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptoasymdsaSeries::median(self : CryptoasymdsaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptoasymdsaSeries::scale(self : CryptoasymdsaSeries, f : Double) -> CryptoasymdsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptoasymdsaSeries::add(self : CryptoasymdsaSeries, other : CryptoasymdsaSeries) -> CryptoasymdsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptoasymdsaSeries::sub(self : CryptoasymdsaSeries, other : CryptoasymdsaSeries) -> CryptoasymdsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptoasymdsaSeries::normalize(self : CryptoasymdsaSeries) -> CryptoasymdsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptoasymdsaSeries::cumsum(self : CryptoasymdsaSeries) -> CryptoasymdsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptoasymdsaSeries::to_string(self : CryptoasymdsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymdsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_dsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymdsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_dsa_matrix_identity(n : Int) -> CryptoasymdsaMatrix {
  let m = crypto_asym_dsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptoasymdsaMatrix::get(self : CryptoasymdsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptoasymdsaMatrix::transpose(self : CryptoasymdsaMatrix) -> CryptoasymdsaMatrix {
  let result = crypto_asym_dsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptoasymdsaMatrix::add(self : CryptoasymdsaMatrix, other : CryptoasymdsaMatrix) -> CryptoasymdsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_dsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptoasymdsaMatrix::scale(self : CryptoasymdsaMatrix, s : Double) -> CryptoasymdsaMatrix {
  let result = crypto_asym_dsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptoasymdsaMatrix::multiply(self : CryptoasymdsaMatrix, other : CryptoasymdsaMatrix) -> CryptoasymdsaMatrix {
  if self.cols != other.rows { return crypto_asym_dsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_dsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptoasymdsaMatrix::trace(self : CryptoasymdsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptoasymdsaMatrix::det(self : CryptoasymdsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptoasymdsaMatrix::norm(self : CryptoasymdsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptoasymdsaMatrix::to_string(self : CryptoasymdsaMatrix) -> String {
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

pub(all) struct CryptoasymdsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_dsa_make_vector(comps : Array[Double]) -> CryptoasymdsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_dsa_vector_zero(dim : Int) -> CryptoasymdsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptoasymdsaVector::add(self : CryptoasymdsaVector, other : CryptoasymdsaVector) -> CryptoasymdsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymdsaVector::sub(self : CryptoasymdsaVector, other : CryptoasymdsaVector) -> CryptoasymdsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymdsaVector::scale(self : CryptoasymdsaVector, s : Double) -> CryptoasymdsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptoasymdsaVector::dot(self : CryptoasymdsaVector, other : CryptoasymdsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptoasymdsaVector::norm(self : CryptoasymdsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptoasymdsaVector::normalize(self : CryptoasymdsaVector) -> CryptoasymdsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymdsaVector::dist(self : CryptoasymdsaVector, other : CryptoasymdsaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptoasymdsaVector::to_string(self : CryptoasymdsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_dsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_dsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_dsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_dsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_dsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_dsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_dsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_dsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_dsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_dsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_dsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_dsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_dsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_dsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_dsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_dsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_dsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_dsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_dsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_dsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_dsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_dsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_dsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_dsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_dsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_dsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_dsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_dsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_dsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymdsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_frame_make(size : Int) -> CryptoasymdsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdsaFrame::len(self : CryptoasymdsaFrame) -> Int { self.size }

pub fn CryptoasymdsaFrame::get(self : CryptoasymdsaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdsaFrame::set(self : CryptoasymdsaFrame, i : Int, v : Double) -> CryptoasymdsaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaFrame::sum(self : CryptoasymdsaFrame) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdsaFrame::mean(self : CryptoasymdsaFrame) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdsaFrame::scale(self : CryptoasymdsaFrame, f : Double) -> CryptoasymdsaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaFrame::add(self : CryptoasymdsaFrame, other : CryptoasymdsaFrame) -> CryptoasymdsaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdsaFrame::copy(self : CryptoasymdsaFrame) -> CryptoasymdsaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaFrame::fill(self : CryptoasymdsaFrame, v : Double) -> CryptoasymdsaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaFrame::min(self : CryptoasymdsaFrame) -> Double { @_common.min(self.data) }

pub fn CryptoasymdsaFrame::max(self : CryptoasymdsaFrame) -> Double { @_common.max(self.data) }

pub fn CryptoasymdsaFrame::to_string(self : CryptoasymdsaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_table_make(size : Int) -> CryptoasymdsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdsaTable::len(self : CryptoasymdsaTable) -> Int { self.size }

pub fn CryptoasymdsaTable::get(self : CryptoasymdsaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdsaTable::set(self : CryptoasymdsaTable, i : Int, v : Double) -> CryptoasymdsaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaTable::sum(self : CryptoasymdsaTable) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdsaTable::mean(self : CryptoasymdsaTable) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdsaTable::scale(self : CryptoasymdsaTable, f : Double) -> CryptoasymdsaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaTable::add(self : CryptoasymdsaTable, other : CryptoasymdsaTable) -> CryptoasymdsaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdsaTable::copy(self : CryptoasymdsaTable) -> CryptoasymdsaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaTable::fill(self : CryptoasymdsaTable, v : Double) -> CryptoasymdsaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaTable::min(self : CryptoasymdsaTable) -> Double { @_common.min(self.data) }

pub fn CryptoasymdsaTable::max(self : CryptoasymdsaTable) -> Double { @_common.max(self.data) }

pub fn CryptoasymdsaTable::to_string(self : CryptoasymdsaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_graphn_make(size : Int) -> CryptoasymdsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdsaGraphN::len(self : CryptoasymdsaGraphN) -> Int { self.size }

pub fn CryptoasymdsaGraphN::get(self : CryptoasymdsaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdsaGraphN::set(self : CryptoasymdsaGraphN, i : Int, v : Double) -> CryptoasymdsaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaGraphN::sum(self : CryptoasymdsaGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdsaGraphN::mean(self : CryptoasymdsaGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdsaGraphN::scale(self : CryptoasymdsaGraphN, f : Double) -> CryptoasymdsaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaGraphN::add(self : CryptoasymdsaGraphN, other : CryptoasymdsaGraphN) -> CryptoasymdsaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdsaGraphN::copy(self : CryptoasymdsaGraphN) -> CryptoasymdsaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaGraphN::fill(self : CryptoasymdsaGraphN, v : Double) -> CryptoasymdsaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaGraphN::min(self : CryptoasymdsaGraphN) -> Double { @_common.min(self.data) }

pub fn CryptoasymdsaGraphN::max(self : CryptoasymdsaGraphN) -> Double { @_common.max(self.data) }

pub fn CryptoasymdsaGraphN::to_string(self : CryptoasymdsaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_node_make(size : Int) -> CryptoasymdsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdsaNode::len(self : CryptoasymdsaNode) -> Int { self.size }

pub fn CryptoasymdsaNode::get(self : CryptoasymdsaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdsaNode::set(self : CryptoasymdsaNode, i : Int, v : Double) -> CryptoasymdsaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaNode::sum(self : CryptoasymdsaNode) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdsaNode::mean(self : CryptoasymdsaNode) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdsaNode::scale(self : CryptoasymdsaNode, f : Double) -> CryptoasymdsaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaNode::add(self : CryptoasymdsaNode, other : CryptoasymdsaNode) -> CryptoasymdsaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdsaNode::copy(self : CryptoasymdsaNode) -> CryptoasymdsaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaNode::fill(self : CryptoasymdsaNode, v : Double) -> CryptoasymdsaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaNode::min(self : CryptoasymdsaNode) -> Double { @_common.min(self.data) }

pub fn CryptoasymdsaNode::max(self : CryptoasymdsaNode) -> Double { @_common.max(self.data) }

pub fn CryptoasymdsaNode::to_string(self : CryptoasymdsaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_edge_make(size : Int) -> CryptoasymdsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdsaEdge::len(self : CryptoasymdsaEdge) -> Int { self.size }

pub fn CryptoasymdsaEdge::get(self : CryptoasymdsaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdsaEdge::set(self : CryptoasymdsaEdge, i : Int, v : Double) -> CryptoasymdsaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaEdge::sum(self : CryptoasymdsaEdge) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdsaEdge::mean(self : CryptoasymdsaEdge) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdsaEdge::scale(self : CryptoasymdsaEdge, f : Double) -> CryptoasymdsaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaEdge::add(self : CryptoasymdsaEdge, other : CryptoasymdsaEdge) -> CryptoasymdsaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdsaEdge::copy(self : CryptoasymdsaEdge) -> CryptoasymdsaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaEdge::fill(self : CryptoasymdsaEdge, v : Double) -> CryptoasymdsaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaEdge::min(self : CryptoasymdsaEdge) -> Double { @_common.min(self.data) }

pub fn CryptoasymdsaEdge::max(self : CryptoasymdsaEdge) -> Double { @_common.max(self.data) }

pub fn CryptoasymdsaEdge::to_string(self : CryptoasymdsaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_path_make(size : Int) -> CryptoasymdsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdsaPath::len(self : CryptoasymdsaPath) -> Int { self.size }

pub fn CryptoasymdsaPath::get(self : CryptoasymdsaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdsaPath::set(self : CryptoasymdsaPath, i : Int, v : Double) -> CryptoasymdsaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaPath::sum(self : CryptoasymdsaPath) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdsaPath::mean(self : CryptoasymdsaPath) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdsaPath::scale(self : CryptoasymdsaPath, f : Double) -> CryptoasymdsaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaPath::add(self : CryptoasymdsaPath, other : CryptoasymdsaPath) -> CryptoasymdsaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdsaPath::copy(self : CryptoasymdsaPath) -> CryptoasymdsaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaPath::fill(self : CryptoasymdsaPath, v : Double) -> CryptoasymdsaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaPath::min(self : CryptoasymdsaPath) -> Double { @_common.min(self.data) }

pub fn CryptoasymdsaPath::max(self : CryptoasymdsaPath) -> Double { @_common.max(self.data) }

pub fn CryptoasymdsaPath::to_string(self : CryptoasymdsaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_cluster_make(size : Int) -> CryptoasymdsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdsaCluster::len(self : CryptoasymdsaCluster) -> Int { self.size }

pub fn CryptoasymdsaCluster::get(self : CryptoasymdsaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdsaCluster::set(self : CryptoasymdsaCluster, i : Int, v : Double) -> CryptoasymdsaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaCluster::sum(self : CryptoasymdsaCluster) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdsaCluster::mean(self : CryptoasymdsaCluster) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdsaCluster::scale(self : CryptoasymdsaCluster, f : Double) -> CryptoasymdsaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaCluster::add(self : CryptoasymdsaCluster, other : CryptoasymdsaCluster) -> CryptoasymdsaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdsaCluster::copy(self : CryptoasymdsaCluster) -> CryptoasymdsaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaCluster::fill(self : CryptoasymdsaCluster, v : Double) -> CryptoasymdsaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaCluster::min(self : CryptoasymdsaCluster) -> Double { @_common.min(self.data) }

pub fn CryptoasymdsaCluster::max(self : CryptoasymdsaCluster) -> Double { @_common.max(self.data) }

pub fn CryptoasymdsaCluster::to_string(self : CryptoasymdsaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_model_make(size : Int) -> CryptoasymdsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdsaModel::len(self : CryptoasymdsaModel) -> Int { self.size }

pub fn CryptoasymdsaModel::get(self : CryptoasymdsaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdsaModel::set(self : CryptoasymdsaModel, i : Int, v : Double) -> CryptoasymdsaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaModel::sum(self : CryptoasymdsaModel) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdsaModel::mean(self : CryptoasymdsaModel) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdsaModel::scale(self : CryptoasymdsaModel, f : Double) -> CryptoasymdsaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaModel::add(self : CryptoasymdsaModel, other : CryptoasymdsaModel) -> CryptoasymdsaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdsaModel::copy(self : CryptoasymdsaModel) -> CryptoasymdsaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaModel::fill(self : CryptoasymdsaModel, v : Double) -> CryptoasymdsaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaModel::min(self : CryptoasymdsaModel) -> Double { @_common.min(self.data) }

pub fn CryptoasymdsaModel::max(self : CryptoasymdsaModel) -> Double { @_common.max(self.data) }

pub fn CryptoasymdsaModel::to_string(self : CryptoasymdsaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_layer_make(size : Int) -> CryptoasymdsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdsaLayer::len(self : CryptoasymdsaLayer) -> Int { self.size }

pub fn CryptoasymdsaLayer::get(self : CryptoasymdsaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdsaLayer::set(self : CryptoasymdsaLayer, i : Int, v : Double) -> CryptoasymdsaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaLayer::sum(self : CryptoasymdsaLayer) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdsaLayer::mean(self : CryptoasymdsaLayer) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdsaLayer::scale(self : CryptoasymdsaLayer, f : Double) -> CryptoasymdsaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaLayer::add(self : CryptoasymdsaLayer, other : CryptoasymdsaLayer) -> CryptoasymdsaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdsaLayer::copy(self : CryptoasymdsaLayer) -> CryptoasymdsaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaLayer::fill(self : CryptoasymdsaLayer, v : Double) -> CryptoasymdsaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaLayer::min(self : CryptoasymdsaLayer) -> Double { @_common.min(self.data) }

pub fn CryptoasymdsaLayer::max(self : CryptoasymdsaLayer) -> Double { @_common.max(self.data) }

pub fn CryptoasymdsaLayer::to_string(self : CryptoasymdsaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_buffer_make(size : Int) -> CryptoasymdsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdsaBuffer::len(self : CryptoasymdsaBuffer) -> Int { self.size }

pub fn CryptoasymdsaBuffer::get(self : CryptoasymdsaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdsaBuffer::set(self : CryptoasymdsaBuffer, i : Int, v : Double) -> CryptoasymdsaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaBuffer::sum(self : CryptoasymdsaBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdsaBuffer::mean(self : CryptoasymdsaBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdsaBuffer::scale(self : CryptoasymdsaBuffer, f : Double) -> CryptoasymdsaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaBuffer::add(self : CryptoasymdsaBuffer, other : CryptoasymdsaBuffer) -> CryptoasymdsaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdsaBuffer::copy(self : CryptoasymdsaBuffer) -> CryptoasymdsaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaBuffer::fill(self : CryptoasymdsaBuffer, v : Double) -> CryptoasymdsaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaBuffer::min(self : CryptoasymdsaBuffer) -> Double { @_common.min(self.data) }

pub fn CryptoasymdsaBuffer::max(self : CryptoasymdsaBuffer) -> Double { @_common.max(self.data) }

pub fn CryptoasymdsaBuffer::to_string(self : CryptoasymdsaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_cursor_make(size : Int) -> CryptoasymdsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdsaCursor::len(self : CryptoasymdsaCursor) -> Int { self.size }

pub fn CryptoasymdsaCursor::get(self : CryptoasymdsaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdsaCursor::set(self : CryptoasymdsaCursor, i : Int, v : Double) -> CryptoasymdsaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaCursor::sum(self : CryptoasymdsaCursor) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdsaCursor::mean(self : CryptoasymdsaCursor) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdsaCursor::scale(self : CryptoasymdsaCursor, f : Double) -> CryptoasymdsaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaCursor::add(self : CryptoasymdsaCursor, other : CryptoasymdsaCursor) -> CryptoasymdsaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdsaCursor::copy(self : CryptoasymdsaCursor) -> CryptoasymdsaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaCursor::fill(self : CryptoasymdsaCursor, v : Double) -> CryptoasymdsaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaCursor::min(self : CryptoasymdsaCursor) -> Double { @_common.min(self.data) }

pub fn CryptoasymdsaCursor::max(self : CryptoasymdsaCursor) -> Double { @_common.max(self.data) }

pub fn CryptoasymdsaCursor::to_string(self : CryptoasymdsaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_view_make(size : Int) -> CryptoasymdsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdsaView::len(self : CryptoasymdsaView) -> Int { self.size }

pub fn CryptoasymdsaView::get(self : CryptoasymdsaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdsaView::set(self : CryptoasymdsaView, i : Int, v : Double) -> CryptoasymdsaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaView::sum(self : CryptoasymdsaView) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdsaView::mean(self : CryptoasymdsaView) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdsaView::scale(self : CryptoasymdsaView, f : Double) -> CryptoasymdsaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaView::add(self : CryptoasymdsaView, other : CryptoasymdsaView) -> CryptoasymdsaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdsaView::copy(self : CryptoasymdsaView) -> CryptoasymdsaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaView::fill(self : CryptoasymdsaView, v : Double) -> CryptoasymdsaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaView::min(self : CryptoasymdsaView) -> Double { @_common.min(self.data) }

pub fn CryptoasymdsaView::max(self : CryptoasymdsaView) -> Double { @_common.max(self.data) }

pub fn CryptoasymdsaView::to_string(self : CryptoasymdsaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_range_make(size : Int) -> CryptoasymdsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdsaRange::len(self : CryptoasymdsaRange) -> Int { self.size }

pub fn CryptoasymdsaRange::get(self : CryptoasymdsaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdsaRange::set(self : CryptoasymdsaRange, i : Int, v : Double) -> CryptoasymdsaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaRange::sum(self : CryptoasymdsaRange) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdsaRange::mean(self : CryptoasymdsaRange) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdsaRange::scale(self : CryptoasymdsaRange, f : Double) -> CryptoasymdsaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaRange::add(self : CryptoasymdsaRange, other : CryptoasymdsaRange) -> CryptoasymdsaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdsaRange::copy(self : CryptoasymdsaRange) -> CryptoasymdsaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaRange::fill(self : CryptoasymdsaRange, v : Double) -> CryptoasymdsaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaRange::min(self : CryptoasymdsaRange) -> Double { @_common.min(self.data) }

pub fn CryptoasymdsaRange::max(self : CryptoasymdsaRange) -> Double { @_common.max(self.data) }

pub fn CryptoasymdsaRange::to_string(self : CryptoasymdsaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptoasymdsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_dsa_slice_make(size : Int) -> CryptoasymdsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptoasymdsaSlice::len(self : CryptoasymdsaSlice) -> Int { self.size }

pub fn CryptoasymdsaSlice::get(self : CryptoasymdsaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptoasymdsaSlice::set(self : CryptoasymdsaSlice, i : Int, v : Double) -> CryptoasymdsaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaSlice::sum(self : CryptoasymdsaSlice) -> Double { @_common.sum(self.data) }

pub fn CryptoasymdsaSlice::mean(self : CryptoasymdsaSlice) -> Double { @_common.mean(self.data) }

pub fn CryptoasymdsaSlice::scale(self : CryptoasymdsaSlice, f : Double) -> CryptoasymdsaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaSlice::add(self : CryptoasymdsaSlice, other : CryptoasymdsaSlice) -> CryptoasymdsaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptoasymdsaSlice::copy(self : CryptoasymdsaSlice) -> CryptoasymdsaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaSlice::fill(self : CryptoasymdsaSlice, v : Double) -> CryptoasymdsaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptoasymdsaSlice::min(self : CryptoasymdsaSlice) -> Double { @_common.min(self.data) }

pub fn CryptoasymdsaSlice::max(self : CryptoasymdsaSlice) -> Double { @_common.max(self.data) }

pub fn CryptoasymdsaSlice::to_string(self : CryptoasymdsaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

