///===
/// extcore/geo_dist_projected

pub(all) struct GeodistprojectedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_projected_make_point(x : Double, y : Double) -> GeodistprojectedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_projected_make_point3(x : Double, y : Double, z : Double) -> GeodistprojectedPoint {
  { x, y, z, label: 0 }
}

pub fn GeodistprojectedPoint::x(self : GeodistprojectedPoint) -> Double { self.x }

pub fn GeodistprojectedPoint::y(self : GeodistprojectedPoint) -> Double { self.y }

pub fn GeodistprojectedPoint::z(self : GeodistprojectedPoint) -> Double { self.z }

pub fn GeodistprojectedPoint::label(self : GeodistprojectedPoint) -> Int { self.label }

pub fn GeodistprojectedPoint::dist(self : GeodistprojectedPoint, other : GeodistprojectedPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistprojectedPoint::add(self : GeodistprojectedPoint, other : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistprojectedPoint::sub(self : GeodistprojectedPoint, other : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistprojectedPoint::scale(self : GeodistprojectedPoint, s : Double) -> GeodistprojectedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistprojectedPoint::dot(self : GeodistprojectedPoint, other : GeodistprojectedPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistprojectedPoint::cross(self : GeodistprojectedPoint, other : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistprojectedPoint::norm(self : GeodistprojectedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistprojectedPoint::normalize(self : GeodistprojectedPoint) -> GeodistprojectedPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistprojectedPoint::negate(self : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistprojectedPoint::mid(self : GeodistprojectedPoint, other : GeodistprojectedPoint) -> GeodistprojectedPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistprojectedPoint::lerp(self : GeodistprojectedPoint, other : GeodistprojectedPoint, t : Double) -> GeodistprojectedPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistprojectedPoint::to_string(self : GeodistprojectedPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistprojectedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_projected_make_series(vals : Array[Double], name : String) -> GeodistprojectedSeries {
  { vals, name, meta: 0 }
}

pub fn GeodistprojectedSeries::len(self : GeodistprojectedSeries) -> Int { self.vals.length() }

pub fn GeodistprojectedSeries::sum(self : GeodistprojectedSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistprojectedSeries::mean(self : GeodistprojectedSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistprojectedSeries::min(self : GeodistprojectedSeries) -> Double { @_common.min(self.vals) }

pub fn GeodistprojectedSeries::max(self : GeodistprojectedSeries) -> Double { @_common.max(self.vals) }

pub fn GeodistprojectedSeries::range(self : GeodistprojectedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistprojectedSeries::variance(self : GeodistprojectedSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistprojectedSeries::std(self : GeodistprojectedSeries) -> Double { @_common.std(self.vals) }

pub fn GeodistprojectedSeries::median(self : GeodistprojectedSeries) -> Double { @_common.median(self.vals) }

pub fn GeodistprojectedSeries::scale(self : GeodistprojectedSeries, f : Double) -> GeodistprojectedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistprojectedSeries::add(self : GeodistprojectedSeries, other : GeodistprojectedSeries) -> GeodistprojectedSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistprojectedSeries::sub(self : GeodistprojectedSeries, other : GeodistprojectedSeries) -> GeodistprojectedSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistprojectedSeries::normalize(self : GeodistprojectedSeries) -> GeodistprojectedSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistprojectedSeries::cumsum(self : GeodistprojectedSeries) -> GeodistprojectedSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistprojectedSeries::to_string(self : GeodistprojectedSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistprojectedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_projected_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistprojectedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_projected_matrix_identity(n : Int) -> GeodistprojectedMatrix {
  let m = geo_dist_projected_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistprojectedMatrix::get(self : GeodistprojectedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistprojectedMatrix::transpose(self : GeodistprojectedMatrix) -> GeodistprojectedMatrix {
  let result = geo_dist_projected_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistprojectedMatrix::add(self : GeodistprojectedMatrix, other : GeodistprojectedMatrix) -> GeodistprojectedMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_projected_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistprojectedMatrix::scale(self : GeodistprojectedMatrix, s : Double) -> GeodistprojectedMatrix {
  let result = geo_dist_projected_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistprojectedMatrix::multiply(self : GeodistprojectedMatrix, other : GeodistprojectedMatrix) -> GeodistprojectedMatrix {
  if self.cols != other.rows { return geo_dist_projected_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_projected_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeodistprojectedMatrix::trace(self : GeodistprojectedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistprojectedMatrix::det(self : GeodistprojectedMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistprojectedMatrix::norm(self : GeodistprojectedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistprojectedMatrix::to_string(self : GeodistprojectedMatrix) -> String {
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

pub(all) struct GeodistprojectedVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_projected_make_vector(comps : Array[Double]) -> GeodistprojectedVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_projected_vector_zero(dim : Int) -> GeodistprojectedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistprojectedVector::add(self : GeodistprojectedVector, other : GeodistprojectedVector) -> GeodistprojectedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistprojectedVector::sub(self : GeodistprojectedVector, other : GeodistprojectedVector) -> GeodistprojectedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistprojectedVector::scale(self : GeodistprojectedVector, s : Double) -> GeodistprojectedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistprojectedVector::dot(self : GeodistprojectedVector, other : GeodistprojectedVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistprojectedVector::norm(self : GeodistprojectedVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistprojectedVector::normalize(self : GeodistprojectedVector) -> GeodistprojectedVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistprojectedVector::dist(self : GeodistprojectedVector, other : GeodistprojectedVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistprojectedVector::to_string(self : GeodistprojectedVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_projected_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_projected_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_projected_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_projected_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_projected_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_projected_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_projected_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_projected_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_projected_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_projected_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_projected_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_projected_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_projected_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_projected_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_projected_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_projected_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_projected_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_projected_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_projected_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_projected_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_projected_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_projected_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_projected_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_projected_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_projected_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_projected_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_projected_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_projected_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_projected_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistprojectedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_frame_make(size : Int) -> GeodistprojectedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_frame_len(s : GeodistprojectedFrame) -> Int { s.size }

pub fn geo_dist_projected_frame_get(s : GeodistprojectedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_frame_set(s : GeodistprojectedFrame, i : Int, v : Double) -> GeodistprojectedFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_frame_sum(s : GeodistprojectedFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_projected_frame_mean(s : GeodistprojectedFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_projected_frame_scale(s : GeodistprojectedFrame, f : Double) -> GeodistprojectedFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_frame_add(a : GeodistprojectedFrame, b : GeodistprojectedFrame) -> GeodistprojectedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_projected_frame_copy(s : GeodistprojectedFrame) -> GeodistprojectedFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_frame_fill(s : GeodistprojectedFrame, v : Double) -> GeodistprojectedFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_frame_min(s : GeodistprojectedFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_projected_frame_max(s : GeodistprojectedFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_projected_frame_to_string(s : GeodistprojectedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_table_make(size : Int) -> GeodistprojectedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_table_len(s : GeodistprojectedTable) -> Int { s.size }

pub fn geo_dist_projected_table_get(s : GeodistprojectedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_table_set(s : GeodistprojectedTable, i : Int, v : Double) -> GeodistprojectedTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_table_sum(s : GeodistprojectedTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_projected_table_mean(s : GeodistprojectedTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_projected_table_scale(s : GeodistprojectedTable, f : Double) -> GeodistprojectedTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_table_add(a : GeodistprojectedTable, b : GeodistprojectedTable) -> GeodistprojectedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_projected_table_copy(s : GeodistprojectedTable) -> GeodistprojectedTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_table_fill(s : GeodistprojectedTable, v : Double) -> GeodistprojectedTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_table_min(s : GeodistprojectedTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_projected_table_max(s : GeodistprojectedTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_projected_table_to_string(s : GeodistprojectedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_graphn_make(size : Int) -> GeodistprojectedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_graphn_len(s : GeodistprojectedGraphN) -> Int { s.size }

pub fn geo_dist_projected_graphn_get(s : GeodistprojectedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_graphn_set(s : GeodistprojectedGraphN, i : Int, v : Double) -> GeodistprojectedGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_graphn_sum(s : GeodistprojectedGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_projected_graphn_mean(s : GeodistprojectedGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_projected_graphn_scale(s : GeodistprojectedGraphN, f : Double) -> GeodistprojectedGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_graphn_add(a : GeodistprojectedGraphN, b : GeodistprojectedGraphN) -> GeodistprojectedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_projected_graphn_copy(s : GeodistprojectedGraphN) -> GeodistprojectedGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_graphn_fill(s : GeodistprojectedGraphN, v : Double) -> GeodistprojectedGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_graphn_min(s : GeodistprojectedGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_projected_graphn_max(s : GeodistprojectedGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_projected_graphn_to_string(s : GeodistprojectedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_node_make(size : Int) -> GeodistprojectedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_node_len(s : GeodistprojectedNode) -> Int { s.size }

pub fn geo_dist_projected_node_get(s : GeodistprojectedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_node_set(s : GeodistprojectedNode, i : Int, v : Double) -> GeodistprojectedNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_node_sum(s : GeodistprojectedNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_projected_node_mean(s : GeodistprojectedNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_projected_node_scale(s : GeodistprojectedNode, f : Double) -> GeodistprojectedNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_node_add(a : GeodistprojectedNode, b : GeodistprojectedNode) -> GeodistprojectedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_projected_node_copy(s : GeodistprojectedNode) -> GeodistprojectedNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_node_fill(s : GeodistprojectedNode, v : Double) -> GeodistprojectedNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_node_min(s : GeodistprojectedNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_projected_node_max(s : GeodistprojectedNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_projected_node_to_string(s : GeodistprojectedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_edge_make(size : Int) -> GeodistprojectedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_edge_len(s : GeodistprojectedEdge) -> Int { s.size }

pub fn geo_dist_projected_edge_get(s : GeodistprojectedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_edge_set(s : GeodistprojectedEdge, i : Int, v : Double) -> GeodistprojectedEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_edge_sum(s : GeodistprojectedEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_projected_edge_mean(s : GeodistprojectedEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_projected_edge_scale(s : GeodistprojectedEdge, f : Double) -> GeodistprojectedEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_edge_add(a : GeodistprojectedEdge, b : GeodistprojectedEdge) -> GeodistprojectedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_projected_edge_copy(s : GeodistprojectedEdge) -> GeodistprojectedEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_edge_fill(s : GeodistprojectedEdge, v : Double) -> GeodistprojectedEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_edge_min(s : GeodistprojectedEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_projected_edge_max(s : GeodistprojectedEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_projected_edge_to_string(s : GeodistprojectedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_path_make(size : Int) -> GeodistprojectedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_path_len(s : GeodistprojectedPath) -> Int { s.size }

pub fn geo_dist_projected_path_get(s : GeodistprojectedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_path_set(s : GeodistprojectedPath, i : Int, v : Double) -> GeodistprojectedPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_path_sum(s : GeodistprojectedPath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_projected_path_mean(s : GeodistprojectedPath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_projected_path_scale(s : GeodistprojectedPath, f : Double) -> GeodistprojectedPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_path_add(a : GeodistprojectedPath, b : GeodistprojectedPath) -> GeodistprojectedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_projected_path_copy(s : GeodistprojectedPath) -> GeodistprojectedPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_path_fill(s : GeodistprojectedPath, v : Double) -> GeodistprojectedPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_path_min(s : GeodistprojectedPath) -> Double { @_common.min(s.data) }

pub fn geo_dist_projected_path_max(s : GeodistprojectedPath) -> Double { @_common.max(s.data) }

pub fn geo_dist_projected_path_to_string(s : GeodistprojectedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_cluster_make(size : Int) -> GeodistprojectedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_cluster_len(s : GeodistprojectedCluster) -> Int { s.size }

pub fn geo_dist_projected_cluster_get(s : GeodistprojectedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_cluster_set(s : GeodistprojectedCluster, i : Int, v : Double) -> GeodistprojectedCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_cluster_sum(s : GeodistprojectedCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_projected_cluster_mean(s : GeodistprojectedCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_projected_cluster_scale(s : GeodistprojectedCluster, f : Double) -> GeodistprojectedCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_cluster_add(a : GeodistprojectedCluster, b : GeodistprojectedCluster) -> GeodistprojectedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_projected_cluster_copy(s : GeodistprojectedCluster) -> GeodistprojectedCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_cluster_fill(s : GeodistprojectedCluster, v : Double) -> GeodistprojectedCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_cluster_min(s : GeodistprojectedCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_projected_cluster_max(s : GeodistprojectedCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_projected_cluster_to_string(s : GeodistprojectedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_model_make(size : Int) -> GeodistprojectedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_model_len(s : GeodistprojectedModel) -> Int { s.size }

pub fn geo_dist_projected_model_get(s : GeodistprojectedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_model_set(s : GeodistprojectedModel, i : Int, v : Double) -> GeodistprojectedModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_model_sum(s : GeodistprojectedModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_projected_model_mean(s : GeodistprojectedModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_projected_model_scale(s : GeodistprojectedModel, f : Double) -> GeodistprojectedModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_model_add(a : GeodistprojectedModel, b : GeodistprojectedModel) -> GeodistprojectedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_projected_model_copy(s : GeodistprojectedModel) -> GeodistprojectedModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_model_fill(s : GeodistprojectedModel, v : Double) -> GeodistprojectedModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_model_min(s : GeodistprojectedModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_projected_model_max(s : GeodistprojectedModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_projected_model_to_string(s : GeodistprojectedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_layer_make(size : Int) -> GeodistprojectedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_layer_len(s : GeodistprojectedLayer) -> Int { s.size }

pub fn geo_dist_projected_layer_get(s : GeodistprojectedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_layer_set(s : GeodistprojectedLayer, i : Int, v : Double) -> GeodistprojectedLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_layer_sum(s : GeodistprojectedLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_projected_layer_mean(s : GeodistprojectedLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_projected_layer_scale(s : GeodistprojectedLayer, f : Double) -> GeodistprojectedLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_layer_add(a : GeodistprojectedLayer, b : GeodistprojectedLayer) -> GeodistprojectedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_projected_layer_copy(s : GeodistprojectedLayer) -> GeodistprojectedLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_layer_fill(s : GeodistprojectedLayer, v : Double) -> GeodistprojectedLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_layer_min(s : GeodistprojectedLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_projected_layer_max(s : GeodistprojectedLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_projected_layer_to_string(s : GeodistprojectedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_buffer_make(size : Int) -> GeodistprojectedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_buffer_len(s : GeodistprojectedBuffer) -> Int { s.size }

pub fn geo_dist_projected_buffer_get(s : GeodistprojectedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_buffer_set(s : GeodistprojectedBuffer, i : Int, v : Double) -> GeodistprojectedBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_buffer_sum(s : GeodistprojectedBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_projected_buffer_mean(s : GeodistprojectedBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_projected_buffer_scale(s : GeodistprojectedBuffer, f : Double) -> GeodistprojectedBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_buffer_add(a : GeodistprojectedBuffer, b : GeodistprojectedBuffer) -> GeodistprojectedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_projected_buffer_copy(s : GeodistprojectedBuffer) -> GeodistprojectedBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_buffer_fill(s : GeodistprojectedBuffer, v : Double) -> GeodistprojectedBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_buffer_min(s : GeodistprojectedBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_projected_buffer_max(s : GeodistprojectedBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_projected_buffer_to_string(s : GeodistprojectedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_cursor_make(size : Int) -> GeodistprojectedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_cursor_len(s : GeodistprojectedCursor) -> Int { s.size }

pub fn geo_dist_projected_cursor_get(s : GeodistprojectedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_cursor_set(s : GeodistprojectedCursor, i : Int, v : Double) -> GeodistprojectedCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_cursor_sum(s : GeodistprojectedCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_projected_cursor_mean(s : GeodistprojectedCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_projected_cursor_scale(s : GeodistprojectedCursor, f : Double) -> GeodistprojectedCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_cursor_add(a : GeodistprojectedCursor, b : GeodistprojectedCursor) -> GeodistprojectedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_projected_cursor_copy(s : GeodistprojectedCursor) -> GeodistprojectedCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_cursor_fill(s : GeodistprojectedCursor, v : Double) -> GeodistprojectedCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_cursor_min(s : GeodistprojectedCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_projected_cursor_max(s : GeodistprojectedCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_projected_cursor_to_string(s : GeodistprojectedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_view_make(size : Int) -> GeodistprojectedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_view_len(s : GeodistprojectedView) -> Int { s.size }

pub fn geo_dist_projected_view_get(s : GeodistprojectedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_view_set(s : GeodistprojectedView, i : Int, v : Double) -> GeodistprojectedView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_view_sum(s : GeodistprojectedView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_projected_view_mean(s : GeodistprojectedView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_projected_view_scale(s : GeodistprojectedView, f : Double) -> GeodistprojectedView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_view_add(a : GeodistprojectedView, b : GeodistprojectedView) -> GeodistprojectedView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_projected_view_copy(s : GeodistprojectedView) -> GeodistprojectedView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_view_fill(s : GeodistprojectedView, v : Double) -> GeodistprojectedView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_view_min(s : GeodistprojectedView) -> Double { @_common.min(s.data) }

pub fn geo_dist_projected_view_max(s : GeodistprojectedView) -> Double { @_common.max(s.data) }

pub fn geo_dist_projected_view_to_string(s : GeodistprojectedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_range_make(size : Int) -> GeodistprojectedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_range_len(s : GeodistprojectedRange) -> Int { s.size }

pub fn geo_dist_projected_range_get(s : GeodistprojectedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_range_set(s : GeodistprojectedRange, i : Int, v : Double) -> GeodistprojectedRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_range_sum(s : GeodistprojectedRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_projected_range_mean(s : GeodistprojectedRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_projected_range_scale(s : GeodistprojectedRange, f : Double) -> GeodistprojectedRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_range_add(a : GeodistprojectedRange, b : GeodistprojectedRange) -> GeodistprojectedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_projected_range_copy(s : GeodistprojectedRange) -> GeodistprojectedRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_range_fill(s : GeodistprojectedRange, v : Double) -> GeodistprojectedRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_range_min(s : GeodistprojectedRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_projected_range_max(s : GeodistprojectedRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_projected_range_to_string(s : GeodistprojectedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistprojectedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_projected_slice_make(size : Int) -> GeodistprojectedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_projected_slice_len(s : GeodistprojectedSlice) -> Int { s.size }

pub fn geo_dist_projected_slice_get(s : GeodistprojectedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_projected_slice_set(s : GeodistprojectedSlice, i : Int, v : Double) -> GeodistprojectedSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_slice_sum(s : GeodistprojectedSlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_projected_slice_mean(s : GeodistprojectedSlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_projected_slice_scale(s : GeodistprojectedSlice, f : Double) -> GeodistprojectedSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_slice_add(a : GeodistprojectedSlice, b : GeodistprojectedSlice) -> GeodistprojectedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_projected_slice_copy(s : GeodistprojectedSlice) -> GeodistprojectedSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_slice_fill(s : GeodistprojectedSlice, v : Double) -> GeodistprojectedSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_projected_slice_min(s : GeodistprojectedSlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_projected_slice_max(s : GeodistprojectedSlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_projected_slice_to_string(s : GeodistprojectedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

