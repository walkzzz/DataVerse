///===
/// extcore/math_special_hermite

pub(all) struct MathspecialhermitePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_hermite_make_point(x : Double, y : Double) -> MathspecialhermitePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_hermite_make_point3(x : Double, y : Double, z : Double) -> MathspecialhermitePoint {
  { x, y, z, label: 0 }
}

pub fn MathspecialhermitePoint::x(self : MathspecialhermitePoint) -> Double { self.x }

pub fn MathspecialhermitePoint::y(self : MathspecialhermitePoint) -> Double { self.y }

pub fn MathspecialhermitePoint::z(self : MathspecialhermitePoint) -> Double { self.z }

pub fn MathspecialhermitePoint::label(self : MathspecialhermitePoint) -> Int { self.label }

pub fn MathspecialhermitePoint::dist(self : MathspecialhermitePoint, other : MathspecialhermitePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspecialhermitePoint::add(self : MathspecialhermitePoint, other : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspecialhermitePoint::sub(self : MathspecialhermitePoint, other : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspecialhermitePoint::scale(self : MathspecialhermitePoint, s : Double) -> MathspecialhermitePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspecialhermitePoint::dot(self : MathspecialhermitePoint, other : MathspecialhermitePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspecialhermitePoint::cross(self : MathspecialhermitePoint, other : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspecialhermitePoint::norm(self : MathspecialhermitePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspecialhermitePoint::normalize(self : MathspecialhermitePoint) -> MathspecialhermitePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialhermitePoint::negate(self : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspecialhermitePoint::mid(self : MathspecialhermitePoint, other : MathspecialhermitePoint) -> MathspecialhermitePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspecialhermitePoint::lerp(self : MathspecialhermitePoint, other : MathspecialhermitePoint, t : Double) -> MathspecialhermitePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspecialhermitePoint::to_string(self : MathspecialhermitePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspecialhermiteSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_hermite_make_series(vals : Array[Double], name : String) -> MathspecialhermiteSeries {
  { vals, name, meta: 0 }
}

pub fn MathspecialhermiteSeries::len(self : MathspecialhermiteSeries) -> Int { self.vals.length() }

pub fn MathspecialhermiteSeries::sum(self : MathspecialhermiteSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspecialhermiteSeries::mean(self : MathspecialhermiteSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspecialhermiteSeries::min(self : MathspecialhermiteSeries) -> Double { @_common.min(self.vals) }

pub fn MathspecialhermiteSeries::max(self : MathspecialhermiteSeries) -> Double { @_common.max(self.vals) }

pub fn MathspecialhermiteSeries::range(self : MathspecialhermiteSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspecialhermiteSeries::variance(self : MathspecialhermiteSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspecialhermiteSeries::std(self : MathspecialhermiteSeries) -> Double { @_common.std(self.vals) }

pub fn MathspecialhermiteSeries::median(self : MathspecialhermiteSeries) -> Double { @_common.median(self.vals) }

pub fn MathspecialhermiteSeries::scale(self : MathspecialhermiteSeries, f : Double) -> MathspecialhermiteSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspecialhermiteSeries::add(self : MathspecialhermiteSeries, other : MathspecialhermiteSeries) -> MathspecialhermiteSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspecialhermiteSeries::sub(self : MathspecialhermiteSeries, other : MathspecialhermiteSeries) -> MathspecialhermiteSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspecialhermiteSeries::normalize(self : MathspecialhermiteSeries) -> MathspecialhermiteSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspecialhermiteSeries::cumsum(self : MathspecialhermiteSeries) -> MathspecialhermiteSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspecialhermiteSeries::to_string(self : MathspecialhermiteSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialhermiteMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_hermite_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialhermiteMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_hermite_matrix_identity(n : Int) -> MathspecialhermiteMatrix {
  let m = math_special_hermite_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspecialhermiteMatrix::get(self : MathspecialhermiteMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspecialhermiteMatrix::transpose(self : MathspecialhermiteMatrix) -> MathspecialhermiteMatrix {
  let result = math_special_hermite_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspecialhermiteMatrix::add(self : MathspecialhermiteMatrix, other : MathspecialhermiteMatrix) -> MathspecialhermiteMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_hermite_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspecialhermiteMatrix::scale(self : MathspecialhermiteMatrix, s : Double) -> MathspecialhermiteMatrix {
  let result = math_special_hermite_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspecialhermiteMatrix::multiply(self : MathspecialhermiteMatrix, other : MathspecialhermiteMatrix) -> MathspecialhermiteMatrix {
  if self.cols != other.rows { return math_special_hermite_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_hermite_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathspecialhermiteMatrix::trace(self : MathspecialhermiteMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspecialhermiteMatrix::det(self : MathspecialhermiteMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspecialhermiteMatrix::norm(self : MathspecialhermiteMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspecialhermiteMatrix::to_string(self : MathspecialhermiteMatrix) -> String {
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

pub(all) struct MathspecialhermiteVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_hermite_make_vector(comps : Array[Double]) -> MathspecialhermiteVector {
  { comps, dim: comps.length() }
}

pub fn math_special_hermite_vector_zero(dim : Int) -> MathspecialhermiteVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspecialhermiteVector::add(self : MathspecialhermiteVector, other : MathspecialhermiteVector) -> MathspecialhermiteVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialhermiteVector::sub(self : MathspecialhermiteVector, other : MathspecialhermiteVector) -> MathspecialhermiteVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialhermiteVector::scale(self : MathspecialhermiteVector, s : Double) -> MathspecialhermiteVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspecialhermiteVector::dot(self : MathspecialhermiteVector, other : MathspecialhermiteVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspecialhermiteVector::norm(self : MathspecialhermiteVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspecialhermiteVector::normalize(self : MathspecialhermiteVector) -> MathspecialhermiteVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialhermiteVector::dist(self : MathspecialhermiteVector, other : MathspecialhermiteVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspecialhermiteVector::to_string(self : MathspecialhermiteVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_hermite_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_hermite_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_hermite_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_hermite_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_hermite_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_hermite_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_hermite_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_hermite_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_hermite_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_hermite_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_hermite_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_hermite_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_hermite_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_hermite_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_hermite_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_hermite_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_hermite_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_hermite_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_hermite_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_hermite_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_hermite_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_hermite_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_hermite_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_hermite_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_hermite_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_hermite_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_hermite_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_hermite_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_hermite_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialhermiteFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_frame_make(size : Int) -> MathspecialhermiteFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialhermiteFrame::len(self : MathspecialhermiteFrame) -> Int { self.size }

pub fn MathspecialhermiteFrame::get(self : MathspecialhermiteFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialhermiteFrame::set(self : MathspecialhermiteFrame, i : Int, v : Double) -> MathspecialhermiteFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteFrame::sum(self : MathspecialhermiteFrame) -> Double { @_common.sum(self.data) }

pub fn MathspecialhermiteFrame::mean(self : MathspecialhermiteFrame) -> Double { @_common.mean(self.data) }

pub fn MathspecialhermiteFrame::scale(self : MathspecialhermiteFrame, f : Double) -> MathspecialhermiteFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteFrame::add(self : MathspecialhermiteFrame, other : MathspecialhermiteFrame) -> MathspecialhermiteFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialhermiteFrame::copy(self : MathspecialhermiteFrame) -> MathspecialhermiteFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteFrame::fill(self : MathspecialhermiteFrame, v : Double) -> MathspecialhermiteFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteFrame::min(self : MathspecialhermiteFrame) -> Double { @_common.min(self.data) }

pub fn MathspecialhermiteFrame::max(self : MathspecialhermiteFrame) -> Double { @_common.max(self.data) }

pub fn MathspecialhermiteFrame::to_string(self : MathspecialhermiteFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_table_make(size : Int) -> MathspecialhermiteTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialhermiteTable::len(self : MathspecialhermiteTable) -> Int { self.size }

pub fn MathspecialhermiteTable::get(self : MathspecialhermiteTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialhermiteTable::set(self : MathspecialhermiteTable, i : Int, v : Double) -> MathspecialhermiteTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteTable::sum(self : MathspecialhermiteTable) -> Double { @_common.sum(self.data) }

pub fn MathspecialhermiteTable::mean(self : MathspecialhermiteTable) -> Double { @_common.mean(self.data) }

pub fn MathspecialhermiteTable::scale(self : MathspecialhermiteTable, f : Double) -> MathspecialhermiteTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteTable::add(self : MathspecialhermiteTable, other : MathspecialhermiteTable) -> MathspecialhermiteTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialhermiteTable::copy(self : MathspecialhermiteTable) -> MathspecialhermiteTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteTable::fill(self : MathspecialhermiteTable, v : Double) -> MathspecialhermiteTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteTable::min(self : MathspecialhermiteTable) -> Double { @_common.min(self.data) }

pub fn MathspecialhermiteTable::max(self : MathspecialhermiteTable) -> Double { @_common.max(self.data) }

pub fn MathspecialhermiteTable::to_string(self : MathspecialhermiteTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_graphn_make(size : Int) -> MathspecialhermiteGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialhermiteGraphN::len(self : MathspecialhermiteGraphN) -> Int { self.size }

pub fn MathspecialhermiteGraphN::get(self : MathspecialhermiteGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialhermiteGraphN::set(self : MathspecialhermiteGraphN, i : Int, v : Double) -> MathspecialhermiteGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteGraphN::sum(self : MathspecialhermiteGraphN) -> Double { @_common.sum(self.data) }

pub fn MathspecialhermiteGraphN::mean(self : MathspecialhermiteGraphN) -> Double { @_common.mean(self.data) }

pub fn MathspecialhermiteGraphN::scale(self : MathspecialhermiteGraphN, f : Double) -> MathspecialhermiteGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteGraphN::add(self : MathspecialhermiteGraphN, other : MathspecialhermiteGraphN) -> MathspecialhermiteGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialhermiteGraphN::copy(self : MathspecialhermiteGraphN) -> MathspecialhermiteGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteGraphN::fill(self : MathspecialhermiteGraphN, v : Double) -> MathspecialhermiteGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteGraphN::min(self : MathspecialhermiteGraphN) -> Double { @_common.min(self.data) }

pub fn MathspecialhermiteGraphN::max(self : MathspecialhermiteGraphN) -> Double { @_common.max(self.data) }

pub fn MathspecialhermiteGraphN::to_string(self : MathspecialhermiteGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_node_make(size : Int) -> MathspecialhermiteNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialhermiteNode::len(self : MathspecialhermiteNode) -> Int { self.size }

pub fn MathspecialhermiteNode::get(self : MathspecialhermiteNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialhermiteNode::set(self : MathspecialhermiteNode, i : Int, v : Double) -> MathspecialhermiteNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteNode::sum(self : MathspecialhermiteNode) -> Double { @_common.sum(self.data) }

pub fn MathspecialhermiteNode::mean(self : MathspecialhermiteNode) -> Double { @_common.mean(self.data) }

pub fn MathspecialhermiteNode::scale(self : MathspecialhermiteNode, f : Double) -> MathspecialhermiteNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteNode::add(self : MathspecialhermiteNode, other : MathspecialhermiteNode) -> MathspecialhermiteNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialhermiteNode::copy(self : MathspecialhermiteNode) -> MathspecialhermiteNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteNode::fill(self : MathspecialhermiteNode, v : Double) -> MathspecialhermiteNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteNode::min(self : MathspecialhermiteNode) -> Double { @_common.min(self.data) }

pub fn MathspecialhermiteNode::max(self : MathspecialhermiteNode) -> Double { @_common.max(self.data) }

pub fn MathspecialhermiteNode::to_string(self : MathspecialhermiteNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_edge_make(size : Int) -> MathspecialhermiteEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialhermiteEdge::len(self : MathspecialhermiteEdge) -> Int { self.size }

pub fn MathspecialhermiteEdge::get(self : MathspecialhermiteEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialhermiteEdge::set(self : MathspecialhermiteEdge, i : Int, v : Double) -> MathspecialhermiteEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteEdge::sum(self : MathspecialhermiteEdge) -> Double { @_common.sum(self.data) }

pub fn MathspecialhermiteEdge::mean(self : MathspecialhermiteEdge) -> Double { @_common.mean(self.data) }

pub fn MathspecialhermiteEdge::scale(self : MathspecialhermiteEdge, f : Double) -> MathspecialhermiteEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteEdge::add(self : MathspecialhermiteEdge, other : MathspecialhermiteEdge) -> MathspecialhermiteEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialhermiteEdge::copy(self : MathspecialhermiteEdge) -> MathspecialhermiteEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteEdge::fill(self : MathspecialhermiteEdge, v : Double) -> MathspecialhermiteEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteEdge::min(self : MathspecialhermiteEdge) -> Double { @_common.min(self.data) }

pub fn MathspecialhermiteEdge::max(self : MathspecialhermiteEdge) -> Double { @_common.max(self.data) }

pub fn MathspecialhermiteEdge::to_string(self : MathspecialhermiteEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialhermitePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_path_make(size : Int) -> MathspecialhermitePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialhermitePath::len(self : MathspecialhermitePath) -> Int { self.size }

pub fn MathspecialhermitePath::get(self : MathspecialhermitePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialhermitePath::set(self : MathspecialhermitePath, i : Int, v : Double) -> MathspecialhermitePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialhermitePath::sum(self : MathspecialhermitePath) -> Double { @_common.sum(self.data) }

pub fn MathspecialhermitePath::mean(self : MathspecialhermitePath) -> Double { @_common.mean(self.data) }

pub fn MathspecialhermitePath::scale(self : MathspecialhermitePath, f : Double) -> MathspecialhermitePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialhermitePath::add(self : MathspecialhermitePath, other : MathspecialhermitePath) -> MathspecialhermitePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialhermitePath::copy(self : MathspecialhermitePath) -> MathspecialhermitePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialhermitePath::fill(self : MathspecialhermitePath, v : Double) -> MathspecialhermitePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialhermitePath::min(self : MathspecialhermitePath) -> Double { @_common.min(self.data) }

pub fn MathspecialhermitePath::max(self : MathspecialhermitePath) -> Double { @_common.max(self.data) }

pub fn MathspecialhermitePath::to_string(self : MathspecialhermitePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_cluster_make(size : Int) -> MathspecialhermiteCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialhermiteCluster::len(self : MathspecialhermiteCluster) -> Int { self.size }

pub fn MathspecialhermiteCluster::get(self : MathspecialhermiteCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialhermiteCluster::set(self : MathspecialhermiteCluster, i : Int, v : Double) -> MathspecialhermiteCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteCluster::sum(self : MathspecialhermiteCluster) -> Double { @_common.sum(self.data) }

pub fn MathspecialhermiteCluster::mean(self : MathspecialhermiteCluster) -> Double { @_common.mean(self.data) }

pub fn MathspecialhermiteCluster::scale(self : MathspecialhermiteCluster, f : Double) -> MathspecialhermiteCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteCluster::add(self : MathspecialhermiteCluster, other : MathspecialhermiteCluster) -> MathspecialhermiteCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialhermiteCluster::copy(self : MathspecialhermiteCluster) -> MathspecialhermiteCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteCluster::fill(self : MathspecialhermiteCluster, v : Double) -> MathspecialhermiteCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteCluster::min(self : MathspecialhermiteCluster) -> Double { @_common.min(self.data) }

pub fn MathspecialhermiteCluster::max(self : MathspecialhermiteCluster) -> Double { @_common.max(self.data) }

pub fn MathspecialhermiteCluster::to_string(self : MathspecialhermiteCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_model_make(size : Int) -> MathspecialhermiteModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialhermiteModel::len(self : MathspecialhermiteModel) -> Int { self.size }

pub fn MathspecialhermiteModel::get(self : MathspecialhermiteModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialhermiteModel::set(self : MathspecialhermiteModel, i : Int, v : Double) -> MathspecialhermiteModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteModel::sum(self : MathspecialhermiteModel) -> Double { @_common.sum(self.data) }

pub fn MathspecialhermiteModel::mean(self : MathspecialhermiteModel) -> Double { @_common.mean(self.data) }

pub fn MathspecialhermiteModel::scale(self : MathspecialhermiteModel, f : Double) -> MathspecialhermiteModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteModel::add(self : MathspecialhermiteModel, other : MathspecialhermiteModel) -> MathspecialhermiteModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialhermiteModel::copy(self : MathspecialhermiteModel) -> MathspecialhermiteModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteModel::fill(self : MathspecialhermiteModel, v : Double) -> MathspecialhermiteModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteModel::min(self : MathspecialhermiteModel) -> Double { @_common.min(self.data) }

pub fn MathspecialhermiteModel::max(self : MathspecialhermiteModel) -> Double { @_common.max(self.data) }

pub fn MathspecialhermiteModel::to_string(self : MathspecialhermiteModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_layer_make(size : Int) -> MathspecialhermiteLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialhermiteLayer::len(self : MathspecialhermiteLayer) -> Int { self.size }

pub fn MathspecialhermiteLayer::get(self : MathspecialhermiteLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialhermiteLayer::set(self : MathspecialhermiteLayer, i : Int, v : Double) -> MathspecialhermiteLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteLayer::sum(self : MathspecialhermiteLayer) -> Double { @_common.sum(self.data) }

pub fn MathspecialhermiteLayer::mean(self : MathspecialhermiteLayer) -> Double { @_common.mean(self.data) }

pub fn MathspecialhermiteLayer::scale(self : MathspecialhermiteLayer, f : Double) -> MathspecialhermiteLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteLayer::add(self : MathspecialhermiteLayer, other : MathspecialhermiteLayer) -> MathspecialhermiteLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialhermiteLayer::copy(self : MathspecialhermiteLayer) -> MathspecialhermiteLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteLayer::fill(self : MathspecialhermiteLayer, v : Double) -> MathspecialhermiteLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteLayer::min(self : MathspecialhermiteLayer) -> Double { @_common.min(self.data) }

pub fn MathspecialhermiteLayer::max(self : MathspecialhermiteLayer) -> Double { @_common.max(self.data) }

pub fn MathspecialhermiteLayer::to_string(self : MathspecialhermiteLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_buffer_make(size : Int) -> MathspecialhermiteBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialhermiteBuffer::len(self : MathspecialhermiteBuffer) -> Int { self.size }

pub fn MathspecialhermiteBuffer::get(self : MathspecialhermiteBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialhermiteBuffer::set(self : MathspecialhermiteBuffer, i : Int, v : Double) -> MathspecialhermiteBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteBuffer::sum(self : MathspecialhermiteBuffer) -> Double { @_common.sum(self.data) }

pub fn MathspecialhermiteBuffer::mean(self : MathspecialhermiteBuffer) -> Double { @_common.mean(self.data) }

pub fn MathspecialhermiteBuffer::scale(self : MathspecialhermiteBuffer, f : Double) -> MathspecialhermiteBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteBuffer::add(self : MathspecialhermiteBuffer, other : MathspecialhermiteBuffer) -> MathspecialhermiteBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialhermiteBuffer::copy(self : MathspecialhermiteBuffer) -> MathspecialhermiteBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteBuffer::fill(self : MathspecialhermiteBuffer, v : Double) -> MathspecialhermiteBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteBuffer::min(self : MathspecialhermiteBuffer) -> Double { @_common.min(self.data) }

pub fn MathspecialhermiteBuffer::max(self : MathspecialhermiteBuffer) -> Double { @_common.max(self.data) }

pub fn MathspecialhermiteBuffer::to_string(self : MathspecialhermiteBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_cursor_make(size : Int) -> MathspecialhermiteCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialhermiteCursor::len(self : MathspecialhermiteCursor) -> Int { self.size }

pub fn MathspecialhermiteCursor::get(self : MathspecialhermiteCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialhermiteCursor::set(self : MathspecialhermiteCursor, i : Int, v : Double) -> MathspecialhermiteCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteCursor::sum(self : MathspecialhermiteCursor) -> Double { @_common.sum(self.data) }

pub fn MathspecialhermiteCursor::mean(self : MathspecialhermiteCursor) -> Double { @_common.mean(self.data) }

pub fn MathspecialhermiteCursor::scale(self : MathspecialhermiteCursor, f : Double) -> MathspecialhermiteCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteCursor::add(self : MathspecialhermiteCursor, other : MathspecialhermiteCursor) -> MathspecialhermiteCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialhermiteCursor::copy(self : MathspecialhermiteCursor) -> MathspecialhermiteCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteCursor::fill(self : MathspecialhermiteCursor, v : Double) -> MathspecialhermiteCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteCursor::min(self : MathspecialhermiteCursor) -> Double { @_common.min(self.data) }

pub fn MathspecialhermiteCursor::max(self : MathspecialhermiteCursor) -> Double { @_common.max(self.data) }

pub fn MathspecialhermiteCursor::to_string(self : MathspecialhermiteCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_view_make(size : Int) -> MathspecialhermiteView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialhermiteView::len(self : MathspecialhermiteView) -> Int { self.size }

pub fn MathspecialhermiteView::get(self : MathspecialhermiteView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialhermiteView::set(self : MathspecialhermiteView, i : Int, v : Double) -> MathspecialhermiteView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteView::sum(self : MathspecialhermiteView) -> Double { @_common.sum(self.data) }

pub fn MathspecialhermiteView::mean(self : MathspecialhermiteView) -> Double { @_common.mean(self.data) }

pub fn MathspecialhermiteView::scale(self : MathspecialhermiteView, f : Double) -> MathspecialhermiteView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteView::add(self : MathspecialhermiteView, other : MathspecialhermiteView) -> MathspecialhermiteView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialhermiteView::copy(self : MathspecialhermiteView) -> MathspecialhermiteView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteView::fill(self : MathspecialhermiteView, v : Double) -> MathspecialhermiteView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteView::min(self : MathspecialhermiteView) -> Double { @_common.min(self.data) }

pub fn MathspecialhermiteView::max(self : MathspecialhermiteView) -> Double { @_common.max(self.data) }

pub fn MathspecialhermiteView::to_string(self : MathspecialhermiteView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_range_make(size : Int) -> MathspecialhermiteRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialhermiteRange::len(self : MathspecialhermiteRange) -> Int { self.size }

pub fn MathspecialhermiteRange::get(self : MathspecialhermiteRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialhermiteRange::set(self : MathspecialhermiteRange, i : Int, v : Double) -> MathspecialhermiteRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteRange::sum(self : MathspecialhermiteRange) -> Double { @_common.sum(self.data) }

pub fn MathspecialhermiteRange::mean(self : MathspecialhermiteRange) -> Double { @_common.mean(self.data) }

pub fn MathspecialhermiteRange::scale(self : MathspecialhermiteRange, f : Double) -> MathspecialhermiteRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteRange::add(self : MathspecialhermiteRange, other : MathspecialhermiteRange) -> MathspecialhermiteRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialhermiteRange::copy(self : MathspecialhermiteRange) -> MathspecialhermiteRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteRange::fill(self : MathspecialhermiteRange, v : Double) -> MathspecialhermiteRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteRange::min(self : MathspecialhermiteRange) -> Double { @_common.min(self.data) }

pub fn MathspecialhermiteRange::max(self : MathspecialhermiteRange) -> Double { @_common.max(self.data) }

pub fn MathspecialhermiteRange::to_string(self : MathspecialhermiteRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathspecialhermiteSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_hermite_slice_make(size : Int) -> MathspecialhermiteSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathspecialhermiteSlice::len(self : MathspecialhermiteSlice) -> Int { self.size }

pub fn MathspecialhermiteSlice::get(self : MathspecialhermiteSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathspecialhermiteSlice::set(self : MathspecialhermiteSlice, i : Int, v : Double) -> MathspecialhermiteSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteSlice::sum(self : MathspecialhermiteSlice) -> Double { @_common.sum(self.data) }

pub fn MathspecialhermiteSlice::mean(self : MathspecialhermiteSlice) -> Double { @_common.mean(self.data) }

pub fn MathspecialhermiteSlice::scale(self : MathspecialhermiteSlice, f : Double) -> MathspecialhermiteSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteSlice::add(self : MathspecialhermiteSlice, other : MathspecialhermiteSlice) -> MathspecialhermiteSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathspecialhermiteSlice::copy(self : MathspecialhermiteSlice) -> MathspecialhermiteSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteSlice::fill(self : MathspecialhermiteSlice, v : Double) -> MathspecialhermiteSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathspecialhermiteSlice::min(self : MathspecialhermiteSlice) -> Double { @_common.min(self.data) }

pub fn MathspecialhermiteSlice::max(self : MathspecialhermiteSlice) -> Double { @_common.max(self.data) }

pub fn MathspecialhermiteSlice::to_string(self : MathspecialhermiteSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

