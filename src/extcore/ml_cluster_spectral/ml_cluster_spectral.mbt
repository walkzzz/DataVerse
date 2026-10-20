///===
/// extcore/ml_cluster_spectral

pub(all) struct MlclusterspectralPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_spectral_make_point(x : Double, y : Double) -> MlclusterspectralPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_spectral_make_point3(x : Double, y : Double, z : Double) -> MlclusterspectralPoint {
  { x, y, z, label: 0 }
}

pub fn MlclusterspectralPoint::x(self : MlclusterspectralPoint) -> Double { self.x }

pub fn MlclusterspectralPoint::y(self : MlclusterspectralPoint) -> Double { self.y }

pub fn MlclusterspectralPoint::z(self : MlclusterspectralPoint) -> Double { self.z }

pub fn MlclusterspectralPoint::label(self : MlclusterspectralPoint) -> Int { self.label }

pub fn MlclusterspectralPoint::dist(self : MlclusterspectralPoint, other : MlclusterspectralPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclusterspectralPoint::add(self : MlclusterspectralPoint, other : MlclusterspectralPoint) -> MlclusterspectralPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclusterspectralPoint::sub(self : MlclusterspectralPoint, other : MlclusterspectralPoint) -> MlclusterspectralPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclusterspectralPoint::scale(self : MlclusterspectralPoint, s : Double) -> MlclusterspectralPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclusterspectralPoint::dot(self : MlclusterspectralPoint, other : MlclusterspectralPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclusterspectralPoint::cross(self : MlclusterspectralPoint, other : MlclusterspectralPoint) -> MlclusterspectralPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclusterspectralPoint::norm(self : MlclusterspectralPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclusterspectralPoint::normalize(self : MlclusterspectralPoint) -> MlclusterspectralPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterspectralPoint::negate(self : MlclusterspectralPoint) -> MlclusterspectralPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclusterspectralPoint::mid(self : MlclusterspectralPoint, other : MlclusterspectralPoint) -> MlclusterspectralPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclusterspectralPoint::lerp(self : MlclusterspectralPoint, other : MlclusterspectralPoint, t : Double) -> MlclusterspectralPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclusterspectralPoint::to_string(self : MlclusterspectralPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclusterspectralSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_spectral_make_series(vals : Array[Double], name : String) -> MlclusterspectralSeries {
  { vals, name, meta: 0 }
}

pub fn MlclusterspectralSeries::len(self : MlclusterspectralSeries) -> Int { self.vals.length() }

pub fn MlclusterspectralSeries::sum(self : MlclusterspectralSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclusterspectralSeries::mean(self : MlclusterspectralSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclusterspectralSeries::min(self : MlclusterspectralSeries) -> Double { @_common.min(self.vals) }

pub fn MlclusterspectralSeries::max(self : MlclusterspectralSeries) -> Double { @_common.max(self.vals) }

pub fn MlclusterspectralSeries::range(self : MlclusterspectralSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclusterspectralSeries::variance(self : MlclusterspectralSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclusterspectralSeries::std(self : MlclusterspectralSeries) -> Double { @_common.std(self.vals) }

pub fn MlclusterspectralSeries::median(self : MlclusterspectralSeries) -> Double { @_common.median(self.vals) }

pub fn MlclusterspectralSeries::scale(self : MlclusterspectralSeries, f : Double) -> MlclusterspectralSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclusterspectralSeries::add(self : MlclusterspectralSeries, other : MlclusterspectralSeries) -> MlclusterspectralSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclusterspectralSeries::sub(self : MlclusterspectralSeries, other : MlclusterspectralSeries) -> MlclusterspectralSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclusterspectralSeries::normalize(self : MlclusterspectralSeries) -> MlclusterspectralSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclusterspectralSeries::cumsum(self : MlclusterspectralSeries) -> MlclusterspectralSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclusterspectralSeries::to_string(self : MlclusterspectralSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusterspectralMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_spectral_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusterspectralMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_spectral_matrix_identity(n : Int) -> MlclusterspectralMatrix {
  let m = ml_cluster_spectral_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclusterspectralMatrix::get(self : MlclusterspectralMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclusterspectralMatrix::transpose(self : MlclusterspectralMatrix) -> MlclusterspectralMatrix {
  let result = ml_cluster_spectral_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclusterspectralMatrix::add(self : MlclusterspectralMatrix, other : MlclusterspectralMatrix) -> MlclusterspectralMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_spectral_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclusterspectralMatrix::scale(self : MlclusterspectralMatrix, s : Double) -> MlclusterspectralMatrix {
  let result = ml_cluster_spectral_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclusterspectralMatrix::multiply(self : MlclusterspectralMatrix, other : MlclusterspectralMatrix) -> MlclusterspectralMatrix {
  if self.cols != other.rows { return ml_cluster_spectral_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_spectral_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclusterspectralMatrix::trace(self : MlclusterspectralMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclusterspectralMatrix::det(self : MlclusterspectralMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclusterspectralMatrix::norm(self : MlclusterspectralMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclusterspectralMatrix::to_string(self : MlclusterspectralMatrix) -> String {
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

pub(all) struct MlclusterspectralVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_spectral_make_vector(comps : Array[Double]) -> MlclusterspectralVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_spectral_vector_zero(dim : Int) -> MlclusterspectralVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclusterspectralVector::add(self : MlclusterspectralVector, other : MlclusterspectralVector) -> MlclusterspectralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterspectralVector::sub(self : MlclusterspectralVector, other : MlclusterspectralVector) -> MlclusterspectralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterspectralVector::scale(self : MlclusterspectralVector, s : Double) -> MlclusterspectralVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclusterspectralVector::dot(self : MlclusterspectralVector, other : MlclusterspectralVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclusterspectralVector::norm(self : MlclusterspectralVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclusterspectralVector::normalize(self : MlclusterspectralVector) -> MlclusterspectralVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterspectralVector::dist(self : MlclusterspectralVector, other : MlclusterspectralVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclusterspectralVector::to_string(self : MlclusterspectralVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_spectral_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_spectral_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_spectral_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_spectral_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_spectral_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_spectral_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_spectral_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_spectral_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_spectral_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_spectral_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_spectral_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_spectral_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_spectral_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_spectral_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_spectral_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_spectral_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_spectral_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_spectral_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_spectral_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_spectral_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_spectral_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_spectral_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_spectral_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_spectral_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_spectral_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_spectral_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_spectral_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_spectral_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_spectral_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclusterspectralFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_frame_make(size : Int) -> MlclusterspectralFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_frame_len(s : MlclusterspectralFrame) -> Int { s.size }

pub fn ml_cluster_spectral_frame_get(s : MlclusterspectralFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_frame_set(s : MlclusterspectralFrame, i : Int, v : Double) -> MlclusterspectralFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_frame_sum(s : MlclusterspectralFrame) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_spectral_frame_mean(s : MlclusterspectralFrame) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_spectral_frame_scale(s : MlclusterspectralFrame, f : Double) -> MlclusterspectralFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_frame_add(a : MlclusterspectralFrame, b : MlclusterspectralFrame) -> MlclusterspectralFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_spectral_frame_copy(s : MlclusterspectralFrame) -> MlclusterspectralFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_frame_fill(s : MlclusterspectralFrame, v : Double) -> MlclusterspectralFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_frame_min(s : MlclusterspectralFrame) -> Double { @_common.min(s.data) }

pub fn ml_cluster_spectral_frame_max(s : MlclusterspectralFrame) -> Double { @_common.max(s.data) }

pub fn ml_cluster_spectral_frame_to_string(s : MlclusterspectralFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_table_make(size : Int) -> MlclusterspectralTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_table_len(s : MlclusterspectralTable) -> Int { s.size }

pub fn ml_cluster_spectral_table_get(s : MlclusterspectralTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_table_set(s : MlclusterspectralTable, i : Int, v : Double) -> MlclusterspectralTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_table_sum(s : MlclusterspectralTable) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_spectral_table_mean(s : MlclusterspectralTable) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_spectral_table_scale(s : MlclusterspectralTable, f : Double) -> MlclusterspectralTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_table_add(a : MlclusterspectralTable, b : MlclusterspectralTable) -> MlclusterspectralTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_spectral_table_copy(s : MlclusterspectralTable) -> MlclusterspectralTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_table_fill(s : MlclusterspectralTable, v : Double) -> MlclusterspectralTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_table_min(s : MlclusterspectralTable) -> Double { @_common.min(s.data) }

pub fn ml_cluster_spectral_table_max(s : MlclusterspectralTable) -> Double { @_common.max(s.data) }

pub fn ml_cluster_spectral_table_to_string(s : MlclusterspectralTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_graphn_make(size : Int) -> MlclusterspectralGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_graphn_len(s : MlclusterspectralGraphN) -> Int { s.size }

pub fn ml_cluster_spectral_graphn_get(s : MlclusterspectralGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_graphn_set(s : MlclusterspectralGraphN, i : Int, v : Double) -> MlclusterspectralGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_graphn_sum(s : MlclusterspectralGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_spectral_graphn_mean(s : MlclusterspectralGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_spectral_graphn_scale(s : MlclusterspectralGraphN, f : Double) -> MlclusterspectralGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_graphn_add(a : MlclusterspectralGraphN, b : MlclusterspectralGraphN) -> MlclusterspectralGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_spectral_graphn_copy(s : MlclusterspectralGraphN) -> MlclusterspectralGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_graphn_fill(s : MlclusterspectralGraphN, v : Double) -> MlclusterspectralGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_graphn_min(s : MlclusterspectralGraphN) -> Double { @_common.min(s.data) }

pub fn ml_cluster_spectral_graphn_max(s : MlclusterspectralGraphN) -> Double { @_common.max(s.data) }

pub fn ml_cluster_spectral_graphn_to_string(s : MlclusterspectralGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_node_make(size : Int) -> MlclusterspectralNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_node_len(s : MlclusterspectralNode) -> Int { s.size }

pub fn ml_cluster_spectral_node_get(s : MlclusterspectralNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_node_set(s : MlclusterspectralNode, i : Int, v : Double) -> MlclusterspectralNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_node_sum(s : MlclusterspectralNode) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_spectral_node_mean(s : MlclusterspectralNode) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_spectral_node_scale(s : MlclusterspectralNode, f : Double) -> MlclusterspectralNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_node_add(a : MlclusterspectralNode, b : MlclusterspectralNode) -> MlclusterspectralNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_spectral_node_copy(s : MlclusterspectralNode) -> MlclusterspectralNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_node_fill(s : MlclusterspectralNode, v : Double) -> MlclusterspectralNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_node_min(s : MlclusterspectralNode) -> Double { @_common.min(s.data) }

pub fn ml_cluster_spectral_node_max(s : MlclusterspectralNode) -> Double { @_common.max(s.data) }

pub fn ml_cluster_spectral_node_to_string(s : MlclusterspectralNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_edge_make(size : Int) -> MlclusterspectralEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_edge_len(s : MlclusterspectralEdge) -> Int { s.size }

pub fn ml_cluster_spectral_edge_get(s : MlclusterspectralEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_edge_set(s : MlclusterspectralEdge, i : Int, v : Double) -> MlclusterspectralEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_edge_sum(s : MlclusterspectralEdge) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_spectral_edge_mean(s : MlclusterspectralEdge) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_spectral_edge_scale(s : MlclusterspectralEdge, f : Double) -> MlclusterspectralEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_edge_add(a : MlclusterspectralEdge, b : MlclusterspectralEdge) -> MlclusterspectralEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_spectral_edge_copy(s : MlclusterspectralEdge) -> MlclusterspectralEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_edge_fill(s : MlclusterspectralEdge, v : Double) -> MlclusterspectralEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_edge_min(s : MlclusterspectralEdge) -> Double { @_common.min(s.data) }

pub fn ml_cluster_spectral_edge_max(s : MlclusterspectralEdge) -> Double { @_common.max(s.data) }

pub fn ml_cluster_spectral_edge_to_string(s : MlclusterspectralEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_path_make(size : Int) -> MlclusterspectralPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_path_len(s : MlclusterspectralPath) -> Int { s.size }

pub fn ml_cluster_spectral_path_get(s : MlclusterspectralPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_path_set(s : MlclusterspectralPath, i : Int, v : Double) -> MlclusterspectralPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_path_sum(s : MlclusterspectralPath) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_spectral_path_mean(s : MlclusterspectralPath) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_spectral_path_scale(s : MlclusterspectralPath, f : Double) -> MlclusterspectralPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_path_add(a : MlclusterspectralPath, b : MlclusterspectralPath) -> MlclusterspectralPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_spectral_path_copy(s : MlclusterspectralPath) -> MlclusterspectralPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_path_fill(s : MlclusterspectralPath, v : Double) -> MlclusterspectralPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_path_min(s : MlclusterspectralPath) -> Double { @_common.min(s.data) }

pub fn ml_cluster_spectral_path_max(s : MlclusterspectralPath) -> Double { @_common.max(s.data) }

pub fn ml_cluster_spectral_path_to_string(s : MlclusterspectralPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_cluster_make(size : Int) -> MlclusterspectralCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_cluster_len(s : MlclusterspectralCluster) -> Int { s.size }

pub fn ml_cluster_spectral_cluster_get(s : MlclusterspectralCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_cluster_set(s : MlclusterspectralCluster, i : Int, v : Double) -> MlclusterspectralCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_cluster_sum(s : MlclusterspectralCluster) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_spectral_cluster_mean(s : MlclusterspectralCluster) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_spectral_cluster_scale(s : MlclusterspectralCluster, f : Double) -> MlclusterspectralCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_cluster_add(a : MlclusterspectralCluster, b : MlclusterspectralCluster) -> MlclusterspectralCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_spectral_cluster_copy(s : MlclusterspectralCluster) -> MlclusterspectralCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_cluster_fill(s : MlclusterspectralCluster, v : Double) -> MlclusterspectralCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_cluster_min(s : MlclusterspectralCluster) -> Double { @_common.min(s.data) }

pub fn ml_cluster_spectral_cluster_max(s : MlclusterspectralCluster) -> Double { @_common.max(s.data) }

pub fn ml_cluster_spectral_cluster_to_string(s : MlclusterspectralCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_model_make(size : Int) -> MlclusterspectralModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_model_len(s : MlclusterspectralModel) -> Int { s.size }

pub fn ml_cluster_spectral_model_get(s : MlclusterspectralModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_model_set(s : MlclusterspectralModel, i : Int, v : Double) -> MlclusterspectralModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_model_sum(s : MlclusterspectralModel) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_spectral_model_mean(s : MlclusterspectralModel) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_spectral_model_scale(s : MlclusterspectralModel, f : Double) -> MlclusterspectralModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_model_add(a : MlclusterspectralModel, b : MlclusterspectralModel) -> MlclusterspectralModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_spectral_model_copy(s : MlclusterspectralModel) -> MlclusterspectralModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_model_fill(s : MlclusterspectralModel, v : Double) -> MlclusterspectralModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_model_min(s : MlclusterspectralModel) -> Double { @_common.min(s.data) }

pub fn ml_cluster_spectral_model_max(s : MlclusterspectralModel) -> Double { @_common.max(s.data) }

pub fn ml_cluster_spectral_model_to_string(s : MlclusterspectralModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_layer_make(size : Int) -> MlclusterspectralLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_layer_len(s : MlclusterspectralLayer) -> Int { s.size }

pub fn ml_cluster_spectral_layer_get(s : MlclusterspectralLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_layer_set(s : MlclusterspectralLayer, i : Int, v : Double) -> MlclusterspectralLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_layer_sum(s : MlclusterspectralLayer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_spectral_layer_mean(s : MlclusterspectralLayer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_spectral_layer_scale(s : MlclusterspectralLayer, f : Double) -> MlclusterspectralLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_layer_add(a : MlclusterspectralLayer, b : MlclusterspectralLayer) -> MlclusterspectralLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_spectral_layer_copy(s : MlclusterspectralLayer) -> MlclusterspectralLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_layer_fill(s : MlclusterspectralLayer, v : Double) -> MlclusterspectralLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_layer_min(s : MlclusterspectralLayer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_spectral_layer_max(s : MlclusterspectralLayer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_spectral_layer_to_string(s : MlclusterspectralLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_buffer_make(size : Int) -> MlclusterspectralBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_buffer_len(s : MlclusterspectralBuffer) -> Int { s.size }

pub fn ml_cluster_spectral_buffer_get(s : MlclusterspectralBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_buffer_set(s : MlclusterspectralBuffer, i : Int, v : Double) -> MlclusterspectralBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_buffer_sum(s : MlclusterspectralBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_spectral_buffer_mean(s : MlclusterspectralBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_spectral_buffer_scale(s : MlclusterspectralBuffer, f : Double) -> MlclusterspectralBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_buffer_add(a : MlclusterspectralBuffer, b : MlclusterspectralBuffer) -> MlclusterspectralBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_spectral_buffer_copy(s : MlclusterspectralBuffer) -> MlclusterspectralBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_buffer_fill(s : MlclusterspectralBuffer, v : Double) -> MlclusterspectralBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_buffer_min(s : MlclusterspectralBuffer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_spectral_buffer_max(s : MlclusterspectralBuffer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_spectral_buffer_to_string(s : MlclusterspectralBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_cursor_make(size : Int) -> MlclusterspectralCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_cursor_len(s : MlclusterspectralCursor) -> Int { s.size }

pub fn ml_cluster_spectral_cursor_get(s : MlclusterspectralCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_cursor_set(s : MlclusterspectralCursor, i : Int, v : Double) -> MlclusterspectralCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_cursor_sum(s : MlclusterspectralCursor) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_spectral_cursor_mean(s : MlclusterspectralCursor) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_spectral_cursor_scale(s : MlclusterspectralCursor, f : Double) -> MlclusterspectralCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_cursor_add(a : MlclusterspectralCursor, b : MlclusterspectralCursor) -> MlclusterspectralCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_spectral_cursor_copy(s : MlclusterspectralCursor) -> MlclusterspectralCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_cursor_fill(s : MlclusterspectralCursor, v : Double) -> MlclusterspectralCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_cursor_min(s : MlclusterspectralCursor) -> Double { @_common.min(s.data) }

pub fn ml_cluster_spectral_cursor_max(s : MlclusterspectralCursor) -> Double { @_common.max(s.data) }

pub fn ml_cluster_spectral_cursor_to_string(s : MlclusterspectralCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_view_make(size : Int) -> MlclusterspectralView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_view_len(s : MlclusterspectralView) -> Int { s.size }

pub fn ml_cluster_spectral_view_get(s : MlclusterspectralView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_view_set(s : MlclusterspectralView, i : Int, v : Double) -> MlclusterspectralView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_view_sum(s : MlclusterspectralView) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_spectral_view_mean(s : MlclusterspectralView) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_spectral_view_scale(s : MlclusterspectralView, f : Double) -> MlclusterspectralView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_view_add(a : MlclusterspectralView, b : MlclusterspectralView) -> MlclusterspectralView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_spectral_view_copy(s : MlclusterspectralView) -> MlclusterspectralView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_view_fill(s : MlclusterspectralView, v : Double) -> MlclusterspectralView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_view_min(s : MlclusterspectralView) -> Double { @_common.min(s.data) }

pub fn ml_cluster_spectral_view_max(s : MlclusterspectralView) -> Double { @_common.max(s.data) }

pub fn ml_cluster_spectral_view_to_string(s : MlclusterspectralView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_range_make(size : Int) -> MlclusterspectralRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_range_len(s : MlclusterspectralRange) -> Int { s.size }

pub fn ml_cluster_spectral_range_get(s : MlclusterspectralRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_range_set(s : MlclusterspectralRange, i : Int, v : Double) -> MlclusterspectralRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_range_sum(s : MlclusterspectralRange) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_spectral_range_mean(s : MlclusterspectralRange) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_spectral_range_scale(s : MlclusterspectralRange, f : Double) -> MlclusterspectralRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_range_add(a : MlclusterspectralRange, b : MlclusterspectralRange) -> MlclusterspectralRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_spectral_range_copy(s : MlclusterspectralRange) -> MlclusterspectralRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_range_fill(s : MlclusterspectralRange, v : Double) -> MlclusterspectralRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_range_min(s : MlclusterspectralRange) -> Double { @_common.min(s.data) }

pub fn ml_cluster_spectral_range_max(s : MlclusterspectralRange) -> Double { @_common.max(s.data) }

pub fn ml_cluster_spectral_range_to_string(s : MlclusterspectralRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterspectralSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_spectral_slice_make(size : Int) -> MlclusterspectralSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_spectral_slice_len(s : MlclusterspectralSlice) -> Int { s.size }

pub fn ml_cluster_spectral_slice_get(s : MlclusterspectralSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_spectral_slice_set(s : MlclusterspectralSlice, i : Int, v : Double) -> MlclusterspectralSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_slice_sum(s : MlclusterspectralSlice) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_spectral_slice_mean(s : MlclusterspectralSlice) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_spectral_slice_scale(s : MlclusterspectralSlice, f : Double) -> MlclusterspectralSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_slice_add(a : MlclusterspectralSlice, b : MlclusterspectralSlice) -> MlclusterspectralSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_spectral_slice_copy(s : MlclusterspectralSlice) -> MlclusterspectralSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_slice_fill(s : MlclusterspectralSlice, v : Double) -> MlclusterspectralSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_spectral_slice_min(s : MlclusterspectralSlice) -> Double { @_common.min(s.data) }

pub fn ml_cluster_spectral_slice_max(s : MlclusterspectralSlice) -> Double { @_common.max(s.data) }

pub fn ml_cluster_spectral_slice_to_string(s : MlclusterspectralSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

