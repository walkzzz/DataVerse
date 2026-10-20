///===
/// extcore/ml_metric_clustering

pub(all) struct MlmetricclusteringPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_clustering_make_point(x : Double, y : Double) -> MlmetricclusteringPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_clustering_make_point3(x : Double, y : Double, z : Double) -> MlmetricclusteringPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetricclusteringPoint::x(self : MlmetricclusteringPoint) -> Double { self.x }

pub fn MlmetricclusteringPoint::y(self : MlmetricclusteringPoint) -> Double { self.y }

pub fn MlmetricclusteringPoint::z(self : MlmetricclusteringPoint) -> Double { self.z }

pub fn MlmetricclusteringPoint::label(self : MlmetricclusteringPoint) -> Int { self.label }

pub fn MlmetricclusteringPoint::dist(self : MlmetricclusteringPoint, other : MlmetricclusteringPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetricclusteringPoint::add(self : MlmetricclusteringPoint, other : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetricclusteringPoint::sub(self : MlmetricclusteringPoint, other : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetricclusteringPoint::scale(self : MlmetricclusteringPoint, s : Double) -> MlmetricclusteringPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetricclusteringPoint::dot(self : MlmetricclusteringPoint, other : MlmetricclusteringPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetricclusteringPoint::cross(self : MlmetricclusteringPoint, other : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetricclusteringPoint::norm(self : MlmetricclusteringPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetricclusteringPoint::normalize(self : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricclusteringPoint::negate(self : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetricclusteringPoint::mid(self : MlmetricclusteringPoint, other : MlmetricclusteringPoint) -> MlmetricclusteringPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetricclusteringPoint::lerp(self : MlmetricclusteringPoint, other : MlmetricclusteringPoint, t : Double) -> MlmetricclusteringPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetricclusteringPoint::to_string(self : MlmetricclusteringPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetricclusteringSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_clustering_make_series(vals : Array[Double], name : String) -> MlmetricclusteringSeries {
  { vals, name, meta: 0 }
}

pub fn MlmetricclusteringSeries::len(self : MlmetricclusteringSeries) -> Int { self.vals.length() }

pub fn MlmetricclusteringSeries::sum(self : MlmetricclusteringSeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetricclusteringSeries::mean(self : MlmetricclusteringSeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetricclusteringSeries::min(self : MlmetricclusteringSeries) -> Double { @_common.min(self.vals) }

pub fn MlmetricclusteringSeries::max(self : MlmetricclusteringSeries) -> Double { @_common.max(self.vals) }

pub fn MlmetricclusteringSeries::range(self : MlmetricclusteringSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetricclusteringSeries::variance(self : MlmetricclusteringSeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetricclusteringSeries::std(self : MlmetricclusteringSeries) -> Double { @_common.std(self.vals) }

pub fn MlmetricclusteringSeries::median(self : MlmetricclusteringSeries) -> Double { @_common.median(self.vals) }

pub fn MlmetricclusteringSeries::scale(self : MlmetricclusteringSeries, f : Double) -> MlmetricclusteringSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetricclusteringSeries::add(self : MlmetricclusteringSeries, other : MlmetricclusteringSeries) -> MlmetricclusteringSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetricclusteringSeries::sub(self : MlmetricclusteringSeries, other : MlmetricclusteringSeries) -> MlmetricclusteringSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetricclusteringSeries::normalize(self : MlmetricclusteringSeries) -> MlmetricclusteringSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetricclusteringSeries::cumsum(self : MlmetricclusteringSeries) -> MlmetricclusteringSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetricclusteringSeries::to_string(self : MlmetricclusteringSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricclusteringMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_clustering_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricclusteringMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_clustering_matrix_identity(n : Int) -> MlmetricclusteringMatrix {
  let m = ml_metric_clustering_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetricclusteringMatrix::get(self : MlmetricclusteringMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetricclusteringMatrix::transpose(self : MlmetricclusteringMatrix) -> MlmetricclusteringMatrix {
  let result = ml_metric_clustering_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetricclusteringMatrix::add(self : MlmetricclusteringMatrix, other : MlmetricclusteringMatrix) -> MlmetricclusteringMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_clustering_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetricclusteringMatrix::scale(self : MlmetricclusteringMatrix, s : Double) -> MlmetricclusteringMatrix {
  let result = ml_metric_clustering_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetricclusteringMatrix::multiply(self : MlmetricclusteringMatrix, other : MlmetricclusteringMatrix) -> MlmetricclusteringMatrix {
  if self.cols != other.rows { return ml_metric_clustering_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_clustering_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlmetricclusteringMatrix::trace(self : MlmetricclusteringMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetricclusteringMatrix::det(self : MlmetricclusteringMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetricclusteringMatrix::norm(self : MlmetricclusteringMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetricclusteringMatrix::to_string(self : MlmetricclusteringMatrix) -> String {
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

pub(all) struct MlmetricclusteringVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_clustering_make_vector(comps : Array[Double]) -> MlmetricclusteringVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_clustering_vector_zero(dim : Int) -> MlmetricclusteringVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetricclusteringVector::add(self : MlmetricclusteringVector, other : MlmetricclusteringVector) -> MlmetricclusteringVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricclusteringVector::sub(self : MlmetricclusteringVector, other : MlmetricclusteringVector) -> MlmetricclusteringVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricclusteringVector::scale(self : MlmetricclusteringVector, s : Double) -> MlmetricclusteringVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetricclusteringVector::dot(self : MlmetricclusteringVector, other : MlmetricclusteringVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetricclusteringVector::norm(self : MlmetricclusteringVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetricclusteringVector::normalize(self : MlmetricclusteringVector) -> MlmetricclusteringVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricclusteringVector::dist(self : MlmetricclusteringVector, other : MlmetricclusteringVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetricclusteringVector::to_string(self : MlmetricclusteringVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_clustering_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_clustering_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_clustering_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_clustering_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_clustering_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_clustering_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_clustering_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_clustering_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_clustering_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_clustering_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_clustering_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_clustering_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_clustering_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_clustering_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_clustering_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_clustering_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_clustering_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_clustering_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_clustering_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_clustering_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_clustering_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_clustering_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_clustering_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_clustering_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_clustering_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_clustering_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_clustering_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_clustering_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_clustering_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricclusteringFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_frame_make(size : Int) -> MlmetricclusteringFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_frame_len(s : MlmetricclusteringFrame) -> Int { s.size }

pub fn ml_metric_clustering_frame_get(s : MlmetricclusteringFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_frame_set(s : MlmetricclusteringFrame, i : Int, v : Double) -> MlmetricclusteringFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_frame_sum(s : MlmetricclusteringFrame) -> Double { @_common.sum(s.data) }

pub fn ml_metric_clustering_frame_mean(s : MlmetricclusteringFrame) -> Double { @_common.mean(s.data) }

pub fn ml_metric_clustering_frame_scale(s : MlmetricclusteringFrame, f : Double) -> MlmetricclusteringFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_frame_add(a : MlmetricclusteringFrame, b : MlmetricclusteringFrame) -> MlmetricclusteringFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_clustering_frame_copy(s : MlmetricclusteringFrame) -> MlmetricclusteringFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_frame_fill(s : MlmetricclusteringFrame, v : Double) -> MlmetricclusteringFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_frame_min(s : MlmetricclusteringFrame) -> Double { @_common.min(s.data) }

pub fn ml_metric_clustering_frame_max(s : MlmetricclusteringFrame) -> Double { @_common.max(s.data) }

pub fn ml_metric_clustering_frame_to_string(s : MlmetricclusteringFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_table_make(size : Int) -> MlmetricclusteringTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_table_len(s : MlmetricclusteringTable) -> Int { s.size }

pub fn ml_metric_clustering_table_get(s : MlmetricclusteringTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_table_set(s : MlmetricclusteringTable, i : Int, v : Double) -> MlmetricclusteringTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_table_sum(s : MlmetricclusteringTable) -> Double { @_common.sum(s.data) }

pub fn ml_metric_clustering_table_mean(s : MlmetricclusteringTable) -> Double { @_common.mean(s.data) }

pub fn ml_metric_clustering_table_scale(s : MlmetricclusteringTable, f : Double) -> MlmetricclusteringTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_table_add(a : MlmetricclusteringTable, b : MlmetricclusteringTable) -> MlmetricclusteringTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_clustering_table_copy(s : MlmetricclusteringTable) -> MlmetricclusteringTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_table_fill(s : MlmetricclusteringTable, v : Double) -> MlmetricclusteringTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_table_min(s : MlmetricclusteringTable) -> Double { @_common.min(s.data) }

pub fn ml_metric_clustering_table_max(s : MlmetricclusteringTable) -> Double { @_common.max(s.data) }

pub fn ml_metric_clustering_table_to_string(s : MlmetricclusteringTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_graphn_make(size : Int) -> MlmetricclusteringGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_graphn_len(s : MlmetricclusteringGraphN) -> Int { s.size }

pub fn ml_metric_clustering_graphn_get(s : MlmetricclusteringGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_graphn_set(s : MlmetricclusteringGraphN, i : Int, v : Double) -> MlmetricclusteringGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_graphn_sum(s : MlmetricclusteringGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_metric_clustering_graphn_mean(s : MlmetricclusteringGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_metric_clustering_graphn_scale(s : MlmetricclusteringGraphN, f : Double) -> MlmetricclusteringGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_graphn_add(a : MlmetricclusteringGraphN, b : MlmetricclusteringGraphN) -> MlmetricclusteringGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_clustering_graphn_copy(s : MlmetricclusteringGraphN) -> MlmetricclusteringGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_graphn_fill(s : MlmetricclusteringGraphN, v : Double) -> MlmetricclusteringGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_graphn_min(s : MlmetricclusteringGraphN) -> Double { @_common.min(s.data) }

pub fn ml_metric_clustering_graphn_max(s : MlmetricclusteringGraphN) -> Double { @_common.max(s.data) }

pub fn ml_metric_clustering_graphn_to_string(s : MlmetricclusteringGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_node_make(size : Int) -> MlmetricclusteringNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_node_len(s : MlmetricclusteringNode) -> Int { s.size }

pub fn ml_metric_clustering_node_get(s : MlmetricclusteringNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_node_set(s : MlmetricclusteringNode, i : Int, v : Double) -> MlmetricclusteringNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_node_sum(s : MlmetricclusteringNode) -> Double { @_common.sum(s.data) }

pub fn ml_metric_clustering_node_mean(s : MlmetricclusteringNode) -> Double { @_common.mean(s.data) }

pub fn ml_metric_clustering_node_scale(s : MlmetricclusteringNode, f : Double) -> MlmetricclusteringNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_node_add(a : MlmetricclusteringNode, b : MlmetricclusteringNode) -> MlmetricclusteringNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_clustering_node_copy(s : MlmetricclusteringNode) -> MlmetricclusteringNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_node_fill(s : MlmetricclusteringNode, v : Double) -> MlmetricclusteringNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_node_min(s : MlmetricclusteringNode) -> Double { @_common.min(s.data) }

pub fn ml_metric_clustering_node_max(s : MlmetricclusteringNode) -> Double { @_common.max(s.data) }

pub fn ml_metric_clustering_node_to_string(s : MlmetricclusteringNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_edge_make(size : Int) -> MlmetricclusteringEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_edge_len(s : MlmetricclusteringEdge) -> Int { s.size }

pub fn ml_metric_clustering_edge_get(s : MlmetricclusteringEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_edge_set(s : MlmetricclusteringEdge, i : Int, v : Double) -> MlmetricclusteringEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_edge_sum(s : MlmetricclusteringEdge) -> Double { @_common.sum(s.data) }

pub fn ml_metric_clustering_edge_mean(s : MlmetricclusteringEdge) -> Double { @_common.mean(s.data) }

pub fn ml_metric_clustering_edge_scale(s : MlmetricclusteringEdge, f : Double) -> MlmetricclusteringEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_edge_add(a : MlmetricclusteringEdge, b : MlmetricclusteringEdge) -> MlmetricclusteringEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_clustering_edge_copy(s : MlmetricclusteringEdge) -> MlmetricclusteringEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_edge_fill(s : MlmetricclusteringEdge, v : Double) -> MlmetricclusteringEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_edge_min(s : MlmetricclusteringEdge) -> Double { @_common.min(s.data) }

pub fn ml_metric_clustering_edge_max(s : MlmetricclusteringEdge) -> Double { @_common.max(s.data) }

pub fn ml_metric_clustering_edge_to_string(s : MlmetricclusteringEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_path_make(size : Int) -> MlmetricclusteringPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_path_len(s : MlmetricclusteringPath) -> Int { s.size }

pub fn ml_metric_clustering_path_get(s : MlmetricclusteringPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_path_set(s : MlmetricclusteringPath, i : Int, v : Double) -> MlmetricclusteringPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_path_sum(s : MlmetricclusteringPath) -> Double { @_common.sum(s.data) }

pub fn ml_metric_clustering_path_mean(s : MlmetricclusteringPath) -> Double { @_common.mean(s.data) }

pub fn ml_metric_clustering_path_scale(s : MlmetricclusteringPath, f : Double) -> MlmetricclusteringPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_path_add(a : MlmetricclusteringPath, b : MlmetricclusteringPath) -> MlmetricclusteringPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_clustering_path_copy(s : MlmetricclusteringPath) -> MlmetricclusteringPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_path_fill(s : MlmetricclusteringPath, v : Double) -> MlmetricclusteringPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_path_min(s : MlmetricclusteringPath) -> Double { @_common.min(s.data) }

pub fn ml_metric_clustering_path_max(s : MlmetricclusteringPath) -> Double { @_common.max(s.data) }

pub fn ml_metric_clustering_path_to_string(s : MlmetricclusteringPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_cluster_make(size : Int) -> MlmetricclusteringCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_cluster_len(s : MlmetricclusteringCluster) -> Int { s.size }

pub fn ml_metric_clustering_cluster_get(s : MlmetricclusteringCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_cluster_set(s : MlmetricclusteringCluster, i : Int, v : Double) -> MlmetricclusteringCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_cluster_sum(s : MlmetricclusteringCluster) -> Double { @_common.sum(s.data) }

pub fn ml_metric_clustering_cluster_mean(s : MlmetricclusteringCluster) -> Double { @_common.mean(s.data) }

pub fn ml_metric_clustering_cluster_scale(s : MlmetricclusteringCluster, f : Double) -> MlmetricclusteringCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_cluster_add(a : MlmetricclusteringCluster, b : MlmetricclusteringCluster) -> MlmetricclusteringCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_clustering_cluster_copy(s : MlmetricclusteringCluster) -> MlmetricclusteringCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_cluster_fill(s : MlmetricclusteringCluster, v : Double) -> MlmetricclusteringCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_cluster_min(s : MlmetricclusteringCluster) -> Double { @_common.min(s.data) }

pub fn ml_metric_clustering_cluster_max(s : MlmetricclusteringCluster) -> Double { @_common.max(s.data) }

pub fn ml_metric_clustering_cluster_to_string(s : MlmetricclusteringCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_model_make(size : Int) -> MlmetricclusteringModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_model_len(s : MlmetricclusteringModel) -> Int { s.size }

pub fn ml_metric_clustering_model_get(s : MlmetricclusteringModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_model_set(s : MlmetricclusteringModel, i : Int, v : Double) -> MlmetricclusteringModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_model_sum(s : MlmetricclusteringModel) -> Double { @_common.sum(s.data) }

pub fn ml_metric_clustering_model_mean(s : MlmetricclusteringModel) -> Double { @_common.mean(s.data) }

pub fn ml_metric_clustering_model_scale(s : MlmetricclusteringModel, f : Double) -> MlmetricclusteringModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_model_add(a : MlmetricclusteringModel, b : MlmetricclusteringModel) -> MlmetricclusteringModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_clustering_model_copy(s : MlmetricclusteringModel) -> MlmetricclusteringModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_model_fill(s : MlmetricclusteringModel, v : Double) -> MlmetricclusteringModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_model_min(s : MlmetricclusteringModel) -> Double { @_common.min(s.data) }

pub fn ml_metric_clustering_model_max(s : MlmetricclusteringModel) -> Double { @_common.max(s.data) }

pub fn ml_metric_clustering_model_to_string(s : MlmetricclusteringModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_layer_make(size : Int) -> MlmetricclusteringLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_layer_len(s : MlmetricclusteringLayer) -> Int { s.size }

pub fn ml_metric_clustering_layer_get(s : MlmetricclusteringLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_layer_set(s : MlmetricclusteringLayer, i : Int, v : Double) -> MlmetricclusteringLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_layer_sum(s : MlmetricclusteringLayer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_clustering_layer_mean(s : MlmetricclusteringLayer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_clustering_layer_scale(s : MlmetricclusteringLayer, f : Double) -> MlmetricclusteringLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_layer_add(a : MlmetricclusteringLayer, b : MlmetricclusteringLayer) -> MlmetricclusteringLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_clustering_layer_copy(s : MlmetricclusteringLayer) -> MlmetricclusteringLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_layer_fill(s : MlmetricclusteringLayer, v : Double) -> MlmetricclusteringLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_layer_min(s : MlmetricclusteringLayer) -> Double { @_common.min(s.data) }

pub fn ml_metric_clustering_layer_max(s : MlmetricclusteringLayer) -> Double { @_common.max(s.data) }

pub fn ml_metric_clustering_layer_to_string(s : MlmetricclusteringLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_buffer_make(size : Int) -> MlmetricclusteringBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_buffer_len(s : MlmetricclusteringBuffer) -> Int { s.size }

pub fn ml_metric_clustering_buffer_get(s : MlmetricclusteringBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_buffer_set(s : MlmetricclusteringBuffer, i : Int, v : Double) -> MlmetricclusteringBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_buffer_sum(s : MlmetricclusteringBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_clustering_buffer_mean(s : MlmetricclusteringBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_clustering_buffer_scale(s : MlmetricclusteringBuffer, f : Double) -> MlmetricclusteringBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_buffer_add(a : MlmetricclusteringBuffer, b : MlmetricclusteringBuffer) -> MlmetricclusteringBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_clustering_buffer_copy(s : MlmetricclusteringBuffer) -> MlmetricclusteringBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_buffer_fill(s : MlmetricclusteringBuffer, v : Double) -> MlmetricclusteringBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_buffer_min(s : MlmetricclusteringBuffer) -> Double { @_common.min(s.data) }

pub fn ml_metric_clustering_buffer_max(s : MlmetricclusteringBuffer) -> Double { @_common.max(s.data) }

pub fn ml_metric_clustering_buffer_to_string(s : MlmetricclusteringBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_cursor_make(size : Int) -> MlmetricclusteringCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_cursor_len(s : MlmetricclusteringCursor) -> Int { s.size }

pub fn ml_metric_clustering_cursor_get(s : MlmetricclusteringCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_cursor_set(s : MlmetricclusteringCursor, i : Int, v : Double) -> MlmetricclusteringCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_cursor_sum(s : MlmetricclusteringCursor) -> Double { @_common.sum(s.data) }

pub fn ml_metric_clustering_cursor_mean(s : MlmetricclusteringCursor) -> Double { @_common.mean(s.data) }

pub fn ml_metric_clustering_cursor_scale(s : MlmetricclusteringCursor, f : Double) -> MlmetricclusteringCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_cursor_add(a : MlmetricclusteringCursor, b : MlmetricclusteringCursor) -> MlmetricclusteringCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_clustering_cursor_copy(s : MlmetricclusteringCursor) -> MlmetricclusteringCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_cursor_fill(s : MlmetricclusteringCursor, v : Double) -> MlmetricclusteringCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_cursor_min(s : MlmetricclusteringCursor) -> Double { @_common.min(s.data) }

pub fn ml_metric_clustering_cursor_max(s : MlmetricclusteringCursor) -> Double { @_common.max(s.data) }

pub fn ml_metric_clustering_cursor_to_string(s : MlmetricclusteringCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_view_make(size : Int) -> MlmetricclusteringView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_view_len(s : MlmetricclusteringView) -> Int { s.size }

pub fn ml_metric_clustering_view_get(s : MlmetricclusteringView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_view_set(s : MlmetricclusteringView, i : Int, v : Double) -> MlmetricclusteringView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_view_sum(s : MlmetricclusteringView) -> Double { @_common.sum(s.data) }

pub fn ml_metric_clustering_view_mean(s : MlmetricclusteringView) -> Double { @_common.mean(s.data) }

pub fn ml_metric_clustering_view_scale(s : MlmetricclusteringView, f : Double) -> MlmetricclusteringView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_view_add(a : MlmetricclusteringView, b : MlmetricclusteringView) -> MlmetricclusteringView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_clustering_view_copy(s : MlmetricclusteringView) -> MlmetricclusteringView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_view_fill(s : MlmetricclusteringView, v : Double) -> MlmetricclusteringView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_view_min(s : MlmetricclusteringView) -> Double { @_common.min(s.data) }

pub fn ml_metric_clustering_view_max(s : MlmetricclusteringView) -> Double { @_common.max(s.data) }

pub fn ml_metric_clustering_view_to_string(s : MlmetricclusteringView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_range_make(size : Int) -> MlmetricclusteringRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_range_len(s : MlmetricclusteringRange) -> Int { s.size }

pub fn ml_metric_clustering_range_get(s : MlmetricclusteringRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_range_set(s : MlmetricclusteringRange, i : Int, v : Double) -> MlmetricclusteringRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_range_sum(s : MlmetricclusteringRange) -> Double { @_common.sum(s.data) }

pub fn ml_metric_clustering_range_mean(s : MlmetricclusteringRange) -> Double { @_common.mean(s.data) }

pub fn ml_metric_clustering_range_scale(s : MlmetricclusteringRange, f : Double) -> MlmetricclusteringRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_range_add(a : MlmetricclusteringRange, b : MlmetricclusteringRange) -> MlmetricclusteringRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_clustering_range_copy(s : MlmetricclusteringRange) -> MlmetricclusteringRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_range_fill(s : MlmetricclusteringRange, v : Double) -> MlmetricclusteringRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_range_min(s : MlmetricclusteringRange) -> Double { @_common.min(s.data) }

pub fn ml_metric_clustering_range_max(s : MlmetricclusteringRange) -> Double { @_common.max(s.data) }

pub fn ml_metric_clustering_range_to_string(s : MlmetricclusteringRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricclusteringSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_clustering_slice_make(size : Int) -> MlmetricclusteringSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_clustering_slice_len(s : MlmetricclusteringSlice) -> Int { s.size }

pub fn ml_metric_clustering_slice_get(s : MlmetricclusteringSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_clustering_slice_set(s : MlmetricclusteringSlice, i : Int, v : Double) -> MlmetricclusteringSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_slice_sum(s : MlmetricclusteringSlice) -> Double { @_common.sum(s.data) }

pub fn ml_metric_clustering_slice_mean(s : MlmetricclusteringSlice) -> Double { @_common.mean(s.data) }

pub fn ml_metric_clustering_slice_scale(s : MlmetricclusteringSlice, f : Double) -> MlmetricclusteringSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_slice_add(a : MlmetricclusteringSlice, b : MlmetricclusteringSlice) -> MlmetricclusteringSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_clustering_slice_copy(s : MlmetricclusteringSlice) -> MlmetricclusteringSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_slice_fill(s : MlmetricclusteringSlice, v : Double) -> MlmetricclusteringSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_clustering_slice_min(s : MlmetricclusteringSlice) -> Double { @_common.min(s.data) }

pub fn ml_metric_clustering_slice_max(s : MlmetricclusteringSlice) -> Double { @_common.max(s.data) }

pub fn ml_metric_clustering_slice_to_string(s : MlmetricclusteringSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

