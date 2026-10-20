///===
/// extcore/sort_compare_selection

pub(all) struct SortcompareselectionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_selection_make_point(x : Double, y : Double) -> SortcompareselectionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_selection_make_point3(x : Double, y : Double, z : Double) -> SortcompareselectionPoint {
  { x, y, z, label: 0 }
}

pub fn SortcompareselectionPoint::x(self : SortcompareselectionPoint) -> Double { self.x }

pub fn SortcompareselectionPoint::y(self : SortcompareselectionPoint) -> Double { self.y }

pub fn SortcompareselectionPoint::z(self : SortcompareselectionPoint) -> Double { self.z }

pub fn SortcompareselectionPoint::label(self : SortcompareselectionPoint) -> Int { self.label }

pub fn SortcompareselectionPoint::dist(self : SortcompareselectionPoint, other : SortcompareselectionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcompareselectionPoint::add(self : SortcompareselectionPoint, other : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcompareselectionPoint::sub(self : SortcompareselectionPoint, other : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcompareselectionPoint::scale(self : SortcompareselectionPoint, s : Double) -> SortcompareselectionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcompareselectionPoint::dot(self : SortcompareselectionPoint, other : SortcompareselectionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcompareselectionPoint::cross(self : SortcompareselectionPoint, other : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcompareselectionPoint::norm(self : SortcompareselectionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcompareselectionPoint::normalize(self : SortcompareselectionPoint) -> SortcompareselectionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcompareselectionPoint::negate(self : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcompareselectionPoint::mid(self : SortcompareselectionPoint, other : SortcompareselectionPoint) -> SortcompareselectionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcompareselectionPoint::lerp(self : SortcompareselectionPoint, other : SortcompareselectionPoint, t : Double) -> SortcompareselectionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcompareselectionPoint::to_string(self : SortcompareselectionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcompareselectionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_selection_make_series(vals : Array[Double], name : String) -> SortcompareselectionSeries {
  { vals, name, meta: 0 }
}

pub fn SortcompareselectionSeries::len(self : SortcompareselectionSeries) -> Int { self.vals.length() }

pub fn SortcompareselectionSeries::sum(self : SortcompareselectionSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcompareselectionSeries::mean(self : SortcompareselectionSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcompareselectionSeries::min(self : SortcompareselectionSeries) -> Double { @_common.min(self.vals) }

pub fn SortcompareselectionSeries::max(self : SortcompareselectionSeries) -> Double { @_common.max(self.vals) }

pub fn SortcompareselectionSeries::range(self : SortcompareselectionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcompareselectionSeries::variance(self : SortcompareselectionSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcompareselectionSeries::std(self : SortcompareselectionSeries) -> Double { @_common.std(self.vals) }

pub fn SortcompareselectionSeries::median(self : SortcompareselectionSeries) -> Double { @_common.median(self.vals) }

pub fn SortcompareselectionSeries::scale(self : SortcompareselectionSeries, f : Double) -> SortcompareselectionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcompareselectionSeries::add(self : SortcompareselectionSeries, other : SortcompareselectionSeries) -> SortcompareselectionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcompareselectionSeries::sub(self : SortcompareselectionSeries, other : SortcompareselectionSeries) -> SortcompareselectionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcompareselectionSeries::normalize(self : SortcompareselectionSeries) -> SortcompareselectionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcompareselectionSeries::cumsum(self : SortcompareselectionSeries) -> SortcompareselectionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcompareselectionSeries::to_string(self : SortcompareselectionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcompareselectionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_selection_make_matrix(rows : Int, cols : Int, val : Double) -> SortcompareselectionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_selection_matrix_identity(n : Int) -> SortcompareselectionMatrix {
  let m = sort_compare_selection_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcompareselectionMatrix::get(self : SortcompareselectionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcompareselectionMatrix::transpose(self : SortcompareselectionMatrix) -> SortcompareselectionMatrix {
  let result = sort_compare_selection_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcompareselectionMatrix::add(self : SortcompareselectionMatrix, other : SortcompareselectionMatrix) -> SortcompareselectionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_selection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcompareselectionMatrix::scale(self : SortcompareselectionMatrix, s : Double) -> SortcompareselectionMatrix {
  let result = sort_compare_selection_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcompareselectionMatrix::multiply(self : SortcompareselectionMatrix, other : SortcompareselectionMatrix) -> SortcompareselectionMatrix {
  if self.cols != other.rows { return sort_compare_selection_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_selection_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcompareselectionMatrix::trace(self : SortcompareselectionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcompareselectionMatrix::det(self : SortcompareselectionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcompareselectionMatrix::norm(self : SortcompareselectionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcompareselectionMatrix::to_string(self : SortcompareselectionMatrix) -> String {
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

pub(all) struct SortcompareselectionVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_selection_make_vector(comps : Array[Double]) -> SortcompareselectionVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_selection_vector_zero(dim : Int) -> SortcompareselectionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcompareselectionVector::add(self : SortcompareselectionVector, other : SortcompareselectionVector) -> SortcompareselectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcompareselectionVector::sub(self : SortcompareselectionVector, other : SortcompareselectionVector) -> SortcompareselectionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcompareselectionVector::scale(self : SortcompareselectionVector, s : Double) -> SortcompareselectionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcompareselectionVector::dot(self : SortcompareselectionVector, other : SortcompareselectionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcompareselectionVector::norm(self : SortcompareselectionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcompareselectionVector::normalize(self : SortcompareselectionVector) -> SortcompareselectionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcompareselectionVector::dist(self : SortcompareselectionVector, other : SortcompareselectionVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcompareselectionVector::to_string(self : SortcompareselectionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_selection_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_selection_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_selection_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_selection_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_selection_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_selection_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_selection_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_selection_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_selection_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_selection_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_selection_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_selection_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_selection_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_selection_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_selection_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_selection_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_selection_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_selection_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_selection_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_selection_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_selection_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_selection_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_selection_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_selection_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_selection_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_selection_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_selection_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_selection_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_selection_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcompareselectionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_frame_make(size : Int) -> SortcompareselectionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareselectionFrame::len(self : SortcompareselectionFrame) -> Int { self.size }

pub fn SortcompareselectionFrame::get(self : SortcompareselectionFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareselectionFrame::set(self : SortcompareselectionFrame, i : Int, v : Double) -> SortcompareselectionFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareselectionFrame::sum(self : SortcompareselectionFrame) -> Double { @_common.sum(self.data) }

pub fn SortcompareselectionFrame::mean(self : SortcompareselectionFrame) -> Double { @_common.mean(self.data) }

pub fn SortcompareselectionFrame::scale(self : SortcompareselectionFrame, f : Double) -> SortcompareselectionFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionFrame::add(self : SortcompareselectionFrame, other : SortcompareselectionFrame) -> SortcompareselectionFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareselectionFrame::copy(self : SortcompareselectionFrame) -> SortcompareselectionFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionFrame::fill(self : SortcompareselectionFrame, v : Double) -> SortcompareselectionFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionFrame::min(self : SortcompareselectionFrame) -> Double { @_common.min(self.data) }

pub fn SortcompareselectionFrame::max(self : SortcompareselectionFrame) -> Double { @_common.max(self.data) }

pub fn SortcompareselectionFrame::to_string(self : SortcompareselectionFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_table_make(size : Int) -> SortcompareselectionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareselectionTable::len(self : SortcompareselectionTable) -> Int { self.size }

pub fn SortcompareselectionTable::get(self : SortcompareselectionTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareselectionTable::set(self : SortcompareselectionTable, i : Int, v : Double) -> SortcompareselectionTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareselectionTable::sum(self : SortcompareselectionTable) -> Double { @_common.sum(self.data) }

pub fn SortcompareselectionTable::mean(self : SortcompareselectionTable) -> Double { @_common.mean(self.data) }

pub fn SortcompareselectionTable::scale(self : SortcompareselectionTable, f : Double) -> SortcompareselectionTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionTable::add(self : SortcompareselectionTable, other : SortcompareselectionTable) -> SortcompareselectionTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareselectionTable::copy(self : SortcompareselectionTable) -> SortcompareselectionTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionTable::fill(self : SortcompareselectionTable, v : Double) -> SortcompareselectionTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionTable::min(self : SortcompareselectionTable) -> Double { @_common.min(self.data) }

pub fn SortcompareselectionTable::max(self : SortcompareselectionTable) -> Double { @_common.max(self.data) }

pub fn SortcompareselectionTable::to_string(self : SortcompareselectionTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_graphn_make(size : Int) -> SortcompareselectionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareselectionGraphN::len(self : SortcompareselectionGraphN) -> Int { self.size }

pub fn SortcompareselectionGraphN::get(self : SortcompareselectionGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareselectionGraphN::set(self : SortcompareselectionGraphN, i : Int, v : Double) -> SortcompareselectionGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareselectionGraphN::sum(self : SortcompareselectionGraphN) -> Double { @_common.sum(self.data) }

pub fn SortcompareselectionGraphN::mean(self : SortcompareselectionGraphN) -> Double { @_common.mean(self.data) }

pub fn SortcompareselectionGraphN::scale(self : SortcompareselectionGraphN, f : Double) -> SortcompareselectionGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionGraphN::add(self : SortcompareselectionGraphN, other : SortcompareselectionGraphN) -> SortcompareselectionGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareselectionGraphN::copy(self : SortcompareselectionGraphN) -> SortcompareselectionGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionGraphN::fill(self : SortcompareselectionGraphN, v : Double) -> SortcompareselectionGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionGraphN::min(self : SortcompareselectionGraphN) -> Double { @_common.min(self.data) }

pub fn SortcompareselectionGraphN::max(self : SortcompareselectionGraphN) -> Double { @_common.max(self.data) }

pub fn SortcompareselectionGraphN::to_string(self : SortcompareselectionGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_node_make(size : Int) -> SortcompareselectionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareselectionNode::len(self : SortcompareselectionNode) -> Int { self.size }

pub fn SortcompareselectionNode::get(self : SortcompareselectionNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareselectionNode::set(self : SortcompareselectionNode, i : Int, v : Double) -> SortcompareselectionNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareselectionNode::sum(self : SortcompareselectionNode) -> Double { @_common.sum(self.data) }

pub fn SortcompareselectionNode::mean(self : SortcompareselectionNode) -> Double { @_common.mean(self.data) }

pub fn SortcompareselectionNode::scale(self : SortcompareselectionNode, f : Double) -> SortcompareselectionNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionNode::add(self : SortcompareselectionNode, other : SortcompareselectionNode) -> SortcompareselectionNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareselectionNode::copy(self : SortcompareselectionNode) -> SortcompareselectionNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionNode::fill(self : SortcompareselectionNode, v : Double) -> SortcompareselectionNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionNode::min(self : SortcompareselectionNode) -> Double { @_common.min(self.data) }

pub fn SortcompareselectionNode::max(self : SortcompareselectionNode) -> Double { @_common.max(self.data) }

pub fn SortcompareselectionNode::to_string(self : SortcompareselectionNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_edge_make(size : Int) -> SortcompareselectionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareselectionEdge::len(self : SortcompareselectionEdge) -> Int { self.size }

pub fn SortcompareselectionEdge::get(self : SortcompareselectionEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareselectionEdge::set(self : SortcompareselectionEdge, i : Int, v : Double) -> SortcompareselectionEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareselectionEdge::sum(self : SortcompareselectionEdge) -> Double { @_common.sum(self.data) }

pub fn SortcompareselectionEdge::mean(self : SortcompareselectionEdge) -> Double { @_common.mean(self.data) }

pub fn SortcompareselectionEdge::scale(self : SortcompareselectionEdge, f : Double) -> SortcompareselectionEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionEdge::add(self : SortcompareselectionEdge, other : SortcompareselectionEdge) -> SortcompareselectionEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareselectionEdge::copy(self : SortcompareselectionEdge) -> SortcompareselectionEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionEdge::fill(self : SortcompareselectionEdge, v : Double) -> SortcompareselectionEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionEdge::min(self : SortcompareselectionEdge) -> Double { @_common.min(self.data) }

pub fn SortcompareselectionEdge::max(self : SortcompareselectionEdge) -> Double { @_common.max(self.data) }

pub fn SortcompareselectionEdge::to_string(self : SortcompareselectionEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_path_make(size : Int) -> SortcompareselectionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareselectionPath::len(self : SortcompareselectionPath) -> Int { self.size }

pub fn SortcompareselectionPath::get(self : SortcompareselectionPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareselectionPath::set(self : SortcompareselectionPath, i : Int, v : Double) -> SortcompareselectionPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareselectionPath::sum(self : SortcompareselectionPath) -> Double { @_common.sum(self.data) }

pub fn SortcompareselectionPath::mean(self : SortcompareselectionPath) -> Double { @_common.mean(self.data) }

pub fn SortcompareselectionPath::scale(self : SortcompareselectionPath, f : Double) -> SortcompareselectionPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionPath::add(self : SortcompareselectionPath, other : SortcompareselectionPath) -> SortcompareselectionPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareselectionPath::copy(self : SortcompareselectionPath) -> SortcompareselectionPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionPath::fill(self : SortcompareselectionPath, v : Double) -> SortcompareselectionPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionPath::min(self : SortcompareselectionPath) -> Double { @_common.min(self.data) }

pub fn SortcompareselectionPath::max(self : SortcompareselectionPath) -> Double { @_common.max(self.data) }

pub fn SortcompareselectionPath::to_string(self : SortcompareselectionPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_cluster_make(size : Int) -> SortcompareselectionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareselectionCluster::len(self : SortcompareselectionCluster) -> Int { self.size }

pub fn SortcompareselectionCluster::get(self : SortcompareselectionCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareselectionCluster::set(self : SortcompareselectionCluster, i : Int, v : Double) -> SortcompareselectionCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareselectionCluster::sum(self : SortcompareselectionCluster) -> Double { @_common.sum(self.data) }

pub fn SortcompareselectionCluster::mean(self : SortcompareselectionCluster) -> Double { @_common.mean(self.data) }

pub fn SortcompareselectionCluster::scale(self : SortcompareselectionCluster, f : Double) -> SortcompareselectionCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionCluster::add(self : SortcompareselectionCluster, other : SortcompareselectionCluster) -> SortcompareselectionCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareselectionCluster::copy(self : SortcompareselectionCluster) -> SortcompareselectionCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionCluster::fill(self : SortcompareselectionCluster, v : Double) -> SortcompareselectionCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionCluster::min(self : SortcompareselectionCluster) -> Double { @_common.min(self.data) }

pub fn SortcompareselectionCluster::max(self : SortcompareselectionCluster) -> Double { @_common.max(self.data) }

pub fn SortcompareselectionCluster::to_string(self : SortcompareselectionCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_model_make(size : Int) -> SortcompareselectionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareselectionModel::len(self : SortcompareselectionModel) -> Int { self.size }

pub fn SortcompareselectionModel::get(self : SortcompareselectionModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareselectionModel::set(self : SortcompareselectionModel, i : Int, v : Double) -> SortcompareselectionModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareselectionModel::sum(self : SortcompareselectionModel) -> Double { @_common.sum(self.data) }

pub fn SortcompareselectionModel::mean(self : SortcompareselectionModel) -> Double { @_common.mean(self.data) }

pub fn SortcompareselectionModel::scale(self : SortcompareselectionModel, f : Double) -> SortcompareselectionModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionModel::add(self : SortcompareselectionModel, other : SortcompareselectionModel) -> SortcompareselectionModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareselectionModel::copy(self : SortcompareselectionModel) -> SortcompareselectionModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionModel::fill(self : SortcompareselectionModel, v : Double) -> SortcompareselectionModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionModel::min(self : SortcompareselectionModel) -> Double { @_common.min(self.data) }

pub fn SortcompareselectionModel::max(self : SortcompareselectionModel) -> Double { @_common.max(self.data) }

pub fn SortcompareselectionModel::to_string(self : SortcompareselectionModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_layer_make(size : Int) -> SortcompareselectionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareselectionLayer::len(self : SortcompareselectionLayer) -> Int { self.size }

pub fn SortcompareselectionLayer::get(self : SortcompareselectionLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareselectionLayer::set(self : SortcompareselectionLayer, i : Int, v : Double) -> SortcompareselectionLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareselectionLayer::sum(self : SortcompareselectionLayer) -> Double { @_common.sum(self.data) }

pub fn SortcompareselectionLayer::mean(self : SortcompareselectionLayer) -> Double { @_common.mean(self.data) }

pub fn SortcompareselectionLayer::scale(self : SortcompareselectionLayer, f : Double) -> SortcompareselectionLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionLayer::add(self : SortcompareselectionLayer, other : SortcompareselectionLayer) -> SortcompareselectionLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareselectionLayer::copy(self : SortcompareselectionLayer) -> SortcompareselectionLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionLayer::fill(self : SortcompareselectionLayer, v : Double) -> SortcompareselectionLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionLayer::min(self : SortcompareselectionLayer) -> Double { @_common.min(self.data) }

pub fn SortcompareselectionLayer::max(self : SortcompareselectionLayer) -> Double { @_common.max(self.data) }

pub fn SortcompareselectionLayer::to_string(self : SortcompareselectionLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_buffer_make(size : Int) -> SortcompareselectionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareselectionBuffer::len(self : SortcompareselectionBuffer) -> Int { self.size }

pub fn SortcompareselectionBuffer::get(self : SortcompareselectionBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareselectionBuffer::set(self : SortcompareselectionBuffer, i : Int, v : Double) -> SortcompareselectionBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareselectionBuffer::sum(self : SortcompareselectionBuffer) -> Double { @_common.sum(self.data) }

pub fn SortcompareselectionBuffer::mean(self : SortcompareselectionBuffer) -> Double { @_common.mean(self.data) }

pub fn SortcompareselectionBuffer::scale(self : SortcompareselectionBuffer, f : Double) -> SortcompareselectionBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionBuffer::add(self : SortcompareselectionBuffer, other : SortcompareselectionBuffer) -> SortcompareselectionBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareselectionBuffer::copy(self : SortcompareselectionBuffer) -> SortcompareselectionBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionBuffer::fill(self : SortcompareselectionBuffer, v : Double) -> SortcompareselectionBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionBuffer::min(self : SortcompareselectionBuffer) -> Double { @_common.min(self.data) }

pub fn SortcompareselectionBuffer::max(self : SortcompareselectionBuffer) -> Double { @_common.max(self.data) }

pub fn SortcompareselectionBuffer::to_string(self : SortcompareselectionBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_cursor_make(size : Int) -> SortcompareselectionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareselectionCursor::len(self : SortcompareselectionCursor) -> Int { self.size }

pub fn SortcompareselectionCursor::get(self : SortcompareselectionCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareselectionCursor::set(self : SortcompareselectionCursor, i : Int, v : Double) -> SortcompareselectionCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareselectionCursor::sum(self : SortcompareselectionCursor) -> Double { @_common.sum(self.data) }

pub fn SortcompareselectionCursor::mean(self : SortcompareselectionCursor) -> Double { @_common.mean(self.data) }

pub fn SortcompareselectionCursor::scale(self : SortcompareselectionCursor, f : Double) -> SortcompareselectionCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionCursor::add(self : SortcompareselectionCursor, other : SortcompareselectionCursor) -> SortcompareselectionCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareselectionCursor::copy(self : SortcompareselectionCursor) -> SortcompareselectionCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionCursor::fill(self : SortcompareselectionCursor, v : Double) -> SortcompareselectionCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionCursor::min(self : SortcompareselectionCursor) -> Double { @_common.min(self.data) }

pub fn SortcompareselectionCursor::max(self : SortcompareselectionCursor) -> Double { @_common.max(self.data) }

pub fn SortcompareselectionCursor::to_string(self : SortcompareselectionCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_view_make(size : Int) -> SortcompareselectionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareselectionView::len(self : SortcompareselectionView) -> Int { self.size }

pub fn SortcompareselectionView::get(self : SortcompareselectionView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareselectionView::set(self : SortcompareselectionView, i : Int, v : Double) -> SortcompareselectionView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareselectionView::sum(self : SortcompareselectionView) -> Double { @_common.sum(self.data) }

pub fn SortcompareselectionView::mean(self : SortcompareselectionView) -> Double { @_common.mean(self.data) }

pub fn SortcompareselectionView::scale(self : SortcompareselectionView, f : Double) -> SortcompareselectionView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionView::add(self : SortcompareselectionView, other : SortcompareselectionView) -> SortcompareselectionView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareselectionView::copy(self : SortcompareselectionView) -> SortcompareselectionView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionView::fill(self : SortcompareselectionView, v : Double) -> SortcompareselectionView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionView::min(self : SortcompareselectionView) -> Double { @_common.min(self.data) }

pub fn SortcompareselectionView::max(self : SortcompareselectionView) -> Double { @_common.max(self.data) }

pub fn SortcompareselectionView::to_string(self : SortcompareselectionView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_range_make(size : Int) -> SortcompareselectionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareselectionRange::len(self : SortcompareselectionRange) -> Int { self.size }

pub fn SortcompareselectionRange::get(self : SortcompareselectionRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareselectionRange::set(self : SortcompareselectionRange, i : Int, v : Double) -> SortcompareselectionRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareselectionRange::sum(self : SortcompareselectionRange) -> Double { @_common.sum(self.data) }

pub fn SortcompareselectionRange::mean(self : SortcompareselectionRange) -> Double { @_common.mean(self.data) }

pub fn SortcompareselectionRange::scale(self : SortcompareselectionRange, f : Double) -> SortcompareselectionRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionRange::add(self : SortcompareselectionRange, other : SortcompareselectionRange) -> SortcompareselectionRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareselectionRange::copy(self : SortcompareselectionRange) -> SortcompareselectionRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionRange::fill(self : SortcompareselectionRange, v : Double) -> SortcompareselectionRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionRange::min(self : SortcompareselectionRange) -> Double { @_common.min(self.data) }

pub fn SortcompareselectionRange::max(self : SortcompareselectionRange) -> Double { @_common.max(self.data) }

pub fn SortcompareselectionRange::to_string(self : SortcompareselectionRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcompareselectionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_selection_slice_make(size : Int) -> SortcompareselectionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcompareselectionSlice::len(self : SortcompareselectionSlice) -> Int { self.size }

pub fn SortcompareselectionSlice::get(self : SortcompareselectionSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcompareselectionSlice::set(self : SortcompareselectionSlice, i : Int, v : Double) -> SortcompareselectionSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcompareselectionSlice::sum(self : SortcompareselectionSlice) -> Double { @_common.sum(self.data) }

pub fn SortcompareselectionSlice::mean(self : SortcompareselectionSlice) -> Double { @_common.mean(self.data) }

pub fn SortcompareselectionSlice::scale(self : SortcompareselectionSlice, f : Double) -> SortcompareselectionSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionSlice::add(self : SortcompareselectionSlice, other : SortcompareselectionSlice) -> SortcompareselectionSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcompareselectionSlice::copy(self : SortcompareselectionSlice) -> SortcompareselectionSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionSlice::fill(self : SortcompareselectionSlice, v : Double) -> SortcompareselectionSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcompareselectionSlice::min(self : SortcompareselectionSlice) -> Double { @_common.min(self.data) }

pub fn SortcompareselectionSlice::max(self : SortcompareselectionSlice) -> Double { @_common.max(self.data) }

pub fn SortcompareselectionSlice::to_string(self : SortcompareselectionSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

