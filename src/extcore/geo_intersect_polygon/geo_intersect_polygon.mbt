///===
/// extcore/geo_intersect_polygon

pub(all) struct GeointersectpolygonPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_polygon_make_point(x : Double, y : Double) -> GeointersectpolygonPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_polygon_make_point3(x : Double, y : Double, z : Double) -> GeointersectpolygonPoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectpolygonPoint::x(self : GeointersectpolygonPoint) -> Double { self.x }

pub fn GeointersectpolygonPoint::y(self : GeointersectpolygonPoint) -> Double { self.y }

pub fn GeointersectpolygonPoint::z(self : GeointersectpolygonPoint) -> Double { self.z }

pub fn GeointersectpolygonPoint::label(self : GeointersectpolygonPoint) -> Int { self.label }

pub fn GeointersectpolygonPoint::dist(self : GeointersectpolygonPoint, other : GeointersectpolygonPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectpolygonPoint::add(self : GeointersectpolygonPoint, other : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectpolygonPoint::sub(self : GeointersectpolygonPoint, other : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectpolygonPoint::scale(self : GeointersectpolygonPoint, s : Double) -> GeointersectpolygonPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectpolygonPoint::dot(self : GeointersectpolygonPoint, other : GeointersectpolygonPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectpolygonPoint::cross(self : GeointersectpolygonPoint, other : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectpolygonPoint::norm(self : GeointersectpolygonPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectpolygonPoint::normalize(self : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectpolygonPoint::negate(self : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectpolygonPoint::mid(self : GeointersectpolygonPoint, other : GeointersectpolygonPoint) -> GeointersectpolygonPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectpolygonPoint::lerp(self : GeointersectpolygonPoint, other : GeointersectpolygonPoint, t : Double) -> GeointersectpolygonPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectpolygonPoint::to_string(self : GeointersectpolygonPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectpolygonSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_polygon_make_series(vals : Array[Double], name : String) -> GeointersectpolygonSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectpolygonSeries::len(self : GeointersectpolygonSeries) -> Int { self.vals.length() }

pub fn GeointersectpolygonSeries::sum(self : GeointersectpolygonSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectpolygonSeries::mean(self : GeointersectpolygonSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectpolygonSeries::min(self : GeointersectpolygonSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectpolygonSeries::max(self : GeointersectpolygonSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectpolygonSeries::range(self : GeointersectpolygonSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectpolygonSeries::variance(self : GeointersectpolygonSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectpolygonSeries::std(self : GeointersectpolygonSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectpolygonSeries::median(self : GeointersectpolygonSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectpolygonSeries::scale(self : GeointersectpolygonSeries, f : Double) -> GeointersectpolygonSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectpolygonSeries::add(self : GeointersectpolygonSeries, other : GeointersectpolygonSeries) -> GeointersectpolygonSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectpolygonSeries::sub(self : GeointersectpolygonSeries, other : GeointersectpolygonSeries) -> GeointersectpolygonSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectpolygonSeries::normalize(self : GeointersectpolygonSeries) -> GeointersectpolygonSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectpolygonSeries::cumsum(self : GeointersectpolygonSeries) -> GeointersectpolygonSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectpolygonSeries::to_string(self : GeointersectpolygonSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectpolygonMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_polygon_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectpolygonMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_polygon_matrix_identity(n : Int) -> GeointersectpolygonMatrix {
  let m = geo_intersect_polygon_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectpolygonMatrix::get(self : GeointersectpolygonMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectpolygonMatrix::transpose(self : GeointersectpolygonMatrix) -> GeointersectpolygonMatrix {
  let result = geo_intersect_polygon_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectpolygonMatrix::add(self : GeointersectpolygonMatrix, other : GeointersectpolygonMatrix) -> GeointersectpolygonMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_polygon_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectpolygonMatrix::scale(self : GeointersectpolygonMatrix, s : Double) -> GeointersectpolygonMatrix {
  let result = geo_intersect_polygon_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectpolygonMatrix::multiply(self : GeointersectpolygonMatrix, other : GeointersectpolygonMatrix) -> GeointersectpolygonMatrix {
  if self.cols != other.rows { return geo_intersect_polygon_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_polygon_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeointersectpolygonMatrix::trace(self : GeointersectpolygonMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectpolygonMatrix::det(self : GeointersectpolygonMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectpolygonMatrix::norm(self : GeointersectpolygonMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectpolygonMatrix::to_string(self : GeointersectpolygonMatrix) -> String {
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

pub(all) struct GeointersectpolygonVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_polygon_make_vector(comps : Array[Double]) -> GeointersectpolygonVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_polygon_vector_zero(dim : Int) -> GeointersectpolygonVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectpolygonVector::add(self : GeointersectpolygonVector, other : GeointersectpolygonVector) -> GeointersectpolygonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectpolygonVector::sub(self : GeointersectpolygonVector, other : GeointersectpolygonVector) -> GeointersectpolygonVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectpolygonVector::scale(self : GeointersectpolygonVector, s : Double) -> GeointersectpolygonVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectpolygonVector::dot(self : GeointersectpolygonVector, other : GeointersectpolygonVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectpolygonVector::norm(self : GeointersectpolygonVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectpolygonVector::normalize(self : GeointersectpolygonVector) -> GeointersectpolygonVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectpolygonVector::dist(self : GeointersectpolygonVector, other : GeointersectpolygonVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectpolygonVector::to_string(self : GeointersectpolygonVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_polygon_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_intersect_polygon_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_intersect_polygon_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_intersect_polygon_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_intersect_polygon_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_intersect_polygon_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_intersect_polygon_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_intersect_polygon_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_intersect_polygon_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_intersect_polygon_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_intersect_polygon_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_intersect_polygon_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_intersect_polygon_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_intersect_polygon_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_intersect_polygon_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_intersect_polygon_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_intersect_polygon_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_intersect_polygon_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_intersect_polygon_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_intersect_polygon_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_intersect_polygon_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_intersect_polygon_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_intersect_polygon_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_intersect_polygon_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_intersect_polygon_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_intersect_polygon_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_intersect_polygon_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_intersect_polygon_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_intersect_polygon_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeointersectpolygonFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_frame_make(size : Int) -> GeointersectpolygonFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_frame_len(s : GeointersectpolygonFrame) -> Int { s.size }

pub fn geo_intersect_polygon_frame_get(s : GeointersectpolygonFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_frame_set(s : GeointersectpolygonFrame, i : Int, v : Double) -> GeointersectpolygonFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_frame_sum(s : GeointersectpolygonFrame) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_polygon_frame_mean(s : GeointersectpolygonFrame) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_polygon_frame_scale(s : GeointersectpolygonFrame, f : Double) -> GeointersectpolygonFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_frame_add(a : GeointersectpolygonFrame, b : GeointersectpolygonFrame) -> GeointersectpolygonFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_polygon_frame_copy(s : GeointersectpolygonFrame) -> GeointersectpolygonFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_frame_fill(s : GeointersectpolygonFrame, v : Double) -> GeointersectpolygonFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_frame_min(s : GeointersectpolygonFrame) -> Double { @_common.min(s.data) }

pub fn geo_intersect_polygon_frame_max(s : GeointersectpolygonFrame) -> Double { @_common.max(s.data) }

pub fn geo_intersect_polygon_frame_to_string(s : GeointersectpolygonFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_table_make(size : Int) -> GeointersectpolygonTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_table_len(s : GeointersectpolygonTable) -> Int { s.size }

pub fn geo_intersect_polygon_table_get(s : GeointersectpolygonTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_table_set(s : GeointersectpolygonTable, i : Int, v : Double) -> GeointersectpolygonTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_table_sum(s : GeointersectpolygonTable) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_polygon_table_mean(s : GeointersectpolygonTable) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_polygon_table_scale(s : GeointersectpolygonTable, f : Double) -> GeointersectpolygonTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_table_add(a : GeointersectpolygonTable, b : GeointersectpolygonTable) -> GeointersectpolygonTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_polygon_table_copy(s : GeointersectpolygonTable) -> GeointersectpolygonTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_table_fill(s : GeointersectpolygonTable, v : Double) -> GeointersectpolygonTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_table_min(s : GeointersectpolygonTable) -> Double { @_common.min(s.data) }

pub fn geo_intersect_polygon_table_max(s : GeointersectpolygonTable) -> Double { @_common.max(s.data) }

pub fn geo_intersect_polygon_table_to_string(s : GeointersectpolygonTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_graphn_make(size : Int) -> GeointersectpolygonGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_graphn_len(s : GeointersectpolygonGraphN) -> Int { s.size }

pub fn geo_intersect_polygon_graphn_get(s : GeointersectpolygonGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_graphn_set(s : GeointersectpolygonGraphN, i : Int, v : Double) -> GeointersectpolygonGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_graphn_sum(s : GeointersectpolygonGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_polygon_graphn_mean(s : GeointersectpolygonGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_polygon_graphn_scale(s : GeointersectpolygonGraphN, f : Double) -> GeointersectpolygonGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_graphn_add(a : GeointersectpolygonGraphN, b : GeointersectpolygonGraphN) -> GeointersectpolygonGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_polygon_graphn_copy(s : GeointersectpolygonGraphN) -> GeointersectpolygonGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_graphn_fill(s : GeointersectpolygonGraphN, v : Double) -> GeointersectpolygonGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_graphn_min(s : GeointersectpolygonGraphN) -> Double { @_common.min(s.data) }

pub fn geo_intersect_polygon_graphn_max(s : GeointersectpolygonGraphN) -> Double { @_common.max(s.data) }

pub fn geo_intersect_polygon_graphn_to_string(s : GeointersectpolygonGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_node_make(size : Int) -> GeointersectpolygonNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_node_len(s : GeointersectpolygonNode) -> Int { s.size }

pub fn geo_intersect_polygon_node_get(s : GeointersectpolygonNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_node_set(s : GeointersectpolygonNode, i : Int, v : Double) -> GeointersectpolygonNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_node_sum(s : GeointersectpolygonNode) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_polygon_node_mean(s : GeointersectpolygonNode) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_polygon_node_scale(s : GeointersectpolygonNode, f : Double) -> GeointersectpolygonNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_node_add(a : GeointersectpolygonNode, b : GeointersectpolygonNode) -> GeointersectpolygonNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_polygon_node_copy(s : GeointersectpolygonNode) -> GeointersectpolygonNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_node_fill(s : GeointersectpolygonNode, v : Double) -> GeointersectpolygonNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_node_min(s : GeointersectpolygonNode) -> Double { @_common.min(s.data) }

pub fn geo_intersect_polygon_node_max(s : GeointersectpolygonNode) -> Double { @_common.max(s.data) }

pub fn geo_intersect_polygon_node_to_string(s : GeointersectpolygonNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_edge_make(size : Int) -> GeointersectpolygonEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_edge_len(s : GeointersectpolygonEdge) -> Int { s.size }

pub fn geo_intersect_polygon_edge_get(s : GeointersectpolygonEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_edge_set(s : GeointersectpolygonEdge, i : Int, v : Double) -> GeointersectpolygonEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_edge_sum(s : GeointersectpolygonEdge) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_polygon_edge_mean(s : GeointersectpolygonEdge) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_polygon_edge_scale(s : GeointersectpolygonEdge, f : Double) -> GeointersectpolygonEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_edge_add(a : GeointersectpolygonEdge, b : GeointersectpolygonEdge) -> GeointersectpolygonEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_polygon_edge_copy(s : GeointersectpolygonEdge) -> GeointersectpolygonEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_edge_fill(s : GeointersectpolygonEdge, v : Double) -> GeointersectpolygonEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_edge_min(s : GeointersectpolygonEdge) -> Double { @_common.min(s.data) }

pub fn geo_intersect_polygon_edge_max(s : GeointersectpolygonEdge) -> Double { @_common.max(s.data) }

pub fn geo_intersect_polygon_edge_to_string(s : GeointersectpolygonEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_path_make(size : Int) -> GeointersectpolygonPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_path_len(s : GeointersectpolygonPath) -> Int { s.size }

pub fn geo_intersect_polygon_path_get(s : GeointersectpolygonPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_path_set(s : GeointersectpolygonPath, i : Int, v : Double) -> GeointersectpolygonPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_path_sum(s : GeointersectpolygonPath) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_polygon_path_mean(s : GeointersectpolygonPath) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_polygon_path_scale(s : GeointersectpolygonPath, f : Double) -> GeointersectpolygonPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_path_add(a : GeointersectpolygonPath, b : GeointersectpolygonPath) -> GeointersectpolygonPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_polygon_path_copy(s : GeointersectpolygonPath) -> GeointersectpolygonPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_path_fill(s : GeointersectpolygonPath, v : Double) -> GeointersectpolygonPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_path_min(s : GeointersectpolygonPath) -> Double { @_common.min(s.data) }

pub fn geo_intersect_polygon_path_max(s : GeointersectpolygonPath) -> Double { @_common.max(s.data) }

pub fn geo_intersect_polygon_path_to_string(s : GeointersectpolygonPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_cluster_make(size : Int) -> GeointersectpolygonCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_cluster_len(s : GeointersectpolygonCluster) -> Int { s.size }

pub fn geo_intersect_polygon_cluster_get(s : GeointersectpolygonCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_cluster_set(s : GeointersectpolygonCluster, i : Int, v : Double) -> GeointersectpolygonCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_cluster_sum(s : GeointersectpolygonCluster) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_polygon_cluster_mean(s : GeointersectpolygonCluster) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_polygon_cluster_scale(s : GeointersectpolygonCluster, f : Double) -> GeointersectpolygonCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_cluster_add(a : GeointersectpolygonCluster, b : GeointersectpolygonCluster) -> GeointersectpolygonCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_polygon_cluster_copy(s : GeointersectpolygonCluster) -> GeointersectpolygonCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_cluster_fill(s : GeointersectpolygonCluster, v : Double) -> GeointersectpolygonCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_cluster_min(s : GeointersectpolygonCluster) -> Double { @_common.min(s.data) }

pub fn geo_intersect_polygon_cluster_max(s : GeointersectpolygonCluster) -> Double { @_common.max(s.data) }

pub fn geo_intersect_polygon_cluster_to_string(s : GeointersectpolygonCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_model_make(size : Int) -> GeointersectpolygonModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_model_len(s : GeointersectpolygonModel) -> Int { s.size }

pub fn geo_intersect_polygon_model_get(s : GeointersectpolygonModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_model_set(s : GeointersectpolygonModel, i : Int, v : Double) -> GeointersectpolygonModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_model_sum(s : GeointersectpolygonModel) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_polygon_model_mean(s : GeointersectpolygonModel) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_polygon_model_scale(s : GeointersectpolygonModel, f : Double) -> GeointersectpolygonModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_model_add(a : GeointersectpolygonModel, b : GeointersectpolygonModel) -> GeointersectpolygonModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_polygon_model_copy(s : GeointersectpolygonModel) -> GeointersectpolygonModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_model_fill(s : GeointersectpolygonModel, v : Double) -> GeointersectpolygonModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_model_min(s : GeointersectpolygonModel) -> Double { @_common.min(s.data) }

pub fn geo_intersect_polygon_model_max(s : GeointersectpolygonModel) -> Double { @_common.max(s.data) }

pub fn geo_intersect_polygon_model_to_string(s : GeointersectpolygonModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_layer_make(size : Int) -> GeointersectpolygonLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_layer_len(s : GeointersectpolygonLayer) -> Int { s.size }

pub fn geo_intersect_polygon_layer_get(s : GeointersectpolygonLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_layer_set(s : GeointersectpolygonLayer, i : Int, v : Double) -> GeointersectpolygonLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_layer_sum(s : GeointersectpolygonLayer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_polygon_layer_mean(s : GeointersectpolygonLayer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_polygon_layer_scale(s : GeointersectpolygonLayer, f : Double) -> GeointersectpolygonLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_layer_add(a : GeointersectpolygonLayer, b : GeointersectpolygonLayer) -> GeointersectpolygonLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_polygon_layer_copy(s : GeointersectpolygonLayer) -> GeointersectpolygonLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_layer_fill(s : GeointersectpolygonLayer, v : Double) -> GeointersectpolygonLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_layer_min(s : GeointersectpolygonLayer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_polygon_layer_max(s : GeointersectpolygonLayer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_polygon_layer_to_string(s : GeointersectpolygonLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_buffer_make(size : Int) -> GeointersectpolygonBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_buffer_len(s : GeointersectpolygonBuffer) -> Int { s.size }

pub fn geo_intersect_polygon_buffer_get(s : GeointersectpolygonBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_buffer_set(s : GeointersectpolygonBuffer, i : Int, v : Double) -> GeointersectpolygonBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_buffer_sum(s : GeointersectpolygonBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_polygon_buffer_mean(s : GeointersectpolygonBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_polygon_buffer_scale(s : GeointersectpolygonBuffer, f : Double) -> GeointersectpolygonBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_buffer_add(a : GeointersectpolygonBuffer, b : GeointersectpolygonBuffer) -> GeointersectpolygonBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_polygon_buffer_copy(s : GeointersectpolygonBuffer) -> GeointersectpolygonBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_buffer_fill(s : GeointersectpolygonBuffer, v : Double) -> GeointersectpolygonBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_buffer_min(s : GeointersectpolygonBuffer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_polygon_buffer_max(s : GeointersectpolygonBuffer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_polygon_buffer_to_string(s : GeointersectpolygonBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_cursor_make(size : Int) -> GeointersectpolygonCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_cursor_len(s : GeointersectpolygonCursor) -> Int { s.size }

pub fn geo_intersect_polygon_cursor_get(s : GeointersectpolygonCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_cursor_set(s : GeointersectpolygonCursor, i : Int, v : Double) -> GeointersectpolygonCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_cursor_sum(s : GeointersectpolygonCursor) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_polygon_cursor_mean(s : GeointersectpolygonCursor) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_polygon_cursor_scale(s : GeointersectpolygonCursor, f : Double) -> GeointersectpolygonCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_cursor_add(a : GeointersectpolygonCursor, b : GeointersectpolygonCursor) -> GeointersectpolygonCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_polygon_cursor_copy(s : GeointersectpolygonCursor) -> GeointersectpolygonCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_cursor_fill(s : GeointersectpolygonCursor, v : Double) -> GeointersectpolygonCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_cursor_min(s : GeointersectpolygonCursor) -> Double { @_common.min(s.data) }

pub fn geo_intersect_polygon_cursor_max(s : GeointersectpolygonCursor) -> Double { @_common.max(s.data) }

pub fn geo_intersect_polygon_cursor_to_string(s : GeointersectpolygonCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_view_make(size : Int) -> GeointersectpolygonView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_view_len(s : GeointersectpolygonView) -> Int { s.size }

pub fn geo_intersect_polygon_view_get(s : GeointersectpolygonView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_view_set(s : GeointersectpolygonView, i : Int, v : Double) -> GeointersectpolygonView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_view_sum(s : GeointersectpolygonView) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_polygon_view_mean(s : GeointersectpolygonView) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_polygon_view_scale(s : GeointersectpolygonView, f : Double) -> GeointersectpolygonView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_view_add(a : GeointersectpolygonView, b : GeointersectpolygonView) -> GeointersectpolygonView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_polygon_view_copy(s : GeointersectpolygonView) -> GeointersectpolygonView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_view_fill(s : GeointersectpolygonView, v : Double) -> GeointersectpolygonView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_view_min(s : GeointersectpolygonView) -> Double { @_common.min(s.data) }

pub fn geo_intersect_polygon_view_max(s : GeointersectpolygonView) -> Double { @_common.max(s.data) }

pub fn geo_intersect_polygon_view_to_string(s : GeointersectpolygonView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_range_make(size : Int) -> GeointersectpolygonRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_range_len(s : GeointersectpolygonRange) -> Int { s.size }

pub fn geo_intersect_polygon_range_get(s : GeointersectpolygonRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_range_set(s : GeointersectpolygonRange, i : Int, v : Double) -> GeointersectpolygonRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_range_sum(s : GeointersectpolygonRange) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_polygon_range_mean(s : GeointersectpolygonRange) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_polygon_range_scale(s : GeointersectpolygonRange, f : Double) -> GeointersectpolygonRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_range_add(a : GeointersectpolygonRange, b : GeointersectpolygonRange) -> GeointersectpolygonRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_polygon_range_copy(s : GeointersectpolygonRange) -> GeointersectpolygonRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_range_fill(s : GeointersectpolygonRange, v : Double) -> GeointersectpolygonRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_range_min(s : GeointersectpolygonRange) -> Double { @_common.min(s.data) }

pub fn geo_intersect_polygon_range_max(s : GeointersectpolygonRange) -> Double { @_common.max(s.data) }

pub fn geo_intersect_polygon_range_to_string(s : GeointersectpolygonRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectpolygonSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_polygon_slice_make(size : Int) -> GeointersectpolygonSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_polygon_slice_len(s : GeointersectpolygonSlice) -> Int { s.size }

pub fn geo_intersect_polygon_slice_get(s : GeointersectpolygonSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_polygon_slice_set(s : GeointersectpolygonSlice, i : Int, v : Double) -> GeointersectpolygonSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_slice_sum(s : GeointersectpolygonSlice) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_polygon_slice_mean(s : GeointersectpolygonSlice) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_polygon_slice_scale(s : GeointersectpolygonSlice, f : Double) -> GeointersectpolygonSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_slice_add(a : GeointersectpolygonSlice, b : GeointersectpolygonSlice) -> GeointersectpolygonSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_polygon_slice_copy(s : GeointersectpolygonSlice) -> GeointersectpolygonSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_slice_fill(s : GeointersectpolygonSlice, v : Double) -> GeointersectpolygonSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_polygon_slice_min(s : GeointersectpolygonSlice) -> Double { @_common.min(s.data) }

pub fn geo_intersect_polygon_slice_max(s : GeointersectpolygonSlice) -> Double { @_common.max(s.data) }

pub fn geo_intersect_polygon_slice_to_string(s : GeointersectpolygonSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

