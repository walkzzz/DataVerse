///===
/// extcore/geo_dist_geodesic

pub(all) struct GeodistgeodesicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_geodesic_make_point(x : Double, y : Double) -> GeodistgeodesicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_geodesic_make_point3(x : Double, y : Double, z : Double) -> GeodistgeodesicPoint {
  { x, y, z, label: 0 }
}

pub fn GeodistgeodesicPoint::x(self : GeodistgeodesicPoint) -> Double { self.x }

pub fn GeodistgeodesicPoint::y(self : GeodistgeodesicPoint) -> Double { self.y }

pub fn GeodistgeodesicPoint::z(self : GeodistgeodesicPoint) -> Double { self.z }

pub fn GeodistgeodesicPoint::label(self : GeodistgeodesicPoint) -> Int { self.label }

pub fn GeodistgeodesicPoint::dist(self : GeodistgeodesicPoint, other : GeodistgeodesicPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeodistgeodesicPoint::add(self : GeodistgeodesicPoint, other : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeodistgeodesicPoint::sub(self : GeodistgeodesicPoint, other : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeodistgeodesicPoint::scale(self : GeodistgeodesicPoint, s : Double) -> GeodistgeodesicPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeodistgeodesicPoint::dot(self : GeodistgeodesicPoint, other : GeodistgeodesicPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeodistgeodesicPoint::cross(self : GeodistgeodesicPoint, other : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeodistgeodesicPoint::norm(self : GeodistgeodesicPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeodistgeodesicPoint::normalize(self : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistgeodesicPoint::negate(self : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeodistgeodesicPoint::mid(self : GeodistgeodesicPoint, other : GeodistgeodesicPoint) -> GeodistgeodesicPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeodistgeodesicPoint::lerp(self : GeodistgeodesicPoint, other : GeodistgeodesicPoint, t : Double) -> GeodistgeodesicPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeodistgeodesicPoint::to_string(self : GeodistgeodesicPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeodistgeodesicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_geodesic_make_series(vals : Array[Double], name : String) -> GeodistgeodesicSeries {
  { vals, name, meta: 0 }
}

pub fn GeodistgeodesicSeries::len(self : GeodistgeodesicSeries) -> Int { self.vals.length() }

pub fn GeodistgeodesicSeries::sum(self : GeodistgeodesicSeries) -> Double { @_common.sum(self.vals) }

pub fn GeodistgeodesicSeries::mean(self : GeodistgeodesicSeries) -> Double { @_common.mean(self.vals) }

pub fn GeodistgeodesicSeries::min(self : GeodistgeodesicSeries) -> Double { @_common.min(self.vals) }

pub fn GeodistgeodesicSeries::max(self : GeodistgeodesicSeries) -> Double { @_common.max(self.vals) }

pub fn GeodistgeodesicSeries::range(self : GeodistgeodesicSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeodistgeodesicSeries::variance(self : GeodistgeodesicSeries) -> Double { @_common.variance(self.vals) }

pub fn GeodistgeodesicSeries::std(self : GeodistgeodesicSeries) -> Double { @_common.std(self.vals) }

pub fn GeodistgeodesicSeries::median(self : GeodistgeodesicSeries) -> Double { @_common.median(self.vals) }

pub fn GeodistgeodesicSeries::scale(self : GeodistgeodesicSeries, f : Double) -> GeodistgeodesicSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeodistgeodesicSeries::add(self : GeodistgeodesicSeries, other : GeodistgeodesicSeries) -> GeodistgeodesicSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeodistgeodesicSeries::sub(self : GeodistgeodesicSeries, other : GeodistgeodesicSeries) -> GeodistgeodesicSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeodistgeodesicSeries::normalize(self : GeodistgeodesicSeries) -> GeodistgeodesicSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeodistgeodesicSeries::cumsum(self : GeodistgeodesicSeries) -> GeodistgeodesicSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeodistgeodesicSeries::to_string(self : GeodistgeodesicSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistgeodesicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_geodesic_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistgeodesicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_geodesic_matrix_identity(n : Int) -> GeodistgeodesicMatrix {
  let m = geo_dist_geodesic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeodistgeodesicMatrix::get(self : GeodistgeodesicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeodistgeodesicMatrix::transpose(self : GeodistgeodesicMatrix) -> GeodistgeodesicMatrix {
  let result = geo_dist_geodesic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeodistgeodesicMatrix::add(self : GeodistgeodesicMatrix, other : GeodistgeodesicMatrix) -> GeodistgeodesicMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_dist_geodesic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeodistgeodesicMatrix::scale(self : GeodistgeodesicMatrix, s : Double) -> GeodistgeodesicMatrix {
  let result = geo_dist_geodesic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeodistgeodesicMatrix::multiply(self : GeodistgeodesicMatrix, other : GeodistgeodesicMatrix) -> GeodistgeodesicMatrix {
  if self.cols != other.rows { return geo_dist_geodesic_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_dist_geodesic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeodistgeodesicMatrix::trace(self : GeodistgeodesicMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeodistgeodesicMatrix::det(self : GeodistgeodesicMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeodistgeodesicMatrix::norm(self : GeodistgeodesicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeodistgeodesicMatrix::to_string(self : GeodistgeodesicMatrix) -> String {
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

pub(all) struct GeodistgeodesicVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_geodesic_make_vector(comps : Array[Double]) -> GeodistgeodesicVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_geodesic_vector_zero(dim : Int) -> GeodistgeodesicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeodistgeodesicVector::add(self : GeodistgeodesicVector, other : GeodistgeodesicVector) -> GeodistgeodesicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistgeodesicVector::sub(self : GeodistgeodesicVector, other : GeodistgeodesicVector) -> GeodistgeodesicVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeodistgeodesicVector::scale(self : GeodistgeodesicVector, s : Double) -> GeodistgeodesicVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeodistgeodesicVector::dot(self : GeodistgeodesicVector, other : GeodistgeodesicVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeodistgeodesicVector::norm(self : GeodistgeodesicVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeodistgeodesicVector::normalize(self : GeodistgeodesicVector) -> GeodistgeodesicVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeodistgeodesicVector::dist(self : GeodistgeodesicVector, other : GeodistgeodesicVector) -> Double {
  self.sub(other).norm()
}

pub fn GeodistgeodesicVector::to_string(self : GeodistgeodesicVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_geodesic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_dist_geodesic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_dist_geodesic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_dist_geodesic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_dist_geodesic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_dist_geodesic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_dist_geodesic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_dist_geodesic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_dist_geodesic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_dist_geodesic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_dist_geodesic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_dist_geodesic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_dist_geodesic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_dist_geodesic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_dist_geodesic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_dist_geodesic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_dist_geodesic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_dist_geodesic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_dist_geodesic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_dist_geodesic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_dist_geodesic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_dist_geodesic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_dist_geodesic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_dist_geodesic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_dist_geodesic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_dist_geodesic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_dist_geodesic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_dist_geodesic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_dist_geodesic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeodistgeodesicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_frame_make(size : Int) -> GeodistgeodesicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_frame_len(s : GeodistgeodesicFrame) -> Int { s.size }

pub fn geo_dist_geodesic_frame_get(s : GeodistgeodesicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_frame_set(s : GeodistgeodesicFrame, i : Int, v : Double) -> GeodistgeodesicFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_frame_sum(s : GeodistgeodesicFrame) -> Double { @_common.sum(s.data) }

pub fn geo_dist_geodesic_frame_mean(s : GeodistgeodesicFrame) -> Double { @_common.mean(s.data) }

pub fn geo_dist_geodesic_frame_scale(s : GeodistgeodesicFrame, f : Double) -> GeodistgeodesicFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_frame_add(a : GeodistgeodesicFrame, b : GeodistgeodesicFrame) -> GeodistgeodesicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_geodesic_frame_copy(s : GeodistgeodesicFrame) -> GeodistgeodesicFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_frame_fill(s : GeodistgeodesicFrame, v : Double) -> GeodistgeodesicFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_frame_min(s : GeodistgeodesicFrame) -> Double { @_common.min(s.data) }

pub fn geo_dist_geodesic_frame_max(s : GeodistgeodesicFrame) -> Double { @_common.max(s.data) }

pub fn geo_dist_geodesic_frame_to_string(s : GeodistgeodesicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_table_make(size : Int) -> GeodistgeodesicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_table_len(s : GeodistgeodesicTable) -> Int { s.size }

pub fn geo_dist_geodesic_table_get(s : GeodistgeodesicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_table_set(s : GeodistgeodesicTable, i : Int, v : Double) -> GeodistgeodesicTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_table_sum(s : GeodistgeodesicTable) -> Double { @_common.sum(s.data) }

pub fn geo_dist_geodesic_table_mean(s : GeodistgeodesicTable) -> Double { @_common.mean(s.data) }

pub fn geo_dist_geodesic_table_scale(s : GeodistgeodesicTable, f : Double) -> GeodistgeodesicTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_table_add(a : GeodistgeodesicTable, b : GeodistgeodesicTable) -> GeodistgeodesicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_geodesic_table_copy(s : GeodistgeodesicTable) -> GeodistgeodesicTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_table_fill(s : GeodistgeodesicTable, v : Double) -> GeodistgeodesicTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_table_min(s : GeodistgeodesicTable) -> Double { @_common.min(s.data) }

pub fn geo_dist_geodesic_table_max(s : GeodistgeodesicTable) -> Double { @_common.max(s.data) }

pub fn geo_dist_geodesic_table_to_string(s : GeodistgeodesicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_graphn_make(size : Int) -> GeodistgeodesicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_graphn_len(s : GeodistgeodesicGraphN) -> Int { s.size }

pub fn geo_dist_geodesic_graphn_get(s : GeodistgeodesicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_graphn_set(s : GeodistgeodesicGraphN, i : Int, v : Double) -> GeodistgeodesicGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_graphn_sum(s : GeodistgeodesicGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_dist_geodesic_graphn_mean(s : GeodistgeodesicGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_dist_geodesic_graphn_scale(s : GeodistgeodesicGraphN, f : Double) -> GeodistgeodesicGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_graphn_add(a : GeodistgeodesicGraphN, b : GeodistgeodesicGraphN) -> GeodistgeodesicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_geodesic_graphn_copy(s : GeodistgeodesicGraphN) -> GeodistgeodesicGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_graphn_fill(s : GeodistgeodesicGraphN, v : Double) -> GeodistgeodesicGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_graphn_min(s : GeodistgeodesicGraphN) -> Double { @_common.min(s.data) }

pub fn geo_dist_geodesic_graphn_max(s : GeodistgeodesicGraphN) -> Double { @_common.max(s.data) }

pub fn geo_dist_geodesic_graphn_to_string(s : GeodistgeodesicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_node_make(size : Int) -> GeodistgeodesicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_node_len(s : GeodistgeodesicNode) -> Int { s.size }

pub fn geo_dist_geodesic_node_get(s : GeodistgeodesicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_node_set(s : GeodistgeodesicNode, i : Int, v : Double) -> GeodistgeodesicNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_node_sum(s : GeodistgeodesicNode) -> Double { @_common.sum(s.data) }

pub fn geo_dist_geodesic_node_mean(s : GeodistgeodesicNode) -> Double { @_common.mean(s.data) }

pub fn geo_dist_geodesic_node_scale(s : GeodistgeodesicNode, f : Double) -> GeodistgeodesicNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_node_add(a : GeodistgeodesicNode, b : GeodistgeodesicNode) -> GeodistgeodesicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_geodesic_node_copy(s : GeodistgeodesicNode) -> GeodistgeodesicNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_node_fill(s : GeodistgeodesicNode, v : Double) -> GeodistgeodesicNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_node_min(s : GeodistgeodesicNode) -> Double { @_common.min(s.data) }

pub fn geo_dist_geodesic_node_max(s : GeodistgeodesicNode) -> Double { @_common.max(s.data) }

pub fn geo_dist_geodesic_node_to_string(s : GeodistgeodesicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_edge_make(size : Int) -> GeodistgeodesicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_edge_len(s : GeodistgeodesicEdge) -> Int { s.size }

pub fn geo_dist_geodesic_edge_get(s : GeodistgeodesicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_edge_set(s : GeodistgeodesicEdge, i : Int, v : Double) -> GeodistgeodesicEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_edge_sum(s : GeodistgeodesicEdge) -> Double { @_common.sum(s.data) }

pub fn geo_dist_geodesic_edge_mean(s : GeodistgeodesicEdge) -> Double { @_common.mean(s.data) }

pub fn geo_dist_geodesic_edge_scale(s : GeodistgeodesicEdge, f : Double) -> GeodistgeodesicEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_edge_add(a : GeodistgeodesicEdge, b : GeodistgeodesicEdge) -> GeodistgeodesicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_geodesic_edge_copy(s : GeodistgeodesicEdge) -> GeodistgeodesicEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_edge_fill(s : GeodistgeodesicEdge, v : Double) -> GeodistgeodesicEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_edge_min(s : GeodistgeodesicEdge) -> Double { @_common.min(s.data) }

pub fn geo_dist_geodesic_edge_max(s : GeodistgeodesicEdge) -> Double { @_common.max(s.data) }

pub fn geo_dist_geodesic_edge_to_string(s : GeodistgeodesicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_path_make(size : Int) -> GeodistgeodesicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_path_len(s : GeodistgeodesicPath) -> Int { s.size }

pub fn geo_dist_geodesic_path_get(s : GeodistgeodesicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_path_set(s : GeodistgeodesicPath, i : Int, v : Double) -> GeodistgeodesicPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_path_sum(s : GeodistgeodesicPath) -> Double { @_common.sum(s.data) }

pub fn geo_dist_geodesic_path_mean(s : GeodistgeodesicPath) -> Double { @_common.mean(s.data) }

pub fn geo_dist_geodesic_path_scale(s : GeodistgeodesicPath, f : Double) -> GeodistgeodesicPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_path_add(a : GeodistgeodesicPath, b : GeodistgeodesicPath) -> GeodistgeodesicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_geodesic_path_copy(s : GeodistgeodesicPath) -> GeodistgeodesicPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_path_fill(s : GeodistgeodesicPath, v : Double) -> GeodistgeodesicPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_path_min(s : GeodistgeodesicPath) -> Double { @_common.min(s.data) }

pub fn geo_dist_geodesic_path_max(s : GeodistgeodesicPath) -> Double { @_common.max(s.data) }

pub fn geo_dist_geodesic_path_to_string(s : GeodistgeodesicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_cluster_make(size : Int) -> GeodistgeodesicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_cluster_len(s : GeodistgeodesicCluster) -> Int { s.size }

pub fn geo_dist_geodesic_cluster_get(s : GeodistgeodesicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_cluster_set(s : GeodistgeodesicCluster, i : Int, v : Double) -> GeodistgeodesicCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_cluster_sum(s : GeodistgeodesicCluster) -> Double { @_common.sum(s.data) }

pub fn geo_dist_geodesic_cluster_mean(s : GeodistgeodesicCluster) -> Double { @_common.mean(s.data) }

pub fn geo_dist_geodesic_cluster_scale(s : GeodistgeodesicCluster, f : Double) -> GeodistgeodesicCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_cluster_add(a : GeodistgeodesicCluster, b : GeodistgeodesicCluster) -> GeodistgeodesicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_geodesic_cluster_copy(s : GeodistgeodesicCluster) -> GeodistgeodesicCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_cluster_fill(s : GeodistgeodesicCluster, v : Double) -> GeodistgeodesicCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_cluster_min(s : GeodistgeodesicCluster) -> Double { @_common.min(s.data) }

pub fn geo_dist_geodesic_cluster_max(s : GeodistgeodesicCluster) -> Double { @_common.max(s.data) }

pub fn geo_dist_geodesic_cluster_to_string(s : GeodistgeodesicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_model_make(size : Int) -> GeodistgeodesicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_model_len(s : GeodistgeodesicModel) -> Int { s.size }

pub fn geo_dist_geodesic_model_get(s : GeodistgeodesicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_model_set(s : GeodistgeodesicModel, i : Int, v : Double) -> GeodistgeodesicModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_model_sum(s : GeodistgeodesicModel) -> Double { @_common.sum(s.data) }

pub fn geo_dist_geodesic_model_mean(s : GeodistgeodesicModel) -> Double { @_common.mean(s.data) }

pub fn geo_dist_geodesic_model_scale(s : GeodistgeodesicModel, f : Double) -> GeodistgeodesicModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_model_add(a : GeodistgeodesicModel, b : GeodistgeodesicModel) -> GeodistgeodesicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_geodesic_model_copy(s : GeodistgeodesicModel) -> GeodistgeodesicModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_model_fill(s : GeodistgeodesicModel, v : Double) -> GeodistgeodesicModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_model_min(s : GeodistgeodesicModel) -> Double { @_common.min(s.data) }

pub fn geo_dist_geodesic_model_max(s : GeodistgeodesicModel) -> Double { @_common.max(s.data) }

pub fn geo_dist_geodesic_model_to_string(s : GeodistgeodesicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_layer_make(size : Int) -> GeodistgeodesicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_layer_len(s : GeodistgeodesicLayer) -> Int { s.size }

pub fn geo_dist_geodesic_layer_get(s : GeodistgeodesicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_layer_set(s : GeodistgeodesicLayer, i : Int, v : Double) -> GeodistgeodesicLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_layer_sum(s : GeodistgeodesicLayer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_geodesic_layer_mean(s : GeodistgeodesicLayer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_geodesic_layer_scale(s : GeodistgeodesicLayer, f : Double) -> GeodistgeodesicLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_layer_add(a : GeodistgeodesicLayer, b : GeodistgeodesicLayer) -> GeodistgeodesicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_geodesic_layer_copy(s : GeodistgeodesicLayer) -> GeodistgeodesicLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_layer_fill(s : GeodistgeodesicLayer, v : Double) -> GeodistgeodesicLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_layer_min(s : GeodistgeodesicLayer) -> Double { @_common.min(s.data) }

pub fn geo_dist_geodesic_layer_max(s : GeodistgeodesicLayer) -> Double { @_common.max(s.data) }

pub fn geo_dist_geodesic_layer_to_string(s : GeodistgeodesicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_buffer_make(size : Int) -> GeodistgeodesicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_buffer_len(s : GeodistgeodesicBuffer) -> Int { s.size }

pub fn geo_dist_geodesic_buffer_get(s : GeodistgeodesicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_buffer_set(s : GeodistgeodesicBuffer, i : Int, v : Double) -> GeodistgeodesicBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_buffer_sum(s : GeodistgeodesicBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_dist_geodesic_buffer_mean(s : GeodistgeodesicBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_dist_geodesic_buffer_scale(s : GeodistgeodesicBuffer, f : Double) -> GeodistgeodesicBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_buffer_add(a : GeodistgeodesicBuffer, b : GeodistgeodesicBuffer) -> GeodistgeodesicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_geodesic_buffer_copy(s : GeodistgeodesicBuffer) -> GeodistgeodesicBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_buffer_fill(s : GeodistgeodesicBuffer, v : Double) -> GeodistgeodesicBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_buffer_min(s : GeodistgeodesicBuffer) -> Double { @_common.min(s.data) }

pub fn geo_dist_geodesic_buffer_max(s : GeodistgeodesicBuffer) -> Double { @_common.max(s.data) }

pub fn geo_dist_geodesic_buffer_to_string(s : GeodistgeodesicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_cursor_make(size : Int) -> GeodistgeodesicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_cursor_len(s : GeodistgeodesicCursor) -> Int { s.size }

pub fn geo_dist_geodesic_cursor_get(s : GeodistgeodesicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_cursor_set(s : GeodistgeodesicCursor, i : Int, v : Double) -> GeodistgeodesicCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_cursor_sum(s : GeodistgeodesicCursor) -> Double { @_common.sum(s.data) }

pub fn geo_dist_geodesic_cursor_mean(s : GeodistgeodesicCursor) -> Double { @_common.mean(s.data) }

pub fn geo_dist_geodesic_cursor_scale(s : GeodistgeodesicCursor, f : Double) -> GeodistgeodesicCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_cursor_add(a : GeodistgeodesicCursor, b : GeodistgeodesicCursor) -> GeodistgeodesicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_geodesic_cursor_copy(s : GeodistgeodesicCursor) -> GeodistgeodesicCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_cursor_fill(s : GeodistgeodesicCursor, v : Double) -> GeodistgeodesicCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_cursor_min(s : GeodistgeodesicCursor) -> Double { @_common.min(s.data) }

pub fn geo_dist_geodesic_cursor_max(s : GeodistgeodesicCursor) -> Double { @_common.max(s.data) }

pub fn geo_dist_geodesic_cursor_to_string(s : GeodistgeodesicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_view_make(size : Int) -> GeodistgeodesicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_view_len(s : GeodistgeodesicView) -> Int { s.size }

pub fn geo_dist_geodesic_view_get(s : GeodistgeodesicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_view_set(s : GeodistgeodesicView, i : Int, v : Double) -> GeodistgeodesicView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_view_sum(s : GeodistgeodesicView) -> Double { @_common.sum(s.data) }

pub fn geo_dist_geodesic_view_mean(s : GeodistgeodesicView) -> Double { @_common.mean(s.data) }

pub fn geo_dist_geodesic_view_scale(s : GeodistgeodesicView, f : Double) -> GeodistgeodesicView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_view_add(a : GeodistgeodesicView, b : GeodistgeodesicView) -> GeodistgeodesicView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_geodesic_view_copy(s : GeodistgeodesicView) -> GeodistgeodesicView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_view_fill(s : GeodistgeodesicView, v : Double) -> GeodistgeodesicView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_view_min(s : GeodistgeodesicView) -> Double { @_common.min(s.data) }

pub fn geo_dist_geodesic_view_max(s : GeodistgeodesicView) -> Double { @_common.max(s.data) }

pub fn geo_dist_geodesic_view_to_string(s : GeodistgeodesicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_range_make(size : Int) -> GeodistgeodesicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_range_len(s : GeodistgeodesicRange) -> Int { s.size }

pub fn geo_dist_geodesic_range_get(s : GeodistgeodesicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_range_set(s : GeodistgeodesicRange, i : Int, v : Double) -> GeodistgeodesicRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_range_sum(s : GeodistgeodesicRange) -> Double { @_common.sum(s.data) }

pub fn geo_dist_geodesic_range_mean(s : GeodistgeodesicRange) -> Double { @_common.mean(s.data) }

pub fn geo_dist_geodesic_range_scale(s : GeodistgeodesicRange, f : Double) -> GeodistgeodesicRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_range_add(a : GeodistgeodesicRange, b : GeodistgeodesicRange) -> GeodistgeodesicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_geodesic_range_copy(s : GeodistgeodesicRange) -> GeodistgeodesicRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_range_fill(s : GeodistgeodesicRange, v : Double) -> GeodistgeodesicRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_range_min(s : GeodistgeodesicRange) -> Double { @_common.min(s.data) }

pub fn geo_dist_geodesic_range_max(s : GeodistgeodesicRange) -> Double { @_common.max(s.data) }

pub fn geo_dist_geodesic_range_to_string(s : GeodistgeodesicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistgeodesicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_geodesic_slice_make(size : Int) -> GeodistgeodesicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_geodesic_slice_len(s : GeodistgeodesicSlice) -> Int { s.size }

pub fn geo_dist_geodesic_slice_get(s : GeodistgeodesicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_geodesic_slice_set(s : GeodistgeodesicSlice, i : Int, v : Double) -> GeodistgeodesicSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_slice_sum(s : GeodistgeodesicSlice) -> Double { @_common.sum(s.data) }

pub fn geo_dist_geodesic_slice_mean(s : GeodistgeodesicSlice) -> Double { @_common.mean(s.data) }

pub fn geo_dist_geodesic_slice_scale(s : GeodistgeodesicSlice, f : Double) -> GeodistgeodesicSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_slice_add(a : GeodistgeodesicSlice, b : GeodistgeodesicSlice) -> GeodistgeodesicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_dist_geodesic_slice_copy(s : GeodistgeodesicSlice) -> GeodistgeodesicSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_slice_fill(s : GeodistgeodesicSlice, v : Double) -> GeodistgeodesicSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_dist_geodesic_slice_min(s : GeodistgeodesicSlice) -> Double { @_common.min(s.data) }

pub fn geo_dist_geodesic_slice_max(s : GeodistgeodesicSlice) -> Double { @_common.max(s.data) }

pub fn geo_dist_geodesic_slice_to_string(s : GeodistgeodesicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

