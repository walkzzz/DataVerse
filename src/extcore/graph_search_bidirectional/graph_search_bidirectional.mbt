///===
/// extcore/graph_search_bidirectional

pub(all) struct GraphsearchbidirectionalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_bidirectional_make_point(x : Double, y : Double) -> GraphsearchbidirectionalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_bidirectional_make_point3(x : Double, y : Double, z : Double) -> GraphsearchbidirectionalPoint {
  { x, y, z, label: 0 }
}

pub fn GraphsearchbidirectionalPoint::x(self : GraphsearchbidirectionalPoint) -> Double { self.x }

pub fn GraphsearchbidirectionalPoint::y(self : GraphsearchbidirectionalPoint) -> Double { self.y }

pub fn GraphsearchbidirectionalPoint::z(self : GraphsearchbidirectionalPoint) -> Double { self.z }

pub fn GraphsearchbidirectionalPoint::label(self : GraphsearchbidirectionalPoint) -> Int { self.label }

pub fn GraphsearchbidirectionalPoint::dist(self : GraphsearchbidirectionalPoint, other : GraphsearchbidirectionalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphsearchbidirectionalPoint::add(self : GraphsearchbidirectionalPoint, other : GraphsearchbidirectionalPoint) -> GraphsearchbidirectionalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphsearchbidirectionalPoint::sub(self : GraphsearchbidirectionalPoint, other : GraphsearchbidirectionalPoint) -> GraphsearchbidirectionalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphsearchbidirectionalPoint::scale(self : GraphsearchbidirectionalPoint, s : Double) -> GraphsearchbidirectionalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphsearchbidirectionalPoint::dot(self : GraphsearchbidirectionalPoint, other : GraphsearchbidirectionalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphsearchbidirectionalPoint::cross(self : GraphsearchbidirectionalPoint, other : GraphsearchbidirectionalPoint) -> GraphsearchbidirectionalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphsearchbidirectionalPoint::norm(self : GraphsearchbidirectionalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphsearchbidirectionalPoint::normalize(self : GraphsearchbidirectionalPoint) -> GraphsearchbidirectionalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchbidirectionalPoint::negate(self : GraphsearchbidirectionalPoint) -> GraphsearchbidirectionalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphsearchbidirectionalPoint::mid(self : GraphsearchbidirectionalPoint, other : GraphsearchbidirectionalPoint) -> GraphsearchbidirectionalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphsearchbidirectionalPoint::lerp(self : GraphsearchbidirectionalPoint, other : GraphsearchbidirectionalPoint, t : Double) -> GraphsearchbidirectionalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphsearchbidirectionalPoint::to_string(self : GraphsearchbidirectionalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_bidirectional_make_series(vals : Array[Double], name : String) -> GraphsearchbidirectionalSeries {
  { vals, name, meta: 0 }
}

pub fn GraphsearchbidirectionalSeries::len(self : GraphsearchbidirectionalSeries) -> Int { self.vals.length() }

pub fn GraphsearchbidirectionalSeries::sum(self : GraphsearchbidirectionalSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphsearchbidirectionalSeries::mean(self : GraphsearchbidirectionalSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphsearchbidirectionalSeries::min(self : GraphsearchbidirectionalSeries) -> Double { @_common.min(self.vals) }

pub fn GraphsearchbidirectionalSeries::max(self : GraphsearchbidirectionalSeries) -> Double { @_common.max(self.vals) }

pub fn GraphsearchbidirectionalSeries::range(self : GraphsearchbidirectionalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphsearchbidirectionalSeries::variance(self : GraphsearchbidirectionalSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphsearchbidirectionalSeries::std(self : GraphsearchbidirectionalSeries) -> Double { @_common.std(self.vals) }

pub fn GraphsearchbidirectionalSeries::median(self : GraphsearchbidirectionalSeries) -> Double { @_common.median(self.vals) }

pub fn GraphsearchbidirectionalSeries::scale(self : GraphsearchbidirectionalSeries, f : Double) -> GraphsearchbidirectionalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphsearchbidirectionalSeries::add(self : GraphsearchbidirectionalSeries, other : GraphsearchbidirectionalSeries) -> GraphsearchbidirectionalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphsearchbidirectionalSeries::sub(self : GraphsearchbidirectionalSeries, other : GraphsearchbidirectionalSeries) -> GraphsearchbidirectionalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphsearchbidirectionalSeries::normalize(self : GraphsearchbidirectionalSeries) -> GraphsearchbidirectionalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphsearchbidirectionalSeries::cumsum(self : GraphsearchbidirectionalSeries) -> GraphsearchbidirectionalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphsearchbidirectionalSeries::to_string(self : GraphsearchbidirectionalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchbidirectionalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_bidirectional_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchbidirectionalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_bidirectional_matrix_identity(n : Int) -> GraphsearchbidirectionalMatrix {
  let m = graph_search_bidirectional_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphsearchbidirectionalMatrix::get(self : GraphsearchbidirectionalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphsearchbidirectionalMatrix::transpose(self : GraphsearchbidirectionalMatrix) -> GraphsearchbidirectionalMatrix {
  let result = graph_search_bidirectional_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphsearchbidirectionalMatrix::add(self : GraphsearchbidirectionalMatrix, other : GraphsearchbidirectionalMatrix) -> GraphsearchbidirectionalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_search_bidirectional_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphsearchbidirectionalMatrix::scale(self : GraphsearchbidirectionalMatrix, s : Double) -> GraphsearchbidirectionalMatrix {
  let result = graph_search_bidirectional_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphsearchbidirectionalMatrix::multiply(self : GraphsearchbidirectionalMatrix, other : GraphsearchbidirectionalMatrix) -> GraphsearchbidirectionalMatrix {
  if self.cols != other.rows { return graph_search_bidirectional_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_search_bidirectional_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphsearchbidirectionalMatrix::trace(self : GraphsearchbidirectionalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphsearchbidirectionalMatrix::det(self : GraphsearchbidirectionalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphsearchbidirectionalMatrix::norm(self : GraphsearchbidirectionalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphsearchbidirectionalMatrix::to_string(self : GraphsearchbidirectionalMatrix) -> String {
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

pub(all) struct GraphsearchbidirectionalVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_bidirectional_make_vector(comps : Array[Double]) -> GraphsearchbidirectionalVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_bidirectional_vector_zero(dim : Int) -> GraphsearchbidirectionalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphsearchbidirectionalVector::add(self : GraphsearchbidirectionalVector, other : GraphsearchbidirectionalVector) -> GraphsearchbidirectionalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchbidirectionalVector::sub(self : GraphsearchbidirectionalVector, other : GraphsearchbidirectionalVector) -> GraphsearchbidirectionalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphsearchbidirectionalVector::scale(self : GraphsearchbidirectionalVector, s : Double) -> GraphsearchbidirectionalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphsearchbidirectionalVector::dot(self : GraphsearchbidirectionalVector, other : GraphsearchbidirectionalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphsearchbidirectionalVector::norm(self : GraphsearchbidirectionalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphsearchbidirectionalVector::normalize(self : GraphsearchbidirectionalVector) -> GraphsearchbidirectionalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphsearchbidirectionalVector::dist(self : GraphsearchbidirectionalVector, other : GraphsearchbidirectionalVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphsearchbidirectionalVector::to_string(self : GraphsearchbidirectionalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_bidirectional_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_search_bidirectional_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_search_bidirectional_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_search_bidirectional_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_search_bidirectional_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_search_bidirectional_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_search_bidirectional_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_search_bidirectional_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_search_bidirectional_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_search_bidirectional_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_search_bidirectional_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_search_bidirectional_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_search_bidirectional_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_search_bidirectional_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_search_bidirectional_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_search_bidirectional_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_search_bidirectional_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_search_bidirectional_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_search_bidirectional_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_search_bidirectional_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_search_bidirectional_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_search_bidirectional_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_search_bidirectional_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_search_bidirectional_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_search_bidirectional_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_search_bidirectional_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_search_bidirectional_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_search_bidirectional_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_search_bidirectional_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphsearchbidirectionalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_frame_make(size : Int) -> GraphsearchbidirectionalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_frame_len(s : GraphsearchbidirectionalFrame) -> Int { s.size }

pub fn graph_search_bidirectional_frame_get(s : GraphsearchbidirectionalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_frame_set(s : GraphsearchbidirectionalFrame, i : Int, v : Double) -> GraphsearchbidirectionalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_frame_sum(s : GraphsearchbidirectionalFrame) -> Double { @_common.sum(s.data) }

pub fn graph_search_bidirectional_frame_mean(s : GraphsearchbidirectionalFrame) -> Double { @_common.mean(s.data) }

pub fn graph_search_bidirectional_frame_scale(s : GraphsearchbidirectionalFrame, f : Double) -> GraphsearchbidirectionalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_frame_add(a : GraphsearchbidirectionalFrame, b : GraphsearchbidirectionalFrame) -> GraphsearchbidirectionalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bidirectional_frame_copy(s : GraphsearchbidirectionalFrame) -> GraphsearchbidirectionalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_frame_fill(s : GraphsearchbidirectionalFrame, v : Double) -> GraphsearchbidirectionalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_frame_min(s : GraphsearchbidirectionalFrame) -> Double { @_common.min(s.data) }

pub fn graph_search_bidirectional_frame_max(s : GraphsearchbidirectionalFrame) -> Double { @_common.max(s.data) }

pub fn graph_search_bidirectional_frame_to_string(s : GraphsearchbidirectionalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_table_make(size : Int) -> GraphsearchbidirectionalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_table_len(s : GraphsearchbidirectionalTable) -> Int { s.size }

pub fn graph_search_bidirectional_table_get(s : GraphsearchbidirectionalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_table_set(s : GraphsearchbidirectionalTable, i : Int, v : Double) -> GraphsearchbidirectionalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_table_sum(s : GraphsearchbidirectionalTable) -> Double { @_common.sum(s.data) }

pub fn graph_search_bidirectional_table_mean(s : GraphsearchbidirectionalTable) -> Double { @_common.mean(s.data) }

pub fn graph_search_bidirectional_table_scale(s : GraphsearchbidirectionalTable, f : Double) -> GraphsearchbidirectionalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_table_add(a : GraphsearchbidirectionalTable, b : GraphsearchbidirectionalTable) -> GraphsearchbidirectionalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bidirectional_table_copy(s : GraphsearchbidirectionalTable) -> GraphsearchbidirectionalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_table_fill(s : GraphsearchbidirectionalTable, v : Double) -> GraphsearchbidirectionalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_table_min(s : GraphsearchbidirectionalTable) -> Double { @_common.min(s.data) }

pub fn graph_search_bidirectional_table_max(s : GraphsearchbidirectionalTable) -> Double { @_common.max(s.data) }

pub fn graph_search_bidirectional_table_to_string(s : GraphsearchbidirectionalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_graphn_make(size : Int) -> GraphsearchbidirectionalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_graphn_len(s : GraphsearchbidirectionalGraphN) -> Int { s.size }

pub fn graph_search_bidirectional_graphn_get(s : GraphsearchbidirectionalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_graphn_set(s : GraphsearchbidirectionalGraphN, i : Int, v : Double) -> GraphsearchbidirectionalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_graphn_sum(s : GraphsearchbidirectionalGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_search_bidirectional_graphn_mean(s : GraphsearchbidirectionalGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_search_bidirectional_graphn_scale(s : GraphsearchbidirectionalGraphN, f : Double) -> GraphsearchbidirectionalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_graphn_add(a : GraphsearchbidirectionalGraphN, b : GraphsearchbidirectionalGraphN) -> GraphsearchbidirectionalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bidirectional_graphn_copy(s : GraphsearchbidirectionalGraphN) -> GraphsearchbidirectionalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_graphn_fill(s : GraphsearchbidirectionalGraphN, v : Double) -> GraphsearchbidirectionalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_graphn_min(s : GraphsearchbidirectionalGraphN) -> Double { @_common.min(s.data) }

pub fn graph_search_bidirectional_graphn_max(s : GraphsearchbidirectionalGraphN) -> Double { @_common.max(s.data) }

pub fn graph_search_bidirectional_graphn_to_string(s : GraphsearchbidirectionalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_node_make(size : Int) -> GraphsearchbidirectionalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_node_len(s : GraphsearchbidirectionalNode) -> Int { s.size }

pub fn graph_search_bidirectional_node_get(s : GraphsearchbidirectionalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_node_set(s : GraphsearchbidirectionalNode, i : Int, v : Double) -> GraphsearchbidirectionalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_node_sum(s : GraphsearchbidirectionalNode) -> Double { @_common.sum(s.data) }

pub fn graph_search_bidirectional_node_mean(s : GraphsearchbidirectionalNode) -> Double { @_common.mean(s.data) }

pub fn graph_search_bidirectional_node_scale(s : GraphsearchbidirectionalNode, f : Double) -> GraphsearchbidirectionalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_node_add(a : GraphsearchbidirectionalNode, b : GraphsearchbidirectionalNode) -> GraphsearchbidirectionalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bidirectional_node_copy(s : GraphsearchbidirectionalNode) -> GraphsearchbidirectionalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_node_fill(s : GraphsearchbidirectionalNode, v : Double) -> GraphsearchbidirectionalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_node_min(s : GraphsearchbidirectionalNode) -> Double { @_common.min(s.data) }

pub fn graph_search_bidirectional_node_max(s : GraphsearchbidirectionalNode) -> Double { @_common.max(s.data) }

pub fn graph_search_bidirectional_node_to_string(s : GraphsearchbidirectionalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_edge_make(size : Int) -> GraphsearchbidirectionalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_edge_len(s : GraphsearchbidirectionalEdge) -> Int { s.size }

pub fn graph_search_bidirectional_edge_get(s : GraphsearchbidirectionalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_edge_set(s : GraphsearchbidirectionalEdge, i : Int, v : Double) -> GraphsearchbidirectionalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_edge_sum(s : GraphsearchbidirectionalEdge) -> Double { @_common.sum(s.data) }

pub fn graph_search_bidirectional_edge_mean(s : GraphsearchbidirectionalEdge) -> Double { @_common.mean(s.data) }

pub fn graph_search_bidirectional_edge_scale(s : GraphsearchbidirectionalEdge, f : Double) -> GraphsearchbidirectionalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_edge_add(a : GraphsearchbidirectionalEdge, b : GraphsearchbidirectionalEdge) -> GraphsearchbidirectionalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bidirectional_edge_copy(s : GraphsearchbidirectionalEdge) -> GraphsearchbidirectionalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_edge_fill(s : GraphsearchbidirectionalEdge, v : Double) -> GraphsearchbidirectionalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_edge_min(s : GraphsearchbidirectionalEdge) -> Double { @_common.min(s.data) }

pub fn graph_search_bidirectional_edge_max(s : GraphsearchbidirectionalEdge) -> Double { @_common.max(s.data) }

pub fn graph_search_bidirectional_edge_to_string(s : GraphsearchbidirectionalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_path_make(size : Int) -> GraphsearchbidirectionalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_path_len(s : GraphsearchbidirectionalPath) -> Int { s.size }

pub fn graph_search_bidirectional_path_get(s : GraphsearchbidirectionalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_path_set(s : GraphsearchbidirectionalPath, i : Int, v : Double) -> GraphsearchbidirectionalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_path_sum(s : GraphsearchbidirectionalPath) -> Double { @_common.sum(s.data) }

pub fn graph_search_bidirectional_path_mean(s : GraphsearchbidirectionalPath) -> Double { @_common.mean(s.data) }

pub fn graph_search_bidirectional_path_scale(s : GraphsearchbidirectionalPath, f : Double) -> GraphsearchbidirectionalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_path_add(a : GraphsearchbidirectionalPath, b : GraphsearchbidirectionalPath) -> GraphsearchbidirectionalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bidirectional_path_copy(s : GraphsearchbidirectionalPath) -> GraphsearchbidirectionalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_path_fill(s : GraphsearchbidirectionalPath, v : Double) -> GraphsearchbidirectionalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_path_min(s : GraphsearchbidirectionalPath) -> Double { @_common.min(s.data) }

pub fn graph_search_bidirectional_path_max(s : GraphsearchbidirectionalPath) -> Double { @_common.max(s.data) }

pub fn graph_search_bidirectional_path_to_string(s : GraphsearchbidirectionalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_cluster_make(size : Int) -> GraphsearchbidirectionalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_cluster_len(s : GraphsearchbidirectionalCluster) -> Int { s.size }

pub fn graph_search_bidirectional_cluster_get(s : GraphsearchbidirectionalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_cluster_set(s : GraphsearchbidirectionalCluster, i : Int, v : Double) -> GraphsearchbidirectionalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_cluster_sum(s : GraphsearchbidirectionalCluster) -> Double { @_common.sum(s.data) }

pub fn graph_search_bidirectional_cluster_mean(s : GraphsearchbidirectionalCluster) -> Double { @_common.mean(s.data) }

pub fn graph_search_bidirectional_cluster_scale(s : GraphsearchbidirectionalCluster, f : Double) -> GraphsearchbidirectionalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_cluster_add(a : GraphsearchbidirectionalCluster, b : GraphsearchbidirectionalCluster) -> GraphsearchbidirectionalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bidirectional_cluster_copy(s : GraphsearchbidirectionalCluster) -> GraphsearchbidirectionalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_cluster_fill(s : GraphsearchbidirectionalCluster, v : Double) -> GraphsearchbidirectionalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_cluster_min(s : GraphsearchbidirectionalCluster) -> Double { @_common.min(s.data) }

pub fn graph_search_bidirectional_cluster_max(s : GraphsearchbidirectionalCluster) -> Double { @_common.max(s.data) }

pub fn graph_search_bidirectional_cluster_to_string(s : GraphsearchbidirectionalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_model_make(size : Int) -> GraphsearchbidirectionalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_model_len(s : GraphsearchbidirectionalModel) -> Int { s.size }

pub fn graph_search_bidirectional_model_get(s : GraphsearchbidirectionalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_model_set(s : GraphsearchbidirectionalModel, i : Int, v : Double) -> GraphsearchbidirectionalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_model_sum(s : GraphsearchbidirectionalModel) -> Double { @_common.sum(s.data) }

pub fn graph_search_bidirectional_model_mean(s : GraphsearchbidirectionalModel) -> Double { @_common.mean(s.data) }

pub fn graph_search_bidirectional_model_scale(s : GraphsearchbidirectionalModel, f : Double) -> GraphsearchbidirectionalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_model_add(a : GraphsearchbidirectionalModel, b : GraphsearchbidirectionalModel) -> GraphsearchbidirectionalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bidirectional_model_copy(s : GraphsearchbidirectionalModel) -> GraphsearchbidirectionalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_model_fill(s : GraphsearchbidirectionalModel, v : Double) -> GraphsearchbidirectionalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_model_min(s : GraphsearchbidirectionalModel) -> Double { @_common.min(s.data) }

pub fn graph_search_bidirectional_model_max(s : GraphsearchbidirectionalModel) -> Double { @_common.max(s.data) }

pub fn graph_search_bidirectional_model_to_string(s : GraphsearchbidirectionalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_layer_make(size : Int) -> GraphsearchbidirectionalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_layer_len(s : GraphsearchbidirectionalLayer) -> Int { s.size }

pub fn graph_search_bidirectional_layer_get(s : GraphsearchbidirectionalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_layer_set(s : GraphsearchbidirectionalLayer, i : Int, v : Double) -> GraphsearchbidirectionalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_layer_sum(s : GraphsearchbidirectionalLayer) -> Double { @_common.sum(s.data) }

pub fn graph_search_bidirectional_layer_mean(s : GraphsearchbidirectionalLayer) -> Double { @_common.mean(s.data) }

pub fn graph_search_bidirectional_layer_scale(s : GraphsearchbidirectionalLayer, f : Double) -> GraphsearchbidirectionalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_layer_add(a : GraphsearchbidirectionalLayer, b : GraphsearchbidirectionalLayer) -> GraphsearchbidirectionalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bidirectional_layer_copy(s : GraphsearchbidirectionalLayer) -> GraphsearchbidirectionalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_layer_fill(s : GraphsearchbidirectionalLayer, v : Double) -> GraphsearchbidirectionalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_layer_min(s : GraphsearchbidirectionalLayer) -> Double { @_common.min(s.data) }

pub fn graph_search_bidirectional_layer_max(s : GraphsearchbidirectionalLayer) -> Double { @_common.max(s.data) }

pub fn graph_search_bidirectional_layer_to_string(s : GraphsearchbidirectionalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_buffer_make(size : Int) -> GraphsearchbidirectionalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_buffer_len(s : GraphsearchbidirectionalBuffer) -> Int { s.size }

pub fn graph_search_bidirectional_buffer_get(s : GraphsearchbidirectionalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_buffer_set(s : GraphsearchbidirectionalBuffer, i : Int, v : Double) -> GraphsearchbidirectionalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_buffer_sum(s : GraphsearchbidirectionalBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_search_bidirectional_buffer_mean(s : GraphsearchbidirectionalBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_search_bidirectional_buffer_scale(s : GraphsearchbidirectionalBuffer, f : Double) -> GraphsearchbidirectionalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_buffer_add(a : GraphsearchbidirectionalBuffer, b : GraphsearchbidirectionalBuffer) -> GraphsearchbidirectionalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bidirectional_buffer_copy(s : GraphsearchbidirectionalBuffer) -> GraphsearchbidirectionalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_buffer_fill(s : GraphsearchbidirectionalBuffer, v : Double) -> GraphsearchbidirectionalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_buffer_min(s : GraphsearchbidirectionalBuffer) -> Double { @_common.min(s.data) }

pub fn graph_search_bidirectional_buffer_max(s : GraphsearchbidirectionalBuffer) -> Double { @_common.max(s.data) }

pub fn graph_search_bidirectional_buffer_to_string(s : GraphsearchbidirectionalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_cursor_make(size : Int) -> GraphsearchbidirectionalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_cursor_len(s : GraphsearchbidirectionalCursor) -> Int { s.size }

pub fn graph_search_bidirectional_cursor_get(s : GraphsearchbidirectionalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_cursor_set(s : GraphsearchbidirectionalCursor, i : Int, v : Double) -> GraphsearchbidirectionalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_cursor_sum(s : GraphsearchbidirectionalCursor) -> Double { @_common.sum(s.data) }

pub fn graph_search_bidirectional_cursor_mean(s : GraphsearchbidirectionalCursor) -> Double { @_common.mean(s.data) }

pub fn graph_search_bidirectional_cursor_scale(s : GraphsearchbidirectionalCursor, f : Double) -> GraphsearchbidirectionalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_cursor_add(a : GraphsearchbidirectionalCursor, b : GraphsearchbidirectionalCursor) -> GraphsearchbidirectionalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bidirectional_cursor_copy(s : GraphsearchbidirectionalCursor) -> GraphsearchbidirectionalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_cursor_fill(s : GraphsearchbidirectionalCursor, v : Double) -> GraphsearchbidirectionalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_cursor_min(s : GraphsearchbidirectionalCursor) -> Double { @_common.min(s.data) }

pub fn graph_search_bidirectional_cursor_max(s : GraphsearchbidirectionalCursor) -> Double { @_common.max(s.data) }

pub fn graph_search_bidirectional_cursor_to_string(s : GraphsearchbidirectionalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_view_make(size : Int) -> GraphsearchbidirectionalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_view_len(s : GraphsearchbidirectionalView) -> Int { s.size }

pub fn graph_search_bidirectional_view_get(s : GraphsearchbidirectionalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_view_set(s : GraphsearchbidirectionalView, i : Int, v : Double) -> GraphsearchbidirectionalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_view_sum(s : GraphsearchbidirectionalView) -> Double { @_common.sum(s.data) }

pub fn graph_search_bidirectional_view_mean(s : GraphsearchbidirectionalView) -> Double { @_common.mean(s.data) }

pub fn graph_search_bidirectional_view_scale(s : GraphsearchbidirectionalView, f : Double) -> GraphsearchbidirectionalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_view_add(a : GraphsearchbidirectionalView, b : GraphsearchbidirectionalView) -> GraphsearchbidirectionalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bidirectional_view_copy(s : GraphsearchbidirectionalView) -> GraphsearchbidirectionalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_view_fill(s : GraphsearchbidirectionalView, v : Double) -> GraphsearchbidirectionalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_view_min(s : GraphsearchbidirectionalView) -> Double { @_common.min(s.data) }

pub fn graph_search_bidirectional_view_max(s : GraphsearchbidirectionalView) -> Double { @_common.max(s.data) }

pub fn graph_search_bidirectional_view_to_string(s : GraphsearchbidirectionalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_range_make(size : Int) -> GraphsearchbidirectionalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_range_len(s : GraphsearchbidirectionalRange) -> Int { s.size }

pub fn graph_search_bidirectional_range_get(s : GraphsearchbidirectionalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_range_set(s : GraphsearchbidirectionalRange, i : Int, v : Double) -> GraphsearchbidirectionalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_range_sum(s : GraphsearchbidirectionalRange) -> Double { @_common.sum(s.data) }

pub fn graph_search_bidirectional_range_mean(s : GraphsearchbidirectionalRange) -> Double { @_common.mean(s.data) }

pub fn graph_search_bidirectional_range_scale(s : GraphsearchbidirectionalRange, f : Double) -> GraphsearchbidirectionalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_range_add(a : GraphsearchbidirectionalRange, b : GraphsearchbidirectionalRange) -> GraphsearchbidirectionalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bidirectional_range_copy(s : GraphsearchbidirectionalRange) -> GraphsearchbidirectionalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_range_fill(s : GraphsearchbidirectionalRange, v : Double) -> GraphsearchbidirectionalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_range_min(s : GraphsearchbidirectionalRange) -> Double { @_common.min(s.data) }

pub fn graph_search_bidirectional_range_max(s : GraphsearchbidirectionalRange) -> Double { @_common.max(s.data) }

pub fn graph_search_bidirectional_range_to_string(s : GraphsearchbidirectionalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_slice_make(size : Int) -> GraphsearchbidirectionalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_slice_len(s : GraphsearchbidirectionalSlice) -> Int { s.size }

pub fn graph_search_bidirectional_slice_get(s : GraphsearchbidirectionalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_slice_set(s : GraphsearchbidirectionalSlice, i : Int, v : Double) -> GraphsearchbidirectionalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_slice_sum(s : GraphsearchbidirectionalSlice) -> Double { @_common.sum(s.data) }

pub fn graph_search_bidirectional_slice_mean(s : GraphsearchbidirectionalSlice) -> Double { @_common.mean(s.data) }

pub fn graph_search_bidirectional_slice_scale(s : GraphsearchbidirectionalSlice, f : Double) -> GraphsearchbidirectionalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_slice_add(a : GraphsearchbidirectionalSlice, b : GraphsearchbidirectionalSlice) -> GraphsearchbidirectionalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_search_bidirectional_slice_copy(s : GraphsearchbidirectionalSlice) -> GraphsearchbidirectionalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_slice_fill(s : GraphsearchbidirectionalSlice, v : Double) -> GraphsearchbidirectionalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_search_bidirectional_slice_min(s : GraphsearchbidirectionalSlice) -> Double { @_common.min(s.data) }

pub fn graph_search_bidirectional_slice_max(s : GraphsearchbidirectionalSlice) -> Double { @_common.max(s.data) }

pub fn graph_search_bidirectional_slice_to_string(s : GraphsearchbidirectionalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

