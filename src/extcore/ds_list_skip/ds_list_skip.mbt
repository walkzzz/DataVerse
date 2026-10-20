///===
/// extcore/ds_list_skip

pub(all) struct DslistskipPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_skip_make_point(x : Double, y : Double) -> DslistskipPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_skip_make_point3(x : Double, y : Double, z : Double) -> DslistskipPoint {
  { x, y, z, label: 0 }
}

pub fn DslistskipPoint::x(self : DslistskipPoint) -> Double { self.x }

pub fn DslistskipPoint::y(self : DslistskipPoint) -> Double { self.y }

pub fn DslistskipPoint::z(self : DslistskipPoint) -> Double { self.z }

pub fn DslistskipPoint::label(self : DslistskipPoint) -> Int { self.label }

pub fn DslistskipPoint::dist(self : DslistskipPoint, other : DslistskipPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistskipPoint::add(self : DslistskipPoint, other : DslistskipPoint) -> DslistskipPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistskipPoint::sub(self : DslistskipPoint, other : DslistskipPoint) -> DslistskipPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistskipPoint::scale(self : DslistskipPoint, s : Double) -> DslistskipPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistskipPoint::dot(self : DslistskipPoint, other : DslistskipPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistskipPoint::cross(self : DslistskipPoint, other : DslistskipPoint) -> DslistskipPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistskipPoint::norm(self : DslistskipPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistskipPoint::normalize(self : DslistskipPoint) -> DslistskipPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistskipPoint::negate(self : DslistskipPoint) -> DslistskipPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistskipPoint::mid(self : DslistskipPoint, other : DslistskipPoint) -> DslistskipPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistskipPoint::lerp(self : DslistskipPoint, other : DslistskipPoint, t : Double) -> DslistskipPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistskipPoint::to_string(self : DslistskipPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistskipSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_skip_make_series(vals : Array[Double], name : String) -> DslistskipSeries {
  { vals, name, meta: 0 }
}

pub fn DslistskipSeries::len(self : DslistskipSeries) -> Int { self.vals.length() }

pub fn DslistskipSeries::sum(self : DslistskipSeries) -> Double { @_common.sum(self.vals) }

pub fn DslistskipSeries::mean(self : DslistskipSeries) -> Double { @_common.mean(self.vals) }

pub fn DslistskipSeries::min(self : DslistskipSeries) -> Double { @_common.min(self.vals) }

pub fn DslistskipSeries::max(self : DslistskipSeries) -> Double { @_common.max(self.vals) }

pub fn DslistskipSeries::range(self : DslistskipSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistskipSeries::variance(self : DslistskipSeries) -> Double { @_common.variance(self.vals) }

pub fn DslistskipSeries::std(self : DslistskipSeries) -> Double { @_common.std(self.vals) }

pub fn DslistskipSeries::median(self : DslistskipSeries) -> Double { @_common.median(self.vals) }

pub fn DslistskipSeries::scale(self : DslistskipSeries, f : Double) -> DslistskipSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistskipSeries::add(self : DslistskipSeries, other : DslistskipSeries) -> DslistskipSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistskipSeries::sub(self : DslistskipSeries, other : DslistskipSeries) -> DslistskipSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistskipSeries::normalize(self : DslistskipSeries) -> DslistskipSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistskipSeries::cumsum(self : DslistskipSeries) -> DslistskipSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistskipSeries::to_string(self : DslistskipSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistskipMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_skip_make_matrix(rows : Int, cols : Int, val : Double) -> DslistskipMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_skip_matrix_identity(n : Int) -> DslistskipMatrix {
  let m = ds_list_skip_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistskipMatrix::get(self : DslistskipMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistskipMatrix::transpose(self : DslistskipMatrix) -> DslistskipMatrix {
  let result = ds_list_skip_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistskipMatrix::add(self : DslistskipMatrix, other : DslistskipMatrix) -> DslistskipMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_skip_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistskipMatrix::scale(self : DslistskipMatrix, s : Double) -> DslistskipMatrix {
  let result = ds_list_skip_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistskipMatrix::multiply(self : DslistskipMatrix, other : DslistskipMatrix) -> DslistskipMatrix {
  if self.cols != other.rows { return ds_list_skip_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_skip_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistskipMatrix::trace(self : DslistskipMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistskipMatrix::det(self : DslistskipMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistskipMatrix::norm(self : DslistskipMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistskipMatrix::to_string(self : DslistskipMatrix) -> String {
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

pub(all) struct DslistskipVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_skip_make_vector(comps : Array[Double]) -> DslistskipVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_skip_vector_zero(dim : Int) -> DslistskipVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistskipVector::add(self : DslistskipVector, other : DslistskipVector) -> DslistskipVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistskipVector::sub(self : DslistskipVector, other : DslistskipVector) -> DslistskipVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistskipVector::scale(self : DslistskipVector, s : Double) -> DslistskipVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistskipVector::dot(self : DslistskipVector, other : DslistskipVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistskipVector::norm(self : DslistskipVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistskipVector::normalize(self : DslistskipVector) -> DslistskipVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistskipVector::dist(self : DslistskipVector, other : DslistskipVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistskipVector::to_string(self : DslistskipVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_skip_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_skip_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_skip_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_skip_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_skip_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_skip_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_skip_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_skip_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_skip_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_skip_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_skip_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_skip_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_skip_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_skip_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_skip_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_skip_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_skip_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_skip_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_skip_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_skip_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_skip_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_skip_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_skip_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_skip_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_skip_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_skip_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_skip_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_skip_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_skip_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistskipFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_frame_make(size : Int) -> DslistskipFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistskipFrame::len(self : DslistskipFrame) -> Int { self.size }

pub fn DslistskipFrame::get(self : DslistskipFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistskipFrame::set(self : DslistskipFrame, i : Int, v : Double) -> DslistskipFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistskipFrame::sum(self : DslistskipFrame) -> Double { @_common.sum(self.data) }

pub fn DslistskipFrame::mean(self : DslistskipFrame) -> Double { @_common.mean(self.data) }

pub fn DslistskipFrame::scale(self : DslistskipFrame, f : Double) -> DslistskipFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistskipFrame::add(self : DslistskipFrame, other : DslistskipFrame) -> DslistskipFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistskipFrame::copy(self : DslistskipFrame) -> DslistskipFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistskipFrame::fill(self : DslistskipFrame, v : Double) -> DslistskipFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistskipFrame::min(self : DslistskipFrame) -> Double { @_common.min(self.data) }

pub fn DslistskipFrame::max(self : DslistskipFrame) -> Double { @_common.max(self.data) }

pub fn DslistskipFrame::to_string(self : DslistskipFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistskipTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_table_make(size : Int) -> DslistskipTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistskipTable::len(self : DslistskipTable) -> Int { self.size }

pub fn DslistskipTable::get(self : DslistskipTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistskipTable::set(self : DslistskipTable, i : Int, v : Double) -> DslistskipTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistskipTable::sum(self : DslistskipTable) -> Double { @_common.sum(self.data) }

pub fn DslistskipTable::mean(self : DslistskipTable) -> Double { @_common.mean(self.data) }

pub fn DslistskipTable::scale(self : DslistskipTable, f : Double) -> DslistskipTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistskipTable::add(self : DslistskipTable, other : DslistskipTable) -> DslistskipTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistskipTable::copy(self : DslistskipTable) -> DslistskipTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistskipTable::fill(self : DslistskipTable, v : Double) -> DslistskipTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistskipTable::min(self : DslistskipTable) -> Double { @_common.min(self.data) }

pub fn DslistskipTable::max(self : DslistskipTable) -> Double { @_common.max(self.data) }

pub fn DslistskipTable::to_string(self : DslistskipTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistskipGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_graphn_make(size : Int) -> DslistskipGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistskipGraphN::len(self : DslistskipGraphN) -> Int { self.size }

pub fn DslistskipGraphN::get(self : DslistskipGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistskipGraphN::set(self : DslistskipGraphN, i : Int, v : Double) -> DslistskipGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistskipGraphN::sum(self : DslistskipGraphN) -> Double { @_common.sum(self.data) }

pub fn DslistskipGraphN::mean(self : DslistskipGraphN) -> Double { @_common.mean(self.data) }

pub fn DslistskipGraphN::scale(self : DslistskipGraphN, f : Double) -> DslistskipGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistskipGraphN::add(self : DslistskipGraphN, other : DslistskipGraphN) -> DslistskipGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistskipGraphN::copy(self : DslistskipGraphN) -> DslistskipGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistskipGraphN::fill(self : DslistskipGraphN, v : Double) -> DslistskipGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistskipGraphN::min(self : DslistskipGraphN) -> Double { @_common.min(self.data) }

pub fn DslistskipGraphN::max(self : DslistskipGraphN) -> Double { @_common.max(self.data) }

pub fn DslistskipGraphN::to_string(self : DslistskipGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistskipNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_node_make(size : Int) -> DslistskipNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistskipNode::len(self : DslistskipNode) -> Int { self.size }

pub fn DslistskipNode::get(self : DslistskipNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistskipNode::set(self : DslistskipNode, i : Int, v : Double) -> DslistskipNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistskipNode::sum(self : DslistskipNode) -> Double { @_common.sum(self.data) }

pub fn DslistskipNode::mean(self : DslistskipNode) -> Double { @_common.mean(self.data) }

pub fn DslistskipNode::scale(self : DslistskipNode, f : Double) -> DslistskipNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistskipNode::add(self : DslistskipNode, other : DslistskipNode) -> DslistskipNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistskipNode::copy(self : DslistskipNode) -> DslistskipNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistskipNode::fill(self : DslistskipNode, v : Double) -> DslistskipNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistskipNode::min(self : DslistskipNode) -> Double { @_common.min(self.data) }

pub fn DslistskipNode::max(self : DslistskipNode) -> Double { @_common.max(self.data) }

pub fn DslistskipNode::to_string(self : DslistskipNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistskipEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_edge_make(size : Int) -> DslistskipEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistskipEdge::len(self : DslistskipEdge) -> Int { self.size }

pub fn DslistskipEdge::get(self : DslistskipEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistskipEdge::set(self : DslistskipEdge, i : Int, v : Double) -> DslistskipEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistskipEdge::sum(self : DslistskipEdge) -> Double { @_common.sum(self.data) }

pub fn DslistskipEdge::mean(self : DslistskipEdge) -> Double { @_common.mean(self.data) }

pub fn DslistskipEdge::scale(self : DslistskipEdge, f : Double) -> DslistskipEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistskipEdge::add(self : DslistskipEdge, other : DslistskipEdge) -> DslistskipEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistskipEdge::copy(self : DslistskipEdge) -> DslistskipEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistskipEdge::fill(self : DslistskipEdge, v : Double) -> DslistskipEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistskipEdge::min(self : DslistskipEdge) -> Double { @_common.min(self.data) }

pub fn DslistskipEdge::max(self : DslistskipEdge) -> Double { @_common.max(self.data) }

pub fn DslistskipEdge::to_string(self : DslistskipEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistskipPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_path_make(size : Int) -> DslistskipPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistskipPath::len(self : DslistskipPath) -> Int { self.size }

pub fn DslistskipPath::get(self : DslistskipPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistskipPath::set(self : DslistskipPath, i : Int, v : Double) -> DslistskipPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistskipPath::sum(self : DslistskipPath) -> Double { @_common.sum(self.data) }

pub fn DslistskipPath::mean(self : DslistskipPath) -> Double { @_common.mean(self.data) }

pub fn DslistskipPath::scale(self : DslistskipPath, f : Double) -> DslistskipPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistskipPath::add(self : DslistskipPath, other : DslistskipPath) -> DslistskipPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistskipPath::copy(self : DslistskipPath) -> DslistskipPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistskipPath::fill(self : DslistskipPath, v : Double) -> DslistskipPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistskipPath::min(self : DslistskipPath) -> Double { @_common.min(self.data) }

pub fn DslistskipPath::max(self : DslistskipPath) -> Double { @_common.max(self.data) }

pub fn DslistskipPath::to_string(self : DslistskipPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistskipCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_cluster_make(size : Int) -> DslistskipCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistskipCluster::len(self : DslistskipCluster) -> Int { self.size }

pub fn DslistskipCluster::get(self : DslistskipCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistskipCluster::set(self : DslistskipCluster, i : Int, v : Double) -> DslistskipCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistskipCluster::sum(self : DslistskipCluster) -> Double { @_common.sum(self.data) }

pub fn DslistskipCluster::mean(self : DslistskipCluster) -> Double { @_common.mean(self.data) }

pub fn DslistskipCluster::scale(self : DslistskipCluster, f : Double) -> DslistskipCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistskipCluster::add(self : DslistskipCluster, other : DslistskipCluster) -> DslistskipCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistskipCluster::copy(self : DslistskipCluster) -> DslistskipCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistskipCluster::fill(self : DslistskipCluster, v : Double) -> DslistskipCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistskipCluster::min(self : DslistskipCluster) -> Double { @_common.min(self.data) }

pub fn DslistskipCluster::max(self : DslistskipCluster) -> Double { @_common.max(self.data) }

pub fn DslistskipCluster::to_string(self : DslistskipCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistskipModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_model_make(size : Int) -> DslistskipModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistskipModel::len(self : DslistskipModel) -> Int { self.size }

pub fn DslistskipModel::get(self : DslistskipModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistskipModel::set(self : DslistskipModel, i : Int, v : Double) -> DslistskipModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistskipModel::sum(self : DslistskipModel) -> Double { @_common.sum(self.data) }

pub fn DslistskipModel::mean(self : DslistskipModel) -> Double { @_common.mean(self.data) }

pub fn DslistskipModel::scale(self : DslistskipModel, f : Double) -> DslistskipModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistskipModel::add(self : DslistskipModel, other : DslistskipModel) -> DslistskipModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistskipModel::copy(self : DslistskipModel) -> DslistskipModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistskipModel::fill(self : DslistskipModel, v : Double) -> DslistskipModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistskipModel::min(self : DslistskipModel) -> Double { @_common.min(self.data) }

pub fn DslistskipModel::max(self : DslistskipModel) -> Double { @_common.max(self.data) }

pub fn DslistskipModel::to_string(self : DslistskipModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistskipLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_layer_make(size : Int) -> DslistskipLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistskipLayer::len(self : DslistskipLayer) -> Int { self.size }

pub fn DslistskipLayer::get(self : DslistskipLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistskipLayer::set(self : DslistskipLayer, i : Int, v : Double) -> DslistskipLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistskipLayer::sum(self : DslistskipLayer) -> Double { @_common.sum(self.data) }

pub fn DslistskipLayer::mean(self : DslistskipLayer) -> Double { @_common.mean(self.data) }

pub fn DslistskipLayer::scale(self : DslistskipLayer, f : Double) -> DslistskipLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistskipLayer::add(self : DslistskipLayer, other : DslistskipLayer) -> DslistskipLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistskipLayer::copy(self : DslistskipLayer) -> DslistskipLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistskipLayer::fill(self : DslistskipLayer, v : Double) -> DslistskipLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistskipLayer::min(self : DslistskipLayer) -> Double { @_common.min(self.data) }

pub fn DslistskipLayer::max(self : DslistskipLayer) -> Double { @_common.max(self.data) }

pub fn DslistskipLayer::to_string(self : DslistskipLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistskipBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_buffer_make(size : Int) -> DslistskipBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistskipBuffer::len(self : DslistskipBuffer) -> Int { self.size }

pub fn DslistskipBuffer::get(self : DslistskipBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistskipBuffer::set(self : DslistskipBuffer, i : Int, v : Double) -> DslistskipBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistskipBuffer::sum(self : DslistskipBuffer) -> Double { @_common.sum(self.data) }

pub fn DslistskipBuffer::mean(self : DslistskipBuffer) -> Double { @_common.mean(self.data) }

pub fn DslistskipBuffer::scale(self : DslistskipBuffer, f : Double) -> DslistskipBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistskipBuffer::add(self : DslistskipBuffer, other : DslistskipBuffer) -> DslistskipBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistskipBuffer::copy(self : DslistskipBuffer) -> DslistskipBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistskipBuffer::fill(self : DslistskipBuffer, v : Double) -> DslistskipBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistskipBuffer::min(self : DslistskipBuffer) -> Double { @_common.min(self.data) }

pub fn DslistskipBuffer::max(self : DslistskipBuffer) -> Double { @_common.max(self.data) }

pub fn DslistskipBuffer::to_string(self : DslistskipBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistskipCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_cursor_make(size : Int) -> DslistskipCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistskipCursor::len(self : DslistskipCursor) -> Int { self.size }

pub fn DslistskipCursor::get(self : DslistskipCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistskipCursor::set(self : DslistskipCursor, i : Int, v : Double) -> DslistskipCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistskipCursor::sum(self : DslistskipCursor) -> Double { @_common.sum(self.data) }

pub fn DslistskipCursor::mean(self : DslistskipCursor) -> Double { @_common.mean(self.data) }

pub fn DslistskipCursor::scale(self : DslistskipCursor, f : Double) -> DslistskipCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistskipCursor::add(self : DslistskipCursor, other : DslistskipCursor) -> DslistskipCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistskipCursor::copy(self : DslistskipCursor) -> DslistskipCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistskipCursor::fill(self : DslistskipCursor, v : Double) -> DslistskipCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistskipCursor::min(self : DslistskipCursor) -> Double { @_common.min(self.data) }

pub fn DslistskipCursor::max(self : DslistskipCursor) -> Double { @_common.max(self.data) }

pub fn DslistskipCursor::to_string(self : DslistskipCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistskipView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_view_make(size : Int) -> DslistskipView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistskipView::len(self : DslistskipView) -> Int { self.size }

pub fn DslistskipView::get(self : DslistskipView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistskipView::set(self : DslistskipView, i : Int, v : Double) -> DslistskipView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistskipView::sum(self : DslistskipView) -> Double { @_common.sum(self.data) }

pub fn DslistskipView::mean(self : DslistskipView) -> Double { @_common.mean(self.data) }

pub fn DslistskipView::scale(self : DslistskipView, f : Double) -> DslistskipView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistskipView::add(self : DslistskipView, other : DslistskipView) -> DslistskipView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistskipView::copy(self : DslistskipView) -> DslistskipView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistskipView::fill(self : DslistskipView, v : Double) -> DslistskipView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistskipView::min(self : DslistskipView) -> Double { @_common.min(self.data) }

pub fn DslistskipView::max(self : DslistskipView) -> Double { @_common.max(self.data) }

pub fn DslistskipView::to_string(self : DslistskipView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistskipRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_range_make(size : Int) -> DslistskipRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistskipRange::len(self : DslistskipRange) -> Int { self.size }

pub fn DslistskipRange::get(self : DslistskipRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistskipRange::set(self : DslistskipRange, i : Int, v : Double) -> DslistskipRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistskipRange::sum(self : DslistskipRange) -> Double { @_common.sum(self.data) }

pub fn DslistskipRange::mean(self : DslistskipRange) -> Double { @_common.mean(self.data) }

pub fn DslistskipRange::scale(self : DslistskipRange, f : Double) -> DslistskipRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistskipRange::add(self : DslistskipRange, other : DslistskipRange) -> DslistskipRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistskipRange::copy(self : DslistskipRange) -> DslistskipRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistskipRange::fill(self : DslistskipRange, v : Double) -> DslistskipRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistskipRange::min(self : DslistskipRange) -> Double { @_common.min(self.data) }

pub fn DslistskipRange::max(self : DslistskipRange) -> Double { @_common.max(self.data) }

pub fn DslistskipRange::to_string(self : DslistskipRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistskipSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_skip_slice_make(size : Int) -> DslistskipSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistskipSlice::len(self : DslistskipSlice) -> Int { self.size }

pub fn DslistskipSlice::get(self : DslistskipSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistskipSlice::set(self : DslistskipSlice, i : Int, v : Double) -> DslistskipSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistskipSlice::sum(self : DslistskipSlice) -> Double { @_common.sum(self.data) }

pub fn DslistskipSlice::mean(self : DslistskipSlice) -> Double { @_common.mean(self.data) }

pub fn DslistskipSlice::scale(self : DslistskipSlice, f : Double) -> DslistskipSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistskipSlice::add(self : DslistskipSlice, other : DslistskipSlice) -> DslistskipSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistskipSlice::copy(self : DslistskipSlice) -> DslistskipSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistskipSlice::fill(self : DslistskipSlice, v : Double) -> DslistskipSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistskipSlice::min(self : DslistskipSlice) -> Double { @_common.min(self.data) }

pub fn DslistskipSlice::max(self : DslistskipSlice) -> Double { @_common.max(self.data) }

pub fn DslistskipSlice::to_string(self : DslistskipSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

