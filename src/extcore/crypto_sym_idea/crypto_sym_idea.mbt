///===
/// extcore/crypto_sym_idea

pub(all) struct CryptosymideaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn crypto_sym_idea_make_point(x : Double, y : Double) -> CryptosymideaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn crypto_sym_idea_make_point3(x : Double, y : Double, z : Double) -> CryptosymideaPoint {
  { x, y, z, label: 0 }
}

pub fn CryptosymideaPoint::x(self : CryptosymideaPoint) -> Double { self.x }

pub fn CryptosymideaPoint::y(self : CryptosymideaPoint) -> Double { self.y }

pub fn CryptosymideaPoint::z(self : CryptosymideaPoint) -> Double { self.z }

pub fn CryptosymideaPoint::label(self : CryptosymideaPoint) -> Int { self.label }

pub fn CryptosymideaPoint::dist(self : CryptosymideaPoint, other : CryptosymideaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn CryptosymideaPoint::add(self : CryptosymideaPoint, other : CryptosymideaPoint) -> CryptosymideaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn CryptosymideaPoint::sub(self : CryptosymideaPoint, other : CryptosymideaPoint) -> CryptosymideaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn CryptosymideaPoint::scale(self : CryptosymideaPoint, s : Double) -> CryptosymideaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn CryptosymideaPoint::dot(self : CryptosymideaPoint, other : CryptosymideaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn CryptosymideaPoint::cross(self : CryptosymideaPoint, other : CryptosymideaPoint) -> CryptosymideaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn CryptosymideaPoint::norm(self : CryptosymideaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn CryptosymideaPoint::normalize(self : CryptosymideaPoint) -> CryptosymideaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymideaPoint::negate(self : CryptosymideaPoint) -> CryptosymideaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn CryptosymideaPoint::mid(self : CryptosymideaPoint, other : CryptosymideaPoint) -> CryptosymideaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn CryptosymideaPoint::lerp(self : CryptosymideaPoint, other : CryptosymideaPoint, t : Double) -> CryptosymideaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn CryptosymideaPoint::to_string(self : CryptosymideaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct CryptosymideaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn crypto_sym_idea_make_series(vals : Array[Double], name : String) -> CryptosymideaSeries {
  { vals, name, meta: 0 }
}

pub fn CryptosymideaSeries::len(self : CryptosymideaSeries) -> Int { self.vals.length() }

pub fn CryptosymideaSeries::sum(self : CryptosymideaSeries) -> Double { @_common.sum(self.vals) }

pub fn CryptosymideaSeries::mean(self : CryptosymideaSeries) -> Double { @_common.mean(self.vals) }

pub fn CryptosymideaSeries::min(self : CryptosymideaSeries) -> Double { @_common.min(self.vals) }

pub fn CryptosymideaSeries::max(self : CryptosymideaSeries) -> Double { @_common.max(self.vals) }

pub fn CryptosymideaSeries::range(self : CryptosymideaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn CryptosymideaSeries::variance(self : CryptosymideaSeries) -> Double { @_common.variance(self.vals) }

pub fn CryptosymideaSeries::std(self : CryptosymideaSeries) -> Double { @_common.std(self.vals) }

pub fn CryptosymideaSeries::median(self : CryptosymideaSeries) -> Double { @_common.median(self.vals) }

pub fn CryptosymideaSeries::scale(self : CryptosymideaSeries, f : Double) -> CryptosymideaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn CryptosymideaSeries::add(self : CryptosymideaSeries, other : CryptosymideaSeries) -> CryptosymideaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn CryptosymideaSeries::sub(self : CryptosymideaSeries, other : CryptosymideaSeries) -> CryptosymideaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn CryptosymideaSeries::normalize(self : CryptosymideaSeries) -> CryptosymideaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn CryptosymideaSeries::cumsum(self : CryptosymideaSeries) -> CryptosymideaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn CryptosymideaSeries::to_string(self : CryptosymideaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct CryptosymideaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn crypto_sym_idea_make_matrix(rows : Int, cols : Int, val : Double) -> CryptosymideaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn crypto_sym_idea_matrix_identity(n : Int) -> CryptosymideaMatrix {
  let m = crypto_sym_idea_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn CryptosymideaMatrix::get(self : CryptosymideaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn CryptosymideaMatrix::transpose(self : CryptosymideaMatrix) -> CryptosymideaMatrix {
  let result = crypto_sym_idea_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn CryptosymideaMatrix::add(self : CryptosymideaMatrix, other : CryptosymideaMatrix) -> CryptosymideaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = crypto_sym_idea_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn CryptosymideaMatrix::scale(self : CryptosymideaMatrix, s : Double) -> CryptosymideaMatrix {
  let result = crypto_sym_idea_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn CryptosymideaMatrix::multiply(self : CryptosymideaMatrix, other : CryptosymideaMatrix) -> CryptosymideaMatrix {
  if self.cols != other.rows { return crypto_sym_idea_make_matrix(self.rows, other.cols, 0.0) }
  let result = crypto_sym_idea_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn CryptosymideaMatrix::trace(self : CryptosymideaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn CryptosymideaMatrix::det(self : CryptosymideaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn CryptosymideaMatrix::norm(self : CryptosymideaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn CryptosymideaMatrix::to_string(self : CryptosymideaMatrix) -> String {
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

pub(all) struct CryptosymideaVector {
  comps : Array[Double]
  dim : Int
}

pub fn crypto_sym_idea_make_vector(comps : Array[Double]) -> CryptosymideaVector {
  { comps, dim: comps.length() }
}

pub fn crypto_sym_idea_vector_zero(dim : Int) -> CryptosymideaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn CryptosymideaVector::add(self : CryptosymideaVector, other : CryptosymideaVector) -> CryptosymideaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymideaVector::sub(self : CryptosymideaVector, other : CryptosymideaVector) -> CryptosymideaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn CryptosymideaVector::scale(self : CryptosymideaVector, s : Double) -> CryptosymideaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn CryptosymideaVector::dot(self : CryptosymideaVector, other : CryptosymideaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn CryptosymideaVector::norm(self : CryptosymideaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn CryptosymideaVector::normalize(self : CryptosymideaVector) -> CryptosymideaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn CryptosymideaVector::dist(self : CryptosymideaVector, other : CryptosymideaVector) -> Double {
  self.sub(other).norm()
}

pub fn CryptosymideaVector::to_string(self : CryptosymideaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn crypto_sym_idea_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn crypto_sym_idea_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn crypto_sym_idea_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn crypto_sym_idea_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn crypto_sym_idea_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn crypto_sym_idea_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn crypto_sym_idea_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn crypto_sym_idea_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn crypto_sym_idea_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn crypto_sym_idea_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn crypto_sym_idea_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn crypto_sym_idea_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn crypto_sym_idea_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn crypto_sym_idea_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn crypto_sym_idea_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn crypto_sym_idea_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn crypto_sym_idea_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn crypto_sym_idea_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn crypto_sym_idea_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn crypto_sym_idea_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn crypto_sym_idea_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn crypto_sym_idea_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn crypto_sym_idea_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn crypto_sym_idea_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn crypto_sym_idea_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn crypto_sym_idea_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn crypto_sym_idea_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn crypto_sym_idea_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn crypto_sym_idea_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct CryptosymideaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_frame_make(size : Int) -> CryptosymideaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_frame_len(s : CryptosymideaFrame) -> Int { s.size }

pub fn crypto_sym_idea_frame_get(s : CryptosymideaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_frame_set(s : CryptosymideaFrame, i : Int, v : Double) -> CryptosymideaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_frame_sum(s : CryptosymideaFrame) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_idea_frame_mean(s : CryptosymideaFrame) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_idea_frame_scale(s : CryptosymideaFrame, f : Double) -> CryptosymideaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_frame_add(a : CryptosymideaFrame, b : CryptosymideaFrame) -> CryptosymideaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_idea_frame_copy(s : CryptosymideaFrame) -> CryptosymideaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_frame_fill(s : CryptosymideaFrame, v : Double) -> CryptosymideaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_frame_min(s : CryptosymideaFrame) -> Double { @_common.min(s.data) }

pub fn crypto_sym_idea_frame_max(s : CryptosymideaFrame) -> Double { @_common.max(s.data) }

pub fn crypto_sym_idea_frame_to_string(s : CryptosymideaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_table_make(size : Int) -> CryptosymideaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_table_len(s : CryptosymideaTable) -> Int { s.size }

pub fn crypto_sym_idea_table_get(s : CryptosymideaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_table_set(s : CryptosymideaTable, i : Int, v : Double) -> CryptosymideaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_table_sum(s : CryptosymideaTable) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_idea_table_mean(s : CryptosymideaTable) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_idea_table_scale(s : CryptosymideaTable, f : Double) -> CryptosymideaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_table_add(a : CryptosymideaTable, b : CryptosymideaTable) -> CryptosymideaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_idea_table_copy(s : CryptosymideaTable) -> CryptosymideaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_table_fill(s : CryptosymideaTable, v : Double) -> CryptosymideaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_table_min(s : CryptosymideaTable) -> Double { @_common.min(s.data) }

pub fn crypto_sym_idea_table_max(s : CryptosymideaTable) -> Double { @_common.max(s.data) }

pub fn crypto_sym_idea_table_to_string(s : CryptosymideaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_graphn_make(size : Int) -> CryptosymideaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_graphn_len(s : CryptosymideaGraphN) -> Int { s.size }

pub fn crypto_sym_idea_graphn_get(s : CryptosymideaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_graphn_set(s : CryptosymideaGraphN, i : Int, v : Double) -> CryptosymideaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_graphn_sum(s : CryptosymideaGraphN) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_idea_graphn_mean(s : CryptosymideaGraphN) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_idea_graphn_scale(s : CryptosymideaGraphN, f : Double) -> CryptosymideaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_graphn_add(a : CryptosymideaGraphN, b : CryptosymideaGraphN) -> CryptosymideaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_idea_graphn_copy(s : CryptosymideaGraphN) -> CryptosymideaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_graphn_fill(s : CryptosymideaGraphN, v : Double) -> CryptosymideaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_graphn_min(s : CryptosymideaGraphN) -> Double { @_common.min(s.data) }

pub fn crypto_sym_idea_graphn_max(s : CryptosymideaGraphN) -> Double { @_common.max(s.data) }

pub fn crypto_sym_idea_graphn_to_string(s : CryptosymideaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_node_make(size : Int) -> CryptosymideaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_node_len(s : CryptosymideaNode) -> Int { s.size }

pub fn crypto_sym_idea_node_get(s : CryptosymideaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_node_set(s : CryptosymideaNode, i : Int, v : Double) -> CryptosymideaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_node_sum(s : CryptosymideaNode) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_idea_node_mean(s : CryptosymideaNode) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_idea_node_scale(s : CryptosymideaNode, f : Double) -> CryptosymideaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_node_add(a : CryptosymideaNode, b : CryptosymideaNode) -> CryptosymideaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_idea_node_copy(s : CryptosymideaNode) -> CryptosymideaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_node_fill(s : CryptosymideaNode, v : Double) -> CryptosymideaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_node_min(s : CryptosymideaNode) -> Double { @_common.min(s.data) }

pub fn crypto_sym_idea_node_max(s : CryptosymideaNode) -> Double { @_common.max(s.data) }

pub fn crypto_sym_idea_node_to_string(s : CryptosymideaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_edge_make(size : Int) -> CryptosymideaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_edge_len(s : CryptosymideaEdge) -> Int { s.size }

pub fn crypto_sym_idea_edge_get(s : CryptosymideaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_edge_set(s : CryptosymideaEdge, i : Int, v : Double) -> CryptosymideaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_edge_sum(s : CryptosymideaEdge) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_idea_edge_mean(s : CryptosymideaEdge) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_idea_edge_scale(s : CryptosymideaEdge, f : Double) -> CryptosymideaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_edge_add(a : CryptosymideaEdge, b : CryptosymideaEdge) -> CryptosymideaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_idea_edge_copy(s : CryptosymideaEdge) -> CryptosymideaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_edge_fill(s : CryptosymideaEdge, v : Double) -> CryptosymideaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_edge_min(s : CryptosymideaEdge) -> Double { @_common.min(s.data) }

pub fn crypto_sym_idea_edge_max(s : CryptosymideaEdge) -> Double { @_common.max(s.data) }

pub fn crypto_sym_idea_edge_to_string(s : CryptosymideaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_path_make(size : Int) -> CryptosymideaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_path_len(s : CryptosymideaPath) -> Int { s.size }

pub fn crypto_sym_idea_path_get(s : CryptosymideaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_path_set(s : CryptosymideaPath, i : Int, v : Double) -> CryptosymideaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_path_sum(s : CryptosymideaPath) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_idea_path_mean(s : CryptosymideaPath) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_idea_path_scale(s : CryptosymideaPath, f : Double) -> CryptosymideaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_path_add(a : CryptosymideaPath, b : CryptosymideaPath) -> CryptosymideaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_idea_path_copy(s : CryptosymideaPath) -> CryptosymideaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_path_fill(s : CryptosymideaPath, v : Double) -> CryptosymideaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_path_min(s : CryptosymideaPath) -> Double { @_common.min(s.data) }

pub fn crypto_sym_idea_path_max(s : CryptosymideaPath) -> Double { @_common.max(s.data) }

pub fn crypto_sym_idea_path_to_string(s : CryptosymideaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_cluster_make(size : Int) -> CryptosymideaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_cluster_len(s : CryptosymideaCluster) -> Int { s.size }

pub fn crypto_sym_idea_cluster_get(s : CryptosymideaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_cluster_set(s : CryptosymideaCluster, i : Int, v : Double) -> CryptosymideaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_cluster_sum(s : CryptosymideaCluster) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_idea_cluster_mean(s : CryptosymideaCluster) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_idea_cluster_scale(s : CryptosymideaCluster, f : Double) -> CryptosymideaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_cluster_add(a : CryptosymideaCluster, b : CryptosymideaCluster) -> CryptosymideaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_idea_cluster_copy(s : CryptosymideaCluster) -> CryptosymideaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_cluster_fill(s : CryptosymideaCluster, v : Double) -> CryptosymideaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_cluster_min(s : CryptosymideaCluster) -> Double { @_common.min(s.data) }

pub fn crypto_sym_idea_cluster_max(s : CryptosymideaCluster) -> Double { @_common.max(s.data) }

pub fn crypto_sym_idea_cluster_to_string(s : CryptosymideaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_model_make(size : Int) -> CryptosymideaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_model_len(s : CryptosymideaModel) -> Int { s.size }

pub fn crypto_sym_idea_model_get(s : CryptosymideaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_model_set(s : CryptosymideaModel, i : Int, v : Double) -> CryptosymideaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_model_sum(s : CryptosymideaModel) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_idea_model_mean(s : CryptosymideaModel) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_idea_model_scale(s : CryptosymideaModel, f : Double) -> CryptosymideaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_model_add(a : CryptosymideaModel, b : CryptosymideaModel) -> CryptosymideaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_idea_model_copy(s : CryptosymideaModel) -> CryptosymideaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_model_fill(s : CryptosymideaModel, v : Double) -> CryptosymideaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_model_min(s : CryptosymideaModel) -> Double { @_common.min(s.data) }

pub fn crypto_sym_idea_model_max(s : CryptosymideaModel) -> Double { @_common.max(s.data) }

pub fn crypto_sym_idea_model_to_string(s : CryptosymideaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_layer_make(size : Int) -> CryptosymideaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_layer_len(s : CryptosymideaLayer) -> Int { s.size }

pub fn crypto_sym_idea_layer_get(s : CryptosymideaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_layer_set(s : CryptosymideaLayer, i : Int, v : Double) -> CryptosymideaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_layer_sum(s : CryptosymideaLayer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_idea_layer_mean(s : CryptosymideaLayer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_idea_layer_scale(s : CryptosymideaLayer, f : Double) -> CryptosymideaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_layer_add(a : CryptosymideaLayer, b : CryptosymideaLayer) -> CryptosymideaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_idea_layer_copy(s : CryptosymideaLayer) -> CryptosymideaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_layer_fill(s : CryptosymideaLayer, v : Double) -> CryptosymideaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_layer_min(s : CryptosymideaLayer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_idea_layer_max(s : CryptosymideaLayer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_idea_layer_to_string(s : CryptosymideaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_buffer_make(size : Int) -> CryptosymideaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_buffer_len(s : CryptosymideaBuffer) -> Int { s.size }

pub fn crypto_sym_idea_buffer_get(s : CryptosymideaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_buffer_set(s : CryptosymideaBuffer, i : Int, v : Double) -> CryptosymideaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_buffer_sum(s : CryptosymideaBuffer) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_idea_buffer_mean(s : CryptosymideaBuffer) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_idea_buffer_scale(s : CryptosymideaBuffer, f : Double) -> CryptosymideaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_buffer_add(a : CryptosymideaBuffer, b : CryptosymideaBuffer) -> CryptosymideaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_idea_buffer_copy(s : CryptosymideaBuffer) -> CryptosymideaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_buffer_fill(s : CryptosymideaBuffer, v : Double) -> CryptosymideaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_buffer_min(s : CryptosymideaBuffer) -> Double { @_common.min(s.data) }

pub fn crypto_sym_idea_buffer_max(s : CryptosymideaBuffer) -> Double { @_common.max(s.data) }

pub fn crypto_sym_idea_buffer_to_string(s : CryptosymideaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_cursor_make(size : Int) -> CryptosymideaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_cursor_len(s : CryptosymideaCursor) -> Int { s.size }

pub fn crypto_sym_idea_cursor_get(s : CryptosymideaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_cursor_set(s : CryptosymideaCursor, i : Int, v : Double) -> CryptosymideaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_cursor_sum(s : CryptosymideaCursor) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_idea_cursor_mean(s : CryptosymideaCursor) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_idea_cursor_scale(s : CryptosymideaCursor, f : Double) -> CryptosymideaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_cursor_add(a : CryptosymideaCursor, b : CryptosymideaCursor) -> CryptosymideaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_idea_cursor_copy(s : CryptosymideaCursor) -> CryptosymideaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_cursor_fill(s : CryptosymideaCursor, v : Double) -> CryptosymideaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_cursor_min(s : CryptosymideaCursor) -> Double { @_common.min(s.data) }

pub fn crypto_sym_idea_cursor_max(s : CryptosymideaCursor) -> Double { @_common.max(s.data) }

pub fn crypto_sym_idea_cursor_to_string(s : CryptosymideaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_view_make(size : Int) -> CryptosymideaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_view_len(s : CryptosymideaView) -> Int { s.size }

pub fn crypto_sym_idea_view_get(s : CryptosymideaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_view_set(s : CryptosymideaView, i : Int, v : Double) -> CryptosymideaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_view_sum(s : CryptosymideaView) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_idea_view_mean(s : CryptosymideaView) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_idea_view_scale(s : CryptosymideaView, f : Double) -> CryptosymideaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_view_add(a : CryptosymideaView, b : CryptosymideaView) -> CryptosymideaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_idea_view_copy(s : CryptosymideaView) -> CryptosymideaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_view_fill(s : CryptosymideaView, v : Double) -> CryptosymideaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_view_min(s : CryptosymideaView) -> Double { @_common.min(s.data) }

pub fn crypto_sym_idea_view_max(s : CryptosymideaView) -> Double { @_common.max(s.data) }

pub fn crypto_sym_idea_view_to_string(s : CryptosymideaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_range_make(size : Int) -> CryptosymideaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_range_len(s : CryptosymideaRange) -> Int { s.size }

pub fn crypto_sym_idea_range_get(s : CryptosymideaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_range_set(s : CryptosymideaRange, i : Int, v : Double) -> CryptosymideaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_range_sum(s : CryptosymideaRange) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_idea_range_mean(s : CryptosymideaRange) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_idea_range_scale(s : CryptosymideaRange, f : Double) -> CryptosymideaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_range_add(a : CryptosymideaRange, b : CryptosymideaRange) -> CryptosymideaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_idea_range_copy(s : CryptosymideaRange) -> CryptosymideaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_range_fill(s : CryptosymideaRange, v : Double) -> CryptosymideaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_range_min(s : CryptosymideaRange) -> Double { @_common.min(s.data) }

pub fn crypto_sym_idea_range_max(s : CryptosymideaRange) -> Double { @_common.max(s.data) }

pub fn crypto_sym_idea_range_to_string(s : CryptosymideaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct CryptosymideaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn crypto_sym_idea_slice_make(size : Int) -> CryptosymideaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn crypto_sym_idea_slice_len(s : CryptosymideaSlice) -> Int { s.size }

pub fn crypto_sym_idea_slice_get(s : CryptosymideaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn crypto_sym_idea_slice_set(s : CryptosymideaSlice, i : Int, v : Double) -> CryptosymideaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_slice_sum(s : CryptosymideaSlice) -> Double { @_common.sum(s.data) }

pub fn crypto_sym_idea_slice_mean(s : CryptosymideaSlice) -> Double { @_common.mean(s.data) }

pub fn crypto_sym_idea_slice_scale(s : CryptosymideaSlice, f : Double) -> CryptosymideaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_slice_add(a : CryptosymideaSlice, b : CryptosymideaSlice) -> CryptosymideaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn crypto_sym_idea_slice_copy(s : CryptosymideaSlice) -> CryptosymideaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_slice_fill(s : CryptosymideaSlice, v : Double) -> CryptosymideaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn crypto_sym_idea_slice_min(s : CryptosymideaSlice) -> Double { @_common.min(s.data) }

pub fn crypto_sym_idea_slice_max(s : CryptosymideaSlice) -> Double { @_common.max(s.data) }

pub fn crypto_sym_idea_slice_to_string(s : CryptosymideaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

