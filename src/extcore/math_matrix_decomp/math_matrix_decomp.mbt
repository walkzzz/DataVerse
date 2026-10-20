///===
/// extcore/math_matrix_decomp

pub(all) struct MathmatrixdecompPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_matrix_decomp_make_point(x : Double, y : Double) -> MathmatrixdecompPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_matrix_decomp_make_point3(x : Double, y : Double, z : Double) -> MathmatrixdecompPoint {
  { x, y, z, label: 0 }
}

pub fn MathmatrixdecompPoint::x(self : MathmatrixdecompPoint) -> Double { self.x }

pub fn MathmatrixdecompPoint::y(self : MathmatrixdecompPoint) -> Double { self.y }

pub fn MathmatrixdecompPoint::z(self : MathmatrixdecompPoint) -> Double { self.z }

pub fn MathmatrixdecompPoint::label(self : MathmatrixdecompPoint) -> Int { self.label }

pub fn MathmatrixdecompPoint::dist(self : MathmatrixdecompPoint, other : MathmatrixdecompPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathmatrixdecompPoint::add(self : MathmatrixdecompPoint, other : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathmatrixdecompPoint::sub(self : MathmatrixdecompPoint, other : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathmatrixdecompPoint::scale(self : MathmatrixdecompPoint, s : Double) -> MathmatrixdecompPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathmatrixdecompPoint::dot(self : MathmatrixdecompPoint, other : MathmatrixdecompPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathmatrixdecompPoint::cross(self : MathmatrixdecompPoint, other : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathmatrixdecompPoint::norm(self : MathmatrixdecompPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathmatrixdecompPoint::normalize(self : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathmatrixdecompPoint::negate(self : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathmatrixdecompPoint::mid(self : MathmatrixdecompPoint, other : MathmatrixdecompPoint) -> MathmatrixdecompPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathmatrixdecompPoint::lerp(self : MathmatrixdecompPoint, other : MathmatrixdecompPoint, t : Double) -> MathmatrixdecompPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathmatrixdecompPoint::to_string(self : MathmatrixdecompPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathmatrixdecompSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_matrix_decomp_make_series(vals : Array[Double], name : String) -> MathmatrixdecompSeries {
  { vals, name, meta: 0 }
}

pub fn MathmatrixdecompSeries::len(self : MathmatrixdecompSeries) -> Int { self.vals.length() }

pub fn MathmatrixdecompSeries::sum(self : MathmatrixdecompSeries) -> Double { @_common.sum(self.vals) }

pub fn MathmatrixdecompSeries::mean(self : MathmatrixdecompSeries) -> Double { @_common.mean(self.vals) }

pub fn MathmatrixdecompSeries::min(self : MathmatrixdecompSeries) -> Double { @_common.min(self.vals) }

pub fn MathmatrixdecompSeries::max(self : MathmatrixdecompSeries) -> Double { @_common.max(self.vals) }

pub fn MathmatrixdecompSeries::range(self : MathmatrixdecompSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathmatrixdecompSeries::variance(self : MathmatrixdecompSeries) -> Double { @_common.variance(self.vals) }

pub fn MathmatrixdecompSeries::std(self : MathmatrixdecompSeries) -> Double { @_common.std(self.vals) }

pub fn MathmatrixdecompSeries::median(self : MathmatrixdecompSeries) -> Double { @_common.median(self.vals) }

pub fn MathmatrixdecompSeries::scale(self : MathmatrixdecompSeries, f : Double) -> MathmatrixdecompSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathmatrixdecompSeries::add(self : MathmatrixdecompSeries, other : MathmatrixdecompSeries) -> MathmatrixdecompSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathmatrixdecompSeries::sub(self : MathmatrixdecompSeries, other : MathmatrixdecompSeries) -> MathmatrixdecompSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathmatrixdecompSeries::normalize(self : MathmatrixdecompSeries) -> MathmatrixdecompSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathmatrixdecompSeries::cumsum(self : MathmatrixdecompSeries) -> MathmatrixdecompSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathmatrixdecompSeries::to_string(self : MathmatrixdecompSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathmatrixdecompMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_matrix_decomp_make_matrix(rows : Int, cols : Int, val : Double) -> MathmatrixdecompMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_matrix_decomp_matrix_identity(n : Int) -> MathmatrixdecompMatrix {
  let m = math_matrix_decomp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathmatrixdecompMatrix::get(self : MathmatrixdecompMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathmatrixdecompMatrix::transpose(self : MathmatrixdecompMatrix) -> MathmatrixdecompMatrix {
  let result = math_matrix_decomp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathmatrixdecompMatrix::add(self : MathmatrixdecompMatrix, other : MathmatrixdecompMatrix) -> MathmatrixdecompMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_matrix_decomp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathmatrixdecompMatrix::scale(self : MathmatrixdecompMatrix, s : Double) -> MathmatrixdecompMatrix {
  let result = math_matrix_decomp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathmatrixdecompMatrix::multiply(self : MathmatrixdecompMatrix, other : MathmatrixdecompMatrix) -> MathmatrixdecompMatrix {
  if self.cols != other.rows { return math_matrix_decomp_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_matrix_decomp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathmatrixdecompMatrix::trace(self : MathmatrixdecompMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathmatrixdecompMatrix::det(self : MathmatrixdecompMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathmatrixdecompMatrix::norm(self : MathmatrixdecompMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathmatrixdecompMatrix::to_string(self : MathmatrixdecompMatrix) -> String {
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

pub(all) struct MathmatrixdecompVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_matrix_decomp_make_vector(comps : Array[Double]) -> MathmatrixdecompVector {
  { comps, dim: comps.length() }
}

pub fn math_matrix_decomp_vector_zero(dim : Int) -> MathmatrixdecompVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathmatrixdecompVector::add(self : MathmatrixdecompVector, other : MathmatrixdecompVector) -> MathmatrixdecompVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathmatrixdecompVector::sub(self : MathmatrixdecompVector, other : MathmatrixdecompVector) -> MathmatrixdecompVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathmatrixdecompVector::scale(self : MathmatrixdecompVector, s : Double) -> MathmatrixdecompVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathmatrixdecompVector::dot(self : MathmatrixdecompVector, other : MathmatrixdecompVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathmatrixdecompVector::norm(self : MathmatrixdecompVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathmatrixdecompVector::normalize(self : MathmatrixdecompVector) -> MathmatrixdecompVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathmatrixdecompVector::dist(self : MathmatrixdecompVector, other : MathmatrixdecompVector) -> Double {
  self.sub(other).norm()
}

pub fn MathmatrixdecompVector::to_string(self : MathmatrixdecompVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_matrix_decomp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_matrix_decomp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_matrix_decomp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_matrix_decomp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_matrix_decomp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_matrix_decomp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_matrix_decomp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_matrix_decomp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_matrix_decomp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_matrix_decomp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_matrix_decomp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_matrix_decomp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_matrix_decomp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_matrix_decomp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_matrix_decomp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_matrix_decomp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_matrix_decomp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_matrix_decomp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_matrix_decomp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_matrix_decomp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_matrix_decomp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_matrix_decomp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_matrix_decomp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_matrix_decomp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_matrix_decomp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_matrix_decomp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_matrix_decomp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_matrix_decomp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_matrix_decomp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathmatrixdecompFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_frame_make(size : Int) -> MathmatrixdecompFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_frame_len(s : MathmatrixdecompFrame) -> Int { s.size }

pub fn math_matrix_decomp_frame_get(s : MathmatrixdecompFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_frame_set(s : MathmatrixdecompFrame, i : Int, v : Double) -> MathmatrixdecompFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_frame_sum(s : MathmatrixdecompFrame) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_frame_mean(s : MathmatrixdecompFrame) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_frame_scale(s : MathmatrixdecompFrame, f : Double) -> MathmatrixdecompFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_frame_add(a : MathmatrixdecompFrame, b : MathmatrixdecompFrame) -> MathmatrixdecompFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_frame_copy(s : MathmatrixdecompFrame) -> MathmatrixdecompFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_frame_fill(s : MathmatrixdecompFrame, v : Double) -> MathmatrixdecompFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_frame_min(s : MathmatrixdecompFrame) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_frame_max(s : MathmatrixdecompFrame) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_frame_to_string(s : MathmatrixdecompFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_table_make(size : Int) -> MathmatrixdecompTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_table_len(s : MathmatrixdecompTable) -> Int { s.size }

pub fn math_matrix_decomp_table_get(s : MathmatrixdecompTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_table_set(s : MathmatrixdecompTable, i : Int, v : Double) -> MathmatrixdecompTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_table_sum(s : MathmatrixdecompTable) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_table_mean(s : MathmatrixdecompTable) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_table_scale(s : MathmatrixdecompTable, f : Double) -> MathmatrixdecompTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_table_add(a : MathmatrixdecompTable, b : MathmatrixdecompTable) -> MathmatrixdecompTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_table_copy(s : MathmatrixdecompTable) -> MathmatrixdecompTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_table_fill(s : MathmatrixdecompTable, v : Double) -> MathmatrixdecompTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_table_min(s : MathmatrixdecompTable) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_table_max(s : MathmatrixdecompTable) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_table_to_string(s : MathmatrixdecompTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_graphn_make(size : Int) -> MathmatrixdecompGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_graphn_len(s : MathmatrixdecompGraphN) -> Int { s.size }

pub fn math_matrix_decomp_graphn_get(s : MathmatrixdecompGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_graphn_set(s : MathmatrixdecompGraphN, i : Int, v : Double) -> MathmatrixdecompGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_graphn_sum(s : MathmatrixdecompGraphN) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_graphn_mean(s : MathmatrixdecompGraphN) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_graphn_scale(s : MathmatrixdecompGraphN, f : Double) -> MathmatrixdecompGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_graphn_add(a : MathmatrixdecompGraphN, b : MathmatrixdecompGraphN) -> MathmatrixdecompGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_graphn_copy(s : MathmatrixdecompGraphN) -> MathmatrixdecompGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_graphn_fill(s : MathmatrixdecompGraphN, v : Double) -> MathmatrixdecompGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_graphn_min(s : MathmatrixdecompGraphN) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_graphn_max(s : MathmatrixdecompGraphN) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_graphn_to_string(s : MathmatrixdecompGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_node_make(size : Int) -> MathmatrixdecompNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_node_len(s : MathmatrixdecompNode) -> Int { s.size }

pub fn math_matrix_decomp_node_get(s : MathmatrixdecompNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_node_set(s : MathmatrixdecompNode, i : Int, v : Double) -> MathmatrixdecompNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_node_sum(s : MathmatrixdecompNode) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_node_mean(s : MathmatrixdecompNode) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_node_scale(s : MathmatrixdecompNode, f : Double) -> MathmatrixdecompNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_node_add(a : MathmatrixdecompNode, b : MathmatrixdecompNode) -> MathmatrixdecompNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_node_copy(s : MathmatrixdecompNode) -> MathmatrixdecompNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_node_fill(s : MathmatrixdecompNode, v : Double) -> MathmatrixdecompNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_node_min(s : MathmatrixdecompNode) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_node_max(s : MathmatrixdecompNode) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_node_to_string(s : MathmatrixdecompNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_edge_make(size : Int) -> MathmatrixdecompEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_edge_len(s : MathmatrixdecompEdge) -> Int { s.size }

pub fn math_matrix_decomp_edge_get(s : MathmatrixdecompEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_edge_set(s : MathmatrixdecompEdge, i : Int, v : Double) -> MathmatrixdecompEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_edge_sum(s : MathmatrixdecompEdge) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_edge_mean(s : MathmatrixdecompEdge) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_edge_scale(s : MathmatrixdecompEdge, f : Double) -> MathmatrixdecompEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_edge_add(a : MathmatrixdecompEdge, b : MathmatrixdecompEdge) -> MathmatrixdecompEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_edge_copy(s : MathmatrixdecompEdge) -> MathmatrixdecompEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_edge_fill(s : MathmatrixdecompEdge, v : Double) -> MathmatrixdecompEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_edge_min(s : MathmatrixdecompEdge) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_edge_max(s : MathmatrixdecompEdge) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_edge_to_string(s : MathmatrixdecompEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_path_make(size : Int) -> MathmatrixdecompPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_path_len(s : MathmatrixdecompPath) -> Int { s.size }

pub fn math_matrix_decomp_path_get(s : MathmatrixdecompPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_path_set(s : MathmatrixdecompPath, i : Int, v : Double) -> MathmatrixdecompPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_path_sum(s : MathmatrixdecompPath) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_path_mean(s : MathmatrixdecompPath) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_path_scale(s : MathmatrixdecompPath, f : Double) -> MathmatrixdecompPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_path_add(a : MathmatrixdecompPath, b : MathmatrixdecompPath) -> MathmatrixdecompPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_path_copy(s : MathmatrixdecompPath) -> MathmatrixdecompPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_path_fill(s : MathmatrixdecompPath, v : Double) -> MathmatrixdecompPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_path_min(s : MathmatrixdecompPath) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_path_max(s : MathmatrixdecompPath) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_path_to_string(s : MathmatrixdecompPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_cluster_make(size : Int) -> MathmatrixdecompCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_cluster_len(s : MathmatrixdecompCluster) -> Int { s.size }

pub fn math_matrix_decomp_cluster_get(s : MathmatrixdecompCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_cluster_set(s : MathmatrixdecompCluster, i : Int, v : Double) -> MathmatrixdecompCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cluster_sum(s : MathmatrixdecompCluster) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_cluster_mean(s : MathmatrixdecompCluster) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_cluster_scale(s : MathmatrixdecompCluster, f : Double) -> MathmatrixdecompCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cluster_add(a : MathmatrixdecompCluster, b : MathmatrixdecompCluster) -> MathmatrixdecompCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_cluster_copy(s : MathmatrixdecompCluster) -> MathmatrixdecompCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cluster_fill(s : MathmatrixdecompCluster, v : Double) -> MathmatrixdecompCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cluster_min(s : MathmatrixdecompCluster) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_cluster_max(s : MathmatrixdecompCluster) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_cluster_to_string(s : MathmatrixdecompCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_model_make(size : Int) -> MathmatrixdecompModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_model_len(s : MathmatrixdecompModel) -> Int { s.size }

pub fn math_matrix_decomp_model_get(s : MathmatrixdecompModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_model_set(s : MathmatrixdecompModel, i : Int, v : Double) -> MathmatrixdecompModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_model_sum(s : MathmatrixdecompModel) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_model_mean(s : MathmatrixdecompModel) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_model_scale(s : MathmatrixdecompModel, f : Double) -> MathmatrixdecompModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_model_add(a : MathmatrixdecompModel, b : MathmatrixdecompModel) -> MathmatrixdecompModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_model_copy(s : MathmatrixdecompModel) -> MathmatrixdecompModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_model_fill(s : MathmatrixdecompModel, v : Double) -> MathmatrixdecompModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_model_min(s : MathmatrixdecompModel) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_model_max(s : MathmatrixdecompModel) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_model_to_string(s : MathmatrixdecompModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_layer_make(size : Int) -> MathmatrixdecompLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_layer_len(s : MathmatrixdecompLayer) -> Int { s.size }

pub fn math_matrix_decomp_layer_get(s : MathmatrixdecompLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_layer_set(s : MathmatrixdecompLayer, i : Int, v : Double) -> MathmatrixdecompLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_layer_sum(s : MathmatrixdecompLayer) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_layer_mean(s : MathmatrixdecompLayer) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_layer_scale(s : MathmatrixdecompLayer, f : Double) -> MathmatrixdecompLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_layer_add(a : MathmatrixdecompLayer, b : MathmatrixdecompLayer) -> MathmatrixdecompLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_layer_copy(s : MathmatrixdecompLayer) -> MathmatrixdecompLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_layer_fill(s : MathmatrixdecompLayer, v : Double) -> MathmatrixdecompLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_layer_min(s : MathmatrixdecompLayer) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_layer_max(s : MathmatrixdecompLayer) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_layer_to_string(s : MathmatrixdecompLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_buffer_make(size : Int) -> MathmatrixdecompBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_buffer_len(s : MathmatrixdecompBuffer) -> Int { s.size }

pub fn math_matrix_decomp_buffer_get(s : MathmatrixdecompBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_buffer_set(s : MathmatrixdecompBuffer, i : Int, v : Double) -> MathmatrixdecompBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_buffer_sum(s : MathmatrixdecompBuffer) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_buffer_mean(s : MathmatrixdecompBuffer) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_buffer_scale(s : MathmatrixdecompBuffer, f : Double) -> MathmatrixdecompBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_buffer_add(a : MathmatrixdecompBuffer, b : MathmatrixdecompBuffer) -> MathmatrixdecompBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_buffer_copy(s : MathmatrixdecompBuffer) -> MathmatrixdecompBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_buffer_fill(s : MathmatrixdecompBuffer, v : Double) -> MathmatrixdecompBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_buffer_min(s : MathmatrixdecompBuffer) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_buffer_max(s : MathmatrixdecompBuffer) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_buffer_to_string(s : MathmatrixdecompBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_cursor_make(size : Int) -> MathmatrixdecompCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_cursor_len(s : MathmatrixdecompCursor) -> Int { s.size }

pub fn math_matrix_decomp_cursor_get(s : MathmatrixdecompCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_cursor_set(s : MathmatrixdecompCursor, i : Int, v : Double) -> MathmatrixdecompCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cursor_sum(s : MathmatrixdecompCursor) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_cursor_mean(s : MathmatrixdecompCursor) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_cursor_scale(s : MathmatrixdecompCursor, f : Double) -> MathmatrixdecompCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cursor_add(a : MathmatrixdecompCursor, b : MathmatrixdecompCursor) -> MathmatrixdecompCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_cursor_copy(s : MathmatrixdecompCursor) -> MathmatrixdecompCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cursor_fill(s : MathmatrixdecompCursor, v : Double) -> MathmatrixdecompCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_cursor_min(s : MathmatrixdecompCursor) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_cursor_max(s : MathmatrixdecompCursor) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_cursor_to_string(s : MathmatrixdecompCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_view_make(size : Int) -> MathmatrixdecompView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_view_len(s : MathmatrixdecompView) -> Int { s.size }

pub fn math_matrix_decomp_view_get(s : MathmatrixdecompView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_view_set(s : MathmatrixdecompView, i : Int, v : Double) -> MathmatrixdecompView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_view_sum(s : MathmatrixdecompView) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_view_mean(s : MathmatrixdecompView) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_view_scale(s : MathmatrixdecompView, f : Double) -> MathmatrixdecompView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_view_add(a : MathmatrixdecompView, b : MathmatrixdecompView) -> MathmatrixdecompView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_view_copy(s : MathmatrixdecompView) -> MathmatrixdecompView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_view_fill(s : MathmatrixdecompView, v : Double) -> MathmatrixdecompView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_view_min(s : MathmatrixdecompView) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_view_max(s : MathmatrixdecompView) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_view_to_string(s : MathmatrixdecompView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_range_make(size : Int) -> MathmatrixdecompRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_range_len(s : MathmatrixdecompRange) -> Int { s.size }

pub fn math_matrix_decomp_range_get(s : MathmatrixdecompRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_range_set(s : MathmatrixdecompRange, i : Int, v : Double) -> MathmatrixdecompRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_range_sum(s : MathmatrixdecompRange) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_range_mean(s : MathmatrixdecompRange) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_range_scale(s : MathmatrixdecompRange, f : Double) -> MathmatrixdecompRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_range_add(a : MathmatrixdecompRange, b : MathmatrixdecompRange) -> MathmatrixdecompRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_range_copy(s : MathmatrixdecompRange) -> MathmatrixdecompRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_range_fill(s : MathmatrixdecompRange, v : Double) -> MathmatrixdecompRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_range_min(s : MathmatrixdecompRange) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_range_max(s : MathmatrixdecompRange) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_range_to_string(s : MathmatrixdecompRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathmatrixdecompSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_matrix_decomp_slice_make(size : Int) -> MathmatrixdecompSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_matrix_decomp_slice_len(s : MathmatrixdecompSlice) -> Int { s.size }

pub fn math_matrix_decomp_slice_get(s : MathmatrixdecompSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_matrix_decomp_slice_set(s : MathmatrixdecompSlice, i : Int, v : Double) -> MathmatrixdecompSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_slice_sum(s : MathmatrixdecompSlice) -> Double { @_common.sum(s.data) }

pub fn math_matrix_decomp_slice_mean(s : MathmatrixdecompSlice) -> Double { @_common.mean(s.data) }

pub fn math_matrix_decomp_slice_scale(s : MathmatrixdecompSlice, f : Double) -> MathmatrixdecompSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_slice_add(a : MathmatrixdecompSlice, b : MathmatrixdecompSlice) -> MathmatrixdecompSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_matrix_decomp_slice_copy(s : MathmatrixdecompSlice) -> MathmatrixdecompSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_slice_fill(s : MathmatrixdecompSlice, v : Double) -> MathmatrixdecompSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_matrix_decomp_slice_min(s : MathmatrixdecompSlice) -> Double { @_common.min(s.data) }

pub fn math_matrix_decomp_slice_max(s : MathmatrixdecompSlice) -> Double { @_common.max(s.data) }

pub fn math_matrix_decomp_slice_to_string(s : MathmatrixdecompSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

