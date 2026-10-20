///===
/// extcore/ml_metric_confusion

pub(all) struct MlmetricconfusionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_confusion_make_point(x : Double, y : Double) -> MlmetricconfusionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_confusion_make_point3(x : Double, y : Double, z : Double) -> MlmetricconfusionPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetricconfusionPoint::x(self : MlmetricconfusionPoint) -> Double { self.x }

pub fn MlmetricconfusionPoint::y(self : MlmetricconfusionPoint) -> Double { self.y }

pub fn MlmetricconfusionPoint::z(self : MlmetricconfusionPoint) -> Double { self.z }

pub fn MlmetricconfusionPoint::label(self : MlmetricconfusionPoint) -> Int { self.label }

pub fn MlmetricconfusionPoint::dist(self : MlmetricconfusionPoint, other : MlmetricconfusionPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetricconfusionPoint::add(self : MlmetricconfusionPoint, other : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetricconfusionPoint::sub(self : MlmetricconfusionPoint, other : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetricconfusionPoint::scale(self : MlmetricconfusionPoint, s : Double) -> MlmetricconfusionPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetricconfusionPoint::dot(self : MlmetricconfusionPoint, other : MlmetricconfusionPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetricconfusionPoint::cross(self : MlmetricconfusionPoint, other : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetricconfusionPoint::norm(self : MlmetricconfusionPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetricconfusionPoint::normalize(self : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricconfusionPoint::negate(self : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetricconfusionPoint::mid(self : MlmetricconfusionPoint, other : MlmetricconfusionPoint) -> MlmetricconfusionPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetricconfusionPoint::lerp(self : MlmetricconfusionPoint, other : MlmetricconfusionPoint, t : Double) -> MlmetricconfusionPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetricconfusionPoint::to_string(self : MlmetricconfusionPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetricconfusionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_confusion_make_series(vals : Array[Double], name : String) -> MlmetricconfusionSeries {
  { vals, name, meta: 0 }
}

pub fn MlmetricconfusionSeries::len(self : MlmetricconfusionSeries) -> Int { self.vals.length() }

pub fn MlmetricconfusionSeries::sum(self : MlmetricconfusionSeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetricconfusionSeries::mean(self : MlmetricconfusionSeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetricconfusionSeries::min(self : MlmetricconfusionSeries) -> Double { @_common.min(self.vals) }

pub fn MlmetricconfusionSeries::max(self : MlmetricconfusionSeries) -> Double { @_common.max(self.vals) }

pub fn MlmetricconfusionSeries::range(self : MlmetricconfusionSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetricconfusionSeries::variance(self : MlmetricconfusionSeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetricconfusionSeries::std(self : MlmetricconfusionSeries) -> Double { @_common.std(self.vals) }

pub fn MlmetricconfusionSeries::median(self : MlmetricconfusionSeries) -> Double { @_common.median(self.vals) }

pub fn MlmetricconfusionSeries::scale(self : MlmetricconfusionSeries, f : Double) -> MlmetricconfusionSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetricconfusionSeries::add(self : MlmetricconfusionSeries, other : MlmetricconfusionSeries) -> MlmetricconfusionSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetricconfusionSeries::sub(self : MlmetricconfusionSeries, other : MlmetricconfusionSeries) -> MlmetricconfusionSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetricconfusionSeries::normalize(self : MlmetricconfusionSeries) -> MlmetricconfusionSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetricconfusionSeries::cumsum(self : MlmetricconfusionSeries) -> MlmetricconfusionSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetricconfusionSeries::to_string(self : MlmetricconfusionSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricconfusionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_confusion_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricconfusionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_confusion_matrix_identity(n : Int) -> MlmetricconfusionMatrix {
  let m = ml_metric_confusion_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetricconfusionMatrix::get(self : MlmetricconfusionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetricconfusionMatrix::transpose(self : MlmetricconfusionMatrix) -> MlmetricconfusionMatrix {
  let result = ml_metric_confusion_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetricconfusionMatrix::add(self : MlmetricconfusionMatrix, other : MlmetricconfusionMatrix) -> MlmetricconfusionMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_confusion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetricconfusionMatrix::scale(self : MlmetricconfusionMatrix, s : Double) -> MlmetricconfusionMatrix {
  let result = ml_metric_confusion_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetricconfusionMatrix::multiply(self : MlmetricconfusionMatrix, other : MlmetricconfusionMatrix) -> MlmetricconfusionMatrix {
  if self.cols != other.rows { return ml_metric_confusion_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_confusion_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlmetricconfusionMatrix::trace(self : MlmetricconfusionMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetricconfusionMatrix::det(self : MlmetricconfusionMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetricconfusionMatrix::norm(self : MlmetricconfusionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetricconfusionMatrix::to_string(self : MlmetricconfusionMatrix) -> String {
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

pub(all) struct MlmetricconfusionVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_confusion_make_vector(comps : Array[Double]) -> MlmetricconfusionVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_confusion_vector_zero(dim : Int) -> MlmetricconfusionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetricconfusionVector::add(self : MlmetricconfusionVector, other : MlmetricconfusionVector) -> MlmetricconfusionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricconfusionVector::sub(self : MlmetricconfusionVector, other : MlmetricconfusionVector) -> MlmetricconfusionVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricconfusionVector::scale(self : MlmetricconfusionVector, s : Double) -> MlmetricconfusionVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetricconfusionVector::dot(self : MlmetricconfusionVector, other : MlmetricconfusionVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetricconfusionVector::norm(self : MlmetricconfusionVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetricconfusionVector::normalize(self : MlmetricconfusionVector) -> MlmetricconfusionVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricconfusionVector::dist(self : MlmetricconfusionVector, other : MlmetricconfusionVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetricconfusionVector::to_string(self : MlmetricconfusionVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_confusion_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_confusion_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_confusion_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_confusion_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_confusion_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_confusion_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_confusion_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_confusion_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_confusion_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_confusion_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_confusion_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_confusion_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_confusion_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_confusion_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_confusion_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_confusion_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_confusion_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_confusion_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_confusion_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_confusion_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_confusion_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_confusion_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_confusion_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_confusion_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_confusion_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_confusion_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_confusion_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_confusion_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_confusion_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricconfusionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_frame_make(size : Int) -> MlmetricconfusionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_frame_len(s : MlmetricconfusionFrame) -> Int { s.size }

pub fn ml_metric_confusion_frame_get(s : MlmetricconfusionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_frame_set(s : MlmetricconfusionFrame, i : Int, v : Double) -> MlmetricconfusionFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_frame_sum(s : MlmetricconfusionFrame) -> Double { @_common.sum(s.data) }

pub fn ml_metric_confusion_frame_mean(s : MlmetricconfusionFrame) -> Double { @_common.mean(s.data) }

pub fn ml_metric_confusion_frame_scale(s : MlmetricconfusionFrame, f : Double) -> MlmetricconfusionFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_frame_add(a : MlmetricconfusionFrame, b : MlmetricconfusionFrame) -> MlmetricconfusionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_confusion_frame_copy(s : MlmetricconfusionFrame) -> MlmetricconfusionFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_frame_fill(s : MlmetricconfusionFrame, v : Double) -> MlmetricconfusionFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_frame_min(s : MlmetricconfusionFrame) -> Double { @_common.min(s.data) }

pub fn ml_metric_confusion_frame_max(s : MlmetricconfusionFrame) -> Double { @_common.max(s.data) }

pub fn ml_metric_confusion_frame_to_string(s : MlmetricconfusionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_table_make(size : Int) -> MlmetricconfusionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_table_len(s : MlmetricconfusionTable) -> Int { s.size }

pub fn ml_metric_confusion_table_get(s : MlmetricconfusionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_table_set(s : MlmetricconfusionTable, i : Int, v : Double) -> MlmetricconfusionTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_table_sum(s : MlmetricconfusionTable) -> Double { @_common.sum(s.data) }

pub fn ml_metric_confusion_table_mean(s : MlmetricconfusionTable) -> Double { @_common.mean(s.data) }

pub fn ml_metric_confusion_table_scale(s : MlmetricconfusionTable, f : Double) -> MlmetricconfusionTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_table_add(a : MlmetricconfusionTable, b : MlmetricconfusionTable) -> MlmetricconfusionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_confusion_table_copy(s : MlmetricconfusionTable) -> MlmetricconfusionTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_table_fill(s : MlmetricconfusionTable, v : Double) -> MlmetricconfusionTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_table_min(s : MlmetricconfusionTable) -> Double { @_common.min(s.data) }

pub fn ml_metric_confusion_table_max(s : MlmetricconfusionTable) -> Double { @_common.max(s.data) }

pub fn ml_metric_confusion_table_to_string(s : MlmetricconfusionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_graphn_make(size : Int) -> MlmetricconfusionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_graphn_len(s : MlmetricconfusionGraphN) -> Int { s.size }

pub fn ml_metric_confusion_graphn_get(s : MlmetricconfusionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_graphn_set(s : MlmetricconfusionGraphN, i : Int, v : Double) -> MlmetricconfusionGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_graphn_sum(s : MlmetricconfusionGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_metric_confusion_graphn_mean(s : MlmetricconfusionGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_metric_confusion_graphn_scale(s : MlmetricconfusionGraphN, f : Double) -> MlmetricconfusionGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_graphn_add(a : MlmetricconfusionGraphN, b : MlmetricconfusionGraphN) -> MlmetricconfusionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_confusion_graphn_copy(s : MlmetricconfusionGraphN) -> MlmetricconfusionGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_graphn_fill(s : MlmetricconfusionGraphN, v : Double) -> MlmetricconfusionGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_graphn_min(s : MlmetricconfusionGraphN) -> Double { @_common.min(s.data) }

pub fn ml_metric_confusion_graphn_max(s : MlmetricconfusionGraphN) -> Double { @_common.max(s.data) }

pub fn ml_metric_confusion_graphn_to_string(s : MlmetricconfusionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_node_make(size : Int) -> MlmetricconfusionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_node_len(s : MlmetricconfusionNode) -> Int { s.size }

pub fn ml_metric_confusion_node_get(s : MlmetricconfusionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_node_set(s : MlmetricconfusionNode, i : Int, v : Double) -> MlmetricconfusionNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_node_sum(s : MlmetricconfusionNode) -> Double { @_common.sum(s.data) }

pub fn ml_metric_confusion_node_mean(s : MlmetricconfusionNode) -> Double { @_common.mean(s.data) }

pub fn ml_metric_confusion_node_scale(s : MlmetricconfusionNode, f : Double) -> MlmetricconfusionNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_node_add(a : MlmetricconfusionNode, b : MlmetricconfusionNode) -> MlmetricconfusionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_confusion_node_copy(s : MlmetricconfusionNode) -> MlmetricconfusionNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_node_fill(s : MlmetricconfusionNode, v : Double) -> MlmetricconfusionNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_node_min(s : MlmetricconfusionNode) -> Double { @_common.min(s.data) }

pub fn ml_metric_confusion_node_max(s : MlmetricconfusionNode) -> Double { @_common.max(s.data) }

pub fn ml_metric_confusion_node_to_string(s : MlmetricconfusionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_edge_make(size : Int) -> MlmetricconfusionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_edge_len(s : MlmetricconfusionEdge) -> Int { s.size }

pub fn ml_metric_confusion_edge_get(s : MlmetricconfusionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_edge_set(s : MlmetricconfusionEdge, i : Int, v : Double) -> MlmetricconfusionEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_edge_sum(s : MlmetricconfusionEdge) -> Double { @_common.sum(s.data) }

pub fn ml_metric_confusion_edge_mean(s : MlmetricconfusionEdge) -> Double { @_common.mean(s.data) }

pub fn ml_metric_confusion_edge_scale(s : MlmetricconfusionEdge, f : Double) -> MlmetricconfusionEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_edge_add(a : MlmetricconfusionEdge, b : MlmetricconfusionEdge) -> MlmetricconfusionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_confusion_edge_copy(s : MlmetricconfusionEdge) -> MlmetricconfusionEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_edge_fill(s : MlmetricconfusionEdge, v : Double) -> MlmetricconfusionEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_edge_min(s : MlmetricconfusionEdge) -> Double { @_common.min(s.data) }

pub fn ml_metric_confusion_edge_max(s : MlmetricconfusionEdge) -> Double { @_common.max(s.data) }

pub fn ml_metric_confusion_edge_to_string(s : MlmetricconfusionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_path_make(size : Int) -> MlmetricconfusionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_path_len(s : MlmetricconfusionPath) -> Int { s.size }

pub fn ml_metric_confusion_path_get(s : MlmetricconfusionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_path_set(s : MlmetricconfusionPath, i : Int, v : Double) -> MlmetricconfusionPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_path_sum(s : MlmetricconfusionPath) -> Double { @_common.sum(s.data) }

pub fn ml_metric_confusion_path_mean(s : MlmetricconfusionPath) -> Double { @_common.mean(s.data) }

pub fn ml_metric_confusion_path_scale(s : MlmetricconfusionPath, f : Double) -> MlmetricconfusionPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_path_add(a : MlmetricconfusionPath, b : MlmetricconfusionPath) -> MlmetricconfusionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_confusion_path_copy(s : MlmetricconfusionPath) -> MlmetricconfusionPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_path_fill(s : MlmetricconfusionPath, v : Double) -> MlmetricconfusionPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_path_min(s : MlmetricconfusionPath) -> Double { @_common.min(s.data) }

pub fn ml_metric_confusion_path_max(s : MlmetricconfusionPath) -> Double { @_common.max(s.data) }

pub fn ml_metric_confusion_path_to_string(s : MlmetricconfusionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_cluster_make(size : Int) -> MlmetricconfusionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_cluster_len(s : MlmetricconfusionCluster) -> Int { s.size }

pub fn ml_metric_confusion_cluster_get(s : MlmetricconfusionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_cluster_set(s : MlmetricconfusionCluster, i : Int, v : Double) -> MlmetricconfusionCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_cluster_sum(s : MlmetricconfusionCluster) -> Double { @_common.sum(s.data) }

pub fn ml_metric_confusion_cluster_mean(s : MlmetricconfusionCluster) -> Double { @_common.mean(s.data) }

pub fn ml_metric_confusion_cluster_scale(s : MlmetricconfusionCluster, f : Double) -> MlmetricconfusionCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_cluster_add(a : MlmetricconfusionCluster, b : MlmetricconfusionCluster) -> MlmetricconfusionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_confusion_cluster_copy(s : MlmetricconfusionCluster) -> MlmetricconfusionCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_cluster_fill(s : MlmetricconfusionCluster, v : Double) -> MlmetricconfusionCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_cluster_min(s : MlmetricconfusionCluster) -> Double { @_common.min(s.data) }

pub fn ml_metric_confusion_cluster_max(s : MlmetricconfusionCluster) -> Double { @_common.max(s.data) }

pub fn ml_metric_confusion_cluster_to_string(s : MlmetricconfusionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_model_make(size : Int) -> MlmetricconfusionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_model_len(s : MlmetricconfusionModel) -> Int { s.size }

pub fn ml_metric_confusion_model_get(s : MlmetricconfusionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_model_set(s : MlmetricconfusionModel, i : Int, v : Double) -> MlmetricconfusionModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_model_sum(s : MlmetricconfusionModel) -> Double { @_common.sum(s.data) }

pub fn ml_metric_confusion_model_mean(s : MlmetricconfusionModel) -> Double { @_common.mean(s.data) }

pub fn ml_metric_confusion_model_scale(s : MlmetricconfusionModel, f : Double) -> MlmetricconfusionModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_model_add(a : MlmetricconfusionModel, b : MlmetricconfusionModel) -> MlmetricconfusionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_confusion_model_copy(s : MlmetricconfusionModel) -> MlmetricconfusionModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_model_fill(s : MlmetricconfusionModel, v : Double) -> MlmetricconfusionModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_model_min(s : MlmetricconfusionModel) -> Double { @_common.min(s.data) }

pub fn ml_metric_confusion_model_max(s : MlmetricconfusionModel) -> Double { @_common.max(s.data) }

pub fn ml_metric_confusion_model_to_string(s : MlmetricconfusionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_layer_make(size : Int) -> MlmetricconfusionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_layer_len(s : MlmetricconfusionLayer) -> Int { s.size }

pub fn ml_metric_confusion_layer_get(s : MlmetricconfusionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_layer_set(s : MlmetricconfusionLayer, i : Int, v : Double) -> MlmetricconfusionLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_layer_sum(s : MlmetricconfusionLayer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_confusion_layer_mean(s : MlmetricconfusionLayer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_confusion_layer_scale(s : MlmetricconfusionLayer, f : Double) -> MlmetricconfusionLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_layer_add(a : MlmetricconfusionLayer, b : MlmetricconfusionLayer) -> MlmetricconfusionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_confusion_layer_copy(s : MlmetricconfusionLayer) -> MlmetricconfusionLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_layer_fill(s : MlmetricconfusionLayer, v : Double) -> MlmetricconfusionLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_layer_min(s : MlmetricconfusionLayer) -> Double { @_common.min(s.data) }

pub fn ml_metric_confusion_layer_max(s : MlmetricconfusionLayer) -> Double { @_common.max(s.data) }

pub fn ml_metric_confusion_layer_to_string(s : MlmetricconfusionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_buffer_make(size : Int) -> MlmetricconfusionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_buffer_len(s : MlmetricconfusionBuffer) -> Int { s.size }

pub fn ml_metric_confusion_buffer_get(s : MlmetricconfusionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_buffer_set(s : MlmetricconfusionBuffer, i : Int, v : Double) -> MlmetricconfusionBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_buffer_sum(s : MlmetricconfusionBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_confusion_buffer_mean(s : MlmetricconfusionBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_confusion_buffer_scale(s : MlmetricconfusionBuffer, f : Double) -> MlmetricconfusionBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_buffer_add(a : MlmetricconfusionBuffer, b : MlmetricconfusionBuffer) -> MlmetricconfusionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_confusion_buffer_copy(s : MlmetricconfusionBuffer) -> MlmetricconfusionBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_buffer_fill(s : MlmetricconfusionBuffer, v : Double) -> MlmetricconfusionBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_buffer_min(s : MlmetricconfusionBuffer) -> Double { @_common.min(s.data) }

pub fn ml_metric_confusion_buffer_max(s : MlmetricconfusionBuffer) -> Double { @_common.max(s.data) }

pub fn ml_metric_confusion_buffer_to_string(s : MlmetricconfusionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_cursor_make(size : Int) -> MlmetricconfusionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_cursor_len(s : MlmetricconfusionCursor) -> Int { s.size }

pub fn ml_metric_confusion_cursor_get(s : MlmetricconfusionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_cursor_set(s : MlmetricconfusionCursor, i : Int, v : Double) -> MlmetricconfusionCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_cursor_sum(s : MlmetricconfusionCursor) -> Double { @_common.sum(s.data) }

pub fn ml_metric_confusion_cursor_mean(s : MlmetricconfusionCursor) -> Double { @_common.mean(s.data) }

pub fn ml_metric_confusion_cursor_scale(s : MlmetricconfusionCursor, f : Double) -> MlmetricconfusionCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_cursor_add(a : MlmetricconfusionCursor, b : MlmetricconfusionCursor) -> MlmetricconfusionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_confusion_cursor_copy(s : MlmetricconfusionCursor) -> MlmetricconfusionCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_cursor_fill(s : MlmetricconfusionCursor, v : Double) -> MlmetricconfusionCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_cursor_min(s : MlmetricconfusionCursor) -> Double { @_common.min(s.data) }

pub fn ml_metric_confusion_cursor_max(s : MlmetricconfusionCursor) -> Double { @_common.max(s.data) }

pub fn ml_metric_confusion_cursor_to_string(s : MlmetricconfusionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_view_make(size : Int) -> MlmetricconfusionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_view_len(s : MlmetricconfusionView) -> Int { s.size }

pub fn ml_metric_confusion_view_get(s : MlmetricconfusionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_view_set(s : MlmetricconfusionView, i : Int, v : Double) -> MlmetricconfusionView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_view_sum(s : MlmetricconfusionView) -> Double { @_common.sum(s.data) }

pub fn ml_metric_confusion_view_mean(s : MlmetricconfusionView) -> Double { @_common.mean(s.data) }

pub fn ml_metric_confusion_view_scale(s : MlmetricconfusionView, f : Double) -> MlmetricconfusionView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_view_add(a : MlmetricconfusionView, b : MlmetricconfusionView) -> MlmetricconfusionView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_confusion_view_copy(s : MlmetricconfusionView) -> MlmetricconfusionView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_view_fill(s : MlmetricconfusionView, v : Double) -> MlmetricconfusionView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_view_min(s : MlmetricconfusionView) -> Double { @_common.min(s.data) }

pub fn ml_metric_confusion_view_max(s : MlmetricconfusionView) -> Double { @_common.max(s.data) }

pub fn ml_metric_confusion_view_to_string(s : MlmetricconfusionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_range_make(size : Int) -> MlmetricconfusionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_range_len(s : MlmetricconfusionRange) -> Int { s.size }

pub fn ml_metric_confusion_range_get(s : MlmetricconfusionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_range_set(s : MlmetricconfusionRange, i : Int, v : Double) -> MlmetricconfusionRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_range_sum(s : MlmetricconfusionRange) -> Double { @_common.sum(s.data) }

pub fn ml_metric_confusion_range_mean(s : MlmetricconfusionRange) -> Double { @_common.mean(s.data) }

pub fn ml_metric_confusion_range_scale(s : MlmetricconfusionRange, f : Double) -> MlmetricconfusionRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_range_add(a : MlmetricconfusionRange, b : MlmetricconfusionRange) -> MlmetricconfusionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_confusion_range_copy(s : MlmetricconfusionRange) -> MlmetricconfusionRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_range_fill(s : MlmetricconfusionRange, v : Double) -> MlmetricconfusionRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_range_min(s : MlmetricconfusionRange) -> Double { @_common.min(s.data) }

pub fn ml_metric_confusion_range_max(s : MlmetricconfusionRange) -> Double { @_common.max(s.data) }

pub fn ml_metric_confusion_range_to_string(s : MlmetricconfusionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricconfusionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_confusion_slice_make(size : Int) -> MlmetricconfusionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_confusion_slice_len(s : MlmetricconfusionSlice) -> Int { s.size }

pub fn ml_metric_confusion_slice_get(s : MlmetricconfusionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_confusion_slice_set(s : MlmetricconfusionSlice, i : Int, v : Double) -> MlmetricconfusionSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_slice_sum(s : MlmetricconfusionSlice) -> Double { @_common.sum(s.data) }

pub fn ml_metric_confusion_slice_mean(s : MlmetricconfusionSlice) -> Double { @_common.mean(s.data) }

pub fn ml_metric_confusion_slice_scale(s : MlmetricconfusionSlice, f : Double) -> MlmetricconfusionSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_slice_add(a : MlmetricconfusionSlice, b : MlmetricconfusionSlice) -> MlmetricconfusionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_confusion_slice_copy(s : MlmetricconfusionSlice) -> MlmetricconfusionSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_slice_fill(s : MlmetricconfusionSlice, v : Double) -> MlmetricconfusionSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_confusion_slice_min(s : MlmetricconfusionSlice) -> Double { @_common.min(s.data) }

pub fn ml_metric_confusion_slice_max(s : MlmetricconfusionSlice) -> Double { @_common.max(s.data) }

pub fn ml_metric_confusion_slice_to_string(s : MlmetricconfusionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

