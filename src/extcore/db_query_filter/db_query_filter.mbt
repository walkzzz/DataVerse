///===
/// extcore/db_query_filter

pub(all) struct DbqueryfilterPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_filter_make_point(x : Double, y : Double) -> DbqueryfilterPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_filter_make_point3(x : Double, y : Double, z : Double) -> DbqueryfilterPoint {
  { x, y, z, label: 0 }
}

pub fn DbqueryfilterPoint::x(self : DbqueryfilterPoint) -> Double { self.x }

pub fn DbqueryfilterPoint::y(self : DbqueryfilterPoint) -> Double { self.y }

pub fn DbqueryfilterPoint::z(self : DbqueryfilterPoint) -> Double { self.z }

pub fn DbqueryfilterPoint::label(self : DbqueryfilterPoint) -> Int { self.label }

pub fn DbqueryfilterPoint::dist(self : DbqueryfilterPoint, other : DbqueryfilterPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbqueryfilterPoint::add(self : DbqueryfilterPoint, other : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbqueryfilterPoint::sub(self : DbqueryfilterPoint, other : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbqueryfilterPoint::scale(self : DbqueryfilterPoint, s : Double) -> DbqueryfilterPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbqueryfilterPoint::dot(self : DbqueryfilterPoint, other : DbqueryfilterPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbqueryfilterPoint::cross(self : DbqueryfilterPoint, other : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbqueryfilterPoint::norm(self : DbqueryfilterPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbqueryfilterPoint::normalize(self : DbqueryfilterPoint) -> DbqueryfilterPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryfilterPoint::negate(self : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbqueryfilterPoint::mid(self : DbqueryfilterPoint, other : DbqueryfilterPoint) -> DbqueryfilterPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbqueryfilterPoint::lerp(self : DbqueryfilterPoint, other : DbqueryfilterPoint, t : Double) -> DbqueryfilterPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbqueryfilterPoint::to_string(self : DbqueryfilterPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbqueryfilterSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_filter_make_series(vals : Array[Double], name : String) -> DbqueryfilterSeries {
  { vals, name, meta: 0 }
}

pub fn DbqueryfilterSeries::len(self : DbqueryfilterSeries) -> Int { self.vals.length() }

pub fn DbqueryfilterSeries::sum(self : DbqueryfilterSeries) -> Double { @_common.sum(self.vals) }

pub fn DbqueryfilterSeries::mean(self : DbqueryfilterSeries) -> Double { @_common.mean(self.vals) }

pub fn DbqueryfilterSeries::min(self : DbqueryfilterSeries) -> Double { @_common.min(self.vals) }

pub fn DbqueryfilterSeries::max(self : DbqueryfilterSeries) -> Double { @_common.max(self.vals) }

pub fn DbqueryfilterSeries::range(self : DbqueryfilterSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbqueryfilterSeries::variance(self : DbqueryfilterSeries) -> Double { @_common.variance(self.vals) }

pub fn DbqueryfilterSeries::std(self : DbqueryfilterSeries) -> Double { @_common.std(self.vals) }

pub fn DbqueryfilterSeries::median(self : DbqueryfilterSeries) -> Double { @_common.median(self.vals) }

pub fn DbqueryfilterSeries::scale(self : DbqueryfilterSeries, f : Double) -> DbqueryfilterSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbqueryfilterSeries::add(self : DbqueryfilterSeries, other : DbqueryfilterSeries) -> DbqueryfilterSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbqueryfilterSeries::sub(self : DbqueryfilterSeries, other : DbqueryfilterSeries) -> DbqueryfilterSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbqueryfilterSeries::normalize(self : DbqueryfilterSeries) -> DbqueryfilterSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbqueryfilterSeries::cumsum(self : DbqueryfilterSeries) -> DbqueryfilterSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbqueryfilterSeries::to_string(self : DbqueryfilterSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryfilterMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_filter_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryfilterMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_filter_matrix_identity(n : Int) -> DbqueryfilterMatrix {
  let m = db_query_filter_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbqueryfilterMatrix::get(self : DbqueryfilterMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbqueryfilterMatrix::transpose(self : DbqueryfilterMatrix) -> DbqueryfilterMatrix {
  let result = db_query_filter_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbqueryfilterMatrix::add(self : DbqueryfilterMatrix, other : DbqueryfilterMatrix) -> DbqueryfilterMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_query_filter_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbqueryfilterMatrix::scale(self : DbqueryfilterMatrix, s : Double) -> DbqueryfilterMatrix {
  let result = db_query_filter_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbqueryfilterMatrix::multiply(self : DbqueryfilterMatrix, other : DbqueryfilterMatrix) -> DbqueryfilterMatrix {
  if self.cols != other.rows { return db_query_filter_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_query_filter_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbqueryfilterMatrix::trace(self : DbqueryfilterMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbqueryfilterMatrix::det(self : DbqueryfilterMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbqueryfilterMatrix::norm(self : DbqueryfilterMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbqueryfilterMatrix::to_string(self : DbqueryfilterMatrix) -> String {
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

pub(all) struct DbqueryfilterVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_filter_make_vector(comps : Array[Double]) -> DbqueryfilterVector {
  { comps, dim: comps.length() }
}

pub fn db_query_filter_vector_zero(dim : Int) -> DbqueryfilterVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbqueryfilterVector::add(self : DbqueryfilterVector, other : DbqueryfilterVector) -> DbqueryfilterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryfilterVector::sub(self : DbqueryfilterVector, other : DbqueryfilterVector) -> DbqueryfilterVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbqueryfilterVector::scale(self : DbqueryfilterVector, s : Double) -> DbqueryfilterVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbqueryfilterVector::dot(self : DbqueryfilterVector, other : DbqueryfilterVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbqueryfilterVector::norm(self : DbqueryfilterVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbqueryfilterVector::normalize(self : DbqueryfilterVector) -> DbqueryfilterVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbqueryfilterVector::dist(self : DbqueryfilterVector, other : DbqueryfilterVector) -> Double {
  self.sub(other).norm()
}

pub fn DbqueryfilterVector::to_string(self : DbqueryfilterVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_filter_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_query_filter_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_query_filter_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_query_filter_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_query_filter_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_query_filter_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_query_filter_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_query_filter_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_query_filter_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_query_filter_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_query_filter_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_query_filter_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_query_filter_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_query_filter_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_query_filter_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_query_filter_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_query_filter_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_query_filter_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_query_filter_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_query_filter_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_query_filter_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_query_filter_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_query_filter_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_query_filter_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_query_filter_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_query_filter_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_query_filter_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_query_filter_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_query_filter_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbqueryfilterFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_frame_make(size : Int) -> DbqueryfilterFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryfilterFrame::len(self : DbqueryfilterFrame) -> Int { self.size }

pub fn DbqueryfilterFrame::get(self : DbqueryfilterFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryfilterFrame::set(self : DbqueryfilterFrame, i : Int, v : Double) -> DbqueryfilterFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryfilterFrame::sum(self : DbqueryfilterFrame) -> Double { @_common.sum(self.data) }

pub fn DbqueryfilterFrame::mean(self : DbqueryfilterFrame) -> Double { @_common.mean(self.data) }

pub fn DbqueryfilterFrame::scale(self : DbqueryfilterFrame, f : Double) -> DbqueryfilterFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterFrame::add(self : DbqueryfilterFrame, other : DbqueryfilterFrame) -> DbqueryfilterFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryfilterFrame::copy(self : DbqueryfilterFrame) -> DbqueryfilterFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterFrame::fill(self : DbqueryfilterFrame, v : Double) -> DbqueryfilterFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterFrame::min(self : DbqueryfilterFrame) -> Double { @_common.min(self.data) }

pub fn DbqueryfilterFrame::max(self : DbqueryfilterFrame) -> Double { @_common.max(self.data) }

pub fn DbqueryfilterFrame::to_string(self : DbqueryfilterFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_table_make(size : Int) -> DbqueryfilterTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryfilterTable::len(self : DbqueryfilterTable) -> Int { self.size }

pub fn DbqueryfilterTable::get(self : DbqueryfilterTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryfilterTable::set(self : DbqueryfilterTable, i : Int, v : Double) -> DbqueryfilterTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryfilterTable::sum(self : DbqueryfilterTable) -> Double { @_common.sum(self.data) }

pub fn DbqueryfilterTable::mean(self : DbqueryfilterTable) -> Double { @_common.mean(self.data) }

pub fn DbqueryfilterTable::scale(self : DbqueryfilterTable, f : Double) -> DbqueryfilterTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterTable::add(self : DbqueryfilterTable, other : DbqueryfilterTable) -> DbqueryfilterTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryfilterTable::copy(self : DbqueryfilterTable) -> DbqueryfilterTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterTable::fill(self : DbqueryfilterTable, v : Double) -> DbqueryfilterTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterTable::min(self : DbqueryfilterTable) -> Double { @_common.min(self.data) }

pub fn DbqueryfilterTable::max(self : DbqueryfilterTable) -> Double { @_common.max(self.data) }

pub fn DbqueryfilterTable::to_string(self : DbqueryfilterTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_graphn_make(size : Int) -> DbqueryfilterGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryfilterGraphN::len(self : DbqueryfilterGraphN) -> Int { self.size }

pub fn DbqueryfilterGraphN::get(self : DbqueryfilterGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryfilterGraphN::set(self : DbqueryfilterGraphN, i : Int, v : Double) -> DbqueryfilterGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryfilterGraphN::sum(self : DbqueryfilterGraphN) -> Double { @_common.sum(self.data) }

pub fn DbqueryfilterGraphN::mean(self : DbqueryfilterGraphN) -> Double { @_common.mean(self.data) }

pub fn DbqueryfilterGraphN::scale(self : DbqueryfilterGraphN, f : Double) -> DbqueryfilterGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterGraphN::add(self : DbqueryfilterGraphN, other : DbqueryfilterGraphN) -> DbqueryfilterGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryfilterGraphN::copy(self : DbqueryfilterGraphN) -> DbqueryfilterGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterGraphN::fill(self : DbqueryfilterGraphN, v : Double) -> DbqueryfilterGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterGraphN::min(self : DbqueryfilterGraphN) -> Double { @_common.min(self.data) }

pub fn DbqueryfilterGraphN::max(self : DbqueryfilterGraphN) -> Double { @_common.max(self.data) }

pub fn DbqueryfilterGraphN::to_string(self : DbqueryfilterGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_node_make(size : Int) -> DbqueryfilterNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryfilterNode::len(self : DbqueryfilterNode) -> Int { self.size }

pub fn DbqueryfilterNode::get(self : DbqueryfilterNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryfilterNode::set(self : DbqueryfilterNode, i : Int, v : Double) -> DbqueryfilterNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryfilterNode::sum(self : DbqueryfilterNode) -> Double { @_common.sum(self.data) }

pub fn DbqueryfilterNode::mean(self : DbqueryfilterNode) -> Double { @_common.mean(self.data) }

pub fn DbqueryfilterNode::scale(self : DbqueryfilterNode, f : Double) -> DbqueryfilterNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterNode::add(self : DbqueryfilterNode, other : DbqueryfilterNode) -> DbqueryfilterNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryfilterNode::copy(self : DbqueryfilterNode) -> DbqueryfilterNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterNode::fill(self : DbqueryfilterNode, v : Double) -> DbqueryfilterNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterNode::min(self : DbqueryfilterNode) -> Double { @_common.min(self.data) }

pub fn DbqueryfilterNode::max(self : DbqueryfilterNode) -> Double { @_common.max(self.data) }

pub fn DbqueryfilterNode::to_string(self : DbqueryfilterNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_edge_make(size : Int) -> DbqueryfilterEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryfilterEdge::len(self : DbqueryfilterEdge) -> Int { self.size }

pub fn DbqueryfilterEdge::get(self : DbqueryfilterEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryfilterEdge::set(self : DbqueryfilterEdge, i : Int, v : Double) -> DbqueryfilterEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryfilterEdge::sum(self : DbqueryfilterEdge) -> Double { @_common.sum(self.data) }

pub fn DbqueryfilterEdge::mean(self : DbqueryfilterEdge) -> Double { @_common.mean(self.data) }

pub fn DbqueryfilterEdge::scale(self : DbqueryfilterEdge, f : Double) -> DbqueryfilterEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterEdge::add(self : DbqueryfilterEdge, other : DbqueryfilterEdge) -> DbqueryfilterEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryfilterEdge::copy(self : DbqueryfilterEdge) -> DbqueryfilterEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterEdge::fill(self : DbqueryfilterEdge, v : Double) -> DbqueryfilterEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterEdge::min(self : DbqueryfilterEdge) -> Double { @_common.min(self.data) }

pub fn DbqueryfilterEdge::max(self : DbqueryfilterEdge) -> Double { @_common.max(self.data) }

pub fn DbqueryfilterEdge::to_string(self : DbqueryfilterEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_path_make(size : Int) -> DbqueryfilterPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryfilterPath::len(self : DbqueryfilterPath) -> Int { self.size }

pub fn DbqueryfilterPath::get(self : DbqueryfilterPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryfilterPath::set(self : DbqueryfilterPath, i : Int, v : Double) -> DbqueryfilterPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryfilterPath::sum(self : DbqueryfilterPath) -> Double { @_common.sum(self.data) }

pub fn DbqueryfilterPath::mean(self : DbqueryfilterPath) -> Double { @_common.mean(self.data) }

pub fn DbqueryfilterPath::scale(self : DbqueryfilterPath, f : Double) -> DbqueryfilterPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterPath::add(self : DbqueryfilterPath, other : DbqueryfilterPath) -> DbqueryfilterPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryfilterPath::copy(self : DbqueryfilterPath) -> DbqueryfilterPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterPath::fill(self : DbqueryfilterPath, v : Double) -> DbqueryfilterPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterPath::min(self : DbqueryfilterPath) -> Double { @_common.min(self.data) }

pub fn DbqueryfilterPath::max(self : DbqueryfilterPath) -> Double { @_common.max(self.data) }

pub fn DbqueryfilterPath::to_string(self : DbqueryfilterPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_cluster_make(size : Int) -> DbqueryfilterCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryfilterCluster::len(self : DbqueryfilterCluster) -> Int { self.size }

pub fn DbqueryfilterCluster::get(self : DbqueryfilterCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryfilterCluster::set(self : DbqueryfilterCluster, i : Int, v : Double) -> DbqueryfilterCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryfilterCluster::sum(self : DbqueryfilterCluster) -> Double { @_common.sum(self.data) }

pub fn DbqueryfilterCluster::mean(self : DbqueryfilterCluster) -> Double { @_common.mean(self.data) }

pub fn DbqueryfilterCluster::scale(self : DbqueryfilterCluster, f : Double) -> DbqueryfilterCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterCluster::add(self : DbqueryfilterCluster, other : DbqueryfilterCluster) -> DbqueryfilterCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryfilterCluster::copy(self : DbqueryfilterCluster) -> DbqueryfilterCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterCluster::fill(self : DbqueryfilterCluster, v : Double) -> DbqueryfilterCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterCluster::min(self : DbqueryfilterCluster) -> Double { @_common.min(self.data) }

pub fn DbqueryfilterCluster::max(self : DbqueryfilterCluster) -> Double { @_common.max(self.data) }

pub fn DbqueryfilterCluster::to_string(self : DbqueryfilterCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_model_make(size : Int) -> DbqueryfilterModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryfilterModel::len(self : DbqueryfilterModel) -> Int { self.size }

pub fn DbqueryfilterModel::get(self : DbqueryfilterModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryfilterModel::set(self : DbqueryfilterModel, i : Int, v : Double) -> DbqueryfilterModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryfilterModel::sum(self : DbqueryfilterModel) -> Double { @_common.sum(self.data) }

pub fn DbqueryfilterModel::mean(self : DbqueryfilterModel) -> Double { @_common.mean(self.data) }

pub fn DbqueryfilterModel::scale(self : DbqueryfilterModel, f : Double) -> DbqueryfilterModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterModel::add(self : DbqueryfilterModel, other : DbqueryfilterModel) -> DbqueryfilterModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryfilterModel::copy(self : DbqueryfilterModel) -> DbqueryfilterModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterModel::fill(self : DbqueryfilterModel, v : Double) -> DbqueryfilterModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterModel::min(self : DbqueryfilterModel) -> Double { @_common.min(self.data) }

pub fn DbqueryfilterModel::max(self : DbqueryfilterModel) -> Double { @_common.max(self.data) }

pub fn DbqueryfilterModel::to_string(self : DbqueryfilterModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_layer_make(size : Int) -> DbqueryfilterLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryfilterLayer::len(self : DbqueryfilterLayer) -> Int { self.size }

pub fn DbqueryfilterLayer::get(self : DbqueryfilterLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryfilterLayer::set(self : DbqueryfilterLayer, i : Int, v : Double) -> DbqueryfilterLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryfilterLayer::sum(self : DbqueryfilterLayer) -> Double { @_common.sum(self.data) }

pub fn DbqueryfilterLayer::mean(self : DbqueryfilterLayer) -> Double { @_common.mean(self.data) }

pub fn DbqueryfilterLayer::scale(self : DbqueryfilterLayer, f : Double) -> DbqueryfilterLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterLayer::add(self : DbqueryfilterLayer, other : DbqueryfilterLayer) -> DbqueryfilterLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryfilterLayer::copy(self : DbqueryfilterLayer) -> DbqueryfilterLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterLayer::fill(self : DbqueryfilterLayer, v : Double) -> DbqueryfilterLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterLayer::min(self : DbqueryfilterLayer) -> Double { @_common.min(self.data) }

pub fn DbqueryfilterLayer::max(self : DbqueryfilterLayer) -> Double { @_common.max(self.data) }

pub fn DbqueryfilterLayer::to_string(self : DbqueryfilterLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_buffer_make(size : Int) -> DbqueryfilterBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryfilterBuffer::len(self : DbqueryfilterBuffer) -> Int { self.size }

pub fn DbqueryfilterBuffer::get(self : DbqueryfilterBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryfilterBuffer::set(self : DbqueryfilterBuffer, i : Int, v : Double) -> DbqueryfilterBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryfilterBuffer::sum(self : DbqueryfilterBuffer) -> Double { @_common.sum(self.data) }

pub fn DbqueryfilterBuffer::mean(self : DbqueryfilterBuffer) -> Double { @_common.mean(self.data) }

pub fn DbqueryfilterBuffer::scale(self : DbqueryfilterBuffer, f : Double) -> DbqueryfilterBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterBuffer::add(self : DbqueryfilterBuffer, other : DbqueryfilterBuffer) -> DbqueryfilterBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryfilterBuffer::copy(self : DbqueryfilterBuffer) -> DbqueryfilterBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterBuffer::fill(self : DbqueryfilterBuffer, v : Double) -> DbqueryfilterBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterBuffer::min(self : DbqueryfilterBuffer) -> Double { @_common.min(self.data) }

pub fn DbqueryfilterBuffer::max(self : DbqueryfilterBuffer) -> Double { @_common.max(self.data) }

pub fn DbqueryfilterBuffer::to_string(self : DbqueryfilterBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_cursor_make(size : Int) -> DbqueryfilterCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryfilterCursor::len(self : DbqueryfilterCursor) -> Int { self.size }

pub fn DbqueryfilterCursor::get(self : DbqueryfilterCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryfilterCursor::set(self : DbqueryfilterCursor, i : Int, v : Double) -> DbqueryfilterCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryfilterCursor::sum(self : DbqueryfilterCursor) -> Double { @_common.sum(self.data) }

pub fn DbqueryfilterCursor::mean(self : DbqueryfilterCursor) -> Double { @_common.mean(self.data) }

pub fn DbqueryfilterCursor::scale(self : DbqueryfilterCursor, f : Double) -> DbqueryfilterCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterCursor::add(self : DbqueryfilterCursor, other : DbqueryfilterCursor) -> DbqueryfilterCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryfilterCursor::copy(self : DbqueryfilterCursor) -> DbqueryfilterCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterCursor::fill(self : DbqueryfilterCursor, v : Double) -> DbqueryfilterCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterCursor::min(self : DbqueryfilterCursor) -> Double { @_common.min(self.data) }

pub fn DbqueryfilterCursor::max(self : DbqueryfilterCursor) -> Double { @_common.max(self.data) }

pub fn DbqueryfilterCursor::to_string(self : DbqueryfilterCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_view_make(size : Int) -> DbqueryfilterView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryfilterView::len(self : DbqueryfilterView) -> Int { self.size }

pub fn DbqueryfilterView::get(self : DbqueryfilterView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryfilterView::set(self : DbqueryfilterView, i : Int, v : Double) -> DbqueryfilterView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryfilterView::sum(self : DbqueryfilterView) -> Double { @_common.sum(self.data) }

pub fn DbqueryfilterView::mean(self : DbqueryfilterView) -> Double { @_common.mean(self.data) }

pub fn DbqueryfilterView::scale(self : DbqueryfilterView, f : Double) -> DbqueryfilterView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterView::add(self : DbqueryfilterView, other : DbqueryfilterView) -> DbqueryfilterView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryfilterView::copy(self : DbqueryfilterView) -> DbqueryfilterView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterView::fill(self : DbqueryfilterView, v : Double) -> DbqueryfilterView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterView::min(self : DbqueryfilterView) -> Double { @_common.min(self.data) }

pub fn DbqueryfilterView::max(self : DbqueryfilterView) -> Double { @_common.max(self.data) }

pub fn DbqueryfilterView::to_string(self : DbqueryfilterView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_range_make(size : Int) -> DbqueryfilterRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryfilterRange::len(self : DbqueryfilterRange) -> Int { self.size }

pub fn DbqueryfilterRange::get(self : DbqueryfilterRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryfilterRange::set(self : DbqueryfilterRange, i : Int, v : Double) -> DbqueryfilterRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryfilterRange::sum(self : DbqueryfilterRange) -> Double { @_common.sum(self.data) }

pub fn DbqueryfilterRange::mean(self : DbqueryfilterRange) -> Double { @_common.mean(self.data) }

pub fn DbqueryfilterRange::scale(self : DbqueryfilterRange, f : Double) -> DbqueryfilterRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterRange::add(self : DbqueryfilterRange, other : DbqueryfilterRange) -> DbqueryfilterRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryfilterRange::copy(self : DbqueryfilterRange) -> DbqueryfilterRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterRange::fill(self : DbqueryfilterRange, v : Double) -> DbqueryfilterRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterRange::min(self : DbqueryfilterRange) -> Double { @_common.min(self.data) }

pub fn DbqueryfilterRange::max(self : DbqueryfilterRange) -> Double { @_common.max(self.data) }

pub fn DbqueryfilterRange::to_string(self : DbqueryfilterRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbqueryfilterSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_filter_slice_make(size : Int) -> DbqueryfilterSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbqueryfilterSlice::len(self : DbqueryfilterSlice) -> Int { self.size }

pub fn DbqueryfilterSlice::get(self : DbqueryfilterSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbqueryfilterSlice::set(self : DbqueryfilterSlice, i : Int, v : Double) -> DbqueryfilterSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbqueryfilterSlice::sum(self : DbqueryfilterSlice) -> Double { @_common.sum(self.data) }

pub fn DbqueryfilterSlice::mean(self : DbqueryfilterSlice) -> Double { @_common.mean(self.data) }

pub fn DbqueryfilterSlice::scale(self : DbqueryfilterSlice, f : Double) -> DbqueryfilterSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterSlice::add(self : DbqueryfilterSlice, other : DbqueryfilterSlice) -> DbqueryfilterSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbqueryfilterSlice::copy(self : DbqueryfilterSlice) -> DbqueryfilterSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterSlice::fill(self : DbqueryfilterSlice, v : Double) -> DbqueryfilterSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbqueryfilterSlice::min(self : DbqueryfilterSlice) -> Double { @_common.min(self.data) }

pub fn DbqueryfilterSlice::max(self : DbqueryfilterSlice) -> Double { @_common.max(self.data) }

pub fn DbqueryfilterSlice::to_string(self : DbqueryfilterSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

