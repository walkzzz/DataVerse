///===
/// extcore/ml_metric_interpret

pub(all) struct MlmetricinterpretPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_interpret_make_point(x : Double, y : Double) -> MlmetricinterpretPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_interpret_make_point3(x : Double, y : Double, z : Double) -> MlmetricinterpretPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetricinterpretPoint::x(self : MlmetricinterpretPoint) -> Double { self.x }

pub fn MlmetricinterpretPoint::y(self : MlmetricinterpretPoint) -> Double { self.y }

pub fn MlmetricinterpretPoint::z(self : MlmetricinterpretPoint) -> Double { self.z }

pub fn MlmetricinterpretPoint::label(self : MlmetricinterpretPoint) -> Int { self.label }

pub fn MlmetricinterpretPoint::dist(self : MlmetricinterpretPoint, other : MlmetricinterpretPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetricinterpretPoint::add(self : MlmetricinterpretPoint, other : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetricinterpretPoint::sub(self : MlmetricinterpretPoint, other : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetricinterpretPoint::scale(self : MlmetricinterpretPoint, s : Double) -> MlmetricinterpretPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetricinterpretPoint::dot(self : MlmetricinterpretPoint, other : MlmetricinterpretPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetricinterpretPoint::cross(self : MlmetricinterpretPoint, other : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetricinterpretPoint::norm(self : MlmetricinterpretPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetricinterpretPoint::normalize(self : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricinterpretPoint::negate(self : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetricinterpretPoint::mid(self : MlmetricinterpretPoint, other : MlmetricinterpretPoint) -> MlmetricinterpretPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetricinterpretPoint::lerp(self : MlmetricinterpretPoint, other : MlmetricinterpretPoint, t : Double) -> MlmetricinterpretPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetricinterpretPoint::to_string(self : MlmetricinterpretPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetricinterpretSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_interpret_make_series(vals : Array[Double], name : String) -> MlmetricinterpretSeries {
  { vals, name, meta: 0 }
}

pub fn MlmetricinterpretSeries::len(self : MlmetricinterpretSeries) -> Int { self.vals.length() }

pub fn MlmetricinterpretSeries::sum(self : MlmetricinterpretSeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetricinterpretSeries::mean(self : MlmetricinterpretSeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetricinterpretSeries::min(self : MlmetricinterpretSeries) -> Double { @_common.min(self.vals) }

pub fn MlmetricinterpretSeries::max(self : MlmetricinterpretSeries) -> Double { @_common.max(self.vals) }

pub fn MlmetricinterpretSeries::range(self : MlmetricinterpretSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetricinterpretSeries::variance(self : MlmetricinterpretSeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetricinterpretSeries::std(self : MlmetricinterpretSeries) -> Double { @_common.std(self.vals) }

pub fn MlmetricinterpretSeries::median(self : MlmetricinterpretSeries) -> Double { @_common.median(self.vals) }

pub fn MlmetricinterpretSeries::scale(self : MlmetricinterpretSeries, f : Double) -> MlmetricinterpretSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetricinterpretSeries::add(self : MlmetricinterpretSeries, other : MlmetricinterpretSeries) -> MlmetricinterpretSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetricinterpretSeries::sub(self : MlmetricinterpretSeries, other : MlmetricinterpretSeries) -> MlmetricinterpretSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetricinterpretSeries::normalize(self : MlmetricinterpretSeries) -> MlmetricinterpretSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetricinterpretSeries::cumsum(self : MlmetricinterpretSeries) -> MlmetricinterpretSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetricinterpretSeries::to_string(self : MlmetricinterpretSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricinterpretMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_interpret_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricinterpretMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_interpret_matrix_identity(n : Int) -> MlmetricinterpretMatrix {
  let m = ml_metric_interpret_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetricinterpretMatrix::get(self : MlmetricinterpretMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetricinterpretMatrix::transpose(self : MlmetricinterpretMatrix) -> MlmetricinterpretMatrix {
  let result = ml_metric_interpret_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetricinterpretMatrix::add(self : MlmetricinterpretMatrix, other : MlmetricinterpretMatrix) -> MlmetricinterpretMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_interpret_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetricinterpretMatrix::scale(self : MlmetricinterpretMatrix, s : Double) -> MlmetricinterpretMatrix {
  let result = ml_metric_interpret_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetricinterpretMatrix::multiply(self : MlmetricinterpretMatrix, other : MlmetricinterpretMatrix) -> MlmetricinterpretMatrix {
  if self.cols != other.rows { return ml_metric_interpret_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_interpret_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlmetricinterpretMatrix::trace(self : MlmetricinterpretMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetricinterpretMatrix::det(self : MlmetricinterpretMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetricinterpretMatrix::norm(self : MlmetricinterpretMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetricinterpretMatrix::to_string(self : MlmetricinterpretMatrix) -> String {
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

pub(all) struct MlmetricinterpretVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_interpret_make_vector(comps : Array[Double]) -> MlmetricinterpretVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_interpret_vector_zero(dim : Int) -> MlmetricinterpretVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetricinterpretVector::add(self : MlmetricinterpretVector, other : MlmetricinterpretVector) -> MlmetricinterpretVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricinterpretVector::sub(self : MlmetricinterpretVector, other : MlmetricinterpretVector) -> MlmetricinterpretVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricinterpretVector::scale(self : MlmetricinterpretVector, s : Double) -> MlmetricinterpretVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetricinterpretVector::dot(self : MlmetricinterpretVector, other : MlmetricinterpretVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetricinterpretVector::norm(self : MlmetricinterpretVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetricinterpretVector::normalize(self : MlmetricinterpretVector) -> MlmetricinterpretVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricinterpretVector::dist(self : MlmetricinterpretVector, other : MlmetricinterpretVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetricinterpretVector::to_string(self : MlmetricinterpretVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_interpret_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_interpret_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_interpret_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_interpret_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_interpret_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_interpret_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_interpret_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_interpret_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_interpret_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_interpret_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_interpret_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_interpret_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_interpret_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_interpret_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_interpret_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_interpret_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_interpret_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_interpret_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_interpret_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_interpret_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_interpret_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_interpret_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_interpret_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_interpret_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_interpret_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_interpret_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_interpret_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_interpret_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_interpret_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricinterpretFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_frame_make(size : Int) -> MlmetricinterpretFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_frame_len(s : MlmetricinterpretFrame) -> Int { s.size }

pub fn ml_metric_interpret_frame_get(s : MlmetricinterpretFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_frame_set(s : MlmetricinterpretFrame, i : Int, v : Double) -> MlmetricinterpretFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_frame_sum(s : MlmetricinterpretFrame) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_frame_mean(s : MlmetricinterpretFrame) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_frame_scale(s : MlmetricinterpretFrame, f : Double) -> MlmetricinterpretFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_frame_add(a : MlmetricinterpretFrame, b : MlmetricinterpretFrame) -> MlmetricinterpretFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_frame_copy(s : MlmetricinterpretFrame) -> MlmetricinterpretFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_frame_fill(s : MlmetricinterpretFrame, v : Double) -> MlmetricinterpretFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_frame_min(s : MlmetricinterpretFrame) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_frame_max(s : MlmetricinterpretFrame) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_frame_to_string(s : MlmetricinterpretFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_table_make(size : Int) -> MlmetricinterpretTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_table_len(s : MlmetricinterpretTable) -> Int { s.size }

pub fn ml_metric_interpret_table_get(s : MlmetricinterpretTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_table_set(s : MlmetricinterpretTable, i : Int, v : Double) -> MlmetricinterpretTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_table_sum(s : MlmetricinterpretTable) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_table_mean(s : MlmetricinterpretTable) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_table_scale(s : MlmetricinterpretTable, f : Double) -> MlmetricinterpretTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_table_add(a : MlmetricinterpretTable, b : MlmetricinterpretTable) -> MlmetricinterpretTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_table_copy(s : MlmetricinterpretTable) -> MlmetricinterpretTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_table_fill(s : MlmetricinterpretTable, v : Double) -> MlmetricinterpretTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_table_min(s : MlmetricinterpretTable) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_table_max(s : MlmetricinterpretTable) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_table_to_string(s : MlmetricinterpretTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_graphn_make(size : Int) -> MlmetricinterpretGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_graphn_len(s : MlmetricinterpretGraphN) -> Int { s.size }

pub fn ml_metric_interpret_graphn_get(s : MlmetricinterpretGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_graphn_set(s : MlmetricinterpretGraphN, i : Int, v : Double) -> MlmetricinterpretGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_graphn_sum(s : MlmetricinterpretGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_graphn_mean(s : MlmetricinterpretGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_graphn_scale(s : MlmetricinterpretGraphN, f : Double) -> MlmetricinterpretGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_graphn_add(a : MlmetricinterpretGraphN, b : MlmetricinterpretGraphN) -> MlmetricinterpretGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_graphn_copy(s : MlmetricinterpretGraphN) -> MlmetricinterpretGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_graphn_fill(s : MlmetricinterpretGraphN, v : Double) -> MlmetricinterpretGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_graphn_min(s : MlmetricinterpretGraphN) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_graphn_max(s : MlmetricinterpretGraphN) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_graphn_to_string(s : MlmetricinterpretGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_node_make(size : Int) -> MlmetricinterpretNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_node_len(s : MlmetricinterpretNode) -> Int { s.size }

pub fn ml_metric_interpret_node_get(s : MlmetricinterpretNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_node_set(s : MlmetricinterpretNode, i : Int, v : Double) -> MlmetricinterpretNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_node_sum(s : MlmetricinterpretNode) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_node_mean(s : MlmetricinterpretNode) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_node_scale(s : MlmetricinterpretNode, f : Double) -> MlmetricinterpretNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_node_add(a : MlmetricinterpretNode, b : MlmetricinterpretNode) -> MlmetricinterpretNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_node_copy(s : MlmetricinterpretNode) -> MlmetricinterpretNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_node_fill(s : MlmetricinterpretNode, v : Double) -> MlmetricinterpretNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_node_min(s : MlmetricinterpretNode) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_node_max(s : MlmetricinterpretNode) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_node_to_string(s : MlmetricinterpretNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_edge_make(size : Int) -> MlmetricinterpretEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_edge_len(s : MlmetricinterpretEdge) -> Int { s.size }

pub fn ml_metric_interpret_edge_get(s : MlmetricinterpretEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_edge_set(s : MlmetricinterpretEdge, i : Int, v : Double) -> MlmetricinterpretEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_edge_sum(s : MlmetricinterpretEdge) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_edge_mean(s : MlmetricinterpretEdge) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_edge_scale(s : MlmetricinterpretEdge, f : Double) -> MlmetricinterpretEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_edge_add(a : MlmetricinterpretEdge, b : MlmetricinterpretEdge) -> MlmetricinterpretEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_edge_copy(s : MlmetricinterpretEdge) -> MlmetricinterpretEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_edge_fill(s : MlmetricinterpretEdge, v : Double) -> MlmetricinterpretEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_edge_min(s : MlmetricinterpretEdge) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_edge_max(s : MlmetricinterpretEdge) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_edge_to_string(s : MlmetricinterpretEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_path_make(size : Int) -> MlmetricinterpretPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_path_len(s : MlmetricinterpretPath) -> Int { s.size }

pub fn ml_metric_interpret_path_get(s : MlmetricinterpretPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_path_set(s : MlmetricinterpretPath, i : Int, v : Double) -> MlmetricinterpretPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_path_sum(s : MlmetricinterpretPath) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_path_mean(s : MlmetricinterpretPath) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_path_scale(s : MlmetricinterpretPath, f : Double) -> MlmetricinterpretPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_path_add(a : MlmetricinterpretPath, b : MlmetricinterpretPath) -> MlmetricinterpretPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_path_copy(s : MlmetricinterpretPath) -> MlmetricinterpretPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_path_fill(s : MlmetricinterpretPath, v : Double) -> MlmetricinterpretPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_path_min(s : MlmetricinterpretPath) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_path_max(s : MlmetricinterpretPath) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_path_to_string(s : MlmetricinterpretPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_cluster_make(size : Int) -> MlmetricinterpretCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_cluster_len(s : MlmetricinterpretCluster) -> Int { s.size }

pub fn ml_metric_interpret_cluster_get(s : MlmetricinterpretCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_cluster_set(s : MlmetricinterpretCluster, i : Int, v : Double) -> MlmetricinterpretCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_cluster_sum(s : MlmetricinterpretCluster) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_cluster_mean(s : MlmetricinterpretCluster) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_cluster_scale(s : MlmetricinterpretCluster, f : Double) -> MlmetricinterpretCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_cluster_add(a : MlmetricinterpretCluster, b : MlmetricinterpretCluster) -> MlmetricinterpretCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_cluster_copy(s : MlmetricinterpretCluster) -> MlmetricinterpretCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_cluster_fill(s : MlmetricinterpretCluster, v : Double) -> MlmetricinterpretCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_cluster_min(s : MlmetricinterpretCluster) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_cluster_max(s : MlmetricinterpretCluster) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_cluster_to_string(s : MlmetricinterpretCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_model_make(size : Int) -> MlmetricinterpretModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_model_len(s : MlmetricinterpretModel) -> Int { s.size }

pub fn ml_metric_interpret_model_get(s : MlmetricinterpretModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_model_set(s : MlmetricinterpretModel, i : Int, v : Double) -> MlmetricinterpretModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_model_sum(s : MlmetricinterpretModel) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_model_mean(s : MlmetricinterpretModel) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_model_scale(s : MlmetricinterpretModel, f : Double) -> MlmetricinterpretModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_model_add(a : MlmetricinterpretModel, b : MlmetricinterpretModel) -> MlmetricinterpretModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_model_copy(s : MlmetricinterpretModel) -> MlmetricinterpretModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_model_fill(s : MlmetricinterpretModel, v : Double) -> MlmetricinterpretModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_model_min(s : MlmetricinterpretModel) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_model_max(s : MlmetricinterpretModel) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_model_to_string(s : MlmetricinterpretModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_layer_make(size : Int) -> MlmetricinterpretLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_layer_len(s : MlmetricinterpretLayer) -> Int { s.size }

pub fn ml_metric_interpret_layer_get(s : MlmetricinterpretLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_layer_set(s : MlmetricinterpretLayer, i : Int, v : Double) -> MlmetricinterpretLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_layer_sum(s : MlmetricinterpretLayer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_layer_mean(s : MlmetricinterpretLayer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_layer_scale(s : MlmetricinterpretLayer, f : Double) -> MlmetricinterpretLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_layer_add(a : MlmetricinterpretLayer, b : MlmetricinterpretLayer) -> MlmetricinterpretLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_layer_copy(s : MlmetricinterpretLayer) -> MlmetricinterpretLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_layer_fill(s : MlmetricinterpretLayer, v : Double) -> MlmetricinterpretLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_layer_min(s : MlmetricinterpretLayer) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_layer_max(s : MlmetricinterpretLayer) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_layer_to_string(s : MlmetricinterpretLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_buffer_make(size : Int) -> MlmetricinterpretBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_buffer_len(s : MlmetricinterpretBuffer) -> Int { s.size }

pub fn ml_metric_interpret_buffer_get(s : MlmetricinterpretBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_buffer_set(s : MlmetricinterpretBuffer, i : Int, v : Double) -> MlmetricinterpretBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_buffer_sum(s : MlmetricinterpretBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_buffer_mean(s : MlmetricinterpretBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_buffer_scale(s : MlmetricinterpretBuffer, f : Double) -> MlmetricinterpretBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_buffer_add(a : MlmetricinterpretBuffer, b : MlmetricinterpretBuffer) -> MlmetricinterpretBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_buffer_copy(s : MlmetricinterpretBuffer) -> MlmetricinterpretBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_buffer_fill(s : MlmetricinterpretBuffer, v : Double) -> MlmetricinterpretBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_buffer_min(s : MlmetricinterpretBuffer) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_buffer_max(s : MlmetricinterpretBuffer) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_buffer_to_string(s : MlmetricinterpretBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_cursor_make(size : Int) -> MlmetricinterpretCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_cursor_len(s : MlmetricinterpretCursor) -> Int { s.size }

pub fn ml_metric_interpret_cursor_get(s : MlmetricinterpretCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_cursor_set(s : MlmetricinterpretCursor, i : Int, v : Double) -> MlmetricinterpretCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_cursor_sum(s : MlmetricinterpretCursor) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_cursor_mean(s : MlmetricinterpretCursor) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_cursor_scale(s : MlmetricinterpretCursor, f : Double) -> MlmetricinterpretCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_cursor_add(a : MlmetricinterpretCursor, b : MlmetricinterpretCursor) -> MlmetricinterpretCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_cursor_copy(s : MlmetricinterpretCursor) -> MlmetricinterpretCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_cursor_fill(s : MlmetricinterpretCursor, v : Double) -> MlmetricinterpretCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_cursor_min(s : MlmetricinterpretCursor) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_cursor_max(s : MlmetricinterpretCursor) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_cursor_to_string(s : MlmetricinterpretCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_view_make(size : Int) -> MlmetricinterpretView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_view_len(s : MlmetricinterpretView) -> Int { s.size }

pub fn ml_metric_interpret_view_get(s : MlmetricinterpretView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_view_set(s : MlmetricinterpretView, i : Int, v : Double) -> MlmetricinterpretView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_view_sum(s : MlmetricinterpretView) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_view_mean(s : MlmetricinterpretView) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_view_scale(s : MlmetricinterpretView, f : Double) -> MlmetricinterpretView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_view_add(a : MlmetricinterpretView, b : MlmetricinterpretView) -> MlmetricinterpretView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_view_copy(s : MlmetricinterpretView) -> MlmetricinterpretView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_view_fill(s : MlmetricinterpretView, v : Double) -> MlmetricinterpretView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_view_min(s : MlmetricinterpretView) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_view_max(s : MlmetricinterpretView) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_view_to_string(s : MlmetricinterpretView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_range_make(size : Int) -> MlmetricinterpretRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_range_len(s : MlmetricinterpretRange) -> Int { s.size }

pub fn ml_metric_interpret_range_get(s : MlmetricinterpretRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_range_set(s : MlmetricinterpretRange, i : Int, v : Double) -> MlmetricinterpretRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_range_sum(s : MlmetricinterpretRange) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_range_mean(s : MlmetricinterpretRange) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_range_scale(s : MlmetricinterpretRange, f : Double) -> MlmetricinterpretRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_range_add(a : MlmetricinterpretRange, b : MlmetricinterpretRange) -> MlmetricinterpretRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_range_copy(s : MlmetricinterpretRange) -> MlmetricinterpretRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_range_fill(s : MlmetricinterpretRange, v : Double) -> MlmetricinterpretRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_range_min(s : MlmetricinterpretRange) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_range_max(s : MlmetricinterpretRange) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_range_to_string(s : MlmetricinterpretRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlmetricinterpretSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_interpret_slice_make(size : Int) -> MlmetricinterpretSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_metric_interpret_slice_len(s : MlmetricinterpretSlice) -> Int { s.size }

pub fn ml_metric_interpret_slice_get(s : MlmetricinterpretSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_metric_interpret_slice_set(s : MlmetricinterpretSlice, i : Int, v : Double) -> MlmetricinterpretSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_slice_sum(s : MlmetricinterpretSlice) -> Double { @_common.sum(s.data) }

pub fn ml_metric_interpret_slice_mean(s : MlmetricinterpretSlice) -> Double { @_common.mean(s.data) }

pub fn ml_metric_interpret_slice_scale(s : MlmetricinterpretSlice, f : Double) -> MlmetricinterpretSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_slice_add(a : MlmetricinterpretSlice, b : MlmetricinterpretSlice) -> MlmetricinterpretSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_metric_interpret_slice_copy(s : MlmetricinterpretSlice) -> MlmetricinterpretSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_slice_fill(s : MlmetricinterpretSlice, v : Double) -> MlmetricinterpretSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_metric_interpret_slice_min(s : MlmetricinterpretSlice) -> Double { @_common.min(s.data) }

pub fn ml_metric_interpret_slice_max(s : MlmetricinterpretSlice) -> Double { @_common.max(s.data) }

pub fn ml_metric_interpret_slice_to_string(s : MlmetricinterpretSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

