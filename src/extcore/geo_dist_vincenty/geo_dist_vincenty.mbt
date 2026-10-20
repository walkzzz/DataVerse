///===
/// extcore/geo_dist_vincenty

pub(all) struct GeodistvincentyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_vincenty_make_point(x : Double, y : Double) -> GeodistvincentyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_vincenty_make_point3(x : Double, y : Double, z : Double) -> GeodistvincentyPoint {
  { x, y, z, label: 0 }
}

pub fn GeodistvincentyPoint::x(self : GeodistvincentyPoint) -> Double { self.x }

pub fn GeodistvincentyPoint::y(self : GeodistvincentyPoint) -> Double { self.y }

pub fn GeodistvincentyPoint::z(self : GeodistvincentyPoint) -> Double { self.z }

pub fn GeodistvincentyPoint::label(self : GeodistvincentyPoint) -> Int { self.label }

pub fn GeodistvincentyPoint::dist(self : GeodistvincentyPoint, other : GeodistvincentyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistvincentyPoint::add(self : GeodistvincentyPoint, other : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistvincentyPoint::sub(self : GeodistvincentyPoint, other : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistvincentyPoint::scale(self : GeodistvincentyPoint, s : Double) -> GeodistvincentyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistvincentyPoint::dot(self : GeodistvincentyPoint, other : GeodistvincentyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistvincentyPoint::cross(self : GeodistvincentyPoint, other : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistvincentyPoint::norm(self : GeodistvincentyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistvincentyPoint::normalize(self : GeodistvincentyPoint) -> GeodistvincentyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistvincentyPoint::negate(self : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistvincentyPoint::mid(self : GeodistvincentyPoint, other : GeodistvincentyPoint) -> GeodistvincentyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistvincentyPoint::lerp(self : GeodistvincentyPoint, other : GeodistvincentyPoint, t : Double) -> GeodistvincentyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistvincentyPoint::to_string(self : GeodistvincentyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistvincentySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_vincenty_make_series(vals : Array[Double], name : String) -> GeodistvincentySeries {
  { vals, name, meta: 0 }
}

pub fn GeodistvincentySeries::len(self : GeodistvincentySeries) -> Int { self.vals.length() }

pub fn GeodistvincentySeries::sum(self : GeodistvincentySeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistvincentySeries::mean(self : GeodistvincentySeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistvincentySeries::min(self : GeodistvincentySeries) -> Double { @_common.min(self.vals) }

pub fn GeodistvincentySeries::max(self : GeodistvincentySeries) -> Double { @_common.max(self.vals) }

pub fn GeodistvincentySeries::range(self : GeodistvincentySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistvincentySeries::variance(self : GeodistvincentySeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistvincentySeries::std(self : GeodistvincentySeries) -> Double { @_common.std(self.vals) }

pub fn GeodistvincentySeries::median(self : GeodistvincentySeries) -> Double { @_common.median(self.vals) }

pub fn GeodistvincentySeries::scale(self : GeodistvincentySeries, f : Double) -> GeodistvincentySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistvincentySeries::add(self : GeodistvincentySeries, other : GeodistvincentySeries) -> GeodistvincentySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistvincentySeries::sub(self : GeodistvincentySeries, other : GeodistvincentySeries) -> GeodistvincentySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistvincentySeries::normalize(self : GeodistvincentySeries) -> GeodistvincentySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistvincentySeries::cumsum(self : GeodistvincentySeries) -> GeodistvincentySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistvincentySeries::to_string(self : GeodistvincentySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistvincentyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_vincenty_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistvincentyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_vincenty_matrix_identity(n : Int) -> GeodistvincentyMatrix {
  let m = geo_dist_vincenty_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistvincentyMatrix::get(self : GeodistvincentyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistvincentyMatrix::transpose(self : GeodistvincentyMatrix) -> GeodistvincentyMatrix {
  let result = geo_dist_vincenty_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistvincentyMatrix::add(self : GeodistvincentyMatrix, other : GeodistvincentyMatrix) -> GeodistvincentyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_vincenty_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistvincentyMatrix::scale(self : GeodistvincentyMatrix, s : Double) -> GeodistvincentyMatrix {
  let result = geo_dist_vincenty_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistvincentyMatrix::multiply(self : GeodistvincentyMatrix, other : GeodistvincentyMatrix) -> GeodistvincentyMatrix {
  if self.cols != other.rows { return geo_dist_vincenty_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_vincenty_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeodistvincentyMatrix::trace(self : GeodistvincentyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistvincentyMatrix::det(self : GeodistvincentyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistvincentyMatrix::norm(self : GeodistvincentyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistvincentyMatrix::to_string(self : GeodistvincentyMatrix) -> String {
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

pub(all) struct GeodistvincentyVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_vincenty_make_vector(comps : Array[Double]) -> GeodistvincentyVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_vincenty_vector_zero(dim : Int) -> GeodistvincentyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistvincentyVector::add(self : GeodistvincentyVector, other : GeodistvincentyVector) -> GeodistvincentyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistvincentyVector::sub(self : GeodistvincentyVector, other : GeodistvincentyVector) -> GeodistvincentyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistvincentyVector::scale(self : GeodistvincentyVector, s : Double) -> GeodistvincentyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistvincentyVector::dot(self : GeodistvincentyVector, other : GeodistvincentyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistvincentyVector::norm(self : GeodistvincentyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistvincentyVector::normalize(self : GeodistvincentyVector) -> GeodistvincentyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistvincentyVector::dist(self : GeodistvincentyVector, other : GeodistvincentyVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistvincentyVector::to_string(self : GeodistvincentyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_vincenty_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_vincenty_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_vincenty_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_vincenty_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_vincenty_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_vincenty_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_vincenty_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_vincenty_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_vincenty_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_vincenty_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_vincenty_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_vincenty_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_vincenty_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_vincenty_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_vincenty_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_vincenty_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_vincenty_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_vincenty_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_vincenty_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_vincenty_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_vincenty_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_vincenty_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_vincenty_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_vincenty_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_vincenty_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_vincenty_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_vincenty_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_vincenty_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_vincenty_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistvincentyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_frame_make(size : Int) -> GeodistvincentyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_frame_len(s : GeodistvincentyFrame) -> Int { s.size }

pub fn geo_dist_vincenty_frame_get(s : GeodistvincentyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_frame_set(s : GeodistvincentyFrame, i : Int, v : Double) -> GeodistvincentyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_frame_sum(s : GeodistvincentyFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_frame_mean(s : GeodistvincentyFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_frame_scale(s : GeodistvincentyFrame, f : Double) -> GeodistvincentyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_frame_add(a : GeodistvincentyFrame, b : GeodistvincentyFrame) -> GeodistvincentyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_frame_copy(s : GeodistvincentyFrame) -> GeodistvincentyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_frame_fill(s : GeodistvincentyFrame, v : Double) -> GeodistvincentyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_frame_min(s : GeodistvincentyFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_frame_max(s : GeodistvincentyFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_frame_to_string(s : GeodistvincentyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_table_make(size : Int) -> GeodistvincentyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_table_len(s : GeodistvincentyTable) -> Int { s.size }

pub fn geo_dist_vincenty_table_get(s : GeodistvincentyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_table_set(s : GeodistvincentyTable, i : Int, v : Double) -> GeodistvincentyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_table_sum(s : GeodistvincentyTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_table_mean(s : GeodistvincentyTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_table_scale(s : GeodistvincentyTable, f : Double) -> GeodistvincentyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_table_add(a : GeodistvincentyTable, b : GeodistvincentyTable) -> GeodistvincentyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_table_copy(s : GeodistvincentyTable) -> GeodistvincentyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_table_fill(s : GeodistvincentyTable, v : Double) -> GeodistvincentyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_table_min(s : GeodistvincentyTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_table_max(s : GeodistvincentyTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_table_to_string(s : GeodistvincentyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_graphn_make(size : Int) -> GeodistvincentyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_graphn_len(s : GeodistvincentyGraphN) -> Int { s.size }

pub fn geo_dist_vincenty_graphn_get(s : GeodistvincentyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_graphn_set(s : GeodistvincentyGraphN, i : Int, v : Double) -> GeodistvincentyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_graphn_sum(s : GeodistvincentyGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_graphn_mean(s : GeodistvincentyGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_graphn_scale(s : GeodistvincentyGraphN, f : Double) -> GeodistvincentyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_graphn_add(a : GeodistvincentyGraphN, b : GeodistvincentyGraphN) -> GeodistvincentyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_graphn_copy(s : GeodistvincentyGraphN) -> GeodistvincentyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_graphn_fill(s : GeodistvincentyGraphN, v : Double) -> GeodistvincentyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_graphn_min(s : GeodistvincentyGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_graphn_max(s : GeodistvincentyGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_graphn_to_string(s : GeodistvincentyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_node_make(size : Int) -> GeodistvincentyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_node_len(s : GeodistvincentyNode) -> Int { s.size }

pub fn geo_dist_vincenty_node_get(s : GeodistvincentyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_node_set(s : GeodistvincentyNode, i : Int, v : Double) -> GeodistvincentyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_node_sum(s : GeodistvincentyNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_node_mean(s : GeodistvincentyNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_node_scale(s : GeodistvincentyNode, f : Double) -> GeodistvincentyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_node_add(a : GeodistvincentyNode, b : GeodistvincentyNode) -> GeodistvincentyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_node_copy(s : GeodistvincentyNode) -> GeodistvincentyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_node_fill(s : GeodistvincentyNode, v : Double) -> GeodistvincentyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_node_min(s : GeodistvincentyNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_node_max(s : GeodistvincentyNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_node_to_string(s : GeodistvincentyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_edge_make(size : Int) -> GeodistvincentyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_edge_len(s : GeodistvincentyEdge) -> Int { s.size }

pub fn geo_dist_vincenty_edge_get(s : GeodistvincentyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_edge_set(s : GeodistvincentyEdge, i : Int, v : Double) -> GeodistvincentyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_edge_sum(s : GeodistvincentyEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_edge_mean(s : GeodistvincentyEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_edge_scale(s : GeodistvincentyEdge, f : Double) -> GeodistvincentyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_edge_add(a : GeodistvincentyEdge, b : GeodistvincentyEdge) -> GeodistvincentyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_edge_copy(s : GeodistvincentyEdge) -> GeodistvincentyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_edge_fill(s : GeodistvincentyEdge, v : Double) -> GeodistvincentyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_edge_min(s : GeodistvincentyEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_edge_max(s : GeodistvincentyEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_edge_to_string(s : GeodistvincentyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_path_make(size : Int) -> GeodistvincentyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_path_len(s : GeodistvincentyPath) -> Int { s.size }

pub fn geo_dist_vincenty_path_get(s : GeodistvincentyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_path_set(s : GeodistvincentyPath, i : Int, v : Double) -> GeodistvincentyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_path_sum(s : GeodistvincentyPath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_path_mean(s : GeodistvincentyPath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_path_scale(s : GeodistvincentyPath, f : Double) -> GeodistvincentyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_path_add(a : GeodistvincentyPath, b : GeodistvincentyPath) -> GeodistvincentyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_path_copy(s : GeodistvincentyPath) -> GeodistvincentyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_path_fill(s : GeodistvincentyPath, v : Double) -> GeodistvincentyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_path_min(s : GeodistvincentyPath) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_path_max(s : GeodistvincentyPath) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_path_to_string(s : GeodistvincentyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_cluster_make(size : Int) -> GeodistvincentyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_cluster_len(s : GeodistvincentyCluster) -> Int { s.size }

pub fn geo_dist_vincenty_cluster_get(s : GeodistvincentyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_cluster_set(s : GeodistvincentyCluster, i : Int, v : Double) -> GeodistvincentyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_cluster_sum(s : GeodistvincentyCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_cluster_mean(s : GeodistvincentyCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_cluster_scale(s : GeodistvincentyCluster, f : Double) -> GeodistvincentyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_cluster_add(a : GeodistvincentyCluster, b : GeodistvincentyCluster) -> GeodistvincentyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_cluster_copy(s : GeodistvincentyCluster) -> GeodistvincentyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_cluster_fill(s : GeodistvincentyCluster, v : Double) -> GeodistvincentyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_cluster_min(s : GeodistvincentyCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_cluster_max(s : GeodistvincentyCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_cluster_to_string(s : GeodistvincentyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_model_make(size : Int) -> GeodistvincentyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_model_len(s : GeodistvincentyModel) -> Int { s.size }

pub fn geo_dist_vincenty_model_get(s : GeodistvincentyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_model_set(s : GeodistvincentyModel, i : Int, v : Double) -> GeodistvincentyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_model_sum(s : GeodistvincentyModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_model_mean(s : GeodistvincentyModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_model_scale(s : GeodistvincentyModel, f : Double) -> GeodistvincentyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_model_add(a : GeodistvincentyModel, b : GeodistvincentyModel) -> GeodistvincentyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_model_copy(s : GeodistvincentyModel) -> GeodistvincentyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_model_fill(s : GeodistvincentyModel, v : Double) -> GeodistvincentyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_model_min(s : GeodistvincentyModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_model_max(s : GeodistvincentyModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_model_to_string(s : GeodistvincentyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_layer_make(size : Int) -> GeodistvincentyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_layer_len(s : GeodistvincentyLayer) -> Int { s.size }

pub fn geo_dist_vincenty_layer_get(s : GeodistvincentyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_layer_set(s : GeodistvincentyLayer, i : Int, v : Double) -> GeodistvincentyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_layer_sum(s : GeodistvincentyLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_layer_mean(s : GeodistvincentyLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_layer_scale(s : GeodistvincentyLayer, f : Double) -> GeodistvincentyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_layer_add(a : GeodistvincentyLayer, b : GeodistvincentyLayer) -> GeodistvincentyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_layer_copy(s : GeodistvincentyLayer) -> GeodistvincentyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_layer_fill(s : GeodistvincentyLayer, v : Double) -> GeodistvincentyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_layer_min(s : GeodistvincentyLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_layer_max(s : GeodistvincentyLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_layer_to_string(s : GeodistvincentyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_buffer_make(size : Int) -> GeodistvincentyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_buffer_len(s : GeodistvincentyBuffer) -> Int { s.size }

pub fn geo_dist_vincenty_buffer_get(s : GeodistvincentyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_buffer_set(s : GeodistvincentyBuffer, i : Int, v : Double) -> GeodistvincentyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_buffer_sum(s : GeodistvincentyBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_buffer_mean(s : GeodistvincentyBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_buffer_scale(s : GeodistvincentyBuffer, f : Double) -> GeodistvincentyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_buffer_add(a : GeodistvincentyBuffer, b : GeodistvincentyBuffer) -> GeodistvincentyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_buffer_copy(s : GeodistvincentyBuffer) -> GeodistvincentyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_buffer_fill(s : GeodistvincentyBuffer, v : Double) -> GeodistvincentyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_buffer_min(s : GeodistvincentyBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_buffer_max(s : GeodistvincentyBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_buffer_to_string(s : GeodistvincentyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_cursor_make(size : Int) -> GeodistvincentyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_cursor_len(s : GeodistvincentyCursor) -> Int { s.size }

pub fn geo_dist_vincenty_cursor_get(s : GeodistvincentyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_cursor_set(s : GeodistvincentyCursor, i : Int, v : Double) -> GeodistvincentyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_cursor_sum(s : GeodistvincentyCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_cursor_mean(s : GeodistvincentyCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_cursor_scale(s : GeodistvincentyCursor, f : Double) -> GeodistvincentyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_cursor_add(a : GeodistvincentyCursor, b : GeodistvincentyCursor) -> GeodistvincentyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_cursor_copy(s : GeodistvincentyCursor) -> GeodistvincentyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_cursor_fill(s : GeodistvincentyCursor, v : Double) -> GeodistvincentyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_cursor_min(s : GeodistvincentyCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_cursor_max(s : GeodistvincentyCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_cursor_to_string(s : GeodistvincentyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_view_make(size : Int) -> GeodistvincentyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_view_len(s : GeodistvincentyView) -> Int { s.size }

pub fn geo_dist_vincenty_view_get(s : GeodistvincentyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_view_set(s : GeodistvincentyView, i : Int, v : Double) -> GeodistvincentyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_view_sum(s : GeodistvincentyView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_view_mean(s : GeodistvincentyView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_view_scale(s : GeodistvincentyView, f : Double) -> GeodistvincentyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_view_add(a : GeodistvincentyView, b : GeodistvincentyView) -> GeodistvincentyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_view_copy(s : GeodistvincentyView) -> GeodistvincentyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_view_fill(s : GeodistvincentyView, v : Double) -> GeodistvincentyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_view_min(s : GeodistvincentyView) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_view_max(s : GeodistvincentyView) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_view_to_string(s : GeodistvincentyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_range_make(size : Int) -> GeodistvincentyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_range_len(s : GeodistvincentyRange) -> Int { s.size }

pub fn geo_dist_vincenty_range_get(s : GeodistvincentyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_range_set(s : GeodistvincentyRange, i : Int, v : Double) -> GeodistvincentyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_range_sum(s : GeodistvincentyRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_range_mean(s : GeodistvincentyRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_range_scale(s : GeodistvincentyRange, f : Double) -> GeodistvincentyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_range_add(a : GeodistvincentyRange, b : GeodistvincentyRange) -> GeodistvincentyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_range_copy(s : GeodistvincentyRange) -> GeodistvincentyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_range_fill(s : GeodistvincentyRange, v : Double) -> GeodistvincentyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_range_min(s : GeodistvincentyRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_range_max(s : GeodistvincentyRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_range_to_string(s : GeodistvincentyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistvincentySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_vincenty_slice_make(size : Int) -> GeodistvincentySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_vincenty_slice_len(s : GeodistvincentySlice) -> Int { s.size }

pub fn geo_dist_vincenty_slice_get(s : GeodistvincentySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_vincenty_slice_set(s : GeodistvincentySlice, i : Int, v : Double) -> GeodistvincentySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_slice_sum(s : GeodistvincentySlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_vincenty_slice_mean(s : GeodistvincentySlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_vincenty_slice_scale(s : GeodistvincentySlice, f : Double) -> GeodistvincentySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_slice_add(a : GeodistvincentySlice, b : GeodistvincentySlice) -> GeodistvincentySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_vincenty_slice_copy(s : GeodistvincentySlice) -> GeodistvincentySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_slice_fill(s : GeodistvincentySlice, v : Double) -> GeodistvincentySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_vincenty_slice_min(s : GeodistvincentySlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_vincenty_slice_max(s : GeodistvincentySlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_vincenty_slice_to_string(s : GeodistvincentySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

