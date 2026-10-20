///===
/// extcore/db_store_doc

pub(all) struct DbstoredocPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_doc_make_point(x : Double, y : Double) -> DbstoredocPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_doc_make_point3(x : Double, y : Double, z : Double) -> DbstoredocPoint {
  { x, y, z, label: 0 }
}

pub fn DbstoredocPoint::x(self : DbstoredocPoint) -> Double { self.x }

pub fn DbstoredocPoint::y(self : DbstoredocPoint) -> Double { self.y }

pub fn DbstoredocPoint::z(self : DbstoredocPoint) -> Double { self.z }

pub fn DbstoredocPoint::label(self : DbstoredocPoint) -> Int { self.label }

pub fn DbstoredocPoint::dist(self : DbstoredocPoint, other : DbstoredocPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstoredocPoint::add(self : DbstoredocPoint, other : DbstoredocPoint) -> DbstoredocPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstoredocPoint::sub(self : DbstoredocPoint, other : DbstoredocPoint) -> DbstoredocPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstoredocPoint::scale(self : DbstoredocPoint, s : Double) -> DbstoredocPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstoredocPoint::dot(self : DbstoredocPoint, other : DbstoredocPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstoredocPoint::cross(self : DbstoredocPoint, other : DbstoredocPoint) -> DbstoredocPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstoredocPoint::norm(self : DbstoredocPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstoredocPoint::normalize(self : DbstoredocPoint) -> DbstoredocPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoredocPoint::negate(self : DbstoredocPoint) -> DbstoredocPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstoredocPoint::mid(self : DbstoredocPoint, other : DbstoredocPoint) -> DbstoredocPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstoredocPoint::lerp(self : DbstoredocPoint, other : DbstoredocPoint, t : Double) -> DbstoredocPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstoredocPoint::to_string(self : DbstoredocPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstoredocSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_doc_make_series(vals : Array[Double], name : String) -> DbstoredocSeries {
  { vals, name, meta: 0 }
}

pub fn DbstoredocSeries::len(self : DbstoredocSeries) -> Int { self.vals.length() }

pub fn DbstoredocSeries::sum(self : DbstoredocSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstoredocSeries::mean(self : DbstoredocSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstoredocSeries::min(self : DbstoredocSeries) -> Double { @_common.min(self.vals) }

pub fn DbstoredocSeries::max(self : DbstoredocSeries) -> Double { @_common.max(self.vals) }

pub fn DbstoredocSeries::range(self : DbstoredocSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstoredocSeries::variance(self : DbstoredocSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstoredocSeries::std(self : DbstoredocSeries) -> Double { @_common.std(self.vals) }

pub fn DbstoredocSeries::median(self : DbstoredocSeries) -> Double { @_common.median(self.vals) }

pub fn DbstoredocSeries::scale(self : DbstoredocSeries, f : Double) -> DbstoredocSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstoredocSeries::add(self : DbstoredocSeries, other : DbstoredocSeries) -> DbstoredocSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstoredocSeries::sub(self : DbstoredocSeries, other : DbstoredocSeries) -> DbstoredocSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstoredocSeries::normalize(self : DbstoredocSeries) -> DbstoredocSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstoredocSeries::cumsum(self : DbstoredocSeries) -> DbstoredocSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstoredocSeries::to_string(self : DbstoredocSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstoredocMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_doc_make_matrix(rows : Int, cols : Int, val : Double) -> DbstoredocMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_doc_matrix_identity(n : Int) -> DbstoredocMatrix {
  let m = db_store_doc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstoredocMatrix::get(self : DbstoredocMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstoredocMatrix::transpose(self : DbstoredocMatrix) -> DbstoredocMatrix {
  let result = db_store_doc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstoredocMatrix::add(self : DbstoredocMatrix, other : DbstoredocMatrix) -> DbstoredocMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_doc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstoredocMatrix::scale(self : DbstoredocMatrix, s : Double) -> DbstoredocMatrix {
  let result = db_store_doc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstoredocMatrix::multiply(self : DbstoredocMatrix, other : DbstoredocMatrix) -> DbstoredocMatrix {
  if self.cols != other.rows { return db_store_doc_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_doc_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstoredocMatrix::trace(self : DbstoredocMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstoredocMatrix::det(self : DbstoredocMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstoredocMatrix::norm(self : DbstoredocMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstoredocMatrix::to_string(self : DbstoredocMatrix) -> String {
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

pub(all) struct DbstoredocVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_doc_make_vector(comps : Array[Double]) -> DbstoredocVector {
  { comps, dim: comps.length() }
}

pub fn db_store_doc_vector_zero(dim : Int) -> DbstoredocVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstoredocVector::add(self : DbstoredocVector, other : DbstoredocVector) -> DbstoredocVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoredocVector::sub(self : DbstoredocVector, other : DbstoredocVector) -> DbstoredocVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstoredocVector::scale(self : DbstoredocVector, s : Double) -> DbstoredocVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstoredocVector::dot(self : DbstoredocVector, other : DbstoredocVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstoredocVector::norm(self : DbstoredocVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstoredocVector::normalize(self : DbstoredocVector) -> DbstoredocVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstoredocVector::dist(self : DbstoredocVector, other : DbstoredocVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstoredocVector::to_string(self : DbstoredocVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_doc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_doc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_doc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_doc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_doc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_doc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_doc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_doc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_doc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_doc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_doc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_doc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_doc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_doc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_doc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_doc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_doc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_doc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_doc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_doc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_doc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_doc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_doc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_doc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_doc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_doc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_doc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_doc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_doc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstoredocFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_frame_make(size : Int) -> DbstoredocFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_frame_len(s : DbstoredocFrame) -> Int { s.size }

pub fn db_store_doc_frame_get(s : DbstoredocFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_frame_set(s : DbstoredocFrame, i : Int, v : Double) -> DbstoredocFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_doc_frame_sum(s : DbstoredocFrame) -> Double { @_common.sum(s.data) }

pub fn db_store_doc_frame_mean(s : DbstoredocFrame) -> Double { @_common.mean(s.data) }

pub fn db_store_doc_frame_scale(s : DbstoredocFrame, f : Double) -> DbstoredocFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_doc_frame_add(a : DbstoredocFrame, b : DbstoredocFrame) -> DbstoredocFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_doc_frame_copy(s : DbstoredocFrame) -> DbstoredocFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_doc_frame_fill(s : DbstoredocFrame, v : Double) -> DbstoredocFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_doc_frame_min(s : DbstoredocFrame) -> Double { @_common.min(s.data) }

pub fn db_store_doc_frame_max(s : DbstoredocFrame) -> Double { @_common.max(s.data) }

pub fn db_store_doc_frame_to_string(s : DbstoredocFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_table_make(size : Int) -> DbstoredocTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_table_len(s : DbstoredocTable) -> Int { s.size }

pub fn db_store_doc_table_get(s : DbstoredocTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_table_set(s : DbstoredocTable, i : Int, v : Double) -> DbstoredocTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_doc_table_sum(s : DbstoredocTable) -> Double { @_common.sum(s.data) }

pub fn db_store_doc_table_mean(s : DbstoredocTable) -> Double { @_common.mean(s.data) }

pub fn db_store_doc_table_scale(s : DbstoredocTable, f : Double) -> DbstoredocTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_doc_table_add(a : DbstoredocTable, b : DbstoredocTable) -> DbstoredocTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_doc_table_copy(s : DbstoredocTable) -> DbstoredocTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_doc_table_fill(s : DbstoredocTable, v : Double) -> DbstoredocTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_doc_table_min(s : DbstoredocTable) -> Double { @_common.min(s.data) }

pub fn db_store_doc_table_max(s : DbstoredocTable) -> Double { @_common.max(s.data) }

pub fn db_store_doc_table_to_string(s : DbstoredocTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_graphn_make(size : Int) -> DbstoredocGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_graphn_len(s : DbstoredocGraphN) -> Int { s.size }

pub fn db_store_doc_graphn_get(s : DbstoredocGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_graphn_set(s : DbstoredocGraphN, i : Int, v : Double) -> DbstoredocGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_doc_graphn_sum(s : DbstoredocGraphN) -> Double { @_common.sum(s.data) }

pub fn db_store_doc_graphn_mean(s : DbstoredocGraphN) -> Double { @_common.mean(s.data) }

pub fn db_store_doc_graphn_scale(s : DbstoredocGraphN, f : Double) -> DbstoredocGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_doc_graphn_add(a : DbstoredocGraphN, b : DbstoredocGraphN) -> DbstoredocGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_doc_graphn_copy(s : DbstoredocGraphN) -> DbstoredocGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_doc_graphn_fill(s : DbstoredocGraphN, v : Double) -> DbstoredocGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_doc_graphn_min(s : DbstoredocGraphN) -> Double { @_common.min(s.data) }

pub fn db_store_doc_graphn_max(s : DbstoredocGraphN) -> Double { @_common.max(s.data) }

pub fn db_store_doc_graphn_to_string(s : DbstoredocGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_node_make(size : Int) -> DbstoredocNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_node_len(s : DbstoredocNode) -> Int { s.size }

pub fn db_store_doc_node_get(s : DbstoredocNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_node_set(s : DbstoredocNode, i : Int, v : Double) -> DbstoredocNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_doc_node_sum(s : DbstoredocNode) -> Double { @_common.sum(s.data) }

pub fn db_store_doc_node_mean(s : DbstoredocNode) -> Double { @_common.mean(s.data) }

pub fn db_store_doc_node_scale(s : DbstoredocNode, f : Double) -> DbstoredocNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_doc_node_add(a : DbstoredocNode, b : DbstoredocNode) -> DbstoredocNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_doc_node_copy(s : DbstoredocNode) -> DbstoredocNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_doc_node_fill(s : DbstoredocNode, v : Double) -> DbstoredocNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_doc_node_min(s : DbstoredocNode) -> Double { @_common.min(s.data) }

pub fn db_store_doc_node_max(s : DbstoredocNode) -> Double { @_common.max(s.data) }

pub fn db_store_doc_node_to_string(s : DbstoredocNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_edge_make(size : Int) -> DbstoredocEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_edge_len(s : DbstoredocEdge) -> Int { s.size }

pub fn db_store_doc_edge_get(s : DbstoredocEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_edge_set(s : DbstoredocEdge, i : Int, v : Double) -> DbstoredocEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_doc_edge_sum(s : DbstoredocEdge) -> Double { @_common.sum(s.data) }

pub fn db_store_doc_edge_mean(s : DbstoredocEdge) -> Double { @_common.mean(s.data) }

pub fn db_store_doc_edge_scale(s : DbstoredocEdge, f : Double) -> DbstoredocEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_doc_edge_add(a : DbstoredocEdge, b : DbstoredocEdge) -> DbstoredocEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_doc_edge_copy(s : DbstoredocEdge) -> DbstoredocEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_doc_edge_fill(s : DbstoredocEdge, v : Double) -> DbstoredocEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_doc_edge_min(s : DbstoredocEdge) -> Double { @_common.min(s.data) }

pub fn db_store_doc_edge_max(s : DbstoredocEdge) -> Double { @_common.max(s.data) }

pub fn db_store_doc_edge_to_string(s : DbstoredocEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_path_make(size : Int) -> DbstoredocPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_path_len(s : DbstoredocPath) -> Int { s.size }

pub fn db_store_doc_path_get(s : DbstoredocPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_path_set(s : DbstoredocPath, i : Int, v : Double) -> DbstoredocPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_doc_path_sum(s : DbstoredocPath) -> Double { @_common.sum(s.data) }

pub fn db_store_doc_path_mean(s : DbstoredocPath) -> Double { @_common.mean(s.data) }

pub fn db_store_doc_path_scale(s : DbstoredocPath, f : Double) -> DbstoredocPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_doc_path_add(a : DbstoredocPath, b : DbstoredocPath) -> DbstoredocPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_doc_path_copy(s : DbstoredocPath) -> DbstoredocPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_doc_path_fill(s : DbstoredocPath, v : Double) -> DbstoredocPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_doc_path_min(s : DbstoredocPath) -> Double { @_common.min(s.data) }

pub fn db_store_doc_path_max(s : DbstoredocPath) -> Double { @_common.max(s.data) }

pub fn db_store_doc_path_to_string(s : DbstoredocPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_cluster_make(size : Int) -> DbstoredocCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_cluster_len(s : DbstoredocCluster) -> Int { s.size }

pub fn db_store_doc_cluster_get(s : DbstoredocCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_cluster_set(s : DbstoredocCluster, i : Int, v : Double) -> DbstoredocCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_doc_cluster_sum(s : DbstoredocCluster) -> Double { @_common.sum(s.data) }

pub fn db_store_doc_cluster_mean(s : DbstoredocCluster) -> Double { @_common.mean(s.data) }

pub fn db_store_doc_cluster_scale(s : DbstoredocCluster, f : Double) -> DbstoredocCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_doc_cluster_add(a : DbstoredocCluster, b : DbstoredocCluster) -> DbstoredocCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_doc_cluster_copy(s : DbstoredocCluster) -> DbstoredocCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_doc_cluster_fill(s : DbstoredocCluster, v : Double) -> DbstoredocCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_doc_cluster_min(s : DbstoredocCluster) -> Double { @_common.min(s.data) }

pub fn db_store_doc_cluster_max(s : DbstoredocCluster) -> Double { @_common.max(s.data) }

pub fn db_store_doc_cluster_to_string(s : DbstoredocCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_model_make(size : Int) -> DbstoredocModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_model_len(s : DbstoredocModel) -> Int { s.size }

pub fn db_store_doc_model_get(s : DbstoredocModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_model_set(s : DbstoredocModel, i : Int, v : Double) -> DbstoredocModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_doc_model_sum(s : DbstoredocModel) -> Double { @_common.sum(s.data) }

pub fn db_store_doc_model_mean(s : DbstoredocModel) -> Double { @_common.mean(s.data) }

pub fn db_store_doc_model_scale(s : DbstoredocModel, f : Double) -> DbstoredocModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_doc_model_add(a : DbstoredocModel, b : DbstoredocModel) -> DbstoredocModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_doc_model_copy(s : DbstoredocModel) -> DbstoredocModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_doc_model_fill(s : DbstoredocModel, v : Double) -> DbstoredocModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_doc_model_min(s : DbstoredocModel) -> Double { @_common.min(s.data) }

pub fn db_store_doc_model_max(s : DbstoredocModel) -> Double { @_common.max(s.data) }

pub fn db_store_doc_model_to_string(s : DbstoredocModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_layer_make(size : Int) -> DbstoredocLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_layer_len(s : DbstoredocLayer) -> Int { s.size }

pub fn db_store_doc_layer_get(s : DbstoredocLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_layer_set(s : DbstoredocLayer, i : Int, v : Double) -> DbstoredocLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_doc_layer_sum(s : DbstoredocLayer) -> Double { @_common.sum(s.data) }

pub fn db_store_doc_layer_mean(s : DbstoredocLayer) -> Double { @_common.mean(s.data) }

pub fn db_store_doc_layer_scale(s : DbstoredocLayer, f : Double) -> DbstoredocLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_doc_layer_add(a : DbstoredocLayer, b : DbstoredocLayer) -> DbstoredocLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_doc_layer_copy(s : DbstoredocLayer) -> DbstoredocLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_doc_layer_fill(s : DbstoredocLayer, v : Double) -> DbstoredocLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_doc_layer_min(s : DbstoredocLayer) -> Double { @_common.min(s.data) }

pub fn db_store_doc_layer_max(s : DbstoredocLayer) -> Double { @_common.max(s.data) }

pub fn db_store_doc_layer_to_string(s : DbstoredocLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_buffer_make(size : Int) -> DbstoredocBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_buffer_len(s : DbstoredocBuffer) -> Int { s.size }

pub fn db_store_doc_buffer_get(s : DbstoredocBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_buffer_set(s : DbstoredocBuffer, i : Int, v : Double) -> DbstoredocBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_doc_buffer_sum(s : DbstoredocBuffer) -> Double { @_common.sum(s.data) }

pub fn db_store_doc_buffer_mean(s : DbstoredocBuffer) -> Double { @_common.mean(s.data) }

pub fn db_store_doc_buffer_scale(s : DbstoredocBuffer, f : Double) -> DbstoredocBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_doc_buffer_add(a : DbstoredocBuffer, b : DbstoredocBuffer) -> DbstoredocBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_doc_buffer_copy(s : DbstoredocBuffer) -> DbstoredocBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_doc_buffer_fill(s : DbstoredocBuffer, v : Double) -> DbstoredocBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_doc_buffer_min(s : DbstoredocBuffer) -> Double { @_common.min(s.data) }

pub fn db_store_doc_buffer_max(s : DbstoredocBuffer) -> Double { @_common.max(s.data) }

pub fn db_store_doc_buffer_to_string(s : DbstoredocBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_cursor_make(size : Int) -> DbstoredocCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_cursor_len(s : DbstoredocCursor) -> Int { s.size }

pub fn db_store_doc_cursor_get(s : DbstoredocCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_cursor_set(s : DbstoredocCursor, i : Int, v : Double) -> DbstoredocCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_doc_cursor_sum(s : DbstoredocCursor) -> Double { @_common.sum(s.data) }

pub fn db_store_doc_cursor_mean(s : DbstoredocCursor) -> Double { @_common.mean(s.data) }

pub fn db_store_doc_cursor_scale(s : DbstoredocCursor, f : Double) -> DbstoredocCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_doc_cursor_add(a : DbstoredocCursor, b : DbstoredocCursor) -> DbstoredocCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_doc_cursor_copy(s : DbstoredocCursor) -> DbstoredocCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_doc_cursor_fill(s : DbstoredocCursor, v : Double) -> DbstoredocCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_doc_cursor_min(s : DbstoredocCursor) -> Double { @_common.min(s.data) }

pub fn db_store_doc_cursor_max(s : DbstoredocCursor) -> Double { @_common.max(s.data) }

pub fn db_store_doc_cursor_to_string(s : DbstoredocCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_view_make(size : Int) -> DbstoredocView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_view_len(s : DbstoredocView) -> Int { s.size }

pub fn db_store_doc_view_get(s : DbstoredocView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_view_set(s : DbstoredocView, i : Int, v : Double) -> DbstoredocView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_doc_view_sum(s : DbstoredocView) -> Double { @_common.sum(s.data) }

pub fn db_store_doc_view_mean(s : DbstoredocView) -> Double { @_common.mean(s.data) }

pub fn db_store_doc_view_scale(s : DbstoredocView, f : Double) -> DbstoredocView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_doc_view_add(a : DbstoredocView, b : DbstoredocView) -> DbstoredocView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_doc_view_copy(s : DbstoredocView) -> DbstoredocView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_doc_view_fill(s : DbstoredocView, v : Double) -> DbstoredocView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_doc_view_min(s : DbstoredocView) -> Double { @_common.min(s.data) }

pub fn db_store_doc_view_max(s : DbstoredocView) -> Double { @_common.max(s.data) }

pub fn db_store_doc_view_to_string(s : DbstoredocView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_range_make(size : Int) -> DbstoredocRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_range_len(s : DbstoredocRange) -> Int { s.size }

pub fn db_store_doc_range_get(s : DbstoredocRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_range_set(s : DbstoredocRange, i : Int, v : Double) -> DbstoredocRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_doc_range_sum(s : DbstoredocRange) -> Double { @_common.sum(s.data) }

pub fn db_store_doc_range_mean(s : DbstoredocRange) -> Double { @_common.mean(s.data) }

pub fn db_store_doc_range_scale(s : DbstoredocRange, f : Double) -> DbstoredocRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_doc_range_add(a : DbstoredocRange, b : DbstoredocRange) -> DbstoredocRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_doc_range_copy(s : DbstoredocRange) -> DbstoredocRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_doc_range_fill(s : DbstoredocRange, v : Double) -> DbstoredocRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_doc_range_min(s : DbstoredocRange) -> Double { @_common.min(s.data) }

pub fn db_store_doc_range_max(s : DbstoredocRange) -> Double { @_common.max(s.data) }

pub fn db_store_doc_range_to_string(s : DbstoredocRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstoredocSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_doc_slice_make(size : Int) -> DbstoredocSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_doc_slice_len(s : DbstoredocSlice) -> Int { s.size }

pub fn db_store_doc_slice_get(s : DbstoredocSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_doc_slice_set(s : DbstoredocSlice, i : Int, v : Double) -> DbstoredocSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_store_doc_slice_sum(s : DbstoredocSlice) -> Double { @_common.sum(s.data) }

pub fn db_store_doc_slice_mean(s : DbstoredocSlice) -> Double { @_common.mean(s.data) }

pub fn db_store_doc_slice_scale(s : DbstoredocSlice, f : Double) -> DbstoredocSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_store_doc_slice_add(a : DbstoredocSlice, b : DbstoredocSlice) -> DbstoredocSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_store_doc_slice_copy(s : DbstoredocSlice) -> DbstoredocSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_store_doc_slice_fill(s : DbstoredocSlice, v : Double) -> DbstoredocSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_store_doc_slice_min(s : DbstoredocSlice) -> Double { @_common.min(s.data) }

pub fn db_store_doc_slice_max(s : DbstoredocSlice) -> Double { @_common.max(s.data) }

pub fn db_store_doc_slice_to_string(s : DbstoredocSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

