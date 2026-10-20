///===
/// extcore/geo_proj_lambert

pub(all) struct GeoprojlambertPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_lambert_make_point(x : Double, y : Double) -> GeoprojlambertPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_lambert_make_point3(x : Double, y : Double, z : Double) -> GeoprojlambertPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojlambertPoint::x(self : GeoprojlambertPoint) -> Double { self.x }

pub fn GeoprojlambertPoint::y(self : GeoprojlambertPoint) -> Double { self.y }

pub fn GeoprojlambertPoint::z(self : GeoprojlambertPoint) -> Double { self.z }

pub fn GeoprojlambertPoint::label(self : GeoprojlambertPoint) -> Int { self.label }

pub fn GeoprojlambertPoint::dist(self : GeoprojlambertPoint, other : GeoprojlambertPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojlambertPoint::add(self : GeoprojlambertPoint, other : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojlambertPoint::sub(self : GeoprojlambertPoint, other : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojlambertPoint::scale(self : GeoprojlambertPoint, s : Double) -> GeoprojlambertPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojlambertPoint::dot(self : GeoprojlambertPoint, other : GeoprojlambertPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojlambertPoint::cross(self : GeoprojlambertPoint, other : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojlambertPoint::norm(self : GeoprojlambertPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojlambertPoint::normalize(self : GeoprojlambertPoint) -> GeoprojlambertPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojlambertPoint::negate(self : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojlambertPoint::mid(self : GeoprojlambertPoint, other : GeoprojlambertPoint) -> GeoprojlambertPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojlambertPoint::lerp(self : GeoprojlambertPoint, other : GeoprojlambertPoint, t : Double) -> GeoprojlambertPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojlambertPoint::to_string(self : GeoprojlambertPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojlambertSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_lambert_make_series(vals : Array[Double], name : String) -> GeoprojlambertSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojlambertSeries::len(self : GeoprojlambertSeries) -> Int { self.vals.length() }

pub fn GeoprojlambertSeries::sum(self : GeoprojlambertSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojlambertSeries::mean(self : GeoprojlambertSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojlambertSeries::min(self : GeoprojlambertSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojlambertSeries::max(self : GeoprojlambertSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojlambertSeries::range(self : GeoprojlambertSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojlambertSeries::variance(self : GeoprojlambertSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojlambertSeries::std(self : GeoprojlambertSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojlambertSeries::median(self : GeoprojlambertSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojlambertSeries::scale(self : GeoprojlambertSeries, f : Double) -> GeoprojlambertSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojlambertSeries::add(self : GeoprojlambertSeries, other : GeoprojlambertSeries) -> GeoprojlambertSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojlambertSeries::sub(self : GeoprojlambertSeries, other : GeoprojlambertSeries) -> GeoprojlambertSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojlambertSeries::normalize(self : GeoprojlambertSeries) -> GeoprojlambertSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojlambertSeries::cumsum(self : GeoprojlambertSeries) -> GeoprojlambertSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojlambertSeries::to_string(self : GeoprojlambertSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojlambertMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_lambert_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojlambertMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_lambert_matrix_identity(n : Int) -> GeoprojlambertMatrix {
  let m = geo_proj_lambert_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojlambertMatrix::get(self : GeoprojlambertMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojlambertMatrix::transpose(self : GeoprojlambertMatrix) -> GeoprojlambertMatrix {
  let result = geo_proj_lambert_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojlambertMatrix::add(self : GeoprojlambertMatrix, other : GeoprojlambertMatrix) -> GeoprojlambertMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_lambert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojlambertMatrix::scale(self : GeoprojlambertMatrix, s : Double) -> GeoprojlambertMatrix {
  let result = geo_proj_lambert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojlambertMatrix::multiply(self : GeoprojlambertMatrix, other : GeoprojlambertMatrix) -> GeoprojlambertMatrix {
  if self.cols != other.rows { return geo_proj_lambert_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_lambert_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeoprojlambertMatrix::trace(self : GeoprojlambertMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojlambertMatrix::det(self : GeoprojlambertMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojlambertMatrix::norm(self : GeoprojlambertMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojlambertMatrix::to_string(self : GeoprojlambertMatrix) -> String {
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

pub(all) struct GeoprojlambertVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_lambert_make_vector(comps : Array[Double]) -> GeoprojlambertVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_lambert_vector_zero(dim : Int) -> GeoprojlambertVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojlambertVector::add(self : GeoprojlambertVector, other : GeoprojlambertVector) -> GeoprojlambertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojlambertVector::sub(self : GeoprojlambertVector, other : GeoprojlambertVector) -> GeoprojlambertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojlambertVector::scale(self : GeoprojlambertVector, s : Double) -> GeoprojlambertVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojlambertVector::dot(self : GeoprojlambertVector, other : GeoprojlambertVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojlambertVector::norm(self : GeoprojlambertVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojlambertVector::normalize(self : GeoprojlambertVector) -> GeoprojlambertVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojlambertVector::dist(self : GeoprojlambertVector, other : GeoprojlambertVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojlambertVector::to_string(self : GeoprojlambertVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_lambert_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_lambert_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_lambert_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_lambert_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_lambert_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_lambert_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_lambert_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_lambert_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_lambert_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_lambert_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_lambert_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_lambert_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_lambert_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_lambert_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_lambert_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_lambert_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_lambert_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_lambert_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_lambert_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_lambert_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_lambert_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_lambert_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_lambert_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_lambert_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_lambert_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_lambert_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_lambert_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_lambert_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_lambert_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojlambertFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_frame_make(size : Int) -> GeoprojlambertFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_frame_len(s : GeoprojlambertFrame) -> Int { s.size }

pub fn geo_proj_lambert_frame_get(s : GeoprojlambertFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_frame_set(s : GeoprojlambertFrame, i : Int, v : Double) -> GeoprojlambertFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_frame_sum(s : GeoprojlambertFrame) -> Double { @_common.sum(s.data) }

pub fn geo_proj_lambert_frame_mean(s : GeoprojlambertFrame) -> Double { @_common.mean(s.data) }

pub fn geo_proj_lambert_frame_scale(s : GeoprojlambertFrame, f : Double) -> GeoprojlambertFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_frame_add(a : GeoprojlambertFrame, b : GeoprojlambertFrame) -> GeoprojlambertFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_lambert_frame_copy(s : GeoprojlambertFrame) -> GeoprojlambertFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_frame_fill(s : GeoprojlambertFrame, v : Double) -> GeoprojlambertFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_frame_min(s : GeoprojlambertFrame) -> Double { @_common.min(s.data) }

pub fn geo_proj_lambert_frame_max(s : GeoprojlambertFrame) -> Double { @_common.max(s.data) }

pub fn geo_proj_lambert_frame_to_string(s : GeoprojlambertFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_table_make(size : Int) -> GeoprojlambertTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_table_len(s : GeoprojlambertTable) -> Int { s.size }

pub fn geo_proj_lambert_table_get(s : GeoprojlambertTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_table_set(s : GeoprojlambertTable, i : Int, v : Double) -> GeoprojlambertTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_table_sum(s : GeoprojlambertTable) -> Double { @_common.sum(s.data) }

pub fn geo_proj_lambert_table_mean(s : GeoprojlambertTable) -> Double { @_common.mean(s.data) }

pub fn geo_proj_lambert_table_scale(s : GeoprojlambertTable, f : Double) -> GeoprojlambertTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_table_add(a : GeoprojlambertTable, b : GeoprojlambertTable) -> GeoprojlambertTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_lambert_table_copy(s : GeoprojlambertTable) -> GeoprojlambertTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_table_fill(s : GeoprojlambertTable, v : Double) -> GeoprojlambertTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_table_min(s : GeoprojlambertTable) -> Double { @_common.min(s.data) }

pub fn geo_proj_lambert_table_max(s : GeoprojlambertTable) -> Double { @_common.max(s.data) }

pub fn geo_proj_lambert_table_to_string(s : GeoprojlambertTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_graphn_make(size : Int) -> GeoprojlambertGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_graphn_len(s : GeoprojlambertGraphN) -> Int { s.size }

pub fn geo_proj_lambert_graphn_get(s : GeoprojlambertGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_graphn_set(s : GeoprojlambertGraphN, i : Int, v : Double) -> GeoprojlambertGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_graphn_sum(s : GeoprojlambertGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_proj_lambert_graphn_mean(s : GeoprojlambertGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_proj_lambert_graphn_scale(s : GeoprojlambertGraphN, f : Double) -> GeoprojlambertGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_graphn_add(a : GeoprojlambertGraphN, b : GeoprojlambertGraphN) -> GeoprojlambertGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_lambert_graphn_copy(s : GeoprojlambertGraphN) -> GeoprojlambertGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_graphn_fill(s : GeoprojlambertGraphN, v : Double) -> GeoprojlambertGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_graphn_min(s : GeoprojlambertGraphN) -> Double { @_common.min(s.data) }

pub fn geo_proj_lambert_graphn_max(s : GeoprojlambertGraphN) -> Double { @_common.max(s.data) }

pub fn geo_proj_lambert_graphn_to_string(s : GeoprojlambertGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_node_make(size : Int) -> GeoprojlambertNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_node_len(s : GeoprojlambertNode) -> Int { s.size }

pub fn geo_proj_lambert_node_get(s : GeoprojlambertNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_node_set(s : GeoprojlambertNode, i : Int, v : Double) -> GeoprojlambertNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_node_sum(s : GeoprojlambertNode) -> Double { @_common.sum(s.data) }

pub fn geo_proj_lambert_node_mean(s : GeoprojlambertNode) -> Double { @_common.mean(s.data) }

pub fn geo_proj_lambert_node_scale(s : GeoprojlambertNode, f : Double) -> GeoprojlambertNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_node_add(a : GeoprojlambertNode, b : GeoprojlambertNode) -> GeoprojlambertNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_lambert_node_copy(s : GeoprojlambertNode) -> GeoprojlambertNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_node_fill(s : GeoprojlambertNode, v : Double) -> GeoprojlambertNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_node_min(s : GeoprojlambertNode) -> Double { @_common.min(s.data) }

pub fn geo_proj_lambert_node_max(s : GeoprojlambertNode) -> Double { @_common.max(s.data) }

pub fn geo_proj_lambert_node_to_string(s : GeoprojlambertNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_edge_make(size : Int) -> GeoprojlambertEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_edge_len(s : GeoprojlambertEdge) -> Int { s.size }

pub fn geo_proj_lambert_edge_get(s : GeoprojlambertEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_edge_set(s : GeoprojlambertEdge, i : Int, v : Double) -> GeoprojlambertEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_edge_sum(s : GeoprojlambertEdge) -> Double { @_common.sum(s.data) }

pub fn geo_proj_lambert_edge_mean(s : GeoprojlambertEdge) -> Double { @_common.mean(s.data) }

pub fn geo_proj_lambert_edge_scale(s : GeoprojlambertEdge, f : Double) -> GeoprojlambertEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_edge_add(a : GeoprojlambertEdge, b : GeoprojlambertEdge) -> GeoprojlambertEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_lambert_edge_copy(s : GeoprojlambertEdge) -> GeoprojlambertEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_edge_fill(s : GeoprojlambertEdge, v : Double) -> GeoprojlambertEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_edge_min(s : GeoprojlambertEdge) -> Double { @_common.min(s.data) }

pub fn geo_proj_lambert_edge_max(s : GeoprojlambertEdge) -> Double { @_common.max(s.data) }

pub fn geo_proj_lambert_edge_to_string(s : GeoprojlambertEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_path_make(size : Int) -> GeoprojlambertPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_path_len(s : GeoprojlambertPath) -> Int { s.size }

pub fn geo_proj_lambert_path_get(s : GeoprojlambertPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_path_set(s : GeoprojlambertPath, i : Int, v : Double) -> GeoprojlambertPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_path_sum(s : GeoprojlambertPath) -> Double { @_common.sum(s.data) }

pub fn geo_proj_lambert_path_mean(s : GeoprojlambertPath) -> Double { @_common.mean(s.data) }

pub fn geo_proj_lambert_path_scale(s : GeoprojlambertPath, f : Double) -> GeoprojlambertPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_path_add(a : GeoprojlambertPath, b : GeoprojlambertPath) -> GeoprojlambertPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_lambert_path_copy(s : GeoprojlambertPath) -> GeoprojlambertPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_path_fill(s : GeoprojlambertPath, v : Double) -> GeoprojlambertPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_path_min(s : GeoprojlambertPath) -> Double { @_common.min(s.data) }

pub fn geo_proj_lambert_path_max(s : GeoprojlambertPath) -> Double { @_common.max(s.data) }

pub fn geo_proj_lambert_path_to_string(s : GeoprojlambertPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_cluster_make(size : Int) -> GeoprojlambertCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_cluster_len(s : GeoprojlambertCluster) -> Int { s.size }

pub fn geo_proj_lambert_cluster_get(s : GeoprojlambertCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_cluster_set(s : GeoprojlambertCluster, i : Int, v : Double) -> GeoprojlambertCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_cluster_sum(s : GeoprojlambertCluster) -> Double { @_common.sum(s.data) }

pub fn geo_proj_lambert_cluster_mean(s : GeoprojlambertCluster) -> Double { @_common.mean(s.data) }

pub fn geo_proj_lambert_cluster_scale(s : GeoprojlambertCluster, f : Double) -> GeoprojlambertCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_cluster_add(a : GeoprojlambertCluster, b : GeoprojlambertCluster) -> GeoprojlambertCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_lambert_cluster_copy(s : GeoprojlambertCluster) -> GeoprojlambertCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_cluster_fill(s : GeoprojlambertCluster, v : Double) -> GeoprojlambertCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_cluster_min(s : GeoprojlambertCluster) -> Double { @_common.min(s.data) }

pub fn geo_proj_lambert_cluster_max(s : GeoprojlambertCluster) -> Double { @_common.max(s.data) }

pub fn geo_proj_lambert_cluster_to_string(s : GeoprojlambertCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_model_make(size : Int) -> GeoprojlambertModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_model_len(s : GeoprojlambertModel) -> Int { s.size }

pub fn geo_proj_lambert_model_get(s : GeoprojlambertModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_model_set(s : GeoprojlambertModel, i : Int, v : Double) -> GeoprojlambertModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_model_sum(s : GeoprojlambertModel) -> Double { @_common.sum(s.data) }

pub fn geo_proj_lambert_model_mean(s : GeoprojlambertModel) -> Double { @_common.mean(s.data) }

pub fn geo_proj_lambert_model_scale(s : GeoprojlambertModel, f : Double) -> GeoprojlambertModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_model_add(a : GeoprojlambertModel, b : GeoprojlambertModel) -> GeoprojlambertModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_lambert_model_copy(s : GeoprojlambertModel) -> GeoprojlambertModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_model_fill(s : GeoprojlambertModel, v : Double) -> GeoprojlambertModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_model_min(s : GeoprojlambertModel) -> Double { @_common.min(s.data) }

pub fn geo_proj_lambert_model_max(s : GeoprojlambertModel) -> Double { @_common.max(s.data) }

pub fn geo_proj_lambert_model_to_string(s : GeoprojlambertModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_layer_make(size : Int) -> GeoprojlambertLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_layer_len(s : GeoprojlambertLayer) -> Int { s.size }

pub fn geo_proj_lambert_layer_get(s : GeoprojlambertLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_layer_set(s : GeoprojlambertLayer, i : Int, v : Double) -> GeoprojlambertLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_layer_sum(s : GeoprojlambertLayer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_lambert_layer_mean(s : GeoprojlambertLayer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_lambert_layer_scale(s : GeoprojlambertLayer, f : Double) -> GeoprojlambertLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_layer_add(a : GeoprojlambertLayer, b : GeoprojlambertLayer) -> GeoprojlambertLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_lambert_layer_copy(s : GeoprojlambertLayer) -> GeoprojlambertLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_layer_fill(s : GeoprojlambertLayer, v : Double) -> GeoprojlambertLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_layer_min(s : GeoprojlambertLayer) -> Double { @_common.min(s.data) }

pub fn geo_proj_lambert_layer_max(s : GeoprojlambertLayer) -> Double { @_common.max(s.data) }

pub fn geo_proj_lambert_layer_to_string(s : GeoprojlambertLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_buffer_make(size : Int) -> GeoprojlambertBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_buffer_len(s : GeoprojlambertBuffer) -> Int { s.size }

pub fn geo_proj_lambert_buffer_get(s : GeoprojlambertBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_buffer_set(s : GeoprojlambertBuffer, i : Int, v : Double) -> GeoprojlambertBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_buffer_sum(s : GeoprojlambertBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_lambert_buffer_mean(s : GeoprojlambertBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_lambert_buffer_scale(s : GeoprojlambertBuffer, f : Double) -> GeoprojlambertBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_buffer_add(a : GeoprojlambertBuffer, b : GeoprojlambertBuffer) -> GeoprojlambertBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_lambert_buffer_copy(s : GeoprojlambertBuffer) -> GeoprojlambertBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_buffer_fill(s : GeoprojlambertBuffer, v : Double) -> GeoprojlambertBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_buffer_min(s : GeoprojlambertBuffer) -> Double { @_common.min(s.data) }

pub fn geo_proj_lambert_buffer_max(s : GeoprojlambertBuffer) -> Double { @_common.max(s.data) }

pub fn geo_proj_lambert_buffer_to_string(s : GeoprojlambertBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_cursor_make(size : Int) -> GeoprojlambertCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_cursor_len(s : GeoprojlambertCursor) -> Int { s.size }

pub fn geo_proj_lambert_cursor_get(s : GeoprojlambertCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_cursor_set(s : GeoprojlambertCursor, i : Int, v : Double) -> GeoprojlambertCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_cursor_sum(s : GeoprojlambertCursor) -> Double { @_common.sum(s.data) }

pub fn geo_proj_lambert_cursor_mean(s : GeoprojlambertCursor) -> Double { @_common.mean(s.data) }

pub fn geo_proj_lambert_cursor_scale(s : GeoprojlambertCursor, f : Double) -> GeoprojlambertCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_cursor_add(a : GeoprojlambertCursor, b : GeoprojlambertCursor) -> GeoprojlambertCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_lambert_cursor_copy(s : GeoprojlambertCursor) -> GeoprojlambertCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_cursor_fill(s : GeoprojlambertCursor, v : Double) -> GeoprojlambertCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_cursor_min(s : GeoprojlambertCursor) -> Double { @_common.min(s.data) }

pub fn geo_proj_lambert_cursor_max(s : GeoprojlambertCursor) -> Double { @_common.max(s.data) }

pub fn geo_proj_lambert_cursor_to_string(s : GeoprojlambertCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_view_make(size : Int) -> GeoprojlambertView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_view_len(s : GeoprojlambertView) -> Int { s.size }

pub fn geo_proj_lambert_view_get(s : GeoprojlambertView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_view_set(s : GeoprojlambertView, i : Int, v : Double) -> GeoprojlambertView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_view_sum(s : GeoprojlambertView) -> Double { @_common.sum(s.data) }

pub fn geo_proj_lambert_view_mean(s : GeoprojlambertView) -> Double { @_common.mean(s.data) }

pub fn geo_proj_lambert_view_scale(s : GeoprojlambertView, f : Double) -> GeoprojlambertView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_view_add(a : GeoprojlambertView, b : GeoprojlambertView) -> GeoprojlambertView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_lambert_view_copy(s : GeoprojlambertView) -> GeoprojlambertView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_view_fill(s : GeoprojlambertView, v : Double) -> GeoprojlambertView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_view_min(s : GeoprojlambertView) -> Double { @_common.min(s.data) }

pub fn geo_proj_lambert_view_max(s : GeoprojlambertView) -> Double { @_common.max(s.data) }

pub fn geo_proj_lambert_view_to_string(s : GeoprojlambertView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_range_make(size : Int) -> GeoprojlambertRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_range_len(s : GeoprojlambertRange) -> Int { s.size }

pub fn geo_proj_lambert_range_get(s : GeoprojlambertRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_range_set(s : GeoprojlambertRange, i : Int, v : Double) -> GeoprojlambertRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_range_sum(s : GeoprojlambertRange) -> Double { @_common.sum(s.data) }

pub fn geo_proj_lambert_range_mean(s : GeoprojlambertRange) -> Double { @_common.mean(s.data) }

pub fn geo_proj_lambert_range_scale(s : GeoprojlambertRange, f : Double) -> GeoprojlambertRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_range_add(a : GeoprojlambertRange, b : GeoprojlambertRange) -> GeoprojlambertRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_lambert_range_copy(s : GeoprojlambertRange) -> GeoprojlambertRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_range_fill(s : GeoprojlambertRange, v : Double) -> GeoprojlambertRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_range_min(s : GeoprojlambertRange) -> Double { @_common.min(s.data) }

pub fn geo_proj_lambert_range_max(s : GeoprojlambertRange) -> Double { @_common.max(s.data) }

pub fn geo_proj_lambert_range_to_string(s : GeoprojlambertRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojlambertSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_lambert_slice_make(size : Int) -> GeoprojlambertSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_lambert_slice_len(s : GeoprojlambertSlice) -> Int { s.size }

pub fn geo_proj_lambert_slice_get(s : GeoprojlambertSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_lambert_slice_set(s : GeoprojlambertSlice, i : Int, v : Double) -> GeoprojlambertSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_slice_sum(s : GeoprojlambertSlice) -> Double { @_common.sum(s.data) }

pub fn geo_proj_lambert_slice_mean(s : GeoprojlambertSlice) -> Double { @_common.mean(s.data) }

pub fn geo_proj_lambert_slice_scale(s : GeoprojlambertSlice, f : Double) -> GeoprojlambertSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_slice_add(a : GeoprojlambertSlice, b : GeoprojlambertSlice) -> GeoprojlambertSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_lambert_slice_copy(s : GeoprojlambertSlice) -> GeoprojlambertSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_slice_fill(s : GeoprojlambertSlice, v : Double) -> GeoprojlambertSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_lambert_slice_min(s : GeoprojlambertSlice) -> Double { @_common.min(s.data) }

pub fn geo_proj_lambert_slice_max(s : GeoprojlambertSlice) -> Double { @_common.max(s.data) }

pub fn geo_proj_lambert_slice_to_string(s : GeoprojlambertSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

