///===
/// extcore/geo_proj_gnomonic

pub(all) struct GeoprojgnomonicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_gnomonic_make_point(x : Double, y : Double) -> GeoprojgnomonicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_gnomonic_make_point3(x : Double, y : Double, z : Double) -> GeoprojgnomonicPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojgnomonicPoint::x(self : GeoprojgnomonicPoint) -> Double { self.x }

pub fn GeoprojgnomonicPoint::y(self : GeoprojgnomonicPoint) -> Double { self.y }

pub fn GeoprojgnomonicPoint::z(self : GeoprojgnomonicPoint) -> Double { self.z }

pub fn GeoprojgnomonicPoint::label(self : GeoprojgnomonicPoint) -> Int { self.label }

pub fn GeoprojgnomonicPoint::dist(self : GeoprojgnomonicPoint, other : GeoprojgnomonicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojgnomonicPoint::add(self : GeoprojgnomonicPoint, other : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojgnomonicPoint::sub(self : GeoprojgnomonicPoint, other : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojgnomonicPoint::scale(self : GeoprojgnomonicPoint, s : Double) -> GeoprojgnomonicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojgnomonicPoint::dot(self : GeoprojgnomonicPoint, other : GeoprojgnomonicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojgnomonicPoint::cross(self : GeoprojgnomonicPoint, other : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojgnomonicPoint::norm(self : GeoprojgnomonicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojgnomonicPoint::normalize(self : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojgnomonicPoint::negate(self : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojgnomonicPoint::mid(self : GeoprojgnomonicPoint, other : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojgnomonicPoint::lerp(self : GeoprojgnomonicPoint, other : GeoprojgnomonicPoint, t : Double) -> GeoprojgnomonicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojgnomonicPoint::to_string(self : GeoprojgnomonicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojgnomonicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_gnomonic_make_series(vals : Array[Double], name : String) -> GeoprojgnomonicSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojgnomonicSeries::len(self : GeoprojgnomonicSeries) -> Int { self.vals.length() }

pub fn GeoprojgnomonicSeries::sum(self : GeoprojgnomonicSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojgnomonicSeries::mean(self : GeoprojgnomonicSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojgnomonicSeries::min(self : GeoprojgnomonicSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojgnomonicSeries::max(self : GeoprojgnomonicSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojgnomonicSeries::range(self : GeoprojgnomonicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojgnomonicSeries::variance(self : GeoprojgnomonicSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojgnomonicSeries::std(self : GeoprojgnomonicSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojgnomonicSeries::median(self : GeoprojgnomonicSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojgnomonicSeries::scale(self : GeoprojgnomonicSeries, f : Double) -> GeoprojgnomonicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojgnomonicSeries::add(self : GeoprojgnomonicSeries, other : GeoprojgnomonicSeries) -> GeoprojgnomonicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojgnomonicSeries::sub(self : GeoprojgnomonicSeries, other : GeoprojgnomonicSeries) -> GeoprojgnomonicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojgnomonicSeries::normalize(self : GeoprojgnomonicSeries) -> GeoprojgnomonicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojgnomonicSeries::cumsum(self : GeoprojgnomonicSeries) -> GeoprojgnomonicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojgnomonicSeries::to_string(self : GeoprojgnomonicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojgnomonicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_gnomonic_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojgnomonicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_gnomonic_matrix_identity(n : Int) -> GeoprojgnomonicMatrix {
  let m = geo_proj_gnomonic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojgnomonicMatrix::get(self : GeoprojgnomonicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojgnomonicMatrix::transpose(self : GeoprojgnomonicMatrix) -> GeoprojgnomonicMatrix {
  let result = geo_proj_gnomonic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojgnomonicMatrix::add(self : GeoprojgnomonicMatrix, other : GeoprojgnomonicMatrix) -> GeoprojgnomonicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_gnomonic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojgnomonicMatrix::scale(self : GeoprojgnomonicMatrix, s : Double) -> GeoprojgnomonicMatrix {
  let result = geo_proj_gnomonic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojgnomonicMatrix::multiply(self : GeoprojgnomonicMatrix, other : GeoprojgnomonicMatrix) -> GeoprojgnomonicMatrix {
  if self.cols != other.rows { return geo_proj_gnomonic_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_gnomonic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeoprojgnomonicMatrix::trace(self : GeoprojgnomonicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojgnomonicMatrix::det(self : GeoprojgnomonicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojgnomonicMatrix::norm(self : GeoprojgnomonicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojgnomonicMatrix::to_string(self : GeoprojgnomonicMatrix) -> String {
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

pub(all) struct GeoprojgnomonicVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_gnomonic_make_vector(comps : Array[Double]) -> GeoprojgnomonicVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_gnomonic_vector_zero(dim : Int) -> GeoprojgnomonicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojgnomonicVector::add(self : GeoprojgnomonicVector, other : GeoprojgnomonicVector) -> GeoprojgnomonicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojgnomonicVector::sub(self : GeoprojgnomonicVector, other : GeoprojgnomonicVector) -> GeoprojgnomonicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojgnomonicVector::scale(self : GeoprojgnomonicVector, s : Double) -> GeoprojgnomonicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojgnomonicVector::dot(self : GeoprojgnomonicVector, other : GeoprojgnomonicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojgnomonicVector::norm(self : GeoprojgnomonicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojgnomonicVector::normalize(self : GeoprojgnomonicVector) -> GeoprojgnomonicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojgnomonicVector::dist(self : GeoprojgnomonicVector, other : GeoprojgnomonicVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojgnomonicVector::to_string(self : GeoprojgnomonicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_gnomonic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_gnomonic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_gnomonic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_gnomonic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_gnomonic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_gnomonic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_gnomonic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_gnomonic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_gnomonic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_gnomonic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_gnomonic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_gnomonic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_gnomonic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_gnomonic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_gnomonic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_gnomonic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_gnomonic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_gnomonic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_gnomonic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_gnomonic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_gnomonic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_gnomonic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_gnomonic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_gnomonic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_gnomonic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_gnomonic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_gnomonic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_gnomonic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_gnomonic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojgnomonicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_frame_make(size : Int) -> GeoprojgnomonicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_frame_len(s : GeoprojgnomonicFrame) -> Int { s.size }

pub fn geo_proj_gnomonic_frame_get(s : GeoprojgnomonicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_frame_set(s : GeoprojgnomonicFrame, i : Int, v : Double) -> GeoprojgnomonicFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_frame_sum(s : GeoprojgnomonicFrame) -> Double { @_common.sum(s.data) }

pub fn geo_proj_gnomonic_frame_mean(s : GeoprojgnomonicFrame) -> Double { @_common.mean(s.data) }

pub fn geo_proj_gnomonic_frame_scale(s : GeoprojgnomonicFrame, f : Double) -> GeoprojgnomonicFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_frame_add(a : GeoprojgnomonicFrame, b : GeoprojgnomonicFrame) -> GeoprojgnomonicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_gnomonic_frame_copy(s : GeoprojgnomonicFrame) -> GeoprojgnomonicFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_frame_fill(s : GeoprojgnomonicFrame, v : Double) -> GeoprojgnomonicFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_frame_min(s : GeoprojgnomonicFrame) -> Double { @_common.min(s.data) }

pub fn geo_proj_gnomonic_frame_max(s : GeoprojgnomonicFrame) -> Double { @_common.max(s.data) }

pub fn geo_proj_gnomonic_frame_to_string(s : GeoprojgnomonicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_table_make(size : Int) -> GeoprojgnomonicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_table_len(s : GeoprojgnomonicTable) -> Int { s.size }

pub fn geo_proj_gnomonic_table_get(s : GeoprojgnomonicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_table_set(s : GeoprojgnomonicTable, i : Int, v : Double) -> GeoprojgnomonicTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_table_sum(s : GeoprojgnomonicTable) -> Double { @_common.sum(s.data) }

pub fn geo_proj_gnomonic_table_mean(s : GeoprojgnomonicTable) -> Double { @_common.mean(s.data) }

pub fn geo_proj_gnomonic_table_scale(s : GeoprojgnomonicTable, f : Double) -> GeoprojgnomonicTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_table_add(a : GeoprojgnomonicTable, b : GeoprojgnomonicTable) -> GeoprojgnomonicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_gnomonic_table_copy(s : GeoprojgnomonicTable) -> GeoprojgnomonicTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_table_fill(s : GeoprojgnomonicTable, v : Double) -> GeoprojgnomonicTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_table_min(s : GeoprojgnomonicTable) -> Double { @_common.min(s.data) }

pub fn geo_proj_gnomonic_table_max(s : GeoprojgnomonicTable) -> Double { @_common.max(s.data) }

pub fn geo_proj_gnomonic_table_to_string(s : GeoprojgnomonicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_graphn_make(size : Int) -> GeoprojgnomonicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_graphn_len(s : GeoprojgnomonicGraphN) -> Int { s.size }

pub fn geo_proj_gnomonic_graphn_get(s : GeoprojgnomonicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_graphn_set(s : GeoprojgnomonicGraphN, i : Int, v : Double) -> GeoprojgnomonicGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_graphn_sum(s : GeoprojgnomonicGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_proj_gnomonic_graphn_mean(s : GeoprojgnomonicGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_proj_gnomonic_graphn_scale(s : GeoprojgnomonicGraphN, f : Double) -> GeoprojgnomonicGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_graphn_add(a : GeoprojgnomonicGraphN, b : GeoprojgnomonicGraphN) -> GeoprojgnomonicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_gnomonic_graphn_copy(s : GeoprojgnomonicGraphN) -> GeoprojgnomonicGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_graphn_fill(s : GeoprojgnomonicGraphN, v : Double) -> GeoprojgnomonicGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_graphn_min(s : GeoprojgnomonicGraphN) -> Double { @_common.min(s.data) }

pub fn geo_proj_gnomonic_graphn_max(s : GeoprojgnomonicGraphN) -> Double { @_common.max(s.data) }

pub fn geo_proj_gnomonic_graphn_to_string(s : GeoprojgnomonicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_node_make(size : Int) -> GeoprojgnomonicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_node_len(s : GeoprojgnomonicNode) -> Int { s.size }

pub fn geo_proj_gnomonic_node_get(s : GeoprojgnomonicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_node_set(s : GeoprojgnomonicNode, i : Int, v : Double) -> GeoprojgnomonicNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_node_sum(s : GeoprojgnomonicNode) -> Double { @_common.sum(s.data) }

pub fn geo_proj_gnomonic_node_mean(s : GeoprojgnomonicNode) -> Double { @_common.mean(s.data) }

pub fn geo_proj_gnomonic_node_scale(s : GeoprojgnomonicNode, f : Double) -> GeoprojgnomonicNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_node_add(a : GeoprojgnomonicNode, b : GeoprojgnomonicNode) -> GeoprojgnomonicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_gnomonic_node_copy(s : GeoprojgnomonicNode) -> GeoprojgnomonicNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_node_fill(s : GeoprojgnomonicNode, v : Double) -> GeoprojgnomonicNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_node_min(s : GeoprojgnomonicNode) -> Double { @_common.min(s.data) }

pub fn geo_proj_gnomonic_node_max(s : GeoprojgnomonicNode) -> Double { @_common.max(s.data) }

pub fn geo_proj_gnomonic_node_to_string(s : GeoprojgnomonicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_edge_make(size : Int) -> GeoprojgnomonicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_edge_len(s : GeoprojgnomonicEdge) -> Int { s.size }

pub fn geo_proj_gnomonic_edge_get(s : GeoprojgnomonicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_edge_set(s : GeoprojgnomonicEdge, i : Int, v : Double) -> GeoprojgnomonicEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_edge_sum(s : GeoprojgnomonicEdge) -> Double { @_common.sum(s.data) }

pub fn geo_proj_gnomonic_edge_mean(s : GeoprojgnomonicEdge) -> Double { @_common.mean(s.data) }

pub fn geo_proj_gnomonic_edge_scale(s : GeoprojgnomonicEdge, f : Double) -> GeoprojgnomonicEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_edge_add(a : GeoprojgnomonicEdge, b : GeoprojgnomonicEdge) -> GeoprojgnomonicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_gnomonic_edge_copy(s : GeoprojgnomonicEdge) -> GeoprojgnomonicEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_edge_fill(s : GeoprojgnomonicEdge, v : Double) -> GeoprojgnomonicEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_edge_min(s : GeoprojgnomonicEdge) -> Double { @_common.min(s.data) }

pub fn geo_proj_gnomonic_edge_max(s : GeoprojgnomonicEdge) -> Double { @_common.max(s.data) }

pub fn geo_proj_gnomonic_edge_to_string(s : GeoprojgnomonicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_path_make(size : Int) -> GeoprojgnomonicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_path_len(s : GeoprojgnomonicPath) -> Int { s.size }

pub fn geo_proj_gnomonic_path_get(s : GeoprojgnomonicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_path_set(s : GeoprojgnomonicPath, i : Int, v : Double) -> GeoprojgnomonicPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_path_sum(s : GeoprojgnomonicPath) -> Double { @_common.sum(s.data) }

pub fn geo_proj_gnomonic_path_mean(s : GeoprojgnomonicPath) -> Double { @_common.mean(s.data) }

pub fn geo_proj_gnomonic_path_scale(s : GeoprojgnomonicPath, f : Double) -> GeoprojgnomonicPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_path_add(a : GeoprojgnomonicPath, b : GeoprojgnomonicPath) -> GeoprojgnomonicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_gnomonic_path_copy(s : GeoprojgnomonicPath) -> GeoprojgnomonicPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_path_fill(s : GeoprojgnomonicPath, v : Double) -> GeoprojgnomonicPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_path_min(s : GeoprojgnomonicPath) -> Double { @_common.min(s.data) }

pub fn geo_proj_gnomonic_path_max(s : GeoprojgnomonicPath) -> Double { @_common.max(s.data) }

pub fn geo_proj_gnomonic_path_to_string(s : GeoprojgnomonicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_cluster_make(size : Int) -> GeoprojgnomonicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_cluster_len(s : GeoprojgnomonicCluster) -> Int { s.size }

pub fn geo_proj_gnomonic_cluster_get(s : GeoprojgnomonicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_cluster_set(s : GeoprojgnomonicCluster, i : Int, v : Double) -> GeoprojgnomonicCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_cluster_sum(s : GeoprojgnomonicCluster) -> Double { @_common.sum(s.data) }

pub fn geo_proj_gnomonic_cluster_mean(s : GeoprojgnomonicCluster) -> Double { @_common.mean(s.data) }

pub fn geo_proj_gnomonic_cluster_scale(s : GeoprojgnomonicCluster, f : Double) -> GeoprojgnomonicCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_cluster_add(a : GeoprojgnomonicCluster, b : GeoprojgnomonicCluster) -> GeoprojgnomonicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_gnomonic_cluster_copy(s : GeoprojgnomonicCluster) -> GeoprojgnomonicCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_cluster_fill(s : GeoprojgnomonicCluster, v : Double) -> GeoprojgnomonicCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_cluster_min(s : GeoprojgnomonicCluster) -> Double { @_common.min(s.data) }

pub fn geo_proj_gnomonic_cluster_max(s : GeoprojgnomonicCluster) -> Double { @_common.max(s.data) }

pub fn geo_proj_gnomonic_cluster_to_string(s : GeoprojgnomonicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_model_make(size : Int) -> GeoprojgnomonicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_model_len(s : GeoprojgnomonicModel) -> Int { s.size }

pub fn geo_proj_gnomonic_model_get(s : GeoprojgnomonicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_model_set(s : GeoprojgnomonicModel, i : Int, v : Double) -> GeoprojgnomonicModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_model_sum(s : GeoprojgnomonicModel) -> Double { @_common.sum(s.data) }

pub fn geo_proj_gnomonic_model_mean(s : GeoprojgnomonicModel) -> Double { @_common.mean(s.data) }

pub fn geo_proj_gnomonic_model_scale(s : GeoprojgnomonicModel, f : Double) -> GeoprojgnomonicModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_model_add(a : GeoprojgnomonicModel, b : GeoprojgnomonicModel) -> GeoprojgnomonicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_gnomonic_model_copy(s : GeoprojgnomonicModel) -> GeoprojgnomonicModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_model_fill(s : GeoprojgnomonicModel, v : Double) -> GeoprojgnomonicModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_model_min(s : GeoprojgnomonicModel) -> Double { @_common.min(s.data) }

pub fn geo_proj_gnomonic_model_max(s : GeoprojgnomonicModel) -> Double { @_common.max(s.data) }

pub fn geo_proj_gnomonic_model_to_string(s : GeoprojgnomonicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_layer_make(size : Int) -> GeoprojgnomonicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_layer_len(s : GeoprojgnomonicLayer) -> Int { s.size }

pub fn geo_proj_gnomonic_layer_get(s : GeoprojgnomonicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_layer_set(s : GeoprojgnomonicLayer, i : Int, v : Double) -> GeoprojgnomonicLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_layer_sum(s : GeoprojgnomonicLayer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_gnomonic_layer_mean(s : GeoprojgnomonicLayer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_gnomonic_layer_scale(s : GeoprojgnomonicLayer, f : Double) -> GeoprojgnomonicLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_layer_add(a : GeoprojgnomonicLayer, b : GeoprojgnomonicLayer) -> GeoprojgnomonicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_gnomonic_layer_copy(s : GeoprojgnomonicLayer) -> GeoprojgnomonicLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_layer_fill(s : GeoprojgnomonicLayer, v : Double) -> GeoprojgnomonicLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_layer_min(s : GeoprojgnomonicLayer) -> Double { @_common.min(s.data) }

pub fn geo_proj_gnomonic_layer_max(s : GeoprojgnomonicLayer) -> Double { @_common.max(s.data) }

pub fn geo_proj_gnomonic_layer_to_string(s : GeoprojgnomonicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_buffer_make(size : Int) -> GeoprojgnomonicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_buffer_len(s : GeoprojgnomonicBuffer) -> Int { s.size }

pub fn geo_proj_gnomonic_buffer_get(s : GeoprojgnomonicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_buffer_set(s : GeoprojgnomonicBuffer, i : Int, v : Double) -> GeoprojgnomonicBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_buffer_sum(s : GeoprojgnomonicBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_gnomonic_buffer_mean(s : GeoprojgnomonicBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_gnomonic_buffer_scale(s : GeoprojgnomonicBuffer, f : Double) -> GeoprojgnomonicBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_buffer_add(a : GeoprojgnomonicBuffer, b : GeoprojgnomonicBuffer) -> GeoprojgnomonicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_gnomonic_buffer_copy(s : GeoprojgnomonicBuffer) -> GeoprojgnomonicBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_buffer_fill(s : GeoprojgnomonicBuffer, v : Double) -> GeoprojgnomonicBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_buffer_min(s : GeoprojgnomonicBuffer) -> Double { @_common.min(s.data) }

pub fn geo_proj_gnomonic_buffer_max(s : GeoprojgnomonicBuffer) -> Double { @_common.max(s.data) }

pub fn geo_proj_gnomonic_buffer_to_string(s : GeoprojgnomonicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_cursor_make(size : Int) -> GeoprojgnomonicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_cursor_len(s : GeoprojgnomonicCursor) -> Int { s.size }

pub fn geo_proj_gnomonic_cursor_get(s : GeoprojgnomonicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_cursor_set(s : GeoprojgnomonicCursor, i : Int, v : Double) -> GeoprojgnomonicCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_cursor_sum(s : GeoprojgnomonicCursor) -> Double { @_common.sum(s.data) }

pub fn geo_proj_gnomonic_cursor_mean(s : GeoprojgnomonicCursor) -> Double { @_common.mean(s.data) }

pub fn geo_proj_gnomonic_cursor_scale(s : GeoprojgnomonicCursor, f : Double) -> GeoprojgnomonicCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_cursor_add(a : GeoprojgnomonicCursor, b : GeoprojgnomonicCursor) -> GeoprojgnomonicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_gnomonic_cursor_copy(s : GeoprojgnomonicCursor) -> GeoprojgnomonicCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_cursor_fill(s : GeoprojgnomonicCursor, v : Double) -> GeoprojgnomonicCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_cursor_min(s : GeoprojgnomonicCursor) -> Double { @_common.min(s.data) }

pub fn geo_proj_gnomonic_cursor_max(s : GeoprojgnomonicCursor) -> Double { @_common.max(s.data) }

pub fn geo_proj_gnomonic_cursor_to_string(s : GeoprojgnomonicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_view_make(size : Int) -> GeoprojgnomonicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_view_len(s : GeoprojgnomonicView) -> Int { s.size }

pub fn geo_proj_gnomonic_view_get(s : GeoprojgnomonicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_view_set(s : GeoprojgnomonicView, i : Int, v : Double) -> GeoprojgnomonicView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_view_sum(s : GeoprojgnomonicView) -> Double { @_common.sum(s.data) }

pub fn geo_proj_gnomonic_view_mean(s : GeoprojgnomonicView) -> Double { @_common.mean(s.data) }

pub fn geo_proj_gnomonic_view_scale(s : GeoprojgnomonicView, f : Double) -> GeoprojgnomonicView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_view_add(a : GeoprojgnomonicView, b : GeoprojgnomonicView) -> GeoprojgnomonicView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_gnomonic_view_copy(s : GeoprojgnomonicView) -> GeoprojgnomonicView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_view_fill(s : GeoprojgnomonicView, v : Double) -> GeoprojgnomonicView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_view_min(s : GeoprojgnomonicView) -> Double { @_common.min(s.data) }

pub fn geo_proj_gnomonic_view_max(s : GeoprojgnomonicView) -> Double { @_common.max(s.data) }

pub fn geo_proj_gnomonic_view_to_string(s : GeoprojgnomonicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_range_make(size : Int) -> GeoprojgnomonicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_range_len(s : GeoprojgnomonicRange) -> Int { s.size }

pub fn geo_proj_gnomonic_range_get(s : GeoprojgnomonicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_range_set(s : GeoprojgnomonicRange, i : Int, v : Double) -> GeoprojgnomonicRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_range_sum(s : GeoprojgnomonicRange) -> Double { @_common.sum(s.data) }

pub fn geo_proj_gnomonic_range_mean(s : GeoprojgnomonicRange) -> Double { @_common.mean(s.data) }

pub fn geo_proj_gnomonic_range_scale(s : GeoprojgnomonicRange, f : Double) -> GeoprojgnomonicRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_range_add(a : GeoprojgnomonicRange, b : GeoprojgnomonicRange) -> GeoprojgnomonicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_gnomonic_range_copy(s : GeoprojgnomonicRange) -> GeoprojgnomonicRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_range_fill(s : GeoprojgnomonicRange, v : Double) -> GeoprojgnomonicRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_range_min(s : GeoprojgnomonicRange) -> Double { @_common.min(s.data) }

pub fn geo_proj_gnomonic_range_max(s : GeoprojgnomonicRange) -> Double { @_common.max(s.data) }

pub fn geo_proj_gnomonic_range_to_string(s : GeoprojgnomonicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_slice_make(size : Int) -> GeoprojgnomonicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_slice_len(s : GeoprojgnomonicSlice) -> Int { s.size }

pub fn geo_proj_gnomonic_slice_get(s : GeoprojgnomonicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_slice_set(s : GeoprojgnomonicSlice, i : Int, v : Double) -> GeoprojgnomonicSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_slice_sum(s : GeoprojgnomonicSlice) -> Double { @_common.sum(s.data) }

pub fn geo_proj_gnomonic_slice_mean(s : GeoprojgnomonicSlice) -> Double { @_common.mean(s.data) }

pub fn geo_proj_gnomonic_slice_scale(s : GeoprojgnomonicSlice, f : Double) -> GeoprojgnomonicSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_slice_add(a : GeoprojgnomonicSlice, b : GeoprojgnomonicSlice) -> GeoprojgnomonicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_gnomonic_slice_copy(s : GeoprojgnomonicSlice) -> GeoprojgnomonicSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_slice_fill(s : GeoprojgnomonicSlice, v : Double) -> GeoprojgnomonicSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_gnomonic_slice_min(s : GeoprojgnomonicSlice) -> Double { @_common.min(s.data) }

pub fn geo_proj_gnomonic_slice_max(s : GeoprojgnomonicSlice) -> Double { @_common.max(s.data) }

pub fn geo_proj_gnomonic_slice_to_string(s : GeoprojgnomonicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

