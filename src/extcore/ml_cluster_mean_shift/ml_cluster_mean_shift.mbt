///===
/// extcore/ml_cluster_mean_shift

pub(all) struct MlclustermeanshiftPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_mean_shift_make_point(x : Double, y : Double) -> MlclustermeanshiftPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_mean_shift_make_point3(x : Double, y : Double, z : Double) -> MlclustermeanshiftPoint {
  { x, y, z, label: 0 }
}

pub fn MlclustermeanshiftPoint::x(self : MlclustermeanshiftPoint) -> Double { self.x }

pub fn MlclustermeanshiftPoint::y(self : MlclustermeanshiftPoint) -> Double { self.y }

pub fn MlclustermeanshiftPoint::z(self : MlclustermeanshiftPoint) -> Double { self.z }

pub fn MlclustermeanshiftPoint::label(self : MlclustermeanshiftPoint) -> Int { self.label }

pub fn MlclustermeanshiftPoint::dist(self : MlclustermeanshiftPoint, other : MlclustermeanshiftPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclustermeanshiftPoint::add(self : MlclustermeanshiftPoint, other : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclustermeanshiftPoint::sub(self : MlclustermeanshiftPoint, other : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclustermeanshiftPoint::scale(self : MlclustermeanshiftPoint, s : Double) -> MlclustermeanshiftPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclustermeanshiftPoint::dot(self : MlclustermeanshiftPoint, other : MlclustermeanshiftPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclustermeanshiftPoint::cross(self : MlclustermeanshiftPoint, other : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclustermeanshiftPoint::norm(self : MlclustermeanshiftPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclustermeanshiftPoint::normalize(self : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclustermeanshiftPoint::negate(self : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclustermeanshiftPoint::mid(self : MlclustermeanshiftPoint, other : MlclustermeanshiftPoint) -> MlclustermeanshiftPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclustermeanshiftPoint::lerp(self : MlclustermeanshiftPoint, other : MlclustermeanshiftPoint, t : Double) -> MlclustermeanshiftPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclustermeanshiftPoint::to_string(self : MlclustermeanshiftPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclustermeanshiftSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_mean_shift_make_series(vals : Array[Double], name : String) -> MlclustermeanshiftSeries {
  { vals, name, meta: 0 }
}

pub fn MlclustermeanshiftSeries::len(self : MlclustermeanshiftSeries) -> Int { self.vals.length() }

pub fn MlclustermeanshiftSeries::sum(self : MlclustermeanshiftSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclustermeanshiftSeries::mean(self : MlclustermeanshiftSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclustermeanshiftSeries::min(self : MlclustermeanshiftSeries) -> Double { @_common.min(self.vals) }

pub fn MlclustermeanshiftSeries::max(self : MlclustermeanshiftSeries) -> Double { @_common.max(self.vals) }

pub fn MlclustermeanshiftSeries::range(self : MlclustermeanshiftSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclustermeanshiftSeries::variance(self : MlclustermeanshiftSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclustermeanshiftSeries::std(self : MlclustermeanshiftSeries) -> Double { @_common.std(self.vals) }

pub fn MlclustermeanshiftSeries::median(self : MlclustermeanshiftSeries) -> Double { @_common.median(self.vals) }

pub fn MlclustermeanshiftSeries::scale(self : MlclustermeanshiftSeries, f : Double) -> MlclustermeanshiftSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclustermeanshiftSeries::add(self : MlclustermeanshiftSeries, other : MlclustermeanshiftSeries) -> MlclustermeanshiftSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclustermeanshiftSeries::sub(self : MlclustermeanshiftSeries, other : MlclustermeanshiftSeries) -> MlclustermeanshiftSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclustermeanshiftSeries::normalize(self : MlclustermeanshiftSeries) -> MlclustermeanshiftSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclustermeanshiftSeries::cumsum(self : MlclustermeanshiftSeries) -> MlclustermeanshiftSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclustermeanshiftSeries::to_string(self : MlclustermeanshiftSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclustermeanshiftMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_mean_shift_make_matrix(rows : Int, cols : Int, val : Double) -> MlclustermeanshiftMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_mean_shift_matrix_identity(n : Int) -> MlclustermeanshiftMatrix {
  let m = ml_cluster_mean_shift_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclustermeanshiftMatrix::get(self : MlclustermeanshiftMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclustermeanshiftMatrix::transpose(self : MlclustermeanshiftMatrix) -> MlclustermeanshiftMatrix {
  let result = ml_cluster_mean_shift_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclustermeanshiftMatrix::add(self : MlclustermeanshiftMatrix, other : MlclustermeanshiftMatrix) -> MlclustermeanshiftMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_mean_shift_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclustermeanshiftMatrix::scale(self : MlclustermeanshiftMatrix, s : Double) -> MlclustermeanshiftMatrix {
  let result = ml_cluster_mean_shift_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclustermeanshiftMatrix::multiply(self : MlclustermeanshiftMatrix, other : MlclustermeanshiftMatrix) -> MlclustermeanshiftMatrix {
  if self.cols != other.rows { return ml_cluster_mean_shift_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_mean_shift_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclustermeanshiftMatrix::trace(self : MlclustermeanshiftMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclustermeanshiftMatrix::det(self : MlclustermeanshiftMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclustermeanshiftMatrix::norm(self : MlclustermeanshiftMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclustermeanshiftMatrix::to_string(self : MlclustermeanshiftMatrix) -> String {
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

pub(all) struct MlclustermeanshiftVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_mean_shift_make_vector(comps : Array[Double]) -> MlclustermeanshiftVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_mean_shift_vector_zero(dim : Int) -> MlclustermeanshiftVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclustermeanshiftVector::add(self : MlclustermeanshiftVector, other : MlclustermeanshiftVector) -> MlclustermeanshiftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclustermeanshiftVector::sub(self : MlclustermeanshiftVector, other : MlclustermeanshiftVector) -> MlclustermeanshiftVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclustermeanshiftVector::scale(self : MlclustermeanshiftVector, s : Double) -> MlclustermeanshiftVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclustermeanshiftVector::dot(self : MlclustermeanshiftVector, other : MlclustermeanshiftVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclustermeanshiftVector::norm(self : MlclustermeanshiftVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclustermeanshiftVector::normalize(self : MlclustermeanshiftVector) -> MlclustermeanshiftVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclustermeanshiftVector::dist(self : MlclustermeanshiftVector, other : MlclustermeanshiftVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclustermeanshiftVector::to_string(self : MlclustermeanshiftVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_mean_shift_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_mean_shift_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_mean_shift_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_mean_shift_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_mean_shift_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_mean_shift_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_mean_shift_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_mean_shift_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_mean_shift_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_mean_shift_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_mean_shift_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_mean_shift_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_mean_shift_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_mean_shift_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_mean_shift_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_mean_shift_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_mean_shift_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_mean_shift_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_mean_shift_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_mean_shift_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_mean_shift_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_mean_shift_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_mean_shift_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_mean_shift_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_mean_shift_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_mean_shift_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_mean_shift_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_mean_shift_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_mean_shift_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclustermeanshiftFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_frame_make(size : Int) -> MlclustermeanshiftFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_frame_len(s : MlclustermeanshiftFrame) -> Int { s.size }

pub fn ml_cluster_mean_shift_frame_get(s : MlclustermeanshiftFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_frame_set(s : MlclustermeanshiftFrame, i : Int, v : Double) -> MlclustermeanshiftFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_frame_sum(s : MlclustermeanshiftFrame) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_mean_shift_frame_mean(s : MlclustermeanshiftFrame) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_mean_shift_frame_scale(s : MlclustermeanshiftFrame, f : Double) -> MlclustermeanshiftFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_frame_add(a : MlclustermeanshiftFrame, b : MlclustermeanshiftFrame) -> MlclustermeanshiftFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_mean_shift_frame_copy(s : MlclustermeanshiftFrame) -> MlclustermeanshiftFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_frame_fill(s : MlclustermeanshiftFrame, v : Double) -> MlclustermeanshiftFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_frame_min(s : MlclustermeanshiftFrame) -> Double { @_common.min(s.data) }

pub fn ml_cluster_mean_shift_frame_max(s : MlclustermeanshiftFrame) -> Double { @_common.max(s.data) }

pub fn ml_cluster_mean_shift_frame_to_string(s : MlclustermeanshiftFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_table_make(size : Int) -> MlclustermeanshiftTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_table_len(s : MlclustermeanshiftTable) -> Int { s.size }

pub fn ml_cluster_mean_shift_table_get(s : MlclustermeanshiftTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_table_set(s : MlclustermeanshiftTable, i : Int, v : Double) -> MlclustermeanshiftTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_table_sum(s : MlclustermeanshiftTable) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_mean_shift_table_mean(s : MlclustermeanshiftTable) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_mean_shift_table_scale(s : MlclustermeanshiftTable, f : Double) -> MlclustermeanshiftTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_table_add(a : MlclustermeanshiftTable, b : MlclustermeanshiftTable) -> MlclustermeanshiftTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_mean_shift_table_copy(s : MlclustermeanshiftTable) -> MlclustermeanshiftTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_table_fill(s : MlclustermeanshiftTable, v : Double) -> MlclustermeanshiftTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_table_min(s : MlclustermeanshiftTable) -> Double { @_common.min(s.data) }

pub fn ml_cluster_mean_shift_table_max(s : MlclustermeanshiftTable) -> Double { @_common.max(s.data) }

pub fn ml_cluster_mean_shift_table_to_string(s : MlclustermeanshiftTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_graphn_make(size : Int) -> MlclustermeanshiftGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_graphn_len(s : MlclustermeanshiftGraphN) -> Int { s.size }

pub fn ml_cluster_mean_shift_graphn_get(s : MlclustermeanshiftGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_graphn_set(s : MlclustermeanshiftGraphN, i : Int, v : Double) -> MlclustermeanshiftGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_graphn_sum(s : MlclustermeanshiftGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_mean_shift_graphn_mean(s : MlclustermeanshiftGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_mean_shift_graphn_scale(s : MlclustermeanshiftGraphN, f : Double) -> MlclustermeanshiftGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_graphn_add(a : MlclustermeanshiftGraphN, b : MlclustermeanshiftGraphN) -> MlclustermeanshiftGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_mean_shift_graphn_copy(s : MlclustermeanshiftGraphN) -> MlclustermeanshiftGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_graphn_fill(s : MlclustermeanshiftGraphN, v : Double) -> MlclustermeanshiftGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_graphn_min(s : MlclustermeanshiftGraphN) -> Double { @_common.min(s.data) }

pub fn ml_cluster_mean_shift_graphn_max(s : MlclustermeanshiftGraphN) -> Double { @_common.max(s.data) }

pub fn ml_cluster_mean_shift_graphn_to_string(s : MlclustermeanshiftGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_node_make(size : Int) -> MlclustermeanshiftNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_node_len(s : MlclustermeanshiftNode) -> Int { s.size }

pub fn ml_cluster_mean_shift_node_get(s : MlclustermeanshiftNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_node_set(s : MlclustermeanshiftNode, i : Int, v : Double) -> MlclustermeanshiftNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_node_sum(s : MlclustermeanshiftNode) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_mean_shift_node_mean(s : MlclustermeanshiftNode) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_mean_shift_node_scale(s : MlclustermeanshiftNode, f : Double) -> MlclustermeanshiftNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_node_add(a : MlclustermeanshiftNode, b : MlclustermeanshiftNode) -> MlclustermeanshiftNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_mean_shift_node_copy(s : MlclustermeanshiftNode) -> MlclustermeanshiftNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_node_fill(s : MlclustermeanshiftNode, v : Double) -> MlclustermeanshiftNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_node_min(s : MlclustermeanshiftNode) -> Double { @_common.min(s.data) }

pub fn ml_cluster_mean_shift_node_max(s : MlclustermeanshiftNode) -> Double { @_common.max(s.data) }

pub fn ml_cluster_mean_shift_node_to_string(s : MlclustermeanshiftNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_edge_make(size : Int) -> MlclustermeanshiftEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_edge_len(s : MlclustermeanshiftEdge) -> Int { s.size }

pub fn ml_cluster_mean_shift_edge_get(s : MlclustermeanshiftEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_edge_set(s : MlclustermeanshiftEdge, i : Int, v : Double) -> MlclustermeanshiftEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_edge_sum(s : MlclustermeanshiftEdge) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_mean_shift_edge_mean(s : MlclustermeanshiftEdge) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_mean_shift_edge_scale(s : MlclustermeanshiftEdge, f : Double) -> MlclustermeanshiftEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_edge_add(a : MlclustermeanshiftEdge, b : MlclustermeanshiftEdge) -> MlclustermeanshiftEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_mean_shift_edge_copy(s : MlclustermeanshiftEdge) -> MlclustermeanshiftEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_edge_fill(s : MlclustermeanshiftEdge, v : Double) -> MlclustermeanshiftEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_edge_min(s : MlclustermeanshiftEdge) -> Double { @_common.min(s.data) }

pub fn ml_cluster_mean_shift_edge_max(s : MlclustermeanshiftEdge) -> Double { @_common.max(s.data) }

pub fn ml_cluster_mean_shift_edge_to_string(s : MlclustermeanshiftEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_path_make(size : Int) -> MlclustermeanshiftPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_path_len(s : MlclustermeanshiftPath) -> Int { s.size }

pub fn ml_cluster_mean_shift_path_get(s : MlclustermeanshiftPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_path_set(s : MlclustermeanshiftPath, i : Int, v : Double) -> MlclustermeanshiftPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_path_sum(s : MlclustermeanshiftPath) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_mean_shift_path_mean(s : MlclustermeanshiftPath) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_mean_shift_path_scale(s : MlclustermeanshiftPath, f : Double) -> MlclustermeanshiftPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_path_add(a : MlclustermeanshiftPath, b : MlclustermeanshiftPath) -> MlclustermeanshiftPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_mean_shift_path_copy(s : MlclustermeanshiftPath) -> MlclustermeanshiftPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_path_fill(s : MlclustermeanshiftPath, v : Double) -> MlclustermeanshiftPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_path_min(s : MlclustermeanshiftPath) -> Double { @_common.min(s.data) }

pub fn ml_cluster_mean_shift_path_max(s : MlclustermeanshiftPath) -> Double { @_common.max(s.data) }

pub fn ml_cluster_mean_shift_path_to_string(s : MlclustermeanshiftPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_cluster_make(size : Int) -> MlclustermeanshiftCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_cluster_len(s : MlclustermeanshiftCluster) -> Int { s.size }

pub fn ml_cluster_mean_shift_cluster_get(s : MlclustermeanshiftCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_cluster_set(s : MlclustermeanshiftCluster, i : Int, v : Double) -> MlclustermeanshiftCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_cluster_sum(s : MlclustermeanshiftCluster) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_mean_shift_cluster_mean(s : MlclustermeanshiftCluster) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_mean_shift_cluster_scale(s : MlclustermeanshiftCluster, f : Double) -> MlclustermeanshiftCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_cluster_add(a : MlclustermeanshiftCluster, b : MlclustermeanshiftCluster) -> MlclustermeanshiftCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_mean_shift_cluster_copy(s : MlclustermeanshiftCluster) -> MlclustermeanshiftCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_cluster_fill(s : MlclustermeanshiftCluster, v : Double) -> MlclustermeanshiftCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_cluster_min(s : MlclustermeanshiftCluster) -> Double { @_common.min(s.data) }

pub fn ml_cluster_mean_shift_cluster_max(s : MlclustermeanshiftCluster) -> Double { @_common.max(s.data) }

pub fn ml_cluster_mean_shift_cluster_to_string(s : MlclustermeanshiftCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_model_make(size : Int) -> MlclustermeanshiftModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_model_len(s : MlclustermeanshiftModel) -> Int { s.size }

pub fn ml_cluster_mean_shift_model_get(s : MlclustermeanshiftModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_model_set(s : MlclustermeanshiftModel, i : Int, v : Double) -> MlclustermeanshiftModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_model_sum(s : MlclustermeanshiftModel) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_mean_shift_model_mean(s : MlclustermeanshiftModel) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_mean_shift_model_scale(s : MlclustermeanshiftModel, f : Double) -> MlclustermeanshiftModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_model_add(a : MlclustermeanshiftModel, b : MlclustermeanshiftModel) -> MlclustermeanshiftModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_mean_shift_model_copy(s : MlclustermeanshiftModel) -> MlclustermeanshiftModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_model_fill(s : MlclustermeanshiftModel, v : Double) -> MlclustermeanshiftModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_model_min(s : MlclustermeanshiftModel) -> Double { @_common.min(s.data) }

pub fn ml_cluster_mean_shift_model_max(s : MlclustermeanshiftModel) -> Double { @_common.max(s.data) }

pub fn ml_cluster_mean_shift_model_to_string(s : MlclustermeanshiftModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_layer_make(size : Int) -> MlclustermeanshiftLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_layer_len(s : MlclustermeanshiftLayer) -> Int { s.size }

pub fn ml_cluster_mean_shift_layer_get(s : MlclustermeanshiftLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_layer_set(s : MlclustermeanshiftLayer, i : Int, v : Double) -> MlclustermeanshiftLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_layer_sum(s : MlclustermeanshiftLayer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_mean_shift_layer_mean(s : MlclustermeanshiftLayer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_mean_shift_layer_scale(s : MlclustermeanshiftLayer, f : Double) -> MlclustermeanshiftLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_layer_add(a : MlclustermeanshiftLayer, b : MlclustermeanshiftLayer) -> MlclustermeanshiftLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_mean_shift_layer_copy(s : MlclustermeanshiftLayer) -> MlclustermeanshiftLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_layer_fill(s : MlclustermeanshiftLayer, v : Double) -> MlclustermeanshiftLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_layer_min(s : MlclustermeanshiftLayer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_mean_shift_layer_max(s : MlclustermeanshiftLayer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_mean_shift_layer_to_string(s : MlclustermeanshiftLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_buffer_make(size : Int) -> MlclustermeanshiftBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_buffer_len(s : MlclustermeanshiftBuffer) -> Int { s.size }

pub fn ml_cluster_mean_shift_buffer_get(s : MlclustermeanshiftBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_buffer_set(s : MlclustermeanshiftBuffer, i : Int, v : Double) -> MlclustermeanshiftBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_buffer_sum(s : MlclustermeanshiftBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_mean_shift_buffer_mean(s : MlclustermeanshiftBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_mean_shift_buffer_scale(s : MlclustermeanshiftBuffer, f : Double) -> MlclustermeanshiftBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_buffer_add(a : MlclustermeanshiftBuffer, b : MlclustermeanshiftBuffer) -> MlclustermeanshiftBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_mean_shift_buffer_copy(s : MlclustermeanshiftBuffer) -> MlclustermeanshiftBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_buffer_fill(s : MlclustermeanshiftBuffer, v : Double) -> MlclustermeanshiftBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_buffer_min(s : MlclustermeanshiftBuffer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_mean_shift_buffer_max(s : MlclustermeanshiftBuffer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_mean_shift_buffer_to_string(s : MlclustermeanshiftBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_cursor_make(size : Int) -> MlclustermeanshiftCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_cursor_len(s : MlclustermeanshiftCursor) -> Int { s.size }

pub fn ml_cluster_mean_shift_cursor_get(s : MlclustermeanshiftCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_cursor_set(s : MlclustermeanshiftCursor, i : Int, v : Double) -> MlclustermeanshiftCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_cursor_sum(s : MlclustermeanshiftCursor) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_mean_shift_cursor_mean(s : MlclustermeanshiftCursor) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_mean_shift_cursor_scale(s : MlclustermeanshiftCursor, f : Double) -> MlclustermeanshiftCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_cursor_add(a : MlclustermeanshiftCursor, b : MlclustermeanshiftCursor) -> MlclustermeanshiftCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_mean_shift_cursor_copy(s : MlclustermeanshiftCursor) -> MlclustermeanshiftCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_cursor_fill(s : MlclustermeanshiftCursor, v : Double) -> MlclustermeanshiftCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_cursor_min(s : MlclustermeanshiftCursor) -> Double { @_common.min(s.data) }

pub fn ml_cluster_mean_shift_cursor_max(s : MlclustermeanshiftCursor) -> Double { @_common.max(s.data) }

pub fn ml_cluster_mean_shift_cursor_to_string(s : MlclustermeanshiftCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_view_make(size : Int) -> MlclustermeanshiftView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_view_len(s : MlclustermeanshiftView) -> Int { s.size }

pub fn ml_cluster_mean_shift_view_get(s : MlclustermeanshiftView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_view_set(s : MlclustermeanshiftView, i : Int, v : Double) -> MlclustermeanshiftView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_view_sum(s : MlclustermeanshiftView) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_mean_shift_view_mean(s : MlclustermeanshiftView) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_mean_shift_view_scale(s : MlclustermeanshiftView, f : Double) -> MlclustermeanshiftView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_view_add(a : MlclustermeanshiftView, b : MlclustermeanshiftView) -> MlclustermeanshiftView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_mean_shift_view_copy(s : MlclustermeanshiftView) -> MlclustermeanshiftView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_view_fill(s : MlclustermeanshiftView, v : Double) -> MlclustermeanshiftView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_view_min(s : MlclustermeanshiftView) -> Double { @_common.min(s.data) }

pub fn ml_cluster_mean_shift_view_max(s : MlclustermeanshiftView) -> Double { @_common.max(s.data) }

pub fn ml_cluster_mean_shift_view_to_string(s : MlclustermeanshiftView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_range_make(size : Int) -> MlclustermeanshiftRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_range_len(s : MlclustermeanshiftRange) -> Int { s.size }

pub fn ml_cluster_mean_shift_range_get(s : MlclustermeanshiftRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_range_set(s : MlclustermeanshiftRange, i : Int, v : Double) -> MlclustermeanshiftRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_range_sum(s : MlclustermeanshiftRange) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_mean_shift_range_mean(s : MlclustermeanshiftRange) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_mean_shift_range_scale(s : MlclustermeanshiftRange, f : Double) -> MlclustermeanshiftRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_range_add(a : MlclustermeanshiftRange, b : MlclustermeanshiftRange) -> MlclustermeanshiftRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_mean_shift_range_copy(s : MlclustermeanshiftRange) -> MlclustermeanshiftRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_range_fill(s : MlclustermeanshiftRange, v : Double) -> MlclustermeanshiftRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_range_min(s : MlclustermeanshiftRange) -> Double { @_common.min(s.data) }

pub fn ml_cluster_mean_shift_range_max(s : MlclustermeanshiftRange) -> Double { @_common.max(s.data) }

pub fn ml_cluster_mean_shift_range_to_string(s : MlclustermeanshiftRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustermeanshiftSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_mean_shift_slice_make(size : Int) -> MlclustermeanshiftSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_mean_shift_slice_len(s : MlclustermeanshiftSlice) -> Int { s.size }

pub fn ml_cluster_mean_shift_slice_get(s : MlclustermeanshiftSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_mean_shift_slice_set(s : MlclustermeanshiftSlice, i : Int, v : Double) -> MlclustermeanshiftSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_slice_sum(s : MlclustermeanshiftSlice) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_mean_shift_slice_mean(s : MlclustermeanshiftSlice) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_mean_shift_slice_scale(s : MlclustermeanshiftSlice, f : Double) -> MlclustermeanshiftSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_slice_add(a : MlclustermeanshiftSlice, b : MlclustermeanshiftSlice) -> MlclustermeanshiftSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_mean_shift_slice_copy(s : MlclustermeanshiftSlice) -> MlclustermeanshiftSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_slice_fill(s : MlclustermeanshiftSlice, v : Double) -> MlclustermeanshiftSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_mean_shift_slice_min(s : MlclustermeanshiftSlice) -> Double { @_common.min(s.data) }

pub fn ml_cluster_mean_shift_slice_max(s : MlclustermeanshiftSlice) -> Double { @_common.max(s.data) }

pub fn ml_cluster_mean_shift_slice_to_string(s : MlclustermeanshiftSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

