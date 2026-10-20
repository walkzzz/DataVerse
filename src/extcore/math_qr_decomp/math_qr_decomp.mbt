///===
/// extcore/math_qr_decomp

pub(all) struct MathqrdecompPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_qr_decomp_make_point(x : Double, y : Double) -> MathqrdecompPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_qr_decomp_make_point3(x : Double, y : Double, z : Double) -> MathqrdecompPoint {
  { x, y, z, label: 0 }
}

pub fn MathqrdecompPoint::x(self : MathqrdecompPoint) -> Double { self.x }

pub fn MathqrdecompPoint::y(self : MathqrdecompPoint) -> Double { self.y }

pub fn MathqrdecompPoint::z(self : MathqrdecompPoint) -> Double { self.z }

pub fn MathqrdecompPoint::label(self : MathqrdecompPoint) -> Int { self.label }

pub fn MathqrdecompPoint::dist(self : MathqrdecompPoint, other : MathqrdecompPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathqrdecompPoint::add(self : MathqrdecompPoint, other : MathqrdecompPoint) -> MathqrdecompPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathqrdecompPoint::sub(self : MathqrdecompPoint, other : MathqrdecompPoint) -> MathqrdecompPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathqrdecompPoint::scale(self : MathqrdecompPoint, s : Double) -> MathqrdecompPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathqrdecompPoint::dot(self : MathqrdecompPoint, other : MathqrdecompPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathqrdecompPoint::cross(self : MathqrdecompPoint, other : MathqrdecompPoint) -> MathqrdecompPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathqrdecompPoint::norm(self : MathqrdecompPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathqrdecompPoint::normalize(self : MathqrdecompPoint) -> MathqrdecompPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathqrdecompPoint::negate(self : MathqrdecompPoint) -> MathqrdecompPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathqrdecompPoint::mid(self : MathqrdecompPoint, other : MathqrdecompPoint) -> MathqrdecompPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathqrdecompPoint::lerp(self : MathqrdecompPoint, other : MathqrdecompPoint, t : Double) -> MathqrdecompPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathqrdecompPoint::to_string(self : MathqrdecompPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathqrdecompSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_qr_decomp_make_series(vals : Array[Double], name : String) -> MathqrdecompSeries {
  { vals, name, meta: 0 }
}

pub fn MathqrdecompSeries::len(self : MathqrdecompSeries) -> Int { self.vals.length() }

pub fn MathqrdecompSeries::sum(self : MathqrdecompSeries) -> Double { @_common.sum(self.vals) }

pub fn MathqrdecompSeries::mean(self : MathqrdecompSeries) -> Double { @_common.mean(self.vals) }

pub fn MathqrdecompSeries::min(self : MathqrdecompSeries) -> Double { @_common.min(self.vals) }

pub fn MathqrdecompSeries::max(self : MathqrdecompSeries) -> Double { @_common.max(self.vals) }

pub fn MathqrdecompSeries::range(self : MathqrdecompSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathqrdecompSeries::variance(self : MathqrdecompSeries) -> Double { @_common.variance(self.vals) }

pub fn MathqrdecompSeries::std(self : MathqrdecompSeries) -> Double { @_common.std(self.vals) }

pub fn MathqrdecompSeries::median(self : MathqrdecompSeries) -> Double { @_common.median(self.vals) }

pub fn MathqrdecompSeries::scale(self : MathqrdecompSeries, f : Double) -> MathqrdecompSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathqrdecompSeries::add(self : MathqrdecompSeries, other : MathqrdecompSeries) -> MathqrdecompSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathqrdecompSeries::sub(self : MathqrdecompSeries, other : MathqrdecompSeries) -> MathqrdecompSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathqrdecompSeries::normalize(self : MathqrdecompSeries) -> MathqrdecompSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathqrdecompSeries::cumsum(self : MathqrdecompSeries) -> MathqrdecompSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathqrdecompSeries::to_string(self : MathqrdecompSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathqrdecompMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_qr_decomp_make_matrix(rows : Int, cols : Int, val : Double) -> MathqrdecompMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_qr_decomp_matrix_identity(n : Int) -> MathqrdecompMatrix {
  let m = math_qr_decomp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathqrdecompMatrix::get(self : MathqrdecompMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathqrdecompMatrix::transpose(self : MathqrdecompMatrix) -> MathqrdecompMatrix {
  let result = math_qr_decomp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathqrdecompMatrix::add(self : MathqrdecompMatrix, other : MathqrdecompMatrix) -> MathqrdecompMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_qr_decomp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathqrdecompMatrix::scale(self : MathqrdecompMatrix, s : Double) -> MathqrdecompMatrix {
  let result = math_qr_decomp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathqrdecompMatrix::multiply(self : MathqrdecompMatrix, other : MathqrdecompMatrix) -> MathqrdecompMatrix {
  if self.cols != other.rows { return math_qr_decomp_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_qr_decomp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathqrdecompMatrix::trace(self : MathqrdecompMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathqrdecompMatrix::det(self : MathqrdecompMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathqrdecompMatrix::norm(self : MathqrdecompMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathqrdecompMatrix::to_string(self : MathqrdecompMatrix) -> String {
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

pub(all) struct MathqrdecompVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_qr_decomp_make_vector(comps : Array[Double]) -> MathqrdecompVector {
  { comps, dim: comps.length() }
}

pub fn math_qr_decomp_vector_zero(dim : Int) -> MathqrdecompVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathqrdecompVector::add(self : MathqrdecompVector, other : MathqrdecompVector) -> MathqrdecompVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathqrdecompVector::sub(self : MathqrdecompVector, other : MathqrdecompVector) -> MathqrdecompVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathqrdecompVector::scale(self : MathqrdecompVector, s : Double) -> MathqrdecompVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathqrdecompVector::dot(self : MathqrdecompVector, other : MathqrdecompVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathqrdecompVector::norm(self : MathqrdecompVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathqrdecompVector::normalize(self : MathqrdecompVector) -> MathqrdecompVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathqrdecompVector::dist(self : MathqrdecompVector, other : MathqrdecompVector) -> Double {
  self.sub(other).norm()
}

pub fn MathqrdecompVector::to_string(self : MathqrdecompVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_qr_decomp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_qr_decomp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_qr_decomp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_qr_decomp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_qr_decomp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_qr_decomp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_qr_decomp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_qr_decomp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_qr_decomp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_qr_decomp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_qr_decomp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_qr_decomp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_qr_decomp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_qr_decomp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_qr_decomp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_qr_decomp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_qr_decomp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_qr_decomp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_qr_decomp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_qr_decomp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_qr_decomp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_qr_decomp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_qr_decomp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_qr_decomp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_qr_decomp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_qr_decomp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_qr_decomp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_qr_decomp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_qr_decomp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathqrdecompFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_frame_make(size : Int) -> MathqrdecompFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathqrdecompFrame::len(self : MathqrdecompFrame) -> Int { self.size }

pub fn MathqrdecompFrame::get(self : MathqrdecompFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathqrdecompFrame::set(self : MathqrdecompFrame, i : Int, v : Double) -> MathqrdecompFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathqrdecompFrame::sum(self : MathqrdecompFrame) -> Double { @_common.sum(self.data) }

pub fn MathqrdecompFrame::mean(self : MathqrdecompFrame) -> Double { @_common.mean(self.data) }

pub fn MathqrdecompFrame::scale(self : MathqrdecompFrame, f : Double) -> MathqrdecompFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathqrdecompFrame::add(self : MathqrdecompFrame, other : MathqrdecompFrame) -> MathqrdecompFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathqrdecompFrame::copy(self : MathqrdecompFrame) -> MathqrdecompFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathqrdecompFrame::fill(self : MathqrdecompFrame, v : Double) -> MathqrdecompFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathqrdecompFrame::min(self : MathqrdecompFrame) -> Double { @_common.min(self.data) }

pub fn MathqrdecompFrame::max(self : MathqrdecompFrame) -> Double { @_common.max(self.data) }

pub fn MathqrdecompFrame::to_string(self : MathqrdecompFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathqrdecompTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_table_make(size : Int) -> MathqrdecompTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathqrdecompTable::len(self : MathqrdecompTable) -> Int { self.size }

pub fn MathqrdecompTable::get(self : MathqrdecompTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathqrdecompTable::set(self : MathqrdecompTable, i : Int, v : Double) -> MathqrdecompTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathqrdecompTable::sum(self : MathqrdecompTable) -> Double { @_common.sum(self.data) }

pub fn MathqrdecompTable::mean(self : MathqrdecompTable) -> Double { @_common.mean(self.data) }

pub fn MathqrdecompTable::scale(self : MathqrdecompTable, f : Double) -> MathqrdecompTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathqrdecompTable::add(self : MathqrdecompTable, other : MathqrdecompTable) -> MathqrdecompTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathqrdecompTable::copy(self : MathqrdecompTable) -> MathqrdecompTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathqrdecompTable::fill(self : MathqrdecompTable, v : Double) -> MathqrdecompTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathqrdecompTable::min(self : MathqrdecompTable) -> Double { @_common.min(self.data) }

pub fn MathqrdecompTable::max(self : MathqrdecompTable) -> Double { @_common.max(self.data) }

pub fn MathqrdecompTable::to_string(self : MathqrdecompTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathqrdecompGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_graphn_make(size : Int) -> MathqrdecompGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathqrdecompGraphN::len(self : MathqrdecompGraphN) -> Int { self.size }

pub fn MathqrdecompGraphN::get(self : MathqrdecompGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathqrdecompGraphN::set(self : MathqrdecompGraphN, i : Int, v : Double) -> MathqrdecompGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathqrdecompGraphN::sum(self : MathqrdecompGraphN) -> Double { @_common.sum(self.data) }

pub fn MathqrdecompGraphN::mean(self : MathqrdecompGraphN) -> Double { @_common.mean(self.data) }

pub fn MathqrdecompGraphN::scale(self : MathqrdecompGraphN, f : Double) -> MathqrdecompGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathqrdecompGraphN::add(self : MathqrdecompGraphN, other : MathqrdecompGraphN) -> MathqrdecompGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathqrdecompGraphN::copy(self : MathqrdecompGraphN) -> MathqrdecompGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathqrdecompGraphN::fill(self : MathqrdecompGraphN, v : Double) -> MathqrdecompGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathqrdecompGraphN::min(self : MathqrdecompGraphN) -> Double { @_common.min(self.data) }

pub fn MathqrdecompGraphN::max(self : MathqrdecompGraphN) -> Double { @_common.max(self.data) }

pub fn MathqrdecompGraphN::to_string(self : MathqrdecompGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathqrdecompNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_node_make(size : Int) -> MathqrdecompNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathqrdecompNode::len(self : MathqrdecompNode) -> Int { self.size }

pub fn MathqrdecompNode::get(self : MathqrdecompNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathqrdecompNode::set(self : MathqrdecompNode, i : Int, v : Double) -> MathqrdecompNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathqrdecompNode::sum(self : MathqrdecompNode) -> Double { @_common.sum(self.data) }

pub fn MathqrdecompNode::mean(self : MathqrdecompNode) -> Double { @_common.mean(self.data) }

pub fn MathqrdecompNode::scale(self : MathqrdecompNode, f : Double) -> MathqrdecompNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathqrdecompNode::add(self : MathqrdecompNode, other : MathqrdecompNode) -> MathqrdecompNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathqrdecompNode::copy(self : MathqrdecompNode) -> MathqrdecompNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathqrdecompNode::fill(self : MathqrdecompNode, v : Double) -> MathqrdecompNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathqrdecompNode::min(self : MathqrdecompNode) -> Double { @_common.min(self.data) }

pub fn MathqrdecompNode::max(self : MathqrdecompNode) -> Double { @_common.max(self.data) }

pub fn MathqrdecompNode::to_string(self : MathqrdecompNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathqrdecompEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_edge_make(size : Int) -> MathqrdecompEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathqrdecompEdge::len(self : MathqrdecompEdge) -> Int { self.size }

pub fn MathqrdecompEdge::get(self : MathqrdecompEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathqrdecompEdge::set(self : MathqrdecompEdge, i : Int, v : Double) -> MathqrdecompEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathqrdecompEdge::sum(self : MathqrdecompEdge) -> Double { @_common.sum(self.data) }

pub fn MathqrdecompEdge::mean(self : MathqrdecompEdge) -> Double { @_common.mean(self.data) }

pub fn MathqrdecompEdge::scale(self : MathqrdecompEdge, f : Double) -> MathqrdecompEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathqrdecompEdge::add(self : MathqrdecompEdge, other : MathqrdecompEdge) -> MathqrdecompEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathqrdecompEdge::copy(self : MathqrdecompEdge) -> MathqrdecompEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathqrdecompEdge::fill(self : MathqrdecompEdge, v : Double) -> MathqrdecompEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathqrdecompEdge::min(self : MathqrdecompEdge) -> Double { @_common.min(self.data) }

pub fn MathqrdecompEdge::max(self : MathqrdecompEdge) -> Double { @_common.max(self.data) }

pub fn MathqrdecompEdge::to_string(self : MathqrdecompEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathqrdecompPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_path_make(size : Int) -> MathqrdecompPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathqrdecompPath::len(self : MathqrdecompPath) -> Int { self.size }

pub fn MathqrdecompPath::get(self : MathqrdecompPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathqrdecompPath::set(self : MathqrdecompPath, i : Int, v : Double) -> MathqrdecompPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathqrdecompPath::sum(self : MathqrdecompPath) -> Double { @_common.sum(self.data) }

pub fn MathqrdecompPath::mean(self : MathqrdecompPath) -> Double { @_common.mean(self.data) }

pub fn MathqrdecompPath::scale(self : MathqrdecompPath, f : Double) -> MathqrdecompPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathqrdecompPath::add(self : MathqrdecompPath, other : MathqrdecompPath) -> MathqrdecompPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathqrdecompPath::copy(self : MathqrdecompPath) -> MathqrdecompPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathqrdecompPath::fill(self : MathqrdecompPath, v : Double) -> MathqrdecompPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathqrdecompPath::min(self : MathqrdecompPath) -> Double { @_common.min(self.data) }

pub fn MathqrdecompPath::max(self : MathqrdecompPath) -> Double { @_common.max(self.data) }

pub fn MathqrdecompPath::to_string(self : MathqrdecompPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathqrdecompCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_cluster_make(size : Int) -> MathqrdecompCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathqrdecompCluster::len(self : MathqrdecompCluster) -> Int { self.size }

pub fn MathqrdecompCluster::get(self : MathqrdecompCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathqrdecompCluster::set(self : MathqrdecompCluster, i : Int, v : Double) -> MathqrdecompCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathqrdecompCluster::sum(self : MathqrdecompCluster) -> Double { @_common.sum(self.data) }

pub fn MathqrdecompCluster::mean(self : MathqrdecompCluster) -> Double { @_common.mean(self.data) }

pub fn MathqrdecompCluster::scale(self : MathqrdecompCluster, f : Double) -> MathqrdecompCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathqrdecompCluster::add(self : MathqrdecompCluster, other : MathqrdecompCluster) -> MathqrdecompCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathqrdecompCluster::copy(self : MathqrdecompCluster) -> MathqrdecompCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathqrdecompCluster::fill(self : MathqrdecompCluster, v : Double) -> MathqrdecompCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathqrdecompCluster::min(self : MathqrdecompCluster) -> Double { @_common.min(self.data) }

pub fn MathqrdecompCluster::max(self : MathqrdecompCluster) -> Double { @_common.max(self.data) }

pub fn MathqrdecompCluster::to_string(self : MathqrdecompCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathqrdecompModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_model_make(size : Int) -> MathqrdecompModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathqrdecompModel::len(self : MathqrdecompModel) -> Int { self.size }

pub fn MathqrdecompModel::get(self : MathqrdecompModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathqrdecompModel::set(self : MathqrdecompModel, i : Int, v : Double) -> MathqrdecompModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathqrdecompModel::sum(self : MathqrdecompModel) -> Double { @_common.sum(self.data) }

pub fn MathqrdecompModel::mean(self : MathqrdecompModel) -> Double { @_common.mean(self.data) }

pub fn MathqrdecompModel::scale(self : MathqrdecompModel, f : Double) -> MathqrdecompModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathqrdecompModel::add(self : MathqrdecompModel, other : MathqrdecompModel) -> MathqrdecompModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathqrdecompModel::copy(self : MathqrdecompModel) -> MathqrdecompModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathqrdecompModel::fill(self : MathqrdecompModel, v : Double) -> MathqrdecompModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathqrdecompModel::min(self : MathqrdecompModel) -> Double { @_common.min(self.data) }

pub fn MathqrdecompModel::max(self : MathqrdecompModel) -> Double { @_common.max(self.data) }

pub fn MathqrdecompModel::to_string(self : MathqrdecompModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathqrdecompLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_layer_make(size : Int) -> MathqrdecompLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathqrdecompLayer::len(self : MathqrdecompLayer) -> Int { self.size }

pub fn MathqrdecompLayer::get(self : MathqrdecompLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathqrdecompLayer::set(self : MathqrdecompLayer, i : Int, v : Double) -> MathqrdecompLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathqrdecompLayer::sum(self : MathqrdecompLayer) -> Double { @_common.sum(self.data) }

pub fn MathqrdecompLayer::mean(self : MathqrdecompLayer) -> Double { @_common.mean(self.data) }

pub fn MathqrdecompLayer::scale(self : MathqrdecompLayer, f : Double) -> MathqrdecompLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathqrdecompLayer::add(self : MathqrdecompLayer, other : MathqrdecompLayer) -> MathqrdecompLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathqrdecompLayer::copy(self : MathqrdecompLayer) -> MathqrdecompLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathqrdecompLayer::fill(self : MathqrdecompLayer, v : Double) -> MathqrdecompLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathqrdecompLayer::min(self : MathqrdecompLayer) -> Double { @_common.min(self.data) }

pub fn MathqrdecompLayer::max(self : MathqrdecompLayer) -> Double { @_common.max(self.data) }

pub fn MathqrdecompLayer::to_string(self : MathqrdecompLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathqrdecompBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_buffer_make(size : Int) -> MathqrdecompBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathqrdecompBuffer::len(self : MathqrdecompBuffer) -> Int { self.size }

pub fn MathqrdecompBuffer::get(self : MathqrdecompBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathqrdecompBuffer::set(self : MathqrdecompBuffer, i : Int, v : Double) -> MathqrdecompBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathqrdecompBuffer::sum(self : MathqrdecompBuffer) -> Double { @_common.sum(self.data) }

pub fn MathqrdecompBuffer::mean(self : MathqrdecompBuffer) -> Double { @_common.mean(self.data) }

pub fn MathqrdecompBuffer::scale(self : MathqrdecompBuffer, f : Double) -> MathqrdecompBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathqrdecompBuffer::add(self : MathqrdecompBuffer, other : MathqrdecompBuffer) -> MathqrdecompBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathqrdecompBuffer::copy(self : MathqrdecompBuffer) -> MathqrdecompBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathqrdecompBuffer::fill(self : MathqrdecompBuffer, v : Double) -> MathqrdecompBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathqrdecompBuffer::min(self : MathqrdecompBuffer) -> Double { @_common.min(self.data) }

pub fn MathqrdecompBuffer::max(self : MathqrdecompBuffer) -> Double { @_common.max(self.data) }

pub fn MathqrdecompBuffer::to_string(self : MathqrdecompBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathqrdecompCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_cursor_make(size : Int) -> MathqrdecompCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathqrdecompCursor::len(self : MathqrdecompCursor) -> Int { self.size }

pub fn MathqrdecompCursor::get(self : MathqrdecompCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathqrdecompCursor::set(self : MathqrdecompCursor, i : Int, v : Double) -> MathqrdecompCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathqrdecompCursor::sum(self : MathqrdecompCursor) -> Double { @_common.sum(self.data) }

pub fn MathqrdecompCursor::mean(self : MathqrdecompCursor) -> Double { @_common.mean(self.data) }

pub fn MathqrdecompCursor::scale(self : MathqrdecompCursor, f : Double) -> MathqrdecompCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathqrdecompCursor::add(self : MathqrdecompCursor, other : MathqrdecompCursor) -> MathqrdecompCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathqrdecompCursor::copy(self : MathqrdecompCursor) -> MathqrdecompCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathqrdecompCursor::fill(self : MathqrdecompCursor, v : Double) -> MathqrdecompCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathqrdecompCursor::min(self : MathqrdecompCursor) -> Double { @_common.min(self.data) }

pub fn MathqrdecompCursor::max(self : MathqrdecompCursor) -> Double { @_common.max(self.data) }

pub fn MathqrdecompCursor::to_string(self : MathqrdecompCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathqrdecompView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_view_make(size : Int) -> MathqrdecompView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathqrdecompView::len(self : MathqrdecompView) -> Int { self.size }

pub fn MathqrdecompView::get(self : MathqrdecompView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathqrdecompView::set(self : MathqrdecompView, i : Int, v : Double) -> MathqrdecompView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathqrdecompView::sum(self : MathqrdecompView) -> Double { @_common.sum(self.data) }

pub fn MathqrdecompView::mean(self : MathqrdecompView) -> Double { @_common.mean(self.data) }

pub fn MathqrdecompView::scale(self : MathqrdecompView, f : Double) -> MathqrdecompView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathqrdecompView::add(self : MathqrdecompView, other : MathqrdecompView) -> MathqrdecompView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathqrdecompView::copy(self : MathqrdecompView) -> MathqrdecompView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathqrdecompView::fill(self : MathqrdecompView, v : Double) -> MathqrdecompView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathqrdecompView::min(self : MathqrdecompView) -> Double { @_common.min(self.data) }

pub fn MathqrdecompView::max(self : MathqrdecompView) -> Double { @_common.max(self.data) }

pub fn MathqrdecompView::to_string(self : MathqrdecompView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathqrdecompRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_range_make(size : Int) -> MathqrdecompRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathqrdecompRange::len(self : MathqrdecompRange) -> Int { self.size }

pub fn MathqrdecompRange::get(self : MathqrdecompRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathqrdecompRange::set(self : MathqrdecompRange, i : Int, v : Double) -> MathqrdecompRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathqrdecompRange::sum(self : MathqrdecompRange) -> Double { @_common.sum(self.data) }

pub fn MathqrdecompRange::mean(self : MathqrdecompRange) -> Double { @_common.mean(self.data) }

pub fn MathqrdecompRange::scale(self : MathqrdecompRange, f : Double) -> MathqrdecompRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathqrdecompRange::add(self : MathqrdecompRange, other : MathqrdecompRange) -> MathqrdecompRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathqrdecompRange::copy(self : MathqrdecompRange) -> MathqrdecompRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathqrdecompRange::fill(self : MathqrdecompRange, v : Double) -> MathqrdecompRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathqrdecompRange::min(self : MathqrdecompRange) -> Double { @_common.min(self.data) }

pub fn MathqrdecompRange::max(self : MathqrdecompRange) -> Double { @_common.max(self.data) }

pub fn MathqrdecompRange::to_string(self : MathqrdecompRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MathqrdecompSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_slice_make(size : Int) -> MathqrdecompSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MathqrdecompSlice::len(self : MathqrdecompSlice) -> Int { self.size }

pub fn MathqrdecompSlice::get(self : MathqrdecompSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MathqrdecompSlice::set(self : MathqrdecompSlice, i : Int, v : Double) -> MathqrdecompSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MathqrdecompSlice::sum(self : MathqrdecompSlice) -> Double { @_common.sum(self.data) }

pub fn MathqrdecompSlice::mean(self : MathqrdecompSlice) -> Double { @_common.mean(self.data) }

pub fn MathqrdecompSlice::scale(self : MathqrdecompSlice, f : Double) -> MathqrdecompSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MathqrdecompSlice::add(self : MathqrdecompSlice, other : MathqrdecompSlice) -> MathqrdecompSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MathqrdecompSlice::copy(self : MathqrdecompSlice) -> MathqrdecompSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MathqrdecompSlice::fill(self : MathqrdecompSlice, v : Double) -> MathqrdecompSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MathqrdecompSlice::min(self : MathqrdecompSlice) -> Double { @_common.min(self.data) }

pub fn MathqrdecompSlice::max(self : MathqrdecompSlice) -> Double { @_common.max(self.data) }

pub fn MathqrdecompSlice::to_string(self : MathqrdecompSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

