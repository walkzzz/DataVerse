///===
/// extcore/geo_proj_cylindrical

pub(all) struct GeoprojcylindricalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_cylindrical_make_point(x : Double, y : Double) -> GeoprojcylindricalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_cylindrical_make_point3(x : Double, y : Double, z : Double) -> GeoprojcylindricalPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojcylindricalPoint::x(self : GeoprojcylindricalPoint) -> Double { self.x }

pub fn GeoprojcylindricalPoint::y(self : GeoprojcylindricalPoint) -> Double { self.y }

pub fn GeoprojcylindricalPoint::z(self : GeoprojcylindricalPoint) -> Double { self.z }

pub fn GeoprojcylindricalPoint::label(self : GeoprojcylindricalPoint) -> Int { self.label }

pub fn GeoprojcylindricalPoint::dist(self : GeoprojcylindricalPoint, other : GeoprojcylindricalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojcylindricalPoint::add(self : GeoprojcylindricalPoint, other : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojcylindricalPoint::sub(self : GeoprojcylindricalPoint, other : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojcylindricalPoint::scale(self : GeoprojcylindricalPoint, s : Double) -> GeoprojcylindricalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojcylindricalPoint::dot(self : GeoprojcylindricalPoint, other : GeoprojcylindricalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojcylindricalPoint::cross(self : GeoprojcylindricalPoint, other : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojcylindricalPoint::norm(self : GeoprojcylindricalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojcylindricalPoint::normalize(self : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojcylindricalPoint::negate(self : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojcylindricalPoint::mid(self : GeoprojcylindricalPoint, other : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojcylindricalPoint::lerp(self : GeoprojcylindricalPoint, other : GeoprojcylindricalPoint, t : Double) -> GeoprojcylindricalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojcylindricalPoint::to_string(self : GeoprojcylindricalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojcylindricalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_cylindrical_make_series(vals : Array[Double], name : String) -> GeoprojcylindricalSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojcylindricalSeries::len(self : GeoprojcylindricalSeries) -> Int { self.vals.length() }

pub fn GeoprojcylindricalSeries::sum(self : GeoprojcylindricalSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojcylindricalSeries::mean(self : GeoprojcylindricalSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojcylindricalSeries::min(self : GeoprojcylindricalSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojcylindricalSeries::max(self : GeoprojcylindricalSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojcylindricalSeries::range(self : GeoprojcylindricalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojcylindricalSeries::variance(self : GeoprojcylindricalSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojcylindricalSeries::std(self : GeoprojcylindricalSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojcylindricalSeries::median(self : GeoprojcylindricalSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojcylindricalSeries::scale(self : GeoprojcylindricalSeries, f : Double) -> GeoprojcylindricalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojcylindricalSeries::add(self : GeoprojcylindricalSeries, other : GeoprojcylindricalSeries) -> GeoprojcylindricalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojcylindricalSeries::sub(self : GeoprojcylindricalSeries, other : GeoprojcylindricalSeries) -> GeoprojcylindricalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojcylindricalSeries::normalize(self : GeoprojcylindricalSeries) -> GeoprojcylindricalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojcylindricalSeries::cumsum(self : GeoprojcylindricalSeries) -> GeoprojcylindricalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojcylindricalSeries::to_string(self : GeoprojcylindricalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojcylindricalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_cylindrical_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojcylindricalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_cylindrical_matrix_identity(n : Int) -> GeoprojcylindricalMatrix {
  let m = geo_proj_cylindrical_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojcylindricalMatrix::get(self : GeoprojcylindricalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojcylindricalMatrix::transpose(self : GeoprojcylindricalMatrix) -> GeoprojcylindricalMatrix {
  let result = geo_proj_cylindrical_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojcylindricalMatrix::add(self : GeoprojcylindricalMatrix, other : GeoprojcylindricalMatrix) -> GeoprojcylindricalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_cylindrical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojcylindricalMatrix::scale(self : GeoprojcylindricalMatrix, s : Double) -> GeoprojcylindricalMatrix {
  let result = geo_proj_cylindrical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojcylindricalMatrix::multiply(self : GeoprojcylindricalMatrix, other : GeoprojcylindricalMatrix) -> GeoprojcylindricalMatrix {
  if self.cols != other.rows { return geo_proj_cylindrical_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_cylindrical_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeoprojcylindricalMatrix::trace(self : GeoprojcylindricalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojcylindricalMatrix::det(self : GeoprojcylindricalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojcylindricalMatrix::norm(self : GeoprojcylindricalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojcylindricalMatrix::to_string(self : GeoprojcylindricalMatrix) -> String {
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

pub(all) struct GeoprojcylindricalVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_cylindrical_make_vector(comps : Array[Double]) -> GeoprojcylindricalVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_cylindrical_vector_zero(dim : Int) -> GeoprojcylindricalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojcylindricalVector::add(self : GeoprojcylindricalVector, other : GeoprojcylindricalVector) -> GeoprojcylindricalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojcylindricalVector::sub(self : GeoprojcylindricalVector, other : GeoprojcylindricalVector) -> GeoprojcylindricalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojcylindricalVector::scale(self : GeoprojcylindricalVector, s : Double) -> GeoprojcylindricalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojcylindricalVector::dot(self : GeoprojcylindricalVector, other : GeoprojcylindricalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojcylindricalVector::norm(self : GeoprojcylindricalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojcylindricalVector::normalize(self : GeoprojcylindricalVector) -> GeoprojcylindricalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojcylindricalVector::dist(self : GeoprojcylindricalVector, other : GeoprojcylindricalVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojcylindricalVector::to_string(self : GeoprojcylindricalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_cylindrical_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_cylindrical_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_cylindrical_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_cylindrical_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_cylindrical_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_cylindrical_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_cylindrical_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_cylindrical_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_cylindrical_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_cylindrical_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_cylindrical_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_cylindrical_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_cylindrical_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_cylindrical_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_cylindrical_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_cylindrical_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_cylindrical_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_cylindrical_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_cylindrical_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_cylindrical_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_cylindrical_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_cylindrical_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_cylindrical_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_cylindrical_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_cylindrical_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_cylindrical_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_cylindrical_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_cylindrical_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_cylindrical_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojcylindricalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_frame_make(size : Int) -> GeoprojcylindricalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_frame_len(s : GeoprojcylindricalFrame) -> Int { s.size }

pub fn geo_proj_cylindrical_frame_get(s : GeoprojcylindricalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_frame_set(s : GeoprojcylindricalFrame, i : Int, v : Double) -> GeoprojcylindricalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_frame_sum(s : GeoprojcylindricalFrame) -> Double { @_common.sum(s.data) }

pub fn geo_proj_cylindrical_frame_mean(s : GeoprojcylindricalFrame) -> Double { @_common.mean(s.data) }

pub fn geo_proj_cylindrical_frame_scale(s : GeoprojcylindricalFrame, f : Double) -> GeoprojcylindricalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_frame_add(a : GeoprojcylindricalFrame, b : GeoprojcylindricalFrame) -> GeoprojcylindricalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_cylindrical_frame_copy(s : GeoprojcylindricalFrame) -> GeoprojcylindricalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_frame_fill(s : GeoprojcylindricalFrame, v : Double) -> GeoprojcylindricalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_frame_min(s : GeoprojcylindricalFrame) -> Double { @_common.min(s.data) }

pub fn geo_proj_cylindrical_frame_max(s : GeoprojcylindricalFrame) -> Double { @_common.max(s.data) }

pub fn geo_proj_cylindrical_frame_to_string(s : GeoprojcylindricalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_table_make(size : Int) -> GeoprojcylindricalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_table_len(s : GeoprojcylindricalTable) -> Int { s.size }

pub fn geo_proj_cylindrical_table_get(s : GeoprojcylindricalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_table_set(s : GeoprojcylindricalTable, i : Int, v : Double) -> GeoprojcylindricalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_table_sum(s : GeoprojcylindricalTable) -> Double { @_common.sum(s.data) }

pub fn geo_proj_cylindrical_table_mean(s : GeoprojcylindricalTable) -> Double { @_common.mean(s.data) }

pub fn geo_proj_cylindrical_table_scale(s : GeoprojcylindricalTable, f : Double) -> GeoprojcylindricalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_table_add(a : GeoprojcylindricalTable, b : GeoprojcylindricalTable) -> GeoprojcylindricalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_cylindrical_table_copy(s : GeoprojcylindricalTable) -> GeoprojcylindricalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_table_fill(s : GeoprojcylindricalTable, v : Double) -> GeoprojcylindricalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_table_min(s : GeoprojcylindricalTable) -> Double { @_common.min(s.data) }

pub fn geo_proj_cylindrical_table_max(s : GeoprojcylindricalTable) -> Double { @_common.max(s.data) }

pub fn geo_proj_cylindrical_table_to_string(s : GeoprojcylindricalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_graphn_make(size : Int) -> GeoprojcylindricalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_graphn_len(s : GeoprojcylindricalGraphN) -> Int { s.size }

pub fn geo_proj_cylindrical_graphn_get(s : GeoprojcylindricalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_graphn_set(s : GeoprojcylindricalGraphN, i : Int, v : Double) -> GeoprojcylindricalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_graphn_sum(s : GeoprojcylindricalGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_proj_cylindrical_graphn_mean(s : GeoprojcylindricalGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_proj_cylindrical_graphn_scale(s : GeoprojcylindricalGraphN, f : Double) -> GeoprojcylindricalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_graphn_add(a : GeoprojcylindricalGraphN, b : GeoprojcylindricalGraphN) -> GeoprojcylindricalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_cylindrical_graphn_copy(s : GeoprojcylindricalGraphN) -> GeoprojcylindricalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_graphn_fill(s : GeoprojcylindricalGraphN, v : Double) -> GeoprojcylindricalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_graphn_min(s : GeoprojcylindricalGraphN) -> Double { @_common.min(s.data) }

pub fn geo_proj_cylindrical_graphn_max(s : GeoprojcylindricalGraphN) -> Double { @_common.max(s.data) }

pub fn geo_proj_cylindrical_graphn_to_string(s : GeoprojcylindricalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_node_make(size : Int) -> GeoprojcylindricalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_node_len(s : GeoprojcylindricalNode) -> Int { s.size }

pub fn geo_proj_cylindrical_node_get(s : GeoprojcylindricalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_node_set(s : GeoprojcylindricalNode, i : Int, v : Double) -> GeoprojcylindricalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_node_sum(s : GeoprojcylindricalNode) -> Double { @_common.sum(s.data) }

pub fn geo_proj_cylindrical_node_mean(s : GeoprojcylindricalNode) -> Double { @_common.mean(s.data) }

pub fn geo_proj_cylindrical_node_scale(s : GeoprojcylindricalNode, f : Double) -> GeoprojcylindricalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_node_add(a : GeoprojcylindricalNode, b : GeoprojcylindricalNode) -> GeoprojcylindricalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_cylindrical_node_copy(s : GeoprojcylindricalNode) -> GeoprojcylindricalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_node_fill(s : GeoprojcylindricalNode, v : Double) -> GeoprojcylindricalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_node_min(s : GeoprojcylindricalNode) -> Double { @_common.min(s.data) }

pub fn geo_proj_cylindrical_node_max(s : GeoprojcylindricalNode) -> Double { @_common.max(s.data) }

pub fn geo_proj_cylindrical_node_to_string(s : GeoprojcylindricalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_edge_make(size : Int) -> GeoprojcylindricalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_edge_len(s : GeoprojcylindricalEdge) -> Int { s.size }

pub fn geo_proj_cylindrical_edge_get(s : GeoprojcylindricalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_edge_set(s : GeoprojcylindricalEdge, i : Int, v : Double) -> GeoprojcylindricalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_edge_sum(s : GeoprojcylindricalEdge) -> Double { @_common.sum(s.data) }

pub fn geo_proj_cylindrical_edge_mean(s : GeoprojcylindricalEdge) -> Double { @_common.mean(s.data) }

pub fn geo_proj_cylindrical_edge_scale(s : GeoprojcylindricalEdge, f : Double) -> GeoprojcylindricalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_edge_add(a : GeoprojcylindricalEdge, b : GeoprojcylindricalEdge) -> GeoprojcylindricalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_cylindrical_edge_copy(s : GeoprojcylindricalEdge) -> GeoprojcylindricalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_edge_fill(s : GeoprojcylindricalEdge, v : Double) -> GeoprojcylindricalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_edge_min(s : GeoprojcylindricalEdge) -> Double { @_common.min(s.data) }

pub fn geo_proj_cylindrical_edge_max(s : GeoprojcylindricalEdge) -> Double { @_common.max(s.data) }

pub fn geo_proj_cylindrical_edge_to_string(s : GeoprojcylindricalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_path_make(size : Int) -> GeoprojcylindricalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_path_len(s : GeoprojcylindricalPath) -> Int { s.size }

pub fn geo_proj_cylindrical_path_get(s : GeoprojcylindricalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_path_set(s : GeoprojcylindricalPath, i : Int, v : Double) -> GeoprojcylindricalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_path_sum(s : GeoprojcylindricalPath) -> Double { @_common.sum(s.data) }

pub fn geo_proj_cylindrical_path_mean(s : GeoprojcylindricalPath) -> Double { @_common.mean(s.data) }

pub fn geo_proj_cylindrical_path_scale(s : GeoprojcylindricalPath, f : Double) -> GeoprojcylindricalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_path_add(a : GeoprojcylindricalPath, b : GeoprojcylindricalPath) -> GeoprojcylindricalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_cylindrical_path_copy(s : GeoprojcylindricalPath) -> GeoprojcylindricalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_path_fill(s : GeoprojcylindricalPath, v : Double) -> GeoprojcylindricalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_path_min(s : GeoprojcylindricalPath) -> Double { @_common.min(s.data) }

pub fn geo_proj_cylindrical_path_max(s : GeoprojcylindricalPath) -> Double { @_common.max(s.data) }

pub fn geo_proj_cylindrical_path_to_string(s : GeoprojcylindricalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_cluster_make(size : Int) -> GeoprojcylindricalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_cluster_len(s : GeoprojcylindricalCluster) -> Int { s.size }

pub fn geo_proj_cylindrical_cluster_get(s : GeoprojcylindricalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_cluster_set(s : GeoprojcylindricalCluster, i : Int, v : Double) -> GeoprojcylindricalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_cluster_sum(s : GeoprojcylindricalCluster) -> Double { @_common.sum(s.data) }

pub fn geo_proj_cylindrical_cluster_mean(s : GeoprojcylindricalCluster) -> Double { @_common.mean(s.data) }

pub fn geo_proj_cylindrical_cluster_scale(s : GeoprojcylindricalCluster, f : Double) -> GeoprojcylindricalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_cluster_add(a : GeoprojcylindricalCluster, b : GeoprojcylindricalCluster) -> GeoprojcylindricalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_cylindrical_cluster_copy(s : GeoprojcylindricalCluster) -> GeoprojcylindricalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_cluster_fill(s : GeoprojcylindricalCluster, v : Double) -> GeoprojcylindricalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_cluster_min(s : GeoprojcylindricalCluster) -> Double { @_common.min(s.data) }

pub fn geo_proj_cylindrical_cluster_max(s : GeoprojcylindricalCluster) -> Double { @_common.max(s.data) }

pub fn geo_proj_cylindrical_cluster_to_string(s : GeoprojcylindricalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_model_make(size : Int) -> GeoprojcylindricalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_model_len(s : GeoprojcylindricalModel) -> Int { s.size }

pub fn geo_proj_cylindrical_model_get(s : GeoprojcylindricalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_model_set(s : GeoprojcylindricalModel, i : Int, v : Double) -> GeoprojcylindricalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_model_sum(s : GeoprojcylindricalModel) -> Double { @_common.sum(s.data) }

pub fn geo_proj_cylindrical_model_mean(s : GeoprojcylindricalModel) -> Double { @_common.mean(s.data) }

pub fn geo_proj_cylindrical_model_scale(s : GeoprojcylindricalModel, f : Double) -> GeoprojcylindricalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_model_add(a : GeoprojcylindricalModel, b : GeoprojcylindricalModel) -> GeoprojcylindricalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_cylindrical_model_copy(s : GeoprojcylindricalModel) -> GeoprojcylindricalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_model_fill(s : GeoprojcylindricalModel, v : Double) -> GeoprojcylindricalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_model_min(s : GeoprojcylindricalModel) -> Double { @_common.min(s.data) }

pub fn geo_proj_cylindrical_model_max(s : GeoprojcylindricalModel) -> Double { @_common.max(s.data) }

pub fn geo_proj_cylindrical_model_to_string(s : GeoprojcylindricalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_layer_make(size : Int) -> GeoprojcylindricalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_layer_len(s : GeoprojcylindricalLayer) -> Int { s.size }

pub fn geo_proj_cylindrical_layer_get(s : GeoprojcylindricalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_layer_set(s : GeoprojcylindricalLayer, i : Int, v : Double) -> GeoprojcylindricalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_layer_sum(s : GeoprojcylindricalLayer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_cylindrical_layer_mean(s : GeoprojcylindricalLayer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_cylindrical_layer_scale(s : GeoprojcylindricalLayer, f : Double) -> GeoprojcylindricalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_layer_add(a : GeoprojcylindricalLayer, b : GeoprojcylindricalLayer) -> GeoprojcylindricalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_cylindrical_layer_copy(s : GeoprojcylindricalLayer) -> GeoprojcylindricalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_layer_fill(s : GeoprojcylindricalLayer, v : Double) -> GeoprojcylindricalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_layer_min(s : GeoprojcylindricalLayer) -> Double { @_common.min(s.data) }

pub fn geo_proj_cylindrical_layer_max(s : GeoprojcylindricalLayer) -> Double { @_common.max(s.data) }

pub fn geo_proj_cylindrical_layer_to_string(s : GeoprojcylindricalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_buffer_make(size : Int) -> GeoprojcylindricalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_buffer_len(s : GeoprojcylindricalBuffer) -> Int { s.size }

pub fn geo_proj_cylindrical_buffer_get(s : GeoprojcylindricalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_buffer_set(s : GeoprojcylindricalBuffer, i : Int, v : Double) -> GeoprojcylindricalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_buffer_sum(s : GeoprojcylindricalBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_cylindrical_buffer_mean(s : GeoprojcylindricalBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_cylindrical_buffer_scale(s : GeoprojcylindricalBuffer, f : Double) -> GeoprojcylindricalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_buffer_add(a : GeoprojcylindricalBuffer, b : GeoprojcylindricalBuffer) -> GeoprojcylindricalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_cylindrical_buffer_copy(s : GeoprojcylindricalBuffer) -> GeoprojcylindricalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_buffer_fill(s : GeoprojcylindricalBuffer, v : Double) -> GeoprojcylindricalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_buffer_min(s : GeoprojcylindricalBuffer) -> Double { @_common.min(s.data) }

pub fn geo_proj_cylindrical_buffer_max(s : GeoprojcylindricalBuffer) -> Double { @_common.max(s.data) }

pub fn geo_proj_cylindrical_buffer_to_string(s : GeoprojcylindricalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_cursor_make(size : Int) -> GeoprojcylindricalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_cursor_len(s : GeoprojcylindricalCursor) -> Int { s.size }

pub fn geo_proj_cylindrical_cursor_get(s : GeoprojcylindricalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_cursor_set(s : GeoprojcylindricalCursor, i : Int, v : Double) -> GeoprojcylindricalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_cursor_sum(s : GeoprojcylindricalCursor) -> Double { @_common.sum(s.data) }

pub fn geo_proj_cylindrical_cursor_mean(s : GeoprojcylindricalCursor) -> Double { @_common.mean(s.data) }

pub fn geo_proj_cylindrical_cursor_scale(s : GeoprojcylindricalCursor, f : Double) -> GeoprojcylindricalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_cursor_add(a : GeoprojcylindricalCursor, b : GeoprojcylindricalCursor) -> GeoprojcylindricalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_cylindrical_cursor_copy(s : GeoprojcylindricalCursor) -> GeoprojcylindricalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_cursor_fill(s : GeoprojcylindricalCursor, v : Double) -> GeoprojcylindricalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_cursor_min(s : GeoprojcylindricalCursor) -> Double { @_common.min(s.data) }

pub fn geo_proj_cylindrical_cursor_max(s : GeoprojcylindricalCursor) -> Double { @_common.max(s.data) }

pub fn geo_proj_cylindrical_cursor_to_string(s : GeoprojcylindricalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_view_make(size : Int) -> GeoprojcylindricalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_view_len(s : GeoprojcylindricalView) -> Int { s.size }

pub fn geo_proj_cylindrical_view_get(s : GeoprojcylindricalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_view_set(s : GeoprojcylindricalView, i : Int, v : Double) -> GeoprojcylindricalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_view_sum(s : GeoprojcylindricalView) -> Double { @_common.sum(s.data) }

pub fn geo_proj_cylindrical_view_mean(s : GeoprojcylindricalView) -> Double { @_common.mean(s.data) }

pub fn geo_proj_cylindrical_view_scale(s : GeoprojcylindricalView, f : Double) -> GeoprojcylindricalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_view_add(a : GeoprojcylindricalView, b : GeoprojcylindricalView) -> GeoprojcylindricalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_cylindrical_view_copy(s : GeoprojcylindricalView) -> GeoprojcylindricalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_view_fill(s : GeoprojcylindricalView, v : Double) -> GeoprojcylindricalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_view_min(s : GeoprojcylindricalView) -> Double { @_common.min(s.data) }

pub fn geo_proj_cylindrical_view_max(s : GeoprojcylindricalView) -> Double { @_common.max(s.data) }

pub fn geo_proj_cylindrical_view_to_string(s : GeoprojcylindricalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_range_make(size : Int) -> GeoprojcylindricalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_range_len(s : GeoprojcylindricalRange) -> Int { s.size }

pub fn geo_proj_cylindrical_range_get(s : GeoprojcylindricalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_range_set(s : GeoprojcylindricalRange, i : Int, v : Double) -> GeoprojcylindricalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_range_sum(s : GeoprojcylindricalRange) -> Double { @_common.sum(s.data) }

pub fn geo_proj_cylindrical_range_mean(s : GeoprojcylindricalRange) -> Double { @_common.mean(s.data) }

pub fn geo_proj_cylindrical_range_scale(s : GeoprojcylindricalRange, f : Double) -> GeoprojcylindricalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_range_add(a : GeoprojcylindricalRange, b : GeoprojcylindricalRange) -> GeoprojcylindricalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_cylindrical_range_copy(s : GeoprojcylindricalRange) -> GeoprojcylindricalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_range_fill(s : GeoprojcylindricalRange, v : Double) -> GeoprojcylindricalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_range_min(s : GeoprojcylindricalRange) -> Double { @_common.min(s.data) }

pub fn geo_proj_cylindrical_range_max(s : GeoprojcylindricalRange) -> Double { @_common.max(s.data) }

pub fn geo_proj_cylindrical_range_to_string(s : GeoprojcylindricalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_slice_make(size : Int) -> GeoprojcylindricalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_slice_len(s : GeoprojcylindricalSlice) -> Int { s.size }

pub fn geo_proj_cylindrical_slice_get(s : GeoprojcylindricalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_slice_set(s : GeoprojcylindricalSlice, i : Int, v : Double) -> GeoprojcylindricalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_slice_sum(s : GeoprojcylindricalSlice) -> Double { @_common.sum(s.data) }

pub fn geo_proj_cylindrical_slice_mean(s : GeoprojcylindricalSlice) -> Double { @_common.mean(s.data) }

pub fn geo_proj_cylindrical_slice_scale(s : GeoprojcylindricalSlice, f : Double) -> GeoprojcylindricalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_slice_add(a : GeoprojcylindricalSlice, b : GeoprojcylindricalSlice) -> GeoprojcylindricalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_cylindrical_slice_copy(s : GeoprojcylindricalSlice) -> GeoprojcylindricalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_slice_fill(s : GeoprojcylindricalSlice, v : Double) -> GeoprojcylindricalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_cylindrical_slice_min(s : GeoprojcylindricalSlice) -> Double { @_common.min(s.data) }

pub fn geo_proj_cylindrical_slice_max(s : GeoprojcylindricalSlice) -> Double { @_common.max(s.data) }

pub fn geo_proj_cylindrical_slice_to_string(s : GeoprojcylindricalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

