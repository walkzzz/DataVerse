///===
/// extcore/graph_flow_mincut

pub(all) struct GraphflowmincutPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_mincut_make_point(x : Double, y : Double) -> GraphflowmincutPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_mincut_make_point3(x : Double, y : Double, z : Double) -> GraphflowmincutPoint {
  { x, y, z, label: 0 }
}

pub fn GraphflowmincutPoint::x(self : GraphflowmincutPoint) -> Double { self.x }

pub fn GraphflowmincutPoint::y(self : GraphflowmincutPoint) -> Double { self.y }

pub fn GraphflowmincutPoint::z(self : GraphflowmincutPoint) -> Double { self.z }

pub fn GraphflowmincutPoint::label(self : GraphflowmincutPoint) -> Int { self.label }

pub fn GraphflowmincutPoint::dist(self : GraphflowmincutPoint, other : GraphflowmincutPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GraphflowmincutPoint::add(self : GraphflowmincutPoint, other : GraphflowmincutPoint) -> GraphflowmincutPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GraphflowmincutPoint::sub(self : GraphflowmincutPoint, other : GraphflowmincutPoint) -> GraphflowmincutPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GraphflowmincutPoint::scale(self : GraphflowmincutPoint, s : Double) -> GraphflowmincutPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GraphflowmincutPoint::dot(self : GraphflowmincutPoint, other : GraphflowmincutPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GraphflowmincutPoint::cross(self : GraphflowmincutPoint, other : GraphflowmincutPoint) -> GraphflowmincutPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GraphflowmincutPoint::norm(self : GraphflowmincutPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GraphflowmincutPoint::normalize(self : GraphflowmincutPoint) -> GraphflowmincutPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowmincutPoint::negate(self : GraphflowmincutPoint) -> GraphflowmincutPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GraphflowmincutPoint::mid(self : GraphflowmincutPoint, other : GraphflowmincutPoint) -> GraphflowmincutPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GraphflowmincutPoint::lerp(self : GraphflowmincutPoint, other : GraphflowmincutPoint, t : Double) -> GraphflowmincutPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GraphflowmincutPoint::to_string(self : GraphflowmincutPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GraphflowmincutSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_mincut_make_series(vals : Array[Double], name : String) -> GraphflowmincutSeries {
  { vals, name, meta: 0 }
}

pub fn GraphflowmincutSeries::len(self : GraphflowmincutSeries) -> Int { self.vals.length() }

pub fn GraphflowmincutSeries::sum(self : GraphflowmincutSeries) -> Double { @_common.sum(self.vals) }

pub fn GraphflowmincutSeries::mean(self : GraphflowmincutSeries) -> Double { @_common.mean(self.vals) }

pub fn GraphflowmincutSeries::min(self : GraphflowmincutSeries) -> Double { @_common.min(self.vals) }

pub fn GraphflowmincutSeries::max(self : GraphflowmincutSeries) -> Double { @_common.max(self.vals) }

pub fn GraphflowmincutSeries::range(self : GraphflowmincutSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GraphflowmincutSeries::variance(self : GraphflowmincutSeries) -> Double { @_common.variance(self.vals) }

pub fn GraphflowmincutSeries::std(self : GraphflowmincutSeries) -> Double { @_common.std(self.vals) }

pub fn GraphflowmincutSeries::median(self : GraphflowmincutSeries) -> Double { @_common.median(self.vals) }

pub fn GraphflowmincutSeries::scale(self : GraphflowmincutSeries, f : Double) -> GraphflowmincutSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GraphflowmincutSeries::add(self : GraphflowmincutSeries, other : GraphflowmincutSeries) -> GraphflowmincutSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GraphflowmincutSeries::sub(self : GraphflowmincutSeries, other : GraphflowmincutSeries) -> GraphflowmincutSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GraphflowmincutSeries::normalize(self : GraphflowmincutSeries) -> GraphflowmincutSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GraphflowmincutSeries::cumsum(self : GraphflowmincutSeries) -> GraphflowmincutSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GraphflowmincutSeries::to_string(self : GraphflowmincutSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowmincutMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_mincut_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowmincutMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_mincut_matrix_identity(n : Int) -> GraphflowmincutMatrix {
  let m = graph_flow_mincut_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GraphflowmincutMatrix::get(self : GraphflowmincutMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GraphflowmincutMatrix::transpose(self : GraphflowmincutMatrix) -> GraphflowmincutMatrix {
  let result = graph_flow_mincut_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GraphflowmincutMatrix::add(self : GraphflowmincutMatrix, other : GraphflowmincutMatrix) -> GraphflowmincutMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = graph_flow_mincut_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GraphflowmincutMatrix::scale(self : GraphflowmincutMatrix, s : Double) -> GraphflowmincutMatrix {
  let result = graph_flow_mincut_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GraphflowmincutMatrix::multiply(self : GraphflowmincutMatrix, other : GraphflowmincutMatrix) -> GraphflowmincutMatrix {
  if self.cols != other.rows { return graph_flow_mincut_make_matrix(self.rows, other.cols, 0.0) }
  let result = graph_flow_mincut_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GraphflowmincutMatrix::trace(self : GraphflowmincutMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GraphflowmincutMatrix::det(self : GraphflowmincutMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GraphflowmincutMatrix::norm(self : GraphflowmincutMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GraphflowmincutMatrix::to_string(self : GraphflowmincutMatrix) -> String {
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

pub(all) struct GraphflowmincutVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_mincut_make_vector(comps : Array[Double]) -> GraphflowmincutVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_mincut_vector_zero(dim : Int) -> GraphflowmincutVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GraphflowmincutVector::add(self : GraphflowmincutVector, other : GraphflowmincutVector) -> GraphflowmincutVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowmincutVector::sub(self : GraphflowmincutVector, other : GraphflowmincutVector) -> GraphflowmincutVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GraphflowmincutVector::scale(self : GraphflowmincutVector, s : Double) -> GraphflowmincutVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GraphflowmincutVector::dot(self : GraphflowmincutVector, other : GraphflowmincutVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GraphflowmincutVector::norm(self : GraphflowmincutVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GraphflowmincutVector::normalize(self : GraphflowmincutVector) -> GraphflowmincutVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GraphflowmincutVector::dist(self : GraphflowmincutVector, other : GraphflowmincutVector) -> Double {
  self.sub(other).norm()
}

pub fn GraphflowmincutVector::to_string(self : GraphflowmincutVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_mincut_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn graph_flow_mincut_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn graph_flow_mincut_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn graph_flow_mincut_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn graph_flow_mincut_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn graph_flow_mincut_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn graph_flow_mincut_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn graph_flow_mincut_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn graph_flow_mincut_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn graph_flow_mincut_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn graph_flow_mincut_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn graph_flow_mincut_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn graph_flow_mincut_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn graph_flow_mincut_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn graph_flow_mincut_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn graph_flow_mincut_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn graph_flow_mincut_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn graph_flow_mincut_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn graph_flow_mincut_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn graph_flow_mincut_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn graph_flow_mincut_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn graph_flow_mincut_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn graph_flow_mincut_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn graph_flow_mincut_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn graph_flow_mincut_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn graph_flow_mincut_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn graph_flow_mincut_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn graph_flow_mincut_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn graph_flow_mincut_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GraphflowmincutFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_frame_make(size : Int) -> GraphflowmincutFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_frame_len(s : GraphflowmincutFrame) -> Int { s.size }

pub fn graph_flow_mincut_frame_get(s : GraphflowmincutFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_frame_set(s : GraphflowmincutFrame, i : Int, v : Double) -> GraphflowmincutFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_frame_sum(s : GraphflowmincutFrame) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mincut_frame_mean(s : GraphflowmincutFrame) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mincut_frame_scale(s : GraphflowmincutFrame, f : Double) -> GraphflowmincutFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_frame_add(a : GraphflowmincutFrame, b : GraphflowmincutFrame) -> GraphflowmincutFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mincut_frame_copy(s : GraphflowmincutFrame) -> GraphflowmincutFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_frame_fill(s : GraphflowmincutFrame, v : Double) -> GraphflowmincutFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_frame_min(s : GraphflowmincutFrame) -> Double { @_common.min(s.data) }

pub fn graph_flow_mincut_frame_max(s : GraphflowmincutFrame) -> Double { @_common.max(s.data) }

pub fn graph_flow_mincut_frame_to_string(s : GraphflowmincutFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_table_make(size : Int) -> GraphflowmincutTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_table_len(s : GraphflowmincutTable) -> Int { s.size }

pub fn graph_flow_mincut_table_get(s : GraphflowmincutTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_table_set(s : GraphflowmincutTable, i : Int, v : Double) -> GraphflowmincutTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_table_sum(s : GraphflowmincutTable) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mincut_table_mean(s : GraphflowmincutTable) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mincut_table_scale(s : GraphflowmincutTable, f : Double) -> GraphflowmincutTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_table_add(a : GraphflowmincutTable, b : GraphflowmincutTable) -> GraphflowmincutTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mincut_table_copy(s : GraphflowmincutTable) -> GraphflowmincutTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_table_fill(s : GraphflowmincutTable, v : Double) -> GraphflowmincutTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_table_min(s : GraphflowmincutTable) -> Double { @_common.min(s.data) }

pub fn graph_flow_mincut_table_max(s : GraphflowmincutTable) -> Double { @_common.max(s.data) }

pub fn graph_flow_mincut_table_to_string(s : GraphflowmincutTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_graphn_make(size : Int) -> GraphflowmincutGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_graphn_len(s : GraphflowmincutGraphN) -> Int { s.size }

pub fn graph_flow_mincut_graphn_get(s : GraphflowmincutGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_graphn_set(s : GraphflowmincutGraphN, i : Int, v : Double) -> GraphflowmincutGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_graphn_sum(s : GraphflowmincutGraphN) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mincut_graphn_mean(s : GraphflowmincutGraphN) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mincut_graphn_scale(s : GraphflowmincutGraphN, f : Double) -> GraphflowmincutGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_graphn_add(a : GraphflowmincutGraphN, b : GraphflowmincutGraphN) -> GraphflowmincutGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mincut_graphn_copy(s : GraphflowmincutGraphN) -> GraphflowmincutGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_graphn_fill(s : GraphflowmincutGraphN, v : Double) -> GraphflowmincutGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_graphn_min(s : GraphflowmincutGraphN) -> Double { @_common.min(s.data) }

pub fn graph_flow_mincut_graphn_max(s : GraphflowmincutGraphN) -> Double { @_common.max(s.data) }

pub fn graph_flow_mincut_graphn_to_string(s : GraphflowmincutGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_node_make(size : Int) -> GraphflowmincutNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_node_len(s : GraphflowmincutNode) -> Int { s.size }

pub fn graph_flow_mincut_node_get(s : GraphflowmincutNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_node_set(s : GraphflowmincutNode, i : Int, v : Double) -> GraphflowmincutNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_node_sum(s : GraphflowmincutNode) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mincut_node_mean(s : GraphflowmincutNode) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mincut_node_scale(s : GraphflowmincutNode, f : Double) -> GraphflowmincutNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_node_add(a : GraphflowmincutNode, b : GraphflowmincutNode) -> GraphflowmincutNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mincut_node_copy(s : GraphflowmincutNode) -> GraphflowmincutNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_node_fill(s : GraphflowmincutNode, v : Double) -> GraphflowmincutNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_node_min(s : GraphflowmincutNode) -> Double { @_common.min(s.data) }

pub fn graph_flow_mincut_node_max(s : GraphflowmincutNode) -> Double { @_common.max(s.data) }

pub fn graph_flow_mincut_node_to_string(s : GraphflowmincutNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_edge_make(size : Int) -> GraphflowmincutEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_edge_len(s : GraphflowmincutEdge) -> Int { s.size }

pub fn graph_flow_mincut_edge_get(s : GraphflowmincutEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_edge_set(s : GraphflowmincutEdge, i : Int, v : Double) -> GraphflowmincutEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_edge_sum(s : GraphflowmincutEdge) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mincut_edge_mean(s : GraphflowmincutEdge) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mincut_edge_scale(s : GraphflowmincutEdge, f : Double) -> GraphflowmincutEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_edge_add(a : GraphflowmincutEdge, b : GraphflowmincutEdge) -> GraphflowmincutEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mincut_edge_copy(s : GraphflowmincutEdge) -> GraphflowmincutEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_edge_fill(s : GraphflowmincutEdge, v : Double) -> GraphflowmincutEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_edge_min(s : GraphflowmincutEdge) -> Double { @_common.min(s.data) }

pub fn graph_flow_mincut_edge_max(s : GraphflowmincutEdge) -> Double { @_common.max(s.data) }

pub fn graph_flow_mincut_edge_to_string(s : GraphflowmincutEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_path_make(size : Int) -> GraphflowmincutPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_path_len(s : GraphflowmincutPath) -> Int { s.size }

pub fn graph_flow_mincut_path_get(s : GraphflowmincutPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_path_set(s : GraphflowmincutPath, i : Int, v : Double) -> GraphflowmincutPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_path_sum(s : GraphflowmincutPath) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mincut_path_mean(s : GraphflowmincutPath) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mincut_path_scale(s : GraphflowmincutPath, f : Double) -> GraphflowmincutPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_path_add(a : GraphflowmincutPath, b : GraphflowmincutPath) -> GraphflowmincutPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mincut_path_copy(s : GraphflowmincutPath) -> GraphflowmincutPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_path_fill(s : GraphflowmincutPath, v : Double) -> GraphflowmincutPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_path_min(s : GraphflowmincutPath) -> Double { @_common.min(s.data) }

pub fn graph_flow_mincut_path_max(s : GraphflowmincutPath) -> Double { @_common.max(s.data) }

pub fn graph_flow_mincut_path_to_string(s : GraphflowmincutPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_cluster_make(size : Int) -> GraphflowmincutCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_cluster_len(s : GraphflowmincutCluster) -> Int { s.size }

pub fn graph_flow_mincut_cluster_get(s : GraphflowmincutCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_cluster_set(s : GraphflowmincutCluster, i : Int, v : Double) -> GraphflowmincutCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_cluster_sum(s : GraphflowmincutCluster) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mincut_cluster_mean(s : GraphflowmincutCluster) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mincut_cluster_scale(s : GraphflowmincutCluster, f : Double) -> GraphflowmincutCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_cluster_add(a : GraphflowmincutCluster, b : GraphflowmincutCluster) -> GraphflowmincutCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mincut_cluster_copy(s : GraphflowmincutCluster) -> GraphflowmincutCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_cluster_fill(s : GraphflowmincutCluster, v : Double) -> GraphflowmincutCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_cluster_min(s : GraphflowmincutCluster) -> Double { @_common.min(s.data) }

pub fn graph_flow_mincut_cluster_max(s : GraphflowmincutCluster) -> Double { @_common.max(s.data) }

pub fn graph_flow_mincut_cluster_to_string(s : GraphflowmincutCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_model_make(size : Int) -> GraphflowmincutModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_model_len(s : GraphflowmincutModel) -> Int { s.size }

pub fn graph_flow_mincut_model_get(s : GraphflowmincutModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_model_set(s : GraphflowmincutModel, i : Int, v : Double) -> GraphflowmincutModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_model_sum(s : GraphflowmincutModel) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mincut_model_mean(s : GraphflowmincutModel) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mincut_model_scale(s : GraphflowmincutModel, f : Double) -> GraphflowmincutModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_model_add(a : GraphflowmincutModel, b : GraphflowmincutModel) -> GraphflowmincutModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mincut_model_copy(s : GraphflowmincutModel) -> GraphflowmincutModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_model_fill(s : GraphflowmincutModel, v : Double) -> GraphflowmincutModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_model_min(s : GraphflowmincutModel) -> Double { @_common.min(s.data) }

pub fn graph_flow_mincut_model_max(s : GraphflowmincutModel) -> Double { @_common.max(s.data) }

pub fn graph_flow_mincut_model_to_string(s : GraphflowmincutModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_layer_make(size : Int) -> GraphflowmincutLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_layer_len(s : GraphflowmincutLayer) -> Int { s.size }

pub fn graph_flow_mincut_layer_get(s : GraphflowmincutLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_layer_set(s : GraphflowmincutLayer, i : Int, v : Double) -> GraphflowmincutLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_layer_sum(s : GraphflowmincutLayer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mincut_layer_mean(s : GraphflowmincutLayer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mincut_layer_scale(s : GraphflowmincutLayer, f : Double) -> GraphflowmincutLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_layer_add(a : GraphflowmincutLayer, b : GraphflowmincutLayer) -> GraphflowmincutLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mincut_layer_copy(s : GraphflowmincutLayer) -> GraphflowmincutLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_layer_fill(s : GraphflowmincutLayer, v : Double) -> GraphflowmincutLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_layer_min(s : GraphflowmincutLayer) -> Double { @_common.min(s.data) }

pub fn graph_flow_mincut_layer_max(s : GraphflowmincutLayer) -> Double { @_common.max(s.data) }

pub fn graph_flow_mincut_layer_to_string(s : GraphflowmincutLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_buffer_make(size : Int) -> GraphflowmincutBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_buffer_len(s : GraphflowmincutBuffer) -> Int { s.size }

pub fn graph_flow_mincut_buffer_get(s : GraphflowmincutBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_buffer_set(s : GraphflowmincutBuffer, i : Int, v : Double) -> GraphflowmincutBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_buffer_sum(s : GraphflowmincutBuffer) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mincut_buffer_mean(s : GraphflowmincutBuffer) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mincut_buffer_scale(s : GraphflowmincutBuffer, f : Double) -> GraphflowmincutBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_buffer_add(a : GraphflowmincutBuffer, b : GraphflowmincutBuffer) -> GraphflowmincutBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mincut_buffer_copy(s : GraphflowmincutBuffer) -> GraphflowmincutBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_buffer_fill(s : GraphflowmincutBuffer, v : Double) -> GraphflowmincutBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_buffer_min(s : GraphflowmincutBuffer) -> Double { @_common.min(s.data) }

pub fn graph_flow_mincut_buffer_max(s : GraphflowmincutBuffer) -> Double { @_common.max(s.data) }

pub fn graph_flow_mincut_buffer_to_string(s : GraphflowmincutBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_cursor_make(size : Int) -> GraphflowmincutCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_cursor_len(s : GraphflowmincutCursor) -> Int { s.size }

pub fn graph_flow_mincut_cursor_get(s : GraphflowmincutCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_cursor_set(s : GraphflowmincutCursor, i : Int, v : Double) -> GraphflowmincutCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_cursor_sum(s : GraphflowmincutCursor) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mincut_cursor_mean(s : GraphflowmincutCursor) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mincut_cursor_scale(s : GraphflowmincutCursor, f : Double) -> GraphflowmincutCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_cursor_add(a : GraphflowmincutCursor, b : GraphflowmincutCursor) -> GraphflowmincutCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mincut_cursor_copy(s : GraphflowmincutCursor) -> GraphflowmincutCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_cursor_fill(s : GraphflowmincutCursor, v : Double) -> GraphflowmincutCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_cursor_min(s : GraphflowmincutCursor) -> Double { @_common.min(s.data) }

pub fn graph_flow_mincut_cursor_max(s : GraphflowmincutCursor) -> Double { @_common.max(s.data) }

pub fn graph_flow_mincut_cursor_to_string(s : GraphflowmincutCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_view_make(size : Int) -> GraphflowmincutView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_view_len(s : GraphflowmincutView) -> Int { s.size }

pub fn graph_flow_mincut_view_get(s : GraphflowmincutView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_view_set(s : GraphflowmincutView, i : Int, v : Double) -> GraphflowmincutView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_view_sum(s : GraphflowmincutView) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mincut_view_mean(s : GraphflowmincutView) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mincut_view_scale(s : GraphflowmincutView, f : Double) -> GraphflowmincutView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_view_add(a : GraphflowmincutView, b : GraphflowmincutView) -> GraphflowmincutView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mincut_view_copy(s : GraphflowmincutView) -> GraphflowmincutView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_view_fill(s : GraphflowmincutView, v : Double) -> GraphflowmincutView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_view_min(s : GraphflowmincutView) -> Double { @_common.min(s.data) }

pub fn graph_flow_mincut_view_max(s : GraphflowmincutView) -> Double { @_common.max(s.data) }

pub fn graph_flow_mincut_view_to_string(s : GraphflowmincutView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_range_make(size : Int) -> GraphflowmincutRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_range_len(s : GraphflowmincutRange) -> Int { s.size }

pub fn graph_flow_mincut_range_get(s : GraphflowmincutRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_range_set(s : GraphflowmincutRange, i : Int, v : Double) -> GraphflowmincutRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_range_sum(s : GraphflowmincutRange) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mincut_range_mean(s : GraphflowmincutRange) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mincut_range_scale(s : GraphflowmincutRange, f : Double) -> GraphflowmincutRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_range_add(a : GraphflowmincutRange, b : GraphflowmincutRange) -> GraphflowmincutRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mincut_range_copy(s : GraphflowmincutRange) -> GraphflowmincutRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_range_fill(s : GraphflowmincutRange, v : Double) -> GraphflowmincutRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_range_min(s : GraphflowmincutRange) -> Double { @_common.min(s.data) }

pub fn graph_flow_mincut_range_max(s : GraphflowmincutRange) -> Double { @_common.max(s.data) }

pub fn graph_flow_mincut_range_to_string(s : GraphflowmincutRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_slice_make(size : Int) -> GraphflowmincutSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_mincut_slice_len(s : GraphflowmincutSlice) -> Int { s.size }

pub fn graph_flow_mincut_slice_get(s : GraphflowmincutSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_mincut_slice_set(s : GraphflowmincutSlice, i : Int, v : Double) -> GraphflowmincutSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_slice_sum(s : GraphflowmincutSlice) -> Double { @_common.sum(s.data) }

pub fn graph_flow_mincut_slice_mean(s : GraphflowmincutSlice) -> Double { @_common.mean(s.data) }

pub fn graph_flow_mincut_slice_scale(s : GraphflowmincutSlice, f : Double) -> GraphflowmincutSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_slice_add(a : GraphflowmincutSlice, b : GraphflowmincutSlice) -> GraphflowmincutSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn graph_flow_mincut_slice_copy(s : GraphflowmincutSlice) -> GraphflowmincutSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_slice_fill(s : GraphflowmincutSlice, v : Double) -> GraphflowmincutSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn graph_flow_mincut_slice_min(s : GraphflowmincutSlice) -> Double { @_common.min(s.data) }

pub fn graph_flow_mincut_slice_max(s : GraphflowmincutSlice) -> Double { @_common.max(s.data) }

pub fn graph_flow_mincut_slice_to_string(s : GraphflowmincutSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

