///===
/// extcore/math_boundary_value

pub(all) struct MathboundaryvaluePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_boundary_value_make_point(x : Double, y : Double) -> MathboundaryvaluePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_boundary_value_make_point3(x : Double, y : Double, z : Double) -> MathboundaryvaluePoint {
  { x, y, z, label: 0 }
}

pub fn MathboundaryvaluePoint::x(self : MathboundaryvaluePoint) -> Double { self.x }

pub fn MathboundaryvaluePoint::y(self : MathboundaryvaluePoint) -> Double { self.y }

pub fn MathboundaryvaluePoint::z(self : MathboundaryvaluePoint) -> Double { self.z }

pub fn MathboundaryvaluePoint::label(self : MathboundaryvaluePoint) -> Int { self.label }

pub fn MathboundaryvaluePoint::dist(self : MathboundaryvaluePoint, other : MathboundaryvaluePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathboundaryvaluePoint::add(self : MathboundaryvaluePoint, other : MathboundaryvaluePoint) -> MathboundaryvaluePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathboundaryvaluePoint::sub(self : MathboundaryvaluePoint, other : MathboundaryvaluePoint) -> MathboundaryvaluePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathboundaryvaluePoint::scale(self : MathboundaryvaluePoint, s : Double) -> MathboundaryvaluePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathboundaryvaluePoint::dot(self : MathboundaryvaluePoint, other : MathboundaryvaluePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathboundaryvaluePoint::cross(self : MathboundaryvaluePoint, other : MathboundaryvaluePoint) -> MathboundaryvaluePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathboundaryvaluePoint::norm(self : MathboundaryvaluePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathboundaryvaluePoint::normalize(self : MathboundaryvaluePoint) -> MathboundaryvaluePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathboundaryvaluePoint::negate(self : MathboundaryvaluePoint) -> MathboundaryvaluePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathboundaryvaluePoint::mid(self : MathboundaryvaluePoint, other : MathboundaryvaluePoint) -> MathboundaryvaluePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathboundaryvaluePoint::lerp(self : MathboundaryvaluePoint, other : MathboundaryvaluePoint, t : Double) -> MathboundaryvaluePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathboundaryvaluePoint::to_string(self : MathboundaryvaluePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathboundaryvalueSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_boundary_value_make_series(vals : Array[Double], name : String) -> MathboundaryvalueSeries {
  { vals, name, meta: 0 }
}

pub fn MathboundaryvalueSeries::len(self : MathboundaryvalueSeries) -> Int { self.vals.length() }

pub fn MathboundaryvalueSeries::sum(self : MathboundaryvalueSeries) -> Double { @_common.sum(self.vals) }

pub fn MathboundaryvalueSeries::mean(self : MathboundaryvalueSeries) -> Double { @_common.mean(self.vals) }

pub fn MathboundaryvalueSeries::min(self : MathboundaryvalueSeries) -> Double { @_common.min(self.vals) }

pub fn MathboundaryvalueSeries::max(self : MathboundaryvalueSeries) -> Double { @_common.max(self.vals) }

pub fn MathboundaryvalueSeries::range(self : MathboundaryvalueSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathboundaryvalueSeries::variance(self : MathboundaryvalueSeries) -> Double { @_common.variance(self.vals) }

pub fn MathboundaryvalueSeries::std(self : MathboundaryvalueSeries) -> Double { @_common.std(self.vals) }

pub fn MathboundaryvalueSeries::median(self : MathboundaryvalueSeries) -> Double { @_common.median(self.vals) }

pub fn MathboundaryvalueSeries::scale(self : MathboundaryvalueSeries, f : Double) -> MathboundaryvalueSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathboundaryvalueSeries::add(self : MathboundaryvalueSeries, other : MathboundaryvalueSeries) -> MathboundaryvalueSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathboundaryvalueSeries::sub(self : MathboundaryvalueSeries, other : MathboundaryvalueSeries) -> MathboundaryvalueSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathboundaryvalueSeries::normalize(self : MathboundaryvalueSeries) -> MathboundaryvalueSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathboundaryvalueSeries::cumsum(self : MathboundaryvalueSeries) -> MathboundaryvalueSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathboundaryvalueSeries::to_string(self : MathboundaryvalueSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathboundaryvalueMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_boundary_value_make_matrix(rows : Int, cols : Int, val : Double) -> MathboundaryvalueMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_boundary_value_matrix_identity(n : Int) -> MathboundaryvalueMatrix {
  let m = math_boundary_value_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathboundaryvalueMatrix::get(self : MathboundaryvalueMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathboundaryvalueMatrix::transpose(self : MathboundaryvalueMatrix) -> MathboundaryvalueMatrix {
  let result = math_boundary_value_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathboundaryvalueMatrix::add(self : MathboundaryvalueMatrix, other : MathboundaryvalueMatrix) -> MathboundaryvalueMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_boundary_value_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathboundaryvalueMatrix::scale(self : MathboundaryvalueMatrix, s : Double) -> MathboundaryvalueMatrix {
  let result = math_boundary_value_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathboundaryvalueMatrix::multiply(self : MathboundaryvalueMatrix, other : MathboundaryvalueMatrix) -> MathboundaryvalueMatrix {
  if self.cols != other.rows { return math_boundary_value_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_boundary_value_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathboundaryvalueMatrix::trace(self : MathboundaryvalueMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathboundaryvalueMatrix::det(self : MathboundaryvalueMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathboundaryvalueMatrix::norm(self : MathboundaryvalueMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathboundaryvalueMatrix::to_string(self : MathboundaryvalueMatrix) -> String {
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

pub(all) struct MathboundaryvalueVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_boundary_value_make_vector(comps : Array[Double]) -> MathboundaryvalueVector {
  { comps, dim: comps.length() }
}

pub fn math_boundary_value_vector_zero(dim : Int) -> MathboundaryvalueVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathboundaryvalueVector::add(self : MathboundaryvalueVector, other : MathboundaryvalueVector) -> MathboundaryvalueVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathboundaryvalueVector::sub(self : MathboundaryvalueVector, other : MathboundaryvalueVector) -> MathboundaryvalueVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathboundaryvalueVector::scale(self : MathboundaryvalueVector, s : Double) -> MathboundaryvalueVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathboundaryvalueVector::dot(self : MathboundaryvalueVector, other : MathboundaryvalueVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathboundaryvalueVector::norm(self : MathboundaryvalueVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathboundaryvalueVector::normalize(self : MathboundaryvalueVector) -> MathboundaryvalueVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathboundaryvalueVector::dist(self : MathboundaryvalueVector, other : MathboundaryvalueVector) -> Double {
  self.sub(other).norm()
}

pub fn MathboundaryvalueVector::to_string(self : MathboundaryvalueVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_boundary_value_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_boundary_value_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_boundary_value_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_boundary_value_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_boundary_value_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_boundary_value_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_boundary_value_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_boundary_value_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_boundary_value_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_boundary_value_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_boundary_value_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_boundary_value_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_boundary_value_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_boundary_value_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_boundary_value_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_boundary_value_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_boundary_value_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_boundary_value_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_boundary_value_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_boundary_value_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_boundary_value_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_boundary_value_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_boundary_value_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_boundary_value_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_boundary_value_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_boundary_value_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_boundary_value_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_boundary_value_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_boundary_value_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathboundaryvalueFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_frame_make(size : Int) -> MathboundaryvalueFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_frame_len(s : MathboundaryvalueFrame) -> Int { s.size }

pub fn math_boundary_value_frame_get(s : MathboundaryvalueFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_frame_set(s : MathboundaryvalueFrame, i : Int, v : Double) -> MathboundaryvalueFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_boundary_value_frame_sum(s : MathboundaryvalueFrame) -> Double { @_common.sum(s.data) }

pub fn math_boundary_value_frame_mean(s : MathboundaryvalueFrame) -> Double { @_common.mean(s.data) }

pub fn math_boundary_value_frame_scale(s : MathboundaryvalueFrame, f : Double) -> MathboundaryvalueFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_frame_add(a : MathboundaryvalueFrame, b : MathboundaryvalueFrame) -> MathboundaryvalueFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_boundary_value_frame_copy(s : MathboundaryvalueFrame) -> MathboundaryvalueFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_frame_fill(s : MathboundaryvalueFrame, v : Double) -> MathboundaryvalueFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_frame_min(s : MathboundaryvalueFrame) -> Double { @_common.min(s.data) }

pub fn math_boundary_value_frame_max(s : MathboundaryvalueFrame) -> Double { @_common.max(s.data) }

pub fn math_boundary_value_frame_to_string(s : MathboundaryvalueFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_table_make(size : Int) -> MathboundaryvalueTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_table_len(s : MathboundaryvalueTable) -> Int { s.size }

pub fn math_boundary_value_table_get(s : MathboundaryvalueTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_table_set(s : MathboundaryvalueTable, i : Int, v : Double) -> MathboundaryvalueTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_boundary_value_table_sum(s : MathboundaryvalueTable) -> Double { @_common.sum(s.data) }

pub fn math_boundary_value_table_mean(s : MathboundaryvalueTable) -> Double { @_common.mean(s.data) }

pub fn math_boundary_value_table_scale(s : MathboundaryvalueTable, f : Double) -> MathboundaryvalueTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_table_add(a : MathboundaryvalueTable, b : MathboundaryvalueTable) -> MathboundaryvalueTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_boundary_value_table_copy(s : MathboundaryvalueTable) -> MathboundaryvalueTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_table_fill(s : MathboundaryvalueTable, v : Double) -> MathboundaryvalueTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_table_min(s : MathboundaryvalueTable) -> Double { @_common.min(s.data) }

pub fn math_boundary_value_table_max(s : MathboundaryvalueTable) -> Double { @_common.max(s.data) }

pub fn math_boundary_value_table_to_string(s : MathboundaryvalueTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_graphn_make(size : Int) -> MathboundaryvalueGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_graphn_len(s : MathboundaryvalueGraphN) -> Int { s.size }

pub fn math_boundary_value_graphn_get(s : MathboundaryvalueGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_graphn_set(s : MathboundaryvalueGraphN, i : Int, v : Double) -> MathboundaryvalueGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_boundary_value_graphn_sum(s : MathboundaryvalueGraphN) -> Double { @_common.sum(s.data) }

pub fn math_boundary_value_graphn_mean(s : MathboundaryvalueGraphN) -> Double { @_common.mean(s.data) }

pub fn math_boundary_value_graphn_scale(s : MathboundaryvalueGraphN, f : Double) -> MathboundaryvalueGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_graphn_add(a : MathboundaryvalueGraphN, b : MathboundaryvalueGraphN) -> MathboundaryvalueGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_boundary_value_graphn_copy(s : MathboundaryvalueGraphN) -> MathboundaryvalueGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_graphn_fill(s : MathboundaryvalueGraphN, v : Double) -> MathboundaryvalueGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_graphn_min(s : MathboundaryvalueGraphN) -> Double { @_common.min(s.data) }

pub fn math_boundary_value_graphn_max(s : MathboundaryvalueGraphN) -> Double { @_common.max(s.data) }

pub fn math_boundary_value_graphn_to_string(s : MathboundaryvalueGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_node_make(size : Int) -> MathboundaryvalueNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_node_len(s : MathboundaryvalueNode) -> Int { s.size }

pub fn math_boundary_value_node_get(s : MathboundaryvalueNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_node_set(s : MathboundaryvalueNode, i : Int, v : Double) -> MathboundaryvalueNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_boundary_value_node_sum(s : MathboundaryvalueNode) -> Double { @_common.sum(s.data) }

pub fn math_boundary_value_node_mean(s : MathboundaryvalueNode) -> Double { @_common.mean(s.data) }

pub fn math_boundary_value_node_scale(s : MathboundaryvalueNode, f : Double) -> MathboundaryvalueNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_node_add(a : MathboundaryvalueNode, b : MathboundaryvalueNode) -> MathboundaryvalueNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_boundary_value_node_copy(s : MathboundaryvalueNode) -> MathboundaryvalueNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_node_fill(s : MathboundaryvalueNode, v : Double) -> MathboundaryvalueNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_node_min(s : MathboundaryvalueNode) -> Double { @_common.min(s.data) }

pub fn math_boundary_value_node_max(s : MathboundaryvalueNode) -> Double { @_common.max(s.data) }

pub fn math_boundary_value_node_to_string(s : MathboundaryvalueNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_edge_make(size : Int) -> MathboundaryvalueEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_edge_len(s : MathboundaryvalueEdge) -> Int { s.size }

pub fn math_boundary_value_edge_get(s : MathboundaryvalueEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_edge_set(s : MathboundaryvalueEdge, i : Int, v : Double) -> MathboundaryvalueEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_boundary_value_edge_sum(s : MathboundaryvalueEdge) -> Double { @_common.sum(s.data) }

pub fn math_boundary_value_edge_mean(s : MathboundaryvalueEdge) -> Double { @_common.mean(s.data) }

pub fn math_boundary_value_edge_scale(s : MathboundaryvalueEdge, f : Double) -> MathboundaryvalueEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_edge_add(a : MathboundaryvalueEdge, b : MathboundaryvalueEdge) -> MathboundaryvalueEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_boundary_value_edge_copy(s : MathboundaryvalueEdge) -> MathboundaryvalueEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_edge_fill(s : MathboundaryvalueEdge, v : Double) -> MathboundaryvalueEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_edge_min(s : MathboundaryvalueEdge) -> Double { @_common.min(s.data) }

pub fn math_boundary_value_edge_max(s : MathboundaryvalueEdge) -> Double { @_common.max(s.data) }

pub fn math_boundary_value_edge_to_string(s : MathboundaryvalueEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvaluePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_path_make(size : Int) -> MathboundaryvaluePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_path_len(s : MathboundaryvaluePath) -> Int { s.size }

pub fn math_boundary_value_path_get(s : MathboundaryvaluePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_path_set(s : MathboundaryvaluePath, i : Int, v : Double) -> MathboundaryvaluePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_boundary_value_path_sum(s : MathboundaryvaluePath) -> Double { @_common.sum(s.data) }

pub fn math_boundary_value_path_mean(s : MathboundaryvaluePath) -> Double { @_common.mean(s.data) }

pub fn math_boundary_value_path_scale(s : MathboundaryvaluePath, f : Double) -> MathboundaryvaluePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_path_add(a : MathboundaryvaluePath, b : MathboundaryvaluePath) -> MathboundaryvaluePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_boundary_value_path_copy(s : MathboundaryvaluePath) -> MathboundaryvaluePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_path_fill(s : MathboundaryvaluePath, v : Double) -> MathboundaryvaluePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_path_min(s : MathboundaryvaluePath) -> Double { @_common.min(s.data) }

pub fn math_boundary_value_path_max(s : MathboundaryvaluePath) -> Double { @_common.max(s.data) }

pub fn math_boundary_value_path_to_string(s : MathboundaryvaluePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_cluster_make(size : Int) -> MathboundaryvalueCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_cluster_len(s : MathboundaryvalueCluster) -> Int { s.size }

pub fn math_boundary_value_cluster_get(s : MathboundaryvalueCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_cluster_set(s : MathboundaryvalueCluster, i : Int, v : Double) -> MathboundaryvalueCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_boundary_value_cluster_sum(s : MathboundaryvalueCluster) -> Double { @_common.sum(s.data) }

pub fn math_boundary_value_cluster_mean(s : MathboundaryvalueCluster) -> Double { @_common.mean(s.data) }

pub fn math_boundary_value_cluster_scale(s : MathboundaryvalueCluster, f : Double) -> MathboundaryvalueCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_cluster_add(a : MathboundaryvalueCluster, b : MathboundaryvalueCluster) -> MathboundaryvalueCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_boundary_value_cluster_copy(s : MathboundaryvalueCluster) -> MathboundaryvalueCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_cluster_fill(s : MathboundaryvalueCluster, v : Double) -> MathboundaryvalueCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_cluster_min(s : MathboundaryvalueCluster) -> Double { @_common.min(s.data) }

pub fn math_boundary_value_cluster_max(s : MathboundaryvalueCluster) -> Double { @_common.max(s.data) }

pub fn math_boundary_value_cluster_to_string(s : MathboundaryvalueCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_model_make(size : Int) -> MathboundaryvalueModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_model_len(s : MathboundaryvalueModel) -> Int { s.size }

pub fn math_boundary_value_model_get(s : MathboundaryvalueModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_model_set(s : MathboundaryvalueModel, i : Int, v : Double) -> MathboundaryvalueModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_boundary_value_model_sum(s : MathboundaryvalueModel) -> Double { @_common.sum(s.data) }

pub fn math_boundary_value_model_mean(s : MathboundaryvalueModel) -> Double { @_common.mean(s.data) }

pub fn math_boundary_value_model_scale(s : MathboundaryvalueModel, f : Double) -> MathboundaryvalueModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_model_add(a : MathboundaryvalueModel, b : MathboundaryvalueModel) -> MathboundaryvalueModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_boundary_value_model_copy(s : MathboundaryvalueModel) -> MathboundaryvalueModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_model_fill(s : MathboundaryvalueModel, v : Double) -> MathboundaryvalueModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_model_min(s : MathboundaryvalueModel) -> Double { @_common.min(s.data) }

pub fn math_boundary_value_model_max(s : MathboundaryvalueModel) -> Double { @_common.max(s.data) }

pub fn math_boundary_value_model_to_string(s : MathboundaryvalueModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_layer_make(size : Int) -> MathboundaryvalueLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_layer_len(s : MathboundaryvalueLayer) -> Int { s.size }

pub fn math_boundary_value_layer_get(s : MathboundaryvalueLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_layer_set(s : MathboundaryvalueLayer, i : Int, v : Double) -> MathboundaryvalueLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_boundary_value_layer_sum(s : MathboundaryvalueLayer) -> Double { @_common.sum(s.data) }

pub fn math_boundary_value_layer_mean(s : MathboundaryvalueLayer) -> Double { @_common.mean(s.data) }

pub fn math_boundary_value_layer_scale(s : MathboundaryvalueLayer, f : Double) -> MathboundaryvalueLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_layer_add(a : MathboundaryvalueLayer, b : MathboundaryvalueLayer) -> MathboundaryvalueLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_boundary_value_layer_copy(s : MathboundaryvalueLayer) -> MathboundaryvalueLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_layer_fill(s : MathboundaryvalueLayer, v : Double) -> MathboundaryvalueLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_layer_min(s : MathboundaryvalueLayer) -> Double { @_common.min(s.data) }

pub fn math_boundary_value_layer_max(s : MathboundaryvalueLayer) -> Double { @_common.max(s.data) }

pub fn math_boundary_value_layer_to_string(s : MathboundaryvalueLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_buffer_make(size : Int) -> MathboundaryvalueBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_buffer_len(s : MathboundaryvalueBuffer) -> Int { s.size }

pub fn math_boundary_value_buffer_get(s : MathboundaryvalueBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_buffer_set(s : MathboundaryvalueBuffer, i : Int, v : Double) -> MathboundaryvalueBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_boundary_value_buffer_sum(s : MathboundaryvalueBuffer) -> Double { @_common.sum(s.data) }

pub fn math_boundary_value_buffer_mean(s : MathboundaryvalueBuffer) -> Double { @_common.mean(s.data) }

pub fn math_boundary_value_buffer_scale(s : MathboundaryvalueBuffer, f : Double) -> MathboundaryvalueBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_buffer_add(a : MathboundaryvalueBuffer, b : MathboundaryvalueBuffer) -> MathboundaryvalueBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_boundary_value_buffer_copy(s : MathboundaryvalueBuffer) -> MathboundaryvalueBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_buffer_fill(s : MathboundaryvalueBuffer, v : Double) -> MathboundaryvalueBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_buffer_min(s : MathboundaryvalueBuffer) -> Double { @_common.min(s.data) }

pub fn math_boundary_value_buffer_max(s : MathboundaryvalueBuffer) -> Double { @_common.max(s.data) }

pub fn math_boundary_value_buffer_to_string(s : MathboundaryvalueBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_cursor_make(size : Int) -> MathboundaryvalueCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_cursor_len(s : MathboundaryvalueCursor) -> Int { s.size }

pub fn math_boundary_value_cursor_get(s : MathboundaryvalueCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_cursor_set(s : MathboundaryvalueCursor, i : Int, v : Double) -> MathboundaryvalueCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_boundary_value_cursor_sum(s : MathboundaryvalueCursor) -> Double { @_common.sum(s.data) }

pub fn math_boundary_value_cursor_mean(s : MathboundaryvalueCursor) -> Double { @_common.mean(s.data) }

pub fn math_boundary_value_cursor_scale(s : MathboundaryvalueCursor, f : Double) -> MathboundaryvalueCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_cursor_add(a : MathboundaryvalueCursor, b : MathboundaryvalueCursor) -> MathboundaryvalueCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_boundary_value_cursor_copy(s : MathboundaryvalueCursor) -> MathboundaryvalueCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_cursor_fill(s : MathboundaryvalueCursor, v : Double) -> MathboundaryvalueCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_cursor_min(s : MathboundaryvalueCursor) -> Double { @_common.min(s.data) }

pub fn math_boundary_value_cursor_max(s : MathboundaryvalueCursor) -> Double { @_common.max(s.data) }

pub fn math_boundary_value_cursor_to_string(s : MathboundaryvalueCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_view_make(size : Int) -> MathboundaryvalueView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_view_len(s : MathboundaryvalueView) -> Int { s.size }

pub fn math_boundary_value_view_get(s : MathboundaryvalueView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_view_set(s : MathboundaryvalueView, i : Int, v : Double) -> MathboundaryvalueView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_boundary_value_view_sum(s : MathboundaryvalueView) -> Double { @_common.sum(s.data) }

pub fn math_boundary_value_view_mean(s : MathboundaryvalueView) -> Double { @_common.mean(s.data) }

pub fn math_boundary_value_view_scale(s : MathboundaryvalueView, f : Double) -> MathboundaryvalueView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_view_add(a : MathboundaryvalueView, b : MathboundaryvalueView) -> MathboundaryvalueView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_boundary_value_view_copy(s : MathboundaryvalueView) -> MathboundaryvalueView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_view_fill(s : MathboundaryvalueView, v : Double) -> MathboundaryvalueView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_view_min(s : MathboundaryvalueView) -> Double { @_common.min(s.data) }

pub fn math_boundary_value_view_max(s : MathboundaryvalueView) -> Double { @_common.max(s.data) }

pub fn math_boundary_value_view_to_string(s : MathboundaryvalueView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_range_make(size : Int) -> MathboundaryvalueRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_range_len(s : MathboundaryvalueRange) -> Int { s.size }

pub fn math_boundary_value_range_get(s : MathboundaryvalueRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_range_set(s : MathboundaryvalueRange, i : Int, v : Double) -> MathboundaryvalueRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_boundary_value_range_sum(s : MathboundaryvalueRange) -> Double { @_common.sum(s.data) }

pub fn math_boundary_value_range_mean(s : MathboundaryvalueRange) -> Double { @_common.mean(s.data) }

pub fn math_boundary_value_range_scale(s : MathboundaryvalueRange, f : Double) -> MathboundaryvalueRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_range_add(a : MathboundaryvalueRange, b : MathboundaryvalueRange) -> MathboundaryvalueRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_boundary_value_range_copy(s : MathboundaryvalueRange) -> MathboundaryvalueRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_range_fill(s : MathboundaryvalueRange, v : Double) -> MathboundaryvalueRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_range_min(s : MathboundaryvalueRange) -> Double { @_common.min(s.data) }

pub fn math_boundary_value_range_max(s : MathboundaryvalueRange) -> Double { @_common.max(s.data) }

pub fn math_boundary_value_range_to_string(s : MathboundaryvalueRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathboundaryvalueSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_boundary_value_slice_make(size : Int) -> MathboundaryvalueSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_boundary_value_slice_len(s : MathboundaryvalueSlice) -> Int { s.size }

pub fn math_boundary_value_slice_get(s : MathboundaryvalueSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_boundary_value_slice_set(s : MathboundaryvalueSlice, i : Int, v : Double) -> MathboundaryvalueSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_boundary_value_slice_sum(s : MathboundaryvalueSlice) -> Double { @_common.sum(s.data) }

pub fn math_boundary_value_slice_mean(s : MathboundaryvalueSlice) -> Double { @_common.mean(s.data) }

pub fn math_boundary_value_slice_scale(s : MathboundaryvalueSlice, f : Double) -> MathboundaryvalueSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_slice_add(a : MathboundaryvalueSlice, b : MathboundaryvalueSlice) -> MathboundaryvalueSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_boundary_value_slice_copy(s : MathboundaryvalueSlice) -> MathboundaryvalueSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_slice_fill(s : MathboundaryvalueSlice, v : Double) -> MathboundaryvalueSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_boundary_value_slice_min(s : MathboundaryvalueSlice) -> Double { @_common.min(s.data) }

pub fn math_boundary_value_slice_max(s : MathboundaryvalueSlice) -> Double { @_common.max(s.data) }

pub fn math_boundary_value_slice_to_string(s : MathboundaryvalueSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

