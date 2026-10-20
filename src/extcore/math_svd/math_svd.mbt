///===
/// extcore/math_svd

pub(all) struct MathsvdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_svd_make_point(x : Double, y : Double) -> MathsvdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_svd_make_point3(x : Double, y : Double, z : Double) -> MathsvdPoint {
  { x, y, z, label: 0 }
}

pub fn MathsvdPoint::x(self : MathsvdPoint) -> Double { self.x }

pub fn MathsvdPoint::y(self : MathsvdPoint) -> Double { self.y }

pub fn MathsvdPoint::z(self : MathsvdPoint) -> Double { self.z }

pub fn MathsvdPoint::label(self : MathsvdPoint) -> Int { self.label }

pub fn MathsvdPoint::dist(self : MathsvdPoint, other : MathsvdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathsvdPoint::add(self : MathsvdPoint, other : MathsvdPoint) -> MathsvdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathsvdPoint::sub(self : MathsvdPoint, other : MathsvdPoint) -> MathsvdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathsvdPoint::scale(self : MathsvdPoint, s : Double) -> MathsvdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathsvdPoint::dot(self : MathsvdPoint, other : MathsvdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathsvdPoint::cross(self : MathsvdPoint, other : MathsvdPoint) -> MathsvdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathsvdPoint::norm(self : MathsvdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathsvdPoint::normalize(self : MathsvdPoint) -> MathsvdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathsvdPoint::negate(self : MathsvdPoint) -> MathsvdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathsvdPoint::mid(self : MathsvdPoint, other : MathsvdPoint) -> MathsvdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathsvdPoint::lerp(self : MathsvdPoint, other : MathsvdPoint, t : Double) -> MathsvdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathsvdPoint::to_string(self : MathsvdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathsvdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_svd_make_series(vals : Array[Double], name : String) -> MathsvdSeries {
  { vals, name, meta: 0 }
}

pub fn MathsvdSeries::len(self : MathsvdSeries) -> Int { self.vals.length() }

pub fn MathsvdSeries::sum(self : MathsvdSeries) -> Double { @_common.sum(self.vals) }

pub fn MathsvdSeries::mean(self : MathsvdSeries) -> Double { @_common.mean(self.vals) }

pub fn MathsvdSeries::min(self : MathsvdSeries) -> Double { @_common.min(self.vals) }

pub fn MathsvdSeries::max(self : MathsvdSeries) -> Double { @_common.max(self.vals) }

pub fn MathsvdSeries::range(self : MathsvdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathsvdSeries::variance(self : MathsvdSeries) -> Double { @_common.variance(self.vals) }

pub fn MathsvdSeries::std(self : MathsvdSeries) -> Double { @_common.std(self.vals) }

pub fn MathsvdSeries::median(self : MathsvdSeries) -> Double { @_common.median(self.vals) }

pub fn MathsvdSeries::scale(self : MathsvdSeries, f : Double) -> MathsvdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathsvdSeries::add(self : MathsvdSeries, other : MathsvdSeries) -> MathsvdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathsvdSeries::sub(self : MathsvdSeries, other : MathsvdSeries) -> MathsvdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathsvdSeries::normalize(self : MathsvdSeries) -> MathsvdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathsvdSeries::cumsum(self : MathsvdSeries) -> MathsvdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathsvdSeries::to_string(self : MathsvdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathsvdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_svd_make_matrix(rows : Int, cols : Int, val : Double) -> MathsvdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_svd_matrix_identity(n : Int) -> MathsvdMatrix {
  let m = math_svd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathsvdMatrix::get(self : MathsvdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathsvdMatrix::transpose(self : MathsvdMatrix) -> MathsvdMatrix {
  let result = math_svd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathsvdMatrix::add(self : MathsvdMatrix, other : MathsvdMatrix) -> MathsvdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_svd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathsvdMatrix::scale(self : MathsvdMatrix, s : Double) -> MathsvdMatrix {
  let result = math_svd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathsvdMatrix::multiply(self : MathsvdMatrix, other : MathsvdMatrix) -> MathsvdMatrix {
  if self.cols != other.rows { return math_svd_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_svd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathsvdMatrix::trace(self : MathsvdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathsvdMatrix::det(self : MathsvdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathsvdMatrix::norm(self : MathsvdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathsvdMatrix::to_string(self : MathsvdMatrix) -> String {
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

pub(all) struct MathsvdVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_svd_make_vector(comps : Array[Double]) -> MathsvdVector {
  { comps, dim: comps.length() }
}

pub fn math_svd_vector_zero(dim : Int) -> MathsvdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathsvdVector::add(self : MathsvdVector, other : MathsvdVector) -> MathsvdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathsvdVector::sub(self : MathsvdVector, other : MathsvdVector) -> MathsvdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathsvdVector::scale(self : MathsvdVector, s : Double) -> MathsvdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathsvdVector::dot(self : MathsvdVector, other : MathsvdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathsvdVector::norm(self : MathsvdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathsvdVector::normalize(self : MathsvdVector) -> MathsvdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathsvdVector::dist(self : MathsvdVector, other : MathsvdVector) -> Double {
  self.sub(other).norm()
}

pub fn MathsvdVector::to_string(self : MathsvdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_svd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_svd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_svd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_svd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_svd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_svd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_svd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_svd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_svd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_svd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_svd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_svd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_svd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_svd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_svd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_svd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_svd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_svd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_svd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_svd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_svd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_svd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_svd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_svd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_svd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_svd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_svd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_svd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_svd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathsvdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_frame_make(size : Int) -> MathsvdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_frame_len(s : MathsvdFrame) -> Int { s.size }

pub fn math_svd_frame_get(s : MathsvdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_frame_set(s : MathsvdFrame, i : Int, v : Double) -> MathsvdFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_svd_frame_sum(s : MathsvdFrame) -> Double { @_common.sum(s.data) }

pub fn math_svd_frame_mean(s : MathsvdFrame) -> Double { @_common.mean(s.data) }

pub fn math_svd_frame_scale(s : MathsvdFrame, f : Double) -> MathsvdFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_svd_frame_add(a : MathsvdFrame, b : MathsvdFrame) -> MathsvdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_svd_frame_copy(s : MathsvdFrame) -> MathsvdFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_svd_frame_fill(s : MathsvdFrame, v : Double) -> MathsvdFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_svd_frame_min(s : MathsvdFrame) -> Double { @_common.min(s.data) }

pub fn math_svd_frame_max(s : MathsvdFrame) -> Double { @_common.max(s.data) }

pub fn math_svd_frame_to_string(s : MathsvdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_table_make(size : Int) -> MathsvdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_table_len(s : MathsvdTable) -> Int { s.size }

pub fn math_svd_table_get(s : MathsvdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_table_set(s : MathsvdTable, i : Int, v : Double) -> MathsvdTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_svd_table_sum(s : MathsvdTable) -> Double { @_common.sum(s.data) }

pub fn math_svd_table_mean(s : MathsvdTable) -> Double { @_common.mean(s.data) }

pub fn math_svd_table_scale(s : MathsvdTable, f : Double) -> MathsvdTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_svd_table_add(a : MathsvdTable, b : MathsvdTable) -> MathsvdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_svd_table_copy(s : MathsvdTable) -> MathsvdTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_svd_table_fill(s : MathsvdTable, v : Double) -> MathsvdTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_svd_table_min(s : MathsvdTable) -> Double { @_common.min(s.data) }

pub fn math_svd_table_max(s : MathsvdTable) -> Double { @_common.max(s.data) }

pub fn math_svd_table_to_string(s : MathsvdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_graphn_make(size : Int) -> MathsvdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_graphn_len(s : MathsvdGraphN) -> Int { s.size }

pub fn math_svd_graphn_get(s : MathsvdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_graphn_set(s : MathsvdGraphN, i : Int, v : Double) -> MathsvdGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_svd_graphn_sum(s : MathsvdGraphN) -> Double { @_common.sum(s.data) }

pub fn math_svd_graphn_mean(s : MathsvdGraphN) -> Double { @_common.mean(s.data) }

pub fn math_svd_graphn_scale(s : MathsvdGraphN, f : Double) -> MathsvdGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_svd_graphn_add(a : MathsvdGraphN, b : MathsvdGraphN) -> MathsvdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_svd_graphn_copy(s : MathsvdGraphN) -> MathsvdGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_svd_graphn_fill(s : MathsvdGraphN, v : Double) -> MathsvdGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_svd_graphn_min(s : MathsvdGraphN) -> Double { @_common.min(s.data) }

pub fn math_svd_graphn_max(s : MathsvdGraphN) -> Double { @_common.max(s.data) }

pub fn math_svd_graphn_to_string(s : MathsvdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_node_make(size : Int) -> MathsvdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_node_len(s : MathsvdNode) -> Int { s.size }

pub fn math_svd_node_get(s : MathsvdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_node_set(s : MathsvdNode, i : Int, v : Double) -> MathsvdNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_svd_node_sum(s : MathsvdNode) -> Double { @_common.sum(s.data) }

pub fn math_svd_node_mean(s : MathsvdNode) -> Double { @_common.mean(s.data) }

pub fn math_svd_node_scale(s : MathsvdNode, f : Double) -> MathsvdNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_svd_node_add(a : MathsvdNode, b : MathsvdNode) -> MathsvdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_svd_node_copy(s : MathsvdNode) -> MathsvdNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_svd_node_fill(s : MathsvdNode, v : Double) -> MathsvdNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_svd_node_min(s : MathsvdNode) -> Double { @_common.min(s.data) }

pub fn math_svd_node_max(s : MathsvdNode) -> Double { @_common.max(s.data) }

pub fn math_svd_node_to_string(s : MathsvdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_edge_make(size : Int) -> MathsvdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_edge_len(s : MathsvdEdge) -> Int { s.size }

pub fn math_svd_edge_get(s : MathsvdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_edge_set(s : MathsvdEdge, i : Int, v : Double) -> MathsvdEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_svd_edge_sum(s : MathsvdEdge) -> Double { @_common.sum(s.data) }

pub fn math_svd_edge_mean(s : MathsvdEdge) -> Double { @_common.mean(s.data) }

pub fn math_svd_edge_scale(s : MathsvdEdge, f : Double) -> MathsvdEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_svd_edge_add(a : MathsvdEdge, b : MathsvdEdge) -> MathsvdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_svd_edge_copy(s : MathsvdEdge) -> MathsvdEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_svd_edge_fill(s : MathsvdEdge, v : Double) -> MathsvdEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_svd_edge_min(s : MathsvdEdge) -> Double { @_common.min(s.data) }

pub fn math_svd_edge_max(s : MathsvdEdge) -> Double { @_common.max(s.data) }

pub fn math_svd_edge_to_string(s : MathsvdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_path_make(size : Int) -> MathsvdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_path_len(s : MathsvdPath) -> Int { s.size }

pub fn math_svd_path_get(s : MathsvdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_path_set(s : MathsvdPath, i : Int, v : Double) -> MathsvdPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_svd_path_sum(s : MathsvdPath) -> Double { @_common.sum(s.data) }

pub fn math_svd_path_mean(s : MathsvdPath) -> Double { @_common.mean(s.data) }

pub fn math_svd_path_scale(s : MathsvdPath, f : Double) -> MathsvdPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_svd_path_add(a : MathsvdPath, b : MathsvdPath) -> MathsvdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_svd_path_copy(s : MathsvdPath) -> MathsvdPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_svd_path_fill(s : MathsvdPath, v : Double) -> MathsvdPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_svd_path_min(s : MathsvdPath) -> Double { @_common.min(s.data) }

pub fn math_svd_path_max(s : MathsvdPath) -> Double { @_common.max(s.data) }

pub fn math_svd_path_to_string(s : MathsvdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_cluster_make(size : Int) -> MathsvdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_cluster_len(s : MathsvdCluster) -> Int { s.size }

pub fn math_svd_cluster_get(s : MathsvdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_cluster_set(s : MathsvdCluster, i : Int, v : Double) -> MathsvdCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_svd_cluster_sum(s : MathsvdCluster) -> Double { @_common.sum(s.data) }

pub fn math_svd_cluster_mean(s : MathsvdCluster) -> Double { @_common.mean(s.data) }

pub fn math_svd_cluster_scale(s : MathsvdCluster, f : Double) -> MathsvdCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_svd_cluster_add(a : MathsvdCluster, b : MathsvdCluster) -> MathsvdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_svd_cluster_copy(s : MathsvdCluster) -> MathsvdCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_svd_cluster_fill(s : MathsvdCluster, v : Double) -> MathsvdCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_svd_cluster_min(s : MathsvdCluster) -> Double { @_common.min(s.data) }

pub fn math_svd_cluster_max(s : MathsvdCluster) -> Double { @_common.max(s.data) }

pub fn math_svd_cluster_to_string(s : MathsvdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_model_make(size : Int) -> MathsvdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_model_len(s : MathsvdModel) -> Int { s.size }

pub fn math_svd_model_get(s : MathsvdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_model_set(s : MathsvdModel, i : Int, v : Double) -> MathsvdModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_svd_model_sum(s : MathsvdModel) -> Double { @_common.sum(s.data) }

pub fn math_svd_model_mean(s : MathsvdModel) -> Double { @_common.mean(s.data) }

pub fn math_svd_model_scale(s : MathsvdModel, f : Double) -> MathsvdModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_svd_model_add(a : MathsvdModel, b : MathsvdModel) -> MathsvdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_svd_model_copy(s : MathsvdModel) -> MathsvdModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_svd_model_fill(s : MathsvdModel, v : Double) -> MathsvdModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_svd_model_min(s : MathsvdModel) -> Double { @_common.min(s.data) }

pub fn math_svd_model_max(s : MathsvdModel) -> Double { @_common.max(s.data) }

pub fn math_svd_model_to_string(s : MathsvdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_layer_make(size : Int) -> MathsvdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_layer_len(s : MathsvdLayer) -> Int { s.size }

pub fn math_svd_layer_get(s : MathsvdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_layer_set(s : MathsvdLayer, i : Int, v : Double) -> MathsvdLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_svd_layer_sum(s : MathsvdLayer) -> Double { @_common.sum(s.data) }

pub fn math_svd_layer_mean(s : MathsvdLayer) -> Double { @_common.mean(s.data) }

pub fn math_svd_layer_scale(s : MathsvdLayer, f : Double) -> MathsvdLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_svd_layer_add(a : MathsvdLayer, b : MathsvdLayer) -> MathsvdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_svd_layer_copy(s : MathsvdLayer) -> MathsvdLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_svd_layer_fill(s : MathsvdLayer, v : Double) -> MathsvdLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_svd_layer_min(s : MathsvdLayer) -> Double { @_common.min(s.data) }

pub fn math_svd_layer_max(s : MathsvdLayer) -> Double { @_common.max(s.data) }

pub fn math_svd_layer_to_string(s : MathsvdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_buffer_make(size : Int) -> MathsvdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_buffer_len(s : MathsvdBuffer) -> Int { s.size }

pub fn math_svd_buffer_get(s : MathsvdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_buffer_set(s : MathsvdBuffer, i : Int, v : Double) -> MathsvdBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_svd_buffer_sum(s : MathsvdBuffer) -> Double { @_common.sum(s.data) }

pub fn math_svd_buffer_mean(s : MathsvdBuffer) -> Double { @_common.mean(s.data) }

pub fn math_svd_buffer_scale(s : MathsvdBuffer, f : Double) -> MathsvdBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_svd_buffer_add(a : MathsvdBuffer, b : MathsvdBuffer) -> MathsvdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_svd_buffer_copy(s : MathsvdBuffer) -> MathsvdBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_svd_buffer_fill(s : MathsvdBuffer, v : Double) -> MathsvdBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_svd_buffer_min(s : MathsvdBuffer) -> Double { @_common.min(s.data) }

pub fn math_svd_buffer_max(s : MathsvdBuffer) -> Double { @_common.max(s.data) }

pub fn math_svd_buffer_to_string(s : MathsvdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_cursor_make(size : Int) -> MathsvdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_cursor_len(s : MathsvdCursor) -> Int { s.size }

pub fn math_svd_cursor_get(s : MathsvdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_cursor_set(s : MathsvdCursor, i : Int, v : Double) -> MathsvdCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_svd_cursor_sum(s : MathsvdCursor) -> Double { @_common.sum(s.data) }

pub fn math_svd_cursor_mean(s : MathsvdCursor) -> Double { @_common.mean(s.data) }

pub fn math_svd_cursor_scale(s : MathsvdCursor, f : Double) -> MathsvdCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_svd_cursor_add(a : MathsvdCursor, b : MathsvdCursor) -> MathsvdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_svd_cursor_copy(s : MathsvdCursor) -> MathsvdCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_svd_cursor_fill(s : MathsvdCursor, v : Double) -> MathsvdCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_svd_cursor_min(s : MathsvdCursor) -> Double { @_common.min(s.data) }

pub fn math_svd_cursor_max(s : MathsvdCursor) -> Double { @_common.max(s.data) }

pub fn math_svd_cursor_to_string(s : MathsvdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_view_make(size : Int) -> MathsvdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_view_len(s : MathsvdView) -> Int { s.size }

pub fn math_svd_view_get(s : MathsvdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_view_set(s : MathsvdView, i : Int, v : Double) -> MathsvdView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_svd_view_sum(s : MathsvdView) -> Double { @_common.sum(s.data) }

pub fn math_svd_view_mean(s : MathsvdView) -> Double { @_common.mean(s.data) }

pub fn math_svd_view_scale(s : MathsvdView, f : Double) -> MathsvdView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_svd_view_add(a : MathsvdView, b : MathsvdView) -> MathsvdView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_svd_view_copy(s : MathsvdView) -> MathsvdView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_svd_view_fill(s : MathsvdView, v : Double) -> MathsvdView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_svd_view_min(s : MathsvdView) -> Double { @_common.min(s.data) }

pub fn math_svd_view_max(s : MathsvdView) -> Double { @_common.max(s.data) }

pub fn math_svd_view_to_string(s : MathsvdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_range_make(size : Int) -> MathsvdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_range_len(s : MathsvdRange) -> Int { s.size }

pub fn math_svd_range_get(s : MathsvdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_range_set(s : MathsvdRange, i : Int, v : Double) -> MathsvdRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_svd_range_sum(s : MathsvdRange) -> Double { @_common.sum(s.data) }

pub fn math_svd_range_mean(s : MathsvdRange) -> Double { @_common.mean(s.data) }

pub fn math_svd_range_scale(s : MathsvdRange, f : Double) -> MathsvdRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_svd_range_add(a : MathsvdRange, b : MathsvdRange) -> MathsvdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_svd_range_copy(s : MathsvdRange) -> MathsvdRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_svd_range_fill(s : MathsvdRange, v : Double) -> MathsvdRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_svd_range_min(s : MathsvdRange) -> Double { @_common.min(s.data) }

pub fn math_svd_range_max(s : MathsvdRange) -> Double { @_common.max(s.data) }

pub fn math_svd_range_to_string(s : MathsvdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathsvdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_svd_slice_make(size : Int) -> MathsvdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_svd_slice_len(s : MathsvdSlice) -> Int { s.size }

pub fn math_svd_slice_get(s : MathsvdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_svd_slice_set(s : MathsvdSlice, i : Int, v : Double) -> MathsvdSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_svd_slice_sum(s : MathsvdSlice) -> Double { @_common.sum(s.data) }

pub fn math_svd_slice_mean(s : MathsvdSlice) -> Double { @_common.mean(s.data) }

pub fn math_svd_slice_scale(s : MathsvdSlice, f : Double) -> MathsvdSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_svd_slice_add(a : MathsvdSlice, b : MathsvdSlice) -> MathsvdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_svd_slice_copy(s : MathsvdSlice) -> MathsvdSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_svd_slice_fill(s : MathsvdSlice, v : Double) -> MathsvdSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_svd_slice_min(s : MathsvdSlice) -> Double { @_common.min(s.data) }

pub fn math_svd_slice_max(s : MathsvdSlice) -> Double { @_common.max(s.data) }

pub fn math_svd_slice_to_string(s : MathsvdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

