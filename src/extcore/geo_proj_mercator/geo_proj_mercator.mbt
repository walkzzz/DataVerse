///===
/// extcore/geo_proj_mercator

pub(all) struct GeoprojmercatorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_mercator_make_point(x : Double, y : Double) -> GeoprojmercatorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_mercator_make_point3(x : Double, y : Double, z : Double) -> GeoprojmercatorPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojmercatorPoint::x(self : GeoprojmercatorPoint) -> Double { self.x }

pub fn GeoprojmercatorPoint::y(self : GeoprojmercatorPoint) -> Double { self.y }

pub fn GeoprojmercatorPoint::z(self : GeoprojmercatorPoint) -> Double { self.z }

pub fn GeoprojmercatorPoint::label(self : GeoprojmercatorPoint) -> Int { self.label }

pub fn GeoprojmercatorPoint::dist(self : GeoprojmercatorPoint, other : GeoprojmercatorPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojmercatorPoint::add(self : GeoprojmercatorPoint, other : GeoprojmercatorPoint) -> GeoprojmercatorPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojmercatorPoint::sub(self : GeoprojmercatorPoint, other : GeoprojmercatorPoint) -> GeoprojmercatorPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojmercatorPoint::scale(self : GeoprojmercatorPoint, s : Double) -> GeoprojmercatorPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojmercatorPoint::dot(self : GeoprojmercatorPoint, other : GeoprojmercatorPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojmercatorPoint::cross(self : GeoprojmercatorPoint, other : GeoprojmercatorPoint) -> GeoprojmercatorPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojmercatorPoint::norm(self : GeoprojmercatorPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojmercatorPoint::normalize(self : GeoprojmercatorPoint) -> GeoprojmercatorPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojmercatorPoint::negate(self : GeoprojmercatorPoint) -> GeoprojmercatorPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojmercatorPoint::mid(self : GeoprojmercatorPoint, other : GeoprojmercatorPoint) -> GeoprojmercatorPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojmercatorPoint::lerp(self : GeoprojmercatorPoint, other : GeoprojmercatorPoint, t : Double) -> GeoprojmercatorPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojmercatorPoint::to_string(self : GeoprojmercatorPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojmercatorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_mercator_make_series(vals : Array[Double], name : String) -> GeoprojmercatorSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojmercatorSeries::len(self : GeoprojmercatorSeries) -> Int { self.vals.length() }

pub fn GeoprojmercatorSeries::sum(self : GeoprojmercatorSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojmercatorSeries::mean(self : GeoprojmercatorSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojmercatorSeries::min(self : GeoprojmercatorSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojmercatorSeries::max(self : GeoprojmercatorSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojmercatorSeries::range(self : GeoprojmercatorSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojmercatorSeries::variance(self : GeoprojmercatorSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojmercatorSeries::std(self : GeoprojmercatorSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojmercatorSeries::median(self : GeoprojmercatorSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojmercatorSeries::scale(self : GeoprojmercatorSeries, f : Double) -> GeoprojmercatorSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojmercatorSeries::add(self : GeoprojmercatorSeries, other : GeoprojmercatorSeries) -> GeoprojmercatorSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojmercatorSeries::sub(self : GeoprojmercatorSeries, other : GeoprojmercatorSeries) -> GeoprojmercatorSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojmercatorSeries::normalize(self : GeoprojmercatorSeries) -> GeoprojmercatorSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojmercatorSeries::cumsum(self : GeoprojmercatorSeries) -> GeoprojmercatorSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojmercatorSeries::to_string(self : GeoprojmercatorSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojmercatorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_mercator_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojmercatorMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_mercator_matrix_identity(n : Int) -> GeoprojmercatorMatrix {
  let m = geo_proj_mercator_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojmercatorMatrix::get(self : GeoprojmercatorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojmercatorMatrix::transpose(self : GeoprojmercatorMatrix) -> GeoprojmercatorMatrix {
  let result = geo_proj_mercator_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojmercatorMatrix::add(self : GeoprojmercatorMatrix, other : GeoprojmercatorMatrix) -> GeoprojmercatorMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_mercator_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojmercatorMatrix::scale(self : GeoprojmercatorMatrix, s : Double) -> GeoprojmercatorMatrix {
  let result = geo_proj_mercator_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojmercatorMatrix::multiply(self : GeoprojmercatorMatrix, other : GeoprojmercatorMatrix) -> GeoprojmercatorMatrix {
  if self.cols != other.rows { return geo_proj_mercator_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_mercator_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeoprojmercatorMatrix::trace(self : GeoprojmercatorMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojmercatorMatrix::det(self : GeoprojmercatorMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojmercatorMatrix::norm(self : GeoprojmercatorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojmercatorMatrix::to_string(self : GeoprojmercatorMatrix) -> String {
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

pub(all) struct GeoprojmercatorVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_mercator_make_vector(comps : Array[Double]) -> GeoprojmercatorVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_mercator_vector_zero(dim : Int) -> GeoprojmercatorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojmercatorVector::add(self : GeoprojmercatorVector, other : GeoprojmercatorVector) -> GeoprojmercatorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojmercatorVector::sub(self : GeoprojmercatorVector, other : GeoprojmercatorVector) -> GeoprojmercatorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojmercatorVector::scale(self : GeoprojmercatorVector, s : Double) -> GeoprojmercatorVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojmercatorVector::dot(self : GeoprojmercatorVector, other : GeoprojmercatorVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojmercatorVector::norm(self : GeoprojmercatorVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojmercatorVector::normalize(self : GeoprojmercatorVector) -> GeoprojmercatorVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojmercatorVector::dist(self : GeoprojmercatorVector, other : GeoprojmercatorVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojmercatorVector::to_string(self : GeoprojmercatorVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_mercator_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_mercator_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_mercator_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_mercator_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_mercator_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_mercator_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_mercator_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_mercator_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_mercator_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_mercator_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_mercator_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_mercator_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_mercator_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_mercator_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_mercator_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_mercator_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_mercator_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_mercator_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_mercator_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_mercator_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_mercator_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_mercator_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_mercator_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_mercator_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_mercator_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_mercator_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_mercator_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_mercator_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_mercator_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojmercatorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_frame_make(size : Int) -> GeoprojmercatorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojmercatorFrame::len(self : GeoprojmercatorFrame) -> Int { self.size }

pub fn GeoprojmercatorFrame::get(self : GeoprojmercatorFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojmercatorFrame::set(self : GeoprojmercatorFrame, i : Int, v : Double) -> GeoprojmercatorFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorFrame::sum(self : GeoprojmercatorFrame) -> Double { @_common.sum(self.data) }

pub fn GeoprojmercatorFrame::mean(self : GeoprojmercatorFrame) -> Double { @_common.mean(self.data) }

pub fn GeoprojmercatorFrame::scale(self : GeoprojmercatorFrame, f : Double) -> GeoprojmercatorFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorFrame::add(self : GeoprojmercatorFrame, other : GeoprojmercatorFrame) -> GeoprojmercatorFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojmercatorFrame::copy(self : GeoprojmercatorFrame) -> GeoprojmercatorFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorFrame::fill(self : GeoprojmercatorFrame, v : Double) -> GeoprojmercatorFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorFrame::min(self : GeoprojmercatorFrame) -> Double { @_common.min(self.data) }

pub fn GeoprojmercatorFrame::max(self : GeoprojmercatorFrame) -> Double { @_common.max(self.data) }

pub fn GeoprojmercatorFrame::to_string(self : GeoprojmercatorFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_table_make(size : Int) -> GeoprojmercatorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojmercatorTable::len(self : GeoprojmercatorTable) -> Int { self.size }

pub fn GeoprojmercatorTable::get(self : GeoprojmercatorTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojmercatorTable::set(self : GeoprojmercatorTable, i : Int, v : Double) -> GeoprojmercatorTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorTable::sum(self : GeoprojmercatorTable) -> Double { @_common.sum(self.data) }

pub fn GeoprojmercatorTable::mean(self : GeoprojmercatorTable) -> Double { @_common.mean(self.data) }

pub fn GeoprojmercatorTable::scale(self : GeoprojmercatorTable, f : Double) -> GeoprojmercatorTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorTable::add(self : GeoprojmercatorTable, other : GeoprojmercatorTable) -> GeoprojmercatorTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojmercatorTable::copy(self : GeoprojmercatorTable) -> GeoprojmercatorTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorTable::fill(self : GeoprojmercatorTable, v : Double) -> GeoprojmercatorTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorTable::min(self : GeoprojmercatorTable) -> Double { @_common.min(self.data) }

pub fn GeoprojmercatorTable::max(self : GeoprojmercatorTable) -> Double { @_common.max(self.data) }

pub fn GeoprojmercatorTable::to_string(self : GeoprojmercatorTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_graphn_make(size : Int) -> GeoprojmercatorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojmercatorGraphN::len(self : GeoprojmercatorGraphN) -> Int { self.size }

pub fn GeoprojmercatorGraphN::get(self : GeoprojmercatorGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojmercatorGraphN::set(self : GeoprojmercatorGraphN, i : Int, v : Double) -> GeoprojmercatorGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorGraphN::sum(self : GeoprojmercatorGraphN) -> Double { @_common.sum(self.data) }

pub fn GeoprojmercatorGraphN::mean(self : GeoprojmercatorGraphN) -> Double { @_common.mean(self.data) }

pub fn GeoprojmercatorGraphN::scale(self : GeoprojmercatorGraphN, f : Double) -> GeoprojmercatorGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorGraphN::add(self : GeoprojmercatorGraphN, other : GeoprojmercatorGraphN) -> GeoprojmercatorGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojmercatorGraphN::copy(self : GeoprojmercatorGraphN) -> GeoprojmercatorGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorGraphN::fill(self : GeoprojmercatorGraphN, v : Double) -> GeoprojmercatorGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorGraphN::min(self : GeoprojmercatorGraphN) -> Double { @_common.min(self.data) }

pub fn GeoprojmercatorGraphN::max(self : GeoprojmercatorGraphN) -> Double { @_common.max(self.data) }

pub fn GeoprojmercatorGraphN::to_string(self : GeoprojmercatorGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_node_make(size : Int) -> GeoprojmercatorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojmercatorNode::len(self : GeoprojmercatorNode) -> Int { self.size }

pub fn GeoprojmercatorNode::get(self : GeoprojmercatorNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojmercatorNode::set(self : GeoprojmercatorNode, i : Int, v : Double) -> GeoprojmercatorNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorNode::sum(self : GeoprojmercatorNode) -> Double { @_common.sum(self.data) }

pub fn GeoprojmercatorNode::mean(self : GeoprojmercatorNode) -> Double { @_common.mean(self.data) }

pub fn GeoprojmercatorNode::scale(self : GeoprojmercatorNode, f : Double) -> GeoprojmercatorNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorNode::add(self : GeoprojmercatorNode, other : GeoprojmercatorNode) -> GeoprojmercatorNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojmercatorNode::copy(self : GeoprojmercatorNode) -> GeoprojmercatorNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorNode::fill(self : GeoprojmercatorNode, v : Double) -> GeoprojmercatorNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorNode::min(self : GeoprojmercatorNode) -> Double { @_common.min(self.data) }

pub fn GeoprojmercatorNode::max(self : GeoprojmercatorNode) -> Double { @_common.max(self.data) }

pub fn GeoprojmercatorNode::to_string(self : GeoprojmercatorNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_edge_make(size : Int) -> GeoprojmercatorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojmercatorEdge::len(self : GeoprojmercatorEdge) -> Int { self.size }

pub fn GeoprojmercatorEdge::get(self : GeoprojmercatorEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojmercatorEdge::set(self : GeoprojmercatorEdge, i : Int, v : Double) -> GeoprojmercatorEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorEdge::sum(self : GeoprojmercatorEdge) -> Double { @_common.sum(self.data) }

pub fn GeoprojmercatorEdge::mean(self : GeoprojmercatorEdge) -> Double { @_common.mean(self.data) }

pub fn GeoprojmercatorEdge::scale(self : GeoprojmercatorEdge, f : Double) -> GeoprojmercatorEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorEdge::add(self : GeoprojmercatorEdge, other : GeoprojmercatorEdge) -> GeoprojmercatorEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojmercatorEdge::copy(self : GeoprojmercatorEdge) -> GeoprojmercatorEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorEdge::fill(self : GeoprojmercatorEdge, v : Double) -> GeoprojmercatorEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorEdge::min(self : GeoprojmercatorEdge) -> Double { @_common.min(self.data) }

pub fn GeoprojmercatorEdge::max(self : GeoprojmercatorEdge) -> Double { @_common.max(self.data) }

pub fn GeoprojmercatorEdge::to_string(self : GeoprojmercatorEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_path_make(size : Int) -> GeoprojmercatorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojmercatorPath::len(self : GeoprojmercatorPath) -> Int { self.size }

pub fn GeoprojmercatorPath::get(self : GeoprojmercatorPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojmercatorPath::set(self : GeoprojmercatorPath, i : Int, v : Double) -> GeoprojmercatorPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorPath::sum(self : GeoprojmercatorPath) -> Double { @_common.sum(self.data) }

pub fn GeoprojmercatorPath::mean(self : GeoprojmercatorPath) -> Double { @_common.mean(self.data) }

pub fn GeoprojmercatorPath::scale(self : GeoprojmercatorPath, f : Double) -> GeoprojmercatorPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorPath::add(self : GeoprojmercatorPath, other : GeoprojmercatorPath) -> GeoprojmercatorPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojmercatorPath::copy(self : GeoprojmercatorPath) -> GeoprojmercatorPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorPath::fill(self : GeoprojmercatorPath, v : Double) -> GeoprojmercatorPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorPath::min(self : GeoprojmercatorPath) -> Double { @_common.min(self.data) }

pub fn GeoprojmercatorPath::max(self : GeoprojmercatorPath) -> Double { @_common.max(self.data) }

pub fn GeoprojmercatorPath::to_string(self : GeoprojmercatorPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_cluster_make(size : Int) -> GeoprojmercatorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojmercatorCluster::len(self : GeoprojmercatorCluster) -> Int { self.size }

pub fn GeoprojmercatorCluster::get(self : GeoprojmercatorCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojmercatorCluster::set(self : GeoprojmercatorCluster, i : Int, v : Double) -> GeoprojmercatorCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorCluster::sum(self : GeoprojmercatorCluster) -> Double { @_common.sum(self.data) }

pub fn GeoprojmercatorCluster::mean(self : GeoprojmercatorCluster) -> Double { @_common.mean(self.data) }

pub fn GeoprojmercatorCluster::scale(self : GeoprojmercatorCluster, f : Double) -> GeoprojmercatorCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorCluster::add(self : GeoprojmercatorCluster, other : GeoprojmercatorCluster) -> GeoprojmercatorCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojmercatorCluster::copy(self : GeoprojmercatorCluster) -> GeoprojmercatorCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorCluster::fill(self : GeoprojmercatorCluster, v : Double) -> GeoprojmercatorCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorCluster::min(self : GeoprojmercatorCluster) -> Double { @_common.min(self.data) }

pub fn GeoprojmercatorCluster::max(self : GeoprojmercatorCluster) -> Double { @_common.max(self.data) }

pub fn GeoprojmercatorCluster::to_string(self : GeoprojmercatorCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_model_make(size : Int) -> GeoprojmercatorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojmercatorModel::len(self : GeoprojmercatorModel) -> Int { self.size }

pub fn GeoprojmercatorModel::get(self : GeoprojmercatorModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojmercatorModel::set(self : GeoprojmercatorModel, i : Int, v : Double) -> GeoprojmercatorModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorModel::sum(self : GeoprojmercatorModel) -> Double { @_common.sum(self.data) }

pub fn GeoprojmercatorModel::mean(self : GeoprojmercatorModel) -> Double { @_common.mean(self.data) }

pub fn GeoprojmercatorModel::scale(self : GeoprojmercatorModel, f : Double) -> GeoprojmercatorModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorModel::add(self : GeoprojmercatorModel, other : GeoprojmercatorModel) -> GeoprojmercatorModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojmercatorModel::copy(self : GeoprojmercatorModel) -> GeoprojmercatorModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorModel::fill(self : GeoprojmercatorModel, v : Double) -> GeoprojmercatorModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorModel::min(self : GeoprojmercatorModel) -> Double { @_common.min(self.data) }

pub fn GeoprojmercatorModel::max(self : GeoprojmercatorModel) -> Double { @_common.max(self.data) }

pub fn GeoprojmercatorModel::to_string(self : GeoprojmercatorModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_layer_make(size : Int) -> GeoprojmercatorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojmercatorLayer::len(self : GeoprojmercatorLayer) -> Int { self.size }

pub fn GeoprojmercatorLayer::get(self : GeoprojmercatorLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojmercatorLayer::set(self : GeoprojmercatorLayer, i : Int, v : Double) -> GeoprojmercatorLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorLayer::sum(self : GeoprojmercatorLayer) -> Double { @_common.sum(self.data) }

pub fn GeoprojmercatorLayer::mean(self : GeoprojmercatorLayer) -> Double { @_common.mean(self.data) }

pub fn GeoprojmercatorLayer::scale(self : GeoprojmercatorLayer, f : Double) -> GeoprojmercatorLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorLayer::add(self : GeoprojmercatorLayer, other : GeoprojmercatorLayer) -> GeoprojmercatorLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojmercatorLayer::copy(self : GeoprojmercatorLayer) -> GeoprojmercatorLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorLayer::fill(self : GeoprojmercatorLayer, v : Double) -> GeoprojmercatorLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorLayer::min(self : GeoprojmercatorLayer) -> Double { @_common.min(self.data) }

pub fn GeoprojmercatorLayer::max(self : GeoprojmercatorLayer) -> Double { @_common.max(self.data) }

pub fn GeoprojmercatorLayer::to_string(self : GeoprojmercatorLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_buffer_make(size : Int) -> GeoprojmercatorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojmercatorBuffer::len(self : GeoprojmercatorBuffer) -> Int { self.size }

pub fn GeoprojmercatorBuffer::get(self : GeoprojmercatorBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojmercatorBuffer::set(self : GeoprojmercatorBuffer, i : Int, v : Double) -> GeoprojmercatorBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorBuffer::sum(self : GeoprojmercatorBuffer) -> Double { @_common.sum(self.data) }

pub fn GeoprojmercatorBuffer::mean(self : GeoprojmercatorBuffer) -> Double { @_common.mean(self.data) }

pub fn GeoprojmercatorBuffer::scale(self : GeoprojmercatorBuffer, f : Double) -> GeoprojmercatorBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorBuffer::add(self : GeoprojmercatorBuffer, other : GeoprojmercatorBuffer) -> GeoprojmercatorBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojmercatorBuffer::copy(self : GeoprojmercatorBuffer) -> GeoprojmercatorBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorBuffer::fill(self : GeoprojmercatorBuffer, v : Double) -> GeoprojmercatorBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorBuffer::min(self : GeoprojmercatorBuffer) -> Double { @_common.min(self.data) }

pub fn GeoprojmercatorBuffer::max(self : GeoprojmercatorBuffer) -> Double { @_common.max(self.data) }

pub fn GeoprojmercatorBuffer::to_string(self : GeoprojmercatorBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_cursor_make(size : Int) -> GeoprojmercatorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojmercatorCursor::len(self : GeoprojmercatorCursor) -> Int { self.size }

pub fn GeoprojmercatorCursor::get(self : GeoprojmercatorCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojmercatorCursor::set(self : GeoprojmercatorCursor, i : Int, v : Double) -> GeoprojmercatorCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorCursor::sum(self : GeoprojmercatorCursor) -> Double { @_common.sum(self.data) }

pub fn GeoprojmercatorCursor::mean(self : GeoprojmercatorCursor) -> Double { @_common.mean(self.data) }

pub fn GeoprojmercatorCursor::scale(self : GeoprojmercatorCursor, f : Double) -> GeoprojmercatorCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorCursor::add(self : GeoprojmercatorCursor, other : GeoprojmercatorCursor) -> GeoprojmercatorCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojmercatorCursor::copy(self : GeoprojmercatorCursor) -> GeoprojmercatorCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorCursor::fill(self : GeoprojmercatorCursor, v : Double) -> GeoprojmercatorCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorCursor::min(self : GeoprojmercatorCursor) -> Double { @_common.min(self.data) }

pub fn GeoprojmercatorCursor::max(self : GeoprojmercatorCursor) -> Double { @_common.max(self.data) }

pub fn GeoprojmercatorCursor::to_string(self : GeoprojmercatorCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_view_make(size : Int) -> GeoprojmercatorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojmercatorView::len(self : GeoprojmercatorView) -> Int { self.size }

pub fn GeoprojmercatorView::get(self : GeoprojmercatorView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojmercatorView::set(self : GeoprojmercatorView, i : Int, v : Double) -> GeoprojmercatorView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorView::sum(self : GeoprojmercatorView) -> Double { @_common.sum(self.data) }

pub fn GeoprojmercatorView::mean(self : GeoprojmercatorView) -> Double { @_common.mean(self.data) }

pub fn GeoprojmercatorView::scale(self : GeoprojmercatorView, f : Double) -> GeoprojmercatorView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorView::add(self : GeoprojmercatorView, other : GeoprojmercatorView) -> GeoprojmercatorView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojmercatorView::copy(self : GeoprojmercatorView) -> GeoprojmercatorView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorView::fill(self : GeoprojmercatorView, v : Double) -> GeoprojmercatorView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorView::min(self : GeoprojmercatorView) -> Double { @_common.min(self.data) }

pub fn GeoprojmercatorView::max(self : GeoprojmercatorView) -> Double { @_common.max(self.data) }

pub fn GeoprojmercatorView::to_string(self : GeoprojmercatorView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_range_make(size : Int) -> GeoprojmercatorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojmercatorRange::len(self : GeoprojmercatorRange) -> Int { self.size }

pub fn GeoprojmercatorRange::get(self : GeoprojmercatorRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojmercatorRange::set(self : GeoprojmercatorRange, i : Int, v : Double) -> GeoprojmercatorRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorRange::sum(self : GeoprojmercatorRange) -> Double { @_common.sum(self.data) }

pub fn GeoprojmercatorRange::mean(self : GeoprojmercatorRange) -> Double { @_common.mean(self.data) }

pub fn GeoprojmercatorRange::scale(self : GeoprojmercatorRange, f : Double) -> GeoprojmercatorRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorRange::add(self : GeoprojmercatorRange, other : GeoprojmercatorRange) -> GeoprojmercatorRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojmercatorRange::copy(self : GeoprojmercatorRange) -> GeoprojmercatorRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorRange::fill(self : GeoprojmercatorRange, v : Double) -> GeoprojmercatorRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorRange::min(self : GeoprojmercatorRange) -> Double { @_common.min(self.data) }

pub fn GeoprojmercatorRange::max(self : GeoprojmercatorRange) -> Double { @_common.max(self.data) }

pub fn GeoprojmercatorRange::to_string(self : GeoprojmercatorRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeoprojmercatorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_mercator_slice_make(size : Int) -> GeoprojmercatorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeoprojmercatorSlice::len(self : GeoprojmercatorSlice) -> Int { self.size }

pub fn GeoprojmercatorSlice::get(self : GeoprojmercatorSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeoprojmercatorSlice::set(self : GeoprojmercatorSlice, i : Int, v : Double) -> GeoprojmercatorSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorSlice::sum(self : GeoprojmercatorSlice) -> Double { @_common.sum(self.data) }

pub fn GeoprojmercatorSlice::mean(self : GeoprojmercatorSlice) -> Double { @_common.mean(self.data) }

pub fn GeoprojmercatorSlice::scale(self : GeoprojmercatorSlice, f : Double) -> GeoprojmercatorSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorSlice::add(self : GeoprojmercatorSlice, other : GeoprojmercatorSlice) -> GeoprojmercatorSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeoprojmercatorSlice::copy(self : GeoprojmercatorSlice) -> GeoprojmercatorSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorSlice::fill(self : GeoprojmercatorSlice, v : Double) -> GeoprojmercatorSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeoprojmercatorSlice::min(self : GeoprojmercatorSlice) -> Double { @_common.min(self.data) }

pub fn GeoprojmercatorSlice::max(self : GeoprojmercatorSlice) -> Double { @_common.max(self.data) }

pub fn GeoprojmercatorSlice::to_string(self : GeoprojmercatorSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

