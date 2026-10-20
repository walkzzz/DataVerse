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

pub fn DbindexbitmapFrame::len(self : DbindexbitmapFrame) -> Int { self.size }

pub fn DbindexbitmapFrame::get(self : DbindexbitmapFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbitmapFrame::set(self : DbindexbitmapFrame, i : Int, v : Double) -> DbindexbitmapFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbitmapFrame::sum(self : DbindexbitmapFrame) -> Double { @_common.sum(self.data) }

pub fn DbindexbitmapFrame::mean(self : DbindexbitmapFrame) -> Double { @_common.mean(self.data) }

pub fn DbindexbitmapFrame::scale(self : DbindexbitmapFrame, f : Double) -> DbindexbitmapFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapFrame::add(self : DbindexbitmapFrame, other : DbindexbitmapFrame) -> DbindexbitmapFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbitmapFrame::copy(self : DbindexbitmapFrame) -> DbindexbitmapFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapFrame::fill(self : DbindexbitmapFrame, v : Double) -> DbindexbitmapFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapFrame::min(self : DbindexbitmapFrame) -> Double { @_common.min(self.data) }

pub fn DbindexbitmapFrame::max(self : DbindexbitmapFrame) -> Double { @_common.max(self.data) }

pub fn DbindexbitmapFrame::to_string(self : DbindexbitmapFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_table_make(size : Int) -> DbindexbitmapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbitmapTable::len(self : DbindexbitmapTable) -> Int { self.size }

pub fn DbindexbitmapTable::get(self : DbindexbitmapTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbitmapTable::set(self : DbindexbitmapTable, i : Int, v : Double) -> DbindexbitmapTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbitmapTable::sum(self : DbindexbitmapTable) -> Double { @_common.sum(self.data) }

pub fn DbindexbitmapTable::mean(self : DbindexbitmapTable) -> Double { @_common.mean(self.data) }

pub fn DbindexbitmapTable::scale(self : DbindexbitmapTable, f : Double) -> DbindexbitmapTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapTable::add(self : DbindexbitmapTable, other : DbindexbitmapTable) -> DbindexbitmapTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbitmapTable::copy(self : DbindexbitmapTable) -> DbindexbitmapTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapTable::fill(self : DbindexbitmapTable, v : Double) -> DbindexbitmapTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapTable::min(self : DbindexbitmapTable) -> Double { @_common.min(self.data) }

pub fn DbindexbitmapTable::max(self : DbindexbitmapTable) -> Double { @_common.max(self.data) }

pub fn DbindexbitmapTable::to_string(self : DbindexbitmapTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_graphn_make(size : Int) -> DbindexbitmapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbitmapGraphN::len(self : DbindexbitmapGraphN) -> Int { self.size }

pub fn DbindexbitmapGraphN::get(self : DbindexbitmapGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbitmapGraphN::set(self : DbindexbitmapGraphN, i : Int, v : Double) -> DbindexbitmapGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbitmapGraphN::sum(self : DbindexbitmapGraphN) -> Double { @_common.sum(self.data) }

pub fn DbindexbitmapGraphN::mean(self : DbindexbitmapGraphN) -> Double { @_common.mean(self.data) }

pub fn DbindexbitmapGraphN::scale(self : DbindexbitmapGraphN, f : Double) -> DbindexbitmapGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapGraphN::add(self : DbindexbitmapGraphN, other : DbindexbitmapGraphN) -> DbindexbitmapGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbitmapGraphN::copy(self : DbindexbitmapGraphN) -> DbindexbitmapGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapGraphN::fill(self : DbindexbitmapGraphN, v : Double) -> DbindexbitmapGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapGraphN::min(self : DbindexbitmapGraphN) -> Double { @_common.min(self.data) }

pub fn DbindexbitmapGraphN::max(self : DbindexbitmapGraphN) -> Double { @_common.max(self.data) }

pub fn DbindexbitmapGraphN::to_string(self : DbindexbitmapGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_node_make(size : Int) -> DbindexbitmapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbitmapNode::len(self : DbindexbitmapNode) -> Int { self.size }

pub fn DbindexbitmapNode::get(self : DbindexbitmapNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbitmapNode::set(self : DbindexbitmapNode, i : Int, v : Double) -> DbindexbitmapNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbitmapNode::sum(self : DbindexbitmapNode) -> Double { @_common.sum(self.data) }

pub fn DbindexbitmapNode::mean(self : DbindexbitmapNode) -> Double { @_common.mean(self.data) }

pub fn DbindexbitmapNode::scale(self : DbindexbitmapNode, f : Double) -> DbindexbitmapNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapNode::add(self : DbindexbitmapNode, other : DbindexbitmapNode) -> DbindexbitmapNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbitmapNode::copy(self : DbindexbitmapNode) -> DbindexbitmapNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapNode::fill(self : DbindexbitmapNode, v : Double) -> DbindexbitmapNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapNode::min(self : DbindexbitmapNode) -> Double { @_common.min(self.data) }

pub fn DbindexbitmapNode::max(self : DbindexbitmapNode) -> Double { @_common.max(self.data) }

pub fn DbindexbitmapNode::to_string(self : DbindexbitmapNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_edge_make(size : Int) -> DbindexbitmapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbitmapEdge::len(self : DbindexbitmapEdge) -> Int { self.size }

pub fn DbindexbitmapEdge::get(self : DbindexbitmapEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbitmapEdge::set(self : DbindexbitmapEdge, i : Int, v : Double) -> DbindexbitmapEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbitmapEdge::sum(self : DbindexbitmapEdge) -> Double { @_common.sum(self.data) }

pub fn DbindexbitmapEdge::mean(self : DbindexbitmapEdge) -> Double { @_common.mean(self.data) }

pub fn DbindexbitmapEdge::scale(self : DbindexbitmapEdge, f : Double) -> DbindexbitmapEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapEdge::add(self : DbindexbitmapEdge, other : DbindexbitmapEdge) -> DbindexbitmapEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbitmapEdge::copy(self : DbindexbitmapEdge) -> DbindexbitmapEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapEdge::fill(self : DbindexbitmapEdge, v : Double) -> DbindexbitmapEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapEdge::min(self : DbindexbitmapEdge) -> Double { @_common.min(self.data) }

pub fn DbindexbitmapEdge::max(self : DbindexbitmapEdge) -> Double { @_common.max(self.data) }

pub fn DbindexbitmapEdge::to_string(self : DbindexbitmapEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_path_make(size : Int) -> DbindexbitmapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbitmapPath::len(self : DbindexbitmapPath) -> Int { self.size }

pub fn DbindexbitmapPath::get(self : DbindexbitmapPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbitmapPath::set(self : DbindexbitmapPath, i : Int, v : Double) -> DbindexbitmapPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbitmapPath::sum(self : DbindexbitmapPath) -> Double { @_common.sum(self.data) }

pub fn DbindexbitmapPath::mean(self : DbindexbitmapPath) -> Double { @_common.mean(self.data) }

pub fn DbindexbitmapPath::scale(self : DbindexbitmapPath, f : Double) -> DbindexbitmapPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapPath::add(self : DbindexbitmapPath, other : DbindexbitmapPath) -> DbindexbitmapPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbitmapPath::copy(self : DbindexbitmapPath) -> DbindexbitmapPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapPath::fill(self : DbindexbitmapPath, v : Double) -> DbindexbitmapPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapPath::min(self : DbindexbitmapPath) -> Double { @_common.min(self.data) }

pub fn DbindexbitmapPath::max(self : DbindexbitmapPath) -> Double { @_common.max(self.data) }

pub fn DbindexbitmapPath::to_string(self : DbindexbitmapPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_cluster_make(size : Int) -> DbindexbitmapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbitmapCluster::len(self : DbindexbitmapCluster) -> Int { self.size }

pub fn DbindexbitmapCluster::get(self : DbindexbitmapCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbitmapCluster::set(self : DbindexbitmapCluster, i : Int, v : Double) -> DbindexbitmapCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbitmapCluster::sum(self : DbindexbitmapCluster) -> Double { @_common.sum(self.data) }

pub fn DbindexbitmapCluster::mean(self : DbindexbitmapCluster) -> Double { @_common.mean(self.data) }

pub fn DbindexbitmapCluster::scale(self : DbindexbitmapCluster, f : Double) -> DbindexbitmapCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapCluster::add(self : DbindexbitmapCluster, other : DbindexbitmapCluster) -> DbindexbitmapCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbitmapCluster::copy(self : DbindexbitmapCluster) -> DbindexbitmapCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapCluster::fill(self : DbindexbitmapCluster, v : Double) -> DbindexbitmapCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapCluster::min(self : DbindexbitmapCluster) -> Double { @_common.min(self.data) }

pub fn DbindexbitmapCluster::max(self : DbindexbitmapCluster) -> Double { @_common.max(self.data) }

pub fn DbindexbitmapCluster::to_string(self : DbindexbitmapCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_model_make(size : Int) -> DbindexbitmapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbitmapModel::len(self : DbindexbitmapModel) -> Int { self.size }

pub fn DbindexbitmapModel::get(self : DbindexbitmapModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbitmapModel::set(self : DbindexbitmapModel, i : Int, v : Double) -> DbindexbitmapModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbitmapModel::sum(self : DbindexbitmapModel) -> Double { @_common.sum(self.data) }

pub fn DbindexbitmapModel::mean(self : DbindexbitmapModel) -> Double { @_common.mean(self.data) }

pub fn DbindexbitmapModel::scale(self : DbindexbitmapModel, f : Double) -> DbindexbitmapModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapModel::add(self : DbindexbitmapModel, other : DbindexbitmapModel) -> DbindexbitmapModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbitmapModel::copy(self : DbindexbitmapModel) -> DbindexbitmapModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapModel::fill(self : DbindexbitmapModel, v : Double) -> DbindexbitmapModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapModel::min(self : DbindexbitmapModel) -> Double { @_common.min(self.data) }

pub fn DbindexbitmapModel::max(self : DbindexbitmapModel) -> Double { @_common.max(self.data) }

pub fn DbindexbitmapModel::to_string(self : DbindexbitmapModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_layer_make(size : Int) -> DbindexbitmapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbitmapLayer::len(self : DbindexbitmapLayer) -> Int { self.size }

pub fn DbindexbitmapLayer::get(self : DbindexbitmapLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbitmapLayer::set(self : DbindexbitmapLayer, i : Int, v : Double) -> DbindexbitmapLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbitmapLayer::sum(self : DbindexbitmapLayer) -> Double { @_common.sum(self.data) }

pub fn DbindexbitmapLayer::mean(self : DbindexbitmapLayer) -> Double { @_common.mean(self.data) }

pub fn DbindexbitmapLayer::scale(self : DbindexbitmapLayer, f : Double) -> DbindexbitmapLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapLayer::add(self : DbindexbitmapLayer, other : DbindexbitmapLayer) -> DbindexbitmapLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbitmapLayer::copy(self : DbindexbitmapLayer) -> DbindexbitmapLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapLayer::fill(self : DbindexbitmapLayer, v : Double) -> DbindexbitmapLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapLayer::min(self : DbindexbitmapLayer) -> Double { @_common.min(self.data) }

pub fn DbindexbitmapLayer::max(self : DbindexbitmapLayer) -> Double { @_common.max(self.data) }

pub fn DbindexbitmapLayer::to_string(self : DbindexbitmapLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_buffer_make(size : Int) -> DbindexbitmapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbitmapBuffer::len(self : DbindexbitmapBuffer) -> Int { self.size }

pub fn DbindexbitmapBuffer::get(self : DbindexbitmapBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbitmapBuffer::set(self : DbindexbitmapBuffer, i : Int, v : Double) -> DbindexbitmapBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbitmapBuffer::sum(self : DbindexbitmapBuffer) -> Double { @_common.sum(self.data) }

pub fn DbindexbitmapBuffer::mean(self : DbindexbitmapBuffer) -> Double { @_common.mean(self.data) }

pub fn DbindexbitmapBuffer::scale(self : DbindexbitmapBuffer, f : Double) -> DbindexbitmapBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapBuffer::add(self : DbindexbitmapBuffer, other : DbindexbitmapBuffer) -> DbindexbitmapBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbitmapBuffer::copy(self : DbindexbitmapBuffer) -> DbindexbitmapBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapBuffer::fill(self : DbindexbitmapBuffer, v : Double) -> DbindexbitmapBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapBuffer::min(self : DbindexbitmapBuffer) -> Double { @_common.min(self.data) }

pub fn DbindexbitmapBuffer::max(self : DbindexbitmapBuffer) -> Double { @_common.max(self.data) }

pub fn DbindexbitmapBuffer::to_string(self : DbindexbitmapBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_cursor_make(size : Int) -> DbindexbitmapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbitmapCursor::len(self : DbindexbitmapCursor) -> Int { self.size }

pub fn DbindexbitmapCursor::get(self : DbindexbitmapCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbitmapCursor::set(self : DbindexbitmapCursor, i : Int, v : Double) -> DbindexbitmapCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbitmapCursor::sum(self : DbindexbitmapCursor) -> Double { @_common.sum(self.data) }

pub fn DbindexbitmapCursor::mean(self : DbindexbitmapCursor) -> Double { @_common.mean(self.data) }

pub fn DbindexbitmapCursor::scale(self : DbindexbitmapCursor, f : Double) -> DbindexbitmapCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapCursor::add(self : DbindexbitmapCursor, other : DbindexbitmapCursor) -> DbindexbitmapCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbitmapCursor::copy(self : DbindexbitmapCursor) -> DbindexbitmapCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapCursor::fill(self : DbindexbitmapCursor, v : Double) -> DbindexbitmapCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapCursor::min(self : DbindexbitmapCursor) -> Double { @_common.min(self.data) }

pub fn DbindexbitmapCursor::max(self : DbindexbitmapCursor) -> Double { @_common.max(self.data) }

pub fn DbindexbitmapCursor::to_string(self : DbindexbitmapCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_view_make(size : Int) -> DbindexbitmapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbitmapView::len(self : DbindexbitmapView) -> Int { self.size }

pub fn DbindexbitmapView::get(self : DbindexbitmapView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbitmapView::set(self : DbindexbitmapView, i : Int, v : Double) -> DbindexbitmapView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbitmapView::sum(self : DbindexbitmapView) -> Double { @_common.sum(self.data) }

pub fn DbindexbitmapView::mean(self : DbindexbitmapView) -> Double { @_common.mean(self.data) }

pub fn DbindexbitmapView::scale(self : DbindexbitmapView, f : Double) -> DbindexbitmapView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapView::add(self : DbindexbitmapView, other : DbindexbitmapView) -> DbindexbitmapView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbitmapView::copy(self : DbindexbitmapView) -> DbindexbitmapView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapView::fill(self : DbindexbitmapView, v : Double) -> DbindexbitmapView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapView::min(self : DbindexbitmapView) -> Double { @_common.min(self.data) }

pub fn DbindexbitmapView::max(self : DbindexbitmapView) -> Double { @_common.max(self.data) }

pub fn DbindexbitmapView::to_string(self : DbindexbitmapView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_range_make(size : Int) -> DbindexbitmapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbitmapRange::len(self : DbindexbitmapRange) -> Int { self.size }

pub fn DbindexbitmapRange::get(self : DbindexbitmapRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbitmapRange::set(self : DbindexbitmapRange, i : Int, v : Double) -> DbindexbitmapRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbitmapRange::sum(self : DbindexbitmapRange) -> Double { @_common.sum(self.data) }

pub fn DbindexbitmapRange::mean(self : DbindexbitmapRange) -> Double { @_common.mean(self.data) }

pub fn DbindexbitmapRange::scale(self : DbindexbitmapRange, f : Double) -> DbindexbitmapRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapRange::add(self : DbindexbitmapRange, other : DbindexbitmapRange) -> DbindexbitmapRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbitmapRange::copy(self : DbindexbitmapRange) -> DbindexbitmapRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapRange::fill(self : DbindexbitmapRange, v : Double) -> DbindexbitmapRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapRange::min(self : DbindexbitmapRange) -> Double { @_common.min(self.data) }

pub fn DbindexbitmapRange::max(self : DbindexbitmapRange) -> Double { @_common.max(self.data) }

pub fn DbindexbitmapRange::to_string(self : DbindexbitmapRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_slice_make(size : Int) -> DbindexbitmapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbindexbitmapSlice::len(self : DbindexbitmapSlice) -> Int { self.size }

pub fn DbindexbitmapSlice::get(self : DbindexbitmapSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbindexbitmapSlice::set(self : DbindexbitmapSlice, i : Int, v : Double) -> DbindexbitmapSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbindexbitmapSlice::sum(self : DbindexbitmapSlice) -> Double { @_common.sum(self.data) }

pub fn DbindexbitmapSlice::mean(self : DbindexbitmapSlice) -> Double { @_common.mean(self.data) }

pub fn DbindexbitmapSlice::scale(self : DbindexbitmapSlice, f : Double) -> DbindexbitmapSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapSlice::add(self : DbindexbitmapSlice, other : DbindexbitmapSlice) -> DbindexbitmapSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbindexbitmapSlice::copy(self : DbindexbitmapSlice) -> DbindexbitmapSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapSlice::fill(self : DbindexbitmapSlice, v : Double) -> DbindexbitmapSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbindexbitmapSlice::min(self : DbindexbitmapSlice) -> Double { @_common.min(self.data) }

pub fn DbindexbitmapSlice::max(self : DbindexbitmapSlice) -> Double { @_common.max(self.data) }

pub fn DbindexbitmapSlice::to_string(self : DbindexbitmapSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

