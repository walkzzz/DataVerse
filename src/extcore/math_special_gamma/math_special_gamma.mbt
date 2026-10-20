///===
/// extcore/math_special_gamma

pub(all) struct MathspecialgammaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_gamma_make_point(x : Double, y : Double) -> MathspecialgammaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_gamma_make_point3(x : Double, y : Double, z : Double) -> MathspecialgammaPoint {
  { x, y, z, label: 0 }
}

pub fn MathspecialgammaPoint::x(self : MathspecialgammaPoint) -> Double { self.x }

pub fn MathspecialgammaPoint::y(self : MathspecialgammaPoint) -> Double { self.y }

pub fn MathspecialgammaPoint::z(self : MathspecialgammaPoint) -> Double { self.z }

pub fn MathspecialgammaPoint::label(self : MathspecialgammaPoint) -> Int { self.label }

pub fn MathspecialgammaPoint::dist(self : MathspecialgammaPoint, other : MathspecialgammaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspecialgammaPoint::add(self : MathspecialgammaPoint, other : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspecialgammaPoint::sub(self : MathspecialgammaPoint, other : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspecialgammaPoint::scale(self : MathspecialgammaPoint, s : Double) -> MathspecialgammaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspecialgammaPoint::dot(self : MathspecialgammaPoint, other : MathspecialgammaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspecialgammaPoint::cross(self : MathspecialgammaPoint, other : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspecialgammaPoint::norm(self : MathspecialgammaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspecialgammaPoint::normalize(self : MathspecialgammaPoint) -> MathspecialgammaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialgammaPoint::negate(self : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspecialgammaPoint::mid(self : MathspecialgammaPoint, other : MathspecialgammaPoint) -> MathspecialgammaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspecialgammaPoint::lerp(self : MathspecialgammaPoint, other : MathspecialgammaPoint, t : Double) -> MathspecialgammaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspecialgammaPoint::to_string(self : MathspecialgammaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspecialgammaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_gamma_make_series(vals : Array[Double], name : String) -> MathspecialgammaSeries {
  { vals, name, meta: 0 }
}

pub fn MathspecialgammaSeries::len(self : MathspecialgammaSeries) -> Int { self.vals.length() }

pub fn MathspecialgammaSeries::sum(self : MathspecialgammaSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspecialgammaSeries::mean(self : MathspecialgammaSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspecialgammaSeries::min(self : MathspecialgammaSeries) -> Double { @_common.min(self.vals) }

pub fn MathspecialgammaSeries::max(self : MathspecialgammaSeries) -> Double { @_common.max(self.vals) }

pub fn MathspecialgammaSeries::range(self : MathspecialgammaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspecialgammaSeries::variance(self : MathspecialgammaSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspecialgammaSeries::std(self : MathspecialgammaSeries) -> Double { @_common.std(self.vals) }

pub fn MathspecialgammaSeries::median(self : MathspecialgammaSeries) -> Double { @_common.median(self.vals) }

pub fn MathspecialgammaSeries::scale(self : MathspecialgammaSeries, f : Double) -> MathspecialgammaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspecialgammaSeries::add(self : MathspecialgammaSeries, other : MathspecialgammaSeries) -> MathspecialgammaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspecialgammaSeries::sub(self : MathspecialgammaSeries, other : MathspecialgammaSeries) -> MathspecialgammaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspecialgammaSeries::normalize(self : MathspecialgammaSeries) -> MathspecialgammaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspecialgammaSeries::cumsum(self : MathspecialgammaSeries) -> MathspecialgammaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspecialgammaSeries::to_string(self : MathspecialgammaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialgammaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_gamma_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialgammaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_gamma_matrix_identity(n : Int) -> MathspecialgammaMatrix {
  let m = math_special_gamma_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspecialgammaMatrix::get(self : MathspecialgammaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspecialgammaMatrix::transpose(self : MathspecialgammaMatrix) -> MathspecialgammaMatrix {
  let result = math_special_gamma_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspecialgammaMatrix::add(self : MathspecialgammaMatrix, other : MathspecialgammaMatrix) -> MathspecialgammaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_gamma_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspecialgammaMatrix::scale(self : MathspecialgammaMatrix, s : Double) -> MathspecialgammaMatrix {
  let result = math_special_gamma_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspecialgammaMatrix::multiply(self : MathspecialgammaMatrix, other : MathspecialgammaMatrix) -> MathspecialgammaMatrix {
  if self.cols != other.rows { return math_special_gamma_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_gamma_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathspecialgammaMatrix::trace(self : MathspecialgammaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspecialgammaMatrix::det(self : MathspecialgammaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspecialgammaMatrix::norm(self : MathspecialgammaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspecialgammaMatrix::to_string(self : MathspecialgammaMatrix) -> String {
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

pub(all) struct MathspecialgammaVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_gamma_make_vector(comps : Array[Double]) -> MathspecialgammaVector {
  { comps, dim: comps.length() }
}

pub fn math_special_gamma_vector_zero(dim : Int) -> MathspecialgammaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspecialgammaVector::add(self : MathspecialgammaVector, other : MathspecialgammaVector) -> MathspecialgammaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialgammaVector::sub(self : MathspecialgammaVector, other : MathspecialgammaVector) -> MathspecialgammaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialgammaVector::scale(self : MathspecialgammaVector, s : Double) -> MathspecialgammaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspecialgammaVector::dot(self : MathspecialgammaVector, other : MathspecialgammaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspecialgammaVector::norm(self : MathspecialgammaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspecialgammaVector::normalize(self : MathspecialgammaVector) -> MathspecialgammaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialgammaVector::dist(self : MathspecialgammaVector, other : MathspecialgammaVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspecialgammaVector::to_string(self : MathspecialgammaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_gamma_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_gamma_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_gamma_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_gamma_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_gamma_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_gamma_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_gamma_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_gamma_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_gamma_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_gamma_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_gamma_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_gamma_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_gamma_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_gamma_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_gamma_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_gamma_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_gamma_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_gamma_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_gamma_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_gamma_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_gamma_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_gamma_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_gamma_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_gamma_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_gamma_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_gamma_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_gamma_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_gamma_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_gamma_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialgammaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_frame_make(size : Int) -> MathspecialgammaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialgammaFrame::len(self : MathspecialgammaFrame) -> Int { self.size }

pub fn MathspecialgammaFrame::get(self : MathspecialgammaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialgammaFrame::set(self : MathspecialgammaFrame, i : Int, v : Double) -> MathspecialgammaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialgammaFrame::sum(self : MathspecialgammaFrame) -> Double { @_common.sum(self.data) }

pub fn MathspecialgammaFrame::mean(self : MathspecialgammaFrame) -> Double { @_common.mean(self.data) }

pub fn MathspecialgammaFrame::scale(self : MathspecialgammaFrame, f : Double) -> MathspecialgammaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaFrame::add(self : MathspecialgammaFrame, other : MathspecialgammaFrame) -> MathspecialgammaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialgammaFrame::copy(self : MathspecialgammaFrame) -> MathspecialgammaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaFrame::fill(self : MathspecialgammaFrame, v : Double) -> MathspecialgammaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaFrame::min(self : MathspecialgammaFrame) -> Double { @_common.min(self.data) }

pub fn MathspecialgammaFrame::max(self : MathspecialgammaFrame) -> Double { @_common.max(self.data) }

pub fn MathspecialgammaFrame::to_string(self : MathspecialgammaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_table_make(size : Int) -> MathspecialgammaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialgammaTable::len(self : MathspecialgammaTable) -> Int { self.size }

pub fn MathspecialgammaTable::get(self : MathspecialgammaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialgammaTable::set(self : MathspecialgammaTable, i : Int, v : Double) -> MathspecialgammaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialgammaTable::sum(self : MathspecialgammaTable) -> Double { @_common.sum(self.data) }

pub fn MathspecialgammaTable::mean(self : MathspecialgammaTable) -> Double { @_common.mean(self.data) }

pub fn MathspecialgammaTable::scale(self : MathspecialgammaTable, f : Double) -> MathspecialgammaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaTable::add(self : MathspecialgammaTable, other : MathspecialgammaTable) -> MathspecialgammaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialgammaTable::copy(self : MathspecialgammaTable) -> MathspecialgammaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaTable::fill(self : MathspecialgammaTable, v : Double) -> MathspecialgammaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaTable::min(self : MathspecialgammaTable) -> Double { @_common.min(self.data) }

pub fn MathspecialgammaTable::max(self : MathspecialgammaTable) -> Double { @_common.max(self.data) }

pub fn MathspecialgammaTable::to_string(self : MathspecialgammaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_graphn_make(size : Int) -> MathspecialgammaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialgammaGraphN::len(self : MathspecialgammaGraphN) -> Int { self.size }

pub fn MathspecialgammaGraphN::get(self : MathspecialgammaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialgammaGraphN::set(self : MathspecialgammaGraphN, i : Int, v : Double) -> MathspecialgammaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialgammaGraphN::sum(self : MathspecialgammaGraphN) -> Double { @_common.sum(self.data) }

pub fn MathspecialgammaGraphN::mean(self : MathspecialgammaGraphN) -> Double { @_common.mean(self.data) }

pub fn MathspecialgammaGraphN::scale(self : MathspecialgammaGraphN, f : Double) -> MathspecialgammaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaGraphN::add(self : MathspecialgammaGraphN, other : MathspecialgammaGraphN) -> MathspecialgammaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialgammaGraphN::copy(self : MathspecialgammaGraphN) -> MathspecialgammaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaGraphN::fill(self : MathspecialgammaGraphN, v : Double) -> MathspecialgammaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaGraphN::min(self : MathspecialgammaGraphN) -> Double { @_common.min(self.data) }

pub fn MathspecialgammaGraphN::max(self : MathspecialgammaGraphN) -> Double { @_common.max(self.data) }

pub fn MathspecialgammaGraphN::to_string(self : MathspecialgammaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_node_make(size : Int) -> MathspecialgammaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialgammaNode::len(self : MathspecialgammaNode) -> Int { self.size }

pub fn MathspecialgammaNode::get(self : MathspecialgammaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialgammaNode::set(self : MathspecialgammaNode, i : Int, v : Double) -> MathspecialgammaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialgammaNode::sum(self : MathspecialgammaNode) -> Double { @_common.sum(self.data) }

pub fn MathspecialgammaNode::mean(self : MathspecialgammaNode) -> Double { @_common.mean(self.data) }

pub fn MathspecialgammaNode::scale(self : MathspecialgammaNode, f : Double) -> MathspecialgammaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaNode::add(self : MathspecialgammaNode, other : MathspecialgammaNode) -> MathspecialgammaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialgammaNode::copy(self : MathspecialgammaNode) -> MathspecialgammaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaNode::fill(self : MathspecialgammaNode, v : Double) -> MathspecialgammaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaNode::min(self : MathspecialgammaNode) -> Double { @_common.min(self.data) }

pub fn MathspecialgammaNode::max(self : MathspecialgammaNode) -> Double { @_common.max(self.data) }

pub fn MathspecialgammaNode::to_string(self : MathspecialgammaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_edge_make(size : Int) -> MathspecialgammaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialgammaEdge::len(self : MathspecialgammaEdge) -> Int { self.size }

pub fn MathspecialgammaEdge::get(self : MathspecialgammaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialgammaEdge::set(self : MathspecialgammaEdge, i : Int, v : Double) -> MathspecialgammaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialgammaEdge::sum(self : MathspecialgammaEdge) -> Double { @_common.sum(self.data) }

pub fn MathspecialgammaEdge::mean(self : MathspecialgammaEdge) -> Double { @_common.mean(self.data) }

pub fn MathspecialgammaEdge::scale(self : MathspecialgammaEdge, f : Double) -> MathspecialgammaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaEdge::add(self : MathspecialgammaEdge, other : MathspecialgammaEdge) -> MathspecialgammaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialgammaEdge::copy(self : MathspecialgammaEdge) -> MathspecialgammaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaEdge::fill(self : MathspecialgammaEdge, v : Double) -> MathspecialgammaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaEdge::min(self : MathspecialgammaEdge) -> Double { @_common.min(self.data) }

pub fn MathspecialgammaEdge::max(self : MathspecialgammaEdge) -> Double { @_common.max(self.data) }

pub fn MathspecialgammaEdge::to_string(self : MathspecialgammaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_path_make(size : Int) -> MathspecialgammaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialgammaPath::len(self : MathspecialgammaPath) -> Int { self.size }

pub fn MathspecialgammaPath::get(self : MathspecialgammaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialgammaPath::set(self : MathspecialgammaPath, i : Int, v : Double) -> MathspecialgammaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialgammaPath::sum(self : MathspecialgammaPath) -> Double { @_common.sum(self.data) }

pub fn MathspecialgammaPath::mean(self : MathspecialgammaPath) -> Double { @_common.mean(self.data) }

pub fn MathspecialgammaPath::scale(self : MathspecialgammaPath, f : Double) -> MathspecialgammaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaPath::add(self : MathspecialgammaPath, other : MathspecialgammaPath) -> MathspecialgammaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialgammaPath::copy(self : MathspecialgammaPath) -> MathspecialgammaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaPath::fill(self : MathspecialgammaPath, v : Double) -> MathspecialgammaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaPath::min(self : MathspecialgammaPath) -> Double { @_common.min(self.data) }

pub fn MathspecialgammaPath::max(self : MathspecialgammaPath) -> Double { @_common.max(self.data) }

pub fn MathspecialgammaPath::to_string(self : MathspecialgammaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_cluster_make(size : Int) -> MathspecialgammaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialgammaCluster::len(self : MathspecialgammaCluster) -> Int { self.size }

pub fn MathspecialgammaCluster::get(self : MathspecialgammaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialgammaCluster::set(self : MathspecialgammaCluster, i : Int, v : Double) -> MathspecialgammaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialgammaCluster::sum(self : MathspecialgammaCluster) -> Double { @_common.sum(self.data) }

pub fn MathspecialgammaCluster::mean(self : MathspecialgammaCluster) -> Double { @_common.mean(self.data) }

pub fn MathspecialgammaCluster::scale(self : MathspecialgammaCluster, f : Double) -> MathspecialgammaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaCluster::add(self : MathspecialgammaCluster, other : MathspecialgammaCluster) -> MathspecialgammaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialgammaCluster::copy(self : MathspecialgammaCluster) -> MathspecialgammaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaCluster::fill(self : MathspecialgammaCluster, v : Double) -> MathspecialgammaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaCluster::min(self : MathspecialgammaCluster) -> Double { @_common.min(self.data) }

pub fn MathspecialgammaCluster::max(self : MathspecialgammaCluster) -> Double { @_common.max(self.data) }

pub fn MathspecialgammaCluster::to_string(self : MathspecialgammaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_model_make(size : Int) -> MathspecialgammaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialgammaModel::len(self : MathspecialgammaModel) -> Int { self.size }

pub fn MathspecialgammaModel::get(self : MathspecialgammaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialgammaModel::set(self : MathspecialgammaModel, i : Int, v : Double) -> MathspecialgammaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialgammaModel::sum(self : MathspecialgammaModel) -> Double { @_common.sum(self.data) }

pub fn MathspecialgammaModel::mean(self : MathspecialgammaModel) -> Double { @_common.mean(self.data) }

pub fn MathspecialgammaModel::scale(self : MathspecialgammaModel, f : Double) -> MathspecialgammaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaModel::add(self : MathspecialgammaModel, other : MathspecialgammaModel) -> MathspecialgammaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialgammaModel::copy(self : MathspecialgammaModel) -> MathspecialgammaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaModel::fill(self : MathspecialgammaModel, v : Double) -> MathspecialgammaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaModel::min(self : MathspecialgammaModel) -> Double { @_common.min(self.data) }

pub fn MathspecialgammaModel::max(self : MathspecialgammaModel) -> Double { @_common.max(self.data) }

pub fn MathspecialgammaModel::to_string(self : MathspecialgammaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_layer_make(size : Int) -> MathspecialgammaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialgammaLayer::len(self : MathspecialgammaLayer) -> Int { self.size }

pub fn MathspecialgammaLayer::get(self : MathspecialgammaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialgammaLayer::set(self : MathspecialgammaLayer, i : Int, v : Double) -> MathspecialgammaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialgammaLayer::sum(self : MathspecialgammaLayer) -> Double { @_common.sum(self.data) }

pub fn MathspecialgammaLayer::mean(self : MathspecialgammaLayer) -> Double { @_common.mean(self.data) }

pub fn MathspecialgammaLayer::scale(self : MathspecialgammaLayer, f : Double) -> MathspecialgammaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaLayer::add(self : MathspecialgammaLayer, other : MathspecialgammaLayer) -> MathspecialgammaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialgammaLayer::copy(self : MathspecialgammaLayer) -> MathspecialgammaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaLayer::fill(self : MathspecialgammaLayer, v : Double) -> MathspecialgammaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaLayer::min(self : MathspecialgammaLayer) -> Double { @_common.min(self.data) }

pub fn MathspecialgammaLayer::max(self : MathspecialgammaLayer) -> Double { @_common.max(self.data) }

pub fn MathspecialgammaLayer::to_string(self : MathspecialgammaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_buffer_make(size : Int) -> MathspecialgammaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialgammaBuffer::len(self : MathspecialgammaBuffer) -> Int { self.size }

pub fn MathspecialgammaBuffer::get(self : MathspecialgammaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialgammaBuffer::set(self : MathspecialgammaBuffer, i : Int, v : Double) -> MathspecialgammaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialgammaBuffer::sum(self : MathspecialgammaBuffer) -> Double { @_common.sum(self.data) }

pub fn MathspecialgammaBuffer::mean(self : MathspecialgammaBuffer) -> Double { @_common.mean(self.data) }

pub fn MathspecialgammaBuffer::scale(self : MathspecialgammaBuffer, f : Double) -> MathspecialgammaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaBuffer::add(self : MathspecialgammaBuffer, other : MathspecialgammaBuffer) -> MathspecialgammaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialgammaBuffer::copy(self : MathspecialgammaBuffer) -> MathspecialgammaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaBuffer::fill(self : MathspecialgammaBuffer, v : Double) -> MathspecialgammaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaBuffer::min(self : MathspecialgammaBuffer) -> Double { @_common.min(self.data) }

pub fn MathspecialgammaBuffer::max(self : MathspecialgammaBuffer) -> Double { @_common.max(self.data) }

pub fn MathspecialgammaBuffer::to_string(self : MathspecialgammaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_cursor_make(size : Int) -> MathspecialgammaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialgammaCursor::len(self : MathspecialgammaCursor) -> Int { self.size }

pub fn MathspecialgammaCursor::get(self : MathspecialgammaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialgammaCursor::set(self : MathspecialgammaCursor, i : Int, v : Double) -> MathspecialgammaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialgammaCursor::sum(self : MathspecialgammaCursor) -> Double { @_common.sum(self.data) }

pub fn MathspecialgammaCursor::mean(self : MathspecialgammaCursor) -> Double { @_common.mean(self.data) }

pub fn MathspecialgammaCursor::scale(self : MathspecialgammaCursor, f : Double) -> MathspecialgammaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaCursor::add(self : MathspecialgammaCursor, other : MathspecialgammaCursor) -> MathspecialgammaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialgammaCursor::copy(self : MathspecialgammaCursor) -> MathspecialgammaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaCursor::fill(self : MathspecialgammaCursor, v : Double) -> MathspecialgammaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaCursor::min(self : MathspecialgammaCursor) -> Double { @_common.min(self.data) }

pub fn MathspecialgammaCursor::max(self : MathspecialgammaCursor) -> Double { @_common.max(self.data) }

pub fn MathspecialgammaCursor::to_string(self : MathspecialgammaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_view_make(size : Int) -> MathspecialgammaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialgammaView::len(self : MathspecialgammaView) -> Int { self.size }

pub fn MathspecialgammaView::get(self : MathspecialgammaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialgammaView::set(self : MathspecialgammaView, i : Int, v : Double) -> MathspecialgammaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialgammaView::sum(self : MathspecialgammaView) -> Double { @_common.sum(self.data) }

pub fn MathspecialgammaView::mean(self : MathspecialgammaView) -> Double { @_common.mean(self.data) }

pub fn MathspecialgammaView::scale(self : MathspecialgammaView, f : Double) -> MathspecialgammaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaView::add(self : MathspecialgammaView, other : MathspecialgammaView) -> MathspecialgammaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialgammaView::copy(self : MathspecialgammaView) -> MathspecialgammaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaView::fill(self : MathspecialgammaView, v : Double) -> MathspecialgammaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaView::min(self : MathspecialgammaView) -> Double { @_common.min(self.data) }

pub fn MathspecialgammaView::max(self : MathspecialgammaView) -> Double { @_common.max(self.data) }

pub fn MathspecialgammaView::to_string(self : MathspecialgammaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_range_make(size : Int) -> MathspecialgammaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialgammaRange::len(self : MathspecialgammaRange) -> Int { self.size }

pub fn MathspecialgammaRange::get(self : MathspecialgammaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialgammaRange::set(self : MathspecialgammaRange, i : Int, v : Double) -> MathspecialgammaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialgammaRange::sum(self : MathspecialgammaRange) -> Double { @_common.sum(self.data) }

pub fn MathspecialgammaRange::mean(self : MathspecialgammaRange) -> Double { @_common.mean(self.data) }

pub fn MathspecialgammaRange::scale(self : MathspecialgammaRange, f : Double) -> MathspecialgammaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaRange::add(self : MathspecialgammaRange, other : MathspecialgammaRange) -> MathspecialgammaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialgammaRange::copy(self : MathspecialgammaRange) -> MathspecialgammaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaRange::fill(self : MathspecialgammaRange, v : Double) -> MathspecialgammaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaRange::min(self : MathspecialgammaRange) -> Double { @_common.min(self.data) }

pub fn MathspecialgammaRange::max(self : MathspecialgammaRange) -> Double { @_common.max(self.data) }

pub fn MathspecialgammaRange::to_string(self : MathspecialgammaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialgammaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_gamma_slice_make(size : Int) -> MathspecialgammaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialgammaSlice::len(self : MathspecialgammaSlice) -> Int { self.size }

pub fn MathspecialgammaSlice::get(self : MathspecialgammaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialgammaSlice::set(self : MathspecialgammaSlice, i : Int, v : Double) -> MathspecialgammaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialgammaSlice::sum(self : MathspecialgammaSlice) -> Double { @_common.sum(self.data) }

pub fn MathspecialgammaSlice::mean(self : MathspecialgammaSlice) -> Double { @_common.mean(self.data) }

pub fn MathspecialgammaSlice::scale(self : MathspecialgammaSlice, f : Double) -> MathspecialgammaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaSlice::add(self : MathspecialgammaSlice, other : MathspecialgammaSlice) -> MathspecialgammaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialgammaSlice::copy(self : MathspecialgammaSlice) -> MathspecialgammaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaSlice::fill(self : MathspecialgammaSlice, v : Double) -> MathspecialgammaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialgammaSlice::min(self : MathspecialgammaSlice) -> Double { @_common.min(self.data) }

pub fn MathspecialgammaSlice::max(self : MathspecialgammaSlice) -> Double { @_common.max(self.data) }

pub fn MathspecialgammaSlice::to_string(self : MathspecialgammaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

