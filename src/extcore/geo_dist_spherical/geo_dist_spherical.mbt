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

pub fn geo_dist_spherical_frame_len(s : GeodistsphericalFrame) -> Int { s.size }

pub fn geo_dist_spherical_frame_get(s : GeodistsphericalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_frame_set(s : GeodistsphericalFrame, i : Int, v : Double) -> GeodistsphericalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_frame_sum(s : GeodistsphericalFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_frame_mean(s : GeodistsphericalFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_frame_scale(s : GeodistsphericalFrame, f : Double) -> GeodistsphericalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_frame_add(a : GeodistsphericalFrame, b : GeodistsphericalFrame) -> GeodistsphericalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_spherical_frame_copy(s : GeodistsphericalFrame) -> GeodistsphericalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_frame_fill(s : GeodistsphericalFrame, v : Double) -> GeodistsphericalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_frame_min(s : GeodistsphericalFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_frame_max(s : GeodistsphericalFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_frame_to_string(s : GeodistsphericalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_table_make(size : Int) -> GeodistsphericalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_table_len(s : GeodistsphericalTable) -> Int { s.size }

pub fn geo_dist_spherical_table_get(s : GeodistsphericalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_table_set(s : GeodistsphericalTable, i : Int, v : Double) -> GeodistsphericalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_table_sum(s : GeodistsphericalTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_table_mean(s : GeodistsphericalTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_table_scale(s : GeodistsphericalTable, f : Double) -> GeodistsphericalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_table_add(a : GeodistsphericalTable, b : GeodistsphericalTable) -> GeodistsphericalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_spherical_table_copy(s : GeodistsphericalTable) -> GeodistsphericalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_table_fill(s : GeodistsphericalTable, v : Double) -> GeodistsphericalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_table_min(s : GeodistsphericalTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_table_max(s : GeodistsphericalTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_table_to_string(s : GeodistsphericalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_graphn_make(size : Int) -> GeodistsphericalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_graphn_len(s : GeodistsphericalGraphN) -> Int { s.size }

pub fn geo_dist_spherical_graphn_get(s : GeodistsphericalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_graphn_set(s : GeodistsphericalGraphN, i : Int, v : Double) -> GeodistsphericalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_graphn_sum(s : GeodistsphericalGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_graphn_mean(s : GeodistsphericalGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_graphn_scale(s : GeodistsphericalGraphN, f : Double) -> GeodistsphericalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_graphn_add(a : GeodistsphericalGraphN, b : GeodistsphericalGraphN) -> GeodistsphericalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_spherical_graphn_copy(s : GeodistsphericalGraphN) -> GeodistsphericalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_graphn_fill(s : GeodistsphericalGraphN, v : Double) -> GeodistsphericalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_graphn_min(s : GeodistsphericalGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_graphn_max(s : GeodistsphericalGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_graphn_to_string(s : GeodistsphericalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_node_make(size : Int) -> GeodistsphericalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_node_len(s : GeodistsphericalNode) -> Int { s.size }

pub fn geo_dist_spherical_node_get(s : GeodistsphericalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_node_set(s : GeodistsphericalNode, i : Int, v : Double) -> GeodistsphericalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_node_sum(s : GeodistsphericalNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_node_mean(s : GeodistsphericalNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_node_scale(s : GeodistsphericalNode, f : Double) -> GeodistsphericalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_node_add(a : GeodistsphericalNode, b : GeodistsphericalNode) -> GeodistsphericalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_spherical_node_copy(s : GeodistsphericalNode) -> GeodistsphericalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_node_fill(s : GeodistsphericalNode, v : Double) -> GeodistsphericalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_node_min(s : GeodistsphericalNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_node_max(s : GeodistsphericalNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_node_to_string(s : GeodistsphericalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_edge_make(size : Int) -> GeodistsphericalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_edge_len(s : GeodistsphericalEdge) -> Int { s.size }

pub fn geo_dist_spherical_edge_get(s : GeodistsphericalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_edge_set(s : GeodistsphericalEdge, i : Int, v : Double) -> GeodistsphericalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_edge_sum(s : GeodistsphericalEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_edge_mean(s : GeodistsphericalEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_edge_scale(s : GeodistsphericalEdge, f : Double) -> GeodistsphericalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_edge_add(a : GeodistsphericalEdge, b : GeodistsphericalEdge) -> GeodistsphericalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_spherical_edge_copy(s : GeodistsphericalEdge) -> GeodistsphericalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_edge_fill(s : GeodistsphericalEdge, v : Double) -> GeodistsphericalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_edge_min(s : GeodistsphericalEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_edge_max(s : GeodistsphericalEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_edge_to_string(s : GeodistsphericalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_path_make(size : Int) -> GeodistsphericalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_path_len(s : GeodistsphericalPath) -> Int { s.size }

pub fn geo_dist_spherical_path_get(s : GeodistsphericalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_path_set(s : GeodistsphericalPath, i : Int, v : Double) -> GeodistsphericalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_path_sum(s : GeodistsphericalPath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_path_mean(s : GeodistsphericalPath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_path_scale(s : GeodistsphericalPath, f : Double) -> GeodistsphericalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_path_add(a : GeodistsphericalPath, b : GeodistsphericalPath) -> GeodistsphericalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_spherical_path_copy(s : GeodistsphericalPath) -> GeodistsphericalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_path_fill(s : GeodistsphericalPath, v : Double) -> GeodistsphericalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_path_min(s : GeodistsphericalPath) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_path_max(s : GeodistsphericalPath) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_path_to_string(s : GeodistsphericalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_cluster_make(size : Int) -> GeodistsphericalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_cluster_len(s : GeodistsphericalCluster) -> Int { s.size }

pub fn geo_dist_spherical_cluster_get(s : GeodistsphericalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_cluster_set(s : GeodistsphericalCluster, i : Int, v : Double) -> GeodistsphericalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_cluster_sum(s : GeodistsphericalCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_cluster_mean(s : GeodistsphericalCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_cluster_scale(s : GeodistsphericalCluster, f : Double) -> GeodistsphericalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_cluster_add(a : GeodistsphericalCluster, b : GeodistsphericalCluster) -> GeodistsphericalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_spherical_cluster_copy(s : GeodistsphericalCluster) -> GeodistsphericalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_cluster_fill(s : GeodistsphericalCluster, v : Double) -> GeodistsphericalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_cluster_min(s : GeodistsphericalCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_cluster_max(s : GeodistsphericalCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_cluster_to_string(s : GeodistsphericalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_model_make(size : Int) -> GeodistsphericalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_model_len(s : GeodistsphericalModel) -> Int { s.size }

pub fn geo_dist_spherical_model_get(s : GeodistsphericalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_model_set(s : GeodistsphericalModel, i : Int, v : Double) -> GeodistsphericalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_model_sum(s : GeodistsphericalModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_model_mean(s : GeodistsphericalModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_model_scale(s : GeodistsphericalModel, f : Double) -> GeodistsphericalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_model_add(a : GeodistsphericalModel, b : GeodistsphericalModel) -> GeodistsphericalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_spherical_model_copy(s : GeodistsphericalModel) -> GeodistsphericalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_model_fill(s : GeodistsphericalModel, v : Double) -> GeodistsphericalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_model_min(s : GeodistsphericalModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_model_max(s : GeodistsphericalModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_model_to_string(s : GeodistsphericalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_layer_make(size : Int) -> GeodistsphericalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_layer_len(s : GeodistsphericalLayer) -> Int { s.size }

pub fn geo_dist_spherical_layer_get(s : GeodistsphericalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_layer_set(s : GeodistsphericalLayer, i : Int, v : Double) -> GeodistsphericalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_layer_sum(s : GeodistsphericalLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_layer_mean(s : GeodistsphericalLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_layer_scale(s : GeodistsphericalLayer, f : Double) -> GeodistsphericalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_layer_add(a : GeodistsphericalLayer, b : GeodistsphericalLayer) -> GeodistsphericalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_spherical_layer_copy(s : GeodistsphericalLayer) -> GeodistsphericalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_layer_fill(s : GeodistsphericalLayer, v : Double) -> GeodistsphericalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_layer_min(s : GeodistsphericalLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_layer_max(s : GeodistsphericalLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_layer_to_string(s : GeodistsphericalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_buffer_make(size : Int) -> GeodistsphericalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_buffer_len(s : GeodistsphericalBuffer) -> Int { s.size }

pub fn geo_dist_spherical_buffer_get(s : GeodistsphericalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_buffer_set(s : GeodistsphericalBuffer, i : Int, v : Double) -> GeodistsphericalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_buffer_sum(s : GeodistsphericalBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_buffer_mean(s : GeodistsphericalBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_buffer_scale(s : GeodistsphericalBuffer, f : Double) -> GeodistsphericalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_buffer_add(a : GeodistsphericalBuffer, b : GeodistsphericalBuffer) -> GeodistsphericalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_spherical_buffer_copy(s : GeodistsphericalBuffer) -> GeodistsphericalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_buffer_fill(s : GeodistsphericalBuffer, v : Double) -> GeodistsphericalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_buffer_min(s : GeodistsphericalBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_buffer_max(s : GeodistsphericalBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_buffer_to_string(s : GeodistsphericalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_cursor_make(size : Int) -> GeodistsphericalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_cursor_len(s : GeodistsphericalCursor) -> Int { s.size }

pub fn geo_dist_spherical_cursor_get(s : GeodistsphericalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_cursor_set(s : GeodistsphericalCursor, i : Int, v : Double) -> GeodistsphericalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_cursor_sum(s : GeodistsphericalCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_cursor_mean(s : GeodistsphericalCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_cursor_scale(s : GeodistsphericalCursor, f : Double) -> GeodistsphericalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_cursor_add(a : GeodistsphericalCursor, b : GeodistsphericalCursor) -> GeodistsphericalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_spherical_cursor_copy(s : GeodistsphericalCursor) -> GeodistsphericalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_cursor_fill(s : GeodistsphericalCursor, v : Double) -> GeodistsphericalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_cursor_min(s : GeodistsphericalCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_cursor_max(s : GeodistsphericalCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_cursor_to_string(s : GeodistsphericalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_view_make(size : Int) -> GeodistsphericalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_view_len(s : GeodistsphericalView) -> Int { s.size }

pub fn geo_dist_spherical_view_get(s : GeodistsphericalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_view_set(s : GeodistsphericalView, i : Int, v : Double) -> GeodistsphericalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_view_sum(s : GeodistsphericalView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_view_mean(s : GeodistsphericalView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_view_scale(s : GeodistsphericalView, f : Double) -> GeodistsphericalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_view_add(a : GeodistsphericalView, b : GeodistsphericalView) -> GeodistsphericalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_spherical_view_copy(s : GeodistsphericalView) -> GeodistsphericalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_view_fill(s : GeodistsphericalView, v : Double) -> GeodistsphericalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_view_min(s : GeodistsphericalView) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_view_max(s : GeodistsphericalView) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_view_to_string(s : GeodistsphericalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_range_make(size : Int) -> GeodistsphericalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_range_len(s : GeodistsphericalRange) -> Int { s.size }

pub fn geo_dist_spherical_range_get(s : GeodistsphericalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_range_set(s : GeodistsphericalRange, i : Int, v : Double) -> GeodistsphericalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_range_sum(s : GeodistsphericalRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_range_mean(s : GeodistsphericalRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_range_scale(s : GeodistsphericalRange, f : Double) -> GeodistsphericalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_range_add(a : GeodistsphericalRange, b : GeodistsphericalRange) -> GeodistsphericalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_spherical_range_copy(s : GeodistsphericalRange) -> GeodistsphericalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_range_fill(s : GeodistsphericalRange, v : Double) -> GeodistsphericalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_range_min(s : GeodistsphericalRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_range_max(s : GeodistsphericalRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_range_to_string(s : GeodistsphericalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistsphericalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_spherical_slice_make(size : Int) -> GeodistsphericalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_spherical_slice_len(s : GeodistsphericalSlice) -> Int { s.size }

pub fn geo_dist_spherical_slice_get(s : GeodistsphericalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_spherical_slice_set(s : GeodistsphericalSlice, i : Int, v : Double) -> GeodistsphericalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_slice_sum(s : GeodistsphericalSlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_spherical_slice_mean(s : GeodistsphericalSlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_spherical_slice_scale(s : GeodistsphericalSlice, f : Double) -> GeodistsphericalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_slice_add(a : GeodistsphericalSlice, b : GeodistsphericalSlice) -> GeodistsphericalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_spherical_slice_copy(s : GeodistsphericalSlice) -> GeodistsphericalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_slice_fill(s : GeodistsphericalSlice, v : Double) -> GeodistsphericalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_spherical_slice_min(s : GeodistsphericalSlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_spherical_slice_max(s : GeodistsphericalSlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_spherical_slice_to_string(s : GeodistsphericalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

