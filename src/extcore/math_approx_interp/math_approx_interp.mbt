///===
/// extcore/math_approx_interp

pub(all) struct MathapproxinterpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_approx_interp_make_point(x : Double, y : Double) -> MathapproxinterpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_approx_interp_make_point3(x : Double, y : Double, z : Double) -> MathapproxinterpPoint {
  { x, y, z, label: 0 }
}

pub fn MathapproxinterpPoint::x(self : MathapproxinterpPoint) -> Double { self.x }

pub fn MathapproxinterpPoint::y(self : MathapproxinterpPoint) -> Double { self.y }

pub fn MathapproxinterpPoint::z(self : MathapproxinterpPoint) -> Double { self.z }

pub fn MathapproxinterpPoint::label(self : MathapproxinterpPoint) -> Int { self.label }

pub fn MathapproxinterpPoint::dist(self : MathapproxinterpPoint, other : MathapproxinterpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathapproxinterpPoint::add(self : MathapproxinterpPoint, other : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathapproxinterpPoint::sub(self : MathapproxinterpPoint, other : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathapproxinterpPoint::scale(self : MathapproxinterpPoint, s : Double) -> MathapproxinterpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathapproxinterpPoint::dot(self : MathapproxinterpPoint, other : MathapproxinterpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathapproxinterpPoint::cross(self : MathapproxinterpPoint, other : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathapproxinterpPoint::norm(self : MathapproxinterpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathapproxinterpPoint::normalize(self : MathapproxinterpPoint) -> MathapproxinterpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxinterpPoint::negate(self : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathapproxinterpPoint::mid(self : MathapproxinterpPoint, other : MathapproxinterpPoint) -> MathapproxinterpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathapproxinterpPoint::lerp(self : MathapproxinterpPoint, other : MathapproxinterpPoint, t : Double) -> MathapproxinterpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathapproxinterpPoint::to_string(self : MathapproxinterpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathapproxinterpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_approx_interp_make_series(vals : Array[Double], name : String) -> MathapproxinterpSeries {
  { vals, name, meta: 0 }
}

pub fn MathapproxinterpSeries::len(self : MathapproxinterpSeries) -> Int { self.vals.length() }

pub fn MathapproxinterpSeries::sum(self : MathapproxinterpSeries) -> Double { @_common.sum(self.vals) }

pub fn MathapproxinterpSeries::mean(self : MathapproxinterpSeries) -> Double { @_common.mean(self.vals) }

pub fn MathapproxinterpSeries::min(self : MathapproxinterpSeries) -> Double { @_common.min(self.vals) }

pub fn MathapproxinterpSeries::max(self : MathapproxinterpSeries) -> Double { @_common.max(self.vals) }

pub fn MathapproxinterpSeries::range(self : MathapproxinterpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathapproxinterpSeries::variance(self : MathapproxinterpSeries) -> Double { @_common.variance(self.vals) }

pub fn MathapproxinterpSeries::std(self : MathapproxinterpSeries) -> Double { @_common.std(self.vals) }

pub fn MathapproxinterpSeries::median(self : MathapproxinterpSeries) -> Double { @_common.median(self.vals) }

pub fn MathapproxinterpSeries::scale(self : MathapproxinterpSeries, f : Double) -> MathapproxinterpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathapproxinterpSeries::add(self : MathapproxinterpSeries, other : MathapproxinterpSeries) -> MathapproxinterpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathapproxinterpSeries::sub(self : MathapproxinterpSeries, other : MathapproxinterpSeries) -> MathapproxinterpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathapproxinterpSeries::normalize(self : MathapproxinterpSeries) -> MathapproxinterpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathapproxinterpSeries::cumsum(self : MathapproxinterpSeries) -> MathapproxinterpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathapproxinterpSeries::to_string(self : MathapproxinterpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathapproxinterpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_approx_interp_make_matrix(rows : Int, cols : Int, val : Double) -> MathapproxinterpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_approx_interp_matrix_identity(n : Int) -> MathapproxinterpMatrix {
  let m = math_approx_interp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathapproxinterpMatrix::get(self : MathapproxinterpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathapproxinterpMatrix::transpose(self : MathapproxinterpMatrix) -> MathapproxinterpMatrix {
  let result = math_approx_interp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathapproxinterpMatrix::add(self : MathapproxinterpMatrix, other : MathapproxinterpMatrix) -> MathapproxinterpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_approx_interp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathapproxinterpMatrix::scale(self : MathapproxinterpMatrix, s : Double) -> MathapproxinterpMatrix {
  let result = math_approx_interp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathapproxinterpMatrix::multiply(self : MathapproxinterpMatrix, other : MathapproxinterpMatrix) -> MathapproxinterpMatrix {
  if self.cols != other.rows { return math_approx_interp_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_approx_interp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathapproxinterpMatrix::trace(self : MathapproxinterpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathapproxinterpMatrix::det(self : MathapproxinterpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathapproxinterpMatrix::norm(self : MathapproxinterpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathapproxinterpMatrix::to_string(self : MathapproxinterpMatrix) -> String {
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

pub(all) struct MathapproxinterpVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_approx_interp_make_vector(comps : Array[Double]) -> MathapproxinterpVector {
  { comps, dim: comps.length() }
}

pub fn math_approx_interp_vector_zero(dim : Int) -> MathapproxinterpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathapproxinterpVector::add(self : MathapproxinterpVector, other : MathapproxinterpVector) -> MathapproxinterpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxinterpVector::sub(self : MathapproxinterpVector, other : MathapproxinterpVector) -> MathapproxinterpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathapproxinterpVector::scale(self : MathapproxinterpVector, s : Double) -> MathapproxinterpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathapproxinterpVector::dot(self : MathapproxinterpVector, other : MathapproxinterpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathapproxinterpVector::norm(self : MathapproxinterpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathapproxinterpVector::normalize(self : MathapproxinterpVector) -> MathapproxinterpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathapproxinterpVector::dist(self : MathapproxinterpVector, other : MathapproxinterpVector) -> Double {
  self.sub(other).norm()
}

pub fn MathapproxinterpVector::to_string(self : MathapproxinterpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_approx_interp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_approx_interp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_approx_interp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_approx_interp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_approx_interp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_approx_interp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_approx_interp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_approx_interp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_approx_interp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_approx_interp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_approx_interp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_approx_interp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_approx_interp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_approx_interp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_approx_interp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_approx_interp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_approx_interp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_approx_interp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_approx_interp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_approx_interp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_approx_interp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_approx_interp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_approx_interp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_approx_interp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_approx_interp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_approx_interp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_approx_interp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_approx_interp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_approx_interp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathapproxinterpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_frame_make(size : Int) -> MathapproxinterpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxinterpFrame::len(self : MathapproxinterpFrame) -> Int { self.size }

pub fn MathapproxinterpFrame::get(self : MathapproxinterpFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxinterpFrame::set(self : MathapproxinterpFrame, i : Int, v : Double) -> MathapproxinterpFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxinterpFrame::sum(self : MathapproxinterpFrame) -> Double { @_common.sum(self.data) }

pub fn MathapproxinterpFrame::mean(self : MathapproxinterpFrame) -> Double { @_common.mean(self.data) }

pub fn MathapproxinterpFrame::scale(self : MathapproxinterpFrame, f : Double) -> MathapproxinterpFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpFrame::add(self : MathapproxinterpFrame, other : MathapproxinterpFrame) -> MathapproxinterpFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxinterpFrame::copy(self : MathapproxinterpFrame) -> MathapproxinterpFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpFrame::fill(self : MathapproxinterpFrame, v : Double) -> MathapproxinterpFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpFrame::min(self : MathapproxinterpFrame) -> Double { @_common.min(self.data) }

pub fn MathapproxinterpFrame::max(self : MathapproxinterpFrame) -> Double { @_common.max(self.data) }

pub fn MathapproxinterpFrame::to_string(self : MathapproxinterpFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_table_make(size : Int) -> MathapproxinterpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxinterpTable::len(self : MathapproxinterpTable) -> Int { self.size }

pub fn MathapproxinterpTable::get(self : MathapproxinterpTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxinterpTable::set(self : MathapproxinterpTable, i : Int, v : Double) -> MathapproxinterpTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxinterpTable::sum(self : MathapproxinterpTable) -> Double { @_common.sum(self.data) }

pub fn MathapproxinterpTable::mean(self : MathapproxinterpTable) -> Double { @_common.mean(self.data) }

pub fn MathapproxinterpTable::scale(self : MathapproxinterpTable, f : Double) -> MathapproxinterpTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpTable::add(self : MathapproxinterpTable, other : MathapproxinterpTable) -> MathapproxinterpTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxinterpTable::copy(self : MathapproxinterpTable) -> MathapproxinterpTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpTable::fill(self : MathapproxinterpTable, v : Double) -> MathapproxinterpTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpTable::min(self : MathapproxinterpTable) -> Double { @_common.min(self.data) }

pub fn MathapproxinterpTable::max(self : MathapproxinterpTable) -> Double { @_common.max(self.data) }

pub fn MathapproxinterpTable::to_string(self : MathapproxinterpTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_graphn_make(size : Int) -> MathapproxinterpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxinterpGraphN::len(self : MathapproxinterpGraphN) -> Int { self.size }

pub fn MathapproxinterpGraphN::get(self : MathapproxinterpGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxinterpGraphN::set(self : MathapproxinterpGraphN, i : Int, v : Double) -> MathapproxinterpGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxinterpGraphN::sum(self : MathapproxinterpGraphN) -> Double { @_common.sum(self.data) }

pub fn MathapproxinterpGraphN::mean(self : MathapproxinterpGraphN) -> Double { @_common.mean(self.data) }

pub fn MathapproxinterpGraphN::scale(self : MathapproxinterpGraphN, f : Double) -> MathapproxinterpGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpGraphN::add(self : MathapproxinterpGraphN, other : MathapproxinterpGraphN) -> MathapproxinterpGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxinterpGraphN::copy(self : MathapproxinterpGraphN) -> MathapproxinterpGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpGraphN::fill(self : MathapproxinterpGraphN, v : Double) -> MathapproxinterpGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpGraphN::min(self : MathapproxinterpGraphN) -> Double { @_common.min(self.data) }

pub fn MathapproxinterpGraphN::max(self : MathapproxinterpGraphN) -> Double { @_common.max(self.data) }

pub fn MathapproxinterpGraphN::to_string(self : MathapproxinterpGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_node_make(size : Int) -> MathapproxinterpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxinterpNode::len(self : MathapproxinterpNode) -> Int { self.size }

pub fn MathapproxinterpNode::get(self : MathapproxinterpNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxinterpNode::set(self : MathapproxinterpNode, i : Int, v : Double) -> MathapproxinterpNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxinterpNode::sum(self : MathapproxinterpNode) -> Double { @_common.sum(self.data) }

pub fn MathapproxinterpNode::mean(self : MathapproxinterpNode) -> Double { @_common.mean(self.data) }

pub fn MathapproxinterpNode::scale(self : MathapproxinterpNode, f : Double) -> MathapproxinterpNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpNode::add(self : MathapproxinterpNode, other : MathapproxinterpNode) -> MathapproxinterpNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxinterpNode::copy(self : MathapproxinterpNode) -> MathapproxinterpNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpNode::fill(self : MathapproxinterpNode, v : Double) -> MathapproxinterpNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpNode::min(self : MathapproxinterpNode) -> Double { @_common.min(self.data) }

pub fn MathapproxinterpNode::max(self : MathapproxinterpNode) -> Double { @_common.max(self.data) }

pub fn MathapproxinterpNode::to_string(self : MathapproxinterpNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_edge_make(size : Int) -> MathapproxinterpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxinterpEdge::len(self : MathapproxinterpEdge) -> Int { self.size }

pub fn MathapproxinterpEdge::get(self : MathapproxinterpEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxinterpEdge::set(self : MathapproxinterpEdge, i : Int, v : Double) -> MathapproxinterpEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxinterpEdge::sum(self : MathapproxinterpEdge) -> Double { @_common.sum(self.data) }

pub fn MathapproxinterpEdge::mean(self : MathapproxinterpEdge) -> Double { @_common.mean(self.data) }

pub fn MathapproxinterpEdge::scale(self : MathapproxinterpEdge, f : Double) -> MathapproxinterpEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpEdge::add(self : MathapproxinterpEdge, other : MathapproxinterpEdge) -> MathapproxinterpEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxinterpEdge::copy(self : MathapproxinterpEdge) -> MathapproxinterpEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpEdge::fill(self : MathapproxinterpEdge, v : Double) -> MathapproxinterpEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpEdge::min(self : MathapproxinterpEdge) -> Double { @_common.min(self.data) }

pub fn MathapproxinterpEdge::max(self : MathapproxinterpEdge) -> Double { @_common.max(self.data) }

pub fn MathapproxinterpEdge::to_string(self : MathapproxinterpEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_path_make(size : Int) -> MathapproxinterpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxinterpPath::len(self : MathapproxinterpPath) -> Int { self.size }

pub fn MathapproxinterpPath::get(self : MathapproxinterpPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxinterpPath::set(self : MathapproxinterpPath, i : Int, v : Double) -> MathapproxinterpPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxinterpPath::sum(self : MathapproxinterpPath) -> Double { @_common.sum(self.data) }

pub fn MathapproxinterpPath::mean(self : MathapproxinterpPath) -> Double { @_common.mean(self.data) }

pub fn MathapproxinterpPath::scale(self : MathapproxinterpPath, f : Double) -> MathapproxinterpPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpPath::add(self : MathapproxinterpPath, other : MathapproxinterpPath) -> MathapproxinterpPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxinterpPath::copy(self : MathapproxinterpPath) -> MathapproxinterpPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpPath::fill(self : MathapproxinterpPath, v : Double) -> MathapproxinterpPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpPath::min(self : MathapproxinterpPath) -> Double { @_common.min(self.data) }

pub fn MathapproxinterpPath::max(self : MathapproxinterpPath) -> Double { @_common.max(self.data) }

pub fn MathapproxinterpPath::to_string(self : MathapproxinterpPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_cluster_make(size : Int) -> MathapproxinterpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxinterpCluster::len(self : MathapproxinterpCluster) -> Int { self.size }

pub fn MathapproxinterpCluster::get(self : MathapproxinterpCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxinterpCluster::set(self : MathapproxinterpCluster, i : Int, v : Double) -> MathapproxinterpCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxinterpCluster::sum(self : MathapproxinterpCluster) -> Double { @_common.sum(self.data) }

pub fn MathapproxinterpCluster::mean(self : MathapproxinterpCluster) -> Double { @_common.mean(self.data) }

pub fn MathapproxinterpCluster::scale(self : MathapproxinterpCluster, f : Double) -> MathapproxinterpCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpCluster::add(self : MathapproxinterpCluster, other : MathapproxinterpCluster) -> MathapproxinterpCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxinterpCluster::copy(self : MathapproxinterpCluster) -> MathapproxinterpCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpCluster::fill(self : MathapproxinterpCluster, v : Double) -> MathapproxinterpCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpCluster::min(self : MathapproxinterpCluster) -> Double { @_common.min(self.data) }

pub fn MathapproxinterpCluster::max(self : MathapproxinterpCluster) -> Double { @_common.max(self.data) }

pub fn MathapproxinterpCluster::to_string(self : MathapproxinterpCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_model_make(size : Int) -> MathapproxinterpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxinterpModel::len(self : MathapproxinterpModel) -> Int { self.size }

pub fn MathapproxinterpModel::get(self : MathapproxinterpModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxinterpModel::set(self : MathapproxinterpModel, i : Int, v : Double) -> MathapproxinterpModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxinterpModel::sum(self : MathapproxinterpModel) -> Double { @_common.sum(self.data) }

pub fn MathapproxinterpModel::mean(self : MathapproxinterpModel) -> Double { @_common.mean(self.data) }

pub fn MathapproxinterpModel::scale(self : MathapproxinterpModel, f : Double) -> MathapproxinterpModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpModel::add(self : MathapproxinterpModel, other : MathapproxinterpModel) -> MathapproxinterpModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxinterpModel::copy(self : MathapproxinterpModel) -> MathapproxinterpModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpModel::fill(self : MathapproxinterpModel, v : Double) -> MathapproxinterpModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpModel::min(self : MathapproxinterpModel) -> Double { @_common.min(self.data) }

pub fn MathapproxinterpModel::max(self : MathapproxinterpModel) -> Double { @_common.max(self.data) }

pub fn MathapproxinterpModel::to_string(self : MathapproxinterpModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_layer_make(size : Int) -> MathapproxinterpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxinterpLayer::len(self : MathapproxinterpLayer) -> Int { self.size }

pub fn MathapproxinterpLayer::get(self : MathapproxinterpLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxinterpLayer::set(self : MathapproxinterpLayer, i : Int, v : Double) -> MathapproxinterpLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxinterpLayer::sum(self : MathapproxinterpLayer) -> Double { @_common.sum(self.data) }

pub fn MathapproxinterpLayer::mean(self : MathapproxinterpLayer) -> Double { @_common.mean(self.data) }

pub fn MathapproxinterpLayer::scale(self : MathapproxinterpLayer, f : Double) -> MathapproxinterpLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpLayer::add(self : MathapproxinterpLayer, other : MathapproxinterpLayer) -> MathapproxinterpLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxinterpLayer::copy(self : MathapproxinterpLayer) -> MathapproxinterpLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpLayer::fill(self : MathapproxinterpLayer, v : Double) -> MathapproxinterpLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpLayer::min(self : MathapproxinterpLayer) -> Double { @_common.min(self.data) }

pub fn MathapproxinterpLayer::max(self : MathapproxinterpLayer) -> Double { @_common.max(self.data) }

pub fn MathapproxinterpLayer::to_string(self : MathapproxinterpLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_buffer_make(size : Int) -> MathapproxinterpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxinterpBuffer::len(self : MathapproxinterpBuffer) -> Int { self.size }

pub fn MathapproxinterpBuffer::get(self : MathapproxinterpBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxinterpBuffer::set(self : MathapproxinterpBuffer, i : Int, v : Double) -> MathapproxinterpBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxinterpBuffer::sum(self : MathapproxinterpBuffer) -> Double { @_common.sum(self.data) }

pub fn MathapproxinterpBuffer::mean(self : MathapproxinterpBuffer) -> Double { @_common.mean(self.data) }

pub fn MathapproxinterpBuffer::scale(self : MathapproxinterpBuffer, f : Double) -> MathapproxinterpBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpBuffer::add(self : MathapproxinterpBuffer, other : MathapproxinterpBuffer) -> MathapproxinterpBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxinterpBuffer::copy(self : MathapproxinterpBuffer) -> MathapproxinterpBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpBuffer::fill(self : MathapproxinterpBuffer, v : Double) -> MathapproxinterpBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpBuffer::min(self : MathapproxinterpBuffer) -> Double { @_common.min(self.data) }

pub fn MathapproxinterpBuffer::max(self : MathapproxinterpBuffer) -> Double { @_common.max(self.data) }

pub fn MathapproxinterpBuffer::to_string(self : MathapproxinterpBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_cursor_make(size : Int) -> MathapproxinterpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxinterpCursor::len(self : MathapproxinterpCursor) -> Int { self.size }

pub fn MathapproxinterpCursor::get(self : MathapproxinterpCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxinterpCursor::set(self : MathapproxinterpCursor, i : Int, v : Double) -> MathapproxinterpCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxinterpCursor::sum(self : MathapproxinterpCursor) -> Double { @_common.sum(self.data) }

pub fn MathapproxinterpCursor::mean(self : MathapproxinterpCursor) -> Double { @_common.mean(self.data) }

pub fn MathapproxinterpCursor::scale(self : MathapproxinterpCursor, f : Double) -> MathapproxinterpCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpCursor::add(self : MathapproxinterpCursor, other : MathapproxinterpCursor) -> MathapproxinterpCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxinterpCursor::copy(self : MathapproxinterpCursor) -> MathapproxinterpCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpCursor::fill(self : MathapproxinterpCursor, v : Double) -> MathapproxinterpCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpCursor::min(self : MathapproxinterpCursor) -> Double { @_common.min(self.data) }

pub fn MathapproxinterpCursor::max(self : MathapproxinterpCursor) -> Double { @_common.max(self.data) }

pub fn MathapproxinterpCursor::to_string(self : MathapproxinterpCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_view_make(size : Int) -> MathapproxinterpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxinterpView::len(self : MathapproxinterpView) -> Int { self.size }

pub fn MathapproxinterpView::get(self : MathapproxinterpView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxinterpView::set(self : MathapproxinterpView, i : Int, v : Double) -> MathapproxinterpView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxinterpView::sum(self : MathapproxinterpView) -> Double { @_common.sum(self.data) }

pub fn MathapproxinterpView::mean(self : MathapproxinterpView) -> Double { @_common.mean(self.data) }

pub fn MathapproxinterpView::scale(self : MathapproxinterpView, f : Double) -> MathapproxinterpView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpView::add(self : MathapproxinterpView, other : MathapproxinterpView) -> MathapproxinterpView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxinterpView::copy(self : MathapproxinterpView) -> MathapproxinterpView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpView::fill(self : MathapproxinterpView, v : Double) -> MathapproxinterpView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpView::min(self : MathapproxinterpView) -> Double { @_common.min(self.data) }

pub fn MathapproxinterpView::max(self : MathapproxinterpView) -> Double { @_common.max(self.data) }

pub fn MathapproxinterpView::to_string(self : MathapproxinterpView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_range_make(size : Int) -> MathapproxinterpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxinterpRange::len(self : MathapproxinterpRange) -> Int { self.size }

pub fn MathapproxinterpRange::get(self : MathapproxinterpRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxinterpRange::set(self : MathapproxinterpRange, i : Int, v : Double) -> MathapproxinterpRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxinterpRange::sum(self : MathapproxinterpRange) -> Double { @_common.sum(self.data) }

pub fn MathapproxinterpRange::mean(self : MathapproxinterpRange) -> Double { @_common.mean(self.data) }

pub fn MathapproxinterpRange::scale(self : MathapproxinterpRange, f : Double) -> MathapproxinterpRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpRange::add(self : MathapproxinterpRange, other : MathapproxinterpRange) -> MathapproxinterpRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxinterpRange::copy(self : MathapproxinterpRange) -> MathapproxinterpRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpRange::fill(self : MathapproxinterpRange, v : Double) -> MathapproxinterpRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpRange::min(self : MathapproxinterpRange) -> Double { @_common.min(self.data) }

pub fn MathapproxinterpRange::max(self : MathapproxinterpRange) -> Double { @_common.max(self.data) }

pub fn MathapproxinterpRange::to_string(self : MathapproxinterpRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathapproxinterpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_approx_interp_slice_make(size : Int) -> MathapproxinterpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathapproxinterpSlice::len(self : MathapproxinterpSlice) -> Int { self.size }

pub fn MathapproxinterpSlice::get(self : MathapproxinterpSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathapproxinterpSlice::set(self : MathapproxinterpSlice, i : Int, v : Double) -> MathapproxinterpSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathapproxinterpSlice::sum(self : MathapproxinterpSlice) -> Double { @_common.sum(self.data) }

pub fn MathapproxinterpSlice::mean(self : MathapproxinterpSlice) -> Double { @_common.mean(self.data) }

pub fn MathapproxinterpSlice::scale(self : MathapproxinterpSlice, f : Double) -> MathapproxinterpSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpSlice::add(self : MathapproxinterpSlice, other : MathapproxinterpSlice) -> MathapproxinterpSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathapproxinterpSlice::copy(self : MathapproxinterpSlice) -> MathapproxinterpSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpSlice::fill(self : MathapproxinterpSlice, v : Double) -> MathapproxinterpSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathapproxinterpSlice::min(self : MathapproxinterpSlice) -> Double { @_common.min(self.data) }

pub fn MathapproxinterpSlice::max(self : MathapproxinterpSlice) -> Double { @_common.max(self.data) }

pub fn MathapproxinterpSlice::to_string(self : MathapproxinterpSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

