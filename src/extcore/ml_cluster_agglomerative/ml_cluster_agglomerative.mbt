///===
/// extcore/ml_cluster_agglomerative

pub(all) struct MlclusteragglomerativePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_agglomerative_make_point(x : Double, y : Double) -> MlclusteragglomerativePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_agglomerative_make_point3(x : Double, y : Double, z : Double) -> MlclusteragglomerativePoint {
  { x, y, z, label: 0 }
}

pub fn MlclusteragglomerativePoint::x(self : MlclusteragglomerativePoint) -> Double { self.x }

pub fn MlclusteragglomerativePoint::y(self : MlclusteragglomerativePoint) -> Double { self.y }

pub fn MlclusteragglomerativePoint::z(self : MlclusteragglomerativePoint) -> Double { self.z }

pub fn MlclusteragglomerativePoint::label(self : MlclusteragglomerativePoint) -> Int { self.label }

pub fn MlclusteragglomerativePoint::dist(self : MlclusteragglomerativePoint, other : MlclusteragglomerativePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclusteragglomerativePoint::add(self : MlclusteragglomerativePoint, other : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclusteragglomerativePoint::sub(self : MlclusteragglomerativePoint, other : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclusteragglomerativePoint::scale(self : MlclusteragglomerativePoint, s : Double) -> MlclusteragglomerativePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclusteragglomerativePoint::dot(self : MlclusteragglomerativePoint, other : MlclusteragglomerativePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclusteragglomerativePoint::cross(self : MlclusteragglomerativePoint, other : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclusteragglomerativePoint::norm(self : MlclusteragglomerativePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclusteragglomerativePoint::normalize(self : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusteragglomerativePoint::negate(self : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclusteragglomerativePoint::mid(self : MlclusteragglomerativePoint, other : MlclusteragglomerativePoint) -> MlclusteragglomerativePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclusteragglomerativePoint::lerp(self : MlclusteragglomerativePoint, other : MlclusteragglomerativePoint, t : Double) -> MlclusteragglomerativePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclusteragglomerativePoint::to_string(self : MlclusteragglomerativePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_agglomerative_make_series(vals : Array[Double], name : String) -> MlclusteragglomerativeSeries {
  { vals, name, meta: 0 }
}

pub fn MlclusteragglomerativeSeries::len(self : MlclusteragglomerativeSeries) -> Int { self.vals.length() }

pub fn MlclusteragglomerativeSeries::sum(self : MlclusteragglomerativeSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclusteragglomerativeSeries::mean(self : MlclusteragglomerativeSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclusteragglomerativeSeries::min(self : MlclusteragglomerativeSeries) -> Double { @_common.min(self.vals) }

pub fn MlclusteragglomerativeSeries::max(self : MlclusteragglomerativeSeries) -> Double { @_common.max(self.vals) }

pub fn MlclusteragglomerativeSeries::range(self : MlclusteragglomerativeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclusteragglomerativeSeries::variance(self : MlclusteragglomerativeSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclusteragglomerativeSeries::std(self : MlclusteragglomerativeSeries) -> Double { @_common.std(self.vals) }

pub fn MlclusteragglomerativeSeries::median(self : MlclusteragglomerativeSeries) -> Double { @_common.median(self.vals) }

pub fn MlclusteragglomerativeSeries::scale(self : MlclusteragglomerativeSeries, f : Double) -> MlclusteragglomerativeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclusteragglomerativeSeries::add(self : MlclusteragglomerativeSeries, other : MlclusteragglomerativeSeries) -> MlclusteragglomerativeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclusteragglomerativeSeries::sub(self : MlclusteragglomerativeSeries, other : MlclusteragglomerativeSeries) -> MlclusteragglomerativeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclusteragglomerativeSeries::normalize(self : MlclusteragglomerativeSeries) -> MlclusteragglomerativeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclusteragglomerativeSeries::cumsum(self : MlclusteragglomerativeSeries) -> MlclusteragglomerativeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclusteragglomerativeSeries::to_string(self : MlclusteragglomerativeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusteragglomerativeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_agglomerative_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusteragglomerativeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_agglomerative_matrix_identity(n : Int) -> MlclusteragglomerativeMatrix {
  let m = ml_cluster_agglomerative_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclusteragglomerativeMatrix::get(self : MlclusteragglomerativeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclusteragglomerativeMatrix::transpose(self : MlclusteragglomerativeMatrix) -> MlclusteragglomerativeMatrix {
  let result = ml_cluster_agglomerative_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclusteragglomerativeMatrix::add(self : MlclusteragglomerativeMatrix, other : MlclusteragglomerativeMatrix) -> MlclusteragglomerativeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_agglomerative_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclusteragglomerativeMatrix::scale(self : MlclusteragglomerativeMatrix, s : Double) -> MlclusteragglomerativeMatrix {
  let result = ml_cluster_agglomerative_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclusteragglomerativeMatrix::multiply(self : MlclusteragglomerativeMatrix, other : MlclusteragglomerativeMatrix) -> MlclusteragglomerativeMatrix {
  if self.cols != other.rows { return ml_cluster_agglomerative_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_agglomerative_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclusteragglomerativeMatrix::trace(self : MlclusteragglomerativeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclusteragglomerativeMatrix::det(self : MlclusteragglomerativeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclusteragglomerativeMatrix::norm(self : MlclusteragglomerativeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclusteragglomerativeMatrix::to_string(self : MlclusteragglomerativeMatrix) -> String {
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

pub(all) struct MlclusteragglomerativeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_agglomerative_make_vector(comps : Array[Double]) -> MlclusteragglomerativeVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_agglomerative_vector_zero(dim : Int) -> MlclusteragglomerativeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclusteragglomerativeVector::add(self : MlclusteragglomerativeVector, other : MlclusteragglomerativeVector) -> MlclusteragglomerativeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusteragglomerativeVector::sub(self : MlclusteragglomerativeVector, other : MlclusteragglomerativeVector) -> MlclusteragglomerativeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusteragglomerativeVector::scale(self : MlclusteragglomerativeVector, s : Double) -> MlclusteragglomerativeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclusteragglomerativeVector::dot(self : MlclusteragglomerativeVector, other : MlclusteragglomerativeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclusteragglomerativeVector::norm(self : MlclusteragglomerativeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclusteragglomerativeVector::normalize(self : MlclusteragglomerativeVector) -> MlclusteragglomerativeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusteragglomerativeVector::dist(self : MlclusteragglomerativeVector, other : MlclusteragglomerativeVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclusteragglomerativeVector::to_string(self : MlclusteragglomerativeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_agglomerative_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_agglomerative_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_agglomerative_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_agglomerative_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_agglomerative_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_agglomerative_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_agglomerative_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_agglomerative_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_agglomerative_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_agglomerative_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_agglomerative_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_agglomerative_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_agglomerative_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_agglomerative_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_agglomerative_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_agglomerative_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_agglomerative_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_agglomerative_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_agglomerative_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_agglomerative_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_agglomerative_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_agglomerative_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_agglomerative_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_agglomerative_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_agglomerative_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_agglomerative_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_agglomerative_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_agglomerative_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_agglomerative_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclusteragglomerativeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_frame_make(size : Int) -> MlclusteragglomerativeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_frame_len(s : MlclusteragglomerativeFrame) -> Int { s.size }

pub fn ml_cluster_agglomerative_frame_get(s : MlclusteragglomerativeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_frame_set(s : MlclusteragglomerativeFrame, i : Int, v : Double) -> MlclusteragglomerativeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_frame_sum(s : MlclusteragglomerativeFrame) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_agglomerative_frame_mean(s : MlclusteragglomerativeFrame) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_agglomerative_frame_scale(s : MlclusteragglomerativeFrame, f : Double) -> MlclusteragglomerativeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_frame_add(a : MlclusteragglomerativeFrame, b : MlclusteragglomerativeFrame) -> MlclusteragglomerativeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_agglomerative_frame_copy(s : MlclusteragglomerativeFrame) -> MlclusteragglomerativeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_frame_fill(s : MlclusteragglomerativeFrame, v : Double) -> MlclusteragglomerativeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_frame_min(s : MlclusteragglomerativeFrame) -> Double { @_common.min(s.data) }

pub fn ml_cluster_agglomerative_frame_max(s : MlclusteragglomerativeFrame) -> Double { @_common.max(s.data) }

pub fn ml_cluster_agglomerative_frame_to_string(s : MlclusteragglomerativeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_table_make(size : Int) -> MlclusteragglomerativeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_table_len(s : MlclusteragglomerativeTable) -> Int { s.size }

pub fn ml_cluster_agglomerative_table_get(s : MlclusteragglomerativeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_table_set(s : MlclusteragglomerativeTable, i : Int, v : Double) -> MlclusteragglomerativeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_table_sum(s : MlclusteragglomerativeTable) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_agglomerative_table_mean(s : MlclusteragglomerativeTable) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_agglomerative_table_scale(s : MlclusteragglomerativeTable, f : Double) -> MlclusteragglomerativeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_table_add(a : MlclusteragglomerativeTable, b : MlclusteragglomerativeTable) -> MlclusteragglomerativeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_agglomerative_table_copy(s : MlclusteragglomerativeTable) -> MlclusteragglomerativeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_table_fill(s : MlclusteragglomerativeTable, v : Double) -> MlclusteragglomerativeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_table_min(s : MlclusteragglomerativeTable) -> Double { @_common.min(s.data) }

pub fn ml_cluster_agglomerative_table_max(s : MlclusteragglomerativeTable) -> Double { @_common.max(s.data) }

pub fn ml_cluster_agglomerative_table_to_string(s : MlclusteragglomerativeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_graphn_make(size : Int) -> MlclusteragglomerativeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_graphn_len(s : MlclusteragglomerativeGraphN) -> Int { s.size }

pub fn ml_cluster_agglomerative_graphn_get(s : MlclusteragglomerativeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_graphn_set(s : MlclusteragglomerativeGraphN, i : Int, v : Double) -> MlclusteragglomerativeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_graphn_sum(s : MlclusteragglomerativeGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_agglomerative_graphn_mean(s : MlclusteragglomerativeGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_agglomerative_graphn_scale(s : MlclusteragglomerativeGraphN, f : Double) -> MlclusteragglomerativeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_graphn_add(a : MlclusteragglomerativeGraphN, b : MlclusteragglomerativeGraphN) -> MlclusteragglomerativeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_agglomerative_graphn_copy(s : MlclusteragglomerativeGraphN) -> MlclusteragglomerativeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_graphn_fill(s : MlclusteragglomerativeGraphN, v : Double) -> MlclusteragglomerativeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_graphn_min(s : MlclusteragglomerativeGraphN) -> Double { @_common.min(s.data) }

pub fn ml_cluster_agglomerative_graphn_max(s : MlclusteragglomerativeGraphN) -> Double { @_common.max(s.data) }

pub fn ml_cluster_agglomerative_graphn_to_string(s : MlclusteragglomerativeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_node_make(size : Int) -> MlclusteragglomerativeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_node_len(s : MlclusteragglomerativeNode) -> Int { s.size }

pub fn ml_cluster_agglomerative_node_get(s : MlclusteragglomerativeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_node_set(s : MlclusteragglomerativeNode, i : Int, v : Double) -> MlclusteragglomerativeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_node_sum(s : MlclusteragglomerativeNode) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_agglomerative_node_mean(s : MlclusteragglomerativeNode) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_agglomerative_node_scale(s : MlclusteragglomerativeNode, f : Double) -> MlclusteragglomerativeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_node_add(a : MlclusteragglomerativeNode, b : MlclusteragglomerativeNode) -> MlclusteragglomerativeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_agglomerative_node_copy(s : MlclusteragglomerativeNode) -> MlclusteragglomerativeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_node_fill(s : MlclusteragglomerativeNode, v : Double) -> MlclusteragglomerativeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_node_min(s : MlclusteragglomerativeNode) -> Double { @_common.min(s.data) }

pub fn ml_cluster_agglomerative_node_max(s : MlclusteragglomerativeNode) -> Double { @_common.max(s.data) }

pub fn ml_cluster_agglomerative_node_to_string(s : MlclusteragglomerativeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_edge_make(size : Int) -> MlclusteragglomerativeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_edge_len(s : MlclusteragglomerativeEdge) -> Int { s.size }

pub fn ml_cluster_agglomerative_edge_get(s : MlclusteragglomerativeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_edge_set(s : MlclusteragglomerativeEdge, i : Int, v : Double) -> MlclusteragglomerativeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_edge_sum(s : MlclusteragglomerativeEdge) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_agglomerative_edge_mean(s : MlclusteragglomerativeEdge) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_agglomerative_edge_scale(s : MlclusteragglomerativeEdge, f : Double) -> MlclusteragglomerativeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_edge_add(a : MlclusteragglomerativeEdge, b : MlclusteragglomerativeEdge) -> MlclusteragglomerativeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_agglomerative_edge_copy(s : MlclusteragglomerativeEdge) -> MlclusteragglomerativeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_edge_fill(s : MlclusteragglomerativeEdge, v : Double) -> MlclusteragglomerativeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_edge_min(s : MlclusteragglomerativeEdge) -> Double { @_common.min(s.data) }

pub fn ml_cluster_agglomerative_edge_max(s : MlclusteragglomerativeEdge) -> Double { @_common.max(s.data) }

pub fn ml_cluster_agglomerative_edge_to_string(s : MlclusteragglomerativeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_path_make(size : Int) -> MlclusteragglomerativePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_path_len(s : MlclusteragglomerativePath) -> Int { s.size }

pub fn ml_cluster_agglomerative_path_get(s : MlclusteragglomerativePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_path_set(s : MlclusteragglomerativePath, i : Int, v : Double) -> MlclusteragglomerativePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_path_sum(s : MlclusteragglomerativePath) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_agglomerative_path_mean(s : MlclusteragglomerativePath) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_agglomerative_path_scale(s : MlclusteragglomerativePath, f : Double) -> MlclusteragglomerativePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_path_add(a : MlclusteragglomerativePath, b : MlclusteragglomerativePath) -> MlclusteragglomerativePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_agglomerative_path_copy(s : MlclusteragglomerativePath) -> MlclusteragglomerativePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_path_fill(s : MlclusteragglomerativePath, v : Double) -> MlclusteragglomerativePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_path_min(s : MlclusteragglomerativePath) -> Double { @_common.min(s.data) }

pub fn ml_cluster_agglomerative_path_max(s : MlclusteragglomerativePath) -> Double { @_common.max(s.data) }

pub fn ml_cluster_agglomerative_path_to_string(s : MlclusteragglomerativePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_cluster_make(size : Int) -> MlclusteragglomerativeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_cluster_len(s : MlclusteragglomerativeCluster) -> Int { s.size }

pub fn ml_cluster_agglomerative_cluster_get(s : MlclusteragglomerativeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_cluster_set(s : MlclusteragglomerativeCluster, i : Int, v : Double) -> MlclusteragglomerativeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_cluster_sum(s : MlclusteragglomerativeCluster) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_agglomerative_cluster_mean(s : MlclusteragglomerativeCluster) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_agglomerative_cluster_scale(s : MlclusteragglomerativeCluster, f : Double) -> MlclusteragglomerativeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_cluster_add(a : MlclusteragglomerativeCluster, b : MlclusteragglomerativeCluster) -> MlclusteragglomerativeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_agglomerative_cluster_copy(s : MlclusteragglomerativeCluster) -> MlclusteragglomerativeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_cluster_fill(s : MlclusteragglomerativeCluster, v : Double) -> MlclusteragglomerativeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_cluster_min(s : MlclusteragglomerativeCluster) -> Double { @_common.min(s.data) }

pub fn ml_cluster_agglomerative_cluster_max(s : MlclusteragglomerativeCluster) -> Double { @_common.max(s.data) }

pub fn ml_cluster_agglomerative_cluster_to_string(s : MlclusteragglomerativeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_model_make(size : Int) -> MlclusteragglomerativeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_model_len(s : MlclusteragglomerativeModel) -> Int { s.size }

pub fn ml_cluster_agglomerative_model_get(s : MlclusteragglomerativeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_model_set(s : MlclusteragglomerativeModel, i : Int, v : Double) -> MlclusteragglomerativeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_model_sum(s : MlclusteragglomerativeModel) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_agglomerative_model_mean(s : MlclusteragglomerativeModel) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_agglomerative_model_scale(s : MlclusteragglomerativeModel, f : Double) -> MlclusteragglomerativeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_model_add(a : MlclusteragglomerativeModel, b : MlclusteragglomerativeModel) -> MlclusteragglomerativeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_agglomerative_model_copy(s : MlclusteragglomerativeModel) -> MlclusteragglomerativeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_model_fill(s : MlclusteragglomerativeModel, v : Double) -> MlclusteragglomerativeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_model_min(s : MlclusteragglomerativeModel) -> Double { @_common.min(s.data) }

pub fn ml_cluster_agglomerative_model_max(s : MlclusteragglomerativeModel) -> Double { @_common.max(s.data) }

pub fn ml_cluster_agglomerative_model_to_string(s : MlclusteragglomerativeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_layer_make(size : Int) -> MlclusteragglomerativeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_layer_len(s : MlclusteragglomerativeLayer) -> Int { s.size }

pub fn ml_cluster_agglomerative_layer_get(s : MlclusteragglomerativeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_layer_set(s : MlclusteragglomerativeLayer, i : Int, v : Double) -> MlclusteragglomerativeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_layer_sum(s : MlclusteragglomerativeLayer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_agglomerative_layer_mean(s : MlclusteragglomerativeLayer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_agglomerative_layer_scale(s : MlclusteragglomerativeLayer, f : Double) -> MlclusteragglomerativeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_layer_add(a : MlclusteragglomerativeLayer, b : MlclusteragglomerativeLayer) -> MlclusteragglomerativeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_agglomerative_layer_copy(s : MlclusteragglomerativeLayer) -> MlclusteragglomerativeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_layer_fill(s : MlclusteragglomerativeLayer, v : Double) -> MlclusteragglomerativeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_layer_min(s : MlclusteragglomerativeLayer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_agglomerative_layer_max(s : MlclusteragglomerativeLayer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_agglomerative_layer_to_string(s : MlclusteragglomerativeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_buffer_make(size : Int) -> MlclusteragglomerativeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_buffer_len(s : MlclusteragglomerativeBuffer) -> Int { s.size }

pub fn ml_cluster_agglomerative_buffer_get(s : MlclusteragglomerativeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_buffer_set(s : MlclusteragglomerativeBuffer, i : Int, v : Double) -> MlclusteragglomerativeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_buffer_sum(s : MlclusteragglomerativeBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_agglomerative_buffer_mean(s : MlclusteragglomerativeBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_agglomerative_buffer_scale(s : MlclusteragglomerativeBuffer, f : Double) -> MlclusteragglomerativeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_buffer_add(a : MlclusteragglomerativeBuffer, b : MlclusteragglomerativeBuffer) -> MlclusteragglomerativeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_agglomerative_buffer_copy(s : MlclusteragglomerativeBuffer) -> MlclusteragglomerativeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_buffer_fill(s : MlclusteragglomerativeBuffer, v : Double) -> MlclusteragglomerativeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_buffer_min(s : MlclusteragglomerativeBuffer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_agglomerative_buffer_max(s : MlclusteragglomerativeBuffer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_agglomerative_buffer_to_string(s : MlclusteragglomerativeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_cursor_make(size : Int) -> MlclusteragglomerativeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_cursor_len(s : MlclusteragglomerativeCursor) -> Int { s.size }

pub fn ml_cluster_agglomerative_cursor_get(s : MlclusteragglomerativeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_cursor_set(s : MlclusteragglomerativeCursor, i : Int, v : Double) -> MlclusteragglomerativeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_cursor_sum(s : MlclusteragglomerativeCursor) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_agglomerative_cursor_mean(s : MlclusteragglomerativeCursor) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_agglomerative_cursor_scale(s : MlclusteragglomerativeCursor, f : Double) -> MlclusteragglomerativeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_cursor_add(a : MlclusteragglomerativeCursor, b : MlclusteragglomerativeCursor) -> MlclusteragglomerativeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_agglomerative_cursor_copy(s : MlclusteragglomerativeCursor) -> MlclusteragglomerativeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_cursor_fill(s : MlclusteragglomerativeCursor, v : Double) -> MlclusteragglomerativeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_cursor_min(s : MlclusteragglomerativeCursor) -> Double { @_common.min(s.data) }

pub fn ml_cluster_agglomerative_cursor_max(s : MlclusteragglomerativeCursor) -> Double { @_common.max(s.data) }

pub fn ml_cluster_agglomerative_cursor_to_string(s : MlclusteragglomerativeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_view_make(size : Int) -> MlclusteragglomerativeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_view_len(s : MlclusteragglomerativeView) -> Int { s.size }

pub fn ml_cluster_agglomerative_view_get(s : MlclusteragglomerativeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_view_set(s : MlclusteragglomerativeView, i : Int, v : Double) -> MlclusteragglomerativeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_view_sum(s : MlclusteragglomerativeView) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_agglomerative_view_mean(s : MlclusteragglomerativeView) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_agglomerative_view_scale(s : MlclusteragglomerativeView, f : Double) -> MlclusteragglomerativeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_view_add(a : MlclusteragglomerativeView, b : MlclusteragglomerativeView) -> MlclusteragglomerativeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_agglomerative_view_copy(s : MlclusteragglomerativeView) -> MlclusteragglomerativeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_view_fill(s : MlclusteragglomerativeView, v : Double) -> MlclusteragglomerativeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_view_min(s : MlclusteragglomerativeView) -> Double { @_common.min(s.data) }

pub fn ml_cluster_agglomerative_view_max(s : MlclusteragglomerativeView) -> Double { @_common.max(s.data) }

pub fn ml_cluster_agglomerative_view_to_string(s : MlclusteragglomerativeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_range_make(size : Int) -> MlclusteragglomerativeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_range_len(s : MlclusteragglomerativeRange) -> Int { s.size }

pub fn ml_cluster_agglomerative_range_get(s : MlclusteragglomerativeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_range_set(s : MlclusteragglomerativeRange, i : Int, v : Double) -> MlclusteragglomerativeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_range_sum(s : MlclusteragglomerativeRange) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_agglomerative_range_mean(s : MlclusteragglomerativeRange) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_agglomerative_range_scale(s : MlclusteragglomerativeRange, f : Double) -> MlclusteragglomerativeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_range_add(a : MlclusteragglomerativeRange, b : MlclusteragglomerativeRange) -> MlclusteragglomerativeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_agglomerative_range_copy(s : MlclusteragglomerativeRange) -> MlclusteragglomerativeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_range_fill(s : MlclusteragglomerativeRange, v : Double) -> MlclusteragglomerativeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_range_min(s : MlclusteragglomerativeRange) -> Double { @_common.min(s.data) }

pub fn ml_cluster_agglomerative_range_max(s : MlclusteragglomerativeRange) -> Double { @_common.max(s.data) }

pub fn ml_cluster_agglomerative_range_to_string(s : MlclusteragglomerativeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteragglomerativeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_agglomerative_slice_make(size : Int) -> MlclusteragglomerativeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_agglomerative_slice_len(s : MlclusteragglomerativeSlice) -> Int { s.size }

pub fn ml_cluster_agglomerative_slice_get(s : MlclusteragglomerativeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_agglomerative_slice_set(s : MlclusteragglomerativeSlice, i : Int, v : Double) -> MlclusteragglomerativeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_slice_sum(s : MlclusteragglomerativeSlice) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_agglomerative_slice_mean(s : MlclusteragglomerativeSlice) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_agglomerative_slice_scale(s : MlclusteragglomerativeSlice, f : Double) -> MlclusteragglomerativeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_slice_add(a : MlclusteragglomerativeSlice, b : MlclusteragglomerativeSlice) -> MlclusteragglomerativeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_agglomerative_slice_copy(s : MlclusteragglomerativeSlice) -> MlclusteragglomerativeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_slice_fill(s : MlclusteragglomerativeSlice, v : Double) -> MlclusteragglomerativeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_agglomerative_slice_min(s : MlclusteragglomerativeSlice) -> Double { @_common.min(s.data) }

pub fn ml_cluster_agglomerative_slice_max(s : MlclusteragglomerativeSlice) -> Double { @_common.max(s.data) }

pub fn ml_cluster_agglomerative_slice_to_string(s : MlclusteragglomerativeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

