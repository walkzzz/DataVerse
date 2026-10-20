///===
/// extcore/db_index_brin

pub(all) struct DbindexbrinPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_brin_make_point(x : Double, y : Double) -> DbindexbrinPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_brin_make_point3(x : Double, y : Double, z : Double) -> DbindexbrinPoint {
  { x, y, z, label: 0 }
}

pub fn DbindexbrinPoint::x(self : DbindexbrinPoint) -> Double { self.x }

pub fn DbindexbrinPoint::y(self : DbindexbrinPoint) -> Double { self.y }

pub fn DbindexbrinPoint::z(self : DbindexbrinPoint) -> Double { self.z }

pub fn DbindexbrinPoint::label(self : DbindexbrinPoint) -> Int { self.label }

pub fn DbindexbrinPoint::dist(self : DbindexbrinPoint, other : DbindexbrinPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexbrinPoint::add(self : DbindexbrinPoint, other : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexbrinPoint::sub(self : DbindexbrinPoint, other : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexbrinPoint::scale(self : DbindexbrinPoint, s : Double) -> DbindexbrinPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexbrinPoint::dot(self : DbindexbrinPoint, other : DbindexbrinPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexbrinPoint::cross(self : DbindexbrinPoint, other : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexbrinPoint::norm(self : DbindexbrinPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexbrinPoint::normalize(self : DbindexbrinPoint) -> DbindexbrinPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexbrinPoint::negate(self : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexbrinPoint::mid(self : DbindexbrinPoint, other : DbindexbrinPoint) -> DbindexbrinPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexbrinPoint::lerp(self : DbindexbrinPoint, other : DbindexbrinPoint, t : Double) -> DbindexbrinPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexbrinPoint::to_string(self : DbindexbrinPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexbrinSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_brin_make_series(vals : Array[Double], name : String) -> DbindexbrinSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexbrinSeries::len(self : DbindexbrinSeries) -> Int { self.vals.length() }

pub fn DbindexbrinSeries::sum(self : DbindexbrinSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexbrinSeries::mean(self : DbindexbrinSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexbrinSeries::min(self : DbindexbrinSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexbrinSeries::max(self : DbindexbrinSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexbrinSeries::range(self : DbindexbrinSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexbrinSeries::variance(self : DbindexbrinSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexbrinSeries::std(self : DbindexbrinSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexbrinSeries::median(self : DbindexbrinSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexbrinSeries::scale(self : DbindexbrinSeries, f : Double) -> DbindexbrinSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexbrinSeries::add(self : DbindexbrinSeries, other : DbindexbrinSeries) -> DbindexbrinSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexbrinSeries::sub(self : DbindexbrinSeries, other : DbindexbrinSeries) -> DbindexbrinSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexbrinSeries::normalize(self : DbindexbrinSeries) -> DbindexbrinSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexbrinSeries::cumsum(self : DbindexbrinSeries) -> DbindexbrinSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexbrinSeries::to_string(self : DbindexbrinSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexbrinMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_brin_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexbrinMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_brin_matrix_identity(n : Int) -> DbindexbrinMatrix {
  let m = db_index_brin_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexbrinMatrix::get(self : DbindexbrinMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexbrinMatrix::transpose(self : DbindexbrinMatrix) -> DbindexbrinMatrix {
  let result = db_index_brin_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexbrinMatrix::add(self : DbindexbrinMatrix, other : DbindexbrinMatrix) -> DbindexbrinMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_brin_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexbrinMatrix::scale(self : DbindexbrinMatrix, s : Double) -> DbindexbrinMatrix {
  let result = db_index_brin_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexbrinMatrix::multiply(self : DbindexbrinMatrix, other : DbindexbrinMatrix) -> DbindexbrinMatrix {
  if self.cols != other.rows { return db_index_brin_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_brin_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbindexbrinMatrix::trace(self : DbindexbrinMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexbrinMatrix::det(self : DbindexbrinMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexbrinMatrix::norm(self : DbindexbrinMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexbrinMatrix::to_string(self : DbindexbrinMatrix) -> String {
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

pub(all) struct DbindexbrinVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_brin_make_vector(comps : Array[Double]) -> DbindexbrinVector {
  { comps, dim: comps.length() }
}

pub fn db_index_brin_vector_zero(dim : Int) -> DbindexbrinVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexbrinVector::add(self : DbindexbrinVector, other : DbindexbrinVector) -> DbindexbrinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexbrinVector::sub(self : DbindexbrinVector, other : DbindexbrinVector) -> DbindexbrinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexbrinVector::scale(self : DbindexbrinVector, s : Double) -> DbindexbrinVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexbrinVector::dot(self : DbindexbrinVector, other : DbindexbrinVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexbrinVector::norm(self : DbindexbrinVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexbrinVector::normalize(self : DbindexbrinVector) -> DbindexbrinVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexbrinVector::dist(self : DbindexbrinVector, other : DbindexbrinVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexbrinVector::to_string(self : DbindexbrinVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_brin_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_index_brin_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_index_brin_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_index_brin_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_index_brin_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_index_brin_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_index_brin_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_index_brin_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_index_brin_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_index_brin_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_index_brin_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_index_brin_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_index_brin_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_index_brin_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_index_brin_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_index_brin_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_index_brin_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_index_brin_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_index_brin_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_index_brin_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_index_brin_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_index_brin_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_index_brin_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_index_brin_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_index_brin_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_index_brin_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_index_brin_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_index_brin_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_index_brin_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbindexbrinFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_frame_make(size : Int) -> DbindexbrinFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_frame_len(s : DbindexbrinFrame) -> Int { s.size }

pub fn db_index_brin_frame_get(s : DbindexbrinFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_frame_set(s : DbindexbrinFrame, i : Int, v : Double) -> DbindexbrinFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_brin_frame_sum(s : DbindexbrinFrame) -> Double { @_common.sum(s.data) }

pub fn db_index_brin_frame_mean(s : DbindexbrinFrame) -> Double { @_common.mean(s.data) }

pub fn db_index_brin_frame_scale(s : DbindexbrinFrame, f : Double) -> DbindexbrinFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_brin_frame_add(a : DbindexbrinFrame, b : DbindexbrinFrame) -> DbindexbrinFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_brin_frame_copy(s : DbindexbrinFrame) -> DbindexbrinFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_brin_frame_fill(s : DbindexbrinFrame, v : Double) -> DbindexbrinFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_brin_frame_min(s : DbindexbrinFrame) -> Double { @_common.min(s.data) }

pub fn db_index_brin_frame_max(s : DbindexbrinFrame) -> Double { @_common.max(s.data) }

pub fn db_index_brin_frame_to_string(s : DbindexbrinFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_table_make(size : Int) -> DbindexbrinTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_table_len(s : DbindexbrinTable) -> Int { s.size }

pub fn db_index_brin_table_get(s : DbindexbrinTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_table_set(s : DbindexbrinTable, i : Int, v : Double) -> DbindexbrinTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_brin_table_sum(s : DbindexbrinTable) -> Double { @_common.sum(s.data) }

pub fn db_index_brin_table_mean(s : DbindexbrinTable) -> Double { @_common.mean(s.data) }

pub fn db_index_brin_table_scale(s : DbindexbrinTable, f : Double) -> DbindexbrinTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_brin_table_add(a : DbindexbrinTable, b : DbindexbrinTable) -> DbindexbrinTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_brin_table_copy(s : DbindexbrinTable) -> DbindexbrinTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_brin_table_fill(s : DbindexbrinTable, v : Double) -> DbindexbrinTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_brin_table_min(s : DbindexbrinTable) -> Double { @_common.min(s.data) }

pub fn db_index_brin_table_max(s : DbindexbrinTable) -> Double { @_common.max(s.data) }

pub fn db_index_brin_table_to_string(s : DbindexbrinTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_graphn_make(size : Int) -> DbindexbrinGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_graphn_len(s : DbindexbrinGraphN) -> Int { s.size }

pub fn db_index_brin_graphn_get(s : DbindexbrinGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_graphn_set(s : DbindexbrinGraphN, i : Int, v : Double) -> DbindexbrinGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_brin_graphn_sum(s : DbindexbrinGraphN) -> Double { @_common.sum(s.data) }

pub fn db_index_brin_graphn_mean(s : DbindexbrinGraphN) -> Double { @_common.mean(s.data) }

pub fn db_index_brin_graphn_scale(s : DbindexbrinGraphN, f : Double) -> DbindexbrinGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_brin_graphn_add(a : DbindexbrinGraphN, b : DbindexbrinGraphN) -> DbindexbrinGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_brin_graphn_copy(s : DbindexbrinGraphN) -> DbindexbrinGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_brin_graphn_fill(s : DbindexbrinGraphN, v : Double) -> DbindexbrinGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_brin_graphn_min(s : DbindexbrinGraphN) -> Double { @_common.min(s.data) }

pub fn db_index_brin_graphn_max(s : DbindexbrinGraphN) -> Double { @_common.max(s.data) }

pub fn db_index_brin_graphn_to_string(s : DbindexbrinGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_node_make(size : Int) -> DbindexbrinNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_node_len(s : DbindexbrinNode) -> Int { s.size }

pub fn db_index_brin_node_get(s : DbindexbrinNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_node_set(s : DbindexbrinNode, i : Int, v : Double) -> DbindexbrinNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_brin_node_sum(s : DbindexbrinNode) -> Double { @_common.sum(s.data) }

pub fn db_index_brin_node_mean(s : DbindexbrinNode) -> Double { @_common.mean(s.data) }

pub fn db_index_brin_node_scale(s : DbindexbrinNode, f : Double) -> DbindexbrinNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_brin_node_add(a : DbindexbrinNode, b : DbindexbrinNode) -> DbindexbrinNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_brin_node_copy(s : DbindexbrinNode) -> DbindexbrinNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_brin_node_fill(s : DbindexbrinNode, v : Double) -> DbindexbrinNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_brin_node_min(s : DbindexbrinNode) -> Double { @_common.min(s.data) }

pub fn db_index_brin_node_max(s : DbindexbrinNode) -> Double { @_common.max(s.data) }

pub fn db_index_brin_node_to_string(s : DbindexbrinNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_edge_make(size : Int) -> DbindexbrinEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_edge_len(s : DbindexbrinEdge) -> Int { s.size }

pub fn db_index_brin_edge_get(s : DbindexbrinEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_edge_set(s : DbindexbrinEdge, i : Int, v : Double) -> DbindexbrinEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_brin_edge_sum(s : DbindexbrinEdge) -> Double { @_common.sum(s.data) }

pub fn db_index_brin_edge_mean(s : DbindexbrinEdge) -> Double { @_common.mean(s.data) }

pub fn db_index_brin_edge_scale(s : DbindexbrinEdge, f : Double) -> DbindexbrinEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_brin_edge_add(a : DbindexbrinEdge, b : DbindexbrinEdge) -> DbindexbrinEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_brin_edge_copy(s : DbindexbrinEdge) -> DbindexbrinEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_brin_edge_fill(s : DbindexbrinEdge, v : Double) -> DbindexbrinEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_brin_edge_min(s : DbindexbrinEdge) -> Double { @_common.min(s.data) }

pub fn db_index_brin_edge_max(s : DbindexbrinEdge) -> Double { @_common.max(s.data) }

pub fn db_index_brin_edge_to_string(s : DbindexbrinEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_path_make(size : Int) -> DbindexbrinPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_path_len(s : DbindexbrinPath) -> Int { s.size }

pub fn db_index_brin_path_get(s : DbindexbrinPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_path_set(s : DbindexbrinPath, i : Int, v : Double) -> DbindexbrinPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_brin_path_sum(s : DbindexbrinPath) -> Double { @_common.sum(s.data) }

pub fn db_index_brin_path_mean(s : DbindexbrinPath) -> Double { @_common.mean(s.data) }

pub fn db_index_brin_path_scale(s : DbindexbrinPath, f : Double) -> DbindexbrinPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_brin_path_add(a : DbindexbrinPath, b : DbindexbrinPath) -> DbindexbrinPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_brin_path_copy(s : DbindexbrinPath) -> DbindexbrinPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_brin_path_fill(s : DbindexbrinPath, v : Double) -> DbindexbrinPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_brin_path_min(s : DbindexbrinPath) -> Double { @_common.min(s.data) }

pub fn db_index_brin_path_max(s : DbindexbrinPath) -> Double { @_common.max(s.data) }

pub fn db_index_brin_path_to_string(s : DbindexbrinPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_cluster_make(size : Int) -> DbindexbrinCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_cluster_len(s : DbindexbrinCluster) -> Int { s.size }

pub fn db_index_brin_cluster_get(s : DbindexbrinCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_cluster_set(s : DbindexbrinCluster, i : Int, v : Double) -> DbindexbrinCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_brin_cluster_sum(s : DbindexbrinCluster) -> Double { @_common.sum(s.data) }

pub fn db_index_brin_cluster_mean(s : DbindexbrinCluster) -> Double { @_common.mean(s.data) }

pub fn db_index_brin_cluster_scale(s : DbindexbrinCluster, f : Double) -> DbindexbrinCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_brin_cluster_add(a : DbindexbrinCluster, b : DbindexbrinCluster) -> DbindexbrinCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_brin_cluster_copy(s : DbindexbrinCluster) -> DbindexbrinCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_brin_cluster_fill(s : DbindexbrinCluster, v : Double) -> DbindexbrinCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_brin_cluster_min(s : DbindexbrinCluster) -> Double { @_common.min(s.data) }

pub fn db_index_brin_cluster_max(s : DbindexbrinCluster) -> Double { @_common.max(s.data) }

pub fn db_index_brin_cluster_to_string(s : DbindexbrinCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_model_make(size : Int) -> DbindexbrinModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_model_len(s : DbindexbrinModel) -> Int { s.size }

pub fn db_index_brin_model_get(s : DbindexbrinModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_model_set(s : DbindexbrinModel, i : Int, v : Double) -> DbindexbrinModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_brin_model_sum(s : DbindexbrinModel) -> Double { @_common.sum(s.data) }

pub fn db_index_brin_model_mean(s : DbindexbrinModel) -> Double { @_common.mean(s.data) }

pub fn db_index_brin_model_scale(s : DbindexbrinModel, f : Double) -> DbindexbrinModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_brin_model_add(a : DbindexbrinModel, b : DbindexbrinModel) -> DbindexbrinModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_brin_model_copy(s : DbindexbrinModel) -> DbindexbrinModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_brin_model_fill(s : DbindexbrinModel, v : Double) -> DbindexbrinModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_brin_model_min(s : DbindexbrinModel) -> Double { @_common.min(s.data) }

pub fn db_index_brin_model_max(s : DbindexbrinModel) -> Double { @_common.max(s.data) }

pub fn db_index_brin_model_to_string(s : DbindexbrinModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_layer_make(size : Int) -> DbindexbrinLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_layer_len(s : DbindexbrinLayer) -> Int { s.size }

pub fn db_index_brin_layer_get(s : DbindexbrinLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_layer_set(s : DbindexbrinLayer, i : Int, v : Double) -> DbindexbrinLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_brin_layer_sum(s : DbindexbrinLayer) -> Double { @_common.sum(s.data) }

pub fn db_index_brin_layer_mean(s : DbindexbrinLayer) -> Double { @_common.mean(s.data) }

pub fn db_index_brin_layer_scale(s : DbindexbrinLayer, f : Double) -> DbindexbrinLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_brin_layer_add(a : DbindexbrinLayer, b : DbindexbrinLayer) -> DbindexbrinLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_brin_layer_copy(s : DbindexbrinLayer) -> DbindexbrinLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_brin_layer_fill(s : DbindexbrinLayer, v : Double) -> DbindexbrinLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_brin_layer_min(s : DbindexbrinLayer) -> Double { @_common.min(s.data) }

pub fn db_index_brin_layer_max(s : DbindexbrinLayer) -> Double { @_common.max(s.data) }

pub fn db_index_brin_layer_to_string(s : DbindexbrinLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_buffer_make(size : Int) -> DbindexbrinBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_buffer_len(s : DbindexbrinBuffer) -> Int { s.size }

pub fn db_index_brin_buffer_get(s : DbindexbrinBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_buffer_set(s : DbindexbrinBuffer, i : Int, v : Double) -> DbindexbrinBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_brin_buffer_sum(s : DbindexbrinBuffer) -> Double { @_common.sum(s.data) }

pub fn db_index_brin_buffer_mean(s : DbindexbrinBuffer) -> Double { @_common.mean(s.data) }

pub fn db_index_brin_buffer_scale(s : DbindexbrinBuffer, f : Double) -> DbindexbrinBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_brin_buffer_add(a : DbindexbrinBuffer, b : DbindexbrinBuffer) -> DbindexbrinBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_brin_buffer_copy(s : DbindexbrinBuffer) -> DbindexbrinBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_brin_buffer_fill(s : DbindexbrinBuffer, v : Double) -> DbindexbrinBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_brin_buffer_min(s : DbindexbrinBuffer) -> Double { @_common.min(s.data) }

pub fn db_index_brin_buffer_max(s : DbindexbrinBuffer) -> Double { @_common.max(s.data) }

pub fn db_index_brin_buffer_to_string(s : DbindexbrinBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_cursor_make(size : Int) -> DbindexbrinCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_cursor_len(s : DbindexbrinCursor) -> Int { s.size }

pub fn db_index_brin_cursor_get(s : DbindexbrinCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_cursor_set(s : DbindexbrinCursor, i : Int, v : Double) -> DbindexbrinCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_brin_cursor_sum(s : DbindexbrinCursor) -> Double { @_common.sum(s.data) }

pub fn db_index_brin_cursor_mean(s : DbindexbrinCursor) -> Double { @_common.mean(s.data) }

pub fn db_index_brin_cursor_scale(s : DbindexbrinCursor, f : Double) -> DbindexbrinCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_brin_cursor_add(a : DbindexbrinCursor, b : DbindexbrinCursor) -> DbindexbrinCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_brin_cursor_copy(s : DbindexbrinCursor) -> DbindexbrinCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_brin_cursor_fill(s : DbindexbrinCursor, v : Double) -> DbindexbrinCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_brin_cursor_min(s : DbindexbrinCursor) -> Double { @_common.min(s.data) }

pub fn db_index_brin_cursor_max(s : DbindexbrinCursor) -> Double { @_common.max(s.data) }

pub fn db_index_brin_cursor_to_string(s : DbindexbrinCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_view_make(size : Int) -> DbindexbrinView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_view_len(s : DbindexbrinView) -> Int { s.size }

pub fn db_index_brin_view_get(s : DbindexbrinView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_view_set(s : DbindexbrinView, i : Int, v : Double) -> DbindexbrinView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_brin_view_sum(s : DbindexbrinView) -> Double { @_common.sum(s.data) }

pub fn db_index_brin_view_mean(s : DbindexbrinView) -> Double { @_common.mean(s.data) }

pub fn db_index_brin_view_scale(s : DbindexbrinView, f : Double) -> DbindexbrinView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_brin_view_add(a : DbindexbrinView, b : DbindexbrinView) -> DbindexbrinView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_brin_view_copy(s : DbindexbrinView) -> DbindexbrinView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_brin_view_fill(s : DbindexbrinView, v : Double) -> DbindexbrinView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_brin_view_min(s : DbindexbrinView) -> Double { @_common.min(s.data) }

pub fn db_index_brin_view_max(s : DbindexbrinView) -> Double { @_common.max(s.data) }

pub fn db_index_brin_view_to_string(s : DbindexbrinView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_range_make(size : Int) -> DbindexbrinRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_range_len(s : DbindexbrinRange) -> Int { s.size }

pub fn db_index_brin_range_get(s : DbindexbrinRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_range_set(s : DbindexbrinRange, i : Int, v : Double) -> DbindexbrinRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_brin_range_sum(s : DbindexbrinRange) -> Double { @_common.sum(s.data) }

pub fn db_index_brin_range_mean(s : DbindexbrinRange) -> Double { @_common.mean(s.data) }

pub fn db_index_brin_range_scale(s : DbindexbrinRange, f : Double) -> DbindexbrinRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_brin_range_add(a : DbindexbrinRange, b : DbindexbrinRange) -> DbindexbrinRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_brin_range_copy(s : DbindexbrinRange) -> DbindexbrinRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_brin_range_fill(s : DbindexbrinRange, v : Double) -> DbindexbrinRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_brin_range_min(s : DbindexbrinRange) -> Double { @_common.min(s.data) }

pub fn db_index_brin_range_max(s : DbindexbrinRange) -> Double { @_common.max(s.data) }

pub fn db_index_brin_range_to_string(s : DbindexbrinRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbrinSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_brin_slice_make(size : Int) -> DbindexbrinSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_brin_slice_len(s : DbindexbrinSlice) -> Int { s.size }

pub fn db_index_brin_slice_get(s : DbindexbrinSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_brin_slice_set(s : DbindexbrinSlice, i : Int, v : Double) -> DbindexbrinSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_brin_slice_sum(s : DbindexbrinSlice) -> Double { @_common.sum(s.data) }

pub fn db_index_brin_slice_mean(s : DbindexbrinSlice) -> Double { @_common.mean(s.data) }

pub fn db_index_brin_slice_scale(s : DbindexbrinSlice, f : Double) -> DbindexbrinSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_brin_slice_add(a : DbindexbrinSlice, b : DbindexbrinSlice) -> DbindexbrinSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_brin_slice_copy(s : DbindexbrinSlice) -> DbindexbrinSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_brin_slice_fill(s : DbindexbrinSlice, v : Double) -> DbindexbrinSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_brin_slice_min(s : DbindexbrinSlice) -> Double { @_common.min(s.data) }

pub fn db_index_brin_slice_max(s : DbindexbrinSlice) -> Double { @_common.max(s.data) }

pub fn db_index_brin_slice_to_string(s : DbindexbrinSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

