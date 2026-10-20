///===
/// extcore/graph_flow_stable_marriage

pub(all) struct GraphflowstablemarriagePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_stable_marriage_make_point(x : Double, y : Double) -> GraphflowstablemarriagePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_stable_marriage_make_point3(x : Double, y : Double, z : Double) -> GraphflowstablemarriagePoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowstablemarriagePoint::x(self : GraphflowstablemarriagePoint) -> Double { self.x }

pub fn GraphflowstablemarriagePoint::y(self : GraphflowstablemarriagePoint) -> Double { self.y }

pub fn GraphflowstablemarriagePoint::z(self : GraphflowstablemarriagePoint) -> Double { self.z }

pub fn GraphflowstablemarriagePoint::label(self : GraphflowstablemarriagePoint) -> Int { self.label }

pub fn GraphflowstablemarriagePoint::dist(self : GraphflowstablemarriagePoint, other : GraphflowstablemarriagePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowstablemarriagePoint::add(self : GraphflowstablemarriagePoint, other : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowstablemarriagePoint::sub(self : GraphflowstablemarriagePoint, other : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowstablemarriagePoint::scale(self : GraphflowstablemarriagePoint, s : Double) -> GraphflowstablemarriagePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowstablemarriagePoint::dot(self : GraphflowstablemarriagePoint, other : GraphflowstablemarriagePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowstablemarriagePoint::cross(self : GraphflowstablemarriagePoint, other : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowstablemarriagePoint::norm(self : GraphflowstablemarriagePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowstablemarriagePoint::normalize(self : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowstablemarriagePoint::negate(self : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowstablemarriagePoint::mid(self : GraphflowstablemarriagePoint, other : GraphflowstablemarriagePoint) -> GraphflowstablemarriagePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowstablemarriagePoint::lerp(self : GraphflowstablemarriagePoint, other : GraphflowstablemarriagePoint, t : Double) -> GraphflowstablemarriagePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowstablemarriagePoint::to_string(self : GraphflowstablemarriagePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_stable_marriage_make_series(vals : Array[Double], name : String) -> GraphflowstablemarriageSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowstablemarriageSeries::len(self : GraphflowstablemarriageSeries) -> Int { self.vals.length() }

pub fn GraphflowstablemarriageSeries::sum(self : GraphflowstablemarriageSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowstablemarriageSeries::mean(self : GraphflowstablemarriageSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowstablemarriageSeries::min(self : GraphflowstablemarriageSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowstablemarriageSeries::max(self : GraphflowstablemarriageSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowstablemarriageSeries::range(self : GraphflowstablemarriageSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowstablemarriageSeries::variance(self : GraphflowstablemarriageSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowstablemarriageSeries::std(self : GraphflowstablemarriageSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowstablemarriageSeries::median(self : GraphflowstablemarriageSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowstablemarriageSeries::scale(self : GraphflowstablemarriageSeries, f : Double) -> GraphflowstablemarriageSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowstablemarriageSeries::add(self : GraphflowstablemarriageSeries, other : GraphflowstablemarriageSeries) -> GraphflowstablemarriageSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowstablemarriageSeries::sub(self : GraphflowstablemarriageSeries, other : GraphflowstablemarriageSeries) -> GraphflowstablemarriageSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowstablemarriageSeries::normalize(self : GraphflowstablemarriageSeries) -> GraphflowstablemarriageSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowstablemarriageSeries::cumsum(self : GraphflowstablemarriageSeries) -> GraphflowstablemarriageSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowstablemarriageSeries::to_string(self : GraphflowstablemarriageSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowstablemarriageMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_stable_marriage_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowstablemarriageMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_stable_marriage_matrix_identity(n : Int) -> GraphflowstablemarriageMatrix {
  let m = graph_flow_stable_marriage_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowstablemarriageMatrix::get(self : GraphflowstablemarriageMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowstablemarriageMatrix::transpose(self : GraphflowstablemarriageMatrix) -> GraphflowstablemarriageMatrix {
  let result = graph_flow_stable_marriage_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowstablemarriageMatrix::add(self : GraphflowstablemarriageMatrix, other : GraphflowstablemarriageMatrix) -> GraphflowstablemarriageMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_stable_marriage_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowstablemarriageMatrix::scale(self : GraphflowstablemarriageMatrix, s : Double) -> GraphflowstablemarriageMatrix {
  let result = graph_flow_stable_marriage_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowstablemarriageMatrix::multiply(self : GraphflowstablemarriageMatrix, other : GraphflowstablemarriageMatrix) -> GraphflowstablemarriageMatrix {
  if self.cols != other.rows { return graph_flow_stable_marriage_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_stable_marriage_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphflowstablemarriageMatrix::trace(self : GraphflowstablemarriageMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowstablemarriageMatrix::det(self : GraphflowstablemarriageMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowstablemarriageMatrix::norm(self : GraphflowstablemarriageMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowstablemarriageMatrix::to_string(self : GraphflowstablemarriageMatrix) -> String {
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

pub(all) struct GraphflowstablemarriageVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_stable_marriage_make_vector(comps : Array[Double]) -> GraphflowstablemarriageVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_stable_marriage_vector_zero(dim : Int) -> GraphflowstablemarriageVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowstablemarriageVector::add(self : GraphflowstablemarriageVector, other : GraphflowstablemarriageVector) -> GraphflowstablemarriageVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowstablemarriageVector::sub(self : GraphflowstablemarriageVector, other : GraphflowstablemarriageVector) -> GraphflowstablemarriageVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowstablemarriageVector::scale(self : GraphflowstablemarriageVector, s : Double) -> GraphflowstablemarriageVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowstablemarriageVector::dot(self : GraphflowstablemarriageVector, other : GraphflowstablemarriageVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowstablemarriageVector::norm(self : GraphflowstablemarriageVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowstablemarriageVector::normalize(self : GraphflowstablemarriageVector) -> GraphflowstablemarriageVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowstablemarriageVector::dist(self : GraphflowstablemarriageVector, other : GraphflowstablemarriageVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowstablemarriageVector::to_string(self : GraphflowstablemarriageVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_stable_marriage_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_stable_marriage_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_stable_marriage_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_stable_marriage_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_stable_marriage_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_stable_marriage_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_stable_marriage_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_stable_marriage_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_stable_marriage_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_stable_marriage_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_stable_marriage_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_stable_marriage_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_stable_marriage_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_stable_marriage_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_stable_marriage_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_stable_marriage_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_stable_marriage_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_stable_marriage_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_stable_marriage_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_stable_marriage_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_stable_marriage_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_stable_marriage_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_stable_marriage_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_stable_marriage_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_stable_marriage_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_stable_marriage_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_stable_marriage_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_stable_marriage_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_stable_marriage_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowstablemarriageFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_frame_make(size : Int) -> GraphflowstablemarriageFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_frame_len(s : GraphflowstablemarriageFrame) -> Int { s.size }

pub fn graph_flow_stable_marriage_frame_get(s : GraphflowstablemarriageFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_frame_set(s : GraphflowstablemarriageFrame, i : Int, v : Double) -> GraphflowstablemarriageFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_frame_sum(s : GraphflowstablemarriageFrame) -> Double { @_common.sum(s.data) }

pub fn graph_flow_stable_marriage_frame_mean(s : GraphflowstablemarriageFrame) -> Double { @_common.mean(s.data) }

pub fn graph_flow_stable_marriage_frame_scale(s : GraphflowstablemarriageFrame, f : Double) -> GraphflowstablemarriageFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_frame_add(a : GraphflowstablemarriageFrame, b : GraphflowstablemarriageFrame) -> GraphflowstablemarriageFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_stable_marriage_frame_copy(s : GraphflowstablemarriageFrame) -> GraphflowstablemarriageFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_frame_fill(s : GraphflowstablemarriageFrame, v : Double) -> GraphflowstablemarriageFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_frame_min(s : GraphflowstablemarriageFrame) -> Double { @_common.min(s.data) }

pub fn graph_flow_stable_marriage_frame_max(s : GraphflowstablemarriageFrame) -> Double { @_common.max(s.data) }

pub fn graph_flow_stable_marriage_frame_to_string(s : GraphflowstablemarriageFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_table_make(size : Int) -> GraphflowstablemarriageTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_table_len(s : GraphflowstablemarriageTable) -> Int { s.size }

pub fn graph_flow_stable_marriage_table_get(s : GraphflowstablemarriageTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_table_set(s : GraphflowstablemarriageTable, i : Int, v : Double) -> GraphflowstablemarriageTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_table_sum(s : GraphflowstablemarriageTable) -> Double { @_common.sum(s.data) }

pub fn graph_flow_stable_marriage_table_mean(s : GraphflowstablemarriageTable) -> Double { @_common.mean(s.data) }

pub fn graph_flow_stable_marriage_table_scale(s : GraphflowstablemarriageTable, f : Double) -> GraphflowstablemarriageTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_table_add(a : GraphflowstablemarriageTable, b : GraphflowstablemarriageTable) -> GraphflowstablemarriageTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_stable_marriage_table_copy(s : GraphflowstablemarriageTable) -> GraphflowstablemarriageTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_table_fill(s : GraphflowstablemarriageTable, v : Double) -> GraphflowstablemarriageTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_table_min(s : GraphflowstablemarriageTable) -> Double { @_common.min(s.data) }

pub fn graph_flow_stable_marriage_table_max(s : GraphflowstablemarriageTable) -> Double { @_common.max(s.data) }

pub fn graph_flow_stable_marriage_table_to_string(s : GraphflowstablemarriageTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_graphn_make(size : Int) -> GraphflowstablemarriageGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_graphn_len(s : GraphflowstablemarriageGraphN) -> Int { s.size }

pub fn graph_flow_stable_marriage_graphn_get(s : GraphflowstablemarriageGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_graphn_set(s : GraphflowstablemarriageGraphN, i : Int, v : Double) -> GraphflowstablemarriageGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_graphn_sum(s : GraphflowstablemarriageGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_flow_stable_marriage_graphn_mean(s : GraphflowstablemarriageGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_flow_stable_marriage_graphn_scale(s : GraphflowstablemarriageGraphN, f : Double) -> GraphflowstablemarriageGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_graphn_add(a : GraphflowstablemarriageGraphN, b : GraphflowstablemarriageGraphN) -> GraphflowstablemarriageGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_stable_marriage_graphn_copy(s : GraphflowstablemarriageGraphN) -> GraphflowstablemarriageGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_graphn_fill(s : GraphflowstablemarriageGraphN, v : Double) -> GraphflowstablemarriageGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_graphn_min(s : GraphflowstablemarriageGraphN) -> Double { @_common.min(s.data) }

pub fn graph_flow_stable_marriage_graphn_max(s : GraphflowstablemarriageGraphN) -> Double { @_common.max(s.data) }

pub fn graph_flow_stable_marriage_graphn_to_string(s : GraphflowstablemarriageGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_node_make(size : Int) -> GraphflowstablemarriageNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_node_len(s : GraphflowstablemarriageNode) -> Int { s.size }

pub fn graph_flow_stable_marriage_node_get(s : GraphflowstablemarriageNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_node_set(s : GraphflowstablemarriageNode, i : Int, v : Double) -> GraphflowstablemarriageNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_node_sum(s : GraphflowstablemarriageNode) -> Double { @_common.sum(s.data) }

pub fn graph_flow_stable_marriage_node_mean(s : GraphflowstablemarriageNode) -> Double { @_common.mean(s.data) }

pub fn graph_flow_stable_marriage_node_scale(s : GraphflowstablemarriageNode, f : Double) -> GraphflowstablemarriageNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_node_add(a : GraphflowstablemarriageNode, b : GraphflowstablemarriageNode) -> GraphflowstablemarriageNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_stable_marriage_node_copy(s : GraphflowstablemarriageNode) -> GraphflowstablemarriageNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_node_fill(s : GraphflowstablemarriageNode, v : Double) -> GraphflowstablemarriageNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_node_min(s : GraphflowstablemarriageNode) -> Double { @_common.min(s.data) }

pub fn graph_flow_stable_marriage_node_max(s : GraphflowstablemarriageNode) -> Double { @_common.max(s.data) }

pub fn graph_flow_stable_marriage_node_to_string(s : GraphflowstablemarriageNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_edge_make(size : Int) -> GraphflowstablemarriageEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_edge_len(s : GraphflowstablemarriageEdge) -> Int { s.size }

pub fn graph_flow_stable_marriage_edge_get(s : GraphflowstablemarriageEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_edge_set(s : GraphflowstablemarriageEdge, i : Int, v : Double) -> GraphflowstablemarriageEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_edge_sum(s : GraphflowstablemarriageEdge) -> Double { @_common.sum(s.data) }

pub fn graph_flow_stable_marriage_edge_mean(s : GraphflowstablemarriageEdge) -> Double { @_common.mean(s.data) }

pub fn graph_flow_stable_marriage_edge_scale(s : GraphflowstablemarriageEdge, f : Double) -> GraphflowstablemarriageEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_edge_add(a : GraphflowstablemarriageEdge, b : GraphflowstablemarriageEdge) -> GraphflowstablemarriageEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_stable_marriage_edge_copy(s : GraphflowstablemarriageEdge) -> GraphflowstablemarriageEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_edge_fill(s : GraphflowstablemarriageEdge, v : Double) -> GraphflowstablemarriageEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_edge_min(s : GraphflowstablemarriageEdge) -> Double { @_common.min(s.data) }

pub fn graph_flow_stable_marriage_edge_max(s : GraphflowstablemarriageEdge) -> Double { @_common.max(s.data) }

pub fn graph_flow_stable_marriage_edge_to_string(s : GraphflowstablemarriageEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriagePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_path_make(size : Int) -> GraphflowstablemarriagePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_path_len(s : GraphflowstablemarriagePath) -> Int { s.size }

pub fn graph_flow_stable_marriage_path_get(s : GraphflowstablemarriagePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_path_set(s : GraphflowstablemarriagePath, i : Int, v : Double) -> GraphflowstablemarriagePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_path_sum(s : GraphflowstablemarriagePath) -> Double { @_common.sum(s.data) }

pub fn graph_flow_stable_marriage_path_mean(s : GraphflowstablemarriagePath) -> Double { @_common.mean(s.data) }

pub fn graph_flow_stable_marriage_path_scale(s : GraphflowstablemarriagePath, f : Double) -> GraphflowstablemarriagePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_path_add(a : GraphflowstablemarriagePath, b : GraphflowstablemarriagePath) -> GraphflowstablemarriagePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_stable_marriage_path_copy(s : GraphflowstablemarriagePath) -> GraphflowstablemarriagePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_path_fill(s : GraphflowstablemarriagePath, v : Double) -> GraphflowstablemarriagePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_path_min(s : GraphflowstablemarriagePath) -> Double { @_common.min(s.data) }

pub fn graph_flow_stable_marriage_path_max(s : GraphflowstablemarriagePath) -> Double { @_common.max(s.data) }

pub fn graph_flow_stable_marriage_path_to_string(s : GraphflowstablemarriagePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_cluster_make(size : Int) -> GraphflowstablemarriageCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_cluster_len(s : GraphflowstablemarriageCluster) -> Int { s.size }

pub fn graph_flow_stable_marriage_cluster_get(s : GraphflowstablemarriageCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_cluster_set(s : GraphflowstablemarriageCluster, i : Int, v : Double) -> GraphflowstablemarriageCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_cluster_sum(s : GraphflowstablemarriageCluster) -> Double { @_common.sum(s.data) }

pub fn graph_flow_stable_marriage_cluster_mean(s : GraphflowstablemarriageCluster) -> Double { @_common.mean(s.data) }

pub fn graph_flow_stable_marriage_cluster_scale(s : GraphflowstablemarriageCluster, f : Double) -> GraphflowstablemarriageCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_cluster_add(a : GraphflowstablemarriageCluster, b : GraphflowstablemarriageCluster) -> GraphflowstablemarriageCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_stable_marriage_cluster_copy(s : GraphflowstablemarriageCluster) -> GraphflowstablemarriageCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_cluster_fill(s : GraphflowstablemarriageCluster, v : Double) -> GraphflowstablemarriageCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_cluster_min(s : GraphflowstablemarriageCluster) -> Double { @_common.min(s.data) }

pub fn graph_flow_stable_marriage_cluster_max(s : GraphflowstablemarriageCluster) -> Double { @_common.max(s.data) }

pub fn graph_flow_stable_marriage_cluster_to_string(s : GraphflowstablemarriageCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_model_make(size : Int) -> GraphflowstablemarriageModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_model_len(s : GraphflowstablemarriageModel) -> Int { s.size }

pub fn graph_flow_stable_marriage_model_get(s : GraphflowstablemarriageModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_model_set(s : GraphflowstablemarriageModel, i : Int, v : Double) -> GraphflowstablemarriageModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_model_sum(s : GraphflowstablemarriageModel) -> Double { @_common.sum(s.data) }

pub fn graph_flow_stable_marriage_model_mean(s : GraphflowstablemarriageModel) -> Double { @_common.mean(s.data) }

pub fn graph_flow_stable_marriage_model_scale(s : GraphflowstablemarriageModel, f : Double) -> GraphflowstablemarriageModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_model_add(a : GraphflowstablemarriageModel, b : GraphflowstablemarriageModel) -> GraphflowstablemarriageModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_stable_marriage_model_copy(s : GraphflowstablemarriageModel) -> GraphflowstablemarriageModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_model_fill(s : GraphflowstablemarriageModel, v : Double) -> GraphflowstablemarriageModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_model_min(s : GraphflowstablemarriageModel) -> Double { @_common.min(s.data) }

pub fn graph_flow_stable_marriage_model_max(s : GraphflowstablemarriageModel) -> Double { @_common.max(s.data) }

pub fn graph_flow_stable_marriage_model_to_string(s : GraphflowstablemarriageModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_layer_make(size : Int) -> GraphflowstablemarriageLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_layer_len(s : GraphflowstablemarriageLayer) -> Int { s.size }

pub fn graph_flow_stable_marriage_layer_get(s : GraphflowstablemarriageLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_layer_set(s : GraphflowstablemarriageLayer, i : Int, v : Double) -> GraphflowstablemarriageLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_layer_sum(s : GraphflowstablemarriageLayer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_stable_marriage_layer_mean(s : GraphflowstablemarriageLayer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_stable_marriage_layer_scale(s : GraphflowstablemarriageLayer, f : Double) -> GraphflowstablemarriageLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_layer_add(a : GraphflowstablemarriageLayer, b : GraphflowstablemarriageLayer) -> GraphflowstablemarriageLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_stable_marriage_layer_copy(s : GraphflowstablemarriageLayer) -> GraphflowstablemarriageLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_layer_fill(s : GraphflowstablemarriageLayer, v : Double) -> GraphflowstablemarriageLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_layer_min(s : GraphflowstablemarriageLayer) -> Double { @_common.min(s.data) }

pub fn graph_flow_stable_marriage_layer_max(s : GraphflowstablemarriageLayer) -> Double { @_common.max(s.data) }

pub fn graph_flow_stable_marriage_layer_to_string(s : GraphflowstablemarriageLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_buffer_make(size : Int) -> GraphflowstablemarriageBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_buffer_len(s : GraphflowstablemarriageBuffer) -> Int { s.size }

pub fn graph_flow_stable_marriage_buffer_get(s : GraphflowstablemarriageBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_buffer_set(s : GraphflowstablemarriageBuffer, i : Int, v : Double) -> GraphflowstablemarriageBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_buffer_sum(s : GraphflowstablemarriageBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_stable_marriage_buffer_mean(s : GraphflowstablemarriageBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_stable_marriage_buffer_scale(s : GraphflowstablemarriageBuffer, f : Double) -> GraphflowstablemarriageBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_buffer_add(a : GraphflowstablemarriageBuffer, b : GraphflowstablemarriageBuffer) -> GraphflowstablemarriageBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_stable_marriage_buffer_copy(s : GraphflowstablemarriageBuffer) -> GraphflowstablemarriageBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_buffer_fill(s : GraphflowstablemarriageBuffer, v : Double) -> GraphflowstablemarriageBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_buffer_min(s : GraphflowstablemarriageBuffer) -> Double { @_common.min(s.data) }

pub fn graph_flow_stable_marriage_buffer_max(s : GraphflowstablemarriageBuffer) -> Double { @_common.max(s.data) }

pub fn graph_flow_stable_marriage_buffer_to_string(s : GraphflowstablemarriageBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_cursor_make(size : Int) -> GraphflowstablemarriageCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_cursor_len(s : GraphflowstablemarriageCursor) -> Int { s.size }

pub fn graph_flow_stable_marriage_cursor_get(s : GraphflowstablemarriageCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_cursor_set(s : GraphflowstablemarriageCursor, i : Int, v : Double) -> GraphflowstablemarriageCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_cursor_sum(s : GraphflowstablemarriageCursor) -> Double { @_common.sum(s.data) }

pub fn graph_flow_stable_marriage_cursor_mean(s : GraphflowstablemarriageCursor) -> Double { @_common.mean(s.data) }

pub fn graph_flow_stable_marriage_cursor_scale(s : GraphflowstablemarriageCursor, f : Double) -> GraphflowstablemarriageCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_cursor_add(a : GraphflowstablemarriageCursor, b : GraphflowstablemarriageCursor) -> GraphflowstablemarriageCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_stable_marriage_cursor_copy(s : GraphflowstablemarriageCursor) -> GraphflowstablemarriageCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_cursor_fill(s : GraphflowstablemarriageCursor, v : Double) -> GraphflowstablemarriageCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_cursor_min(s : GraphflowstablemarriageCursor) -> Double { @_common.min(s.data) }

pub fn graph_flow_stable_marriage_cursor_max(s : GraphflowstablemarriageCursor) -> Double { @_common.max(s.data) }

pub fn graph_flow_stable_marriage_cursor_to_string(s : GraphflowstablemarriageCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_view_make(size : Int) -> GraphflowstablemarriageView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_view_len(s : GraphflowstablemarriageView) -> Int { s.size }

pub fn graph_flow_stable_marriage_view_get(s : GraphflowstablemarriageView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_view_set(s : GraphflowstablemarriageView, i : Int, v : Double) -> GraphflowstablemarriageView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_view_sum(s : GraphflowstablemarriageView) -> Double { @_common.sum(s.data) }

pub fn graph_flow_stable_marriage_view_mean(s : GraphflowstablemarriageView) -> Double { @_common.mean(s.data) }

pub fn graph_flow_stable_marriage_view_scale(s : GraphflowstablemarriageView, f : Double) -> GraphflowstablemarriageView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_view_add(a : GraphflowstablemarriageView, b : GraphflowstablemarriageView) -> GraphflowstablemarriageView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_stable_marriage_view_copy(s : GraphflowstablemarriageView) -> GraphflowstablemarriageView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_view_fill(s : GraphflowstablemarriageView, v : Double) -> GraphflowstablemarriageView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_view_min(s : GraphflowstablemarriageView) -> Double { @_common.min(s.data) }

pub fn graph_flow_stable_marriage_view_max(s : GraphflowstablemarriageView) -> Double { @_common.max(s.data) }

pub fn graph_flow_stable_marriage_view_to_string(s : GraphflowstablemarriageView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_range_make(size : Int) -> GraphflowstablemarriageRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_range_len(s : GraphflowstablemarriageRange) -> Int { s.size }

pub fn graph_flow_stable_marriage_range_get(s : GraphflowstablemarriageRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_range_set(s : GraphflowstablemarriageRange, i : Int, v : Double) -> GraphflowstablemarriageRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_range_sum(s : GraphflowstablemarriageRange) -> Double { @_common.sum(s.data) }

pub fn graph_flow_stable_marriage_range_mean(s : GraphflowstablemarriageRange) -> Double { @_common.mean(s.data) }

pub fn graph_flow_stable_marriage_range_scale(s : GraphflowstablemarriageRange, f : Double) -> GraphflowstablemarriageRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_range_add(a : GraphflowstablemarriageRange, b : GraphflowstablemarriageRange) -> GraphflowstablemarriageRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_stable_marriage_range_copy(s : GraphflowstablemarriageRange) -> GraphflowstablemarriageRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_range_fill(s : GraphflowstablemarriageRange, v : Double) -> GraphflowstablemarriageRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_range_min(s : GraphflowstablemarriageRange) -> Double { @_common.min(s.data) }

pub fn graph_flow_stable_marriage_range_max(s : GraphflowstablemarriageRange) -> Double { @_common.max(s.data) }

pub fn graph_flow_stable_marriage_range_to_string(s : GraphflowstablemarriageRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowstablemarriageSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_stable_marriage_slice_make(size : Int) -> GraphflowstablemarriageSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_stable_marriage_slice_len(s : GraphflowstablemarriageSlice) -> Int { s.size }

pub fn graph_flow_stable_marriage_slice_get(s : GraphflowstablemarriageSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_stable_marriage_slice_set(s : GraphflowstablemarriageSlice, i : Int, v : Double) -> GraphflowstablemarriageSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_slice_sum(s : GraphflowstablemarriageSlice) -> Double { @_common.sum(s.data) }

pub fn graph_flow_stable_marriage_slice_mean(s : GraphflowstablemarriageSlice) -> Double { @_common.mean(s.data) }

pub fn graph_flow_stable_marriage_slice_scale(s : GraphflowstablemarriageSlice, f : Double) -> GraphflowstablemarriageSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_slice_add(a : GraphflowstablemarriageSlice, b : GraphflowstablemarriageSlice) -> GraphflowstablemarriageSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_stable_marriage_slice_copy(s : GraphflowstablemarriageSlice) -> GraphflowstablemarriageSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_slice_fill(s : GraphflowstablemarriageSlice, v : Double) -> GraphflowstablemarriageSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_stable_marriage_slice_min(s : GraphflowstablemarriageSlice) -> Double { @_common.min(s.data) }

pub fn graph_flow_stable_marriage_slice_max(s : GraphflowstablemarriageSlice) -> Double { @_common.max(s.data) }

pub fn graph_flow_stable_marriage_slice_to_string(s : GraphflowstablemarriageSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

