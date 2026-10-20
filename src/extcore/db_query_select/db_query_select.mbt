///===
/// extcore/db_query_select

pub(all) struct DbqueryselectPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_select_make_point(x : Double, y : Double) -> DbqueryselectPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_select_make_point3(x : Double, y : Double, z : Double) -> DbqueryselectPoint {
  { x, y, z, label: 0 }
}

pub fn DbqueryselectPoint::x(self : DbqueryselectPoint) -> Double { self.x }

pub fn DbqueryselectPoint::y(self : DbqueryselectPoint) -> Double { self.y }

pub fn DbqueryselectPoint::z(self : DbqueryselectPoint) -> Double { self.z }

pub fn DbqueryselectPoint::label(self : DbqueryselectPoint) -> Int { self.label }

pub fn DbqueryselectPoint::dist(self : DbqueryselectPoint, other : DbqueryselectPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbqueryselectPoint::add(self : DbqueryselectPoint, other : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbqueryselectPoint::sub(self : DbqueryselectPoint, other : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbqueryselectPoint::scale(self : DbqueryselectPoint, s : Double) -> DbqueryselectPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbqueryselectPoint::dot(self : DbqueryselectPoint, other : DbqueryselectPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbqueryselectPoint::cross(self : DbqueryselectPoint, other : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbqueryselectPoint::norm(self : DbqueryselectPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbqueryselectPoint::normalize(self : DbqueryselectPoint) -> DbqueryselectPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryselectPoint::negate(self : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbqueryselectPoint::mid(self : DbqueryselectPoint, other : DbqueryselectPoint) -> DbqueryselectPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbqueryselectPoint::lerp(self : DbqueryselectPoint, other : DbqueryselectPoint, t : Double) -> DbqueryselectPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbqueryselectPoint::to_string(self : DbqueryselectPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbqueryselectSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_select_make_series(vals : Array[Double], name : String) -> DbqueryselectSeries {
  { vals, name, meta: 0 }
}

pub fn DbqueryselectSeries::len(self : DbqueryselectSeries) -> Int { self.vals.length() }

pub fn DbqueryselectSeries::sum(self : DbqueryselectSeries) -> Double { @_common.sum(self.vals) }

pub fn DbqueryselectSeries::mean(self : DbqueryselectSeries) -> Double { @_common.mean(self.vals) }

pub fn DbqueryselectSeries::min(self : DbqueryselectSeries) -> Double { @_common.min(self.vals) }

pub fn DbqueryselectSeries::max(self : DbqueryselectSeries) -> Double { @_common.max(self.vals) }

pub fn DbqueryselectSeries::range(self : DbqueryselectSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbqueryselectSeries::variance(self : DbqueryselectSeries) -> Double { @_common.variance(self.vals) }

pub fn DbqueryselectSeries::std(self : DbqueryselectSeries) -> Double { @_common.std(self.vals) }

pub fn DbqueryselectSeries::median(self : DbqueryselectSeries) -> Double { @_common.median(self.vals) }

pub fn DbqueryselectSeries::scale(self : DbqueryselectSeries, f : Double) -> DbqueryselectSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbqueryselectSeries::add(self : DbqueryselectSeries, other : DbqueryselectSeries) -> DbqueryselectSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbqueryselectSeries::sub(self : DbqueryselectSeries, other : DbqueryselectSeries) -> DbqueryselectSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbqueryselectSeries::normalize(self : DbqueryselectSeries) -> DbqueryselectSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbqueryselectSeries::cumsum(self : DbqueryselectSeries) -> DbqueryselectSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbqueryselectSeries::to_string(self : DbqueryselectSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryselectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_select_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryselectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_select_matrix_identity(n : Int) -> DbqueryselectMatrix {
  let m = db_query_select_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbqueryselectMatrix::get(self : DbqueryselectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbqueryselectMatrix::transpose(self : DbqueryselectMatrix) -> DbqueryselectMatrix {
  let result = db_query_select_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbqueryselectMatrix::add(self : DbqueryselectMatrix, other : DbqueryselectMatrix) -> DbqueryselectMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_select_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbqueryselectMatrix::scale(self : DbqueryselectMatrix, s : Double) -> DbqueryselectMatrix {
  let result = db_query_select_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbqueryselectMatrix::multiply(self : DbqueryselectMatrix, other : DbqueryselectMatrix) -> DbqueryselectMatrix {
  if self.cols != other.rows { return db_query_select_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_select_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbqueryselectMatrix::trace(self : DbqueryselectMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbqueryselectMatrix::det(self : DbqueryselectMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbqueryselectMatrix::norm(self : DbqueryselectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbqueryselectMatrix::to_string(self : DbqueryselectMatrix) -> String {
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

pub(all) struct DbqueryselectVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_select_make_vector(comps : Array[Double]) -> DbqueryselectVector {
  { comps, dim: comps.length() }
}

pub fn db_query_select_vector_zero(dim : Int) -> DbqueryselectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbqueryselectVector::add(self : DbqueryselectVector, other : DbqueryselectVector) -> DbqueryselectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryselectVector::sub(self : DbqueryselectVector, other : DbqueryselectVector) -> DbqueryselectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryselectVector::scale(self : DbqueryselectVector, s : Double) -> DbqueryselectVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbqueryselectVector::dot(self : DbqueryselectVector, other : DbqueryselectVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbqueryselectVector::norm(self : DbqueryselectVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbqueryselectVector::normalize(self : DbqueryselectVector) -> DbqueryselectVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryselectVector::dist(self : DbqueryselectVector, other : DbqueryselectVector) -> Double {
  self.sub(other).norm()
}

pub fn DbqueryselectVector::to_string(self : DbqueryselectVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_select_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_select_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_select_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_select_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_select_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_select_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_select_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_select_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_select_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_select_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_select_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_select_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_select_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_select_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_select_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_select_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_select_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_select_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_select_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_select_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_select_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_select_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_select_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_select_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_select_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_select_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_select_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_select_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_select_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbqueryselectFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_frame_make(size : Int) -> DbqueryselectFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryselectFrame::len(self : DbqueryselectFrame) -> Int { self.size }

pub fn DbqueryselectFrame::get(self : DbqueryselectFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryselectFrame::set(self : DbqueryselectFrame, i : Int, v : Double) -> DbqueryselectFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryselectFrame::sum(self : DbqueryselectFrame) -> Double { @_common.sum(self.data) }

pub fn DbqueryselectFrame::mean(self : DbqueryselectFrame) -> Double { @_common.mean(self.data) }

pub fn DbqueryselectFrame::scale(self : DbqueryselectFrame, f : Double) -> DbqueryselectFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryselectFrame::add(self : DbqueryselectFrame, other : DbqueryselectFrame) -> DbqueryselectFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryselectFrame::copy(self : DbqueryselectFrame) -> DbqueryselectFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryselectFrame::fill(self : DbqueryselectFrame, v : Double) -> DbqueryselectFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryselectFrame::min(self : DbqueryselectFrame) -> Double { @_common.min(self.data) }

pub fn DbqueryselectFrame::max(self : DbqueryselectFrame) -> Double { @_common.max(self.data) }

pub fn DbqueryselectFrame::to_string(self : DbqueryselectFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryselectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_table_make(size : Int) -> DbqueryselectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryselectTable::len(self : DbqueryselectTable) -> Int { self.size }

pub fn DbqueryselectTable::get(self : DbqueryselectTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryselectTable::set(self : DbqueryselectTable, i : Int, v : Double) -> DbqueryselectTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryselectTable::sum(self : DbqueryselectTable) -> Double { @_common.sum(self.data) }

pub fn DbqueryselectTable::mean(self : DbqueryselectTable) -> Double { @_common.mean(self.data) }

pub fn DbqueryselectTable::scale(self : DbqueryselectTable, f : Double) -> DbqueryselectTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryselectTable::add(self : DbqueryselectTable, other : DbqueryselectTable) -> DbqueryselectTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryselectTable::copy(self : DbqueryselectTable) -> DbqueryselectTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryselectTable::fill(self : DbqueryselectTable, v : Double) -> DbqueryselectTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryselectTable::min(self : DbqueryselectTable) -> Double { @_common.min(self.data) }

pub fn DbqueryselectTable::max(self : DbqueryselectTable) -> Double { @_common.max(self.data) }

pub fn DbqueryselectTable::to_string(self : DbqueryselectTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryselectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_graphn_make(size : Int) -> DbqueryselectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryselectGraphN::len(self : DbqueryselectGraphN) -> Int { self.size }

pub fn DbqueryselectGraphN::get(self : DbqueryselectGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryselectGraphN::set(self : DbqueryselectGraphN, i : Int, v : Double) -> DbqueryselectGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryselectGraphN::sum(self : DbqueryselectGraphN) -> Double { @_common.sum(self.data) }

pub fn DbqueryselectGraphN::mean(self : DbqueryselectGraphN) -> Double { @_common.mean(self.data) }

pub fn DbqueryselectGraphN::scale(self : DbqueryselectGraphN, f : Double) -> DbqueryselectGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryselectGraphN::add(self : DbqueryselectGraphN, other : DbqueryselectGraphN) -> DbqueryselectGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryselectGraphN::copy(self : DbqueryselectGraphN) -> DbqueryselectGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryselectGraphN::fill(self : DbqueryselectGraphN, v : Double) -> DbqueryselectGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryselectGraphN::min(self : DbqueryselectGraphN) -> Double { @_common.min(self.data) }

pub fn DbqueryselectGraphN::max(self : DbqueryselectGraphN) -> Double { @_common.max(self.data) }

pub fn DbqueryselectGraphN::to_string(self : DbqueryselectGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryselectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_node_make(size : Int) -> DbqueryselectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryselectNode::len(self : DbqueryselectNode) -> Int { self.size }

pub fn DbqueryselectNode::get(self : DbqueryselectNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryselectNode::set(self : DbqueryselectNode, i : Int, v : Double) -> DbqueryselectNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryselectNode::sum(self : DbqueryselectNode) -> Double { @_common.sum(self.data) }

pub fn DbqueryselectNode::mean(self : DbqueryselectNode) -> Double { @_common.mean(self.data) }

pub fn DbqueryselectNode::scale(self : DbqueryselectNode, f : Double) -> DbqueryselectNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryselectNode::add(self : DbqueryselectNode, other : DbqueryselectNode) -> DbqueryselectNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryselectNode::copy(self : DbqueryselectNode) -> DbqueryselectNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryselectNode::fill(self : DbqueryselectNode, v : Double) -> DbqueryselectNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryselectNode::min(self : DbqueryselectNode) -> Double { @_common.min(self.data) }

pub fn DbqueryselectNode::max(self : DbqueryselectNode) -> Double { @_common.max(self.data) }

pub fn DbqueryselectNode::to_string(self : DbqueryselectNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryselectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_edge_make(size : Int) -> DbqueryselectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryselectEdge::len(self : DbqueryselectEdge) -> Int { self.size }

pub fn DbqueryselectEdge::get(self : DbqueryselectEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryselectEdge::set(self : DbqueryselectEdge, i : Int, v : Double) -> DbqueryselectEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryselectEdge::sum(self : DbqueryselectEdge) -> Double { @_common.sum(self.data) }

pub fn DbqueryselectEdge::mean(self : DbqueryselectEdge) -> Double { @_common.mean(self.data) }

pub fn DbqueryselectEdge::scale(self : DbqueryselectEdge, f : Double) -> DbqueryselectEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryselectEdge::add(self : DbqueryselectEdge, other : DbqueryselectEdge) -> DbqueryselectEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryselectEdge::copy(self : DbqueryselectEdge) -> DbqueryselectEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryselectEdge::fill(self : DbqueryselectEdge, v : Double) -> DbqueryselectEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryselectEdge::min(self : DbqueryselectEdge) -> Double { @_common.min(self.data) }

pub fn DbqueryselectEdge::max(self : DbqueryselectEdge) -> Double { @_common.max(self.data) }

pub fn DbqueryselectEdge::to_string(self : DbqueryselectEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryselectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_path_make(size : Int) -> DbqueryselectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryselectPath::len(self : DbqueryselectPath) -> Int { self.size }

pub fn DbqueryselectPath::get(self : DbqueryselectPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryselectPath::set(self : DbqueryselectPath, i : Int, v : Double) -> DbqueryselectPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryselectPath::sum(self : DbqueryselectPath) -> Double { @_common.sum(self.data) }

pub fn DbqueryselectPath::mean(self : DbqueryselectPath) -> Double { @_common.mean(self.data) }

pub fn DbqueryselectPath::scale(self : DbqueryselectPath, f : Double) -> DbqueryselectPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryselectPath::add(self : DbqueryselectPath, other : DbqueryselectPath) -> DbqueryselectPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryselectPath::copy(self : DbqueryselectPath) -> DbqueryselectPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryselectPath::fill(self : DbqueryselectPath, v : Double) -> DbqueryselectPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryselectPath::min(self : DbqueryselectPath) -> Double { @_common.min(self.data) }

pub fn DbqueryselectPath::max(self : DbqueryselectPath) -> Double { @_common.max(self.data) }

pub fn DbqueryselectPath::to_string(self : DbqueryselectPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryselectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_cluster_make(size : Int) -> DbqueryselectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryselectCluster::len(self : DbqueryselectCluster) -> Int { self.size }

pub fn DbqueryselectCluster::get(self : DbqueryselectCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryselectCluster::set(self : DbqueryselectCluster, i : Int, v : Double) -> DbqueryselectCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryselectCluster::sum(self : DbqueryselectCluster) -> Double { @_common.sum(self.data) }

pub fn DbqueryselectCluster::mean(self : DbqueryselectCluster) -> Double { @_common.mean(self.data) }

pub fn DbqueryselectCluster::scale(self : DbqueryselectCluster, f : Double) -> DbqueryselectCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryselectCluster::add(self : DbqueryselectCluster, other : DbqueryselectCluster) -> DbqueryselectCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryselectCluster::copy(self : DbqueryselectCluster) -> DbqueryselectCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryselectCluster::fill(self : DbqueryselectCluster, v : Double) -> DbqueryselectCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryselectCluster::min(self : DbqueryselectCluster) -> Double { @_common.min(self.data) }

pub fn DbqueryselectCluster::max(self : DbqueryselectCluster) -> Double { @_common.max(self.data) }

pub fn DbqueryselectCluster::to_string(self : DbqueryselectCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryselectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_model_make(size : Int) -> DbqueryselectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryselectModel::len(self : DbqueryselectModel) -> Int { self.size }

pub fn DbqueryselectModel::get(self : DbqueryselectModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryselectModel::set(self : DbqueryselectModel, i : Int, v : Double) -> DbqueryselectModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryselectModel::sum(self : DbqueryselectModel) -> Double { @_common.sum(self.data) }

pub fn DbqueryselectModel::mean(self : DbqueryselectModel) -> Double { @_common.mean(self.data) }

pub fn DbqueryselectModel::scale(self : DbqueryselectModel, f : Double) -> DbqueryselectModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryselectModel::add(self : DbqueryselectModel, other : DbqueryselectModel) -> DbqueryselectModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryselectModel::copy(self : DbqueryselectModel) -> DbqueryselectModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryselectModel::fill(self : DbqueryselectModel, v : Double) -> DbqueryselectModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryselectModel::min(self : DbqueryselectModel) -> Double { @_common.min(self.data) }

pub fn DbqueryselectModel::max(self : DbqueryselectModel) -> Double { @_common.max(self.data) }

pub fn DbqueryselectModel::to_string(self : DbqueryselectModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryselectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_layer_make(size : Int) -> DbqueryselectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryselectLayer::len(self : DbqueryselectLayer) -> Int { self.size }

pub fn DbqueryselectLayer::get(self : DbqueryselectLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryselectLayer::set(self : DbqueryselectLayer, i : Int, v : Double) -> DbqueryselectLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryselectLayer::sum(self : DbqueryselectLayer) -> Double { @_common.sum(self.data) }

pub fn DbqueryselectLayer::mean(self : DbqueryselectLayer) -> Double { @_common.mean(self.data) }

pub fn DbqueryselectLayer::scale(self : DbqueryselectLayer, f : Double) -> DbqueryselectLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryselectLayer::add(self : DbqueryselectLayer, other : DbqueryselectLayer) -> DbqueryselectLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryselectLayer::copy(self : DbqueryselectLayer) -> DbqueryselectLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryselectLayer::fill(self : DbqueryselectLayer, v : Double) -> DbqueryselectLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryselectLayer::min(self : DbqueryselectLayer) -> Double { @_common.min(self.data) }

pub fn DbqueryselectLayer::max(self : DbqueryselectLayer) -> Double { @_common.max(self.data) }

pub fn DbqueryselectLayer::to_string(self : DbqueryselectLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryselectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_buffer_make(size : Int) -> DbqueryselectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryselectBuffer::len(self : DbqueryselectBuffer) -> Int { self.size }

pub fn DbqueryselectBuffer::get(self : DbqueryselectBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryselectBuffer::set(self : DbqueryselectBuffer, i : Int, v : Double) -> DbqueryselectBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryselectBuffer::sum(self : DbqueryselectBuffer) -> Double { @_common.sum(self.data) }

pub fn DbqueryselectBuffer::mean(self : DbqueryselectBuffer) -> Double { @_common.mean(self.data) }

pub fn DbqueryselectBuffer::scale(self : DbqueryselectBuffer, f : Double) -> DbqueryselectBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryselectBuffer::add(self : DbqueryselectBuffer, other : DbqueryselectBuffer) -> DbqueryselectBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryselectBuffer::copy(self : DbqueryselectBuffer) -> DbqueryselectBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryselectBuffer::fill(self : DbqueryselectBuffer, v : Double) -> DbqueryselectBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryselectBuffer::min(self : DbqueryselectBuffer) -> Double { @_common.min(self.data) }

pub fn DbqueryselectBuffer::max(self : DbqueryselectBuffer) -> Double { @_common.max(self.data) }

pub fn DbqueryselectBuffer::to_string(self : DbqueryselectBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryselectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_cursor_make(size : Int) -> DbqueryselectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryselectCursor::len(self : DbqueryselectCursor) -> Int { self.size }

pub fn DbqueryselectCursor::get(self : DbqueryselectCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryselectCursor::set(self : DbqueryselectCursor, i : Int, v : Double) -> DbqueryselectCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryselectCursor::sum(self : DbqueryselectCursor) -> Double { @_common.sum(self.data) }

pub fn DbqueryselectCursor::mean(self : DbqueryselectCursor) -> Double { @_common.mean(self.data) }

pub fn DbqueryselectCursor::scale(self : DbqueryselectCursor, f : Double) -> DbqueryselectCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryselectCursor::add(self : DbqueryselectCursor, other : DbqueryselectCursor) -> DbqueryselectCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryselectCursor::copy(self : DbqueryselectCursor) -> DbqueryselectCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryselectCursor::fill(self : DbqueryselectCursor, v : Double) -> DbqueryselectCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryselectCursor::min(self : DbqueryselectCursor) -> Double { @_common.min(self.data) }

pub fn DbqueryselectCursor::max(self : DbqueryselectCursor) -> Double { @_common.max(self.data) }

pub fn DbqueryselectCursor::to_string(self : DbqueryselectCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryselectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_view_make(size : Int) -> DbqueryselectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryselectView::len(self : DbqueryselectView) -> Int { self.size }

pub fn DbqueryselectView::get(self : DbqueryselectView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryselectView::set(self : DbqueryselectView, i : Int, v : Double) -> DbqueryselectView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryselectView::sum(self : DbqueryselectView) -> Double { @_common.sum(self.data) }

pub fn DbqueryselectView::mean(self : DbqueryselectView) -> Double { @_common.mean(self.data) }

pub fn DbqueryselectView::scale(self : DbqueryselectView, f : Double) -> DbqueryselectView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryselectView::add(self : DbqueryselectView, other : DbqueryselectView) -> DbqueryselectView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryselectView::copy(self : DbqueryselectView) -> DbqueryselectView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryselectView::fill(self : DbqueryselectView, v : Double) -> DbqueryselectView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryselectView::min(self : DbqueryselectView) -> Double { @_common.min(self.data) }

pub fn DbqueryselectView::max(self : DbqueryselectView) -> Double { @_common.max(self.data) }

pub fn DbqueryselectView::to_string(self : DbqueryselectView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryselectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_range_make(size : Int) -> DbqueryselectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryselectRange::len(self : DbqueryselectRange) -> Int { self.size }

pub fn DbqueryselectRange::get(self : DbqueryselectRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryselectRange::set(self : DbqueryselectRange, i : Int, v : Double) -> DbqueryselectRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryselectRange::sum(self : DbqueryselectRange) -> Double { @_common.sum(self.data) }

pub fn DbqueryselectRange::mean(self : DbqueryselectRange) -> Double { @_common.mean(self.data) }

pub fn DbqueryselectRange::scale(self : DbqueryselectRange, f : Double) -> DbqueryselectRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryselectRange::add(self : DbqueryselectRange, other : DbqueryselectRange) -> DbqueryselectRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryselectRange::copy(self : DbqueryselectRange) -> DbqueryselectRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryselectRange::fill(self : DbqueryselectRange, v : Double) -> DbqueryselectRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryselectRange::min(self : DbqueryselectRange) -> Double { @_common.min(self.data) }

pub fn DbqueryselectRange::max(self : DbqueryselectRange) -> Double { @_common.max(self.data) }

pub fn DbqueryselectRange::to_string(self : DbqueryselectRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryselectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_select_slice_make(size : Int) -> DbqueryselectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryselectSlice::len(self : DbqueryselectSlice) -> Int { self.size }

pub fn DbqueryselectSlice::get(self : DbqueryselectSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryselectSlice::set(self : DbqueryselectSlice, i : Int, v : Double) -> DbqueryselectSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryselectSlice::sum(self : DbqueryselectSlice) -> Double { @_common.sum(self.data) }

pub fn DbqueryselectSlice::mean(self : DbqueryselectSlice) -> Double { @_common.mean(self.data) }

pub fn DbqueryselectSlice::scale(self : DbqueryselectSlice, f : Double) -> DbqueryselectSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryselectSlice::add(self : DbqueryselectSlice, other : DbqueryselectSlice) -> DbqueryselectSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryselectSlice::copy(self : DbqueryselectSlice) -> DbqueryselectSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryselectSlice::fill(self : DbqueryselectSlice, v : Double) -> DbqueryselectSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryselectSlice::min(self : DbqueryselectSlice) -> Double { @_common.min(self.data) }

pub fn DbqueryselectSlice::max(self : DbqueryselectSlice) -> Double { @_common.max(self.data) }

pub fn DbqueryselectSlice::to_string(self : DbqueryselectSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

