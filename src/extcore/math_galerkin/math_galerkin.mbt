///===
/// extcore/math_galerkin

pub(all) struct MathgalerkinPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_galerkin_make_point(x : Double, y : Double) -> MathgalerkinPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_galerkin_make_point3(x : Double, y : Double, z : Double) -> MathgalerkinPoint {
  { x, y, z, label: 0 }
}

pub fn MathgalerkinPoint::x(self : MathgalerkinPoint) -> Double { self.x }

pub fn MathgalerkinPoint::y(self : MathgalerkinPoint) -> Double { self.y }

pub fn MathgalerkinPoint::z(self : MathgalerkinPoint) -> Double { self.z }

pub fn MathgalerkinPoint::label(self : MathgalerkinPoint) -> Int { self.label }

pub fn MathgalerkinPoint::dist(self : MathgalerkinPoint, other : MathgalerkinPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathgalerkinPoint::add(self : MathgalerkinPoint, other : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathgalerkinPoint::sub(self : MathgalerkinPoint, other : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathgalerkinPoint::scale(self : MathgalerkinPoint, s : Double) -> MathgalerkinPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathgalerkinPoint::dot(self : MathgalerkinPoint, other : MathgalerkinPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathgalerkinPoint::cross(self : MathgalerkinPoint, other : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathgalerkinPoint::norm(self : MathgalerkinPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathgalerkinPoint::normalize(self : MathgalerkinPoint) -> MathgalerkinPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathgalerkinPoint::negate(self : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathgalerkinPoint::mid(self : MathgalerkinPoint, other : MathgalerkinPoint) -> MathgalerkinPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathgalerkinPoint::lerp(self : MathgalerkinPoint, other : MathgalerkinPoint, t : Double) -> MathgalerkinPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathgalerkinPoint::to_string(self : MathgalerkinPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathgalerkinSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_galerkin_make_series(vals : Array[Double], name : String) -> MathgalerkinSeries {
  { vals, name, meta: 0 }
}

pub fn MathgalerkinSeries::len(self : MathgalerkinSeries) -> Int { self.vals.length() }

pub fn MathgalerkinSeries::sum(self : MathgalerkinSeries) -> Double { @_common.sum(self.vals) }

pub fn MathgalerkinSeries::mean(self : MathgalerkinSeries) -> Double { @_common.mean(self.vals) }

pub fn MathgalerkinSeries::min(self : MathgalerkinSeries) -> Double { @_common.min(self.vals) }

pub fn MathgalerkinSeries::max(self : MathgalerkinSeries) -> Double { @_common.max(self.vals) }

pub fn MathgalerkinSeries::range(self : MathgalerkinSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathgalerkinSeries::variance(self : MathgalerkinSeries) -> Double { @_common.variance(self.vals) }

pub fn MathgalerkinSeries::std(self : MathgalerkinSeries) -> Double { @_common.std(self.vals) }

pub fn MathgalerkinSeries::median(self : MathgalerkinSeries) -> Double { @_common.median(self.vals) }

pub fn MathgalerkinSeries::scale(self : MathgalerkinSeries, f : Double) -> MathgalerkinSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathgalerkinSeries::add(self : MathgalerkinSeries, other : MathgalerkinSeries) -> MathgalerkinSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathgalerkinSeries::sub(self : MathgalerkinSeries, other : MathgalerkinSeries) -> MathgalerkinSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathgalerkinSeries::normalize(self : MathgalerkinSeries) -> MathgalerkinSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathgalerkinSeries::cumsum(self : MathgalerkinSeries) -> MathgalerkinSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathgalerkinSeries::to_string(self : MathgalerkinSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathgalerkinMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_galerkin_make_matrix(rows : Int, cols : Int, val : Double) -> MathgalerkinMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_galerkin_matrix_identity(n : Int) -> MathgalerkinMatrix {
  let m = math_galerkin_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathgalerkinMatrix::get(self : MathgalerkinMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathgalerkinMatrix::transpose(self : MathgalerkinMatrix) -> MathgalerkinMatrix {
  let result = math_galerkin_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathgalerkinMatrix::add(self : MathgalerkinMatrix, other : MathgalerkinMatrix) -> MathgalerkinMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_galerkin_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathgalerkinMatrix::scale(self : MathgalerkinMatrix, s : Double) -> MathgalerkinMatrix {
  let result = math_galerkin_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathgalerkinMatrix::multiply(self : MathgalerkinMatrix, other : MathgalerkinMatrix) -> MathgalerkinMatrix {
  if self.cols != other.rows { return math_galerkin_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_galerkin_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathgalerkinMatrix::trace(self : MathgalerkinMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathgalerkinMatrix::det(self : MathgalerkinMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathgalerkinMatrix::norm(self : MathgalerkinMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathgalerkinMatrix::to_string(self : MathgalerkinMatrix) -> String {
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

pub(all) struct MathgalerkinVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_galerkin_make_vector(comps : Array[Double]) -> MathgalerkinVector {
  { comps, dim: comps.length() }
}

pub fn math_galerkin_vector_zero(dim : Int) -> MathgalerkinVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathgalerkinVector::add(self : MathgalerkinVector, other : MathgalerkinVector) -> MathgalerkinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathgalerkinVector::sub(self : MathgalerkinVector, other : MathgalerkinVector) -> MathgalerkinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathgalerkinVector::scale(self : MathgalerkinVector, s : Double) -> MathgalerkinVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathgalerkinVector::dot(self : MathgalerkinVector, other : MathgalerkinVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathgalerkinVector::norm(self : MathgalerkinVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathgalerkinVector::normalize(self : MathgalerkinVector) -> MathgalerkinVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathgalerkinVector::dist(self : MathgalerkinVector, other : MathgalerkinVector) -> Double {
  self.sub(other).norm()
}

pub fn MathgalerkinVector::to_string(self : MathgalerkinVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_galerkin_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_galerkin_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_galerkin_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_galerkin_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_galerkin_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_galerkin_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_galerkin_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_galerkin_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_galerkin_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_galerkin_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_galerkin_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_galerkin_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_galerkin_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_galerkin_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_galerkin_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_galerkin_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_galerkin_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_galerkin_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_galerkin_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_galerkin_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_galerkin_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_galerkin_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_galerkin_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_galerkin_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_galerkin_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_galerkin_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_galerkin_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_galerkin_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_galerkin_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathgalerkinFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_frame_make(size : Int) -> MathgalerkinFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_frame_len(s : MathgalerkinFrame) -> Int { s.size }

pub fn math_galerkin_frame_get(s : MathgalerkinFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_frame_set(s : MathgalerkinFrame, i : Int, v : Double) -> MathgalerkinFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_galerkin_frame_sum(s : MathgalerkinFrame) -> Double { @_common.sum(s.data) }

pub fn math_galerkin_frame_mean(s : MathgalerkinFrame) -> Double { @_common.mean(s.data) }

pub fn math_galerkin_frame_scale(s : MathgalerkinFrame, f : Double) -> MathgalerkinFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_galerkin_frame_add(a : MathgalerkinFrame, b : MathgalerkinFrame) -> MathgalerkinFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_galerkin_frame_copy(s : MathgalerkinFrame) -> MathgalerkinFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_galerkin_frame_fill(s : MathgalerkinFrame, v : Double) -> MathgalerkinFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_galerkin_frame_min(s : MathgalerkinFrame) -> Double { @_common.min(s.data) }

pub fn math_galerkin_frame_max(s : MathgalerkinFrame) -> Double { @_common.max(s.data) }

pub fn math_galerkin_frame_to_string(s : MathgalerkinFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_table_make(size : Int) -> MathgalerkinTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_table_len(s : MathgalerkinTable) -> Int { s.size }

pub fn math_galerkin_table_get(s : MathgalerkinTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_table_set(s : MathgalerkinTable, i : Int, v : Double) -> MathgalerkinTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_galerkin_table_sum(s : MathgalerkinTable) -> Double { @_common.sum(s.data) }

pub fn math_galerkin_table_mean(s : MathgalerkinTable) -> Double { @_common.mean(s.data) }

pub fn math_galerkin_table_scale(s : MathgalerkinTable, f : Double) -> MathgalerkinTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_galerkin_table_add(a : MathgalerkinTable, b : MathgalerkinTable) -> MathgalerkinTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_galerkin_table_copy(s : MathgalerkinTable) -> MathgalerkinTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_galerkin_table_fill(s : MathgalerkinTable, v : Double) -> MathgalerkinTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_galerkin_table_min(s : MathgalerkinTable) -> Double { @_common.min(s.data) }

pub fn math_galerkin_table_max(s : MathgalerkinTable) -> Double { @_common.max(s.data) }

pub fn math_galerkin_table_to_string(s : MathgalerkinTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_graphn_make(size : Int) -> MathgalerkinGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_graphn_len(s : MathgalerkinGraphN) -> Int { s.size }

pub fn math_galerkin_graphn_get(s : MathgalerkinGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_graphn_set(s : MathgalerkinGraphN, i : Int, v : Double) -> MathgalerkinGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_galerkin_graphn_sum(s : MathgalerkinGraphN) -> Double { @_common.sum(s.data) }

pub fn math_galerkin_graphn_mean(s : MathgalerkinGraphN) -> Double { @_common.mean(s.data) }

pub fn math_galerkin_graphn_scale(s : MathgalerkinGraphN, f : Double) -> MathgalerkinGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_galerkin_graphn_add(a : MathgalerkinGraphN, b : MathgalerkinGraphN) -> MathgalerkinGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_galerkin_graphn_copy(s : MathgalerkinGraphN) -> MathgalerkinGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_galerkin_graphn_fill(s : MathgalerkinGraphN, v : Double) -> MathgalerkinGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_galerkin_graphn_min(s : MathgalerkinGraphN) -> Double { @_common.min(s.data) }

pub fn math_galerkin_graphn_max(s : MathgalerkinGraphN) -> Double { @_common.max(s.data) }

pub fn math_galerkin_graphn_to_string(s : MathgalerkinGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_node_make(size : Int) -> MathgalerkinNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_node_len(s : MathgalerkinNode) -> Int { s.size }

pub fn math_galerkin_node_get(s : MathgalerkinNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_node_set(s : MathgalerkinNode, i : Int, v : Double) -> MathgalerkinNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_galerkin_node_sum(s : MathgalerkinNode) -> Double { @_common.sum(s.data) }

pub fn math_galerkin_node_mean(s : MathgalerkinNode) -> Double { @_common.mean(s.data) }

pub fn math_galerkin_node_scale(s : MathgalerkinNode, f : Double) -> MathgalerkinNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_galerkin_node_add(a : MathgalerkinNode, b : MathgalerkinNode) -> MathgalerkinNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_galerkin_node_copy(s : MathgalerkinNode) -> MathgalerkinNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_galerkin_node_fill(s : MathgalerkinNode, v : Double) -> MathgalerkinNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_galerkin_node_min(s : MathgalerkinNode) -> Double { @_common.min(s.data) }

pub fn math_galerkin_node_max(s : MathgalerkinNode) -> Double { @_common.max(s.data) }

pub fn math_galerkin_node_to_string(s : MathgalerkinNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_edge_make(size : Int) -> MathgalerkinEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_edge_len(s : MathgalerkinEdge) -> Int { s.size }

pub fn math_galerkin_edge_get(s : MathgalerkinEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_edge_set(s : MathgalerkinEdge, i : Int, v : Double) -> MathgalerkinEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_galerkin_edge_sum(s : MathgalerkinEdge) -> Double { @_common.sum(s.data) }

pub fn math_galerkin_edge_mean(s : MathgalerkinEdge) -> Double { @_common.mean(s.data) }

pub fn math_galerkin_edge_scale(s : MathgalerkinEdge, f : Double) -> MathgalerkinEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_galerkin_edge_add(a : MathgalerkinEdge, b : MathgalerkinEdge) -> MathgalerkinEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_galerkin_edge_copy(s : MathgalerkinEdge) -> MathgalerkinEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_galerkin_edge_fill(s : MathgalerkinEdge, v : Double) -> MathgalerkinEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_galerkin_edge_min(s : MathgalerkinEdge) -> Double { @_common.min(s.data) }

pub fn math_galerkin_edge_max(s : MathgalerkinEdge) -> Double { @_common.max(s.data) }

pub fn math_galerkin_edge_to_string(s : MathgalerkinEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_path_make(size : Int) -> MathgalerkinPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_path_len(s : MathgalerkinPath) -> Int { s.size }

pub fn math_galerkin_path_get(s : MathgalerkinPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_path_set(s : MathgalerkinPath, i : Int, v : Double) -> MathgalerkinPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_galerkin_path_sum(s : MathgalerkinPath) -> Double { @_common.sum(s.data) }

pub fn math_galerkin_path_mean(s : MathgalerkinPath) -> Double { @_common.mean(s.data) }

pub fn math_galerkin_path_scale(s : MathgalerkinPath, f : Double) -> MathgalerkinPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_galerkin_path_add(a : MathgalerkinPath, b : MathgalerkinPath) -> MathgalerkinPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_galerkin_path_copy(s : MathgalerkinPath) -> MathgalerkinPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_galerkin_path_fill(s : MathgalerkinPath, v : Double) -> MathgalerkinPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_galerkin_path_min(s : MathgalerkinPath) -> Double { @_common.min(s.data) }

pub fn math_galerkin_path_max(s : MathgalerkinPath) -> Double { @_common.max(s.data) }

pub fn math_galerkin_path_to_string(s : MathgalerkinPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_cluster_make(size : Int) -> MathgalerkinCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_cluster_len(s : MathgalerkinCluster) -> Int { s.size }

pub fn math_galerkin_cluster_get(s : MathgalerkinCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_cluster_set(s : MathgalerkinCluster, i : Int, v : Double) -> MathgalerkinCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_galerkin_cluster_sum(s : MathgalerkinCluster) -> Double { @_common.sum(s.data) }

pub fn math_galerkin_cluster_mean(s : MathgalerkinCluster) -> Double { @_common.mean(s.data) }

pub fn math_galerkin_cluster_scale(s : MathgalerkinCluster, f : Double) -> MathgalerkinCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_galerkin_cluster_add(a : MathgalerkinCluster, b : MathgalerkinCluster) -> MathgalerkinCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_galerkin_cluster_copy(s : MathgalerkinCluster) -> MathgalerkinCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_galerkin_cluster_fill(s : MathgalerkinCluster, v : Double) -> MathgalerkinCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_galerkin_cluster_min(s : MathgalerkinCluster) -> Double { @_common.min(s.data) }

pub fn math_galerkin_cluster_max(s : MathgalerkinCluster) -> Double { @_common.max(s.data) }

pub fn math_galerkin_cluster_to_string(s : MathgalerkinCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_model_make(size : Int) -> MathgalerkinModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_model_len(s : MathgalerkinModel) -> Int { s.size }

pub fn math_galerkin_model_get(s : MathgalerkinModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_model_set(s : MathgalerkinModel, i : Int, v : Double) -> MathgalerkinModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_galerkin_model_sum(s : MathgalerkinModel) -> Double { @_common.sum(s.data) }

pub fn math_galerkin_model_mean(s : MathgalerkinModel) -> Double { @_common.mean(s.data) }

pub fn math_galerkin_model_scale(s : MathgalerkinModel, f : Double) -> MathgalerkinModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_galerkin_model_add(a : MathgalerkinModel, b : MathgalerkinModel) -> MathgalerkinModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_galerkin_model_copy(s : MathgalerkinModel) -> MathgalerkinModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_galerkin_model_fill(s : MathgalerkinModel, v : Double) -> MathgalerkinModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_galerkin_model_min(s : MathgalerkinModel) -> Double { @_common.min(s.data) }

pub fn math_galerkin_model_max(s : MathgalerkinModel) -> Double { @_common.max(s.data) }

pub fn math_galerkin_model_to_string(s : MathgalerkinModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_layer_make(size : Int) -> MathgalerkinLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_layer_len(s : MathgalerkinLayer) -> Int { s.size }

pub fn math_galerkin_layer_get(s : MathgalerkinLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_layer_set(s : MathgalerkinLayer, i : Int, v : Double) -> MathgalerkinLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_galerkin_layer_sum(s : MathgalerkinLayer) -> Double { @_common.sum(s.data) }

pub fn math_galerkin_layer_mean(s : MathgalerkinLayer) -> Double { @_common.mean(s.data) }

pub fn math_galerkin_layer_scale(s : MathgalerkinLayer, f : Double) -> MathgalerkinLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_galerkin_layer_add(a : MathgalerkinLayer, b : MathgalerkinLayer) -> MathgalerkinLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_galerkin_layer_copy(s : MathgalerkinLayer) -> MathgalerkinLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_galerkin_layer_fill(s : MathgalerkinLayer, v : Double) -> MathgalerkinLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_galerkin_layer_min(s : MathgalerkinLayer) -> Double { @_common.min(s.data) }

pub fn math_galerkin_layer_max(s : MathgalerkinLayer) -> Double { @_common.max(s.data) }

pub fn math_galerkin_layer_to_string(s : MathgalerkinLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_buffer_make(size : Int) -> MathgalerkinBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_buffer_len(s : MathgalerkinBuffer) -> Int { s.size }

pub fn math_galerkin_buffer_get(s : MathgalerkinBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_buffer_set(s : MathgalerkinBuffer, i : Int, v : Double) -> MathgalerkinBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_galerkin_buffer_sum(s : MathgalerkinBuffer) -> Double { @_common.sum(s.data) }

pub fn math_galerkin_buffer_mean(s : MathgalerkinBuffer) -> Double { @_common.mean(s.data) }

pub fn math_galerkin_buffer_scale(s : MathgalerkinBuffer, f : Double) -> MathgalerkinBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_galerkin_buffer_add(a : MathgalerkinBuffer, b : MathgalerkinBuffer) -> MathgalerkinBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_galerkin_buffer_copy(s : MathgalerkinBuffer) -> MathgalerkinBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_galerkin_buffer_fill(s : MathgalerkinBuffer, v : Double) -> MathgalerkinBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_galerkin_buffer_min(s : MathgalerkinBuffer) -> Double { @_common.min(s.data) }

pub fn math_galerkin_buffer_max(s : MathgalerkinBuffer) -> Double { @_common.max(s.data) }

pub fn math_galerkin_buffer_to_string(s : MathgalerkinBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_cursor_make(size : Int) -> MathgalerkinCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_cursor_len(s : MathgalerkinCursor) -> Int { s.size }

pub fn math_galerkin_cursor_get(s : MathgalerkinCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_cursor_set(s : MathgalerkinCursor, i : Int, v : Double) -> MathgalerkinCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_galerkin_cursor_sum(s : MathgalerkinCursor) -> Double { @_common.sum(s.data) }

pub fn math_galerkin_cursor_mean(s : MathgalerkinCursor) -> Double { @_common.mean(s.data) }

pub fn math_galerkin_cursor_scale(s : MathgalerkinCursor, f : Double) -> MathgalerkinCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_galerkin_cursor_add(a : MathgalerkinCursor, b : MathgalerkinCursor) -> MathgalerkinCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_galerkin_cursor_copy(s : MathgalerkinCursor) -> MathgalerkinCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_galerkin_cursor_fill(s : MathgalerkinCursor, v : Double) -> MathgalerkinCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_galerkin_cursor_min(s : MathgalerkinCursor) -> Double { @_common.min(s.data) }

pub fn math_galerkin_cursor_max(s : MathgalerkinCursor) -> Double { @_common.max(s.data) }

pub fn math_galerkin_cursor_to_string(s : MathgalerkinCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_view_make(size : Int) -> MathgalerkinView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_view_len(s : MathgalerkinView) -> Int { s.size }

pub fn math_galerkin_view_get(s : MathgalerkinView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_view_set(s : MathgalerkinView, i : Int, v : Double) -> MathgalerkinView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_galerkin_view_sum(s : MathgalerkinView) -> Double { @_common.sum(s.data) }

pub fn math_galerkin_view_mean(s : MathgalerkinView) -> Double { @_common.mean(s.data) }

pub fn math_galerkin_view_scale(s : MathgalerkinView, f : Double) -> MathgalerkinView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_galerkin_view_add(a : MathgalerkinView, b : MathgalerkinView) -> MathgalerkinView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_galerkin_view_copy(s : MathgalerkinView) -> MathgalerkinView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_galerkin_view_fill(s : MathgalerkinView, v : Double) -> MathgalerkinView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_galerkin_view_min(s : MathgalerkinView) -> Double { @_common.min(s.data) }

pub fn math_galerkin_view_max(s : MathgalerkinView) -> Double { @_common.max(s.data) }

pub fn math_galerkin_view_to_string(s : MathgalerkinView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_range_make(size : Int) -> MathgalerkinRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_range_len(s : MathgalerkinRange) -> Int { s.size }

pub fn math_galerkin_range_get(s : MathgalerkinRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_range_set(s : MathgalerkinRange, i : Int, v : Double) -> MathgalerkinRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_galerkin_range_sum(s : MathgalerkinRange) -> Double { @_common.sum(s.data) }

pub fn math_galerkin_range_mean(s : MathgalerkinRange) -> Double { @_common.mean(s.data) }

pub fn math_galerkin_range_scale(s : MathgalerkinRange, f : Double) -> MathgalerkinRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_galerkin_range_add(a : MathgalerkinRange, b : MathgalerkinRange) -> MathgalerkinRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_galerkin_range_copy(s : MathgalerkinRange) -> MathgalerkinRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_galerkin_range_fill(s : MathgalerkinRange, v : Double) -> MathgalerkinRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_galerkin_range_min(s : MathgalerkinRange) -> Double { @_common.min(s.data) }

pub fn math_galerkin_range_max(s : MathgalerkinRange) -> Double { @_common.max(s.data) }

pub fn math_galerkin_range_to_string(s : MathgalerkinRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathgalerkinSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_galerkin_slice_make(size : Int) -> MathgalerkinSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_galerkin_slice_len(s : MathgalerkinSlice) -> Int { s.size }

pub fn math_galerkin_slice_get(s : MathgalerkinSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_galerkin_slice_set(s : MathgalerkinSlice, i : Int, v : Double) -> MathgalerkinSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_galerkin_slice_sum(s : MathgalerkinSlice) -> Double { @_common.sum(s.data) }

pub fn math_galerkin_slice_mean(s : MathgalerkinSlice) -> Double { @_common.mean(s.data) }

pub fn math_galerkin_slice_scale(s : MathgalerkinSlice, f : Double) -> MathgalerkinSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_galerkin_slice_add(a : MathgalerkinSlice, b : MathgalerkinSlice) -> MathgalerkinSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_galerkin_slice_copy(s : MathgalerkinSlice) -> MathgalerkinSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_galerkin_slice_fill(s : MathgalerkinSlice, v : Double) -> MathgalerkinSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_galerkin_slice_min(s : MathgalerkinSlice) -> Double { @_common.min(s.data) }

pub fn math_galerkin_slice_max(s : MathgalerkinSlice) -> Double { @_common.max(s.data) }

pub fn math_galerkin_slice_to_string(s : MathgalerkinSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

