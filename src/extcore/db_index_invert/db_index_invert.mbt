///===
/// extcore/db_index_invert

pub(all) struct DbindexinvertPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_invert_make_point(x : Double, y : Double) -> DbindexinvertPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_invert_make_point3(x : Double, y : Double, z : Double) -> DbindexinvertPoint {
  { x, y, z, label: 0 }
}

pub fn DbindexinvertPoint::x(self : DbindexinvertPoint) -> Double { self.x }

pub fn DbindexinvertPoint::y(self : DbindexinvertPoint) -> Double { self.y }

pub fn DbindexinvertPoint::z(self : DbindexinvertPoint) -> Double { self.z }

pub fn DbindexinvertPoint::label(self : DbindexinvertPoint) -> Int { self.label }

pub fn DbindexinvertPoint::dist(self : DbindexinvertPoint, other : DbindexinvertPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexinvertPoint::add(self : DbindexinvertPoint, other : DbindexinvertPoint) -> DbindexinvertPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexinvertPoint::sub(self : DbindexinvertPoint, other : DbindexinvertPoint) -> DbindexinvertPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexinvertPoint::scale(self : DbindexinvertPoint, s : Double) -> DbindexinvertPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexinvertPoint::dot(self : DbindexinvertPoint, other : DbindexinvertPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexinvertPoint::cross(self : DbindexinvertPoint, other : DbindexinvertPoint) -> DbindexinvertPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexinvertPoint::norm(self : DbindexinvertPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexinvertPoint::normalize(self : DbindexinvertPoint) -> DbindexinvertPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexinvertPoint::negate(self : DbindexinvertPoint) -> DbindexinvertPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexinvertPoint::mid(self : DbindexinvertPoint, other : DbindexinvertPoint) -> DbindexinvertPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexinvertPoint::lerp(self : DbindexinvertPoint, other : DbindexinvertPoint, t : Double) -> DbindexinvertPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexinvertPoint::to_string(self : DbindexinvertPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexinvertSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_invert_make_series(vals : Array[Double], name : String) -> DbindexinvertSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexinvertSeries::len(self : DbindexinvertSeries) -> Int { self.vals.length() }

pub fn DbindexinvertSeries::sum(self : DbindexinvertSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexinvertSeries::mean(self : DbindexinvertSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexinvertSeries::min(self : DbindexinvertSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexinvertSeries::max(self : DbindexinvertSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexinvertSeries::range(self : DbindexinvertSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexinvertSeries::variance(self : DbindexinvertSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexinvertSeries::std(self : DbindexinvertSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexinvertSeries::median(self : DbindexinvertSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexinvertSeries::scale(self : DbindexinvertSeries, f : Double) -> DbindexinvertSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexinvertSeries::add(self : DbindexinvertSeries, other : DbindexinvertSeries) -> DbindexinvertSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexinvertSeries::sub(self : DbindexinvertSeries, other : DbindexinvertSeries) -> DbindexinvertSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexinvertSeries::normalize(self : DbindexinvertSeries) -> DbindexinvertSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexinvertSeries::cumsum(self : DbindexinvertSeries) -> DbindexinvertSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexinvertSeries::to_string(self : DbindexinvertSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexinvertMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_invert_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexinvertMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_invert_matrix_identity(n : Int) -> DbindexinvertMatrix {
  let m = db_index_invert_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexinvertMatrix::get(self : DbindexinvertMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexinvertMatrix::transpose(self : DbindexinvertMatrix) -> DbindexinvertMatrix {
  let result = db_index_invert_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexinvertMatrix::add(self : DbindexinvertMatrix, other : DbindexinvertMatrix) -> DbindexinvertMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_invert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexinvertMatrix::scale(self : DbindexinvertMatrix, s : Double) -> DbindexinvertMatrix {
  let result = db_index_invert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexinvertMatrix::multiply(self : DbindexinvertMatrix, other : DbindexinvertMatrix) -> DbindexinvertMatrix {
  if self.cols != other.rows { return db_index_invert_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_invert_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbindexinvertMatrix::trace(self : DbindexinvertMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexinvertMatrix::det(self : DbindexinvertMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexinvertMatrix::norm(self : DbindexinvertMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexinvertMatrix::to_string(self : DbindexinvertMatrix) -> String {
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

pub(all) struct DbindexinvertVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_invert_make_vector(comps : Array[Double]) -> DbindexinvertVector {
  { comps, dim: comps.length() }
}

pub fn db_index_invert_vector_zero(dim : Int) -> DbindexinvertVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexinvertVector::add(self : DbindexinvertVector, other : DbindexinvertVector) -> DbindexinvertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexinvertVector::sub(self : DbindexinvertVector, other : DbindexinvertVector) -> DbindexinvertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexinvertVector::scale(self : DbindexinvertVector, s : Double) -> DbindexinvertVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexinvertVector::dot(self : DbindexinvertVector, other : DbindexinvertVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexinvertVector::norm(self : DbindexinvertVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexinvertVector::normalize(self : DbindexinvertVector) -> DbindexinvertVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexinvertVector::dist(self : DbindexinvertVector, other : DbindexinvertVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexinvertVector::to_string(self : DbindexinvertVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_invert_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_index_invert_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_index_invert_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_index_invert_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_index_invert_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_index_invert_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_index_invert_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_index_invert_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_index_invert_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_index_invert_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_index_invert_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_index_invert_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_index_invert_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_index_invert_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_index_invert_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_index_invert_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_index_invert_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_index_invert_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_index_invert_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_index_invert_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_index_invert_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_index_invert_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_index_invert_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_index_invert_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_index_invert_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_index_invert_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_index_invert_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_index_invert_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_index_invert_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbindexinvertFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_frame_make(size : Int) -> DbindexinvertFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_invert_frame_len(s : DbindexinvertFrame) -> Int { s.size }

pub fn db_index_invert_frame_get(s : DbindexinvertFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_invert_frame_set(s : DbindexinvertFrame, i : Int, v : Double) -> DbindexinvertFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_invert_frame_sum(s : DbindexinvertFrame) -> Double { @_common.sum(s.data) }

pub fn db_index_invert_frame_mean(s : DbindexinvertFrame) -> Double { @_common.mean(s.data) }

pub fn db_index_invert_frame_scale(s : DbindexinvertFrame, f : Double) -> DbindexinvertFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_invert_frame_add(a : DbindexinvertFrame, b : DbindexinvertFrame) -> DbindexinvertFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_invert_frame_copy(s : DbindexinvertFrame) -> DbindexinvertFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_invert_frame_fill(s : DbindexinvertFrame, v : Double) -> DbindexinvertFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_invert_frame_min(s : DbindexinvertFrame) -> Double { @_common.min(s.data) }

pub fn db_index_invert_frame_max(s : DbindexinvertFrame) -> Double { @_common.max(s.data) }

pub fn db_index_invert_frame_to_string(s : DbindexinvertFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexinvertTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_table_make(size : Int) -> DbindexinvertTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_invert_table_len(s : DbindexinvertTable) -> Int { s.size }

pub fn db_index_invert_table_get(s : DbindexinvertTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_invert_table_set(s : DbindexinvertTable, i : Int, v : Double) -> DbindexinvertTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_invert_table_sum(s : DbindexinvertTable) -> Double { @_common.sum(s.data) }

pub fn db_index_invert_table_mean(s : DbindexinvertTable) -> Double { @_common.mean(s.data) }

pub fn db_index_invert_table_scale(s : DbindexinvertTable, f : Double) -> DbindexinvertTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_invert_table_add(a : DbindexinvertTable, b : DbindexinvertTable) -> DbindexinvertTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_invert_table_copy(s : DbindexinvertTable) -> DbindexinvertTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_invert_table_fill(s : DbindexinvertTable, v : Double) -> DbindexinvertTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_invert_table_min(s : DbindexinvertTable) -> Double { @_common.min(s.data) }

pub fn db_index_invert_table_max(s : DbindexinvertTable) -> Double { @_common.max(s.data) }

pub fn db_index_invert_table_to_string(s : DbindexinvertTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexinvertGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_graphn_make(size : Int) -> DbindexinvertGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_invert_graphn_len(s : DbindexinvertGraphN) -> Int { s.size }

pub fn db_index_invert_graphn_get(s : DbindexinvertGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_invert_graphn_set(s : DbindexinvertGraphN, i : Int, v : Double) -> DbindexinvertGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_invert_graphn_sum(s : DbindexinvertGraphN) -> Double { @_common.sum(s.data) }

pub fn db_index_invert_graphn_mean(s : DbindexinvertGraphN) -> Double { @_common.mean(s.data) }

pub fn db_index_invert_graphn_scale(s : DbindexinvertGraphN, f : Double) -> DbindexinvertGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_invert_graphn_add(a : DbindexinvertGraphN, b : DbindexinvertGraphN) -> DbindexinvertGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_invert_graphn_copy(s : DbindexinvertGraphN) -> DbindexinvertGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_invert_graphn_fill(s : DbindexinvertGraphN, v : Double) -> DbindexinvertGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_invert_graphn_min(s : DbindexinvertGraphN) -> Double { @_common.min(s.data) }

pub fn db_index_invert_graphn_max(s : DbindexinvertGraphN) -> Double { @_common.max(s.data) }

pub fn db_index_invert_graphn_to_string(s : DbindexinvertGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexinvertNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_node_make(size : Int) -> DbindexinvertNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_invert_node_len(s : DbindexinvertNode) -> Int { s.size }

pub fn db_index_invert_node_get(s : DbindexinvertNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_invert_node_set(s : DbindexinvertNode, i : Int, v : Double) -> DbindexinvertNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_invert_node_sum(s : DbindexinvertNode) -> Double { @_common.sum(s.data) }

pub fn db_index_invert_node_mean(s : DbindexinvertNode) -> Double { @_common.mean(s.data) }

pub fn db_index_invert_node_scale(s : DbindexinvertNode, f : Double) -> DbindexinvertNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_invert_node_add(a : DbindexinvertNode, b : DbindexinvertNode) -> DbindexinvertNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_invert_node_copy(s : DbindexinvertNode) -> DbindexinvertNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_invert_node_fill(s : DbindexinvertNode, v : Double) -> DbindexinvertNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_invert_node_min(s : DbindexinvertNode) -> Double { @_common.min(s.data) }

pub fn db_index_invert_node_max(s : DbindexinvertNode) -> Double { @_common.max(s.data) }

pub fn db_index_invert_node_to_string(s : DbindexinvertNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexinvertEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_edge_make(size : Int) -> DbindexinvertEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_invert_edge_len(s : DbindexinvertEdge) -> Int { s.size }

pub fn db_index_invert_edge_get(s : DbindexinvertEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_invert_edge_set(s : DbindexinvertEdge, i : Int, v : Double) -> DbindexinvertEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_invert_edge_sum(s : DbindexinvertEdge) -> Double { @_common.sum(s.data) }

pub fn db_index_invert_edge_mean(s : DbindexinvertEdge) -> Double { @_common.mean(s.data) }

pub fn db_index_invert_edge_scale(s : DbindexinvertEdge, f : Double) -> DbindexinvertEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_invert_edge_add(a : DbindexinvertEdge, b : DbindexinvertEdge) -> DbindexinvertEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_invert_edge_copy(s : DbindexinvertEdge) -> DbindexinvertEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_invert_edge_fill(s : DbindexinvertEdge, v : Double) -> DbindexinvertEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_invert_edge_min(s : DbindexinvertEdge) -> Double { @_common.min(s.data) }

pub fn db_index_invert_edge_max(s : DbindexinvertEdge) -> Double { @_common.max(s.data) }

pub fn db_index_invert_edge_to_string(s : DbindexinvertEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexinvertPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_path_make(size : Int) -> DbindexinvertPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_invert_path_len(s : DbindexinvertPath) -> Int { s.size }

pub fn db_index_invert_path_get(s : DbindexinvertPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_invert_path_set(s : DbindexinvertPath, i : Int, v : Double) -> DbindexinvertPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_invert_path_sum(s : DbindexinvertPath) -> Double { @_common.sum(s.data) }

pub fn db_index_invert_path_mean(s : DbindexinvertPath) -> Double { @_common.mean(s.data) }

pub fn db_index_invert_path_scale(s : DbindexinvertPath, f : Double) -> DbindexinvertPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_invert_path_add(a : DbindexinvertPath, b : DbindexinvertPath) -> DbindexinvertPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_invert_path_copy(s : DbindexinvertPath) -> DbindexinvertPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_invert_path_fill(s : DbindexinvertPath, v : Double) -> DbindexinvertPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_invert_path_min(s : DbindexinvertPath) -> Double { @_common.min(s.data) }

pub fn db_index_invert_path_max(s : DbindexinvertPath) -> Double { @_common.max(s.data) }

pub fn db_index_invert_path_to_string(s : DbindexinvertPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexinvertCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_cluster_make(size : Int) -> DbindexinvertCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_invert_cluster_len(s : DbindexinvertCluster) -> Int { s.size }

pub fn db_index_invert_cluster_get(s : DbindexinvertCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_invert_cluster_set(s : DbindexinvertCluster, i : Int, v : Double) -> DbindexinvertCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_invert_cluster_sum(s : DbindexinvertCluster) -> Double { @_common.sum(s.data) }

pub fn db_index_invert_cluster_mean(s : DbindexinvertCluster) -> Double { @_common.mean(s.data) }

pub fn db_index_invert_cluster_scale(s : DbindexinvertCluster, f : Double) -> DbindexinvertCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_invert_cluster_add(a : DbindexinvertCluster, b : DbindexinvertCluster) -> DbindexinvertCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_invert_cluster_copy(s : DbindexinvertCluster) -> DbindexinvertCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_invert_cluster_fill(s : DbindexinvertCluster, v : Double) -> DbindexinvertCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_invert_cluster_min(s : DbindexinvertCluster) -> Double { @_common.min(s.data) }

pub fn db_index_invert_cluster_max(s : DbindexinvertCluster) -> Double { @_common.max(s.data) }

pub fn db_index_invert_cluster_to_string(s : DbindexinvertCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexinvertModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_model_make(size : Int) -> DbindexinvertModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_invert_model_len(s : DbindexinvertModel) -> Int { s.size }

pub fn db_index_invert_model_get(s : DbindexinvertModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_invert_model_set(s : DbindexinvertModel, i : Int, v : Double) -> DbindexinvertModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_invert_model_sum(s : DbindexinvertModel) -> Double { @_common.sum(s.data) }

pub fn db_index_invert_model_mean(s : DbindexinvertModel) -> Double { @_common.mean(s.data) }

pub fn db_index_invert_model_scale(s : DbindexinvertModel, f : Double) -> DbindexinvertModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_invert_model_add(a : DbindexinvertModel, b : DbindexinvertModel) -> DbindexinvertModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_invert_model_copy(s : DbindexinvertModel) -> DbindexinvertModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_invert_model_fill(s : DbindexinvertModel, v : Double) -> DbindexinvertModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_invert_model_min(s : DbindexinvertModel) -> Double { @_common.min(s.data) }

pub fn db_index_invert_model_max(s : DbindexinvertModel) -> Double { @_common.max(s.data) }

pub fn db_index_invert_model_to_string(s : DbindexinvertModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexinvertLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_layer_make(size : Int) -> DbindexinvertLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_invert_layer_len(s : DbindexinvertLayer) -> Int { s.size }

pub fn db_index_invert_layer_get(s : DbindexinvertLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_invert_layer_set(s : DbindexinvertLayer, i : Int, v : Double) -> DbindexinvertLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_invert_layer_sum(s : DbindexinvertLayer) -> Double { @_common.sum(s.data) }

pub fn db_index_invert_layer_mean(s : DbindexinvertLayer) -> Double { @_common.mean(s.data) }

pub fn db_index_invert_layer_scale(s : DbindexinvertLayer, f : Double) -> DbindexinvertLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_invert_layer_add(a : DbindexinvertLayer, b : DbindexinvertLayer) -> DbindexinvertLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_invert_layer_copy(s : DbindexinvertLayer) -> DbindexinvertLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_invert_layer_fill(s : DbindexinvertLayer, v : Double) -> DbindexinvertLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_invert_layer_min(s : DbindexinvertLayer) -> Double { @_common.min(s.data) }

pub fn db_index_invert_layer_max(s : DbindexinvertLayer) -> Double { @_common.max(s.data) }

pub fn db_index_invert_layer_to_string(s : DbindexinvertLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexinvertBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_buffer_make(size : Int) -> DbindexinvertBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_invert_buffer_len(s : DbindexinvertBuffer) -> Int { s.size }

pub fn db_index_invert_buffer_get(s : DbindexinvertBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_invert_buffer_set(s : DbindexinvertBuffer, i : Int, v : Double) -> DbindexinvertBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_invert_buffer_sum(s : DbindexinvertBuffer) -> Double { @_common.sum(s.data) }

pub fn db_index_invert_buffer_mean(s : DbindexinvertBuffer) -> Double { @_common.mean(s.data) }

pub fn db_index_invert_buffer_scale(s : DbindexinvertBuffer, f : Double) -> DbindexinvertBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_invert_buffer_add(a : DbindexinvertBuffer, b : DbindexinvertBuffer) -> DbindexinvertBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_invert_buffer_copy(s : DbindexinvertBuffer) -> DbindexinvertBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_invert_buffer_fill(s : DbindexinvertBuffer, v : Double) -> DbindexinvertBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_invert_buffer_min(s : DbindexinvertBuffer) -> Double { @_common.min(s.data) }

pub fn db_index_invert_buffer_max(s : DbindexinvertBuffer) -> Double { @_common.max(s.data) }

pub fn db_index_invert_buffer_to_string(s : DbindexinvertBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexinvertCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_cursor_make(size : Int) -> DbindexinvertCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_invert_cursor_len(s : DbindexinvertCursor) -> Int { s.size }

pub fn db_index_invert_cursor_get(s : DbindexinvertCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_invert_cursor_set(s : DbindexinvertCursor, i : Int, v : Double) -> DbindexinvertCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_invert_cursor_sum(s : DbindexinvertCursor) -> Double { @_common.sum(s.data) }

pub fn db_index_invert_cursor_mean(s : DbindexinvertCursor) -> Double { @_common.mean(s.data) }

pub fn db_index_invert_cursor_scale(s : DbindexinvertCursor, f : Double) -> DbindexinvertCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_invert_cursor_add(a : DbindexinvertCursor, b : DbindexinvertCursor) -> DbindexinvertCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_invert_cursor_copy(s : DbindexinvertCursor) -> DbindexinvertCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_invert_cursor_fill(s : DbindexinvertCursor, v : Double) -> DbindexinvertCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_invert_cursor_min(s : DbindexinvertCursor) -> Double { @_common.min(s.data) }

pub fn db_index_invert_cursor_max(s : DbindexinvertCursor) -> Double { @_common.max(s.data) }

pub fn db_index_invert_cursor_to_string(s : DbindexinvertCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexinvertView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_view_make(size : Int) -> DbindexinvertView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_invert_view_len(s : DbindexinvertView) -> Int { s.size }

pub fn db_index_invert_view_get(s : DbindexinvertView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_invert_view_set(s : DbindexinvertView, i : Int, v : Double) -> DbindexinvertView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_invert_view_sum(s : DbindexinvertView) -> Double { @_common.sum(s.data) }

pub fn db_index_invert_view_mean(s : DbindexinvertView) -> Double { @_common.mean(s.data) }

pub fn db_index_invert_view_scale(s : DbindexinvertView, f : Double) -> DbindexinvertView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_invert_view_add(a : DbindexinvertView, b : DbindexinvertView) -> DbindexinvertView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_invert_view_copy(s : DbindexinvertView) -> DbindexinvertView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_invert_view_fill(s : DbindexinvertView, v : Double) -> DbindexinvertView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_invert_view_min(s : DbindexinvertView) -> Double { @_common.min(s.data) }

pub fn db_index_invert_view_max(s : DbindexinvertView) -> Double { @_common.max(s.data) }

pub fn db_index_invert_view_to_string(s : DbindexinvertView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexinvertRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_range_make(size : Int) -> DbindexinvertRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_invert_range_len(s : DbindexinvertRange) -> Int { s.size }

pub fn db_index_invert_range_get(s : DbindexinvertRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_invert_range_set(s : DbindexinvertRange, i : Int, v : Double) -> DbindexinvertRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_invert_range_sum(s : DbindexinvertRange) -> Double { @_common.sum(s.data) }

pub fn db_index_invert_range_mean(s : DbindexinvertRange) -> Double { @_common.mean(s.data) }

pub fn db_index_invert_range_scale(s : DbindexinvertRange, f : Double) -> DbindexinvertRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_invert_range_add(a : DbindexinvertRange, b : DbindexinvertRange) -> DbindexinvertRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_invert_range_copy(s : DbindexinvertRange) -> DbindexinvertRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_invert_range_fill(s : DbindexinvertRange, v : Double) -> DbindexinvertRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_invert_range_min(s : DbindexinvertRange) -> Double { @_common.min(s.data) }

pub fn db_index_invert_range_max(s : DbindexinvertRange) -> Double { @_common.max(s.data) }

pub fn db_index_invert_range_to_string(s : DbindexinvertRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexinvertSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_invert_slice_make(size : Int) -> DbindexinvertSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_invert_slice_len(s : DbindexinvertSlice) -> Int { s.size }

pub fn db_index_invert_slice_get(s : DbindexinvertSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_invert_slice_set(s : DbindexinvertSlice, i : Int, v : Double) -> DbindexinvertSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_invert_slice_sum(s : DbindexinvertSlice) -> Double { @_common.sum(s.data) }

pub fn db_index_invert_slice_mean(s : DbindexinvertSlice) -> Double { @_common.mean(s.data) }

pub fn db_index_invert_slice_scale(s : DbindexinvertSlice, f : Double) -> DbindexinvertSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_invert_slice_add(a : DbindexinvertSlice, b : DbindexinvertSlice) -> DbindexinvertSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_invert_slice_copy(s : DbindexinvertSlice) -> DbindexinvertSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_invert_slice_fill(s : DbindexinvertSlice, v : Double) -> DbindexinvertSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_invert_slice_min(s : DbindexinvertSlice) -> Double { @_common.min(s.data) }

pub fn db_index_invert_slice_max(s : DbindexinvertSlice) -> Double { @_common.max(s.data) }

pub fn db_index_invert_slice_to_string(s : DbindexinvertSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

