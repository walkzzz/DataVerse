///===
/// extcore/db_store_row

pub(all) struct DbstorerowPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_row_make_point(x : Double, y : Double) -> DbstorerowPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_row_make_point3(x : Double, y : Double, z : Double) -> DbstorerowPoint {
  { x, y, z, label: 0 }
}

pub fn DbstorerowPoint::x(self : DbstorerowPoint) -> Double { self.x }

pub fn DbstorerowPoint::y(self : DbstorerowPoint) -> Double { self.y }

pub fn DbstorerowPoint::z(self : DbstorerowPoint) -> Double { self.z }

pub fn DbstorerowPoint::label(self : DbstorerowPoint) -> Int { self.label }

pub fn DbstorerowPoint::dist(self : DbstorerowPoint, other : DbstorerowPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbstorerowPoint::add(self : DbstorerowPoint, other : DbstorerowPoint) -> DbstorerowPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbstorerowPoint::sub(self : DbstorerowPoint, other : DbstorerowPoint) -> DbstorerowPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbstorerowPoint::scale(self : DbstorerowPoint, s : Double) -> DbstorerowPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbstorerowPoint::dot(self : DbstorerowPoint, other : DbstorerowPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbstorerowPoint::cross(self : DbstorerowPoint, other : DbstorerowPoint) -> DbstorerowPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbstorerowPoint::norm(self : DbstorerowPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbstorerowPoint::normalize(self : DbstorerowPoint) -> DbstorerowPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorerowPoint::negate(self : DbstorerowPoint) -> DbstorerowPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbstorerowPoint::mid(self : DbstorerowPoint, other : DbstorerowPoint) -> DbstorerowPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbstorerowPoint::lerp(self : DbstorerowPoint, other : DbstorerowPoint, t : Double) -> DbstorerowPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbstorerowPoint::to_string(self : DbstorerowPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbstorerowSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_row_make_series(vals : Array[Double], name : String) -> DbstorerowSeries {
  { vals, name, meta: 0 }
}

pub fn DbstorerowSeries::len(self : DbstorerowSeries) -> Int { self.vals.length() }

pub fn DbstorerowSeries::sum(self : DbstorerowSeries) -> Double { @_common.sum(self.vals) }

pub fn DbstorerowSeries::mean(self : DbstorerowSeries) -> Double { @_common.mean(self.vals) }

pub fn DbstorerowSeries::min(self : DbstorerowSeries) -> Double { @_common.min(self.vals) }

pub fn DbstorerowSeries::max(self : DbstorerowSeries) -> Double { @_common.max(self.vals) }

pub fn DbstorerowSeries::range(self : DbstorerowSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbstorerowSeries::variance(self : DbstorerowSeries) -> Double { @_common.variance(self.vals) }

pub fn DbstorerowSeries::std(self : DbstorerowSeries) -> Double { @_common.std(self.vals) }

pub fn DbstorerowSeries::median(self : DbstorerowSeries) -> Double { @_common.median(self.vals) }

pub fn DbstorerowSeries::scale(self : DbstorerowSeries, f : Double) -> DbstorerowSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbstorerowSeries::add(self : DbstorerowSeries, other : DbstorerowSeries) -> DbstorerowSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbstorerowSeries::sub(self : DbstorerowSeries, other : DbstorerowSeries) -> DbstorerowSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbstorerowSeries::normalize(self : DbstorerowSeries) -> DbstorerowSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbstorerowSeries::cumsum(self : DbstorerowSeries) -> DbstorerowSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbstorerowSeries::to_string(self : DbstorerowSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorerowMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_row_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorerowMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_row_matrix_identity(n : Int) -> DbstorerowMatrix {
  let m = db_store_row_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbstorerowMatrix::get(self : DbstorerowMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbstorerowMatrix::transpose(self : DbstorerowMatrix) -> DbstorerowMatrix {
  let result = db_store_row_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbstorerowMatrix::add(self : DbstorerowMatrix, other : DbstorerowMatrix) -> DbstorerowMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_store_row_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbstorerowMatrix::scale(self : DbstorerowMatrix, s : Double) -> DbstorerowMatrix {
  let result = db_store_row_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbstorerowMatrix::multiply(self : DbstorerowMatrix, other : DbstorerowMatrix) -> DbstorerowMatrix {
  if self.cols != other.rows { return db_store_row_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_store_row_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbstorerowMatrix::trace(self : DbstorerowMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbstorerowMatrix::det(self : DbstorerowMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbstorerowMatrix::norm(self : DbstorerowMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbstorerowMatrix::to_string(self : DbstorerowMatrix) -> String {
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

pub(all) struct DbstorerowVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_row_make_vector(comps : Array[Double]) -> DbstorerowVector {
  { comps, dim: comps.length() }
}

pub fn db_store_row_vector_zero(dim : Int) -> DbstorerowVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbstorerowVector::add(self : DbstorerowVector, other : DbstorerowVector) -> DbstorerowVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorerowVector::sub(self : DbstorerowVector, other : DbstorerowVector) -> DbstorerowVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbstorerowVector::scale(self : DbstorerowVector, s : Double) -> DbstorerowVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbstorerowVector::dot(self : DbstorerowVector, other : DbstorerowVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbstorerowVector::norm(self : DbstorerowVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbstorerowVector::normalize(self : DbstorerowVector) -> DbstorerowVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbstorerowVector::dist(self : DbstorerowVector, other : DbstorerowVector) -> Double {
  self.sub(other).norm()
}

pub fn DbstorerowVector::to_string(self : DbstorerowVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_row_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_store_row_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_store_row_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_store_row_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_store_row_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_store_row_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_store_row_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_store_row_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_store_row_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_store_row_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_store_row_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_store_row_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_store_row_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_store_row_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_store_row_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_store_row_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_store_row_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_store_row_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_store_row_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_store_row_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_store_row_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_store_row_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_store_row_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_store_row_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_store_row_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_store_row_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_store_row_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_store_row_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_store_row_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbstorerowFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_frame_make(size : Int) -> DbstorerowFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorerowFrame::len(self : DbstorerowFrame) -> Int { self.size }

pub fn DbstorerowFrame::get(self : DbstorerowFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorerowFrame::set(self : DbstorerowFrame, i : Int, v : Double) -> DbstorerowFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorerowFrame::sum(self : DbstorerowFrame) -> Double { @_common.sum(self.data) }

pub fn DbstorerowFrame::mean(self : DbstorerowFrame) -> Double { @_common.mean(self.data) }

pub fn DbstorerowFrame::scale(self : DbstorerowFrame, f : Double) -> DbstorerowFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorerowFrame::add(self : DbstorerowFrame, other : DbstorerowFrame) -> DbstorerowFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorerowFrame::copy(self : DbstorerowFrame) -> DbstorerowFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorerowFrame::fill(self : DbstorerowFrame, v : Double) -> DbstorerowFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorerowFrame::min(self : DbstorerowFrame) -> Double { @_common.min(self.data) }

pub fn DbstorerowFrame::max(self : DbstorerowFrame) -> Double { @_common.max(self.data) }

pub fn DbstorerowFrame::to_string(self : DbstorerowFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorerowTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_table_make(size : Int) -> DbstorerowTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorerowTable::len(self : DbstorerowTable) -> Int { self.size }

pub fn DbstorerowTable::get(self : DbstorerowTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorerowTable::set(self : DbstorerowTable, i : Int, v : Double) -> DbstorerowTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorerowTable::sum(self : DbstorerowTable) -> Double { @_common.sum(self.data) }

pub fn DbstorerowTable::mean(self : DbstorerowTable) -> Double { @_common.mean(self.data) }

pub fn DbstorerowTable::scale(self : DbstorerowTable, f : Double) -> DbstorerowTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorerowTable::add(self : DbstorerowTable, other : DbstorerowTable) -> DbstorerowTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorerowTable::copy(self : DbstorerowTable) -> DbstorerowTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorerowTable::fill(self : DbstorerowTable, v : Double) -> DbstorerowTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorerowTable::min(self : DbstorerowTable) -> Double { @_common.min(self.data) }

pub fn DbstorerowTable::max(self : DbstorerowTable) -> Double { @_common.max(self.data) }

pub fn DbstorerowTable::to_string(self : DbstorerowTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorerowGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_graphn_make(size : Int) -> DbstorerowGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorerowGraphN::len(self : DbstorerowGraphN) -> Int { self.size }

pub fn DbstorerowGraphN::get(self : DbstorerowGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorerowGraphN::set(self : DbstorerowGraphN, i : Int, v : Double) -> DbstorerowGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorerowGraphN::sum(self : DbstorerowGraphN) -> Double { @_common.sum(self.data) }

pub fn DbstorerowGraphN::mean(self : DbstorerowGraphN) -> Double { @_common.mean(self.data) }

pub fn DbstorerowGraphN::scale(self : DbstorerowGraphN, f : Double) -> DbstorerowGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorerowGraphN::add(self : DbstorerowGraphN, other : DbstorerowGraphN) -> DbstorerowGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorerowGraphN::copy(self : DbstorerowGraphN) -> DbstorerowGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorerowGraphN::fill(self : DbstorerowGraphN, v : Double) -> DbstorerowGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorerowGraphN::min(self : DbstorerowGraphN) -> Double { @_common.min(self.data) }

pub fn DbstorerowGraphN::max(self : DbstorerowGraphN) -> Double { @_common.max(self.data) }

pub fn DbstorerowGraphN::to_string(self : DbstorerowGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorerowNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_node_make(size : Int) -> DbstorerowNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorerowNode::len(self : DbstorerowNode) -> Int { self.size }

pub fn DbstorerowNode::get(self : DbstorerowNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorerowNode::set(self : DbstorerowNode, i : Int, v : Double) -> DbstorerowNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorerowNode::sum(self : DbstorerowNode) -> Double { @_common.sum(self.data) }

pub fn DbstorerowNode::mean(self : DbstorerowNode) -> Double { @_common.mean(self.data) }

pub fn DbstorerowNode::scale(self : DbstorerowNode, f : Double) -> DbstorerowNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorerowNode::add(self : DbstorerowNode, other : DbstorerowNode) -> DbstorerowNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorerowNode::copy(self : DbstorerowNode) -> DbstorerowNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorerowNode::fill(self : DbstorerowNode, v : Double) -> DbstorerowNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorerowNode::min(self : DbstorerowNode) -> Double { @_common.min(self.data) }

pub fn DbstorerowNode::max(self : DbstorerowNode) -> Double { @_common.max(self.data) }

pub fn DbstorerowNode::to_string(self : DbstorerowNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorerowEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_edge_make(size : Int) -> DbstorerowEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorerowEdge::len(self : DbstorerowEdge) -> Int { self.size }

pub fn DbstorerowEdge::get(self : DbstorerowEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorerowEdge::set(self : DbstorerowEdge, i : Int, v : Double) -> DbstorerowEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorerowEdge::sum(self : DbstorerowEdge) -> Double { @_common.sum(self.data) }

pub fn DbstorerowEdge::mean(self : DbstorerowEdge) -> Double { @_common.mean(self.data) }

pub fn DbstorerowEdge::scale(self : DbstorerowEdge, f : Double) -> DbstorerowEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorerowEdge::add(self : DbstorerowEdge, other : DbstorerowEdge) -> DbstorerowEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorerowEdge::copy(self : DbstorerowEdge) -> DbstorerowEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorerowEdge::fill(self : DbstorerowEdge, v : Double) -> DbstorerowEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorerowEdge::min(self : DbstorerowEdge) -> Double { @_common.min(self.data) }

pub fn DbstorerowEdge::max(self : DbstorerowEdge) -> Double { @_common.max(self.data) }

pub fn DbstorerowEdge::to_string(self : DbstorerowEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorerowPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_path_make(size : Int) -> DbstorerowPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorerowPath::len(self : DbstorerowPath) -> Int { self.size }

pub fn DbstorerowPath::get(self : DbstorerowPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorerowPath::set(self : DbstorerowPath, i : Int, v : Double) -> DbstorerowPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorerowPath::sum(self : DbstorerowPath) -> Double { @_common.sum(self.data) }

pub fn DbstorerowPath::mean(self : DbstorerowPath) -> Double { @_common.mean(self.data) }

pub fn DbstorerowPath::scale(self : DbstorerowPath, f : Double) -> DbstorerowPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorerowPath::add(self : DbstorerowPath, other : DbstorerowPath) -> DbstorerowPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorerowPath::copy(self : DbstorerowPath) -> DbstorerowPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorerowPath::fill(self : DbstorerowPath, v : Double) -> DbstorerowPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorerowPath::min(self : DbstorerowPath) -> Double { @_common.min(self.data) }

pub fn DbstorerowPath::max(self : DbstorerowPath) -> Double { @_common.max(self.data) }

pub fn DbstorerowPath::to_string(self : DbstorerowPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorerowCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_cluster_make(size : Int) -> DbstorerowCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorerowCluster::len(self : DbstorerowCluster) -> Int { self.size }

pub fn DbstorerowCluster::get(self : DbstorerowCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorerowCluster::set(self : DbstorerowCluster, i : Int, v : Double) -> DbstorerowCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorerowCluster::sum(self : DbstorerowCluster) -> Double { @_common.sum(self.data) }

pub fn DbstorerowCluster::mean(self : DbstorerowCluster) -> Double { @_common.mean(self.data) }

pub fn DbstorerowCluster::scale(self : DbstorerowCluster, f : Double) -> DbstorerowCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorerowCluster::add(self : DbstorerowCluster, other : DbstorerowCluster) -> DbstorerowCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorerowCluster::copy(self : DbstorerowCluster) -> DbstorerowCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorerowCluster::fill(self : DbstorerowCluster, v : Double) -> DbstorerowCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorerowCluster::min(self : DbstorerowCluster) -> Double { @_common.min(self.data) }

pub fn DbstorerowCluster::max(self : DbstorerowCluster) -> Double { @_common.max(self.data) }

pub fn DbstorerowCluster::to_string(self : DbstorerowCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorerowModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_model_make(size : Int) -> DbstorerowModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorerowModel::len(self : DbstorerowModel) -> Int { self.size }

pub fn DbstorerowModel::get(self : DbstorerowModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorerowModel::set(self : DbstorerowModel, i : Int, v : Double) -> DbstorerowModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorerowModel::sum(self : DbstorerowModel) -> Double { @_common.sum(self.data) }

pub fn DbstorerowModel::mean(self : DbstorerowModel) -> Double { @_common.mean(self.data) }

pub fn DbstorerowModel::scale(self : DbstorerowModel, f : Double) -> DbstorerowModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorerowModel::add(self : DbstorerowModel, other : DbstorerowModel) -> DbstorerowModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorerowModel::copy(self : DbstorerowModel) -> DbstorerowModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorerowModel::fill(self : DbstorerowModel, v : Double) -> DbstorerowModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorerowModel::min(self : DbstorerowModel) -> Double { @_common.min(self.data) }

pub fn DbstorerowModel::max(self : DbstorerowModel) -> Double { @_common.max(self.data) }

pub fn DbstorerowModel::to_string(self : DbstorerowModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorerowLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_layer_make(size : Int) -> DbstorerowLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorerowLayer::len(self : DbstorerowLayer) -> Int { self.size }

pub fn DbstorerowLayer::get(self : DbstorerowLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorerowLayer::set(self : DbstorerowLayer, i : Int, v : Double) -> DbstorerowLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorerowLayer::sum(self : DbstorerowLayer) -> Double { @_common.sum(self.data) }

pub fn DbstorerowLayer::mean(self : DbstorerowLayer) -> Double { @_common.mean(self.data) }

pub fn DbstorerowLayer::scale(self : DbstorerowLayer, f : Double) -> DbstorerowLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorerowLayer::add(self : DbstorerowLayer, other : DbstorerowLayer) -> DbstorerowLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorerowLayer::copy(self : DbstorerowLayer) -> DbstorerowLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorerowLayer::fill(self : DbstorerowLayer, v : Double) -> DbstorerowLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorerowLayer::min(self : DbstorerowLayer) -> Double { @_common.min(self.data) }

pub fn DbstorerowLayer::max(self : DbstorerowLayer) -> Double { @_common.max(self.data) }

pub fn DbstorerowLayer::to_string(self : DbstorerowLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorerowBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_buffer_make(size : Int) -> DbstorerowBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorerowBuffer::len(self : DbstorerowBuffer) -> Int { self.size }

pub fn DbstorerowBuffer::get(self : DbstorerowBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorerowBuffer::set(self : DbstorerowBuffer, i : Int, v : Double) -> DbstorerowBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorerowBuffer::sum(self : DbstorerowBuffer) -> Double { @_common.sum(self.data) }

pub fn DbstorerowBuffer::mean(self : DbstorerowBuffer) -> Double { @_common.mean(self.data) }

pub fn DbstorerowBuffer::scale(self : DbstorerowBuffer, f : Double) -> DbstorerowBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorerowBuffer::add(self : DbstorerowBuffer, other : DbstorerowBuffer) -> DbstorerowBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorerowBuffer::copy(self : DbstorerowBuffer) -> DbstorerowBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorerowBuffer::fill(self : DbstorerowBuffer, v : Double) -> DbstorerowBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorerowBuffer::min(self : DbstorerowBuffer) -> Double { @_common.min(self.data) }

pub fn DbstorerowBuffer::max(self : DbstorerowBuffer) -> Double { @_common.max(self.data) }

pub fn DbstorerowBuffer::to_string(self : DbstorerowBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorerowCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_cursor_make(size : Int) -> DbstorerowCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorerowCursor::len(self : DbstorerowCursor) -> Int { self.size }

pub fn DbstorerowCursor::get(self : DbstorerowCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorerowCursor::set(self : DbstorerowCursor, i : Int, v : Double) -> DbstorerowCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorerowCursor::sum(self : DbstorerowCursor) -> Double { @_common.sum(self.data) }

pub fn DbstorerowCursor::mean(self : DbstorerowCursor) -> Double { @_common.mean(self.data) }

pub fn DbstorerowCursor::scale(self : DbstorerowCursor, f : Double) -> DbstorerowCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorerowCursor::add(self : DbstorerowCursor, other : DbstorerowCursor) -> DbstorerowCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorerowCursor::copy(self : DbstorerowCursor) -> DbstorerowCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorerowCursor::fill(self : DbstorerowCursor, v : Double) -> DbstorerowCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorerowCursor::min(self : DbstorerowCursor) -> Double { @_common.min(self.data) }

pub fn DbstorerowCursor::max(self : DbstorerowCursor) -> Double { @_common.max(self.data) }

pub fn DbstorerowCursor::to_string(self : DbstorerowCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorerowView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_view_make(size : Int) -> DbstorerowView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorerowView::len(self : DbstorerowView) -> Int { self.size }

pub fn DbstorerowView::get(self : DbstorerowView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorerowView::set(self : DbstorerowView, i : Int, v : Double) -> DbstorerowView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorerowView::sum(self : DbstorerowView) -> Double { @_common.sum(self.data) }

pub fn DbstorerowView::mean(self : DbstorerowView) -> Double { @_common.mean(self.data) }

pub fn DbstorerowView::scale(self : DbstorerowView, f : Double) -> DbstorerowView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorerowView::add(self : DbstorerowView, other : DbstorerowView) -> DbstorerowView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorerowView::copy(self : DbstorerowView) -> DbstorerowView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorerowView::fill(self : DbstorerowView, v : Double) -> DbstorerowView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorerowView::min(self : DbstorerowView) -> Double { @_common.min(self.data) }

pub fn DbstorerowView::max(self : DbstorerowView) -> Double { @_common.max(self.data) }

pub fn DbstorerowView::to_string(self : DbstorerowView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorerowRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_range_make(size : Int) -> DbstorerowRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorerowRange::len(self : DbstorerowRange) -> Int { self.size }

pub fn DbstorerowRange::get(self : DbstorerowRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorerowRange::set(self : DbstorerowRange, i : Int, v : Double) -> DbstorerowRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorerowRange::sum(self : DbstorerowRange) -> Double { @_common.sum(self.data) }

pub fn DbstorerowRange::mean(self : DbstorerowRange) -> Double { @_common.mean(self.data) }

pub fn DbstorerowRange::scale(self : DbstorerowRange, f : Double) -> DbstorerowRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorerowRange::add(self : DbstorerowRange, other : DbstorerowRange) -> DbstorerowRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorerowRange::copy(self : DbstorerowRange) -> DbstorerowRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorerowRange::fill(self : DbstorerowRange, v : Double) -> DbstorerowRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorerowRange::min(self : DbstorerowRange) -> Double { @_common.min(self.data) }

pub fn DbstorerowRange::max(self : DbstorerowRange) -> Double { @_common.max(self.data) }

pub fn DbstorerowRange::to_string(self : DbstorerowRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbstorerowSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_row_slice_make(size : Int) -> DbstorerowSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbstorerowSlice::len(self : DbstorerowSlice) -> Int { self.size }

pub fn DbstorerowSlice::get(self : DbstorerowSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbstorerowSlice::set(self : DbstorerowSlice, i : Int, v : Double) -> DbstorerowSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbstorerowSlice::sum(self : DbstorerowSlice) -> Double { @_common.sum(self.data) }

pub fn DbstorerowSlice::mean(self : DbstorerowSlice) -> Double { @_common.mean(self.data) }

pub fn DbstorerowSlice::scale(self : DbstorerowSlice, f : Double) -> DbstorerowSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbstorerowSlice::add(self : DbstorerowSlice, other : DbstorerowSlice) -> DbstorerowSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbstorerowSlice::copy(self : DbstorerowSlice) -> DbstorerowSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbstorerowSlice::fill(self : DbstorerowSlice, v : Double) -> DbstorerowSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbstorerowSlice::min(self : DbstorerowSlice) -> Double { @_common.min(self.data) }

pub fn DbstorerowSlice::max(self : DbstorerowSlice) -> Double { @_common.max(self.data) }

pub fn DbstorerowSlice::to_string(self : DbstorerowSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

