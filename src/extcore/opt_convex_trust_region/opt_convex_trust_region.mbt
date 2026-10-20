///===
/// extcore/opt_convex_trust_region

pub(all) struct OptconvextrustregionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_trust_region_make_point(x : Double, y : Double) -> OptconvextrustregionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_trust_region_make_point3(x : Double, y : Double, z : Double) -> OptconvextrustregionPoint {
  { x, y, z, label: 0 }
}

pub fn OptconvextrustregionPoint::x(self : OptconvextrustregionPoint) -> Double { self.x }

pub fn OptconvextrustregionPoint::y(self : OptconvextrustregionPoint) -> Double { self.y }

pub fn OptconvextrustregionPoint::z(self : OptconvextrustregionPoint) -> Double { self.z }

pub fn OptconvextrustregionPoint::label(self : OptconvextrustregionPoint) -> Int { self.label }

pub fn OptconvextrustregionPoint::dist(self : OptconvextrustregionPoint, other : OptconvextrustregionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptconvextrustregionPoint::add(self : OptconvextrustregionPoint, other : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptconvextrustregionPoint::sub(self : OptconvextrustregionPoint, other : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptconvextrustregionPoint::scale(self : OptconvextrustregionPoint, s : Double) -> OptconvextrustregionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptconvextrustregionPoint::dot(self : OptconvextrustregionPoint, other : OptconvextrustregionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptconvextrustregionPoint::cross(self : OptconvextrustregionPoint, other : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptconvextrustregionPoint::norm(self : OptconvextrustregionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptconvextrustregionPoint::normalize(self : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvextrustregionPoint::negate(self : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptconvextrustregionPoint::mid(self : OptconvextrustregionPoint, other : OptconvextrustregionPoint) -> OptconvextrustregionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptconvextrustregionPoint::lerp(self : OptconvextrustregionPoint, other : OptconvextrustregionPoint, t : Double) -> OptconvextrustregionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptconvextrustregionPoint::to_string(self : OptconvextrustregionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptconvextrustregionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_trust_region_make_series(vals : Array[Double], name : String) -> OptconvextrustregionSeries {
  { vals, name, meta: 0 }
}

pub fn OptconvextrustregionSeries::len(self : OptconvextrustregionSeries) -> Int { self.vals.length() }

pub fn OptconvextrustregionSeries::sum(self : OptconvextrustregionSeries) -> Double { @_common.sum(self.vals) }

pub fn OptconvextrustregionSeries::mean(self : OptconvextrustregionSeries) -> Double { @_common.mean(self.vals) }

pub fn OptconvextrustregionSeries::min(self : OptconvextrustregionSeries) -> Double { @_common.min(self.vals) }

pub fn OptconvextrustregionSeries::max(self : OptconvextrustregionSeries) -> Double { @_common.max(self.vals) }

pub fn OptconvextrustregionSeries::range(self : OptconvextrustregionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptconvextrustregionSeries::variance(self : OptconvextrustregionSeries) -> Double { @_common.variance(self.vals) }

pub fn OptconvextrustregionSeries::std(self : OptconvextrustregionSeries) -> Double { @_common.std(self.vals) }

pub fn OptconvextrustregionSeries::median(self : OptconvextrustregionSeries) -> Double { @_common.median(self.vals) }

pub fn OptconvextrustregionSeries::scale(self : OptconvextrustregionSeries, f : Double) -> OptconvextrustregionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptconvextrustregionSeries::add(self : OptconvextrustregionSeries, other : OptconvextrustregionSeries) -> OptconvextrustregionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptconvextrustregionSeries::sub(self : OptconvextrustregionSeries, other : OptconvextrustregionSeries) -> OptconvextrustregionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptconvextrustregionSeries::normalize(self : OptconvextrustregionSeries) -> OptconvextrustregionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptconvextrustregionSeries::cumsum(self : OptconvextrustregionSeries) -> OptconvextrustregionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptconvextrustregionSeries::to_string(self : OptconvextrustregionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvextrustregionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_trust_region_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvextrustregionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_trust_region_matrix_identity(n : Int) -> OptconvextrustregionMatrix {
  let m = opt_convex_trust_region_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptconvextrustregionMatrix::get(self : OptconvextrustregionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptconvextrustregionMatrix::transpose(self : OptconvextrustregionMatrix) -> OptconvextrustregionMatrix {
  let result = opt_convex_trust_region_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptconvextrustregionMatrix::add(self : OptconvextrustregionMatrix, other : OptconvextrustregionMatrix) -> OptconvextrustregionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_convex_trust_region_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptconvextrustregionMatrix::scale(self : OptconvextrustregionMatrix, s : Double) -> OptconvextrustregionMatrix {
  let result = opt_convex_trust_region_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptconvextrustregionMatrix::multiply(self : OptconvextrustregionMatrix, other : OptconvextrustregionMatrix) -> OptconvextrustregionMatrix {
  if self.cols != other.rows { return opt_convex_trust_region_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_convex_trust_region_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptconvextrustregionMatrix::trace(self : OptconvextrustregionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptconvextrustregionMatrix::det(self : OptconvextrustregionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptconvextrustregionMatrix::norm(self : OptconvextrustregionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptconvextrustregionMatrix::to_string(self : OptconvextrustregionMatrix) -> String {
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

pub(all) struct OptconvextrustregionVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_trust_region_make_vector(comps : Array[Double]) -> OptconvextrustregionVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_trust_region_vector_zero(dim : Int) -> OptconvextrustregionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptconvextrustregionVector::add(self : OptconvextrustregionVector, other : OptconvextrustregionVector) -> OptconvextrustregionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvextrustregionVector::sub(self : OptconvextrustregionVector, other : OptconvextrustregionVector) -> OptconvextrustregionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptconvextrustregionVector::scale(self : OptconvextrustregionVector, s : Double) -> OptconvextrustregionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptconvextrustregionVector::dot(self : OptconvextrustregionVector, other : OptconvextrustregionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptconvextrustregionVector::norm(self : OptconvextrustregionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptconvextrustregionVector::normalize(self : OptconvextrustregionVector) -> OptconvextrustregionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptconvextrustregionVector::dist(self : OptconvextrustregionVector, other : OptconvextrustregionVector) -> Double {
  self.sub(other).norm()
}

pub fn OptconvextrustregionVector::to_string(self : OptconvextrustregionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_trust_region_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_convex_trust_region_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_convex_trust_region_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_convex_trust_region_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_convex_trust_region_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_convex_trust_region_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_convex_trust_region_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_convex_trust_region_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_convex_trust_region_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_convex_trust_region_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_convex_trust_region_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_convex_trust_region_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_convex_trust_region_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_convex_trust_region_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_convex_trust_region_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_convex_trust_region_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_convex_trust_region_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_convex_trust_region_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_convex_trust_region_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_convex_trust_region_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_convex_trust_region_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_convex_trust_region_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_convex_trust_region_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_convex_trust_region_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_convex_trust_region_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_convex_trust_region_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_convex_trust_region_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_convex_trust_region_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_convex_trust_region_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptconvextrustregionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_frame_make(size : Int) -> OptconvextrustregionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_frame_len(s : OptconvextrustregionFrame) -> Int { s.size }

pub fn opt_convex_trust_region_frame_get(s : OptconvextrustregionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_frame_set(s : OptconvextrustregionFrame, i : Int, v : Double) -> OptconvextrustregionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_frame_sum(s : OptconvextrustregionFrame) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_frame_mean(s : OptconvextrustregionFrame) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_frame_scale(s : OptconvextrustregionFrame, f : Double) -> OptconvextrustregionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_frame_add(a : OptconvextrustregionFrame, b : OptconvextrustregionFrame) -> OptconvextrustregionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_frame_copy(s : OptconvextrustregionFrame) -> OptconvextrustregionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_frame_fill(s : OptconvextrustregionFrame, v : Double) -> OptconvextrustregionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_frame_min(s : OptconvextrustregionFrame) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_frame_max(s : OptconvextrustregionFrame) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_frame_to_string(s : OptconvextrustregionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_table_make(size : Int) -> OptconvextrustregionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_table_len(s : OptconvextrustregionTable) -> Int { s.size }

pub fn opt_convex_trust_region_table_get(s : OptconvextrustregionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_table_set(s : OptconvextrustregionTable, i : Int, v : Double) -> OptconvextrustregionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_table_sum(s : OptconvextrustregionTable) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_table_mean(s : OptconvextrustregionTable) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_table_scale(s : OptconvextrustregionTable, f : Double) -> OptconvextrustregionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_table_add(a : OptconvextrustregionTable, b : OptconvextrustregionTable) -> OptconvextrustregionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_table_copy(s : OptconvextrustregionTable) -> OptconvextrustregionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_table_fill(s : OptconvextrustregionTable, v : Double) -> OptconvextrustregionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_table_min(s : OptconvextrustregionTable) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_table_max(s : OptconvextrustregionTable) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_table_to_string(s : OptconvextrustregionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_graphn_make(size : Int) -> OptconvextrustregionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_graphn_len(s : OptconvextrustregionGraphN) -> Int { s.size }

pub fn opt_convex_trust_region_graphn_get(s : OptconvextrustregionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_graphn_set(s : OptconvextrustregionGraphN, i : Int, v : Double) -> OptconvextrustregionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_graphn_sum(s : OptconvextrustregionGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_graphn_mean(s : OptconvextrustregionGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_graphn_scale(s : OptconvextrustregionGraphN, f : Double) -> OptconvextrustregionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_graphn_add(a : OptconvextrustregionGraphN, b : OptconvextrustregionGraphN) -> OptconvextrustregionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_graphn_copy(s : OptconvextrustregionGraphN) -> OptconvextrustregionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_graphn_fill(s : OptconvextrustregionGraphN, v : Double) -> OptconvextrustregionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_graphn_min(s : OptconvextrustregionGraphN) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_graphn_max(s : OptconvextrustregionGraphN) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_graphn_to_string(s : OptconvextrustregionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_node_make(size : Int) -> OptconvextrustregionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_node_len(s : OptconvextrustregionNode) -> Int { s.size }

pub fn opt_convex_trust_region_node_get(s : OptconvextrustregionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_node_set(s : OptconvextrustregionNode, i : Int, v : Double) -> OptconvextrustregionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_node_sum(s : OptconvextrustregionNode) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_node_mean(s : OptconvextrustregionNode) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_node_scale(s : OptconvextrustregionNode, f : Double) -> OptconvextrustregionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_node_add(a : OptconvextrustregionNode, b : OptconvextrustregionNode) -> OptconvextrustregionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_node_copy(s : OptconvextrustregionNode) -> OptconvextrustregionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_node_fill(s : OptconvextrustregionNode, v : Double) -> OptconvextrustregionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_node_min(s : OptconvextrustregionNode) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_node_max(s : OptconvextrustregionNode) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_node_to_string(s : OptconvextrustregionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_edge_make(size : Int) -> OptconvextrustregionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_edge_len(s : OptconvextrustregionEdge) -> Int { s.size }

pub fn opt_convex_trust_region_edge_get(s : OptconvextrustregionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_edge_set(s : OptconvextrustregionEdge, i : Int, v : Double) -> OptconvextrustregionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_edge_sum(s : OptconvextrustregionEdge) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_edge_mean(s : OptconvextrustregionEdge) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_edge_scale(s : OptconvextrustregionEdge, f : Double) -> OptconvextrustregionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_edge_add(a : OptconvextrustregionEdge, b : OptconvextrustregionEdge) -> OptconvextrustregionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_edge_copy(s : OptconvextrustregionEdge) -> OptconvextrustregionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_edge_fill(s : OptconvextrustregionEdge, v : Double) -> OptconvextrustregionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_edge_min(s : OptconvextrustregionEdge) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_edge_max(s : OptconvextrustregionEdge) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_edge_to_string(s : OptconvextrustregionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_path_make(size : Int) -> OptconvextrustregionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_path_len(s : OptconvextrustregionPath) -> Int { s.size }

pub fn opt_convex_trust_region_path_get(s : OptconvextrustregionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_path_set(s : OptconvextrustregionPath, i : Int, v : Double) -> OptconvextrustregionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_path_sum(s : OptconvextrustregionPath) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_path_mean(s : OptconvextrustregionPath) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_path_scale(s : OptconvextrustregionPath, f : Double) -> OptconvextrustregionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_path_add(a : OptconvextrustregionPath, b : OptconvextrustregionPath) -> OptconvextrustregionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_path_copy(s : OptconvextrustregionPath) -> OptconvextrustregionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_path_fill(s : OptconvextrustregionPath, v : Double) -> OptconvextrustregionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_path_min(s : OptconvextrustregionPath) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_path_max(s : OptconvextrustregionPath) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_path_to_string(s : OptconvextrustregionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_cluster_make(size : Int) -> OptconvextrustregionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_cluster_len(s : OptconvextrustregionCluster) -> Int { s.size }

pub fn opt_convex_trust_region_cluster_get(s : OptconvextrustregionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_cluster_set(s : OptconvextrustregionCluster, i : Int, v : Double) -> OptconvextrustregionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_cluster_sum(s : OptconvextrustregionCluster) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_cluster_mean(s : OptconvextrustregionCluster) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_cluster_scale(s : OptconvextrustregionCluster, f : Double) -> OptconvextrustregionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_cluster_add(a : OptconvextrustregionCluster, b : OptconvextrustregionCluster) -> OptconvextrustregionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_cluster_copy(s : OptconvextrustregionCluster) -> OptconvextrustregionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_cluster_fill(s : OptconvextrustregionCluster, v : Double) -> OptconvextrustregionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_cluster_min(s : OptconvextrustregionCluster) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_cluster_max(s : OptconvextrustregionCluster) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_cluster_to_string(s : OptconvextrustregionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_model_make(size : Int) -> OptconvextrustregionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_model_len(s : OptconvextrustregionModel) -> Int { s.size }

pub fn opt_convex_trust_region_model_get(s : OptconvextrustregionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_model_set(s : OptconvextrustregionModel, i : Int, v : Double) -> OptconvextrustregionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_model_sum(s : OptconvextrustregionModel) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_model_mean(s : OptconvextrustregionModel) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_model_scale(s : OptconvextrustregionModel, f : Double) -> OptconvextrustregionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_model_add(a : OptconvextrustregionModel, b : OptconvextrustregionModel) -> OptconvextrustregionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_model_copy(s : OptconvextrustregionModel) -> OptconvextrustregionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_model_fill(s : OptconvextrustregionModel, v : Double) -> OptconvextrustregionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_model_min(s : OptconvextrustregionModel) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_model_max(s : OptconvextrustregionModel) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_model_to_string(s : OptconvextrustregionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_layer_make(size : Int) -> OptconvextrustregionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_layer_len(s : OptconvextrustregionLayer) -> Int { s.size }

pub fn opt_convex_trust_region_layer_get(s : OptconvextrustregionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_layer_set(s : OptconvextrustregionLayer, i : Int, v : Double) -> OptconvextrustregionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_layer_sum(s : OptconvextrustregionLayer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_layer_mean(s : OptconvextrustregionLayer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_layer_scale(s : OptconvextrustregionLayer, f : Double) -> OptconvextrustregionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_layer_add(a : OptconvextrustregionLayer, b : OptconvextrustregionLayer) -> OptconvextrustregionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_layer_copy(s : OptconvextrustregionLayer) -> OptconvextrustregionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_layer_fill(s : OptconvextrustregionLayer, v : Double) -> OptconvextrustregionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_layer_min(s : OptconvextrustregionLayer) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_layer_max(s : OptconvextrustregionLayer) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_layer_to_string(s : OptconvextrustregionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_buffer_make(size : Int) -> OptconvextrustregionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_buffer_len(s : OptconvextrustregionBuffer) -> Int { s.size }

pub fn opt_convex_trust_region_buffer_get(s : OptconvextrustregionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_buffer_set(s : OptconvextrustregionBuffer, i : Int, v : Double) -> OptconvextrustregionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_buffer_sum(s : OptconvextrustregionBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_buffer_mean(s : OptconvextrustregionBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_buffer_scale(s : OptconvextrustregionBuffer, f : Double) -> OptconvextrustregionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_buffer_add(a : OptconvextrustregionBuffer, b : OptconvextrustregionBuffer) -> OptconvextrustregionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_buffer_copy(s : OptconvextrustregionBuffer) -> OptconvextrustregionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_buffer_fill(s : OptconvextrustregionBuffer, v : Double) -> OptconvextrustregionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_buffer_min(s : OptconvextrustregionBuffer) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_buffer_max(s : OptconvextrustregionBuffer) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_buffer_to_string(s : OptconvextrustregionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_cursor_make(size : Int) -> OptconvextrustregionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_cursor_len(s : OptconvextrustregionCursor) -> Int { s.size }

pub fn opt_convex_trust_region_cursor_get(s : OptconvextrustregionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_cursor_set(s : OptconvextrustregionCursor, i : Int, v : Double) -> OptconvextrustregionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_cursor_sum(s : OptconvextrustregionCursor) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_cursor_mean(s : OptconvextrustregionCursor) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_cursor_scale(s : OptconvextrustregionCursor, f : Double) -> OptconvextrustregionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_cursor_add(a : OptconvextrustregionCursor, b : OptconvextrustregionCursor) -> OptconvextrustregionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_cursor_copy(s : OptconvextrustregionCursor) -> OptconvextrustregionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_cursor_fill(s : OptconvextrustregionCursor, v : Double) -> OptconvextrustregionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_cursor_min(s : OptconvextrustregionCursor) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_cursor_max(s : OptconvextrustregionCursor) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_cursor_to_string(s : OptconvextrustregionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_view_make(size : Int) -> OptconvextrustregionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_view_len(s : OptconvextrustregionView) -> Int { s.size }

pub fn opt_convex_trust_region_view_get(s : OptconvextrustregionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_view_set(s : OptconvextrustregionView, i : Int, v : Double) -> OptconvextrustregionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_view_sum(s : OptconvextrustregionView) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_view_mean(s : OptconvextrustregionView) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_view_scale(s : OptconvextrustregionView, f : Double) -> OptconvextrustregionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_view_add(a : OptconvextrustregionView, b : OptconvextrustregionView) -> OptconvextrustregionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_view_copy(s : OptconvextrustregionView) -> OptconvextrustregionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_view_fill(s : OptconvextrustregionView, v : Double) -> OptconvextrustregionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_view_min(s : OptconvextrustregionView) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_view_max(s : OptconvextrustregionView) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_view_to_string(s : OptconvextrustregionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_range_make(size : Int) -> OptconvextrustregionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_range_len(s : OptconvextrustregionRange) -> Int { s.size }

pub fn opt_convex_trust_region_range_get(s : OptconvextrustregionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_range_set(s : OptconvextrustregionRange, i : Int, v : Double) -> OptconvextrustregionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_range_sum(s : OptconvextrustregionRange) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_range_mean(s : OptconvextrustregionRange) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_range_scale(s : OptconvextrustregionRange, f : Double) -> OptconvextrustregionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_range_add(a : OptconvextrustregionRange, b : OptconvextrustregionRange) -> OptconvextrustregionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_range_copy(s : OptconvextrustregionRange) -> OptconvextrustregionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_range_fill(s : OptconvextrustregionRange, v : Double) -> OptconvextrustregionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_range_min(s : OptconvextrustregionRange) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_range_max(s : OptconvextrustregionRange) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_range_to_string(s : OptconvextrustregionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvextrustregionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_trust_region_slice_make(size : Int) -> OptconvextrustregionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_trust_region_slice_len(s : OptconvextrustregionSlice) -> Int { s.size }

pub fn opt_convex_trust_region_slice_get(s : OptconvextrustregionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_trust_region_slice_set(s : OptconvextrustregionSlice, i : Int, v : Double) -> OptconvextrustregionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_slice_sum(s : OptconvextrustregionSlice) -> Double { @_common.sum(s.data) }

pub fn opt_convex_trust_region_slice_mean(s : OptconvextrustregionSlice) -> Double { @_common.mean(s.data) }

pub fn opt_convex_trust_region_slice_scale(s : OptconvextrustregionSlice, f : Double) -> OptconvextrustregionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_slice_add(a : OptconvextrustregionSlice, b : OptconvextrustregionSlice) -> OptconvextrustregionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_convex_trust_region_slice_copy(s : OptconvextrustregionSlice) -> OptconvextrustregionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_slice_fill(s : OptconvextrustregionSlice, v : Double) -> OptconvextrustregionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_convex_trust_region_slice_min(s : OptconvextrustregionSlice) -> Double { @_common.min(s.data) }

pub fn opt_convex_trust_region_slice_max(s : OptconvextrustregionSlice) -> Double { @_common.max(s.data) }

pub fn opt_convex_trust_region_slice_to_string(s : OptconvextrustregionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

