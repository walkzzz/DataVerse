///===
/// extcore/crypto_sym_cast

pub(all) struct CryptosymcastPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_cast_make_point(x : Double, y : Double) -> CryptosymcastPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_cast_make_point3(x : Double, y : Double, z : Double) -> CryptosymcastPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosymcastPoint::x(self : CryptosymcastPoint) -> Double { self.x }

pub fn CryptosymcastPoint::y(self : CryptosymcastPoint) -> Double { self.y }

pub fn CryptosymcastPoint::z(self : CryptosymcastPoint) -> Double { self.z }

pub fn CryptosymcastPoint::label(self : CryptosymcastPoint) -> Int { self.label }

pub fn CryptosymcastPoint::dist(self : CryptosymcastPoint, other : CryptosymcastPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosymcastPoint::add(self : CryptosymcastPoint, other : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosymcastPoint::sub(self : CryptosymcastPoint, other : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosymcastPoint::scale(self : CryptosymcastPoint, s : Double) -> CryptosymcastPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosymcastPoint::dot(self : CryptosymcastPoint, other : CryptosymcastPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosymcastPoint::cross(self : CryptosymcastPoint, other : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosymcastPoint::norm(self : CryptosymcastPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosymcastPoint::normalize(self : CryptosymcastPoint) -> CryptosymcastPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymcastPoint::negate(self : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosymcastPoint::mid(self : CryptosymcastPoint, other : CryptosymcastPoint) -> CryptosymcastPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosymcastPoint::lerp(self : CryptosymcastPoint, other : CryptosymcastPoint, t : Double) -> CryptosymcastPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosymcastPoint::to_string(self : CryptosymcastPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosymcastSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_cast_make_series(vals : Array[Double], name : String) -> CryptosymcastSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosymcastSeries::len(self : CryptosymcastSeries) -> Int { self.vals.length() }

pub fn CryptosymcastSeries::sum(self : CryptosymcastSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosymcastSeries::mean(self : CryptosymcastSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosymcastSeries::min(self : CryptosymcastSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosymcastSeries::max(self : CryptosymcastSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosymcastSeries::range(self : CryptosymcastSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosymcastSeries::variance(self : CryptosymcastSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosymcastSeries::std(self : CryptosymcastSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosymcastSeries::median(self : CryptosymcastSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosymcastSeries::scale(self : CryptosymcastSeries, f : Double) -> CryptosymcastSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosymcastSeries::add(self : CryptosymcastSeries, other : CryptosymcastSeries) -> CryptosymcastSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosymcastSeries::sub(self : CryptosymcastSeries, other : CryptosymcastSeries) -> CryptosymcastSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosymcastSeries::normalize(self : CryptosymcastSeries) -> CryptosymcastSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosymcastSeries::cumsum(self : CryptosymcastSeries) -> CryptosymcastSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosymcastSeries::to_string(self : CryptosymcastSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymcastMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_cast_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymcastMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_cast_matrix_identity(n : Int) -> CryptosymcastMatrix {
  let m = crypto_sym_cast_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosymcastMatrix::get(self : CryptosymcastMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosymcastMatrix::transpose(self : CryptosymcastMatrix) -> CryptosymcastMatrix {
  let result = crypto_sym_cast_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosymcastMatrix::add(self : CryptosymcastMatrix, other : CryptosymcastMatrix) -> CryptosymcastMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_cast_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosymcastMatrix::scale(self : CryptosymcastMatrix, s : Double) -> CryptosymcastMatrix {
  let result = crypto_sym_cast_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosymcastMatrix::multiply(self : CryptosymcastMatrix, other : CryptosymcastMatrix) -> CryptosymcastMatrix {
  if self.cols != other.rows { return crypto_sym_cast_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_cast_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosymcastMatrix::trace(self : CryptosymcastMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosymcastMatrix::det(self : CryptosymcastMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosymcastMatrix::norm(self : CryptosymcastMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosymcastMatrix::to_string(self : CryptosymcastMatrix) -> String {
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

pub(all) struct CryptosymcastVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_cast_make_vector(comps : Array[Double]) -> CryptosymcastVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_cast_vector_zero(dim : Int) -> CryptosymcastVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosymcastVector::add(self : CryptosymcastVector, other : CryptosymcastVector) -> CryptosymcastVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymcastVector::sub(self : CryptosymcastVector, other : CryptosymcastVector) -> CryptosymcastVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymcastVector::scale(self : CryptosymcastVector, s : Double) -> CryptosymcastVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosymcastVector::dot(self : CryptosymcastVector, other : CryptosymcastVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosymcastVector::norm(self : CryptosymcastVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosymcastVector::normalize(self : CryptosymcastVector) -> CryptosymcastVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymcastVector::dist(self : CryptosymcastVector, other : CryptosymcastVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosymcastVector::to_string(self : CryptosymcastVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_cast_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_cast_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_cast_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_cast_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_cast_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_cast_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_cast_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_cast_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_cast_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_cast_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_cast_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_cast_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_cast_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_cast_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_cast_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_cast_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_cast_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_cast_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_cast_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_cast_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_cast_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_cast_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_cast_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_cast_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_cast_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_cast_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_cast_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_cast_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_cast_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosymcastFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_frame_make(size : Int) -> CryptosymcastFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_frame_len(s : CryptosymcastFrame) -> Int { s.size }

pub fn crypto_sym_cast_frame_get(s : CryptosymcastFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_frame_set(s : CryptosymcastFrame, i : Int, v : Double) -> CryptosymcastFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_frame_sum(s : CryptosymcastFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_frame_mean(s : CryptosymcastFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_frame_scale(s : CryptosymcastFrame, f : Double) -> CryptosymcastFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_frame_add(a : CryptosymcastFrame, b : CryptosymcastFrame) -> CryptosymcastFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_frame_copy(s : CryptosymcastFrame) -> CryptosymcastFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_frame_fill(s : CryptosymcastFrame, v : Double) -> CryptosymcastFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_frame_min(s : CryptosymcastFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_frame_max(s : CryptosymcastFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_frame_to_string(s : CryptosymcastFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_table_make(size : Int) -> CryptosymcastTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_table_len(s : CryptosymcastTable) -> Int { s.size }

pub fn crypto_sym_cast_table_get(s : CryptosymcastTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_table_set(s : CryptosymcastTable, i : Int, v : Double) -> CryptosymcastTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_table_sum(s : CryptosymcastTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_table_mean(s : CryptosymcastTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_table_scale(s : CryptosymcastTable, f : Double) -> CryptosymcastTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_table_add(a : CryptosymcastTable, b : CryptosymcastTable) -> CryptosymcastTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_table_copy(s : CryptosymcastTable) -> CryptosymcastTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_table_fill(s : CryptosymcastTable, v : Double) -> CryptosymcastTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_table_min(s : CryptosymcastTable) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_table_max(s : CryptosymcastTable) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_table_to_string(s : CryptosymcastTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_graphn_make(size : Int) -> CryptosymcastGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_graphn_len(s : CryptosymcastGraphN) -> Int { s.size }

pub fn crypto_sym_cast_graphn_get(s : CryptosymcastGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_graphn_set(s : CryptosymcastGraphN, i : Int, v : Double) -> CryptosymcastGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_graphn_sum(s : CryptosymcastGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_graphn_mean(s : CryptosymcastGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_graphn_scale(s : CryptosymcastGraphN, f : Double) -> CryptosymcastGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_graphn_add(a : CryptosymcastGraphN, b : CryptosymcastGraphN) -> CryptosymcastGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_graphn_copy(s : CryptosymcastGraphN) -> CryptosymcastGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_graphn_fill(s : CryptosymcastGraphN, v : Double) -> CryptosymcastGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_graphn_min(s : CryptosymcastGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_graphn_max(s : CryptosymcastGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_graphn_to_string(s : CryptosymcastGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_node_make(size : Int) -> CryptosymcastNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_node_len(s : CryptosymcastNode) -> Int { s.size }

pub fn crypto_sym_cast_node_get(s : CryptosymcastNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_node_set(s : CryptosymcastNode, i : Int, v : Double) -> CryptosymcastNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_node_sum(s : CryptosymcastNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_node_mean(s : CryptosymcastNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_node_scale(s : CryptosymcastNode, f : Double) -> CryptosymcastNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_node_add(a : CryptosymcastNode, b : CryptosymcastNode) -> CryptosymcastNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_node_copy(s : CryptosymcastNode) -> CryptosymcastNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_node_fill(s : CryptosymcastNode, v : Double) -> CryptosymcastNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_node_min(s : CryptosymcastNode) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_node_max(s : CryptosymcastNode) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_node_to_string(s : CryptosymcastNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_edge_make(size : Int) -> CryptosymcastEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_edge_len(s : CryptosymcastEdge) -> Int { s.size }

pub fn crypto_sym_cast_edge_get(s : CryptosymcastEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_edge_set(s : CryptosymcastEdge, i : Int, v : Double) -> CryptosymcastEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_edge_sum(s : CryptosymcastEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_edge_mean(s : CryptosymcastEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_edge_scale(s : CryptosymcastEdge, f : Double) -> CryptosymcastEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_edge_add(a : CryptosymcastEdge, b : CryptosymcastEdge) -> CryptosymcastEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_edge_copy(s : CryptosymcastEdge) -> CryptosymcastEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_edge_fill(s : CryptosymcastEdge, v : Double) -> CryptosymcastEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_edge_min(s : CryptosymcastEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_edge_max(s : CryptosymcastEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_edge_to_string(s : CryptosymcastEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_path_make(size : Int) -> CryptosymcastPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_path_len(s : CryptosymcastPath) -> Int { s.size }

pub fn crypto_sym_cast_path_get(s : CryptosymcastPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_path_set(s : CryptosymcastPath, i : Int, v : Double) -> CryptosymcastPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_path_sum(s : CryptosymcastPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_path_mean(s : CryptosymcastPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_path_scale(s : CryptosymcastPath, f : Double) -> CryptosymcastPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_path_add(a : CryptosymcastPath, b : CryptosymcastPath) -> CryptosymcastPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_path_copy(s : CryptosymcastPath) -> CryptosymcastPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_path_fill(s : CryptosymcastPath, v : Double) -> CryptosymcastPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_path_min(s : CryptosymcastPath) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_path_max(s : CryptosymcastPath) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_path_to_string(s : CryptosymcastPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_cluster_make(size : Int) -> CryptosymcastCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_cluster_len(s : CryptosymcastCluster) -> Int { s.size }

pub fn crypto_sym_cast_cluster_get(s : CryptosymcastCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_cluster_set(s : CryptosymcastCluster, i : Int, v : Double) -> CryptosymcastCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cluster_sum(s : CryptosymcastCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_cluster_mean(s : CryptosymcastCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_cluster_scale(s : CryptosymcastCluster, f : Double) -> CryptosymcastCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cluster_add(a : CryptosymcastCluster, b : CryptosymcastCluster) -> CryptosymcastCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_cluster_copy(s : CryptosymcastCluster) -> CryptosymcastCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cluster_fill(s : CryptosymcastCluster, v : Double) -> CryptosymcastCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cluster_min(s : CryptosymcastCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_cluster_max(s : CryptosymcastCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_cluster_to_string(s : CryptosymcastCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_model_make(size : Int) -> CryptosymcastModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_model_len(s : CryptosymcastModel) -> Int { s.size }

pub fn crypto_sym_cast_model_get(s : CryptosymcastModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_model_set(s : CryptosymcastModel, i : Int, v : Double) -> CryptosymcastModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_model_sum(s : CryptosymcastModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_model_mean(s : CryptosymcastModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_model_scale(s : CryptosymcastModel, f : Double) -> CryptosymcastModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_model_add(a : CryptosymcastModel, b : CryptosymcastModel) -> CryptosymcastModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_model_copy(s : CryptosymcastModel) -> CryptosymcastModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_model_fill(s : CryptosymcastModel, v : Double) -> CryptosymcastModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_model_min(s : CryptosymcastModel) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_model_max(s : CryptosymcastModel) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_model_to_string(s : CryptosymcastModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_layer_make(size : Int) -> CryptosymcastLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_layer_len(s : CryptosymcastLayer) -> Int { s.size }

pub fn crypto_sym_cast_layer_get(s : CryptosymcastLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_layer_set(s : CryptosymcastLayer, i : Int, v : Double) -> CryptosymcastLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_layer_sum(s : CryptosymcastLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_layer_mean(s : CryptosymcastLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_layer_scale(s : CryptosymcastLayer, f : Double) -> CryptosymcastLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_layer_add(a : CryptosymcastLayer, b : CryptosymcastLayer) -> CryptosymcastLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_layer_copy(s : CryptosymcastLayer) -> CryptosymcastLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_layer_fill(s : CryptosymcastLayer, v : Double) -> CryptosymcastLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_layer_min(s : CryptosymcastLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_layer_max(s : CryptosymcastLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_layer_to_string(s : CryptosymcastLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_buffer_make(size : Int) -> CryptosymcastBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_buffer_len(s : CryptosymcastBuffer) -> Int { s.size }

pub fn crypto_sym_cast_buffer_get(s : CryptosymcastBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_buffer_set(s : CryptosymcastBuffer, i : Int, v : Double) -> CryptosymcastBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_buffer_sum(s : CryptosymcastBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_buffer_mean(s : CryptosymcastBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_buffer_scale(s : CryptosymcastBuffer, f : Double) -> CryptosymcastBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_buffer_add(a : CryptosymcastBuffer, b : CryptosymcastBuffer) -> CryptosymcastBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_buffer_copy(s : CryptosymcastBuffer) -> CryptosymcastBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_buffer_fill(s : CryptosymcastBuffer, v : Double) -> CryptosymcastBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_buffer_min(s : CryptosymcastBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_buffer_max(s : CryptosymcastBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_buffer_to_string(s : CryptosymcastBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_cursor_make(size : Int) -> CryptosymcastCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_cursor_len(s : CryptosymcastCursor) -> Int { s.size }

pub fn crypto_sym_cast_cursor_get(s : CryptosymcastCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_cursor_set(s : CryptosymcastCursor, i : Int, v : Double) -> CryptosymcastCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cursor_sum(s : CryptosymcastCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_cursor_mean(s : CryptosymcastCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_cursor_scale(s : CryptosymcastCursor, f : Double) -> CryptosymcastCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cursor_add(a : CryptosymcastCursor, b : CryptosymcastCursor) -> CryptosymcastCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_cursor_copy(s : CryptosymcastCursor) -> CryptosymcastCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cursor_fill(s : CryptosymcastCursor, v : Double) -> CryptosymcastCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_cursor_min(s : CryptosymcastCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_cursor_max(s : CryptosymcastCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_cursor_to_string(s : CryptosymcastCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_view_make(size : Int) -> CryptosymcastView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_view_len(s : CryptosymcastView) -> Int { s.size }

pub fn crypto_sym_cast_view_get(s : CryptosymcastView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_view_set(s : CryptosymcastView, i : Int, v : Double) -> CryptosymcastView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_view_sum(s : CryptosymcastView) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_view_mean(s : CryptosymcastView) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_view_scale(s : CryptosymcastView, f : Double) -> CryptosymcastView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_view_add(a : CryptosymcastView, b : CryptosymcastView) -> CryptosymcastView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_view_copy(s : CryptosymcastView) -> CryptosymcastView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_view_fill(s : CryptosymcastView, v : Double) -> CryptosymcastView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_view_min(s : CryptosymcastView) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_view_max(s : CryptosymcastView) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_view_to_string(s : CryptosymcastView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_range_make(size : Int) -> CryptosymcastRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_range_len(s : CryptosymcastRange) -> Int { s.size }

pub fn crypto_sym_cast_range_get(s : CryptosymcastRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_range_set(s : CryptosymcastRange, i : Int, v : Double) -> CryptosymcastRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_range_sum(s : CryptosymcastRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_range_mean(s : CryptosymcastRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_range_scale(s : CryptosymcastRange, f : Double) -> CryptosymcastRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_range_add(a : CryptosymcastRange, b : CryptosymcastRange) -> CryptosymcastRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_range_copy(s : CryptosymcastRange) -> CryptosymcastRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_range_fill(s : CryptosymcastRange, v : Double) -> CryptosymcastRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_range_min(s : CryptosymcastRange) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_range_max(s : CryptosymcastRange) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_range_to_string(s : CryptosymcastRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymcastSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_cast_slice_make(size : Int) -> CryptosymcastSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_cast_slice_len(s : CryptosymcastSlice) -> Int { s.size }

pub fn crypto_sym_cast_slice_get(s : CryptosymcastSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_cast_slice_set(s : CryptosymcastSlice, i : Int, v : Double) -> CryptosymcastSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_slice_sum(s : CryptosymcastSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_cast_slice_mean(s : CryptosymcastSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_cast_slice_scale(s : CryptosymcastSlice, f : Double) -> CryptosymcastSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_slice_add(a : CryptosymcastSlice, b : CryptosymcastSlice) -> CryptosymcastSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_cast_slice_copy(s : CryptosymcastSlice) -> CryptosymcastSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_slice_fill(s : CryptosymcastSlice, v : Double) -> CryptosymcastSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_cast_slice_min(s : CryptosymcastSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sym_cast_slice_max(s : CryptosymcastSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sym_cast_slice_to_string(s : CryptosymcastSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

