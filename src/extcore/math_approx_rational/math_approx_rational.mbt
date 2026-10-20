///===
/// extcore/math_approx_rational

pub(all) struct MathapproxrationalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_rational_make_point(x : Double, y : Double) -> MathapproxrationalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_rational_make_point3(x : Double, y : Double, z : Double) -> MathapproxrationalPoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxrationalPoint::x(self : MathapproxrationalPoint) -> Double { self.x }

pub fn MathapproxrationalPoint::y(self : MathapproxrationalPoint) -> Double { self.y }

pub fn MathapproxrationalPoint::z(self : MathapproxrationalPoint) -> Double { self.z }

pub fn MathapproxrationalPoint::label(self : MathapproxrationalPoint) -> Int { self.label }

pub fn MathapproxrationalPoint::dist(self : MathapproxrationalPoint, other : MathapproxrationalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxrationalPoint::add(self : MathapproxrationalPoint, other : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxrationalPoint::sub(self : MathapproxrationalPoint, other : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxrationalPoint::scale(self : MathapproxrationalPoint, s : Double) -> MathapproxrationalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxrationalPoint::dot(self : MathapproxrationalPoint, other : MathapproxrationalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxrationalPoint::cross(self : MathapproxrationalPoint, other : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxrationalPoint::norm(self : MathapproxrationalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxrationalPoint::normalize(self : MathapproxrationalPoint) -> MathapproxrationalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxrationalPoint::negate(self : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxrationalPoint::mid(self : MathapproxrationalPoint, other : MathapproxrationalPoint) -> MathapproxrationalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxrationalPoint::lerp(self : MathapproxrationalPoint, other : MathapproxrationalPoint, t : Double) -> MathapproxrationalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxrationalPoint::to_string(self : MathapproxrationalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxrationalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_rational_make_series(vals : Array[Double], name : String) -> MathapproxrationalSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxrationalSeries::len(self : MathapproxrationalSeries) -> Int { self.vals.length() }

pub fn MathapproxrationalSeries::sum(self : MathapproxrationalSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxrationalSeries::mean(self : MathapproxrationalSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxrationalSeries::min(self : MathapproxrationalSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxrationalSeries::max(self : MathapproxrationalSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxrationalSeries::range(self : MathapproxrationalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxrationalSeries::variance(self : MathapproxrationalSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxrationalSeries::std(self : MathapproxrationalSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxrationalSeries::median(self : MathapproxrationalSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxrationalSeries::scale(self : MathapproxrationalSeries, f : Double) -> MathapproxrationalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxrationalSeries::add(self : MathapproxrationalSeries, other : MathapproxrationalSeries) -> MathapproxrationalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxrationalSeries::sub(self : MathapproxrationalSeries, other : MathapproxrationalSeries) -> MathapproxrationalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxrationalSeries::normalize(self : MathapproxrationalSeries) -> MathapproxrationalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxrationalSeries::cumsum(self : MathapproxrationalSeries) -> MathapproxrationalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxrationalSeries::to_string(self : MathapproxrationalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxrationalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_rational_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxrationalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_rational_matrix_identity(n : Int) -> MathapproxrationalMatrix {
  let m = math_approx_rational_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxrationalMatrix::get(self : MathapproxrationalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxrationalMatrix::transpose(self : MathapproxrationalMatrix) -> MathapproxrationalMatrix {
  let result = math_approx_rational_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxrationalMatrix::add(self : MathapproxrationalMatrix, other : MathapproxrationalMatrix) -> MathapproxrationalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_rational_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxrationalMatrix::scale(self : MathapproxrationalMatrix, s : Double) -> MathapproxrationalMatrix {
  let result = math_approx_rational_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxrationalMatrix::multiply(self : MathapproxrationalMatrix, other : MathapproxrationalMatrix) -> MathapproxrationalMatrix {
  if self.cols != other.rows { return math_approx_rational_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_rational_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathapproxrationalMatrix::trace(self : MathapproxrationalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxrationalMatrix::det(self : MathapproxrationalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxrationalMatrix::norm(self : MathapproxrationalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxrationalMatrix::to_string(self : MathapproxrationalMatrix) -> String {
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

pub(all) struct MathapproxrationalVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_rational_make_vector(comps : Array[Double]) -> MathapproxrationalVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_rational_vector_zero(dim : Int) -> MathapproxrationalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxrationalVector::add(self : MathapproxrationalVector, other : MathapproxrationalVector) -> MathapproxrationalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxrationalVector::sub(self : MathapproxrationalVector, other : MathapproxrationalVector) -> MathapproxrationalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxrationalVector::scale(self : MathapproxrationalVector, s : Double) -> MathapproxrationalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxrationalVector::dot(self : MathapproxrationalVector, other : MathapproxrationalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxrationalVector::norm(self : MathapproxrationalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxrationalVector::normalize(self : MathapproxrationalVector) -> MathapproxrationalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxrationalVector::dist(self : MathapproxrationalVector, other : MathapproxrationalVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxrationalVector::to_string(self : MathapproxrationalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_rational_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_rational_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_rational_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_rational_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_rational_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_rational_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_rational_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_rational_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_rational_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_rational_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_rational_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_rational_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_rational_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_rational_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_rational_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_rational_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_rational_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_rational_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_rational_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_rational_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_rational_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_rational_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_rational_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_rational_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_rational_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_rational_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_rational_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_rational_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_rational_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxrationalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_frame_make(size : Int) -> MathapproxrationalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxrationalFrame::len(self : MathapproxrationalFrame) -> Int { self.size }

pub fn MathapproxrationalFrame::get(self : MathapproxrationalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxrationalFrame::set(self : MathapproxrationalFrame, i : Int, v : Double) -> MathapproxrationalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxrationalFrame::sum(self : MathapproxrationalFrame) -> Double { @_common.sum(self.data) }

pub fn MathapproxrationalFrame::mean(self : MathapproxrationalFrame) -> Double { @_common.mean(self.data) }

pub fn MathapproxrationalFrame::scale(self : MathapproxrationalFrame, f : Double) -> MathapproxrationalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalFrame::add(self : MathapproxrationalFrame, other : MathapproxrationalFrame) -> MathapproxrationalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxrationalFrame::copy(self : MathapproxrationalFrame) -> MathapproxrationalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalFrame::fill(self : MathapproxrationalFrame, v : Double) -> MathapproxrationalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalFrame::min(self : MathapproxrationalFrame) -> Double { @_common.min(self.data) }

pub fn MathapproxrationalFrame::max(self : MathapproxrationalFrame) -> Double { @_common.max(self.data) }

pub fn MathapproxrationalFrame::to_string(self : MathapproxrationalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_table_make(size : Int) -> MathapproxrationalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxrationalTable::len(self : MathapproxrationalTable) -> Int { self.size }

pub fn MathapproxrationalTable::get(self : MathapproxrationalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxrationalTable::set(self : MathapproxrationalTable, i : Int, v : Double) -> MathapproxrationalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxrationalTable::sum(self : MathapproxrationalTable) -> Double { @_common.sum(self.data) }

pub fn MathapproxrationalTable::mean(self : MathapproxrationalTable) -> Double { @_common.mean(self.data) }

pub fn MathapproxrationalTable::scale(self : MathapproxrationalTable, f : Double) -> MathapproxrationalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalTable::add(self : MathapproxrationalTable, other : MathapproxrationalTable) -> MathapproxrationalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxrationalTable::copy(self : MathapproxrationalTable) -> MathapproxrationalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalTable::fill(self : MathapproxrationalTable, v : Double) -> MathapproxrationalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalTable::min(self : MathapproxrationalTable) -> Double { @_common.min(self.data) }

pub fn MathapproxrationalTable::max(self : MathapproxrationalTable) -> Double { @_common.max(self.data) }

pub fn MathapproxrationalTable::to_string(self : MathapproxrationalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_graphn_make(size : Int) -> MathapproxrationalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxrationalGraphN::len(self : MathapproxrationalGraphN) -> Int { self.size }

pub fn MathapproxrationalGraphN::get(self : MathapproxrationalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxrationalGraphN::set(self : MathapproxrationalGraphN, i : Int, v : Double) -> MathapproxrationalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxrationalGraphN::sum(self : MathapproxrationalGraphN) -> Double { @_common.sum(self.data) }

pub fn MathapproxrationalGraphN::mean(self : MathapproxrationalGraphN) -> Double { @_common.mean(self.data) }

pub fn MathapproxrationalGraphN::scale(self : MathapproxrationalGraphN, f : Double) -> MathapproxrationalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalGraphN::add(self : MathapproxrationalGraphN, other : MathapproxrationalGraphN) -> MathapproxrationalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxrationalGraphN::copy(self : MathapproxrationalGraphN) -> MathapproxrationalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalGraphN::fill(self : MathapproxrationalGraphN, v : Double) -> MathapproxrationalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalGraphN::min(self : MathapproxrationalGraphN) -> Double { @_common.min(self.data) }

pub fn MathapproxrationalGraphN::max(self : MathapproxrationalGraphN) -> Double { @_common.max(self.data) }

pub fn MathapproxrationalGraphN::to_string(self : MathapproxrationalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_node_make(size : Int) -> MathapproxrationalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxrationalNode::len(self : MathapproxrationalNode) -> Int { self.size }

pub fn MathapproxrationalNode::get(self : MathapproxrationalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxrationalNode::set(self : MathapproxrationalNode, i : Int, v : Double) -> MathapproxrationalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxrationalNode::sum(self : MathapproxrationalNode) -> Double { @_common.sum(self.data) }

pub fn MathapproxrationalNode::mean(self : MathapproxrationalNode) -> Double { @_common.mean(self.data) }

pub fn MathapproxrationalNode::scale(self : MathapproxrationalNode, f : Double) -> MathapproxrationalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalNode::add(self : MathapproxrationalNode, other : MathapproxrationalNode) -> MathapproxrationalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxrationalNode::copy(self : MathapproxrationalNode) -> MathapproxrationalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalNode::fill(self : MathapproxrationalNode, v : Double) -> MathapproxrationalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalNode::min(self : MathapproxrationalNode) -> Double { @_common.min(self.data) }

pub fn MathapproxrationalNode::max(self : MathapproxrationalNode) -> Double { @_common.max(self.data) }

pub fn MathapproxrationalNode::to_string(self : MathapproxrationalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_edge_make(size : Int) -> MathapproxrationalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxrationalEdge::len(self : MathapproxrationalEdge) -> Int { self.size }

pub fn MathapproxrationalEdge::get(self : MathapproxrationalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxrationalEdge::set(self : MathapproxrationalEdge, i : Int, v : Double) -> MathapproxrationalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxrationalEdge::sum(self : MathapproxrationalEdge) -> Double { @_common.sum(self.data) }

pub fn MathapproxrationalEdge::mean(self : MathapproxrationalEdge) -> Double { @_common.mean(self.data) }

pub fn MathapproxrationalEdge::scale(self : MathapproxrationalEdge, f : Double) -> MathapproxrationalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalEdge::add(self : MathapproxrationalEdge, other : MathapproxrationalEdge) -> MathapproxrationalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxrationalEdge::copy(self : MathapproxrationalEdge) -> MathapproxrationalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalEdge::fill(self : MathapproxrationalEdge, v : Double) -> MathapproxrationalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalEdge::min(self : MathapproxrationalEdge) -> Double { @_common.min(self.data) }

pub fn MathapproxrationalEdge::max(self : MathapproxrationalEdge) -> Double { @_common.max(self.data) }

pub fn MathapproxrationalEdge::to_string(self : MathapproxrationalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_path_make(size : Int) -> MathapproxrationalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxrationalPath::len(self : MathapproxrationalPath) -> Int { self.size }

pub fn MathapproxrationalPath::get(self : MathapproxrationalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxrationalPath::set(self : MathapproxrationalPath, i : Int, v : Double) -> MathapproxrationalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxrationalPath::sum(self : MathapproxrationalPath) -> Double { @_common.sum(self.data) }

pub fn MathapproxrationalPath::mean(self : MathapproxrationalPath) -> Double { @_common.mean(self.data) }

pub fn MathapproxrationalPath::scale(self : MathapproxrationalPath, f : Double) -> MathapproxrationalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalPath::add(self : MathapproxrationalPath, other : MathapproxrationalPath) -> MathapproxrationalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxrationalPath::copy(self : MathapproxrationalPath) -> MathapproxrationalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalPath::fill(self : MathapproxrationalPath, v : Double) -> MathapproxrationalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalPath::min(self : MathapproxrationalPath) -> Double { @_common.min(self.data) }

pub fn MathapproxrationalPath::max(self : MathapproxrationalPath) -> Double { @_common.max(self.data) }

pub fn MathapproxrationalPath::to_string(self : MathapproxrationalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_cluster_make(size : Int) -> MathapproxrationalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxrationalCluster::len(self : MathapproxrationalCluster) -> Int { self.size }

pub fn MathapproxrationalCluster::get(self : MathapproxrationalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxrationalCluster::set(self : MathapproxrationalCluster, i : Int, v : Double) -> MathapproxrationalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxrationalCluster::sum(self : MathapproxrationalCluster) -> Double { @_common.sum(self.data) }

pub fn MathapproxrationalCluster::mean(self : MathapproxrationalCluster) -> Double { @_common.mean(self.data) }

pub fn MathapproxrationalCluster::scale(self : MathapproxrationalCluster, f : Double) -> MathapproxrationalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalCluster::add(self : MathapproxrationalCluster, other : MathapproxrationalCluster) -> MathapproxrationalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxrationalCluster::copy(self : MathapproxrationalCluster) -> MathapproxrationalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalCluster::fill(self : MathapproxrationalCluster, v : Double) -> MathapproxrationalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalCluster::min(self : MathapproxrationalCluster) -> Double { @_common.min(self.data) }

pub fn MathapproxrationalCluster::max(self : MathapproxrationalCluster) -> Double { @_common.max(self.data) }

pub fn MathapproxrationalCluster::to_string(self : MathapproxrationalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_model_make(size : Int) -> MathapproxrationalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxrationalModel::len(self : MathapproxrationalModel) -> Int { self.size }

pub fn MathapproxrationalModel::get(self : MathapproxrationalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxrationalModel::set(self : MathapproxrationalModel, i : Int, v : Double) -> MathapproxrationalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxrationalModel::sum(self : MathapproxrationalModel) -> Double { @_common.sum(self.data) }

pub fn MathapproxrationalModel::mean(self : MathapproxrationalModel) -> Double { @_common.mean(self.data) }

pub fn MathapproxrationalModel::scale(self : MathapproxrationalModel, f : Double) -> MathapproxrationalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalModel::add(self : MathapproxrationalModel, other : MathapproxrationalModel) -> MathapproxrationalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxrationalModel::copy(self : MathapproxrationalModel) -> MathapproxrationalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalModel::fill(self : MathapproxrationalModel, v : Double) -> MathapproxrationalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalModel::min(self : MathapproxrationalModel) -> Double { @_common.min(self.data) }

pub fn MathapproxrationalModel::max(self : MathapproxrationalModel) -> Double { @_common.max(self.data) }

pub fn MathapproxrationalModel::to_string(self : MathapproxrationalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_layer_make(size : Int) -> MathapproxrationalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxrationalLayer::len(self : MathapproxrationalLayer) -> Int { self.size }

pub fn MathapproxrationalLayer::get(self : MathapproxrationalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxrationalLayer::set(self : MathapproxrationalLayer, i : Int, v : Double) -> MathapproxrationalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxrationalLayer::sum(self : MathapproxrationalLayer) -> Double { @_common.sum(self.data) }

pub fn MathapproxrationalLayer::mean(self : MathapproxrationalLayer) -> Double { @_common.mean(self.data) }

pub fn MathapproxrationalLayer::scale(self : MathapproxrationalLayer, f : Double) -> MathapproxrationalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalLayer::add(self : MathapproxrationalLayer, other : MathapproxrationalLayer) -> MathapproxrationalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxrationalLayer::copy(self : MathapproxrationalLayer) -> MathapproxrationalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalLayer::fill(self : MathapproxrationalLayer, v : Double) -> MathapproxrationalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalLayer::min(self : MathapproxrationalLayer) -> Double { @_common.min(self.data) }

pub fn MathapproxrationalLayer::max(self : MathapproxrationalLayer) -> Double { @_common.max(self.data) }

pub fn MathapproxrationalLayer::to_string(self : MathapproxrationalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_buffer_make(size : Int) -> MathapproxrationalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxrationalBuffer::len(self : MathapproxrationalBuffer) -> Int { self.size }

pub fn MathapproxrationalBuffer::get(self : MathapproxrationalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxrationalBuffer::set(self : MathapproxrationalBuffer, i : Int, v : Double) -> MathapproxrationalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxrationalBuffer::sum(self : MathapproxrationalBuffer) -> Double { @_common.sum(self.data) }

pub fn MathapproxrationalBuffer::mean(self : MathapproxrationalBuffer) -> Double { @_common.mean(self.data) }

pub fn MathapproxrationalBuffer::scale(self : MathapproxrationalBuffer, f : Double) -> MathapproxrationalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalBuffer::add(self : MathapproxrationalBuffer, other : MathapproxrationalBuffer) -> MathapproxrationalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxrationalBuffer::copy(self : MathapproxrationalBuffer) -> MathapproxrationalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalBuffer::fill(self : MathapproxrationalBuffer, v : Double) -> MathapproxrationalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalBuffer::min(self : MathapproxrationalBuffer) -> Double { @_common.min(self.data) }

pub fn MathapproxrationalBuffer::max(self : MathapproxrationalBuffer) -> Double { @_common.max(self.data) }

pub fn MathapproxrationalBuffer::to_string(self : MathapproxrationalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_cursor_make(size : Int) -> MathapproxrationalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxrationalCursor::len(self : MathapproxrationalCursor) -> Int { self.size }

pub fn MathapproxrationalCursor::get(self : MathapproxrationalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxrationalCursor::set(self : MathapproxrationalCursor, i : Int, v : Double) -> MathapproxrationalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxrationalCursor::sum(self : MathapproxrationalCursor) -> Double { @_common.sum(self.data) }

pub fn MathapproxrationalCursor::mean(self : MathapproxrationalCursor) -> Double { @_common.mean(self.data) }

pub fn MathapproxrationalCursor::scale(self : MathapproxrationalCursor, f : Double) -> MathapproxrationalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalCursor::add(self : MathapproxrationalCursor, other : MathapproxrationalCursor) -> MathapproxrationalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxrationalCursor::copy(self : MathapproxrationalCursor) -> MathapproxrationalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalCursor::fill(self : MathapproxrationalCursor, v : Double) -> MathapproxrationalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalCursor::min(self : MathapproxrationalCursor) -> Double { @_common.min(self.data) }

pub fn MathapproxrationalCursor::max(self : MathapproxrationalCursor) -> Double { @_common.max(self.data) }

pub fn MathapproxrationalCursor::to_string(self : MathapproxrationalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_view_make(size : Int) -> MathapproxrationalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxrationalView::len(self : MathapproxrationalView) -> Int { self.size }

pub fn MathapproxrationalView::get(self : MathapproxrationalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxrationalView::set(self : MathapproxrationalView, i : Int, v : Double) -> MathapproxrationalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxrationalView::sum(self : MathapproxrationalView) -> Double { @_common.sum(self.data) }

pub fn MathapproxrationalView::mean(self : MathapproxrationalView) -> Double { @_common.mean(self.data) }

pub fn MathapproxrationalView::scale(self : MathapproxrationalView, f : Double) -> MathapproxrationalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalView::add(self : MathapproxrationalView, other : MathapproxrationalView) -> MathapproxrationalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxrationalView::copy(self : MathapproxrationalView) -> MathapproxrationalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalView::fill(self : MathapproxrationalView, v : Double) -> MathapproxrationalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalView::min(self : MathapproxrationalView) -> Double { @_common.min(self.data) }

pub fn MathapproxrationalView::max(self : MathapproxrationalView) -> Double { @_common.max(self.data) }

pub fn MathapproxrationalView::to_string(self : MathapproxrationalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_range_make(size : Int) -> MathapproxrationalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxrationalRange::len(self : MathapproxrationalRange) -> Int { self.size }

pub fn MathapproxrationalRange::get(self : MathapproxrationalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxrationalRange::set(self : MathapproxrationalRange, i : Int, v : Double) -> MathapproxrationalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxrationalRange::sum(self : MathapproxrationalRange) -> Double { @_common.sum(self.data) }

pub fn MathapproxrationalRange::mean(self : MathapproxrationalRange) -> Double { @_common.mean(self.data) }

pub fn MathapproxrationalRange::scale(self : MathapproxrationalRange, f : Double) -> MathapproxrationalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalRange::add(self : MathapproxrationalRange, other : MathapproxrationalRange) -> MathapproxrationalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxrationalRange::copy(self : MathapproxrationalRange) -> MathapproxrationalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalRange::fill(self : MathapproxrationalRange, v : Double) -> MathapproxrationalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalRange::min(self : MathapproxrationalRange) -> Double { @_common.min(self.data) }

pub fn MathapproxrationalRange::max(self : MathapproxrationalRange) -> Double { @_common.max(self.data) }

pub fn MathapproxrationalRange::to_string(self : MathapproxrationalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxrationalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_rational_slice_make(size : Int) -> MathapproxrationalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxrationalSlice::len(self : MathapproxrationalSlice) -> Int { self.size }

pub fn MathapproxrationalSlice::get(self : MathapproxrationalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxrationalSlice::set(self : MathapproxrationalSlice, i : Int, v : Double) -> MathapproxrationalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxrationalSlice::sum(self : MathapproxrationalSlice) -> Double { @_common.sum(self.data) }

pub fn MathapproxrationalSlice::mean(self : MathapproxrationalSlice) -> Double { @_common.mean(self.data) }

pub fn MathapproxrationalSlice::scale(self : MathapproxrationalSlice, f : Double) -> MathapproxrationalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalSlice::add(self : MathapproxrationalSlice, other : MathapproxrationalSlice) -> MathapproxrationalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxrationalSlice::copy(self : MathapproxrationalSlice) -> MathapproxrationalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalSlice::fill(self : MathapproxrationalSlice, v : Double) -> MathapproxrationalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxrationalSlice::min(self : MathapproxrationalSlice) -> Double { @_common.min(self.data) }

pub fn MathapproxrationalSlice::max(self : MathapproxrationalSlice) -> Double { @_common.max(self.data) }

pub fn MathapproxrationalSlice::to_string(self : MathapproxrationalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

