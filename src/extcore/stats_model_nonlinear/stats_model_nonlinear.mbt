///===
/// extcore/stats_model_nonlinear

pub(all) struct StatsmodelnonlinearPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_model_nonlinear_make_point(x : Double, y : Double) -> StatsmodelnonlinearPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_model_nonlinear_make_point3(x : Double, y : Double, z : Double) -> StatsmodelnonlinearPoint {
  { x, y, z, label: 0 }
}

pub fn StatsmodelnonlinearPoint::x(self : StatsmodelnonlinearPoint) -> Double { self.x }

pub fn StatsmodelnonlinearPoint::y(self : StatsmodelnonlinearPoint) -> Double { self.y }

pub fn StatsmodelnonlinearPoint::z(self : StatsmodelnonlinearPoint) -> Double { self.z }

pub fn StatsmodelnonlinearPoint::label(self : StatsmodelnonlinearPoint) -> Int { self.label }

pub fn StatsmodelnonlinearPoint::dist(self : StatsmodelnonlinearPoint, other : StatsmodelnonlinearPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsmodelnonlinearPoint::add(self : StatsmodelnonlinearPoint, other : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsmodelnonlinearPoint::sub(self : StatsmodelnonlinearPoint, other : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsmodelnonlinearPoint::scale(self : StatsmodelnonlinearPoint, s : Double) -> StatsmodelnonlinearPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsmodelnonlinearPoint::dot(self : StatsmodelnonlinearPoint, other : StatsmodelnonlinearPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsmodelnonlinearPoint::cross(self : StatsmodelnonlinearPoint, other : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsmodelnonlinearPoint::norm(self : StatsmodelnonlinearPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsmodelnonlinearPoint::normalize(self : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsmodelnonlinearPoint::negate(self : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsmodelnonlinearPoint::mid(self : StatsmodelnonlinearPoint, other : StatsmodelnonlinearPoint) -> StatsmodelnonlinearPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsmodelnonlinearPoint::lerp(self : StatsmodelnonlinearPoint, other : StatsmodelnonlinearPoint, t : Double) -> StatsmodelnonlinearPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsmodelnonlinearPoint::to_string(self : StatsmodelnonlinearPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_model_nonlinear_make_series(vals : Array[Double], name : String) -> StatsmodelnonlinearSeries {
  { vals, name, meta: 0 }
}

pub fn StatsmodelnonlinearSeries::len(self : StatsmodelnonlinearSeries) -> Int { self.vals.length() }

pub fn StatsmodelnonlinearSeries::sum(self : StatsmodelnonlinearSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsmodelnonlinearSeries::mean(self : StatsmodelnonlinearSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsmodelnonlinearSeries::min(self : StatsmodelnonlinearSeries) -> Double { @_common.min(self.vals) }

pub fn StatsmodelnonlinearSeries::max(self : StatsmodelnonlinearSeries) -> Double { @_common.max(self.vals) }

pub fn StatsmodelnonlinearSeries::range(self : StatsmodelnonlinearSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsmodelnonlinearSeries::variance(self : StatsmodelnonlinearSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsmodelnonlinearSeries::std(self : StatsmodelnonlinearSeries) -> Double { @_common.std(self.vals) }

pub fn StatsmodelnonlinearSeries::median(self : StatsmodelnonlinearSeries) -> Double { @_common.median(self.vals) }

pub fn StatsmodelnonlinearSeries::scale(self : StatsmodelnonlinearSeries, f : Double) -> StatsmodelnonlinearSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsmodelnonlinearSeries::add(self : StatsmodelnonlinearSeries, other : StatsmodelnonlinearSeries) -> StatsmodelnonlinearSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsmodelnonlinearSeries::sub(self : StatsmodelnonlinearSeries, other : StatsmodelnonlinearSeries) -> StatsmodelnonlinearSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsmodelnonlinearSeries::normalize(self : StatsmodelnonlinearSeries) -> StatsmodelnonlinearSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsmodelnonlinearSeries::cumsum(self : StatsmodelnonlinearSeries) -> StatsmodelnonlinearSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsmodelnonlinearSeries::to_string(self : StatsmodelnonlinearSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsmodelnonlinearMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_model_nonlinear_make_matrix(rows : Int, cols : Int, val : Double) -> StatsmodelnonlinearMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_model_nonlinear_matrix_identity(n : Int) -> StatsmodelnonlinearMatrix {
  let m = stats_model_nonlinear_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsmodelnonlinearMatrix::get(self : StatsmodelnonlinearMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsmodelnonlinearMatrix::transpose(self : StatsmodelnonlinearMatrix) -> StatsmodelnonlinearMatrix {
  let result = stats_model_nonlinear_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsmodelnonlinearMatrix::add(self : StatsmodelnonlinearMatrix, other : StatsmodelnonlinearMatrix) -> StatsmodelnonlinearMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_model_nonlinear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsmodelnonlinearMatrix::scale(self : StatsmodelnonlinearMatrix, s : Double) -> StatsmodelnonlinearMatrix {
  let result = stats_model_nonlinear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsmodelnonlinearMatrix::multiply(self : StatsmodelnonlinearMatrix, other : StatsmodelnonlinearMatrix) -> StatsmodelnonlinearMatrix {
  if self.cols != other.rows { return stats_model_nonlinear_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_model_nonlinear_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsmodelnonlinearMatrix::trace(self : StatsmodelnonlinearMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsmodelnonlinearMatrix::det(self : StatsmodelnonlinearMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsmodelnonlinearMatrix::norm(self : StatsmodelnonlinearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsmodelnonlinearMatrix::to_string(self : StatsmodelnonlinearMatrix) -> String {
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

pub(all) struct StatsmodelnonlinearVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_model_nonlinear_make_vector(comps : Array[Double]) -> StatsmodelnonlinearVector {
  { comps, dim: comps.length() }
}

pub fn stats_model_nonlinear_vector_zero(dim : Int) -> StatsmodelnonlinearVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsmodelnonlinearVector::add(self : StatsmodelnonlinearVector, other : StatsmodelnonlinearVector) -> StatsmodelnonlinearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsmodelnonlinearVector::sub(self : StatsmodelnonlinearVector, other : StatsmodelnonlinearVector) -> StatsmodelnonlinearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsmodelnonlinearVector::scale(self : StatsmodelnonlinearVector, s : Double) -> StatsmodelnonlinearVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsmodelnonlinearVector::dot(self : StatsmodelnonlinearVector, other : StatsmodelnonlinearVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsmodelnonlinearVector::norm(self : StatsmodelnonlinearVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsmodelnonlinearVector::normalize(self : StatsmodelnonlinearVector) -> StatsmodelnonlinearVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsmodelnonlinearVector::dist(self : StatsmodelnonlinearVector, other : StatsmodelnonlinearVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsmodelnonlinearVector::to_string(self : StatsmodelnonlinearVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_model_nonlinear_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_model_nonlinear_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_model_nonlinear_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_model_nonlinear_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_model_nonlinear_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_model_nonlinear_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_model_nonlinear_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_model_nonlinear_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_model_nonlinear_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_model_nonlinear_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_model_nonlinear_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_model_nonlinear_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_model_nonlinear_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_model_nonlinear_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_model_nonlinear_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_model_nonlinear_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_model_nonlinear_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_model_nonlinear_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_model_nonlinear_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_model_nonlinear_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_model_nonlinear_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_model_nonlinear_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_model_nonlinear_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_model_nonlinear_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_model_nonlinear_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_model_nonlinear_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_model_nonlinear_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_model_nonlinear_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_model_nonlinear_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsmodelnonlinearFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_frame_make(size : Int) -> StatsmodelnonlinearFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_frame_len(s : StatsmodelnonlinearFrame) -> Int { s.size }

pub fn stats_model_nonlinear_frame_get(s : StatsmodelnonlinearFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_frame_set(s : StatsmodelnonlinearFrame, i : Int, v : Double) -> StatsmodelnonlinearFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_frame_sum(s : StatsmodelnonlinearFrame) -> Double { @_common.sum(s.data) }

pub fn stats_model_nonlinear_frame_mean(s : StatsmodelnonlinearFrame) -> Double { @_common.mean(s.data) }

pub fn stats_model_nonlinear_frame_scale(s : StatsmodelnonlinearFrame, f : Double) -> StatsmodelnonlinearFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_frame_add(a : StatsmodelnonlinearFrame, b : StatsmodelnonlinearFrame) -> StatsmodelnonlinearFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_nonlinear_frame_copy(s : StatsmodelnonlinearFrame) -> StatsmodelnonlinearFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_frame_fill(s : StatsmodelnonlinearFrame, v : Double) -> StatsmodelnonlinearFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_frame_min(s : StatsmodelnonlinearFrame) -> Double { @_common.min(s.data) }

pub fn stats_model_nonlinear_frame_max(s : StatsmodelnonlinearFrame) -> Double { @_common.max(s.data) }

pub fn stats_model_nonlinear_frame_to_string(s : StatsmodelnonlinearFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_table_make(size : Int) -> StatsmodelnonlinearTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_table_len(s : StatsmodelnonlinearTable) -> Int { s.size }

pub fn stats_model_nonlinear_table_get(s : StatsmodelnonlinearTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_table_set(s : StatsmodelnonlinearTable, i : Int, v : Double) -> StatsmodelnonlinearTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_table_sum(s : StatsmodelnonlinearTable) -> Double { @_common.sum(s.data) }

pub fn stats_model_nonlinear_table_mean(s : StatsmodelnonlinearTable) -> Double { @_common.mean(s.data) }

pub fn stats_model_nonlinear_table_scale(s : StatsmodelnonlinearTable, f : Double) -> StatsmodelnonlinearTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_table_add(a : StatsmodelnonlinearTable, b : StatsmodelnonlinearTable) -> StatsmodelnonlinearTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_nonlinear_table_copy(s : StatsmodelnonlinearTable) -> StatsmodelnonlinearTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_table_fill(s : StatsmodelnonlinearTable, v : Double) -> StatsmodelnonlinearTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_table_min(s : StatsmodelnonlinearTable) -> Double { @_common.min(s.data) }

pub fn stats_model_nonlinear_table_max(s : StatsmodelnonlinearTable) -> Double { @_common.max(s.data) }

pub fn stats_model_nonlinear_table_to_string(s : StatsmodelnonlinearTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_graphn_make(size : Int) -> StatsmodelnonlinearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_graphn_len(s : StatsmodelnonlinearGraphN) -> Int { s.size }

pub fn stats_model_nonlinear_graphn_get(s : StatsmodelnonlinearGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_graphn_set(s : StatsmodelnonlinearGraphN, i : Int, v : Double) -> StatsmodelnonlinearGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_graphn_sum(s : StatsmodelnonlinearGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_model_nonlinear_graphn_mean(s : StatsmodelnonlinearGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_model_nonlinear_graphn_scale(s : StatsmodelnonlinearGraphN, f : Double) -> StatsmodelnonlinearGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_graphn_add(a : StatsmodelnonlinearGraphN, b : StatsmodelnonlinearGraphN) -> StatsmodelnonlinearGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_nonlinear_graphn_copy(s : StatsmodelnonlinearGraphN) -> StatsmodelnonlinearGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_graphn_fill(s : StatsmodelnonlinearGraphN, v : Double) -> StatsmodelnonlinearGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_graphn_min(s : StatsmodelnonlinearGraphN) -> Double { @_common.min(s.data) }

pub fn stats_model_nonlinear_graphn_max(s : StatsmodelnonlinearGraphN) -> Double { @_common.max(s.data) }

pub fn stats_model_nonlinear_graphn_to_string(s : StatsmodelnonlinearGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_node_make(size : Int) -> StatsmodelnonlinearNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_node_len(s : StatsmodelnonlinearNode) -> Int { s.size }

pub fn stats_model_nonlinear_node_get(s : StatsmodelnonlinearNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_node_set(s : StatsmodelnonlinearNode, i : Int, v : Double) -> StatsmodelnonlinearNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_node_sum(s : StatsmodelnonlinearNode) -> Double { @_common.sum(s.data) }

pub fn stats_model_nonlinear_node_mean(s : StatsmodelnonlinearNode) -> Double { @_common.mean(s.data) }

pub fn stats_model_nonlinear_node_scale(s : StatsmodelnonlinearNode, f : Double) -> StatsmodelnonlinearNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_node_add(a : StatsmodelnonlinearNode, b : StatsmodelnonlinearNode) -> StatsmodelnonlinearNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_nonlinear_node_copy(s : StatsmodelnonlinearNode) -> StatsmodelnonlinearNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_node_fill(s : StatsmodelnonlinearNode, v : Double) -> StatsmodelnonlinearNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_node_min(s : StatsmodelnonlinearNode) -> Double { @_common.min(s.data) }

pub fn stats_model_nonlinear_node_max(s : StatsmodelnonlinearNode) -> Double { @_common.max(s.data) }

pub fn stats_model_nonlinear_node_to_string(s : StatsmodelnonlinearNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_edge_make(size : Int) -> StatsmodelnonlinearEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_edge_len(s : StatsmodelnonlinearEdge) -> Int { s.size }

pub fn stats_model_nonlinear_edge_get(s : StatsmodelnonlinearEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_edge_set(s : StatsmodelnonlinearEdge, i : Int, v : Double) -> StatsmodelnonlinearEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_edge_sum(s : StatsmodelnonlinearEdge) -> Double { @_common.sum(s.data) }

pub fn stats_model_nonlinear_edge_mean(s : StatsmodelnonlinearEdge) -> Double { @_common.mean(s.data) }

pub fn stats_model_nonlinear_edge_scale(s : StatsmodelnonlinearEdge, f : Double) -> StatsmodelnonlinearEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_edge_add(a : StatsmodelnonlinearEdge, b : StatsmodelnonlinearEdge) -> StatsmodelnonlinearEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_nonlinear_edge_copy(s : StatsmodelnonlinearEdge) -> StatsmodelnonlinearEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_edge_fill(s : StatsmodelnonlinearEdge, v : Double) -> StatsmodelnonlinearEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_edge_min(s : StatsmodelnonlinearEdge) -> Double { @_common.min(s.data) }

pub fn stats_model_nonlinear_edge_max(s : StatsmodelnonlinearEdge) -> Double { @_common.max(s.data) }

pub fn stats_model_nonlinear_edge_to_string(s : StatsmodelnonlinearEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_path_make(size : Int) -> StatsmodelnonlinearPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_path_len(s : StatsmodelnonlinearPath) -> Int { s.size }

pub fn stats_model_nonlinear_path_get(s : StatsmodelnonlinearPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_path_set(s : StatsmodelnonlinearPath, i : Int, v : Double) -> StatsmodelnonlinearPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_path_sum(s : StatsmodelnonlinearPath) -> Double { @_common.sum(s.data) }

pub fn stats_model_nonlinear_path_mean(s : StatsmodelnonlinearPath) -> Double { @_common.mean(s.data) }

pub fn stats_model_nonlinear_path_scale(s : StatsmodelnonlinearPath, f : Double) -> StatsmodelnonlinearPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_path_add(a : StatsmodelnonlinearPath, b : StatsmodelnonlinearPath) -> StatsmodelnonlinearPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_nonlinear_path_copy(s : StatsmodelnonlinearPath) -> StatsmodelnonlinearPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_path_fill(s : StatsmodelnonlinearPath, v : Double) -> StatsmodelnonlinearPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_path_min(s : StatsmodelnonlinearPath) -> Double { @_common.min(s.data) }

pub fn stats_model_nonlinear_path_max(s : StatsmodelnonlinearPath) -> Double { @_common.max(s.data) }

pub fn stats_model_nonlinear_path_to_string(s : StatsmodelnonlinearPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_cluster_make(size : Int) -> StatsmodelnonlinearCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_cluster_len(s : StatsmodelnonlinearCluster) -> Int { s.size }

pub fn stats_model_nonlinear_cluster_get(s : StatsmodelnonlinearCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_cluster_set(s : StatsmodelnonlinearCluster, i : Int, v : Double) -> StatsmodelnonlinearCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_cluster_sum(s : StatsmodelnonlinearCluster) -> Double { @_common.sum(s.data) }

pub fn stats_model_nonlinear_cluster_mean(s : StatsmodelnonlinearCluster) -> Double { @_common.mean(s.data) }

pub fn stats_model_nonlinear_cluster_scale(s : StatsmodelnonlinearCluster, f : Double) -> StatsmodelnonlinearCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_cluster_add(a : StatsmodelnonlinearCluster, b : StatsmodelnonlinearCluster) -> StatsmodelnonlinearCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_nonlinear_cluster_copy(s : StatsmodelnonlinearCluster) -> StatsmodelnonlinearCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_cluster_fill(s : StatsmodelnonlinearCluster, v : Double) -> StatsmodelnonlinearCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_cluster_min(s : StatsmodelnonlinearCluster) -> Double { @_common.min(s.data) }

pub fn stats_model_nonlinear_cluster_max(s : StatsmodelnonlinearCluster) -> Double { @_common.max(s.data) }

pub fn stats_model_nonlinear_cluster_to_string(s : StatsmodelnonlinearCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_model_make(size : Int) -> StatsmodelnonlinearModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_model_len(s : StatsmodelnonlinearModel) -> Int { s.size }

pub fn stats_model_nonlinear_model_get(s : StatsmodelnonlinearModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_model_set(s : StatsmodelnonlinearModel, i : Int, v : Double) -> StatsmodelnonlinearModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_model_sum(s : StatsmodelnonlinearModel) -> Double { @_common.sum(s.data) }

pub fn stats_model_nonlinear_model_mean(s : StatsmodelnonlinearModel) -> Double { @_common.mean(s.data) }

pub fn stats_model_nonlinear_model_scale(s : StatsmodelnonlinearModel, f : Double) -> StatsmodelnonlinearModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_model_add(a : StatsmodelnonlinearModel, b : StatsmodelnonlinearModel) -> StatsmodelnonlinearModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_nonlinear_model_copy(s : StatsmodelnonlinearModel) -> StatsmodelnonlinearModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_model_fill(s : StatsmodelnonlinearModel, v : Double) -> StatsmodelnonlinearModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_model_min(s : StatsmodelnonlinearModel) -> Double { @_common.min(s.data) }

pub fn stats_model_nonlinear_model_max(s : StatsmodelnonlinearModel) -> Double { @_common.max(s.data) }

pub fn stats_model_nonlinear_model_to_string(s : StatsmodelnonlinearModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_layer_make(size : Int) -> StatsmodelnonlinearLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_layer_len(s : StatsmodelnonlinearLayer) -> Int { s.size }

pub fn stats_model_nonlinear_layer_get(s : StatsmodelnonlinearLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_layer_set(s : StatsmodelnonlinearLayer, i : Int, v : Double) -> StatsmodelnonlinearLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_layer_sum(s : StatsmodelnonlinearLayer) -> Double { @_common.sum(s.data) }

pub fn stats_model_nonlinear_layer_mean(s : StatsmodelnonlinearLayer) -> Double { @_common.mean(s.data) }

pub fn stats_model_nonlinear_layer_scale(s : StatsmodelnonlinearLayer, f : Double) -> StatsmodelnonlinearLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_layer_add(a : StatsmodelnonlinearLayer, b : StatsmodelnonlinearLayer) -> StatsmodelnonlinearLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_nonlinear_layer_copy(s : StatsmodelnonlinearLayer) -> StatsmodelnonlinearLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_layer_fill(s : StatsmodelnonlinearLayer, v : Double) -> StatsmodelnonlinearLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_layer_min(s : StatsmodelnonlinearLayer) -> Double { @_common.min(s.data) }

pub fn stats_model_nonlinear_layer_max(s : StatsmodelnonlinearLayer) -> Double { @_common.max(s.data) }

pub fn stats_model_nonlinear_layer_to_string(s : StatsmodelnonlinearLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_buffer_make(size : Int) -> StatsmodelnonlinearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_buffer_len(s : StatsmodelnonlinearBuffer) -> Int { s.size }

pub fn stats_model_nonlinear_buffer_get(s : StatsmodelnonlinearBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_buffer_set(s : StatsmodelnonlinearBuffer, i : Int, v : Double) -> StatsmodelnonlinearBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_buffer_sum(s : StatsmodelnonlinearBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_model_nonlinear_buffer_mean(s : StatsmodelnonlinearBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_model_nonlinear_buffer_scale(s : StatsmodelnonlinearBuffer, f : Double) -> StatsmodelnonlinearBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_buffer_add(a : StatsmodelnonlinearBuffer, b : StatsmodelnonlinearBuffer) -> StatsmodelnonlinearBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_nonlinear_buffer_copy(s : StatsmodelnonlinearBuffer) -> StatsmodelnonlinearBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_buffer_fill(s : StatsmodelnonlinearBuffer, v : Double) -> StatsmodelnonlinearBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_buffer_min(s : StatsmodelnonlinearBuffer) -> Double { @_common.min(s.data) }

pub fn stats_model_nonlinear_buffer_max(s : StatsmodelnonlinearBuffer) -> Double { @_common.max(s.data) }

pub fn stats_model_nonlinear_buffer_to_string(s : StatsmodelnonlinearBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_cursor_make(size : Int) -> StatsmodelnonlinearCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_cursor_len(s : StatsmodelnonlinearCursor) -> Int { s.size }

pub fn stats_model_nonlinear_cursor_get(s : StatsmodelnonlinearCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_cursor_set(s : StatsmodelnonlinearCursor, i : Int, v : Double) -> StatsmodelnonlinearCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_cursor_sum(s : StatsmodelnonlinearCursor) -> Double { @_common.sum(s.data) }

pub fn stats_model_nonlinear_cursor_mean(s : StatsmodelnonlinearCursor) -> Double { @_common.mean(s.data) }

pub fn stats_model_nonlinear_cursor_scale(s : StatsmodelnonlinearCursor, f : Double) -> StatsmodelnonlinearCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_cursor_add(a : StatsmodelnonlinearCursor, b : StatsmodelnonlinearCursor) -> StatsmodelnonlinearCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_nonlinear_cursor_copy(s : StatsmodelnonlinearCursor) -> StatsmodelnonlinearCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_cursor_fill(s : StatsmodelnonlinearCursor, v : Double) -> StatsmodelnonlinearCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_cursor_min(s : StatsmodelnonlinearCursor) -> Double { @_common.min(s.data) }

pub fn stats_model_nonlinear_cursor_max(s : StatsmodelnonlinearCursor) -> Double { @_common.max(s.data) }

pub fn stats_model_nonlinear_cursor_to_string(s : StatsmodelnonlinearCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_view_make(size : Int) -> StatsmodelnonlinearView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_view_len(s : StatsmodelnonlinearView) -> Int { s.size }

pub fn stats_model_nonlinear_view_get(s : StatsmodelnonlinearView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_view_set(s : StatsmodelnonlinearView, i : Int, v : Double) -> StatsmodelnonlinearView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_view_sum(s : StatsmodelnonlinearView) -> Double { @_common.sum(s.data) }

pub fn stats_model_nonlinear_view_mean(s : StatsmodelnonlinearView) -> Double { @_common.mean(s.data) }

pub fn stats_model_nonlinear_view_scale(s : StatsmodelnonlinearView, f : Double) -> StatsmodelnonlinearView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_view_add(a : StatsmodelnonlinearView, b : StatsmodelnonlinearView) -> StatsmodelnonlinearView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_nonlinear_view_copy(s : StatsmodelnonlinearView) -> StatsmodelnonlinearView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_view_fill(s : StatsmodelnonlinearView, v : Double) -> StatsmodelnonlinearView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_view_min(s : StatsmodelnonlinearView) -> Double { @_common.min(s.data) }

pub fn stats_model_nonlinear_view_max(s : StatsmodelnonlinearView) -> Double { @_common.max(s.data) }

pub fn stats_model_nonlinear_view_to_string(s : StatsmodelnonlinearView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_range_make(size : Int) -> StatsmodelnonlinearRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_range_len(s : StatsmodelnonlinearRange) -> Int { s.size }

pub fn stats_model_nonlinear_range_get(s : StatsmodelnonlinearRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_range_set(s : StatsmodelnonlinearRange, i : Int, v : Double) -> StatsmodelnonlinearRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_range_sum(s : StatsmodelnonlinearRange) -> Double { @_common.sum(s.data) }

pub fn stats_model_nonlinear_range_mean(s : StatsmodelnonlinearRange) -> Double { @_common.mean(s.data) }

pub fn stats_model_nonlinear_range_scale(s : StatsmodelnonlinearRange, f : Double) -> StatsmodelnonlinearRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_range_add(a : StatsmodelnonlinearRange, b : StatsmodelnonlinearRange) -> StatsmodelnonlinearRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_nonlinear_range_copy(s : StatsmodelnonlinearRange) -> StatsmodelnonlinearRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_range_fill(s : StatsmodelnonlinearRange, v : Double) -> StatsmodelnonlinearRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_range_min(s : StatsmodelnonlinearRange) -> Double { @_common.min(s.data) }

pub fn stats_model_nonlinear_range_max(s : StatsmodelnonlinearRange) -> Double { @_common.max(s.data) }

pub fn stats_model_nonlinear_range_to_string(s : StatsmodelnonlinearRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsmodelnonlinearSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_model_nonlinear_slice_make(size : Int) -> StatsmodelnonlinearSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_model_nonlinear_slice_len(s : StatsmodelnonlinearSlice) -> Int { s.size }

pub fn stats_model_nonlinear_slice_get(s : StatsmodelnonlinearSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_model_nonlinear_slice_set(s : StatsmodelnonlinearSlice, i : Int, v : Double) -> StatsmodelnonlinearSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_slice_sum(s : StatsmodelnonlinearSlice) -> Double { @_common.sum(s.data) }

pub fn stats_model_nonlinear_slice_mean(s : StatsmodelnonlinearSlice) -> Double { @_common.mean(s.data) }

pub fn stats_model_nonlinear_slice_scale(s : StatsmodelnonlinearSlice, f : Double) -> StatsmodelnonlinearSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_slice_add(a : StatsmodelnonlinearSlice, b : StatsmodelnonlinearSlice) -> StatsmodelnonlinearSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_model_nonlinear_slice_copy(s : StatsmodelnonlinearSlice) -> StatsmodelnonlinearSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_slice_fill(s : StatsmodelnonlinearSlice, v : Double) -> StatsmodelnonlinearSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_model_nonlinear_slice_min(s : StatsmodelnonlinearSlice) -> Double { @_common.min(s.data) }

pub fn stats_model_nonlinear_slice_max(s : StatsmodelnonlinearSlice) -> Double { @_common.max(s.data) }

pub fn stats_model_nonlinear_slice_to_string(s : StatsmodelnonlinearSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

