///===
/// extcore/ml_cluster_affinity

pub(all) struct MlclusteraffinityPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_cluster_affinity_make_point(x : Double, y : Double) -> MlclusteraffinityPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_cluster_affinity_make_point3(x : Double, y : Double, z : Double) -> MlclusteraffinityPoint {
  { x, y, z, label: 0 }
}

pub fn MlclusteraffinityPoint::x(self : MlclusteraffinityPoint) -> Double { self.x }

pub fn MlclusteraffinityPoint::y(self : MlclusteraffinityPoint) -> Double { self.y }

pub fn MlclusteraffinityPoint::z(self : MlclusteraffinityPoint) -> Double { self.z }

pub fn MlclusteraffinityPoint::label(self : MlclusteraffinityPoint) -> Int { self.label }

pub fn MlclusteraffinityPoint::dist(self : MlclusteraffinityPoint, other : MlclusteraffinityPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclusteraffinityPoint::add(self : MlclusteraffinityPoint, other : MlclusteraffinityPoint) -> MlclusteraffinityPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclusteraffinityPoint::sub(self : MlclusteraffinityPoint, other : MlclusteraffinityPoint) -> MlclusteraffinityPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclusteraffinityPoint::scale(self : MlclusteraffinityPoint, s : Double) -> MlclusteraffinityPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclusteraffinityPoint::dot(self : MlclusteraffinityPoint, other : MlclusteraffinityPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclusteraffinityPoint::cross(self : MlclusteraffinityPoint, other : MlclusteraffinityPoint) -> MlclusteraffinityPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclusteraffinityPoint::norm(self : MlclusteraffinityPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclusteraffinityPoint::normalize(self : MlclusteraffinityPoint) -> MlclusteraffinityPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusteraffinityPoint::negate(self : MlclusteraffinityPoint) -> MlclusteraffinityPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclusteraffinityPoint::mid(self : MlclusteraffinityPoint, other : MlclusteraffinityPoint) -> MlclusteraffinityPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclusteraffinityPoint::lerp(self : MlclusteraffinityPoint, other : MlclusteraffinityPoint, t : Double) -> MlclusteraffinityPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclusteraffinityPoint::to_string(self : MlclusteraffinityPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclusteraffinitySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_cluster_affinity_make_series(vals : Array[Double], name : String) -> MlclusteraffinitySeries {
  { vals, name, meta: 0 }
}

pub fn MlclusteraffinitySeries::len(self : MlclusteraffinitySeries) -> Int { self.vals.length() }

pub fn MlclusteraffinitySeries::sum(self : MlclusteraffinitySeries) -> Double { @_common.sum(self.vals) }

pub fn MlclusteraffinitySeries::mean(self : MlclusteraffinitySeries) -> Double { @_common.mean(self.vals) }

pub fn MlclusteraffinitySeries::min(self : MlclusteraffinitySeries) -> Double { @_common.min(self.vals) }

pub fn MlclusteraffinitySeries::max(self : MlclusteraffinitySeries) -> Double { @_common.max(self.vals) }

pub fn MlclusteraffinitySeries::range(self : MlclusteraffinitySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclusteraffinitySeries::variance(self : MlclusteraffinitySeries) -> Double { @_common.variance(self.vals) }

pub fn MlclusteraffinitySeries::std(self : MlclusteraffinitySeries) -> Double { @_common.std(self.vals) }

pub fn MlclusteraffinitySeries::median(self : MlclusteraffinitySeries) -> Double { @_common.median(self.vals) }

pub fn MlclusteraffinitySeries::scale(self : MlclusteraffinitySeries, f : Double) -> MlclusteraffinitySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclusteraffinitySeries::add(self : MlclusteraffinitySeries, other : MlclusteraffinitySeries) -> MlclusteraffinitySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclusteraffinitySeries::sub(self : MlclusteraffinitySeries, other : MlclusteraffinitySeries) -> MlclusteraffinitySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclusteraffinitySeries::normalize(self : MlclusteraffinitySeries) -> MlclusteraffinitySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclusteraffinitySeries::cumsum(self : MlclusteraffinitySeries) -> MlclusteraffinitySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclusteraffinitySeries::to_string(self : MlclusteraffinitySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclusteraffinityMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_cluster_affinity_make_matrix(rows : Int, cols : Int, val : Double) -> MlclusteraffinityMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_cluster_affinity_matrix_identity(n : Int) -> MlclusteraffinityMatrix {
  let m = ml_cluster_affinity_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclusteraffinityMatrix::get(self : MlclusteraffinityMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclusteraffinityMatrix::transpose(self : MlclusteraffinityMatrix) -> MlclusteraffinityMatrix {
  let result = ml_cluster_affinity_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclusteraffinityMatrix::add(self : MlclusteraffinityMatrix, other : MlclusteraffinityMatrix) -> MlclusteraffinityMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_cluster_affinity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclusteraffinityMatrix::scale(self : MlclusteraffinityMatrix, s : Double) -> MlclusteraffinityMatrix {
  let result = ml_cluster_affinity_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclusteraffinityMatrix::multiply(self : MlclusteraffinityMatrix, other : MlclusteraffinityMatrix) -> MlclusteraffinityMatrix {
  if self.cols != other.rows { return ml_cluster_affinity_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_cluster_affinity_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclusteraffinityMatrix::trace(self : MlclusteraffinityMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclusteraffinityMatrix::det(self : MlclusteraffinityMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclusteraffinityMatrix::norm(self : MlclusteraffinityMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclusteraffinityMatrix::to_string(self : MlclusteraffinityMatrix) -> String {
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

pub(all) struct MlclusteraffinityVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_cluster_affinity_make_vector(comps : Array[Double]) -> MlclusteraffinityVector {
  { comps, dim: comps.length() }
}

pub fn ml_cluster_affinity_vector_zero(dim : Int) -> MlclusteraffinityVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclusteraffinityVector::add(self : MlclusteraffinityVector, other : MlclusteraffinityVector) -> MlclusteraffinityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusteraffinityVector::sub(self : MlclusteraffinityVector, other : MlclusteraffinityVector) -> MlclusteraffinityVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclusteraffinityVector::scale(self : MlclusteraffinityVector, s : Double) -> MlclusteraffinityVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclusteraffinityVector::dot(self : MlclusteraffinityVector, other : MlclusteraffinityVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclusteraffinityVector::norm(self : MlclusteraffinityVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclusteraffinityVector::normalize(self : MlclusteraffinityVector) -> MlclusteraffinityVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclusteraffinityVector::dist(self : MlclusteraffinityVector, other : MlclusteraffinityVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclusteraffinityVector::to_string(self : MlclusteraffinityVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_cluster_affinity_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_cluster_affinity_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_cluster_affinity_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_cluster_affinity_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_cluster_affinity_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_cluster_affinity_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_cluster_affinity_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_cluster_affinity_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_cluster_affinity_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_cluster_affinity_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_cluster_affinity_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_cluster_affinity_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_cluster_affinity_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_cluster_affinity_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_cluster_affinity_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_cluster_affinity_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_cluster_affinity_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_cluster_affinity_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_cluster_affinity_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_cluster_affinity_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_cluster_affinity_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_cluster_affinity_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_cluster_affinity_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_cluster_affinity_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_cluster_affinity_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_cluster_affinity_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_cluster_affinity_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_cluster_affinity_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_cluster_affinity_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclusteraffinityFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_frame_make(size : Int) -> MlclusteraffinityFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_frame_len(s : MlclusteraffinityFrame) -> Int { s.size }

pub fn ml_cluster_affinity_frame_get(s : MlclusteraffinityFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_frame_set(s : MlclusteraffinityFrame, i : Int, v : Double) -> MlclusteraffinityFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_frame_sum(s : MlclusteraffinityFrame) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_affinity_frame_mean(s : MlclusteraffinityFrame) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_affinity_frame_scale(s : MlclusteraffinityFrame, f : Double) -> MlclusteraffinityFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_frame_add(a : MlclusteraffinityFrame, b : MlclusteraffinityFrame) -> MlclusteraffinityFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_affinity_frame_copy(s : MlclusteraffinityFrame) -> MlclusteraffinityFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_frame_fill(s : MlclusteraffinityFrame, v : Double) -> MlclusteraffinityFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_frame_min(s : MlclusteraffinityFrame) -> Double { @_common.min(s.data) }

pub fn ml_cluster_affinity_frame_max(s : MlclusteraffinityFrame) -> Double { @_common.max(s.data) }

pub fn ml_cluster_affinity_frame_to_string(s : MlclusteraffinityFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_table_make(size : Int) -> MlclusteraffinityTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_table_len(s : MlclusteraffinityTable) -> Int { s.size }

pub fn ml_cluster_affinity_table_get(s : MlclusteraffinityTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_table_set(s : MlclusteraffinityTable, i : Int, v : Double) -> MlclusteraffinityTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_table_sum(s : MlclusteraffinityTable) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_affinity_table_mean(s : MlclusteraffinityTable) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_affinity_table_scale(s : MlclusteraffinityTable, f : Double) -> MlclusteraffinityTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_table_add(a : MlclusteraffinityTable, b : MlclusteraffinityTable) -> MlclusteraffinityTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_affinity_table_copy(s : MlclusteraffinityTable) -> MlclusteraffinityTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_table_fill(s : MlclusteraffinityTable, v : Double) -> MlclusteraffinityTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_table_min(s : MlclusteraffinityTable) -> Double { @_common.min(s.data) }

pub fn ml_cluster_affinity_table_max(s : MlclusteraffinityTable) -> Double { @_common.max(s.data) }

pub fn ml_cluster_affinity_table_to_string(s : MlclusteraffinityTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_graphn_make(size : Int) -> MlclusteraffinityGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_graphn_len(s : MlclusteraffinityGraphN) -> Int { s.size }

pub fn ml_cluster_affinity_graphn_get(s : MlclusteraffinityGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_graphn_set(s : MlclusteraffinityGraphN, i : Int, v : Double) -> MlclusteraffinityGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_graphn_sum(s : MlclusteraffinityGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_affinity_graphn_mean(s : MlclusteraffinityGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_affinity_graphn_scale(s : MlclusteraffinityGraphN, f : Double) -> MlclusteraffinityGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_graphn_add(a : MlclusteraffinityGraphN, b : MlclusteraffinityGraphN) -> MlclusteraffinityGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_affinity_graphn_copy(s : MlclusteraffinityGraphN) -> MlclusteraffinityGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_graphn_fill(s : MlclusteraffinityGraphN, v : Double) -> MlclusteraffinityGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_graphn_min(s : MlclusteraffinityGraphN) -> Double { @_common.min(s.data) }

pub fn ml_cluster_affinity_graphn_max(s : MlclusteraffinityGraphN) -> Double { @_common.max(s.data) }

pub fn ml_cluster_affinity_graphn_to_string(s : MlclusteraffinityGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_node_make(size : Int) -> MlclusteraffinityNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_node_len(s : MlclusteraffinityNode) -> Int { s.size }

pub fn ml_cluster_affinity_node_get(s : MlclusteraffinityNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_node_set(s : MlclusteraffinityNode, i : Int, v : Double) -> MlclusteraffinityNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_node_sum(s : MlclusteraffinityNode) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_affinity_node_mean(s : MlclusteraffinityNode) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_affinity_node_scale(s : MlclusteraffinityNode, f : Double) -> MlclusteraffinityNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_node_add(a : MlclusteraffinityNode, b : MlclusteraffinityNode) -> MlclusteraffinityNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_affinity_node_copy(s : MlclusteraffinityNode) -> MlclusteraffinityNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_node_fill(s : MlclusteraffinityNode, v : Double) -> MlclusteraffinityNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_node_min(s : MlclusteraffinityNode) -> Double { @_common.min(s.data) }

pub fn ml_cluster_affinity_node_max(s : MlclusteraffinityNode) -> Double { @_common.max(s.data) }

pub fn ml_cluster_affinity_node_to_string(s : MlclusteraffinityNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_edge_make(size : Int) -> MlclusteraffinityEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_edge_len(s : MlclusteraffinityEdge) -> Int { s.size }

pub fn ml_cluster_affinity_edge_get(s : MlclusteraffinityEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_edge_set(s : MlclusteraffinityEdge, i : Int, v : Double) -> MlclusteraffinityEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_edge_sum(s : MlclusteraffinityEdge) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_affinity_edge_mean(s : MlclusteraffinityEdge) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_affinity_edge_scale(s : MlclusteraffinityEdge, f : Double) -> MlclusteraffinityEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_edge_add(a : MlclusteraffinityEdge, b : MlclusteraffinityEdge) -> MlclusteraffinityEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_affinity_edge_copy(s : MlclusteraffinityEdge) -> MlclusteraffinityEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_edge_fill(s : MlclusteraffinityEdge, v : Double) -> MlclusteraffinityEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_edge_min(s : MlclusteraffinityEdge) -> Double { @_common.min(s.data) }

pub fn ml_cluster_affinity_edge_max(s : MlclusteraffinityEdge) -> Double { @_common.max(s.data) }

pub fn ml_cluster_affinity_edge_to_string(s : MlclusteraffinityEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_path_make(size : Int) -> MlclusteraffinityPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_path_len(s : MlclusteraffinityPath) -> Int { s.size }

pub fn ml_cluster_affinity_path_get(s : MlclusteraffinityPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_path_set(s : MlclusteraffinityPath, i : Int, v : Double) -> MlclusteraffinityPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_path_sum(s : MlclusteraffinityPath) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_affinity_path_mean(s : MlclusteraffinityPath) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_affinity_path_scale(s : MlclusteraffinityPath, f : Double) -> MlclusteraffinityPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_path_add(a : MlclusteraffinityPath, b : MlclusteraffinityPath) -> MlclusteraffinityPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_affinity_path_copy(s : MlclusteraffinityPath) -> MlclusteraffinityPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_path_fill(s : MlclusteraffinityPath, v : Double) -> MlclusteraffinityPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_path_min(s : MlclusteraffinityPath) -> Double { @_common.min(s.data) }

pub fn ml_cluster_affinity_path_max(s : MlclusteraffinityPath) -> Double { @_common.max(s.data) }

pub fn ml_cluster_affinity_path_to_string(s : MlclusteraffinityPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_cluster_make(size : Int) -> MlclusteraffinityCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_cluster_len(s : MlclusteraffinityCluster) -> Int { s.size }

pub fn ml_cluster_affinity_cluster_get(s : MlclusteraffinityCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_cluster_set(s : MlclusteraffinityCluster, i : Int, v : Double) -> MlclusteraffinityCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_cluster_sum(s : MlclusteraffinityCluster) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_affinity_cluster_mean(s : MlclusteraffinityCluster) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_affinity_cluster_scale(s : MlclusteraffinityCluster, f : Double) -> MlclusteraffinityCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_cluster_add(a : MlclusteraffinityCluster, b : MlclusteraffinityCluster) -> MlclusteraffinityCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_affinity_cluster_copy(s : MlclusteraffinityCluster) -> MlclusteraffinityCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_cluster_fill(s : MlclusteraffinityCluster, v : Double) -> MlclusteraffinityCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_cluster_min(s : MlclusteraffinityCluster) -> Double { @_common.min(s.data) }

pub fn ml_cluster_affinity_cluster_max(s : MlclusteraffinityCluster) -> Double { @_common.max(s.data) }

pub fn ml_cluster_affinity_cluster_to_string(s : MlclusteraffinityCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_model_make(size : Int) -> MlclusteraffinityModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_model_len(s : MlclusteraffinityModel) -> Int { s.size }

pub fn ml_cluster_affinity_model_get(s : MlclusteraffinityModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_model_set(s : MlclusteraffinityModel, i : Int, v : Double) -> MlclusteraffinityModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_model_sum(s : MlclusteraffinityModel) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_affinity_model_mean(s : MlclusteraffinityModel) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_affinity_model_scale(s : MlclusteraffinityModel, f : Double) -> MlclusteraffinityModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_model_add(a : MlclusteraffinityModel, b : MlclusteraffinityModel) -> MlclusteraffinityModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_affinity_model_copy(s : MlclusteraffinityModel) -> MlclusteraffinityModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_model_fill(s : MlclusteraffinityModel, v : Double) -> MlclusteraffinityModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_model_min(s : MlclusteraffinityModel) -> Double { @_common.min(s.data) }

pub fn ml_cluster_affinity_model_max(s : MlclusteraffinityModel) -> Double { @_common.max(s.data) }

pub fn ml_cluster_affinity_model_to_string(s : MlclusteraffinityModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_layer_make(size : Int) -> MlclusteraffinityLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_layer_len(s : MlclusteraffinityLayer) -> Int { s.size }

pub fn ml_cluster_affinity_layer_get(s : MlclusteraffinityLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_layer_set(s : MlclusteraffinityLayer, i : Int, v : Double) -> MlclusteraffinityLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_layer_sum(s : MlclusteraffinityLayer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_affinity_layer_mean(s : MlclusteraffinityLayer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_affinity_layer_scale(s : MlclusteraffinityLayer, f : Double) -> MlclusteraffinityLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_layer_add(a : MlclusteraffinityLayer, b : MlclusteraffinityLayer) -> MlclusteraffinityLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_affinity_layer_copy(s : MlclusteraffinityLayer) -> MlclusteraffinityLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_layer_fill(s : MlclusteraffinityLayer, v : Double) -> MlclusteraffinityLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_layer_min(s : MlclusteraffinityLayer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_affinity_layer_max(s : MlclusteraffinityLayer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_affinity_layer_to_string(s : MlclusteraffinityLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_buffer_make(size : Int) -> MlclusteraffinityBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_buffer_len(s : MlclusteraffinityBuffer) -> Int { s.size }

pub fn ml_cluster_affinity_buffer_get(s : MlclusteraffinityBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_buffer_set(s : MlclusteraffinityBuffer, i : Int, v : Double) -> MlclusteraffinityBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_buffer_sum(s : MlclusteraffinityBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_affinity_buffer_mean(s : MlclusteraffinityBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_affinity_buffer_scale(s : MlclusteraffinityBuffer, f : Double) -> MlclusteraffinityBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_buffer_add(a : MlclusteraffinityBuffer, b : MlclusteraffinityBuffer) -> MlclusteraffinityBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_affinity_buffer_copy(s : MlclusteraffinityBuffer) -> MlclusteraffinityBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_buffer_fill(s : MlclusteraffinityBuffer, v : Double) -> MlclusteraffinityBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_buffer_min(s : MlclusteraffinityBuffer) -> Double { @_common.min(s.data) }

pub fn ml_cluster_affinity_buffer_max(s : MlclusteraffinityBuffer) -> Double { @_common.max(s.data) }

pub fn ml_cluster_affinity_buffer_to_string(s : MlclusteraffinityBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_cursor_make(size : Int) -> MlclusteraffinityCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_cursor_len(s : MlclusteraffinityCursor) -> Int { s.size }

pub fn ml_cluster_affinity_cursor_get(s : MlclusteraffinityCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_cursor_set(s : MlclusteraffinityCursor, i : Int, v : Double) -> MlclusteraffinityCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_cursor_sum(s : MlclusteraffinityCursor) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_affinity_cursor_mean(s : MlclusteraffinityCursor) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_affinity_cursor_scale(s : MlclusteraffinityCursor, f : Double) -> MlclusteraffinityCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_cursor_add(a : MlclusteraffinityCursor, b : MlclusteraffinityCursor) -> MlclusteraffinityCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_affinity_cursor_copy(s : MlclusteraffinityCursor) -> MlclusteraffinityCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_cursor_fill(s : MlclusteraffinityCursor, v : Double) -> MlclusteraffinityCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_cursor_min(s : MlclusteraffinityCursor) -> Double { @_common.min(s.data) }

pub fn ml_cluster_affinity_cursor_max(s : MlclusteraffinityCursor) -> Double { @_common.max(s.data) }

pub fn ml_cluster_affinity_cursor_to_string(s : MlclusteraffinityCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_view_make(size : Int) -> MlclusteraffinityView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_view_len(s : MlclusteraffinityView) -> Int { s.size }

pub fn ml_cluster_affinity_view_get(s : MlclusteraffinityView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_view_set(s : MlclusteraffinityView, i : Int, v : Double) -> MlclusteraffinityView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_view_sum(s : MlclusteraffinityView) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_affinity_view_mean(s : MlclusteraffinityView) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_affinity_view_scale(s : MlclusteraffinityView, f : Double) -> MlclusteraffinityView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_view_add(a : MlclusteraffinityView, b : MlclusteraffinityView) -> MlclusteraffinityView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_affinity_view_copy(s : MlclusteraffinityView) -> MlclusteraffinityView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_view_fill(s : MlclusteraffinityView, v : Double) -> MlclusteraffinityView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_view_min(s : MlclusteraffinityView) -> Double { @_common.min(s.data) }

pub fn ml_cluster_affinity_view_max(s : MlclusteraffinityView) -> Double { @_common.max(s.data) }

pub fn ml_cluster_affinity_view_to_string(s : MlclusteraffinityView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinityRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_range_make(size : Int) -> MlclusteraffinityRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_range_len(s : MlclusteraffinityRange) -> Int { s.size }

pub fn ml_cluster_affinity_range_get(s : MlclusteraffinityRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_range_set(s : MlclusteraffinityRange, i : Int, v : Double) -> MlclusteraffinityRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_range_sum(s : MlclusteraffinityRange) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_affinity_range_mean(s : MlclusteraffinityRange) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_affinity_range_scale(s : MlclusteraffinityRange, f : Double) -> MlclusteraffinityRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_range_add(a : MlclusteraffinityRange, b : MlclusteraffinityRange) -> MlclusteraffinityRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_affinity_range_copy(s : MlclusteraffinityRange) -> MlclusteraffinityRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_range_fill(s : MlclusteraffinityRange, v : Double) -> MlclusteraffinityRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_range_min(s : MlclusteraffinityRange) -> Double { @_common.min(s.data) }

pub fn ml_cluster_affinity_range_max(s : MlclusteraffinityRange) -> Double { @_common.max(s.data) }

pub fn ml_cluster_affinity_range_to_string(s : MlclusteraffinityRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclusteraffinitySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_cluster_affinity_slice_make(size : Int) -> MlclusteraffinitySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_cluster_affinity_slice_len(s : MlclusteraffinitySlice) -> Int { s.size }

pub fn ml_cluster_affinity_slice_get(s : MlclusteraffinitySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_cluster_affinity_slice_set(s : MlclusteraffinitySlice, i : Int, v : Double) -> MlclusteraffinitySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_slice_sum(s : MlclusteraffinitySlice) -> Double { @_common.sum(s.data) }

pub fn ml_cluster_affinity_slice_mean(s : MlclusteraffinitySlice) -> Double { @_common.mean(s.data) }

pub fn ml_cluster_affinity_slice_scale(s : MlclusteraffinitySlice, f : Double) -> MlclusteraffinitySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_slice_add(a : MlclusteraffinitySlice, b : MlclusteraffinitySlice) -> MlclusteraffinitySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_cluster_affinity_slice_copy(s : MlclusteraffinitySlice) -> MlclusteraffinitySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_slice_fill(s : MlclusteraffinitySlice, v : Double) -> MlclusteraffinitySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_cluster_affinity_slice_min(s : MlclusteraffinitySlice) -> Double { @_common.min(s.data) }

pub fn ml_cluster_affinity_slice_max(s : MlclusteraffinitySlice) -> Double { @_common.max(s.data) }

pub fn ml_cluster_affinity_slice_to_string(s : MlclusteraffinitySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

