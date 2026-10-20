///===
/// extcore/stats_infer_hypothesis

pub(all) struct StatsinferhypothesisPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_infer_hypothesis_make_point(x : Double, y : Double) -> StatsinferhypothesisPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_infer_hypothesis_make_point3(x : Double, y : Double, z : Double) -> StatsinferhypothesisPoint {
  { x, y, z, label: 0 }
}

pub fn StatsinferhypothesisPoint::x(self : StatsinferhypothesisPoint) -> Double { self.x }

pub fn StatsinferhypothesisPoint::y(self : StatsinferhypothesisPoint) -> Double { self.y }

pub fn StatsinferhypothesisPoint::z(self : StatsinferhypothesisPoint) -> Double { self.z }

pub fn StatsinferhypothesisPoint::label(self : StatsinferhypothesisPoint) -> Int { self.label }

pub fn StatsinferhypothesisPoint::dist(self : StatsinferhypothesisPoint, other : StatsinferhypothesisPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatsinferhypothesisPoint::add(self : StatsinferhypothesisPoint, other : StatsinferhypothesisPoint) -> StatsinferhypothesisPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatsinferhypothesisPoint::sub(self : StatsinferhypothesisPoint, other : StatsinferhypothesisPoint) -> StatsinferhypothesisPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatsinferhypothesisPoint::scale(self : StatsinferhypothesisPoint, s : Double) -> StatsinferhypothesisPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatsinferhypothesisPoint::dot(self : StatsinferhypothesisPoint, other : StatsinferhypothesisPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatsinferhypothesisPoint::cross(self : StatsinferhypothesisPoint, other : StatsinferhypothesisPoint) -> StatsinferhypothesisPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatsinferhypothesisPoint::norm(self : StatsinferhypothesisPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatsinferhypothesisPoint::normalize(self : StatsinferhypothesisPoint) -> StatsinferhypothesisPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinferhypothesisPoint::negate(self : StatsinferhypothesisPoint) -> StatsinferhypothesisPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatsinferhypothesisPoint::mid(self : StatsinferhypothesisPoint, other : StatsinferhypothesisPoint) -> StatsinferhypothesisPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatsinferhypothesisPoint::lerp(self : StatsinferhypothesisPoint, other : StatsinferhypothesisPoint, t : Double) -> StatsinferhypothesisPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatsinferhypothesisPoint::to_string(self : StatsinferhypothesisPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatsinferhypothesisSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_infer_hypothesis_make_series(vals : Array[Double], name : String) -> StatsinferhypothesisSeries {
  { vals, name, meta: 0 }
}

pub fn StatsinferhypothesisSeries::len(self : StatsinferhypothesisSeries) -> Int { self.vals.length() }

pub fn StatsinferhypothesisSeries::sum(self : StatsinferhypothesisSeries) -> Double { @_common.sum(self.vals) }

pub fn StatsinferhypothesisSeries::mean(self : StatsinferhypothesisSeries) -> Double { @_common.mean(self.vals) }

pub fn StatsinferhypothesisSeries::min(self : StatsinferhypothesisSeries) -> Double { @_common.min(self.vals) }

pub fn StatsinferhypothesisSeries::max(self : StatsinferhypothesisSeries) -> Double { @_common.max(self.vals) }

pub fn StatsinferhypothesisSeries::range(self : StatsinferhypothesisSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatsinferhypothesisSeries::variance(self : StatsinferhypothesisSeries) -> Double { @_common.variance(self.vals) }

pub fn StatsinferhypothesisSeries::std(self : StatsinferhypothesisSeries) -> Double { @_common.std(self.vals) }

pub fn StatsinferhypothesisSeries::median(self : StatsinferhypothesisSeries) -> Double { @_common.median(self.vals) }

pub fn StatsinferhypothesisSeries::scale(self : StatsinferhypothesisSeries, f : Double) -> StatsinferhypothesisSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatsinferhypothesisSeries::add(self : StatsinferhypothesisSeries, other : StatsinferhypothesisSeries) -> StatsinferhypothesisSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatsinferhypothesisSeries::sub(self : StatsinferhypothesisSeries, other : StatsinferhypothesisSeries) -> StatsinferhypothesisSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatsinferhypothesisSeries::normalize(self : StatsinferhypothesisSeries) -> StatsinferhypothesisSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatsinferhypothesisSeries::cumsum(self : StatsinferhypothesisSeries) -> StatsinferhypothesisSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatsinferhypothesisSeries::to_string(self : StatsinferhypothesisSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatsinferhypothesisMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_infer_hypothesis_make_matrix(rows : Int, cols : Int, val : Double) -> StatsinferhypothesisMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_infer_hypothesis_matrix_identity(n : Int) -> StatsinferhypothesisMatrix {
  let m = stats_infer_hypothesis_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatsinferhypothesisMatrix::get(self : StatsinferhypothesisMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatsinferhypothesisMatrix::transpose(self : StatsinferhypothesisMatrix) -> StatsinferhypothesisMatrix {
  let result = stats_infer_hypothesis_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatsinferhypothesisMatrix::add(self : StatsinferhypothesisMatrix, other : StatsinferhypothesisMatrix) -> StatsinferhypothesisMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_infer_hypothesis_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatsinferhypothesisMatrix::scale(self : StatsinferhypothesisMatrix, s : Double) -> StatsinferhypothesisMatrix {
  let result = stats_infer_hypothesis_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatsinferhypothesisMatrix::multiply(self : StatsinferhypothesisMatrix, other : StatsinferhypothesisMatrix) -> StatsinferhypothesisMatrix {
  if self.cols != other.rows { return stats_infer_hypothesis_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_infer_hypothesis_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatsinferhypothesisMatrix::trace(self : StatsinferhypothesisMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatsinferhypothesisMatrix::det(self : StatsinferhypothesisMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatsinferhypothesisMatrix::norm(self : StatsinferhypothesisMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatsinferhypothesisMatrix::to_string(self : StatsinferhypothesisMatrix) -> String {
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

pub(all) struct StatsinferhypothesisVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_infer_hypothesis_make_vector(comps : Array[Double]) -> StatsinferhypothesisVector {
  { comps, dim: comps.length() }
}

pub fn stats_infer_hypothesis_vector_zero(dim : Int) -> StatsinferhypothesisVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatsinferhypothesisVector::add(self : StatsinferhypothesisVector, other : StatsinferhypothesisVector) -> StatsinferhypothesisVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinferhypothesisVector::sub(self : StatsinferhypothesisVector, other : StatsinferhypothesisVector) -> StatsinferhypothesisVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatsinferhypothesisVector::scale(self : StatsinferhypothesisVector, s : Double) -> StatsinferhypothesisVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatsinferhypothesisVector::dot(self : StatsinferhypothesisVector, other : StatsinferhypothesisVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatsinferhypothesisVector::norm(self : StatsinferhypothesisVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatsinferhypothesisVector::normalize(self : StatsinferhypothesisVector) -> StatsinferhypothesisVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatsinferhypothesisVector::dist(self : StatsinferhypothesisVector, other : StatsinferhypothesisVector) -> Double {
  self.sub(other).norm()
}

pub fn StatsinferhypothesisVector::to_string(self : StatsinferhypothesisVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_infer_hypothesis_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_infer_hypothesis_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_infer_hypothesis_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_infer_hypothesis_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_infer_hypothesis_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_infer_hypothesis_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_infer_hypothesis_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_infer_hypothesis_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_infer_hypothesis_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_infer_hypothesis_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_infer_hypothesis_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_infer_hypothesis_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_infer_hypothesis_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_infer_hypothesis_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_infer_hypothesis_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_infer_hypothesis_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_infer_hypothesis_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_infer_hypothesis_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_infer_hypothesis_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_infer_hypothesis_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_infer_hypothesis_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_infer_hypothesis_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_infer_hypothesis_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_infer_hypothesis_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_infer_hypothesis_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_infer_hypothesis_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_infer_hypothesis_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_infer_hypothesis_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_infer_hypothesis_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatsinferhypothesisFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_frame_make(size : Int) -> StatsinferhypothesisFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_frame_len(s : StatsinferhypothesisFrame) -> Int { s.size }

pub fn stats_infer_hypothesis_frame_get(s : StatsinferhypothesisFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_frame_set(s : StatsinferhypothesisFrame, i : Int, v : Double) -> StatsinferhypothesisFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_frame_sum(s : StatsinferhypothesisFrame) -> Double { @_common.sum(s.data) }

pub fn stats_infer_hypothesis_frame_mean(s : StatsinferhypothesisFrame) -> Double { @_common.mean(s.data) }

pub fn stats_infer_hypothesis_frame_scale(s : StatsinferhypothesisFrame, f : Double) -> StatsinferhypothesisFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_frame_add(a : StatsinferhypothesisFrame, b : StatsinferhypothesisFrame) -> StatsinferhypothesisFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_hypothesis_frame_copy(s : StatsinferhypothesisFrame) -> StatsinferhypothesisFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_frame_fill(s : StatsinferhypothesisFrame, v : Double) -> StatsinferhypothesisFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_frame_min(s : StatsinferhypothesisFrame) -> Double { @_common.min(s.data) }

pub fn stats_infer_hypothesis_frame_max(s : StatsinferhypothesisFrame) -> Double { @_common.max(s.data) }

pub fn stats_infer_hypothesis_frame_to_string(s : StatsinferhypothesisFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_table_make(size : Int) -> StatsinferhypothesisTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_table_len(s : StatsinferhypothesisTable) -> Int { s.size }

pub fn stats_infer_hypothesis_table_get(s : StatsinferhypothesisTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_table_set(s : StatsinferhypothesisTable, i : Int, v : Double) -> StatsinferhypothesisTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_table_sum(s : StatsinferhypothesisTable) -> Double { @_common.sum(s.data) }

pub fn stats_infer_hypothesis_table_mean(s : StatsinferhypothesisTable) -> Double { @_common.mean(s.data) }

pub fn stats_infer_hypothesis_table_scale(s : StatsinferhypothesisTable, f : Double) -> StatsinferhypothesisTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_table_add(a : StatsinferhypothesisTable, b : StatsinferhypothesisTable) -> StatsinferhypothesisTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_hypothesis_table_copy(s : StatsinferhypothesisTable) -> StatsinferhypothesisTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_table_fill(s : StatsinferhypothesisTable, v : Double) -> StatsinferhypothesisTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_table_min(s : StatsinferhypothesisTable) -> Double { @_common.min(s.data) }

pub fn stats_infer_hypothesis_table_max(s : StatsinferhypothesisTable) -> Double { @_common.max(s.data) }

pub fn stats_infer_hypothesis_table_to_string(s : StatsinferhypothesisTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_graphn_make(size : Int) -> StatsinferhypothesisGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_graphn_len(s : StatsinferhypothesisGraphN) -> Int { s.size }

pub fn stats_infer_hypothesis_graphn_get(s : StatsinferhypothesisGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_graphn_set(s : StatsinferhypothesisGraphN, i : Int, v : Double) -> StatsinferhypothesisGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_graphn_sum(s : StatsinferhypothesisGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_infer_hypothesis_graphn_mean(s : StatsinferhypothesisGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_infer_hypothesis_graphn_scale(s : StatsinferhypothesisGraphN, f : Double) -> StatsinferhypothesisGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_graphn_add(a : StatsinferhypothesisGraphN, b : StatsinferhypothesisGraphN) -> StatsinferhypothesisGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_hypothesis_graphn_copy(s : StatsinferhypothesisGraphN) -> StatsinferhypothesisGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_graphn_fill(s : StatsinferhypothesisGraphN, v : Double) -> StatsinferhypothesisGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_graphn_min(s : StatsinferhypothesisGraphN) -> Double { @_common.min(s.data) }

pub fn stats_infer_hypothesis_graphn_max(s : StatsinferhypothesisGraphN) -> Double { @_common.max(s.data) }

pub fn stats_infer_hypothesis_graphn_to_string(s : StatsinferhypothesisGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_node_make(size : Int) -> StatsinferhypothesisNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_node_len(s : StatsinferhypothesisNode) -> Int { s.size }

pub fn stats_infer_hypothesis_node_get(s : StatsinferhypothesisNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_node_set(s : StatsinferhypothesisNode, i : Int, v : Double) -> StatsinferhypothesisNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_node_sum(s : StatsinferhypothesisNode) -> Double { @_common.sum(s.data) }

pub fn stats_infer_hypothesis_node_mean(s : StatsinferhypothesisNode) -> Double { @_common.mean(s.data) }

pub fn stats_infer_hypothesis_node_scale(s : StatsinferhypothesisNode, f : Double) -> StatsinferhypothesisNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_node_add(a : StatsinferhypothesisNode, b : StatsinferhypothesisNode) -> StatsinferhypothesisNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_hypothesis_node_copy(s : StatsinferhypothesisNode) -> StatsinferhypothesisNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_node_fill(s : StatsinferhypothesisNode, v : Double) -> StatsinferhypothesisNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_node_min(s : StatsinferhypothesisNode) -> Double { @_common.min(s.data) }

pub fn stats_infer_hypothesis_node_max(s : StatsinferhypothesisNode) -> Double { @_common.max(s.data) }

pub fn stats_infer_hypothesis_node_to_string(s : StatsinferhypothesisNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_edge_make(size : Int) -> StatsinferhypothesisEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_edge_len(s : StatsinferhypothesisEdge) -> Int { s.size }

pub fn stats_infer_hypothesis_edge_get(s : StatsinferhypothesisEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_edge_set(s : StatsinferhypothesisEdge, i : Int, v : Double) -> StatsinferhypothesisEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_edge_sum(s : StatsinferhypothesisEdge) -> Double { @_common.sum(s.data) }

pub fn stats_infer_hypothesis_edge_mean(s : StatsinferhypothesisEdge) -> Double { @_common.mean(s.data) }

pub fn stats_infer_hypothesis_edge_scale(s : StatsinferhypothesisEdge, f : Double) -> StatsinferhypothesisEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_edge_add(a : StatsinferhypothesisEdge, b : StatsinferhypothesisEdge) -> StatsinferhypothesisEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_hypothesis_edge_copy(s : StatsinferhypothesisEdge) -> StatsinferhypothesisEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_edge_fill(s : StatsinferhypothesisEdge, v : Double) -> StatsinferhypothesisEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_edge_min(s : StatsinferhypothesisEdge) -> Double { @_common.min(s.data) }

pub fn stats_infer_hypothesis_edge_max(s : StatsinferhypothesisEdge) -> Double { @_common.max(s.data) }

pub fn stats_infer_hypothesis_edge_to_string(s : StatsinferhypothesisEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_path_make(size : Int) -> StatsinferhypothesisPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_path_len(s : StatsinferhypothesisPath) -> Int { s.size }

pub fn stats_infer_hypothesis_path_get(s : StatsinferhypothesisPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_path_set(s : StatsinferhypothesisPath, i : Int, v : Double) -> StatsinferhypothesisPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_path_sum(s : StatsinferhypothesisPath) -> Double { @_common.sum(s.data) }

pub fn stats_infer_hypothesis_path_mean(s : StatsinferhypothesisPath) -> Double { @_common.mean(s.data) }

pub fn stats_infer_hypothesis_path_scale(s : StatsinferhypothesisPath, f : Double) -> StatsinferhypothesisPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_path_add(a : StatsinferhypothesisPath, b : StatsinferhypothesisPath) -> StatsinferhypothesisPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_hypothesis_path_copy(s : StatsinferhypothesisPath) -> StatsinferhypothesisPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_path_fill(s : StatsinferhypothesisPath, v : Double) -> StatsinferhypothesisPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_path_min(s : StatsinferhypothesisPath) -> Double { @_common.min(s.data) }

pub fn stats_infer_hypothesis_path_max(s : StatsinferhypothesisPath) -> Double { @_common.max(s.data) }

pub fn stats_infer_hypothesis_path_to_string(s : StatsinferhypothesisPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_cluster_make(size : Int) -> StatsinferhypothesisCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_cluster_len(s : StatsinferhypothesisCluster) -> Int { s.size }

pub fn stats_infer_hypothesis_cluster_get(s : StatsinferhypothesisCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_cluster_set(s : StatsinferhypothesisCluster, i : Int, v : Double) -> StatsinferhypothesisCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_cluster_sum(s : StatsinferhypothesisCluster) -> Double { @_common.sum(s.data) }

pub fn stats_infer_hypothesis_cluster_mean(s : StatsinferhypothesisCluster) -> Double { @_common.mean(s.data) }

pub fn stats_infer_hypothesis_cluster_scale(s : StatsinferhypothesisCluster, f : Double) -> StatsinferhypothesisCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_cluster_add(a : StatsinferhypothesisCluster, b : StatsinferhypothesisCluster) -> StatsinferhypothesisCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_hypothesis_cluster_copy(s : StatsinferhypothesisCluster) -> StatsinferhypothesisCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_cluster_fill(s : StatsinferhypothesisCluster, v : Double) -> StatsinferhypothesisCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_cluster_min(s : StatsinferhypothesisCluster) -> Double { @_common.min(s.data) }

pub fn stats_infer_hypothesis_cluster_max(s : StatsinferhypothesisCluster) -> Double { @_common.max(s.data) }

pub fn stats_infer_hypothesis_cluster_to_string(s : StatsinferhypothesisCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_model_make(size : Int) -> StatsinferhypothesisModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_model_len(s : StatsinferhypothesisModel) -> Int { s.size }

pub fn stats_infer_hypothesis_model_get(s : StatsinferhypothesisModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_model_set(s : StatsinferhypothesisModel, i : Int, v : Double) -> StatsinferhypothesisModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_model_sum(s : StatsinferhypothesisModel) -> Double { @_common.sum(s.data) }

pub fn stats_infer_hypothesis_model_mean(s : StatsinferhypothesisModel) -> Double { @_common.mean(s.data) }

pub fn stats_infer_hypothesis_model_scale(s : StatsinferhypothesisModel, f : Double) -> StatsinferhypothesisModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_model_add(a : StatsinferhypothesisModel, b : StatsinferhypothesisModel) -> StatsinferhypothesisModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_hypothesis_model_copy(s : StatsinferhypothesisModel) -> StatsinferhypothesisModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_model_fill(s : StatsinferhypothesisModel, v : Double) -> StatsinferhypothesisModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_model_min(s : StatsinferhypothesisModel) -> Double { @_common.min(s.data) }

pub fn stats_infer_hypothesis_model_max(s : StatsinferhypothesisModel) -> Double { @_common.max(s.data) }

pub fn stats_infer_hypothesis_model_to_string(s : StatsinferhypothesisModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_layer_make(size : Int) -> StatsinferhypothesisLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_layer_len(s : StatsinferhypothesisLayer) -> Int { s.size }

pub fn stats_infer_hypothesis_layer_get(s : StatsinferhypothesisLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_layer_set(s : StatsinferhypothesisLayer, i : Int, v : Double) -> StatsinferhypothesisLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_layer_sum(s : StatsinferhypothesisLayer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_hypothesis_layer_mean(s : StatsinferhypothesisLayer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_hypothesis_layer_scale(s : StatsinferhypothesisLayer, f : Double) -> StatsinferhypothesisLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_layer_add(a : StatsinferhypothesisLayer, b : StatsinferhypothesisLayer) -> StatsinferhypothesisLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_hypothesis_layer_copy(s : StatsinferhypothesisLayer) -> StatsinferhypothesisLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_layer_fill(s : StatsinferhypothesisLayer, v : Double) -> StatsinferhypothesisLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_layer_min(s : StatsinferhypothesisLayer) -> Double { @_common.min(s.data) }

pub fn stats_infer_hypothesis_layer_max(s : StatsinferhypothesisLayer) -> Double { @_common.max(s.data) }

pub fn stats_infer_hypothesis_layer_to_string(s : StatsinferhypothesisLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_buffer_make(size : Int) -> StatsinferhypothesisBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_buffer_len(s : StatsinferhypothesisBuffer) -> Int { s.size }

pub fn stats_infer_hypothesis_buffer_get(s : StatsinferhypothesisBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_buffer_set(s : StatsinferhypothesisBuffer, i : Int, v : Double) -> StatsinferhypothesisBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_buffer_sum(s : StatsinferhypothesisBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_infer_hypothesis_buffer_mean(s : StatsinferhypothesisBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_infer_hypothesis_buffer_scale(s : StatsinferhypothesisBuffer, f : Double) -> StatsinferhypothesisBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_buffer_add(a : StatsinferhypothesisBuffer, b : StatsinferhypothesisBuffer) -> StatsinferhypothesisBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_hypothesis_buffer_copy(s : StatsinferhypothesisBuffer) -> StatsinferhypothesisBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_buffer_fill(s : StatsinferhypothesisBuffer, v : Double) -> StatsinferhypothesisBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_buffer_min(s : StatsinferhypothesisBuffer) -> Double { @_common.min(s.data) }

pub fn stats_infer_hypothesis_buffer_max(s : StatsinferhypothesisBuffer) -> Double { @_common.max(s.data) }

pub fn stats_infer_hypothesis_buffer_to_string(s : StatsinferhypothesisBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_cursor_make(size : Int) -> StatsinferhypothesisCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_cursor_len(s : StatsinferhypothesisCursor) -> Int { s.size }

pub fn stats_infer_hypothesis_cursor_get(s : StatsinferhypothesisCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_cursor_set(s : StatsinferhypothesisCursor, i : Int, v : Double) -> StatsinferhypothesisCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_cursor_sum(s : StatsinferhypothesisCursor) -> Double { @_common.sum(s.data) }

pub fn stats_infer_hypothesis_cursor_mean(s : StatsinferhypothesisCursor) -> Double { @_common.mean(s.data) }

pub fn stats_infer_hypothesis_cursor_scale(s : StatsinferhypothesisCursor, f : Double) -> StatsinferhypothesisCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_cursor_add(a : StatsinferhypothesisCursor, b : StatsinferhypothesisCursor) -> StatsinferhypothesisCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_hypothesis_cursor_copy(s : StatsinferhypothesisCursor) -> StatsinferhypothesisCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_cursor_fill(s : StatsinferhypothesisCursor, v : Double) -> StatsinferhypothesisCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_cursor_min(s : StatsinferhypothesisCursor) -> Double { @_common.min(s.data) }

pub fn stats_infer_hypothesis_cursor_max(s : StatsinferhypothesisCursor) -> Double { @_common.max(s.data) }

pub fn stats_infer_hypothesis_cursor_to_string(s : StatsinferhypothesisCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_view_make(size : Int) -> StatsinferhypothesisView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_view_len(s : StatsinferhypothesisView) -> Int { s.size }

pub fn stats_infer_hypothesis_view_get(s : StatsinferhypothesisView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_view_set(s : StatsinferhypothesisView, i : Int, v : Double) -> StatsinferhypothesisView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_view_sum(s : StatsinferhypothesisView) -> Double { @_common.sum(s.data) }

pub fn stats_infer_hypothesis_view_mean(s : StatsinferhypothesisView) -> Double { @_common.mean(s.data) }

pub fn stats_infer_hypothesis_view_scale(s : StatsinferhypothesisView, f : Double) -> StatsinferhypothesisView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_view_add(a : StatsinferhypothesisView, b : StatsinferhypothesisView) -> StatsinferhypothesisView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_hypothesis_view_copy(s : StatsinferhypothesisView) -> StatsinferhypothesisView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_view_fill(s : StatsinferhypothesisView, v : Double) -> StatsinferhypothesisView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_view_min(s : StatsinferhypothesisView) -> Double { @_common.min(s.data) }

pub fn stats_infer_hypothesis_view_max(s : StatsinferhypothesisView) -> Double { @_common.max(s.data) }

pub fn stats_infer_hypothesis_view_to_string(s : StatsinferhypothesisView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_range_make(size : Int) -> StatsinferhypothesisRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_range_len(s : StatsinferhypothesisRange) -> Int { s.size }

pub fn stats_infer_hypothesis_range_get(s : StatsinferhypothesisRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_range_set(s : StatsinferhypothesisRange, i : Int, v : Double) -> StatsinferhypothesisRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_range_sum(s : StatsinferhypothesisRange) -> Double { @_common.sum(s.data) }

pub fn stats_infer_hypothesis_range_mean(s : StatsinferhypothesisRange) -> Double { @_common.mean(s.data) }

pub fn stats_infer_hypothesis_range_scale(s : StatsinferhypothesisRange, f : Double) -> StatsinferhypothesisRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_range_add(a : StatsinferhypothesisRange, b : StatsinferhypothesisRange) -> StatsinferhypothesisRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_hypothesis_range_copy(s : StatsinferhypothesisRange) -> StatsinferhypothesisRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_range_fill(s : StatsinferhypothesisRange, v : Double) -> StatsinferhypothesisRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_range_min(s : StatsinferhypothesisRange) -> Double { @_common.min(s.data) }

pub fn stats_infer_hypothesis_range_max(s : StatsinferhypothesisRange) -> Double { @_common.max(s.data) }

pub fn stats_infer_hypothesis_range_to_string(s : StatsinferhypothesisRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_slice_make(size : Int) -> StatsinferhypothesisSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_infer_hypothesis_slice_len(s : StatsinferhypothesisSlice) -> Int { s.size }

pub fn stats_infer_hypothesis_slice_get(s : StatsinferhypothesisSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_infer_hypothesis_slice_set(s : StatsinferhypothesisSlice, i : Int, v : Double) -> StatsinferhypothesisSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_slice_sum(s : StatsinferhypothesisSlice) -> Double { @_common.sum(s.data) }

pub fn stats_infer_hypothesis_slice_mean(s : StatsinferhypothesisSlice) -> Double { @_common.mean(s.data) }

pub fn stats_infer_hypothesis_slice_scale(s : StatsinferhypothesisSlice, f : Double) -> StatsinferhypothesisSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_slice_add(a : StatsinferhypothesisSlice, b : StatsinferhypothesisSlice) -> StatsinferhypothesisSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_infer_hypothesis_slice_copy(s : StatsinferhypothesisSlice) -> StatsinferhypothesisSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_slice_fill(s : StatsinferhypothesisSlice, v : Double) -> StatsinferhypothesisSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_infer_hypothesis_slice_min(s : StatsinferhypothesisSlice) -> Double { @_common.min(s.data) }

pub fn stats_infer_hypothesis_slice_max(s : StatsinferhypothesisSlice) -> Double { @_common.max(s.data) }

pub fn stats_infer_hypothesis_slice_to_string(s : StatsinferhypothesisSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

