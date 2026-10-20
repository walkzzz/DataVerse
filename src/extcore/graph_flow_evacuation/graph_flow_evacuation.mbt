///===
/// extcore/graph_flow_evacuation

pub(all) struct GraphflowevacuationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_evacuation_make_point(x : Double, y : Double) -> GraphflowevacuationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_evacuation_make_point3(x : Double, y : Double, z : Double) -> GraphflowevacuationPoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowevacuationPoint::x(self : GraphflowevacuationPoint) -> Double { self.x }

pub fn GraphflowevacuationPoint::y(self : GraphflowevacuationPoint) -> Double { self.y }

pub fn GraphflowevacuationPoint::z(self : GraphflowevacuationPoint) -> Double { self.z }

pub fn GraphflowevacuationPoint::label(self : GraphflowevacuationPoint) -> Int { self.label }

pub fn GraphflowevacuationPoint::dist(self : GraphflowevacuationPoint, other : GraphflowevacuationPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowevacuationPoint::add(self : GraphflowevacuationPoint, other : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowevacuationPoint::sub(self : GraphflowevacuationPoint, other : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowevacuationPoint::scale(self : GraphflowevacuationPoint, s : Double) -> GraphflowevacuationPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowevacuationPoint::dot(self : GraphflowevacuationPoint, other : GraphflowevacuationPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowevacuationPoint::cross(self : GraphflowevacuationPoint, other : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowevacuationPoint::norm(self : GraphflowevacuationPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowevacuationPoint::normalize(self : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowevacuationPoint::negate(self : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowevacuationPoint::mid(self : GraphflowevacuationPoint, other : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowevacuationPoint::lerp(self : GraphflowevacuationPoint, other : GraphflowevacuationPoint, t : Double) -> GraphflowevacuationPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowevacuationPoint::to_string(self : GraphflowevacuationPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowevacuationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_evacuation_make_series(vals : Array[Double], name : String) -> GraphflowevacuationSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowevacuationSeries::len(self : GraphflowevacuationSeries) -> Int { self.vals.length() }

pub fn GraphflowevacuationSeries::sum(self : GraphflowevacuationSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowevacuationSeries::mean(self : GraphflowevacuationSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowevacuationSeries::min(self : GraphflowevacuationSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowevacuationSeries::max(self : GraphflowevacuationSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowevacuationSeries::range(self : GraphflowevacuationSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowevacuationSeries::variance(self : GraphflowevacuationSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowevacuationSeries::std(self : GraphflowevacuationSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowevacuationSeries::median(self : GraphflowevacuationSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowevacuationSeries::scale(self : GraphflowevacuationSeries, f : Double) -> GraphflowevacuationSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowevacuationSeries::add(self : GraphflowevacuationSeries, other : GraphflowevacuationSeries) -> GraphflowevacuationSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowevacuationSeries::sub(self : GraphflowevacuationSeries, other : GraphflowevacuationSeries) -> GraphflowevacuationSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowevacuationSeries::normalize(self : GraphflowevacuationSeries) -> GraphflowevacuationSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowevacuationSeries::cumsum(self : GraphflowevacuationSeries) -> GraphflowevacuationSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowevacuationSeries::to_string(self : GraphflowevacuationSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowevacuationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_evacuation_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowevacuationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_evacuation_matrix_identity(n : Int) -> GraphflowevacuationMatrix {
  let m = graph_flow_evacuation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowevacuationMatrix::get(self : GraphflowevacuationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowevacuationMatrix::transpose(self : GraphflowevacuationMatrix) -> GraphflowevacuationMatrix {
  let result = graph_flow_evacuation_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowevacuationMatrix::add(self : GraphflowevacuationMatrix, other : GraphflowevacuationMatrix) -> GraphflowevacuationMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_evacuation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowevacuationMatrix::scale(self : GraphflowevacuationMatrix, s : Double) -> GraphflowevacuationMatrix {
  let result = graph_flow_evacuation_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowevacuationMatrix::multiply(self : GraphflowevacuationMatrix, other : GraphflowevacuationMatrix) -> GraphflowevacuationMatrix {
  if self.cols != other.rows { return graph_flow_evacuation_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_evacuation_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphflowevacuationMatrix::trace(self : GraphflowevacuationMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowevacuationMatrix::det(self : GraphflowevacuationMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowevacuationMatrix::norm(self : GraphflowevacuationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowevacuationMatrix::to_string(self : GraphflowevacuationMatrix) -> String {
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

pub(all) struct GraphflowevacuationVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_evacuation_make_vector(comps : Array[Double]) -> GraphflowevacuationVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_evacuation_vector_zero(dim : Int) -> GraphflowevacuationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowevacuationVector::add(self : GraphflowevacuationVector, other : GraphflowevacuationVector) -> GraphflowevacuationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowevacuationVector::sub(self : GraphflowevacuationVector, other : GraphflowevacuationVector) -> GraphflowevacuationVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowevacuationVector::scale(self : GraphflowevacuationVector, s : Double) -> GraphflowevacuationVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowevacuationVector::dot(self : GraphflowevacuationVector, other : GraphflowevacuationVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowevacuationVector::norm(self : GraphflowevacuationVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowevacuationVector::normalize(self : GraphflowevacuationVector) -> GraphflowevacuationVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowevacuationVector::dist(self : GraphflowevacuationVector, other : GraphflowevacuationVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowevacuationVector::to_string(self : GraphflowevacuationVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_evacuation_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_evacuation_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_evacuation_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_evacuation_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_evacuation_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_evacuation_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_evacuation_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_evacuation_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_evacuation_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_evacuation_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_evacuation_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_evacuation_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_evacuation_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_evacuation_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_evacuation_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_evacuation_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_evacuation_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_evacuation_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_evacuation_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_evacuation_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_evacuation_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_evacuation_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_evacuation_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_evacuation_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_evacuation_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_evacuation_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_evacuation_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_evacuation_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_evacuation_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowevacuationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_frame_make(size : Int) -> GraphflowevacuationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_frame_len(s : GraphflowevacuationFrame) -> Int { s.size }

pub fn graph_flow_evacuation_frame_get(s : GraphflowevacuationFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_frame_set(s : GraphflowevacuationFrame, i : Int, v : Double) -> GraphflowevacuationFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_frame_sum(s : GraphflowevacuationFrame) -> Double { @_common.sum(s.data) }

pub fn graph_flow_evacuation_frame_mean(s : GraphflowevacuationFrame) -> Double { @_common.mean(s.data) }

pub fn graph_flow_evacuation_frame_scale(s : GraphflowevacuationFrame, f : Double) -> GraphflowevacuationFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_frame_add(a : GraphflowevacuationFrame, b : GraphflowevacuationFrame) -> GraphflowevacuationFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_evacuation_frame_copy(s : GraphflowevacuationFrame) -> GraphflowevacuationFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_frame_fill(s : GraphflowevacuationFrame, v : Double) -> GraphflowevacuationFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_frame_min(s : GraphflowevacuationFrame) -> Double { @_common.min(s.data) }

pub fn graph_flow_evacuation_frame_max(s : GraphflowevacuationFrame) -> Double { @_common.max(s.data) }

pub fn graph_flow_evacuation_frame_to_string(s : GraphflowevacuationFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_table_make(size : Int) -> GraphflowevacuationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_table_len(s : GraphflowevacuationTable) -> Int { s.size }

pub fn graph_flow_evacuation_table_get(s : GraphflowevacuationTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_table_set(s : GraphflowevacuationTable, i : Int, v : Double) -> GraphflowevacuationTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_table_sum(s : GraphflowevacuationTable) -> Double { @_common.sum(s.data) }

pub fn graph_flow_evacuation_table_mean(s : GraphflowevacuationTable) -> Double { @_common.mean(s.data) }

pub fn graph_flow_evacuation_table_scale(s : GraphflowevacuationTable, f : Double) -> GraphflowevacuationTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_table_add(a : GraphflowevacuationTable, b : GraphflowevacuationTable) -> GraphflowevacuationTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_evacuation_table_copy(s : GraphflowevacuationTable) -> GraphflowevacuationTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_table_fill(s : GraphflowevacuationTable, v : Double) -> GraphflowevacuationTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_table_min(s : GraphflowevacuationTable) -> Double { @_common.min(s.data) }

pub fn graph_flow_evacuation_table_max(s : GraphflowevacuationTable) -> Double { @_common.max(s.data) }

pub fn graph_flow_evacuation_table_to_string(s : GraphflowevacuationTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_graphn_make(size : Int) -> GraphflowevacuationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_graphn_len(s : GraphflowevacuationGraphN) -> Int { s.size }

pub fn graph_flow_evacuation_graphn_get(s : GraphflowevacuationGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_graphn_set(s : GraphflowevacuationGraphN, i : Int, v : Double) -> GraphflowevacuationGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_graphn_sum(s : GraphflowevacuationGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_flow_evacuation_graphn_mean(s : GraphflowevacuationGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_flow_evacuation_graphn_scale(s : GraphflowevacuationGraphN, f : Double) -> GraphflowevacuationGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_graphn_add(a : GraphflowevacuationGraphN, b : GraphflowevacuationGraphN) -> GraphflowevacuationGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_evacuation_graphn_copy(s : GraphflowevacuationGraphN) -> GraphflowevacuationGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_graphn_fill(s : GraphflowevacuationGraphN, v : Double) -> GraphflowevacuationGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_graphn_min(s : GraphflowevacuationGraphN) -> Double { @_common.min(s.data) }

pub fn graph_flow_evacuation_graphn_max(s : GraphflowevacuationGraphN) -> Double { @_common.max(s.data) }

pub fn graph_flow_evacuation_graphn_to_string(s : GraphflowevacuationGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_node_make(size : Int) -> GraphflowevacuationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_node_len(s : GraphflowevacuationNode) -> Int { s.size }

pub fn graph_flow_evacuation_node_get(s : GraphflowevacuationNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_node_set(s : GraphflowevacuationNode, i : Int, v : Double) -> GraphflowevacuationNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_node_sum(s : GraphflowevacuationNode) -> Double { @_common.sum(s.data) }

pub fn graph_flow_evacuation_node_mean(s : GraphflowevacuationNode) -> Double { @_common.mean(s.data) }

pub fn graph_flow_evacuation_node_scale(s : GraphflowevacuationNode, f : Double) -> GraphflowevacuationNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_node_add(a : GraphflowevacuationNode, b : GraphflowevacuationNode) -> GraphflowevacuationNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_evacuation_node_copy(s : GraphflowevacuationNode) -> GraphflowevacuationNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_node_fill(s : GraphflowevacuationNode, v : Double) -> GraphflowevacuationNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_node_min(s : GraphflowevacuationNode) -> Double { @_common.min(s.data) }

pub fn graph_flow_evacuation_node_max(s : GraphflowevacuationNode) -> Double { @_common.max(s.data) }

pub fn graph_flow_evacuation_node_to_string(s : GraphflowevacuationNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_edge_make(size : Int) -> GraphflowevacuationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_edge_len(s : GraphflowevacuationEdge) -> Int { s.size }

pub fn graph_flow_evacuation_edge_get(s : GraphflowevacuationEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_edge_set(s : GraphflowevacuationEdge, i : Int, v : Double) -> GraphflowevacuationEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_edge_sum(s : GraphflowevacuationEdge) -> Double { @_common.sum(s.data) }

pub fn graph_flow_evacuation_edge_mean(s : GraphflowevacuationEdge) -> Double { @_common.mean(s.data) }

pub fn graph_flow_evacuation_edge_scale(s : GraphflowevacuationEdge, f : Double) -> GraphflowevacuationEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_edge_add(a : GraphflowevacuationEdge, b : GraphflowevacuationEdge) -> GraphflowevacuationEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_evacuation_edge_copy(s : GraphflowevacuationEdge) -> GraphflowevacuationEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_edge_fill(s : GraphflowevacuationEdge, v : Double) -> GraphflowevacuationEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_edge_min(s : GraphflowevacuationEdge) -> Double { @_common.min(s.data) }

pub fn graph_flow_evacuation_edge_max(s : GraphflowevacuationEdge) -> Double { @_common.max(s.data) }

pub fn graph_flow_evacuation_edge_to_string(s : GraphflowevacuationEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_path_make(size : Int) -> GraphflowevacuationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_path_len(s : GraphflowevacuationPath) -> Int { s.size }

pub fn graph_flow_evacuation_path_get(s : GraphflowevacuationPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_path_set(s : GraphflowevacuationPath, i : Int, v : Double) -> GraphflowevacuationPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_path_sum(s : GraphflowevacuationPath) -> Double { @_common.sum(s.data) }

pub fn graph_flow_evacuation_path_mean(s : GraphflowevacuationPath) -> Double { @_common.mean(s.data) }

pub fn graph_flow_evacuation_path_scale(s : GraphflowevacuationPath, f : Double) -> GraphflowevacuationPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_path_add(a : GraphflowevacuationPath, b : GraphflowevacuationPath) -> GraphflowevacuationPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_evacuation_path_copy(s : GraphflowevacuationPath) -> GraphflowevacuationPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_path_fill(s : GraphflowevacuationPath, v : Double) -> GraphflowevacuationPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_path_min(s : GraphflowevacuationPath) -> Double { @_common.min(s.data) }

pub fn graph_flow_evacuation_path_max(s : GraphflowevacuationPath) -> Double { @_common.max(s.data) }

pub fn graph_flow_evacuation_path_to_string(s : GraphflowevacuationPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_cluster_make(size : Int) -> GraphflowevacuationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_cluster_len(s : GraphflowevacuationCluster) -> Int { s.size }

pub fn graph_flow_evacuation_cluster_get(s : GraphflowevacuationCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_cluster_set(s : GraphflowevacuationCluster, i : Int, v : Double) -> GraphflowevacuationCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_cluster_sum(s : GraphflowevacuationCluster) -> Double { @_common.sum(s.data) }

pub fn graph_flow_evacuation_cluster_mean(s : GraphflowevacuationCluster) -> Double { @_common.mean(s.data) }

pub fn graph_flow_evacuation_cluster_scale(s : GraphflowevacuationCluster, f : Double) -> GraphflowevacuationCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_cluster_add(a : GraphflowevacuationCluster, b : GraphflowevacuationCluster) -> GraphflowevacuationCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_evacuation_cluster_copy(s : GraphflowevacuationCluster) -> GraphflowevacuationCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_cluster_fill(s : GraphflowevacuationCluster, v : Double) -> GraphflowevacuationCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_cluster_min(s : GraphflowevacuationCluster) -> Double { @_common.min(s.data) }

pub fn graph_flow_evacuation_cluster_max(s : GraphflowevacuationCluster) -> Double { @_common.max(s.data) }

pub fn graph_flow_evacuation_cluster_to_string(s : GraphflowevacuationCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_model_make(size : Int) -> GraphflowevacuationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_model_len(s : GraphflowevacuationModel) -> Int { s.size }

pub fn graph_flow_evacuation_model_get(s : GraphflowevacuationModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_model_set(s : GraphflowevacuationModel, i : Int, v : Double) -> GraphflowevacuationModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_model_sum(s : GraphflowevacuationModel) -> Double { @_common.sum(s.data) }

pub fn graph_flow_evacuation_model_mean(s : GraphflowevacuationModel) -> Double { @_common.mean(s.data) }

pub fn graph_flow_evacuation_model_scale(s : GraphflowevacuationModel, f : Double) -> GraphflowevacuationModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_model_add(a : GraphflowevacuationModel, b : GraphflowevacuationModel) -> GraphflowevacuationModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_evacuation_model_copy(s : GraphflowevacuationModel) -> GraphflowevacuationModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_model_fill(s : GraphflowevacuationModel, v : Double) -> GraphflowevacuationModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_model_min(s : GraphflowevacuationModel) -> Double { @_common.min(s.data) }

pub fn graph_flow_evacuation_model_max(s : GraphflowevacuationModel) -> Double { @_common.max(s.data) }

pub fn graph_flow_evacuation_model_to_string(s : GraphflowevacuationModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_layer_make(size : Int) -> GraphflowevacuationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_layer_len(s : GraphflowevacuationLayer) -> Int { s.size }

pub fn graph_flow_evacuation_layer_get(s : GraphflowevacuationLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_layer_set(s : GraphflowevacuationLayer, i : Int, v : Double) -> GraphflowevacuationLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_layer_sum(s : GraphflowevacuationLayer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_evacuation_layer_mean(s : GraphflowevacuationLayer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_evacuation_layer_scale(s : GraphflowevacuationLayer, f : Double) -> GraphflowevacuationLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_layer_add(a : GraphflowevacuationLayer, b : GraphflowevacuationLayer) -> GraphflowevacuationLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_evacuation_layer_copy(s : GraphflowevacuationLayer) -> GraphflowevacuationLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_layer_fill(s : GraphflowevacuationLayer, v : Double) -> GraphflowevacuationLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_layer_min(s : GraphflowevacuationLayer) -> Double { @_common.min(s.data) }

pub fn graph_flow_evacuation_layer_max(s : GraphflowevacuationLayer) -> Double { @_common.max(s.data) }

pub fn graph_flow_evacuation_layer_to_string(s : GraphflowevacuationLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_buffer_make(size : Int) -> GraphflowevacuationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_buffer_len(s : GraphflowevacuationBuffer) -> Int { s.size }

pub fn graph_flow_evacuation_buffer_get(s : GraphflowevacuationBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_buffer_set(s : GraphflowevacuationBuffer, i : Int, v : Double) -> GraphflowevacuationBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_buffer_sum(s : GraphflowevacuationBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_evacuation_buffer_mean(s : GraphflowevacuationBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_evacuation_buffer_scale(s : GraphflowevacuationBuffer, f : Double) -> GraphflowevacuationBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_buffer_add(a : GraphflowevacuationBuffer, b : GraphflowevacuationBuffer) -> GraphflowevacuationBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_evacuation_buffer_copy(s : GraphflowevacuationBuffer) -> GraphflowevacuationBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_buffer_fill(s : GraphflowevacuationBuffer, v : Double) -> GraphflowevacuationBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_buffer_min(s : GraphflowevacuationBuffer) -> Double { @_common.min(s.data) }

pub fn graph_flow_evacuation_buffer_max(s : GraphflowevacuationBuffer) -> Double { @_common.max(s.data) }

pub fn graph_flow_evacuation_buffer_to_string(s : GraphflowevacuationBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_cursor_make(size : Int) -> GraphflowevacuationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_cursor_len(s : GraphflowevacuationCursor) -> Int { s.size }

pub fn graph_flow_evacuation_cursor_get(s : GraphflowevacuationCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_cursor_set(s : GraphflowevacuationCursor, i : Int, v : Double) -> GraphflowevacuationCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_cursor_sum(s : GraphflowevacuationCursor) -> Double { @_common.sum(s.data) }

pub fn graph_flow_evacuation_cursor_mean(s : GraphflowevacuationCursor) -> Double { @_common.mean(s.data) }

pub fn graph_flow_evacuation_cursor_scale(s : GraphflowevacuationCursor, f : Double) -> GraphflowevacuationCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_cursor_add(a : GraphflowevacuationCursor, b : GraphflowevacuationCursor) -> GraphflowevacuationCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_evacuation_cursor_copy(s : GraphflowevacuationCursor) -> GraphflowevacuationCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_cursor_fill(s : GraphflowevacuationCursor, v : Double) -> GraphflowevacuationCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_cursor_min(s : GraphflowevacuationCursor) -> Double { @_common.min(s.data) }

pub fn graph_flow_evacuation_cursor_max(s : GraphflowevacuationCursor) -> Double { @_common.max(s.data) }

pub fn graph_flow_evacuation_cursor_to_string(s : GraphflowevacuationCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_view_make(size : Int) -> GraphflowevacuationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_view_len(s : GraphflowevacuationView) -> Int { s.size }

pub fn graph_flow_evacuation_view_get(s : GraphflowevacuationView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_view_set(s : GraphflowevacuationView, i : Int, v : Double) -> GraphflowevacuationView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_view_sum(s : GraphflowevacuationView) -> Double { @_common.sum(s.data) }

pub fn graph_flow_evacuation_view_mean(s : GraphflowevacuationView) -> Double { @_common.mean(s.data) }

pub fn graph_flow_evacuation_view_scale(s : GraphflowevacuationView, f : Double) -> GraphflowevacuationView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_view_add(a : GraphflowevacuationView, b : GraphflowevacuationView) -> GraphflowevacuationView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_evacuation_view_copy(s : GraphflowevacuationView) -> GraphflowevacuationView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_view_fill(s : GraphflowevacuationView, v : Double) -> GraphflowevacuationView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_view_min(s : GraphflowevacuationView) -> Double { @_common.min(s.data) }

pub fn graph_flow_evacuation_view_max(s : GraphflowevacuationView) -> Double { @_common.max(s.data) }

pub fn graph_flow_evacuation_view_to_string(s : GraphflowevacuationView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_range_make(size : Int) -> GraphflowevacuationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_range_len(s : GraphflowevacuationRange) -> Int { s.size }

pub fn graph_flow_evacuation_range_get(s : GraphflowevacuationRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_range_set(s : GraphflowevacuationRange, i : Int, v : Double) -> GraphflowevacuationRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_range_sum(s : GraphflowevacuationRange) -> Double { @_common.sum(s.data) }

pub fn graph_flow_evacuation_range_mean(s : GraphflowevacuationRange) -> Double { @_common.mean(s.data) }

pub fn graph_flow_evacuation_range_scale(s : GraphflowevacuationRange, f : Double) -> GraphflowevacuationRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_range_add(a : GraphflowevacuationRange, b : GraphflowevacuationRange) -> GraphflowevacuationRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_evacuation_range_copy(s : GraphflowevacuationRange) -> GraphflowevacuationRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_range_fill(s : GraphflowevacuationRange, v : Double) -> GraphflowevacuationRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_range_min(s : GraphflowevacuationRange) -> Double { @_common.min(s.data) }

pub fn graph_flow_evacuation_range_max(s : GraphflowevacuationRange) -> Double { @_common.max(s.data) }

pub fn graph_flow_evacuation_range_to_string(s : GraphflowevacuationRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_slice_make(size : Int) -> GraphflowevacuationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_slice_len(s : GraphflowevacuationSlice) -> Int { s.size }

pub fn graph_flow_evacuation_slice_get(s : GraphflowevacuationSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_slice_set(s : GraphflowevacuationSlice, i : Int, v : Double) -> GraphflowevacuationSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_slice_sum(s : GraphflowevacuationSlice) -> Double { @_common.sum(s.data) }

pub fn graph_flow_evacuation_slice_mean(s : GraphflowevacuationSlice) -> Double { @_common.mean(s.data) }

pub fn graph_flow_evacuation_slice_scale(s : GraphflowevacuationSlice, f : Double) -> GraphflowevacuationSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_slice_add(a : GraphflowevacuationSlice, b : GraphflowevacuationSlice) -> GraphflowevacuationSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_evacuation_slice_copy(s : GraphflowevacuationSlice) -> GraphflowevacuationSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_slice_fill(s : GraphflowevacuationSlice, v : Double) -> GraphflowevacuationSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_evacuation_slice_min(s : GraphflowevacuationSlice) -> Double { @_common.min(s.data) }

pub fn graph_flow_evacuation_slice_max(s : GraphflowevacuationSlice) -> Double { @_common.max(s.data) }

pub fn graph_flow_evacuation_slice_to_string(s : GraphflowevacuationSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

