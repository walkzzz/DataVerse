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

pub fn StatsinferhypothesisFrame::len(self : StatsinferhypothesisFrame) -> Int { self.size }

pub fn StatsinferhypothesisFrame::get(self : StatsinferhypothesisFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferhypothesisFrame::set(self : StatsinferhypothesisFrame, i : Int, v : Double) -> StatsinferhypothesisFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisFrame::sum(self : StatsinferhypothesisFrame) -> Double { @_common.sum(self.data) }

pub fn StatsinferhypothesisFrame::mean(self : StatsinferhypothesisFrame) -> Double { @_common.mean(self.data) }

pub fn StatsinferhypothesisFrame::scale(self : StatsinferhypothesisFrame, f : Double) -> StatsinferhypothesisFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisFrame::add(self : StatsinferhypothesisFrame, other : StatsinferhypothesisFrame) -> StatsinferhypothesisFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferhypothesisFrame::copy(self : StatsinferhypothesisFrame) -> StatsinferhypothesisFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisFrame::fill(self : StatsinferhypothesisFrame, v : Double) -> StatsinferhypothesisFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisFrame::min(self : StatsinferhypothesisFrame) -> Double { @_common.min(self.data) }

pub fn StatsinferhypothesisFrame::max(self : StatsinferhypothesisFrame) -> Double { @_common.max(self.data) }

pub fn StatsinferhypothesisFrame::to_string(self : StatsinferhypothesisFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_table_make(size : Int) -> StatsinferhypothesisTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferhypothesisTable::len(self : StatsinferhypothesisTable) -> Int { self.size }

pub fn StatsinferhypothesisTable::get(self : StatsinferhypothesisTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferhypothesisTable::set(self : StatsinferhypothesisTable, i : Int, v : Double) -> StatsinferhypothesisTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisTable::sum(self : StatsinferhypothesisTable) -> Double { @_common.sum(self.data) }

pub fn StatsinferhypothesisTable::mean(self : StatsinferhypothesisTable) -> Double { @_common.mean(self.data) }

pub fn StatsinferhypothesisTable::scale(self : StatsinferhypothesisTable, f : Double) -> StatsinferhypothesisTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisTable::add(self : StatsinferhypothesisTable, other : StatsinferhypothesisTable) -> StatsinferhypothesisTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferhypothesisTable::copy(self : StatsinferhypothesisTable) -> StatsinferhypothesisTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisTable::fill(self : StatsinferhypothesisTable, v : Double) -> StatsinferhypothesisTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisTable::min(self : StatsinferhypothesisTable) -> Double { @_common.min(self.data) }

pub fn StatsinferhypothesisTable::max(self : StatsinferhypothesisTable) -> Double { @_common.max(self.data) }

pub fn StatsinferhypothesisTable::to_string(self : StatsinferhypothesisTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_graphn_make(size : Int) -> StatsinferhypothesisGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferhypothesisGraphN::len(self : StatsinferhypothesisGraphN) -> Int { self.size }

pub fn StatsinferhypothesisGraphN::get(self : StatsinferhypothesisGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferhypothesisGraphN::set(self : StatsinferhypothesisGraphN, i : Int, v : Double) -> StatsinferhypothesisGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisGraphN::sum(self : StatsinferhypothesisGraphN) -> Double { @_common.sum(self.data) }

pub fn StatsinferhypothesisGraphN::mean(self : StatsinferhypothesisGraphN) -> Double { @_common.mean(self.data) }

pub fn StatsinferhypothesisGraphN::scale(self : StatsinferhypothesisGraphN, f : Double) -> StatsinferhypothesisGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisGraphN::add(self : StatsinferhypothesisGraphN, other : StatsinferhypothesisGraphN) -> StatsinferhypothesisGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferhypothesisGraphN::copy(self : StatsinferhypothesisGraphN) -> StatsinferhypothesisGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisGraphN::fill(self : StatsinferhypothesisGraphN, v : Double) -> StatsinferhypothesisGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisGraphN::min(self : StatsinferhypothesisGraphN) -> Double { @_common.min(self.data) }

pub fn StatsinferhypothesisGraphN::max(self : StatsinferhypothesisGraphN) -> Double { @_common.max(self.data) }

pub fn StatsinferhypothesisGraphN::to_string(self : StatsinferhypothesisGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_node_make(size : Int) -> StatsinferhypothesisNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferhypothesisNode::len(self : StatsinferhypothesisNode) -> Int { self.size }

pub fn StatsinferhypothesisNode::get(self : StatsinferhypothesisNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferhypothesisNode::set(self : StatsinferhypothesisNode, i : Int, v : Double) -> StatsinferhypothesisNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisNode::sum(self : StatsinferhypothesisNode) -> Double { @_common.sum(self.data) }

pub fn StatsinferhypothesisNode::mean(self : StatsinferhypothesisNode) -> Double { @_common.mean(self.data) }

pub fn StatsinferhypothesisNode::scale(self : StatsinferhypothesisNode, f : Double) -> StatsinferhypothesisNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisNode::add(self : StatsinferhypothesisNode, other : StatsinferhypothesisNode) -> StatsinferhypothesisNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferhypothesisNode::copy(self : StatsinferhypothesisNode) -> StatsinferhypothesisNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisNode::fill(self : StatsinferhypothesisNode, v : Double) -> StatsinferhypothesisNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisNode::min(self : StatsinferhypothesisNode) -> Double { @_common.min(self.data) }

pub fn StatsinferhypothesisNode::max(self : StatsinferhypothesisNode) -> Double { @_common.max(self.data) }

pub fn StatsinferhypothesisNode::to_string(self : StatsinferhypothesisNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_edge_make(size : Int) -> StatsinferhypothesisEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferhypothesisEdge::len(self : StatsinferhypothesisEdge) -> Int { self.size }

pub fn StatsinferhypothesisEdge::get(self : StatsinferhypothesisEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferhypothesisEdge::set(self : StatsinferhypothesisEdge, i : Int, v : Double) -> StatsinferhypothesisEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisEdge::sum(self : StatsinferhypothesisEdge) -> Double { @_common.sum(self.data) }

pub fn StatsinferhypothesisEdge::mean(self : StatsinferhypothesisEdge) -> Double { @_common.mean(self.data) }

pub fn StatsinferhypothesisEdge::scale(self : StatsinferhypothesisEdge, f : Double) -> StatsinferhypothesisEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisEdge::add(self : StatsinferhypothesisEdge, other : StatsinferhypothesisEdge) -> StatsinferhypothesisEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferhypothesisEdge::copy(self : StatsinferhypothesisEdge) -> StatsinferhypothesisEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisEdge::fill(self : StatsinferhypothesisEdge, v : Double) -> StatsinferhypothesisEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisEdge::min(self : StatsinferhypothesisEdge) -> Double { @_common.min(self.data) }

pub fn StatsinferhypothesisEdge::max(self : StatsinferhypothesisEdge) -> Double { @_common.max(self.data) }

pub fn StatsinferhypothesisEdge::to_string(self : StatsinferhypothesisEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_path_make(size : Int) -> StatsinferhypothesisPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferhypothesisPath::len(self : StatsinferhypothesisPath) -> Int { self.size }

pub fn StatsinferhypothesisPath::get(self : StatsinferhypothesisPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferhypothesisPath::set(self : StatsinferhypothesisPath, i : Int, v : Double) -> StatsinferhypothesisPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisPath::sum(self : StatsinferhypothesisPath) -> Double { @_common.sum(self.data) }

pub fn StatsinferhypothesisPath::mean(self : StatsinferhypothesisPath) -> Double { @_common.mean(self.data) }

pub fn StatsinferhypothesisPath::scale(self : StatsinferhypothesisPath, f : Double) -> StatsinferhypothesisPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisPath::add(self : StatsinferhypothesisPath, other : StatsinferhypothesisPath) -> StatsinferhypothesisPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferhypothesisPath::copy(self : StatsinferhypothesisPath) -> StatsinferhypothesisPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisPath::fill(self : StatsinferhypothesisPath, v : Double) -> StatsinferhypothesisPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisPath::min(self : StatsinferhypothesisPath) -> Double { @_common.min(self.data) }

pub fn StatsinferhypothesisPath::max(self : StatsinferhypothesisPath) -> Double { @_common.max(self.data) }

pub fn StatsinferhypothesisPath::to_string(self : StatsinferhypothesisPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_cluster_make(size : Int) -> StatsinferhypothesisCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferhypothesisCluster::len(self : StatsinferhypothesisCluster) -> Int { self.size }

pub fn StatsinferhypothesisCluster::get(self : StatsinferhypothesisCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferhypothesisCluster::set(self : StatsinferhypothesisCluster, i : Int, v : Double) -> StatsinferhypothesisCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisCluster::sum(self : StatsinferhypothesisCluster) -> Double { @_common.sum(self.data) }

pub fn StatsinferhypothesisCluster::mean(self : StatsinferhypothesisCluster) -> Double { @_common.mean(self.data) }

pub fn StatsinferhypothesisCluster::scale(self : StatsinferhypothesisCluster, f : Double) -> StatsinferhypothesisCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisCluster::add(self : StatsinferhypothesisCluster, other : StatsinferhypothesisCluster) -> StatsinferhypothesisCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferhypothesisCluster::copy(self : StatsinferhypothesisCluster) -> StatsinferhypothesisCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisCluster::fill(self : StatsinferhypothesisCluster, v : Double) -> StatsinferhypothesisCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisCluster::min(self : StatsinferhypothesisCluster) -> Double { @_common.min(self.data) }

pub fn StatsinferhypothesisCluster::max(self : StatsinferhypothesisCluster) -> Double { @_common.max(self.data) }

pub fn StatsinferhypothesisCluster::to_string(self : StatsinferhypothesisCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_model_make(size : Int) -> StatsinferhypothesisModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferhypothesisModel::len(self : StatsinferhypothesisModel) -> Int { self.size }

pub fn StatsinferhypothesisModel::get(self : StatsinferhypothesisModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferhypothesisModel::set(self : StatsinferhypothesisModel, i : Int, v : Double) -> StatsinferhypothesisModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisModel::sum(self : StatsinferhypothesisModel) -> Double { @_common.sum(self.data) }

pub fn StatsinferhypothesisModel::mean(self : StatsinferhypothesisModel) -> Double { @_common.mean(self.data) }

pub fn StatsinferhypothesisModel::scale(self : StatsinferhypothesisModel, f : Double) -> StatsinferhypothesisModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisModel::add(self : StatsinferhypothesisModel, other : StatsinferhypothesisModel) -> StatsinferhypothesisModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferhypothesisModel::copy(self : StatsinferhypothesisModel) -> StatsinferhypothesisModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisModel::fill(self : StatsinferhypothesisModel, v : Double) -> StatsinferhypothesisModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisModel::min(self : StatsinferhypothesisModel) -> Double { @_common.min(self.data) }

pub fn StatsinferhypothesisModel::max(self : StatsinferhypothesisModel) -> Double { @_common.max(self.data) }

pub fn StatsinferhypothesisModel::to_string(self : StatsinferhypothesisModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_layer_make(size : Int) -> StatsinferhypothesisLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferhypothesisLayer::len(self : StatsinferhypothesisLayer) -> Int { self.size }

pub fn StatsinferhypothesisLayer::get(self : StatsinferhypothesisLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferhypothesisLayer::set(self : StatsinferhypothesisLayer, i : Int, v : Double) -> StatsinferhypothesisLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisLayer::sum(self : StatsinferhypothesisLayer) -> Double { @_common.sum(self.data) }

pub fn StatsinferhypothesisLayer::mean(self : StatsinferhypothesisLayer) -> Double { @_common.mean(self.data) }

pub fn StatsinferhypothesisLayer::scale(self : StatsinferhypothesisLayer, f : Double) -> StatsinferhypothesisLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisLayer::add(self : StatsinferhypothesisLayer, other : StatsinferhypothesisLayer) -> StatsinferhypothesisLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferhypothesisLayer::copy(self : StatsinferhypothesisLayer) -> StatsinferhypothesisLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisLayer::fill(self : StatsinferhypothesisLayer, v : Double) -> StatsinferhypothesisLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisLayer::min(self : StatsinferhypothesisLayer) -> Double { @_common.min(self.data) }

pub fn StatsinferhypothesisLayer::max(self : StatsinferhypothesisLayer) -> Double { @_common.max(self.data) }

pub fn StatsinferhypothesisLayer::to_string(self : StatsinferhypothesisLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_buffer_make(size : Int) -> StatsinferhypothesisBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferhypothesisBuffer::len(self : StatsinferhypothesisBuffer) -> Int { self.size }

pub fn StatsinferhypothesisBuffer::get(self : StatsinferhypothesisBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferhypothesisBuffer::set(self : StatsinferhypothesisBuffer, i : Int, v : Double) -> StatsinferhypothesisBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisBuffer::sum(self : StatsinferhypothesisBuffer) -> Double { @_common.sum(self.data) }

pub fn StatsinferhypothesisBuffer::mean(self : StatsinferhypothesisBuffer) -> Double { @_common.mean(self.data) }

pub fn StatsinferhypothesisBuffer::scale(self : StatsinferhypothesisBuffer, f : Double) -> StatsinferhypothesisBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisBuffer::add(self : StatsinferhypothesisBuffer, other : StatsinferhypothesisBuffer) -> StatsinferhypothesisBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferhypothesisBuffer::copy(self : StatsinferhypothesisBuffer) -> StatsinferhypothesisBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisBuffer::fill(self : StatsinferhypothesisBuffer, v : Double) -> StatsinferhypothesisBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisBuffer::min(self : StatsinferhypothesisBuffer) -> Double { @_common.min(self.data) }

pub fn StatsinferhypothesisBuffer::max(self : StatsinferhypothesisBuffer) -> Double { @_common.max(self.data) }

pub fn StatsinferhypothesisBuffer::to_string(self : StatsinferhypothesisBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_cursor_make(size : Int) -> StatsinferhypothesisCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferhypothesisCursor::len(self : StatsinferhypothesisCursor) -> Int { self.size }

pub fn StatsinferhypothesisCursor::get(self : StatsinferhypothesisCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferhypothesisCursor::set(self : StatsinferhypothesisCursor, i : Int, v : Double) -> StatsinferhypothesisCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisCursor::sum(self : StatsinferhypothesisCursor) -> Double { @_common.sum(self.data) }

pub fn StatsinferhypothesisCursor::mean(self : StatsinferhypothesisCursor) -> Double { @_common.mean(self.data) }

pub fn StatsinferhypothesisCursor::scale(self : StatsinferhypothesisCursor, f : Double) -> StatsinferhypothesisCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisCursor::add(self : StatsinferhypothesisCursor, other : StatsinferhypothesisCursor) -> StatsinferhypothesisCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferhypothesisCursor::copy(self : StatsinferhypothesisCursor) -> StatsinferhypothesisCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisCursor::fill(self : StatsinferhypothesisCursor, v : Double) -> StatsinferhypothesisCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisCursor::min(self : StatsinferhypothesisCursor) -> Double { @_common.min(self.data) }

pub fn StatsinferhypothesisCursor::max(self : StatsinferhypothesisCursor) -> Double { @_common.max(self.data) }

pub fn StatsinferhypothesisCursor::to_string(self : StatsinferhypothesisCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_view_make(size : Int) -> StatsinferhypothesisView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferhypothesisView::len(self : StatsinferhypothesisView) -> Int { self.size }

pub fn StatsinferhypothesisView::get(self : StatsinferhypothesisView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferhypothesisView::set(self : StatsinferhypothesisView, i : Int, v : Double) -> StatsinferhypothesisView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisView::sum(self : StatsinferhypothesisView) -> Double { @_common.sum(self.data) }

pub fn StatsinferhypothesisView::mean(self : StatsinferhypothesisView) -> Double { @_common.mean(self.data) }

pub fn StatsinferhypothesisView::scale(self : StatsinferhypothesisView, f : Double) -> StatsinferhypothesisView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisView::add(self : StatsinferhypothesisView, other : StatsinferhypothesisView) -> StatsinferhypothesisView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferhypothesisView::copy(self : StatsinferhypothesisView) -> StatsinferhypothesisView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisView::fill(self : StatsinferhypothesisView, v : Double) -> StatsinferhypothesisView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisView::min(self : StatsinferhypothesisView) -> Double { @_common.min(self.data) }

pub fn StatsinferhypothesisView::max(self : StatsinferhypothesisView) -> Double { @_common.max(self.data) }

pub fn StatsinferhypothesisView::to_string(self : StatsinferhypothesisView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_range_make(size : Int) -> StatsinferhypothesisRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferhypothesisRange::len(self : StatsinferhypothesisRange) -> Int { self.size }

pub fn StatsinferhypothesisRange::get(self : StatsinferhypothesisRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferhypothesisRange::set(self : StatsinferhypothesisRange, i : Int, v : Double) -> StatsinferhypothesisRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisRange::sum(self : StatsinferhypothesisRange) -> Double { @_common.sum(self.data) }

pub fn StatsinferhypothesisRange::mean(self : StatsinferhypothesisRange) -> Double { @_common.mean(self.data) }

pub fn StatsinferhypothesisRange::scale(self : StatsinferhypothesisRange, f : Double) -> StatsinferhypothesisRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisRange::add(self : StatsinferhypothesisRange, other : StatsinferhypothesisRange) -> StatsinferhypothesisRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferhypothesisRange::copy(self : StatsinferhypothesisRange) -> StatsinferhypothesisRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisRange::fill(self : StatsinferhypothesisRange, v : Double) -> StatsinferhypothesisRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisRange::min(self : StatsinferhypothesisRange) -> Double { @_common.min(self.data) }

pub fn StatsinferhypothesisRange::max(self : StatsinferhypothesisRange) -> Double { @_common.max(self.data) }

pub fn StatsinferhypothesisRange::to_string(self : StatsinferhypothesisRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct StatsinferhypothesisSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_infer_hypothesis_slice_make(size : Int) -> StatsinferhypothesisSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn StatsinferhypothesisSlice::len(self : StatsinferhypothesisSlice) -> Int { self.size }

pub fn StatsinferhypothesisSlice::get(self : StatsinferhypothesisSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn StatsinferhypothesisSlice::set(self : StatsinferhypothesisSlice, i : Int, v : Double) -> StatsinferhypothesisSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisSlice::sum(self : StatsinferhypothesisSlice) -> Double { @_common.sum(self.data) }

pub fn StatsinferhypothesisSlice::mean(self : StatsinferhypothesisSlice) -> Double { @_common.mean(self.data) }

pub fn StatsinferhypothesisSlice::scale(self : StatsinferhypothesisSlice, f : Double) -> StatsinferhypothesisSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisSlice::add(self : StatsinferhypothesisSlice, other : StatsinferhypothesisSlice) -> StatsinferhypothesisSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn StatsinferhypothesisSlice::copy(self : StatsinferhypothesisSlice) -> StatsinferhypothesisSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisSlice::fill(self : StatsinferhypothesisSlice, v : Double) -> StatsinferhypothesisSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn StatsinferhypothesisSlice::min(self : StatsinferhypothesisSlice) -> Double { @_common.min(self.data) }

pub fn StatsinferhypothesisSlice::max(self : StatsinferhypothesisSlice) -> Double { @_common.max(self.data) }

pub fn StatsinferhypothesisSlice::to_string(self : StatsinferhypothesisSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

