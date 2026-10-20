///===
/// extcore/db_query_join

pub(all) struct DbqueryjoinPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_join_make_point(x : Double, y : Double) -> DbqueryjoinPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_join_make_point3(x : Double, y : Double, z : Double) -> DbqueryjoinPoint {
  { x, y, z, label: 0 }
}

pub fn DbqueryjoinPoint::x(self : DbqueryjoinPoint) -> Double { self.x }

pub fn DbqueryjoinPoint::y(self : DbqueryjoinPoint) -> Double { self.y }

pub fn DbqueryjoinPoint::z(self : DbqueryjoinPoint) -> Double { self.z }

pub fn DbqueryjoinPoint::label(self : DbqueryjoinPoint) -> Int { self.label }

pub fn DbqueryjoinPoint::dist(self : DbqueryjoinPoint, other : DbqueryjoinPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbqueryjoinPoint::add(self : DbqueryjoinPoint, other : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbqueryjoinPoint::sub(self : DbqueryjoinPoint, other : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbqueryjoinPoint::scale(self : DbqueryjoinPoint, s : Double) -> DbqueryjoinPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbqueryjoinPoint::dot(self : DbqueryjoinPoint, other : DbqueryjoinPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbqueryjoinPoint::cross(self : DbqueryjoinPoint, other : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbqueryjoinPoint::norm(self : DbqueryjoinPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbqueryjoinPoint::normalize(self : DbqueryjoinPoint) -> DbqueryjoinPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryjoinPoint::negate(self : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbqueryjoinPoint::mid(self : DbqueryjoinPoint, other : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbqueryjoinPoint::lerp(self : DbqueryjoinPoint, other : DbqueryjoinPoint, t : Double) -> DbqueryjoinPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbqueryjoinPoint::to_string(self : DbqueryjoinPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbqueryjoinSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_join_make_series(vals : Array[Double], name : String) -> DbqueryjoinSeries {
  { vals, name, meta: 0 }
}

pub fn DbqueryjoinSeries::len(self : DbqueryjoinSeries) -> Int { self.vals.length() }

pub fn DbqueryjoinSeries::sum(self : DbqueryjoinSeries) -> Double { @_common.sum(self.vals) }

pub fn DbqueryjoinSeries::mean(self : DbqueryjoinSeries) -> Double { @_common.mean(self.vals) }

pub fn DbqueryjoinSeries::min(self : DbqueryjoinSeries) -> Double { @_common.min(self.vals) }

pub fn DbqueryjoinSeries::max(self : DbqueryjoinSeries) -> Double { @_common.max(self.vals) }

pub fn DbqueryjoinSeries::range(self : DbqueryjoinSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbqueryjoinSeries::variance(self : DbqueryjoinSeries) -> Double { @_common.variance(self.vals) }

pub fn DbqueryjoinSeries::std(self : DbqueryjoinSeries) -> Double { @_common.std(self.vals) }

pub fn DbqueryjoinSeries::median(self : DbqueryjoinSeries) -> Double { @_common.median(self.vals) }

pub fn DbqueryjoinSeries::scale(self : DbqueryjoinSeries, f : Double) -> DbqueryjoinSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbqueryjoinSeries::add(self : DbqueryjoinSeries, other : DbqueryjoinSeries) -> DbqueryjoinSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbqueryjoinSeries::sub(self : DbqueryjoinSeries, other : DbqueryjoinSeries) -> DbqueryjoinSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbqueryjoinSeries::normalize(self : DbqueryjoinSeries) -> DbqueryjoinSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbqueryjoinSeries::cumsum(self : DbqueryjoinSeries) -> DbqueryjoinSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbqueryjoinSeries::to_string(self : DbqueryjoinSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryjoinMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_join_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryjoinMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_join_matrix_identity(n : Int) -> DbqueryjoinMatrix {
  let m = db_query_join_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbqueryjoinMatrix::get(self : DbqueryjoinMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbqueryjoinMatrix::transpose(self : DbqueryjoinMatrix) -> DbqueryjoinMatrix {
  let result = db_query_join_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbqueryjoinMatrix::add(self : DbqueryjoinMatrix, other : DbqueryjoinMatrix) -> DbqueryjoinMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_join_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbqueryjoinMatrix::scale(self : DbqueryjoinMatrix, s : Double) -> DbqueryjoinMatrix {
  let result = db_query_join_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbqueryjoinMatrix::multiply(self : DbqueryjoinMatrix, other : DbqueryjoinMatrix) -> DbqueryjoinMatrix {
  if self.cols != other.rows { return db_query_join_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_join_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbqueryjoinMatrix::trace(self : DbqueryjoinMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbqueryjoinMatrix::det(self : DbqueryjoinMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbqueryjoinMatrix::norm(self : DbqueryjoinMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbqueryjoinMatrix::to_string(self : DbqueryjoinMatrix) -> String {
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

pub(all) struct DbqueryjoinVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_join_make_vector(comps : Array[Double]) -> DbqueryjoinVector {
  { comps, dim: comps.length() }
}

pub fn db_query_join_vector_zero(dim : Int) -> DbqueryjoinVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbqueryjoinVector::add(self : DbqueryjoinVector, other : DbqueryjoinVector) -> DbqueryjoinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryjoinVector::sub(self : DbqueryjoinVector, other : DbqueryjoinVector) -> DbqueryjoinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryjoinVector::scale(self : DbqueryjoinVector, s : Double) -> DbqueryjoinVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbqueryjoinVector::dot(self : DbqueryjoinVector, other : DbqueryjoinVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbqueryjoinVector::norm(self : DbqueryjoinVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbqueryjoinVector::normalize(self : DbqueryjoinVector) -> DbqueryjoinVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryjoinVector::dist(self : DbqueryjoinVector, other : DbqueryjoinVector) -> Double {
  self.sub(other).norm()
}

pub fn DbqueryjoinVector::to_string(self : DbqueryjoinVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_join_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_join_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_join_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_join_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_join_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_join_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_join_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_join_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_join_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_join_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_join_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_join_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_join_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_join_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_join_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_join_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_join_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_join_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_join_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_join_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_join_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_join_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_join_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_join_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_join_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_join_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_join_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_join_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_join_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbqueryjoinFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_frame_make(size : Int) -> DbqueryjoinFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryjoinFrame::len(self : DbqueryjoinFrame) -> Int { self.size }

pub fn DbqueryjoinFrame::get(self : DbqueryjoinFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryjoinFrame::set(self : DbqueryjoinFrame, i : Int, v : Double) -> DbqueryjoinFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryjoinFrame::sum(self : DbqueryjoinFrame) -> Double { @_common.sum(self.data) }

pub fn DbqueryjoinFrame::mean(self : DbqueryjoinFrame) -> Double { @_common.mean(self.data) }

pub fn DbqueryjoinFrame::scale(self : DbqueryjoinFrame, f : Double) -> DbqueryjoinFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinFrame::add(self : DbqueryjoinFrame, other : DbqueryjoinFrame) -> DbqueryjoinFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryjoinFrame::copy(self : DbqueryjoinFrame) -> DbqueryjoinFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinFrame::fill(self : DbqueryjoinFrame, v : Double) -> DbqueryjoinFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinFrame::min(self : DbqueryjoinFrame) -> Double { @_common.min(self.data) }

pub fn DbqueryjoinFrame::max(self : DbqueryjoinFrame) -> Double { @_common.max(self.data) }

pub fn DbqueryjoinFrame::to_string(self : DbqueryjoinFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_table_make(size : Int) -> DbqueryjoinTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryjoinTable::len(self : DbqueryjoinTable) -> Int { self.size }

pub fn DbqueryjoinTable::get(self : DbqueryjoinTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryjoinTable::set(self : DbqueryjoinTable, i : Int, v : Double) -> DbqueryjoinTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryjoinTable::sum(self : DbqueryjoinTable) -> Double { @_common.sum(self.data) }

pub fn DbqueryjoinTable::mean(self : DbqueryjoinTable) -> Double { @_common.mean(self.data) }

pub fn DbqueryjoinTable::scale(self : DbqueryjoinTable, f : Double) -> DbqueryjoinTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinTable::add(self : DbqueryjoinTable, other : DbqueryjoinTable) -> DbqueryjoinTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryjoinTable::copy(self : DbqueryjoinTable) -> DbqueryjoinTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinTable::fill(self : DbqueryjoinTable, v : Double) -> DbqueryjoinTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinTable::min(self : DbqueryjoinTable) -> Double { @_common.min(self.data) }

pub fn DbqueryjoinTable::max(self : DbqueryjoinTable) -> Double { @_common.max(self.data) }

pub fn DbqueryjoinTable::to_string(self : DbqueryjoinTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_graphn_make(size : Int) -> DbqueryjoinGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryjoinGraphN::len(self : DbqueryjoinGraphN) -> Int { self.size }

pub fn DbqueryjoinGraphN::get(self : DbqueryjoinGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryjoinGraphN::set(self : DbqueryjoinGraphN, i : Int, v : Double) -> DbqueryjoinGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryjoinGraphN::sum(self : DbqueryjoinGraphN) -> Double { @_common.sum(self.data) }

pub fn DbqueryjoinGraphN::mean(self : DbqueryjoinGraphN) -> Double { @_common.mean(self.data) }

pub fn DbqueryjoinGraphN::scale(self : DbqueryjoinGraphN, f : Double) -> DbqueryjoinGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinGraphN::add(self : DbqueryjoinGraphN, other : DbqueryjoinGraphN) -> DbqueryjoinGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryjoinGraphN::copy(self : DbqueryjoinGraphN) -> DbqueryjoinGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinGraphN::fill(self : DbqueryjoinGraphN, v : Double) -> DbqueryjoinGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinGraphN::min(self : DbqueryjoinGraphN) -> Double { @_common.min(self.data) }

pub fn DbqueryjoinGraphN::max(self : DbqueryjoinGraphN) -> Double { @_common.max(self.data) }

pub fn DbqueryjoinGraphN::to_string(self : DbqueryjoinGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_node_make(size : Int) -> DbqueryjoinNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryjoinNode::len(self : DbqueryjoinNode) -> Int { self.size }

pub fn DbqueryjoinNode::get(self : DbqueryjoinNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryjoinNode::set(self : DbqueryjoinNode, i : Int, v : Double) -> DbqueryjoinNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryjoinNode::sum(self : DbqueryjoinNode) -> Double { @_common.sum(self.data) }

pub fn DbqueryjoinNode::mean(self : DbqueryjoinNode) -> Double { @_common.mean(self.data) }

pub fn DbqueryjoinNode::scale(self : DbqueryjoinNode, f : Double) -> DbqueryjoinNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinNode::add(self : DbqueryjoinNode, other : DbqueryjoinNode) -> DbqueryjoinNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryjoinNode::copy(self : DbqueryjoinNode) -> DbqueryjoinNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinNode::fill(self : DbqueryjoinNode, v : Double) -> DbqueryjoinNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinNode::min(self : DbqueryjoinNode) -> Double { @_common.min(self.data) }

pub fn DbqueryjoinNode::max(self : DbqueryjoinNode) -> Double { @_common.max(self.data) }

pub fn DbqueryjoinNode::to_string(self : DbqueryjoinNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_edge_make(size : Int) -> DbqueryjoinEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryjoinEdge::len(self : DbqueryjoinEdge) -> Int { self.size }

pub fn DbqueryjoinEdge::get(self : DbqueryjoinEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryjoinEdge::set(self : DbqueryjoinEdge, i : Int, v : Double) -> DbqueryjoinEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryjoinEdge::sum(self : DbqueryjoinEdge) -> Double { @_common.sum(self.data) }

pub fn DbqueryjoinEdge::mean(self : DbqueryjoinEdge) -> Double { @_common.mean(self.data) }

pub fn DbqueryjoinEdge::scale(self : DbqueryjoinEdge, f : Double) -> DbqueryjoinEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinEdge::add(self : DbqueryjoinEdge, other : DbqueryjoinEdge) -> DbqueryjoinEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryjoinEdge::copy(self : DbqueryjoinEdge) -> DbqueryjoinEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinEdge::fill(self : DbqueryjoinEdge, v : Double) -> DbqueryjoinEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinEdge::min(self : DbqueryjoinEdge) -> Double { @_common.min(self.data) }

pub fn DbqueryjoinEdge::max(self : DbqueryjoinEdge) -> Double { @_common.max(self.data) }

pub fn DbqueryjoinEdge::to_string(self : DbqueryjoinEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_path_make(size : Int) -> DbqueryjoinPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryjoinPath::len(self : DbqueryjoinPath) -> Int { self.size }

pub fn DbqueryjoinPath::get(self : DbqueryjoinPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryjoinPath::set(self : DbqueryjoinPath, i : Int, v : Double) -> DbqueryjoinPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryjoinPath::sum(self : DbqueryjoinPath) -> Double { @_common.sum(self.data) }

pub fn DbqueryjoinPath::mean(self : DbqueryjoinPath) -> Double { @_common.mean(self.data) }

pub fn DbqueryjoinPath::scale(self : DbqueryjoinPath, f : Double) -> DbqueryjoinPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinPath::add(self : DbqueryjoinPath, other : DbqueryjoinPath) -> DbqueryjoinPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryjoinPath::copy(self : DbqueryjoinPath) -> DbqueryjoinPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinPath::fill(self : DbqueryjoinPath, v : Double) -> DbqueryjoinPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinPath::min(self : DbqueryjoinPath) -> Double { @_common.min(self.data) }

pub fn DbqueryjoinPath::max(self : DbqueryjoinPath) -> Double { @_common.max(self.data) }

pub fn DbqueryjoinPath::to_string(self : DbqueryjoinPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_cluster_make(size : Int) -> DbqueryjoinCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryjoinCluster::len(self : DbqueryjoinCluster) -> Int { self.size }

pub fn DbqueryjoinCluster::get(self : DbqueryjoinCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryjoinCluster::set(self : DbqueryjoinCluster, i : Int, v : Double) -> DbqueryjoinCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryjoinCluster::sum(self : DbqueryjoinCluster) -> Double { @_common.sum(self.data) }

pub fn DbqueryjoinCluster::mean(self : DbqueryjoinCluster) -> Double { @_common.mean(self.data) }

pub fn DbqueryjoinCluster::scale(self : DbqueryjoinCluster, f : Double) -> DbqueryjoinCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinCluster::add(self : DbqueryjoinCluster, other : DbqueryjoinCluster) -> DbqueryjoinCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryjoinCluster::copy(self : DbqueryjoinCluster) -> DbqueryjoinCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinCluster::fill(self : DbqueryjoinCluster, v : Double) -> DbqueryjoinCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinCluster::min(self : DbqueryjoinCluster) -> Double { @_common.min(self.data) }

pub fn DbqueryjoinCluster::max(self : DbqueryjoinCluster) -> Double { @_common.max(self.data) }

pub fn DbqueryjoinCluster::to_string(self : DbqueryjoinCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_model_make(size : Int) -> DbqueryjoinModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryjoinModel::len(self : DbqueryjoinModel) -> Int { self.size }

pub fn DbqueryjoinModel::get(self : DbqueryjoinModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryjoinModel::set(self : DbqueryjoinModel, i : Int, v : Double) -> DbqueryjoinModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryjoinModel::sum(self : DbqueryjoinModel) -> Double { @_common.sum(self.data) }

pub fn DbqueryjoinModel::mean(self : DbqueryjoinModel) -> Double { @_common.mean(self.data) }

pub fn DbqueryjoinModel::scale(self : DbqueryjoinModel, f : Double) -> DbqueryjoinModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinModel::add(self : DbqueryjoinModel, other : DbqueryjoinModel) -> DbqueryjoinModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryjoinModel::copy(self : DbqueryjoinModel) -> DbqueryjoinModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinModel::fill(self : DbqueryjoinModel, v : Double) -> DbqueryjoinModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinModel::min(self : DbqueryjoinModel) -> Double { @_common.min(self.data) }

pub fn DbqueryjoinModel::max(self : DbqueryjoinModel) -> Double { @_common.max(self.data) }

pub fn DbqueryjoinModel::to_string(self : DbqueryjoinModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_layer_make(size : Int) -> DbqueryjoinLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryjoinLayer::len(self : DbqueryjoinLayer) -> Int { self.size }

pub fn DbqueryjoinLayer::get(self : DbqueryjoinLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryjoinLayer::set(self : DbqueryjoinLayer, i : Int, v : Double) -> DbqueryjoinLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryjoinLayer::sum(self : DbqueryjoinLayer) -> Double { @_common.sum(self.data) }

pub fn DbqueryjoinLayer::mean(self : DbqueryjoinLayer) -> Double { @_common.mean(self.data) }

pub fn DbqueryjoinLayer::scale(self : DbqueryjoinLayer, f : Double) -> DbqueryjoinLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinLayer::add(self : DbqueryjoinLayer, other : DbqueryjoinLayer) -> DbqueryjoinLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryjoinLayer::copy(self : DbqueryjoinLayer) -> DbqueryjoinLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinLayer::fill(self : DbqueryjoinLayer, v : Double) -> DbqueryjoinLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinLayer::min(self : DbqueryjoinLayer) -> Double { @_common.min(self.data) }

pub fn DbqueryjoinLayer::max(self : DbqueryjoinLayer) -> Double { @_common.max(self.data) }

pub fn DbqueryjoinLayer::to_string(self : DbqueryjoinLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_buffer_make(size : Int) -> DbqueryjoinBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryjoinBuffer::len(self : DbqueryjoinBuffer) -> Int { self.size }

pub fn DbqueryjoinBuffer::get(self : DbqueryjoinBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryjoinBuffer::set(self : DbqueryjoinBuffer, i : Int, v : Double) -> DbqueryjoinBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryjoinBuffer::sum(self : DbqueryjoinBuffer) -> Double { @_common.sum(self.data) }

pub fn DbqueryjoinBuffer::mean(self : DbqueryjoinBuffer) -> Double { @_common.mean(self.data) }

pub fn DbqueryjoinBuffer::scale(self : DbqueryjoinBuffer, f : Double) -> DbqueryjoinBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinBuffer::add(self : DbqueryjoinBuffer, other : DbqueryjoinBuffer) -> DbqueryjoinBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryjoinBuffer::copy(self : DbqueryjoinBuffer) -> DbqueryjoinBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinBuffer::fill(self : DbqueryjoinBuffer, v : Double) -> DbqueryjoinBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinBuffer::min(self : DbqueryjoinBuffer) -> Double { @_common.min(self.data) }

pub fn DbqueryjoinBuffer::max(self : DbqueryjoinBuffer) -> Double { @_common.max(self.data) }

pub fn DbqueryjoinBuffer::to_string(self : DbqueryjoinBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_cursor_make(size : Int) -> DbqueryjoinCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryjoinCursor::len(self : DbqueryjoinCursor) -> Int { self.size }

pub fn DbqueryjoinCursor::get(self : DbqueryjoinCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryjoinCursor::set(self : DbqueryjoinCursor, i : Int, v : Double) -> DbqueryjoinCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryjoinCursor::sum(self : DbqueryjoinCursor) -> Double { @_common.sum(self.data) }

pub fn DbqueryjoinCursor::mean(self : DbqueryjoinCursor) -> Double { @_common.mean(self.data) }

pub fn DbqueryjoinCursor::scale(self : DbqueryjoinCursor, f : Double) -> DbqueryjoinCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinCursor::add(self : DbqueryjoinCursor, other : DbqueryjoinCursor) -> DbqueryjoinCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryjoinCursor::copy(self : DbqueryjoinCursor) -> DbqueryjoinCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinCursor::fill(self : DbqueryjoinCursor, v : Double) -> DbqueryjoinCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinCursor::min(self : DbqueryjoinCursor) -> Double { @_common.min(self.data) }

pub fn DbqueryjoinCursor::max(self : DbqueryjoinCursor) -> Double { @_common.max(self.data) }

pub fn DbqueryjoinCursor::to_string(self : DbqueryjoinCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_view_make(size : Int) -> DbqueryjoinView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryjoinView::len(self : DbqueryjoinView) -> Int { self.size }

pub fn DbqueryjoinView::get(self : DbqueryjoinView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryjoinView::set(self : DbqueryjoinView, i : Int, v : Double) -> DbqueryjoinView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryjoinView::sum(self : DbqueryjoinView) -> Double { @_common.sum(self.data) }

pub fn DbqueryjoinView::mean(self : DbqueryjoinView) -> Double { @_common.mean(self.data) }

pub fn DbqueryjoinView::scale(self : DbqueryjoinView, f : Double) -> DbqueryjoinView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinView::add(self : DbqueryjoinView, other : DbqueryjoinView) -> DbqueryjoinView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryjoinView::copy(self : DbqueryjoinView) -> DbqueryjoinView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinView::fill(self : DbqueryjoinView, v : Double) -> DbqueryjoinView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinView::min(self : DbqueryjoinView) -> Double { @_common.min(self.data) }

pub fn DbqueryjoinView::max(self : DbqueryjoinView) -> Double { @_common.max(self.data) }

pub fn DbqueryjoinView::to_string(self : DbqueryjoinView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_range_make(size : Int) -> DbqueryjoinRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryjoinRange::len(self : DbqueryjoinRange) -> Int { self.size }

pub fn DbqueryjoinRange::get(self : DbqueryjoinRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryjoinRange::set(self : DbqueryjoinRange, i : Int, v : Double) -> DbqueryjoinRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryjoinRange::sum(self : DbqueryjoinRange) -> Double { @_common.sum(self.data) }

pub fn DbqueryjoinRange::mean(self : DbqueryjoinRange) -> Double { @_common.mean(self.data) }

pub fn DbqueryjoinRange::scale(self : DbqueryjoinRange, f : Double) -> DbqueryjoinRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinRange::add(self : DbqueryjoinRange, other : DbqueryjoinRange) -> DbqueryjoinRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryjoinRange::copy(self : DbqueryjoinRange) -> DbqueryjoinRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinRange::fill(self : DbqueryjoinRange, v : Double) -> DbqueryjoinRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinRange::min(self : DbqueryjoinRange) -> Double { @_common.min(self.data) }

pub fn DbqueryjoinRange::max(self : DbqueryjoinRange) -> Double { @_common.max(self.data) }

pub fn DbqueryjoinRange::to_string(self : DbqueryjoinRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_slice_make(size : Int) -> DbqueryjoinSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryjoinSlice::len(self : DbqueryjoinSlice) -> Int { self.size }

pub fn DbqueryjoinSlice::get(self : DbqueryjoinSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryjoinSlice::set(self : DbqueryjoinSlice, i : Int, v : Double) -> DbqueryjoinSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryjoinSlice::sum(self : DbqueryjoinSlice) -> Double { @_common.sum(self.data) }

pub fn DbqueryjoinSlice::mean(self : DbqueryjoinSlice) -> Double { @_common.mean(self.data) }

pub fn DbqueryjoinSlice::scale(self : DbqueryjoinSlice, f : Double) -> DbqueryjoinSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinSlice::add(self : DbqueryjoinSlice, other : DbqueryjoinSlice) -> DbqueryjoinSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryjoinSlice::copy(self : DbqueryjoinSlice) -> DbqueryjoinSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinSlice::fill(self : DbqueryjoinSlice, v : Double) -> DbqueryjoinSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryjoinSlice::min(self : DbqueryjoinSlice) -> Double { @_common.min(self.data) }

pub fn DbqueryjoinSlice::max(self : DbqueryjoinSlice) -> Double { @_common.max(self.data) }

pub fn DbqueryjoinSlice::to_string(self : DbqueryjoinSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

