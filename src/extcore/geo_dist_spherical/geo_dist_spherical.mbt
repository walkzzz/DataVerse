///===
/// extcore/geo_dist_spherical

pub(all) struct GeodistsphericalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_spherical_make_point(x : Double, y : Double) -> GeodistsphericalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_spherical_make_point3(x : Double, y : Double, z : Double) -> GeodistsphericalPoint {
  { x, y, z, label: 0 }
}

pub fn GeodistsphericalPoint::x(self : GeodistsphericalPoint) -> Double { self.x }

pub fn GeodistsphericalPoint::y(self : GeodistsphericalPoint) -> Double { self.y }

pub fn GeodistsphericalPoint::z(self : GeodistsphericalPoint) -> Double { self.z }

pub fn GeodistsphericalPoint::label(self : GeodistsphericalPoint) -> Int { self.label }

pub fn GeodistsphericalPoint::dist(self : GeodistsphericalPoint, other : GeodistsphericalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistsphericalPoint::add(self : GeodistsphericalPoint, other : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistsphericalPoint::sub(self : GeodistsphericalPoint, other : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistsphericalPoint::scale(self : GeodistsphericalPoint, s : Double) -> GeodistsphericalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistsphericalPoint::dot(self : GeodistsphericalPoint, other : GeodistsphericalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistsphericalPoint::cross(self : GeodistsphericalPoint, other : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistsphericalPoint::norm(self : GeodistsphericalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistsphericalPoint::normalize(self : GeodistsphericalPoint) -> GeodistsphericalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistsphericalPoint::negate(self : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistsphericalPoint::mid(self : GeodistsphericalPoint, other : GeodistsphericalPoint) -> GeodistsphericalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistsphericalPoint::lerp(self : GeodistsphericalPoint, other : GeodistsphericalPoint, t : Double) -> GeodistsphericalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistsphericalPoint::to_string(self : GeodistsphericalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistsphericalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_spherical_make_series(vals : Array[Double], name : String) -> GeodistsphericalSeries {
  { vals, name, meta: 0 }
}

pub fn GeodistsphericalSeries::len(self : GeodistsphericalSeries) -> Int { self.vals.length() }

pub fn GeodistsphericalSeries::sum(self : GeodistsphericalSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistsphericalSeries::mean(self : GeodistsphericalSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistsphericalSeries::min(self : GeodistsphericalSeries) -> Double { @_common.min(self.vals) }

pub fn GeodistsphericalSeries::max(self : GeodistsphericalSeries) -> Double { @_common.max(self.vals) }

pub fn GeodistsphericalSeries::range(self : GeodistsphericalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistsphericalSeries::variance(self : GeodistsphericalSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistsphericalSeries::std(self : GeodistsphericalSeries) -> Double { @_common.std(self.vals) }

pub fn GeodistsphericalSeries::median(self : GeodistsphericalSeries) -> Double { @_common.median(self.vals) }

pub fn GeodistsphericalSeries::scale(self : GeodistsphericalSeries, f : Double) -> GeodistsphericalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistsphericalSeries::add(self : GeodistsphericalSeries, other : GeodistsphericalSeries) -> GeodistsphericalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistsphericalSeries::sub(self : GeodistsphericalSeries, other : GeodistsphericalSeries) -> GeodistsphericalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistsphericalSeries::normalize(self : GeodistsphericalSeries) -> GeodistsphericalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistsphericalSeries::cumsum(self : GeodistsphericalSeries) -> GeodistsphericalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistsphericalSeries::to_string(self : GeodistsphericalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistsphericalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_spherical_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistsphericalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_spherical_matrix_identity(n : Int) -> GeodistsphericalMatrix {
  let m = geo_dist_spherical_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistsphericalMatrix::get(self : GeodistsphericalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistsphericalMatrix::transpose(self : GeodistsphericalMatrix) -> GeodistsphericalMatrix {
  let result = geo_dist_spherical_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistsphericalMatrix::add(self : GeodistsphericalMatrix, other : GeodistsphericalMatrix) -> GeodistsphericalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_spherical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistsphericalMatrix::scale(self : GeodistsphericalMatrix, s : Double) -> GeodistsphericalMatrix {
  let result = geo_dist_spherical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistsphericalMatrix::multiply(self : GeodistsphericalMatrix, other : GeodistsphericalMatrix) -> GeodistsphericalMatrix {
  if self.cols != other.rows { return geo_dist_spherical_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_spherical_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeodistsphericalMatrix::trace(self : GeodistsphericalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistsphericalMatrix::det(self : GeodistsphericalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistsphericalMatrix::norm(self : GeodistsphericalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistsphericalMatrix::to_string(self : GeodistsphericalMatrix) -> String {
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

pub(all) struct GeodistsphericalVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_spherical_make_vector(comps : Array[Double]) -> GeodistsphericalVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_spherical_vector_zero(dim : Int) -> GeodistsphericalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistsphericalVector::add(self : GeodistsphericalVector, other : GeodistsphericalVector) -> GeodistsphericalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistsphericalVector::sub(self : GeodistsphericalVector, other : GeodistsphericalVector) -> GeodistsphericalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistsphericalVector::scale(self : GeodistsphericalVector, s : Double) -> GeodistsphericalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistsphericalVector::dot(self : GeodistsphericalVector, other : GeodistsphericalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistsphericalVector::norm(self : GeodistsphericalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistsphericalVector::normalize(self : GeodistsphericalVector) -> GeodistsphericalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistsphericalVector::dist(self : GeodistsphericalVector, other : GeodistsphericalVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistsphericalVector::to_string(self : GeodistsphericalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_spherical_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_spherical_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_spherical_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_spherical_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_spherical_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_spherical_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_spherical_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_spherical_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_spherical_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_spherical_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_spherical_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_spherical_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_spherical_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_spherical_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_spherical_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_spherical_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_spherical_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_spherical_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_spherical_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_spherical_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_spherical_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_spherical_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_spherical_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_spherical_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_spherical_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_spherical_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_spherical_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_spherical_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_spherical_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistsphericalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_frame_make(size : Int) -> GeodistsphericalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistsphericalFrame::len(self : GeodistsphericalFrame) -> Int { self.size }

pub fn GeodistsphericalFrame::get(self : GeodistsphericalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistsphericalFrame::set(self : GeodistsphericalFrame, i : Int, v : Double) -> GeodistsphericalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistsphericalFrame::sum(self : GeodistsphericalFrame) -> Double { @_common.sum(self.data) }

pub fn GeodistsphericalFrame::mean(self : GeodistsphericalFrame) -> Double { @_common.mean(self.data) }

pub fn GeodistsphericalFrame::scale(self : GeodistsphericalFrame, f : Double) -> GeodistsphericalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalFrame::add(self : GeodistsphericalFrame, other : GeodistsphericalFrame) -> GeodistsphericalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistsphericalFrame::copy(self : GeodistsphericalFrame) -> GeodistsphericalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalFrame::fill(self : GeodistsphericalFrame, v : Double) -> GeodistsphericalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalFrame::min(self : GeodistsphericalFrame) -> Double { @_common.min(self.data) }

pub fn GeodistsphericalFrame::max(self : GeodistsphericalFrame) -> Double { @_common.max(self.data) }

pub fn GeodistsphericalFrame::to_string(self : GeodistsphericalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_table_make(size : Int) -> GeodistsphericalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistsphericalTable::len(self : GeodistsphericalTable) -> Int { self.size }

pub fn GeodistsphericalTable::get(self : GeodistsphericalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistsphericalTable::set(self : GeodistsphericalTable, i : Int, v : Double) -> GeodistsphericalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistsphericalTable::sum(self : GeodistsphericalTable) -> Double { @_common.sum(self.data) }

pub fn GeodistsphericalTable::mean(self : GeodistsphericalTable) -> Double { @_common.mean(self.data) }

pub fn GeodistsphericalTable::scale(self : GeodistsphericalTable, f : Double) -> GeodistsphericalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalTable::add(self : GeodistsphericalTable, other : GeodistsphericalTable) -> GeodistsphericalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistsphericalTable::copy(self : GeodistsphericalTable) -> GeodistsphericalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalTable::fill(self : GeodistsphericalTable, v : Double) -> GeodistsphericalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalTable::min(self : GeodistsphericalTable) -> Double { @_common.min(self.data) }

pub fn GeodistsphericalTable::max(self : GeodistsphericalTable) -> Double { @_common.max(self.data) }

pub fn GeodistsphericalTable::to_string(self : GeodistsphericalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_graphn_make(size : Int) -> GeodistsphericalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistsphericalGraphN::len(self : GeodistsphericalGraphN) -> Int { self.size }

pub fn GeodistsphericalGraphN::get(self : GeodistsphericalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistsphericalGraphN::set(self : GeodistsphericalGraphN, i : Int, v : Double) -> GeodistsphericalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistsphericalGraphN::sum(self : GeodistsphericalGraphN) -> Double { @_common.sum(self.data) }

pub fn GeodistsphericalGraphN::mean(self : GeodistsphericalGraphN) -> Double { @_common.mean(self.data) }

pub fn GeodistsphericalGraphN::scale(self : GeodistsphericalGraphN, f : Double) -> GeodistsphericalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalGraphN::add(self : GeodistsphericalGraphN, other : GeodistsphericalGraphN) -> GeodistsphericalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistsphericalGraphN::copy(self : GeodistsphericalGraphN) -> GeodistsphericalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalGraphN::fill(self : GeodistsphericalGraphN, v : Double) -> GeodistsphericalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalGraphN::min(self : GeodistsphericalGraphN) -> Double { @_common.min(self.data) }

pub fn GeodistsphericalGraphN::max(self : GeodistsphericalGraphN) -> Double { @_common.max(self.data) }

pub fn GeodistsphericalGraphN::to_string(self : GeodistsphericalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_node_make(size : Int) -> GeodistsphericalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistsphericalNode::len(self : GeodistsphericalNode) -> Int { self.size }

pub fn GeodistsphericalNode::get(self : GeodistsphericalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistsphericalNode::set(self : GeodistsphericalNode, i : Int, v : Double) -> GeodistsphericalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistsphericalNode::sum(self : GeodistsphericalNode) -> Double { @_common.sum(self.data) }

pub fn GeodistsphericalNode::mean(self : GeodistsphericalNode) -> Double { @_common.mean(self.data) }

pub fn GeodistsphericalNode::scale(self : GeodistsphericalNode, f : Double) -> GeodistsphericalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalNode::add(self : GeodistsphericalNode, other : GeodistsphericalNode) -> GeodistsphericalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistsphericalNode::copy(self : GeodistsphericalNode) -> GeodistsphericalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalNode::fill(self : GeodistsphericalNode, v : Double) -> GeodistsphericalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalNode::min(self : GeodistsphericalNode) -> Double { @_common.min(self.data) }

pub fn GeodistsphericalNode::max(self : GeodistsphericalNode) -> Double { @_common.max(self.data) }

pub fn GeodistsphericalNode::to_string(self : GeodistsphericalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_edge_make(size : Int) -> GeodistsphericalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistsphericalEdge::len(self : GeodistsphericalEdge) -> Int { self.size }

pub fn GeodistsphericalEdge::get(self : GeodistsphericalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistsphericalEdge::set(self : GeodistsphericalEdge, i : Int, v : Double) -> GeodistsphericalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistsphericalEdge::sum(self : GeodistsphericalEdge) -> Double { @_common.sum(self.data) }

pub fn GeodistsphericalEdge::mean(self : GeodistsphericalEdge) -> Double { @_common.mean(self.data) }

pub fn GeodistsphericalEdge::scale(self : GeodistsphericalEdge, f : Double) -> GeodistsphericalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalEdge::add(self : GeodistsphericalEdge, other : GeodistsphericalEdge) -> GeodistsphericalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistsphericalEdge::copy(self : GeodistsphericalEdge) -> GeodistsphericalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalEdge::fill(self : GeodistsphericalEdge, v : Double) -> GeodistsphericalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalEdge::min(self : GeodistsphericalEdge) -> Double { @_common.min(self.data) }

pub fn GeodistsphericalEdge::max(self : GeodistsphericalEdge) -> Double { @_common.max(self.data) }

pub fn GeodistsphericalEdge::to_string(self : GeodistsphericalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_path_make(size : Int) -> GeodistsphericalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistsphericalPath::len(self : GeodistsphericalPath) -> Int { self.size }

pub fn GeodistsphericalPath::get(self : GeodistsphericalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistsphericalPath::set(self : GeodistsphericalPath, i : Int, v : Double) -> GeodistsphericalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistsphericalPath::sum(self : GeodistsphericalPath) -> Double { @_common.sum(self.data) }

pub fn GeodistsphericalPath::mean(self : GeodistsphericalPath) -> Double { @_common.mean(self.data) }

pub fn GeodistsphericalPath::scale(self : GeodistsphericalPath, f : Double) -> GeodistsphericalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalPath::add(self : GeodistsphericalPath, other : GeodistsphericalPath) -> GeodistsphericalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistsphericalPath::copy(self : GeodistsphericalPath) -> GeodistsphericalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalPath::fill(self : GeodistsphericalPath, v : Double) -> GeodistsphericalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalPath::min(self : GeodistsphericalPath) -> Double { @_common.min(self.data) }

pub fn GeodistsphericalPath::max(self : GeodistsphericalPath) -> Double { @_common.max(self.data) }

pub fn GeodistsphericalPath::to_string(self : GeodistsphericalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_cluster_make(size : Int) -> GeodistsphericalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistsphericalCluster::len(self : GeodistsphericalCluster) -> Int { self.size }

pub fn GeodistsphericalCluster::get(self : GeodistsphericalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistsphericalCluster::set(self : GeodistsphericalCluster, i : Int, v : Double) -> GeodistsphericalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistsphericalCluster::sum(self : GeodistsphericalCluster) -> Double { @_common.sum(self.data) }

pub fn GeodistsphericalCluster::mean(self : GeodistsphericalCluster) -> Double { @_common.mean(self.data) }

pub fn GeodistsphericalCluster::scale(self : GeodistsphericalCluster, f : Double) -> GeodistsphericalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalCluster::add(self : GeodistsphericalCluster, other : GeodistsphericalCluster) -> GeodistsphericalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistsphericalCluster::copy(self : GeodistsphericalCluster) -> GeodistsphericalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalCluster::fill(self : GeodistsphericalCluster, v : Double) -> GeodistsphericalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalCluster::min(self : GeodistsphericalCluster) -> Double { @_common.min(self.data) }

pub fn GeodistsphericalCluster::max(self : GeodistsphericalCluster) -> Double { @_common.max(self.data) }

pub fn GeodistsphericalCluster::to_string(self : GeodistsphericalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_model_make(size : Int) -> GeodistsphericalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistsphericalModel::len(self : GeodistsphericalModel) -> Int { self.size }

pub fn GeodistsphericalModel::get(self : GeodistsphericalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistsphericalModel::set(self : GeodistsphericalModel, i : Int, v : Double) -> GeodistsphericalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistsphericalModel::sum(self : GeodistsphericalModel) -> Double { @_common.sum(self.data) }

pub fn GeodistsphericalModel::mean(self : GeodistsphericalModel) -> Double { @_common.mean(self.data) }

pub fn GeodistsphericalModel::scale(self : GeodistsphericalModel, f : Double) -> GeodistsphericalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalModel::add(self : GeodistsphericalModel, other : GeodistsphericalModel) -> GeodistsphericalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistsphericalModel::copy(self : GeodistsphericalModel) -> GeodistsphericalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalModel::fill(self : GeodistsphericalModel, v : Double) -> GeodistsphericalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalModel::min(self : GeodistsphericalModel) -> Double { @_common.min(self.data) }

pub fn GeodistsphericalModel::max(self : GeodistsphericalModel) -> Double { @_common.max(self.data) }

pub fn GeodistsphericalModel::to_string(self : GeodistsphericalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_layer_make(size : Int) -> GeodistsphericalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistsphericalLayer::len(self : GeodistsphericalLayer) -> Int { self.size }

pub fn GeodistsphericalLayer::get(self : GeodistsphericalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistsphericalLayer::set(self : GeodistsphericalLayer, i : Int, v : Double) -> GeodistsphericalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistsphericalLayer::sum(self : GeodistsphericalLayer) -> Double { @_common.sum(self.data) }

pub fn GeodistsphericalLayer::mean(self : GeodistsphericalLayer) -> Double { @_common.mean(self.data) }

pub fn GeodistsphericalLayer::scale(self : GeodistsphericalLayer, f : Double) -> GeodistsphericalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalLayer::add(self : GeodistsphericalLayer, other : GeodistsphericalLayer) -> GeodistsphericalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistsphericalLayer::copy(self : GeodistsphericalLayer) -> GeodistsphericalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalLayer::fill(self : GeodistsphericalLayer, v : Double) -> GeodistsphericalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalLayer::min(self : GeodistsphericalLayer) -> Double { @_common.min(self.data) }

pub fn GeodistsphericalLayer::max(self : GeodistsphericalLayer) -> Double { @_common.max(self.data) }

pub fn GeodistsphericalLayer::to_string(self : GeodistsphericalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_buffer_make(size : Int) -> GeodistsphericalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistsphericalBuffer::len(self : GeodistsphericalBuffer) -> Int { self.size }

pub fn GeodistsphericalBuffer::get(self : GeodistsphericalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistsphericalBuffer::set(self : GeodistsphericalBuffer, i : Int, v : Double) -> GeodistsphericalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistsphericalBuffer::sum(self : GeodistsphericalBuffer) -> Double { @_common.sum(self.data) }

pub fn GeodistsphericalBuffer::mean(self : GeodistsphericalBuffer) -> Double { @_common.mean(self.data) }

pub fn GeodistsphericalBuffer::scale(self : GeodistsphericalBuffer, f : Double) -> GeodistsphericalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalBuffer::add(self : GeodistsphericalBuffer, other : GeodistsphericalBuffer) -> GeodistsphericalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistsphericalBuffer::copy(self : GeodistsphericalBuffer) -> GeodistsphericalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalBuffer::fill(self : GeodistsphericalBuffer, v : Double) -> GeodistsphericalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalBuffer::min(self : GeodistsphericalBuffer) -> Double { @_common.min(self.data) }

pub fn GeodistsphericalBuffer::max(self : GeodistsphericalBuffer) -> Double { @_common.max(self.data) }

pub fn GeodistsphericalBuffer::to_string(self : GeodistsphericalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_cursor_make(size : Int) -> GeodistsphericalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistsphericalCursor::len(self : GeodistsphericalCursor) -> Int { self.size }

pub fn GeodistsphericalCursor::get(self : GeodistsphericalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistsphericalCursor::set(self : GeodistsphericalCursor, i : Int, v : Double) -> GeodistsphericalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistsphericalCursor::sum(self : GeodistsphericalCursor) -> Double { @_common.sum(self.data) }

pub fn GeodistsphericalCursor::mean(self : GeodistsphericalCursor) -> Double { @_common.mean(self.data) }

pub fn GeodistsphericalCursor::scale(self : GeodistsphericalCursor, f : Double) -> GeodistsphericalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalCursor::add(self : GeodistsphericalCursor, other : GeodistsphericalCursor) -> GeodistsphericalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistsphericalCursor::copy(self : GeodistsphericalCursor) -> GeodistsphericalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalCursor::fill(self : GeodistsphericalCursor, v : Double) -> GeodistsphericalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalCursor::min(self : GeodistsphericalCursor) -> Double { @_common.min(self.data) }

pub fn GeodistsphericalCursor::max(self : GeodistsphericalCursor) -> Double { @_common.max(self.data) }

pub fn GeodistsphericalCursor::to_string(self : GeodistsphericalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_view_make(size : Int) -> GeodistsphericalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistsphericalView::len(self : GeodistsphericalView) -> Int { self.size }

pub fn GeodistsphericalView::get(self : GeodistsphericalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistsphericalView::set(self : GeodistsphericalView, i : Int, v : Double) -> GeodistsphericalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistsphericalView::sum(self : GeodistsphericalView) -> Double { @_common.sum(self.data) }

pub fn GeodistsphericalView::mean(self : GeodistsphericalView) -> Double { @_common.mean(self.data) }

pub fn GeodistsphericalView::scale(self : GeodistsphericalView, f : Double) -> GeodistsphericalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalView::add(self : GeodistsphericalView, other : GeodistsphericalView) -> GeodistsphericalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistsphericalView::copy(self : GeodistsphericalView) -> GeodistsphericalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalView::fill(self : GeodistsphericalView, v : Double) -> GeodistsphericalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalView::min(self : GeodistsphericalView) -> Double { @_common.min(self.data) }

pub fn GeodistsphericalView::max(self : GeodistsphericalView) -> Double { @_common.max(self.data) }

pub fn GeodistsphericalView::to_string(self : GeodistsphericalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_range_make(size : Int) -> GeodistsphericalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistsphericalRange::len(self : GeodistsphericalRange) -> Int { self.size }

pub fn GeodistsphericalRange::get(self : GeodistsphericalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistsphericalRange::set(self : GeodistsphericalRange, i : Int, v : Double) -> GeodistsphericalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistsphericalRange::sum(self : GeodistsphericalRange) -> Double { @_common.sum(self.data) }

pub fn GeodistsphericalRange::mean(self : GeodistsphericalRange) -> Double { @_common.mean(self.data) }

pub fn GeodistsphericalRange::scale(self : GeodistsphericalRange, f : Double) -> GeodistsphericalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalRange::add(self : GeodistsphericalRange, other : GeodistsphericalRange) -> GeodistsphericalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistsphericalRange::copy(self : GeodistsphericalRange) -> GeodistsphericalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalRange::fill(self : GeodistsphericalRange, v : Double) -> GeodistsphericalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalRange::min(self : GeodistsphericalRange) -> Double { @_common.min(self.data) }

pub fn GeodistsphericalRange::max(self : GeodistsphericalRange) -> Double { @_common.max(self.data) }

pub fn GeodistsphericalRange::to_string(self : GeodistsphericalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_slice_make(size : Int) -> GeodistsphericalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn GeodistsphericalSlice::len(self : GeodistsphericalSlice) -> Int { self.size }

pub fn GeodistsphericalSlice::get(self : GeodistsphericalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn GeodistsphericalSlice::set(self : GeodistsphericalSlice, i : Int, v : Double) -> GeodistsphericalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn GeodistsphericalSlice::sum(self : GeodistsphericalSlice) -> Double { @_common.sum(self.data) }

pub fn GeodistsphericalSlice::mean(self : GeodistsphericalSlice) -> Double { @_common.mean(self.data) }

pub fn GeodistsphericalSlice::scale(self : GeodistsphericalSlice, f : Double) -> GeodistsphericalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalSlice::add(self : GeodistsphericalSlice, other : GeodistsphericalSlice) -> GeodistsphericalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn GeodistsphericalSlice::copy(self : GeodistsphericalSlice) -> GeodistsphericalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalSlice::fill(self : GeodistsphericalSlice, v : Double) -> GeodistsphericalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn GeodistsphericalSlice::min(self : GeodistsphericalSlice) -> Double { @_common.min(self.data) }

pub fn GeodistsphericalSlice::max(self : GeodistsphericalSlice) -> Double { @_common.max(self.data) }

pub fn GeodistsphericalSlice::to_string(self : GeodistsphericalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

