///===
/// extcore/math_special_beta

pub(all) struct MathspecialbetaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_beta_make_point(x : Double, y : Double) -> MathspecialbetaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_beta_make_point3(x : Double, y : Double, z : Double) -> MathspecialbetaPoint {
  { x, y, z, label: 0 }
}

pub fn MathspecialbetaPoint::x(self : MathspecialbetaPoint) -> Double { self.x }

pub fn MathspecialbetaPoint::y(self : MathspecialbetaPoint) -> Double { self.y }

pub fn MathspecialbetaPoint::z(self : MathspecialbetaPoint) -> Double { self.z }

pub fn MathspecialbetaPoint::label(self : MathspecialbetaPoint) -> Int { self.label }

pub fn MathspecialbetaPoint::dist(self : MathspecialbetaPoint, other : MathspecialbetaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspecialbetaPoint::add(self : MathspecialbetaPoint, other : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspecialbetaPoint::sub(self : MathspecialbetaPoint, other : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspecialbetaPoint::scale(self : MathspecialbetaPoint, s : Double) -> MathspecialbetaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspecialbetaPoint::dot(self : MathspecialbetaPoint, other : MathspecialbetaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspecialbetaPoint::cross(self : MathspecialbetaPoint, other : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspecialbetaPoint::norm(self : MathspecialbetaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspecialbetaPoint::normalize(self : MathspecialbetaPoint) -> MathspecialbetaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialbetaPoint::negate(self : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspecialbetaPoint::mid(self : MathspecialbetaPoint, other : MathspecialbetaPoint) -> MathspecialbetaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspecialbetaPoint::lerp(self : MathspecialbetaPoint, other : MathspecialbetaPoint, t : Double) -> MathspecialbetaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspecialbetaPoint::to_string(self : MathspecialbetaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspecialbetaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_beta_make_series(vals : Array[Double], name : String) -> MathspecialbetaSeries {
  { vals, name, meta: 0 }
}

pub fn MathspecialbetaSeries::len(self : MathspecialbetaSeries) -> Int { self.vals.length() }

pub fn MathspecialbetaSeries::sum(self : MathspecialbetaSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspecialbetaSeries::mean(self : MathspecialbetaSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspecialbetaSeries::min(self : MathspecialbetaSeries) -> Double { @_common.min(self.vals) }

pub fn MathspecialbetaSeries::max(self : MathspecialbetaSeries) -> Double { @_common.max(self.vals) }

pub fn MathspecialbetaSeries::range(self : MathspecialbetaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspecialbetaSeries::variance(self : MathspecialbetaSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspecialbetaSeries::std(self : MathspecialbetaSeries) -> Double { @_common.std(self.vals) }

pub fn MathspecialbetaSeries::median(self : MathspecialbetaSeries) -> Double { @_common.median(self.vals) }

pub fn MathspecialbetaSeries::scale(self : MathspecialbetaSeries, f : Double) -> MathspecialbetaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspecialbetaSeries::add(self : MathspecialbetaSeries, other : MathspecialbetaSeries) -> MathspecialbetaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspecialbetaSeries::sub(self : MathspecialbetaSeries, other : MathspecialbetaSeries) -> MathspecialbetaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspecialbetaSeries::normalize(self : MathspecialbetaSeries) -> MathspecialbetaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspecialbetaSeries::cumsum(self : MathspecialbetaSeries) -> MathspecialbetaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspecialbetaSeries::to_string(self : MathspecialbetaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialbetaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_beta_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialbetaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_beta_matrix_identity(n : Int) -> MathspecialbetaMatrix {
  let m = math_special_beta_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspecialbetaMatrix::get(self : MathspecialbetaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspecialbetaMatrix::transpose(self : MathspecialbetaMatrix) -> MathspecialbetaMatrix {
  let result = math_special_beta_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspecialbetaMatrix::add(self : MathspecialbetaMatrix, other : MathspecialbetaMatrix) -> MathspecialbetaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_beta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspecialbetaMatrix::scale(self : MathspecialbetaMatrix, s : Double) -> MathspecialbetaMatrix {
  let result = math_special_beta_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspecialbetaMatrix::multiply(self : MathspecialbetaMatrix, other : MathspecialbetaMatrix) -> MathspecialbetaMatrix {
  if self.cols != other.rows { return math_special_beta_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_beta_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathspecialbetaMatrix::trace(self : MathspecialbetaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspecialbetaMatrix::det(self : MathspecialbetaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspecialbetaMatrix::norm(self : MathspecialbetaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspecialbetaMatrix::to_string(self : MathspecialbetaMatrix) -> String {
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

pub(all) struct MathspecialbetaVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_beta_make_vector(comps : Array[Double]) -> MathspecialbetaVector {
  { comps, dim: comps.length() }
}

pub fn math_special_beta_vector_zero(dim : Int) -> MathspecialbetaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspecialbetaVector::add(self : MathspecialbetaVector, other : MathspecialbetaVector) -> MathspecialbetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialbetaVector::sub(self : MathspecialbetaVector, other : MathspecialbetaVector) -> MathspecialbetaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialbetaVector::scale(self : MathspecialbetaVector, s : Double) -> MathspecialbetaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspecialbetaVector::dot(self : MathspecialbetaVector, other : MathspecialbetaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspecialbetaVector::norm(self : MathspecialbetaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspecialbetaVector::normalize(self : MathspecialbetaVector) -> MathspecialbetaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialbetaVector::dist(self : MathspecialbetaVector, other : MathspecialbetaVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspecialbetaVector::to_string(self : MathspecialbetaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_beta_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_beta_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_beta_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_beta_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_beta_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_beta_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_beta_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_beta_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_beta_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_beta_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_beta_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_beta_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_beta_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_beta_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_beta_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_beta_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_beta_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_beta_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_beta_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_beta_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_beta_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_beta_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_beta_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_beta_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_beta_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_beta_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_beta_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_beta_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_beta_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialbetaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_frame_make(size : Int) -> MathspecialbetaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbetaFrame::len(self : MathspecialbetaFrame) -> Int { self.size }

pub fn MathspecialbetaFrame::get(self : MathspecialbetaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbetaFrame::set(self : MathspecialbetaFrame, i : Int, v : Double) -> MathspecialbetaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbetaFrame::sum(self : MathspecialbetaFrame) -> Double { @_common.sum(self.data) }

pub fn MathspecialbetaFrame::mean(self : MathspecialbetaFrame) -> Double { @_common.mean(self.data) }

pub fn MathspecialbetaFrame::scale(self : MathspecialbetaFrame, f : Double) -> MathspecialbetaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaFrame::add(self : MathspecialbetaFrame, other : MathspecialbetaFrame) -> MathspecialbetaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbetaFrame::copy(self : MathspecialbetaFrame) -> MathspecialbetaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaFrame::fill(self : MathspecialbetaFrame, v : Double) -> MathspecialbetaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaFrame::min(self : MathspecialbetaFrame) -> Double { @_common.min(self.data) }

pub fn MathspecialbetaFrame::max(self : MathspecialbetaFrame) -> Double { @_common.max(self.data) }

pub fn MathspecialbetaFrame::to_string(self : MathspecialbetaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_table_make(size : Int) -> MathspecialbetaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbetaTable::len(self : MathspecialbetaTable) -> Int { self.size }

pub fn MathspecialbetaTable::get(self : MathspecialbetaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbetaTable::set(self : MathspecialbetaTable, i : Int, v : Double) -> MathspecialbetaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbetaTable::sum(self : MathspecialbetaTable) -> Double { @_common.sum(self.data) }

pub fn MathspecialbetaTable::mean(self : MathspecialbetaTable) -> Double { @_common.mean(self.data) }

pub fn MathspecialbetaTable::scale(self : MathspecialbetaTable, f : Double) -> MathspecialbetaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaTable::add(self : MathspecialbetaTable, other : MathspecialbetaTable) -> MathspecialbetaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbetaTable::copy(self : MathspecialbetaTable) -> MathspecialbetaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaTable::fill(self : MathspecialbetaTable, v : Double) -> MathspecialbetaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaTable::min(self : MathspecialbetaTable) -> Double { @_common.min(self.data) }

pub fn MathspecialbetaTable::max(self : MathspecialbetaTable) -> Double { @_common.max(self.data) }

pub fn MathspecialbetaTable::to_string(self : MathspecialbetaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_graphn_make(size : Int) -> MathspecialbetaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbetaGraphN::len(self : MathspecialbetaGraphN) -> Int { self.size }

pub fn MathspecialbetaGraphN::get(self : MathspecialbetaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbetaGraphN::set(self : MathspecialbetaGraphN, i : Int, v : Double) -> MathspecialbetaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbetaGraphN::sum(self : MathspecialbetaGraphN) -> Double { @_common.sum(self.data) }

pub fn MathspecialbetaGraphN::mean(self : MathspecialbetaGraphN) -> Double { @_common.mean(self.data) }

pub fn MathspecialbetaGraphN::scale(self : MathspecialbetaGraphN, f : Double) -> MathspecialbetaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaGraphN::add(self : MathspecialbetaGraphN, other : MathspecialbetaGraphN) -> MathspecialbetaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbetaGraphN::copy(self : MathspecialbetaGraphN) -> MathspecialbetaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaGraphN::fill(self : MathspecialbetaGraphN, v : Double) -> MathspecialbetaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaGraphN::min(self : MathspecialbetaGraphN) -> Double { @_common.min(self.data) }

pub fn MathspecialbetaGraphN::max(self : MathspecialbetaGraphN) -> Double { @_common.max(self.data) }

pub fn MathspecialbetaGraphN::to_string(self : MathspecialbetaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_node_make(size : Int) -> MathspecialbetaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbetaNode::len(self : MathspecialbetaNode) -> Int { self.size }

pub fn MathspecialbetaNode::get(self : MathspecialbetaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbetaNode::set(self : MathspecialbetaNode, i : Int, v : Double) -> MathspecialbetaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbetaNode::sum(self : MathspecialbetaNode) -> Double { @_common.sum(self.data) }

pub fn MathspecialbetaNode::mean(self : MathspecialbetaNode) -> Double { @_common.mean(self.data) }

pub fn MathspecialbetaNode::scale(self : MathspecialbetaNode, f : Double) -> MathspecialbetaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaNode::add(self : MathspecialbetaNode, other : MathspecialbetaNode) -> MathspecialbetaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbetaNode::copy(self : MathspecialbetaNode) -> MathspecialbetaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaNode::fill(self : MathspecialbetaNode, v : Double) -> MathspecialbetaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaNode::min(self : MathspecialbetaNode) -> Double { @_common.min(self.data) }

pub fn MathspecialbetaNode::max(self : MathspecialbetaNode) -> Double { @_common.max(self.data) }

pub fn MathspecialbetaNode::to_string(self : MathspecialbetaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_edge_make(size : Int) -> MathspecialbetaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbetaEdge::len(self : MathspecialbetaEdge) -> Int { self.size }

pub fn MathspecialbetaEdge::get(self : MathspecialbetaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbetaEdge::set(self : MathspecialbetaEdge, i : Int, v : Double) -> MathspecialbetaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbetaEdge::sum(self : MathspecialbetaEdge) -> Double { @_common.sum(self.data) }

pub fn MathspecialbetaEdge::mean(self : MathspecialbetaEdge) -> Double { @_common.mean(self.data) }

pub fn MathspecialbetaEdge::scale(self : MathspecialbetaEdge, f : Double) -> MathspecialbetaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaEdge::add(self : MathspecialbetaEdge, other : MathspecialbetaEdge) -> MathspecialbetaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbetaEdge::copy(self : MathspecialbetaEdge) -> MathspecialbetaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaEdge::fill(self : MathspecialbetaEdge, v : Double) -> MathspecialbetaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaEdge::min(self : MathspecialbetaEdge) -> Double { @_common.min(self.data) }

pub fn MathspecialbetaEdge::max(self : MathspecialbetaEdge) -> Double { @_common.max(self.data) }

pub fn MathspecialbetaEdge::to_string(self : MathspecialbetaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_path_make(size : Int) -> MathspecialbetaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbetaPath::len(self : MathspecialbetaPath) -> Int { self.size }

pub fn MathspecialbetaPath::get(self : MathspecialbetaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbetaPath::set(self : MathspecialbetaPath, i : Int, v : Double) -> MathspecialbetaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbetaPath::sum(self : MathspecialbetaPath) -> Double { @_common.sum(self.data) }

pub fn MathspecialbetaPath::mean(self : MathspecialbetaPath) -> Double { @_common.mean(self.data) }

pub fn MathspecialbetaPath::scale(self : MathspecialbetaPath, f : Double) -> MathspecialbetaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaPath::add(self : MathspecialbetaPath, other : MathspecialbetaPath) -> MathspecialbetaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbetaPath::copy(self : MathspecialbetaPath) -> MathspecialbetaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaPath::fill(self : MathspecialbetaPath, v : Double) -> MathspecialbetaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaPath::min(self : MathspecialbetaPath) -> Double { @_common.min(self.data) }

pub fn MathspecialbetaPath::max(self : MathspecialbetaPath) -> Double { @_common.max(self.data) }

pub fn MathspecialbetaPath::to_string(self : MathspecialbetaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_cluster_make(size : Int) -> MathspecialbetaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbetaCluster::len(self : MathspecialbetaCluster) -> Int { self.size }

pub fn MathspecialbetaCluster::get(self : MathspecialbetaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbetaCluster::set(self : MathspecialbetaCluster, i : Int, v : Double) -> MathspecialbetaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbetaCluster::sum(self : MathspecialbetaCluster) -> Double { @_common.sum(self.data) }

pub fn MathspecialbetaCluster::mean(self : MathspecialbetaCluster) -> Double { @_common.mean(self.data) }

pub fn MathspecialbetaCluster::scale(self : MathspecialbetaCluster, f : Double) -> MathspecialbetaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaCluster::add(self : MathspecialbetaCluster, other : MathspecialbetaCluster) -> MathspecialbetaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbetaCluster::copy(self : MathspecialbetaCluster) -> MathspecialbetaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaCluster::fill(self : MathspecialbetaCluster, v : Double) -> MathspecialbetaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaCluster::min(self : MathspecialbetaCluster) -> Double { @_common.min(self.data) }

pub fn MathspecialbetaCluster::max(self : MathspecialbetaCluster) -> Double { @_common.max(self.data) }

pub fn MathspecialbetaCluster::to_string(self : MathspecialbetaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_model_make(size : Int) -> MathspecialbetaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbetaModel::len(self : MathspecialbetaModel) -> Int { self.size }

pub fn MathspecialbetaModel::get(self : MathspecialbetaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbetaModel::set(self : MathspecialbetaModel, i : Int, v : Double) -> MathspecialbetaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbetaModel::sum(self : MathspecialbetaModel) -> Double { @_common.sum(self.data) }

pub fn MathspecialbetaModel::mean(self : MathspecialbetaModel) -> Double { @_common.mean(self.data) }

pub fn MathspecialbetaModel::scale(self : MathspecialbetaModel, f : Double) -> MathspecialbetaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaModel::add(self : MathspecialbetaModel, other : MathspecialbetaModel) -> MathspecialbetaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbetaModel::copy(self : MathspecialbetaModel) -> MathspecialbetaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaModel::fill(self : MathspecialbetaModel, v : Double) -> MathspecialbetaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaModel::min(self : MathspecialbetaModel) -> Double { @_common.min(self.data) }

pub fn MathspecialbetaModel::max(self : MathspecialbetaModel) -> Double { @_common.max(self.data) }

pub fn MathspecialbetaModel::to_string(self : MathspecialbetaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_layer_make(size : Int) -> MathspecialbetaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbetaLayer::len(self : MathspecialbetaLayer) -> Int { self.size }

pub fn MathspecialbetaLayer::get(self : MathspecialbetaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbetaLayer::set(self : MathspecialbetaLayer, i : Int, v : Double) -> MathspecialbetaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbetaLayer::sum(self : MathspecialbetaLayer) -> Double { @_common.sum(self.data) }

pub fn MathspecialbetaLayer::mean(self : MathspecialbetaLayer) -> Double { @_common.mean(self.data) }

pub fn MathspecialbetaLayer::scale(self : MathspecialbetaLayer, f : Double) -> MathspecialbetaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaLayer::add(self : MathspecialbetaLayer, other : MathspecialbetaLayer) -> MathspecialbetaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbetaLayer::copy(self : MathspecialbetaLayer) -> MathspecialbetaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaLayer::fill(self : MathspecialbetaLayer, v : Double) -> MathspecialbetaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaLayer::min(self : MathspecialbetaLayer) -> Double { @_common.min(self.data) }

pub fn MathspecialbetaLayer::max(self : MathspecialbetaLayer) -> Double { @_common.max(self.data) }

pub fn MathspecialbetaLayer::to_string(self : MathspecialbetaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_buffer_make(size : Int) -> MathspecialbetaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbetaBuffer::len(self : MathspecialbetaBuffer) -> Int { self.size }

pub fn MathspecialbetaBuffer::get(self : MathspecialbetaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbetaBuffer::set(self : MathspecialbetaBuffer, i : Int, v : Double) -> MathspecialbetaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbetaBuffer::sum(self : MathspecialbetaBuffer) -> Double { @_common.sum(self.data) }

pub fn MathspecialbetaBuffer::mean(self : MathspecialbetaBuffer) -> Double { @_common.mean(self.data) }

pub fn MathspecialbetaBuffer::scale(self : MathspecialbetaBuffer, f : Double) -> MathspecialbetaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaBuffer::add(self : MathspecialbetaBuffer, other : MathspecialbetaBuffer) -> MathspecialbetaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbetaBuffer::copy(self : MathspecialbetaBuffer) -> MathspecialbetaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaBuffer::fill(self : MathspecialbetaBuffer, v : Double) -> MathspecialbetaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaBuffer::min(self : MathspecialbetaBuffer) -> Double { @_common.min(self.data) }

pub fn MathspecialbetaBuffer::max(self : MathspecialbetaBuffer) -> Double { @_common.max(self.data) }

pub fn MathspecialbetaBuffer::to_string(self : MathspecialbetaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_cursor_make(size : Int) -> MathspecialbetaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbetaCursor::len(self : MathspecialbetaCursor) -> Int { self.size }

pub fn MathspecialbetaCursor::get(self : MathspecialbetaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbetaCursor::set(self : MathspecialbetaCursor, i : Int, v : Double) -> MathspecialbetaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbetaCursor::sum(self : MathspecialbetaCursor) -> Double { @_common.sum(self.data) }

pub fn MathspecialbetaCursor::mean(self : MathspecialbetaCursor) -> Double { @_common.mean(self.data) }

pub fn MathspecialbetaCursor::scale(self : MathspecialbetaCursor, f : Double) -> MathspecialbetaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaCursor::add(self : MathspecialbetaCursor, other : MathspecialbetaCursor) -> MathspecialbetaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbetaCursor::copy(self : MathspecialbetaCursor) -> MathspecialbetaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaCursor::fill(self : MathspecialbetaCursor, v : Double) -> MathspecialbetaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaCursor::min(self : MathspecialbetaCursor) -> Double { @_common.min(self.data) }

pub fn MathspecialbetaCursor::max(self : MathspecialbetaCursor) -> Double { @_common.max(self.data) }

pub fn MathspecialbetaCursor::to_string(self : MathspecialbetaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_view_make(size : Int) -> MathspecialbetaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbetaView::len(self : MathspecialbetaView) -> Int { self.size }

pub fn MathspecialbetaView::get(self : MathspecialbetaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbetaView::set(self : MathspecialbetaView, i : Int, v : Double) -> MathspecialbetaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbetaView::sum(self : MathspecialbetaView) -> Double { @_common.sum(self.data) }

pub fn MathspecialbetaView::mean(self : MathspecialbetaView) -> Double { @_common.mean(self.data) }

pub fn MathspecialbetaView::scale(self : MathspecialbetaView, f : Double) -> MathspecialbetaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaView::add(self : MathspecialbetaView, other : MathspecialbetaView) -> MathspecialbetaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbetaView::copy(self : MathspecialbetaView) -> MathspecialbetaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaView::fill(self : MathspecialbetaView, v : Double) -> MathspecialbetaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaView::min(self : MathspecialbetaView) -> Double { @_common.min(self.data) }

pub fn MathspecialbetaView::max(self : MathspecialbetaView) -> Double { @_common.max(self.data) }

pub fn MathspecialbetaView::to_string(self : MathspecialbetaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_range_make(size : Int) -> MathspecialbetaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbetaRange::len(self : MathspecialbetaRange) -> Int { self.size }

pub fn MathspecialbetaRange::get(self : MathspecialbetaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbetaRange::set(self : MathspecialbetaRange, i : Int, v : Double) -> MathspecialbetaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbetaRange::sum(self : MathspecialbetaRange) -> Double { @_common.sum(self.data) }

pub fn MathspecialbetaRange::mean(self : MathspecialbetaRange) -> Double { @_common.mean(self.data) }

pub fn MathspecialbetaRange::scale(self : MathspecialbetaRange, f : Double) -> MathspecialbetaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaRange::add(self : MathspecialbetaRange, other : MathspecialbetaRange) -> MathspecialbetaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbetaRange::copy(self : MathspecialbetaRange) -> MathspecialbetaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaRange::fill(self : MathspecialbetaRange, v : Double) -> MathspecialbetaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaRange::min(self : MathspecialbetaRange) -> Double { @_common.min(self.data) }

pub fn MathspecialbetaRange::max(self : MathspecialbetaRange) -> Double { @_common.max(self.data) }

pub fn MathspecialbetaRange::to_string(self : MathspecialbetaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialbetaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_beta_slice_make(size : Int) -> MathspecialbetaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialbetaSlice::len(self : MathspecialbetaSlice) -> Int { self.size }

pub fn MathspecialbetaSlice::get(self : MathspecialbetaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialbetaSlice::set(self : MathspecialbetaSlice, i : Int, v : Double) -> MathspecialbetaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialbetaSlice::sum(self : MathspecialbetaSlice) -> Double { @_common.sum(self.data) }

pub fn MathspecialbetaSlice::mean(self : MathspecialbetaSlice) -> Double { @_common.mean(self.data) }

pub fn MathspecialbetaSlice::scale(self : MathspecialbetaSlice, f : Double) -> MathspecialbetaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaSlice::add(self : MathspecialbetaSlice, other : MathspecialbetaSlice) -> MathspecialbetaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialbetaSlice::copy(self : MathspecialbetaSlice) -> MathspecialbetaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaSlice::fill(self : MathspecialbetaSlice, v : Double) -> MathspecialbetaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialbetaSlice::min(self : MathspecialbetaSlice) -> Double { @_common.min(self.data) }

pub fn MathspecialbetaSlice::max(self : MathspecialbetaSlice) -> Double { @_common.max(self.data) }

pub fn MathspecialbetaSlice::to_string(self : MathspecialbetaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

