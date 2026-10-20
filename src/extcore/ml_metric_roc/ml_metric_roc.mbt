///===
/// extcore/ml_metric_roc

pub(all) struct MlmetricrocPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_roc_make_point(x : Double, y : Double) -> MlmetricrocPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_roc_make_point3(x : Double, y : Double, z : Double) -> MlmetricrocPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetricrocPoint::x(self : MlmetricrocPoint) -> Double { self.x }

pub fn MlmetricrocPoint::y(self : MlmetricrocPoint) -> Double { self.y }

pub fn MlmetricrocPoint::z(self : MlmetricrocPoint) -> Double { self.z }

pub fn MlmetricrocPoint::label(self : MlmetricrocPoint) -> Int { self.label }

pub fn MlmetricrocPoint::dist(self : MlmetricrocPoint, other : MlmetricrocPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetricrocPoint::add(self : MlmetricrocPoint, other : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetricrocPoint::sub(self : MlmetricrocPoint, other : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetricrocPoint::scale(self : MlmetricrocPoint, s : Double) -> MlmetricrocPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetricrocPoint::dot(self : MlmetricrocPoint, other : MlmetricrocPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetricrocPoint::cross(self : MlmetricrocPoint, other : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetricrocPoint::norm(self : MlmetricrocPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetricrocPoint::normalize(self : MlmetricrocPoint) -> MlmetricrocPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricrocPoint::negate(self : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetricrocPoint::mid(self : MlmetricrocPoint, other : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetricrocPoint::lerp(self : MlmetricrocPoint, other : MlmetricrocPoint, t : Double) -> MlmetricrocPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetricrocPoint::to_string(self : MlmetricrocPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetricrocSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_roc_make_series(vals : Array[Double], name : String) -> MlmetricrocSeries {
  { vals, name, meta: 0 }
}

pub fn MlmetricrocSeries::len(self : MlmetricrocSeries) -> Int { self.vals.length() }

pub fn MlmetricrocSeries::sum(self : MlmetricrocSeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetricrocSeries::mean(self : MlmetricrocSeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetricrocSeries::min(self : MlmetricrocSeries) -> Double { @_common.min(self.vals) }

pub fn MlmetricrocSeries::max(self : MlmetricrocSeries) -> Double { @_common.max(self.vals) }

pub fn MlmetricrocSeries::range(self : MlmetricrocSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetricrocSeries::variance(self : MlmetricrocSeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetricrocSeries::std(self : MlmetricrocSeries) -> Double { @_common.std(self.vals) }

pub fn MlmetricrocSeries::median(self : MlmetricrocSeries) -> Double { @_common.median(self.vals) }

pub fn MlmetricrocSeries::scale(self : MlmetricrocSeries, f : Double) -> MlmetricrocSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetricrocSeries::add(self : MlmetricrocSeries, other : MlmetricrocSeries) -> MlmetricrocSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetricrocSeries::sub(self : MlmetricrocSeries, other : MlmetricrocSeries) -> MlmetricrocSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetricrocSeries::normalize(self : MlmetricrocSeries) -> MlmetricrocSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetricrocSeries::cumsum(self : MlmetricrocSeries) -> MlmetricrocSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetricrocSeries::to_string(self : MlmetricrocSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricrocMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_roc_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricrocMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_roc_matrix_identity(n : Int) -> MlmetricrocMatrix {
  let m = ml_metric_roc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetricrocMatrix::get(self : MlmetricrocMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetricrocMatrix::transpose(self : MlmetricrocMatrix) -> MlmetricrocMatrix {
  let result = ml_metric_roc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetricrocMatrix::add(self : MlmetricrocMatrix, other : MlmetricrocMatrix) -> MlmetricrocMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_roc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetricrocMatrix::scale(self : MlmetricrocMatrix, s : Double) -> MlmetricrocMatrix {
  let result = ml_metric_roc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetricrocMatrix::multiply(self : MlmetricrocMatrix, other : MlmetricrocMatrix) -> MlmetricrocMatrix {
  if self.cols != other.rows { return ml_metric_roc_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_roc_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlmetricrocMatrix::trace(self : MlmetricrocMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetricrocMatrix::det(self : MlmetricrocMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetricrocMatrix::norm(self : MlmetricrocMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetricrocMatrix::to_string(self : MlmetricrocMatrix) -> String {
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

pub(all) struct MlmetricrocVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_roc_make_vector(comps : Array[Double]) -> MlmetricrocVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_roc_vector_zero(dim : Int) -> MlmetricrocVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetricrocVector::add(self : MlmetricrocVector, other : MlmetricrocVector) -> MlmetricrocVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricrocVector::sub(self : MlmetricrocVector, other : MlmetricrocVector) -> MlmetricrocVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricrocVector::scale(self : MlmetricrocVector, s : Double) -> MlmetricrocVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetricrocVector::dot(self : MlmetricrocVector, other : MlmetricrocVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetricrocVector::norm(self : MlmetricrocVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetricrocVector::normalize(self : MlmetricrocVector) -> MlmetricrocVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricrocVector::dist(self : MlmetricrocVector, other : MlmetricrocVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetricrocVector::to_string(self : MlmetricrocVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_roc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_roc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_roc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_roc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_roc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_roc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_roc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_roc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_roc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_roc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_roc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_roc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_roc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_roc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_roc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_roc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_roc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_roc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_roc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_roc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_roc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_roc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_roc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_roc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_roc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_roc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_roc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_roc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_roc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricrocFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_frame_make(size : Int) -> MlmetricrocFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_frame_len(s : MlmetricrocFrame) -> Int { s.size }

pub fn ml_metric_roc_frame_get(s : MlmetricrocFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_frame_set(s : MlmetricrocFrame, i : Int, v : Double) -> MlmetricrocFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_frame_sum(s : MlmetricrocFrame) -> Double { @_common.sum(s.data) }

pub fn ml_metric_roc_frame_mean(s : MlmetricrocFrame) -> Double { @_common.mean(s.data) }

pub fn ml_metric_roc_frame_scale(s : MlmetricrocFrame, f : Double) -> MlmetricrocFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_frame_add(a : MlmetricrocFrame, b : MlmetricrocFrame) -> MlmetricrocFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_roc_frame_copy(s : MlmetricrocFrame) -> MlmetricrocFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_frame_fill(s : MlmetricrocFrame, v : Double) -> MlmetricrocFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_frame_min(s : MlmetricrocFrame) -> Double { @_common.min(s.data) }

pub fn ml_metric_roc_frame_max(s : MlmetricrocFrame) -> Double { @_common.max(s.data) }

pub fn ml_metric_roc_frame_to_string(s : MlmetricrocFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_table_make(size : Int) -> MlmetricrocTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_table_len(s : MlmetricrocTable) -> Int { s.size }

pub fn ml_metric_roc_table_get(s : MlmetricrocTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_table_set(s : MlmetricrocTable, i : Int, v : Double) -> MlmetricrocTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_table_sum(s : MlmetricrocTable) -> Double { @_common.sum(s.data) }

pub fn ml_metric_roc_table_mean(s : MlmetricrocTable) -> Double { @_common.mean(s.data) }

pub fn ml_metric_roc_table_scale(s : MlmetricrocTable, f : Double) -> MlmetricrocTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_table_add(a : MlmetricrocTable, b : MlmetricrocTable) -> MlmetricrocTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_roc_table_copy(s : MlmetricrocTable) -> MlmetricrocTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_table_fill(s : MlmetricrocTable, v : Double) -> MlmetricrocTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_table_min(s : MlmetricrocTable) -> Double { @_common.min(s.data) }

pub fn ml_metric_roc_table_max(s : MlmetricrocTable) -> Double { @_common.max(s.data) }

pub fn ml_metric_roc_table_to_string(s : MlmetricrocTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_graphn_make(size : Int) -> MlmetricrocGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_graphn_len(s : MlmetricrocGraphN) -> Int { s.size }

pub fn ml_metric_roc_graphn_get(s : MlmetricrocGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_graphn_set(s : MlmetricrocGraphN, i : Int, v : Double) -> MlmetricrocGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_graphn_sum(s : MlmetricrocGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_metric_roc_graphn_mean(s : MlmetricrocGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_metric_roc_graphn_scale(s : MlmetricrocGraphN, f : Double) -> MlmetricrocGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_graphn_add(a : MlmetricrocGraphN, b : MlmetricrocGraphN) -> MlmetricrocGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_roc_graphn_copy(s : MlmetricrocGraphN) -> MlmetricrocGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_graphn_fill(s : MlmetricrocGraphN, v : Double) -> MlmetricrocGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_graphn_min(s : MlmetricrocGraphN) -> Double { @_common.min(s.data) }

pub fn ml_metric_roc_graphn_max(s : MlmetricrocGraphN) -> Double { @_common.max(s.data) }

pub fn ml_metric_roc_graphn_to_string(s : MlmetricrocGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_node_make(size : Int) -> MlmetricrocNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_node_len(s : MlmetricrocNode) -> Int { s.size }

pub fn ml_metric_roc_node_get(s : MlmetricrocNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_node_set(s : MlmetricrocNode, i : Int, v : Double) -> MlmetricrocNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_node_sum(s : MlmetricrocNode) -> Double { @_common.sum(s.data) }

pub fn ml_metric_roc_node_mean(s : MlmetricrocNode) -> Double { @_common.mean(s.data) }

pub fn ml_metric_roc_node_scale(s : MlmetricrocNode, f : Double) -> MlmetricrocNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_node_add(a : MlmetricrocNode, b : MlmetricrocNode) -> MlmetricrocNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_roc_node_copy(s : MlmetricrocNode) -> MlmetricrocNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_node_fill(s : MlmetricrocNode, v : Double) -> MlmetricrocNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_node_min(s : MlmetricrocNode) -> Double { @_common.min(s.data) }

pub fn ml_metric_roc_node_max(s : MlmetricrocNode) -> Double { @_common.max(s.data) }

pub fn ml_metric_roc_node_to_string(s : MlmetricrocNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_edge_make(size : Int) -> MlmetricrocEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_edge_len(s : MlmetricrocEdge) -> Int { s.size }

pub fn ml_metric_roc_edge_get(s : MlmetricrocEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_edge_set(s : MlmetricrocEdge, i : Int, v : Double) -> MlmetricrocEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_edge_sum(s : MlmetricrocEdge) -> Double { @_common.sum(s.data) }

pub fn ml_metric_roc_edge_mean(s : MlmetricrocEdge) -> Double { @_common.mean(s.data) }

pub fn ml_metric_roc_edge_scale(s : MlmetricrocEdge, f : Double) -> MlmetricrocEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_edge_add(a : MlmetricrocEdge, b : MlmetricrocEdge) -> MlmetricrocEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_roc_edge_copy(s : MlmetricrocEdge) -> MlmetricrocEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_edge_fill(s : MlmetricrocEdge, v : Double) -> MlmetricrocEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_edge_min(s : MlmetricrocEdge) -> Double { @_common.min(s.data) }

pub fn ml_metric_roc_edge_max(s : MlmetricrocEdge) -> Double { @_common.max(s.data) }

pub fn ml_metric_roc_edge_to_string(s : MlmetricrocEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_path_make(size : Int) -> MlmetricrocPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_path_len(s : MlmetricrocPath) -> Int { s.size }

pub fn ml_metric_roc_path_get(s : MlmetricrocPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_path_set(s : MlmetricrocPath, i : Int, v : Double) -> MlmetricrocPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_path_sum(s : MlmetricrocPath) -> Double { @_common.sum(s.data) }

pub fn ml_metric_roc_path_mean(s : MlmetricrocPath) -> Double { @_common.mean(s.data) }

pub fn ml_metric_roc_path_scale(s : MlmetricrocPath, f : Double) -> MlmetricrocPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_path_add(a : MlmetricrocPath, b : MlmetricrocPath) -> MlmetricrocPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_roc_path_copy(s : MlmetricrocPath) -> MlmetricrocPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_path_fill(s : MlmetricrocPath, v : Double) -> MlmetricrocPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_path_min(s : MlmetricrocPath) -> Double { @_common.min(s.data) }

pub fn ml_metric_roc_path_max(s : MlmetricrocPath) -> Double { @_common.max(s.data) }

pub fn ml_metric_roc_path_to_string(s : MlmetricrocPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_cluster_make(size : Int) -> MlmetricrocCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_cluster_len(s : MlmetricrocCluster) -> Int { s.size }

pub fn ml_metric_roc_cluster_get(s : MlmetricrocCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_cluster_set(s : MlmetricrocCluster, i : Int, v : Double) -> MlmetricrocCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_cluster_sum(s : MlmetricrocCluster) -> Double { @_common.sum(s.data) }

pub fn ml_metric_roc_cluster_mean(s : MlmetricrocCluster) -> Double { @_common.mean(s.data) }

pub fn ml_metric_roc_cluster_scale(s : MlmetricrocCluster, f : Double) -> MlmetricrocCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_cluster_add(a : MlmetricrocCluster, b : MlmetricrocCluster) -> MlmetricrocCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_roc_cluster_copy(s : MlmetricrocCluster) -> MlmetricrocCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_cluster_fill(s : MlmetricrocCluster, v : Double) -> MlmetricrocCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_cluster_min(s : MlmetricrocCluster) -> Double { @_common.min(s.data) }

pub fn ml_metric_roc_cluster_max(s : MlmetricrocCluster) -> Double { @_common.max(s.data) }

pub fn ml_metric_roc_cluster_to_string(s : MlmetricrocCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_model_make(size : Int) -> MlmetricrocModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_model_len(s : MlmetricrocModel) -> Int { s.size }

pub fn ml_metric_roc_model_get(s : MlmetricrocModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_model_set(s : MlmetricrocModel, i : Int, v : Double) -> MlmetricrocModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_model_sum(s : MlmetricrocModel) -> Double { @_common.sum(s.data) }

pub fn ml_metric_roc_model_mean(s : MlmetricrocModel) -> Double { @_common.mean(s.data) }

pub fn ml_metric_roc_model_scale(s : MlmetricrocModel, f : Double) -> MlmetricrocModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_model_add(a : MlmetricrocModel, b : MlmetricrocModel) -> MlmetricrocModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_roc_model_copy(s : MlmetricrocModel) -> MlmetricrocModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_model_fill(s : MlmetricrocModel, v : Double) -> MlmetricrocModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_model_min(s : MlmetricrocModel) -> Double { @_common.min(s.data) }

pub fn ml_metric_roc_model_max(s : MlmetricrocModel) -> Double { @_common.max(s.data) }

pub fn ml_metric_roc_model_to_string(s : MlmetricrocModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_layer_make(size : Int) -> MlmetricrocLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_layer_len(s : MlmetricrocLayer) -> Int { s.size }

pub fn ml_metric_roc_layer_get(s : MlmetricrocLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_layer_set(s : MlmetricrocLayer, i : Int, v : Double) -> MlmetricrocLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_layer_sum(s : MlmetricrocLayer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_roc_layer_mean(s : MlmetricrocLayer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_roc_layer_scale(s : MlmetricrocLayer, f : Double) -> MlmetricrocLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_layer_add(a : MlmetricrocLayer, b : MlmetricrocLayer) -> MlmetricrocLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_roc_layer_copy(s : MlmetricrocLayer) -> MlmetricrocLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_layer_fill(s : MlmetricrocLayer, v : Double) -> MlmetricrocLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_layer_min(s : MlmetricrocLayer) -> Double { @_common.min(s.data) }

pub fn ml_metric_roc_layer_max(s : MlmetricrocLayer) -> Double { @_common.max(s.data) }

pub fn ml_metric_roc_layer_to_string(s : MlmetricrocLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_buffer_make(size : Int) -> MlmetricrocBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_buffer_len(s : MlmetricrocBuffer) -> Int { s.size }

pub fn ml_metric_roc_buffer_get(s : MlmetricrocBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_buffer_set(s : MlmetricrocBuffer, i : Int, v : Double) -> MlmetricrocBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_buffer_sum(s : MlmetricrocBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_roc_buffer_mean(s : MlmetricrocBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_roc_buffer_scale(s : MlmetricrocBuffer, f : Double) -> MlmetricrocBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_buffer_add(a : MlmetricrocBuffer, b : MlmetricrocBuffer) -> MlmetricrocBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_roc_buffer_copy(s : MlmetricrocBuffer) -> MlmetricrocBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_buffer_fill(s : MlmetricrocBuffer, v : Double) -> MlmetricrocBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_buffer_min(s : MlmetricrocBuffer) -> Double { @_common.min(s.data) }

pub fn ml_metric_roc_buffer_max(s : MlmetricrocBuffer) -> Double { @_common.max(s.data) }

pub fn ml_metric_roc_buffer_to_string(s : MlmetricrocBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_cursor_make(size : Int) -> MlmetricrocCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_cursor_len(s : MlmetricrocCursor) -> Int { s.size }

pub fn ml_metric_roc_cursor_get(s : MlmetricrocCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_cursor_set(s : MlmetricrocCursor, i : Int, v : Double) -> MlmetricrocCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_cursor_sum(s : MlmetricrocCursor) -> Double { @_common.sum(s.data) }

pub fn ml_metric_roc_cursor_mean(s : MlmetricrocCursor) -> Double { @_common.mean(s.data) }

pub fn ml_metric_roc_cursor_scale(s : MlmetricrocCursor, f : Double) -> MlmetricrocCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_cursor_add(a : MlmetricrocCursor, b : MlmetricrocCursor) -> MlmetricrocCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_roc_cursor_copy(s : MlmetricrocCursor) -> MlmetricrocCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_cursor_fill(s : MlmetricrocCursor, v : Double) -> MlmetricrocCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_cursor_min(s : MlmetricrocCursor) -> Double { @_common.min(s.data) }

pub fn ml_metric_roc_cursor_max(s : MlmetricrocCursor) -> Double { @_common.max(s.data) }

pub fn ml_metric_roc_cursor_to_string(s : MlmetricrocCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_view_make(size : Int) -> MlmetricrocView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_view_len(s : MlmetricrocView) -> Int { s.size }

pub fn ml_metric_roc_view_get(s : MlmetricrocView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_view_set(s : MlmetricrocView, i : Int, v : Double) -> MlmetricrocView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_view_sum(s : MlmetricrocView) -> Double { @_common.sum(s.data) }

pub fn ml_metric_roc_view_mean(s : MlmetricrocView) -> Double { @_common.mean(s.data) }

pub fn ml_metric_roc_view_scale(s : MlmetricrocView, f : Double) -> MlmetricrocView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_view_add(a : MlmetricrocView, b : MlmetricrocView) -> MlmetricrocView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_roc_view_copy(s : MlmetricrocView) -> MlmetricrocView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_view_fill(s : MlmetricrocView, v : Double) -> MlmetricrocView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_view_min(s : MlmetricrocView) -> Double { @_common.min(s.data) }

pub fn ml_metric_roc_view_max(s : MlmetricrocView) -> Double { @_common.max(s.data) }

pub fn ml_metric_roc_view_to_string(s : MlmetricrocView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_range_make(size : Int) -> MlmetricrocRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_range_len(s : MlmetricrocRange) -> Int { s.size }

pub fn ml_metric_roc_range_get(s : MlmetricrocRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_range_set(s : MlmetricrocRange, i : Int, v : Double) -> MlmetricrocRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_range_sum(s : MlmetricrocRange) -> Double { @_common.sum(s.data) }

pub fn ml_metric_roc_range_mean(s : MlmetricrocRange) -> Double { @_common.mean(s.data) }

pub fn ml_metric_roc_range_scale(s : MlmetricrocRange, f : Double) -> MlmetricrocRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_range_add(a : MlmetricrocRange, b : MlmetricrocRange) -> MlmetricrocRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_roc_range_copy(s : MlmetricrocRange) -> MlmetricrocRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_range_fill(s : MlmetricrocRange, v : Double) -> MlmetricrocRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_range_min(s : MlmetricrocRange) -> Double { @_common.min(s.data) }

pub fn ml_metric_roc_range_max(s : MlmetricrocRange) -> Double { @_common.max(s.data) }

pub fn ml_metric_roc_range_to_string(s : MlmetricrocRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricrocSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_slice_make(size : Int) -> MlmetricrocSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_roc_slice_len(s : MlmetricrocSlice) -> Int { s.size }

pub fn ml_metric_roc_slice_get(s : MlmetricrocSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_roc_slice_set(s : MlmetricrocSlice, i : Int, v : Double) -> MlmetricrocSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_slice_sum(s : MlmetricrocSlice) -> Double { @_common.sum(s.data) }

pub fn ml_metric_roc_slice_mean(s : MlmetricrocSlice) -> Double { @_common.mean(s.data) }

pub fn ml_metric_roc_slice_scale(s : MlmetricrocSlice, f : Double) -> MlmetricrocSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_slice_add(a : MlmetricrocSlice, b : MlmetricrocSlice) -> MlmetricrocSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_roc_slice_copy(s : MlmetricrocSlice) -> MlmetricrocSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_slice_fill(s : MlmetricrocSlice, v : Double) -> MlmetricrocSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_roc_slice_min(s : MlmetricrocSlice) -> Double { @_common.min(s.data) }

pub fn ml_metric_roc_slice_max(s : MlmetricrocSlice) -> Double { @_common.max(s.data) }

pub fn ml_metric_roc_slice_to_string(s : MlmetricrocSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

