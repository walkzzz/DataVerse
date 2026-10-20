///===
/// extcore/geo_intersect_bbox

pub(all) struct GeointersectbboxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_bbox_make_point(x : Double, y : Double) -> GeointersectbboxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_bbox_make_point3(x : Double, y : Double, z : Double) -> GeointersectbboxPoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectbboxPoint::x(self : GeointersectbboxPoint) -> Double { self.x }

pub fn GeointersectbboxPoint::y(self : GeointersectbboxPoint) -> Double { self.y }

pub fn GeointersectbboxPoint::z(self : GeointersectbboxPoint) -> Double { self.z }

pub fn GeointersectbboxPoint::label(self : GeointersectbboxPoint) -> Int { self.label }

pub fn GeointersectbboxPoint::dist(self : GeointersectbboxPoint, other : GeointersectbboxPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectbboxPoint::add(self : GeointersectbboxPoint, other : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectbboxPoint::sub(self : GeointersectbboxPoint, other : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectbboxPoint::scale(self : GeointersectbboxPoint, s : Double) -> GeointersectbboxPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectbboxPoint::dot(self : GeointersectbboxPoint, other : GeointersectbboxPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectbboxPoint::cross(self : GeointersectbboxPoint, other : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectbboxPoint::norm(self : GeointersectbboxPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectbboxPoint::normalize(self : GeointersectbboxPoint) -> GeointersectbboxPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectbboxPoint::negate(self : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectbboxPoint::mid(self : GeointersectbboxPoint, other : GeointersectbboxPoint) -> GeointersectbboxPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectbboxPoint::lerp(self : GeointersectbboxPoint, other : GeointersectbboxPoint, t : Double) -> GeointersectbboxPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectbboxPoint::to_string(self : GeointersectbboxPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectbboxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_bbox_make_series(vals : Array[Double], name : String) -> GeointersectbboxSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectbboxSeries::len(self : GeointersectbboxSeries) -> Int { self.vals.length() }

pub fn GeointersectbboxSeries::sum(self : GeointersectbboxSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectbboxSeries::mean(self : GeointersectbboxSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectbboxSeries::min(self : GeointersectbboxSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectbboxSeries::max(self : GeointersectbboxSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectbboxSeries::range(self : GeointersectbboxSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectbboxSeries::variance(self : GeointersectbboxSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectbboxSeries::std(self : GeointersectbboxSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectbboxSeries::median(self : GeointersectbboxSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectbboxSeries::scale(self : GeointersectbboxSeries, f : Double) -> GeointersectbboxSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectbboxSeries::add(self : GeointersectbboxSeries, other : GeointersectbboxSeries) -> GeointersectbboxSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectbboxSeries::sub(self : GeointersectbboxSeries, other : GeointersectbboxSeries) -> GeointersectbboxSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectbboxSeries::normalize(self : GeointersectbboxSeries) -> GeointersectbboxSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectbboxSeries::cumsum(self : GeointersectbboxSeries) -> GeointersectbboxSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectbboxSeries::to_string(self : GeointersectbboxSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectbboxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_bbox_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectbboxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_bbox_matrix_identity(n : Int) -> GeointersectbboxMatrix {
  let m = geo_intersect_bbox_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectbboxMatrix::get(self : GeointersectbboxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectbboxMatrix::transpose(self : GeointersectbboxMatrix) -> GeointersectbboxMatrix {
  let result = geo_intersect_bbox_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectbboxMatrix::add(self : GeointersectbboxMatrix, other : GeointersectbboxMatrix) -> GeointersectbboxMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_bbox_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectbboxMatrix::scale(self : GeointersectbboxMatrix, s : Double) -> GeointersectbboxMatrix {
  let result = geo_intersect_bbox_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectbboxMatrix::multiply(self : GeointersectbboxMatrix, other : GeointersectbboxMatrix) -> GeointersectbboxMatrix {
  if self.cols != other.rows { return geo_intersect_bbox_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_bbox_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeointersectbboxMatrix::trace(self : GeointersectbboxMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectbboxMatrix::det(self : GeointersectbboxMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectbboxMatrix::norm(self : GeointersectbboxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectbboxMatrix::to_string(self : GeointersectbboxMatrix) -> String {
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

pub(all) struct GeointersectbboxVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_bbox_make_vector(comps : Array[Double]) -> GeointersectbboxVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_bbox_vector_zero(dim : Int) -> GeointersectbboxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectbboxVector::add(self : GeointersectbboxVector, other : GeointersectbboxVector) -> GeointersectbboxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectbboxVector::sub(self : GeointersectbboxVector, other : GeointersectbboxVector) -> GeointersectbboxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectbboxVector::scale(self : GeointersectbboxVector, s : Double) -> GeointersectbboxVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectbboxVector::dot(self : GeointersectbboxVector, other : GeointersectbboxVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectbboxVector::norm(self : GeointersectbboxVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectbboxVector::normalize(self : GeointersectbboxVector) -> GeointersectbboxVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectbboxVector::dist(self : GeointersectbboxVector, other : GeointersectbboxVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectbboxVector::to_string(self : GeointersectbboxVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_bbox_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_intersect_bbox_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_intersect_bbox_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_intersect_bbox_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_intersect_bbox_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_intersect_bbox_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_intersect_bbox_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_intersect_bbox_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_intersect_bbox_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_intersect_bbox_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_intersect_bbox_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_intersect_bbox_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_intersect_bbox_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_intersect_bbox_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_intersect_bbox_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_intersect_bbox_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_intersect_bbox_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_intersect_bbox_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_intersect_bbox_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_intersect_bbox_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_intersect_bbox_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_intersect_bbox_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_intersect_bbox_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_intersect_bbox_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_intersect_bbox_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_intersect_bbox_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_intersect_bbox_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_intersect_bbox_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_intersect_bbox_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeointersectbboxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_frame_make(size : Int) -> GeointersectbboxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_frame_len(s : GeointersectbboxFrame) -> Int { s.size }

pub fn geo_intersect_bbox_frame_get(s : GeointersectbboxFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_frame_set(s : GeointersectbboxFrame, i : Int, v : Double) -> GeointersectbboxFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_frame_sum(s : GeointersectbboxFrame) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_bbox_frame_mean(s : GeointersectbboxFrame) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_bbox_frame_scale(s : GeointersectbboxFrame, f : Double) -> GeointersectbboxFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_frame_add(a : GeointersectbboxFrame, b : GeointersectbboxFrame) -> GeointersectbboxFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_bbox_frame_copy(s : GeointersectbboxFrame) -> GeointersectbboxFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_frame_fill(s : GeointersectbboxFrame, v : Double) -> GeointersectbboxFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_frame_min(s : GeointersectbboxFrame) -> Double { @_common.min(s.data) }

pub fn geo_intersect_bbox_frame_max(s : GeointersectbboxFrame) -> Double { @_common.max(s.data) }

pub fn geo_intersect_bbox_frame_to_string(s : GeointersectbboxFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_table_make(size : Int) -> GeointersectbboxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_table_len(s : GeointersectbboxTable) -> Int { s.size }

pub fn geo_intersect_bbox_table_get(s : GeointersectbboxTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_table_set(s : GeointersectbboxTable, i : Int, v : Double) -> GeointersectbboxTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_table_sum(s : GeointersectbboxTable) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_bbox_table_mean(s : GeointersectbboxTable) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_bbox_table_scale(s : GeointersectbboxTable, f : Double) -> GeointersectbboxTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_table_add(a : GeointersectbboxTable, b : GeointersectbboxTable) -> GeointersectbboxTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_bbox_table_copy(s : GeointersectbboxTable) -> GeointersectbboxTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_table_fill(s : GeointersectbboxTable, v : Double) -> GeointersectbboxTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_table_min(s : GeointersectbboxTable) -> Double { @_common.min(s.data) }

pub fn geo_intersect_bbox_table_max(s : GeointersectbboxTable) -> Double { @_common.max(s.data) }

pub fn geo_intersect_bbox_table_to_string(s : GeointersectbboxTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_graphn_make(size : Int) -> GeointersectbboxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_graphn_len(s : GeointersectbboxGraphN) -> Int { s.size }

pub fn geo_intersect_bbox_graphn_get(s : GeointersectbboxGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_graphn_set(s : GeointersectbboxGraphN, i : Int, v : Double) -> GeointersectbboxGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_graphn_sum(s : GeointersectbboxGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_bbox_graphn_mean(s : GeointersectbboxGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_bbox_graphn_scale(s : GeointersectbboxGraphN, f : Double) -> GeointersectbboxGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_graphn_add(a : GeointersectbboxGraphN, b : GeointersectbboxGraphN) -> GeointersectbboxGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_bbox_graphn_copy(s : GeointersectbboxGraphN) -> GeointersectbboxGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_graphn_fill(s : GeointersectbboxGraphN, v : Double) -> GeointersectbboxGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_graphn_min(s : GeointersectbboxGraphN) -> Double { @_common.min(s.data) }

pub fn geo_intersect_bbox_graphn_max(s : GeointersectbboxGraphN) -> Double { @_common.max(s.data) }

pub fn geo_intersect_bbox_graphn_to_string(s : GeointersectbboxGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_node_make(size : Int) -> GeointersectbboxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_node_len(s : GeointersectbboxNode) -> Int { s.size }

pub fn geo_intersect_bbox_node_get(s : GeointersectbboxNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_node_set(s : GeointersectbboxNode, i : Int, v : Double) -> GeointersectbboxNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_node_sum(s : GeointersectbboxNode) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_bbox_node_mean(s : GeointersectbboxNode) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_bbox_node_scale(s : GeointersectbboxNode, f : Double) -> GeointersectbboxNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_node_add(a : GeointersectbboxNode, b : GeointersectbboxNode) -> GeointersectbboxNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_bbox_node_copy(s : GeointersectbboxNode) -> GeointersectbboxNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_node_fill(s : GeointersectbboxNode, v : Double) -> GeointersectbboxNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_node_min(s : GeointersectbboxNode) -> Double { @_common.min(s.data) }

pub fn geo_intersect_bbox_node_max(s : GeointersectbboxNode) -> Double { @_common.max(s.data) }

pub fn geo_intersect_bbox_node_to_string(s : GeointersectbboxNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_edge_make(size : Int) -> GeointersectbboxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_edge_len(s : GeointersectbboxEdge) -> Int { s.size }

pub fn geo_intersect_bbox_edge_get(s : GeointersectbboxEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_edge_set(s : GeointersectbboxEdge, i : Int, v : Double) -> GeointersectbboxEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_edge_sum(s : GeointersectbboxEdge) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_bbox_edge_mean(s : GeointersectbboxEdge) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_bbox_edge_scale(s : GeointersectbboxEdge, f : Double) -> GeointersectbboxEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_edge_add(a : GeointersectbboxEdge, b : GeointersectbboxEdge) -> GeointersectbboxEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_bbox_edge_copy(s : GeointersectbboxEdge) -> GeointersectbboxEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_edge_fill(s : GeointersectbboxEdge, v : Double) -> GeointersectbboxEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_edge_min(s : GeointersectbboxEdge) -> Double { @_common.min(s.data) }

pub fn geo_intersect_bbox_edge_max(s : GeointersectbboxEdge) -> Double { @_common.max(s.data) }

pub fn geo_intersect_bbox_edge_to_string(s : GeointersectbboxEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_path_make(size : Int) -> GeointersectbboxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_path_len(s : GeointersectbboxPath) -> Int { s.size }

pub fn geo_intersect_bbox_path_get(s : GeointersectbboxPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_path_set(s : GeointersectbboxPath, i : Int, v : Double) -> GeointersectbboxPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_path_sum(s : GeointersectbboxPath) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_bbox_path_mean(s : GeointersectbboxPath) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_bbox_path_scale(s : GeointersectbboxPath, f : Double) -> GeointersectbboxPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_path_add(a : GeointersectbboxPath, b : GeointersectbboxPath) -> GeointersectbboxPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_bbox_path_copy(s : GeointersectbboxPath) -> GeointersectbboxPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_path_fill(s : GeointersectbboxPath, v : Double) -> GeointersectbboxPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_path_min(s : GeointersectbboxPath) -> Double { @_common.min(s.data) }

pub fn geo_intersect_bbox_path_max(s : GeointersectbboxPath) -> Double { @_common.max(s.data) }

pub fn geo_intersect_bbox_path_to_string(s : GeointersectbboxPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_cluster_make(size : Int) -> GeointersectbboxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_cluster_len(s : GeointersectbboxCluster) -> Int { s.size }

pub fn geo_intersect_bbox_cluster_get(s : GeointersectbboxCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_cluster_set(s : GeointersectbboxCluster, i : Int, v : Double) -> GeointersectbboxCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_cluster_sum(s : GeointersectbboxCluster) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_bbox_cluster_mean(s : GeointersectbboxCluster) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_bbox_cluster_scale(s : GeointersectbboxCluster, f : Double) -> GeointersectbboxCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_cluster_add(a : GeointersectbboxCluster, b : GeointersectbboxCluster) -> GeointersectbboxCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_bbox_cluster_copy(s : GeointersectbboxCluster) -> GeointersectbboxCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_cluster_fill(s : GeointersectbboxCluster, v : Double) -> GeointersectbboxCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_cluster_min(s : GeointersectbboxCluster) -> Double { @_common.min(s.data) }

pub fn geo_intersect_bbox_cluster_max(s : GeointersectbboxCluster) -> Double { @_common.max(s.data) }

pub fn geo_intersect_bbox_cluster_to_string(s : GeointersectbboxCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_model_make(size : Int) -> GeointersectbboxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_model_len(s : GeointersectbboxModel) -> Int { s.size }

pub fn geo_intersect_bbox_model_get(s : GeointersectbboxModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_model_set(s : GeointersectbboxModel, i : Int, v : Double) -> GeointersectbboxModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_model_sum(s : GeointersectbboxModel) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_bbox_model_mean(s : GeointersectbboxModel) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_bbox_model_scale(s : GeointersectbboxModel, f : Double) -> GeointersectbboxModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_model_add(a : GeointersectbboxModel, b : GeointersectbboxModel) -> GeointersectbboxModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_bbox_model_copy(s : GeointersectbboxModel) -> GeointersectbboxModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_model_fill(s : GeointersectbboxModel, v : Double) -> GeointersectbboxModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_model_min(s : GeointersectbboxModel) -> Double { @_common.min(s.data) }

pub fn geo_intersect_bbox_model_max(s : GeointersectbboxModel) -> Double { @_common.max(s.data) }

pub fn geo_intersect_bbox_model_to_string(s : GeointersectbboxModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_layer_make(size : Int) -> GeointersectbboxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_layer_len(s : GeointersectbboxLayer) -> Int { s.size }

pub fn geo_intersect_bbox_layer_get(s : GeointersectbboxLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_layer_set(s : GeointersectbboxLayer, i : Int, v : Double) -> GeointersectbboxLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_layer_sum(s : GeointersectbboxLayer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_bbox_layer_mean(s : GeointersectbboxLayer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_bbox_layer_scale(s : GeointersectbboxLayer, f : Double) -> GeointersectbboxLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_layer_add(a : GeointersectbboxLayer, b : GeointersectbboxLayer) -> GeointersectbboxLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_bbox_layer_copy(s : GeointersectbboxLayer) -> GeointersectbboxLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_layer_fill(s : GeointersectbboxLayer, v : Double) -> GeointersectbboxLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_layer_min(s : GeointersectbboxLayer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_bbox_layer_max(s : GeointersectbboxLayer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_bbox_layer_to_string(s : GeointersectbboxLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_buffer_make(size : Int) -> GeointersectbboxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_buffer_len(s : GeointersectbboxBuffer) -> Int { s.size }

pub fn geo_intersect_bbox_buffer_get(s : GeointersectbboxBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_buffer_set(s : GeointersectbboxBuffer, i : Int, v : Double) -> GeointersectbboxBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_buffer_sum(s : GeointersectbboxBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_bbox_buffer_mean(s : GeointersectbboxBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_bbox_buffer_scale(s : GeointersectbboxBuffer, f : Double) -> GeointersectbboxBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_buffer_add(a : GeointersectbboxBuffer, b : GeointersectbboxBuffer) -> GeointersectbboxBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_bbox_buffer_copy(s : GeointersectbboxBuffer) -> GeointersectbboxBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_buffer_fill(s : GeointersectbboxBuffer, v : Double) -> GeointersectbboxBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_buffer_min(s : GeointersectbboxBuffer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_bbox_buffer_max(s : GeointersectbboxBuffer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_bbox_buffer_to_string(s : GeointersectbboxBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_cursor_make(size : Int) -> GeointersectbboxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_cursor_len(s : GeointersectbboxCursor) -> Int { s.size }

pub fn geo_intersect_bbox_cursor_get(s : GeointersectbboxCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_cursor_set(s : GeointersectbboxCursor, i : Int, v : Double) -> GeointersectbboxCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_cursor_sum(s : GeointersectbboxCursor) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_bbox_cursor_mean(s : GeointersectbboxCursor) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_bbox_cursor_scale(s : GeointersectbboxCursor, f : Double) -> GeointersectbboxCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_cursor_add(a : GeointersectbboxCursor, b : GeointersectbboxCursor) -> GeointersectbboxCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_bbox_cursor_copy(s : GeointersectbboxCursor) -> GeointersectbboxCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_cursor_fill(s : GeointersectbboxCursor, v : Double) -> GeointersectbboxCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_cursor_min(s : GeointersectbboxCursor) -> Double { @_common.min(s.data) }

pub fn geo_intersect_bbox_cursor_max(s : GeointersectbboxCursor) -> Double { @_common.max(s.data) }

pub fn geo_intersect_bbox_cursor_to_string(s : GeointersectbboxCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_view_make(size : Int) -> GeointersectbboxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_view_len(s : GeointersectbboxView) -> Int { s.size }

pub fn geo_intersect_bbox_view_get(s : GeointersectbboxView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_view_set(s : GeointersectbboxView, i : Int, v : Double) -> GeointersectbboxView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_view_sum(s : GeointersectbboxView) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_bbox_view_mean(s : GeointersectbboxView) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_bbox_view_scale(s : GeointersectbboxView, f : Double) -> GeointersectbboxView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_view_add(a : GeointersectbboxView, b : GeointersectbboxView) -> GeointersectbboxView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_bbox_view_copy(s : GeointersectbboxView) -> GeointersectbboxView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_view_fill(s : GeointersectbboxView, v : Double) -> GeointersectbboxView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_view_min(s : GeointersectbboxView) -> Double { @_common.min(s.data) }

pub fn geo_intersect_bbox_view_max(s : GeointersectbboxView) -> Double { @_common.max(s.data) }

pub fn geo_intersect_bbox_view_to_string(s : GeointersectbboxView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_range_make(size : Int) -> GeointersectbboxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_range_len(s : GeointersectbboxRange) -> Int { s.size }

pub fn geo_intersect_bbox_range_get(s : GeointersectbboxRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_range_set(s : GeointersectbboxRange, i : Int, v : Double) -> GeointersectbboxRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_range_sum(s : GeointersectbboxRange) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_bbox_range_mean(s : GeointersectbboxRange) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_bbox_range_scale(s : GeointersectbboxRange, f : Double) -> GeointersectbboxRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_range_add(a : GeointersectbboxRange, b : GeointersectbboxRange) -> GeointersectbboxRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_bbox_range_copy(s : GeointersectbboxRange) -> GeointersectbboxRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_range_fill(s : GeointersectbboxRange, v : Double) -> GeointersectbboxRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_range_min(s : GeointersectbboxRange) -> Double { @_common.min(s.data) }

pub fn geo_intersect_bbox_range_max(s : GeointersectbboxRange) -> Double { @_common.max(s.data) }

pub fn geo_intersect_bbox_range_to_string(s : GeointersectbboxRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectbboxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_bbox_slice_make(size : Int) -> GeointersectbboxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_bbox_slice_len(s : GeointersectbboxSlice) -> Int { s.size }

pub fn geo_intersect_bbox_slice_get(s : GeointersectbboxSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_bbox_slice_set(s : GeointersectbboxSlice, i : Int, v : Double) -> GeointersectbboxSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_slice_sum(s : GeointersectbboxSlice) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_bbox_slice_mean(s : GeointersectbboxSlice) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_bbox_slice_scale(s : GeointersectbboxSlice, f : Double) -> GeointersectbboxSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_slice_add(a : GeointersectbboxSlice, b : GeointersectbboxSlice) -> GeointersectbboxSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_bbox_slice_copy(s : GeointersectbboxSlice) -> GeointersectbboxSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_slice_fill(s : GeointersectbboxSlice, v : Double) -> GeointersectbboxSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_bbox_slice_min(s : GeointersectbboxSlice) -> Double { @_common.min(s.data) }

pub fn geo_intersect_bbox_slice_max(s : GeointersectbboxSlice) -> Double { @_common.max(s.data) }

pub fn geo_intersect_bbox_slice_to_string(s : GeointersectbboxSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

