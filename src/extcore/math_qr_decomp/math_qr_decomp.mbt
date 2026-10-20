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

pub fn math_qr_decomp_frame_len(s : MathqrdecompFrame) -> Int { s.size }

pub fn math_qr_decomp_frame_get(s : MathqrdecompFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_frame_set(s : MathqrdecompFrame, i : Int, v : Double) -> MathqrdecompFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_frame_sum(s : MathqrdecompFrame) -> Double { @_common.sum(s.data) }

pub fn math_qr_decomp_frame_mean(s : MathqrdecompFrame) -> Double { @_common.mean(s.data) }

pub fn math_qr_decomp_frame_scale(s : MathqrdecompFrame, f : Double) -> MathqrdecompFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_frame_add(a : MathqrdecompFrame, b : MathqrdecompFrame) -> MathqrdecompFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_qr_decomp_frame_copy(s : MathqrdecompFrame) -> MathqrdecompFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_frame_fill(s : MathqrdecompFrame, v : Double) -> MathqrdecompFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_frame_min(s : MathqrdecompFrame) -> Double { @_common.min(s.data) }

pub fn math_qr_decomp_frame_max(s : MathqrdecompFrame) -> Double { @_common.max(s.data) }

pub fn math_qr_decomp_frame_to_string(s : MathqrdecompFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_table_make(size : Int) -> MathqrdecompTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_table_len(s : MathqrdecompTable) -> Int { s.size }

pub fn math_qr_decomp_table_get(s : MathqrdecompTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_table_set(s : MathqrdecompTable, i : Int, v : Double) -> MathqrdecompTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_table_sum(s : MathqrdecompTable) -> Double { @_common.sum(s.data) }

pub fn math_qr_decomp_table_mean(s : MathqrdecompTable) -> Double { @_common.mean(s.data) }

pub fn math_qr_decomp_table_scale(s : MathqrdecompTable, f : Double) -> MathqrdecompTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_table_add(a : MathqrdecompTable, b : MathqrdecompTable) -> MathqrdecompTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_qr_decomp_table_copy(s : MathqrdecompTable) -> MathqrdecompTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_table_fill(s : MathqrdecompTable, v : Double) -> MathqrdecompTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_table_min(s : MathqrdecompTable) -> Double { @_common.min(s.data) }

pub fn math_qr_decomp_table_max(s : MathqrdecompTable) -> Double { @_common.max(s.data) }

pub fn math_qr_decomp_table_to_string(s : MathqrdecompTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_graphn_make(size : Int) -> MathqrdecompGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_graphn_len(s : MathqrdecompGraphN) -> Int { s.size }

pub fn math_qr_decomp_graphn_get(s : MathqrdecompGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_graphn_set(s : MathqrdecompGraphN, i : Int, v : Double) -> MathqrdecompGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_graphn_sum(s : MathqrdecompGraphN) -> Double { @_common.sum(s.data) }

pub fn math_qr_decomp_graphn_mean(s : MathqrdecompGraphN) -> Double { @_common.mean(s.data) }

pub fn math_qr_decomp_graphn_scale(s : MathqrdecompGraphN, f : Double) -> MathqrdecompGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_graphn_add(a : MathqrdecompGraphN, b : MathqrdecompGraphN) -> MathqrdecompGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_qr_decomp_graphn_copy(s : MathqrdecompGraphN) -> MathqrdecompGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_graphn_fill(s : MathqrdecompGraphN, v : Double) -> MathqrdecompGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_graphn_min(s : MathqrdecompGraphN) -> Double { @_common.min(s.data) }

pub fn math_qr_decomp_graphn_max(s : MathqrdecompGraphN) -> Double { @_common.max(s.data) }

pub fn math_qr_decomp_graphn_to_string(s : MathqrdecompGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_node_make(size : Int) -> MathqrdecompNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_node_len(s : MathqrdecompNode) -> Int { s.size }

pub fn math_qr_decomp_node_get(s : MathqrdecompNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_node_set(s : MathqrdecompNode, i : Int, v : Double) -> MathqrdecompNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_node_sum(s : MathqrdecompNode) -> Double { @_common.sum(s.data) }

pub fn math_qr_decomp_node_mean(s : MathqrdecompNode) -> Double { @_common.mean(s.data) }

pub fn math_qr_decomp_node_scale(s : MathqrdecompNode, f : Double) -> MathqrdecompNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_node_add(a : MathqrdecompNode, b : MathqrdecompNode) -> MathqrdecompNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_qr_decomp_node_copy(s : MathqrdecompNode) -> MathqrdecompNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_node_fill(s : MathqrdecompNode, v : Double) -> MathqrdecompNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_node_min(s : MathqrdecompNode) -> Double { @_common.min(s.data) }

pub fn math_qr_decomp_node_max(s : MathqrdecompNode) -> Double { @_common.max(s.data) }

pub fn math_qr_decomp_node_to_string(s : MathqrdecompNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_edge_make(size : Int) -> MathqrdecompEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_edge_len(s : MathqrdecompEdge) -> Int { s.size }

pub fn math_qr_decomp_edge_get(s : MathqrdecompEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_edge_set(s : MathqrdecompEdge, i : Int, v : Double) -> MathqrdecompEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_edge_sum(s : MathqrdecompEdge) -> Double { @_common.sum(s.data) }

pub fn math_qr_decomp_edge_mean(s : MathqrdecompEdge) -> Double { @_common.mean(s.data) }

pub fn math_qr_decomp_edge_scale(s : MathqrdecompEdge, f : Double) -> MathqrdecompEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_edge_add(a : MathqrdecompEdge, b : MathqrdecompEdge) -> MathqrdecompEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_qr_decomp_edge_copy(s : MathqrdecompEdge) -> MathqrdecompEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_edge_fill(s : MathqrdecompEdge, v : Double) -> MathqrdecompEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_edge_min(s : MathqrdecompEdge) -> Double { @_common.min(s.data) }

pub fn math_qr_decomp_edge_max(s : MathqrdecompEdge) -> Double { @_common.max(s.data) }

pub fn math_qr_decomp_edge_to_string(s : MathqrdecompEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_path_make(size : Int) -> MathqrdecompPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_path_len(s : MathqrdecompPath) -> Int { s.size }

pub fn math_qr_decomp_path_get(s : MathqrdecompPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_path_set(s : MathqrdecompPath, i : Int, v : Double) -> MathqrdecompPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_path_sum(s : MathqrdecompPath) -> Double { @_common.sum(s.data) }

pub fn math_qr_decomp_path_mean(s : MathqrdecompPath) -> Double { @_common.mean(s.data) }

pub fn math_qr_decomp_path_scale(s : MathqrdecompPath, f : Double) -> MathqrdecompPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_path_add(a : MathqrdecompPath, b : MathqrdecompPath) -> MathqrdecompPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_qr_decomp_path_copy(s : MathqrdecompPath) -> MathqrdecompPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_path_fill(s : MathqrdecompPath, v : Double) -> MathqrdecompPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_path_min(s : MathqrdecompPath) -> Double { @_common.min(s.data) }

pub fn math_qr_decomp_path_max(s : MathqrdecompPath) -> Double { @_common.max(s.data) }

pub fn math_qr_decomp_path_to_string(s : MathqrdecompPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_cluster_make(size : Int) -> MathqrdecompCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_cluster_len(s : MathqrdecompCluster) -> Int { s.size }

pub fn math_qr_decomp_cluster_get(s : MathqrdecompCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_cluster_set(s : MathqrdecompCluster, i : Int, v : Double) -> MathqrdecompCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_cluster_sum(s : MathqrdecompCluster) -> Double { @_common.sum(s.data) }

pub fn math_qr_decomp_cluster_mean(s : MathqrdecompCluster) -> Double { @_common.mean(s.data) }

pub fn math_qr_decomp_cluster_scale(s : MathqrdecompCluster, f : Double) -> MathqrdecompCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_cluster_add(a : MathqrdecompCluster, b : MathqrdecompCluster) -> MathqrdecompCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_qr_decomp_cluster_copy(s : MathqrdecompCluster) -> MathqrdecompCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_cluster_fill(s : MathqrdecompCluster, v : Double) -> MathqrdecompCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_cluster_min(s : MathqrdecompCluster) -> Double { @_common.min(s.data) }

pub fn math_qr_decomp_cluster_max(s : MathqrdecompCluster) -> Double { @_common.max(s.data) }

pub fn math_qr_decomp_cluster_to_string(s : MathqrdecompCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_model_make(size : Int) -> MathqrdecompModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_model_len(s : MathqrdecompModel) -> Int { s.size }

pub fn math_qr_decomp_model_get(s : MathqrdecompModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_model_set(s : MathqrdecompModel, i : Int, v : Double) -> MathqrdecompModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_model_sum(s : MathqrdecompModel) -> Double { @_common.sum(s.data) }

pub fn math_qr_decomp_model_mean(s : MathqrdecompModel) -> Double { @_common.mean(s.data) }

pub fn math_qr_decomp_model_scale(s : MathqrdecompModel, f : Double) -> MathqrdecompModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_model_add(a : MathqrdecompModel, b : MathqrdecompModel) -> MathqrdecompModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_qr_decomp_model_copy(s : MathqrdecompModel) -> MathqrdecompModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_model_fill(s : MathqrdecompModel, v : Double) -> MathqrdecompModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_model_min(s : MathqrdecompModel) -> Double { @_common.min(s.data) }

pub fn math_qr_decomp_model_max(s : MathqrdecompModel) -> Double { @_common.max(s.data) }

pub fn math_qr_decomp_model_to_string(s : MathqrdecompModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_layer_make(size : Int) -> MathqrdecompLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_layer_len(s : MathqrdecompLayer) -> Int { s.size }

pub fn math_qr_decomp_layer_get(s : MathqrdecompLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_layer_set(s : MathqrdecompLayer, i : Int, v : Double) -> MathqrdecompLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_layer_sum(s : MathqrdecompLayer) -> Double { @_common.sum(s.data) }

pub fn math_qr_decomp_layer_mean(s : MathqrdecompLayer) -> Double { @_common.mean(s.data) }

pub fn math_qr_decomp_layer_scale(s : MathqrdecompLayer, f : Double) -> MathqrdecompLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_layer_add(a : MathqrdecompLayer, b : MathqrdecompLayer) -> MathqrdecompLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_qr_decomp_layer_copy(s : MathqrdecompLayer) -> MathqrdecompLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_layer_fill(s : MathqrdecompLayer, v : Double) -> MathqrdecompLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_layer_min(s : MathqrdecompLayer) -> Double { @_common.min(s.data) }

pub fn math_qr_decomp_layer_max(s : MathqrdecompLayer) -> Double { @_common.max(s.data) }

pub fn math_qr_decomp_layer_to_string(s : MathqrdecompLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_buffer_make(size : Int) -> MathqrdecompBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_buffer_len(s : MathqrdecompBuffer) -> Int { s.size }

pub fn math_qr_decomp_buffer_get(s : MathqrdecompBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_buffer_set(s : MathqrdecompBuffer, i : Int, v : Double) -> MathqrdecompBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_buffer_sum(s : MathqrdecompBuffer) -> Double { @_common.sum(s.data) }

pub fn math_qr_decomp_buffer_mean(s : MathqrdecompBuffer) -> Double { @_common.mean(s.data) }

pub fn math_qr_decomp_buffer_scale(s : MathqrdecompBuffer, f : Double) -> MathqrdecompBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_buffer_add(a : MathqrdecompBuffer, b : MathqrdecompBuffer) -> MathqrdecompBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_qr_decomp_buffer_copy(s : MathqrdecompBuffer) -> MathqrdecompBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_buffer_fill(s : MathqrdecompBuffer, v : Double) -> MathqrdecompBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_buffer_min(s : MathqrdecompBuffer) -> Double { @_common.min(s.data) }

pub fn math_qr_decomp_buffer_max(s : MathqrdecompBuffer) -> Double { @_common.max(s.data) }

pub fn math_qr_decomp_buffer_to_string(s : MathqrdecompBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_cursor_make(size : Int) -> MathqrdecompCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_cursor_len(s : MathqrdecompCursor) -> Int { s.size }

pub fn math_qr_decomp_cursor_get(s : MathqrdecompCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_cursor_set(s : MathqrdecompCursor, i : Int, v : Double) -> MathqrdecompCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_cursor_sum(s : MathqrdecompCursor) -> Double { @_common.sum(s.data) }

pub fn math_qr_decomp_cursor_mean(s : MathqrdecompCursor) -> Double { @_common.mean(s.data) }

pub fn math_qr_decomp_cursor_scale(s : MathqrdecompCursor, f : Double) -> MathqrdecompCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_cursor_add(a : MathqrdecompCursor, b : MathqrdecompCursor) -> MathqrdecompCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_qr_decomp_cursor_copy(s : MathqrdecompCursor) -> MathqrdecompCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_cursor_fill(s : MathqrdecompCursor, v : Double) -> MathqrdecompCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_cursor_min(s : MathqrdecompCursor) -> Double { @_common.min(s.data) }

pub fn math_qr_decomp_cursor_max(s : MathqrdecompCursor) -> Double { @_common.max(s.data) }

pub fn math_qr_decomp_cursor_to_string(s : MathqrdecompCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_view_make(size : Int) -> MathqrdecompView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_view_len(s : MathqrdecompView) -> Int { s.size }

pub fn math_qr_decomp_view_get(s : MathqrdecompView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_view_set(s : MathqrdecompView, i : Int, v : Double) -> MathqrdecompView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_view_sum(s : MathqrdecompView) -> Double { @_common.sum(s.data) }

pub fn math_qr_decomp_view_mean(s : MathqrdecompView) -> Double { @_common.mean(s.data) }

pub fn math_qr_decomp_view_scale(s : MathqrdecompView, f : Double) -> MathqrdecompView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_view_add(a : MathqrdecompView, b : MathqrdecompView) -> MathqrdecompView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_qr_decomp_view_copy(s : MathqrdecompView) -> MathqrdecompView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_view_fill(s : MathqrdecompView, v : Double) -> MathqrdecompView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_view_min(s : MathqrdecompView) -> Double { @_common.min(s.data) }

pub fn math_qr_decomp_view_max(s : MathqrdecompView) -> Double { @_common.max(s.data) }

pub fn math_qr_decomp_view_to_string(s : MathqrdecompView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_range_make(size : Int) -> MathqrdecompRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_range_len(s : MathqrdecompRange) -> Int { s.size }

pub fn math_qr_decomp_range_get(s : MathqrdecompRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_range_set(s : MathqrdecompRange, i : Int, v : Double) -> MathqrdecompRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_range_sum(s : MathqrdecompRange) -> Double { @_common.sum(s.data) }

pub fn math_qr_decomp_range_mean(s : MathqrdecompRange) -> Double { @_common.mean(s.data) }

pub fn math_qr_decomp_range_scale(s : MathqrdecompRange, f : Double) -> MathqrdecompRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_range_add(a : MathqrdecompRange, b : MathqrdecompRange) -> MathqrdecompRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_qr_decomp_range_copy(s : MathqrdecompRange) -> MathqrdecompRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_range_fill(s : MathqrdecompRange, v : Double) -> MathqrdecompRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_range_min(s : MathqrdecompRange) -> Double { @_common.min(s.data) }

pub fn math_qr_decomp_range_max(s : MathqrdecompRange) -> Double { @_common.max(s.data) }

pub fn math_qr_decomp_range_to_string(s : MathqrdecompRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathqrdecompSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_qr_decomp_slice_make(size : Int) -> MathqrdecompSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_qr_decomp_slice_len(s : MathqrdecompSlice) -> Int { s.size }

pub fn math_qr_decomp_slice_get(s : MathqrdecompSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_qr_decomp_slice_set(s : MathqrdecompSlice, i : Int, v : Double) -> MathqrdecompSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_slice_sum(s : MathqrdecompSlice) -> Double { @_common.sum(s.data) }

pub fn math_qr_decomp_slice_mean(s : MathqrdecompSlice) -> Double { @_common.mean(s.data) }

pub fn math_qr_decomp_slice_scale(s : MathqrdecompSlice, f : Double) -> MathqrdecompSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_slice_add(a : MathqrdecompSlice, b : MathqrdecompSlice) -> MathqrdecompSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_qr_decomp_slice_copy(s : MathqrdecompSlice) -> MathqrdecompSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_slice_fill(s : MathqrdecompSlice, v : Double) -> MathqrdecompSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_qr_decomp_slice_min(s : MathqrdecompSlice) -> Double { @_common.min(s.data) }

pub fn math_qr_decomp_slice_max(s : MathqrdecompSlice) -> Double { @_common.max(s.data) }

pub fn math_qr_decomp_slice_to_string(s : MathqrdecompSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

