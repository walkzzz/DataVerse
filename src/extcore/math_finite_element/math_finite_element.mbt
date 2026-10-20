///===
/// extcore/math_finite_element

pub(all) struct MathfiniteelementPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_finite_element_make_point(x : Double, y : Double) -> MathfiniteelementPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_finite_element_make_point3(x : Double, y : Double, z : Double) -> MathfiniteelementPoint {
  { x, y, z, label: 0 }
}

pub fn MathfiniteelementPoint::x(self : MathfiniteelementPoint) -> Double { self.x }

pub fn MathfiniteelementPoint::y(self : MathfiniteelementPoint) -> Double { self.y }

pub fn MathfiniteelementPoint::z(self : MathfiniteelementPoint) -> Double { self.z }

pub fn MathfiniteelementPoint::label(self : MathfiniteelementPoint) -> Int { self.label }

pub fn MathfiniteelementPoint::dist(self : MathfiniteelementPoint, other : MathfiniteelementPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathfiniteelementPoint::add(self : MathfiniteelementPoint, other : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathfiniteelementPoint::sub(self : MathfiniteelementPoint, other : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathfiniteelementPoint::scale(self : MathfiniteelementPoint, s : Double) -> MathfiniteelementPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathfiniteelementPoint::dot(self : MathfiniteelementPoint, other : MathfiniteelementPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathfiniteelementPoint::cross(self : MathfiniteelementPoint, other : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathfiniteelementPoint::norm(self : MathfiniteelementPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathfiniteelementPoint::normalize(self : MathfiniteelementPoint) -> MathfiniteelementPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathfiniteelementPoint::negate(self : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathfiniteelementPoint::mid(self : MathfiniteelementPoint, other : MathfiniteelementPoint) -> MathfiniteelementPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathfiniteelementPoint::lerp(self : MathfiniteelementPoint, other : MathfiniteelementPoint, t : Double) -> MathfiniteelementPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathfiniteelementPoint::to_string(self : MathfiniteelementPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathfiniteelementSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_finite_element_make_series(vals : Array[Double], name : String) -> MathfiniteelementSeries {
  { vals, name, meta: 0 }
}

pub fn MathfiniteelementSeries::len(self : MathfiniteelementSeries) -> Int { self.vals.length() }

pub fn MathfiniteelementSeries::sum(self : MathfiniteelementSeries) -> Double { @_common.sum(self.vals) }

pub fn MathfiniteelementSeries::mean(self : MathfiniteelementSeries) -> Double { @_common.mean(self.vals) }

pub fn MathfiniteelementSeries::min(self : MathfiniteelementSeries) -> Double { @_common.min(self.vals) }

pub fn MathfiniteelementSeries::max(self : MathfiniteelementSeries) -> Double { @_common.max(self.vals) }

pub fn MathfiniteelementSeries::range(self : MathfiniteelementSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathfiniteelementSeries::variance(self : MathfiniteelementSeries) -> Double { @_common.variance(self.vals) }

pub fn MathfiniteelementSeries::std(self : MathfiniteelementSeries) -> Double { @_common.std(self.vals) }

pub fn MathfiniteelementSeries::median(self : MathfiniteelementSeries) -> Double { @_common.median(self.vals) }

pub fn MathfiniteelementSeries::scale(self : MathfiniteelementSeries, f : Double) -> MathfiniteelementSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathfiniteelementSeries::add(self : MathfiniteelementSeries, other : MathfiniteelementSeries) -> MathfiniteelementSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathfiniteelementSeries::sub(self : MathfiniteelementSeries, other : MathfiniteelementSeries) -> MathfiniteelementSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathfiniteelementSeries::normalize(self : MathfiniteelementSeries) -> MathfiniteelementSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathfiniteelementSeries::cumsum(self : MathfiniteelementSeries) -> MathfiniteelementSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathfiniteelementSeries::to_string(self : MathfiniteelementSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathfiniteelementMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_finite_element_make_matrix(rows : Int, cols : Int, val : Double) -> MathfiniteelementMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_finite_element_matrix_identity(n : Int) -> MathfiniteelementMatrix {
  let m = math_finite_element_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathfiniteelementMatrix::get(self : MathfiniteelementMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathfiniteelementMatrix::transpose(self : MathfiniteelementMatrix) -> MathfiniteelementMatrix {
  let result = math_finite_element_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathfiniteelementMatrix::add(self : MathfiniteelementMatrix, other : MathfiniteelementMatrix) -> MathfiniteelementMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_finite_element_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathfiniteelementMatrix::scale(self : MathfiniteelementMatrix, s : Double) -> MathfiniteelementMatrix {
  let result = math_finite_element_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathfiniteelementMatrix::multiply(self : MathfiniteelementMatrix, other : MathfiniteelementMatrix) -> MathfiniteelementMatrix {
  if self.cols != other.rows { return math_finite_element_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_finite_element_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathfiniteelementMatrix::trace(self : MathfiniteelementMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathfiniteelementMatrix::det(self : MathfiniteelementMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathfiniteelementMatrix::norm(self : MathfiniteelementMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathfiniteelementMatrix::to_string(self : MathfiniteelementMatrix) -> String {
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

pub(all) struct MathfiniteelementVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_finite_element_make_vector(comps : Array[Double]) -> MathfiniteelementVector {
  { comps, dim: comps.length() }
}

pub fn math_finite_element_vector_zero(dim : Int) -> MathfiniteelementVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathfiniteelementVector::add(self : MathfiniteelementVector, other : MathfiniteelementVector) -> MathfiniteelementVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathfiniteelementVector::sub(self : MathfiniteelementVector, other : MathfiniteelementVector) -> MathfiniteelementVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathfiniteelementVector::scale(self : MathfiniteelementVector, s : Double) -> MathfiniteelementVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathfiniteelementVector::dot(self : MathfiniteelementVector, other : MathfiniteelementVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathfiniteelementVector::norm(self : MathfiniteelementVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathfiniteelementVector::normalize(self : MathfiniteelementVector) -> MathfiniteelementVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathfiniteelementVector::dist(self : MathfiniteelementVector, other : MathfiniteelementVector) -> Double {
  self.sub(other).norm()
}

pub fn MathfiniteelementVector::to_string(self : MathfiniteelementVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_finite_element_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_finite_element_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_finite_element_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_finite_element_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_finite_element_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_finite_element_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_finite_element_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_finite_element_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_finite_element_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_finite_element_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_finite_element_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_finite_element_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_finite_element_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_finite_element_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_finite_element_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_finite_element_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_finite_element_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_finite_element_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_finite_element_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_finite_element_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_finite_element_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_finite_element_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_finite_element_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_finite_element_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_finite_element_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_finite_element_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_finite_element_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_finite_element_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_finite_element_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathfiniteelementFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_frame_make(size : Int) -> MathfiniteelementFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_frame_len(s : MathfiniteelementFrame) -> Int { s.size }

pub fn math_finite_element_frame_get(s : MathfiniteelementFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_frame_set(s : MathfiniteelementFrame, i : Int, v : Double) -> MathfiniteelementFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_element_frame_sum(s : MathfiniteelementFrame) -> Double { @_common.sum(s.data) }

pub fn math_finite_element_frame_mean(s : MathfiniteelementFrame) -> Double { @_common.mean(s.data) }

pub fn math_finite_element_frame_scale(s : MathfiniteelementFrame, f : Double) -> MathfiniteelementFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_element_frame_add(a : MathfiniteelementFrame, b : MathfiniteelementFrame) -> MathfiniteelementFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_element_frame_copy(s : MathfiniteelementFrame) -> MathfiniteelementFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_element_frame_fill(s : MathfiniteelementFrame, v : Double) -> MathfiniteelementFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_element_frame_min(s : MathfiniteelementFrame) -> Double { @_common.min(s.data) }

pub fn math_finite_element_frame_max(s : MathfiniteelementFrame) -> Double { @_common.max(s.data) }

pub fn math_finite_element_frame_to_string(s : MathfiniteelementFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_table_make(size : Int) -> MathfiniteelementTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_table_len(s : MathfiniteelementTable) -> Int { s.size }

pub fn math_finite_element_table_get(s : MathfiniteelementTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_table_set(s : MathfiniteelementTable, i : Int, v : Double) -> MathfiniteelementTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_element_table_sum(s : MathfiniteelementTable) -> Double { @_common.sum(s.data) }

pub fn math_finite_element_table_mean(s : MathfiniteelementTable) -> Double { @_common.mean(s.data) }

pub fn math_finite_element_table_scale(s : MathfiniteelementTable, f : Double) -> MathfiniteelementTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_element_table_add(a : MathfiniteelementTable, b : MathfiniteelementTable) -> MathfiniteelementTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_element_table_copy(s : MathfiniteelementTable) -> MathfiniteelementTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_element_table_fill(s : MathfiniteelementTable, v : Double) -> MathfiniteelementTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_element_table_min(s : MathfiniteelementTable) -> Double { @_common.min(s.data) }

pub fn math_finite_element_table_max(s : MathfiniteelementTable) -> Double { @_common.max(s.data) }

pub fn math_finite_element_table_to_string(s : MathfiniteelementTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_graphn_make(size : Int) -> MathfiniteelementGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_graphn_len(s : MathfiniteelementGraphN) -> Int { s.size }

pub fn math_finite_element_graphn_get(s : MathfiniteelementGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_graphn_set(s : MathfiniteelementGraphN, i : Int, v : Double) -> MathfiniteelementGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_element_graphn_sum(s : MathfiniteelementGraphN) -> Double { @_common.sum(s.data) }

pub fn math_finite_element_graphn_mean(s : MathfiniteelementGraphN) -> Double { @_common.mean(s.data) }

pub fn math_finite_element_graphn_scale(s : MathfiniteelementGraphN, f : Double) -> MathfiniteelementGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_element_graphn_add(a : MathfiniteelementGraphN, b : MathfiniteelementGraphN) -> MathfiniteelementGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_element_graphn_copy(s : MathfiniteelementGraphN) -> MathfiniteelementGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_element_graphn_fill(s : MathfiniteelementGraphN, v : Double) -> MathfiniteelementGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_element_graphn_min(s : MathfiniteelementGraphN) -> Double { @_common.min(s.data) }

pub fn math_finite_element_graphn_max(s : MathfiniteelementGraphN) -> Double { @_common.max(s.data) }

pub fn math_finite_element_graphn_to_string(s : MathfiniteelementGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_node_make(size : Int) -> MathfiniteelementNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_node_len(s : MathfiniteelementNode) -> Int { s.size }

pub fn math_finite_element_node_get(s : MathfiniteelementNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_node_set(s : MathfiniteelementNode, i : Int, v : Double) -> MathfiniteelementNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_element_node_sum(s : MathfiniteelementNode) -> Double { @_common.sum(s.data) }

pub fn math_finite_element_node_mean(s : MathfiniteelementNode) -> Double { @_common.mean(s.data) }

pub fn math_finite_element_node_scale(s : MathfiniteelementNode, f : Double) -> MathfiniteelementNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_element_node_add(a : MathfiniteelementNode, b : MathfiniteelementNode) -> MathfiniteelementNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_element_node_copy(s : MathfiniteelementNode) -> MathfiniteelementNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_element_node_fill(s : MathfiniteelementNode, v : Double) -> MathfiniteelementNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_element_node_min(s : MathfiniteelementNode) -> Double { @_common.min(s.data) }

pub fn math_finite_element_node_max(s : MathfiniteelementNode) -> Double { @_common.max(s.data) }

pub fn math_finite_element_node_to_string(s : MathfiniteelementNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_edge_make(size : Int) -> MathfiniteelementEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_edge_len(s : MathfiniteelementEdge) -> Int { s.size }

pub fn math_finite_element_edge_get(s : MathfiniteelementEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_edge_set(s : MathfiniteelementEdge, i : Int, v : Double) -> MathfiniteelementEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_element_edge_sum(s : MathfiniteelementEdge) -> Double { @_common.sum(s.data) }

pub fn math_finite_element_edge_mean(s : MathfiniteelementEdge) -> Double { @_common.mean(s.data) }

pub fn math_finite_element_edge_scale(s : MathfiniteelementEdge, f : Double) -> MathfiniteelementEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_element_edge_add(a : MathfiniteelementEdge, b : MathfiniteelementEdge) -> MathfiniteelementEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_element_edge_copy(s : MathfiniteelementEdge) -> MathfiniteelementEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_element_edge_fill(s : MathfiniteelementEdge, v : Double) -> MathfiniteelementEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_element_edge_min(s : MathfiniteelementEdge) -> Double { @_common.min(s.data) }

pub fn math_finite_element_edge_max(s : MathfiniteelementEdge) -> Double { @_common.max(s.data) }

pub fn math_finite_element_edge_to_string(s : MathfiniteelementEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_path_make(size : Int) -> MathfiniteelementPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_path_len(s : MathfiniteelementPath) -> Int { s.size }

pub fn math_finite_element_path_get(s : MathfiniteelementPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_path_set(s : MathfiniteelementPath, i : Int, v : Double) -> MathfiniteelementPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_element_path_sum(s : MathfiniteelementPath) -> Double { @_common.sum(s.data) }

pub fn math_finite_element_path_mean(s : MathfiniteelementPath) -> Double { @_common.mean(s.data) }

pub fn math_finite_element_path_scale(s : MathfiniteelementPath, f : Double) -> MathfiniteelementPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_element_path_add(a : MathfiniteelementPath, b : MathfiniteelementPath) -> MathfiniteelementPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_element_path_copy(s : MathfiniteelementPath) -> MathfiniteelementPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_element_path_fill(s : MathfiniteelementPath, v : Double) -> MathfiniteelementPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_element_path_min(s : MathfiniteelementPath) -> Double { @_common.min(s.data) }

pub fn math_finite_element_path_max(s : MathfiniteelementPath) -> Double { @_common.max(s.data) }

pub fn math_finite_element_path_to_string(s : MathfiniteelementPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_cluster_make(size : Int) -> MathfiniteelementCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_cluster_len(s : MathfiniteelementCluster) -> Int { s.size }

pub fn math_finite_element_cluster_get(s : MathfiniteelementCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_cluster_set(s : MathfiniteelementCluster, i : Int, v : Double) -> MathfiniteelementCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_element_cluster_sum(s : MathfiniteelementCluster) -> Double { @_common.sum(s.data) }

pub fn math_finite_element_cluster_mean(s : MathfiniteelementCluster) -> Double { @_common.mean(s.data) }

pub fn math_finite_element_cluster_scale(s : MathfiniteelementCluster, f : Double) -> MathfiniteelementCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_element_cluster_add(a : MathfiniteelementCluster, b : MathfiniteelementCluster) -> MathfiniteelementCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_element_cluster_copy(s : MathfiniteelementCluster) -> MathfiniteelementCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_element_cluster_fill(s : MathfiniteelementCluster, v : Double) -> MathfiniteelementCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_element_cluster_min(s : MathfiniteelementCluster) -> Double { @_common.min(s.data) }

pub fn math_finite_element_cluster_max(s : MathfiniteelementCluster) -> Double { @_common.max(s.data) }

pub fn math_finite_element_cluster_to_string(s : MathfiniteelementCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_model_make(size : Int) -> MathfiniteelementModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_model_len(s : MathfiniteelementModel) -> Int { s.size }

pub fn math_finite_element_model_get(s : MathfiniteelementModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_model_set(s : MathfiniteelementModel, i : Int, v : Double) -> MathfiniteelementModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_element_model_sum(s : MathfiniteelementModel) -> Double { @_common.sum(s.data) }

pub fn math_finite_element_model_mean(s : MathfiniteelementModel) -> Double { @_common.mean(s.data) }

pub fn math_finite_element_model_scale(s : MathfiniteelementModel, f : Double) -> MathfiniteelementModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_element_model_add(a : MathfiniteelementModel, b : MathfiniteelementModel) -> MathfiniteelementModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_element_model_copy(s : MathfiniteelementModel) -> MathfiniteelementModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_element_model_fill(s : MathfiniteelementModel, v : Double) -> MathfiniteelementModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_element_model_min(s : MathfiniteelementModel) -> Double { @_common.min(s.data) }

pub fn math_finite_element_model_max(s : MathfiniteelementModel) -> Double { @_common.max(s.data) }

pub fn math_finite_element_model_to_string(s : MathfiniteelementModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_layer_make(size : Int) -> MathfiniteelementLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_layer_len(s : MathfiniteelementLayer) -> Int { s.size }

pub fn math_finite_element_layer_get(s : MathfiniteelementLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_layer_set(s : MathfiniteelementLayer, i : Int, v : Double) -> MathfiniteelementLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_element_layer_sum(s : MathfiniteelementLayer) -> Double { @_common.sum(s.data) }

pub fn math_finite_element_layer_mean(s : MathfiniteelementLayer) -> Double { @_common.mean(s.data) }

pub fn math_finite_element_layer_scale(s : MathfiniteelementLayer, f : Double) -> MathfiniteelementLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_element_layer_add(a : MathfiniteelementLayer, b : MathfiniteelementLayer) -> MathfiniteelementLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_element_layer_copy(s : MathfiniteelementLayer) -> MathfiniteelementLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_element_layer_fill(s : MathfiniteelementLayer, v : Double) -> MathfiniteelementLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_element_layer_min(s : MathfiniteelementLayer) -> Double { @_common.min(s.data) }

pub fn math_finite_element_layer_max(s : MathfiniteelementLayer) -> Double { @_common.max(s.data) }

pub fn math_finite_element_layer_to_string(s : MathfiniteelementLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_buffer_make(size : Int) -> MathfiniteelementBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_buffer_len(s : MathfiniteelementBuffer) -> Int { s.size }

pub fn math_finite_element_buffer_get(s : MathfiniteelementBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_buffer_set(s : MathfiniteelementBuffer, i : Int, v : Double) -> MathfiniteelementBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_element_buffer_sum(s : MathfiniteelementBuffer) -> Double { @_common.sum(s.data) }

pub fn math_finite_element_buffer_mean(s : MathfiniteelementBuffer) -> Double { @_common.mean(s.data) }

pub fn math_finite_element_buffer_scale(s : MathfiniteelementBuffer, f : Double) -> MathfiniteelementBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_element_buffer_add(a : MathfiniteelementBuffer, b : MathfiniteelementBuffer) -> MathfiniteelementBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_element_buffer_copy(s : MathfiniteelementBuffer) -> MathfiniteelementBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_element_buffer_fill(s : MathfiniteelementBuffer, v : Double) -> MathfiniteelementBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_element_buffer_min(s : MathfiniteelementBuffer) -> Double { @_common.min(s.data) }

pub fn math_finite_element_buffer_max(s : MathfiniteelementBuffer) -> Double { @_common.max(s.data) }

pub fn math_finite_element_buffer_to_string(s : MathfiniteelementBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_cursor_make(size : Int) -> MathfiniteelementCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_cursor_len(s : MathfiniteelementCursor) -> Int { s.size }

pub fn math_finite_element_cursor_get(s : MathfiniteelementCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_cursor_set(s : MathfiniteelementCursor, i : Int, v : Double) -> MathfiniteelementCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_element_cursor_sum(s : MathfiniteelementCursor) -> Double { @_common.sum(s.data) }

pub fn math_finite_element_cursor_mean(s : MathfiniteelementCursor) -> Double { @_common.mean(s.data) }

pub fn math_finite_element_cursor_scale(s : MathfiniteelementCursor, f : Double) -> MathfiniteelementCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_element_cursor_add(a : MathfiniteelementCursor, b : MathfiniteelementCursor) -> MathfiniteelementCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_element_cursor_copy(s : MathfiniteelementCursor) -> MathfiniteelementCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_element_cursor_fill(s : MathfiniteelementCursor, v : Double) -> MathfiniteelementCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_element_cursor_min(s : MathfiniteelementCursor) -> Double { @_common.min(s.data) }

pub fn math_finite_element_cursor_max(s : MathfiniteelementCursor) -> Double { @_common.max(s.data) }

pub fn math_finite_element_cursor_to_string(s : MathfiniteelementCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_view_make(size : Int) -> MathfiniteelementView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_view_len(s : MathfiniteelementView) -> Int { s.size }

pub fn math_finite_element_view_get(s : MathfiniteelementView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_view_set(s : MathfiniteelementView, i : Int, v : Double) -> MathfiniteelementView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_element_view_sum(s : MathfiniteelementView) -> Double { @_common.sum(s.data) }

pub fn math_finite_element_view_mean(s : MathfiniteelementView) -> Double { @_common.mean(s.data) }

pub fn math_finite_element_view_scale(s : MathfiniteelementView, f : Double) -> MathfiniteelementView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_element_view_add(a : MathfiniteelementView, b : MathfiniteelementView) -> MathfiniteelementView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_element_view_copy(s : MathfiniteelementView) -> MathfiniteelementView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_element_view_fill(s : MathfiniteelementView, v : Double) -> MathfiniteelementView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_element_view_min(s : MathfiniteelementView) -> Double { @_common.min(s.data) }

pub fn math_finite_element_view_max(s : MathfiniteelementView) -> Double { @_common.max(s.data) }

pub fn math_finite_element_view_to_string(s : MathfiniteelementView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_range_make(size : Int) -> MathfiniteelementRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_range_len(s : MathfiniteelementRange) -> Int { s.size }

pub fn math_finite_element_range_get(s : MathfiniteelementRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_range_set(s : MathfiniteelementRange, i : Int, v : Double) -> MathfiniteelementRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_element_range_sum(s : MathfiniteelementRange) -> Double { @_common.sum(s.data) }

pub fn math_finite_element_range_mean(s : MathfiniteelementRange) -> Double { @_common.mean(s.data) }

pub fn math_finite_element_range_scale(s : MathfiniteelementRange, f : Double) -> MathfiniteelementRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_element_range_add(a : MathfiniteelementRange, b : MathfiniteelementRange) -> MathfiniteelementRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_element_range_copy(s : MathfiniteelementRange) -> MathfiniteelementRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_element_range_fill(s : MathfiniteelementRange, v : Double) -> MathfiniteelementRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_element_range_min(s : MathfiniteelementRange) -> Double { @_common.min(s.data) }

pub fn math_finite_element_range_max(s : MathfiniteelementRange) -> Double { @_common.max(s.data) }

pub fn math_finite_element_range_to_string(s : MathfiniteelementRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathfiniteelementSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_finite_element_slice_make(size : Int) -> MathfiniteelementSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_finite_element_slice_len(s : MathfiniteelementSlice) -> Int { s.size }

pub fn math_finite_element_slice_get(s : MathfiniteelementSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_finite_element_slice_set(s : MathfiniteelementSlice, i : Int, v : Double) -> MathfiniteelementSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_finite_element_slice_sum(s : MathfiniteelementSlice) -> Double { @_common.sum(s.data) }

pub fn math_finite_element_slice_mean(s : MathfiniteelementSlice) -> Double { @_common.mean(s.data) }

pub fn math_finite_element_slice_scale(s : MathfiniteelementSlice, f : Double) -> MathfiniteelementSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_finite_element_slice_add(a : MathfiniteelementSlice, b : MathfiniteelementSlice) -> MathfiniteelementSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_finite_element_slice_copy(s : MathfiniteelementSlice) -> MathfiniteelementSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_finite_element_slice_fill(s : MathfiniteelementSlice, v : Double) -> MathfiniteelementSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_finite_element_slice_min(s : MathfiniteelementSlice) -> Double { @_common.min(s.data) }

pub fn math_finite_element_slice_max(s : MathfiniteelementSlice) -> Double { @_common.max(s.data) }

pub fn math_finite_element_slice_to_string(s : MathfiniteelementSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

