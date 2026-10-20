///===
/// extcore/ml_cluster_hierarchical

pub(all) struct MlclusterhierarchicalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_hierarchical_make_point(x : Double, y : Double) -> MlclusterhierarchicalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_hierarchical_make_point3(x : Double, y : Double, z : Double) -> MlclusterhierarchicalPoint {
  { x, y, z, label: 0 }
}

pub fn MlclusterhierarchicalPoint::x(self : MlclusterhierarchicalPoint) -> Double { self.x }

pub fn MlclusterhierarchicalPoint::y(self : MlclusterhierarchicalPoint) -> Double { self.y }

pub fn MlclusterhierarchicalPoint::z(self : MlclusterhierarchicalPoint) -> Double { self.z }

pub fn MlclusterhierarchicalPoint::label(self : MlclusterhierarchicalPoint) -> Int { self.label }

pub fn MlclusterhierarchicalPoint::dist(self : MlclusterhierarchicalPoint, other : MlclusterhierarchicalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclusterhierarchicalPoint::add(self : MlclusterhierarchicalPoint, other : MlclusterhierarchicalPoint) -> MlclusterhierarchicalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclusterhierarchicalPoint::sub(self : MlclusterhierarchicalPoint, other : MlclusterhierarchicalPoint) -> MlclusterhierarchicalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclusterhierarchicalPoint::scale(self : MlclusterhierarchicalPoint, s : Double) -> MlclusterhierarchicalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclusterhierarchicalPoint::dot(self : MlclusterhierarchicalPoint, other : MlclusterhierarchicalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclusterhierarchicalPoint::cross(self : MlclusterhierarchicalPoint, other : MlclusterhierarchicalPoint) -> MlclusterhierarchicalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclusterhierarchicalPoint::norm(self : MlclusterhierarchicalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclusterhierarchicalPoint::normalize(self : MlclusterhierarchicalPoint) -> MlclusterhierarchicalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterhierarchicalPoint::negate(self : MlclusterhierarchicalPoint) -> MlclusterhierarchicalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclusterhierarchicalPoint::mid(self : MlclusterhierarchicalPoint, other : MlclusterhierarchicalPoint) -> MlclusterhierarchicalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclusterhierarchicalPoint::lerp(self : MlclusterhierarchicalPoint, other : MlclusterhierarchicalPoint, t : Double) -> MlclusterhierarchicalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclusterhierarchicalPoint::to_string(self : MlclusterhierarchicalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_hierarchical_make_series(vals : Array[Double], name : String) -> MlclusterhierarchicalSeries {
  { vals, name, meta: 0 }
}

pub fn MlclusterhierarchicalSeries::len(self : MlclusterhierarchicalSeries) -> Int { self.vals.length() }

pub fn MlclusterhierarchicalSeries::sum(self : MlclusterhierarchicalSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclusterhierarchicalSeries::mean(self : MlclusterhierarchicalSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclusterhierarchicalSeries::min(self : MlclusterhierarchicalSeries) -> Double { @_common.min(self.vals) }

pub fn MlclusterhierarchicalSeries::max(self : MlclusterhierarchicalSeries) -> Double { @_common.max(self.vals) }

pub fn MlclusterhierarchicalSeries::range(self : MlclusterhierarchicalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclusterhierarchicalSeries::variance(self : MlclusterhierarchicalSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclusterhierarchicalSeries::std(self : MlclusterhierarchicalSeries) -> Double { @_common.std(self.vals) }

pub fn MlclusterhierarchicalSeries::median(self : MlclusterhierarchicalSeries) -> Double { @_common.median(self.vals) }

pub fn MlclusterhierarchicalSeries::scale(self : MlclusterhierarchicalSeries, f : Double) -> MlclusterhierarchicalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclusterhierarchicalSeries::add(self : MlclusterhierarchicalSeries, other : MlclusterhierarchicalSeries) -> MlclusterhierarchicalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclusterhierarchicalSeries::sub(self : MlclusterhierarchicalSeries, other : MlclusterhierarchicalSeries) -> MlclusterhierarchicalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclusterhierarchicalSeries::normalize(self : MlclusterhierarchicalSeries) -> MlclusterhierarchicalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclusterhierarchicalSeries::cumsum(self : MlclusterhierarchicalSeries) -> MlclusterhierarchicalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclusterhierarchicalSeries::to_string(self : MlclusterhierarchicalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusterhierarchicalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_hierarchical_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusterhierarchicalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_hierarchical_matrix_identity(n : Int) -> MlclusterhierarchicalMatrix {
  let m = ml_cluster_hierarchical_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclusterhierarchicalMatrix::get(self : MlclusterhierarchicalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclusterhierarchicalMatrix::transpose(self : MlclusterhierarchicalMatrix) -> MlclusterhierarchicalMatrix {
  let result = ml_cluster_hierarchical_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclusterhierarchicalMatrix::add(self : MlclusterhierarchicalMatrix, other : MlclusterhierarchicalMatrix) -> MlclusterhierarchicalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_hierarchical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclusterhierarchicalMatrix::scale(self : MlclusterhierarchicalMatrix, s : Double) -> MlclusterhierarchicalMatrix {
  let result = ml_cluster_hierarchical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclusterhierarchicalMatrix::multiply(self : MlclusterhierarchicalMatrix, other : MlclusterhierarchicalMatrix) -> MlclusterhierarchicalMatrix {
  if self.cols != other.rows { return ml_cluster_hierarchical_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_hierarchical_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclusterhierarchicalMatrix::trace(self : MlclusterhierarchicalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclusterhierarchicalMatrix::det(self : MlclusterhierarchicalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclusterhierarchicalMatrix::norm(self : MlclusterhierarchicalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclusterhierarchicalMatrix::to_string(self : MlclusterhierarchicalMatrix) -> String {
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

pub(all) struct MlclusterhierarchicalVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_hierarchical_make_vector(comps : Array[Double]) -> MlclusterhierarchicalVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_hierarchical_vector_zero(dim : Int) -> MlclusterhierarchicalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclusterhierarchicalVector::add(self : MlclusterhierarchicalVector, other : MlclusterhierarchicalVector) -> MlclusterhierarchicalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterhierarchicalVector::sub(self : MlclusterhierarchicalVector, other : MlclusterhierarchicalVector) -> MlclusterhierarchicalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterhierarchicalVector::scale(self : MlclusterhierarchicalVector, s : Double) -> MlclusterhierarchicalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclusterhierarchicalVector::dot(self : MlclusterhierarchicalVector, other : MlclusterhierarchicalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclusterhierarchicalVector::norm(self : MlclusterhierarchicalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclusterhierarchicalVector::normalize(self : MlclusterhierarchicalVector) -> MlclusterhierarchicalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterhierarchicalVector::dist(self : MlclusterhierarchicalVector, other : MlclusterhierarchicalVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclusterhierarchicalVector::to_string(self : MlclusterhierarchicalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_hierarchical_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_hierarchical_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_hierarchical_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_hierarchical_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_hierarchical_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_hierarchical_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_hierarchical_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_hierarchical_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_hierarchical_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_hierarchical_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_hierarchical_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_hierarchical_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_hierarchical_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_hierarchical_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_hierarchical_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_hierarchical_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_hierarchical_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_hierarchical_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_hierarchical_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_hierarchical_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_hierarchical_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_hierarchical_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_hierarchical_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_hierarchical_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_hierarchical_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_hierarchical_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_hierarchical_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_hierarchical_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_hierarchical_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclusterhierarchicalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_frame_make(size : Int) -> MlclusterhierarchicalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_hierarchical_frame_len(s : MlclusterhierarchicalFrame) -> Int { s.size }

pub fn ml_cluster_hierarchical_frame_get(s : MlclusterhierarchicalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_hierarchical_frame_set(s : MlclusterhierarchicalFrame, i : Int, v : Double) -> MlclusterhierarchicalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_frame_sum(s : MlclusterhierarchicalFrame) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_hierarchical_frame_mean(s : MlclusterhierarchicalFrame) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_hierarchical_frame_scale(s : MlclusterhierarchicalFrame, f : Double) -> MlclusterhierarchicalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_frame_add(a : MlclusterhierarchicalFrame, b : MlclusterhierarchicalFrame) -> MlclusterhierarchicalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_hierarchical_frame_copy(s : MlclusterhierarchicalFrame) -> MlclusterhierarchicalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_frame_fill(s : MlclusterhierarchicalFrame, v : Double) -> MlclusterhierarchicalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_frame_min(s : MlclusterhierarchicalFrame) -> Double { @_common.min(s.data) }

pub fn ml_cluster_hierarchical_frame_max(s : MlclusterhierarchicalFrame) -> Double { @_common.max(s.data) }

pub fn ml_cluster_hierarchical_frame_to_string(s : MlclusterhierarchicalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_table_make(size : Int) -> MlclusterhierarchicalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_hierarchical_table_len(s : MlclusterhierarchicalTable) -> Int { s.size }

pub fn ml_cluster_hierarchical_table_get(s : MlclusterhierarchicalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_hierarchical_table_set(s : MlclusterhierarchicalTable, i : Int, v : Double) -> MlclusterhierarchicalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_table_sum(s : MlclusterhierarchicalTable) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_hierarchical_table_mean(s : MlclusterhierarchicalTable) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_hierarchical_table_scale(s : MlclusterhierarchicalTable, f : Double) -> MlclusterhierarchicalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_table_add(a : MlclusterhierarchicalTable, b : MlclusterhierarchicalTable) -> MlclusterhierarchicalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_hierarchical_table_copy(s : MlclusterhierarchicalTable) -> MlclusterhierarchicalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_table_fill(s : MlclusterhierarchicalTable, v : Double) -> MlclusterhierarchicalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_table_min(s : MlclusterhierarchicalTable) -> Double { @_common.min(s.data) }

pub fn ml_cluster_hierarchical_table_max(s : MlclusterhierarchicalTable) -> Double { @_common.max(s.data) }

pub fn ml_cluster_hierarchical_table_to_string(s : MlclusterhierarchicalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_graphn_make(size : Int) -> MlclusterhierarchicalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_hierarchical_graphn_len(s : MlclusterhierarchicalGraphN) -> Int { s.size }

pub fn ml_cluster_hierarchical_graphn_get(s : MlclusterhierarchicalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_hierarchical_graphn_set(s : MlclusterhierarchicalGraphN, i : Int, v : Double) -> MlclusterhierarchicalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_graphn_sum(s : MlclusterhierarchicalGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_hierarchical_graphn_mean(s : MlclusterhierarchicalGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_hierarchical_graphn_scale(s : MlclusterhierarchicalGraphN, f : Double) -> MlclusterhierarchicalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_graphn_add(a : MlclusterhierarchicalGraphN, b : MlclusterhierarchicalGraphN) -> MlclusterhierarchicalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_hierarchical_graphn_copy(s : MlclusterhierarchicalGraphN) -> MlclusterhierarchicalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_graphn_fill(s : MlclusterhierarchicalGraphN, v : Double) -> MlclusterhierarchicalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_graphn_min(s : MlclusterhierarchicalGraphN) -> Double { @_common.min(s.data) }

pub fn ml_cluster_hierarchical_graphn_max(s : MlclusterhierarchicalGraphN) -> Double { @_common.max(s.data) }

pub fn ml_cluster_hierarchical_graphn_to_string(s : MlclusterhierarchicalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_node_make(size : Int) -> MlclusterhierarchicalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_hierarchical_node_len(s : MlclusterhierarchicalNode) -> Int { s.size }

pub fn ml_cluster_hierarchical_node_get(s : MlclusterhierarchicalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_hierarchical_node_set(s : MlclusterhierarchicalNode, i : Int, v : Double) -> MlclusterhierarchicalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_node_sum(s : MlclusterhierarchicalNode) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_hierarchical_node_mean(s : MlclusterhierarchicalNode) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_hierarchical_node_scale(s : MlclusterhierarchicalNode, f : Double) -> MlclusterhierarchicalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_node_add(a : MlclusterhierarchicalNode, b : MlclusterhierarchicalNode) -> MlclusterhierarchicalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_hierarchical_node_copy(s : MlclusterhierarchicalNode) -> MlclusterhierarchicalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_node_fill(s : MlclusterhierarchicalNode, v : Double) -> MlclusterhierarchicalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_node_min(s : MlclusterhierarchicalNode) -> Double { @_common.min(s.data) }

pub fn ml_cluster_hierarchical_node_max(s : MlclusterhierarchicalNode) -> Double { @_common.max(s.data) }

pub fn ml_cluster_hierarchical_node_to_string(s : MlclusterhierarchicalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_edge_make(size : Int) -> MlclusterhierarchicalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_hierarchical_edge_len(s : MlclusterhierarchicalEdge) -> Int { s.size }

pub fn ml_cluster_hierarchical_edge_get(s : MlclusterhierarchicalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_hierarchical_edge_set(s : MlclusterhierarchicalEdge, i : Int, v : Double) -> MlclusterhierarchicalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_edge_sum(s : MlclusterhierarchicalEdge) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_hierarchical_edge_mean(s : MlclusterhierarchicalEdge) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_hierarchical_edge_scale(s : MlclusterhierarchicalEdge, f : Double) -> MlclusterhierarchicalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_edge_add(a : MlclusterhierarchicalEdge, b : MlclusterhierarchicalEdge) -> MlclusterhierarchicalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_hierarchical_edge_copy(s : MlclusterhierarchicalEdge) -> MlclusterhierarchicalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_edge_fill(s : MlclusterhierarchicalEdge, v : Double) -> MlclusterhierarchicalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_edge_min(s : MlclusterhierarchicalEdge) -> Double { @_common.min(s.data) }

pub fn ml_cluster_hierarchical_edge_max(s : MlclusterhierarchicalEdge) -> Double { @_common.max(s.data) }

pub fn ml_cluster_hierarchical_edge_to_string(s : MlclusterhierarchicalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_path_make(size : Int) -> MlclusterhierarchicalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_hierarchical_path_len(s : MlclusterhierarchicalPath) -> Int { s.size }

pub fn ml_cluster_hierarchical_path_get(s : MlclusterhierarchicalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_hierarchical_path_set(s : MlclusterhierarchicalPath, i : Int, v : Double) -> MlclusterhierarchicalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_path_sum(s : MlclusterhierarchicalPath) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_hierarchical_path_mean(s : MlclusterhierarchicalPath) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_hierarchical_path_scale(s : MlclusterhierarchicalPath, f : Double) -> MlclusterhierarchicalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_path_add(a : MlclusterhierarchicalPath, b : MlclusterhierarchicalPath) -> MlclusterhierarchicalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_hierarchical_path_copy(s : MlclusterhierarchicalPath) -> MlclusterhierarchicalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_path_fill(s : MlclusterhierarchicalPath, v : Double) -> MlclusterhierarchicalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_path_min(s : MlclusterhierarchicalPath) -> Double { @_common.min(s.data) }

pub fn ml_cluster_hierarchical_path_max(s : MlclusterhierarchicalPath) -> Double { @_common.max(s.data) }

pub fn ml_cluster_hierarchical_path_to_string(s : MlclusterhierarchicalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_cluster_make(size : Int) -> MlclusterhierarchicalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_hierarchical_cluster_len(s : MlclusterhierarchicalCluster) -> Int { s.size }

pub fn ml_cluster_hierarchical_cluster_get(s : MlclusterhierarchicalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_hierarchical_cluster_set(s : MlclusterhierarchicalCluster, i : Int, v : Double) -> MlclusterhierarchicalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_cluster_sum(s : MlclusterhierarchicalCluster) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_hierarchical_cluster_mean(s : MlclusterhierarchicalCluster) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_hierarchical_cluster_scale(s : MlclusterhierarchicalCluster, f : Double) -> MlclusterhierarchicalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_cluster_add(a : MlclusterhierarchicalCluster, b : MlclusterhierarchicalCluster) -> MlclusterhierarchicalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_hierarchical_cluster_copy(s : MlclusterhierarchicalCluster) -> MlclusterhierarchicalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_cluster_fill(s : MlclusterhierarchicalCluster, v : Double) -> MlclusterhierarchicalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_cluster_min(s : MlclusterhierarchicalCluster) -> Double { @_common.min(s.data) }

pub fn ml_cluster_hierarchical_cluster_max(s : MlclusterhierarchicalCluster) -> Double { @_common.max(s.data) }

pub fn ml_cluster_hierarchical_cluster_to_string(s : MlclusterhierarchicalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_model_make(size : Int) -> MlclusterhierarchicalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_hierarchical_model_len(s : MlclusterhierarchicalModel) -> Int { s.size }

pub fn ml_cluster_hierarchical_model_get(s : MlclusterhierarchicalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_hierarchical_model_set(s : MlclusterhierarchicalModel, i : Int, v : Double) -> MlclusterhierarchicalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_model_sum(s : MlclusterhierarchicalModel) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_hierarchical_model_mean(s : MlclusterhierarchicalModel) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_hierarchical_model_scale(s : MlclusterhierarchicalModel, f : Double) -> MlclusterhierarchicalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_model_add(a : MlclusterhierarchicalModel, b : MlclusterhierarchicalModel) -> MlclusterhierarchicalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_hierarchical_model_copy(s : MlclusterhierarchicalModel) -> MlclusterhierarchicalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_model_fill(s : MlclusterhierarchicalModel, v : Double) -> MlclusterhierarchicalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_model_min(s : MlclusterhierarchicalModel) -> Double { @_common.min(s.data) }

pub fn ml_cluster_hierarchical_model_max(s : MlclusterhierarchicalModel) -> Double { @_common.max(s.data) }

pub fn ml_cluster_hierarchical_model_to_string(s : MlclusterhierarchicalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_layer_make(size : Int) -> MlclusterhierarchicalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_hierarchical_layer_len(s : MlclusterhierarchicalLayer) -> Int { s.size }

pub fn ml_cluster_hierarchical_layer_get(s : MlclusterhierarchicalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_hierarchical_layer_set(s : MlclusterhierarchicalLayer, i : Int, v : Double) -> MlclusterhierarchicalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_layer_sum(s : MlclusterhierarchicalLayer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_hierarchical_layer_mean(s : MlclusterhierarchicalLayer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_hierarchical_layer_scale(s : MlclusterhierarchicalLayer, f : Double) -> MlclusterhierarchicalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_layer_add(a : MlclusterhierarchicalLayer, b : MlclusterhierarchicalLayer) -> MlclusterhierarchicalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_hierarchical_layer_copy(s : MlclusterhierarchicalLayer) -> MlclusterhierarchicalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_layer_fill(s : MlclusterhierarchicalLayer, v : Double) -> MlclusterhierarchicalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_layer_min(s : MlclusterhierarchicalLayer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_hierarchical_layer_max(s : MlclusterhierarchicalLayer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_hierarchical_layer_to_string(s : MlclusterhierarchicalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_buffer_make(size : Int) -> MlclusterhierarchicalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_hierarchical_buffer_len(s : MlclusterhierarchicalBuffer) -> Int { s.size }

pub fn ml_cluster_hierarchical_buffer_get(s : MlclusterhierarchicalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_hierarchical_buffer_set(s : MlclusterhierarchicalBuffer, i : Int, v : Double) -> MlclusterhierarchicalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_buffer_sum(s : MlclusterhierarchicalBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_hierarchical_buffer_mean(s : MlclusterhierarchicalBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_hierarchical_buffer_scale(s : MlclusterhierarchicalBuffer, f : Double) -> MlclusterhierarchicalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_buffer_add(a : MlclusterhierarchicalBuffer, b : MlclusterhierarchicalBuffer) -> MlclusterhierarchicalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_hierarchical_buffer_copy(s : MlclusterhierarchicalBuffer) -> MlclusterhierarchicalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_buffer_fill(s : MlclusterhierarchicalBuffer, v : Double) -> MlclusterhierarchicalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_buffer_min(s : MlclusterhierarchicalBuffer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_hierarchical_buffer_max(s : MlclusterhierarchicalBuffer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_hierarchical_buffer_to_string(s : MlclusterhierarchicalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_cursor_make(size : Int) -> MlclusterhierarchicalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_hierarchical_cursor_len(s : MlclusterhierarchicalCursor) -> Int { s.size }

pub fn ml_cluster_hierarchical_cursor_get(s : MlclusterhierarchicalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_hierarchical_cursor_set(s : MlclusterhierarchicalCursor, i : Int, v : Double) -> MlclusterhierarchicalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_cursor_sum(s : MlclusterhierarchicalCursor) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_hierarchical_cursor_mean(s : MlclusterhierarchicalCursor) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_hierarchical_cursor_scale(s : MlclusterhierarchicalCursor, f : Double) -> MlclusterhierarchicalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_cursor_add(a : MlclusterhierarchicalCursor, b : MlclusterhierarchicalCursor) -> MlclusterhierarchicalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_hierarchical_cursor_copy(s : MlclusterhierarchicalCursor) -> MlclusterhierarchicalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_cursor_fill(s : MlclusterhierarchicalCursor, v : Double) -> MlclusterhierarchicalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_cursor_min(s : MlclusterhierarchicalCursor) -> Double { @_common.min(s.data) }

pub fn ml_cluster_hierarchical_cursor_max(s : MlclusterhierarchicalCursor) -> Double { @_common.max(s.data) }

pub fn ml_cluster_hierarchical_cursor_to_string(s : MlclusterhierarchicalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_view_make(size : Int) -> MlclusterhierarchicalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_hierarchical_view_len(s : MlclusterhierarchicalView) -> Int { s.size }

pub fn ml_cluster_hierarchical_view_get(s : MlclusterhierarchicalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_hierarchical_view_set(s : MlclusterhierarchicalView, i : Int, v : Double) -> MlclusterhierarchicalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_view_sum(s : MlclusterhierarchicalView) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_hierarchical_view_mean(s : MlclusterhierarchicalView) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_hierarchical_view_scale(s : MlclusterhierarchicalView, f : Double) -> MlclusterhierarchicalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_view_add(a : MlclusterhierarchicalView, b : MlclusterhierarchicalView) -> MlclusterhierarchicalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_hierarchical_view_copy(s : MlclusterhierarchicalView) -> MlclusterhierarchicalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_view_fill(s : MlclusterhierarchicalView, v : Double) -> MlclusterhierarchicalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_view_min(s : MlclusterhierarchicalView) -> Double { @_common.min(s.data) }

pub fn ml_cluster_hierarchical_view_max(s : MlclusterhierarchicalView) -> Double { @_common.max(s.data) }

pub fn ml_cluster_hierarchical_view_to_string(s : MlclusterhierarchicalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_range_make(size : Int) -> MlclusterhierarchicalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_hierarchical_range_len(s : MlclusterhierarchicalRange) -> Int { s.size }

pub fn ml_cluster_hierarchical_range_get(s : MlclusterhierarchicalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_hierarchical_range_set(s : MlclusterhierarchicalRange, i : Int, v : Double) -> MlclusterhierarchicalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_range_sum(s : MlclusterhierarchicalRange) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_hierarchical_range_mean(s : MlclusterhierarchicalRange) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_hierarchical_range_scale(s : MlclusterhierarchicalRange, f : Double) -> MlclusterhierarchicalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_range_add(a : MlclusterhierarchicalRange, b : MlclusterhierarchicalRange) -> MlclusterhierarchicalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_hierarchical_range_copy(s : MlclusterhierarchicalRange) -> MlclusterhierarchicalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_range_fill(s : MlclusterhierarchicalRange, v : Double) -> MlclusterhierarchicalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_range_min(s : MlclusterhierarchicalRange) -> Double { @_common.min(s.data) }

pub fn ml_cluster_hierarchical_range_max(s : MlclusterhierarchicalRange) -> Double { @_common.max(s.data) }

pub fn ml_cluster_hierarchical_range_to_string(s : MlclusterhierarchicalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterhierarchicalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_hierarchical_slice_make(size : Int) -> MlclusterhierarchicalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_hierarchical_slice_len(s : MlclusterhierarchicalSlice) -> Int { s.size }

pub fn ml_cluster_hierarchical_slice_get(s : MlclusterhierarchicalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_hierarchical_slice_set(s : MlclusterhierarchicalSlice, i : Int, v : Double) -> MlclusterhierarchicalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_slice_sum(s : MlclusterhierarchicalSlice) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_hierarchical_slice_mean(s : MlclusterhierarchicalSlice) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_hierarchical_slice_scale(s : MlclusterhierarchicalSlice, f : Double) -> MlclusterhierarchicalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_slice_add(a : MlclusterhierarchicalSlice, b : MlclusterhierarchicalSlice) -> MlclusterhierarchicalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_hierarchical_slice_copy(s : MlclusterhierarchicalSlice) -> MlclusterhierarchicalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_slice_fill(s : MlclusterhierarchicalSlice, v : Double) -> MlclusterhierarchicalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_hierarchical_slice_min(s : MlclusterhierarchicalSlice) -> Double { @_common.min(s.data) }

pub fn ml_cluster_hierarchical_slice_max(s : MlclusterhierarchicalSlice) -> Double { @_common.max(s.data) }

pub fn ml_cluster_hierarchical_slice_to_string(s : MlclusterhierarchicalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

