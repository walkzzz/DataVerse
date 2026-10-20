///===
/// extcore/sort_dist_flash

pub(all) struct SortdistflashPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_flash_make_point(x : Double, y : Double) -> SortdistflashPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_flash_make_point3(x : Double, y : Double, z : Double) -> SortdistflashPoint {
  { x, y, z, label: 0 }
}

pub fn SortdistflashPoint::x(self : SortdistflashPoint) -> Double { self.x }

pub fn SortdistflashPoint::y(self : SortdistflashPoint) -> Double { self.y }

pub fn SortdistflashPoint::z(self : SortdistflashPoint) -> Double { self.z }

pub fn SortdistflashPoint::label(self : SortdistflashPoint) -> Int { self.label }

pub fn SortdistflashPoint::dist(self : SortdistflashPoint, other : SortdistflashPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistflashPoint::add(self : SortdistflashPoint, other : SortdistflashPoint) -> SortdistflashPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistflashPoint::sub(self : SortdistflashPoint, other : SortdistflashPoint) -> SortdistflashPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistflashPoint::scale(self : SortdistflashPoint, s : Double) -> SortdistflashPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistflashPoint::dot(self : SortdistflashPoint, other : SortdistflashPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistflashPoint::cross(self : SortdistflashPoint, other : SortdistflashPoint) -> SortdistflashPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistflashPoint::norm(self : SortdistflashPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistflashPoint::normalize(self : SortdistflashPoint) -> SortdistflashPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistflashPoint::negate(self : SortdistflashPoint) -> SortdistflashPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistflashPoint::mid(self : SortdistflashPoint, other : SortdistflashPoint) -> SortdistflashPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistflashPoint::lerp(self : SortdistflashPoint, other : SortdistflashPoint, t : Double) -> SortdistflashPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistflashPoint::to_string(self : SortdistflashPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistflashSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_flash_make_series(vals : Array[Double], name : String) -> SortdistflashSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistflashSeries::len(self : SortdistflashSeries) -> Int { self.vals.length() }

pub fn SortdistflashSeries::sum(self : SortdistflashSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistflashSeries::mean(self : SortdistflashSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistflashSeries::min(self : SortdistflashSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistflashSeries::max(self : SortdistflashSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistflashSeries::range(self : SortdistflashSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistflashSeries::variance(self : SortdistflashSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistflashSeries::std(self : SortdistflashSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistflashSeries::median(self : SortdistflashSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistflashSeries::scale(self : SortdistflashSeries, f : Double) -> SortdistflashSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistflashSeries::add(self : SortdistflashSeries, other : SortdistflashSeries) -> SortdistflashSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistflashSeries::sub(self : SortdistflashSeries, other : SortdistflashSeries) -> SortdistflashSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistflashSeries::normalize(self : SortdistflashSeries) -> SortdistflashSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistflashSeries::cumsum(self : SortdistflashSeries) -> SortdistflashSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistflashSeries::to_string(self : SortdistflashSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistflashMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_flash_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistflashMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_flash_matrix_identity(n : Int) -> SortdistflashMatrix {
  let m = sort_dist_flash_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistflashMatrix::get(self : SortdistflashMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistflashMatrix::transpose(self : SortdistflashMatrix) -> SortdistflashMatrix {
  let result = sort_dist_flash_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistflashMatrix::add(self : SortdistflashMatrix, other : SortdistflashMatrix) -> SortdistflashMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_flash_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistflashMatrix::scale(self : SortdistflashMatrix, s : Double) -> SortdistflashMatrix {
  let result = sort_dist_flash_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistflashMatrix::multiply(self : SortdistflashMatrix, other : SortdistflashMatrix) -> SortdistflashMatrix {
  if self.cols != other.rows { return sort_dist_flash_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_flash_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistflashMatrix::trace(self : SortdistflashMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistflashMatrix::det(self : SortdistflashMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistflashMatrix::norm(self : SortdistflashMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistflashMatrix::to_string(self : SortdistflashMatrix) -> String {
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

pub(all) struct SortdistflashVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_flash_make_vector(comps : Array[Double]) -> SortdistflashVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_flash_vector_zero(dim : Int) -> SortdistflashVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistflashVector::add(self : SortdistflashVector, other : SortdistflashVector) -> SortdistflashVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistflashVector::sub(self : SortdistflashVector, other : SortdistflashVector) -> SortdistflashVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistflashVector::scale(self : SortdistflashVector, s : Double) -> SortdistflashVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistflashVector::dot(self : SortdistflashVector, other : SortdistflashVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistflashVector::norm(self : SortdistflashVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistflashVector::normalize(self : SortdistflashVector) -> SortdistflashVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistflashVector::dist(self : SortdistflashVector, other : SortdistflashVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistflashVector::to_string(self : SortdistflashVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_flash_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_flash_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_flash_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_flash_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_flash_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_flash_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_flash_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_flash_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_flash_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_flash_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_flash_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_flash_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_flash_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_flash_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_flash_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_flash_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_flash_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_flash_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_flash_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_flash_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_flash_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_flash_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_flash_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_flash_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_flash_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_flash_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_flash_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_flash_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_flash_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistflashFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_frame_make(size : Int) -> SortdistflashFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistflashFrame::len(self : SortdistflashFrame) -> Int { self.size }

pub fn SortdistflashFrame::get(self : SortdistflashFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistflashFrame::set(self : SortdistflashFrame, i : Int, v : Double) -> SortdistflashFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistflashFrame::sum(self : SortdistflashFrame) -> Double { @_common.sum(self.data) }

pub fn SortdistflashFrame::mean(self : SortdistflashFrame) -> Double { @_common.mean(self.data) }

pub fn SortdistflashFrame::scale(self : SortdistflashFrame, f : Double) -> SortdistflashFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistflashFrame::add(self : SortdistflashFrame, other : SortdistflashFrame) -> SortdistflashFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistflashFrame::copy(self : SortdistflashFrame) -> SortdistflashFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistflashFrame::fill(self : SortdistflashFrame, v : Double) -> SortdistflashFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistflashFrame::min(self : SortdistflashFrame) -> Double { @_common.min(self.data) }

pub fn SortdistflashFrame::max(self : SortdistflashFrame) -> Double { @_common.max(self.data) }

pub fn SortdistflashFrame::to_string(self : SortdistflashFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistflashTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_table_make(size : Int) -> SortdistflashTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistflashTable::len(self : SortdistflashTable) -> Int { self.size }

pub fn SortdistflashTable::get(self : SortdistflashTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistflashTable::set(self : SortdistflashTable, i : Int, v : Double) -> SortdistflashTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistflashTable::sum(self : SortdistflashTable) -> Double { @_common.sum(self.data) }

pub fn SortdistflashTable::mean(self : SortdistflashTable) -> Double { @_common.mean(self.data) }

pub fn SortdistflashTable::scale(self : SortdistflashTable, f : Double) -> SortdistflashTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistflashTable::add(self : SortdistflashTable, other : SortdistflashTable) -> SortdistflashTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistflashTable::copy(self : SortdistflashTable) -> SortdistflashTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistflashTable::fill(self : SortdistflashTable, v : Double) -> SortdistflashTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistflashTable::min(self : SortdistflashTable) -> Double { @_common.min(self.data) }

pub fn SortdistflashTable::max(self : SortdistflashTable) -> Double { @_common.max(self.data) }

pub fn SortdistflashTable::to_string(self : SortdistflashTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistflashGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_graphn_make(size : Int) -> SortdistflashGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistflashGraphN::len(self : SortdistflashGraphN) -> Int { self.size }

pub fn SortdistflashGraphN::get(self : SortdistflashGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistflashGraphN::set(self : SortdistflashGraphN, i : Int, v : Double) -> SortdistflashGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistflashGraphN::sum(self : SortdistflashGraphN) -> Double { @_common.sum(self.data) }

pub fn SortdistflashGraphN::mean(self : SortdistflashGraphN) -> Double { @_common.mean(self.data) }

pub fn SortdistflashGraphN::scale(self : SortdistflashGraphN, f : Double) -> SortdistflashGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistflashGraphN::add(self : SortdistflashGraphN, other : SortdistflashGraphN) -> SortdistflashGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistflashGraphN::copy(self : SortdistflashGraphN) -> SortdistflashGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistflashGraphN::fill(self : SortdistflashGraphN, v : Double) -> SortdistflashGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistflashGraphN::min(self : SortdistflashGraphN) -> Double { @_common.min(self.data) }

pub fn SortdistflashGraphN::max(self : SortdistflashGraphN) -> Double { @_common.max(self.data) }

pub fn SortdistflashGraphN::to_string(self : SortdistflashGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistflashNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_node_make(size : Int) -> SortdistflashNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistflashNode::len(self : SortdistflashNode) -> Int { self.size }

pub fn SortdistflashNode::get(self : SortdistflashNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistflashNode::set(self : SortdistflashNode, i : Int, v : Double) -> SortdistflashNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistflashNode::sum(self : SortdistflashNode) -> Double { @_common.sum(self.data) }

pub fn SortdistflashNode::mean(self : SortdistflashNode) -> Double { @_common.mean(self.data) }

pub fn SortdistflashNode::scale(self : SortdistflashNode, f : Double) -> SortdistflashNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistflashNode::add(self : SortdistflashNode, other : SortdistflashNode) -> SortdistflashNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistflashNode::copy(self : SortdistflashNode) -> SortdistflashNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistflashNode::fill(self : SortdistflashNode, v : Double) -> SortdistflashNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistflashNode::min(self : SortdistflashNode) -> Double { @_common.min(self.data) }

pub fn SortdistflashNode::max(self : SortdistflashNode) -> Double { @_common.max(self.data) }

pub fn SortdistflashNode::to_string(self : SortdistflashNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistflashEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_edge_make(size : Int) -> SortdistflashEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistflashEdge::len(self : SortdistflashEdge) -> Int { self.size }

pub fn SortdistflashEdge::get(self : SortdistflashEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistflashEdge::set(self : SortdistflashEdge, i : Int, v : Double) -> SortdistflashEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistflashEdge::sum(self : SortdistflashEdge) -> Double { @_common.sum(self.data) }

pub fn SortdistflashEdge::mean(self : SortdistflashEdge) -> Double { @_common.mean(self.data) }

pub fn SortdistflashEdge::scale(self : SortdistflashEdge, f : Double) -> SortdistflashEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistflashEdge::add(self : SortdistflashEdge, other : SortdistflashEdge) -> SortdistflashEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistflashEdge::copy(self : SortdistflashEdge) -> SortdistflashEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistflashEdge::fill(self : SortdistflashEdge, v : Double) -> SortdistflashEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistflashEdge::min(self : SortdistflashEdge) -> Double { @_common.min(self.data) }

pub fn SortdistflashEdge::max(self : SortdistflashEdge) -> Double { @_common.max(self.data) }

pub fn SortdistflashEdge::to_string(self : SortdistflashEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistflashPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_path_make(size : Int) -> SortdistflashPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistflashPath::len(self : SortdistflashPath) -> Int { self.size }

pub fn SortdistflashPath::get(self : SortdistflashPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistflashPath::set(self : SortdistflashPath, i : Int, v : Double) -> SortdistflashPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistflashPath::sum(self : SortdistflashPath) -> Double { @_common.sum(self.data) }

pub fn SortdistflashPath::mean(self : SortdistflashPath) -> Double { @_common.mean(self.data) }

pub fn SortdistflashPath::scale(self : SortdistflashPath, f : Double) -> SortdistflashPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistflashPath::add(self : SortdistflashPath, other : SortdistflashPath) -> SortdistflashPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistflashPath::copy(self : SortdistflashPath) -> SortdistflashPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistflashPath::fill(self : SortdistflashPath, v : Double) -> SortdistflashPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistflashPath::min(self : SortdistflashPath) -> Double { @_common.min(self.data) }

pub fn SortdistflashPath::max(self : SortdistflashPath) -> Double { @_common.max(self.data) }

pub fn SortdistflashPath::to_string(self : SortdistflashPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistflashCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_cluster_make(size : Int) -> SortdistflashCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistflashCluster::len(self : SortdistflashCluster) -> Int { self.size }

pub fn SortdistflashCluster::get(self : SortdistflashCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistflashCluster::set(self : SortdistflashCluster, i : Int, v : Double) -> SortdistflashCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistflashCluster::sum(self : SortdistflashCluster) -> Double { @_common.sum(self.data) }

pub fn SortdistflashCluster::mean(self : SortdistflashCluster) -> Double { @_common.mean(self.data) }

pub fn SortdistflashCluster::scale(self : SortdistflashCluster, f : Double) -> SortdistflashCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistflashCluster::add(self : SortdistflashCluster, other : SortdistflashCluster) -> SortdistflashCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistflashCluster::copy(self : SortdistflashCluster) -> SortdistflashCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistflashCluster::fill(self : SortdistflashCluster, v : Double) -> SortdistflashCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistflashCluster::min(self : SortdistflashCluster) -> Double { @_common.min(self.data) }

pub fn SortdistflashCluster::max(self : SortdistflashCluster) -> Double { @_common.max(self.data) }

pub fn SortdistflashCluster::to_string(self : SortdistflashCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistflashModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_model_make(size : Int) -> SortdistflashModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistflashModel::len(self : SortdistflashModel) -> Int { self.size }

pub fn SortdistflashModel::get(self : SortdistflashModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistflashModel::set(self : SortdistflashModel, i : Int, v : Double) -> SortdistflashModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistflashModel::sum(self : SortdistflashModel) -> Double { @_common.sum(self.data) }

pub fn SortdistflashModel::mean(self : SortdistflashModel) -> Double { @_common.mean(self.data) }

pub fn SortdistflashModel::scale(self : SortdistflashModel, f : Double) -> SortdistflashModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistflashModel::add(self : SortdistflashModel, other : SortdistflashModel) -> SortdistflashModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistflashModel::copy(self : SortdistflashModel) -> SortdistflashModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistflashModel::fill(self : SortdistflashModel, v : Double) -> SortdistflashModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistflashModel::min(self : SortdistflashModel) -> Double { @_common.min(self.data) }

pub fn SortdistflashModel::max(self : SortdistflashModel) -> Double { @_common.max(self.data) }

pub fn SortdistflashModel::to_string(self : SortdistflashModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistflashLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_layer_make(size : Int) -> SortdistflashLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistflashLayer::len(self : SortdistflashLayer) -> Int { self.size }

pub fn SortdistflashLayer::get(self : SortdistflashLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistflashLayer::set(self : SortdistflashLayer, i : Int, v : Double) -> SortdistflashLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistflashLayer::sum(self : SortdistflashLayer) -> Double { @_common.sum(self.data) }

pub fn SortdistflashLayer::mean(self : SortdistflashLayer) -> Double { @_common.mean(self.data) }

pub fn SortdistflashLayer::scale(self : SortdistflashLayer, f : Double) -> SortdistflashLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistflashLayer::add(self : SortdistflashLayer, other : SortdistflashLayer) -> SortdistflashLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistflashLayer::copy(self : SortdistflashLayer) -> SortdistflashLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistflashLayer::fill(self : SortdistflashLayer, v : Double) -> SortdistflashLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistflashLayer::min(self : SortdistflashLayer) -> Double { @_common.min(self.data) }

pub fn SortdistflashLayer::max(self : SortdistflashLayer) -> Double { @_common.max(self.data) }

pub fn SortdistflashLayer::to_string(self : SortdistflashLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistflashBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_buffer_make(size : Int) -> SortdistflashBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistflashBuffer::len(self : SortdistflashBuffer) -> Int { self.size }

pub fn SortdistflashBuffer::get(self : SortdistflashBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistflashBuffer::set(self : SortdistflashBuffer, i : Int, v : Double) -> SortdistflashBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistflashBuffer::sum(self : SortdistflashBuffer) -> Double { @_common.sum(self.data) }

pub fn SortdistflashBuffer::mean(self : SortdistflashBuffer) -> Double { @_common.mean(self.data) }

pub fn SortdistflashBuffer::scale(self : SortdistflashBuffer, f : Double) -> SortdistflashBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistflashBuffer::add(self : SortdistflashBuffer, other : SortdistflashBuffer) -> SortdistflashBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistflashBuffer::copy(self : SortdistflashBuffer) -> SortdistflashBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistflashBuffer::fill(self : SortdistflashBuffer, v : Double) -> SortdistflashBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistflashBuffer::min(self : SortdistflashBuffer) -> Double { @_common.min(self.data) }

pub fn SortdistflashBuffer::max(self : SortdistflashBuffer) -> Double { @_common.max(self.data) }

pub fn SortdistflashBuffer::to_string(self : SortdistflashBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistflashCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_cursor_make(size : Int) -> SortdistflashCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistflashCursor::len(self : SortdistflashCursor) -> Int { self.size }

pub fn SortdistflashCursor::get(self : SortdistflashCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistflashCursor::set(self : SortdistflashCursor, i : Int, v : Double) -> SortdistflashCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistflashCursor::sum(self : SortdistflashCursor) -> Double { @_common.sum(self.data) }

pub fn SortdistflashCursor::mean(self : SortdistflashCursor) -> Double { @_common.mean(self.data) }

pub fn SortdistflashCursor::scale(self : SortdistflashCursor, f : Double) -> SortdistflashCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistflashCursor::add(self : SortdistflashCursor, other : SortdistflashCursor) -> SortdistflashCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistflashCursor::copy(self : SortdistflashCursor) -> SortdistflashCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistflashCursor::fill(self : SortdistflashCursor, v : Double) -> SortdistflashCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistflashCursor::min(self : SortdistflashCursor) -> Double { @_common.min(self.data) }

pub fn SortdistflashCursor::max(self : SortdistflashCursor) -> Double { @_common.max(self.data) }

pub fn SortdistflashCursor::to_string(self : SortdistflashCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistflashView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_view_make(size : Int) -> SortdistflashView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistflashView::len(self : SortdistflashView) -> Int { self.size }

pub fn SortdistflashView::get(self : SortdistflashView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistflashView::set(self : SortdistflashView, i : Int, v : Double) -> SortdistflashView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistflashView::sum(self : SortdistflashView) -> Double { @_common.sum(self.data) }

pub fn SortdistflashView::mean(self : SortdistflashView) -> Double { @_common.mean(self.data) }

pub fn SortdistflashView::scale(self : SortdistflashView, f : Double) -> SortdistflashView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistflashView::add(self : SortdistflashView, other : SortdistflashView) -> SortdistflashView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistflashView::copy(self : SortdistflashView) -> SortdistflashView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistflashView::fill(self : SortdistflashView, v : Double) -> SortdistflashView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistflashView::min(self : SortdistflashView) -> Double { @_common.min(self.data) }

pub fn SortdistflashView::max(self : SortdistflashView) -> Double { @_common.max(self.data) }

pub fn SortdistflashView::to_string(self : SortdistflashView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistflashRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_range_make(size : Int) -> SortdistflashRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistflashRange::len(self : SortdistflashRange) -> Int { self.size }

pub fn SortdistflashRange::get(self : SortdistflashRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistflashRange::set(self : SortdistflashRange, i : Int, v : Double) -> SortdistflashRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistflashRange::sum(self : SortdistflashRange) -> Double { @_common.sum(self.data) }

pub fn SortdistflashRange::mean(self : SortdistflashRange) -> Double { @_common.mean(self.data) }

pub fn SortdistflashRange::scale(self : SortdistflashRange, f : Double) -> SortdistflashRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistflashRange::add(self : SortdistflashRange, other : SortdistflashRange) -> SortdistflashRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistflashRange::copy(self : SortdistflashRange) -> SortdistflashRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistflashRange::fill(self : SortdistflashRange, v : Double) -> SortdistflashRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistflashRange::min(self : SortdistflashRange) -> Double { @_common.min(self.data) }

pub fn SortdistflashRange::max(self : SortdistflashRange) -> Double { @_common.max(self.data) }

pub fn SortdistflashRange::to_string(self : SortdistflashRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistflashSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_flash_slice_make(size : Int) -> SortdistflashSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistflashSlice::len(self : SortdistflashSlice) -> Int { self.size }

pub fn SortdistflashSlice::get(self : SortdistflashSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistflashSlice::set(self : SortdistflashSlice, i : Int, v : Double) -> SortdistflashSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistflashSlice::sum(self : SortdistflashSlice) -> Double { @_common.sum(self.data) }

pub fn SortdistflashSlice::mean(self : SortdistflashSlice) -> Double { @_common.mean(self.data) }

pub fn SortdistflashSlice::scale(self : SortdistflashSlice, f : Double) -> SortdistflashSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistflashSlice::add(self : SortdistflashSlice, other : SortdistflashSlice) -> SortdistflashSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistflashSlice::copy(self : SortdistflashSlice) -> SortdistflashSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistflashSlice::fill(self : SortdistflashSlice, v : Double) -> SortdistflashSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistflashSlice::min(self : SortdistflashSlice) -> Double { @_common.min(self.data) }

pub fn SortdistflashSlice::max(self : SortdistflashSlice) -> Double { @_common.max(self.data) }

pub fn SortdistflashSlice::to_string(self : SortdistflashSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

