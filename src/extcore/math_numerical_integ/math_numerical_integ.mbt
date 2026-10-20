///===
/// extcore/math_numerical_integ

pub(all) struct MathnumericalintegPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_numerical_integ_make_point(x : Double, y : Double) -> MathnumericalintegPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_numerical_integ_make_point3(x : Double, y : Double, z : Double) -> MathnumericalintegPoint {
  { x, y, z, label: 0 }
}

pub fn MathnumericalintegPoint::x(self : MathnumericalintegPoint) -> Double { self.x }

pub fn MathnumericalintegPoint::y(self : MathnumericalintegPoint) -> Double { self.y }

pub fn MathnumericalintegPoint::z(self : MathnumericalintegPoint) -> Double { self.z }

pub fn MathnumericalintegPoint::label(self : MathnumericalintegPoint) -> Int { self.label }

pub fn MathnumericalintegPoint::dist(self : MathnumericalintegPoint, other : MathnumericalintegPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathnumericalintegPoint::add(self : MathnumericalintegPoint, other : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathnumericalintegPoint::sub(self : MathnumericalintegPoint, other : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathnumericalintegPoint::scale(self : MathnumericalintegPoint, s : Double) -> MathnumericalintegPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathnumericalintegPoint::dot(self : MathnumericalintegPoint, other : MathnumericalintegPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathnumericalintegPoint::cross(self : MathnumericalintegPoint, other : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathnumericalintegPoint::norm(self : MathnumericalintegPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathnumericalintegPoint::normalize(self : MathnumericalintegPoint) -> MathnumericalintegPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathnumericalintegPoint::negate(self : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathnumericalintegPoint::mid(self : MathnumericalintegPoint, other : MathnumericalintegPoint) -> MathnumericalintegPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathnumericalintegPoint::lerp(self : MathnumericalintegPoint, other : MathnumericalintegPoint, t : Double) -> MathnumericalintegPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathnumericalintegPoint::to_string(self : MathnumericalintegPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathnumericalintegSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_numerical_integ_make_series(vals : Array[Double], name : String) -> MathnumericalintegSeries {
  { vals, name, meta: 0 }
}

pub fn MathnumericalintegSeries::len(self : MathnumericalintegSeries) -> Int { self.vals.length() }

pub fn MathnumericalintegSeries::sum(self : MathnumericalintegSeries) -> Double { @_common.sum(self.vals) }

pub fn MathnumericalintegSeries::mean(self : MathnumericalintegSeries) -> Double { @_common.mean(self.vals) }

pub fn MathnumericalintegSeries::min(self : MathnumericalintegSeries) -> Double { @_common.min(self.vals) }

pub fn MathnumericalintegSeries::max(self : MathnumericalintegSeries) -> Double { @_common.max(self.vals) }

pub fn MathnumericalintegSeries::range(self : MathnumericalintegSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathnumericalintegSeries::variance(self : MathnumericalintegSeries) -> Double { @_common.variance(self.vals) }

pub fn MathnumericalintegSeries::std(self : MathnumericalintegSeries) -> Double { @_common.std(self.vals) }

pub fn MathnumericalintegSeries::median(self : MathnumericalintegSeries) -> Double { @_common.median(self.vals) }

pub fn MathnumericalintegSeries::scale(self : MathnumericalintegSeries, f : Double) -> MathnumericalintegSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathnumericalintegSeries::add(self : MathnumericalintegSeries, other : MathnumericalintegSeries) -> MathnumericalintegSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathnumericalintegSeries::sub(self : MathnumericalintegSeries, other : MathnumericalintegSeries) -> MathnumericalintegSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathnumericalintegSeries::normalize(self : MathnumericalintegSeries) -> MathnumericalintegSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathnumericalintegSeries::cumsum(self : MathnumericalintegSeries) -> MathnumericalintegSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathnumericalintegSeries::to_string(self : MathnumericalintegSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathnumericalintegMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_numerical_integ_make_matrix(rows : Int, cols : Int, val : Double) -> MathnumericalintegMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_numerical_integ_matrix_identity(n : Int) -> MathnumericalintegMatrix {
  let m = math_numerical_integ_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathnumericalintegMatrix::get(self : MathnumericalintegMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathnumericalintegMatrix::transpose(self : MathnumericalintegMatrix) -> MathnumericalintegMatrix {
  let result = math_numerical_integ_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathnumericalintegMatrix::add(self : MathnumericalintegMatrix, other : MathnumericalintegMatrix) -> MathnumericalintegMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_numerical_integ_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathnumericalintegMatrix::scale(self : MathnumericalintegMatrix, s : Double) -> MathnumericalintegMatrix {
  let result = math_numerical_integ_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathnumericalintegMatrix::multiply(self : MathnumericalintegMatrix, other : MathnumericalintegMatrix) -> MathnumericalintegMatrix {
  if self.cols != other.rows { return math_numerical_integ_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_numerical_integ_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathnumericalintegMatrix::trace(self : MathnumericalintegMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathnumericalintegMatrix::det(self : MathnumericalintegMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathnumericalintegMatrix::norm(self : MathnumericalintegMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathnumericalintegMatrix::to_string(self : MathnumericalintegMatrix) -> String {
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

pub(all) struct MathnumericalintegVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_numerical_integ_make_vector(comps : Array[Double]) -> MathnumericalintegVector {
  { comps, dim: comps.length() }
}

pub fn math_numerical_integ_vector_zero(dim : Int) -> MathnumericalintegVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathnumericalintegVector::add(self : MathnumericalintegVector, other : MathnumericalintegVector) -> MathnumericalintegVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathnumericalintegVector::sub(self : MathnumericalintegVector, other : MathnumericalintegVector) -> MathnumericalintegVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathnumericalintegVector::scale(self : MathnumericalintegVector, s : Double) -> MathnumericalintegVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathnumericalintegVector::dot(self : MathnumericalintegVector, other : MathnumericalintegVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathnumericalintegVector::norm(self : MathnumericalintegVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathnumericalintegVector::normalize(self : MathnumericalintegVector) -> MathnumericalintegVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathnumericalintegVector::dist(self : MathnumericalintegVector, other : MathnumericalintegVector) -> Double {
  self.sub(other).norm()
}

pub fn MathnumericalintegVector::to_string(self : MathnumericalintegVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_numerical_integ_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_numerical_integ_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_numerical_integ_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_numerical_integ_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_numerical_integ_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_numerical_integ_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_numerical_integ_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_numerical_integ_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_numerical_integ_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_numerical_integ_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_numerical_integ_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_numerical_integ_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_numerical_integ_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_numerical_integ_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_numerical_integ_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_numerical_integ_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_numerical_integ_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_numerical_integ_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_numerical_integ_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_numerical_integ_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_numerical_integ_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_numerical_integ_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_numerical_integ_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_numerical_integ_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_numerical_integ_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_numerical_integ_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_numerical_integ_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_numerical_integ_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_numerical_integ_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathnumericalintegFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_frame_make(size : Int) -> MathnumericalintegFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_frame_len(s : MathnumericalintegFrame) -> Int { s.size }

pub fn math_numerical_integ_frame_get(s : MathnumericalintegFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_frame_set(s : MathnumericalintegFrame, i : Int, v : Double) -> MathnumericalintegFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_frame_sum(s : MathnumericalintegFrame) -> Double { @_common.sum(s.data) }

pub fn math_numerical_integ_frame_mean(s : MathnumericalintegFrame) -> Double { @_common.mean(s.data) }

pub fn math_numerical_integ_frame_scale(s : MathnumericalintegFrame, f : Double) -> MathnumericalintegFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_frame_add(a : MathnumericalintegFrame, b : MathnumericalintegFrame) -> MathnumericalintegFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_integ_frame_copy(s : MathnumericalintegFrame) -> MathnumericalintegFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_frame_fill(s : MathnumericalintegFrame, v : Double) -> MathnumericalintegFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_frame_min(s : MathnumericalintegFrame) -> Double { @_common.min(s.data) }

pub fn math_numerical_integ_frame_max(s : MathnumericalintegFrame) -> Double { @_common.max(s.data) }

pub fn math_numerical_integ_frame_to_string(s : MathnumericalintegFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_table_make(size : Int) -> MathnumericalintegTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_table_len(s : MathnumericalintegTable) -> Int { s.size }

pub fn math_numerical_integ_table_get(s : MathnumericalintegTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_table_set(s : MathnumericalintegTable, i : Int, v : Double) -> MathnumericalintegTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_table_sum(s : MathnumericalintegTable) -> Double { @_common.sum(s.data) }

pub fn math_numerical_integ_table_mean(s : MathnumericalintegTable) -> Double { @_common.mean(s.data) }

pub fn math_numerical_integ_table_scale(s : MathnumericalintegTable, f : Double) -> MathnumericalintegTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_table_add(a : MathnumericalintegTable, b : MathnumericalintegTable) -> MathnumericalintegTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_integ_table_copy(s : MathnumericalintegTable) -> MathnumericalintegTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_table_fill(s : MathnumericalintegTable, v : Double) -> MathnumericalintegTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_table_min(s : MathnumericalintegTable) -> Double { @_common.min(s.data) }

pub fn math_numerical_integ_table_max(s : MathnumericalintegTable) -> Double { @_common.max(s.data) }

pub fn math_numerical_integ_table_to_string(s : MathnumericalintegTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_graphn_make(size : Int) -> MathnumericalintegGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_graphn_len(s : MathnumericalintegGraphN) -> Int { s.size }

pub fn math_numerical_integ_graphn_get(s : MathnumericalintegGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_graphn_set(s : MathnumericalintegGraphN, i : Int, v : Double) -> MathnumericalintegGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_graphn_sum(s : MathnumericalintegGraphN) -> Double { @_common.sum(s.data) }

pub fn math_numerical_integ_graphn_mean(s : MathnumericalintegGraphN) -> Double { @_common.mean(s.data) }

pub fn math_numerical_integ_graphn_scale(s : MathnumericalintegGraphN, f : Double) -> MathnumericalintegGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_graphn_add(a : MathnumericalintegGraphN, b : MathnumericalintegGraphN) -> MathnumericalintegGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_integ_graphn_copy(s : MathnumericalintegGraphN) -> MathnumericalintegGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_graphn_fill(s : MathnumericalintegGraphN, v : Double) -> MathnumericalintegGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_graphn_min(s : MathnumericalintegGraphN) -> Double { @_common.min(s.data) }

pub fn math_numerical_integ_graphn_max(s : MathnumericalintegGraphN) -> Double { @_common.max(s.data) }

pub fn math_numerical_integ_graphn_to_string(s : MathnumericalintegGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_node_make(size : Int) -> MathnumericalintegNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_node_len(s : MathnumericalintegNode) -> Int { s.size }

pub fn math_numerical_integ_node_get(s : MathnumericalintegNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_node_set(s : MathnumericalintegNode, i : Int, v : Double) -> MathnumericalintegNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_node_sum(s : MathnumericalintegNode) -> Double { @_common.sum(s.data) }

pub fn math_numerical_integ_node_mean(s : MathnumericalintegNode) -> Double { @_common.mean(s.data) }

pub fn math_numerical_integ_node_scale(s : MathnumericalintegNode, f : Double) -> MathnumericalintegNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_node_add(a : MathnumericalintegNode, b : MathnumericalintegNode) -> MathnumericalintegNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_integ_node_copy(s : MathnumericalintegNode) -> MathnumericalintegNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_node_fill(s : MathnumericalintegNode, v : Double) -> MathnumericalintegNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_node_min(s : MathnumericalintegNode) -> Double { @_common.min(s.data) }

pub fn math_numerical_integ_node_max(s : MathnumericalintegNode) -> Double { @_common.max(s.data) }

pub fn math_numerical_integ_node_to_string(s : MathnumericalintegNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_edge_make(size : Int) -> MathnumericalintegEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_edge_len(s : MathnumericalintegEdge) -> Int { s.size }

pub fn math_numerical_integ_edge_get(s : MathnumericalintegEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_edge_set(s : MathnumericalintegEdge, i : Int, v : Double) -> MathnumericalintegEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_edge_sum(s : MathnumericalintegEdge) -> Double { @_common.sum(s.data) }

pub fn math_numerical_integ_edge_mean(s : MathnumericalintegEdge) -> Double { @_common.mean(s.data) }

pub fn math_numerical_integ_edge_scale(s : MathnumericalintegEdge, f : Double) -> MathnumericalintegEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_edge_add(a : MathnumericalintegEdge, b : MathnumericalintegEdge) -> MathnumericalintegEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_integ_edge_copy(s : MathnumericalintegEdge) -> MathnumericalintegEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_edge_fill(s : MathnumericalintegEdge, v : Double) -> MathnumericalintegEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_edge_min(s : MathnumericalintegEdge) -> Double { @_common.min(s.data) }

pub fn math_numerical_integ_edge_max(s : MathnumericalintegEdge) -> Double { @_common.max(s.data) }

pub fn math_numerical_integ_edge_to_string(s : MathnumericalintegEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_path_make(size : Int) -> MathnumericalintegPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_path_len(s : MathnumericalintegPath) -> Int { s.size }

pub fn math_numerical_integ_path_get(s : MathnumericalintegPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_path_set(s : MathnumericalintegPath, i : Int, v : Double) -> MathnumericalintegPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_path_sum(s : MathnumericalintegPath) -> Double { @_common.sum(s.data) }

pub fn math_numerical_integ_path_mean(s : MathnumericalintegPath) -> Double { @_common.mean(s.data) }

pub fn math_numerical_integ_path_scale(s : MathnumericalintegPath, f : Double) -> MathnumericalintegPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_path_add(a : MathnumericalintegPath, b : MathnumericalintegPath) -> MathnumericalintegPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_integ_path_copy(s : MathnumericalintegPath) -> MathnumericalintegPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_path_fill(s : MathnumericalintegPath, v : Double) -> MathnumericalintegPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_path_min(s : MathnumericalintegPath) -> Double { @_common.min(s.data) }

pub fn math_numerical_integ_path_max(s : MathnumericalintegPath) -> Double { @_common.max(s.data) }

pub fn math_numerical_integ_path_to_string(s : MathnumericalintegPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_cluster_make(size : Int) -> MathnumericalintegCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_cluster_len(s : MathnumericalintegCluster) -> Int { s.size }

pub fn math_numerical_integ_cluster_get(s : MathnumericalintegCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_cluster_set(s : MathnumericalintegCluster, i : Int, v : Double) -> MathnumericalintegCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_cluster_sum(s : MathnumericalintegCluster) -> Double { @_common.sum(s.data) }

pub fn math_numerical_integ_cluster_mean(s : MathnumericalintegCluster) -> Double { @_common.mean(s.data) }

pub fn math_numerical_integ_cluster_scale(s : MathnumericalintegCluster, f : Double) -> MathnumericalintegCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_cluster_add(a : MathnumericalintegCluster, b : MathnumericalintegCluster) -> MathnumericalintegCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_integ_cluster_copy(s : MathnumericalintegCluster) -> MathnumericalintegCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_cluster_fill(s : MathnumericalintegCluster, v : Double) -> MathnumericalintegCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_cluster_min(s : MathnumericalintegCluster) -> Double { @_common.min(s.data) }

pub fn math_numerical_integ_cluster_max(s : MathnumericalintegCluster) -> Double { @_common.max(s.data) }

pub fn math_numerical_integ_cluster_to_string(s : MathnumericalintegCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_model_make(size : Int) -> MathnumericalintegModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_model_len(s : MathnumericalintegModel) -> Int { s.size }

pub fn math_numerical_integ_model_get(s : MathnumericalintegModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_model_set(s : MathnumericalintegModel, i : Int, v : Double) -> MathnumericalintegModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_model_sum(s : MathnumericalintegModel) -> Double { @_common.sum(s.data) }

pub fn math_numerical_integ_model_mean(s : MathnumericalintegModel) -> Double { @_common.mean(s.data) }

pub fn math_numerical_integ_model_scale(s : MathnumericalintegModel, f : Double) -> MathnumericalintegModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_model_add(a : MathnumericalintegModel, b : MathnumericalintegModel) -> MathnumericalintegModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_integ_model_copy(s : MathnumericalintegModel) -> MathnumericalintegModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_model_fill(s : MathnumericalintegModel, v : Double) -> MathnumericalintegModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_model_min(s : MathnumericalintegModel) -> Double { @_common.min(s.data) }

pub fn math_numerical_integ_model_max(s : MathnumericalintegModel) -> Double { @_common.max(s.data) }

pub fn math_numerical_integ_model_to_string(s : MathnumericalintegModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_layer_make(size : Int) -> MathnumericalintegLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_layer_len(s : MathnumericalintegLayer) -> Int { s.size }

pub fn math_numerical_integ_layer_get(s : MathnumericalintegLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_layer_set(s : MathnumericalintegLayer, i : Int, v : Double) -> MathnumericalintegLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_layer_sum(s : MathnumericalintegLayer) -> Double { @_common.sum(s.data) }

pub fn math_numerical_integ_layer_mean(s : MathnumericalintegLayer) -> Double { @_common.mean(s.data) }

pub fn math_numerical_integ_layer_scale(s : MathnumericalintegLayer, f : Double) -> MathnumericalintegLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_layer_add(a : MathnumericalintegLayer, b : MathnumericalintegLayer) -> MathnumericalintegLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_integ_layer_copy(s : MathnumericalintegLayer) -> MathnumericalintegLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_layer_fill(s : MathnumericalintegLayer, v : Double) -> MathnumericalintegLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_layer_min(s : MathnumericalintegLayer) -> Double { @_common.min(s.data) }

pub fn math_numerical_integ_layer_max(s : MathnumericalintegLayer) -> Double { @_common.max(s.data) }

pub fn math_numerical_integ_layer_to_string(s : MathnumericalintegLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_buffer_make(size : Int) -> MathnumericalintegBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_buffer_len(s : MathnumericalintegBuffer) -> Int { s.size }

pub fn math_numerical_integ_buffer_get(s : MathnumericalintegBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_buffer_set(s : MathnumericalintegBuffer, i : Int, v : Double) -> MathnumericalintegBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_buffer_sum(s : MathnumericalintegBuffer) -> Double { @_common.sum(s.data) }

pub fn math_numerical_integ_buffer_mean(s : MathnumericalintegBuffer) -> Double { @_common.mean(s.data) }

pub fn math_numerical_integ_buffer_scale(s : MathnumericalintegBuffer, f : Double) -> MathnumericalintegBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_buffer_add(a : MathnumericalintegBuffer, b : MathnumericalintegBuffer) -> MathnumericalintegBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_integ_buffer_copy(s : MathnumericalintegBuffer) -> MathnumericalintegBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_buffer_fill(s : MathnumericalintegBuffer, v : Double) -> MathnumericalintegBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_buffer_min(s : MathnumericalintegBuffer) -> Double { @_common.min(s.data) }

pub fn math_numerical_integ_buffer_max(s : MathnumericalintegBuffer) -> Double { @_common.max(s.data) }

pub fn math_numerical_integ_buffer_to_string(s : MathnumericalintegBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_cursor_make(size : Int) -> MathnumericalintegCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_cursor_len(s : MathnumericalintegCursor) -> Int { s.size }

pub fn math_numerical_integ_cursor_get(s : MathnumericalintegCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_cursor_set(s : MathnumericalintegCursor, i : Int, v : Double) -> MathnumericalintegCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_cursor_sum(s : MathnumericalintegCursor) -> Double { @_common.sum(s.data) }

pub fn math_numerical_integ_cursor_mean(s : MathnumericalintegCursor) -> Double { @_common.mean(s.data) }

pub fn math_numerical_integ_cursor_scale(s : MathnumericalintegCursor, f : Double) -> MathnumericalintegCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_cursor_add(a : MathnumericalintegCursor, b : MathnumericalintegCursor) -> MathnumericalintegCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_integ_cursor_copy(s : MathnumericalintegCursor) -> MathnumericalintegCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_cursor_fill(s : MathnumericalintegCursor, v : Double) -> MathnumericalintegCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_cursor_min(s : MathnumericalintegCursor) -> Double { @_common.min(s.data) }

pub fn math_numerical_integ_cursor_max(s : MathnumericalintegCursor) -> Double { @_common.max(s.data) }

pub fn math_numerical_integ_cursor_to_string(s : MathnumericalintegCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_view_make(size : Int) -> MathnumericalintegView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_view_len(s : MathnumericalintegView) -> Int { s.size }

pub fn math_numerical_integ_view_get(s : MathnumericalintegView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_view_set(s : MathnumericalintegView, i : Int, v : Double) -> MathnumericalintegView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_view_sum(s : MathnumericalintegView) -> Double { @_common.sum(s.data) }

pub fn math_numerical_integ_view_mean(s : MathnumericalintegView) -> Double { @_common.mean(s.data) }

pub fn math_numerical_integ_view_scale(s : MathnumericalintegView, f : Double) -> MathnumericalintegView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_view_add(a : MathnumericalintegView, b : MathnumericalintegView) -> MathnumericalintegView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_integ_view_copy(s : MathnumericalintegView) -> MathnumericalintegView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_view_fill(s : MathnumericalintegView, v : Double) -> MathnumericalintegView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_view_min(s : MathnumericalintegView) -> Double { @_common.min(s.data) }

pub fn math_numerical_integ_view_max(s : MathnumericalintegView) -> Double { @_common.max(s.data) }

pub fn math_numerical_integ_view_to_string(s : MathnumericalintegView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_range_make(size : Int) -> MathnumericalintegRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_range_len(s : MathnumericalintegRange) -> Int { s.size }

pub fn math_numerical_integ_range_get(s : MathnumericalintegRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_range_set(s : MathnumericalintegRange, i : Int, v : Double) -> MathnumericalintegRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_range_sum(s : MathnumericalintegRange) -> Double { @_common.sum(s.data) }

pub fn math_numerical_integ_range_mean(s : MathnumericalintegRange) -> Double { @_common.mean(s.data) }

pub fn math_numerical_integ_range_scale(s : MathnumericalintegRange, f : Double) -> MathnumericalintegRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_range_add(a : MathnumericalintegRange, b : MathnumericalintegRange) -> MathnumericalintegRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_integ_range_copy(s : MathnumericalintegRange) -> MathnumericalintegRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_range_fill(s : MathnumericalintegRange, v : Double) -> MathnumericalintegRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_range_min(s : MathnumericalintegRange) -> Double { @_common.min(s.data) }

pub fn math_numerical_integ_range_max(s : MathnumericalintegRange) -> Double { @_common.max(s.data) }

pub fn math_numerical_integ_range_to_string(s : MathnumericalintegRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathnumericalintegSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_numerical_integ_slice_make(size : Int) -> MathnumericalintegSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_numerical_integ_slice_len(s : MathnumericalintegSlice) -> Int { s.size }

pub fn math_numerical_integ_slice_get(s : MathnumericalintegSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_numerical_integ_slice_set(s : MathnumericalintegSlice, i : Int, v : Double) -> MathnumericalintegSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_slice_sum(s : MathnumericalintegSlice) -> Double { @_common.sum(s.data) }

pub fn math_numerical_integ_slice_mean(s : MathnumericalintegSlice) -> Double { @_common.mean(s.data) }

pub fn math_numerical_integ_slice_scale(s : MathnumericalintegSlice, f : Double) -> MathnumericalintegSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_slice_add(a : MathnumericalintegSlice, b : MathnumericalintegSlice) -> MathnumericalintegSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_numerical_integ_slice_copy(s : MathnumericalintegSlice) -> MathnumericalintegSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_slice_fill(s : MathnumericalintegSlice, v : Double) -> MathnumericalintegSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_numerical_integ_slice_min(s : MathnumericalintegSlice) -> Double { @_common.min(s.data) }

pub fn math_numerical_integ_slice_max(s : MathnumericalintegSlice) -> Double { @_common.max(s.data) }

pub fn math_numerical_integ_slice_to_string(s : MathnumericalintegSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

