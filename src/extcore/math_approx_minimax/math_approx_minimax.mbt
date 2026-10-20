///===
/// extcore/math_approx_minimax

pub(all) struct MathapproxminimaxPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_minimax_make_point(x : Double, y : Double) -> MathapproxminimaxPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_minimax_make_point3(x : Double, y : Double, z : Double) -> MathapproxminimaxPoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxminimaxPoint::x(self : MathapproxminimaxPoint) -> Double { self.x }

pub fn MathapproxminimaxPoint::y(self : MathapproxminimaxPoint) -> Double { self.y }

pub fn MathapproxminimaxPoint::z(self : MathapproxminimaxPoint) -> Double { self.z }

pub fn MathapproxminimaxPoint::label(self : MathapproxminimaxPoint) -> Int { self.label }

pub fn MathapproxminimaxPoint::dist(self : MathapproxminimaxPoint, other : MathapproxminimaxPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxminimaxPoint::add(self : MathapproxminimaxPoint, other : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxminimaxPoint::sub(self : MathapproxminimaxPoint, other : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxminimaxPoint::scale(self : MathapproxminimaxPoint, s : Double) -> MathapproxminimaxPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxminimaxPoint::dot(self : MathapproxminimaxPoint, other : MathapproxminimaxPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxminimaxPoint::cross(self : MathapproxminimaxPoint, other : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxminimaxPoint::norm(self : MathapproxminimaxPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxminimaxPoint::normalize(self : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxminimaxPoint::negate(self : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxminimaxPoint::mid(self : MathapproxminimaxPoint, other : MathapproxminimaxPoint) -> MathapproxminimaxPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxminimaxPoint::lerp(self : MathapproxminimaxPoint, other : MathapproxminimaxPoint, t : Double) -> MathapproxminimaxPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxminimaxPoint::to_string(self : MathapproxminimaxPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxminimaxSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_minimax_make_series(vals : Array[Double], name : String) -> MathapproxminimaxSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxminimaxSeries::len(self : MathapproxminimaxSeries) -> Int { self.vals.length() }

pub fn MathapproxminimaxSeries::sum(self : MathapproxminimaxSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxminimaxSeries::mean(self : MathapproxminimaxSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxminimaxSeries::min(self : MathapproxminimaxSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxminimaxSeries::max(self : MathapproxminimaxSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxminimaxSeries::range(self : MathapproxminimaxSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxminimaxSeries::variance(self : MathapproxminimaxSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxminimaxSeries::std(self : MathapproxminimaxSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxminimaxSeries::median(self : MathapproxminimaxSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxminimaxSeries::scale(self : MathapproxminimaxSeries, f : Double) -> MathapproxminimaxSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxminimaxSeries::add(self : MathapproxminimaxSeries, other : MathapproxminimaxSeries) -> MathapproxminimaxSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxminimaxSeries::sub(self : MathapproxminimaxSeries, other : MathapproxminimaxSeries) -> MathapproxminimaxSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxminimaxSeries::normalize(self : MathapproxminimaxSeries) -> MathapproxminimaxSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxminimaxSeries::cumsum(self : MathapproxminimaxSeries) -> MathapproxminimaxSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxminimaxSeries::to_string(self : MathapproxminimaxSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxminimaxMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_minimax_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxminimaxMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_minimax_matrix_identity(n : Int) -> MathapproxminimaxMatrix {
  let m = math_approx_minimax_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxminimaxMatrix::get(self : MathapproxminimaxMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxminimaxMatrix::transpose(self : MathapproxminimaxMatrix) -> MathapproxminimaxMatrix {
  let result = math_approx_minimax_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxminimaxMatrix::add(self : MathapproxminimaxMatrix, other : MathapproxminimaxMatrix) -> MathapproxminimaxMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_minimax_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxminimaxMatrix::scale(self : MathapproxminimaxMatrix, s : Double) -> MathapproxminimaxMatrix {
  let result = math_approx_minimax_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxminimaxMatrix::multiply(self : MathapproxminimaxMatrix, other : MathapproxminimaxMatrix) -> MathapproxminimaxMatrix {
  if self.cols != other.rows { return math_approx_minimax_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_minimax_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathapproxminimaxMatrix::trace(self : MathapproxminimaxMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxminimaxMatrix::det(self : MathapproxminimaxMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxminimaxMatrix::norm(self : MathapproxminimaxMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxminimaxMatrix::to_string(self : MathapproxminimaxMatrix) -> String {
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

pub(all) struct MathapproxminimaxVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_minimax_make_vector(comps : Array[Double]) -> MathapproxminimaxVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_minimax_vector_zero(dim : Int) -> MathapproxminimaxVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxminimaxVector::add(self : MathapproxminimaxVector, other : MathapproxminimaxVector) -> MathapproxminimaxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxminimaxVector::sub(self : MathapproxminimaxVector, other : MathapproxminimaxVector) -> MathapproxminimaxVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxminimaxVector::scale(self : MathapproxminimaxVector, s : Double) -> MathapproxminimaxVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxminimaxVector::dot(self : MathapproxminimaxVector, other : MathapproxminimaxVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxminimaxVector::norm(self : MathapproxminimaxVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxminimaxVector::normalize(self : MathapproxminimaxVector) -> MathapproxminimaxVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxminimaxVector::dist(self : MathapproxminimaxVector, other : MathapproxminimaxVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxminimaxVector::to_string(self : MathapproxminimaxVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_minimax_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_minimax_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_minimax_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_minimax_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_minimax_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_minimax_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_minimax_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_minimax_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_minimax_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_minimax_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_minimax_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_minimax_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_minimax_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_minimax_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_minimax_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_minimax_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_minimax_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_minimax_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_minimax_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_minimax_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_minimax_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_minimax_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_minimax_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_minimax_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_minimax_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_minimax_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_minimax_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_minimax_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_minimax_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxminimaxFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_frame_make(size : Int) -> MathapproxminimaxFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxminimaxFrame::len(self : MathapproxminimaxFrame) -> Int { self.size }

pub fn MathapproxminimaxFrame::get(self : MathapproxminimaxFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxminimaxFrame::set(self : MathapproxminimaxFrame, i : Int, v : Double) -> MathapproxminimaxFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxFrame::sum(self : MathapproxminimaxFrame) -> Double { @_common.sum(self.data) }

pub fn MathapproxminimaxFrame::mean(self : MathapproxminimaxFrame) -> Double { @_common.mean(self.data) }

pub fn MathapproxminimaxFrame::scale(self : MathapproxminimaxFrame, f : Double) -> MathapproxminimaxFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxFrame::add(self : MathapproxminimaxFrame, other : MathapproxminimaxFrame) -> MathapproxminimaxFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxminimaxFrame::copy(self : MathapproxminimaxFrame) -> MathapproxminimaxFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxFrame::fill(self : MathapproxminimaxFrame, v : Double) -> MathapproxminimaxFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxFrame::min(self : MathapproxminimaxFrame) -> Double { @_common.min(self.data) }

pub fn MathapproxminimaxFrame::max(self : MathapproxminimaxFrame) -> Double { @_common.max(self.data) }

pub fn MathapproxminimaxFrame::to_string(self : MathapproxminimaxFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_table_make(size : Int) -> MathapproxminimaxTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxminimaxTable::len(self : MathapproxminimaxTable) -> Int { self.size }

pub fn MathapproxminimaxTable::get(self : MathapproxminimaxTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxminimaxTable::set(self : MathapproxminimaxTable, i : Int, v : Double) -> MathapproxminimaxTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxTable::sum(self : MathapproxminimaxTable) -> Double { @_common.sum(self.data) }

pub fn MathapproxminimaxTable::mean(self : MathapproxminimaxTable) -> Double { @_common.mean(self.data) }

pub fn MathapproxminimaxTable::scale(self : MathapproxminimaxTable, f : Double) -> MathapproxminimaxTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxTable::add(self : MathapproxminimaxTable, other : MathapproxminimaxTable) -> MathapproxminimaxTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxminimaxTable::copy(self : MathapproxminimaxTable) -> MathapproxminimaxTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxTable::fill(self : MathapproxminimaxTable, v : Double) -> MathapproxminimaxTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxTable::min(self : MathapproxminimaxTable) -> Double { @_common.min(self.data) }

pub fn MathapproxminimaxTable::max(self : MathapproxminimaxTable) -> Double { @_common.max(self.data) }

pub fn MathapproxminimaxTable::to_string(self : MathapproxminimaxTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_graphn_make(size : Int) -> MathapproxminimaxGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxminimaxGraphN::len(self : MathapproxminimaxGraphN) -> Int { self.size }

pub fn MathapproxminimaxGraphN::get(self : MathapproxminimaxGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxminimaxGraphN::set(self : MathapproxminimaxGraphN, i : Int, v : Double) -> MathapproxminimaxGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxGraphN::sum(self : MathapproxminimaxGraphN) -> Double { @_common.sum(self.data) }

pub fn MathapproxminimaxGraphN::mean(self : MathapproxminimaxGraphN) -> Double { @_common.mean(self.data) }

pub fn MathapproxminimaxGraphN::scale(self : MathapproxminimaxGraphN, f : Double) -> MathapproxminimaxGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxGraphN::add(self : MathapproxminimaxGraphN, other : MathapproxminimaxGraphN) -> MathapproxminimaxGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxminimaxGraphN::copy(self : MathapproxminimaxGraphN) -> MathapproxminimaxGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxGraphN::fill(self : MathapproxminimaxGraphN, v : Double) -> MathapproxminimaxGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxGraphN::min(self : MathapproxminimaxGraphN) -> Double { @_common.min(self.data) }

pub fn MathapproxminimaxGraphN::max(self : MathapproxminimaxGraphN) -> Double { @_common.max(self.data) }

pub fn MathapproxminimaxGraphN::to_string(self : MathapproxminimaxGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_node_make(size : Int) -> MathapproxminimaxNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxminimaxNode::len(self : MathapproxminimaxNode) -> Int { self.size }

pub fn MathapproxminimaxNode::get(self : MathapproxminimaxNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxminimaxNode::set(self : MathapproxminimaxNode, i : Int, v : Double) -> MathapproxminimaxNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxNode::sum(self : MathapproxminimaxNode) -> Double { @_common.sum(self.data) }

pub fn MathapproxminimaxNode::mean(self : MathapproxminimaxNode) -> Double { @_common.mean(self.data) }

pub fn MathapproxminimaxNode::scale(self : MathapproxminimaxNode, f : Double) -> MathapproxminimaxNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxNode::add(self : MathapproxminimaxNode, other : MathapproxminimaxNode) -> MathapproxminimaxNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxminimaxNode::copy(self : MathapproxminimaxNode) -> MathapproxminimaxNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxNode::fill(self : MathapproxminimaxNode, v : Double) -> MathapproxminimaxNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxNode::min(self : MathapproxminimaxNode) -> Double { @_common.min(self.data) }

pub fn MathapproxminimaxNode::max(self : MathapproxminimaxNode) -> Double { @_common.max(self.data) }

pub fn MathapproxminimaxNode::to_string(self : MathapproxminimaxNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_edge_make(size : Int) -> MathapproxminimaxEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxminimaxEdge::len(self : MathapproxminimaxEdge) -> Int { self.size }

pub fn MathapproxminimaxEdge::get(self : MathapproxminimaxEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxminimaxEdge::set(self : MathapproxminimaxEdge, i : Int, v : Double) -> MathapproxminimaxEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxEdge::sum(self : MathapproxminimaxEdge) -> Double { @_common.sum(self.data) }

pub fn MathapproxminimaxEdge::mean(self : MathapproxminimaxEdge) -> Double { @_common.mean(self.data) }

pub fn MathapproxminimaxEdge::scale(self : MathapproxminimaxEdge, f : Double) -> MathapproxminimaxEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxEdge::add(self : MathapproxminimaxEdge, other : MathapproxminimaxEdge) -> MathapproxminimaxEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxminimaxEdge::copy(self : MathapproxminimaxEdge) -> MathapproxminimaxEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxEdge::fill(self : MathapproxminimaxEdge, v : Double) -> MathapproxminimaxEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxEdge::min(self : MathapproxminimaxEdge) -> Double { @_common.min(self.data) }

pub fn MathapproxminimaxEdge::max(self : MathapproxminimaxEdge) -> Double { @_common.max(self.data) }

pub fn MathapproxminimaxEdge::to_string(self : MathapproxminimaxEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_path_make(size : Int) -> MathapproxminimaxPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxminimaxPath::len(self : MathapproxminimaxPath) -> Int { self.size }

pub fn MathapproxminimaxPath::get(self : MathapproxminimaxPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxminimaxPath::set(self : MathapproxminimaxPath, i : Int, v : Double) -> MathapproxminimaxPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxPath::sum(self : MathapproxminimaxPath) -> Double { @_common.sum(self.data) }

pub fn MathapproxminimaxPath::mean(self : MathapproxminimaxPath) -> Double { @_common.mean(self.data) }

pub fn MathapproxminimaxPath::scale(self : MathapproxminimaxPath, f : Double) -> MathapproxminimaxPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxPath::add(self : MathapproxminimaxPath, other : MathapproxminimaxPath) -> MathapproxminimaxPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxminimaxPath::copy(self : MathapproxminimaxPath) -> MathapproxminimaxPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxPath::fill(self : MathapproxminimaxPath, v : Double) -> MathapproxminimaxPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxPath::min(self : MathapproxminimaxPath) -> Double { @_common.min(self.data) }

pub fn MathapproxminimaxPath::max(self : MathapproxminimaxPath) -> Double { @_common.max(self.data) }

pub fn MathapproxminimaxPath::to_string(self : MathapproxminimaxPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_cluster_make(size : Int) -> MathapproxminimaxCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxminimaxCluster::len(self : MathapproxminimaxCluster) -> Int { self.size }

pub fn MathapproxminimaxCluster::get(self : MathapproxminimaxCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxminimaxCluster::set(self : MathapproxminimaxCluster, i : Int, v : Double) -> MathapproxminimaxCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxCluster::sum(self : MathapproxminimaxCluster) -> Double { @_common.sum(self.data) }

pub fn MathapproxminimaxCluster::mean(self : MathapproxminimaxCluster) -> Double { @_common.mean(self.data) }

pub fn MathapproxminimaxCluster::scale(self : MathapproxminimaxCluster, f : Double) -> MathapproxminimaxCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxCluster::add(self : MathapproxminimaxCluster, other : MathapproxminimaxCluster) -> MathapproxminimaxCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxminimaxCluster::copy(self : MathapproxminimaxCluster) -> MathapproxminimaxCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxCluster::fill(self : MathapproxminimaxCluster, v : Double) -> MathapproxminimaxCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxCluster::min(self : MathapproxminimaxCluster) -> Double { @_common.min(self.data) }

pub fn MathapproxminimaxCluster::max(self : MathapproxminimaxCluster) -> Double { @_common.max(self.data) }

pub fn MathapproxminimaxCluster::to_string(self : MathapproxminimaxCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_model_make(size : Int) -> MathapproxminimaxModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxminimaxModel::len(self : MathapproxminimaxModel) -> Int { self.size }

pub fn MathapproxminimaxModel::get(self : MathapproxminimaxModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxminimaxModel::set(self : MathapproxminimaxModel, i : Int, v : Double) -> MathapproxminimaxModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxModel::sum(self : MathapproxminimaxModel) -> Double { @_common.sum(self.data) }

pub fn MathapproxminimaxModel::mean(self : MathapproxminimaxModel) -> Double { @_common.mean(self.data) }

pub fn MathapproxminimaxModel::scale(self : MathapproxminimaxModel, f : Double) -> MathapproxminimaxModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxModel::add(self : MathapproxminimaxModel, other : MathapproxminimaxModel) -> MathapproxminimaxModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxminimaxModel::copy(self : MathapproxminimaxModel) -> MathapproxminimaxModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxModel::fill(self : MathapproxminimaxModel, v : Double) -> MathapproxminimaxModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxModel::min(self : MathapproxminimaxModel) -> Double { @_common.min(self.data) }

pub fn MathapproxminimaxModel::max(self : MathapproxminimaxModel) -> Double { @_common.max(self.data) }

pub fn MathapproxminimaxModel::to_string(self : MathapproxminimaxModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_layer_make(size : Int) -> MathapproxminimaxLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxminimaxLayer::len(self : MathapproxminimaxLayer) -> Int { self.size }

pub fn MathapproxminimaxLayer::get(self : MathapproxminimaxLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxminimaxLayer::set(self : MathapproxminimaxLayer, i : Int, v : Double) -> MathapproxminimaxLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxLayer::sum(self : MathapproxminimaxLayer) -> Double { @_common.sum(self.data) }

pub fn MathapproxminimaxLayer::mean(self : MathapproxminimaxLayer) -> Double { @_common.mean(self.data) }

pub fn MathapproxminimaxLayer::scale(self : MathapproxminimaxLayer, f : Double) -> MathapproxminimaxLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxLayer::add(self : MathapproxminimaxLayer, other : MathapproxminimaxLayer) -> MathapproxminimaxLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxminimaxLayer::copy(self : MathapproxminimaxLayer) -> MathapproxminimaxLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxLayer::fill(self : MathapproxminimaxLayer, v : Double) -> MathapproxminimaxLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxLayer::min(self : MathapproxminimaxLayer) -> Double { @_common.min(self.data) }

pub fn MathapproxminimaxLayer::max(self : MathapproxminimaxLayer) -> Double { @_common.max(self.data) }

pub fn MathapproxminimaxLayer::to_string(self : MathapproxminimaxLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_buffer_make(size : Int) -> MathapproxminimaxBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxminimaxBuffer::len(self : MathapproxminimaxBuffer) -> Int { self.size }

pub fn MathapproxminimaxBuffer::get(self : MathapproxminimaxBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxminimaxBuffer::set(self : MathapproxminimaxBuffer, i : Int, v : Double) -> MathapproxminimaxBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxBuffer::sum(self : MathapproxminimaxBuffer) -> Double { @_common.sum(self.data) }

pub fn MathapproxminimaxBuffer::mean(self : MathapproxminimaxBuffer) -> Double { @_common.mean(self.data) }

pub fn MathapproxminimaxBuffer::scale(self : MathapproxminimaxBuffer, f : Double) -> MathapproxminimaxBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxBuffer::add(self : MathapproxminimaxBuffer, other : MathapproxminimaxBuffer) -> MathapproxminimaxBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxminimaxBuffer::copy(self : MathapproxminimaxBuffer) -> MathapproxminimaxBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxBuffer::fill(self : MathapproxminimaxBuffer, v : Double) -> MathapproxminimaxBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxBuffer::min(self : MathapproxminimaxBuffer) -> Double { @_common.min(self.data) }

pub fn MathapproxminimaxBuffer::max(self : MathapproxminimaxBuffer) -> Double { @_common.max(self.data) }

pub fn MathapproxminimaxBuffer::to_string(self : MathapproxminimaxBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_cursor_make(size : Int) -> MathapproxminimaxCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxminimaxCursor::len(self : MathapproxminimaxCursor) -> Int { self.size }

pub fn MathapproxminimaxCursor::get(self : MathapproxminimaxCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxminimaxCursor::set(self : MathapproxminimaxCursor, i : Int, v : Double) -> MathapproxminimaxCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxCursor::sum(self : MathapproxminimaxCursor) -> Double { @_common.sum(self.data) }

pub fn MathapproxminimaxCursor::mean(self : MathapproxminimaxCursor) -> Double { @_common.mean(self.data) }

pub fn MathapproxminimaxCursor::scale(self : MathapproxminimaxCursor, f : Double) -> MathapproxminimaxCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxCursor::add(self : MathapproxminimaxCursor, other : MathapproxminimaxCursor) -> MathapproxminimaxCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxminimaxCursor::copy(self : MathapproxminimaxCursor) -> MathapproxminimaxCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxCursor::fill(self : MathapproxminimaxCursor, v : Double) -> MathapproxminimaxCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxCursor::min(self : MathapproxminimaxCursor) -> Double { @_common.min(self.data) }

pub fn MathapproxminimaxCursor::max(self : MathapproxminimaxCursor) -> Double { @_common.max(self.data) }

pub fn MathapproxminimaxCursor::to_string(self : MathapproxminimaxCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_view_make(size : Int) -> MathapproxminimaxView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxminimaxView::len(self : MathapproxminimaxView) -> Int { self.size }

pub fn MathapproxminimaxView::get(self : MathapproxminimaxView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxminimaxView::set(self : MathapproxminimaxView, i : Int, v : Double) -> MathapproxminimaxView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxView::sum(self : MathapproxminimaxView) -> Double { @_common.sum(self.data) }

pub fn MathapproxminimaxView::mean(self : MathapproxminimaxView) -> Double { @_common.mean(self.data) }

pub fn MathapproxminimaxView::scale(self : MathapproxminimaxView, f : Double) -> MathapproxminimaxView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxView::add(self : MathapproxminimaxView, other : MathapproxminimaxView) -> MathapproxminimaxView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxminimaxView::copy(self : MathapproxminimaxView) -> MathapproxminimaxView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxView::fill(self : MathapproxminimaxView, v : Double) -> MathapproxminimaxView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxView::min(self : MathapproxminimaxView) -> Double { @_common.min(self.data) }

pub fn MathapproxminimaxView::max(self : MathapproxminimaxView) -> Double { @_common.max(self.data) }

pub fn MathapproxminimaxView::to_string(self : MathapproxminimaxView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_range_make(size : Int) -> MathapproxminimaxRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxminimaxRange::len(self : MathapproxminimaxRange) -> Int { self.size }

pub fn MathapproxminimaxRange::get(self : MathapproxminimaxRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxminimaxRange::set(self : MathapproxminimaxRange, i : Int, v : Double) -> MathapproxminimaxRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxRange::sum(self : MathapproxminimaxRange) -> Double { @_common.sum(self.data) }

pub fn MathapproxminimaxRange::mean(self : MathapproxminimaxRange) -> Double { @_common.mean(self.data) }

pub fn MathapproxminimaxRange::scale(self : MathapproxminimaxRange, f : Double) -> MathapproxminimaxRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxRange::add(self : MathapproxminimaxRange, other : MathapproxminimaxRange) -> MathapproxminimaxRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxminimaxRange::copy(self : MathapproxminimaxRange) -> MathapproxminimaxRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxRange::fill(self : MathapproxminimaxRange, v : Double) -> MathapproxminimaxRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxRange::min(self : MathapproxminimaxRange) -> Double { @_common.min(self.data) }

pub fn MathapproxminimaxRange::max(self : MathapproxminimaxRange) -> Double { @_common.max(self.data) }

pub fn MathapproxminimaxRange::to_string(self : MathapproxminimaxRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxminimaxSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_minimax_slice_make(size : Int) -> MathapproxminimaxSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxminimaxSlice::len(self : MathapproxminimaxSlice) -> Int { self.size }

pub fn MathapproxminimaxSlice::get(self : MathapproxminimaxSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxminimaxSlice::set(self : MathapproxminimaxSlice, i : Int, v : Double) -> MathapproxminimaxSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxSlice::sum(self : MathapproxminimaxSlice) -> Double { @_common.sum(self.data) }

pub fn MathapproxminimaxSlice::mean(self : MathapproxminimaxSlice) -> Double { @_common.mean(self.data) }

pub fn MathapproxminimaxSlice::scale(self : MathapproxminimaxSlice, f : Double) -> MathapproxminimaxSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxSlice::add(self : MathapproxminimaxSlice, other : MathapproxminimaxSlice) -> MathapproxminimaxSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxminimaxSlice::copy(self : MathapproxminimaxSlice) -> MathapproxminimaxSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxSlice::fill(self : MathapproxminimaxSlice, v : Double) -> MathapproxminimaxSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxminimaxSlice::min(self : MathapproxminimaxSlice) -> Double { @_common.min(self.data) }

pub fn MathapproxminimaxSlice::max(self : MathapproxminimaxSlice) -> Double { @_common.max(self.data) }

pub fn MathapproxminimaxSlice::to_string(self : MathapproxminimaxSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

