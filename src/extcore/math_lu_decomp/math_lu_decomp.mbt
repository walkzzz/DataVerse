///===
/// extcore/math_lu_decomp

pub(all) struct MathludecompPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_lu_decomp_make_point(x : Double, y : Double) -> MathludecompPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_lu_decomp_make_point3(x : Double, y : Double, z : Double) -> MathludecompPoint {
  { x, y, z, label: 0 }
}

pub fn MathludecompPoint::x(self : MathludecompPoint) -> Double { self.x }

pub fn MathludecompPoint::y(self : MathludecompPoint) -> Double { self.y }

pub fn MathludecompPoint::z(self : MathludecompPoint) -> Double { self.z }

pub fn MathludecompPoint::label(self : MathludecompPoint) -> Int { self.label }

pub fn MathludecompPoint::dist(self : MathludecompPoint, other : MathludecompPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathludecompPoint::add(self : MathludecompPoint, other : MathludecompPoint) -> MathludecompPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathludecompPoint::sub(self : MathludecompPoint, other : MathludecompPoint) -> MathludecompPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathludecompPoint::scale(self : MathludecompPoint, s : Double) -> MathludecompPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathludecompPoint::dot(self : MathludecompPoint, other : MathludecompPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathludecompPoint::cross(self : MathludecompPoint, other : MathludecompPoint) -> MathludecompPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathludecompPoint::norm(self : MathludecompPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathludecompPoint::normalize(self : MathludecompPoint) -> MathludecompPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathludecompPoint::negate(self : MathludecompPoint) -> MathludecompPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathludecompPoint::mid(self : MathludecompPoint, other : MathludecompPoint) -> MathludecompPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathludecompPoint::lerp(self : MathludecompPoint, other : MathludecompPoint, t : Double) -> MathludecompPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathludecompPoint::to_string(self : MathludecompPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathludecompSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_lu_decomp_make_series(vals : Array[Double], name : String) -> MathludecompSeries {
  { vals, name, meta: 0 }
}

pub fn MathludecompSeries::len(self : MathludecompSeries) -> Int { self.vals.length() }

pub fn MathludecompSeries::sum(self : MathludecompSeries) -> Double { @_common.sum(self.vals) }

pub fn MathludecompSeries::mean(self : MathludecompSeries) -> Double { @_common.mean(self.vals) }

pub fn MathludecompSeries::min(self : MathludecompSeries) -> Double { @_common.min(self.vals) }

pub fn MathludecompSeries::max(self : MathludecompSeries) -> Double { @_common.max(self.vals) }

pub fn MathludecompSeries::range(self : MathludecompSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathludecompSeries::variance(self : MathludecompSeries) -> Double { @_common.variance(self.vals) }

pub fn MathludecompSeries::std(self : MathludecompSeries) -> Double { @_common.std(self.vals) }

pub fn MathludecompSeries::median(self : MathludecompSeries) -> Double { @_common.median(self.vals) }

pub fn MathludecompSeries::scale(self : MathludecompSeries, f : Double) -> MathludecompSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathludecompSeries::add(self : MathludecompSeries, other : MathludecompSeries) -> MathludecompSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathludecompSeries::sub(self : MathludecompSeries, other : MathludecompSeries) -> MathludecompSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathludecompSeries::normalize(self : MathludecompSeries) -> MathludecompSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathludecompSeries::cumsum(self : MathludecompSeries) -> MathludecompSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathludecompSeries::to_string(self : MathludecompSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathludecompMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_lu_decomp_make_matrix(rows : Int, cols : Int, val : Double) -> MathludecompMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_lu_decomp_matrix_identity(n : Int) -> MathludecompMatrix {
  let m = math_lu_decomp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathludecompMatrix::get(self : MathludecompMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathludecompMatrix::transpose(self : MathludecompMatrix) -> MathludecompMatrix {
  let result = math_lu_decomp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathludecompMatrix::add(self : MathludecompMatrix, other : MathludecompMatrix) -> MathludecompMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_lu_decomp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathludecompMatrix::scale(self : MathludecompMatrix, s : Double) -> MathludecompMatrix {
  let result = math_lu_decomp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathludecompMatrix::multiply(self : MathludecompMatrix, other : MathludecompMatrix) -> MathludecompMatrix {
  if self.cols != other.rows { return math_lu_decomp_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_lu_decomp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathludecompMatrix::trace(self : MathludecompMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathludecompMatrix::det(self : MathludecompMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathludecompMatrix::norm(self : MathludecompMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathludecompMatrix::to_string(self : MathludecompMatrix) -> String {
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

pub(all) struct MathludecompVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_lu_decomp_make_vector(comps : Array[Double]) -> MathludecompVector {
  { comps, dim: comps.length() }
}

pub fn math_lu_decomp_vector_zero(dim : Int) -> MathludecompVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathludecompVector::add(self : MathludecompVector, other : MathludecompVector) -> MathludecompVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathludecompVector::sub(self : MathludecompVector, other : MathludecompVector) -> MathludecompVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathludecompVector::scale(self : MathludecompVector, s : Double) -> MathludecompVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathludecompVector::dot(self : MathludecompVector, other : MathludecompVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathludecompVector::norm(self : MathludecompVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathludecompVector::normalize(self : MathludecompVector) -> MathludecompVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathludecompVector::dist(self : MathludecompVector, other : MathludecompVector) -> Double {
  self.sub(other).norm()
}

pub fn MathludecompVector::to_string(self : MathludecompVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_lu_decomp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_lu_decomp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_lu_decomp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_lu_decomp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_lu_decomp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_lu_decomp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_lu_decomp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_lu_decomp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_lu_decomp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_lu_decomp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_lu_decomp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_lu_decomp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_lu_decomp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_lu_decomp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_lu_decomp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_lu_decomp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_lu_decomp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_lu_decomp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_lu_decomp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_lu_decomp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_lu_decomp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_lu_decomp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_lu_decomp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_lu_decomp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_lu_decomp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_lu_decomp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_lu_decomp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_lu_decomp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_lu_decomp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathludecompFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_frame_make(size : Int) -> MathludecompFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_frame_len(s : MathludecompFrame) -> Int { s.size }

pub fn math_lu_decomp_frame_get(s : MathludecompFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_frame_set(s : MathludecompFrame, i : Int, v : Double) -> MathludecompFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_frame_sum(s : MathludecompFrame) -> Double { @_common.sum(s.data) }

pub fn math_lu_decomp_frame_mean(s : MathludecompFrame) -> Double { @_common.mean(s.data) }

pub fn math_lu_decomp_frame_scale(s : MathludecompFrame, f : Double) -> MathludecompFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_frame_add(a : MathludecompFrame, b : MathludecompFrame) -> MathludecompFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_lu_decomp_frame_copy(s : MathludecompFrame) -> MathludecompFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_frame_fill(s : MathludecompFrame, v : Double) -> MathludecompFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_frame_min(s : MathludecompFrame) -> Double { @_common.min(s.data) }

pub fn math_lu_decomp_frame_max(s : MathludecompFrame) -> Double { @_common.max(s.data) }

pub fn math_lu_decomp_frame_to_string(s : MathludecompFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_table_make(size : Int) -> MathludecompTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_table_len(s : MathludecompTable) -> Int { s.size }

pub fn math_lu_decomp_table_get(s : MathludecompTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_table_set(s : MathludecompTable, i : Int, v : Double) -> MathludecompTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_table_sum(s : MathludecompTable) -> Double { @_common.sum(s.data) }

pub fn math_lu_decomp_table_mean(s : MathludecompTable) -> Double { @_common.mean(s.data) }

pub fn math_lu_decomp_table_scale(s : MathludecompTable, f : Double) -> MathludecompTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_table_add(a : MathludecompTable, b : MathludecompTable) -> MathludecompTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_lu_decomp_table_copy(s : MathludecompTable) -> MathludecompTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_table_fill(s : MathludecompTable, v : Double) -> MathludecompTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_table_min(s : MathludecompTable) -> Double { @_common.min(s.data) }

pub fn math_lu_decomp_table_max(s : MathludecompTable) -> Double { @_common.max(s.data) }

pub fn math_lu_decomp_table_to_string(s : MathludecompTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_graphn_make(size : Int) -> MathludecompGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_graphn_len(s : MathludecompGraphN) -> Int { s.size }

pub fn math_lu_decomp_graphn_get(s : MathludecompGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_graphn_set(s : MathludecompGraphN, i : Int, v : Double) -> MathludecompGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_graphn_sum(s : MathludecompGraphN) -> Double { @_common.sum(s.data) }

pub fn math_lu_decomp_graphn_mean(s : MathludecompGraphN) -> Double { @_common.mean(s.data) }

pub fn math_lu_decomp_graphn_scale(s : MathludecompGraphN, f : Double) -> MathludecompGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_graphn_add(a : MathludecompGraphN, b : MathludecompGraphN) -> MathludecompGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_lu_decomp_graphn_copy(s : MathludecompGraphN) -> MathludecompGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_graphn_fill(s : MathludecompGraphN, v : Double) -> MathludecompGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_graphn_min(s : MathludecompGraphN) -> Double { @_common.min(s.data) }

pub fn math_lu_decomp_graphn_max(s : MathludecompGraphN) -> Double { @_common.max(s.data) }

pub fn math_lu_decomp_graphn_to_string(s : MathludecompGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_node_make(size : Int) -> MathludecompNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_node_len(s : MathludecompNode) -> Int { s.size }

pub fn math_lu_decomp_node_get(s : MathludecompNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_node_set(s : MathludecompNode, i : Int, v : Double) -> MathludecompNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_node_sum(s : MathludecompNode) -> Double { @_common.sum(s.data) }

pub fn math_lu_decomp_node_mean(s : MathludecompNode) -> Double { @_common.mean(s.data) }

pub fn math_lu_decomp_node_scale(s : MathludecompNode, f : Double) -> MathludecompNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_node_add(a : MathludecompNode, b : MathludecompNode) -> MathludecompNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_lu_decomp_node_copy(s : MathludecompNode) -> MathludecompNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_node_fill(s : MathludecompNode, v : Double) -> MathludecompNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_node_min(s : MathludecompNode) -> Double { @_common.min(s.data) }

pub fn math_lu_decomp_node_max(s : MathludecompNode) -> Double { @_common.max(s.data) }

pub fn math_lu_decomp_node_to_string(s : MathludecompNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_edge_make(size : Int) -> MathludecompEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_edge_len(s : MathludecompEdge) -> Int { s.size }

pub fn math_lu_decomp_edge_get(s : MathludecompEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_edge_set(s : MathludecompEdge, i : Int, v : Double) -> MathludecompEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_edge_sum(s : MathludecompEdge) -> Double { @_common.sum(s.data) }

pub fn math_lu_decomp_edge_mean(s : MathludecompEdge) -> Double { @_common.mean(s.data) }

pub fn math_lu_decomp_edge_scale(s : MathludecompEdge, f : Double) -> MathludecompEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_edge_add(a : MathludecompEdge, b : MathludecompEdge) -> MathludecompEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_lu_decomp_edge_copy(s : MathludecompEdge) -> MathludecompEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_edge_fill(s : MathludecompEdge, v : Double) -> MathludecompEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_edge_min(s : MathludecompEdge) -> Double { @_common.min(s.data) }

pub fn math_lu_decomp_edge_max(s : MathludecompEdge) -> Double { @_common.max(s.data) }

pub fn math_lu_decomp_edge_to_string(s : MathludecompEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_path_make(size : Int) -> MathludecompPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_path_len(s : MathludecompPath) -> Int { s.size }

pub fn math_lu_decomp_path_get(s : MathludecompPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_path_set(s : MathludecompPath, i : Int, v : Double) -> MathludecompPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_path_sum(s : MathludecompPath) -> Double { @_common.sum(s.data) }

pub fn math_lu_decomp_path_mean(s : MathludecompPath) -> Double { @_common.mean(s.data) }

pub fn math_lu_decomp_path_scale(s : MathludecompPath, f : Double) -> MathludecompPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_path_add(a : MathludecompPath, b : MathludecompPath) -> MathludecompPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_lu_decomp_path_copy(s : MathludecompPath) -> MathludecompPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_path_fill(s : MathludecompPath, v : Double) -> MathludecompPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_path_min(s : MathludecompPath) -> Double { @_common.min(s.data) }

pub fn math_lu_decomp_path_max(s : MathludecompPath) -> Double { @_common.max(s.data) }

pub fn math_lu_decomp_path_to_string(s : MathludecompPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_cluster_make(size : Int) -> MathludecompCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_cluster_len(s : MathludecompCluster) -> Int { s.size }

pub fn math_lu_decomp_cluster_get(s : MathludecompCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_cluster_set(s : MathludecompCluster, i : Int, v : Double) -> MathludecompCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_cluster_sum(s : MathludecompCluster) -> Double { @_common.sum(s.data) }

pub fn math_lu_decomp_cluster_mean(s : MathludecompCluster) -> Double { @_common.mean(s.data) }

pub fn math_lu_decomp_cluster_scale(s : MathludecompCluster, f : Double) -> MathludecompCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_cluster_add(a : MathludecompCluster, b : MathludecompCluster) -> MathludecompCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_lu_decomp_cluster_copy(s : MathludecompCluster) -> MathludecompCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_cluster_fill(s : MathludecompCluster, v : Double) -> MathludecompCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_cluster_min(s : MathludecompCluster) -> Double { @_common.min(s.data) }

pub fn math_lu_decomp_cluster_max(s : MathludecompCluster) -> Double { @_common.max(s.data) }

pub fn math_lu_decomp_cluster_to_string(s : MathludecompCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_model_make(size : Int) -> MathludecompModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_model_len(s : MathludecompModel) -> Int { s.size }

pub fn math_lu_decomp_model_get(s : MathludecompModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_model_set(s : MathludecompModel, i : Int, v : Double) -> MathludecompModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_model_sum(s : MathludecompModel) -> Double { @_common.sum(s.data) }

pub fn math_lu_decomp_model_mean(s : MathludecompModel) -> Double { @_common.mean(s.data) }

pub fn math_lu_decomp_model_scale(s : MathludecompModel, f : Double) -> MathludecompModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_model_add(a : MathludecompModel, b : MathludecompModel) -> MathludecompModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_lu_decomp_model_copy(s : MathludecompModel) -> MathludecompModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_model_fill(s : MathludecompModel, v : Double) -> MathludecompModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_model_min(s : MathludecompModel) -> Double { @_common.min(s.data) }

pub fn math_lu_decomp_model_max(s : MathludecompModel) -> Double { @_common.max(s.data) }

pub fn math_lu_decomp_model_to_string(s : MathludecompModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_layer_make(size : Int) -> MathludecompLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_layer_len(s : MathludecompLayer) -> Int { s.size }

pub fn math_lu_decomp_layer_get(s : MathludecompLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_layer_set(s : MathludecompLayer, i : Int, v : Double) -> MathludecompLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_layer_sum(s : MathludecompLayer) -> Double { @_common.sum(s.data) }

pub fn math_lu_decomp_layer_mean(s : MathludecompLayer) -> Double { @_common.mean(s.data) }

pub fn math_lu_decomp_layer_scale(s : MathludecompLayer, f : Double) -> MathludecompLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_layer_add(a : MathludecompLayer, b : MathludecompLayer) -> MathludecompLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_lu_decomp_layer_copy(s : MathludecompLayer) -> MathludecompLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_layer_fill(s : MathludecompLayer, v : Double) -> MathludecompLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_layer_min(s : MathludecompLayer) -> Double { @_common.min(s.data) }

pub fn math_lu_decomp_layer_max(s : MathludecompLayer) -> Double { @_common.max(s.data) }

pub fn math_lu_decomp_layer_to_string(s : MathludecompLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_buffer_make(size : Int) -> MathludecompBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_buffer_len(s : MathludecompBuffer) -> Int { s.size }

pub fn math_lu_decomp_buffer_get(s : MathludecompBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_buffer_set(s : MathludecompBuffer, i : Int, v : Double) -> MathludecompBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_buffer_sum(s : MathludecompBuffer) -> Double { @_common.sum(s.data) }

pub fn math_lu_decomp_buffer_mean(s : MathludecompBuffer) -> Double { @_common.mean(s.data) }

pub fn math_lu_decomp_buffer_scale(s : MathludecompBuffer, f : Double) -> MathludecompBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_buffer_add(a : MathludecompBuffer, b : MathludecompBuffer) -> MathludecompBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_lu_decomp_buffer_copy(s : MathludecompBuffer) -> MathludecompBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_buffer_fill(s : MathludecompBuffer, v : Double) -> MathludecompBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_buffer_min(s : MathludecompBuffer) -> Double { @_common.min(s.data) }

pub fn math_lu_decomp_buffer_max(s : MathludecompBuffer) -> Double { @_common.max(s.data) }

pub fn math_lu_decomp_buffer_to_string(s : MathludecompBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_cursor_make(size : Int) -> MathludecompCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_cursor_len(s : MathludecompCursor) -> Int { s.size }

pub fn math_lu_decomp_cursor_get(s : MathludecompCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_cursor_set(s : MathludecompCursor, i : Int, v : Double) -> MathludecompCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_cursor_sum(s : MathludecompCursor) -> Double { @_common.sum(s.data) }

pub fn math_lu_decomp_cursor_mean(s : MathludecompCursor) -> Double { @_common.mean(s.data) }

pub fn math_lu_decomp_cursor_scale(s : MathludecompCursor, f : Double) -> MathludecompCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_cursor_add(a : MathludecompCursor, b : MathludecompCursor) -> MathludecompCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_lu_decomp_cursor_copy(s : MathludecompCursor) -> MathludecompCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_cursor_fill(s : MathludecompCursor, v : Double) -> MathludecompCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_cursor_min(s : MathludecompCursor) -> Double { @_common.min(s.data) }

pub fn math_lu_decomp_cursor_max(s : MathludecompCursor) -> Double { @_common.max(s.data) }

pub fn math_lu_decomp_cursor_to_string(s : MathludecompCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_view_make(size : Int) -> MathludecompView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_view_len(s : MathludecompView) -> Int { s.size }

pub fn math_lu_decomp_view_get(s : MathludecompView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_view_set(s : MathludecompView, i : Int, v : Double) -> MathludecompView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_view_sum(s : MathludecompView) -> Double { @_common.sum(s.data) }

pub fn math_lu_decomp_view_mean(s : MathludecompView) -> Double { @_common.mean(s.data) }

pub fn math_lu_decomp_view_scale(s : MathludecompView, f : Double) -> MathludecompView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_view_add(a : MathludecompView, b : MathludecompView) -> MathludecompView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_lu_decomp_view_copy(s : MathludecompView) -> MathludecompView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_view_fill(s : MathludecompView, v : Double) -> MathludecompView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_view_min(s : MathludecompView) -> Double { @_common.min(s.data) }

pub fn math_lu_decomp_view_max(s : MathludecompView) -> Double { @_common.max(s.data) }

pub fn math_lu_decomp_view_to_string(s : MathludecompView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_range_make(size : Int) -> MathludecompRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_range_len(s : MathludecompRange) -> Int { s.size }

pub fn math_lu_decomp_range_get(s : MathludecompRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_range_set(s : MathludecompRange, i : Int, v : Double) -> MathludecompRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_range_sum(s : MathludecompRange) -> Double { @_common.sum(s.data) }

pub fn math_lu_decomp_range_mean(s : MathludecompRange) -> Double { @_common.mean(s.data) }

pub fn math_lu_decomp_range_scale(s : MathludecompRange, f : Double) -> MathludecompRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_range_add(a : MathludecompRange, b : MathludecompRange) -> MathludecompRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_lu_decomp_range_copy(s : MathludecompRange) -> MathludecompRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_range_fill(s : MathludecompRange, v : Double) -> MathludecompRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_range_min(s : MathludecompRange) -> Double { @_common.min(s.data) }

pub fn math_lu_decomp_range_max(s : MathludecompRange) -> Double { @_common.max(s.data) }

pub fn math_lu_decomp_range_to_string(s : MathludecompRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathludecompSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_lu_decomp_slice_make(size : Int) -> MathludecompSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_lu_decomp_slice_len(s : MathludecompSlice) -> Int { s.size }

pub fn math_lu_decomp_slice_get(s : MathludecompSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_lu_decomp_slice_set(s : MathludecompSlice, i : Int, v : Double) -> MathludecompSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_slice_sum(s : MathludecompSlice) -> Double { @_common.sum(s.data) }

pub fn math_lu_decomp_slice_mean(s : MathludecompSlice) -> Double { @_common.mean(s.data) }

pub fn math_lu_decomp_slice_scale(s : MathludecompSlice, f : Double) -> MathludecompSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_slice_add(a : MathludecompSlice, b : MathludecompSlice) -> MathludecompSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_lu_decomp_slice_copy(s : MathludecompSlice) -> MathludecompSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_slice_fill(s : MathludecompSlice, v : Double) -> MathludecompSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_lu_decomp_slice_min(s : MathludecompSlice) -> Double { @_common.min(s.data) }

pub fn math_lu_decomp_slice_max(s : MathludecompSlice) -> Double { @_common.max(s.data) }

pub fn math_lu_decomp_slice_to_string(s : MathludecompSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

