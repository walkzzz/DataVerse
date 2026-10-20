///===
/// extcore/ml_cluster_dbscan

pub(all) struct MlclusterdbscanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_dbscan_make_point(x : Double, y : Double) -> MlclusterdbscanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_dbscan_make_point3(x : Double, y : Double, z : Double) -> MlclusterdbscanPoint {
  { x, y, z, label: 0 }
}

pub fn MlclusterdbscanPoint::x(self : MlclusterdbscanPoint) -> Double { self.x }

pub fn MlclusterdbscanPoint::y(self : MlclusterdbscanPoint) -> Double { self.y }

pub fn MlclusterdbscanPoint::z(self : MlclusterdbscanPoint) -> Double { self.z }

pub fn MlclusterdbscanPoint::label(self : MlclusterdbscanPoint) -> Int { self.label }

pub fn MlclusterdbscanPoint::dist(self : MlclusterdbscanPoint, other : MlclusterdbscanPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclusterdbscanPoint::add(self : MlclusterdbscanPoint, other : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclusterdbscanPoint::sub(self : MlclusterdbscanPoint, other : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclusterdbscanPoint::scale(self : MlclusterdbscanPoint, s : Double) -> MlclusterdbscanPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclusterdbscanPoint::dot(self : MlclusterdbscanPoint, other : MlclusterdbscanPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclusterdbscanPoint::cross(self : MlclusterdbscanPoint, other : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclusterdbscanPoint::norm(self : MlclusterdbscanPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclusterdbscanPoint::normalize(self : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterdbscanPoint::negate(self : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclusterdbscanPoint::mid(self : MlclusterdbscanPoint, other : MlclusterdbscanPoint) -> MlclusterdbscanPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclusterdbscanPoint::lerp(self : MlclusterdbscanPoint, other : MlclusterdbscanPoint, t : Double) -> MlclusterdbscanPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclusterdbscanPoint::to_string(self : MlclusterdbscanPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclusterdbscanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_dbscan_make_series(vals : Array[Double], name : String) -> MlclusterdbscanSeries {
  { vals, name, meta: 0 }
}

pub fn MlclusterdbscanSeries::len(self : MlclusterdbscanSeries) -> Int { self.vals.length() }

pub fn MlclusterdbscanSeries::sum(self : MlclusterdbscanSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclusterdbscanSeries::mean(self : MlclusterdbscanSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclusterdbscanSeries::min(self : MlclusterdbscanSeries) -> Double { @_common.min(self.vals) }

pub fn MlclusterdbscanSeries::max(self : MlclusterdbscanSeries) -> Double { @_common.max(self.vals) }

pub fn MlclusterdbscanSeries::range(self : MlclusterdbscanSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclusterdbscanSeries::variance(self : MlclusterdbscanSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclusterdbscanSeries::std(self : MlclusterdbscanSeries) -> Double { @_common.std(self.vals) }

pub fn MlclusterdbscanSeries::median(self : MlclusterdbscanSeries) -> Double { @_common.median(self.vals) }

pub fn MlclusterdbscanSeries::scale(self : MlclusterdbscanSeries, f : Double) -> MlclusterdbscanSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclusterdbscanSeries::add(self : MlclusterdbscanSeries, other : MlclusterdbscanSeries) -> MlclusterdbscanSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclusterdbscanSeries::sub(self : MlclusterdbscanSeries, other : MlclusterdbscanSeries) -> MlclusterdbscanSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclusterdbscanSeries::normalize(self : MlclusterdbscanSeries) -> MlclusterdbscanSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclusterdbscanSeries::cumsum(self : MlclusterdbscanSeries) -> MlclusterdbscanSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclusterdbscanSeries::to_string(self : MlclusterdbscanSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusterdbscanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_dbscan_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusterdbscanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_dbscan_matrix_identity(n : Int) -> MlclusterdbscanMatrix {
  let m = ml_cluster_dbscan_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclusterdbscanMatrix::get(self : MlclusterdbscanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclusterdbscanMatrix::transpose(self : MlclusterdbscanMatrix) -> MlclusterdbscanMatrix {
  let result = ml_cluster_dbscan_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclusterdbscanMatrix::add(self : MlclusterdbscanMatrix, other : MlclusterdbscanMatrix) -> MlclusterdbscanMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_dbscan_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclusterdbscanMatrix::scale(self : MlclusterdbscanMatrix, s : Double) -> MlclusterdbscanMatrix {
  let result = ml_cluster_dbscan_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclusterdbscanMatrix::multiply(self : MlclusterdbscanMatrix, other : MlclusterdbscanMatrix) -> MlclusterdbscanMatrix {
  if self.cols != other.rows { return ml_cluster_dbscan_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_dbscan_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclusterdbscanMatrix::trace(self : MlclusterdbscanMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclusterdbscanMatrix::det(self : MlclusterdbscanMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclusterdbscanMatrix::norm(self : MlclusterdbscanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclusterdbscanMatrix::to_string(self : MlclusterdbscanMatrix) -> String {
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

pub(all) struct MlclusterdbscanVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_dbscan_make_vector(comps : Array[Double]) -> MlclusterdbscanVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_dbscan_vector_zero(dim : Int) -> MlclusterdbscanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclusterdbscanVector::add(self : MlclusterdbscanVector, other : MlclusterdbscanVector) -> MlclusterdbscanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterdbscanVector::sub(self : MlclusterdbscanVector, other : MlclusterdbscanVector) -> MlclusterdbscanVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterdbscanVector::scale(self : MlclusterdbscanVector, s : Double) -> MlclusterdbscanVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclusterdbscanVector::dot(self : MlclusterdbscanVector, other : MlclusterdbscanVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclusterdbscanVector::norm(self : MlclusterdbscanVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclusterdbscanVector::normalize(self : MlclusterdbscanVector) -> MlclusterdbscanVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterdbscanVector::dist(self : MlclusterdbscanVector, other : MlclusterdbscanVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclusterdbscanVector::to_string(self : MlclusterdbscanVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_dbscan_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_dbscan_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_dbscan_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_dbscan_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_dbscan_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_dbscan_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_dbscan_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_dbscan_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_dbscan_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_dbscan_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_dbscan_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_dbscan_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_dbscan_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_dbscan_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_dbscan_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_dbscan_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_dbscan_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_dbscan_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_dbscan_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_dbscan_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_dbscan_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_dbscan_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_dbscan_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_dbscan_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_dbscan_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_dbscan_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_dbscan_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_dbscan_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_dbscan_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclusterdbscanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_frame_make(size : Int) -> MlclusterdbscanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_frame_len(s : MlclusterdbscanFrame) -> Int { s.size }

pub fn ml_cluster_dbscan_frame_get(s : MlclusterdbscanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_frame_set(s : MlclusterdbscanFrame, i : Int, v : Double) -> MlclusterdbscanFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_frame_sum(s : MlclusterdbscanFrame) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_dbscan_frame_mean(s : MlclusterdbscanFrame) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_dbscan_frame_scale(s : MlclusterdbscanFrame, f : Double) -> MlclusterdbscanFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_frame_add(a : MlclusterdbscanFrame, b : MlclusterdbscanFrame) -> MlclusterdbscanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_dbscan_frame_copy(s : MlclusterdbscanFrame) -> MlclusterdbscanFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_frame_fill(s : MlclusterdbscanFrame, v : Double) -> MlclusterdbscanFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_frame_min(s : MlclusterdbscanFrame) -> Double { @_common.min(s.data) }

pub fn ml_cluster_dbscan_frame_max(s : MlclusterdbscanFrame) -> Double { @_common.max(s.data) }

pub fn ml_cluster_dbscan_frame_to_string(s : MlclusterdbscanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_table_make(size : Int) -> MlclusterdbscanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_table_len(s : MlclusterdbscanTable) -> Int { s.size }

pub fn ml_cluster_dbscan_table_get(s : MlclusterdbscanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_table_set(s : MlclusterdbscanTable, i : Int, v : Double) -> MlclusterdbscanTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_table_sum(s : MlclusterdbscanTable) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_dbscan_table_mean(s : MlclusterdbscanTable) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_dbscan_table_scale(s : MlclusterdbscanTable, f : Double) -> MlclusterdbscanTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_table_add(a : MlclusterdbscanTable, b : MlclusterdbscanTable) -> MlclusterdbscanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_dbscan_table_copy(s : MlclusterdbscanTable) -> MlclusterdbscanTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_table_fill(s : MlclusterdbscanTable, v : Double) -> MlclusterdbscanTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_table_min(s : MlclusterdbscanTable) -> Double { @_common.min(s.data) }

pub fn ml_cluster_dbscan_table_max(s : MlclusterdbscanTable) -> Double { @_common.max(s.data) }

pub fn ml_cluster_dbscan_table_to_string(s : MlclusterdbscanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_graphn_make(size : Int) -> MlclusterdbscanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_graphn_len(s : MlclusterdbscanGraphN) -> Int { s.size }

pub fn ml_cluster_dbscan_graphn_get(s : MlclusterdbscanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_graphn_set(s : MlclusterdbscanGraphN, i : Int, v : Double) -> MlclusterdbscanGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_graphn_sum(s : MlclusterdbscanGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_dbscan_graphn_mean(s : MlclusterdbscanGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_dbscan_graphn_scale(s : MlclusterdbscanGraphN, f : Double) -> MlclusterdbscanGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_graphn_add(a : MlclusterdbscanGraphN, b : MlclusterdbscanGraphN) -> MlclusterdbscanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_dbscan_graphn_copy(s : MlclusterdbscanGraphN) -> MlclusterdbscanGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_graphn_fill(s : MlclusterdbscanGraphN, v : Double) -> MlclusterdbscanGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_graphn_min(s : MlclusterdbscanGraphN) -> Double { @_common.min(s.data) }

pub fn ml_cluster_dbscan_graphn_max(s : MlclusterdbscanGraphN) -> Double { @_common.max(s.data) }

pub fn ml_cluster_dbscan_graphn_to_string(s : MlclusterdbscanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_node_make(size : Int) -> MlclusterdbscanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_node_len(s : MlclusterdbscanNode) -> Int { s.size }

pub fn ml_cluster_dbscan_node_get(s : MlclusterdbscanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_node_set(s : MlclusterdbscanNode, i : Int, v : Double) -> MlclusterdbscanNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_node_sum(s : MlclusterdbscanNode) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_dbscan_node_mean(s : MlclusterdbscanNode) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_dbscan_node_scale(s : MlclusterdbscanNode, f : Double) -> MlclusterdbscanNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_node_add(a : MlclusterdbscanNode, b : MlclusterdbscanNode) -> MlclusterdbscanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_dbscan_node_copy(s : MlclusterdbscanNode) -> MlclusterdbscanNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_node_fill(s : MlclusterdbscanNode, v : Double) -> MlclusterdbscanNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_node_min(s : MlclusterdbscanNode) -> Double { @_common.min(s.data) }

pub fn ml_cluster_dbscan_node_max(s : MlclusterdbscanNode) -> Double { @_common.max(s.data) }

pub fn ml_cluster_dbscan_node_to_string(s : MlclusterdbscanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_edge_make(size : Int) -> MlclusterdbscanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_edge_len(s : MlclusterdbscanEdge) -> Int { s.size }

pub fn ml_cluster_dbscan_edge_get(s : MlclusterdbscanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_edge_set(s : MlclusterdbscanEdge, i : Int, v : Double) -> MlclusterdbscanEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_edge_sum(s : MlclusterdbscanEdge) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_dbscan_edge_mean(s : MlclusterdbscanEdge) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_dbscan_edge_scale(s : MlclusterdbscanEdge, f : Double) -> MlclusterdbscanEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_edge_add(a : MlclusterdbscanEdge, b : MlclusterdbscanEdge) -> MlclusterdbscanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_dbscan_edge_copy(s : MlclusterdbscanEdge) -> MlclusterdbscanEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_edge_fill(s : MlclusterdbscanEdge, v : Double) -> MlclusterdbscanEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_edge_min(s : MlclusterdbscanEdge) -> Double { @_common.min(s.data) }

pub fn ml_cluster_dbscan_edge_max(s : MlclusterdbscanEdge) -> Double { @_common.max(s.data) }

pub fn ml_cluster_dbscan_edge_to_string(s : MlclusterdbscanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_path_make(size : Int) -> MlclusterdbscanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_path_len(s : MlclusterdbscanPath) -> Int { s.size }

pub fn ml_cluster_dbscan_path_get(s : MlclusterdbscanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_path_set(s : MlclusterdbscanPath, i : Int, v : Double) -> MlclusterdbscanPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_path_sum(s : MlclusterdbscanPath) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_dbscan_path_mean(s : MlclusterdbscanPath) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_dbscan_path_scale(s : MlclusterdbscanPath, f : Double) -> MlclusterdbscanPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_path_add(a : MlclusterdbscanPath, b : MlclusterdbscanPath) -> MlclusterdbscanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_dbscan_path_copy(s : MlclusterdbscanPath) -> MlclusterdbscanPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_path_fill(s : MlclusterdbscanPath, v : Double) -> MlclusterdbscanPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_path_min(s : MlclusterdbscanPath) -> Double { @_common.min(s.data) }

pub fn ml_cluster_dbscan_path_max(s : MlclusterdbscanPath) -> Double { @_common.max(s.data) }

pub fn ml_cluster_dbscan_path_to_string(s : MlclusterdbscanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_cluster_make(size : Int) -> MlclusterdbscanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_cluster_len(s : MlclusterdbscanCluster) -> Int { s.size }

pub fn ml_cluster_dbscan_cluster_get(s : MlclusterdbscanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_cluster_set(s : MlclusterdbscanCluster, i : Int, v : Double) -> MlclusterdbscanCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_cluster_sum(s : MlclusterdbscanCluster) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_dbscan_cluster_mean(s : MlclusterdbscanCluster) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_dbscan_cluster_scale(s : MlclusterdbscanCluster, f : Double) -> MlclusterdbscanCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_cluster_add(a : MlclusterdbscanCluster, b : MlclusterdbscanCluster) -> MlclusterdbscanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_dbscan_cluster_copy(s : MlclusterdbscanCluster) -> MlclusterdbscanCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_cluster_fill(s : MlclusterdbscanCluster, v : Double) -> MlclusterdbscanCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_cluster_min(s : MlclusterdbscanCluster) -> Double { @_common.min(s.data) }

pub fn ml_cluster_dbscan_cluster_max(s : MlclusterdbscanCluster) -> Double { @_common.max(s.data) }

pub fn ml_cluster_dbscan_cluster_to_string(s : MlclusterdbscanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_model_make(size : Int) -> MlclusterdbscanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_model_len(s : MlclusterdbscanModel) -> Int { s.size }

pub fn ml_cluster_dbscan_model_get(s : MlclusterdbscanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_model_set(s : MlclusterdbscanModel, i : Int, v : Double) -> MlclusterdbscanModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_model_sum(s : MlclusterdbscanModel) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_dbscan_model_mean(s : MlclusterdbscanModel) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_dbscan_model_scale(s : MlclusterdbscanModel, f : Double) -> MlclusterdbscanModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_model_add(a : MlclusterdbscanModel, b : MlclusterdbscanModel) -> MlclusterdbscanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_dbscan_model_copy(s : MlclusterdbscanModel) -> MlclusterdbscanModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_model_fill(s : MlclusterdbscanModel, v : Double) -> MlclusterdbscanModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_model_min(s : MlclusterdbscanModel) -> Double { @_common.min(s.data) }

pub fn ml_cluster_dbscan_model_max(s : MlclusterdbscanModel) -> Double { @_common.max(s.data) }

pub fn ml_cluster_dbscan_model_to_string(s : MlclusterdbscanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_layer_make(size : Int) -> MlclusterdbscanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_layer_len(s : MlclusterdbscanLayer) -> Int { s.size }

pub fn ml_cluster_dbscan_layer_get(s : MlclusterdbscanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_layer_set(s : MlclusterdbscanLayer, i : Int, v : Double) -> MlclusterdbscanLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_layer_sum(s : MlclusterdbscanLayer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_dbscan_layer_mean(s : MlclusterdbscanLayer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_dbscan_layer_scale(s : MlclusterdbscanLayer, f : Double) -> MlclusterdbscanLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_layer_add(a : MlclusterdbscanLayer, b : MlclusterdbscanLayer) -> MlclusterdbscanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_dbscan_layer_copy(s : MlclusterdbscanLayer) -> MlclusterdbscanLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_layer_fill(s : MlclusterdbscanLayer, v : Double) -> MlclusterdbscanLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_layer_min(s : MlclusterdbscanLayer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_dbscan_layer_max(s : MlclusterdbscanLayer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_dbscan_layer_to_string(s : MlclusterdbscanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_buffer_make(size : Int) -> MlclusterdbscanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_buffer_len(s : MlclusterdbscanBuffer) -> Int { s.size }

pub fn ml_cluster_dbscan_buffer_get(s : MlclusterdbscanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_buffer_set(s : MlclusterdbscanBuffer, i : Int, v : Double) -> MlclusterdbscanBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_buffer_sum(s : MlclusterdbscanBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_dbscan_buffer_mean(s : MlclusterdbscanBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_dbscan_buffer_scale(s : MlclusterdbscanBuffer, f : Double) -> MlclusterdbscanBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_buffer_add(a : MlclusterdbscanBuffer, b : MlclusterdbscanBuffer) -> MlclusterdbscanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_dbscan_buffer_copy(s : MlclusterdbscanBuffer) -> MlclusterdbscanBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_buffer_fill(s : MlclusterdbscanBuffer, v : Double) -> MlclusterdbscanBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_buffer_min(s : MlclusterdbscanBuffer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_dbscan_buffer_max(s : MlclusterdbscanBuffer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_dbscan_buffer_to_string(s : MlclusterdbscanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_cursor_make(size : Int) -> MlclusterdbscanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_cursor_len(s : MlclusterdbscanCursor) -> Int { s.size }

pub fn ml_cluster_dbscan_cursor_get(s : MlclusterdbscanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_cursor_set(s : MlclusterdbscanCursor, i : Int, v : Double) -> MlclusterdbscanCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_cursor_sum(s : MlclusterdbscanCursor) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_dbscan_cursor_mean(s : MlclusterdbscanCursor) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_dbscan_cursor_scale(s : MlclusterdbscanCursor, f : Double) -> MlclusterdbscanCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_cursor_add(a : MlclusterdbscanCursor, b : MlclusterdbscanCursor) -> MlclusterdbscanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_dbscan_cursor_copy(s : MlclusterdbscanCursor) -> MlclusterdbscanCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_cursor_fill(s : MlclusterdbscanCursor, v : Double) -> MlclusterdbscanCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_cursor_min(s : MlclusterdbscanCursor) -> Double { @_common.min(s.data) }

pub fn ml_cluster_dbscan_cursor_max(s : MlclusterdbscanCursor) -> Double { @_common.max(s.data) }

pub fn ml_cluster_dbscan_cursor_to_string(s : MlclusterdbscanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_view_make(size : Int) -> MlclusterdbscanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_view_len(s : MlclusterdbscanView) -> Int { s.size }

pub fn ml_cluster_dbscan_view_get(s : MlclusterdbscanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_view_set(s : MlclusterdbscanView, i : Int, v : Double) -> MlclusterdbscanView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_view_sum(s : MlclusterdbscanView) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_dbscan_view_mean(s : MlclusterdbscanView) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_dbscan_view_scale(s : MlclusterdbscanView, f : Double) -> MlclusterdbscanView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_view_add(a : MlclusterdbscanView, b : MlclusterdbscanView) -> MlclusterdbscanView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_dbscan_view_copy(s : MlclusterdbscanView) -> MlclusterdbscanView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_view_fill(s : MlclusterdbscanView, v : Double) -> MlclusterdbscanView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_view_min(s : MlclusterdbscanView) -> Double { @_common.min(s.data) }

pub fn ml_cluster_dbscan_view_max(s : MlclusterdbscanView) -> Double { @_common.max(s.data) }

pub fn ml_cluster_dbscan_view_to_string(s : MlclusterdbscanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_range_make(size : Int) -> MlclusterdbscanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_range_len(s : MlclusterdbscanRange) -> Int { s.size }

pub fn ml_cluster_dbscan_range_get(s : MlclusterdbscanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_range_set(s : MlclusterdbscanRange, i : Int, v : Double) -> MlclusterdbscanRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_range_sum(s : MlclusterdbscanRange) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_dbscan_range_mean(s : MlclusterdbscanRange) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_dbscan_range_scale(s : MlclusterdbscanRange, f : Double) -> MlclusterdbscanRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_range_add(a : MlclusterdbscanRange, b : MlclusterdbscanRange) -> MlclusterdbscanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_dbscan_range_copy(s : MlclusterdbscanRange) -> MlclusterdbscanRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_range_fill(s : MlclusterdbscanRange, v : Double) -> MlclusterdbscanRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_range_min(s : MlclusterdbscanRange) -> Double { @_common.min(s.data) }

pub fn ml_cluster_dbscan_range_max(s : MlclusterdbscanRange) -> Double { @_common.max(s.data) }

pub fn ml_cluster_dbscan_range_to_string(s : MlclusterdbscanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterdbscanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_dbscan_slice_make(size : Int) -> MlclusterdbscanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_dbscan_slice_len(s : MlclusterdbscanSlice) -> Int { s.size }

pub fn ml_cluster_dbscan_slice_get(s : MlclusterdbscanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_dbscan_slice_set(s : MlclusterdbscanSlice, i : Int, v : Double) -> MlclusterdbscanSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_slice_sum(s : MlclusterdbscanSlice) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_dbscan_slice_mean(s : MlclusterdbscanSlice) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_dbscan_slice_scale(s : MlclusterdbscanSlice, f : Double) -> MlclusterdbscanSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_slice_add(a : MlclusterdbscanSlice, b : MlclusterdbscanSlice) -> MlclusterdbscanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_dbscan_slice_copy(s : MlclusterdbscanSlice) -> MlclusterdbscanSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_slice_fill(s : MlclusterdbscanSlice, v : Double) -> MlclusterdbscanSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_dbscan_slice_min(s : MlclusterdbscanSlice) -> Double { @_common.min(s.data) }

pub fn ml_cluster_dbscan_slice_max(s : MlclusterdbscanSlice) -> Double { @_common.max(s.data) }

pub fn ml_cluster_dbscan_slice_to_string(s : MlclusterdbscanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

