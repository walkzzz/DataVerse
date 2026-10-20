///===
/// extcore/crypto_sym_blowfish

pub(all) struct CryptosymblowfishPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_blowfish_make_point(x : Double, y : Double) -> CryptosymblowfishPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_blowfish_make_point3(x : Double, y : Double, z : Double) -> CryptosymblowfishPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosymblowfishPoint::x(self : CryptosymblowfishPoint) -> Double { self.x }

pub fn CryptosymblowfishPoint::y(self : CryptosymblowfishPoint) -> Double { self.y }

pub fn CryptosymblowfishPoint::z(self : CryptosymblowfishPoint) -> Double { self.z }

pub fn CryptosymblowfishPoint::label(self : CryptosymblowfishPoint) -> Int { self.label }

pub fn CryptosymblowfishPoint::dist(self : CryptosymblowfishPoint, other : CryptosymblowfishPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosymblowfishPoint::add(self : CryptosymblowfishPoint, other : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosymblowfishPoint::sub(self : CryptosymblowfishPoint, other : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosymblowfishPoint::scale(self : CryptosymblowfishPoint, s : Double) -> CryptosymblowfishPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosymblowfishPoint::dot(self : CryptosymblowfishPoint, other : CryptosymblowfishPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosymblowfishPoint::cross(self : CryptosymblowfishPoint, other : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosymblowfishPoint::norm(self : CryptosymblowfishPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosymblowfishPoint::normalize(self : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymblowfishPoint::negate(self : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosymblowfishPoint::mid(self : CryptosymblowfishPoint, other : CryptosymblowfishPoint) -> CryptosymblowfishPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosymblowfishPoint::lerp(self : CryptosymblowfishPoint, other : CryptosymblowfishPoint, t : Double) -> CryptosymblowfishPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosymblowfishPoint::to_string(self : CryptosymblowfishPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosymblowfishSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_blowfish_make_series(vals : Array[Double], name : String) -> CryptosymblowfishSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosymblowfishSeries::len(self : CryptosymblowfishSeries) -> Int { self.vals.length() }

pub fn CryptosymblowfishSeries::sum(self : CryptosymblowfishSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosymblowfishSeries::mean(self : CryptosymblowfishSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosymblowfishSeries::min(self : CryptosymblowfishSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosymblowfishSeries::max(self : CryptosymblowfishSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosymblowfishSeries::range(self : CryptosymblowfishSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosymblowfishSeries::variance(self : CryptosymblowfishSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosymblowfishSeries::std(self : CryptosymblowfishSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosymblowfishSeries::median(self : CryptosymblowfishSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosymblowfishSeries::scale(self : CryptosymblowfishSeries, f : Double) -> CryptosymblowfishSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosymblowfishSeries::add(self : CryptosymblowfishSeries, other : CryptosymblowfishSeries) -> CryptosymblowfishSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosymblowfishSeries::sub(self : CryptosymblowfishSeries, other : CryptosymblowfishSeries) -> CryptosymblowfishSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosymblowfishSeries::normalize(self : CryptosymblowfishSeries) -> CryptosymblowfishSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosymblowfishSeries::cumsum(self : CryptosymblowfishSeries) -> CryptosymblowfishSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosymblowfishSeries::to_string(self : CryptosymblowfishSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymblowfishMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_blowfish_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymblowfishMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_blowfish_matrix_identity(n : Int) -> CryptosymblowfishMatrix {
  let m = crypto_sym_blowfish_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosymblowfishMatrix::get(self : CryptosymblowfishMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosymblowfishMatrix::transpose(self : CryptosymblowfishMatrix) -> CryptosymblowfishMatrix {
  let result = crypto_sym_blowfish_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosymblowfishMatrix::add(self : CryptosymblowfishMatrix, other : CryptosymblowfishMatrix) -> CryptosymblowfishMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_blowfish_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosymblowfishMatrix::scale(self : CryptosymblowfishMatrix, s : Double) -> CryptosymblowfishMatrix {
  let result = crypto_sym_blowfish_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosymblowfishMatrix::multiply(self : CryptosymblowfishMatrix, other : CryptosymblowfishMatrix) -> CryptosymblowfishMatrix {
  if self.cols != other.rows { return crypto_sym_blowfish_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_blowfish_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosymblowfishMatrix::trace(self : CryptosymblowfishMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosymblowfishMatrix::det(self : CryptosymblowfishMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosymblowfishMatrix::norm(self : CryptosymblowfishMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosymblowfishMatrix::to_string(self : CryptosymblowfishMatrix) -> String {
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

pub(all) struct CryptosymblowfishVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_blowfish_make_vector(comps : Array[Double]) -> CryptosymblowfishVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_blowfish_vector_zero(dim : Int) -> CryptosymblowfishVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosymblowfishVector::add(self : CryptosymblowfishVector, other : CryptosymblowfishVector) -> CryptosymblowfishVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymblowfishVector::sub(self : CryptosymblowfishVector, other : CryptosymblowfishVector) -> CryptosymblowfishVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymblowfishVector::scale(self : CryptosymblowfishVector, s : Double) -> CryptosymblowfishVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosymblowfishVector::dot(self : CryptosymblowfishVector, other : CryptosymblowfishVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosymblowfishVector::norm(self : CryptosymblowfishVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosymblowfishVector::normalize(self : CryptosymblowfishVector) -> CryptosymblowfishVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymblowfishVector::dist(self : CryptosymblowfishVector, other : CryptosymblowfishVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosymblowfishVector::to_string(self : CryptosymblowfishVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_blowfish_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_blowfish_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_blowfish_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_blowfish_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_blowfish_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_blowfish_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_blowfish_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_blowfish_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_blowfish_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_blowfish_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_blowfish_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_blowfish_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_blowfish_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_blowfish_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_blowfish_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_blowfish_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_blowfish_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_blowfish_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_blowfish_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_blowfish_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_blowfish_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_blowfish_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_blowfish_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_blowfish_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_blowfish_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_blowfish_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_blowfish_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_blowfish_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_blowfish_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosymblowfishFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_frame_make(size : Int) -> CryptosymblowfishFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymblowfishFrame::len(self : CryptosymblowfishFrame) -> Int { self.size }

pub fn CryptosymblowfishFrame::get(self : CryptosymblowfishFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymblowfishFrame::set(self : CryptosymblowfishFrame, i : Int, v : Double) -> CryptosymblowfishFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishFrame::sum(self : CryptosymblowfishFrame) -> Double { @_common.sum(self.data) }

pub fn CryptosymblowfishFrame::mean(self : CryptosymblowfishFrame) -> Double { @_common.mean(self.data) }

pub fn CryptosymblowfishFrame::scale(self : CryptosymblowfishFrame, f : Double) -> CryptosymblowfishFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishFrame::add(self : CryptosymblowfishFrame, other : CryptosymblowfishFrame) -> CryptosymblowfishFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymblowfishFrame::copy(self : CryptosymblowfishFrame) -> CryptosymblowfishFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishFrame::fill(self : CryptosymblowfishFrame, v : Double) -> CryptosymblowfishFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishFrame::min(self : CryptosymblowfishFrame) -> Double { @_common.min(self.data) }

pub fn CryptosymblowfishFrame::max(self : CryptosymblowfishFrame) -> Double { @_common.max(self.data) }

pub fn CryptosymblowfishFrame::to_string(self : CryptosymblowfishFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_table_make(size : Int) -> CryptosymblowfishTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymblowfishTable::len(self : CryptosymblowfishTable) -> Int { self.size }

pub fn CryptosymblowfishTable::get(self : CryptosymblowfishTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymblowfishTable::set(self : CryptosymblowfishTable, i : Int, v : Double) -> CryptosymblowfishTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishTable::sum(self : CryptosymblowfishTable) -> Double { @_common.sum(self.data) }

pub fn CryptosymblowfishTable::mean(self : CryptosymblowfishTable) -> Double { @_common.mean(self.data) }

pub fn CryptosymblowfishTable::scale(self : CryptosymblowfishTable, f : Double) -> CryptosymblowfishTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishTable::add(self : CryptosymblowfishTable, other : CryptosymblowfishTable) -> CryptosymblowfishTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymblowfishTable::copy(self : CryptosymblowfishTable) -> CryptosymblowfishTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishTable::fill(self : CryptosymblowfishTable, v : Double) -> CryptosymblowfishTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishTable::min(self : CryptosymblowfishTable) -> Double { @_common.min(self.data) }

pub fn CryptosymblowfishTable::max(self : CryptosymblowfishTable) -> Double { @_common.max(self.data) }

pub fn CryptosymblowfishTable::to_string(self : CryptosymblowfishTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_graphn_make(size : Int) -> CryptosymblowfishGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymblowfishGraphN::len(self : CryptosymblowfishGraphN) -> Int { self.size }

pub fn CryptosymblowfishGraphN::get(self : CryptosymblowfishGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymblowfishGraphN::set(self : CryptosymblowfishGraphN, i : Int, v : Double) -> CryptosymblowfishGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishGraphN::sum(self : CryptosymblowfishGraphN) -> Double { @_common.sum(self.data) }

pub fn CryptosymblowfishGraphN::mean(self : CryptosymblowfishGraphN) -> Double { @_common.mean(self.data) }

pub fn CryptosymblowfishGraphN::scale(self : CryptosymblowfishGraphN, f : Double) -> CryptosymblowfishGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishGraphN::add(self : CryptosymblowfishGraphN, other : CryptosymblowfishGraphN) -> CryptosymblowfishGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymblowfishGraphN::copy(self : CryptosymblowfishGraphN) -> CryptosymblowfishGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishGraphN::fill(self : CryptosymblowfishGraphN, v : Double) -> CryptosymblowfishGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishGraphN::min(self : CryptosymblowfishGraphN) -> Double { @_common.min(self.data) }

pub fn CryptosymblowfishGraphN::max(self : CryptosymblowfishGraphN) -> Double { @_common.max(self.data) }

pub fn CryptosymblowfishGraphN::to_string(self : CryptosymblowfishGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_node_make(size : Int) -> CryptosymblowfishNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymblowfishNode::len(self : CryptosymblowfishNode) -> Int { self.size }

pub fn CryptosymblowfishNode::get(self : CryptosymblowfishNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymblowfishNode::set(self : CryptosymblowfishNode, i : Int, v : Double) -> CryptosymblowfishNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishNode::sum(self : CryptosymblowfishNode) -> Double { @_common.sum(self.data) }

pub fn CryptosymblowfishNode::mean(self : CryptosymblowfishNode) -> Double { @_common.mean(self.data) }

pub fn CryptosymblowfishNode::scale(self : CryptosymblowfishNode, f : Double) -> CryptosymblowfishNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishNode::add(self : CryptosymblowfishNode, other : CryptosymblowfishNode) -> CryptosymblowfishNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymblowfishNode::copy(self : CryptosymblowfishNode) -> CryptosymblowfishNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishNode::fill(self : CryptosymblowfishNode, v : Double) -> CryptosymblowfishNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishNode::min(self : CryptosymblowfishNode) -> Double { @_common.min(self.data) }

pub fn CryptosymblowfishNode::max(self : CryptosymblowfishNode) -> Double { @_common.max(self.data) }

pub fn CryptosymblowfishNode::to_string(self : CryptosymblowfishNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_edge_make(size : Int) -> CryptosymblowfishEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymblowfishEdge::len(self : CryptosymblowfishEdge) -> Int { self.size }

pub fn CryptosymblowfishEdge::get(self : CryptosymblowfishEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymblowfishEdge::set(self : CryptosymblowfishEdge, i : Int, v : Double) -> CryptosymblowfishEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishEdge::sum(self : CryptosymblowfishEdge) -> Double { @_common.sum(self.data) }

pub fn CryptosymblowfishEdge::mean(self : CryptosymblowfishEdge) -> Double { @_common.mean(self.data) }

pub fn CryptosymblowfishEdge::scale(self : CryptosymblowfishEdge, f : Double) -> CryptosymblowfishEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishEdge::add(self : CryptosymblowfishEdge, other : CryptosymblowfishEdge) -> CryptosymblowfishEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymblowfishEdge::copy(self : CryptosymblowfishEdge) -> CryptosymblowfishEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishEdge::fill(self : CryptosymblowfishEdge, v : Double) -> CryptosymblowfishEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishEdge::min(self : CryptosymblowfishEdge) -> Double { @_common.min(self.data) }

pub fn CryptosymblowfishEdge::max(self : CryptosymblowfishEdge) -> Double { @_common.max(self.data) }

pub fn CryptosymblowfishEdge::to_string(self : CryptosymblowfishEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_path_make(size : Int) -> CryptosymblowfishPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymblowfishPath::len(self : CryptosymblowfishPath) -> Int { self.size }

pub fn CryptosymblowfishPath::get(self : CryptosymblowfishPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymblowfishPath::set(self : CryptosymblowfishPath, i : Int, v : Double) -> CryptosymblowfishPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishPath::sum(self : CryptosymblowfishPath) -> Double { @_common.sum(self.data) }

pub fn CryptosymblowfishPath::mean(self : CryptosymblowfishPath) -> Double { @_common.mean(self.data) }

pub fn CryptosymblowfishPath::scale(self : CryptosymblowfishPath, f : Double) -> CryptosymblowfishPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishPath::add(self : CryptosymblowfishPath, other : CryptosymblowfishPath) -> CryptosymblowfishPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymblowfishPath::copy(self : CryptosymblowfishPath) -> CryptosymblowfishPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishPath::fill(self : CryptosymblowfishPath, v : Double) -> CryptosymblowfishPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishPath::min(self : CryptosymblowfishPath) -> Double { @_common.min(self.data) }

pub fn CryptosymblowfishPath::max(self : CryptosymblowfishPath) -> Double { @_common.max(self.data) }

pub fn CryptosymblowfishPath::to_string(self : CryptosymblowfishPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_cluster_make(size : Int) -> CryptosymblowfishCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymblowfishCluster::len(self : CryptosymblowfishCluster) -> Int { self.size }

pub fn CryptosymblowfishCluster::get(self : CryptosymblowfishCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymblowfishCluster::set(self : CryptosymblowfishCluster, i : Int, v : Double) -> CryptosymblowfishCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishCluster::sum(self : CryptosymblowfishCluster) -> Double { @_common.sum(self.data) }

pub fn CryptosymblowfishCluster::mean(self : CryptosymblowfishCluster) -> Double { @_common.mean(self.data) }

pub fn CryptosymblowfishCluster::scale(self : CryptosymblowfishCluster, f : Double) -> CryptosymblowfishCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishCluster::add(self : CryptosymblowfishCluster, other : CryptosymblowfishCluster) -> CryptosymblowfishCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymblowfishCluster::copy(self : CryptosymblowfishCluster) -> CryptosymblowfishCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishCluster::fill(self : CryptosymblowfishCluster, v : Double) -> CryptosymblowfishCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishCluster::min(self : CryptosymblowfishCluster) -> Double { @_common.min(self.data) }

pub fn CryptosymblowfishCluster::max(self : CryptosymblowfishCluster) -> Double { @_common.max(self.data) }

pub fn CryptosymblowfishCluster::to_string(self : CryptosymblowfishCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_model_make(size : Int) -> CryptosymblowfishModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymblowfishModel::len(self : CryptosymblowfishModel) -> Int { self.size }

pub fn CryptosymblowfishModel::get(self : CryptosymblowfishModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymblowfishModel::set(self : CryptosymblowfishModel, i : Int, v : Double) -> CryptosymblowfishModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishModel::sum(self : CryptosymblowfishModel) -> Double { @_common.sum(self.data) }

pub fn CryptosymblowfishModel::mean(self : CryptosymblowfishModel) -> Double { @_common.mean(self.data) }

pub fn CryptosymblowfishModel::scale(self : CryptosymblowfishModel, f : Double) -> CryptosymblowfishModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishModel::add(self : CryptosymblowfishModel, other : CryptosymblowfishModel) -> CryptosymblowfishModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymblowfishModel::copy(self : CryptosymblowfishModel) -> CryptosymblowfishModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishModel::fill(self : CryptosymblowfishModel, v : Double) -> CryptosymblowfishModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishModel::min(self : CryptosymblowfishModel) -> Double { @_common.min(self.data) }

pub fn CryptosymblowfishModel::max(self : CryptosymblowfishModel) -> Double { @_common.max(self.data) }

pub fn CryptosymblowfishModel::to_string(self : CryptosymblowfishModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_layer_make(size : Int) -> CryptosymblowfishLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymblowfishLayer::len(self : CryptosymblowfishLayer) -> Int { self.size }

pub fn CryptosymblowfishLayer::get(self : CryptosymblowfishLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymblowfishLayer::set(self : CryptosymblowfishLayer, i : Int, v : Double) -> CryptosymblowfishLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishLayer::sum(self : CryptosymblowfishLayer) -> Double { @_common.sum(self.data) }

pub fn CryptosymblowfishLayer::mean(self : CryptosymblowfishLayer) -> Double { @_common.mean(self.data) }

pub fn CryptosymblowfishLayer::scale(self : CryptosymblowfishLayer, f : Double) -> CryptosymblowfishLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishLayer::add(self : CryptosymblowfishLayer, other : CryptosymblowfishLayer) -> CryptosymblowfishLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymblowfishLayer::copy(self : CryptosymblowfishLayer) -> CryptosymblowfishLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishLayer::fill(self : CryptosymblowfishLayer, v : Double) -> CryptosymblowfishLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishLayer::min(self : CryptosymblowfishLayer) -> Double { @_common.min(self.data) }

pub fn CryptosymblowfishLayer::max(self : CryptosymblowfishLayer) -> Double { @_common.max(self.data) }

pub fn CryptosymblowfishLayer::to_string(self : CryptosymblowfishLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_buffer_make(size : Int) -> CryptosymblowfishBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymblowfishBuffer::len(self : CryptosymblowfishBuffer) -> Int { self.size }

pub fn CryptosymblowfishBuffer::get(self : CryptosymblowfishBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymblowfishBuffer::set(self : CryptosymblowfishBuffer, i : Int, v : Double) -> CryptosymblowfishBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishBuffer::sum(self : CryptosymblowfishBuffer) -> Double { @_common.sum(self.data) }

pub fn CryptosymblowfishBuffer::mean(self : CryptosymblowfishBuffer) -> Double { @_common.mean(self.data) }

pub fn CryptosymblowfishBuffer::scale(self : CryptosymblowfishBuffer, f : Double) -> CryptosymblowfishBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishBuffer::add(self : CryptosymblowfishBuffer, other : CryptosymblowfishBuffer) -> CryptosymblowfishBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymblowfishBuffer::copy(self : CryptosymblowfishBuffer) -> CryptosymblowfishBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishBuffer::fill(self : CryptosymblowfishBuffer, v : Double) -> CryptosymblowfishBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishBuffer::min(self : CryptosymblowfishBuffer) -> Double { @_common.min(self.data) }

pub fn CryptosymblowfishBuffer::max(self : CryptosymblowfishBuffer) -> Double { @_common.max(self.data) }

pub fn CryptosymblowfishBuffer::to_string(self : CryptosymblowfishBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_cursor_make(size : Int) -> CryptosymblowfishCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymblowfishCursor::len(self : CryptosymblowfishCursor) -> Int { self.size }

pub fn CryptosymblowfishCursor::get(self : CryptosymblowfishCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymblowfishCursor::set(self : CryptosymblowfishCursor, i : Int, v : Double) -> CryptosymblowfishCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishCursor::sum(self : CryptosymblowfishCursor) -> Double { @_common.sum(self.data) }

pub fn CryptosymblowfishCursor::mean(self : CryptosymblowfishCursor) -> Double { @_common.mean(self.data) }

pub fn CryptosymblowfishCursor::scale(self : CryptosymblowfishCursor, f : Double) -> CryptosymblowfishCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishCursor::add(self : CryptosymblowfishCursor, other : CryptosymblowfishCursor) -> CryptosymblowfishCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymblowfishCursor::copy(self : CryptosymblowfishCursor) -> CryptosymblowfishCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishCursor::fill(self : CryptosymblowfishCursor, v : Double) -> CryptosymblowfishCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishCursor::min(self : CryptosymblowfishCursor) -> Double { @_common.min(self.data) }

pub fn CryptosymblowfishCursor::max(self : CryptosymblowfishCursor) -> Double { @_common.max(self.data) }

pub fn CryptosymblowfishCursor::to_string(self : CryptosymblowfishCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_view_make(size : Int) -> CryptosymblowfishView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymblowfishView::len(self : CryptosymblowfishView) -> Int { self.size }

pub fn CryptosymblowfishView::get(self : CryptosymblowfishView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymblowfishView::set(self : CryptosymblowfishView, i : Int, v : Double) -> CryptosymblowfishView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishView::sum(self : CryptosymblowfishView) -> Double { @_common.sum(self.data) }

pub fn CryptosymblowfishView::mean(self : CryptosymblowfishView) -> Double { @_common.mean(self.data) }

pub fn CryptosymblowfishView::scale(self : CryptosymblowfishView, f : Double) -> CryptosymblowfishView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishView::add(self : CryptosymblowfishView, other : CryptosymblowfishView) -> CryptosymblowfishView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymblowfishView::copy(self : CryptosymblowfishView) -> CryptosymblowfishView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishView::fill(self : CryptosymblowfishView, v : Double) -> CryptosymblowfishView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishView::min(self : CryptosymblowfishView) -> Double { @_common.min(self.data) }

pub fn CryptosymblowfishView::max(self : CryptosymblowfishView) -> Double { @_common.max(self.data) }

pub fn CryptosymblowfishView::to_string(self : CryptosymblowfishView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_range_make(size : Int) -> CryptosymblowfishRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymblowfishRange::len(self : CryptosymblowfishRange) -> Int { self.size }

pub fn CryptosymblowfishRange::get(self : CryptosymblowfishRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymblowfishRange::set(self : CryptosymblowfishRange, i : Int, v : Double) -> CryptosymblowfishRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishRange::sum(self : CryptosymblowfishRange) -> Double { @_common.sum(self.data) }

pub fn CryptosymblowfishRange::mean(self : CryptosymblowfishRange) -> Double { @_common.mean(self.data) }

pub fn CryptosymblowfishRange::scale(self : CryptosymblowfishRange, f : Double) -> CryptosymblowfishRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishRange::add(self : CryptosymblowfishRange, other : CryptosymblowfishRange) -> CryptosymblowfishRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymblowfishRange::copy(self : CryptosymblowfishRange) -> CryptosymblowfishRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishRange::fill(self : CryptosymblowfishRange, v : Double) -> CryptosymblowfishRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishRange::min(self : CryptosymblowfishRange) -> Double { @_common.min(self.data) }

pub fn CryptosymblowfishRange::max(self : CryptosymblowfishRange) -> Double { @_common.max(self.data) }

pub fn CryptosymblowfishRange::to_string(self : CryptosymblowfishRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct CryptosymblowfishSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_blowfish_slice_make(size : Int) -> CryptosymblowfishSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn CryptosymblowfishSlice::len(self : CryptosymblowfishSlice) -> Int { self.size }

pub fn CryptosymblowfishSlice::get(self : CryptosymblowfishSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn CryptosymblowfishSlice::set(self : CryptosymblowfishSlice, i : Int, v : Double) -> CryptosymblowfishSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishSlice::sum(self : CryptosymblowfishSlice) -> Double { @_common.sum(self.data) }

pub fn CryptosymblowfishSlice::mean(self : CryptosymblowfishSlice) -> Double { @_common.mean(self.data) }

pub fn CryptosymblowfishSlice::scale(self : CryptosymblowfishSlice, f : Double) -> CryptosymblowfishSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishSlice::add(self : CryptosymblowfishSlice, other : CryptosymblowfishSlice) -> CryptosymblowfishSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn CryptosymblowfishSlice::copy(self : CryptosymblowfishSlice) -> CryptosymblowfishSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishSlice::fill(self : CryptosymblowfishSlice, v : Double) -> CryptosymblowfishSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn CryptosymblowfishSlice::min(self : CryptosymblowfishSlice) -> Double { @_common.min(self.data) }

pub fn CryptosymblowfishSlice::max(self : CryptosymblowfishSlice) -> Double { @_common.max(self.data) }

pub fn CryptosymblowfishSlice::to_string(self : CryptosymblowfishSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

