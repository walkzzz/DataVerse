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

pub fn GraphflowmincutFrame::len(self : GraphflowmincutFrame) -> Int { self.size }

pub fn GraphflowmincutFrame::get(self : GraphflowmincutFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmincutFrame::set(self : GraphflowmincutFrame, i : Int, v : Double) -> GraphflowmincutFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmincutFrame::sum(self : GraphflowmincutFrame) -> Double { @_common.sum(self.data) }

pub fn GraphflowmincutFrame::mean(self : GraphflowmincutFrame) -> Double { @_common.mean(self.data) }

pub fn GraphflowmincutFrame::scale(self : GraphflowmincutFrame, f : Double) -> GraphflowmincutFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutFrame::add(self : GraphflowmincutFrame, other : GraphflowmincutFrame) -> GraphflowmincutFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmincutFrame::copy(self : GraphflowmincutFrame) -> GraphflowmincutFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutFrame::fill(self : GraphflowmincutFrame, v : Double) -> GraphflowmincutFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutFrame::min(self : GraphflowmincutFrame) -> Double { @_common.min(self.data) }

pub fn GraphflowmincutFrame::max(self : GraphflowmincutFrame) -> Double { @_common.max(self.data) }

pub fn GraphflowmincutFrame::to_string(self : GraphflowmincutFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_table_make(size : Int) -> GraphflowmincutTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmincutTable::len(self : GraphflowmincutTable) -> Int { self.size }

pub fn GraphflowmincutTable::get(self : GraphflowmincutTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmincutTable::set(self : GraphflowmincutTable, i : Int, v : Double) -> GraphflowmincutTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmincutTable::sum(self : GraphflowmincutTable) -> Double { @_common.sum(self.data) }

pub fn GraphflowmincutTable::mean(self : GraphflowmincutTable) -> Double { @_common.mean(self.data) }

pub fn GraphflowmincutTable::scale(self : GraphflowmincutTable, f : Double) -> GraphflowmincutTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutTable::add(self : GraphflowmincutTable, other : GraphflowmincutTable) -> GraphflowmincutTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmincutTable::copy(self : GraphflowmincutTable) -> GraphflowmincutTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutTable::fill(self : GraphflowmincutTable, v : Double) -> GraphflowmincutTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutTable::min(self : GraphflowmincutTable) -> Double { @_common.min(self.data) }

pub fn GraphflowmincutTable::max(self : GraphflowmincutTable) -> Double { @_common.max(self.data) }

pub fn GraphflowmincutTable::to_string(self : GraphflowmincutTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_graphn_make(size : Int) -> GraphflowmincutGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmincutGraphN::len(self : GraphflowmincutGraphN) -> Int { self.size }

pub fn GraphflowmincutGraphN::get(self : GraphflowmincutGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmincutGraphN::set(self : GraphflowmincutGraphN, i : Int, v : Double) -> GraphflowmincutGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmincutGraphN::sum(self : GraphflowmincutGraphN) -> Double { @_common.sum(self.data) }

pub fn GraphflowmincutGraphN::mean(self : GraphflowmincutGraphN) -> Double { @_common.mean(self.data) }

pub fn GraphflowmincutGraphN::scale(self : GraphflowmincutGraphN, f : Double) -> GraphflowmincutGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutGraphN::add(self : GraphflowmincutGraphN, other : GraphflowmincutGraphN) -> GraphflowmincutGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmincutGraphN::copy(self : GraphflowmincutGraphN) -> GraphflowmincutGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutGraphN::fill(self : GraphflowmincutGraphN, v : Double) -> GraphflowmincutGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutGraphN::min(self : GraphflowmincutGraphN) -> Double { @_common.min(self.data) }

pub fn GraphflowmincutGraphN::max(self : GraphflowmincutGraphN) -> Double { @_common.max(self.data) }

pub fn GraphflowmincutGraphN::to_string(self : GraphflowmincutGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_node_make(size : Int) -> GraphflowmincutNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmincutNode::len(self : GraphflowmincutNode) -> Int { self.size }

pub fn GraphflowmincutNode::get(self : GraphflowmincutNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmincutNode::set(self : GraphflowmincutNode, i : Int, v : Double) -> GraphflowmincutNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmincutNode::sum(self : GraphflowmincutNode) -> Double { @_common.sum(self.data) }

pub fn GraphflowmincutNode::mean(self : GraphflowmincutNode) -> Double { @_common.mean(self.data) }

pub fn GraphflowmincutNode::scale(self : GraphflowmincutNode, f : Double) -> GraphflowmincutNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutNode::add(self : GraphflowmincutNode, other : GraphflowmincutNode) -> GraphflowmincutNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmincutNode::copy(self : GraphflowmincutNode) -> GraphflowmincutNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutNode::fill(self : GraphflowmincutNode, v : Double) -> GraphflowmincutNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutNode::min(self : GraphflowmincutNode) -> Double { @_common.min(self.data) }

pub fn GraphflowmincutNode::max(self : GraphflowmincutNode) -> Double { @_common.max(self.data) }

pub fn GraphflowmincutNode::to_string(self : GraphflowmincutNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_edge_make(size : Int) -> GraphflowmincutEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmincutEdge::len(self : GraphflowmincutEdge) -> Int { self.size }

pub fn GraphflowmincutEdge::get(self : GraphflowmincutEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmincutEdge::set(self : GraphflowmincutEdge, i : Int, v : Double) -> GraphflowmincutEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmincutEdge::sum(self : GraphflowmincutEdge) -> Double { @_common.sum(self.data) }

pub fn GraphflowmincutEdge::mean(self : GraphflowmincutEdge) -> Double { @_common.mean(self.data) }

pub fn GraphflowmincutEdge::scale(self : GraphflowmincutEdge, f : Double) -> GraphflowmincutEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutEdge::add(self : GraphflowmincutEdge, other : GraphflowmincutEdge) -> GraphflowmincutEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmincutEdge::copy(self : GraphflowmincutEdge) -> GraphflowmincutEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutEdge::fill(self : GraphflowmincutEdge, v : Double) -> GraphflowmincutEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutEdge::min(self : GraphflowmincutEdge) -> Double { @_common.min(self.data) }

pub fn GraphflowmincutEdge::max(self : GraphflowmincutEdge) -> Double { @_common.max(self.data) }

pub fn GraphflowmincutEdge::to_string(self : GraphflowmincutEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_path_make(size : Int) -> GraphflowmincutPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmincutPath::len(self : GraphflowmincutPath) -> Int { self.size }

pub fn GraphflowmincutPath::get(self : GraphflowmincutPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmincutPath::set(self : GraphflowmincutPath, i : Int, v : Double) -> GraphflowmincutPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmincutPath::sum(self : GraphflowmincutPath) -> Double { @_common.sum(self.data) }

pub fn GraphflowmincutPath::mean(self : GraphflowmincutPath) -> Double { @_common.mean(self.data) }

pub fn GraphflowmincutPath::scale(self : GraphflowmincutPath, f : Double) -> GraphflowmincutPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutPath::add(self : GraphflowmincutPath, other : GraphflowmincutPath) -> GraphflowmincutPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmincutPath::copy(self : GraphflowmincutPath) -> GraphflowmincutPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutPath::fill(self : GraphflowmincutPath, v : Double) -> GraphflowmincutPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutPath::min(self : GraphflowmincutPath) -> Double { @_common.min(self.data) }

pub fn GraphflowmincutPath::max(self : GraphflowmincutPath) -> Double { @_common.max(self.data) }

pub fn GraphflowmincutPath::to_string(self : GraphflowmincutPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_cluster_make(size : Int) -> GraphflowmincutCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmincutCluster::len(self : GraphflowmincutCluster) -> Int { self.size }

pub fn GraphflowmincutCluster::get(self : GraphflowmincutCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmincutCluster::set(self : GraphflowmincutCluster, i : Int, v : Double) -> GraphflowmincutCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmincutCluster::sum(self : GraphflowmincutCluster) -> Double { @_common.sum(self.data) }

pub fn GraphflowmincutCluster::mean(self : GraphflowmincutCluster) -> Double { @_common.mean(self.data) }

pub fn GraphflowmincutCluster::scale(self : GraphflowmincutCluster, f : Double) -> GraphflowmincutCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutCluster::add(self : GraphflowmincutCluster, other : GraphflowmincutCluster) -> GraphflowmincutCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmincutCluster::copy(self : GraphflowmincutCluster) -> GraphflowmincutCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutCluster::fill(self : GraphflowmincutCluster, v : Double) -> GraphflowmincutCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutCluster::min(self : GraphflowmincutCluster) -> Double { @_common.min(self.data) }

pub fn GraphflowmincutCluster::max(self : GraphflowmincutCluster) -> Double { @_common.max(self.data) }

pub fn GraphflowmincutCluster::to_string(self : GraphflowmincutCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_model_make(size : Int) -> GraphflowmincutModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmincutModel::len(self : GraphflowmincutModel) -> Int { self.size }

pub fn GraphflowmincutModel::get(self : GraphflowmincutModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmincutModel::set(self : GraphflowmincutModel, i : Int, v : Double) -> GraphflowmincutModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmincutModel::sum(self : GraphflowmincutModel) -> Double { @_common.sum(self.data) }

pub fn GraphflowmincutModel::mean(self : GraphflowmincutModel) -> Double { @_common.mean(self.data) }

pub fn GraphflowmincutModel::scale(self : GraphflowmincutModel, f : Double) -> GraphflowmincutModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutModel::add(self : GraphflowmincutModel, other : GraphflowmincutModel) -> GraphflowmincutModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmincutModel::copy(self : GraphflowmincutModel) -> GraphflowmincutModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutModel::fill(self : GraphflowmincutModel, v : Double) -> GraphflowmincutModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutModel::min(self : GraphflowmincutModel) -> Double { @_common.min(self.data) }

pub fn GraphflowmincutModel::max(self : GraphflowmincutModel) -> Double { @_common.max(self.data) }

pub fn GraphflowmincutModel::to_string(self : GraphflowmincutModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_layer_make(size : Int) -> GraphflowmincutLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmincutLayer::len(self : GraphflowmincutLayer) -> Int { self.size }

pub fn GraphflowmincutLayer::get(self : GraphflowmincutLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmincutLayer::set(self : GraphflowmincutLayer, i : Int, v : Double) -> GraphflowmincutLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmincutLayer::sum(self : GraphflowmincutLayer) -> Double { @_common.sum(self.data) }

pub fn GraphflowmincutLayer::mean(self : GraphflowmincutLayer) -> Double { @_common.mean(self.data) }

pub fn GraphflowmincutLayer::scale(self : GraphflowmincutLayer, f : Double) -> GraphflowmincutLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutLayer::add(self : GraphflowmincutLayer, other : GraphflowmincutLayer) -> GraphflowmincutLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmincutLayer::copy(self : GraphflowmincutLayer) -> GraphflowmincutLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutLayer::fill(self : GraphflowmincutLayer, v : Double) -> GraphflowmincutLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutLayer::min(self : GraphflowmincutLayer) -> Double { @_common.min(self.data) }

pub fn GraphflowmincutLayer::max(self : GraphflowmincutLayer) -> Double { @_common.max(self.data) }

pub fn GraphflowmincutLayer::to_string(self : GraphflowmincutLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_buffer_make(size : Int) -> GraphflowmincutBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmincutBuffer::len(self : GraphflowmincutBuffer) -> Int { self.size }

pub fn GraphflowmincutBuffer::get(self : GraphflowmincutBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmincutBuffer::set(self : GraphflowmincutBuffer, i : Int, v : Double) -> GraphflowmincutBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmincutBuffer::sum(self : GraphflowmincutBuffer) -> Double { @_common.sum(self.data) }

pub fn GraphflowmincutBuffer::mean(self : GraphflowmincutBuffer) -> Double { @_common.mean(self.data) }

pub fn GraphflowmincutBuffer::scale(self : GraphflowmincutBuffer, f : Double) -> GraphflowmincutBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutBuffer::add(self : GraphflowmincutBuffer, other : GraphflowmincutBuffer) -> GraphflowmincutBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmincutBuffer::copy(self : GraphflowmincutBuffer) -> GraphflowmincutBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutBuffer::fill(self : GraphflowmincutBuffer, v : Double) -> GraphflowmincutBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutBuffer::min(self : GraphflowmincutBuffer) -> Double { @_common.min(self.data) }

pub fn GraphflowmincutBuffer::max(self : GraphflowmincutBuffer) -> Double { @_common.max(self.data) }

pub fn GraphflowmincutBuffer::to_string(self : GraphflowmincutBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_cursor_make(size : Int) -> GraphflowmincutCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmincutCursor::len(self : GraphflowmincutCursor) -> Int { self.size }

pub fn GraphflowmincutCursor::get(self : GraphflowmincutCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmincutCursor::set(self : GraphflowmincutCursor, i : Int, v : Double) -> GraphflowmincutCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmincutCursor::sum(self : GraphflowmincutCursor) -> Double { @_common.sum(self.data) }

pub fn GraphflowmincutCursor::mean(self : GraphflowmincutCursor) -> Double { @_common.mean(self.data) }

pub fn GraphflowmincutCursor::scale(self : GraphflowmincutCursor, f : Double) -> GraphflowmincutCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutCursor::add(self : GraphflowmincutCursor, other : GraphflowmincutCursor) -> GraphflowmincutCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmincutCursor::copy(self : GraphflowmincutCursor) -> GraphflowmincutCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutCursor::fill(self : GraphflowmincutCursor, v : Double) -> GraphflowmincutCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutCursor::min(self : GraphflowmincutCursor) -> Double { @_common.min(self.data) }

pub fn GraphflowmincutCursor::max(self : GraphflowmincutCursor) -> Double { @_common.max(self.data) }

pub fn GraphflowmincutCursor::to_string(self : GraphflowmincutCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_view_make(size : Int) -> GraphflowmincutView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmincutView::len(self : GraphflowmincutView) -> Int { self.size }

pub fn GraphflowmincutView::get(self : GraphflowmincutView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmincutView::set(self : GraphflowmincutView, i : Int, v : Double) -> GraphflowmincutView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmincutView::sum(self : GraphflowmincutView) -> Double { @_common.sum(self.data) }

pub fn GraphflowmincutView::mean(self : GraphflowmincutView) -> Double { @_common.mean(self.data) }

pub fn GraphflowmincutView::scale(self : GraphflowmincutView, f : Double) -> GraphflowmincutView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutView::add(self : GraphflowmincutView, other : GraphflowmincutView) -> GraphflowmincutView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmincutView::copy(self : GraphflowmincutView) -> GraphflowmincutView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutView::fill(self : GraphflowmincutView, v : Double) -> GraphflowmincutView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutView::min(self : GraphflowmincutView) -> Double { @_common.min(self.data) }

pub fn GraphflowmincutView::max(self : GraphflowmincutView) -> Double { @_common.max(self.data) }

pub fn GraphflowmincutView::to_string(self : GraphflowmincutView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_range_make(size : Int) -> GraphflowmincutRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmincutRange::len(self : GraphflowmincutRange) -> Int { self.size }

pub fn GraphflowmincutRange::get(self : GraphflowmincutRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmincutRange::set(self : GraphflowmincutRange, i : Int, v : Double) -> GraphflowmincutRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmincutRange::sum(self : GraphflowmincutRange) -> Double { @_common.sum(self.data) }

pub fn GraphflowmincutRange::mean(self : GraphflowmincutRange) -> Double { @_common.mean(self.data) }

pub fn GraphflowmincutRange::scale(self : GraphflowmincutRange, f : Double) -> GraphflowmincutRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutRange::add(self : GraphflowmincutRange, other : GraphflowmincutRange) -> GraphflowmincutRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmincutRange::copy(self : GraphflowmincutRange) -> GraphflowmincutRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutRange::fill(self : GraphflowmincutRange, v : Double) -> GraphflowmincutRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutRange::min(self : GraphflowmincutRange) -> Double { @_common.min(self.data) }

pub fn GraphflowmincutRange::max(self : GraphflowmincutRange) -> Double { @_common.max(self.data) }

pub fn GraphflowmincutRange::to_string(self : GraphflowmincutRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GraphflowmincutSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_mincut_slice_make(size : Int) -> GraphflowmincutSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GraphflowmincutSlice::len(self : GraphflowmincutSlice) -> Int { self.size }

pub fn GraphflowmincutSlice::get(self : GraphflowmincutSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GraphflowmincutSlice::set(self : GraphflowmincutSlice, i : Int, v : Double) -> GraphflowmincutSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GraphflowmincutSlice::sum(self : GraphflowmincutSlice) -> Double { @_common.sum(self.data) }

pub fn GraphflowmincutSlice::mean(self : GraphflowmincutSlice) -> Double { @_common.mean(self.data) }

pub fn GraphflowmincutSlice::scale(self : GraphflowmincutSlice, f : Double) -> GraphflowmincutSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutSlice::add(self : GraphflowmincutSlice, other : GraphflowmincutSlice) -> GraphflowmincutSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GraphflowmincutSlice::copy(self : GraphflowmincutSlice) -> GraphflowmincutSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutSlice::fill(self : GraphflowmincutSlice, v : Double) -> GraphflowmincutSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GraphflowmincutSlice::min(self : GraphflowmincutSlice) -> Double { @_common.min(self.data) }

pub fn GraphflowmincutSlice::max(self : GraphflowmincutSlice) -> Double { @_common.max(self.data) }

pub fn GraphflowmincutSlice::to_string(self : GraphflowmincutSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

