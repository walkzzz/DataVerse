///===
/// extcore/db_store_time

pub(all) struct DbstoretimePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_time_make_point(x : Double, y : Double) -> DbstoretimePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_time_make_point3(x : Double, y : Double, z : Double) -> DbstoretimePoint {
  { x, y, z, label: 0 }
}

pub fn DbstoretimePoint::x(self : DbstoretimePoint) -> Double { self.x }

pub fn DbstoretimePoint::y(self : DbstoretimePoint) -> Double { self.y }

pub fn DbstoretimePoint::z(self : DbstoretimePoint) -> Double { self.z }

pub fn DbstoretimePoint::label(self : DbstoretimePoint) -> Int { self.label }

pub fn DbstoretimePoint::dist(self : DbstoretimePoint, other : DbstoretimePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstoretimePoint::add(self : DbstoretimePoint, other : DbstoretimePoint) -> DbstoretimePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstoretimePoint::sub(self : DbstoretimePoint, other : DbstoretimePoint) -> DbstoretimePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstoretimePoint::scale(self : DbstoretimePoint, s : Double) -> DbstoretimePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstoretimePoint::dot(self : DbstoretimePoint, other : DbstoretimePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstoretimePoint::cross(self : DbstoretimePoint, other : DbstoretimePoint) -> DbstoretimePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstoretimePoint::norm(self : DbstoretimePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstoretimePoint::normalize(self : DbstoretimePoint) -> DbstoretimePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoretimePoint::negate(self : DbstoretimePoint) -> DbstoretimePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstoretimePoint::mid(self : DbstoretimePoint, other : DbstoretimePoint) -> DbstoretimePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstoretimePoint::lerp(self : DbstoretimePoint, other : DbstoretimePoint, t : Double) -> DbstoretimePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstoretimePoint::to_string(self : DbstoretimePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstoretimeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_time_make_series(vals : Array[Double], name : String) -> DbstoretimeSeries {
  { vals, name, meta: 0 }
}

pub fn DbstoretimeSeries::len(self : DbstoretimeSeries) -> Int { self.vals.length() }

pub fn DbstoretimeSeries::sum(self : DbstoretimeSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstoretimeSeries::mean(self : DbstoretimeSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstoretimeSeries::min(self : DbstoretimeSeries) -> Double { @_common.min(self.vals) }

pub fn DbstoretimeSeries::max(self : DbstoretimeSeries) -> Double { @_common.max(self.vals) }

pub fn DbstoretimeSeries::range(self : DbstoretimeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstoretimeSeries::variance(self : DbstoretimeSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstoretimeSeries::std(self : DbstoretimeSeries) -> Double { @_common.std(self.vals) }

pub fn DbstoretimeSeries::median(self : DbstoretimeSeries) -> Double { @_common.median(self.vals) }

pub fn DbstoretimeSeries::scale(self : DbstoretimeSeries, f : Double) -> DbstoretimeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstoretimeSeries::add(self : DbstoretimeSeries, other : DbstoretimeSeries) -> DbstoretimeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstoretimeSeries::sub(self : DbstoretimeSeries, other : DbstoretimeSeries) -> DbstoretimeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstoretimeSeries::normalize(self : DbstoretimeSeries) -> DbstoretimeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstoretimeSeries::cumsum(self : DbstoretimeSeries) -> DbstoretimeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstoretimeSeries::to_string(self : DbstoretimeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoretimeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_time_make_matrix(rows : Int, cols : Int, val : Double) -> DbstoretimeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_time_matrix_identity(n : Int) -> DbstoretimeMatrix {
  let m = db_store_time_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstoretimeMatrix::get(self : DbstoretimeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstoretimeMatrix::transpose(self : DbstoretimeMatrix) -> DbstoretimeMatrix {
  let result = db_store_time_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstoretimeMatrix::add(self : DbstoretimeMatrix, other : DbstoretimeMatrix) -> DbstoretimeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_time_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstoretimeMatrix::scale(self : DbstoretimeMatrix, s : Double) -> DbstoretimeMatrix {
  let result = db_store_time_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstoretimeMatrix::multiply(self : DbstoretimeMatrix, other : DbstoretimeMatrix) -> DbstoretimeMatrix {
  if self.cols != other.rows { return db_store_time_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_time_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstoretimeMatrix::trace(self : DbstoretimeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstoretimeMatrix::det(self : DbstoretimeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstoretimeMatrix::norm(self : DbstoretimeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstoretimeMatrix::to_string(self : DbstoretimeMatrix) -> String {
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

pub(all) struct DbstoretimeVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_time_make_vector(comps : Array[Double]) -> DbstoretimeVector {
  { comps, dim: comps.length() }
}

pub fn db_store_time_vector_zero(dim : Int) -> DbstoretimeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstoretimeVector::add(self : DbstoretimeVector, other : DbstoretimeVector) -> DbstoretimeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoretimeVector::sub(self : DbstoretimeVector, other : DbstoretimeVector) -> DbstoretimeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoretimeVector::scale(self : DbstoretimeVector, s : Double) -> DbstoretimeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstoretimeVector::dot(self : DbstoretimeVector, other : DbstoretimeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstoretimeVector::norm(self : DbstoretimeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstoretimeVector::normalize(self : DbstoretimeVector) -> DbstoretimeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoretimeVector::dist(self : DbstoretimeVector, other : DbstoretimeVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstoretimeVector::to_string(self : DbstoretimeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_time_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_time_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_time_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_time_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_time_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_time_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_time_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_time_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_time_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_time_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_time_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_time_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_time_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_time_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_time_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_time_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_time_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_time_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_time_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_time_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_time_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_time_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_time_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_time_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_time_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_time_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_time_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_time_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_time_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstoretimeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_frame_make(size : Int) -> DbstoretimeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretimeFrame::len(self : DbstoretimeFrame) -> Int { self.size }

pub fn DbstoretimeFrame::get(self : DbstoretimeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretimeFrame::set(self : DbstoretimeFrame, i : Int, v : Double) -> DbstoretimeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretimeFrame::sum(self : DbstoretimeFrame) -> Double { @_common.sum(self.data) }

pub fn DbstoretimeFrame::mean(self : DbstoretimeFrame) -> Double { @_common.mean(self.data) }

pub fn DbstoretimeFrame::scale(self : DbstoretimeFrame, f : Double) -> DbstoretimeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretimeFrame::add(self : DbstoretimeFrame, other : DbstoretimeFrame) -> DbstoretimeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretimeFrame::copy(self : DbstoretimeFrame) -> DbstoretimeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretimeFrame::fill(self : DbstoretimeFrame, v : Double) -> DbstoretimeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretimeFrame::min(self : DbstoretimeFrame) -> Double { @_common.min(self.data) }

pub fn DbstoretimeFrame::max(self : DbstoretimeFrame) -> Double { @_common.max(self.data) }

pub fn DbstoretimeFrame::to_string(self : DbstoretimeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretimeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_table_make(size : Int) -> DbstoretimeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretimeTable::len(self : DbstoretimeTable) -> Int { self.size }

pub fn DbstoretimeTable::get(self : DbstoretimeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretimeTable::set(self : DbstoretimeTable, i : Int, v : Double) -> DbstoretimeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretimeTable::sum(self : DbstoretimeTable) -> Double { @_common.sum(self.data) }

pub fn DbstoretimeTable::mean(self : DbstoretimeTable) -> Double { @_common.mean(self.data) }

pub fn DbstoretimeTable::scale(self : DbstoretimeTable, f : Double) -> DbstoretimeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretimeTable::add(self : DbstoretimeTable, other : DbstoretimeTable) -> DbstoretimeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretimeTable::copy(self : DbstoretimeTable) -> DbstoretimeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretimeTable::fill(self : DbstoretimeTable, v : Double) -> DbstoretimeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretimeTable::min(self : DbstoretimeTable) -> Double { @_common.min(self.data) }

pub fn DbstoretimeTable::max(self : DbstoretimeTable) -> Double { @_common.max(self.data) }

pub fn DbstoretimeTable::to_string(self : DbstoretimeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretimeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_graphn_make(size : Int) -> DbstoretimeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretimeGraphN::len(self : DbstoretimeGraphN) -> Int { self.size }

pub fn DbstoretimeGraphN::get(self : DbstoretimeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretimeGraphN::set(self : DbstoretimeGraphN, i : Int, v : Double) -> DbstoretimeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretimeGraphN::sum(self : DbstoretimeGraphN) -> Double { @_common.sum(self.data) }

pub fn DbstoretimeGraphN::mean(self : DbstoretimeGraphN) -> Double { @_common.mean(self.data) }

pub fn DbstoretimeGraphN::scale(self : DbstoretimeGraphN, f : Double) -> DbstoretimeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretimeGraphN::add(self : DbstoretimeGraphN, other : DbstoretimeGraphN) -> DbstoretimeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretimeGraphN::copy(self : DbstoretimeGraphN) -> DbstoretimeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretimeGraphN::fill(self : DbstoretimeGraphN, v : Double) -> DbstoretimeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretimeGraphN::min(self : DbstoretimeGraphN) -> Double { @_common.min(self.data) }

pub fn DbstoretimeGraphN::max(self : DbstoretimeGraphN) -> Double { @_common.max(self.data) }

pub fn DbstoretimeGraphN::to_string(self : DbstoretimeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretimeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_node_make(size : Int) -> DbstoretimeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretimeNode::len(self : DbstoretimeNode) -> Int { self.size }

pub fn DbstoretimeNode::get(self : DbstoretimeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretimeNode::set(self : DbstoretimeNode, i : Int, v : Double) -> DbstoretimeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretimeNode::sum(self : DbstoretimeNode) -> Double { @_common.sum(self.data) }

pub fn DbstoretimeNode::mean(self : DbstoretimeNode) -> Double { @_common.mean(self.data) }

pub fn DbstoretimeNode::scale(self : DbstoretimeNode, f : Double) -> DbstoretimeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretimeNode::add(self : DbstoretimeNode, other : DbstoretimeNode) -> DbstoretimeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretimeNode::copy(self : DbstoretimeNode) -> DbstoretimeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretimeNode::fill(self : DbstoretimeNode, v : Double) -> DbstoretimeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretimeNode::min(self : DbstoretimeNode) -> Double { @_common.min(self.data) }

pub fn DbstoretimeNode::max(self : DbstoretimeNode) -> Double { @_common.max(self.data) }

pub fn DbstoretimeNode::to_string(self : DbstoretimeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretimeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_edge_make(size : Int) -> DbstoretimeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretimeEdge::len(self : DbstoretimeEdge) -> Int { self.size }

pub fn DbstoretimeEdge::get(self : DbstoretimeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretimeEdge::set(self : DbstoretimeEdge, i : Int, v : Double) -> DbstoretimeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretimeEdge::sum(self : DbstoretimeEdge) -> Double { @_common.sum(self.data) }

pub fn DbstoretimeEdge::mean(self : DbstoretimeEdge) -> Double { @_common.mean(self.data) }

pub fn DbstoretimeEdge::scale(self : DbstoretimeEdge, f : Double) -> DbstoretimeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretimeEdge::add(self : DbstoretimeEdge, other : DbstoretimeEdge) -> DbstoretimeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretimeEdge::copy(self : DbstoretimeEdge) -> DbstoretimeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretimeEdge::fill(self : DbstoretimeEdge, v : Double) -> DbstoretimeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretimeEdge::min(self : DbstoretimeEdge) -> Double { @_common.min(self.data) }

pub fn DbstoretimeEdge::max(self : DbstoretimeEdge) -> Double { @_common.max(self.data) }

pub fn DbstoretimeEdge::to_string(self : DbstoretimeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretimePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_path_make(size : Int) -> DbstoretimePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretimePath::len(self : DbstoretimePath) -> Int { self.size }

pub fn DbstoretimePath::get(self : DbstoretimePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretimePath::set(self : DbstoretimePath, i : Int, v : Double) -> DbstoretimePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretimePath::sum(self : DbstoretimePath) -> Double { @_common.sum(self.data) }

pub fn DbstoretimePath::mean(self : DbstoretimePath) -> Double { @_common.mean(self.data) }

pub fn DbstoretimePath::scale(self : DbstoretimePath, f : Double) -> DbstoretimePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretimePath::add(self : DbstoretimePath, other : DbstoretimePath) -> DbstoretimePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretimePath::copy(self : DbstoretimePath) -> DbstoretimePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretimePath::fill(self : DbstoretimePath, v : Double) -> DbstoretimePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretimePath::min(self : DbstoretimePath) -> Double { @_common.min(self.data) }

pub fn DbstoretimePath::max(self : DbstoretimePath) -> Double { @_common.max(self.data) }

pub fn DbstoretimePath::to_string(self : DbstoretimePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretimeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_cluster_make(size : Int) -> DbstoretimeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretimeCluster::len(self : DbstoretimeCluster) -> Int { self.size }

pub fn DbstoretimeCluster::get(self : DbstoretimeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretimeCluster::set(self : DbstoretimeCluster, i : Int, v : Double) -> DbstoretimeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretimeCluster::sum(self : DbstoretimeCluster) -> Double { @_common.sum(self.data) }

pub fn DbstoretimeCluster::mean(self : DbstoretimeCluster) -> Double { @_common.mean(self.data) }

pub fn DbstoretimeCluster::scale(self : DbstoretimeCluster, f : Double) -> DbstoretimeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretimeCluster::add(self : DbstoretimeCluster, other : DbstoretimeCluster) -> DbstoretimeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretimeCluster::copy(self : DbstoretimeCluster) -> DbstoretimeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretimeCluster::fill(self : DbstoretimeCluster, v : Double) -> DbstoretimeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretimeCluster::min(self : DbstoretimeCluster) -> Double { @_common.min(self.data) }

pub fn DbstoretimeCluster::max(self : DbstoretimeCluster) -> Double { @_common.max(self.data) }

pub fn DbstoretimeCluster::to_string(self : DbstoretimeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretimeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_model_make(size : Int) -> DbstoretimeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretimeModel::len(self : DbstoretimeModel) -> Int { self.size }

pub fn DbstoretimeModel::get(self : DbstoretimeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretimeModel::set(self : DbstoretimeModel, i : Int, v : Double) -> DbstoretimeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretimeModel::sum(self : DbstoretimeModel) -> Double { @_common.sum(self.data) }

pub fn DbstoretimeModel::mean(self : DbstoretimeModel) -> Double { @_common.mean(self.data) }

pub fn DbstoretimeModel::scale(self : DbstoretimeModel, f : Double) -> DbstoretimeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretimeModel::add(self : DbstoretimeModel, other : DbstoretimeModel) -> DbstoretimeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretimeModel::copy(self : DbstoretimeModel) -> DbstoretimeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretimeModel::fill(self : DbstoretimeModel, v : Double) -> DbstoretimeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretimeModel::min(self : DbstoretimeModel) -> Double { @_common.min(self.data) }

pub fn DbstoretimeModel::max(self : DbstoretimeModel) -> Double { @_common.max(self.data) }

pub fn DbstoretimeModel::to_string(self : DbstoretimeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretimeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_layer_make(size : Int) -> DbstoretimeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretimeLayer::len(self : DbstoretimeLayer) -> Int { self.size }

pub fn DbstoretimeLayer::get(self : DbstoretimeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretimeLayer::set(self : DbstoretimeLayer, i : Int, v : Double) -> DbstoretimeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretimeLayer::sum(self : DbstoretimeLayer) -> Double { @_common.sum(self.data) }

pub fn DbstoretimeLayer::mean(self : DbstoretimeLayer) -> Double { @_common.mean(self.data) }

pub fn DbstoretimeLayer::scale(self : DbstoretimeLayer, f : Double) -> DbstoretimeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretimeLayer::add(self : DbstoretimeLayer, other : DbstoretimeLayer) -> DbstoretimeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretimeLayer::copy(self : DbstoretimeLayer) -> DbstoretimeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretimeLayer::fill(self : DbstoretimeLayer, v : Double) -> DbstoretimeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretimeLayer::min(self : DbstoretimeLayer) -> Double { @_common.min(self.data) }

pub fn DbstoretimeLayer::max(self : DbstoretimeLayer) -> Double { @_common.max(self.data) }

pub fn DbstoretimeLayer::to_string(self : DbstoretimeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretimeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_buffer_make(size : Int) -> DbstoretimeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretimeBuffer::len(self : DbstoretimeBuffer) -> Int { self.size }

pub fn DbstoretimeBuffer::get(self : DbstoretimeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretimeBuffer::set(self : DbstoretimeBuffer, i : Int, v : Double) -> DbstoretimeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretimeBuffer::sum(self : DbstoretimeBuffer) -> Double { @_common.sum(self.data) }

pub fn DbstoretimeBuffer::mean(self : DbstoretimeBuffer) -> Double { @_common.mean(self.data) }

pub fn DbstoretimeBuffer::scale(self : DbstoretimeBuffer, f : Double) -> DbstoretimeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretimeBuffer::add(self : DbstoretimeBuffer, other : DbstoretimeBuffer) -> DbstoretimeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretimeBuffer::copy(self : DbstoretimeBuffer) -> DbstoretimeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretimeBuffer::fill(self : DbstoretimeBuffer, v : Double) -> DbstoretimeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretimeBuffer::min(self : DbstoretimeBuffer) -> Double { @_common.min(self.data) }

pub fn DbstoretimeBuffer::max(self : DbstoretimeBuffer) -> Double { @_common.max(self.data) }

pub fn DbstoretimeBuffer::to_string(self : DbstoretimeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretimeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_cursor_make(size : Int) -> DbstoretimeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretimeCursor::len(self : DbstoretimeCursor) -> Int { self.size }

pub fn DbstoretimeCursor::get(self : DbstoretimeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretimeCursor::set(self : DbstoretimeCursor, i : Int, v : Double) -> DbstoretimeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretimeCursor::sum(self : DbstoretimeCursor) -> Double { @_common.sum(self.data) }

pub fn DbstoretimeCursor::mean(self : DbstoretimeCursor) -> Double { @_common.mean(self.data) }

pub fn DbstoretimeCursor::scale(self : DbstoretimeCursor, f : Double) -> DbstoretimeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretimeCursor::add(self : DbstoretimeCursor, other : DbstoretimeCursor) -> DbstoretimeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretimeCursor::copy(self : DbstoretimeCursor) -> DbstoretimeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretimeCursor::fill(self : DbstoretimeCursor, v : Double) -> DbstoretimeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretimeCursor::min(self : DbstoretimeCursor) -> Double { @_common.min(self.data) }

pub fn DbstoretimeCursor::max(self : DbstoretimeCursor) -> Double { @_common.max(self.data) }

pub fn DbstoretimeCursor::to_string(self : DbstoretimeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretimeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_view_make(size : Int) -> DbstoretimeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretimeView::len(self : DbstoretimeView) -> Int { self.size }

pub fn DbstoretimeView::get(self : DbstoretimeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretimeView::set(self : DbstoretimeView, i : Int, v : Double) -> DbstoretimeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretimeView::sum(self : DbstoretimeView) -> Double { @_common.sum(self.data) }

pub fn DbstoretimeView::mean(self : DbstoretimeView) -> Double { @_common.mean(self.data) }

pub fn DbstoretimeView::scale(self : DbstoretimeView, f : Double) -> DbstoretimeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretimeView::add(self : DbstoretimeView, other : DbstoretimeView) -> DbstoretimeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretimeView::copy(self : DbstoretimeView) -> DbstoretimeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretimeView::fill(self : DbstoretimeView, v : Double) -> DbstoretimeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretimeView::min(self : DbstoretimeView) -> Double { @_common.min(self.data) }

pub fn DbstoretimeView::max(self : DbstoretimeView) -> Double { @_common.max(self.data) }

pub fn DbstoretimeView::to_string(self : DbstoretimeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretimeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_range_make(size : Int) -> DbstoretimeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretimeRange::len(self : DbstoretimeRange) -> Int { self.size }

pub fn DbstoretimeRange::get(self : DbstoretimeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretimeRange::set(self : DbstoretimeRange, i : Int, v : Double) -> DbstoretimeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretimeRange::sum(self : DbstoretimeRange) -> Double { @_common.sum(self.data) }

pub fn DbstoretimeRange::mean(self : DbstoretimeRange) -> Double { @_common.mean(self.data) }

pub fn DbstoretimeRange::scale(self : DbstoretimeRange, f : Double) -> DbstoretimeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretimeRange::add(self : DbstoretimeRange, other : DbstoretimeRange) -> DbstoretimeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretimeRange::copy(self : DbstoretimeRange) -> DbstoretimeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretimeRange::fill(self : DbstoretimeRange, v : Double) -> DbstoretimeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretimeRange::min(self : DbstoretimeRange) -> Double { @_common.min(self.data) }

pub fn DbstoretimeRange::max(self : DbstoretimeRange) -> Double { @_common.max(self.data) }

pub fn DbstoretimeRange::to_string(self : DbstoretimeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstoretimeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_slice_make(size : Int) -> DbstoretimeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstoretimeSlice::len(self : DbstoretimeSlice) -> Int { self.size }

pub fn DbstoretimeSlice::get(self : DbstoretimeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstoretimeSlice::set(self : DbstoretimeSlice, i : Int, v : Double) -> DbstoretimeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstoretimeSlice::sum(self : DbstoretimeSlice) -> Double { @_common.sum(self.data) }

pub fn DbstoretimeSlice::mean(self : DbstoretimeSlice) -> Double { @_common.mean(self.data) }

pub fn DbstoretimeSlice::scale(self : DbstoretimeSlice, f : Double) -> DbstoretimeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstoretimeSlice::add(self : DbstoretimeSlice, other : DbstoretimeSlice) -> DbstoretimeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstoretimeSlice::copy(self : DbstoretimeSlice) -> DbstoretimeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstoretimeSlice::fill(self : DbstoretimeSlice, v : Double) -> DbstoretimeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstoretimeSlice::min(self : DbstoretimeSlice) -> Double { @_common.min(self.data) }

pub fn DbstoretimeSlice::max(self : DbstoretimeSlice) -> Double { @_common.max(self.data) }

pub fn DbstoretimeSlice::to_string(self : DbstoretimeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

