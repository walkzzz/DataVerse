///===
/// extcore/ml_cluster_gmm

pub(all) struct MlclustergmmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_gmm_make_point(x : Double, y : Double) -> MlclustergmmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_gmm_make_point3(x : Double, y : Double, z : Double) -> MlclustergmmPoint {
  { x, y, z, label: 0 }
}

pub fn MlclustergmmPoint::x(self : MlclustergmmPoint) -> Double { self.x }

pub fn MlclustergmmPoint::y(self : MlclustergmmPoint) -> Double { self.y }

pub fn MlclustergmmPoint::z(self : MlclustergmmPoint) -> Double { self.z }

pub fn MlclustergmmPoint::label(self : MlclustergmmPoint) -> Int { self.label }

pub fn MlclustergmmPoint::dist(self : MlclustergmmPoint, other : MlclustergmmPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclustergmmPoint::add(self : MlclustergmmPoint, other : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclustergmmPoint::sub(self : MlclustergmmPoint, other : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclustergmmPoint::scale(self : MlclustergmmPoint, s : Double) -> MlclustergmmPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclustergmmPoint::dot(self : MlclustergmmPoint, other : MlclustergmmPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclustergmmPoint::cross(self : MlclustergmmPoint, other : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclustergmmPoint::norm(self : MlclustergmmPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclustergmmPoint::normalize(self : MlclustergmmPoint) -> MlclustergmmPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclustergmmPoint::negate(self : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclustergmmPoint::mid(self : MlclustergmmPoint, other : MlclustergmmPoint) -> MlclustergmmPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclustergmmPoint::lerp(self : MlclustergmmPoint, other : MlclustergmmPoint, t : Double) -> MlclustergmmPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclustergmmPoint::to_string(self : MlclustergmmPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclustergmmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_gmm_make_series(vals : Array[Double], name : String) -> MlclustergmmSeries {
  { vals, name, meta: 0 }
}

pub fn MlclustergmmSeries::len(self : MlclustergmmSeries) -> Int { self.vals.length() }

pub fn MlclustergmmSeries::sum(self : MlclustergmmSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclustergmmSeries::mean(self : MlclustergmmSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclustergmmSeries::min(self : MlclustergmmSeries) -> Double { @_common.min(self.vals) }

pub fn MlclustergmmSeries::max(self : MlclustergmmSeries) -> Double { @_common.max(self.vals) }

pub fn MlclustergmmSeries::range(self : MlclustergmmSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclustergmmSeries::variance(self : MlclustergmmSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclustergmmSeries::std(self : MlclustergmmSeries) -> Double { @_common.std(self.vals) }

pub fn MlclustergmmSeries::median(self : MlclustergmmSeries) -> Double { @_common.median(self.vals) }

pub fn MlclustergmmSeries::scale(self : MlclustergmmSeries, f : Double) -> MlclustergmmSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclustergmmSeries::add(self : MlclustergmmSeries, other : MlclustergmmSeries) -> MlclustergmmSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclustergmmSeries::sub(self : MlclustergmmSeries, other : MlclustergmmSeries) -> MlclustergmmSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclustergmmSeries::normalize(self : MlclustergmmSeries) -> MlclustergmmSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclustergmmSeries::cumsum(self : MlclustergmmSeries) -> MlclustergmmSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclustergmmSeries::to_string(self : MlclustergmmSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclustergmmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_gmm_make_matrix(rows : Int, cols : Int, val : Double) -> MlclustergmmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_gmm_matrix_identity(n : Int) -> MlclustergmmMatrix {
  let m = ml_cluster_gmm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclustergmmMatrix::get(self : MlclustergmmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclustergmmMatrix::transpose(self : MlclustergmmMatrix) -> MlclustergmmMatrix {
  let result = ml_cluster_gmm_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclustergmmMatrix::add(self : MlclustergmmMatrix, other : MlclustergmmMatrix) -> MlclustergmmMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_gmm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclustergmmMatrix::scale(self : MlclustergmmMatrix, s : Double) -> MlclustergmmMatrix {
  let result = ml_cluster_gmm_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclustergmmMatrix::multiply(self : MlclustergmmMatrix, other : MlclustergmmMatrix) -> MlclustergmmMatrix {
  if self.cols != other.rows { return ml_cluster_gmm_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_gmm_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclustergmmMatrix::trace(self : MlclustergmmMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclustergmmMatrix::det(self : MlclustergmmMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclustergmmMatrix::norm(self : MlclustergmmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclustergmmMatrix::to_string(self : MlclustergmmMatrix) -> String {
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

pub(all) struct MlclustergmmVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_gmm_make_vector(comps : Array[Double]) -> MlclustergmmVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_gmm_vector_zero(dim : Int) -> MlclustergmmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclustergmmVector::add(self : MlclustergmmVector, other : MlclustergmmVector) -> MlclustergmmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclustergmmVector::sub(self : MlclustergmmVector, other : MlclustergmmVector) -> MlclustergmmVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclustergmmVector::scale(self : MlclustergmmVector, s : Double) -> MlclustergmmVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclustergmmVector::dot(self : MlclustergmmVector, other : MlclustergmmVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclustergmmVector::norm(self : MlclustergmmVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclustergmmVector::normalize(self : MlclustergmmVector) -> MlclustergmmVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclustergmmVector::dist(self : MlclustergmmVector, other : MlclustergmmVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclustergmmVector::to_string(self : MlclustergmmVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_gmm_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_gmm_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_gmm_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_gmm_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_gmm_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_gmm_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_gmm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_gmm_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_gmm_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_gmm_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_gmm_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_gmm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_gmm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_gmm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_gmm_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_gmm_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_gmm_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_gmm_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_gmm_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_gmm_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_gmm_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_gmm_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_gmm_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_gmm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_gmm_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_gmm_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_gmm_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_gmm_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_gmm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclustergmmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_frame_make(size : Int) -> MlclustergmmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_frame_len(s : MlclustergmmFrame) -> Int { s.size }

pub fn ml_cluster_gmm_frame_get(s : MlclustergmmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_frame_set(s : MlclustergmmFrame, i : Int, v : Double) -> MlclustergmmFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_frame_sum(s : MlclustergmmFrame) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_gmm_frame_mean(s : MlclustergmmFrame) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_gmm_frame_scale(s : MlclustergmmFrame, f : Double) -> MlclustergmmFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_frame_add(a : MlclustergmmFrame, b : MlclustergmmFrame) -> MlclustergmmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_gmm_frame_copy(s : MlclustergmmFrame) -> MlclustergmmFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_frame_fill(s : MlclustergmmFrame, v : Double) -> MlclustergmmFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_frame_min(s : MlclustergmmFrame) -> Double { @_common.min(s.data) }

pub fn ml_cluster_gmm_frame_max(s : MlclustergmmFrame) -> Double { @_common.max(s.data) }

pub fn ml_cluster_gmm_frame_to_string(s : MlclustergmmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_table_make(size : Int) -> MlclustergmmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_table_len(s : MlclustergmmTable) -> Int { s.size }

pub fn ml_cluster_gmm_table_get(s : MlclustergmmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_table_set(s : MlclustergmmTable, i : Int, v : Double) -> MlclustergmmTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_table_sum(s : MlclustergmmTable) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_gmm_table_mean(s : MlclustergmmTable) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_gmm_table_scale(s : MlclustergmmTable, f : Double) -> MlclustergmmTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_table_add(a : MlclustergmmTable, b : MlclustergmmTable) -> MlclustergmmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_gmm_table_copy(s : MlclustergmmTable) -> MlclustergmmTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_table_fill(s : MlclustergmmTable, v : Double) -> MlclustergmmTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_table_min(s : MlclustergmmTable) -> Double { @_common.min(s.data) }

pub fn ml_cluster_gmm_table_max(s : MlclustergmmTable) -> Double { @_common.max(s.data) }

pub fn ml_cluster_gmm_table_to_string(s : MlclustergmmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_graphn_make(size : Int) -> MlclustergmmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_graphn_len(s : MlclustergmmGraphN) -> Int { s.size }

pub fn ml_cluster_gmm_graphn_get(s : MlclustergmmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_graphn_set(s : MlclustergmmGraphN, i : Int, v : Double) -> MlclustergmmGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_graphn_sum(s : MlclustergmmGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_gmm_graphn_mean(s : MlclustergmmGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_gmm_graphn_scale(s : MlclustergmmGraphN, f : Double) -> MlclustergmmGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_graphn_add(a : MlclustergmmGraphN, b : MlclustergmmGraphN) -> MlclustergmmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_gmm_graphn_copy(s : MlclustergmmGraphN) -> MlclustergmmGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_graphn_fill(s : MlclustergmmGraphN, v : Double) -> MlclustergmmGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_graphn_min(s : MlclustergmmGraphN) -> Double { @_common.min(s.data) }

pub fn ml_cluster_gmm_graphn_max(s : MlclustergmmGraphN) -> Double { @_common.max(s.data) }

pub fn ml_cluster_gmm_graphn_to_string(s : MlclustergmmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_node_make(size : Int) -> MlclustergmmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_node_len(s : MlclustergmmNode) -> Int { s.size }

pub fn ml_cluster_gmm_node_get(s : MlclustergmmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_node_set(s : MlclustergmmNode, i : Int, v : Double) -> MlclustergmmNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_node_sum(s : MlclustergmmNode) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_gmm_node_mean(s : MlclustergmmNode) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_gmm_node_scale(s : MlclustergmmNode, f : Double) -> MlclustergmmNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_node_add(a : MlclustergmmNode, b : MlclustergmmNode) -> MlclustergmmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_gmm_node_copy(s : MlclustergmmNode) -> MlclustergmmNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_node_fill(s : MlclustergmmNode, v : Double) -> MlclustergmmNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_node_min(s : MlclustergmmNode) -> Double { @_common.min(s.data) }

pub fn ml_cluster_gmm_node_max(s : MlclustergmmNode) -> Double { @_common.max(s.data) }

pub fn ml_cluster_gmm_node_to_string(s : MlclustergmmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_edge_make(size : Int) -> MlclustergmmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_edge_len(s : MlclustergmmEdge) -> Int { s.size }

pub fn ml_cluster_gmm_edge_get(s : MlclustergmmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_edge_set(s : MlclustergmmEdge, i : Int, v : Double) -> MlclustergmmEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_edge_sum(s : MlclustergmmEdge) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_gmm_edge_mean(s : MlclustergmmEdge) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_gmm_edge_scale(s : MlclustergmmEdge, f : Double) -> MlclustergmmEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_edge_add(a : MlclustergmmEdge, b : MlclustergmmEdge) -> MlclustergmmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_gmm_edge_copy(s : MlclustergmmEdge) -> MlclustergmmEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_edge_fill(s : MlclustergmmEdge, v : Double) -> MlclustergmmEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_edge_min(s : MlclustergmmEdge) -> Double { @_common.min(s.data) }

pub fn ml_cluster_gmm_edge_max(s : MlclustergmmEdge) -> Double { @_common.max(s.data) }

pub fn ml_cluster_gmm_edge_to_string(s : MlclustergmmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_path_make(size : Int) -> MlclustergmmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_path_len(s : MlclustergmmPath) -> Int { s.size }

pub fn ml_cluster_gmm_path_get(s : MlclustergmmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_path_set(s : MlclustergmmPath, i : Int, v : Double) -> MlclustergmmPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_path_sum(s : MlclustergmmPath) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_gmm_path_mean(s : MlclustergmmPath) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_gmm_path_scale(s : MlclustergmmPath, f : Double) -> MlclustergmmPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_path_add(a : MlclustergmmPath, b : MlclustergmmPath) -> MlclustergmmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_gmm_path_copy(s : MlclustergmmPath) -> MlclustergmmPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_path_fill(s : MlclustergmmPath, v : Double) -> MlclustergmmPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_path_min(s : MlclustergmmPath) -> Double { @_common.min(s.data) }

pub fn ml_cluster_gmm_path_max(s : MlclustergmmPath) -> Double { @_common.max(s.data) }

pub fn ml_cluster_gmm_path_to_string(s : MlclustergmmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_cluster_make(size : Int) -> MlclustergmmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_cluster_len(s : MlclustergmmCluster) -> Int { s.size }

pub fn ml_cluster_gmm_cluster_get(s : MlclustergmmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_cluster_set(s : MlclustergmmCluster, i : Int, v : Double) -> MlclustergmmCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_cluster_sum(s : MlclustergmmCluster) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_gmm_cluster_mean(s : MlclustergmmCluster) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_gmm_cluster_scale(s : MlclustergmmCluster, f : Double) -> MlclustergmmCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_cluster_add(a : MlclustergmmCluster, b : MlclustergmmCluster) -> MlclustergmmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_gmm_cluster_copy(s : MlclustergmmCluster) -> MlclustergmmCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_cluster_fill(s : MlclustergmmCluster, v : Double) -> MlclustergmmCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_cluster_min(s : MlclustergmmCluster) -> Double { @_common.min(s.data) }

pub fn ml_cluster_gmm_cluster_max(s : MlclustergmmCluster) -> Double { @_common.max(s.data) }

pub fn ml_cluster_gmm_cluster_to_string(s : MlclustergmmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_model_make(size : Int) -> MlclustergmmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_model_len(s : MlclustergmmModel) -> Int { s.size }

pub fn ml_cluster_gmm_model_get(s : MlclustergmmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_model_set(s : MlclustergmmModel, i : Int, v : Double) -> MlclustergmmModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_model_sum(s : MlclustergmmModel) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_gmm_model_mean(s : MlclustergmmModel) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_gmm_model_scale(s : MlclustergmmModel, f : Double) -> MlclustergmmModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_model_add(a : MlclustergmmModel, b : MlclustergmmModel) -> MlclustergmmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_gmm_model_copy(s : MlclustergmmModel) -> MlclustergmmModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_model_fill(s : MlclustergmmModel, v : Double) -> MlclustergmmModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_model_min(s : MlclustergmmModel) -> Double { @_common.min(s.data) }

pub fn ml_cluster_gmm_model_max(s : MlclustergmmModel) -> Double { @_common.max(s.data) }

pub fn ml_cluster_gmm_model_to_string(s : MlclustergmmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_layer_make(size : Int) -> MlclustergmmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_layer_len(s : MlclustergmmLayer) -> Int { s.size }

pub fn ml_cluster_gmm_layer_get(s : MlclustergmmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_layer_set(s : MlclustergmmLayer, i : Int, v : Double) -> MlclustergmmLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_layer_sum(s : MlclustergmmLayer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_gmm_layer_mean(s : MlclustergmmLayer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_gmm_layer_scale(s : MlclustergmmLayer, f : Double) -> MlclustergmmLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_layer_add(a : MlclustergmmLayer, b : MlclustergmmLayer) -> MlclustergmmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_gmm_layer_copy(s : MlclustergmmLayer) -> MlclustergmmLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_layer_fill(s : MlclustergmmLayer, v : Double) -> MlclustergmmLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_layer_min(s : MlclustergmmLayer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_gmm_layer_max(s : MlclustergmmLayer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_gmm_layer_to_string(s : MlclustergmmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_buffer_make(size : Int) -> MlclustergmmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_buffer_len(s : MlclustergmmBuffer) -> Int { s.size }

pub fn ml_cluster_gmm_buffer_get(s : MlclustergmmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_buffer_set(s : MlclustergmmBuffer, i : Int, v : Double) -> MlclustergmmBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_buffer_sum(s : MlclustergmmBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_gmm_buffer_mean(s : MlclustergmmBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_gmm_buffer_scale(s : MlclustergmmBuffer, f : Double) -> MlclustergmmBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_buffer_add(a : MlclustergmmBuffer, b : MlclustergmmBuffer) -> MlclustergmmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_gmm_buffer_copy(s : MlclustergmmBuffer) -> MlclustergmmBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_buffer_fill(s : MlclustergmmBuffer, v : Double) -> MlclustergmmBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_buffer_min(s : MlclustergmmBuffer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_gmm_buffer_max(s : MlclustergmmBuffer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_gmm_buffer_to_string(s : MlclustergmmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_cursor_make(size : Int) -> MlclustergmmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_cursor_len(s : MlclustergmmCursor) -> Int { s.size }

pub fn ml_cluster_gmm_cursor_get(s : MlclustergmmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_cursor_set(s : MlclustergmmCursor, i : Int, v : Double) -> MlclustergmmCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_cursor_sum(s : MlclustergmmCursor) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_gmm_cursor_mean(s : MlclustergmmCursor) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_gmm_cursor_scale(s : MlclustergmmCursor, f : Double) -> MlclustergmmCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_cursor_add(a : MlclustergmmCursor, b : MlclustergmmCursor) -> MlclustergmmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_gmm_cursor_copy(s : MlclustergmmCursor) -> MlclustergmmCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_cursor_fill(s : MlclustergmmCursor, v : Double) -> MlclustergmmCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_cursor_min(s : MlclustergmmCursor) -> Double { @_common.min(s.data) }

pub fn ml_cluster_gmm_cursor_max(s : MlclustergmmCursor) -> Double { @_common.max(s.data) }

pub fn ml_cluster_gmm_cursor_to_string(s : MlclustergmmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_view_make(size : Int) -> MlclustergmmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_view_len(s : MlclustergmmView) -> Int { s.size }

pub fn ml_cluster_gmm_view_get(s : MlclustergmmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_view_set(s : MlclustergmmView, i : Int, v : Double) -> MlclustergmmView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_view_sum(s : MlclustergmmView) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_gmm_view_mean(s : MlclustergmmView) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_gmm_view_scale(s : MlclustergmmView, f : Double) -> MlclustergmmView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_view_add(a : MlclustergmmView, b : MlclustergmmView) -> MlclustergmmView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_gmm_view_copy(s : MlclustergmmView) -> MlclustergmmView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_view_fill(s : MlclustergmmView, v : Double) -> MlclustergmmView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_view_min(s : MlclustergmmView) -> Double { @_common.min(s.data) }

pub fn ml_cluster_gmm_view_max(s : MlclustergmmView) -> Double { @_common.max(s.data) }

pub fn ml_cluster_gmm_view_to_string(s : MlclustergmmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_range_make(size : Int) -> MlclustergmmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_range_len(s : MlclustergmmRange) -> Int { s.size }

pub fn ml_cluster_gmm_range_get(s : MlclustergmmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_range_set(s : MlclustergmmRange, i : Int, v : Double) -> MlclustergmmRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_range_sum(s : MlclustergmmRange) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_gmm_range_mean(s : MlclustergmmRange) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_gmm_range_scale(s : MlclustergmmRange, f : Double) -> MlclustergmmRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_range_add(a : MlclustergmmRange, b : MlclustergmmRange) -> MlclustergmmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_gmm_range_copy(s : MlclustergmmRange) -> MlclustergmmRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_range_fill(s : MlclustergmmRange, v : Double) -> MlclustergmmRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_range_min(s : MlclustergmmRange) -> Double { @_common.min(s.data) }

pub fn ml_cluster_gmm_range_max(s : MlclustergmmRange) -> Double { @_common.max(s.data) }

pub fn ml_cluster_gmm_range_to_string(s : MlclustergmmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclustergmmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_gmm_slice_make(size : Int) -> MlclustergmmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_gmm_slice_len(s : MlclustergmmSlice) -> Int { s.size }

pub fn ml_cluster_gmm_slice_get(s : MlclustergmmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_gmm_slice_set(s : MlclustergmmSlice, i : Int, v : Double) -> MlclustergmmSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_slice_sum(s : MlclustergmmSlice) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_gmm_slice_mean(s : MlclustergmmSlice) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_gmm_slice_scale(s : MlclustergmmSlice, f : Double) -> MlclustergmmSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_slice_add(a : MlclustergmmSlice, b : MlclustergmmSlice) -> MlclustergmmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_gmm_slice_copy(s : MlclustergmmSlice) -> MlclustergmmSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_slice_fill(s : MlclustergmmSlice, v : Double) -> MlclustergmmSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_gmm_slice_min(s : MlclustergmmSlice) -> Double { @_common.min(s.data) }

pub fn ml_cluster_gmm_slice_max(s : MlclustergmmSlice) -> Double { @_common.max(s.data) }

pub fn ml_cluster_gmm_slice_to_string(s : MlclustergmmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

