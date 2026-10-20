///===
/// extcore/db_store_kv

pub(all) struct DbstorekvPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_kv_make_point(x : Double, y : Double) -> DbstorekvPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_kv_make_point3(x : Double, y : Double, z : Double) -> DbstorekvPoint {
  { x, y, z, label: 0 }
}

pub fn DbstorekvPoint::x(self : DbstorekvPoint) -> Double { self.x }

pub fn DbstorekvPoint::y(self : DbstorekvPoint) -> Double { self.y }

pub fn DbstorekvPoint::z(self : DbstorekvPoint) -> Double { self.z }

pub fn DbstorekvPoint::label(self : DbstorekvPoint) -> Int { self.label }

pub fn DbstorekvPoint::dist(self : DbstorekvPoint, other : DbstorekvPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstorekvPoint::add(self : DbstorekvPoint, other : DbstorekvPoint) -> DbstorekvPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstorekvPoint::sub(self : DbstorekvPoint, other : DbstorekvPoint) -> DbstorekvPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstorekvPoint::scale(self : DbstorekvPoint, s : Double) -> DbstorekvPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstorekvPoint::dot(self : DbstorekvPoint, other : DbstorekvPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstorekvPoint::cross(self : DbstorekvPoint, other : DbstorekvPoint) -> DbstorekvPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstorekvPoint::norm(self : DbstorekvPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstorekvPoint::normalize(self : DbstorekvPoint) -> DbstorekvPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorekvPoint::negate(self : DbstorekvPoint) -> DbstorekvPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstorekvPoint::mid(self : DbstorekvPoint, other : DbstorekvPoint) -> DbstorekvPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstorekvPoint::lerp(self : DbstorekvPoint, other : DbstorekvPoint, t : Double) -> DbstorekvPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstorekvPoint::to_string(self : DbstorekvPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstorekvSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_kv_make_series(vals : Array[Double], name : String) -> DbstorekvSeries {
  { vals, name, meta: 0 }
}

pub fn DbstorekvSeries::len(self : DbstorekvSeries) -> Int { self.vals.length() }

pub fn DbstorekvSeries::sum(self : DbstorekvSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstorekvSeries::mean(self : DbstorekvSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstorekvSeries::min(self : DbstorekvSeries) -> Double { @_common.min(self.vals) }

pub fn DbstorekvSeries::max(self : DbstorekvSeries) -> Double { @_common.max(self.vals) }

pub fn DbstorekvSeries::range(self : DbstorekvSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstorekvSeries::variance(self : DbstorekvSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstorekvSeries::std(self : DbstorekvSeries) -> Double { @_common.std(self.vals) }

pub fn DbstorekvSeries::median(self : DbstorekvSeries) -> Double { @_common.median(self.vals) }

pub fn DbstorekvSeries::scale(self : DbstorekvSeries, f : Double) -> DbstorekvSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstorekvSeries::add(self : DbstorekvSeries, other : DbstorekvSeries) -> DbstorekvSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstorekvSeries::sub(self : DbstorekvSeries, other : DbstorekvSeries) -> DbstorekvSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstorekvSeries::normalize(self : DbstorekvSeries) -> DbstorekvSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstorekvSeries::cumsum(self : DbstorekvSeries) -> DbstorekvSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstorekvSeries::to_string(self : DbstorekvSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorekvMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_kv_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorekvMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_kv_matrix_identity(n : Int) -> DbstorekvMatrix {
  let m = db_store_kv_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstorekvMatrix::get(self : DbstorekvMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstorekvMatrix::transpose(self : DbstorekvMatrix) -> DbstorekvMatrix {
  let result = db_store_kv_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstorekvMatrix::add(self : DbstorekvMatrix, other : DbstorekvMatrix) -> DbstorekvMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_kv_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstorekvMatrix::scale(self : DbstorekvMatrix, s : Double) -> DbstorekvMatrix {
  let result = db_store_kv_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstorekvMatrix::multiply(self : DbstorekvMatrix, other : DbstorekvMatrix) -> DbstorekvMatrix {
  if self.cols != other.rows { return db_store_kv_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_kv_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstorekvMatrix::trace(self : DbstorekvMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstorekvMatrix::det(self : DbstorekvMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstorekvMatrix::norm(self : DbstorekvMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstorekvMatrix::to_string(self : DbstorekvMatrix) -> String {
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

pub(all) struct DbstorekvVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_kv_make_vector(comps : Array[Double]) -> DbstorekvVector {
  { comps, dim: comps.length() }
}

pub fn db_store_kv_vector_zero(dim : Int) -> DbstorekvVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstorekvVector::add(self : DbstorekvVector, other : DbstorekvVector) -> DbstorekvVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorekvVector::sub(self : DbstorekvVector, other : DbstorekvVector) -> DbstorekvVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorekvVector::scale(self : DbstorekvVector, s : Double) -> DbstorekvVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstorekvVector::dot(self : DbstorekvVector, other : DbstorekvVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstorekvVector::norm(self : DbstorekvVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstorekvVector::normalize(self : DbstorekvVector) -> DbstorekvVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorekvVector::dist(self : DbstorekvVector, other : DbstorekvVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstorekvVector::to_string(self : DbstorekvVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_kv_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_kv_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_kv_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_kv_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_kv_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_kv_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_kv_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_kv_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_kv_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_kv_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_kv_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_kv_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_kv_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_kv_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_kv_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_kv_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_kv_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_kv_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_kv_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_kv_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_kv_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_kv_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_kv_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_kv_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_kv_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_kv_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_kv_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_kv_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_kv_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstorekvFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_frame_make(size : Int) -> DbstorekvFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorekvFrame::len(self : DbstorekvFrame) -> Int { self.size }

pub fn DbstorekvFrame::get(self : DbstorekvFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorekvFrame::set(self : DbstorekvFrame, i : Int, v : Double) -> DbstorekvFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorekvFrame::sum(self : DbstorekvFrame) -> Double { @_common.sum(self.data) }

pub fn DbstorekvFrame::mean(self : DbstorekvFrame) -> Double { @_common.mean(self.data) }

pub fn DbstorekvFrame::scale(self : DbstorekvFrame, f : Double) -> DbstorekvFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorekvFrame::add(self : DbstorekvFrame, other : DbstorekvFrame) -> DbstorekvFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorekvFrame::copy(self : DbstorekvFrame) -> DbstorekvFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorekvFrame::fill(self : DbstorekvFrame, v : Double) -> DbstorekvFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorekvFrame::min(self : DbstorekvFrame) -> Double { @_common.min(self.data) }

pub fn DbstorekvFrame::max(self : DbstorekvFrame) -> Double { @_common.max(self.data) }

pub fn DbstorekvFrame::to_string(self : DbstorekvFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorekvTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_table_make(size : Int) -> DbstorekvTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorekvTable::len(self : DbstorekvTable) -> Int { self.size }

pub fn DbstorekvTable::get(self : DbstorekvTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorekvTable::set(self : DbstorekvTable, i : Int, v : Double) -> DbstorekvTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorekvTable::sum(self : DbstorekvTable) -> Double { @_common.sum(self.data) }

pub fn DbstorekvTable::mean(self : DbstorekvTable) -> Double { @_common.mean(self.data) }

pub fn DbstorekvTable::scale(self : DbstorekvTable, f : Double) -> DbstorekvTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorekvTable::add(self : DbstorekvTable, other : DbstorekvTable) -> DbstorekvTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorekvTable::copy(self : DbstorekvTable) -> DbstorekvTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorekvTable::fill(self : DbstorekvTable, v : Double) -> DbstorekvTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorekvTable::min(self : DbstorekvTable) -> Double { @_common.min(self.data) }

pub fn DbstorekvTable::max(self : DbstorekvTable) -> Double { @_common.max(self.data) }

pub fn DbstorekvTable::to_string(self : DbstorekvTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorekvGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_graphn_make(size : Int) -> DbstorekvGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorekvGraphN::len(self : DbstorekvGraphN) -> Int { self.size }

pub fn DbstorekvGraphN::get(self : DbstorekvGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorekvGraphN::set(self : DbstorekvGraphN, i : Int, v : Double) -> DbstorekvGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorekvGraphN::sum(self : DbstorekvGraphN) -> Double { @_common.sum(self.data) }

pub fn DbstorekvGraphN::mean(self : DbstorekvGraphN) -> Double { @_common.mean(self.data) }

pub fn DbstorekvGraphN::scale(self : DbstorekvGraphN, f : Double) -> DbstorekvGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorekvGraphN::add(self : DbstorekvGraphN, other : DbstorekvGraphN) -> DbstorekvGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorekvGraphN::copy(self : DbstorekvGraphN) -> DbstorekvGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorekvGraphN::fill(self : DbstorekvGraphN, v : Double) -> DbstorekvGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorekvGraphN::min(self : DbstorekvGraphN) -> Double { @_common.min(self.data) }

pub fn DbstorekvGraphN::max(self : DbstorekvGraphN) -> Double { @_common.max(self.data) }

pub fn DbstorekvGraphN::to_string(self : DbstorekvGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorekvNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_node_make(size : Int) -> DbstorekvNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorekvNode::len(self : DbstorekvNode) -> Int { self.size }

pub fn DbstorekvNode::get(self : DbstorekvNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorekvNode::set(self : DbstorekvNode, i : Int, v : Double) -> DbstorekvNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorekvNode::sum(self : DbstorekvNode) -> Double { @_common.sum(self.data) }

pub fn DbstorekvNode::mean(self : DbstorekvNode) -> Double { @_common.mean(self.data) }

pub fn DbstorekvNode::scale(self : DbstorekvNode, f : Double) -> DbstorekvNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorekvNode::add(self : DbstorekvNode, other : DbstorekvNode) -> DbstorekvNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorekvNode::copy(self : DbstorekvNode) -> DbstorekvNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorekvNode::fill(self : DbstorekvNode, v : Double) -> DbstorekvNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorekvNode::min(self : DbstorekvNode) -> Double { @_common.min(self.data) }

pub fn DbstorekvNode::max(self : DbstorekvNode) -> Double { @_common.max(self.data) }

pub fn DbstorekvNode::to_string(self : DbstorekvNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorekvEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_edge_make(size : Int) -> DbstorekvEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorekvEdge::len(self : DbstorekvEdge) -> Int { self.size }

pub fn DbstorekvEdge::get(self : DbstorekvEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorekvEdge::set(self : DbstorekvEdge, i : Int, v : Double) -> DbstorekvEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorekvEdge::sum(self : DbstorekvEdge) -> Double { @_common.sum(self.data) }

pub fn DbstorekvEdge::mean(self : DbstorekvEdge) -> Double { @_common.mean(self.data) }

pub fn DbstorekvEdge::scale(self : DbstorekvEdge, f : Double) -> DbstorekvEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorekvEdge::add(self : DbstorekvEdge, other : DbstorekvEdge) -> DbstorekvEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorekvEdge::copy(self : DbstorekvEdge) -> DbstorekvEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorekvEdge::fill(self : DbstorekvEdge, v : Double) -> DbstorekvEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorekvEdge::min(self : DbstorekvEdge) -> Double { @_common.min(self.data) }

pub fn DbstorekvEdge::max(self : DbstorekvEdge) -> Double { @_common.max(self.data) }

pub fn DbstorekvEdge::to_string(self : DbstorekvEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorekvPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_path_make(size : Int) -> DbstorekvPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorekvPath::len(self : DbstorekvPath) -> Int { self.size }

pub fn DbstorekvPath::get(self : DbstorekvPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorekvPath::set(self : DbstorekvPath, i : Int, v : Double) -> DbstorekvPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorekvPath::sum(self : DbstorekvPath) -> Double { @_common.sum(self.data) }

pub fn DbstorekvPath::mean(self : DbstorekvPath) -> Double { @_common.mean(self.data) }

pub fn DbstorekvPath::scale(self : DbstorekvPath, f : Double) -> DbstorekvPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorekvPath::add(self : DbstorekvPath, other : DbstorekvPath) -> DbstorekvPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorekvPath::copy(self : DbstorekvPath) -> DbstorekvPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorekvPath::fill(self : DbstorekvPath, v : Double) -> DbstorekvPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorekvPath::min(self : DbstorekvPath) -> Double { @_common.min(self.data) }

pub fn DbstorekvPath::max(self : DbstorekvPath) -> Double { @_common.max(self.data) }

pub fn DbstorekvPath::to_string(self : DbstorekvPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorekvCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_cluster_make(size : Int) -> DbstorekvCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorekvCluster::len(self : DbstorekvCluster) -> Int { self.size }

pub fn DbstorekvCluster::get(self : DbstorekvCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorekvCluster::set(self : DbstorekvCluster, i : Int, v : Double) -> DbstorekvCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorekvCluster::sum(self : DbstorekvCluster) -> Double { @_common.sum(self.data) }

pub fn DbstorekvCluster::mean(self : DbstorekvCluster) -> Double { @_common.mean(self.data) }

pub fn DbstorekvCluster::scale(self : DbstorekvCluster, f : Double) -> DbstorekvCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorekvCluster::add(self : DbstorekvCluster, other : DbstorekvCluster) -> DbstorekvCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorekvCluster::copy(self : DbstorekvCluster) -> DbstorekvCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorekvCluster::fill(self : DbstorekvCluster, v : Double) -> DbstorekvCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorekvCluster::min(self : DbstorekvCluster) -> Double { @_common.min(self.data) }

pub fn DbstorekvCluster::max(self : DbstorekvCluster) -> Double { @_common.max(self.data) }

pub fn DbstorekvCluster::to_string(self : DbstorekvCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorekvModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_model_make(size : Int) -> DbstorekvModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorekvModel::len(self : DbstorekvModel) -> Int { self.size }

pub fn DbstorekvModel::get(self : DbstorekvModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorekvModel::set(self : DbstorekvModel, i : Int, v : Double) -> DbstorekvModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorekvModel::sum(self : DbstorekvModel) -> Double { @_common.sum(self.data) }

pub fn DbstorekvModel::mean(self : DbstorekvModel) -> Double { @_common.mean(self.data) }

pub fn DbstorekvModel::scale(self : DbstorekvModel, f : Double) -> DbstorekvModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorekvModel::add(self : DbstorekvModel, other : DbstorekvModel) -> DbstorekvModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorekvModel::copy(self : DbstorekvModel) -> DbstorekvModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorekvModel::fill(self : DbstorekvModel, v : Double) -> DbstorekvModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorekvModel::min(self : DbstorekvModel) -> Double { @_common.min(self.data) }

pub fn DbstorekvModel::max(self : DbstorekvModel) -> Double { @_common.max(self.data) }

pub fn DbstorekvModel::to_string(self : DbstorekvModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorekvLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_layer_make(size : Int) -> DbstorekvLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorekvLayer::len(self : DbstorekvLayer) -> Int { self.size }

pub fn DbstorekvLayer::get(self : DbstorekvLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorekvLayer::set(self : DbstorekvLayer, i : Int, v : Double) -> DbstorekvLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorekvLayer::sum(self : DbstorekvLayer) -> Double { @_common.sum(self.data) }

pub fn DbstorekvLayer::mean(self : DbstorekvLayer) -> Double { @_common.mean(self.data) }

pub fn DbstorekvLayer::scale(self : DbstorekvLayer, f : Double) -> DbstorekvLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorekvLayer::add(self : DbstorekvLayer, other : DbstorekvLayer) -> DbstorekvLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorekvLayer::copy(self : DbstorekvLayer) -> DbstorekvLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorekvLayer::fill(self : DbstorekvLayer, v : Double) -> DbstorekvLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorekvLayer::min(self : DbstorekvLayer) -> Double { @_common.min(self.data) }

pub fn DbstorekvLayer::max(self : DbstorekvLayer) -> Double { @_common.max(self.data) }

pub fn DbstorekvLayer::to_string(self : DbstorekvLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorekvBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_buffer_make(size : Int) -> DbstorekvBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorekvBuffer::len(self : DbstorekvBuffer) -> Int { self.size }

pub fn DbstorekvBuffer::get(self : DbstorekvBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorekvBuffer::set(self : DbstorekvBuffer, i : Int, v : Double) -> DbstorekvBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorekvBuffer::sum(self : DbstorekvBuffer) -> Double { @_common.sum(self.data) }

pub fn DbstorekvBuffer::mean(self : DbstorekvBuffer) -> Double { @_common.mean(self.data) }

pub fn DbstorekvBuffer::scale(self : DbstorekvBuffer, f : Double) -> DbstorekvBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorekvBuffer::add(self : DbstorekvBuffer, other : DbstorekvBuffer) -> DbstorekvBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorekvBuffer::copy(self : DbstorekvBuffer) -> DbstorekvBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorekvBuffer::fill(self : DbstorekvBuffer, v : Double) -> DbstorekvBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorekvBuffer::min(self : DbstorekvBuffer) -> Double { @_common.min(self.data) }

pub fn DbstorekvBuffer::max(self : DbstorekvBuffer) -> Double { @_common.max(self.data) }

pub fn DbstorekvBuffer::to_string(self : DbstorekvBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorekvCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_cursor_make(size : Int) -> DbstorekvCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorekvCursor::len(self : DbstorekvCursor) -> Int { self.size }

pub fn DbstorekvCursor::get(self : DbstorekvCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorekvCursor::set(self : DbstorekvCursor, i : Int, v : Double) -> DbstorekvCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorekvCursor::sum(self : DbstorekvCursor) -> Double { @_common.sum(self.data) }

pub fn DbstorekvCursor::mean(self : DbstorekvCursor) -> Double { @_common.mean(self.data) }

pub fn DbstorekvCursor::scale(self : DbstorekvCursor, f : Double) -> DbstorekvCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorekvCursor::add(self : DbstorekvCursor, other : DbstorekvCursor) -> DbstorekvCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorekvCursor::copy(self : DbstorekvCursor) -> DbstorekvCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorekvCursor::fill(self : DbstorekvCursor, v : Double) -> DbstorekvCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorekvCursor::min(self : DbstorekvCursor) -> Double { @_common.min(self.data) }

pub fn DbstorekvCursor::max(self : DbstorekvCursor) -> Double { @_common.max(self.data) }

pub fn DbstorekvCursor::to_string(self : DbstorekvCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorekvView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_view_make(size : Int) -> DbstorekvView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorekvView::len(self : DbstorekvView) -> Int { self.size }

pub fn DbstorekvView::get(self : DbstorekvView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorekvView::set(self : DbstorekvView, i : Int, v : Double) -> DbstorekvView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorekvView::sum(self : DbstorekvView) -> Double { @_common.sum(self.data) }

pub fn DbstorekvView::mean(self : DbstorekvView) -> Double { @_common.mean(self.data) }

pub fn DbstorekvView::scale(self : DbstorekvView, f : Double) -> DbstorekvView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorekvView::add(self : DbstorekvView, other : DbstorekvView) -> DbstorekvView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorekvView::copy(self : DbstorekvView) -> DbstorekvView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorekvView::fill(self : DbstorekvView, v : Double) -> DbstorekvView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorekvView::min(self : DbstorekvView) -> Double { @_common.min(self.data) }

pub fn DbstorekvView::max(self : DbstorekvView) -> Double { @_common.max(self.data) }

pub fn DbstorekvView::to_string(self : DbstorekvView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorekvRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_range_make(size : Int) -> DbstorekvRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorekvRange::len(self : DbstorekvRange) -> Int { self.size }

pub fn DbstorekvRange::get(self : DbstorekvRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorekvRange::set(self : DbstorekvRange, i : Int, v : Double) -> DbstorekvRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorekvRange::sum(self : DbstorekvRange) -> Double { @_common.sum(self.data) }

pub fn DbstorekvRange::mean(self : DbstorekvRange) -> Double { @_common.mean(self.data) }

pub fn DbstorekvRange::scale(self : DbstorekvRange, f : Double) -> DbstorekvRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorekvRange::add(self : DbstorekvRange, other : DbstorekvRange) -> DbstorekvRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorekvRange::copy(self : DbstorekvRange) -> DbstorekvRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorekvRange::fill(self : DbstorekvRange, v : Double) -> DbstorekvRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorekvRange::min(self : DbstorekvRange) -> Double { @_common.min(self.data) }

pub fn DbstorekvRange::max(self : DbstorekvRange) -> Double { @_common.max(self.data) }

pub fn DbstorekvRange::to_string(self : DbstorekvRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorekvSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_slice_make(size : Int) -> DbstorekvSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorekvSlice::len(self : DbstorekvSlice) -> Int { self.size }

pub fn DbstorekvSlice::get(self : DbstorekvSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorekvSlice::set(self : DbstorekvSlice, i : Int, v : Double) -> DbstorekvSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorekvSlice::sum(self : DbstorekvSlice) -> Double { @_common.sum(self.data) }

pub fn DbstorekvSlice::mean(self : DbstorekvSlice) -> Double { @_common.mean(self.data) }

pub fn DbstorekvSlice::scale(self : DbstorekvSlice, f : Double) -> DbstorekvSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorekvSlice::add(self : DbstorekvSlice, other : DbstorekvSlice) -> DbstorekvSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorekvSlice::copy(self : DbstorekvSlice) -> DbstorekvSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorekvSlice::fill(self : DbstorekvSlice, v : Double) -> DbstorekvSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorekvSlice::min(self : DbstorekvSlice) -> Double { @_common.min(self.data) }

pub fn DbstorekvSlice::max(self : DbstorekvSlice) -> Double { @_common.max(self.data) }

pub fn DbstorekvSlice::to_string(self : DbstorekvSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

