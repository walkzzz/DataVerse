///===
/// extcore/ml_cluster_birch

pub(all) struct MlclusterbirchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_birch_make_point(x : Double, y : Double) -> MlclusterbirchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_birch_make_point3(x : Double, y : Double, z : Double) -> MlclusterbirchPoint {
  { x, y, z, label: 0 }
}

pub fn MlclusterbirchPoint::x(self : MlclusterbirchPoint) -> Double { self.x }

pub fn MlclusterbirchPoint::y(self : MlclusterbirchPoint) -> Double { self.y }

pub fn MlclusterbirchPoint::z(self : MlclusterbirchPoint) -> Double { self.z }

pub fn MlclusterbirchPoint::label(self : MlclusterbirchPoint) -> Int { self.label }

pub fn MlclusterbirchPoint::dist(self : MlclusterbirchPoint, other : MlclusterbirchPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclusterbirchPoint::add(self : MlclusterbirchPoint, other : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclusterbirchPoint::sub(self : MlclusterbirchPoint, other : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclusterbirchPoint::scale(self : MlclusterbirchPoint, s : Double) -> MlclusterbirchPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclusterbirchPoint::dot(self : MlclusterbirchPoint, other : MlclusterbirchPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclusterbirchPoint::cross(self : MlclusterbirchPoint, other : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclusterbirchPoint::norm(self : MlclusterbirchPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclusterbirchPoint::normalize(self : MlclusterbirchPoint) -> MlclusterbirchPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterbirchPoint::negate(self : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclusterbirchPoint::mid(self : MlclusterbirchPoint, other : MlclusterbirchPoint) -> MlclusterbirchPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclusterbirchPoint::lerp(self : MlclusterbirchPoint, other : MlclusterbirchPoint, t : Double) -> MlclusterbirchPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclusterbirchPoint::to_string(self : MlclusterbirchPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclusterbirchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_birch_make_series(vals : Array[Double], name : String) -> MlclusterbirchSeries {
  { vals, name, meta: 0 }
}

pub fn MlclusterbirchSeries::len(self : MlclusterbirchSeries) -> Int { self.vals.length() }

pub fn MlclusterbirchSeries::sum(self : MlclusterbirchSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclusterbirchSeries::mean(self : MlclusterbirchSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclusterbirchSeries::min(self : MlclusterbirchSeries) -> Double { @_common.min(self.vals) }

pub fn MlclusterbirchSeries::max(self : MlclusterbirchSeries) -> Double { @_common.max(self.vals) }

pub fn MlclusterbirchSeries::range(self : MlclusterbirchSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclusterbirchSeries::variance(self : MlclusterbirchSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclusterbirchSeries::std(self : MlclusterbirchSeries) -> Double { @_common.std(self.vals) }

pub fn MlclusterbirchSeries::median(self : MlclusterbirchSeries) -> Double { @_common.median(self.vals) }

pub fn MlclusterbirchSeries::scale(self : MlclusterbirchSeries, f : Double) -> MlclusterbirchSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclusterbirchSeries::add(self : MlclusterbirchSeries, other : MlclusterbirchSeries) -> MlclusterbirchSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclusterbirchSeries::sub(self : MlclusterbirchSeries, other : MlclusterbirchSeries) -> MlclusterbirchSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclusterbirchSeries::normalize(self : MlclusterbirchSeries) -> MlclusterbirchSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclusterbirchSeries::cumsum(self : MlclusterbirchSeries) -> MlclusterbirchSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclusterbirchSeries::to_string(self : MlclusterbirchSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusterbirchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_birch_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusterbirchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_birch_matrix_identity(n : Int) -> MlclusterbirchMatrix {
  let m = ml_cluster_birch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclusterbirchMatrix::get(self : MlclusterbirchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclusterbirchMatrix::transpose(self : MlclusterbirchMatrix) -> MlclusterbirchMatrix {
  let result = ml_cluster_birch_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclusterbirchMatrix::add(self : MlclusterbirchMatrix, other : MlclusterbirchMatrix) -> MlclusterbirchMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_birch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclusterbirchMatrix::scale(self : MlclusterbirchMatrix, s : Double) -> MlclusterbirchMatrix {
  let result = ml_cluster_birch_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclusterbirchMatrix::multiply(self : MlclusterbirchMatrix, other : MlclusterbirchMatrix) -> MlclusterbirchMatrix {
  if self.cols != other.rows { return ml_cluster_birch_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_birch_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclusterbirchMatrix::trace(self : MlclusterbirchMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclusterbirchMatrix::det(self : MlclusterbirchMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclusterbirchMatrix::norm(self : MlclusterbirchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclusterbirchMatrix::to_string(self : MlclusterbirchMatrix) -> String {
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

pub(all) struct MlclusterbirchVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_birch_make_vector(comps : Array[Double]) -> MlclusterbirchVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_birch_vector_zero(dim : Int) -> MlclusterbirchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclusterbirchVector::add(self : MlclusterbirchVector, other : MlclusterbirchVector) -> MlclusterbirchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterbirchVector::sub(self : MlclusterbirchVector, other : MlclusterbirchVector) -> MlclusterbirchVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusterbirchVector::scale(self : MlclusterbirchVector, s : Double) -> MlclusterbirchVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclusterbirchVector::dot(self : MlclusterbirchVector, other : MlclusterbirchVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclusterbirchVector::norm(self : MlclusterbirchVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclusterbirchVector::normalize(self : MlclusterbirchVector) -> MlclusterbirchVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusterbirchVector::dist(self : MlclusterbirchVector, other : MlclusterbirchVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclusterbirchVector::to_string(self : MlclusterbirchVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_birch_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_birch_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_birch_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_birch_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_birch_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_birch_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_birch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_birch_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_birch_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_birch_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_birch_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_birch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_birch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_birch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_birch_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_birch_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_birch_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_birch_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_birch_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_birch_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_birch_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_birch_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_birch_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_birch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_birch_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_birch_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_birch_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_birch_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_birch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclusterbirchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_frame_make(size : Int) -> MlclusterbirchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_frame_len(s : MlclusterbirchFrame) -> Int { s.size }

pub fn ml_cluster_birch_frame_get(s : MlclusterbirchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_frame_set(s : MlclusterbirchFrame, i : Int, v : Double) -> MlclusterbirchFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_frame_sum(s : MlclusterbirchFrame) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_frame_mean(s : MlclusterbirchFrame) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_frame_scale(s : MlclusterbirchFrame, f : Double) -> MlclusterbirchFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_frame_add(a : MlclusterbirchFrame, b : MlclusterbirchFrame) -> MlclusterbirchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_frame_copy(s : MlclusterbirchFrame) -> MlclusterbirchFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_frame_fill(s : MlclusterbirchFrame, v : Double) -> MlclusterbirchFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_frame_min(s : MlclusterbirchFrame) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_frame_max(s : MlclusterbirchFrame) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_frame_to_string(s : MlclusterbirchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_table_make(size : Int) -> MlclusterbirchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_table_len(s : MlclusterbirchTable) -> Int { s.size }

pub fn ml_cluster_birch_table_get(s : MlclusterbirchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_table_set(s : MlclusterbirchTable, i : Int, v : Double) -> MlclusterbirchTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_table_sum(s : MlclusterbirchTable) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_table_mean(s : MlclusterbirchTable) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_table_scale(s : MlclusterbirchTable, f : Double) -> MlclusterbirchTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_table_add(a : MlclusterbirchTable, b : MlclusterbirchTable) -> MlclusterbirchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_table_copy(s : MlclusterbirchTable) -> MlclusterbirchTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_table_fill(s : MlclusterbirchTable, v : Double) -> MlclusterbirchTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_table_min(s : MlclusterbirchTable) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_table_max(s : MlclusterbirchTable) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_table_to_string(s : MlclusterbirchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_graphn_make(size : Int) -> MlclusterbirchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_graphn_len(s : MlclusterbirchGraphN) -> Int { s.size }

pub fn ml_cluster_birch_graphn_get(s : MlclusterbirchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_graphn_set(s : MlclusterbirchGraphN, i : Int, v : Double) -> MlclusterbirchGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_graphn_sum(s : MlclusterbirchGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_graphn_mean(s : MlclusterbirchGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_graphn_scale(s : MlclusterbirchGraphN, f : Double) -> MlclusterbirchGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_graphn_add(a : MlclusterbirchGraphN, b : MlclusterbirchGraphN) -> MlclusterbirchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_graphn_copy(s : MlclusterbirchGraphN) -> MlclusterbirchGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_graphn_fill(s : MlclusterbirchGraphN, v : Double) -> MlclusterbirchGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_graphn_min(s : MlclusterbirchGraphN) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_graphn_max(s : MlclusterbirchGraphN) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_graphn_to_string(s : MlclusterbirchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_node_make(size : Int) -> MlclusterbirchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_node_len(s : MlclusterbirchNode) -> Int { s.size }

pub fn ml_cluster_birch_node_get(s : MlclusterbirchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_node_set(s : MlclusterbirchNode, i : Int, v : Double) -> MlclusterbirchNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_node_sum(s : MlclusterbirchNode) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_node_mean(s : MlclusterbirchNode) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_node_scale(s : MlclusterbirchNode, f : Double) -> MlclusterbirchNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_node_add(a : MlclusterbirchNode, b : MlclusterbirchNode) -> MlclusterbirchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_node_copy(s : MlclusterbirchNode) -> MlclusterbirchNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_node_fill(s : MlclusterbirchNode, v : Double) -> MlclusterbirchNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_node_min(s : MlclusterbirchNode) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_node_max(s : MlclusterbirchNode) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_node_to_string(s : MlclusterbirchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_edge_make(size : Int) -> MlclusterbirchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_edge_len(s : MlclusterbirchEdge) -> Int { s.size }

pub fn ml_cluster_birch_edge_get(s : MlclusterbirchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_edge_set(s : MlclusterbirchEdge, i : Int, v : Double) -> MlclusterbirchEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_edge_sum(s : MlclusterbirchEdge) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_edge_mean(s : MlclusterbirchEdge) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_edge_scale(s : MlclusterbirchEdge, f : Double) -> MlclusterbirchEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_edge_add(a : MlclusterbirchEdge, b : MlclusterbirchEdge) -> MlclusterbirchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_edge_copy(s : MlclusterbirchEdge) -> MlclusterbirchEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_edge_fill(s : MlclusterbirchEdge, v : Double) -> MlclusterbirchEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_edge_min(s : MlclusterbirchEdge) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_edge_max(s : MlclusterbirchEdge) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_edge_to_string(s : MlclusterbirchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_path_make(size : Int) -> MlclusterbirchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_path_len(s : MlclusterbirchPath) -> Int { s.size }

pub fn ml_cluster_birch_path_get(s : MlclusterbirchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_path_set(s : MlclusterbirchPath, i : Int, v : Double) -> MlclusterbirchPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_path_sum(s : MlclusterbirchPath) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_path_mean(s : MlclusterbirchPath) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_path_scale(s : MlclusterbirchPath, f : Double) -> MlclusterbirchPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_path_add(a : MlclusterbirchPath, b : MlclusterbirchPath) -> MlclusterbirchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_path_copy(s : MlclusterbirchPath) -> MlclusterbirchPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_path_fill(s : MlclusterbirchPath, v : Double) -> MlclusterbirchPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_path_min(s : MlclusterbirchPath) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_path_max(s : MlclusterbirchPath) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_path_to_string(s : MlclusterbirchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_cluster_make(size : Int) -> MlclusterbirchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_cluster_len(s : MlclusterbirchCluster) -> Int { s.size }

pub fn ml_cluster_birch_cluster_get(s : MlclusterbirchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_cluster_set(s : MlclusterbirchCluster, i : Int, v : Double) -> MlclusterbirchCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cluster_sum(s : MlclusterbirchCluster) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_cluster_mean(s : MlclusterbirchCluster) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_cluster_scale(s : MlclusterbirchCluster, f : Double) -> MlclusterbirchCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cluster_add(a : MlclusterbirchCluster, b : MlclusterbirchCluster) -> MlclusterbirchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_cluster_copy(s : MlclusterbirchCluster) -> MlclusterbirchCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cluster_fill(s : MlclusterbirchCluster, v : Double) -> MlclusterbirchCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cluster_min(s : MlclusterbirchCluster) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_cluster_max(s : MlclusterbirchCluster) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_cluster_to_string(s : MlclusterbirchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_model_make(size : Int) -> MlclusterbirchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_model_len(s : MlclusterbirchModel) -> Int { s.size }

pub fn ml_cluster_birch_model_get(s : MlclusterbirchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_model_set(s : MlclusterbirchModel, i : Int, v : Double) -> MlclusterbirchModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_model_sum(s : MlclusterbirchModel) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_model_mean(s : MlclusterbirchModel) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_model_scale(s : MlclusterbirchModel, f : Double) -> MlclusterbirchModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_model_add(a : MlclusterbirchModel, b : MlclusterbirchModel) -> MlclusterbirchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_model_copy(s : MlclusterbirchModel) -> MlclusterbirchModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_model_fill(s : MlclusterbirchModel, v : Double) -> MlclusterbirchModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_model_min(s : MlclusterbirchModel) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_model_max(s : MlclusterbirchModel) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_model_to_string(s : MlclusterbirchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_layer_make(size : Int) -> MlclusterbirchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_layer_len(s : MlclusterbirchLayer) -> Int { s.size }

pub fn ml_cluster_birch_layer_get(s : MlclusterbirchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_layer_set(s : MlclusterbirchLayer, i : Int, v : Double) -> MlclusterbirchLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_layer_sum(s : MlclusterbirchLayer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_layer_mean(s : MlclusterbirchLayer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_layer_scale(s : MlclusterbirchLayer, f : Double) -> MlclusterbirchLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_layer_add(a : MlclusterbirchLayer, b : MlclusterbirchLayer) -> MlclusterbirchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_layer_copy(s : MlclusterbirchLayer) -> MlclusterbirchLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_layer_fill(s : MlclusterbirchLayer, v : Double) -> MlclusterbirchLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_layer_min(s : MlclusterbirchLayer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_layer_max(s : MlclusterbirchLayer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_layer_to_string(s : MlclusterbirchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_buffer_make(size : Int) -> MlclusterbirchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_buffer_len(s : MlclusterbirchBuffer) -> Int { s.size }

pub fn ml_cluster_birch_buffer_get(s : MlclusterbirchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_buffer_set(s : MlclusterbirchBuffer, i : Int, v : Double) -> MlclusterbirchBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_buffer_sum(s : MlclusterbirchBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_buffer_mean(s : MlclusterbirchBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_buffer_scale(s : MlclusterbirchBuffer, f : Double) -> MlclusterbirchBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_buffer_add(a : MlclusterbirchBuffer, b : MlclusterbirchBuffer) -> MlclusterbirchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_buffer_copy(s : MlclusterbirchBuffer) -> MlclusterbirchBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_buffer_fill(s : MlclusterbirchBuffer, v : Double) -> MlclusterbirchBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_buffer_min(s : MlclusterbirchBuffer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_buffer_max(s : MlclusterbirchBuffer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_buffer_to_string(s : MlclusterbirchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_cursor_make(size : Int) -> MlclusterbirchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_cursor_len(s : MlclusterbirchCursor) -> Int { s.size }

pub fn ml_cluster_birch_cursor_get(s : MlclusterbirchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_cursor_set(s : MlclusterbirchCursor, i : Int, v : Double) -> MlclusterbirchCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cursor_sum(s : MlclusterbirchCursor) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_cursor_mean(s : MlclusterbirchCursor) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_cursor_scale(s : MlclusterbirchCursor, f : Double) -> MlclusterbirchCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cursor_add(a : MlclusterbirchCursor, b : MlclusterbirchCursor) -> MlclusterbirchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_cursor_copy(s : MlclusterbirchCursor) -> MlclusterbirchCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cursor_fill(s : MlclusterbirchCursor, v : Double) -> MlclusterbirchCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_cursor_min(s : MlclusterbirchCursor) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_cursor_max(s : MlclusterbirchCursor) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_cursor_to_string(s : MlclusterbirchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_view_make(size : Int) -> MlclusterbirchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_view_len(s : MlclusterbirchView) -> Int { s.size }

pub fn ml_cluster_birch_view_get(s : MlclusterbirchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_view_set(s : MlclusterbirchView, i : Int, v : Double) -> MlclusterbirchView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_view_sum(s : MlclusterbirchView) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_view_mean(s : MlclusterbirchView) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_view_scale(s : MlclusterbirchView, f : Double) -> MlclusterbirchView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_view_add(a : MlclusterbirchView, b : MlclusterbirchView) -> MlclusterbirchView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_view_copy(s : MlclusterbirchView) -> MlclusterbirchView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_view_fill(s : MlclusterbirchView, v : Double) -> MlclusterbirchView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_view_min(s : MlclusterbirchView) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_view_max(s : MlclusterbirchView) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_view_to_string(s : MlclusterbirchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_range_make(size : Int) -> MlclusterbirchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_range_len(s : MlclusterbirchRange) -> Int { s.size }

pub fn ml_cluster_birch_range_get(s : MlclusterbirchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_range_set(s : MlclusterbirchRange, i : Int, v : Double) -> MlclusterbirchRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_range_sum(s : MlclusterbirchRange) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_range_mean(s : MlclusterbirchRange) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_range_scale(s : MlclusterbirchRange, f : Double) -> MlclusterbirchRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_range_add(a : MlclusterbirchRange, b : MlclusterbirchRange) -> MlclusterbirchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_range_copy(s : MlclusterbirchRange) -> MlclusterbirchRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_range_fill(s : MlclusterbirchRange, v : Double) -> MlclusterbirchRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_range_min(s : MlclusterbirchRange) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_range_max(s : MlclusterbirchRange) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_range_to_string(s : MlclusterbirchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusterbirchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_birch_slice_make(size : Int) -> MlclusterbirchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_birch_slice_len(s : MlclusterbirchSlice) -> Int { s.size }

pub fn ml_cluster_birch_slice_get(s : MlclusterbirchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_birch_slice_set(s : MlclusterbirchSlice, i : Int, v : Double) -> MlclusterbirchSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_slice_sum(s : MlclusterbirchSlice) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_birch_slice_mean(s : MlclusterbirchSlice) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_birch_slice_scale(s : MlclusterbirchSlice, f : Double) -> MlclusterbirchSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_slice_add(a : MlclusterbirchSlice, b : MlclusterbirchSlice) -> MlclusterbirchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_birch_slice_copy(s : MlclusterbirchSlice) -> MlclusterbirchSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_slice_fill(s : MlclusterbirchSlice, v : Double) -> MlclusterbirchSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_birch_slice_min(s : MlclusterbirchSlice) -> Double { @_common.min(s.data) }

pub fn ml_cluster_birch_slice_max(s : MlclusterbirchSlice) -> Double { @_common.max(s.data) }

pub fn ml_cluster_birch_slice_to_string(s : MlclusterbirchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

