///===
/// extcore/db_store_tensor

pub(all) struct DbstoretensorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_tensor_make_point(x : Double, y : Double) -> DbstoretensorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_tensor_make_point3(x : Double, y : Double, z : Double) -> DbstoretensorPoint {
  { x, y, z, label: 0 }
}

pub fn DbstoretensorPoint::x(self : DbstoretensorPoint) -> Double { self.x }

pub fn DbstoretensorPoint::y(self : DbstoretensorPoint) -> Double { self.y }

pub fn DbstoretensorPoint::z(self : DbstoretensorPoint) -> Double { self.z }

pub fn DbstoretensorPoint::label(self : DbstoretensorPoint) -> Int { self.label }

pub fn DbstoretensorPoint::dist(self : DbstoretensorPoint, other : DbstoretensorPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstoretensorPoint::add(self : DbstoretensorPoint, other : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstoretensorPoint::sub(self : DbstoretensorPoint, other : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstoretensorPoint::scale(self : DbstoretensorPoint, s : Double) -> DbstoretensorPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstoretensorPoint::dot(self : DbstoretensorPoint, other : DbstoretensorPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstoretensorPoint::cross(self : DbstoretensorPoint, other : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstoretensorPoint::norm(self : DbstoretensorPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstoretensorPoint::normalize(self : DbstoretensorPoint) -> DbstoretensorPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoretensorPoint::negate(self : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstoretensorPoint::mid(self : DbstoretensorPoint, other : DbstoretensorPoint) -> DbstoretensorPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstoretensorPoint::lerp(self : DbstoretensorPoint, other : DbstoretensorPoint, t : Double) -> DbstoretensorPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstoretensorPoint::to_string(self : DbstoretensorPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstoretensorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_tensor_make_series(vals : Array[Double], name : String) -> DbstoretensorSeries {
  { vals, name, meta: 0 }
}

pub fn DbstoretensorSeries::len(self : DbstoretensorSeries) -> Int { self.vals.length() }

pub fn DbstoretensorSeries::sum(self : DbstoretensorSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstoretensorSeries::mean(self : DbstoretensorSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstoretensorSeries::min(self : DbstoretensorSeries) -> Double { @_common.min(self.vals) }

pub fn DbstoretensorSeries::max(self : DbstoretensorSeries) -> Double { @_common.max(self.vals) }

pub fn DbstoretensorSeries::range(self : DbstoretensorSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstoretensorSeries::variance(self : DbstoretensorSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstoretensorSeries::std(self : DbstoretensorSeries) -> Double { @_common.std(self.vals) }

pub fn DbstoretensorSeries::median(self : DbstoretensorSeries) -> Double { @_common.median(self.vals) }

pub fn DbstoretensorSeries::scale(self : DbstoretensorSeries, f : Double) -> DbstoretensorSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstoretensorSeries::add(self : DbstoretensorSeries, other : DbstoretensorSeries) -> DbstoretensorSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstoretensorSeries::sub(self : DbstoretensorSeries, other : DbstoretensorSeries) -> DbstoretensorSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstoretensorSeries::normalize(self : DbstoretensorSeries) -> DbstoretensorSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstoretensorSeries::cumsum(self : DbstoretensorSeries) -> DbstoretensorSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstoretensorSeries::to_string(self : DbstoretensorSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoretensorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_tensor_make_matrix(rows : Int, cols : Int, val : Double) -> DbstoretensorMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_tensor_matrix_identity(n : Int) -> DbstoretensorMatrix {
  let m = db_store_tensor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstoretensorMatrix::get(self : DbstoretensorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstoretensorMatrix::transpose(self : DbstoretensorMatrix) -> DbstoretensorMatrix {
  let result = db_store_tensor_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstoretensorMatrix::add(self : DbstoretensorMatrix, other : DbstoretensorMatrix) -> DbstoretensorMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_tensor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstoretensorMatrix::scale(self : DbstoretensorMatrix, s : Double) -> DbstoretensorMatrix {
  let result = db_store_tensor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstoretensorMatrix::multiply(self : DbstoretensorMatrix, other : DbstoretensorMatrix) -> DbstoretensorMatrix {
  if self.cols != other.rows { return db_store_tensor_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_tensor_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstoretensorMatrix::trace(self : DbstoretensorMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstoretensorMatrix::det(self : DbstoretensorMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstoretensorMatrix::norm(self : DbstoretensorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstoretensorMatrix::to_string(self : DbstoretensorMatrix) -> String {
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

pub(all) struct DbstoretensorVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_tensor_make_vector(comps : Array[Double]) -> DbstoretensorVector {
  { comps, dim: comps.length() }
}

pub fn db_store_tensor_vector_zero(dim : Int) -> DbstoretensorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstoretensorVector::add(self : DbstoretensorVector, other : DbstoretensorVector) -> DbstoretensorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoretensorVector::sub(self : DbstoretensorVector, other : DbstoretensorVector) -> DbstoretensorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoretensorVector::scale(self : DbstoretensorVector, s : Double) -> DbstoretensorVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstoretensorVector::dot(self : DbstoretensorVector, other : DbstoretensorVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstoretensorVector::norm(self : DbstoretensorVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstoretensorVector::normalize(self : DbstoretensorVector) -> DbstoretensorVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoretensorVector::dist(self : DbstoretensorVector, other : DbstoretensorVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstoretensorVector::to_string(self : DbstoretensorVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_tensor_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_tensor_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_tensor_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_tensor_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_tensor_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_tensor_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_tensor_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_tensor_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_tensor_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_tensor_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_tensor_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_tensor_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_tensor_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_tensor_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_tensor_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_tensor_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_tensor_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_tensor_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_tensor_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_tensor_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_tensor_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_tensor_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_tensor_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_tensor_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_tensor_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_tensor_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_tensor_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_tensor_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_tensor_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstoretensorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_frame_make(size : Int) -> DbstoretensorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_frame_len(s : DbstoretensorFrame) -> Int { s.size }

pub fn db_store_tensor_frame_get(s : DbstoretensorFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_frame_set(s : DbstoretensorFrame, i : Int, v : Double) -> DbstoretensorFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_frame_sum(s : DbstoretensorFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_frame_mean(s : DbstoretensorFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_frame_scale(s : DbstoretensorFrame, f : Double) -> DbstoretensorFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_frame_add(a : DbstoretensorFrame, b : DbstoretensorFrame) -> DbstoretensorFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_frame_copy(s : DbstoretensorFrame) -> DbstoretensorFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_frame_fill(s : DbstoretensorFrame, v : Double) -> DbstoretensorFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_frame_min(s : DbstoretensorFrame) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_frame_max(s : DbstoretensorFrame) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_frame_to_string(s : DbstoretensorFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_table_make(size : Int) -> DbstoretensorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_table_len(s : DbstoretensorTable) -> Int { s.size }

pub fn db_store_tensor_table_get(s : DbstoretensorTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_table_set(s : DbstoretensorTable, i : Int, v : Double) -> DbstoretensorTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_table_sum(s : DbstoretensorTable) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_table_mean(s : DbstoretensorTable) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_table_scale(s : DbstoretensorTable, f : Double) -> DbstoretensorTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_table_add(a : DbstoretensorTable, b : DbstoretensorTable) -> DbstoretensorTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_table_copy(s : DbstoretensorTable) -> DbstoretensorTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_table_fill(s : DbstoretensorTable, v : Double) -> DbstoretensorTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_table_min(s : DbstoretensorTable) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_table_max(s : DbstoretensorTable) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_table_to_string(s : DbstoretensorTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_graphn_make(size : Int) -> DbstoretensorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_graphn_len(s : DbstoretensorGraphN) -> Int { s.size }

pub fn db_store_tensor_graphn_get(s : DbstoretensorGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_graphn_set(s : DbstoretensorGraphN, i : Int, v : Double) -> DbstoretensorGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_graphn_sum(s : DbstoretensorGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_graphn_mean(s : DbstoretensorGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_graphn_scale(s : DbstoretensorGraphN, f : Double) -> DbstoretensorGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_graphn_add(a : DbstoretensorGraphN, b : DbstoretensorGraphN) -> DbstoretensorGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_graphn_copy(s : DbstoretensorGraphN) -> DbstoretensorGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_graphn_fill(s : DbstoretensorGraphN, v : Double) -> DbstoretensorGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_graphn_min(s : DbstoretensorGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_graphn_max(s : DbstoretensorGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_graphn_to_string(s : DbstoretensorGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_node_make(size : Int) -> DbstoretensorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_node_len(s : DbstoretensorNode) -> Int { s.size }

pub fn db_store_tensor_node_get(s : DbstoretensorNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_node_set(s : DbstoretensorNode, i : Int, v : Double) -> DbstoretensorNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_node_sum(s : DbstoretensorNode) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_node_mean(s : DbstoretensorNode) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_node_scale(s : DbstoretensorNode, f : Double) -> DbstoretensorNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_node_add(a : DbstoretensorNode, b : DbstoretensorNode) -> DbstoretensorNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_node_copy(s : DbstoretensorNode) -> DbstoretensorNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_node_fill(s : DbstoretensorNode, v : Double) -> DbstoretensorNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_node_min(s : DbstoretensorNode) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_node_max(s : DbstoretensorNode) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_node_to_string(s : DbstoretensorNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_edge_make(size : Int) -> DbstoretensorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_edge_len(s : DbstoretensorEdge) -> Int { s.size }

pub fn db_store_tensor_edge_get(s : DbstoretensorEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_edge_set(s : DbstoretensorEdge, i : Int, v : Double) -> DbstoretensorEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_edge_sum(s : DbstoretensorEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_edge_mean(s : DbstoretensorEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_edge_scale(s : DbstoretensorEdge, f : Double) -> DbstoretensorEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_edge_add(a : DbstoretensorEdge, b : DbstoretensorEdge) -> DbstoretensorEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_edge_copy(s : DbstoretensorEdge) -> DbstoretensorEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_edge_fill(s : DbstoretensorEdge, v : Double) -> DbstoretensorEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_edge_min(s : DbstoretensorEdge) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_edge_max(s : DbstoretensorEdge) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_edge_to_string(s : DbstoretensorEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_path_make(size : Int) -> DbstoretensorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_path_len(s : DbstoretensorPath) -> Int { s.size }

pub fn db_store_tensor_path_get(s : DbstoretensorPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_path_set(s : DbstoretensorPath, i : Int, v : Double) -> DbstoretensorPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_path_sum(s : DbstoretensorPath) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_path_mean(s : DbstoretensorPath) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_path_scale(s : DbstoretensorPath, f : Double) -> DbstoretensorPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_path_add(a : DbstoretensorPath, b : DbstoretensorPath) -> DbstoretensorPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_path_copy(s : DbstoretensorPath) -> DbstoretensorPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_path_fill(s : DbstoretensorPath, v : Double) -> DbstoretensorPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_path_min(s : DbstoretensorPath) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_path_max(s : DbstoretensorPath) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_path_to_string(s : DbstoretensorPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_cluster_make(size : Int) -> DbstoretensorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_cluster_len(s : DbstoretensorCluster) -> Int { s.size }

pub fn db_store_tensor_cluster_get(s : DbstoretensorCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_cluster_set(s : DbstoretensorCluster, i : Int, v : Double) -> DbstoretensorCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cluster_sum(s : DbstoretensorCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_cluster_mean(s : DbstoretensorCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_cluster_scale(s : DbstoretensorCluster, f : Double) -> DbstoretensorCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cluster_add(a : DbstoretensorCluster, b : DbstoretensorCluster) -> DbstoretensorCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_cluster_copy(s : DbstoretensorCluster) -> DbstoretensorCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cluster_fill(s : DbstoretensorCluster, v : Double) -> DbstoretensorCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cluster_min(s : DbstoretensorCluster) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_cluster_max(s : DbstoretensorCluster) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_cluster_to_string(s : DbstoretensorCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_model_make(size : Int) -> DbstoretensorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_model_len(s : DbstoretensorModel) -> Int { s.size }

pub fn db_store_tensor_model_get(s : DbstoretensorModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_model_set(s : DbstoretensorModel, i : Int, v : Double) -> DbstoretensorModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_model_sum(s : DbstoretensorModel) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_model_mean(s : DbstoretensorModel) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_model_scale(s : DbstoretensorModel, f : Double) -> DbstoretensorModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_model_add(a : DbstoretensorModel, b : DbstoretensorModel) -> DbstoretensorModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_model_copy(s : DbstoretensorModel) -> DbstoretensorModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_model_fill(s : DbstoretensorModel, v : Double) -> DbstoretensorModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_model_min(s : DbstoretensorModel) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_model_max(s : DbstoretensorModel) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_model_to_string(s : DbstoretensorModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_layer_make(size : Int) -> DbstoretensorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_layer_len(s : DbstoretensorLayer) -> Int { s.size }

pub fn db_store_tensor_layer_get(s : DbstoretensorLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_layer_set(s : DbstoretensorLayer, i : Int, v : Double) -> DbstoretensorLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_layer_sum(s : DbstoretensorLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_layer_mean(s : DbstoretensorLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_layer_scale(s : DbstoretensorLayer, f : Double) -> DbstoretensorLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_layer_add(a : DbstoretensorLayer, b : DbstoretensorLayer) -> DbstoretensorLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_layer_copy(s : DbstoretensorLayer) -> DbstoretensorLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_layer_fill(s : DbstoretensorLayer, v : Double) -> DbstoretensorLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_layer_min(s : DbstoretensorLayer) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_layer_max(s : DbstoretensorLayer) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_layer_to_string(s : DbstoretensorLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_buffer_make(size : Int) -> DbstoretensorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_buffer_len(s : DbstoretensorBuffer) -> Int { s.size }

pub fn db_store_tensor_buffer_get(s : DbstoretensorBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_buffer_set(s : DbstoretensorBuffer, i : Int, v : Double) -> DbstoretensorBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_buffer_sum(s : DbstoretensorBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_buffer_mean(s : DbstoretensorBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_buffer_scale(s : DbstoretensorBuffer, f : Double) -> DbstoretensorBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_buffer_add(a : DbstoretensorBuffer, b : DbstoretensorBuffer) -> DbstoretensorBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_buffer_copy(s : DbstoretensorBuffer) -> DbstoretensorBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_buffer_fill(s : DbstoretensorBuffer, v : Double) -> DbstoretensorBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_buffer_min(s : DbstoretensorBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_buffer_max(s : DbstoretensorBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_buffer_to_string(s : DbstoretensorBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_cursor_make(size : Int) -> DbstoretensorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_cursor_len(s : DbstoretensorCursor) -> Int { s.size }

pub fn db_store_tensor_cursor_get(s : DbstoretensorCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_cursor_set(s : DbstoretensorCursor, i : Int, v : Double) -> DbstoretensorCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cursor_sum(s : DbstoretensorCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_cursor_mean(s : DbstoretensorCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_cursor_scale(s : DbstoretensorCursor, f : Double) -> DbstoretensorCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cursor_add(a : DbstoretensorCursor, b : DbstoretensorCursor) -> DbstoretensorCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_cursor_copy(s : DbstoretensorCursor) -> DbstoretensorCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cursor_fill(s : DbstoretensorCursor, v : Double) -> DbstoretensorCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_cursor_min(s : DbstoretensorCursor) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_cursor_max(s : DbstoretensorCursor) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_cursor_to_string(s : DbstoretensorCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_view_make(size : Int) -> DbstoretensorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_view_len(s : DbstoretensorView) -> Int { s.size }

pub fn db_store_tensor_view_get(s : DbstoretensorView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_view_set(s : DbstoretensorView, i : Int, v : Double) -> DbstoretensorView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_view_sum(s : DbstoretensorView) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_view_mean(s : DbstoretensorView) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_view_scale(s : DbstoretensorView, f : Double) -> DbstoretensorView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_view_add(a : DbstoretensorView, b : DbstoretensorView) -> DbstoretensorView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_view_copy(s : DbstoretensorView) -> DbstoretensorView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_view_fill(s : DbstoretensorView, v : Double) -> DbstoretensorView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_view_min(s : DbstoretensorView) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_view_max(s : DbstoretensorView) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_view_to_string(s : DbstoretensorView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_range_make(size : Int) -> DbstoretensorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_range_len(s : DbstoretensorRange) -> Int { s.size }

pub fn db_store_tensor_range_get(s : DbstoretensorRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_range_set(s : DbstoretensorRange, i : Int, v : Double) -> DbstoretensorRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_range_sum(s : DbstoretensorRange) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_range_mean(s : DbstoretensorRange) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_range_scale(s : DbstoretensorRange, f : Double) -> DbstoretensorRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_range_add(a : DbstoretensorRange, b : DbstoretensorRange) -> DbstoretensorRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_range_copy(s : DbstoretensorRange) -> DbstoretensorRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_range_fill(s : DbstoretensorRange, v : Double) -> DbstoretensorRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_range_min(s : DbstoretensorRange) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_range_max(s : DbstoretensorRange) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_range_to_string(s : DbstoretensorRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoretensorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_tensor_slice_make(size : Int) -> DbstoretensorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_tensor_slice_len(s : DbstoretensorSlice) -> Int { s.size }

pub fn db_store_tensor_slice_get(s : DbstoretensorSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_tensor_slice_set(s : DbstoretensorSlice, i : Int, v : Double) -> DbstoretensorSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_tensor_slice_sum(s : DbstoretensorSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_tensor_slice_mean(s : DbstoretensorSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_tensor_slice_scale(s : DbstoretensorSlice, f : Double) -> DbstoretensorSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_slice_add(a : DbstoretensorSlice, b : DbstoretensorSlice) -> DbstoretensorSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_tensor_slice_copy(s : DbstoretensorSlice) -> DbstoretensorSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_slice_fill(s : DbstoretensorSlice, v : Double) -> DbstoretensorSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_tensor_slice_min(s : DbstoretensorSlice) -> Double { @_common.min(s.data) }

pub fn db_store_tensor_slice_max(s : DbstoretensorSlice) -> Double { @_common.max(s.data) }

pub fn db_store_tensor_slice_to_string(s : DbstoretensorSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

