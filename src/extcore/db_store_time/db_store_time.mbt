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

pub fn db_store_time_frame_len(s : DbstoretimeFrame) -> Int { s.size }

pub fn db_store_time_frame_get(s : DbstoretimeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_frame_set(s : DbstoretimeFrame, i : Int, v : Double) -> DbstoretimeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_time_frame_sum(s : DbstoretimeFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_time_frame_mean(s : DbstoretimeFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_time_frame_scale(s : DbstoretimeFrame, f : Double) -> DbstoretimeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_time_frame_add(a : DbstoretimeFrame, b : DbstoretimeFrame) -> DbstoretimeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_time_frame_copy(s : DbstoretimeFrame) -> DbstoretimeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_time_frame_fill(s : DbstoretimeFrame, v : Double) -> DbstoretimeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_time_frame_min(s : DbstoretimeFrame) -> Double { @_common.min(s.data) }

pub fn db_store_time_frame_max(s : DbstoretimeFrame) -> Double { @_common.max(s.data) }

pub fn db_store_time_frame_to_string(s : DbstoretimeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_table_make(size : Int) -> DbstoretimeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_table_len(s : DbstoretimeTable) -> Int { s.size }

pub fn db_store_time_table_get(s : DbstoretimeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_table_set(s : DbstoretimeTable, i : Int, v : Double) -> DbstoretimeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_time_table_sum(s : DbstoretimeTable) -> Double { @_common.sum(s.data) }

pub fn db_store_time_table_mean(s : DbstoretimeTable) -> Double { @_common.mean(s.data) }

pub fn db_store_time_table_scale(s : DbstoretimeTable, f : Double) -> DbstoretimeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_time_table_add(a : DbstoretimeTable, b : DbstoretimeTable) -> DbstoretimeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_time_table_copy(s : DbstoretimeTable) -> DbstoretimeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_time_table_fill(s : DbstoretimeTable, v : Double) -> DbstoretimeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_time_table_min(s : DbstoretimeTable) -> Double { @_common.min(s.data) }

pub fn db_store_time_table_max(s : DbstoretimeTable) -> Double { @_common.max(s.data) }

pub fn db_store_time_table_to_string(s : DbstoretimeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_graphn_make(size : Int) -> DbstoretimeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_graphn_len(s : DbstoretimeGraphN) -> Int { s.size }

pub fn db_store_time_graphn_get(s : DbstoretimeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_graphn_set(s : DbstoretimeGraphN, i : Int, v : Double) -> DbstoretimeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_time_graphn_sum(s : DbstoretimeGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_time_graphn_mean(s : DbstoretimeGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_time_graphn_scale(s : DbstoretimeGraphN, f : Double) -> DbstoretimeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_time_graphn_add(a : DbstoretimeGraphN, b : DbstoretimeGraphN) -> DbstoretimeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_time_graphn_copy(s : DbstoretimeGraphN) -> DbstoretimeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_time_graphn_fill(s : DbstoretimeGraphN, v : Double) -> DbstoretimeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_time_graphn_min(s : DbstoretimeGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_time_graphn_max(s : DbstoretimeGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_time_graphn_to_string(s : DbstoretimeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_node_make(size : Int) -> DbstoretimeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_node_len(s : DbstoretimeNode) -> Int { s.size }

pub fn db_store_time_node_get(s : DbstoretimeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_node_set(s : DbstoretimeNode, i : Int, v : Double) -> DbstoretimeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_time_node_sum(s : DbstoretimeNode) -> Double { @_common.sum(s.data) }

pub fn db_store_time_node_mean(s : DbstoretimeNode) -> Double { @_common.mean(s.data) }

pub fn db_store_time_node_scale(s : DbstoretimeNode, f : Double) -> DbstoretimeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_time_node_add(a : DbstoretimeNode, b : DbstoretimeNode) -> DbstoretimeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_time_node_copy(s : DbstoretimeNode) -> DbstoretimeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_time_node_fill(s : DbstoretimeNode, v : Double) -> DbstoretimeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_time_node_min(s : DbstoretimeNode) -> Double { @_common.min(s.data) }

pub fn db_store_time_node_max(s : DbstoretimeNode) -> Double { @_common.max(s.data) }

pub fn db_store_time_node_to_string(s : DbstoretimeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_edge_make(size : Int) -> DbstoretimeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_edge_len(s : DbstoretimeEdge) -> Int { s.size }

pub fn db_store_time_edge_get(s : DbstoretimeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_edge_set(s : DbstoretimeEdge, i : Int, v : Double) -> DbstoretimeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_time_edge_sum(s : DbstoretimeEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_time_edge_mean(s : DbstoretimeEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_time_edge_scale(s : DbstoretimeEdge, f : Double) -> DbstoretimeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_time_edge_add(a : DbstoretimeEdge, b : DbstoretimeEdge) -> DbstoretimeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_time_edge_copy(s : DbstoretimeEdge) -> DbstoretimeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_time_edge_fill(s : DbstoretimeEdge, v : Double) -> DbstoretimeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_time_edge_min(s : DbstoretimeEdge) -> Double { @_common.min(s.data) }

pub fn db_store_time_edge_max(s : DbstoretimeEdge) -> Double { @_common.max(s.data) }

pub fn db_store_time_edge_to_string(s : DbstoretimeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_path_make(size : Int) -> DbstoretimePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_path_len(s : DbstoretimePath) -> Int { s.size }

pub fn db_store_time_path_get(s : DbstoretimePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_path_set(s : DbstoretimePath, i : Int, v : Double) -> DbstoretimePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_time_path_sum(s : DbstoretimePath) -> Double { @_common.sum(s.data) }

pub fn db_store_time_path_mean(s : DbstoretimePath) -> Double { @_common.mean(s.data) }

pub fn db_store_time_path_scale(s : DbstoretimePath, f : Double) -> DbstoretimePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_time_path_add(a : DbstoretimePath, b : DbstoretimePath) -> DbstoretimePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_time_path_copy(s : DbstoretimePath) -> DbstoretimePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_time_path_fill(s : DbstoretimePath, v : Double) -> DbstoretimePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_time_path_min(s : DbstoretimePath) -> Double { @_common.min(s.data) }

pub fn db_store_time_path_max(s : DbstoretimePath) -> Double { @_common.max(s.data) }

pub fn db_store_time_path_to_string(s : DbstoretimePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_cluster_make(size : Int) -> DbstoretimeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_cluster_len(s : DbstoretimeCluster) -> Int { s.size }

pub fn db_store_time_cluster_get(s : DbstoretimeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_cluster_set(s : DbstoretimeCluster, i : Int, v : Double) -> DbstoretimeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_time_cluster_sum(s : DbstoretimeCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_time_cluster_mean(s : DbstoretimeCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_time_cluster_scale(s : DbstoretimeCluster, f : Double) -> DbstoretimeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_time_cluster_add(a : DbstoretimeCluster, b : DbstoretimeCluster) -> DbstoretimeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_time_cluster_copy(s : DbstoretimeCluster) -> DbstoretimeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_time_cluster_fill(s : DbstoretimeCluster, v : Double) -> DbstoretimeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_time_cluster_min(s : DbstoretimeCluster) -> Double { @_common.min(s.data) }

pub fn db_store_time_cluster_max(s : DbstoretimeCluster) -> Double { @_common.max(s.data) }

pub fn db_store_time_cluster_to_string(s : DbstoretimeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_model_make(size : Int) -> DbstoretimeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_model_len(s : DbstoretimeModel) -> Int { s.size }

pub fn db_store_time_model_get(s : DbstoretimeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_model_set(s : DbstoretimeModel, i : Int, v : Double) -> DbstoretimeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_time_model_sum(s : DbstoretimeModel) -> Double { @_common.sum(s.data) }

pub fn db_store_time_model_mean(s : DbstoretimeModel) -> Double { @_common.mean(s.data) }

pub fn db_store_time_model_scale(s : DbstoretimeModel, f : Double) -> DbstoretimeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_time_model_add(a : DbstoretimeModel, b : DbstoretimeModel) -> DbstoretimeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_time_model_copy(s : DbstoretimeModel) -> DbstoretimeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_time_model_fill(s : DbstoretimeModel, v : Double) -> DbstoretimeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_time_model_min(s : DbstoretimeModel) -> Double { @_common.min(s.data) }

pub fn db_store_time_model_max(s : DbstoretimeModel) -> Double { @_common.max(s.data) }

pub fn db_store_time_model_to_string(s : DbstoretimeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_layer_make(size : Int) -> DbstoretimeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_layer_len(s : DbstoretimeLayer) -> Int { s.size }

pub fn db_store_time_layer_get(s : DbstoretimeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_layer_set(s : DbstoretimeLayer, i : Int, v : Double) -> DbstoretimeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_time_layer_sum(s : DbstoretimeLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_time_layer_mean(s : DbstoretimeLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_time_layer_scale(s : DbstoretimeLayer, f : Double) -> DbstoretimeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_time_layer_add(a : DbstoretimeLayer, b : DbstoretimeLayer) -> DbstoretimeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_time_layer_copy(s : DbstoretimeLayer) -> DbstoretimeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_time_layer_fill(s : DbstoretimeLayer, v : Double) -> DbstoretimeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_time_layer_min(s : DbstoretimeLayer) -> Double { @_common.min(s.data) }

pub fn db_store_time_layer_max(s : DbstoretimeLayer) -> Double { @_common.max(s.data) }

pub fn db_store_time_layer_to_string(s : DbstoretimeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_buffer_make(size : Int) -> DbstoretimeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_buffer_len(s : DbstoretimeBuffer) -> Int { s.size }

pub fn db_store_time_buffer_get(s : DbstoretimeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_buffer_set(s : DbstoretimeBuffer, i : Int, v : Double) -> DbstoretimeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_time_buffer_sum(s : DbstoretimeBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_time_buffer_mean(s : DbstoretimeBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_time_buffer_scale(s : DbstoretimeBuffer, f : Double) -> DbstoretimeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_time_buffer_add(a : DbstoretimeBuffer, b : DbstoretimeBuffer) -> DbstoretimeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_time_buffer_copy(s : DbstoretimeBuffer) -> DbstoretimeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_time_buffer_fill(s : DbstoretimeBuffer, v : Double) -> DbstoretimeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_time_buffer_min(s : DbstoretimeBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_time_buffer_max(s : DbstoretimeBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_time_buffer_to_string(s : DbstoretimeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_cursor_make(size : Int) -> DbstoretimeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_cursor_len(s : DbstoretimeCursor) -> Int { s.size }

pub fn db_store_time_cursor_get(s : DbstoretimeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_cursor_set(s : DbstoretimeCursor, i : Int, v : Double) -> DbstoretimeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_time_cursor_sum(s : DbstoretimeCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_time_cursor_mean(s : DbstoretimeCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_time_cursor_scale(s : DbstoretimeCursor, f : Double) -> DbstoretimeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_time_cursor_add(a : DbstoretimeCursor, b : DbstoretimeCursor) -> DbstoretimeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_time_cursor_copy(s : DbstoretimeCursor) -> DbstoretimeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_time_cursor_fill(s : DbstoretimeCursor, v : Double) -> DbstoretimeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_time_cursor_min(s : DbstoretimeCursor) -> Double { @_common.min(s.data) }

pub fn db_store_time_cursor_max(s : DbstoretimeCursor) -> Double { @_common.max(s.data) }

pub fn db_store_time_cursor_to_string(s : DbstoretimeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_view_make(size : Int) -> DbstoretimeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_view_len(s : DbstoretimeView) -> Int { s.size }

pub fn db_store_time_view_get(s : DbstoretimeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_view_set(s : DbstoretimeView, i : Int, v : Double) -> DbstoretimeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_time_view_sum(s : DbstoretimeView) -> Double { @_common.sum(s.data) }

pub fn db_store_time_view_mean(s : DbstoretimeView) -> Double { @_common.mean(s.data) }

pub fn db_store_time_view_scale(s : DbstoretimeView, f : Double) -> DbstoretimeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_time_view_add(a : DbstoretimeView, b : DbstoretimeView) -> DbstoretimeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_time_view_copy(s : DbstoretimeView) -> DbstoretimeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_time_view_fill(s : DbstoretimeView, v : Double) -> DbstoretimeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_time_view_min(s : DbstoretimeView) -> Double { @_common.min(s.data) }

pub fn db_store_time_view_max(s : DbstoretimeView) -> Double { @_common.max(s.data) }

pub fn db_store_time_view_to_string(s : DbstoretimeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_range_make(size : Int) -> DbstoretimeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_range_len(s : DbstoretimeRange) -> Int { s.size }

pub fn db_store_time_range_get(s : DbstoretimeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_range_set(s : DbstoretimeRange, i : Int, v : Double) -> DbstoretimeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_time_range_sum(s : DbstoretimeRange) -> Double { @_common.sum(s.data) }

pub fn db_store_time_range_mean(s : DbstoretimeRange) -> Double { @_common.mean(s.data) }

pub fn db_store_time_range_scale(s : DbstoretimeRange, f : Double) -> DbstoretimeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_time_range_add(a : DbstoretimeRange, b : DbstoretimeRange) -> DbstoretimeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_time_range_copy(s : DbstoretimeRange) -> DbstoretimeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_time_range_fill(s : DbstoretimeRange, v : Double) -> DbstoretimeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_time_range_min(s : DbstoretimeRange) -> Double { @_common.min(s.data) }

pub fn db_store_time_range_max(s : DbstoretimeRange) -> Double { @_common.max(s.data) }

pub fn db_store_time_range_to_string(s : DbstoretimeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretimeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_time_slice_make(size : Int) -> DbstoretimeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_time_slice_len(s : DbstoretimeSlice) -> Int { s.size }

pub fn db_store_time_slice_get(s : DbstoretimeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_time_slice_set(s : DbstoretimeSlice, i : Int, v : Double) -> DbstoretimeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_time_slice_sum(s : DbstoretimeSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_time_slice_mean(s : DbstoretimeSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_time_slice_scale(s : DbstoretimeSlice, f : Double) -> DbstoretimeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_time_slice_add(a : DbstoretimeSlice, b : DbstoretimeSlice) -> DbstoretimeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_time_slice_copy(s : DbstoretimeSlice) -> DbstoretimeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_time_slice_fill(s : DbstoretimeSlice, v : Double) -> DbstoretimeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_time_slice_min(s : DbstoretimeSlice) -> Double { @_common.min(s.data) }

pub fn db_store_time_slice_max(s : DbstoretimeSlice) -> Double { @_common.max(s.data) }

pub fn db_store_time_slice_to_string(s : DbstoretimeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

