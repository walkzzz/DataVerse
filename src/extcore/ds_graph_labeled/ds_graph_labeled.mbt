///===
/// extcore/ds_graph_labeled

pub(all) struct DsgraphlabeledPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_labeled_make_point(x : Double, y : Double) -> DsgraphlabeledPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_labeled_make_point3(x : Double, y : Double, z : Double) -> DsgraphlabeledPoint {
  { x, y, z, label: 0 }
}

pub fn DsgraphlabeledPoint::x(self : DsgraphlabeledPoint) -> Double { self.x }

pub fn DsgraphlabeledPoint::y(self : DsgraphlabeledPoint) -> Double { self.y }

pub fn DsgraphlabeledPoint::z(self : DsgraphlabeledPoint) -> Double { self.z }

pub fn DsgraphlabeledPoint::label(self : DsgraphlabeledPoint) -> Int { self.label }

pub fn DsgraphlabeledPoint::dist(self : DsgraphlabeledPoint, other : DsgraphlabeledPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsgraphlabeledPoint::add(self : DsgraphlabeledPoint, other : DsgraphlabeledPoint) -> DsgraphlabeledPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsgraphlabeledPoint::sub(self : DsgraphlabeledPoint, other : DsgraphlabeledPoint) -> DsgraphlabeledPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsgraphlabeledPoint::scale(self : DsgraphlabeledPoint, s : Double) -> DsgraphlabeledPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsgraphlabeledPoint::dot(self : DsgraphlabeledPoint, other : DsgraphlabeledPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsgraphlabeledPoint::cross(self : DsgraphlabeledPoint, other : DsgraphlabeledPoint) -> DsgraphlabeledPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsgraphlabeledPoint::norm(self : DsgraphlabeledPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsgraphlabeledPoint::normalize(self : DsgraphlabeledPoint) -> DsgraphlabeledPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphlabeledPoint::negate(self : DsgraphlabeledPoint) -> DsgraphlabeledPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsgraphlabeledPoint::mid(self : DsgraphlabeledPoint, other : DsgraphlabeledPoint) -> DsgraphlabeledPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsgraphlabeledPoint::lerp(self : DsgraphlabeledPoint, other : DsgraphlabeledPoint, t : Double) -> DsgraphlabeledPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsgraphlabeledPoint::to_string(self : DsgraphlabeledPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsgraphlabeledSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_labeled_make_series(vals : Array[Double], name : String) -> DsgraphlabeledSeries {
  { vals, name, meta: 0 }
}

pub fn DsgraphlabeledSeries::len(self : DsgraphlabeledSeries) -> Int { self.vals.length() }

pub fn DsgraphlabeledSeries::sum(self : DsgraphlabeledSeries) -> Double { @_common.sum(self.vals) }

pub fn DsgraphlabeledSeries::mean(self : DsgraphlabeledSeries) -> Double { @_common.mean(self.vals) }

pub fn DsgraphlabeledSeries::min(self : DsgraphlabeledSeries) -> Double { @_common.min(self.vals) }

pub fn DsgraphlabeledSeries::max(self : DsgraphlabeledSeries) -> Double { @_common.max(self.vals) }

pub fn DsgraphlabeledSeries::range(self : DsgraphlabeledSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsgraphlabeledSeries::variance(self : DsgraphlabeledSeries) -> Double { @_common.variance(self.vals) }

pub fn DsgraphlabeledSeries::std(self : DsgraphlabeledSeries) -> Double { @_common.std(self.vals) }

pub fn DsgraphlabeledSeries::median(self : DsgraphlabeledSeries) -> Double { @_common.median(self.vals) }

pub fn DsgraphlabeledSeries::scale(self : DsgraphlabeledSeries, f : Double) -> DsgraphlabeledSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsgraphlabeledSeries::add(self : DsgraphlabeledSeries, other : DsgraphlabeledSeries) -> DsgraphlabeledSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsgraphlabeledSeries::sub(self : DsgraphlabeledSeries, other : DsgraphlabeledSeries) -> DsgraphlabeledSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsgraphlabeledSeries::normalize(self : DsgraphlabeledSeries) -> DsgraphlabeledSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsgraphlabeledSeries::cumsum(self : DsgraphlabeledSeries) -> DsgraphlabeledSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsgraphlabeledSeries::to_string(self : DsgraphlabeledSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphlabeledMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_labeled_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphlabeledMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_labeled_matrix_identity(n : Int) -> DsgraphlabeledMatrix {
  let m = ds_graph_labeled_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsgraphlabeledMatrix::get(self : DsgraphlabeledMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsgraphlabeledMatrix::transpose(self : DsgraphlabeledMatrix) -> DsgraphlabeledMatrix {
  let result = ds_graph_labeled_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsgraphlabeledMatrix::add(self : DsgraphlabeledMatrix, other : DsgraphlabeledMatrix) -> DsgraphlabeledMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_graph_labeled_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsgraphlabeledMatrix::scale(self : DsgraphlabeledMatrix, s : Double) -> DsgraphlabeledMatrix {
  let result = ds_graph_labeled_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsgraphlabeledMatrix::multiply(self : DsgraphlabeledMatrix, other : DsgraphlabeledMatrix) -> DsgraphlabeledMatrix {
  if self.cols != other.rows { return ds_graph_labeled_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_graph_labeled_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsgraphlabeledMatrix::trace(self : DsgraphlabeledMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsgraphlabeledMatrix::det(self : DsgraphlabeledMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsgraphlabeledMatrix::norm(self : DsgraphlabeledMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsgraphlabeledMatrix::to_string(self : DsgraphlabeledMatrix) -> String {
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

pub(all) struct DsgraphlabeledVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_labeled_make_vector(comps : Array[Double]) -> DsgraphlabeledVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_labeled_vector_zero(dim : Int) -> DsgraphlabeledVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsgraphlabeledVector::add(self : DsgraphlabeledVector, other : DsgraphlabeledVector) -> DsgraphlabeledVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphlabeledVector::sub(self : DsgraphlabeledVector, other : DsgraphlabeledVector) -> DsgraphlabeledVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsgraphlabeledVector::scale(self : DsgraphlabeledVector, s : Double) -> DsgraphlabeledVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsgraphlabeledVector::dot(self : DsgraphlabeledVector, other : DsgraphlabeledVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsgraphlabeledVector::norm(self : DsgraphlabeledVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsgraphlabeledVector::normalize(self : DsgraphlabeledVector) -> DsgraphlabeledVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsgraphlabeledVector::dist(self : DsgraphlabeledVector, other : DsgraphlabeledVector) -> Double {
  self.sub(other).norm()
}

pub fn DsgraphlabeledVector::to_string(self : DsgraphlabeledVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_labeled_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_graph_labeled_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_graph_labeled_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_graph_labeled_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_graph_labeled_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_graph_labeled_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_graph_labeled_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_graph_labeled_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_graph_labeled_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_graph_labeled_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_graph_labeled_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_graph_labeled_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_graph_labeled_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_graph_labeled_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_graph_labeled_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_graph_labeled_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_graph_labeled_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_graph_labeled_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_graph_labeled_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_graph_labeled_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_graph_labeled_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_graph_labeled_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_graph_labeled_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_graph_labeled_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_graph_labeled_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_graph_labeled_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_graph_labeled_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_graph_labeled_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_graph_labeled_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsgraphlabeledFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_frame_make(size : Int) -> DsgraphlabeledFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphlabeledFrame::len(self : DsgraphlabeledFrame) -> Int { self.size }

pub fn DsgraphlabeledFrame::get(self : DsgraphlabeledFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphlabeledFrame::set(self : DsgraphlabeledFrame, i : Int, v : Double) -> DsgraphlabeledFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledFrame::sum(self : DsgraphlabeledFrame) -> Double { @_common.sum(self.data) }

pub fn DsgraphlabeledFrame::mean(self : DsgraphlabeledFrame) -> Double { @_common.mean(self.data) }

pub fn DsgraphlabeledFrame::scale(self : DsgraphlabeledFrame, f : Double) -> DsgraphlabeledFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledFrame::add(self : DsgraphlabeledFrame, other : DsgraphlabeledFrame) -> DsgraphlabeledFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphlabeledFrame::copy(self : DsgraphlabeledFrame) -> DsgraphlabeledFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledFrame::fill(self : DsgraphlabeledFrame, v : Double) -> DsgraphlabeledFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledFrame::min(self : DsgraphlabeledFrame) -> Double { @_common.min(self.data) }

pub fn DsgraphlabeledFrame::max(self : DsgraphlabeledFrame) -> Double { @_common.max(self.data) }

pub fn DsgraphlabeledFrame::to_string(self : DsgraphlabeledFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_table_make(size : Int) -> DsgraphlabeledTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphlabeledTable::len(self : DsgraphlabeledTable) -> Int { self.size }

pub fn DsgraphlabeledTable::get(self : DsgraphlabeledTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphlabeledTable::set(self : DsgraphlabeledTable, i : Int, v : Double) -> DsgraphlabeledTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledTable::sum(self : DsgraphlabeledTable) -> Double { @_common.sum(self.data) }

pub fn DsgraphlabeledTable::mean(self : DsgraphlabeledTable) -> Double { @_common.mean(self.data) }

pub fn DsgraphlabeledTable::scale(self : DsgraphlabeledTable, f : Double) -> DsgraphlabeledTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledTable::add(self : DsgraphlabeledTable, other : DsgraphlabeledTable) -> DsgraphlabeledTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphlabeledTable::copy(self : DsgraphlabeledTable) -> DsgraphlabeledTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledTable::fill(self : DsgraphlabeledTable, v : Double) -> DsgraphlabeledTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledTable::min(self : DsgraphlabeledTable) -> Double { @_common.min(self.data) }

pub fn DsgraphlabeledTable::max(self : DsgraphlabeledTable) -> Double { @_common.max(self.data) }

pub fn DsgraphlabeledTable::to_string(self : DsgraphlabeledTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_graphn_make(size : Int) -> DsgraphlabeledGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphlabeledGraphN::len(self : DsgraphlabeledGraphN) -> Int { self.size }

pub fn DsgraphlabeledGraphN::get(self : DsgraphlabeledGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphlabeledGraphN::set(self : DsgraphlabeledGraphN, i : Int, v : Double) -> DsgraphlabeledGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledGraphN::sum(self : DsgraphlabeledGraphN) -> Double { @_common.sum(self.data) }

pub fn DsgraphlabeledGraphN::mean(self : DsgraphlabeledGraphN) -> Double { @_common.mean(self.data) }

pub fn DsgraphlabeledGraphN::scale(self : DsgraphlabeledGraphN, f : Double) -> DsgraphlabeledGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledGraphN::add(self : DsgraphlabeledGraphN, other : DsgraphlabeledGraphN) -> DsgraphlabeledGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphlabeledGraphN::copy(self : DsgraphlabeledGraphN) -> DsgraphlabeledGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledGraphN::fill(self : DsgraphlabeledGraphN, v : Double) -> DsgraphlabeledGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledGraphN::min(self : DsgraphlabeledGraphN) -> Double { @_common.min(self.data) }

pub fn DsgraphlabeledGraphN::max(self : DsgraphlabeledGraphN) -> Double { @_common.max(self.data) }

pub fn DsgraphlabeledGraphN::to_string(self : DsgraphlabeledGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_node_make(size : Int) -> DsgraphlabeledNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphlabeledNode::len(self : DsgraphlabeledNode) -> Int { self.size }

pub fn DsgraphlabeledNode::get(self : DsgraphlabeledNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphlabeledNode::set(self : DsgraphlabeledNode, i : Int, v : Double) -> DsgraphlabeledNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledNode::sum(self : DsgraphlabeledNode) -> Double { @_common.sum(self.data) }

pub fn DsgraphlabeledNode::mean(self : DsgraphlabeledNode) -> Double { @_common.mean(self.data) }

pub fn DsgraphlabeledNode::scale(self : DsgraphlabeledNode, f : Double) -> DsgraphlabeledNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledNode::add(self : DsgraphlabeledNode, other : DsgraphlabeledNode) -> DsgraphlabeledNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphlabeledNode::copy(self : DsgraphlabeledNode) -> DsgraphlabeledNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledNode::fill(self : DsgraphlabeledNode, v : Double) -> DsgraphlabeledNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledNode::min(self : DsgraphlabeledNode) -> Double { @_common.min(self.data) }

pub fn DsgraphlabeledNode::max(self : DsgraphlabeledNode) -> Double { @_common.max(self.data) }

pub fn DsgraphlabeledNode::to_string(self : DsgraphlabeledNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_edge_make(size : Int) -> DsgraphlabeledEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphlabeledEdge::len(self : DsgraphlabeledEdge) -> Int { self.size }

pub fn DsgraphlabeledEdge::get(self : DsgraphlabeledEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphlabeledEdge::set(self : DsgraphlabeledEdge, i : Int, v : Double) -> DsgraphlabeledEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledEdge::sum(self : DsgraphlabeledEdge) -> Double { @_common.sum(self.data) }

pub fn DsgraphlabeledEdge::mean(self : DsgraphlabeledEdge) -> Double { @_common.mean(self.data) }

pub fn DsgraphlabeledEdge::scale(self : DsgraphlabeledEdge, f : Double) -> DsgraphlabeledEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledEdge::add(self : DsgraphlabeledEdge, other : DsgraphlabeledEdge) -> DsgraphlabeledEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphlabeledEdge::copy(self : DsgraphlabeledEdge) -> DsgraphlabeledEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledEdge::fill(self : DsgraphlabeledEdge, v : Double) -> DsgraphlabeledEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledEdge::min(self : DsgraphlabeledEdge) -> Double { @_common.min(self.data) }

pub fn DsgraphlabeledEdge::max(self : DsgraphlabeledEdge) -> Double { @_common.max(self.data) }

pub fn DsgraphlabeledEdge::to_string(self : DsgraphlabeledEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_path_make(size : Int) -> DsgraphlabeledPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphlabeledPath::len(self : DsgraphlabeledPath) -> Int { self.size }

pub fn DsgraphlabeledPath::get(self : DsgraphlabeledPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphlabeledPath::set(self : DsgraphlabeledPath, i : Int, v : Double) -> DsgraphlabeledPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledPath::sum(self : DsgraphlabeledPath) -> Double { @_common.sum(self.data) }

pub fn DsgraphlabeledPath::mean(self : DsgraphlabeledPath) -> Double { @_common.mean(self.data) }

pub fn DsgraphlabeledPath::scale(self : DsgraphlabeledPath, f : Double) -> DsgraphlabeledPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledPath::add(self : DsgraphlabeledPath, other : DsgraphlabeledPath) -> DsgraphlabeledPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphlabeledPath::copy(self : DsgraphlabeledPath) -> DsgraphlabeledPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledPath::fill(self : DsgraphlabeledPath, v : Double) -> DsgraphlabeledPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledPath::min(self : DsgraphlabeledPath) -> Double { @_common.min(self.data) }

pub fn DsgraphlabeledPath::max(self : DsgraphlabeledPath) -> Double { @_common.max(self.data) }

pub fn DsgraphlabeledPath::to_string(self : DsgraphlabeledPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_cluster_make(size : Int) -> DsgraphlabeledCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphlabeledCluster::len(self : DsgraphlabeledCluster) -> Int { self.size }

pub fn DsgraphlabeledCluster::get(self : DsgraphlabeledCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphlabeledCluster::set(self : DsgraphlabeledCluster, i : Int, v : Double) -> DsgraphlabeledCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledCluster::sum(self : DsgraphlabeledCluster) -> Double { @_common.sum(self.data) }

pub fn DsgraphlabeledCluster::mean(self : DsgraphlabeledCluster) -> Double { @_common.mean(self.data) }

pub fn DsgraphlabeledCluster::scale(self : DsgraphlabeledCluster, f : Double) -> DsgraphlabeledCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledCluster::add(self : DsgraphlabeledCluster, other : DsgraphlabeledCluster) -> DsgraphlabeledCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphlabeledCluster::copy(self : DsgraphlabeledCluster) -> DsgraphlabeledCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledCluster::fill(self : DsgraphlabeledCluster, v : Double) -> DsgraphlabeledCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledCluster::min(self : DsgraphlabeledCluster) -> Double { @_common.min(self.data) }

pub fn DsgraphlabeledCluster::max(self : DsgraphlabeledCluster) -> Double { @_common.max(self.data) }

pub fn DsgraphlabeledCluster::to_string(self : DsgraphlabeledCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_model_make(size : Int) -> DsgraphlabeledModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphlabeledModel::len(self : DsgraphlabeledModel) -> Int { self.size }

pub fn DsgraphlabeledModel::get(self : DsgraphlabeledModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphlabeledModel::set(self : DsgraphlabeledModel, i : Int, v : Double) -> DsgraphlabeledModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledModel::sum(self : DsgraphlabeledModel) -> Double { @_common.sum(self.data) }

pub fn DsgraphlabeledModel::mean(self : DsgraphlabeledModel) -> Double { @_common.mean(self.data) }

pub fn DsgraphlabeledModel::scale(self : DsgraphlabeledModel, f : Double) -> DsgraphlabeledModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledModel::add(self : DsgraphlabeledModel, other : DsgraphlabeledModel) -> DsgraphlabeledModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphlabeledModel::copy(self : DsgraphlabeledModel) -> DsgraphlabeledModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledModel::fill(self : DsgraphlabeledModel, v : Double) -> DsgraphlabeledModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledModel::min(self : DsgraphlabeledModel) -> Double { @_common.min(self.data) }

pub fn DsgraphlabeledModel::max(self : DsgraphlabeledModel) -> Double { @_common.max(self.data) }

pub fn DsgraphlabeledModel::to_string(self : DsgraphlabeledModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_layer_make(size : Int) -> DsgraphlabeledLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphlabeledLayer::len(self : DsgraphlabeledLayer) -> Int { self.size }

pub fn DsgraphlabeledLayer::get(self : DsgraphlabeledLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphlabeledLayer::set(self : DsgraphlabeledLayer, i : Int, v : Double) -> DsgraphlabeledLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledLayer::sum(self : DsgraphlabeledLayer) -> Double { @_common.sum(self.data) }

pub fn DsgraphlabeledLayer::mean(self : DsgraphlabeledLayer) -> Double { @_common.mean(self.data) }

pub fn DsgraphlabeledLayer::scale(self : DsgraphlabeledLayer, f : Double) -> DsgraphlabeledLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledLayer::add(self : DsgraphlabeledLayer, other : DsgraphlabeledLayer) -> DsgraphlabeledLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphlabeledLayer::copy(self : DsgraphlabeledLayer) -> DsgraphlabeledLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledLayer::fill(self : DsgraphlabeledLayer, v : Double) -> DsgraphlabeledLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledLayer::min(self : DsgraphlabeledLayer) -> Double { @_common.min(self.data) }

pub fn DsgraphlabeledLayer::max(self : DsgraphlabeledLayer) -> Double { @_common.max(self.data) }

pub fn DsgraphlabeledLayer::to_string(self : DsgraphlabeledLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_buffer_make(size : Int) -> DsgraphlabeledBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphlabeledBuffer::len(self : DsgraphlabeledBuffer) -> Int { self.size }

pub fn DsgraphlabeledBuffer::get(self : DsgraphlabeledBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphlabeledBuffer::set(self : DsgraphlabeledBuffer, i : Int, v : Double) -> DsgraphlabeledBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledBuffer::sum(self : DsgraphlabeledBuffer) -> Double { @_common.sum(self.data) }

pub fn DsgraphlabeledBuffer::mean(self : DsgraphlabeledBuffer) -> Double { @_common.mean(self.data) }

pub fn DsgraphlabeledBuffer::scale(self : DsgraphlabeledBuffer, f : Double) -> DsgraphlabeledBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledBuffer::add(self : DsgraphlabeledBuffer, other : DsgraphlabeledBuffer) -> DsgraphlabeledBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphlabeledBuffer::copy(self : DsgraphlabeledBuffer) -> DsgraphlabeledBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledBuffer::fill(self : DsgraphlabeledBuffer, v : Double) -> DsgraphlabeledBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledBuffer::min(self : DsgraphlabeledBuffer) -> Double { @_common.min(self.data) }

pub fn DsgraphlabeledBuffer::max(self : DsgraphlabeledBuffer) -> Double { @_common.max(self.data) }

pub fn DsgraphlabeledBuffer::to_string(self : DsgraphlabeledBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_cursor_make(size : Int) -> DsgraphlabeledCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphlabeledCursor::len(self : DsgraphlabeledCursor) -> Int { self.size }

pub fn DsgraphlabeledCursor::get(self : DsgraphlabeledCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphlabeledCursor::set(self : DsgraphlabeledCursor, i : Int, v : Double) -> DsgraphlabeledCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledCursor::sum(self : DsgraphlabeledCursor) -> Double { @_common.sum(self.data) }

pub fn DsgraphlabeledCursor::mean(self : DsgraphlabeledCursor) -> Double { @_common.mean(self.data) }

pub fn DsgraphlabeledCursor::scale(self : DsgraphlabeledCursor, f : Double) -> DsgraphlabeledCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledCursor::add(self : DsgraphlabeledCursor, other : DsgraphlabeledCursor) -> DsgraphlabeledCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphlabeledCursor::copy(self : DsgraphlabeledCursor) -> DsgraphlabeledCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledCursor::fill(self : DsgraphlabeledCursor, v : Double) -> DsgraphlabeledCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledCursor::min(self : DsgraphlabeledCursor) -> Double { @_common.min(self.data) }

pub fn DsgraphlabeledCursor::max(self : DsgraphlabeledCursor) -> Double { @_common.max(self.data) }

pub fn DsgraphlabeledCursor::to_string(self : DsgraphlabeledCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_view_make(size : Int) -> DsgraphlabeledView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphlabeledView::len(self : DsgraphlabeledView) -> Int { self.size }

pub fn DsgraphlabeledView::get(self : DsgraphlabeledView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphlabeledView::set(self : DsgraphlabeledView, i : Int, v : Double) -> DsgraphlabeledView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledView::sum(self : DsgraphlabeledView) -> Double { @_common.sum(self.data) }

pub fn DsgraphlabeledView::mean(self : DsgraphlabeledView) -> Double { @_common.mean(self.data) }

pub fn DsgraphlabeledView::scale(self : DsgraphlabeledView, f : Double) -> DsgraphlabeledView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledView::add(self : DsgraphlabeledView, other : DsgraphlabeledView) -> DsgraphlabeledView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphlabeledView::copy(self : DsgraphlabeledView) -> DsgraphlabeledView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledView::fill(self : DsgraphlabeledView, v : Double) -> DsgraphlabeledView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledView::min(self : DsgraphlabeledView) -> Double { @_common.min(self.data) }

pub fn DsgraphlabeledView::max(self : DsgraphlabeledView) -> Double { @_common.max(self.data) }

pub fn DsgraphlabeledView::to_string(self : DsgraphlabeledView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_range_make(size : Int) -> DsgraphlabeledRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphlabeledRange::len(self : DsgraphlabeledRange) -> Int { self.size }

pub fn DsgraphlabeledRange::get(self : DsgraphlabeledRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphlabeledRange::set(self : DsgraphlabeledRange, i : Int, v : Double) -> DsgraphlabeledRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledRange::sum(self : DsgraphlabeledRange) -> Double { @_common.sum(self.data) }

pub fn DsgraphlabeledRange::mean(self : DsgraphlabeledRange) -> Double { @_common.mean(self.data) }

pub fn DsgraphlabeledRange::scale(self : DsgraphlabeledRange, f : Double) -> DsgraphlabeledRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledRange::add(self : DsgraphlabeledRange, other : DsgraphlabeledRange) -> DsgraphlabeledRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphlabeledRange::copy(self : DsgraphlabeledRange) -> DsgraphlabeledRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledRange::fill(self : DsgraphlabeledRange, v : Double) -> DsgraphlabeledRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledRange::min(self : DsgraphlabeledRange) -> Double { @_common.min(self.data) }

pub fn DsgraphlabeledRange::max(self : DsgraphlabeledRange) -> Double { @_common.max(self.data) }

pub fn DsgraphlabeledRange::to_string(self : DsgraphlabeledRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsgraphlabeledSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_labeled_slice_make(size : Int) -> DsgraphlabeledSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsgraphlabeledSlice::len(self : DsgraphlabeledSlice) -> Int { self.size }

pub fn DsgraphlabeledSlice::get(self : DsgraphlabeledSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsgraphlabeledSlice::set(self : DsgraphlabeledSlice, i : Int, v : Double) -> DsgraphlabeledSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledSlice::sum(self : DsgraphlabeledSlice) -> Double { @_common.sum(self.data) }

pub fn DsgraphlabeledSlice::mean(self : DsgraphlabeledSlice) -> Double { @_common.mean(self.data) }

pub fn DsgraphlabeledSlice::scale(self : DsgraphlabeledSlice, f : Double) -> DsgraphlabeledSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledSlice::add(self : DsgraphlabeledSlice, other : DsgraphlabeledSlice) -> DsgraphlabeledSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsgraphlabeledSlice::copy(self : DsgraphlabeledSlice) -> DsgraphlabeledSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledSlice::fill(self : DsgraphlabeledSlice, v : Double) -> DsgraphlabeledSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsgraphlabeledSlice::min(self : DsgraphlabeledSlice) -> Double { @_common.min(self.data) }

pub fn DsgraphlabeledSlice::max(self : DsgraphlabeledSlice) -> Double { @_common.max(self.data) }

pub fn DsgraphlabeledSlice::to_string(self : DsgraphlabeledSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

