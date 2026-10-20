///===
/// extcore/sort_dist_msd

pub(all) struct SortdistmsdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_dist_msd_make_point(x : Double, y : Double) -> SortdistmsdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_dist_msd_make_point3(x : Double, y : Double, z : Double) -> SortdistmsdPoint {
  { x, y, z, label: 0 }
}

pub fn SortdistmsdPoint::x(self : SortdistmsdPoint) -> Double { self.x }

pub fn SortdistmsdPoint::y(self : SortdistmsdPoint) -> Double { self.y }

pub fn SortdistmsdPoint::z(self : SortdistmsdPoint) -> Double { self.z }

pub fn SortdistmsdPoint::label(self : SortdistmsdPoint) -> Int { self.label }

pub fn SortdistmsdPoint::dist(self : SortdistmsdPoint, other : SortdistmsdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortdistmsdPoint::add(self : SortdistmsdPoint, other : SortdistmsdPoint) -> SortdistmsdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortdistmsdPoint::sub(self : SortdistmsdPoint, other : SortdistmsdPoint) -> SortdistmsdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortdistmsdPoint::scale(self : SortdistmsdPoint, s : Double) -> SortdistmsdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortdistmsdPoint::dot(self : SortdistmsdPoint, other : SortdistmsdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortdistmsdPoint::cross(self : SortdistmsdPoint, other : SortdistmsdPoint) -> SortdistmsdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortdistmsdPoint::norm(self : SortdistmsdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortdistmsdPoint::normalize(self : SortdistmsdPoint) -> SortdistmsdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistmsdPoint::negate(self : SortdistmsdPoint) -> SortdistmsdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortdistmsdPoint::mid(self : SortdistmsdPoint, other : SortdistmsdPoint) -> SortdistmsdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortdistmsdPoint::lerp(self : SortdistmsdPoint, other : SortdistmsdPoint, t : Double) -> SortdistmsdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortdistmsdPoint::to_string(self : SortdistmsdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortdistmsdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_dist_msd_make_series(vals : Array[Double], name : String) -> SortdistmsdSeries {
  { vals, name, meta: 0 }
}

pub fn SortdistmsdSeries::len(self : SortdistmsdSeries) -> Int { self.vals.length() }

pub fn SortdistmsdSeries::sum(self : SortdistmsdSeries) -> Double { @_common.sum(self.vals) }

pub fn SortdistmsdSeries::mean(self : SortdistmsdSeries) -> Double { @_common.mean(self.vals) }

pub fn SortdistmsdSeries::min(self : SortdistmsdSeries) -> Double { @_common.min(self.vals) }

pub fn SortdistmsdSeries::max(self : SortdistmsdSeries) -> Double { @_common.max(self.vals) }

pub fn SortdistmsdSeries::range(self : SortdistmsdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortdistmsdSeries::variance(self : SortdistmsdSeries) -> Double { @_common.variance(self.vals) }

pub fn SortdistmsdSeries::std(self : SortdistmsdSeries) -> Double { @_common.std(self.vals) }

pub fn SortdistmsdSeries::median(self : SortdistmsdSeries) -> Double { @_common.median(self.vals) }

pub fn SortdistmsdSeries::scale(self : SortdistmsdSeries, f : Double) -> SortdistmsdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortdistmsdSeries::add(self : SortdistmsdSeries, other : SortdistmsdSeries) -> SortdistmsdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortdistmsdSeries::sub(self : SortdistmsdSeries, other : SortdistmsdSeries) -> SortdistmsdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortdistmsdSeries::normalize(self : SortdistmsdSeries) -> SortdistmsdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortdistmsdSeries::cumsum(self : SortdistmsdSeries) -> SortdistmsdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortdistmsdSeries::to_string(self : SortdistmsdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortdistmsdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_dist_msd_make_matrix(rows : Int, cols : Int, val : Double) -> SortdistmsdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_dist_msd_matrix_identity(n : Int) -> SortdistmsdMatrix {
  let m = sort_dist_msd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortdistmsdMatrix::get(self : SortdistmsdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortdistmsdMatrix::transpose(self : SortdistmsdMatrix) -> SortdistmsdMatrix {
  let result = sort_dist_msd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortdistmsdMatrix::add(self : SortdistmsdMatrix, other : SortdistmsdMatrix) -> SortdistmsdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_dist_msd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortdistmsdMatrix::scale(self : SortdistmsdMatrix, s : Double) -> SortdistmsdMatrix {
  let result = sort_dist_msd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortdistmsdMatrix::multiply(self : SortdistmsdMatrix, other : SortdistmsdMatrix) -> SortdistmsdMatrix {
  if self.cols != other.rows { return sort_dist_msd_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_dist_msd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortdistmsdMatrix::trace(self : SortdistmsdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortdistmsdMatrix::det(self : SortdistmsdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortdistmsdMatrix::norm(self : SortdistmsdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortdistmsdMatrix::to_string(self : SortdistmsdMatrix) -> String {
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

pub(all) struct SortdistmsdVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_dist_msd_make_vector(comps : Array[Double]) -> SortdistmsdVector {
  { comps, dim: comps.length() }
}

pub fn sort_dist_msd_vector_zero(dim : Int) -> SortdistmsdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortdistmsdVector::add(self : SortdistmsdVector, other : SortdistmsdVector) -> SortdistmsdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistmsdVector::sub(self : SortdistmsdVector, other : SortdistmsdVector) -> SortdistmsdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortdistmsdVector::scale(self : SortdistmsdVector, s : Double) -> SortdistmsdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortdistmsdVector::dot(self : SortdistmsdVector, other : SortdistmsdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortdistmsdVector::norm(self : SortdistmsdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortdistmsdVector::normalize(self : SortdistmsdVector) -> SortdistmsdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortdistmsdVector::dist(self : SortdistmsdVector, other : SortdistmsdVector) -> Double {
  self.sub(other).norm()
}

pub fn SortdistmsdVector::to_string(self : SortdistmsdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_dist_msd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_dist_msd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_dist_msd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_dist_msd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_dist_msd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_dist_msd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_dist_msd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_dist_msd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_dist_msd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_dist_msd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_dist_msd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_dist_msd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_dist_msd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_dist_msd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_dist_msd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_dist_msd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_dist_msd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_dist_msd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_dist_msd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_dist_msd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_dist_msd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_dist_msd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_dist_msd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_dist_msd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_dist_msd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_dist_msd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_dist_msd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_dist_msd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_dist_msd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortdistmsdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_frame_make(size : Int) -> SortdistmsdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistmsdFrame::len(self : SortdistmsdFrame) -> Int { self.size }

pub fn SortdistmsdFrame::get(self : SortdistmsdFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistmsdFrame::set(self : SortdistmsdFrame, i : Int, v : Double) -> SortdistmsdFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistmsdFrame::sum(self : SortdistmsdFrame) -> Double { @_common.sum(self.data) }

pub fn SortdistmsdFrame::mean(self : SortdistmsdFrame) -> Double { @_common.mean(self.data) }

pub fn SortdistmsdFrame::scale(self : SortdistmsdFrame, f : Double) -> SortdistmsdFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistmsdFrame::add(self : SortdistmsdFrame, other : SortdistmsdFrame) -> SortdistmsdFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistmsdFrame::copy(self : SortdistmsdFrame) -> SortdistmsdFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistmsdFrame::fill(self : SortdistmsdFrame, v : Double) -> SortdistmsdFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistmsdFrame::min(self : SortdistmsdFrame) -> Double { @_common.min(self.data) }

pub fn SortdistmsdFrame::max(self : SortdistmsdFrame) -> Double { @_common.max(self.data) }

pub fn SortdistmsdFrame::to_string(self : SortdistmsdFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistmsdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_table_make(size : Int) -> SortdistmsdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistmsdTable::len(self : SortdistmsdTable) -> Int { self.size }

pub fn SortdistmsdTable::get(self : SortdistmsdTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistmsdTable::set(self : SortdistmsdTable, i : Int, v : Double) -> SortdistmsdTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistmsdTable::sum(self : SortdistmsdTable) -> Double { @_common.sum(self.data) }

pub fn SortdistmsdTable::mean(self : SortdistmsdTable) -> Double { @_common.mean(self.data) }

pub fn SortdistmsdTable::scale(self : SortdistmsdTable, f : Double) -> SortdistmsdTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistmsdTable::add(self : SortdistmsdTable, other : SortdistmsdTable) -> SortdistmsdTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistmsdTable::copy(self : SortdistmsdTable) -> SortdistmsdTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistmsdTable::fill(self : SortdistmsdTable, v : Double) -> SortdistmsdTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistmsdTable::min(self : SortdistmsdTable) -> Double { @_common.min(self.data) }

pub fn SortdistmsdTable::max(self : SortdistmsdTable) -> Double { @_common.max(self.data) }

pub fn SortdistmsdTable::to_string(self : SortdistmsdTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistmsdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_graphn_make(size : Int) -> SortdistmsdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistmsdGraphN::len(self : SortdistmsdGraphN) -> Int { self.size }

pub fn SortdistmsdGraphN::get(self : SortdistmsdGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistmsdGraphN::set(self : SortdistmsdGraphN, i : Int, v : Double) -> SortdistmsdGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistmsdGraphN::sum(self : SortdistmsdGraphN) -> Double { @_common.sum(self.data) }

pub fn SortdistmsdGraphN::mean(self : SortdistmsdGraphN) -> Double { @_common.mean(self.data) }

pub fn SortdistmsdGraphN::scale(self : SortdistmsdGraphN, f : Double) -> SortdistmsdGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistmsdGraphN::add(self : SortdistmsdGraphN, other : SortdistmsdGraphN) -> SortdistmsdGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistmsdGraphN::copy(self : SortdistmsdGraphN) -> SortdistmsdGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistmsdGraphN::fill(self : SortdistmsdGraphN, v : Double) -> SortdistmsdGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistmsdGraphN::min(self : SortdistmsdGraphN) -> Double { @_common.min(self.data) }

pub fn SortdistmsdGraphN::max(self : SortdistmsdGraphN) -> Double { @_common.max(self.data) }

pub fn SortdistmsdGraphN::to_string(self : SortdistmsdGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistmsdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_node_make(size : Int) -> SortdistmsdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistmsdNode::len(self : SortdistmsdNode) -> Int { self.size }

pub fn SortdistmsdNode::get(self : SortdistmsdNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistmsdNode::set(self : SortdistmsdNode, i : Int, v : Double) -> SortdistmsdNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistmsdNode::sum(self : SortdistmsdNode) -> Double { @_common.sum(self.data) }

pub fn SortdistmsdNode::mean(self : SortdistmsdNode) -> Double { @_common.mean(self.data) }

pub fn SortdistmsdNode::scale(self : SortdistmsdNode, f : Double) -> SortdistmsdNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistmsdNode::add(self : SortdistmsdNode, other : SortdistmsdNode) -> SortdistmsdNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistmsdNode::copy(self : SortdistmsdNode) -> SortdistmsdNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistmsdNode::fill(self : SortdistmsdNode, v : Double) -> SortdistmsdNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistmsdNode::min(self : SortdistmsdNode) -> Double { @_common.min(self.data) }

pub fn SortdistmsdNode::max(self : SortdistmsdNode) -> Double { @_common.max(self.data) }

pub fn SortdistmsdNode::to_string(self : SortdistmsdNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistmsdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_edge_make(size : Int) -> SortdistmsdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistmsdEdge::len(self : SortdistmsdEdge) -> Int { self.size }

pub fn SortdistmsdEdge::get(self : SortdistmsdEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistmsdEdge::set(self : SortdistmsdEdge, i : Int, v : Double) -> SortdistmsdEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistmsdEdge::sum(self : SortdistmsdEdge) -> Double { @_common.sum(self.data) }

pub fn SortdistmsdEdge::mean(self : SortdistmsdEdge) -> Double { @_common.mean(self.data) }

pub fn SortdistmsdEdge::scale(self : SortdistmsdEdge, f : Double) -> SortdistmsdEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistmsdEdge::add(self : SortdistmsdEdge, other : SortdistmsdEdge) -> SortdistmsdEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistmsdEdge::copy(self : SortdistmsdEdge) -> SortdistmsdEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistmsdEdge::fill(self : SortdistmsdEdge, v : Double) -> SortdistmsdEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistmsdEdge::min(self : SortdistmsdEdge) -> Double { @_common.min(self.data) }

pub fn SortdistmsdEdge::max(self : SortdistmsdEdge) -> Double { @_common.max(self.data) }

pub fn SortdistmsdEdge::to_string(self : SortdistmsdEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistmsdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_path_make(size : Int) -> SortdistmsdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistmsdPath::len(self : SortdistmsdPath) -> Int { self.size }

pub fn SortdistmsdPath::get(self : SortdistmsdPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistmsdPath::set(self : SortdistmsdPath, i : Int, v : Double) -> SortdistmsdPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistmsdPath::sum(self : SortdistmsdPath) -> Double { @_common.sum(self.data) }

pub fn SortdistmsdPath::mean(self : SortdistmsdPath) -> Double { @_common.mean(self.data) }

pub fn SortdistmsdPath::scale(self : SortdistmsdPath, f : Double) -> SortdistmsdPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistmsdPath::add(self : SortdistmsdPath, other : SortdistmsdPath) -> SortdistmsdPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistmsdPath::copy(self : SortdistmsdPath) -> SortdistmsdPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistmsdPath::fill(self : SortdistmsdPath, v : Double) -> SortdistmsdPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistmsdPath::min(self : SortdistmsdPath) -> Double { @_common.min(self.data) }

pub fn SortdistmsdPath::max(self : SortdistmsdPath) -> Double { @_common.max(self.data) }

pub fn SortdistmsdPath::to_string(self : SortdistmsdPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistmsdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_cluster_make(size : Int) -> SortdistmsdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistmsdCluster::len(self : SortdistmsdCluster) -> Int { self.size }

pub fn SortdistmsdCluster::get(self : SortdistmsdCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistmsdCluster::set(self : SortdistmsdCluster, i : Int, v : Double) -> SortdistmsdCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistmsdCluster::sum(self : SortdistmsdCluster) -> Double { @_common.sum(self.data) }

pub fn SortdistmsdCluster::mean(self : SortdistmsdCluster) -> Double { @_common.mean(self.data) }

pub fn SortdistmsdCluster::scale(self : SortdistmsdCluster, f : Double) -> SortdistmsdCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistmsdCluster::add(self : SortdistmsdCluster, other : SortdistmsdCluster) -> SortdistmsdCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistmsdCluster::copy(self : SortdistmsdCluster) -> SortdistmsdCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistmsdCluster::fill(self : SortdistmsdCluster, v : Double) -> SortdistmsdCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistmsdCluster::min(self : SortdistmsdCluster) -> Double { @_common.min(self.data) }

pub fn SortdistmsdCluster::max(self : SortdistmsdCluster) -> Double { @_common.max(self.data) }

pub fn SortdistmsdCluster::to_string(self : SortdistmsdCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistmsdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_model_make(size : Int) -> SortdistmsdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistmsdModel::len(self : SortdistmsdModel) -> Int { self.size }

pub fn SortdistmsdModel::get(self : SortdistmsdModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistmsdModel::set(self : SortdistmsdModel, i : Int, v : Double) -> SortdistmsdModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistmsdModel::sum(self : SortdistmsdModel) -> Double { @_common.sum(self.data) }

pub fn SortdistmsdModel::mean(self : SortdistmsdModel) -> Double { @_common.mean(self.data) }

pub fn SortdistmsdModel::scale(self : SortdistmsdModel, f : Double) -> SortdistmsdModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistmsdModel::add(self : SortdistmsdModel, other : SortdistmsdModel) -> SortdistmsdModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistmsdModel::copy(self : SortdistmsdModel) -> SortdistmsdModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistmsdModel::fill(self : SortdistmsdModel, v : Double) -> SortdistmsdModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistmsdModel::min(self : SortdistmsdModel) -> Double { @_common.min(self.data) }

pub fn SortdistmsdModel::max(self : SortdistmsdModel) -> Double { @_common.max(self.data) }

pub fn SortdistmsdModel::to_string(self : SortdistmsdModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistmsdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_layer_make(size : Int) -> SortdistmsdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistmsdLayer::len(self : SortdistmsdLayer) -> Int { self.size }

pub fn SortdistmsdLayer::get(self : SortdistmsdLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistmsdLayer::set(self : SortdistmsdLayer, i : Int, v : Double) -> SortdistmsdLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistmsdLayer::sum(self : SortdistmsdLayer) -> Double { @_common.sum(self.data) }

pub fn SortdistmsdLayer::mean(self : SortdistmsdLayer) -> Double { @_common.mean(self.data) }

pub fn SortdistmsdLayer::scale(self : SortdistmsdLayer, f : Double) -> SortdistmsdLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistmsdLayer::add(self : SortdistmsdLayer, other : SortdistmsdLayer) -> SortdistmsdLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistmsdLayer::copy(self : SortdistmsdLayer) -> SortdistmsdLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistmsdLayer::fill(self : SortdistmsdLayer, v : Double) -> SortdistmsdLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistmsdLayer::min(self : SortdistmsdLayer) -> Double { @_common.min(self.data) }

pub fn SortdistmsdLayer::max(self : SortdistmsdLayer) -> Double { @_common.max(self.data) }

pub fn SortdistmsdLayer::to_string(self : SortdistmsdLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistmsdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_buffer_make(size : Int) -> SortdistmsdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistmsdBuffer::len(self : SortdistmsdBuffer) -> Int { self.size }

pub fn SortdistmsdBuffer::get(self : SortdistmsdBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistmsdBuffer::set(self : SortdistmsdBuffer, i : Int, v : Double) -> SortdistmsdBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistmsdBuffer::sum(self : SortdistmsdBuffer) -> Double { @_common.sum(self.data) }

pub fn SortdistmsdBuffer::mean(self : SortdistmsdBuffer) -> Double { @_common.mean(self.data) }

pub fn SortdistmsdBuffer::scale(self : SortdistmsdBuffer, f : Double) -> SortdistmsdBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistmsdBuffer::add(self : SortdistmsdBuffer, other : SortdistmsdBuffer) -> SortdistmsdBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistmsdBuffer::copy(self : SortdistmsdBuffer) -> SortdistmsdBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistmsdBuffer::fill(self : SortdistmsdBuffer, v : Double) -> SortdistmsdBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistmsdBuffer::min(self : SortdistmsdBuffer) -> Double { @_common.min(self.data) }

pub fn SortdistmsdBuffer::max(self : SortdistmsdBuffer) -> Double { @_common.max(self.data) }

pub fn SortdistmsdBuffer::to_string(self : SortdistmsdBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistmsdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_cursor_make(size : Int) -> SortdistmsdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistmsdCursor::len(self : SortdistmsdCursor) -> Int { self.size }

pub fn SortdistmsdCursor::get(self : SortdistmsdCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistmsdCursor::set(self : SortdistmsdCursor, i : Int, v : Double) -> SortdistmsdCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistmsdCursor::sum(self : SortdistmsdCursor) -> Double { @_common.sum(self.data) }

pub fn SortdistmsdCursor::mean(self : SortdistmsdCursor) -> Double { @_common.mean(self.data) }

pub fn SortdistmsdCursor::scale(self : SortdistmsdCursor, f : Double) -> SortdistmsdCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistmsdCursor::add(self : SortdistmsdCursor, other : SortdistmsdCursor) -> SortdistmsdCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistmsdCursor::copy(self : SortdistmsdCursor) -> SortdistmsdCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistmsdCursor::fill(self : SortdistmsdCursor, v : Double) -> SortdistmsdCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistmsdCursor::min(self : SortdistmsdCursor) -> Double { @_common.min(self.data) }

pub fn SortdistmsdCursor::max(self : SortdistmsdCursor) -> Double { @_common.max(self.data) }

pub fn SortdistmsdCursor::to_string(self : SortdistmsdCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistmsdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_view_make(size : Int) -> SortdistmsdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistmsdView::len(self : SortdistmsdView) -> Int { self.size }

pub fn SortdistmsdView::get(self : SortdistmsdView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistmsdView::set(self : SortdistmsdView, i : Int, v : Double) -> SortdistmsdView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistmsdView::sum(self : SortdistmsdView) -> Double { @_common.sum(self.data) }

pub fn SortdistmsdView::mean(self : SortdistmsdView) -> Double { @_common.mean(self.data) }

pub fn SortdistmsdView::scale(self : SortdistmsdView, f : Double) -> SortdistmsdView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistmsdView::add(self : SortdistmsdView, other : SortdistmsdView) -> SortdistmsdView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistmsdView::copy(self : SortdistmsdView) -> SortdistmsdView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistmsdView::fill(self : SortdistmsdView, v : Double) -> SortdistmsdView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistmsdView::min(self : SortdistmsdView) -> Double { @_common.min(self.data) }

pub fn SortdistmsdView::max(self : SortdistmsdView) -> Double { @_common.max(self.data) }

pub fn SortdistmsdView::to_string(self : SortdistmsdView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistmsdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_range_make(size : Int) -> SortdistmsdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistmsdRange::len(self : SortdistmsdRange) -> Int { self.size }

pub fn SortdistmsdRange::get(self : SortdistmsdRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistmsdRange::set(self : SortdistmsdRange, i : Int, v : Double) -> SortdistmsdRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistmsdRange::sum(self : SortdistmsdRange) -> Double { @_common.sum(self.data) }

pub fn SortdistmsdRange::mean(self : SortdistmsdRange) -> Double { @_common.mean(self.data) }

pub fn SortdistmsdRange::scale(self : SortdistmsdRange, f : Double) -> SortdistmsdRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistmsdRange::add(self : SortdistmsdRange, other : SortdistmsdRange) -> SortdistmsdRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistmsdRange::copy(self : SortdistmsdRange) -> SortdistmsdRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistmsdRange::fill(self : SortdistmsdRange, v : Double) -> SortdistmsdRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistmsdRange::min(self : SortdistmsdRange) -> Double { @_common.min(self.data) }

pub fn SortdistmsdRange::max(self : SortdistmsdRange) -> Double { @_common.max(self.data) }

pub fn SortdistmsdRange::to_string(self : SortdistmsdRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortdistmsdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_dist_msd_slice_make(size : Int) -> SortdistmsdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortdistmsdSlice::len(self : SortdistmsdSlice) -> Int { self.size }

pub fn SortdistmsdSlice::get(self : SortdistmsdSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortdistmsdSlice::set(self : SortdistmsdSlice, i : Int, v : Double) -> SortdistmsdSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortdistmsdSlice::sum(self : SortdistmsdSlice) -> Double { @_common.sum(self.data) }

pub fn SortdistmsdSlice::mean(self : SortdistmsdSlice) -> Double { @_common.mean(self.data) }

pub fn SortdistmsdSlice::scale(self : SortdistmsdSlice, f : Double) -> SortdistmsdSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortdistmsdSlice::add(self : SortdistmsdSlice, other : SortdistmsdSlice) -> SortdistmsdSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortdistmsdSlice::copy(self : SortdistmsdSlice) -> SortdistmsdSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortdistmsdSlice::fill(self : SortdistmsdSlice, v : Double) -> SortdistmsdSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortdistmsdSlice::min(self : SortdistmsdSlice) -> Double { @_common.min(self.data) }

pub fn SortdistmsdSlice::max(self : SortdistmsdSlice) -> Double { @_common.max(self.data) }

pub fn SortdistmsdSlice::to_string(self : SortdistmsdSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

