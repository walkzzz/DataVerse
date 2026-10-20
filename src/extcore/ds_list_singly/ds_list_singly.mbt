///===
/// extcore/ds_list_singly

pub(all) struct DslistsinglyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_singly_make_point(x : Double, y : Double) -> DslistsinglyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_singly_make_point3(x : Double, y : Double, z : Double) -> DslistsinglyPoint {
  { x, y, z, label: 0 }
}

pub fn DslistsinglyPoint::x(self : DslistsinglyPoint) -> Double { self.x }

pub fn DslistsinglyPoint::y(self : DslistsinglyPoint) -> Double { self.y }

pub fn DslistsinglyPoint::z(self : DslistsinglyPoint) -> Double { self.z }

pub fn DslistsinglyPoint::label(self : DslistsinglyPoint) -> Int { self.label }

pub fn DslistsinglyPoint::dist(self : DslistsinglyPoint, other : DslistsinglyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistsinglyPoint::add(self : DslistsinglyPoint, other : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistsinglyPoint::sub(self : DslistsinglyPoint, other : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistsinglyPoint::scale(self : DslistsinglyPoint, s : Double) -> DslistsinglyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistsinglyPoint::dot(self : DslistsinglyPoint, other : DslistsinglyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistsinglyPoint::cross(self : DslistsinglyPoint, other : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistsinglyPoint::norm(self : DslistsinglyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistsinglyPoint::normalize(self : DslistsinglyPoint) -> DslistsinglyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistsinglyPoint::negate(self : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistsinglyPoint::mid(self : DslistsinglyPoint, other : DslistsinglyPoint) -> DslistsinglyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistsinglyPoint::lerp(self : DslistsinglyPoint, other : DslistsinglyPoint, t : Double) -> DslistsinglyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistsinglyPoint::to_string(self : DslistsinglyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistsinglySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_singly_make_series(vals : Array[Double], name : String) -> DslistsinglySeries {
  { vals, name, meta: 0 }
}

pub fn DslistsinglySeries::len(self : DslistsinglySeries) -> Int { self.vals.length() }

pub fn DslistsinglySeries::sum(self : DslistsinglySeries) -> Double { @_common.sum(self.vals) }

pub fn DslistsinglySeries::mean(self : DslistsinglySeries) -> Double { @_common.mean(self.vals) }

pub fn DslistsinglySeries::min(self : DslistsinglySeries) -> Double { @_common.min(self.vals) }

pub fn DslistsinglySeries::max(self : DslistsinglySeries) -> Double { @_common.max(self.vals) }

pub fn DslistsinglySeries::range(self : DslistsinglySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistsinglySeries::variance(self : DslistsinglySeries) -> Double { @_common.variance(self.vals) }

pub fn DslistsinglySeries::std(self : DslistsinglySeries) -> Double { @_common.std(self.vals) }

pub fn DslistsinglySeries::median(self : DslistsinglySeries) -> Double { @_common.median(self.vals) }

pub fn DslistsinglySeries::scale(self : DslistsinglySeries, f : Double) -> DslistsinglySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistsinglySeries::add(self : DslistsinglySeries, other : DslistsinglySeries) -> DslistsinglySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistsinglySeries::sub(self : DslistsinglySeries, other : DslistsinglySeries) -> DslistsinglySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistsinglySeries::normalize(self : DslistsinglySeries) -> DslistsinglySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistsinglySeries::cumsum(self : DslistsinglySeries) -> DslistsinglySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistsinglySeries::to_string(self : DslistsinglySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistsinglyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_singly_make_matrix(rows : Int, cols : Int, val : Double) -> DslistsinglyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_singly_matrix_identity(n : Int) -> DslistsinglyMatrix {
  let m = ds_list_singly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistsinglyMatrix::get(self : DslistsinglyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistsinglyMatrix::transpose(self : DslistsinglyMatrix) -> DslistsinglyMatrix {
  let result = ds_list_singly_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistsinglyMatrix::add(self : DslistsinglyMatrix, other : DslistsinglyMatrix) -> DslistsinglyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_singly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistsinglyMatrix::scale(self : DslistsinglyMatrix, s : Double) -> DslistsinglyMatrix {
  let result = ds_list_singly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistsinglyMatrix::multiply(self : DslistsinglyMatrix, other : DslistsinglyMatrix) -> DslistsinglyMatrix {
  if self.cols != other.rows { return ds_list_singly_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_singly_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistsinglyMatrix::trace(self : DslistsinglyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistsinglyMatrix::det(self : DslistsinglyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistsinglyMatrix::norm(self : DslistsinglyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistsinglyMatrix::to_string(self : DslistsinglyMatrix) -> String {
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

pub(all) struct DslistsinglyVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_singly_make_vector(comps : Array[Double]) -> DslistsinglyVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_singly_vector_zero(dim : Int) -> DslistsinglyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistsinglyVector::add(self : DslistsinglyVector, other : DslistsinglyVector) -> DslistsinglyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistsinglyVector::sub(self : DslistsinglyVector, other : DslistsinglyVector) -> DslistsinglyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistsinglyVector::scale(self : DslistsinglyVector, s : Double) -> DslistsinglyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistsinglyVector::dot(self : DslistsinglyVector, other : DslistsinglyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistsinglyVector::norm(self : DslistsinglyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistsinglyVector::normalize(self : DslistsinglyVector) -> DslistsinglyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistsinglyVector::dist(self : DslistsinglyVector, other : DslistsinglyVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistsinglyVector::to_string(self : DslistsinglyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_singly_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_singly_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_singly_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_singly_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_singly_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_singly_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_singly_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_singly_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_singly_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_singly_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_singly_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_singly_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_singly_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_singly_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_singly_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_singly_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_singly_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_singly_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_singly_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_singly_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_singly_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_singly_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_singly_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_singly_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_singly_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_singly_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_singly_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_singly_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_singly_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistsinglyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_frame_make(size : Int) -> DslistsinglyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistsinglyFrame::len(self : DslistsinglyFrame) -> Int { self.size }

pub fn DslistsinglyFrame::get(self : DslistsinglyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistsinglyFrame::set(self : DslistsinglyFrame, i : Int, v : Double) -> DslistsinglyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistsinglyFrame::sum(self : DslistsinglyFrame) -> Double { @_common.sum(self.data) }

pub fn DslistsinglyFrame::mean(self : DslistsinglyFrame) -> Double { @_common.mean(self.data) }

pub fn DslistsinglyFrame::scale(self : DslistsinglyFrame, f : Double) -> DslistsinglyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistsinglyFrame::add(self : DslistsinglyFrame, other : DslistsinglyFrame) -> DslistsinglyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistsinglyFrame::copy(self : DslistsinglyFrame) -> DslistsinglyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistsinglyFrame::fill(self : DslistsinglyFrame, v : Double) -> DslistsinglyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistsinglyFrame::min(self : DslistsinglyFrame) -> Double { @_common.min(self.data) }

pub fn DslistsinglyFrame::max(self : DslistsinglyFrame) -> Double { @_common.max(self.data) }

pub fn DslistsinglyFrame::to_string(self : DslistsinglyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistsinglyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_table_make(size : Int) -> DslistsinglyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistsinglyTable::len(self : DslistsinglyTable) -> Int { self.size }

pub fn DslistsinglyTable::get(self : DslistsinglyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistsinglyTable::set(self : DslistsinglyTable, i : Int, v : Double) -> DslistsinglyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistsinglyTable::sum(self : DslistsinglyTable) -> Double { @_common.sum(self.data) }

pub fn DslistsinglyTable::mean(self : DslistsinglyTable) -> Double { @_common.mean(self.data) }

pub fn DslistsinglyTable::scale(self : DslistsinglyTable, f : Double) -> DslistsinglyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistsinglyTable::add(self : DslistsinglyTable, other : DslistsinglyTable) -> DslistsinglyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistsinglyTable::copy(self : DslistsinglyTable) -> DslistsinglyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistsinglyTable::fill(self : DslistsinglyTable, v : Double) -> DslistsinglyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistsinglyTable::min(self : DslistsinglyTable) -> Double { @_common.min(self.data) }

pub fn DslistsinglyTable::max(self : DslistsinglyTable) -> Double { @_common.max(self.data) }

pub fn DslistsinglyTable::to_string(self : DslistsinglyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistsinglyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_graphn_make(size : Int) -> DslistsinglyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistsinglyGraphN::len(self : DslistsinglyGraphN) -> Int { self.size }

pub fn DslistsinglyGraphN::get(self : DslistsinglyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistsinglyGraphN::set(self : DslistsinglyGraphN, i : Int, v : Double) -> DslistsinglyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistsinglyGraphN::sum(self : DslistsinglyGraphN) -> Double { @_common.sum(self.data) }

pub fn DslistsinglyGraphN::mean(self : DslistsinglyGraphN) -> Double { @_common.mean(self.data) }

pub fn DslistsinglyGraphN::scale(self : DslistsinglyGraphN, f : Double) -> DslistsinglyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistsinglyGraphN::add(self : DslistsinglyGraphN, other : DslistsinglyGraphN) -> DslistsinglyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistsinglyGraphN::copy(self : DslistsinglyGraphN) -> DslistsinglyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistsinglyGraphN::fill(self : DslistsinglyGraphN, v : Double) -> DslistsinglyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistsinglyGraphN::min(self : DslistsinglyGraphN) -> Double { @_common.min(self.data) }

pub fn DslistsinglyGraphN::max(self : DslistsinglyGraphN) -> Double { @_common.max(self.data) }

pub fn DslistsinglyGraphN::to_string(self : DslistsinglyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistsinglyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_node_make(size : Int) -> DslistsinglyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistsinglyNode::len(self : DslistsinglyNode) -> Int { self.size }

pub fn DslistsinglyNode::get(self : DslistsinglyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistsinglyNode::set(self : DslistsinglyNode, i : Int, v : Double) -> DslistsinglyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistsinglyNode::sum(self : DslistsinglyNode) -> Double { @_common.sum(self.data) }

pub fn DslistsinglyNode::mean(self : DslistsinglyNode) -> Double { @_common.mean(self.data) }

pub fn DslistsinglyNode::scale(self : DslistsinglyNode, f : Double) -> DslistsinglyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistsinglyNode::add(self : DslistsinglyNode, other : DslistsinglyNode) -> DslistsinglyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistsinglyNode::copy(self : DslistsinglyNode) -> DslistsinglyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistsinglyNode::fill(self : DslistsinglyNode, v : Double) -> DslistsinglyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistsinglyNode::min(self : DslistsinglyNode) -> Double { @_common.min(self.data) }

pub fn DslistsinglyNode::max(self : DslistsinglyNode) -> Double { @_common.max(self.data) }

pub fn DslistsinglyNode::to_string(self : DslistsinglyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistsinglyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_edge_make(size : Int) -> DslistsinglyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistsinglyEdge::len(self : DslistsinglyEdge) -> Int { self.size }

pub fn DslistsinglyEdge::get(self : DslistsinglyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistsinglyEdge::set(self : DslistsinglyEdge, i : Int, v : Double) -> DslistsinglyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistsinglyEdge::sum(self : DslistsinglyEdge) -> Double { @_common.sum(self.data) }

pub fn DslistsinglyEdge::mean(self : DslistsinglyEdge) -> Double { @_common.mean(self.data) }

pub fn DslistsinglyEdge::scale(self : DslistsinglyEdge, f : Double) -> DslistsinglyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistsinglyEdge::add(self : DslistsinglyEdge, other : DslistsinglyEdge) -> DslistsinglyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistsinglyEdge::copy(self : DslistsinglyEdge) -> DslistsinglyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistsinglyEdge::fill(self : DslistsinglyEdge, v : Double) -> DslistsinglyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistsinglyEdge::min(self : DslistsinglyEdge) -> Double { @_common.min(self.data) }

pub fn DslistsinglyEdge::max(self : DslistsinglyEdge) -> Double { @_common.max(self.data) }

pub fn DslistsinglyEdge::to_string(self : DslistsinglyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistsinglyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_path_make(size : Int) -> DslistsinglyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistsinglyPath::len(self : DslistsinglyPath) -> Int { self.size }

pub fn DslistsinglyPath::get(self : DslistsinglyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistsinglyPath::set(self : DslistsinglyPath, i : Int, v : Double) -> DslistsinglyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistsinglyPath::sum(self : DslistsinglyPath) -> Double { @_common.sum(self.data) }

pub fn DslistsinglyPath::mean(self : DslistsinglyPath) -> Double { @_common.mean(self.data) }

pub fn DslistsinglyPath::scale(self : DslistsinglyPath, f : Double) -> DslistsinglyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistsinglyPath::add(self : DslistsinglyPath, other : DslistsinglyPath) -> DslistsinglyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistsinglyPath::copy(self : DslistsinglyPath) -> DslistsinglyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistsinglyPath::fill(self : DslistsinglyPath, v : Double) -> DslistsinglyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistsinglyPath::min(self : DslistsinglyPath) -> Double { @_common.min(self.data) }

pub fn DslistsinglyPath::max(self : DslistsinglyPath) -> Double { @_common.max(self.data) }

pub fn DslistsinglyPath::to_string(self : DslistsinglyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistsinglyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_cluster_make(size : Int) -> DslistsinglyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistsinglyCluster::len(self : DslistsinglyCluster) -> Int { self.size }

pub fn DslistsinglyCluster::get(self : DslistsinglyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistsinglyCluster::set(self : DslistsinglyCluster, i : Int, v : Double) -> DslistsinglyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistsinglyCluster::sum(self : DslistsinglyCluster) -> Double { @_common.sum(self.data) }

pub fn DslistsinglyCluster::mean(self : DslistsinglyCluster) -> Double { @_common.mean(self.data) }

pub fn DslistsinglyCluster::scale(self : DslistsinglyCluster, f : Double) -> DslistsinglyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistsinglyCluster::add(self : DslistsinglyCluster, other : DslistsinglyCluster) -> DslistsinglyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistsinglyCluster::copy(self : DslistsinglyCluster) -> DslistsinglyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistsinglyCluster::fill(self : DslistsinglyCluster, v : Double) -> DslistsinglyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistsinglyCluster::min(self : DslistsinglyCluster) -> Double { @_common.min(self.data) }

pub fn DslistsinglyCluster::max(self : DslistsinglyCluster) -> Double { @_common.max(self.data) }

pub fn DslistsinglyCluster::to_string(self : DslistsinglyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistsinglyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_model_make(size : Int) -> DslistsinglyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistsinglyModel::len(self : DslistsinglyModel) -> Int { self.size }

pub fn DslistsinglyModel::get(self : DslistsinglyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistsinglyModel::set(self : DslistsinglyModel, i : Int, v : Double) -> DslistsinglyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistsinglyModel::sum(self : DslistsinglyModel) -> Double { @_common.sum(self.data) }

pub fn DslistsinglyModel::mean(self : DslistsinglyModel) -> Double { @_common.mean(self.data) }

pub fn DslistsinglyModel::scale(self : DslistsinglyModel, f : Double) -> DslistsinglyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistsinglyModel::add(self : DslistsinglyModel, other : DslistsinglyModel) -> DslistsinglyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistsinglyModel::copy(self : DslistsinglyModel) -> DslistsinglyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistsinglyModel::fill(self : DslistsinglyModel, v : Double) -> DslistsinglyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistsinglyModel::min(self : DslistsinglyModel) -> Double { @_common.min(self.data) }

pub fn DslistsinglyModel::max(self : DslistsinglyModel) -> Double { @_common.max(self.data) }

pub fn DslistsinglyModel::to_string(self : DslistsinglyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistsinglyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_layer_make(size : Int) -> DslistsinglyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistsinglyLayer::len(self : DslistsinglyLayer) -> Int { self.size }

pub fn DslistsinglyLayer::get(self : DslistsinglyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistsinglyLayer::set(self : DslistsinglyLayer, i : Int, v : Double) -> DslistsinglyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistsinglyLayer::sum(self : DslistsinglyLayer) -> Double { @_common.sum(self.data) }

pub fn DslistsinglyLayer::mean(self : DslistsinglyLayer) -> Double { @_common.mean(self.data) }

pub fn DslistsinglyLayer::scale(self : DslistsinglyLayer, f : Double) -> DslistsinglyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistsinglyLayer::add(self : DslistsinglyLayer, other : DslistsinglyLayer) -> DslistsinglyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistsinglyLayer::copy(self : DslistsinglyLayer) -> DslistsinglyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistsinglyLayer::fill(self : DslistsinglyLayer, v : Double) -> DslistsinglyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistsinglyLayer::min(self : DslistsinglyLayer) -> Double { @_common.min(self.data) }

pub fn DslistsinglyLayer::max(self : DslistsinglyLayer) -> Double { @_common.max(self.data) }

pub fn DslistsinglyLayer::to_string(self : DslistsinglyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistsinglyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_buffer_make(size : Int) -> DslistsinglyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistsinglyBuffer::len(self : DslistsinglyBuffer) -> Int { self.size }

pub fn DslistsinglyBuffer::get(self : DslistsinglyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistsinglyBuffer::set(self : DslistsinglyBuffer, i : Int, v : Double) -> DslistsinglyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistsinglyBuffer::sum(self : DslistsinglyBuffer) -> Double { @_common.sum(self.data) }

pub fn DslistsinglyBuffer::mean(self : DslistsinglyBuffer) -> Double { @_common.mean(self.data) }

pub fn DslistsinglyBuffer::scale(self : DslistsinglyBuffer, f : Double) -> DslistsinglyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistsinglyBuffer::add(self : DslistsinglyBuffer, other : DslistsinglyBuffer) -> DslistsinglyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistsinglyBuffer::copy(self : DslistsinglyBuffer) -> DslistsinglyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistsinglyBuffer::fill(self : DslistsinglyBuffer, v : Double) -> DslistsinglyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistsinglyBuffer::min(self : DslistsinglyBuffer) -> Double { @_common.min(self.data) }

pub fn DslistsinglyBuffer::max(self : DslistsinglyBuffer) -> Double { @_common.max(self.data) }

pub fn DslistsinglyBuffer::to_string(self : DslistsinglyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistsinglyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_cursor_make(size : Int) -> DslistsinglyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistsinglyCursor::len(self : DslistsinglyCursor) -> Int { self.size }

pub fn DslistsinglyCursor::get(self : DslistsinglyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistsinglyCursor::set(self : DslistsinglyCursor, i : Int, v : Double) -> DslistsinglyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistsinglyCursor::sum(self : DslistsinglyCursor) -> Double { @_common.sum(self.data) }

pub fn DslistsinglyCursor::mean(self : DslistsinglyCursor) -> Double { @_common.mean(self.data) }

pub fn DslistsinglyCursor::scale(self : DslistsinglyCursor, f : Double) -> DslistsinglyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistsinglyCursor::add(self : DslistsinglyCursor, other : DslistsinglyCursor) -> DslistsinglyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistsinglyCursor::copy(self : DslistsinglyCursor) -> DslistsinglyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistsinglyCursor::fill(self : DslistsinglyCursor, v : Double) -> DslistsinglyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistsinglyCursor::min(self : DslistsinglyCursor) -> Double { @_common.min(self.data) }

pub fn DslistsinglyCursor::max(self : DslistsinglyCursor) -> Double { @_common.max(self.data) }

pub fn DslistsinglyCursor::to_string(self : DslistsinglyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistsinglyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_view_make(size : Int) -> DslistsinglyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistsinglyView::len(self : DslistsinglyView) -> Int { self.size }

pub fn DslistsinglyView::get(self : DslistsinglyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistsinglyView::set(self : DslistsinglyView, i : Int, v : Double) -> DslistsinglyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistsinglyView::sum(self : DslistsinglyView) -> Double { @_common.sum(self.data) }

pub fn DslistsinglyView::mean(self : DslistsinglyView) -> Double { @_common.mean(self.data) }

pub fn DslistsinglyView::scale(self : DslistsinglyView, f : Double) -> DslistsinglyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistsinglyView::add(self : DslistsinglyView, other : DslistsinglyView) -> DslistsinglyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistsinglyView::copy(self : DslistsinglyView) -> DslistsinglyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistsinglyView::fill(self : DslistsinglyView, v : Double) -> DslistsinglyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistsinglyView::min(self : DslistsinglyView) -> Double { @_common.min(self.data) }

pub fn DslistsinglyView::max(self : DslistsinglyView) -> Double { @_common.max(self.data) }

pub fn DslistsinglyView::to_string(self : DslistsinglyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistsinglyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_range_make(size : Int) -> DslistsinglyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistsinglyRange::len(self : DslistsinglyRange) -> Int { self.size }

pub fn DslistsinglyRange::get(self : DslistsinglyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistsinglyRange::set(self : DslistsinglyRange, i : Int, v : Double) -> DslistsinglyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistsinglyRange::sum(self : DslistsinglyRange) -> Double { @_common.sum(self.data) }

pub fn DslistsinglyRange::mean(self : DslistsinglyRange) -> Double { @_common.mean(self.data) }

pub fn DslistsinglyRange::scale(self : DslistsinglyRange, f : Double) -> DslistsinglyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistsinglyRange::add(self : DslistsinglyRange, other : DslistsinglyRange) -> DslistsinglyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistsinglyRange::copy(self : DslistsinglyRange) -> DslistsinglyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistsinglyRange::fill(self : DslistsinglyRange, v : Double) -> DslistsinglyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistsinglyRange::min(self : DslistsinglyRange) -> Double { @_common.min(self.data) }

pub fn DslistsinglyRange::max(self : DslistsinglyRange) -> Double { @_common.max(self.data) }

pub fn DslistsinglyRange::to_string(self : DslistsinglyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistsinglySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_singly_slice_make(size : Int) -> DslistsinglySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistsinglySlice::len(self : DslistsinglySlice) -> Int { self.size }

pub fn DslistsinglySlice::get(self : DslistsinglySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistsinglySlice::set(self : DslistsinglySlice, i : Int, v : Double) -> DslistsinglySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistsinglySlice::sum(self : DslistsinglySlice) -> Double { @_common.sum(self.data) }

pub fn DslistsinglySlice::mean(self : DslistsinglySlice) -> Double { @_common.mean(self.data) }

pub fn DslistsinglySlice::scale(self : DslistsinglySlice, f : Double) -> DslistsinglySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistsinglySlice::add(self : DslistsinglySlice, other : DslistsinglySlice) -> DslistsinglySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistsinglySlice::copy(self : DslistsinglySlice) -> DslistsinglySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistsinglySlice::fill(self : DslistsinglySlice, v : Double) -> DslistsinglySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistsinglySlice::min(self : DslistsinglySlice) -> Double { @_common.min(self.data) }

pub fn DslistsinglySlice::max(self : DslistsinglySlice) -> Double { @_common.max(self.data) }

pub fn DslistsinglySlice::to_string(self : DslistsinglySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

