///===
/// extcore/db_index_bitmap

pub(all) struct DbindexbitmapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_bitmap_make_point(x : Double, y : Double) -> DbindexbitmapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_bitmap_make_point3(x : Double, y : Double, z : Double) -> DbindexbitmapPoint {
  { x, y, z, label: 0 }
}

pub fn DbindexbitmapPoint::x(self : DbindexbitmapPoint) -> Double { self.x }

pub fn DbindexbitmapPoint::y(self : DbindexbitmapPoint) -> Double { self.y }

pub fn DbindexbitmapPoint::z(self : DbindexbitmapPoint) -> Double { self.z }

pub fn DbindexbitmapPoint::label(self : DbindexbitmapPoint) -> Int { self.label }

pub fn DbindexbitmapPoint::dist(self : DbindexbitmapPoint, other : DbindexbitmapPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbindexbitmapPoint::add(self : DbindexbitmapPoint, other : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbindexbitmapPoint::sub(self : DbindexbitmapPoint, other : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbindexbitmapPoint::scale(self : DbindexbitmapPoint, s : Double) -> DbindexbitmapPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbindexbitmapPoint::dot(self : DbindexbitmapPoint, other : DbindexbitmapPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbindexbitmapPoint::cross(self : DbindexbitmapPoint, other : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbindexbitmapPoint::norm(self : DbindexbitmapPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbindexbitmapPoint::normalize(self : DbindexbitmapPoint) -> DbindexbitmapPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexbitmapPoint::negate(self : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbindexbitmapPoint::mid(self : DbindexbitmapPoint, other : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbindexbitmapPoint::lerp(self : DbindexbitmapPoint, other : DbindexbitmapPoint, t : Double) -> DbindexbitmapPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbindexbitmapPoint::to_string(self : DbindexbitmapPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbindexbitmapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_bitmap_make_series(vals : Array[Double], name : String) -> DbindexbitmapSeries {
  { vals, name, meta: 0 }
}

pub fn DbindexbitmapSeries::len(self : DbindexbitmapSeries) -> Int { self.vals.length() }

pub fn DbindexbitmapSeries::sum(self : DbindexbitmapSeries) -> Double { @_common.sum(self.vals) }

pub fn DbindexbitmapSeries::mean(self : DbindexbitmapSeries) -> Double { @_common.mean(self.vals) }

pub fn DbindexbitmapSeries::min(self : DbindexbitmapSeries) -> Double { @_common.min(self.vals) }

pub fn DbindexbitmapSeries::max(self : DbindexbitmapSeries) -> Double { @_common.max(self.vals) }

pub fn DbindexbitmapSeries::range(self : DbindexbitmapSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbindexbitmapSeries::variance(self : DbindexbitmapSeries) -> Double { @_common.variance(self.vals) }

pub fn DbindexbitmapSeries::std(self : DbindexbitmapSeries) -> Double { @_common.std(self.vals) }

pub fn DbindexbitmapSeries::median(self : DbindexbitmapSeries) -> Double { @_common.median(self.vals) }

pub fn DbindexbitmapSeries::scale(self : DbindexbitmapSeries, f : Double) -> DbindexbitmapSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbindexbitmapSeries::add(self : DbindexbitmapSeries, other : DbindexbitmapSeries) -> DbindexbitmapSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbindexbitmapSeries::sub(self : DbindexbitmapSeries, other : DbindexbitmapSeries) -> DbindexbitmapSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbindexbitmapSeries::normalize(self : DbindexbitmapSeries) -> DbindexbitmapSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbindexbitmapSeries::cumsum(self : DbindexbitmapSeries) -> DbindexbitmapSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbindexbitmapSeries::to_string(self : DbindexbitmapSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexbitmapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_bitmap_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexbitmapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_bitmap_matrix_identity(n : Int) -> DbindexbitmapMatrix {
  let m = db_index_bitmap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbindexbitmapMatrix::get(self : DbindexbitmapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbindexbitmapMatrix::transpose(self : DbindexbitmapMatrix) -> DbindexbitmapMatrix {
  let result = db_index_bitmap_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbindexbitmapMatrix::add(self : DbindexbitmapMatrix, other : DbindexbitmapMatrix) -> DbindexbitmapMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_index_bitmap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbindexbitmapMatrix::scale(self : DbindexbitmapMatrix, s : Double) -> DbindexbitmapMatrix {
  let result = db_index_bitmap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbindexbitmapMatrix::multiply(self : DbindexbitmapMatrix, other : DbindexbitmapMatrix) -> DbindexbitmapMatrix {
  if self.cols != other.rows { return db_index_bitmap_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_index_bitmap_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbindexbitmapMatrix::trace(self : DbindexbitmapMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbindexbitmapMatrix::det(self : DbindexbitmapMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbindexbitmapMatrix::norm(self : DbindexbitmapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbindexbitmapMatrix::to_string(self : DbindexbitmapMatrix) -> String {
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

pub(all) struct DbindexbitmapVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_bitmap_make_vector(comps : Array[Double]) -> DbindexbitmapVector {
  { comps, dim: comps.length() }
}

pub fn db_index_bitmap_vector_zero(dim : Int) -> DbindexbitmapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbindexbitmapVector::add(self : DbindexbitmapVector, other : DbindexbitmapVector) -> DbindexbitmapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexbitmapVector::sub(self : DbindexbitmapVector, other : DbindexbitmapVector) -> DbindexbitmapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbindexbitmapVector::scale(self : DbindexbitmapVector, s : Double) -> DbindexbitmapVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbindexbitmapVector::dot(self : DbindexbitmapVector, other : DbindexbitmapVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbindexbitmapVector::norm(self : DbindexbitmapVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbindexbitmapVector::normalize(self : DbindexbitmapVector) -> DbindexbitmapVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbindexbitmapVector::dist(self : DbindexbitmapVector, other : DbindexbitmapVector) -> Double {
  self.sub(other).norm()
}

pub fn DbindexbitmapVector::to_string(self : DbindexbitmapVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_bitmap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_index_bitmap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_index_bitmap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_index_bitmap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_index_bitmap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_index_bitmap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_index_bitmap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_index_bitmap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_index_bitmap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_index_bitmap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_index_bitmap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_index_bitmap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_index_bitmap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_index_bitmap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_index_bitmap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_index_bitmap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_index_bitmap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_index_bitmap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_index_bitmap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_index_bitmap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_index_bitmap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_index_bitmap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_index_bitmap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_index_bitmap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_index_bitmap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_index_bitmap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_index_bitmap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_index_bitmap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_index_bitmap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbindexbitmapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_frame_make(size : Int) -> DbindexbitmapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_frame_len(s : DbindexbitmapFrame) -> Int { s.size }

pub fn db_index_bitmap_frame_get(s : DbindexbitmapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_frame_set(s : DbindexbitmapFrame, i : Int, v : Double) -> DbindexbitmapFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_frame_sum(s : DbindexbitmapFrame) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_frame_mean(s : DbindexbitmapFrame) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_frame_scale(s : DbindexbitmapFrame, f : Double) -> DbindexbitmapFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_frame_add(a : DbindexbitmapFrame, b : DbindexbitmapFrame) -> DbindexbitmapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_frame_copy(s : DbindexbitmapFrame) -> DbindexbitmapFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_frame_fill(s : DbindexbitmapFrame, v : Double) -> DbindexbitmapFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_frame_min(s : DbindexbitmapFrame) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_frame_max(s : DbindexbitmapFrame) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_frame_to_string(s : DbindexbitmapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_table_make(size : Int) -> DbindexbitmapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_table_len(s : DbindexbitmapTable) -> Int { s.size }

pub fn db_index_bitmap_table_get(s : DbindexbitmapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_table_set(s : DbindexbitmapTable, i : Int, v : Double) -> DbindexbitmapTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_table_sum(s : DbindexbitmapTable) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_table_mean(s : DbindexbitmapTable) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_table_scale(s : DbindexbitmapTable, f : Double) -> DbindexbitmapTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_table_add(a : DbindexbitmapTable, b : DbindexbitmapTable) -> DbindexbitmapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_table_copy(s : DbindexbitmapTable) -> DbindexbitmapTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_table_fill(s : DbindexbitmapTable, v : Double) -> DbindexbitmapTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_table_min(s : DbindexbitmapTable) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_table_max(s : DbindexbitmapTable) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_table_to_string(s : DbindexbitmapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_graphn_make(size : Int) -> DbindexbitmapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_graphn_len(s : DbindexbitmapGraphN) -> Int { s.size }

pub fn db_index_bitmap_graphn_get(s : DbindexbitmapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_graphn_set(s : DbindexbitmapGraphN, i : Int, v : Double) -> DbindexbitmapGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_graphn_sum(s : DbindexbitmapGraphN) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_graphn_mean(s : DbindexbitmapGraphN) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_graphn_scale(s : DbindexbitmapGraphN, f : Double) -> DbindexbitmapGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_graphn_add(a : DbindexbitmapGraphN, b : DbindexbitmapGraphN) -> DbindexbitmapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_graphn_copy(s : DbindexbitmapGraphN) -> DbindexbitmapGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_graphn_fill(s : DbindexbitmapGraphN, v : Double) -> DbindexbitmapGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_graphn_min(s : DbindexbitmapGraphN) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_graphn_max(s : DbindexbitmapGraphN) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_graphn_to_string(s : DbindexbitmapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_node_make(size : Int) -> DbindexbitmapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_node_len(s : DbindexbitmapNode) -> Int { s.size }

pub fn db_index_bitmap_node_get(s : DbindexbitmapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_node_set(s : DbindexbitmapNode, i : Int, v : Double) -> DbindexbitmapNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_node_sum(s : DbindexbitmapNode) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_node_mean(s : DbindexbitmapNode) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_node_scale(s : DbindexbitmapNode, f : Double) -> DbindexbitmapNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_node_add(a : DbindexbitmapNode, b : DbindexbitmapNode) -> DbindexbitmapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_node_copy(s : DbindexbitmapNode) -> DbindexbitmapNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_node_fill(s : DbindexbitmapNode, v : Double) -> DbindexbitmapNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_node_min(s : DbindexbitmapNode) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_node_max(s : DbindexbitmapNode) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_node_to_string(s : DbindexbitmapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_edge_make(size : Int) -> DbindexbitmapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_edge_len(s : DbindexbitmapEdge) -> Int { s.size }

pub fn db_index_bitmap_edge_get(s : DbindexbitmapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_edge_set(s : DbindexbitmapEdge, i : Int, v : Double) -> DbindexbitmapEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_edge_sum(s : DbindexbitmapEdge) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_edge_mean(s : DbindexbitmapEdge) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_edge_scale(s : DbindexbitmapEdge, f : Double) -> DbindexbitmapEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_edge_add(a : DbindexbitmapEdge, b : DbindexbitmapEdge) -> DbindexbitmapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_edge_copy(s : DbindexbitmapEdge) -> DbindexbitmapEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_edge_fill(s : DbindexbitmapEdge, v : Double) -> DbindexbitmapEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_edge_min(s : DbindexbitmapEdge) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_edge_max(s : DbindexbitmapEdge) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_edge_to_string(s : DbindexbitmapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_path_make(size : Int) -> DbindexbitmapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_path_len(s : DbindexbitmapPath) -> Int { s.size }

pub fn db_index_bitmap_path_get(s : DbindexbitmapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_path_set(s : DbindexbitmapPath, i : Int, v : Double) -> DbindexbitmapPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_path_sum(s : DbindexbitmapPath) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_path_mean(s : DbindexbitmapPath) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_path_scale(s : DbindexbitmapPath, f : Double) -> DbindexbitmapPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_path_add(a : DbindexbitmapPath, b : DbindexbitmapPath) -> DbindexbitmapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_path_copy(s : DbindexbitmapPath) -> DbindexbitmapPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_path_fill(s : DbindexbitmapPath, v : Double) -> DbindexbitmapPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_path_min(s : DbindexbitmapPath) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_path_max(s : DbindexbitmapPath) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_path_to_string(s : DbindexbitmapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_cluster_make(size : Int) -> DbindexbitmapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_cluster_len(s : DbindexbitmapCluster) -> Int { s.size }

pub fn db_index_bitmap_cluster_get(s : DbindexbitmapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_cluster_set(s : DbindexbitmapCluster, i : Int, v : Double) -> DbindexbitmapCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_cluster_sum(s : DbindexbitmapCluster) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_cluster_mean(s : DbindexbitmapCluster) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_cluster_scale(s : DbindexbitmapCluster, f : Double) -> DbindexbitmapCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_cluster_add(a : DbindexbitmapCluster, b : DbindexbitmapCluster) -> DbindexbitmapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_cluster_copy(s : DbindexbitmapCluster) -> DbindexbitmapCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_cluster_fill(s : DbindexbitmapCluster, v : Double) -> DbindexbitmapCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_cluster_min(s : DbindexbitmapCluster) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_cluster_max(s : DbindexbitmapCluster) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_cluster_to_string(s : DbindexbitmapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_model_make(size : Int) -> DbindexbitmapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_model_len(s : DbindexbitmapModel) -> Int { s.size }

pub fn db_index_bitmap_model_get(s : DbindexbitmapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_model_set(s : DbindexbitmapModel, i : Int, v : Double) -> DbindexbitmapModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_model_sum(s : DbindexbitmapModel) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_model_mean(s : DbindexbitmapModel) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_model_scale(s : DbindexbitmapModel, f : Double) -> DbindexbitmapModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_model_add(a : DbindexbitmapModel, b : DbindexbitmapModel) -> DbindexbitmapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_model_copy(s : DbindexbitmapModel) -> DbindexbitmapModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_model_fill(s : DbindexbitmapModel, v : Double) -> DbindexbitmapModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_model_min(s : DbindexbitmapModel) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_model_max(s : DbindexbitmapModel) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_model_to_string(s : DbindexbitmapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_layer_make(size : Int) -> DbindexbitmapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_layer_len(s : DbindexbitmapLayer) -> Int { s.size }

pub fn db_index_bitmap_layer_get(s : DbindexbitmapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_layer_set(s : DbindexbitmapLayer, i : Int, v : Double) -> DbindexbitmapLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_layer_sum(s : DbindexbitmapLayer) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_layer_mean(s : DbindexbitmapLayer) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_layer_scale(s : DbindexbitmapLayer, f : Double) -> DbindexbitmapLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_layer_add(a : DbindexbitmapLayer, b : DbindexbitmapLayer) -> DbindexbitmapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_layer_copy(s : DbindexbitmapLayer) -> DbindexbitmapLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_layer_fill(s : DbindexbitmapLayer, v : Double) -> DbindexbitmapLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_layer_min(s : DbindexbitmapLayer) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_layer_max(s : DbindexbitmapLayer) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_layer_to_string(s : DbindexbitmapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_buffer_make(size : Int) -> DbindexbitmapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_buffer_len(s : DbindexbitmapBuffer) -> Int { s.size }

pub fn db_index_bitmap_buffer_get(s : DbindexbitmapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_buffer_set(s : DbindexbitmapBuffer, i : Int, v : Double) -> DbindexbitmapBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_buffer_sum(s : DbindexbitmapBuffer) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_buffer_mean(s : DbindexbitmapBuffer) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_buffer_scale(s : DbindexbitmapBuffer, f : Double) -> DbindexbitmapBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_buffer_add(a : DbindexbitmapBuffer, b : DbindexbitmapBuffer) -> DbindexbitmapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_buffer_copy(s : DbindexbitmapBuffer) -> DbindexbitmapBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_buffer_fill(s : DbindexbitmapBuffer, v : Double) -> DbindexbitmapBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_buffer_min(s : DbindexbitmapBuffer) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_buffer_max(s : DbindexbitmapBuffer) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_buffer_to_string(s : DbindexbitmapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_cursor_make(size : Int) -> DbindexbitmapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_cursor_len(s : DbindexbitmapCursor) -> Int { s.size }

pub fn db_index_bitmap_cursor_get(s : DbindexbitmapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_cursor_set(s : DbindexbitmapCursor, i : Int, v : Double) -> DbindexbitmapCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_cursor_sum(s : DbindexbitmapCursor) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_cursor_mean(s : DbindexbitmapCursor) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_cursor_scale(s : DbindexbitmapCursor, f : Double) -> DbindexbitmapCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_cursor_add(a : DbindexbitmapCursor, b : DbindexbitmapCursor) -> DbindexbitmapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_cursor_copy(s : DbindexbitmapCursor) -> DbindexbitmapCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_cursor_fill(s : DbindexbitmapCursor, v : Double) -> DbindexbitmapCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_cursor_min(s : DbindexbitmapCursor) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_cursor_max(s : DbindexbitmapCursor) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_cursor_to_string(s : DbindexbitmapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_view_make(size : Int) -> DbindexbitmapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_view_len(s : DbindexbitmapView) -> Int { s.size }

pub fn db_index_bitmap_view_get(s : DbindexbitmapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_view_set(s : DbindexbitmapView, i : Int, v : Double) -> DbindexbitmapView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_view_sum(s : DbindexbitmapView) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_view_mean(s : DbindexbitmapView) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_view_scale(s : DbindexbitmapView, f : Double) -> DbindexbitmapView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_view_add(a : DbindexbitmapView, b : DbindexbitmapView) -> DbindexbitmapView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_view_copy(s : DbindexbitmapView) -> DbindexbitmapView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_view_fill(s : DbindexbitmapView, v : Double) -> DbindexbitmapView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_view_min(s : DbindexbitmapView) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_view_max(s : DbindexbitmapView) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_view_to_string(s : DbindexbitmapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_range_make(size : Int) -> DbindexbitmapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_range_len(s : DbindexbitmapRange) -> Int { s.size }

pub fn db_index_bitmap_range_get(s : DbindexbitmapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_range_set(s : DbindexbitmapRange, i : Int, v : Double) -> DbindexbitmapRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_range_sum(s : DbindexbitmapRange) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_range_mean(s : DbindexbitmapRange) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_range_scale(s : DbindexbitmapRange, f : Double) -> DbindexbitmapRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_range_add(a : DbindexbitmapRange, b : DbindexbitmapRange) -> DbindexbitmapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_range_copy(s : DbindexbitmapRange) -> DbindexbitmapRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_range_fill(s : DbindexbitmapRange, v : Double) -> DbindexbitmapRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_range_min(s : DbindexbitmapRange) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_range_max(s : DbindexbitmapRange) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_range_to_string(s : DbindexbitmapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_slice_make(size : Int) -> DbindexbitmapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_slice_len(s : DbindexbitmapSlice) -> Int { s.size }

pub fn db_index_bitmap_slice_get(s : DbindexbitmapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_slice_set(s : DbindexbitmapSlice, i : Int, v : Double) -> DbindexbitmapSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_slice_sum(s : DbindexbitmapSlice) -> Double { @_common.sum(s.data) }

pub fn db_index_bitmap_slice_mean(s : DbindexbitmapSlice) -> Double { @_common.mean(s.data) }

pub fn db_index_bitmap_slice_scale(s : DbindexbitmapSlice, f : Double) -> DbindexbitmapSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_slice_add(a : DbindexbitmapSlice, b : DbindexbitmapSlice) -> DbindexbitmapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn db_index_bitmap_slice_copy(s : DbindexbitmapSlice) -> DbindexbitmapSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_slice_fill(s : DbindexbitmapSlice, v : Double) -> DbindexbitmapSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn db_index_bitmap_slice_min(s : DbindexbitmapSlice) -> Double { @_common.min(s.data) }

pub fn db_index_bitmap_slice_max(s : DbindexbitmapSlice) -> Double { @_common.max(s.data) }

pub fn db_index_bitmap_slice_to_string(s : DbindexbitmapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

