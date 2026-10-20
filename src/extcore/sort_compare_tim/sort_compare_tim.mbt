///===
/// extcore/sort_compare_tim

pub(all) struct SortcomparetimPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_tim_make_point(x : Double, y : Double) -> SortcomparetimPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_tim_make_point3(x : Double, y : Double, z : Double) -> SortcomparetimPoint {
  { x, y, z, label: 0 }
}

pub fn SortcomparetimPoint::x(self : SortcomparetimPoint) -> Double { self.x }

pub fn SortcomparetimPoint::y(self : SortcomparetimPoint) -> Double { self.y }

pub fn SortcomparetimPoint::z(self : SortcomparetimPoint) -> Double { self.z }

pub fn SortcomparetimPoint::label(self : SortcomparetimPoint) -> Int { self.label }

pub fn SortcomparetimPoint::dist(self : SortcomparetimPoint, other : SortcomparetimPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcomparetimPoint::add(self : SortcomparetimPoint, other : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcomparetimPoint::sub(self : SortcomparetimPoint, other : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcomparetimPoint::scale(self : SortcomparetimPoint, s : Double) -> SortcomparetimPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcomparetimPoint::dot(self : SortcomparetimPoint, other : SortcomparetimPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcomparetimPoint::cross(self : SortcomparetimPoint, other : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcomparetimPoint::norm(self : SortcomparetimPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcomparetimPoint::normalize(self : SortcomparetimPoint) -> SortcomparetimPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparetimPoint::negate(self : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcomparetimPoint::mid(self : SortcomparetimPoint, other : SortcomparetimPoint) -> SortcomparetimPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcomparetimPoint::lerp(self : SortcomparetimPoint, other : SortcomparetimPoint, t : Double) -> SortcomparetimPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcomparetimPoint::to_string(self : SortcomparetimPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcomparetimSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_tim_make_series(vals : Array[Double], name : String) -> SortcomparetimSeries {
  { vals, name, meta: 0 }
}

pub fn SortcomparetimSeries::len(self : SortcomparetimSeries) -> Int { self.vals.length() }

pub fn SortcomparetimSeries::sum(self : SortcomparetimSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcomparetimSeries::mean(self : SortcomparetimSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcomparetimSeries::min(self : SortcomparetimSeries) -> Double { @_common.min(self.vals) }

pub fn SortcomparetimSeries::max(self : SortcomparetimSeries) -> Double { @_common.max(self.vals) }

pub fn SortcomparetimSeries::range(self : SortcomparetimSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcomparetimSeries::variance(self : SortcomparetimSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcomparetimSeries::std(self : SortcomparetimSeries) -> Double { @_common.std(self.vals) }

pub fn SortcomparetimSeries::median(self : SortcomparetimSeries) -> Double { @_common.median(self.vals) }

pub fn SortcomparetimSeries::scale(self : SortcomparetimSeries, f : Double) -> SortcomparetimSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcomparetimSeries::add(self : SortcomparetimSeries, other : SortcomparetimSeries) -> SortcomparetimSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcomparetimSeries::sub(self : SortcomparetimSeries, other : SortcomparetimSeries) -> SortcomparetimSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcomparetimSeries::normalize(self : SortcomparetimSeries) -> SortcomparetimSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcomparetimSeries::cumsum(self : SortcomparetimSeries) -> SortcomparetimSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcomparetimSeries::to_string(self : SortcomparetimSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparetimMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_tim_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparetimMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_tim_matrix_identity(n : Int) -> SortcomparetimMatrix {
  let m = sort_compare_tim_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcomparetimMatrix::get(self : SortcomparetimMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcomparetimMatrix::transpose(self : SortcomparetimMatrix) -> SortcomparetimMatrix {
  let result = sort_compare_tim_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcomparetimMatrix::add(self : SortcomparetimMatrix, other : SortcomparetimMatrix) -> SortcomparetimMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_tim_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcomparetimMatrix::scale(self : SortcomparetimMatrix, s : Double) -> SortcomparetimMatrix {
  let result = sort_compare_tim_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcomparetimMatrix::multiply(self : SortcomparetimMatrix, other : SortcomparetimMatrix) -> SortcomparetimMatrix {
  if self.cols != other.rows { return sort_compare_tim_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_tim_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcomparetimMatrix::trace(self : SortcomparetimMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcomparetimMatrix::det(self : SortcomparetimMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcomparetimMatrix::norm(self : SortcomparetimMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcomparetimMatrix::to_string(self : SortcomparetimMatrix) -> String {
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

pub(all) struct SortcomparetimVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_tim_make_vector(comps : Array[Double]) -> SortcomparetimVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_tim_vector_zero(dim : Int) -> SortcomparetimVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcomparetimVector::add(self : SortcomparetimVector, other : SortcomparetimVector) -> SortcomparetimVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparetimVector::sub(self : SortcomparetimVector, other : SortcomparetimVector) -> SortcomparetimVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparetimVector::scale(self : SortcomparetimVector, s : Double) -> SortcomparetimVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcomparetimVector::dot(self : SortcomparetimVector, other : SortcomparetimVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcomparetimVector::norm(self : SortcomparetimVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcomparetimVector::normalize(self : SortcomparetimVector) -> SortcomparetimVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparetimVector::dist(self : SortcomparetimVector, other : SortcomparetimVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcomparetimVector::to_string(self : SortcomparetimVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_tim_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_tim_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_tim_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_tim_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_tim_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_tim_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_tim_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_tim_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_tim_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_tim_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_tim_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_tim_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_tim_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_tim_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_tim_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_tim_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_tim_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_tim_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_tim_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_tim_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_tim_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_tim_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_tim_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_tim_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_tim_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_tim_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_tim_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_tim_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_tim_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcomparetimFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_frame_make(size : Int) -> SortcomparetimFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparetimFrame::len(self : SortcomparetimFrame) -> Int { self.size }

pub fn SortcomparetimFrame::get(self : SortcomparetimFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparetimFrame::set(self : SortcomparetimFrame, i : Int, v : Double) -> SortcomparetimFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparetimFrame::sum(self : SortcomparetimFrame) -> Double { @_common.sum(self.data) }

pub fn SortcomparetimFrame::mean(self : SortcomparetimFrame) -> Double { @_common.mean(self.data) }

pub fn SortcomparetimFrame::scale(self : SortcomparetimFrame, f : Double) -> SortcomparetimFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparetimFrame::add(self : SortcomparetimFrame, other : SortcomparetimFrame) -> SortcomparetimFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparetimFrame::copy(self : SortcomparetimFrame) -> SortcomparetimFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparetimFrame::fill(self : SortcomparetimFrame, v : Double) -> SortcomparetimFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparetimFrame::min(self : SortcomparetimFrame) -> Double { @_common.min(self.data) }

pub fn SortcomparetimFrame::max(self : SortcomparetimFrame) -> Double { @_common.max(self.data) }

pub fn SortcomparetimFrame::to_string(self : SortcomparetimFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparetimTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_table_make(size : Int) -> SortcomparetimTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparetimTable::len(self : SortcomparetimTable) -> Int { self.size }

pub fn SortcomparetimTable::get(self : SortcomparetimTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparetimTable::set(self : SortcomparetimTable, i : Int, v : Double) -> SortcomparetimTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparetimTable::sum(self : SortcomparetimTable) -> Double { @_common.sum(self.data) }

pub fn SortcomparetimTable::mean(self : SortcomparetimTable) -> Double { @_common.mean(self.data) }

pub fn SortcomparetimTable::scale(self : SortcomparetimTable, f : Double) -> SortcomparetimTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparetimTable::add(self : SortcomparetimTable, other : SortcomparetimTable) -> SortcomparetimTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparetimTable::copy(self : SortcomparetimTable) -> SortcomparetimTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparetimTable::fill(self : SortcomparetimTable, v : Double) -> SortcomparetimTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparetimTable::min(self : SortcomparetimTable) -> Double { @_common.min(self.data) }

pub fn SortcomparetimTable::max(self : SortcomparetimTable) -> Double { @_common.max(self.data) }

pub fn SortcomparetimTable::to_string(self : SortcomparetimTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparetimGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_graphn_make(size : Int) -> SortcomparetimGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparetimGraphN::len(self : SortcomparetimGraphN) -> Int { self.size }

pub fn SortcomparetimGraphN::get(self : SortcomparetimGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparetimGraphN::set(self : SortcomparetimGraphN, i : Int, v : Double) -> SortcomparetimGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparetimGraphN::sum(self : SortcomparetimGraphN) -> Double { @_common.sum(self.data) }

pub fn SortcomparetimGraphN::mean(self : SortcomparetimGraphN) -> Double { @_common.mean(self.data) }

pub fn SortcomparetimGraphN::scale(self : SortcomparetimGraphN, f : Double) -> SortcomparetimGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparetimGraphN::add(self : SortcomparetimGraphN, other : SortcomparetimGraphN) -> SortcomparetimGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparetimGraphN::copy(self : SortcomparetimGraphN) -> SortcomparetimGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparetimGraphN::fill(self : SortcomparetimGraphN, v : Double) -> SortcomparetimGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparetimGraphN::min(self : SortcomparetimGraphN) -> Double { @_common.min(self.data) }

pub fn SortcomparetimGraphN::max(self : SortcomparetimGraphN) -> Double { @_common.max(self.data) }

pub fn SortcomparetimGraphN::to_string(self : SortcomparetimGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparetimNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_node_make(size : Int) -> SortcomparetimNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparetimNode::len(self : SortcomparetimNode) -> Int { self.size }

pub fn SortcomparetimNode::get(self : SortcomparetimNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparetimNode::set(self : SortcomparetimNode, i : Int, v : Double) -> SortcomparetimNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparetimNode::sum(self : SortcomparetimNode) -> Double { @_common.sum(self.data) }

pub fn SortcomparetimNode::mean(self : SortcomparetimNode) -> Double { @_common.mean(self.data) }

pub fn SortcomparetimNode::scale(self : SortcomparetimNode, f : Double) -> SortcomparetimNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparetimNode::add(self : SortcomparetimNode, other : SortcomparetimNode) -> SortcomparetimNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparetimNode::copy(self : SortcomparetimNode) -> SortcomparetimNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparetimNode::fill(self : SortcomparetimNode, v : Double) -> SortcomparetimNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparetimNode::min(self : SortcomparetimNode) -> Double { @_common.min(self.data) }

pub fn SortcomparetimNode::max(self : SortcomparetimNode) -> Double { @_common.max(self.data) }

pub fn SortcomparetimNode::to_string(self : SortcomparetimNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparetimEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_edge_make(size : Int) -> SortcomparetimEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparetimEdge::len(self : SortcomparetimEdge) -> Int { self.size }

pub fn SortcomparetimEdge::get(self : SortcomparetimEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparetimEdge::set(self : SortcomparetimEdge, i : Int, v : Double) -> SortcomparetimEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparetimEdge::sum(self : SortcomparetimEdge) -> Double { @_common.sum(self.data) }

pub fn SortcomparetimEdge::mean(self : SortcomparetimEdge) -> Double { @_common.mean(self.data) }

pub fn SortcomparetimEdge::scale(self : SortcomparetimEdge, f : Double) -> SortcomparetimEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparetimEdge::add(self : SortcomparetimEdge, other : SortcomparetimEdge) -> SortcomparetimEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparetimEdge::copy(self : SortcomparetimEdge) -> SortcomparetimEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparetimEdge::fill(self : SortcomparetimEdge, v : Double) -> SortcomparetimEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparetimEdge::min(self : SortcomparetimEdge) -> Double { @_common.min(self.data) }

pub fn SortcomparetimEdge::max(self : SortcomparetimEdge) -> Double { @_common.max(self.data) }

pub fn SortcomparetimEdge::to_string(self : SortcomparetimEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparetimPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_path_make(size : Int) -> SortcomparetimPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparetimPath::len(self : SortcomparetimPath) -> Int { self.size }

pub fn SortcomparetimPath::get(self : SortcomparetimPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparetimPath::set(self : SortcomparetimPath, i : Int, v : Double) -> SortcomparetimPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparetimPath::sum(self : SortcomparetimPath) -> Double { @_common.sum(self.data) }

pub fn SortcomparetimPath::mean(self : SortcomparetimPath) -> Double { @_common.mean(self.data) }

pub fn SortcomparetimPath::scale(self : SortcomparetimPath, f : Double) -> SortcomparetimPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparetimPath::add(self : SortcomparetimPath, other : SortcomparetimPath) -> SortcomparetimPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparetimPath::copy(self : SortcomparetimPath) -> SortcomparetimPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparetimPath::fill(self : SortcomparetimPath, v : Double) -> SortcomparetimPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparetimPath::min(self : SortcomparetimPath) -> Double { @_common.min(self.data) }

pub fn SortcomparetimPath::max(self : SortcomparetimPath) -> Double { @_common.max(self.data) }

pub fn SortcomparetimPath::to_string(self : SortcomparetimPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparetimCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_cluster_make(size : Int) -> SortcomparetimCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparetimCluster::len(self : SortcomparetimCluster) -> Int { self.size }

pub fn SortcomparetimCluster::get(self : SortcomparetimCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparetimCluster::set(self : SortcomparetimCluster, i : Int, v : Double) -> SortcomparetimCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparetimCluster::sum(self : SortcomparetimCluster) -> Double { @_common.sum(self.data) }

pub fn SortcomparetimCluster::mean(self : SortcomparetimCluster) -> Double { @_common.mean(self.data) }

pub fn SortcomparetimCluster::scale(self : SortcomparetimCluster, f : Double) -> SortcomparetimCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparetimCluster::add(self : SortcomparetimCluster, other : SortcomparetimCluster) -> SortcomparetimCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparetimCluster::copy(self : SortcomparetimCluster) -> SortcomparetimCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparetimCluster::fill(self : SortcomparetimCluster, v : Double) -> SortcomparetimCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparetimCluster::min(self : SortcomparetimCluster) -> Double { @_common.min(self.data) }

pub fn SortcomparetimCluster::max(self : SortcomparetimCluster) -> Double { @_common.max(self.data) }

pub fn SortcomparetimCluster::to_string(self : SortcomparetimCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparetimModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_model_make(size : Int) -> SortcomparetimModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparetimModel::len(self : SortcomparetimModel) -> Int { self.size }

pub fn SortcomparetimModel::get(self : SortcomparetimModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparetimModel::set(self : SortcomparetimModel, i : Int, v : Double) -> SortcomparetimModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparetimModel::sum(self : SortcomparetimModel) -> Double { @_common.sum(self.data) }

pub fn SortcomparetimModel::mean(self : SortcomparetimModel) -> Double { @_common.mean(self.data) }

pub fn SortcomparetimModel::scale(self : SortcomparetimModel, f : Double) -> SortcomparetimModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparetimModel::add(self : SortcomparetimModel, other : SortcomparetimModel) -> SortcomparetimModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparetimModel::copy(self : SortcomparetimModel) -> SortcomparetimModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparetimModel::fill(self : SortcomparetimModel, v : Double) -> SortcomparetimModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparetimModel::min(self : SortcomparetimModel) -> Double { @_common.min(self.data) }

pub fn SortcomparetimModel::max(self : SortcomparetimModel) -> Double { @_common.max(self.data) }

pub fn SortcomparetimModel::to_string(self : SortcomparetimModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparetimLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_layer_make(size : Int) -> SortcomparetimLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparetimLayer::len(self : SortcomparetimLayer) -> Int { self.size }

pub fn SortcomparetimLayer::get(self : SortcomparetimLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparetimLayer::set(self : SortcomparetimLayer, i : Int, v : Double) -> SortcomparetimLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparetimLayer::sum(self : SortcomparetimLayer) -> Double { @_common.sum(self.data) }

pub fn SortcomparetimLayer::mean(self : SortcomparetimLayer) -> Double { @_common.mean(self.data) }

pub fn SortcomparetimLayer::scale(self : SortcomparetimLayer, f : Double) -> SortcomparetimLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparetimLayer::add(self : SortcomparetimLayer, other : SortcomparetimLayer) -> SortcomparetimLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparetimLayer::copy(self : SortcomparetimLayer) -> SortcomparetimLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparetimLayer::fill(self : SortcomparetimLayer, v : Double) -> SortcomparetimLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparetimLayer::min(self : SortcomparetimLayer) -> Double { @_common.min(self.data) }

pub fn SortcomparetimLayer::max(self : SortcomparetimLayer) -> Double { @_common.max(self.data) }

pub fn SortcomparetimLayer::to_string(self : SortcomparetimLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparetimBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_buffer_make(size : Int) -> SortcomparetimBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparetimBuffer::len(self : SortcomparetimBuffer) -> Int { self.size }

pub fn SortcomparetimBuffer::get(self : SortcomparetimBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparetimBuffer::set(self : SortcomparetimBuffer, i : Int, v : Double) -> SortcomparetimBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparetimBuffer::sum(self : SortcomparetimBuffer) -> Double { @_common.sum(self.data) }

pub fn SortcomparetimBuffer::mean(self : SortcomparetimBuffer) -> Double { @_common.mean(self.data) }

pub fn SortcomparetimBuffer::scale(self : SortcomparetimBuffer, f : Double) -> SortcomparetimBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparetimBuffer::add(self : SortcomparetimBuffer, other : SortcomparetimBuffer) -> SortcomparetimBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparetimBuffer::copy(self : SortcomparetimBuffer) -> SortcomparetimBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparetimBuffer::fill(self : SortcomparetimBuffer, v : Double) -> SortcomparetimBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparetimBuffer::min(self : SortcomparetimBuffer) -> Double { @_common.min(self.data) }

pub fn SortcomparetimBuffer::max(self : SortcomparetimBuffer) -> Double { @_common.max(self.data) }

pub fn SortcomparetimBuffer::to_string(self : SortcomparetimBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparetimCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_cursor_make(size : Int) -> SortcomparetimCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparetimCursor::len(self : SortcomparetimCursor) -> Int { self.size }

pub fn SortcomparetimCursor::get(self : SortcomparetimCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparetimCursor::set(self : SortcomparetimCursor, i : Int, v : Double) -> SortcomparetimCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparetimCursor::sum(self : SortcomparetimCursor) -> Double { @_common.sum(self.data) }

pub fn SortcomparetimCursor::mean(self : SortcomparetimCursor) -> Double { @_common.mean(self.data) }

pub fn SortcomparetimCursor::scale(self : SortcomparetimCursor, f : Double) -> SortcomparetimCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparetimCursor::add(self : SortcomparetimCursor, other : SortcomparetimCursor) -> SortcomparetimCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparetimCursor::copy(self : SortcomparetimCursor) -> SortcomparetimCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparetimCursor::fill(self : SortcomparetimCursor, v : Double) -> SortcomparetimCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparetimCursor::min(self : SortcomparetimCursor) -> Double { @_common.min(self.data) }

pub fn SortcomparetimCursor::max(self : SortcomparetimCursor) -> Double { @_common.max(self.data) }

pub fn SortcomparetimCursor::to_string(self : SortcomparetimCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparetimView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_view_make(size : Int) -> SortcomparetimView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparetimView::len(self : SortcomparetimView) -> Int { self.size }

pub fn SortcomparetimView::get(self : SortcomparetimView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparetimView::set(self : SortcomparetimView, i : Int, v : Double) -> SortcomparetimView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparetimView::sum(self : SortcomparetimView) -> Double { @_common.sum(self.data) }

pub fn SortcomparetimView::mean(self : SortcomparetimView) -> Double { @_common.mean(self.data) }

pub fn SortcomparetimView::scale(self : SortcomparetimView, f : Double) -> SortcomparetimView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparetimView::add(self : SortcomparetimView, other : SortcomparetimView) -> SortcomparetimView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparetimView::copy(self : SortcomparetimView) -> SortcomparetimView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparetimView::fill(self : SortcomparetimView, v : Double) -> SortcomparetimView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparetimView::min(self : SortcomparetimView) -> Double { @_common.min(self.data) }

pub fn SortcomparetimView::max(self : SortcomparetimView) -> Double { @_common.max(self.data) }

pub fn SortcomparetimView::to_string(self : SortcomparetimView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparetimRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_range_make(size : Int) -> SortcomparetimRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparetimRange::len(self : SortcomparetimRange) -> Int { self.size }

pub fn SortcomparetimRange::get(self : SortcomparetimRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparetimRange::set(self : SortcomparetimRange, i : Int, v : Double) -> SortcomparetimRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparetimRange::sum(self : SortcomparetimRange) -> Double { @_common.sum(self.data) }

pub fn SortcomparetimRange::mean(self : SortcomparetimRange) -> Double { @_common.mean(self.data) }

pub fn SortcomparetimRange::scale(self : SortcomparetimRange, f : Double) -> SortcomparetimRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparetimRange::add(self : SortcomparetimRange, other : SortcomparetimRange) -> SortcomparetimRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparetimRange::copy(self : SortcomparetimRange) -> SortcomparetimRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparetimRange::fill(self : SortcomparetimRange, v : Double) -> SortcomparetimRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparetimRange::min(self : SortcomparetimRange) -> Double { @_common.min(self.data) }

pub fn SortcomparetimRange::max(self : SortcomparetimRange) -> Double { @_common.max(self.data) }

pub fn SortcomparetimRange::to_string(self : SortcomparetimRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortcomparetimSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_tim_slice_make(size : Int) -> SortcomparetimSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortcomparetimSlice::len(self : SortcomparetimSlice) -> Int { self.size }

pub fn SortcomparetimSlice::get(self : SortcomparetimSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortcomparetimSlice::set(self : SortcomparetimSlice, i : Int, v : Double) -> SortcomparetimSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortcomparetimSlice::sum(self : SortcomparetimSlice) -> Double { @_common.sum(self.data) }

pub fn SortcomparetimSlice::mean(self : SortcomparetimSlice) -> Double { @_common.mean(self.data) }

pub fn SortcomparetimSlice::scale(self : SortcomparetimSlice, f : Double) -> SortcomparetimSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortcomparetimSlice::add(self : SortcomparetimSlice, other : SortcomparetimSlice) -> SortcomparetimSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortcomparetimSlice::copy(self : SortcomparetimSlice) -> SortcomparetimSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortcomparetimSlice::fill(self : SortcomparetimSlice, v : Double) -> SortcomparetimSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortcomparetimSlice::min(self : SortcomparetimSlice) -> Double { @_common.min(self.data) }

pub fn SortcomparetimSlice::max(self : SortcomparetimSlice) -> Double { @_common.max(self.data) }

pub fn SortcomparetimSlice::to_string(self : SortcomparetimSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

