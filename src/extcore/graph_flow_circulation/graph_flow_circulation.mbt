///===
/// extcore/graph_flow_circulation

pub(all) struct GraphflowcirculationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_circulation_make_point(x : Double, y : Double) -> GraphflowcirculationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_circulation_make_point3(x : Double, y : Double, z : Double) -> GraphflowcirculationPoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowcirculationPoint::x(self : GraphflowcirculationPoint) -> Double { self.x }

pub fn GraphflowcirculationPoint::y(self : GraphflowcirculationPoint) -> Double { self.y }

pub fn GraphflowcirculationPoint::z(self : GraphflowcirculationPoint) -> Double { self.z }

pub fn GraphflowcirculationPoint::label(self : GraphflowcirculationPoint) -> Int { self.label }

pub fn GraphflowcirculationPoint::dist(self : GraphflowcirculationPoint, other : GraphflowcirculationPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowcirculationPoint::add(self : GraphflowcirculationPoint, other : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowcirculationPoint::sub(self : GraphflowcirculationPoint, other : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowcirculationPoint::scale(self : GraphflowcirculationPoint, s : Double) -> GraphflowcirculationPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowcirculationPoint::dot(self : GraphflowcirculationPoint, other : GraphflowcirculationPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowcirculationPoint::cross(self : GraphflowcirculationPoint, other : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowcirculationPoint::norm(self : GraphflowcirculationPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowcirculationPoint::normalize(self : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowcirculationPoint::negate(self : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowcirculationPoint::mid(self : GraphflowcirculationPoint, other : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowcirculationPoint::lerp(self : GraphflowcirculationPoint, other : GraphflowcirculationPoint, t : Double) -> GraphflowcirculationPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowcirculationPoint::to_string(self : GraphflowcirculationPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowcirculationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_circulation_make_series(vals : Array[Double], name : String) -> GraphflowcirculationSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowcirculationSeries::len(self : GraphflowcirculationSeries) -> Int { self.vals.length() }

pub fn GraphflowcirculationSeries::sum(self : GraphflowcirculationSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowcirculationSeries::mean(self : GraphflowcirculationSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowcirculationSeries::min(self : GraphflowcirculationSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowcirculationSeries::max(self : GraphflowcirculationSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowcirculationSeries::range(self : GraphflowcirculationSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowcirculationSeries::variance(self : GraphflowcirculationSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowcirculationSeries::std(self : GraphflowcirculationSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowcirculationSeries::median(self : GraphflowcirculationSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowcirculationSeries::scale(self : GraphflowcirculationSeries, f : Double) -> GraphflowcirculationSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowcirculationSeries::add(self : GraphflowcirculationSeries, other : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowcirculationSeries::sub(self : GraphflowcirculationSeries, other : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowcirculationSeries::normalize(self : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowcirculationSeries::cumsum(self : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowcirculationSeries::to_string(self : GraphflowcirculationSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowcirculationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_circulation_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowcirculationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_circulation_matrix_identity(n : Int) -> GraphflowcirculationMatrix {
  let m = graph_flow_circulation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowcirculationMatrix::get(self : GraphflowcirculationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowcirculationMatrix::transpose(self : GraphflowcirculationMatrix) -> GraphflowcirculationMatrix {
  let result = graph_flow_circulation_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowcirculationMatrix::add(self : GraphflowcirculationMatrix, other : GraphflowcirculationMatrix) -> GraphflowcirculationMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_circulation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowcirculationMatrix::scale(self : GraphflowcirculationMatrix, s : Double) -> GraphflowcirculationMatrix {
  let result = graph_flow_circulation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowcirculationMatrix::multiply(self : GraphflowcirculationMatrix, other : GraphflowcirculationMatrix) -> GraphflowcirculationMatrix {
  if self.cols != other.rows { return graph_flow_circulation_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_circulation_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphflowcirculationMatrix::trace(self : GraphflowcirculationMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowcirculationMatrix::det(self : GraphflowcirculationMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowcirculationMatrix::norm(self : GraphflowcirculationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowcirculationMatrix::to_string(self : GraphflowcirculationMatrix) -> String {
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

pub(all) struct GraphflowcirculationVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_circulation_make_vector(comps : Array[Double]) -> GraphflowcirculationVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_circulation_vector_zero(dim : Int) -> GraphflowcirculationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowcirculationVector::add(self : GraphflowcirculationVector, other : GraphflowcirculationVector) -> GraphflowcirculationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowcirculationVector::sub(self : GraphflowcirculationVector, other : GraphflowcirculationVector) -> GraphflowcirculationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowcirculationVector::scale(self : GraphflowcirculationVector, s : Double) -> GraphflowcirculationVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowcirculationVector::dot(self : GraphflowcirculationVector, other : GraphflowcirculationVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowcirculationVector::norm(self : GraphflowcirculationVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowcirculationVector::normalize(self : GraphflowcirculationVector) -> GraphflowcirculationVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowcirculationVector::dist(self : GraphflowcirculationVector, other : GraphflowcirculationVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowcirculationVector::to_string(self : GraphflowcirculationVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_circulation_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_circulation_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_circulation_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_circulation_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_circulation_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_circulation_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_circulation_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_circulation_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_circulation_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_circulation_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_circulation_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_circulation_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_circulation_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_circulation_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_circulation_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_circulation_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_circulation_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_circulation_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_circulation_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_circulation_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_circulation_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_circulation_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_circulation_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_circulation_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_circulation_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_circulation_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_circulation_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_circulation_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_circulation_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowcirculationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_frame_make(size : Int) -> GraphflowcirculationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_frame_len(s : GraphflowcirculationFrame) -> Int { s.size }

pub fn graph_flow_circulation_frame_get(s : GraphflowcirculationFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_frame_set(s : GraphflowcirculationFrame, i : Int, v : Double) -> GraphflowcirculationFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_frame_sum(s : GraphflowcirculationFrame) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_frame_mean(s : GraphflowcirculationFrame) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_frame_scale(s : GraphflowcirculationFrame, f : Double) -> GraphflowcirculationFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_frame_add(a : GraphflowcirculationFrame, b : GraphflowcirculationFrame) -> GraphflowcirculationFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_frame_copy(s : GraphflowcirculationFrame) -> GraphflowcirculationFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_frame_fill(s : GraphflowcirculationFrame, v : Double) -> GraphflowcirculationFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_frame_min(s : GraphflowcirculationFrame) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_frame_max(s : GraphflowcirculationFrame) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_frame_to_string(s : GraphflowcirculationFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_table_make(size : Int) -> GraphflowcirculationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_table_len(s : GraphflowcirculationTable) -> Int { s.size }

pub fn graph_flow_circulation_table_get(s : GraphflowcirculationTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_table_set(s : GraphflowcirculationTable, i : Int, v : Double) -> GraphflowcirculationTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_table_sum(s : GraphflowcirculationTable) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_table_mean(s : GraphflowcirculationTable) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_table_scale(s : GraphflowcirculationTable, f : Double) -> GraphflowcirculationTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_table_add(a : GraphflowcirculationTable, b : GraphflowcirculationTable) -> GraphflowcirculationTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_table_copy(s : GraphflowcirculationTable) -> GraphflowcirculationTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_table_fill(s : GraphflowcirculationTable, v : Double) -> GraphflowcirculationTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_table_min(s : GraphflowcirculationTable) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_table_max(s : GraphflowcirculationTable) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_table_to_string(s : GraphflowcirculationTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_graphn_make(size : Int) -> GraphflowcirculationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_graphn_len(s : GraphflowcirculationGraphN) -> Int { s.size }

pub fn graph_flow_circulation_graphn_get(s : GraphflowcirculationGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_graphn_set(s : GraphflowcirculationGraphN, i : Int, v : Double) -> GraphflowcirculationGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_graphn_sum(s : GraphflowcirculationGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_graphn_mean(s : GraphflowcirculationGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_graphn_scale(s : GraphflowcirculationGraphN, f : Double) -> GraphflowcirculationGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_graphn_add(a : GraphflowcirculationGraphN, b : GraphflowcirculationGraphN) -> GraphflowcirculationGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_graphn_copy(s : GraphflowcirculationGraphN) -> GraphflowcirculationGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_graphn_fill(s : GraphflowcirculationGraphN, v : Double) -> GraphflowcirculationGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_graphn_min(s : GraphflowcirculationGraphN) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_graphn_max(s : GraphflowcirculationGraphN) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_graphn_to_string(s : GraphflowcirculationGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_node_make(size : Int) -> GraphflowcirculationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_node_len(s : GraphflowcirculationNode) -> Int { s.size }

pub fn graph_flow_circulation_node_get(s : GraphflowcirculationNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_node_set(s : GraphflowcirculationNode, i : Int, v : Double) -> GraphflowcirculationNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_node_sum(s : GraphflowcirculationNode) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_node_mean(s : GraphflowcirculationNode) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_node_scale(s : GraphflowcirculationNode, f : Double) -> GraphflowcirculationNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_node_add(a : GraphflowcirculationNode, b : GraphflowcirculationNode) -> GraphflowcirculationNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_node_copy(s : GraphflowcirculationNode) -> GraphflowcirculationNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_node_fill(s : GraphflowcirculationNode, v : Double) -> GraphflowcirculationNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_node_min(s : GraphflowcirculationNode) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_node_max(s : GraphflowcirculationNode) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_node_to_string(s : GraphflowcirculationNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_edge_make(size : Int) -> GraphflowcirculationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_edge_len(s : GraphflowcirculationEdge) -> Int { s.size }

pub fn graph_flow_circulation_edge_get(s : GraphflowcirculationEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_edge_set(s : GraphflowcirculationEdge, i : Int, v : Double) -> GraphflowcirculationEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_edge_sum(s : GraphflowcirculationEdge) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_edge_mean(s : GraphflowcirculationEdge) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_edge_scale(s : GraphflowcirculationEdge, f : Double) -> GraphflowcirculationEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_edge_add(a : GraphflowcirculationEdge, b : GraphflowcirculationEdge) -> GraphflowcirculationEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_edge_copy(s : GraphflowcirculationEdge) -> GraphflowcirculationEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_edge_fill(s : GraphflowcirculationEdge, v : Double) -> GraphflowcirculationEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_edge_min(s : GraphflowcirculationEdge) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_edge_max(s : GraphflowcirculationEdge) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_edge_to_string(s : GraphflowcirculationEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_path_make(size : Int) -> GraphflowcirculationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_path_len(s : GraphflowcirculationPath) -> Int { s.size }

pub fn graph_flow_circulation_path_get(s : GraphflowcirculationPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_path_set(s : GraphflowcirculationPath, i : Int, v : Double) -> GraphflowcirculationPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_path_sum(s : GraphflowcirculationPath) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_path_mean(s : GraphflowcirculationPath) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_path_scale(s : GraphflowcirculationPath, f : Double) -> GraphflowcirculationPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_path_add(a : GraphflowcirculationPath, b : GraphflowcirculationPath) -> GraphflowcirculationPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_path_copy(s : GraphflowcirculationPath) -> GraphflowcirculationPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_path_fill(s : GraphflowcirculationPath, v : Double) -> GraphflowcirculationPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_path_min(s : GraphflowcirculationPath) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_path_max(s : GraphflowcirculationPath) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_path_to_string(s : GraphflowcirculationPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_cluster_make(size : Int) -> GraphflowcirculationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_cluster_len(s : GraphflowcirculationCluster) -> Int { s.size }

pub fn graph_flow_circulation_cluster_get(s : GraphflowcirculationCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_cluster_set(s : GraphflowcirculationCluster, i : Int, v : Double) -> GraphflowcirculationCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cluster_sum(s : GraphflowcirculationCluster) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_cluster_mean(s : GraphflowcirculationCluster) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_cluster_scale(s : GraphflowcirculationCluster, f : Double) -> GraphflowcirculationCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cluster_add(a : GraphflowcirculationCluster, b : GraphflowcirculationCluster) -> GraphflowcirculationCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_cluster_copy(s : GraphflowcirculationCluster) -> GraphflowcirculationCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cluster_fill(s : GraphflowcirculationCluster, v : Double) -> GraphflowcirculationCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cluster_min(s : GraphflowcirculationCluster) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_cluster_max(s : GraphflowcirculationCluster) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_cluster_to_string(s : GraphflowcirculationCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_model_make(size : Int) -> GraphflowcirculationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_model_len(s : GraphflowcirculationModel) -> Int { s.size }

pub fn graph_flow_circulation_model_get(s : GraphflowcirculationModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_model_set(s : GraphflowcirculationModel, i : Int, v : Double) -> GraphflowcirculationModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_model_sum(s : GraphflowcirculationModel) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_model_mean(s : GraphflowcirculationModel) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_model_scale(s : GraphflowcirculationModel, f : Double) -> GraphflowcirculationModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_model_add(a : GraphflowcirculationModel, b : GraphflowcirculationModel) -> GraphflowcirculationModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_model_copy(s : GraphflowcirculationModel) -> GraphflowcirculationModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_model_fill(s : GraphflowcirculationModel, v : Double) -> GraphflowcirculationModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_model_min(s : GraphflowcirculationModel) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_model_max(s : GraphflowcirculationModel) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_model_to_string(s : GraphflowcirculationModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_layer_make(size : Int) -> GraphflowcirculationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_layer_len(s : GraphflowcirculationLayer) -> Int { s.size }

pub fn graph_flow_circulation_layer_get(s : GraphflowcirculationLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_layer_set(s : GraphflowcirculationLayer, i : Int, v : Double) -> GraphflowcirculationLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_layer_sum(s : GraphflowcirculationLayer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_layer_mean(s : GraphflowcirculationLayer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_layer_scale(s : GraphflowcirculationLayer, f : Double) -> GraphflowcirculationLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_layer_add(a : GraphflowcirculationLayer, b : GraphflowcirculationLayer) -> GraphflowcirculationLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_layer_copy(s : GraphflowcirculationLayer) -> GraphflowcirculationLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_layer_fill(s : GraphflowcirculationLayer, v : Double) -> GraphflowcirculationLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_layer_min(s : GraphflowcirculationLayer) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_layer_max(s : GraphflowcirculationLayer) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_layer_to_string(s : GraphflowcirculationLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_buffer_make(size : Int) -> GraphflowcirculationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_buffer_len(s : GraphflowcirculationBuffer) -> Int { s.size }

pub fn graph_flow_circulation_buffer_get(s : GraphflowcirculationBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_buffer_set(s : GraphflowcirculationBuffer, i : Int, v : Double) -> GraphflowcirculationBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_buffer_sum(s : GraphflowcirculationBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_buffer_mean(s : GraphflowcirculationBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_buffer_scale(s : GraphflowcirculationBuffer, f : Double) -> GraphflowcirculationBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_buffer_add(a : GraphflowcirculationBuffer, b : GraphflowcirculationBuffer) -> GraphflowcirculationBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_buffer_copy(s : GraphflowcirculationBuffer) -> GraphflowcirculationBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_buffer_fill(s : GraphflowcirculationBuffer, v : Double) -> GraphflowcirculationBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_buffer_min(s : GraphflowcirculationBuffer) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_buffer_max(s : GraphflowcirculationBuffer) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_buffer_to_string(s : GraphflowcirculationBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_cursor_make(size : Int) -> GraphflowcirculationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_cursor_len(s : GraphflowcirculationCursor) -> Int { s.size }

pub fn graph_flow_circulation_cursor_get(s : GraphflowcirculationCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_cursor_set(s : GraphflowcirculationCursor, i : Int, v : Double) -> GraphflowcirculationCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cursor_sum(s : GraphflowcirculationCursor) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_cursor_mean(s : GraphflowcirculationCursor) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_cursor_scale(s : GraphflowcirculationCursor, f : Double) -> GraphflowcirculationCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cursor_add(a : GraphflowcirculationCursor, b : GraphflowcirculationCursor) -> GraphflowcirculationCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_cursor_copy(s : GraphflowcirculationCursor) -> GraphflowcirculationCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cursor_fill(s : GraphflowcirculationCursor, v : Double) -> GraphflowcirculationCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_cursor_min(s : GraphflowcirculationCursor) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_cursor_max(s : GraphflowcirculationCursor) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_cursor_to_string(s : GraphflowcirculationCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_view_make(size : Int) -> GraphflowcirculationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_view_len(s : GraphflowcirculationView) -> Int { s.size }

pub fn graph_flow_circulation_view_get(s : GraphflowcirculationView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_view_set(s : GraphflowcirculationView, i : Int, v : Double) -> GraphflowcirculationView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_view_sum(s : GraphflowcirculationView) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_view_mean(s : GraphflowcirculationView) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_view_scale(s : GraphflowcirculationView, f : Double) -> GraphflowcirculationView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_view_add(a : GraphflowcirculationView, b : GraphflowcirculationView) -> GraphflowcirculationView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_view_copy(s : GraphflowcirculationView) -> GraphflowcirculationView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_view_fill(s : GraphflowcirculationView, v : Double) -> GraphflowcirculationView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_view_min(s : GraphflowcirculationView) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_view_max(s : GraphflowcirculationView) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_view_to_string(s : GraphflowcirculationView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_range_make(size : Int) -> GraphflowcirculationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_range_len(s : GraphflowcirculationRange) -> Int { s.size }

pub fn graph_flow_circulation_range_get(s : GraphflowcirculationRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_range_set(s : GraphflowcirculationRange, i : Int, v : Double) -> GraphflowcirculationRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_range_sum(s : GraphflowcirculationRange) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_range_mean(s : GraphflowcirculationRange) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_range_scale(s : GraphflowcirculationRange, f : Double) -> GraphflowcirculationRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_range_add(a : GraphflowcirculationRange, b : GraphflowcirculationRange) -> GraphflowcirculationRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_range_copy(s : GraphflowcirculationRange) -> GraphflowcirculationRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_range_fill(s : GraphflowcirculationRange, v : Double) -> GraphflowcirculationRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_range_min(s : GraphflowcirculationRange) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_range_max(s : GraphflowcirculationRange) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_range_to_string(s : GraphflowcirculationRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_slice_make(size : Int) -> GraphflowcirculationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_slice_len(s : GraphflowcirculationSlice) -> Int { s.size }

pub fn graph_flow_circulation_slice_get(s : GraphflowcirculationSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_slice_set(s : GraphflowcirculationSlice, i : Int, v : Double) -> GraphflowcirculationSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_slice_sum(s : GraphflowcirculationSlice) -> Double { @_common.sum(s.data) }

pub fn graph_flow_circulation_slice_mean(s : GraphflowcirculationSlice) -> Double { @_common.mean(s.data) }

pub fn graph_flow_circulation_slice_scale(s : GraphflowcirculationSlice, f : Double) -> GraphflowcirculationSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_slice_add(a : GraphflowcirculationSlice, b : GraphflowcirculationSlice) -> GraphflowcirculationSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_circulation_slice_copy(s : GraphflowcirculationSlice) -> GraphflowcirculationSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_slice_fill(s : GraphflowcirculationSlice, v : Double) -> GraphflowcirculationSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_circulation_slice_min(s : GraphflowcirculationSlice) -> Double { @_common.min(s.data) }

pub fn graph_flow_circulation_slice_max(s : GraphflowcirculationSlice) -> Double { @_common.max(s.data) }

pub fn graph_flow_circulation_slice_to_string(s : GraphflowcirculationSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

