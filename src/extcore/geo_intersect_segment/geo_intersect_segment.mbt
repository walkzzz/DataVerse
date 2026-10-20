///===
/// extcore/geo_intersect_segment

pub(all) struct GeointersectsegmentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_segment_make_point(x : Double, y : Double) -> GeointersectsegmentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_segment_make_point3(x : Double, y : Double, z : Double) -> GeointersectsegmentPoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectsegmentPoint::x(self : GeointersectsegmentPoint) -> Double { self.x }

pub fn GeointersectsegmentPoint::y(self : GeointersectsegmentPoint) -> Double { self.y }

pub fn GeointersectsegmentPoint::z(self : GeointersectsegmentPoint) -> Double { self.z }

pub fn GeointersectsegmentPoint::label(self : GeointersectsegmentPoint) -> Int { self.label }

pub fn GeointersectsegmentPoint::dist(self : GeointersectsegmentPoint, other : GeointersectsegmentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectsegmentPoint::add(self : GeointersectsegmentPoint, other : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectsegmentPoint::sub(self : GeointersectsegmentPoint, other : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectsegmentPoint::scale(self : GeointersectsegmentPoint, s : Double) -> GeointersectsegmentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectsegmentPoint::dot(self : GeointersectsegmentPoint, other : GeointersectsegmentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectsegmentPoint::cross(self : GeointersectsegmentPoint, other : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectsegmentPoint::norm(self : GeointersectsegmentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectsegmentPoint::normalize(self : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectsegmentPoint::negate(self : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectsegmentPoint::mid(self : GeointersectsegmentPoint, other : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectsegmentPoint::lerp(self : GeointersectsegmentPoint, other : GeointersectsegmentPoint, t : Double) -> GeointersectsegmentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectsegmentPoint::to_string(self : GeointersectsegmentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectsegmentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_segment_make_series(vals : Array[Double], name : String) -> GeointersectsegmentSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectsegmentSeries::len(self : GeointersectsegmentSeries) -> Int { self.vals.length() }

pub fn GeointersectsegmentSeries::sum(self : GeointersectsegmentSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectsegmentSeries::mean(self : GeointersectsegmentSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectsegmentSeries::min(self : GeointersectsegmentSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectsegmentSeries::max(self : GeointersectsegmentSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectsegmentSeries::range(self : GeointersectsegmentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectsegmentSeries::variance(self : GeointersectsegmentSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectsegmentSeries::std(self : GeointersectsegmentSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectsegmentSeries::median(self : GeointersectsegmentSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectsegmentSeries::scale(self : GeointersectsegmentSeries, f : Double) -> GeointersectsegmentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectsegmentSeries::add(self : GeointersectsegmentSeries, other : GeointersectsegmentSeries) -> GeointersectsegmentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectsegmentSeries::sub(self : GeointersectsegmentSeries, other : GeointersectsegmentSeries) -> GeointersectsegmentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectsegmentSeries::normalize(self : GeointersectsegmentSeries) -> GeointersectsegmentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectsegmentSeries::cumsum(self : GeointersectsegmentSeries) -> GeointersectsegmentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectsegmentSeries::to_string(self : GeointersectsegmentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectsegmentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_segment_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectsegmentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_segment_matrix_identity(n : Int) -> GeointersectsegmentMatrix {
  let m = geo_intersect_segment_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectsegmentMatrix::get(self : GeointersectsegmentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectsegmentMatrix::transpose(self : GeointersectsegmentMatrix) -> GeointersectsegmentMatrix {
  let result = geo_intersect_segment_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectsegmentMatrix::add(self : GeointersectsegmentMatrix, other : GeointersectsegmentMatrix) -> GeointersectsegmentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_segment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectsegmentMatrix::scale(self : GeointersectsegmentMatrix, s : Double) -> GeointersectsegmentMatrix {
  let result = geo_intersect_segment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectsegmentMatrix::multiply(self : GeointersectsegmentMatrix, other : GeointersectsegmentMatrix) -> GeointersectsegmentMatrix {
  if self.cols != other.rows { return geo_intersect_segment_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_segment_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeointersectsegmentMatrix::trace(self : GeointersectsegmentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectsegmentMatrix::det(self : GeointersectsegmentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectsegmentMatrix::norm(self : GeointersectsegmentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectsegmentMatrix::to_string(self : GeointersectsegmentMatrix) -> String {
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

pub(all) struct GeointersectsegmentVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_segment_make_vector(comps : Array[Double]) -> GeointersectsegmentVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_segment_vector_zero(dim : Int) -> GeointersectsegmentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectsegmentVector::add(self : GeointersectsegmentVector, other : GeointersectsegmentVector) -> GeointersectsegmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectsegmentVector::sub(self : GeointersectsegmentVector, other : GeointersectsegmentVector) -> GeointersectsegmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectsegmentVector::scale(self : GeointersectsegmentVector, s : Double) -> GeointersectsegmentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectsegmentVector::dot(self : GeointersectsegmentVector, other : GeointersectsegmentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectsegmentVector::norm(self : GeointersectsegmentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectsegmentVector::normalize(self : GeointersectsegmentVector) -> GeointersectsegmentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectsegmentVector::dist(self : GeointersectsegmentVector, other : GeointersectsegmentVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectsegmentVector::to_string(self : GeointersectsegmentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_segment_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_intersect_segment_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_intersect_segment_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_intersect_segment_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_intersect_segment_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_intersect_segment_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_intersect_segment_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_intersect_segment_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_intersect_segment_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_intersect_segment_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_intersect_segment_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_intersect_segment_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_intersect_segment_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_intersect_segment_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_intersect_segment_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_intersect_segment_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_intersect_segment_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_intersect_segment_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_intersect_segment_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_intersect_segment_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_intersect_segment_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_intersect_segment_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_intersect_segment_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_intersect_segment_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_intersect_segment_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_intersect_segment_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_intersect_segment_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_intersect_segment_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_intersect_segment_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeointersectsegmentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_frame_make(size : Int) -> GeointersectsegmentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_frame_len(s : GeointersectsegmentFrame) -> Int { s.size }

pub fn geo_intersect_segment_frame_get(s : GeointersectsegmentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_frame_set(s : GeointersectsegmentFrame, i : Int, v : Double) -> GeointersectsegmentFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_frame_sum(s : GeointersectsegmentFrame) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_segment_frame_mean(s : GeointersectsegmentFrame) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_segment_frame_scale(s : GeointersectsegmentFrame, f : Double) -> GeointersectsegmentFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_frame_add(a : GeointersectsegmentFrame, b : GeointersectsegmentFrame) -> GeointersectsegmentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_segment_frame_copy(s : GeointersectsegmentFrame) -> GeointersectsegmentFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_frame_fill(s : GeointersectsegmentFrame, v : Double) -> GeointersectsegmentFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_frame_min(s : GeointersectsegmentFrame) -> Double { @_common.min(s.data) }

pub fn geo_intersect_segment_frame_max(s : GeointersectsegmentFrame) -> Double { @_common.max(s.data) }

pub fn geo_intersect_segment_frame_to_string(s : GeointersectsegmentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_table_make(size : Int) -> GeointersectsegmentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_table_len(s : GeointersectsegmentTable) -> Int { s.size }

pub fn geo_intersect_segment_table_get(s : GeointersectsegmentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_table_set(s : GeointersectsegmentTable, i : Int, v : Double) -> GeointersectsegmentTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_table_sum(s : GeointersectsegmentTable) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_segment_table_mean(s : GeointersectsegmentTable) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_segment_table_scale(s : GeointersectsegmentTable, f : Double) -> GeointersectsegmentTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_table_add(a : GeointersectsegmentTable, b : GeointersectsegmentTable) -> GeointersectsegmentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_segment_table_copy(s : GeointersectsegmentTable) -> GeointersectsegmentTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_table_fill(s : GeointersectsegmentTable, v : Double) -> GeointersectsegmentTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_table_min(s : GeointersectsegmentTable) -> Double { @_common.min(s.data) }

pub fn geo_intersect_segment_table_max(s : GeointersectsegmentTable) -> Double { @_common.max(s.data) }

pub fn geo_intersect_segment_table_to_string(s : GeointersectsegmentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_graphn_make(size : Int) -> GeointersectsegmentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_graphn_len(s : GeointersectsegmentGraphN) -> Int { s.size }

pub fn geo_intersect_segment_graphn_get(s : GeointersectsegmentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_graphn_set(s : GeointersectsegmentGraphN, i : Int, v : Double) -> GeointersectsegmentGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_graphn_sum(s : GeointersectsegmentGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_segment_graphn_mean(s : GeointersectsegmentGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_segment_graphn_scale(s : GeointersectsegmentGraphN, f : Double) -> GeointersectsegmentGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_graphn_add(a : GeointersectsegmentGraphN, b : GeointersectsegmentGraphN) -> GeointersectsegmentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_segment_graphn_copy(s : GeointersectsegmentGraphN) -> GeointersectsegmentGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_graphn_fill(s : GeointersectsegmentGraphN, v : Double) -> GeointersectsegmentGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_graphn_min(s : GeointersectsegmentGraphN) -> Double { @_common.min(s.data) }

pub fn geo_intersect_segment_graphn_max(s : GeointersectsegmentGraphN) -> Double { @_common.max(s.data) }

pub fn geo_intersect_segment_graphn_to_string(s : GeointersectsegmentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_node_make(size : Int) -> GeointersectsegmentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_node_len(s : GeointersectsegmentNode) -> Int { s.size }

pub fn geo_intersect_segment_node_get(s : GeointersectsegmentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_node_set(s : GeointersectsegmentNode, i : Int, v : Double) -> GeointersectsegmentNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_node_sum(s : GeointersectsegmentNode) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_segment_node_mean(s : GeointersectsegmentNode) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_segment_node_scale(s : GeointersectsegmentNode, f : Double) -> GeointersectsegmentNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_node_add(a : GeointersectsegmentNode, b : GeointersectsegmentNode) -> GeointersectsegmentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_segment_node_copy(s : GeointersectsegmentNode) -> GeointersectsegmentNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_node_fill(s : GeointersectsegmentNode, v : Double) -> GeointersectsegmentNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_node_min(s : GeointersectsegmentNode) -> Double { @_common.min(s.data) }

pub fn geo_intersect_segment_node_max(s : GeointersectsegmentNode) -> Double { @_common.max(s.data) }

pub fn geo_intersect_segment_node_to_string(s : GeointersectsegmentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_edge_make(size : Int) -> GeointersectsegmentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_edge_len(s : GeointersectsegmentEdge) -> Int { s.size }

pub fn geo_intersect_segment_edge_get(s : GeointersectsegmentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_edge_set(s : GeointersectsegmentEdge, i : Int, v : Double) -> GeointersectsegmentEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_edge_sum(s : GeointersectsegmentEdge) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_segment_edge_mean(s : GeointersectsegmentEdge) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_segment_edge_scale(s : GeointersectsegmentEdge, f : Double) -> GeointersectsegmentEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_edge_add(a : GeointersectsegmentEdge, b : GeointersectsegmentEdge) -> GeointersectsegmentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_segment_edge_copy(s : GeointersectsegmentEdge) -> GeointersectsegmentEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_edge_fill(s : GeointersectsegmentEdge, v : Double) -> GeointersectsegmentEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_edge_min(s : GeointersectsegmentEdge) -> Double { @_common.min(s.data) }

pub fn geo_intersect_segment_edge_max(s : GeointersectsegmentEdge) -> Double { @_common.max(s.data) }

pub fn geo_intersect_segment_edge_to_string(s : GeointersectsegmentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_path_make(size : Int) -> GeointersectsegmentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_path_len(s : GeointersectsegmentPath) -> Int { s.size }

pub fn geo_intersect_segment_path_get(s : GeointersectsegmentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_path_set(s : GeointersectsegmentPath, i : Int, v : Double) -> GeointersectsegmentPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_path_sum(s : GeointersectsegmentPath) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_segment_path_mean(s : GeointersectsegmentPath) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_segment_path_scale(s : GeointersectsegmentPath, f : Double) -> GeointersectsegmentPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_path_add(a : GeointersectsegmentPath, b : GeointersectsegmentPath) -> GeointersectsegmentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_segment_path_copy(s : GeointersectsegmentPath) -> GeointersectsegmentPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_path_fill(s : GeointersectsegmentPath, v : Double) -> GeointersectsegmentPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_path_min(s : GeointersectsegmentPath) -> Double { @_common.min(s.data) }

pub fn geo_intersect_segment_path_max(s : GeointersectsegmentPath) -> Double { @_common.max(s.data) }

pub fn geo_intersect_segment_path_to_string(s : GeointersectsegmentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_cluster_make(size : Int) -> GeointersectsegmentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_cluster_len(s : GeointersectsegmentCluster) -> Int { s.size }

pub fn geo_intersect_segment_cluster_get(s : GeointersectsegmentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_cluster_set(s : GeointersectsegmentCluster, i : Int, v : Double) -> GeointersectsegmentCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_cluster_sum(s : GeointersectsegmentCluster) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_segment_cluster_mean(s : GeointersectsegmentCluster) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_segment_cluster_scale(s : GeointersectsegmentCluster, f : Double) -> GeointersectsegmentCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_cluster_add(a : GeointersectsegmentCluster, b : GeointersectsegmentCluster) -> GeointersectsegmentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_segment_cluster_copy(s : GeointersectsegmentCluster) -> GeointersectsegmentCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_cluster_fill(s : GeointersectsegmentCluster, v : Double) -> GeointersectsegmentCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_cluster_min(s : GeointersectsegmentCluster) -> Double { @_common.min(s.data) }

pub fn geo_intersect_segment_cluster_max(s : GeointersectsegmentCluster) -> Double { @_common.max(s.data) }

pub fn geo_intersect_segment_cluster_to_string(s : GeointersectsegmentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_model_make(size : Int) -> GeointersectsegmentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_model_len(s : GeointersectsegmentModel) -> Int { s.size }

pub fn geo_intersect_segment_model_get(s : GeointersectsegmentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_model_set(s : GeointersectsegmentModel, i : Int, v : Double) -> GeointersectsegmentModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_model_sum(s : GeointersectsegmentModel) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_segment_model_mean(s : GeointersectsegmentModel) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_segment_model_scale(s : GeointersectsegmentModel, f : Double) -> GeointersectsegmentModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_model_add(a : GeointersectsegmentModel, b : GeointersectsegmentModel) -> GeointersectsegmentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_segment_model_copy(s : GeointersectsegmentModel) -> GeointersectsegmentModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_model_fill(s : GeointersectsegmentModel, v : Double) -> GeointersectsegmentModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_model_min(s : GeointersectsegmentModel) -> Double { @_common.min(s.data) }

pub fn geo_intersect_segment_model_max(s : GeointersectsegmentModel) -> Double { @_common.max(s.data) }

pub fn geo_intersect_segment_model_to_string(s : GeointersectsegmentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_layer_make(size : Int) -> GeointersectsegmentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_layer_len(s : GeointersectsegmentLayer) -> Int { s.size }

pub fn geo_intersect_segment_layer_get(s : GeointersectsegmentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_layer_set(s : GeointersectsegmentLayer, i : Int, v : Double) -> GeointersectsegmentLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_layer_sum(s : GeointersectsegmentLayer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_segment_layer_mean(s : GeointersectsegmentLayer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_segment_layer_scale(s : GeointersectsegmentLayer, f : Double) -> GeointersectsegmentLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_layer_add(a : GeointersectsegmentLayer, b : GeointersectsegmentLayer) -> GeointersectsegmentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_segment_layer_copy(s : GeointersectsegmentLayer) -> GeointersectsegmentLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_layer_fill(s : GeointersectsegmentLayer, v : Double) -> GeointersectsegmentLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_layer_min(s : GeointersectsegmentLayer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_segment_layer_max(s : GeointersectsegmentLayer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_segment_layer_to_string(s : GeointersectsegmentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_buffer_make(size : Int) -> GeointersectsegmentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_buffer_len(s : GeointersectsegmentBuffer) -> Int { s.size }

pub fn geo_intersect_segment_buffer_get(s : GeointersectsegmentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_buffer_set(s : GeointersectsegmentBuffer, i : Int, v : Double) -> GeointersectsegmentBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_buffer_sum(s : GeointersectsegmentBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_segment_buffer_mean(s : GeointersectsegmentBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_segment_buffer_scale(s : GeointersectsegmentBuffer, f : Double) -> GeointersectsegmentBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_buffer_add(a : GeointersectsegmentBuffer, b : GeointersectsegmentBuffer) -> GeointersectsegmentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_segment_buffer_copy(s : GeointersectsegmentBuffer) -> GeointersectsegmentBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_buffer_fill(s : GeointersectsegmentBuffer, v : Double) -> GeointersectsegmentBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_buffer_min(s : GeointersectsegmentBuffer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_segment_buffer_max(s : GeointersectsegmentBuffer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_segment_buffer_to_string(s : GeointersectsegmentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_cursor_make(size : Int) -> GeointersectsegmentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_cursor_len(s : GeointersectsegmentCursor) -> Int { s.size }

pub fn geo_intersect_segment_cursor_get(s : GeointersectsegmentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_cursor_set(s : GeointersectsegmentCursor, i : Int, v : Double) -> GeointersectsegmentCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_cursor_sum(s : GeointersectsegmentCursor) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_segment_cursor_mean(s : GeointersectsegmentCursor) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_segment_cursor_scale(s : GeointersectsegmentCursor, f : Double) -> GeointersectsegmentCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_cursor_add(a : GeointersectsegmentCursor, b : GeointersectsegmentCursor) -> GeointersectsegmentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_segment_cursor_copy(s : GeointersectsegmentCursor) -> GeointersectsegmentCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_cursor_fill(s : GeointersectsegmentCursor, v : Double) -> GeointersectsegmentCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_cursor_min(s : GeointersectsegmentCursor) -> Double { @_common.min(s.data) }

pub fn geo_intersect_segment_cursor_max(s : GeointersectsegmentCursor) -> Double { @_common.max(s.data) }

pub fn geo_intersect_segment_cursor_to_string(s : GeointersectsegmentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_view_make(size : Int) -> GeointersectsegmentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_view_len(s : GeointersectsegmentView) -> Int { s.size }

pub fn geo_intersect_segment_view_get(s : GeointersectsegmentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_view_set(s : GeointersectsegmentView, i : Int, v : Double) -> GeointersectsegmentView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_view_sum(s : GeointersectsegmentView) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_segment_view_mean(s : GeointersectsegmentView) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_segment_view_scale(s : GeointersectsegmentView, f : Double) -> GeointersectsegmentView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_view_add(a : GeointersectsegmentView, b : GeointersectsegmentView) -> GeointersectsegmentView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_segment_view_copy(s : GeointersectsegmentView) -> GeointersectsegmentView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_view_fill(s : GeointersectsegmentView, v : Double) -> GeointersectsegmentView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_view_min(s : GeointersectsegmentView) -> Double { @_common.min(s.data) }

pub fn geo_intersect_segment_view_max(s : GeointersectsegmentView) -> Double { @_common.max(s.data) }

pub fn geo_intersect_segment_view_to_string(s : GeointersectsegmentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_range_make(size : Int) -> GeointersectsegmentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_range_len(s : GeointersectsegmentRange) -> Int { s.size }

pub fn geo_intersect_segment_range_get(s : GeointersectsegmentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_range_set(s : GeointersectsegmentRange, i : Int, v : Double) -> GeointersectsegmentRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_range_sum(s : GeointersectsegmentRange) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_segment_range_mean(s : GeointersectsegmentRange) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_segment_range_scale(s : GeointersectsegmentRange, f : Double) -> GeointersectsegmentRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_range_add(a : GeointersectsegmentRange, b : GeointersectsegmentRange) -> GeointersectsegmentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_segment_range_copy(s : GeointersectsegmentRange) -> GeointersectsegmentRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_range_fill(s : GeointersectsegmentRange, v : Double) -> GeointersectsegmentRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_range_min(s : GeointersectsegmentRange) -> Double { @_common.min(s.data) }

pub fn geo_intersect_segment_range_max(s : GeointersectsegmentRange) -> Double { @_common.max(s.data) }

pub fn geo_intersect_segment_range_to_string(s : GeointersectsegmentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_slice_make(size : Int) -> GeointersectsegmentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_slice_len(s : GeointersectsegmentSlice) -> Int { s.size }

pub fn geo_intersect_segment_slice_get(s : GeointersectsegmentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_slice_set(s : GeointersectsegmentSlice, i : Int, v : Double) -> GeointersectsegmentSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_slice_sum(s : GeointersectsegmentSlice) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_segment_slice_mean(s : GeointersectsegmentSlice) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_segment_slice_scale(s : GeointersectsegmentSlice, f : Double) -> GeointersectsegmentSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_slice_add(a : GeointersectsegmentSlice, b : GeointersectsegmentSlice) -> GeointersectsegmentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_segment_slice_copy(s : GeointersectsegmentSlice) -> GeointersectsegmentSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_slice_fill(s : GeointersectsegmentSlice, v : Double) -> GeointersectsegmentSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_segment_slice_min(s : GeointersectsegmentSlice) -> Double { @_common.min(s.data) }

pub fn geo_intersect_segment_slice_max(s : GeointersectsegmentSlice) -> Double { @_common.max(s.data) }

pub fn geo_intersect_segment_slice_to_string(s : GeointersectsegmentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

