///===
/// extcore/geo_proj_conic

pub(all) struct GeoprojconicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_conic_make_point(x : Double, y : Double) -> GeoprojconicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_conic_make_point3(x : Double, y : Double, z : Double) -> GeoprojconicPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojconicPoint::x(self : GeoprojconicPoint) -> Double { self.x }

pub fn GeoprojconicPoint::y(self : GeoprojconicPoint) -> Double { self.y }

pub fn GeoprojconicPoint::z(self : GeoprojconicPoint) -> Double { self.z }

pub fn GeoprojconicPoint::label(self : GeoprojconicPoint) -> Int { self.label }

pub fn GeoprojconicPoint::dist(self : GeoprojconicPoint, other : GeoprojconicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojconicPoint::add(self : GeoprojconicPoint, other : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojconicPoint::sub(self : GeoprojconicPoint, other : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojconicPoint::scale(self : GeoprojconicPoint, s : Double) -> GeoprojconicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojconicPoint::dot(self : GeoprojconicPoint, other : GeoprojconicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojconicPoint::cross(self : GeoprojconicPoint, other : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojconicPoint::norm(self : GeoprojconicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojconicPoint::normalize(self : GeoprojconicPoint) -> GeoprojconicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojconicPoint::negate(self : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojconicPoint::mid(self : GeoprojconicPoint, other : GeoprojconicPoint) -> GeoprojconicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojconicPoint::lerp(self : GeoprojconicPoint, other : GeoprojconicPoint, t : Double) -> GeoprojconicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojconicPoint::to_string(self : GeoprojconicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojconicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_conic_make_series(vals : Array[Double], name : String) -> GeoprojconicSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojconicSeries::len(self : GeoprojconicSeries) -> Int { self.vals.length() }

pub fn GeoprojconicSeries::sum(self : GeoprojconicSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojconicSeries::mean(self : GeoprojconicSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojconicSeries::min(self : GeoprojconicSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojconicSeries::max(self : GeoprojconicSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojconicSeries::range(self : GeoprojconicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojconicSeries::variance(self : GeoprojconicSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojconicSeries::std(self : GeoprojconicSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojconicSeries::median(self : GeoprojconicSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojconicSeries::scale(self : GeoprojconicSeries, f : Double) -> GeoprojconicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojconicSeries::add(self : GeoprojconicSeries, other : GeoprojconicSeries) -> GeoprojconicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojconicSeries::sub(self : GeoprojconicSeries, other : GeoprojconicSeries) -> GeoprojconicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojconicSeries::normalize(self : GeoprojconicSeries) -> GeoprojconicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojconicSeries::cumsum(self : GeoprojconicSeries) -> GeoprojconicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojconicSeries::to_string(self : GeoprojconicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojconicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_conic_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojconicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_conic_matrix_identity(n : Int) -> GeoprojconicMatrix {
  let m = geo_proj_conic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojconicMatrix::get(self : GeoprojconicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojconicMatrix::transpose(self : GeoprojconicMatrix) -> GeoprojconicMatrix {
  let result = geo_proj_conic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojconicMatrix::add(self : GeoprojconicMatrix, other : GeoprojconicMatrix) -> GeoprojconicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_conic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojconicMatrix::scale(self : GeoprojconicMatrix, s : Double) -> GeoprojconicMatrix {
  let result = geo_proj_conic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojconicMatrix::multiply(self : GeoprojconicMatrix, other : GeoprojconicMatrix) -> GeoprojconicMatrix {
  if self.cols != other.rows { return geo_proj_conic_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_conic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeoprojconicMatrix::trace(self : GeoprojconicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojconicMatrix::det(self : GeoprojconicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojconicMatrix::norm(self : GeoprojconicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojconicMatrix::to_string(self : GeoprojconicMatrix) -> String {
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

pub(all) struct GeoprojconicVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_conic_make_vector(comps : Array[Double]) -> GeoprojconicVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_conic_vector_zero(dim : Int) -> GeoprojconicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojconicVector::add(self : GeoprojconicVector, other : GeoprojconicVector) -> GeoprojconicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojconicVector::sub(self : GeoprojconicVector, other : GeoprojconicVector) -> GeoprojconicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojconicVector::scale(self : GeoprojconicVector, s : Double) -> GeoprojconicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojconicVector::dot(self : GeoprojconicVector, other : GeoprojconicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojconicVector::norm(self : GeoprojconicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojconicVector::normalize(self : GeoprojconicVector) -> GeoprojconicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojconicVector::dist(self : GeoprojconicVector, other : GeoprojconicVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojconicVector::to_string(self : GeoprojconicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_conic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_conic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_conic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_conic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_conic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_conic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_conic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_conic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_conic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_conic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_conic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_conic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_conic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_conic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_conic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_conic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_conic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_conic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_conic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_conic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_conic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_conic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_conic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_conic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_conic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_conic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_conic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_conic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_conic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojconicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_frame_make(size : Int) -> GeoprojconicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_frame_len(s : GeoprojconicFrame) -> Int { s.size }

pub fn geo_proj_conic_frame_get(s : GeoprojconicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_frame_set(s : GeoprojconicFrame, i : Int, v : Double) -> GeoprojconicFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_frame_sum(s : GeoprojconicFrame) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_frame_mean(s : GeoprojconicFrame) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_frame_scale(s : GeoprojconicFrame, f : Double) -> GeoprojconicFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_frame_add(a : GeoprojconicFrame, b : GeoprojconicFrame) -> GeoprojconicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_conic_frame_copy(s : GeoprojconicFrame) -> GeoprojconicFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_frame_fill(s : GeoprojconicFrame, v : Double) -> GeoprojconicFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_frame_min(s : GeoprojconicFrame) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_frame_max(s : GeoprojconicFrame) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_frame_to_string(s : GeoprojconicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_table_make(size : Int) -> GeoprojconicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_table_len(s : GeoprojconicTable) -> Int { s.size }

pub fn geo_proj_conic_table_get(s : GeoprojconicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_table_set(s : GeoprojconicTable, i : Int, v : Double) -> GeoprojconicTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_table_sum(s : GeoprojconicTable) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_table_mean(s : GeoprojconicTable) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_table_scale(s : GeoprojconicTable, f : Double) -> GeoprojconicTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_table_add(a : GeoprojconicTable, b : GeoprojconicTable) -> GeoprojconicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_conic_table_copy(s : GeoprojconicTable) -> GeoprojconicTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_table_fill(s : GeoprojconicTable, v : Double) -> GeoprojconicTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_table_min(s : GeoprojconicTable) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_table_max(s : GeoprojconicTable) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_table_to_string(s : GeoprojconicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_graphn_make(size : Int) -> GeoprojconicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_graphn_len(s : GeoprojconicGraphN) -> Int { s.size }

pub fn geo_proj_conic_graphn_get(s : GeoprojconicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_graphn_set(s : GeoprojconicGraphN, i : Int, v : Double) -> GeoprojconicGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_graphn_sum(s : GeoprojconicGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_graphn_mean(s : GeoprojconicGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_graphn_scale(s : GeoprojconicGraphN, f : Double) -> GeoprojconicGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_graphn_add(a : GeoprojconicGraphN, b : GeoprojconicGraphN) -> GeoprojconicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_conic_graphn_copy(s : GeoprojconicGraphN) -> GeoprojconicGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_graphn_fill(s : GeoprojconicGraphN, v : Double) -> GeoprojconicGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_graphn_min(s : GeoprojconicGraphN) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_graphn_max(s : GeoprojconicGraphN) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_graphn_to_string(s : GeoprojconicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_node_make(size : Int) -> GeoprojconicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_node_len(s : GeoprojconicNode) -> Int { s.size }

pub fn geo_proj_conic_node_get(s : GeoprojconicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_node_set(s : GeoprojconicNode, i : Int, v : Double) -> GeoprojconicNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_node_sum(s : GeoprojconicNode) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_node_mean(s : GeoprojconicNode) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_node_scale(s : GeoprojconicNode, f : Double) -> GeoprojconicNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_node_add(a : GeoprojconicNode, b : GeoprojconicNode) -> GeoprojconicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_conic_node_copy(s : GeoprojconicNode) -> GeoprojconicNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_node_fill(s : GeoprojconicNode, v : Double) -> GeoprojconicNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_node_min(s : GeoprojconicNode) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_node_max(s : GeoprojconicNode) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_node_to_string(s : GeoprojconicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_edge_make(size : Int) -> GeoprojconicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_edge_len(s : GeoprojconicEdge) -> Int { s.size }

pub fn geo_proj_conic_edge_get(s : GeoprojconicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_edge_set(s : GeoprojconicEdge, i : Int, v : Double) -> GeoprojconicEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_edge_sum(s : GeoprojconicEdge) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_edge_mean(s : GeoprojconicEdge) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_edge_scale(s : GeoprojconicEdge, f : Double) -> GeoprojconicEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_edge_add(a : GeoprojconicEdge, b : GeoprojconicEdge) -> GeoprojconicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_conic_edge_copy(s : GeoprojconicEdge) -> GeoprojconicEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_edge_fill(s : GeoprojconicEdge, v : Double) -> GeoprojconicEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_edge_min(s : GeoprojconicEdge) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_edge_max(s : GeoprojconicEdge) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_edge_to_string(s : GeoprojconicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_path_make(size : Int) -> GeoprojconicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_path_len(s : GeoprojconicPath) -> Int { s.size }

pub fn geo_proj_conic_path_get(s : GeoprojconicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_path_set(s : GeoprojconicPath, i : Int, v : Double) -> GeoprojconicPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_path_sum(s : GeoprojconicPath) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_path_mean(s : GeoprojconicPath) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_path_scale(s : GeoprojconicPath, f : Double) -> GeoprojconicPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_path_add(a : GeoprojconicPath, b : GeoprojconicPath) -> GeoprojconicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_conic_path_copy(s : GeoprojconicPath) -> GeoprojconicPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_path_fill(s : GeoprojconicPath, v : Double) -> GeoprojconicPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_path_min(s : GeoprojconicPath) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_path_max(s : GeoprojconicPath) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_path_to_string(s : GeoprojconicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_cluster_make(size : Int) -> GeoprojconicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_cluster_len(s : GeoprojconicCluster) -> Int { s.size }

pub fn geo_proj_conic_cluster_get(s : GeoprojconicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_cluster_set(s : GeoprojconicCluster, i : Int, v : Double) -> GeoprojconicCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_cluster_sum(s : GeoprojconicCluster) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_cluster_mean(s : GeoprojconicCluster) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_cluster_scale(s : GeoprojconicCluster, f : Double) -> GeoprojconicCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_cluster_add(a : GeoprojconicCluster, b : GeoprojconicCluster) -> GeoprojconicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_conic_cluster_copy(s : GeoprojconicCluster) -> GeoprojconicCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_cluster_fill(s : GeoprojconicCluster, v : Double) -> GeoprojconicCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_cluster_min(s : GeoprojconicCluster) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_cluster_max(s : GeoprojconicCluster) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_cluster_to_string(s : GeoprojconicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_model_make(size : Int) -> GeoprojconicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_model_len(s : GeoprojconicModel) -> Int { s.size }

pub fn geo_proj_conic_model_get(s : GeoprojconicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_model_set(s : GeoprojconicModel, i : Int, v : Double) -> GeoprojconicModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_model_sum(s : GeoprojconicModel) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_model_mean(s : GeoprojconicModel) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_model_scale(s : GeoprojconicModel, f : Double) -> GeoprojconicModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_model_add(a : GeoprojconicModel, b : GeoprojconicModel) -> GeoprojconicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_conic_model_copy(s : GeoprojconicModel) -> GeoprojconicModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_model_fill(s : GeoprojconicModel, v : Double) -> GeoprojconicModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_model_min(s : GeoprojconicModel) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_model_max(s : GeoprojconicModel) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_model_to_string(s : GeoprojconicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_layer_make(size : Int) -> GeoprojconicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_layer_len(s : GeoprojconicLayer) -> Int { s.size }

pub fn geo_proj_conic_layer_get(s : GeoprojconicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_layer_set(s : GeoprojconicLayer, i : Int, v : Double) -> GeoprojconicLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_layer_sum(s : GeoprojconicLayer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_layer_mean(s : GeoprojconicLayer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_layer_scale(s : GeoprojconicLayer, f : Double) -> GeoprojconicLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_layer_add(a : GeoprojconicLayer, b : GeoprojconicLayer) -> GeoprojconicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_conic_layer_copy(s : GeoprojconicLayer) -> GeoprojconicLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_layer_fill(s : GeoprojconicLayer, v : Double) -> GeoprojconicLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_layer_min(s : GeoprojconicLayer) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_layer_max(s : GeoprojconicLayer) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_layer_to_string(s : GeoprojconicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_buffer_make(size : Int) -> GeoprojconicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_buffer_len(s : GeoprojconicBuffer) -> Int { s.size }

pub fn geo_proj_conic_buffer_get(s : GeoprojconicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_buffer_set(s : GeoprojconicBuffer, i : Int, v : Double) -> GeoprojconicBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_buffer_sum(s : GeoprojconicBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_buffer_mean(s : GeoprojconicBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_buffer_scale(s : GeoprojconicBuffer, f : Double) -> GeoprojconicBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_buffer_add(a : GeoprojconicBuffer, b : GeoprojconicBuffer) -> GeoprojconicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_conic_buffer_copy(s : GeoprojconicBuffer) -> GeoprojconicBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_buffer_fill(s : GeoprojconicBuffer, v : Double) -> GeoprojconicBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_buffer_min(s : GeoprojconicBuffer) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_buffer_max(s : GeoprojconicBuffer) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_buffer_to_string(s : GeoprojconicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_cursor_make(size : Int) -> GeoprojconicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_cursor_len(s : GeoprojconicCursor) -> Int { s.size }

pub fn geo_proj_conic_cursor_get(s : GeoprojconicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_cursor_set(s : GeoprojconicCursor, i : Int, v : Double) -> GeoprojconicCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_cursor_sum(s : GeoprojconicCursor) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_cursor_mean(s : GeoprojconicCursor) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_cursor_scale(s : GeoprojconicCursor, f : Double) -> GeoprojconicCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_cursor_add(a : GeoprojconicCursor, b : GeoprojconicCursor) -> GeoprojconicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_conic_cursor_copy(s : GeoprojconicCursor) -> GeoprojconicCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_cursor_fill(s : GeoprojconicCursor, v : Double) -> GeoprojconicCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_cursor_min(s : GeoprojconicCursor) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_cursor_max(s : GeoprojconicCursor) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_cursor_to_string(s : GeoprojconicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_view_make(size : Int) -> GeoprojconicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_view_len(s : GeoprojconicView) -> Int { s.size }

pub fn geo_proj_conic_view_get(s : GeoprojconicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_view_set(s : GeoprojconicView, i : Int, v : Double) -> GeoprojconicView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_view_sum(s : GeoprojconicView) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_view_mean(s : GeoprojconicView) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_view_scale(s : GeoprojconicView, f : Double) -> GeoprojconicView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_view_add(a : GeoprojconicView, b : GeoprojconicView) -> GeoprojconicView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_conic_view_copy(s : GeoprojconicView) -> GeoprojconicView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_view_fill(s : GeoprojconicView, v : Double) -> GeoprojconicView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_view_min(s : GeoprojconicView) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_view_max(s : GeoprojconicView) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_view_to_string(s : GeoprojconicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_range_make(size : Int) -> GeoprojconicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_range_len(s : GeoprojconicRange) -> Int { s.size }

pub fn geo_proj_conic_range_get(s : GeoprojconicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_range_set(s : GeoprojconicRange, i : Int, v : Double) -> GeoprojconicRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_range_sum(s : GeoprojconicRange) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_range_mean(s : GeoprojconicRange) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_range_scale(s : GeoprojconicRange, f : Double) -> GeoprojconicRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_range_add(a : GeoprojconicRange, b : GeoprojconicRange) -> GeoprojconicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_conic_range_copy(s : GeoprojconicRange) -> GeoprojconicRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_range_fill(s : GeoprojconicRange, v : Double) -> GeoprojconicRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_range_min(s : GeoprojconicRange) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_range_max(s : GeoprojconicRange) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_range_to_string(s : GeoprojconicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojconicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_conic_slice_make(size : Int) -> GeoprojconicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_conic_slice_len(s : GeoprojconicSlice) -> Int { s.size }

pub fn geo_proj_conic_slice_get(s : GeoprojconicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_conic_slice_set(s : GeoprojconicSlice, i : Int, v : Double) -> GeoprojconicSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_slice_sum(s : GeoprojconicSlice) -> Double { @_common.sum(s.data) }

pub fn geo_proj_conic_slice_mean(s : GeoprojconicSlice) -> Double { @_common.mean(s.data) }

pub fn geo_proj_conic_slice_scale(s : GeoprojconicSlice, f : Double) -> GeoprojconicSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_slice_add(a : GeoprojconicSlice, b : GeoprojconicSlice) -> GeoprojconicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_conic_slice_copy(s : GeoprojconicSlice) -> GeoprojconicSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_slice_fill(s : GeoprojconicSlice, v : Double) -> GeoprojconicSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_conic_slice_min(s : GeoprojconicSlice) -> Double { @_common.min(s.data) }

pub fn geo_proj_conic_slice_max(s : GeoprojconicSlice) -> Double { @_common.max(s.data) }

pub fn geo_proj_conic_slice_to_string(s : GeoprojconicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

