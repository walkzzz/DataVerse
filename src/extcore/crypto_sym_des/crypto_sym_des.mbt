///===
/// extcore/crypto_sym_des

pub(all) struct CryptosymdesPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_des_make_point(x : Double, y : Double) -> CryptosymdesPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_des_make_point3(x : Double, y : Double, z : Double) -> CryptosymdesPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosymdesPoint::x(self : CryptosymdesPoint) -> Double { self.x }

pub fn CryptosymdesPoint::y(self : CryptosymdesPoint) -> Double { self.y }

pub fn CryptosymdesPoint::z(self : CryptosymdesPoint) -> Double { self.z }

pub fn CryptosymdesPoint::label(self : CryptosymdesPoint) -> Int { self.label }

pub fn CryptosymdesPoint::dist(self : CryptosymdesPoint, other : CryptosymdesPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosymdesPoint::add(self : CryptosymdesPoint, other : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosymdesPoint::sub(self : CryptosymdesPoint, other : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosymdesPoint::scale(self : CryptosymdesPoint, s : Double) -> CryptosymdesPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosymdesPoint::dot(self : CryptosymdesPoint, other : CryptosymdesPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosymdesPoint::cross(self : CryptosymdesPoint, other : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosymdesPoint::norm(self : CryptosymdesPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosymdesPoint::normalize(self : CryptosymdesPoint) -> CryptosymdesPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymdesPoint::negate(self : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosymdesPoint::mid(self : CryptosymdesPoint, other : CryptosymdesPoint) -> CryptosymdesPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosymdesPoint::lerp(self : CryptosymdesPoint, other : CryptosymdesPoint, t : Double) -> CryptosymdesPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosymdesPoint::to_string(self : CryptosymdesPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosymdesSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_des_make_series(vals : Array[Double], name : String) -> CryptosymdesSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosymdesSeries::len(self : CryptosymdesSeries) -> Int { self.vals.length() }

pub fn CryptosymdesSeries::sum(self : CryptosymdesSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosymdesSeries::mean(self : CryptosymdesSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosymdesSeries::min(self : CryptosymdesSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosymdesSeries::max(self : CryptosymdesSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosymdesSeries::range(self : CryptosymdesSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosymdesSeries::variance(self : CryptosymdesSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosymdesSeries::std(self : CryptosymdesSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosymdesSeries::median(self : CryptosymdesSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosymdesSeries::scale(self : CryptosymdesSeries, f : Double) -> CryptosymdesSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosymdesSeries::add(self : CryptosymdesSeries, other : CryptosymdesSeries) -> CryptosymdesSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosymdesSeries::sub(self : CryptosymdesSeries, other : CryptosymdesSeries) -> CryptosymdesSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosymdesSeries::normalize(self : CryptosymdesSeries) -> CryptosymdesSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosymdesSeries::cumsum(self : CryptosymdesSeries) -> CryptosymdesSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosymdesSeries::to_string(self : CryptosymdesSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymdesMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_des_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymdesMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_des_matrix_identity(n : Int) -> CryptosymdesMatrix {
  let m = crypto_sym_des_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosymdesMatrix::get(self : CryptosymdesMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosymdesMatrix::transpose(self : CryptosymdesMatrix) -> CryptosymdesMatrix {
  let result = crypto_sym_des_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosymdesMatrix::add(self : CryptosymdesMatrix, other : CryptosymdesMatrix) -> CryptosymdesMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_des_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosymdesMatrix::scale(self : CryptosymdesMatrix, s : Double) -> CryptosymdesMatrix {
  let result = crypto_sym_des_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosymdesMatrix::multiply(self : CryptosymdesMatrix, other : CryptosymdesMatrix) -> CryptosymdesMatrix {
  if self.cols != other.rows { return crypto_sym_des_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_des_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosymdesMatrix::trace(self : CryptosymdesMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosymdesMatrix::det(self : CryptosymdesMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosymdesMatrix::norm(self : CryptosymdesMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosymdesMatrix::to_string(self : CryptosymdesMatrix) -> String {
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

pub(all) struct CryptosymdesVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_des_make_vector(comps : Array[Double]) -> CryptosymdesVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_des_vector_zero(dim : Int) -> CryptosymdesVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosymdesVector::add(self : CryptosymdesVector, other : CryptosymdesVector) -> CryptosymdesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymdesVector::sub(self : CryptosymdesVector, other : CryptosymdesVector) -> CryptosymdesVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymdesVector::scale(self : CryptosymdesVector, s : Double) -> CryptosymdesVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosymdesVector::dot(self : CryptosymdesVector, other : CryptosymdesVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosymdesVector::norm(self : CryptosymdesVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosymdesVector::normalize(self : CryptosymdesVector) -> CryptosymdesVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymdesVector::dist(self : CryptosymdesVector, other : CryptosymdesVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosymdesVector::to_string(self : CryptosymdesVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_des_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_des_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_des_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_des_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_des_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_des_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_des_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_des_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_des_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_des_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_des_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_des_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_des_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_des_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_des_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_des_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_des_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_des_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_des_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_des_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_des_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_des_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_des_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_des_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_des_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_des_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_des_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_des_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_des_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosymdesFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_frame_make(size : Int) -> CryptosymdesFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_frame_len(s : CryptosymdesFrame) -> Int { s.size }

pub fn crypto_sym_des_frame_get(s : CryptosymdesFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_frame_set(s : CryptosymdesFrame, i : Int, v : Double) -> CryptosymdesFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_frame_sum(s : CryptosymdesFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_frame_mean(s : CryptosymdesFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_frame_scale(s : CryptosymdesFrame, f : Double) -> CryptosymdesFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_frame_add(a : CryptosymdesFrame, b : CryptosymdesFrame) -> CryptosymdesFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_frame_copy(s : CryptosymdesFrame) -> CryptosymdesFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_frame_fill(s : CryptosymdesFrame, v : Double) -> CryptosymdesFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_frame_min(s : CryptosymdesFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_frame_max(s : CryptosymdesFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_frame_to_string(s : CryptosymdesFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_table_make(size : Int) -> CryptosymdesTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_table_len(s : CryptosymdesTable) -> Int { s.size }

pub fn crypto_sym_des_table_get(s : CryptosymdesTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_table_set(s : CryptosymdesTable, i : Int, v : Double) -> CryptosymdesTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_table_sum(s : CryptosymdesTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_table_mean(s : CryptosymdesTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_table_scale(s : CryptosymdesTable, f : Double) -> CryptosymdesTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_table_add(a : CryptosymdesTable, b : CryptosymdesTable) -> CryptosymdesTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_table_copy(s : CryptosymdesTable) -> CryptosymdesTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_table_fill(s : CryptosymdesTable, v : Double) -> CryptosymdesTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_table_min(s : CryptosymdesTable) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_table_max(s : CryptosymdesTable) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_table_to_string(s : CryptosymdesTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_graphn_make(size : Int) -> CryptosymdesGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_graphn_len(s : CryptosymdesGraphN) -> Int { s.size }

pub fn crypto_sym_des_graphn_get(s : CryptosymdesGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_graphn_set(s : CryptosymdesGraphN, i : Int, v : Double) -> CryptosymdesGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_graphn_sum(s : CryptosymdesGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_graphn_mean(s : CryptosymdesGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_graphn_scale(s : CryptosymdesGraphN, f : Double) -> CryptosymdesGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_graphn_add(a : CryptosymdesGraphN, b : CryptosymdesGraphN) -> CryptosymdesGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_graphn_copy(s : CryptosymdesGraphN) -> CryptosymdesGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_graphn_fill(s : CryptosymdesGraphN, v : Double) -> CryptosymdesGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_graphn_min(s : CryptosymdesGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_graphn_max(s : CryptosymdesGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_graphn_to_string(s : CryptosymdesGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_node_make(size : Int) -> CryptosymdesNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_node_len(s : CryptosymdesNode) -> Int { s.size }

pub fn crypto_sym_des_node_get(s : CryptosymdesNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_node_set(s : CryptosymdesNode, i : Int, v : Double) -> CryptosymdesNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_node_sum(s : CryptosymdesNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_node_mean(s : CryptosymdesNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_node_scale(s : CryptosymdesNode, f : Double) -> CryptosymdesNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_node_add(a : CryptosymdesNode, b : CryptosymdesNode) -> CryptosymdesNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_node_copy(s : CryptosymdesNode) -> CryptosymdesNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_node_fill(s : CryptosymdesNode, v : Double) -> CryptosymdesNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_node_min(s : CryptosymdesNode) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_node_max(s : CryptosymdesNode) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_node_to_string(s : CryptosymdesNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_edge_make(size : Int) -> CryptosymdesEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_edge_len(s : CryptosymdesEdge) -> Int { s.size }

pub fn crypto_sym_des_edge_get(s : CryptosymdesEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_edge_set(s : CryptosymdesEdge, i : Int, v : Double) -> CryptosymdesEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_edge_sum(s : CryptosymdesEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_edge_mean(s : CryptosymdesEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_edge_scale(s : CryptosymdesEdge, f : Double) -> CryptosymdesEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_edge_add(a : CryptosymdesEdge, b : CryptosymdesEdge) -> CryptosymdesEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_edge_copy(s : CryptosymdesEdge) -> CryptosymdesEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_edge_fill(s : CryptosymdesEdge, v : Double) -> CryptosymdesEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_edge_min(s : CryptosymdesEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_edge_max(s : CryptosymdesEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_edge_to_string(s : CryptosymdesEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_path_make(size : Int) -> CryptosymdesPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_path_len(s : CryptosymdesPath) -> Int { s.size }

pub fn crypto_sym_des_path_get(s : CryptosymdesPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_path_set(s : CryptosymdesPath, i : Int, v : Double) -> CryptosymdesPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_path_sum(s : CryptosymdesPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_path_mean(s : CryptosymdesPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_path_scale(s : CryptosymdesPath, f : Double) -> CryptosymdesPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_path_add(a : CryptosymdesPath, b : CryptosymdesPath) -> CryptosymdesPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_path_copy(s : CryptosymdesPath) -> CryptosymdesPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_path_fill(s : CryptosymdesPath, v : Double) -> CryptosymdesPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_path_min(s : CryptosymdesPath) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_path_max(s : CryptosymdesPath) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_path_to_string(s : CryptosymdesPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_cluster_make(size : Int) -> CryptosymdesCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_cluster_len(s : CryptosymdesCluster) -> Int { s.size }

pub fn crypto_sym_des_cluster_get(s : CryptosymdesCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_cluster_set(s : CryptosymdesCluster, i : Int, v : Double) -> CryptosymdesCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_cluster_sum(s : CryptosymdesCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_cluster_mean(s : CryptosymdesCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_cluster_scale(s : CryptosymdesCluster, f : Double) -> CryptosymdesCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_cluster_add(a : CryptosymdesCluster, b : CryptosymdesCluster) -> CryptosymdesCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_cluster_copy(s : CryptosymdesCluster) -> CryptosymdesCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_cluster_fill(s : CryptosymdesCluster, v : Double) -> CryptosymdesCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_cluster_min(s : CryptosymdesCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_cluster_max(s : CryptosymdesCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_cluster_to_string(s : CryptosymdesCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_model_make(size : Int) -> CryptosymdesModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_model_len(s : CryptosymdesModel) -> Int { s.size }

pub fn crypto_sym_des_model_get(s : CryptosymdesModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_model_set(s : CryptosymdesModel, i : Int, v : Double) -> CryptosymdesModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_model_sum(s : CryptosymdesModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_model_mean(s : CryptosymdesModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_model_scale(s : CryptosymdesModel, f : Double) -> CryptosymdesModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_model_add(a : CryptosymdesModel, b : CryptosymdesModel) -> CryptosymdesModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_model_copy(s : CryptosymdesModel) -> CryptosymdesModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_model_fill(s : CryptosymdesModel, v : Double) -> CryptosymdesModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_model_min(s : CryptosymdesModel) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_model_max(s : CryptosymdesModel) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_model_to_string(s : CryptosymdesModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_layer_make(size : Int) -> CryptosymdesLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_layer_len(s : CryptosymdesLayer) -> Int { s.size }

pub fn crypto_sym_des_layer_get(s : CryptosymdesLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_layer_set(s : CryptosymdesLayer, i : Int, v : Double) -> CryptosymdesLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_layer_sum(s : CryptosymdesLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_layer_mean(s : CryptosymdesLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_layer_scale(s : CryptosymdesLayer, f : Double) -> CryptosymdesLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_layer_add(a : CryptosymdesLayer, b : CryptosymdesLayer) -> CryptosymdesLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_layer_copy(s : CryptosymdesLayer) -> CryptosymdesLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_layer_fill(s : CryptosymdesLayer, v : Double) -> CryptosymdesLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_layer_min(s : CryptosymdesLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_layer_max(s : CryptosymdesLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_layer_to_string(s : CryptosymdesLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_buffer_make(size : Int) -> CryptosymdesBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_buffer_len(s : CryptosymdesBuffer) -> Int { s.size }

pub fn crypto_sym_des_buffer_get(s : CryptosymdesBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_buffer_set(s : CryptosymdesBuffer, i : Int, v : Double) -> CryptosymdesBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_buffer_sum(s : CryptosymdesBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_buffer_mean(s : CryptosymdesBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_buffer_scale(s : CryptosymdesBuffer, f : Double) -> CryptosymdesBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_buffer_add(a : CryptosymdesBuffer, b : CryptosymdesBuffer) -> CryptosymdesBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_buffer_copy(s : CryptosymdesBuffer) -> CryptosymdesBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_buffer_fill(s : CryptosymdesBuffer, v : Double) -> CryptosymdesBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_buffer_min(s : CryptosymdesBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_buffer_max(s : CryptosymdesBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_buffer_to_string(s : CryptosymdesBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_cursor_make(size : Int) -> CryptosymdesCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_cursor_len(s : CryptosymdesCursor) -> Int { s.size }

pub fn crypto_sym_des_cursor_get(s : CryptosymdesCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_cursor_set(s : CryptosymdesCursor, i : Int, v : Double) -> CryptosymdesCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_cursor_sum(s : CryptosymdesCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_cursor_mean(s : CryptosymdesCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_cursor_scale(s : CryptosymdesCursor, f : Double) -> CryptosymdesCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_cursor_add(a : CryptosymdesCursor, b : CryptosymdesCursor) -> CryptosymdesCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_cursor_copy(s : CryptosymdesCursor) -> CryptosymdesCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_cursor_fill(s : CryptosymdesCursor, v : Double) -> CryptosymdesCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_cursor_min(s : CryptosymdesCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_cursor_max(s : CryptosymdesCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_cursor_to_string(s : CryptosymdesCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_view_make(size : Int) -> CryptosymdesView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_view_len(s : CryptosymdesView) -> Int { s.size }

pub fn crypto_sym_des_view_get(s : CryptosymdesView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_view_set(s : CryptosymdesView, i : Int, v : Double) -> CryptosymdesView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_view_sum(s : CryptosymdesView) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_view_mean(s : CryptosymdesView) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_view_scale(s : CryptosymdesView, f : Double) -> CryptosymdesView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_view_add(a : CryptosymdesView, b : CryptosymdesView) -> CryptosymdesView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_view_copy(s : CryptosymdesView) -> CryptosymdesView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_view_fill(s : CryptosymdesView, v : Double) -> CryptosymdesView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_view_min(s : CryptosymdesView) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_view_max(s : CryptosymdesView) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_view_to_string(s : CryptosymdesView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_range_make(size : Int) -> CryptosymdesRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_range_len(s : CryptosymdesRange) -> Int { s.size }

pub fn crypto_sym_des_range_get(s : CryptosymdesRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_range_set(s : CryptosymdesRange, i : Int, v : Double) -> CryptosymdesRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_range_sum(s : CryptosymdesRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_range_mean(s : CryptosymdesRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_range_scale(s : CryptosymdesRange, f : Double) -> CryptosymdesRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_range_add(a : CryptosymdesRange, b : CryptosymdesRange) -> CryptosymdesRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_range_copy(s : CryptosymdesRange) -> CryptosymdesRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_range_fill(s : CryptosymdesRange, v : Double) -> CryptosymdesRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_range_min(s : CryptosymdesRange) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_range_max(s : CryptosymdesRange) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_range_to_string(s : CryptosymdesRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymdesSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_des_slice_make(size : Int) -> CryptosymdesSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_des_slice_len(s : CryptosymdesSlice) -> Int { s.size }

pub fn crypto_sym_des_slice_get(s : CryptosymdesSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_des_slice_set(s : CryptosymdesSlice, i : Int, v : Double) -> CryptosymdesSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_slice_sum(s : CryptosymdesSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_des_slice_mean(s : CryptosymdesSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_des_slice_scale(s : CryptosymdesSlice, f : Double) -> CryptosymdesSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_slice_add(a : CryptosymdesSlice, b : CryptosymdesSlice) -> CryptosymdesSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_des_slice_copy(s : CryptosymdesSlice) -> CryptosymdesSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_slice_fill(s : CryptosymdesSlice, v : Double) -> CryptosymdesSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_des_slice_min(s : CryptosymdesSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sym_des_slice_max(s : CryptosymdesSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sym_des_slice_to_string(s : CryptosymdesSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

