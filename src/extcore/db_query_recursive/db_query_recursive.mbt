///===
/// extcore/db_query_recursive

pub(all) struct DbqueryrecursivePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_recursive_make_point(x : Double, y : Double) -> DbqueryrecursivePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_recursive_make_point3(x : Double, y : Double, z : Double) -> DbqueryrecursivePoint {
  { x, y, z, label: 0 }
}

pub fn DbqueryrecursivePoint::x(self : DbqueryrecursivePoint) -> Double { self.x }

pub fn DbqueryrecursivePoint::y(self : DbqueryrecursivePoint) -> Double { self.y }

pub fn DbqueryrecursivePoint::z(self : DbqueryrecursivePoint) -> Double { self.z }

pub fn DbqueryrecursivePoint::label(self : DbqueryrecursivePoint) -> Int { self.label }

pub fn DbqueryrecursivePoint::dist(self : DbqueryrecursivePoint, other : DbqueryrecursivePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbqueryrecursivePoint::add(self : DbqueryrecursivePoint, other : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbqueryrecursivePoint::sub(self : DbqueryrecursivePoint, other : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbqueryrecursivePoint::scale(self : DbqueryrecursivePoint, s : Double) -> DbqueryrecursivePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbqueryrecursivePoint::dot(self : DbqueryrecursivePoint, other : DbqueryrecursivePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbqueryrecursivePoint::cross(self : DbqueryrecursivePoint, other : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbqueryrecursivePoint::norm(self : DbqueryrecursivePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbqueryrecursivePoint::normalize(self : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryrecursivePoint::negate(self : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbqueryrecursivePoint::mid(self : DbqueryrecursivePoint, other : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbqueryrecursivePoint::lerp(self : DbqueryrecursivePoint, other : DbqueryrecursivePoint, t : Double) -> DbqueryrecursivePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbqueryrecursivePoint::to_string(self : DbqueryrecursivePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbqueryrecursiveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_recursive_make_series(vals : Array[Double], name : String) -> DbqueryrecursiveSeries {
  { vals, name, meta: 0 }
}

pub fn DbqueryrecursiveSeries::len(self : DbqueryrecursiveSeries) -> Int { self.vals.length() }

pub fn DbqueryrecursiveSeries::sum(self : DbqueryrecursiveSeries) -> Double { @_common.sum(self.vals) }

pub fn DbqueryrecursiveSeries::mean(self : DbqueryrecursiveSeries) -> Double { @_common.mean(self.vals) }

pub fn DbqueryrecursiveSeries::min(self : DbqueryrecursiveSeries) -> Double { @_common.min(self.vals) }

pub fn DbqueryrecursiveSeries::max(self : DbqueryrecursiveSeries) -> Double { @_common.max(self.vals) }

pub fn DbqueryrecursiveSeries::range(self : DbqueryrecursiveSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbqueryrecursiveSeries::variance(self : DbqueryrecursiveSeries) -> Double { @_common.variance(self.vals) }

pub fn DbqueryrecursiveSeries::std(self : DbqueryrecursiveSeries) -> Double { @_common.std(self.vals) }

pub fn DbqueryrecursiveSeries::median(self : DbqueryrecursiveSeries) -> Double { @_common.median(self.vals) }

pub fn DbqueryrecursiveSeries::scale(self : DbqueryrecursiveSeries, f : Double) -> DbqueryrecursiveSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbqueryrecursiveSeries::add(self : DbqueryrecursiveSeries, other : DbqueryrecursiveSeries) -> DbqueryrecursiveSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbqueryrecursiveSeries::sub(self : DbqueryrecursiveSeries, other : DbqueryrecursiveSeries) -> DbqueryrecursiveSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbqueryrecursiveSeries::normalize(self : DbqueryrecursiveSeries) -> DbqueryrecursiveSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbqueryrecursiveSeries::cumsum(self : DbqueryrecursiveSeries) -> DbqueryrecursiveSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbqueryrecursiveSeries::to_string(self : DbqueryrecursiveSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryrecursiveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_recursive_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryrecursiveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_recursive_matrix_identity(n : Int) -> DbqueryrecursiveMatrix {
  let m = db_query_recursive_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbqueryrecursiveMatrix::get(self : DbqueryrecursiveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbqueryrecursiveMatrix::transpose(self : DbqueryrecursiveMatrix) -> DbqueryrecursiveMatrix {
  let result = db_query_recursive_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbqueryrecursiveMatrix::add(self : DbqueryrecursiveMatrix, other : DbqueryrecursiveMatrix) -> DbqueryrecursiveMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_recursive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbqueryrecursiveMatrix::scale(self : DbqueryrecursiveMatrix, s : Double) -> DbqueryrecursiveMatrix {
  let result = db_query_recursive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbqueryrecursiveMatrix::multiply(self : DbqueryrecursiveMatrix, other : DbqueryrecursiveMatrix) -> DbqueryrecursiveMatrix {
  if self.cols != other.rows { return db_query_recursive_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_recursive_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbqueryrecursiveMatrix::trace(self : DbqueryrecursiveMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbqueryrecursiveMatrix::det(self : DbqueryrecursiveMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbqueryrecursiveMatrix::norm(self : DbqueryrecursiveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbqueryrecursiveMatrix::to_string(self : DbqueryrecursiveMatrix) -> String {
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

pub(all) struct DbqueryrecursiveVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_recursive_make_vector(comps : Array[Double]) -> DbqueryrecursiveVector {
  { comps, dim: comps.length() }
}

pub fn db_query_recursive_vector_zero(dim : Int) -> DbqueryrecursiveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbqueryrecursiveVector::add(self : DbqueryrecursiveVector, other : DbqueryrecursiveVector) -> DbqueryrecursiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryrecursiveVector::sub(self : DbqueryrecursiveVector, other : DbqueryrecursiveVector) -> DbqueryrecursiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryrecursiveVector::scale(self : DbqueryrecursiveVector, s : Double) -> DbqueryrecursiveVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbqueryrecursiveVector::dot(self : DbqueryrecursiveVector, other : DbqueryrecursiveVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbqueryrecursiveVector::norm(self : DbqueryrecursiveVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbqueryrecursiveVector::normalize(self : DbqueryrecursiveVector) -> DbqueryrecursiveVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryrecursiveVector::dist(self : DbqueryrecursiveVector, other : DbqueryrecursiveVector) -> Double {
  self.sub(other).norm()
}

pub fn DbqueryrecursiveVector::to_string(self : DbqueryrecursiveVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_recursive_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_recursive_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_recursive_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_recursive_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_recursive_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_recursive_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_recursive_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_recursive_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_recursive_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_recursive_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_recursive_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_recursive_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_recursive_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_recursive_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_recursive_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_recursive_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_recursive_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_recursive_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_recursive_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_recursive_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_recursive_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_recursive_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_recursive_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_recursive_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_recursive_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_recursive_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_recursive_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_recursive_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_recursive_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbqueryrecursiveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_frame_make(size : Int) -> DbqueryrecursiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryrecursiveFrame::len(self : DbqueryrecursiveFrame) -> Int { self.size }

pub fn DbqueryrecursiveFrame::get(self : DbqueryrecursiveFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryrecursiveFrame::set(self : DbqueryrecursiveFrame, i : Int, v : Double) -> DbqueryrecursiveFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveFrame::sum(self : DbqueryrecursiveFrame) -> Double { @_common.sum(self.data) }

pub fn DbqueryrecursiveFrame::mean(self : DbqueryrecursiveFrame) -> Double { @_common.mean(self.data) }

pub fn DbqueryrecursiveFrame::scale(self : DbqueryrecursiveFrame, f : Double) -> DbqueryrecursiveFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveFrame::add(self : DbqueryrecursiveFrame, other : DbqueryrecursiveFrame) -> DbqueryrecursiveFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryrecursiveFrame::copy(self : DbqueryrecursiveFrame) -> DbqueryrecursiveFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveFrame::fill(self : DbqueryrecursiveFrame, v : Double) -> DbqueryrecursiveFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveFrame::min(self : DbqueryrecursiveFrame) -> Double { @_common.min(self.data) }

pub fn DbqueryrecursiveFrame::max(self : DbqueryrecursiveFrame) -> Double { @_common.max(self.data) }

pub fn DbqueryrecursiveFrame::to_string(self : DbqueryrecursiveFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_table_make(size : Int) -> DbqueryrecursiveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryrecursiveTable::len(self : DbqueryrecursiveTable) -> Int { self.size }

pub fn DbqueryrecursiveTable::get(self : DbqueryrecursiveTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryrecursiveTable::set(self : DbqueryrecursiveTable, i : Int, v : Double) -> DbqueryrecursiveTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveTable::sum(self : DbqueryrecursiveTable) -> Double { @_common.sum(self.data) }

pub fn DbqueryrecursiveTable::mean(self : DbqueryrecursiveTable) -> Double { @_common.mean(self.data) }

pub fn DbqueryrecursiveTable::scale(self : DbqueryrecursiveTable, f : Double) -> DbqueryrecursiveTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveTable::add(self : DbqueryrecursiveTable, other : DbqueryrecursiveTable) -> DbqueryrecursiveTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryrecursiveTable::copy(self : DbqueryrecursiveTable) -> DbqueryrecursiveTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveTable::fill(self : DbqueryrecursiveTable, v : Double) -> DbqueryrecursiveTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveTable::min(self : DbqueryrecursiveTable) -> Double { @_common.min(self.data) }

pub fn DbqueryrecursiveTable::max(self : DbqueryrecursiveTable) -> Double { @_common.max(self.data) }

pub fn DbqueryrecursiveTable::to_string(self : DbqueryrecursiveTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_graphn_make(size : Int) -> DbqueryrecursiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryrecursiveGraphN::len(self : DbqueryrecursiveGraphN) -> Int { self.size }

pub fn DbqueryrecursiveGraphN::get(self : DbqueryrecursiveGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryrecursiveGraphN::set(self : DbqueryrecursiveGraphN, i : Int, v : Double) -> DbqueryrecursiveGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveGraphN::sum(self : DbqueryrecursiveGraphN) -> Double { @_common.sum(self.data) }

pub fn DbqueryrecursiveGraphN::mean(self : DbqueryrecursiveGraphN) -> Double { @_common.mean(self.data) }

pub fn DbqueryrecursiveGraphN::scale(self : DbqueryrecursiveGraphN, f : Double) -> DbqueryrecursiveGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveGraphN::add(self : DbqueryrecursiveGraphN, other : DbqueryrecursiveGraphN) -> DbqueryrecursiveGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryrecursiveGraphN::copy(self : DbqueryrecursiveGraphN) -> DbqueryrecursiveGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveGraphN::fill(self : DbqueryrecursiveGraphN, v : Double) -> DbqueryrecursiveGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveGraphN::min(self : DbqueryrecursiveGraphN) -> Double { @_common.min(self.data) }

pub fn DbqueryrecursiveGraphN::max(self : DbqueryrecursiveGraphN) -> Double { @_common.max(self.data) }

pub fn DbqueryrecursiveGraphN::to_string(self : DbqueryrecursiveGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_node_make(size : Int) -> DbqueryrecursiveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryrecursiveNode::len(self : DbqueryrecursiveNode) -> Int { self.size }

pub fn DbqueryrecursiveNode::get(self : DbqueryrecursiveNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryrecursiveNode::set(self : DbqueryrecursiveNode, i : Int, v : Double) -> DbqueryrecursiveNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveNode::sum(self : DbqueryrecursiveNode) -> Double { @_common.sum(self.data) }

pub fn DbqueryrecursiveNode::mean(self : DbqueryrecursiveNode) -> Double { @_common.mean(self.data) }

pub fn DbqueryrecursiveNode::scale(self : DbqueryrecursiveNode, f : Double) -> DbqueryrecursiveNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveNode::add(self : DbqueryrecursiveNode, other : DbqueryrecursiveNode) -> DbqueryrecursiveNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryrecursiveNode::copy(self : DbqueryrecursiveNode) -> DbqueryrecursiveNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveNode::fill(self : DbqueryrecursiveNode, v : Double) -> DbqueryrecursiveNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveNode::min(self : DbqueryrecursiveNode) -> Double { @_common.min(self.data) }

pub fn DbqueryrecursiveNode::max(self : DbqueryrecursiveNode) -> Double { @_common.max(self.data) }

pub fn DbqueryrecursiveNode::to_string(self : DbqueryrecursiveNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_edge_make(size : Int) -> DbqueryrecursiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryrecursiveEdge::len(self : DbqueryrecursiveEdge) -> Int { self.size }

pub fn DbqueryrecursiveEdge::get(self : DbqueryrecursiveEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryrecursiveEdge::set(self : DbqueryrecursiveEdge, i : Int, v : Double) -> DbqueryrecursiveEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveEdge::sum(self : DbqueryrecursiveEdge) -> Double { @_common.sum(self.data) }

pub fn DbqueryrecursiveEdge::mean(self : DbqueryrecursiveEdge) -> Double { @_common.mean(self.data) }

pub fn DbqueryrecursiveEdge::scale(self : DbqueryrecursiveEdge, f : Double) -> DbqueryrecursiveEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveEdge::add(self : DbqueryrecursiveEdge, other : DbqueryrecursiveEdge) -> DbqueryrecursiveEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryrecursiveEdge::copy(self : DbqueryrecursiveEdge) -> DbqueryrecursiveEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveEdge::fill(self : DbqueryrecursiveEdge, v : Double) -> DbqueryrecursiveEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveEdge::min(self : DbqueryrecursiveEdge) -> Double { @_common.min(self.data) }

pub fn DbqueryrecursiveEdge::max(self : DbqueryrecursiveEdge) -> Double { @_common.max(self.data) }

pub fn DbqueryrecursiveEdge::to_string(self : DbqueryrecursiveEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursivePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_path_make(size : Int) -> DbqueryrecursivePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryrecursivePath::len(self : DbqueryrecursivePath) -> Int { self.size }

pub fn DbqueryrecursivePath::get(self : DbqueryrecursivePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryrecursivePath::set(self : DbqueryrecursivePath, i : Int, v : Double) -> DbqueryrecursivePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryrecursivePath::sum(self : DbqueryrecursivePath) -> Double { @_common.sum(self.data) }

pub fn DbqueryrecursivePath::mean(self : DbqueryrecursivePath) -> Double { @_common.mean(self.data) }

pub fn DbqueryrecursivePath::scale(self : DbqueryrecursivePath, f : Double) -> DbqueryrecursivePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursivePath::add(self : DbqueryrecursivePath, other : DbqueryrecursivePath) -> DbqueryrecursivePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryrecursivePath::copy(self : DbqueryrecursivePath) -> DbqueryrecursivePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursivePath::fill(self : DbqueryrecursivePath, v : Double) -> DbqueryrecursivePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursivePath::min(self : DbqueryrecursivePath) -> Double { @_common.min(self.data) }

pub fn DbqueryrecursivePath::max(self : DbqueryrecursivePath) -> Double { @_common.max(self.data) }

pub fn DbqueryrecursivePath::to_string(self : DbqueryrecursivePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_cluster_make(size : Int) -> DbqueryrecursiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryrecursiveCluster::len(self : DbqueryrecursiveCluster) -> Int { self.size }

pub fn DbqueryrecursiveCluster::get(self : DbqueryrecursiveCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryrecursiveCluster::set(self : DbqueryrecursiveCluster, i : Int, v : Double) -> DbqueryrecursiveCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveCluster::sum(self : DbqueryrecursiveCluster) -> Double { @_common.sum(self.data) }

pub fn DbqueryrecursiveCluster::mean(self : DbqueryrecursiveCluster) -> Double { @_common.mean(self.data) }

pub fn DbqueryrecursiveCluster::scale(self : DbqueryrecursiveCluster, f : Double) -> DbqueryrecursiveCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveCluster::add(self : DbqueryrecursiveCluster, other : DbqueryrecursiveCluster) -> DbqueryrecursiveCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryrecursiveCluster::copy(self : DbqueryrecursiveCluster) -> DbqueryrecursiveCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveCluster::fill(self : DbqueryrecursiveCluster, v : Double) -> DbqueryrecursiveCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveCluster::min(self : DbqueryrecursiveCluster) -> Double { @_common.min(self.data) }

pub fn DbqueryrecursiveCluster::max(self : DbqueryrecursiveCluster) -> Double { @_common.max(self.data) }

pub fn DbqueryrecursiveCluster::to_string(self : DbqueryrecursiveCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_model_make(size : Int) -> DbqueryrecursiveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryrecursiveModel::len(self : DbqueryrecursiveModel) -> Int { self.size }

pub fn DbqueryrecursiveModel::get(self : DbqueryrecursiveModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryrecursiveModel::set(self : DbqueryrecursiveModel, i : Int, v : Double) -> DbqueryrecursiveModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveModel::sum(self : DbqueryrecursiveModel) -> Double { @_common.sum(self.data) }

pub fn DbqueryrecursiveModel::mean(self : DbqueryrecursiveModel) -> Double { @_common.mean(self.data) }

pub fn DbqueryrecursiveModel::scale(self : DbqueryrecursiveModel, f : Double) -> DbqueryrecursiveModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveModel::add(self : DbqueryrecursiveModel, other : DbqueryrecursiveModel) -> DbqueryrecursiveModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryrecursiveModel::copy(self : DbqueryrecursiveModel) -> DbqueryrecursiveModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveModel::fill(self : DbqueryrecursiveModel, v : Double) -> DbqueryrecursiveModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveModel::min(self : DbqueryrecursiveModel) -> Double { @_common.min(self.data) }

pub fn DbqueryrecursiveModel::max(self : DbqueryrecursiveModel) -> Double { @_common.max(self.data) }

pub fn DbqueryrecursiveModel::to_string(self : DbqueryrecursiveModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_layer_make(size : Int) -> DbqueryrecursiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryrecursiveLayer::len(self : DbqueryrecursiveLayer) -> Int { self.size }

pub fn DbqueryrecursiveLayer::get(self : DbqueryrecursiveLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryrecursiveLayer::set(self : DbqueryrecursiveLayer, i : Int, v : Double) -> DbqueryrecursiveLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveLayer::sum(self : DbqueryrecursiveLayer) -> Double { @_common.sum(self.data) }

pub fn DbqueryrecursiveLayer::mean(self : DbqueryrecursiveLayer) -> Double { @_common.mean(self.data) }

pub fn DbqueryrecursiveLayer::scale(self : DbqueryrecursiveLayer, f : Double) -> DbqueryrecursiveLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveLayer::add(self : DbqueryrecursiveLayer, other : DbqueryrecursiveLayer) -> DbqueryrecursiveLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryrecursiveLayer::copy(self : DbqueryrecursiveLayer) -> DbqueryrecursiveLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveLayer::fill(self : DbqueryrecursiveLayer, v : Double) -> DbqueryrecursiveLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveLayer::min(self : DbqueryrecursiveLayer) -> Double { @_common.min(self.data) }

pub fn DbqueryrecursiveLayer::max(self : DbqueryrecursiveLayer) -> Double { @_common.max(self.data) }

pub fn DbqueryrecursiveLayer::to_string(self : DbqueryrecursiveLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_buffer_make(size : Int) -> DbqueryrecursiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryrecursiveBuffer::len(self : DbqueryrecursiveBuffer) -> Int { self.size }

pub fn DbqueryrecursiveBuffer::get(self : DbqueryrecursiveBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryrecursiveBuffer::set(self : DbqueryrecursiveBuffer, i : Int, v : Double) -> DbqueryrecursiveBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveBuffer::sum(self : DbqueryrecursiveBuffer) -> Double { @_common.sum(self.data) }

pub fn DbqueryrecursiveBuffer::mean(self : DbqueryrecursiveBuffer) -> Double { @_common.mean(self.data) }

pub fn DbqueryrecursiveBuffer::scale(self : DbqueryrecursiveBuffer, f : Double) -> DbqueryrecursiveBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveBuffer::add(self : DbqueryrecursiveBuffer, other : DbqueryrecursiveBuffer) -> DbqueryrecursiveBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryrecursiveBuffer::copy(self : DbqueryrecursiveBuffer) -> DbqueryrecursiveBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveBuffer::fill(self : DbqueryrecursiveBuffer, v : Double) -> DbqueryrecursiveBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveBuffer::min(self : DbqueryrecursiveBuffer) -> Double { @_common.min(self.data) }

pub fn DbqueryrecursiveBuffer::max(self : DbqueryrecursiveBuffer) -> Double { @_common.max(self.data) }

pub fn DbqueryrecursiveBuffer::to_string(self : DbqueryrecursiveBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_cursor_make(size : Int) -> DbqueryrecursiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryrecursiveCursor::len(self : DbqueryrecursiveCursor) -> Int { self.size }

pub fn DbqueryrecursiveCursor::get(self : DbqueryrecursiveCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryrecursiveCursor::set(self : DbqueryrecursiveCursor, i : Int, v : Double) -> DbqueryrecursiveCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveCursor::sum(self : DbqueryrecursiveCursor) -> Double { @_common.sum(self.data) }

pub fn DbqueryrecursiveCursor::mean(self : DbqueryrecursiveCursor) -> Double { @_common.mean(self.data) }

pub fn DbqueryrecursiveCursor::scale(self : DbqueryrecursiveCursor, f : Double) -> DbqueryrecursiveCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveCursor::add(self : DbqueryrecursiveCursor, other : DbqueryrecursiveCursor) -> DbqueryrecursiveCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryrecursiveCursor::copy(self : DbqueryrecursiveCursor) -> DbqueryrecursiveCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveCursor::fill(self : DbqueryrecursiveCursor, v : Double) -> DbqueryrecursiveCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveCursor::min(self : DbqueryrecursiveCursor) -> Double { @_common.min(self.data) }

pub fn DbqueryrecursiveCursor::max(self : DbqueryrecursiveCursor) -> Double { @_common.max(self.data) }

pub fn DbqueryrecursiveCursor::to_string(self : DbqueryrecursiveCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_view_make(size : Int) -> DbqueryrecursiveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryrecursiveView::len(self : DbqueryrecursiveView) -> Int { self.size }

pub fn DbqueryrecursiveView::get(self : DbqueryrecursiveView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryrecursiveView::set(self : DbqueryrecursiveView, i : Int, v : Double) -> DbqueryrecursiveView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveView::sum(self : DbqueryrecursiveView) -> Double { @_common.sum(self.data) }

pub fn DbqueryrecursiveView::mean(self : DbqueryrecursiveView) -> Double { @_common.mean(self.data) }

pub fn DbqueryrecursiveView::scale(self : DbqueryrecursiveView, f : Double) -> DbqueryrecursiveView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveView::add(self : DbqueryrecursiveView, other : DbqueryrecursiveView) -> DbqueryrecursiveView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryrecursiveView::copy(self : DbqueryrecursiveView) -> DbqueryrecursiveView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveView::fill(self : DbqueryrecursiveView, v : Double) -> DbqueryrecursiveView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveView::min(self : DbqueryrecursiveView) -> Double { @_common.min(self.data) }

pub fn DbqueryrecursiveView::max(self : DbqueryrecursiveView) -> Double { @_common.max(self.data) }

pub fn DbqueryrecursiveView::to_string(self : DbqueryrecursiveView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_range_make(size : Int) -> DbqueryrecursiveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryrecursiveRange::len(self : DbqueryrecursiveRange) -> Int { self.size }

pub fn DbqueryrecursiveRange::get(self : DbqueryrecursiveRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryrecursiveRange::set(self : DbqueryrecursiveRange, i : Int, v : Double) -> DbqueryrecursiveRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveRange::sum(self : DbqueryrecursiveRange) -> Double { @_common.sum(self.data) }

pub fn DbqueryrecursiveRange::mean(self : DbqueryrecursiveRange) -> Double { @_common.mean(self.data) }

pub fn DbqueryrecursiveRange::scale(self : DbqueryrecursiveRange, f : Double) -> DbqueryrecursiveRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveRange::add(self : DbqueryrecursiveRange, other : DbqueryrecursiveRange) -> DbqueryrecursiveRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryrecursiveRange::copy(self : DbqueryrecursiveRange) -> DbqueryrecursiveRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveRange::fill(self : DbqueryrecursiveRange, v : Double) -> DbqueryrecursiveRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveRange::min(self : DbqueryrecursiveRange) -> Double { @_common.min(self.data) }

pub fn DbqueryrecursiveRange::max(self : DbqueryrecursiveRange) -> Double { @_common.max(self.data) }

pub fn DbqueryrecursiveRange::to_string(self : DbqueryrecursiveRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_slice_make(size : Int) -> DbqueryrecursiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryrecursiveSlice::len(self : DbqueryrecursiveSlice) -> Int { self.size }

pub fn DbqueryrecursiveSlice::get(self : DbqueryrecursiveSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryrecursiveSlice::set(self : DbqueryrecursiveSlice, i : Int, v : Double) -> DbqueryrecursiveSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveSlice::sum(self : DbqueryrecursiveSlice) -> Double { @_common.sum(self.data) }

pub fn DbqueryrecursiveSlice::mean(self : DbqueryrecursiveSlice) -> Double { @_common.mean(self.data) }

pub fn DbqueryrecursiveSlice::scale(self : DbqueryrecursiveSlice, f : Double) -> DbqueryrecursiveSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveSlice::add(self : DbqueryrecursiveSlice, other : DbqueryrecursiveSlice) -> DbqueryrecursiveSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryrecursiveSlice::copy(self : DbqueryrecursiveSlice) -> DbqueryrecursiveSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveSlice::fill(self : DbqueryrecursiveSlice, v : Double) -> DbqueryrecursiveSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryrecursiveSlice::min(self : DbqueryrecursiveSlice) -> Double { @_common.min(self.data) }

pub fn DbqueryrecursiveSlice::max(self : DbqueryrecursiveSlice) -> Double { @_common.max(self.data) }

pub fn DbqueryrecursiveSlice::to_string(self : DbqueryrecursiveSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

