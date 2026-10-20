///===
/// extcore/geo_proj_stereographic

pub(all) struct GeoprojstereographicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_stereographic_make_point(x : Double, y : Double) -> GeoprojstereographicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_stereographic_make_point3(x : Double, y : Double, z : Double) -> GeoprojstereographicPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojstereographicPoint::x(self : GeoprojstereographicPoint) -> Double { self.x }

pub fn GeoprojstereographicPoint::y(self : GeoprojstereographicPoint) -> Double { self.y }

pub fn GeoprojstereographicPoint::z(self : GeoprojstereographicPoint) -> Double { self.z }

pub fn GeoprojstereographicPoint::label(self : GeoprojstereographicPoint) -> Int { self.label }

pub fn GeoprojstereographicPoint::dist(self : GeoprojstereographicPoint, other : GeoprojstereographicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojstereographicPoint::add(self : GeoprojstereographicPoint, other : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojstereographicPoint::sub(self : GeoprojstereographicPoint, other : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojstereographicPoint::scale(self : GeoprojstereographicPoint, s : Double) -> GeoprojstereographicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojstereographicPoint::dot(self : GeoprojstereographicPoint, other : GeoprojstereographicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojstereographicPoint::cross(self : GeoprojstereographicPoint, other : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojstereographicPoint::norm(self : GeoprojstereographicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojstereographicPoint::normalize(self : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojstereographicPoint::negate(self : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojstereographicPoint::mid(self : GeoprojstereographicPoint, other : GeoprojstereographicPoint) -> GeoprojstereographicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojstereographicPoint::lerp(self : GeoprojstereographicPoint, other : GeoprojstereographicPoint, t : Double) -> GeoprojstereographicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojstereographicPoint::to_string(self : GeoprojstereographicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojstereographicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_stereographic_make_series(vals : Array[Double], name : String) -> GeoprojstereographicSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojstereographicSeries::len(self : GeoprojstereographicSeries) -> Int { self.vals.length() }

pub fn GeoprojstereographicSeries::sum(self : GeoprojstereographicSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojstereographicSeries::mean(self : GeoprojstereographicSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojstereographicSeries::min(self : GeoprojstereographicSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojstereographicSeries::max(self : GeoprojstereographicSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojstereographicSeries::range(self : GeoprojstereographicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojstereographicSeries::variance(self : GeoprojstereographicSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojstereographicSeries::std(self : GeoprojstereographicSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojstereographicSeries::median(self : GeoprojstereographicSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojstereographicSeries::scale(self : GeoprojstereographicSeries, f : Double) -> GeoprojstereographicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojstereographicSeries::add(self : GeoprojstereographicSeries, other : GeoprojstereographicSeries) -> GeoprojstereographicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojstereographicSeries::sub(self : GeoprojstereographicSeries, other : GeoprojstereographicSeries) -> GeoprojstereographicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojstereographicSeries::normalize(self : GeoprojstereographicSeries) -> GeoprojstereographicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojstereographicSeries::cumsum(self : GeoprojstereographicSeries) -> GeoprojstereographicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojstereographicSeries::to_string(self : GeoprojstereographicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojstereographicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_stereographic_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojstereographicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_stereographic_matrix_identity(n : Int) -> GeoprojstereographicMatrix {
  let m = geo_proj_stereographic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojstereographicMatrix::get(self : GeoprojstereographicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojstereographicMatrix::transpose(self : GeoprojstereographicMatrix) -> GeoprojstereographicMatrix {
  let result = geo_proj_stereographic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojstereographicMatrix::add(self : GeoprojstereographicMatrix, other : GeoprojstereographicMatrix) -> GeoprojstereographicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_stereographic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojstereographicMatrix::scale(self : GeoprojstereographicMatrix, s : Double) -> GeoprojstereographicMatrix {
  let result = geo_proj_stereographic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojstereographicMatrix::multiply(self : GeoprojstereographicMatrix, other : GeoprojstereographicMatrix) -> GeoprojstereographicMatrix {
  if self.cols != other.rows { return geo_proj_stereographic_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_stereographic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeoprojstereographicMatrix::trace(self : GeoprojstereographicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojstereographicMatrix::det(self : GeoprojstereographicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojstereographicMatrix::norm(self : GeoprojstereographicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojstereographicMatrix::to_string(self : GeoprojstereographicMatrix) -> String {
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

pub(all) struct GeoprojstereographicVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_stereographic_make_vector(comps : Array[Double]) -> GeoprojstereographicVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_stereographic_vector_zero(dim : Int) -> GeoprojstereographicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojstereographicVector::add(self : GeoprojstereographicVector, other : GeoprojstereographicVector) -> GeoprojstereographicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojstereographicVector::sub(self : GeoprojstereographicVector, other : GeoprojstereographicVector) -> GeoprojstereographicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojstereographicVector::scale(self : GeoprojstereographicVector, s : Double) -> GeoprojstereographicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojstereographicVector::dot(self : GeoprojstereographicVector, other : GeoprojstereographicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojstereographicVector::norm(self : GeoprojstereographicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojstereographicVector::normalize(self : GeoprojstereographicVector) -> GeoprojstereographicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojstereographicVector::dist(self : GeoprojstereographicVector, other : GeoprojstereographicVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojstereographicVector::to_string(self : GeoprojstereographicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_stereographic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_stereographic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_stereographic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_stereographic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_stereographic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_stereographic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_stereographic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_stereographic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_stereographic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_stereographic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_stereographic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_stereographic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_stereographic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_stereographic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_stereographic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_stereographic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_stereographic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_stereographic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_stereographic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_stereographic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_stereographic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_stereographic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_stereographic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_stereographic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_stereographic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_stereographic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_stereographic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_stereographic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_stereographic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojstereographicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_frame_make(size : Int) -> GeoprojstereographicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_frame_len(s : GeoprojstereographicFrame) -> Int { s.size }

pub fn geo_proj_stereographic_frame_get(s : GeoprojstereographicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_frame_set(s : GeoprojstereographicFrame, i : Int, v : Double) -> GeoprojstereographicFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_frame_sum(s : GeoprojstereographicFrame) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_frame_mean(s : GeoprojstereographicFrame) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_frame_scale(s : GeoprojstereographicFrame, f : Double) -> GeoprojstereographicFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_frame_add(a : GeoprojstereographicFrame, b : GeoprojstereographicFrame) -> GeoprojstereographicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_frame_copy(s : GeoprojstereographicFrame) -> GeoprojstereographicFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_frame_fill(s : GeoprojstereographicFrame, v : Double) -> GeoprojstereographicFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_frame_min(s : GeoprojstereographicFrame) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_frame_max(s : GeoprojstereographicFrame) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_frame_to_string(s : GeoprojstereographicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_table_make(size : Int) -> GeoprojstereographicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_table_len(s : GeoprojstereographicTable) -> Int { s.size }

pub fn geo_proj_stereographic_table_get(s : GeoprojstereographicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_table_set(s : GeoprojstereographicTable, i : Int, v : Double) -> GeoprojstereographicTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_table_sum(s : GeoprojstereographicTable) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_table_mean(s : GeoprojstereographicTable) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_table_scale(s : GeoprojstereographicTable, f : Double) -> GeoprojstereographicTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_table_add(a : GeoprojstereographicTable, b : GeoprojstereographicTable) -> GeoprojstereographicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_table_copy(s : GeoprojstereographicTable) -> GeoprojstereographicTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_table_fill(s : GeoprojstereographicTable, v : Double) -> GeoprojstereographicTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_table_min(s : GeoprojstereographicTable) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_table_max(s : GeoprojstereographicTable) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_table_to_string(s : GeoprojstereographicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_graphn_make(size : Int) -> GeoprojstereographicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_graphn_len(s : GeoprojstereographicGraphN) -> Int { s.size }

pub fn geo_proj_stereographic_graphn_get(s : GeoprojstereographicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_graphn_set(s : GeoprojstereographicGraphN, i : Int, v : Double) -> GeoprojstereographicGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_graphn_sum(s : GeoprojstereographicGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_graphn_mean(s : GeoprojstereographicGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_graphn_scale(s : GeoprojstereographicGraphN, f : Double) -> GeoprojstereographicGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_graphn_add(a : GeoprojstereographicGraphN, b : GeoprojstereographicGraphN) -> GeoprojstereographicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_graphn_copy(s : GeoprojstereographicGraphN) -> GeoprojstereographicGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_graphn_fill(s : GeoprojstereographicGraphN, v : Double) -> GeoprojstereographicGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_graphn_min(s : GeoprojstereographicGraphN) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_graphn_max(s : GeoprojstereographicGraphN) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_graphn_to_string(s : GeoprojstereographicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_node_make(size : Int) -> GeoprojstereographicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_node_len(s : GeoprojstereographicNode) -> Int { s.size }

pub fn geo_proj_stereographic_node_get(s : GeoprojstereographicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_node_set(s : GeoprojstereographicNode, i : Int, v : Double) -> GeoprojstereographicNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_node_sum(s : GeoprojstereographicNode) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_node_mean(s : GeoprojstereographicNode) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_node_scale(s : GeoprojstereographicNode, f : Double) -> GeoprojstereographicNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_node_add(a : GeoprojstereographicNode, b : GeoprojstereographicNode) -> GeoprojstereographicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_node_copy(s : GeoprojstereographicNode) -> GeoprojstereographicNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_node_fill(s : GeoprojstereographicNode, v : Double) -> GeoprojstereographicNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_node_min(s : GeoprojstereographicNode) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_node_max(s : GeoprojstereographicNode) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_node_to_string(s : GeoprojstereographicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_edge_make(size : Int) -> GeoprojstereographicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_edge_len(s : GeoprojstereographicEdge) -> Int { s.size }

pub fn geo_proj_stereographic_edge_get(s : GeoprojstereographicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_edge_set(s : GeoprojstereographicEdge, i : Int, v : Double) -> GeoprojstereographicEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_edge_sum(s : GeoprojstereographicEdge) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_edge_mean(s : GeoprojstereographicEdge) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_edge_scale(s : GeoprojstereographicEdge, f : Double) -> GeoprojstereographicEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_edge_add(a : GeoprojstereographicEdge, b : GeoprojstereographicEdge) -> GeoprojstereographicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_edge_copy(s : GeoprojstereographicEdge) -> GeoprojstereographicEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_edge_fill(s : GeoprojstereographicEdge, v : Double) -> GeoprojstereographicEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_edge_min(s : GeoprojstereographicEdge) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_edge_max(s : GeoprojstereographicEdge) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_edge_to_string(s : GeoprojstereographicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_path_make(size : Int) -> GeoprojstereographicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_path_len(s : GeoprojstereographicPath) -> Int { s.size }

pub fn geo_proj_stereographic_path_get(s : GeoprojstereographicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_path_set(s : GeoprojstereographicPath, i : Int, v : Double) -> GeoprojstereographicPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_path_sum(s : GeoprojstereographicPath) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_path_mean(s : GeoprojstereographicPath) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_path_scale(s : GeoprojstereographicPath, f : Double) -> GeoprojstereographicPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_path_add(a : GeoprojstereographicPath, b : GeoprojstereographicPath) -> GeoprojstereographicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_path_copy(s : GeoprojstereographicPath) -> GeoprojstereographicPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_path_fill(s : GeoprojstereographicPath, v : Double) -> GeoprojstereographicPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_path_min(s : GeoprojstereographicPath) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_path_max(s : GeoprojstereographicPath) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_path_to_string(s : GeoprojstereographicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_cluster_make(size : Int) -> GeoprojstereographicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_cluster_len(s : GeoprojstereographicCluster) -> Int { s.size }

pub fn geo_proj_stereographic_cluster_get(s : GeoprojstereographicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_cluster_set(s : GeoprojstereographicCluster, i : Int, v : Double) -> GeoprojstereographicCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cluster_sum(s : GeoprojstereographicCluster) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_cluster_mean(s : GeoprojstereographicCluster) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_cluster_scale(s : GeoprojstereographicCluster, f : Double) -> GeoprojstereographicCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cluster_add(a : GeoprojstereographicCluster, b : GeoprojstereographicCluster) -> GeoprojstereographicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_cluster_copy(s : GeoprojstereographicCluster) -> GeoprojstereographicCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cluster_fill(s : GeoprojstereographicCluster, v : Double) -> GeoprojstereographicCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cluster_min(s : GeoprojstereographicCluster) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_cluster_max(s : GeoprojstereographicCluster) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_cluster_to_string(s : GeoprojstereographicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_model_make(size : Int) -> GeoprojstereographicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_model_len(s : GeoprojstereographicModel) -> Int { s.size }

pub fn geo_proj_stereographic_model_get(s : GeoprojstereographicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_model_set(s : GeoprojstereographicModel, i : Int, v : Double) -> GeoprojstereographicModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_model_sum(s : GeoprojstereographicModel) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_model_mean(s : GeoprojstereographicModel) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_model_scale(s : GeoprojstereographicModel, f : Double) -> GeoprojstereographicModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_model_add(a : GeoprojstereographicModel, b : GeoprojstereographicModel) -> GeoprojstereographicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_model_copy(s : GeoprojstereographicModel) -> GeoprojstereographicModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_model_fill(s : GeoprojstereographicModel, v : Double) -> GeoprojstereographicModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_model_min(s : GeoprojstereographicModel) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_model_max(s : GeoprojstereographicModel) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_model_to_string(s : GeoprojstereographicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_layer_make(size : Int) -> GeoprojstereographicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_layer_len(s : GeoprojstereographicLayer) -> Int { s.size }

pub fn geo_proj_stereographic_layer_get(s : GeoprojstereographicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_layer_set(s : GeoprojstereographicLayer, i : Int, v : Double) -> GeoprojstereographicLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_layer_sum(s : GeoprojstereographicLayer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_layer_mean(s : GeoprojstereographicLayer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_layer_scale(s : GeoprojstereographicLayer, f : Double) -> GeoprojstereographicLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_layer_add(a : GeoprojstereographicLayer, b : GeoprojstereographicLayer) -> GeoprojstereographicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_layer_copy(s : GeoprojstereographicLayer) -> GeoprojstereographicLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_layer_fill(s : GeoprojstereographicLayer, v : Double) -> GeoprojstereographicLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_layer_min(s : GeoprojstereographicLayer) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_layer_max(s : GeoprojstereographicLayer) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_layer_to_string(s : GeoprojstereographicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_buffer_make(size : Int) -> GeoprojstereographicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_buffer_len(s : GeoprojstereographicBuffer) -> Int { s.size }

pub fn geo_proj_stereographic_buffer_get(s : GeoprojstereographicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_buffer_set(s : GeoprojstereographicBuffer, i : Int, v : Double) -> GeoprojstereographicBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_buffer_sum(s : GeoprojstereographicBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_buffer_mean(s : GeoprojstereographicBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_buffer_scale(s : GeoprojstereographicBuffer, f : Double) -> GeoprojstereographicBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_buffer_add(a : GeoprojstereographicBuffer, b : GeoprojstereographicBuffer) -> GeoprojstereographicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_buffer_copy(s : GeoprojstereographicBuffer) -> GeoprojstereographicBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_buffer_fill(s : GeoprojstereographicBuffer, v : Double) -> GeoprojstereographicBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_buffer_min(s : GeoprojstereographicBuffer) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_buffer_max(s : GeoprojstereographicBuffer) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_buffer_to_string(s : GeoprojstereographicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_cursor_make(size : Int) -> GeoprojstereographicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_cursor_len(s : GeoprojstereographicCursor) -> Int { s.size }

pub fn geo_proj_stereographic_cursor_get(s : GeoprojstereographicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_cursor_set(s : GeoprojstereographicCursor, i : Int, v : Double) -> GeoprojstereographicCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cursor_sum(s : GeoprojstereographicCursor) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_cursor_mean(s : GeoprojstereographicCursor) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_cursor_scale(s : GeoprojstereographicCursor, f : Double) -> GeoprojstereographicCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cursor_add(a : GeoprojstereographicCursor, b : GeoprojstereographicCursor) -> GeoprojstereographicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_cursor_copy(s : GeoprojstereographicCursor) -> GeoprojstereographicCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cursor_fill(s : GeoprojstereographicCursor, v : Double) -> GeoprojstereographicCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_cursor_min(s : GeoprojstereographicCursor) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_cursor_max(s : GeoprojstereographicCursor) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_cursor_to_string(s : GeoprojstereographicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_view_make(size : Int) -> GeoprojstereographicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_view_len(s : GeoprojstereographicView) -> Int { s.size }

pub fn geo_proj_stereographic_view_get(s : GeoprojstereographicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_view_set(s : GeoprojstereographicView, i : Int, v : Double) -> GeoprojstereographicView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_view_sum(s : GeoprojstereographicView) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_view_mean(s : GeoprojstereographicView) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_view_scale(s : GeoprojstereographicView, f : Double) -> GeoprojstereographicView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_view_add(a : GeoprojstereographicView, b : GeoprojstereographicView) -> GeoprojstereographicView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_view_copy(s : GeoprojstereographicView) -> GeoprojstereographicView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_view_fill(s : GeoprojstereographicView, v : Double) -> GeoprojstereographicView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_view_min(s : GeoprojstereographicView) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_view_max(s : GeoprojstereographicView) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_view_to_string(s : GeoprojstereographicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_range_make(size : Int) -> GeoprojstereographicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_range_len(s : GeoprojstereographicRange) -> Int { s.size }

pub fn geo_proj_stereographic_range_get(s : GeoprojstereographicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_range_set(s : GeoprojstereographicRange, i : Int, v : Double) -> GeoprojstereographicRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_range_sum(s : GeoprojstereographicRange) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_range_mean(s : GeoprojstereographicRange) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_range_scale(s : GeoprojstereographicRange, f : Double) -> GeoprojstereographicRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_range_add(a : GeoprojstereographicRange, b : GeoprojstereographicRange) -> GeoprojstereographicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_range_copy(s : GeoprojstereographicRange) -> GeoprojstereographicRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_range_fill(s : GeoprojstereographicRange, v : Double) -> GeoprojstereographicRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_range_min(s : GeoprojstereographicRange) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_range_max(s : GeoprojstereographicRange) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_range_to_string(s : GeoprojstereographicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojstereographicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_stereographic_slice_make(size : Int) -> GeoprojstereographicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_stereographic_slice_len(s : GeoprojstereographicSlice) -> Int { s.size }

pub fn geo_proj_stereographic_slice_get(s : GeoprojstereographicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_stereographic_slice_set(s : GeoprojstereographicSlice, i : Int, v : Double) -> GeoprojstereographicSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_slice_sum(s : GeoprojstereographicSlice) -> Double { @_common.sum(s.data) }

pub fn geo_proj_stereographic_slice_mean(s : GeoprojstereographicSlice) -> Double { @_common.mean(s.data) }

pub fn geo_proj_stereographic_slice_scale(s : GeoprojstereographicSlice, f : Double) -> GeoprojstereographicSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_slice_add(a : GeoprojstereographicSlice, b : GeoprojstereographicSlice) -> GeoprojstereographicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_stereographic_slice_copy(s : GeoprojstereographicSlice) -> GeoprojstereographicSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_slice_fill(s : GeoprojstereographicSlice, v : Double) -> GeoprojstereographicSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_stereographic_slice_min(s : GeoprojstereographicSlice) -> Double { @_common.min(s.data) }

pub fn geo_proj_stereographic_slice_max(s : GeoprojstereographicSlice) -> Double { @_common.max(s.data) }

pub fn geo_proj_stereographic_slice_to_string(s : GeoprojstereographicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

