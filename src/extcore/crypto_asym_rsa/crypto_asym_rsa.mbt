///===
/// extcore/crypto_asym_rsa

pub(all) struct CryptoasymrsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_asym_rsa_make_point(x : Double, y : Double) -> CryptoasymrsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_asym_rsa_make_point3(x : Double, y : Double, z : Double) -> CryptoasymrsaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptoasymrsaPoint::x(self : CryptoasymrsaPoint) -> Double { self.x }

pub fn CryptoasymrsaPoint::y(self : CryptoasymrsaPoint) -> Double { self.y }

pub fn CryptoasymrsaPoint::z(self : CryptoasymrsaPoint) -> Double { self.z }

pub fn CryptoasymrsaPoint::label(self : CryptoasymrsaPoint) -> Int { self.label }

pub fn CryptoasymrsaPoint::dist(self : CryptoasymrsaPoint, other : CryptoasymrsaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptoasymrsaPoint::add(self : CryptoasymrsaPoint, other : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptoasymrsaPoint::sub(self : CryptoasymrsaPoint, other : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptoasymrsaPoint::scale(self : CryptoasymrsaPoint, s : Double) -> CryptoasymrsaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptoasymrsaPoint::dot(self : CryptoasymrsaPoint, other : CryptoasymrsaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptoasymrsaPoint::cross(self : CryptoasymrsaPoint, other : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptoasymrsaPoint::norm(self : CryptoasymrsaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptoasymrsaPoint::normalize(self : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymrsaPoint::negate(self : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptoasymrsaPoint::mid(self : CryptoasymrsaPoint, other : CryptoasymrsaPoint) -> CryptoasymrsaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptoasymrsaPoint::lerp(self : CryptoasymrsaPoint, other : CryptoasymrsaPoint, t : Double) -> CryptoasymrsaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptoasymrsaPoint::to_string(self : CryptoasymrsaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptoasymrsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_asym_rsa_make_series(vals : Array[Double], name : String) -> CryptoasymrsaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptoasymrsaSeries::len(self : CryptoasymrsaSeries) -> Int { self.vals.length() }

pub fn CryptoasymrsaSeries::sum(self : CryptoasymrsaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptoasymrsaSeries::mean(self : CryptoasymrsaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptoasymrsaSeries::min(self : CryptoasymrsaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptoasymrsaSeries::max(self : CryptoasymrsaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptoasymrsaSeries::range(self : CryptoasymrsaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptoasymrsaSeries::variance(self : CryptoasymrsaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptoasymrsaSeries::std(self : CryptoasymrsaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptoasymrsaSeries::median(self : CryptoasymrsaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptoasymrsaSeries::scale(self : CryptoasymrsaSeries, f : Double) -> CryptoasymrsaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptoasymrsaSeries::add(self : CryptoasymrsaSeries, other : CryptoasymrsaSeries) -> CryptoasymrsaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptoasymrsaSeries::sub(self : CryptoasymrsaSeries, other : CryptoasymrsaSeries) -> CryptoasymrsaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptoasymrsaSeries::normalize(self : CryptoasymrsaSeries) -> CryptoasymrsaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptoasymrsaSeries::cumsum(self : CryptoasymrsaSeries) -> CryptoasymrsaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptoasymrsaSeries::to_string(self : CryptoasymrsaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptoasymrsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_asym_rsa_make_matrix(rows : Int, cols : Int, val : Double) -> CryptoasymrsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_asym_rsa_matrix_identity(n : Int) -> CryptoasymrsaMatrix {
  let m = crypto_asym_rsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptoasymrsaMatrix::get(self : CryptoasymrsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptoasymrsaMatrix::transpose(self : CryptoasymrsaMatrix) -> CryptoasymrsaMatrix {
  let result = crypto_asym_rsa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptoasymrsaMatrix::add(self : CryptoasymrsaMatrix, other : CryptoasymrsaMatrix) -> CryptoasymrsaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_asym_rsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptoasymrsaMatrix::scale(self : CryptoasymrsaMatrix, s : Double) -> CryptoasymrsaMatrix {
  let result = crypto_asym_rsa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptoasymrsaMatrix::multiply(self : CryptoasymrsaMatrix, other : CryptoasymrsaMatrix) -> CryptoasymrsaMatrix {
  if self.cols != other.rows { return crypto_asym_rsa_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_asym_rsa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptoasymrsaMatrix::trace(self : CryptoasymrsaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptoasymrsaMatrix::det(self : CryptoasymrsaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptoasymrsaMatrix::norm(self : CryptoasymrsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptoasymrsaMatrix::to_string(self : CryptoasymrsaMatrix) -> String {
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

pub(all) struct CryptoasymrsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_asym_rsa_make_vector(comps : Array[Double]) -> CryptoasymrsaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_asym_rsa_vector_zero(dim : Int) -> CryptoasymrsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptoasymrsaVector::add(self : CryptoasymrsaVector, other : CryptoasymrsaVector) -> CryptoasymrsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymrsaVector::sub(self : CryptoasymrsaVector, other : CryptoasymrsaVector) -> CryptoasymrsaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptoasymrsaVector::scale(self : CryptoasymrsaVector, s : Double) -> CryptoasymrsaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptoasymrsaVector::dot(self : CryptoasymrsaVector, other : CryptoasymrsaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptoasymrsaVector::norm(self : CryptoasymrsaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptoasymrsaVector::normalize(self : CryptoasymrsaVector) -> CryptoasymrsaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptoasymrsaVector::dist(self : CryptoasymrsaVector, other : CryptoasymrsaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptoasymrsaVector::to_string(self : CryptoasymrsaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_asym_rsa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_asym_rsa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_asym_rsa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_asym_rsa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_asym_rsa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_asym_rsa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_asym_rsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_asym_rsa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_asym_rsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_asym_rsa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_asym_rsa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_asym_rsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_asym_rsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_asym_rsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_asym_rsa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_asym_rsa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_asym_rsa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_asym_rsa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_asym_rsa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_asym_rsa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_asym_rsa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_asym_rsa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_asym_rsa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_asym_rsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_asym_rsa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_asym_rsa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_asym_rsa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_asym_rsa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_asym_rsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptoasymrsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_frame_make(size : Int) -> CryptoasymrsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_frame_len(s : CryptoasymrsaFrame) -> Int { s.size }

pub fn crypto_asym_rsa_frame_get(s : CryptoasymrsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_frame_set(s : CryptoasymrsaFrame, i : Int, v : Double) -> CryptoasymrsaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_frame_sum(s : CryptoasymrsaFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_frame_mean(s : CryptoasymrsaFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_frame_scale(s : CryptoasymrsaFrame, f : Double) -> CryptoasymrsaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_frame_add(a : CryptoasymrsaFrame, b : CryptoasymrsaFrame) -> CryptoasymrsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_frame_copy(s : CryptoasymrsaFrame) -> CryptoasymrsaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_frame_fill(s : CryptoasymrsaFrame, v : Double) -> CryptoasymrsaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_frame_min(s : CryptoasymrsaFrame) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_frame_max(s : CryptoasymrsaFrame) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_frame_to_string(s : CryptoasymrsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_table_make(size : Int) -> CryptoasymrsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_table_len(s : CryptoasymrsaTable) -> Int { s.size }

pub fn crypto_asym_rsa_table_get(s : CryptoasymrsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_table_set(s : CryptoasymrsaTable, i : Int, v : Double) -> CryptoasymrsaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_table_sum(s : CryptoasymrsaTable) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_table_mean(s : CryptoasymrsaTable) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_table_scale(s : CryptoasymrsaTable, f : Double) -> CryptoasymrsaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_table_add(a : CryptoasymrsaTable, b : CryptoasymrsaTable) -> CryptoasymrsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_table_copy(s : CryptoasymrsaTable) -> CryptoasymrsaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_table_fill(s : CryptoasymrsaTable, v : Double) -> CryptoasymrsaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_table_min(s : CryptoasymrsaTable) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_table_max(s : CryptoasymrsaTable) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_table_to_string(s : CryptoasymrsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_graphn_make(size : Int) -> CryptoasymrsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_graphn_len(s : CryptoasymrsaGraphN) -> Int { s.size }

pub fn crypto_asym_rsa_graphn_get(s : CryptoasymrsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_graphn_set(s : CryptoasymrsaGraphN, i : Int, v : Double) -> CryptoasymrsaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_graphn_sum(s : CryptoasymrsaGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_graphn_mean(s : CryptoasymrsaGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_graphn_scale(s : CryptoasymrsaGraphN, f : Double) -> CryptoasymrsaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_graphn_add(a : CryptoasymrsaGraphN, b : CryptoasymrsaGraphN) -> CryptoasymrsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_graphn_copy(s : CryptoasymrsaGraphN) -> CryptoasymrsaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_graphn_fill(s : CryptoasymrsaGraphN, v : Double) -> CryptoasymrsaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_graphn_min(s : CryptoasymrsaGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_graphn_max(s : CryptoasymrsaGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_graphn_to_string(s : CryptoasymrsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_node_make(size : Int) -> CryptoasymrsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_node_len(s : CryptoasymrsaNode) -> Int { s.size }

pub fn crypto_asym_rsa_node_get(s : CryptoasymrsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_node_set(s : CryptoasymrsaNode, i : Int, v : Double) -> CryptoasymrsaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_node_sum(s : CryptoasymrsaNode) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_node_mean(s : CryptoasymrsaNode) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_node_scale(s : CryptoasymrsaNode, f : Double) -> CryptoasymrsaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_node_add(a : CryptoasymrsaNode, b : CryptoasymrsaNode) -> CryptoasymrsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_node_copy(s : CryptoasymrsaNode) -> CryptoasymrsaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_node_fill(s : CryptoasymrsaNode, v : Double) -> CryptoasymrsaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_node_min(s : CryptoasymrsaNode) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_node_max(s : CryptoasymrsaNode) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_node_to_string(s : CryptoasymrsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_edge_make(size : Int) -> CryptoasymrsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_edge_len(s : CryptoasymrsaEdge) -> Int { s.size }

pub fn crypto_asym_rsa_edge_get(s : CryptoasymrsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_edge_set(s : CryptoasymrsaEdge, i : Int, v : Double) -> CryptoasymrsaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_edge_sum(s : CryptoasymrsaEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_edge_mean(s : CryptoasymrsaEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_edge_scale(s : CryptoasymrsaEdge, f : Double) -> CryptoasymrsaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_edge_add(a : CryptoasymrsaEdge, b : CryptoasymrsaEdge) -> CryptoasymrsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_edge_copy(s : CryptoasymrsaEdge) -> CryptoasymrsaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_edge_fill(s : CryptoasymrsaEdge, v : Double) -> CryptoasymrsaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_edge_min(s : CryptoasymrsaEdge) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_edge_max(s : CryptoasymrsaEdge) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_edge_to_string(s : CryptoasymrsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_path_make(size : Int) -> CryptoasymrsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_path_len(s : CryptoasymrsaPath) -> Int { s.size }

pub fn crypto_asym_rsa_path_get(s : CryptoasymrsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_path_set(s : CryptoasymrsaPath, i : Int, v : Double) -> CryptoasymrsaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_path_sum(s : CryptoasymrsaPath) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_path_mean(s : CryptoasymrsaPath) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_path_scale(s : CryptoasymrsaPath, f : Double) -> CryptoasymrsaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_path_add(a : CryptoasymrsaPath, b : CryptoasymrsaPath) -> CryptoasymrsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_path_copy(s : CryptoasymrsaPath) -> CryptoasymrsaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_path_fill(s : CryptoasymrsaPath, v : Double) -> CryptoasymrsaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_path_min(s : CryptoasymrsaPath) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_path_max(s : CryptoasymrsaPath) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_path_to_string(s : CryptoasymrsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_cluster_make(size : Int) -> CryptoasymrsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_cluster_len(s : CryptoasymrsaCluster) -> Int { s.size }

pub fn crypto_asym_rsa_cluster_get(s : CryptoasymrsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_cluster_set(s : CryptoasymrsaCluster, i : Int, v : Double) -> CryptoasymrsaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cluster_sum(s : CryptoasymrsaCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_cluster_mean(s : CryptoasymrsaCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_cluster_scale(s : CryptoasymrsaCluster, f : Double) -> CryptoasymrsaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cluster_add(a : CryptoasymrsaCluster, b : CryptoasymrsaCluster) -> CryptoasymrsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_cluster_copy(s : CryptoasymrsaCluster) -> CryptoasymrsaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cluster_fill(s : CryptoasymrsaCluster, v : Double) -> CryptoasymrsaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cluster_min(s : CryptoasymrsaCluster) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_cluster_max(s : CryptoasymrsaCluster) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_cluster_to_string(s : CryptoasymrsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_model_make(size : Int) -> CryptoasymrsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_model_len(s : CryptoasymrsaModel) -> Int { s.size }

pub fn crypto_asym_rsa_model_get(s : CryptoasymrsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_model_set(s : CryptoasymrsaModel, i : Int, v : Double) -> CryptoasymrsaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_model_sum(s : CryptoasymrsaModel) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_model_mean(s : CryptoasymrsaModel) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_model_scale(s : CryptoasymrsaModel, f : Double) -> CryptoasymrsaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_model_add(a : CryptoasymrsaModel, b : CryptoasymrsaModel) -> CryptoasymrsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_model_copy(s : CryptoasymrsaModel) -> CryptoasymrsaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_model_fill(s : CryptoasymrsaModel, v : Double) -> CryptoasymrsaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_model_min(s : CryptoasymrsaModel) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_model_max(s : CryptoasymrsaModel) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_model_to_string(s : CryptoasymrsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_layer_make(size : Int) -> CryptoasymrsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_layer_len(s : CryptoasymrsaLayer) -> Int { s.size }

pub fn crypto_asym_rsa_layer_get(s : CryptoasymrsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_layer_set(s : CryptoasymrsaLayer, i : Int, v : Double) -> CryptoasymrsaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_layer_sum(s : CryptoasymrsaLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_layer_mean(s : CryptoasymrsaLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_layer_scale(s : CryptoasymrsaLayer, f : Double) -> CryptoasymrsaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_layer_add(a : CryptoasymrsaLayer, b : CryptoasymrsaLayer) -> CryptoasymrsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_layer_copy(s : CryptoasymrsaLayer) -> CryptoasymrsaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_layer_fill(s : CryptoasymrsaLayer, v : Double) -> CryptoasymrsaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_layer_min(s : CryptoasymrsaLayer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_layer_max(s : CryptoasymrsaLayer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_layer_to_string(s : CryptoasymrsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_buffer_make(size : Int) -> CryptoasymrsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_buffer_len(s : CryptoasymrsaBuffer) -> Int { s.size }

pub fn crypto_asym_rsa_buffer_get(s : CryptoasymrsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_buffer_set(s : CryptoasymrsaBuffer, i : Int, v : Double) -> CryptoasymrsaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_buffer_sum(s : CryptoasymrsaBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_buffer_mean(s : CryptoasymrsaBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_buffer_scale(s : CryptoasymrsaBuffer, f : Double) -> CryptoasymrsaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_buffer_add(a : CryptoasymrsaBuffer, b : CryptoasymrsaBuffer) -> CryptoasymrsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_buffer_copy(s : CryptoasymrsaBuffer) -> CryptoasymrsaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_buffer_fill(s : CryptoasymrsaBuffer, v : Double) -> CryptoasymrsaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_buffer_min(s : CryptoasymrsaBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_buffer_max(s : CryptoasymrsaBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_buffer_to_string(s : CryptoasymrsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_cursor_make(size : Int) -> CryptoasymrsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_cursor_len(s : CryptoasymrsaCursor) -> Int { s.size }

pub fn crypto_asym_rsa_cursor_get(s : CryptoasymrsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_cursor_set(s : CryptoasymrsaCursor, i : Int, v : Double) -> CryptoasymrsaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cursor_sum(s : CryptoasymrsaCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_cursor_mean(s : CryptoasymrsaCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_cursor_scale(s : CryptoasymrsaCursor, f : Double) -> CryptoasymrsaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cursor_add(a : CryptoasymrsaCursor, b : CryptoasymrsaCursor) -> CryptoasymrsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_cursor_copy(s : CryptoasymrsaCursor) -> CryptoasymrsaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cursor_fill(s : CryptoasymrsaCursor, v : Double) -> CryptoasymrsaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_cursor_min(s : CryptoasymrsaCursor) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_cursor_max(s : CryptoasymrsaCursor) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_cursor_to_string(s : CryptoasymrsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_view_make(size : Int) -> CryptoasymrsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_view_len(s : CryptoasymrsaView) -> Int { s.size }

pub fn crypto_asym_rsa_view_get(s : CryptoasymrsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_view_set(s : CryptoasymrsaView, i : Int, v : Double) -> CryptoasymrsaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_view_sum(s : CryptoasymrsaView) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_view_mean(s : CryptoasymrsaView) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_view_scale(s : CryptoasymrsaView, f : Double) -> CryptoasymrsaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_view_add(a : CryptoasymrsaView, b : CryptoasymrsaView) -> CryptoasymrsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_view_copy(s : CryptoasymrsaView) -> CryptoasymrsaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_view_fill(s : CryptoasymrsaView, v : Double) -> CryptoasymrsaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_view_min(s : CryptoasymrsaView) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_view_max(s : CryptoasymrsaView) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_view_to_string(s : CryptoasymrsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_range_make(size : Int) -> CryptoasymrsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_range_len(s : CryptoasymrsaRange) -> Int { s.size }

pub fn crypto_asym_rsa_range_get(s : CryptoasymrsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_range_set(s : CryptoasymrsaRange, i : Int, v : Double) -> CryptoasymrsaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_range_sum(s : CryptoasymrsaRange) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_range_mean(s : CryptoasymrsaRange) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_range_scale(s : CryptoasymrsaRange, f : Double) -> CryptoasymrsaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_range_add(a : CryptoasymrsaRange, b : CryptoasymrsaRange) -> CryptoasymrsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_range_copy(s : CryptoasymrsaRange) -> CryptoasymrsaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_range_fill(s : CryptoasymrsaRange, v : Double) -> CryptoasymrsaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_range_min(s : CryptoasymrsaRange) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_range_max(s : CryptoasymrsaRange) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_range_to_string(s : CryptoasymrsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptoasymrsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_asym_rsa_slice_make(size : Int) -> CryptoasymrsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_asym_rsa_slice_len(s : CryptoasymrsaSlice) -> Int { s.size }

pub fn crypto_asym_rsa_slice_get(s : CryptoasymrsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_asym_rsa_slice_set(s : CryptoasymrsaSlice, i : Int, v : Double) -> CryptoasymrsaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_slice_sum(s : CryptoasymrsaSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_asym_rsa_slice_mean(s : CryptoasymrsaSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_asym_rsa_slice_scale(s : CryptoasymrsaSlice, f : Double) -> CryptoasymrsaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_slice_add(a : CryptoasymrsaSlice, b : CryptoasymrsaSlice) -> CryptoasymrsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_asym_rsa_slice_copy(s : CryptoasymrsaSlice) -> CryptoasymrsaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_slice_fill(s : CryptoasymrsaSlice, v : Double) -> CryptoasymrsaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_asym_rsa_slice_min(s : CryptoasymrsaSlice) -> Double { @_common.min(s.data) }

pub fn crypto_asym_rsa_slice_max(s : CryptoasymrsaSlice) -> Double { @_common.max(s.data) }

pub fn crypto_asym_rsa_slice_to_string(s : CryptoasymrsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

