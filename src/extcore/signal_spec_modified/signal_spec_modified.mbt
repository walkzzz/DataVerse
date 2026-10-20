///===
/// extcore/signal_spec_modified

pub(all) struct SignalspecmodifiedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_spec_modified_make_point(x : Double, y : Double) -> SignalspecmodifiedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_spec_modified_make_point3(x : Double, y : Double, z : Double) -> SignalspecmodifiedPoint {
  { x, y, z, label: 0 }
}

pub fn SignalspecmodifiedPoint::x(self : SignalspecmodifiedPoint) -> Double { self.x }

pub fn SignalspecmodifiedPoint::y(self : SignalspecmodifiedPoint) -> Double { self.y }

pub fn SignalspecmodifiedPoint::z(self : SignalspecmodifiedPoint) -> Double { self.z }

pub fn SignalspecmodifiedPoint::label(self : SignalspecmodifiedPoint) -> Int { self.label }

pub fn SignalspecmodifiedPoint::dist(self : SignalspecmodifiedPoint, other : SignalspecmodifiedPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignalspecmodifiedPoint::add(self : SignalspecmodifiedPoint, other : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignalspecmodifiedPoint::sub(self : SignalspecmodifiedPoint, other : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignalspecmodifiedPoint::scale(self : SignalspecmodifiedPoint, s : Double) -> SignalspecmodifiedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignalspecmodifiedPoint::dot(self : SignalspecmodifiedPoint, other : SignalspecmodifiedPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignalspecmodifiedPoint::cross(self : SignalspecmodifiedPoint, other : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignalspecmodifiedPoint::norm(self : SignalspecmodifiedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignalspecmodifiedPoint::normalize(self : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecmodifiedPoint::negate(self : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignalspecmodifiedPoint::mid(self : SignalspecmodifiedPoint, other : SignalspecmodifiedPoint) -> SignalspecmodifiedPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignalspecmodifiedPoint::lerp(self : SignalspecmodifiedPoint, other : SignalspecmodifiedPoint, t : Double) -> SignalspecmodifiedPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignalspecmodifiedPoint::to_string(self : SignalspecmodifiedPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignalspecmodifiedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_spec_modified_make_series(vals : Array[Double], name : String) -> SignalspecmodifiedSeries {
  { vals, name, meta: 0 }
}

pub fn SignalspecmodifiedSeries::len(self : SignalspecmodifiedSeries) -> Int { self.vals.length() }

pub fn SignalspecmodifiedSeries::sum(self : SignalspecmodifiedSeries) -> Double { @_common.sum(self.vals) }

pub fn SignalspecmodifiedSeries::mean(self : SignalspecmodifiedSeries) -> Double { @_common.mean(self.vals) }

pub fn SignalspecmodifiedSeries::min(self : SignalspecmodifiedSeries) -> Double { @_common.min(self.vals) }

pub fn SignalspecmodifiedSeries::max(self : SignalspecmodifiedSeries) -> Double { @_common.max(self.vals) }

pub fn SignalspecmodifiedSeries::range(self : SignalspecmodifiedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignalspecmodifiedSeries::variance(self : SignalspecmodifiedSeries) -> Double { @_common.variance(self.vals) }

pub fn SignalspecmodifiedSeries::std(self : SignalspecmodifiedSeries) -> Double { @_common.std(self.vals) }

pub fn SignalspecmodifiedSeries::median(self : SignalspecmodifiedSeries) -> Double { @_common.median(self.vals) }

pub fn SignalspecmodifiedSeries::scale(self : SignalspecmodifiedSeries, f : Double) -> SignalspecmodifiedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignalspecmodifiedSeries::add(self : SignalspecmodifiedSeries, other : SignalspecmodifiedSeries) -> SignalspecmodifiedSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignalspecmodifiedSeries::sub(self : SignalspecmodifiedSeries, other : SignalspecmodifiedSeries) -> SignalspecmodifiedSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignalspecmodifiedSeries::normalize(self : SignalspecmodifiedSeries) -> SignalspecmodifiedSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignalspecmodifiedSeries::cumsum(self : SignalspecmodifiedSeries) -> SignalspecmodifiedSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignalspecmodifiedSeries::to_string(self : SignalspecmodifiedSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignalspecmodifiedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_spec_modified_make_matrix(rows : Int, cols : Int, val : Double) -> SignalspecmodifiedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_spec_modified_matrix_identity(n : Int) -> SignalspecmodifiedMatrix {
  let m = signal_spec_modified_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignalspecmodifiedMatrix::get(self : SignalspecmodifiedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignalspecmodifiedMatrix::transpose(self : SignalspecmodifiedMatrix) -> SignalspecmodifiedMatrix {
  let result = signal_spec_modified_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignalspecmodifiedMatrix::add(self : SignalspecmodifiedMatrix, other : SignalspecmodifiedMatrix) -> SignalspecmodifiedMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_spec_modified_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignalspecmodifiedMatrix::scale(self : SignalspecmodifiedMatrix, s : Double) -> SignalspecmodifiedMatrix {
  let result = signal_spec_modified_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignalspecmodifiedMatrix::multiply(self : SignalspecmodifiedMatrix, other : SignalspecmodifiedMatrix) -> SignalspecmodifiedMatrix {
  if self.cols != other.rows { return signal_spec_modified_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_spec_modified_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignalspecmodifiedMatrix::trace(self : SignalspecmodifiedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignalspecmodifiedMatrix::det(self : SignalspecmodifiedMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignalspecmodifiedMatrix::norm(self : SignalspecmodifiedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignalspecmodifiedMatrix::to_string(self : SignalspecmodifiedMatrix) -> String {
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

pub(all) struct SignalspecmodifiedVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_spec_modified_make_vector(comps : Array[Double]) -> SignalspecmodifiedVector {
  { comps, dim: comps.length() }
}

pub fn signal_spec_modified_vector_zero(dim : Int) -> SignalspecmodifiedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignalspecmodifiedVector::add(self : SignalspecmodifiedVector, other : SignalspecmodifiedVector) -> SignalspecmodifiedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecmodifiedVector::sub(self : SignalspecmodifiedVector, other : SignalspecmodifiedVector) -> SignalspecmodifiedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignalspecmodifiedVector::scale(self : SignalspecmodifiedVector, s : Double) -> SignalspecmodifiedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignalspecmodifiedVector::dot(self : SignalspecmodifiedVector, other : SignalspecmodifiedVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignalspecmodifiedVector::norm(self : SignalspecmodifiedVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignalspecmodifiedVector::normalize(self : SignalspecmodifiedVector) -> SignalspecmodifiedVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignalspecmodifiedVector::dist(self : SignalspecmodifiedVector, other : SignalspecmodifiedVector) -> Double {
  self.sub(other).norm()
}

pub fn SignalspecmodifiedVector::to_string(self : SignalspecmodifiedVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_spec_modified_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_spec_modified_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_spec_modified_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_spec_modified_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_spec_modified_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_spec_modified_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_spec_modified_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_spec_modified_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_spec_modified_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_spec_modified_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_spec_modified_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_spec_modified_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_spec_modified_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_spec_modified_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_spec_modified_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_spec_modified_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_spec_modified_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_spec_modified_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_spec_modified_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_spec_modified_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_spec_modified_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_spec_modified_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_spec_modified_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_spec_modified_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_spec_modified_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_spec_modified_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_spec_modified_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_spec_modified_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_spec_modified_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignalspecmodifiedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_frame_make(size : Int) -> SignalspecmodifiedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecmodifiedFrame::len(self : SignalspecmodifiedFrame) -> Int { self.size }

pub fn SignalspecmodifiedFrame::get(self : SignalspecmodifiedFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecmodifiedFrame::set(self : SignalspecmodifiedFrame, i : Int, v : Double) -> SignalspecmodifiedFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedFrame::sum(self : SignalspecmodifiedFrame) -> Double { @_common.sum(self.data) }

pub fn SignalspecmodifiedFrame::mean(self : SignalspecmodifiedFrame) -> Double { @_common.mean(self.data) }

pub fn SignalspecmodifiedFrame::scale(self : SignalspecmodifiedFrame, f : Double) -> SignalspecmodifiedFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedFrame::add(self : SignalspecmodifiedFrame, other : SignalspecmodifiedFrame) -> SignalspecmodifiedFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecmodifiedFrame::copy(self : SignalspecmodifiedFrame) -> SignalspecmodifiedFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedFrame::fill(self : SignalspecmodifiedFrame, v : Double) -> SignalspecmodifiedFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedFrame::min(self : SignalspecmodifiedFrame) -> Double { @_common.min(self.data) }

pub fn SignalspecmodifiedFrame::max(self : SignalspecmodifiedFrame) -> Double { @_common.max(self.data) }

pub fn SignalspecmodifiedFrame::to_string(self : SignalspecmodifiedFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_table_make(size : Int) -> SignalspecmodifiedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecmodifiedTable::len(self : SignalspecmodifiedTable) -> Int { self.size }

pub fn SignalspecmodifiedTable::get(self : SignalspecmodifiedTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecmodifiedTable::set(self : SignalspecmodifiedTable, i : Int, v : Double) -> SignalspecmodifiedTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedTable::sum(self : SignalspecmodifiedTable) -> Double { @_common.sum(self.data) }

pub fn SignalspecmodifiedTable::mean(self : SignalspecmodifiedTable) -> Double { @_common.mean(self.data) }

pub fn SignalspecmodifiedTable::scale(self : SignalspecmodifiedTable, f : Double) -> SignalspecmodifiedTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedTable::add(self : SignalspecmodifiedTable, other : SignalspecmodifiedTable) -> SignalspecmodifiedTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecmodifiedTable::copy(self : SignalspecmodifiedTable) -> SignalspecmodifiedTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedTable::fill(self : SignalspecmodifiedTable, v : Double) -> SignalspecmodifiedTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedTable::min(self : SignalspecmodifiedTable) -> Double { @_common.min(self.data) }

pub fn SignalspecmodifiedTable::max(self : SignalspecmodifiedTable) -> Double { @_common.max(self.data) }

pub fn SignalspecmodifiedTable::to_string(self : SignalspecmodifiedTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_graphn_make(size : Int) -> SignalspecmodifiedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecmodifiedGraphN::len(self : SignalspecmodifiedGraphN) -> Int { self.size }

pub fn SignalspecmodifiedGraphN::get(self : SignalspecmodifiedGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecmodifiedGraphN::set(self : SignalspecmodifiedGraphN, i : Int, v : Double) -> SignalspecmodifiedGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedGraphN::sum(self : SignalspecmodifiedGraphN) -> Double { @_common.sum(self.data) }

pub fn SignalspecmodifiedGraphN::mean(self : SignalspecmodifiedGraphN) -> Double { @_common.mean(self.data) }

pub fn SignalspecmodifiedGraphN::scale(self : SignalspecmodifiedGraphN, f : Double) -> SignalspecmodifiedGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedGraphN::add(self : SignalspecmodifiedGraphN, other : SignalspecmodifiedGraphN) -> SignalspecmodifiedGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecmodifiedGraphN::copy(self : SignalspecmodifiedGraphN) -> SignalspecmodifiedGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedGraphN::fill(self : SignalspecmodifiedGraphN, v : Double) -> SignalspecmodifiedGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedGraphN::min(self : SignalspecmodifiedGraphN) -> Double { @_common.min(self.data) }

pub fn SignalspecmodifiedGraphN::max(self : SignalspecmodifiedGraphN) -> Double { @_common.max(self.data) }

pub fn SignalspecmodifiedGraphN::to_string(self : SignalspecmodifiedGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_node_make(size : Int) -> SignalspecmodifiedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecmodifiedNode::len(self : SignalspecmodifiedNode) -> Int { self.size }

pub fn SignalspecmodifiedNode::get(self : SignalspecmodifiedNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecmodifiedNode::set(self : SignalspecmodifiedNode, i : Int, v : Double) -> SignalspecmodifiedNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedNode::sum(self : SignalspecmodifiedNode) -> Double { @_common.sum(self.data) }

pub fn SignalspecmodifiedNode::mean(self : SignalspecmodifiedNode) -> Double { @_common.mean(self.data) }

pub fn SignalspecmodifiedNode::scale(self : SignalspecmodifiedNode, f : Double) -> SignalspecmodifiedNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedNode::add(self : SignalspecmodifiedNode, other : SignalspecmodifiedNode) -> SignalspecmodifiedNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecmodifiedNode::copy(self : SignalspecmodifiedNode) -> SignalspecmodifiedNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedNode::fill(self : SignalspecmodifiedNode, v : Double) -> SignalspecmodifiedNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedNode::min(self : SignalspecmodifiedNode) -> Double { @_common.min(self.data) }

pub fn SignalspecmodifiedNode::max(self : SignalspecmodifiedNode) -> Double { @_common.max(self.data) }

pub fn SignalspecmodifiedNode::to_string(self : SignalspecmodifiedNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_edge_make(size : Int) -> SignalspecmodifiedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecmodifiedEdge::len(self : SignalspecmodifiedEdge) -> Int { self.size }

pub fn SignalspecmodifiedEdge::get(self : SignalspecmodifiedEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecmodifiedEdge::set(self : SignalspecmodifiedEdge, i : Int, v : Double) -> SignalspecmodifiedEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedEdge::sum(self : SignalspecmodifiedEdge) -> Double { @_common.sum(self.data) }

pub fn SignalspecmodifiedEdge::mean(self : SignalspecmodifiedEdge) -> Double { @_common.mean(self.data) }

pub fn SignalspecmodifiedEdge::scale(self : SignalspecmodifiedEdge, f : Double) -> SignalspecmodifiedEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedEdge::add(self : SignalspecmodifiedEdge, other : SignalspecmodifiedEdge) -> SignalspecmodifiedEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecmodifiedEdge::copy(self : SignalspecmodifiedEdge) -> SignalspecmodifiedEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedEdge::fill(self : SignalspecmodifiedEdge, v : Double) -> SignalspecmodifiedEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedEdge::min(self : SignalspecmodifiedEdge) -> Double { @_common.min(self.data) }

pub fn SignalspecmodifiedEdge::max(self : SignalspecmodifiedEdge) -> Double { @_common.max(self.data) }

pub fn SignalspecmodifiedEdge::to_string(self : SignalspecmodifiedEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_path_make(size : Int) -> SignalspecmodifiedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecmodifiedPath::len(self : SignalspecmodifiedPath) -> Int { self.size }

pub fn SignalspecmodifiedPath::get(self : SignalspecmodifiedPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecmodifiedPath::set(self : SignalspecmodifiedPath, i : Int, v : Double) -> SignalspecmodifiedPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedPath::sum(self : SignalspecmodifiedPath) -> Double { @_common.sum(self.data) }

pub fn SignalspecmodifiedPath::mean(self : SignalspecmodifiedPath) -> Double { @_common.mean(self.data) }

pub fn SignalspecmodifiedPath::scale(self : SignalspecmodifiedPath, f : Double) -> SignalspecmodifiedPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedPath::add(self : SignalspecmodifiedPath, other : SignalspecmodifiedPath) -> SignalspecmodifiedPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecmodifiedPath::copy(self : SignalspecmodifiedPath) -> SignalspecmodifiedPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedPath::fill(self : SignalspecmodifiedPath, v : Double) -> SignalspecmodifiedPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedPath::min(self : SignalspecmodifiedPath) -> Double { @_common.min(self.data) }

pub fn SignalspecmodifiedPath::max(self : SignalspecmodifiedPath) -> Double { @_common.max(self.data) }

pub fn SignalspecmodifiedPath::to_string(self : SignalspecmodifiedPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_cluster_make(size : Int) -> SignalspecmodifiedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecmodifiedCluster::len(self : SignalspecmodifiedCluster) -> Int { self.size }

pub fn SignalspecmodifiedCluster::get(self : SignalspecmodifiedCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecmodifiedCluster::set(self : SignalspecmodifiedCluster, i : Int, v : Double) -> SignalspecmodifiedCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedCluster::sum(self : SignalspecmodifiedCluster) -> Double { @_common.sum(self.data) }

pub fn SignalspecmodifiedCluster::mean(self : SignalspecmodifiedCluster) -> Double { @_common.mean(self.data) }

pub fn SignalspecmodifiedCluster::scale(self : SignalspecmodifiedCluster, f : Double) -> SignalspecmodifiedCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedCluster::add(self : SignalspecmodifiedCluster, other : SignalspecmodifiedCluster) -> SignalspecmodifiedCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecmodifiedCluster::copy(self : SignalspecmodifiedCluster) -> SignalspecmodifiedCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedCluster::fill(self : SignalspecmodifiedCluster, v : Double) -> SignalspecmodifiedCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedCluster::min(self : SignalspecmodifiedCluster) -> Double { @_common.min(self.data) }

pub fn SignalspecmodifiedCluster::max(self : SignalspecmodifiedCluster) -> Double { @_common.max(self.data) }

pub fn SignalspecmodifiedCluster::to_string(self : SignalspecmodifiedCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_model_make(size : Int) -> SignalspecmodifiedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecmodifiedModel::len(self : SignalspecmodifiedModel) -> Int { self.size }

pub fn SignalspecmodifiedModel::get(self : SignalspecmodifiedModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecmodifiedModel::set(self : SignalspecmodifiedModel, i : Int, v : Double) -> SignalspecmodifiedModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedModel::sum(self : SignalspecmodifiedModel) -> Double { @_common.sum(self.data) }

pub fn SignalspecmodifiedModel::mean(self : SignalspecmodifiedModel) -> Double { @_common.mean(self.data) }

pub fn SignalspecmodifiedModel::scale(self : SignalspecmodifiedModel, f : Double) -> SignalspecmodifiedModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedModel::add(self : SignalspecmodifiedModel, other : SignalspecmodifiedModel) -> SignalspecmodifiedModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecmodifiedModel::copy(self : SignalspecmodifiedModel) -> SignalspecmodifiedModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedModel::fill(self : SignalspecmodifiedModel, v : Double) -> SignalspecmodifiedModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedModel::min(self : SignalspecmodifiedModel) -> Double { @_common.min(self.data) }

pub fn SignalspecmodifiedModel::max(self : SignalspecmodifiedModel) -> Double { @_common.max(self.data) }

pub fn SignalspecmodifiedModel::to_string(self : SignalspecmodifiedModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_layer_make(size : Int) -> SignalspecmodifiedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecmodifiedLayer::len(self : SignalspecmodifiedLayer) -> Int { self.size }

pub fn SignalspecmodifiedLayer::get(self : SignalspecmodifiedLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecmodifiedLayer::set(self : SignalspecmodifiedLayer, i : Int, v : Double) -> SignalspecmodifiedLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedLayer::sum(self : SignalspecmodifiedLayer) -> Double { @_common.sum(self.data) }

pub fn SignalspecmodifiedLayer::mean(self : SignalspecmodifiedLayer) -> Double { @_common.mean(self.data) }

pub fn SignalspecmodifiedLayer::scale(self : SignalspecmodifiedLayer, f : Double) -> SignalspecmodifiedLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedLayer::add(self : SignalspecmodifiedLayer, other : SignalspecmodifiedLayer) -> SignalspecmodifiedLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecmodifiedLayer::copy(self : SignalspecmodifiedLayer) -> SignalspecmodifiedLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedLayer::fill(self : SignalspecmodifiedLayer, v : Double) -> SignalspecmodifiedLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedLayer::min(self : SignalspecmodifiedLayer) -> Double { @_common.min(self.data) }

pub fn SignalspecmodifiedLayer::max(self : SignalspecmodifiedLayer) -> Double { @_common.max(self.data) }

pub fn SignalspecmodifiedLayer::to_string(self : SignalspecmodifiedLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_buffer_make(size : Int) -> SignalspecmodifiedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecmodifiedBuffer::len(self : SignalspecmodifiedBuffer) -> Int { self.size }

pub fn SignalspecmodifiedBuffer::get(self : SignalspecmodifiedBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecmodifiedBuffer::set(self : SignalspecmodifiedBuffer, i : Int, v : Double) -> SignalspecmodifiedBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedBuffer::sum(self : SignalspecmodifiedBuffer) -> Double { @_common.sum(self.data) }

pub fn SignalspecmodifiedBuffer::mean(self : SignalspecmodifiedBuffer) -> Double { @_common.mean(self.data) }

pub fn SignalspecmodifiedBuffer::scale(self : SignalspecmodifiedBuffer, f : Double) -> SignalspecmodifiedBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedBuffer::add(self : SignalspecmodifiedBuffer, other : SignalspecmodifiedBuffer) -> SignalspecmodifiedBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecmodifiedBuffer::copy(self : SignalspecmodifiedBuffer) -> SignalspecmodifiedBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedBuffer::fill(self : SignalspecmodifiedBuffer, v : Double) -> SignalspecmodifiedBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedBuffer::min(self : SignalspecmodifiedBuffer) -> Double { @_common.min(self.data) }

pub fn SignalspecmodifiedBuffer::max(self : SignalspecmodifiedBuffer) -> Double { @_common.max(self.data) }

pub fn SignalspecmodifiedBuffer::to_string(self : SignalspecmodifiedBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_cursor_make(size : Int) -> SignalspecmodifiedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecmodifiedCursor::len(self : SignalspecmodifiedCursor) -> Int { self.size }

pub fn SignalspecmodifiedCursor::get(self : SignalspecmodifiedCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecmodifiedCursor::set(self : SignalspecmodifiedCursor, i : Int, v : Double) -> SignalspecmodifiedCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedCursor::sum(self : SignalspecmodifiedCursor) -> Double { @_common.sum(self.data) }

pub fn SignalspecmodifiedCursor::mean(self : SignalspecmodifiedCursor) -> Double { @_common.mean(self.data) }

pub fn SignalspecmodifiedCursor::scale(self : SignalspecmodifiedCursor, f : Double) -> SignalspecmodifiedCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedCursor::add(self : SignalspecmodifiedCursor, other : SignalspecmodifiedCursor) -> SignalspecmodifiedCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecmodifiedCursor::copy(self : SignalspecmodifiedCursor) -> SignalspecmodifiedCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedCursor::fill(self : SignalspecmodifiedCursor, v : Double) -> SignalspecmodifiedCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedCursor::min(self : SignalspecmodifiedCursor) -> Double { @_common.min(self.data) }

pub fn SignalspecmodifiedCursor::max(self : SignalspecmodifiedCursor) -> Double { @_common.max(self.data) }

pub fn SignalspecmodifiedCursor::to_string(self : SignalspecmodifiedCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_view_make(size : Int) -> SignalspecmodifiedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecmodifiedView::len(self : SignalspecmodifiedView) -> Int { self.size }

pub fn SignalspecmodifiedView::get(self : SignalspecmodifiedView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecmodifiedView::set(self : SignalspecmodifiedView, i : Int, v : Double) -> SignalspecmodifiedView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedView::sum(self : SignalspecmodifiedView) -> Double { @_common.sum(self.data) }

pub fn SignalspecmodifiedView::mean(self : SignalspecmodifiedView) -> Double { @_common.mean(self.data) }

pub fn SignalspecmodifiedView::scale(self : SignalspecmodifiedView, f : Double) -> SignalspecmodifiedView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedView::add(self : SignalspecmodifiedView, other : SignalspecmodifiedView) -> SignalspecmodifiedView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecmodifiedView::copy(self : SignalspecmodifiedView) -> SignalspecmodifiedView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedView::fill(self : SignalspecmodifiedView, v : Double) -> SignalspecmodifiedView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedView::min(self : SignalspecmodifiedView) -> Double { @_common.min(self.data) }

pub fn SignalspecmodifiedView::max(self : SignalspecmodifiedView) -> Double { @_common.max(self.data) }

pub fn SignalspecmodifiedView::to_string(self : SignalspecmodifiedView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_range_make(size : Int) -> SignalspecmodifiedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecmodifiedRange::len(self : SignalspecmodifiedRange) -> Int { self.size }

pub fn SignalspecmodifiedRange::get(self : SignalspecmodifiedRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecmodifiedRange::set(self : SignalspecmodifiedRange, i : Int, v : Double) -> SignalspecmodifiedRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedRange::sum(self : SignalspecmodifiedRange) -> Double { @_common.sum(self.data) }

pub fn SignalspecmodifiedRange::mean(self : SignalspecmodifiedRange) -> Double { @_common.mean(self.data) }

pub fn SignalspecmodifiedRange::scale(self : SignalspecmodifiedRange, f : Double) -> SignalspecmodifiedRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedRange::add(self : SignalspecmodifiedRange, other : SignalspecmodifiedRange) -> SignalspecmodifiedRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecmodifiedRange::copy(self : SignalspecmodifiedRange) -> SignalspecmodifiedRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedRange::fill(self : SignalspecmodifiedRange, v : Double) -> SignalspecmodifiedRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedRange::min(self : SignalspecmodifiedRange) -> Double { @_common.min(self.data) }

pub fn SignalspecmodifiedRange::max(self : SignalspecmodifiedRange) -> Double { @_common.max(self.data) }

pub fn SignalspecmodifiedRange::to_string(self : SignalspecmodifiedRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignalspecmodifiedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_spec_modified_slice_make(size : Int) -> SignalspecmodifiedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignalspecmodifiedSlice::len(self : SignalspecmodifiedSlice) -> Int { self.size }

pub fn SignalspecmodifiedSlice::get(self : SignalspecmodifiedSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignalspecmodifiedSlice::set(self : SignalspecmodifiedSlice, i : Int, v : Double) -> SignalspecmodifiedSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedSlice::sum(self : SignalspecmodifiedSlice) -> Double { @_common.sum(self.data) }

pub fn SignalspecmodifiedSlice::mean(self : SignalspecmodifiedSlice) -> Double { @_common.mean(self.data) }

pub fn SignalspecmodifiedSlice::scale(self : SignalspecmodifiedSlice, f : Double) -> SignalspecmodifiedSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedSlice::add(self : SignalspecmodifiedSlice, other : SignalspecmodifiedSlice) -> SignalspecmodifiedSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignalspecmodifiedSlice::copy(self : SignalspecmodifiedSlice) -> SignalspecmodifiedSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedSlice::fill(self : SignalspecmodifiedSlice, v : Double) -> SignalspecmodifiedSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignalspecmodifiedSlice::min(self : SignalspecmodifiedSlice) -> Double { @_common.min(self.data) }

pub fn SignalspecmodifiedSlice::max(self : SignalspecmodifiedSlice) -> Double { @_common.max(self.data) }

pub fn SignalspecmodifiedSlice::to_string(self : SignalspecmodifiedSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

