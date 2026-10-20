///===
/// extcore/db_store_spatial

pub(all) struct DbstorespatialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_spatial_make_point(x : Double, y : Double) -> DbstorespatialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_spatial_make_point3(x : Double, y : Double, z : Double) -> DbstorespatialPoint {
  { x, y, z, label: 0 }
}

pub fn DbstorespatialPoint::x(self : DbstorespatialPoint) -> Double { self.x }

pub fn DbstorespatialPoint::y(self : DbstorespatialPoint) -> Double { self.y }

pub fn DbstorespatialPoint::z(self : DbstorespatialPoint) -> Double { self.z }

pub fn DbstorespatialPoint::label(self : DbstorespatialPoint) -> Int { self.label }

pub fn DbstorespatialPoint::dist(self : DbstorespatialPoint, other : DbstorespatialPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstorespatialPoint::add(self : DbstorespatialPoint, other : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstorespatialPoint::sub(self : DbstorespatialPoint, other : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstorespatialPoint::scale(self : DbstorespatialPoint, s : Double) -> DbstorespatialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstorespatialPoint::dot(self : DbstorespatialPoint, other : DbstorespatialPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstorespatialPoint::cross(self : DbstorespatialPoint, other : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstorespatialPoint::norm(self : DbstorespatialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstorespatialPoint::normalize(self : DbstorespatialPoint) -> DbstorespatialPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorespatialPoint::negate(self : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstorespatialPoint::mid(self : DbstorespatialPoint, other : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstorespatialPoint::lerp(self : DbstorespatialPoint, other : DbstorespatialPoint, t : Double) -> DbstorespatialPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstorespatialPoint::to_string(self : DbstorespatialPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstorespatialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_spatial_make_series(vals : Array[Double], name : String) -> DbstorespatialSeries {
  { vals, name, meta: 0 }
}

pub fn DbstorespatialSeries::len(self : DbstorespatialSeries) -> Int { self.vals.length() }

pub fn DbstorespatialSeries::sum(self : DbstorespatialSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstorespatialSeries::mean(self : DbstorespatialSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstorespatialSeries::min(self : DbstorespatialSeries) -> Double { @_common.min(self.vals) }

pub fn DbstorespatialSeries::max(self : DbstorespatialSeries) -> Double { @_common.max(self.vals) }

pub fn DbstorespatialSeries::range(self : DbstorespatialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstorespatialSeries::variance(self : DbstorespatialSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstorespatialSeries::std(self : DbstorespatialSeries) -> Double { @_common.std(self.vals) }

pub fn DbstorespatialSeries::median(self : DbstorespatialSeries) -> Double { @_common.median(self.vals) }

pub fn DbstorespatialSeries::scale(self : DbstorespatialSeries, f : Double) -> DbstorespatialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstorespatialSeries::add(self : DbstorespatialSeries, other : DbstorespatialSeries) -> DbstorespatialSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstorespatialSeries::sub(self : DbstorespatialSeries, other : DbstorespatialSeries) -> DbstorespatialSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstorespatialSeries::normalize(self : DbstorespatialSeries) -> DbstorespatialSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstorespatialSeries::cumsum(self : DbstorespatialSeries) -> DbstorespatialSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstorespatialSeries::to_string(self : DbstorespatialSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorespatialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_spatial_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorespatialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_spatial_matrix_identity(n : Int) -> DbstorespatialMatrix {
  let m = db_store_spatial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstorespatialMatrix::get(self : DbstorespatialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstorespatialMatrix::transpose(self : DbstorespatialMatrix) -> DbstorespatialMatrix {
  let result = db_store_spatial_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstorespatialMatrix::add(self : DbstorespatialMatrix, other : DbstorespatialMatrix) -> DbstorespatialMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_spatial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstorespatialMatrix::scale(self : DbstorespatialMatrix, s : Double) -> DbstorespatialMatrix {
  let result = db_store_spatial_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstorespatialMatrix::multiply(self : DbstorespatialMatrix, other : DbstorespatialMatrix) -> DbstorespatialMatrix {
  if self.cols != other.rows { return db_store_spatial_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_spatial_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstorespatialMatrix::trace(self : DbstorespatialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstorespatialMatrix::det(self : DbstorespatialMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstorespatialMatrix::norm(self : DbstorespatialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstorespatialMatrix::to_string(self : DbstorespatialMatrix) -> String {
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

pub(all) struct DbstorespatialVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_spatial_make_vector(comps : Array[Double]) -> DbstorespatialVector {
  { comps, dim: comps.length() }
}

pub fn db_store_spatial_vector_zero(dim : Int) -> DbstorespatialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstorespatialVector::add(self : DbstorespatialVector, other : DbstorespatialVector) -> DbstorespatialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorespatialVector::sub(self : DbstorespatialVector, other : DbstorespatialVector) -> DbstorespatialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorespatialVector::scale(self : DbstorespatialVector, s : Double) -> DbstorespatialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstorespatialVector::dot(self : DbstorespatialVector, other : DbstorespatialVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstorespatialVector::norm(self : DbstorespatialVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstorespatialVector::normalize(self : DbstorespatialVector) -> DbstorespatialVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorespatialVector::dist(self : DbstorespatialVector, other : DbstorespatialVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstorespatialVector::to_string(self : DbstorespatialVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_spatial_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_spatial_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_spatial_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_spatial_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_spatial_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_spatial_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_spatial_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_spatial_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_spatial_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_spatial_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_spatial_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_spatial_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_spatial_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_spatial_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_spatial_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_spatial_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_spatial_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_spatial_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_spatial_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_spatial_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_spatial_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_spatial_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_spatial_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_spatial_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_spatial_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_spatial_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_spatial_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_spatial_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_spatial_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstorespatialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_frame_make(size : Int) -> DbstorespatialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_frame_len(s : DbstorespatialFrame) -> Int { s.size }

pub fn db_store_spatial_frame_get(s : DbstorespatialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_frame_set(s : DbstorespatialFrame, i : Int, v : Double) -> DbstorespatialFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_spatial_frame_sum(s : DbstorespatialFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_frame_mean(s : DbstorespatialFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_frame_scale(s : DbstorespatialFrame, f : Double) -> DbstorespatialFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_frame_add(a : DbstorespatialFrame, b : DbstorespatialFrame) -> DbstorespatialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_frame_copy(s : DbstorespatialFrame) -> DbstorespatialFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_frame_fill(s : DbstorespatialFrame, v : Double) -> DbstorespatialFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_frame_min(s : DbstorespatialFrame) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_frame_max(s : DbstorespatialFrame) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_frame_to_string(s : DbstorespatialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_table_make(size : Int) -> DbstorespatialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_table_len(s : DbstorespatialTable) -> Int { s.size }

pub fn db_store_spatial_table_get(s : DbstorespatialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_table_set(s : DbstorespatialTable, i : Int, v : Double) -> DbstorespatialTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_spatial_table_sum(s : DbstorespatialTable) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_table_mean(s : DbstorespatialTable) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_table_scale(s : DbstorespatialTable, f : Double) -> DbstorespatialTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_table_add(a : DbstorespatialTable, b : DbstorespatialTable) -> DbstorespatialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_table_copy(s : DbstorespatialTable) -> DbstorespatialTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_table_fill(s : DbstorespatialTable, v : Double) -> DbstorespatialTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_table_min(s : DbstorespatialTable) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_table_max(s : DbstorespatialTable) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_table_to_string(s : DbstorespatialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_graphn_make(size : Int) -> DbstorespatialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_graphn_len(s : DbstorespatialGraphN) -> Int { s.size }

pub fn db_store_spatial_graphn_get(s : DbstorespatialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_graphn_set(s : DbstorespatialGraphN, i : Int, v : Double) -> DbstorespatialGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_spatial_graphn_sum(s : DbstorespatialGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_graphn_mean(s : DbstorespatialGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_graphn_scale(s : DbstorespatialGraphN, f : Double) -> DbstorespatialGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_graphn_add(a : DbstorespatialGraphN, b : DbstorespatialGraphN) -> DbstorespatialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_graphn_copy(s : DbstorespatialGraphN) -> DbstorespatialGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_graphn_fill(s : DbstorespatialGraphN, v : Double) -> DbstorespatialGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_graphn_min(s : DbstorespatialGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_graphn_max(s : DbstorespatialGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_graphn_to_string(s : DbstorespatialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_node_make(size : Int) -> DbstorespatialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_node_len(s : DbstorespatialNode) -> Int { s.size }

pub fn db_store_spatial_node_get(s : DbstorespatialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_node_set(s : DbstorespatialNode, i : Int, v : Double) -> DbstorespatialNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_spatial_node_sum(s : DbstorespatialNode) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_node_mean(s : DbstorespatialNode) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_node_scale(s : DbstorespatialNode, f : Double) -> DbstorespatialNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_node_add(a : DbstorespatialNode, b : DbstorespatialNode) -> DbstorespatialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_node_copy(s : DbstorespatialNode) -> DbstorespatialNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_node_fill(s : DbstorespatialNode, v : Double) -> DbstorespatialNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_node_min(s : DbstorespatialNode) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_node_max(s : DbstorespatialNode) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_node_to_string(s : DbstorespatialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_edge_make(size : Int) -> DbstorespatialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_edge_len(s : DbstorespatialEdge) -> Int { s.size }

pub fn db_store_spatial_edge_get(s : DbstorespatialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_edge_set(s : DbstorespatialEdge, i : Int, v : Double) -> DbstorespatialEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_spatial_edge_sum(s : DbstorespatialEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_edge_mean(s : DbstorespatialEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_edge_scale(s : DbstorespatialEdge, f : Double) -> DbstorespatialEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_edge_add(a : DbstorespatialEdge, b : DbstorespatialEdge) -> DbstorespatialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_edge_copy(s : DbstorespatialEdge) -> DbstorespatialEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_edge_fill(s : DbstorespatialEdge, v : Double) -> DbstorespatialEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_edge_min(s : DbstorespatialEdge) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_edge_max(s : DbstorespatialEdge) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_edge_to_string(s : DbstorespatialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_path_make(size : Int) -> DbstorespatialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_path_len(s : DbstorespatialPath) -> Int { s.size }

pub fn db_store_spatial_path_get(s : DbstorespatialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_path_set(s : DbstorespatialPath, i : Int, v : Double) -> DbstorespatialPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_spatial_path_sum(s : DbstorespatialPath) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_path_mean(s : DbstorespatialPath) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_path_scale(s : DbstorespatialPath, f : Double) -> DbstorespatialPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_path_add(a : DbstorespatialPath, b : DbstorespatialPath) -> DbstorespatialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_path_copy(s : DbstorespatialPath) -> DbstorespatialPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_path_fill(s : DbstorespatialPath, v : Double) -> DbstorespatialPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_path_min(s : DbstorespatialPath) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_path_max(s : DbstorespatialPath) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_path_to_string(s : DbstorespatialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_cluster_make(size : Int) -> DbstorespatialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_cluster_len(s : DbstorespatialCluster) -> Int { s.size }

pub fn db_store_spatial_cluster_get(s : DbstorespatialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_cluster_set(s : DbstorespatialCluster, i : Int, v : Double) -> DbstorespatialCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_spatial_cluster_sum(s : DbstorespatialCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_cluster_mean(s : DbstorespatialCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_cluster_scale(s : DbstorespatialCluster, f : Double) -> DbstorespatialCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_cluster_add(a : DbstorespatialCluster, b : DbstorespatialCluster) -> DbstorespatialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_cluster_copy(s : DbstorespatialCluster) -> DbstorespatialCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_cluster_fill(s : DbstorespatialCluster, v : Double) -> DbstorespatialCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_cluster_min(s : DbstorespatialCluster) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_cluster_max(s : DbstorespatialCluster) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_cluster_to_string(s : DbstorespatialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_model_make(size : Int) -> DbstorespatialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_model_len(s : DbstorespatialModel) -> Int { s.size }

pub fn db_store_spatial_model_get(s : DbstorespatialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_model_set(s : DbstorespatialModel, i : Int, v : Double) -> DbstorespatialModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_spatial_model_sum(s : DbstorespatialModel) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_model_mean(s : DbstorespatialModel) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_model_scale(s : DbstorespatialModel, f : Double) -> DbstorespatialModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_model_add(a : DbstorespatialModel, b : DbstorespatialModel) -> DbstorespatialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_model_copy(s : DbstorespatialModel) -> DbstorespatialModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_model_fill(s : DbstorespatialModel, v : Double) -> DbstorespatialModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_model_min(s : DbstorespatialModel) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_model_max(s : DbstorespatialModel) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_model_to_string(s : DbstorespatialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_layer_make(size : Int) -> DbstorespatialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_layer_len(s : DbstorespatialLayer) -> Int { s.size }

pub fn db_store_spatial_layer_get(s : DbstorespatialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_layer_set(s : DbstorespatialLayer, i : Int, v : Double) -> DbstorespatialLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_spatial_layer_sum(s : DbstorespatialLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_layer_mean(s : DbstorespatialLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_layer_scale(s : DbstorespatialLayer, f : Double) -> DbstorespatialLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_layer_add(a : DbstorespatialLayer, b : DbstorespatialLayer) -> DbstorespatialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_layer_copy(s : DbstorespatialLayer) -> DbstorespatialLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_layer_fill(s : DbstorespatialLayer, v : Double) -> DbstorespatialLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_layer_min(s : DbstorespatialLayer) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_layer_max(s : DbstorespatialLayer) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_layer_to_string(s : DbstorespatialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_buffer_make(size : Int) -> DbstorespatialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_buffer_len(s : DbstorespatialBuffer) -> Int { s.size }

pub fn db_store_spatial_buffer_get(s : DbstorespatialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_buffer_set(s : DbstorespatialBuffer, i : Int, v : Double) -> DbstorespatialBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_spatial_buffer_sum(s : DbstorespatialBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_buffer_mean(s : DbstorespatialBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_buffer_scale(s : DbstorespatialBuffer, f : Double) -> DbstorespatialBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_buffer_add(a : DbstorespatialBuffer, b : DbstorespatialBuffer) -> DbstorespatialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_buffer_copy(s : DbstorespatialBuffer) -> DbstorespatialBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_buffer_fill(s : DbstorespatialBuffer, v : Double) -> DbstorespatialBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_buffer_min(s : DbstorespatialBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_buffer_max(s : DbstorespatialBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_buffer_to_string(s : DbstorespatialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_cursor_make(size : Int) -> DbstorespatialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_cursor_len(s : DbstorespatialCursor) -> Int { s.size }

pub fn db_store_spatial_cursor_get(s : DbstorespatialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_cursor_set(s : DbstorespatialCursor, i : Int, v : Double) -> DbstorespatialCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_spatial_cursor_sum(s : DbstorespatialCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_cursor_mean(s : DbstorespatialCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_cursor_scale(s : DbstorespatialCursor, f : Double) -> DbstorespatialCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_cursor_add(a : DbstorespatialCursor, b : DbstorespatialCursor) -> DbstorespatialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_cursor_copy(s : DbstorespatialCursor) -> DbstorespatialCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_cursor_fill(s : DbstorespatialCursor, v : Double) -> DbstorespatialCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_cursor_min(s : DbstorespatialCursor) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_cursor_max(s : DbstorespatialCursor) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_cursor_to_string(s : DbstorespatialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_view_make(size : Int) -> DbstorespatialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_view_len(s : DbstorespatialView) -> Int { s.size }

pub fn db_store_spatial_view_get(s : DbstorespatialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_view_set(s : DbstorespatialView, i : Int, v : Double) -> DbstorespatialView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_spatial_view_sum(s : DbstorespatialView) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_view_mean(s : DbstorespatialView) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_view_scale(s : DbstorespatialView, f : Double) -> DbstorespatialView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_view_add(a : DbstorespatialView, b : DbstorespatialView) -> DbstorespatialView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_view_copy(s : DbstorespatialView) -> DbstorespatialView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_view_fill(s : DbstorespatialView, v : Double) -> DbstorespatialView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_view_min(s : DbstorespatialView) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_view_max(s : DbstorespatialView) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_view_to_string(s : DbstorespatialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_range_make(size : Int) -> DbstorespatialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_range_len(s : DbstorespatialRange) -> Int { s.size }

pub fn db_store_spatial_range_get(s : DbstorespatialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_range_set(s : DbstorespatialRange, i : Int, v : Double) -> DbstorespatialRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_spatial_range_sum(s : DbstorespatialRange) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_range_mean(s : DbstorespatialRange) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_range_scale(s : DbstorespatialRange, f : Double) -> DbstorespatialRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_range_add(a : DbstorespatialRange, b : DbstorespatialRange) -> DbstorespatialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_range_copy(s : DbstorespatialRange) -> DbstorespatialRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_range_fill(s : DbstorespatialRange, v : Double) -> DbstorespatialRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_range_min(s : DbstorespatialRange) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_range_max(s : DbstorespatialRange) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_range_to_string(s : DbstorespatialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_slice_make(size : Int) -> DbstorespatialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_slice_len(s : DbstorespatialSlice) -> Int { s.size }

pub fn db_store_spatial_slice_get(s : DbstorespatialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_slice_set(s : DbstorespatialSlice, i : Int, v : Double) -> DbstorespatialSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_spatial_slice_sum(s : DbstorespatialSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_spatial_slice_mean(s : DbstorespatialSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_spatial_slice_scale(s : DbstorespatialSlice, f : Double) -> DbstorespatialSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_slice_add(a : DbstorespatialSlice, b : DbstorespatialSlice) -> DbstorespatialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_spatial_slice_copy(s : DbstorespatialSlice) -> DbstorespatialSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_slice_fill(s : DbstorespatialSlice, v : Double) -> DbstorespatialSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_spatial_slice_min(s : DbstorespatialSlice) -> Double { @_common.min(s.data) }

pub fn db_store_spatial_slice_max(s : DbstorespatialSlice) -> Double { @_common.max(s.data) }

pub fn db_store_spatial_slice_to_string(s : DbstorespatialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

