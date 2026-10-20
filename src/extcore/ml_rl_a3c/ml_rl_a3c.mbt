///===
/// extcore/ml_rl_a3c

pub(all) struct Mlrla3cPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_a3c_make_point(x : Double, y : Double) -> Mlrla3cPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_a3c_make_point3(x : Double, y : Double, z : Double) -> Mlrla3cPoint {
  { x, y, z, label: 0 }
}

pub fn Mlrla3cPoint::x(self : Mlrla3cPoint) -> Double { self.x }

pub fn Mlrla3cPoint::y(self : Mlrla3cPoint) -> Double { self.y }

pub fn Mlrla3cPoint::z(self : Mlrla3cPoint) -> Double { self.z }

pub fn Mlrla3cPoint::label(self : Mlrla3cPoint) -> Int { self.label }

pub fn Mlrla3cPoint::dist(self : Mlrla3cPoint, other : Mlrla3cPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Mlrla3cPoint::add(self : Mlrla3cPoint, other : Mlrla3cPoint) -> Mlrla3cPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Mlrla3cPoint::sub(self : Mlrla3cPoint, other : Mlrla3cPoint) -> Mlrla3cPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Mlrla3cPoint::scale(self : Mlrla3cPoint, s : Double) -> Mlrla3cPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Mlrla3cPoint::dot(self : Mlrla3cPoint, other : Mlrla3cPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Mlrla3cPoint::cross(self : Mlrla3cPoint, other : Mlrla3cPoint) -> Mlrla3cPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Mlrla3cPoint::norm(self : Mlrla3cPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Mlrla3cPoint::normalize(self : Mlrla3cPoint) -> Mlrla3cPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Mlrla3cPoint::negate(self : Mlrla3cPoint) -> Mlrla3cPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Mlrla3cPoint::mid(self : Mlrla3cPoint, other : Mlrla3cPoint) -> Mlrla3cPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Mlrla3cPoint::lerp(self : Mlrla3cPoint, other : Mlrla3cPoint, t : Double) -> Mlrla3cPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Mlrla3cPoint::to_string(self : Mlrla3cPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Mlrla3cSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_a3c_make_series(vals : Array[Double], name : String) -> Mlrla3cSeries {
  { vals, name, meta: 0 }
}

pub fn Mlrla3cSeries::len(self : Mlrla3cSeries) -> Int { self.vals.length() }

pub fn Mlrla3cSeries::sum(self : Mlrla3cSeries) -> Double { @_common.sum(self.vals) }

pub fn Mlrla3cSeries::mean(self : Mlrla3cSeries) -> Double { @_common.mean(self.vals) }

pub fn Mlrla3cSeries::min(self : Mlrla3cSeries) -> Double { @_common.min(self.vals) }

pub fn Mlrla3cSeries::max(self : Mlrla3cSeries) -> Double { @_common.max(self.vals) }

pub fn Mlrla3cSeries::range(self : Mlrla3cSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Mlrla3cSeries::variance(self : Mlrla3cSeries) -> Double { @_common.variance(self.vals) }

pub fn Mlrla3cSeries::std(self : Mlrla3cSeries) -> Double { @_common.std(self.vals) }

pub fn Mlrla3cSeries::median(self : Mlrla3cSeries) -> Double { @_common.median(self.vals) }

pub fn Mlrla3cSeries::scale(self : Mlrla3cSeries, f : Double) -> Mlrla3cSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Mlrla3cSeries::add(self : Mlrla3cSeries, other : Mlrla3cSeries) -> Mlrla3cSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Mlrla3cSeries::sub(self : Mlrla3cSeries, other : Mlrla3cSeries) -> Mlrla3cSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Mlrla3cSeries::normalize(self : Mlrla3cSeries) -> Mlrla3cSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Mlrla3cSeries::cumsum(self : Mlrla3cSeries) -> Mlrla3cSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Mlrla3cSeries::to_string(self : Mlrla3cSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Mlrla3cMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_a3c_make_matrix(rows : Int, cols : Int, val : Double) -> Mlrla3cMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_a3c_matrix_identity(n : Int) -> Mlrla3cMatrix {
  let m = ml_rl_a3c_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Mlrla3cMatrix::get(self : Mlrla3cMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Mlrla3cMatrix::transpose(self : Mlrla3cMatrix) -> Mlrla3cMatrix {
  let result = ml_rl_a3c_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Mlrla3cMatrix::add(self : Mlrla3cMatrix, other : Mlrla3cMatrix) -> Mlrla3cMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_rl_a3c_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Mlrla3cMatrix::scale(self : Mlrla3cMatrix, s : Double) -> Mlrla3cMatrix {
  let result = ml_rl_a3c_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Mlrla3cMatrix::multiply(self : Mlrla3cMatrix, other : Mlrla3cMatrix) -> Mlrla3cMatrix {
  if self.cols != other.rows { return ml_rl_a3c_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_rl_a3c_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Mlrla3cMatrix::trace(self : Mlrla3cMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Mlrla3cMatrix::det(self : Mlrla3cMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Mlrla3cMatrix::norm(self : Mlrla3cMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Mlrla3cMatrix::to_string(self : Mlrla3cMatrix) -> String {
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

pub(all) struct Mlrla3cVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_a3c_make_vector(comps : Array[Double]) -> Mlrla3cVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_a3c_vector_zero(dim : Int) -> Mlrla3cVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Mlrla3cVector::add(self : Mlrla3cVector, other : Mlrla3cVector) -> Mlrla3cVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Mlrla3cVector::sub(self : Mlrla3cVector, other : Mlrla3cVector) -> Mlrla3cVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Mlrla3cVector::scale(self : Mlrla3cVector, s : Double) -> Mlrla3cVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Mlrla3cVector::dot(self : Mlrla3cVector, other : Mlrla3cVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Mlrla3cVector::norm(self : Mlrla3cVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Mlrla3cVector::normalize(self : Mlrla3cVector) -> Mlrla3cVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Mlrla3cVector::dist(self : Mlrla3cVector, other : Mlrla3cVector) -> Double {
  self.sub(other).norm()
}

pub fn Mlrla3cVector::to_string(self : Mlrla3cVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_a3c_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_rl_a3c_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_rl_a3c_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_rl_a3c_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_rl_a3c_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_rl_a3c_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_rl_a3c_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_rl_a3c_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_rl_a3c_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_rl_a3c_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_rl_a3c_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_rl_a3c_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_rl_a3c_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_rl_a3c_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_rl_a3c_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_rl_a3c_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_rl_a3c_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_rl_a3c_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_rl_a3c_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_rl_a3c_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_rl_a3c_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_rl_a3c_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_rl_a3c_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_rl_a3c_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_rl_a3c_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_rl_a3c_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_rl_a3c_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_rl_a3c_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_rl_a3c_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Mlrla3cFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_frame_make(size : Int) -> Mlrla3cFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_a3c_frame_len(s : Mlrla3cFrame) -> Int { s.size }

pub fn ml_rl_a3c_frame_get(s : Mlrla3cFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_a3c_frame_set(s : Mlrla3cFrame, i : Int, v : Double) -> Mlrla3cFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_frame_sum(s : Mlrla3cFrame) -> Double { @_common.sum(s.data) }

pub fn ml_rl_a3c_frame_mean(s : Mlrla3cFrame) -> Double { @_common.mean(s.data) }

pub fn ml_rl_a3c_frame_scale(s : Mlrla3cFrame, f : Double) -> Mlrla3cFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_frame_add(a : Mlrla3cFrame, b : Mlrla3cFrame) -> Mlrla3cFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_a3c_frame_copy(s : Mlrla3cFrame) -> Mlrla3cFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_frame_fill(s : Mlrla3cFrame, v : Double) -> Mlrla3cFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_frame_min(s : Mlrla3cFrame) -> Double { @_common.min(s.data) }

pub fn ml_rl_a3c_frame_max(s : Mlrla3cFrame) -> Double { @_common.max(s.data) }

pub fn ml_rl_a3c_frame_to_string(s : Mlrla3cFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Mlrla3cTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_table_make(size : Int) -> Mlrla3cTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_a3c_table_len(s : Mlrla3cTable) -> Int { s.size }

pub fn ml_rl_a3c_table_get(s : Mlrla3cTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_a3c_table_set(s : Mlrla3cTable, i : Int, v : Double) -> Mlrla3cTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_table_sum(s : Mlrla3cTable) -> Double { @_common.sum(s.data) }

pub fn ml_rl_a3c_table_mean(s : Mlrla3cTable) -> Double { @_common.mean(s.data) }

pub fn ml_rl_a3c_table_scale(s : Mlrla3cTable, f : Double) -> Mlrla3cTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_table_add(a : Mlrla3cTable, b : Mlrla3cTable) -> Mlrla3cTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_a3c_table_copy(s : Mlrla3cTable) -> Mlrla3cTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_table_fill(s : Mlrla3cTable, v : Double) -> Mlrla3cTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_table_min(s : Mlrla3cTable) -> Double { @_common.min(s.data) }

pub fn ml_rl_a3c_table_max(s : Mlrla3cTable) -> Double { @_common.max(s.data) }

pub fn ml_rl_a3c_table_to_string(s : Mlrla3cTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Mlrla3cGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_graphn_make(size : Int) -> Mlrla3cGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_a3c_graphn_len(s : Mlrla3cGraphN) -> Int { s.size }

pub fn ml_rl_a3c_graphn_get(s : Mlrla3cGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_a3c_graphn_set(s : Mlrla3cGraphN, i : Int, v : Double) -> Mlrla3cGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_graphn_sum(s : Mlrla3cGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_rl_a3c_graphn_mean(s : Mlrla3cGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_rl_a3c_graphn_scale(s : Mlrla3cGraphN, f : Double) -> Mlrla3cGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_graphn_add(a : Mlrla3cGraphN, b : Mlrla3cGraphN) -> Mlrla3cGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_a3c_graphn_copy(s : Mlrla3cGraphN) -> Mlrla3cGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_graphn_fill(s : Mlrla3cGraphN, v : Double) -> Mlrla3cGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_graphn_min(s : Mlrla3cGraphN) -> Double { @_common.min(s.data) }

pub fn ml_rl_a3c_graphn_max(s : Mlrla3cGraphN) -> Double { @_common.max(s.data) }

pub fn ml_rl_a3c_graphn_to_string(s : Mlrla3cGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Mlrla3cNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_node_make(size : Int) -> Mlrla3cNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_a3c_node_len(s : Mlrla3cNode) -> Int { s.size }

pub fn ml_rl_a3c_node_get(s : Mlrla3cNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_a3c_node_set(s : Mlrla3cNode, i : Int, v : Double) -> Mlrla3cNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_node_sum(s : Mlrla3cNode) -> Double { @_common.sum(s.data) }

pub fn ml_rl_a3c_node_mean(s : Mlrla3cNode) -> Double { @_common.mean(s.data) }

pub fn ml_rl_a3c_node_scale(s : Mlrla3cNode, f : Double) -> Mlrla3cNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_node_add(a : Mlrla3cNode, b : Mlrla3cNode) -> Mlrla3cNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_a3c_node_copy(s : Mlrla3cNode) -> Mlrla3cNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_node_fill(s : Mlrla3cNode, v : Double) -> Mlrla3cNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_node_min(s : Mlrla3cNode) -> Double { @_common.min(s.data) }

pub fn ml_rl_a3c_node_max(s : Mlrla3cNode) -> Double { @_common.max(s.data) }

pub fn ml_rl_a3c_node_to_string(s : Mlrla3cNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Mlrla3cEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_edge_make(size : Int) -> Mlrla3cEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_a3c_edge_len(s : Mlrla3cEdge) -> Int { s.size }

pub fn ml_rl_a3c_edge_get(s : Mlrla3cEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_a3c_edge_set(s : Mlrla3cEdge, i : Int, v : Double) -> Mlrla3cEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_edge_sum(s : Mlrla3cEdge) -> Double { @_common.sum(s.data) }

pub fn ml_rl_a3c_edge_mean(s : Mlrla3cEdge) -> Double { @_common.mean(s.data) }

pub fn ml_rl_a3c_edge_scale(s : Mlrla3cEdge, f : Double) -> Mlrla3cEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_edge_add(a : Mlrla3cEdge, b : Mlrla3cEdge) -> Mlrla3cEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_a3c_edge_copy(s : Mlrla3cEdge) -> Mlrla3cEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_edge_fill(s : Mlrla3cEdge, v : Double) -> Mlrla3cEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_edge_min(s : Mlrla3cEdge) -> Double { @_common.min(s.data) }

pub fn ml_rl_a3c_edge_max(s : Mlrla3cEdge) -> Double { @_common.max(s.data) }

pub fn ml_rl_a3c_edge_to_string(s : Mlrla3cEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Mlrla3cPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_path_make(size : Int) -> Mlrla3cPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_a3c_path_len(s : Mlrla3cPath) -> Int { s.size }

pub fn ml_rl_a3c_path_get(s : Mlrla3cPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_a3c_path_set(s : Mlrla3cPath, i : Int, v : Double) -> Mlrla3cPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_path_sum(s : Mlrla3cPath) -> Double { @_common.sum(s.data) }

pub fn ml_rl_a3c_path_mean(s : Mlrla3cPath) -> Double { @_common.mean(s.data) }

pub fn ml_rl_a3c_path_scale(s : Mlrla3cPath, f : Double) -> Mlrla3cPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_path_add(a : Mlrla3cPath, b : Mlrla3cPath) -> Mlrla3cPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_a3c_path_copy(s : Mlrla3cPath) -> Mlrla3cPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_path_fill(s : Mlrla3cPath, v : Double) -> Mlrla3cPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_path_min(s : Mlrla3cPath) -> Double { @_common.min(s.data) }

pub fn ml_rl_a3c_path_max(s : Mlrla3cPath) -> Double { @_common.max(s.data) }

pub fn ml_rl_a3c_path_to_string(s : Mlrla3cPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Mlrla3cCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_cluster_make(size : Int) -> Mlrla3cCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_a3c_cluster_len(s : Mlrla3cCluster) -> Int { s.size }

pub fn ml_rl_a3c_cluster_get(s : Mlrla3cCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_a3c_cluster_set(s : Mlrla3cCluster, i : Int, v : Double) -> Mlrla3cCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_cluster_sum(s : Mlrla3cCluster) -> Double { @_common.sum(s.data) }

pub fn ml_rl_a3c_cluster_mean(s : Mlrla3cCluster) -> Double { @_common.mean(s.data) }

pub fn ml_rl_a3c_cluster_scale(s : Mlrla3cCluster, f : Double) -> Mlrla3cCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_cluster_add(a : Mlrla3cCluster, b : Mlrla3cCluster) -> Mlrla3cCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_a3c_cluster_copy(s : Mlrla3cCluster) -> Mlrla3cCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_cluster_fill(s : Mlrla3cCluster, v : Double) -> Mlrla3cCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_cluster_min(s : Mlrla3cCluster) -> Double { @_common.min(s.data) }

pub fn ml_rl_a3c_cluster_max(s : Mlrla3cCluster) -> Double { @_common.max(s.data) }

pub fn ml_rl_a3c_cluster_to_string(s : Mlrla3cCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Mlrla3cModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_model_make(size : Int) -> Mlrla3cModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_a3c_model_len(s : Mlrla3cModel) -> Int { s.size }

pub fn ml_rl_a3c_model_get(s : Mlrla3cModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_a3c_model_set(s : Mlrla3cModel, i : Int, v : Double) -> Mlrla3cModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_model_sum(s : Mlrla3cModel) -> Double { @_common.sum(s.data) }

pub fn ml_rl_a3c_model_mean(s : Mlrla3cModel) -> Double { @_common.mean(s.data) }

pub fn ml_rl_a3c_model_scale(s : Mlrla3cModel, f : Double) -> Mlrla3cModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_model_add(a : Mlrla3cModel, b : Mlrla3cModel) -> Mlrla3cModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_a3c_model_copy(s : Mlrla3cModel) -> Mlrla3cModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_model_fill(s : Mlrla3cModel, v : Double) -> Mlrla3cModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_model_min(s : Mlrla3cModel) -> Double { @_common.min(s.data) }

pub fn ml_rl_a3c_model_max(s : Mlrla3cModel) -> Double { @_common.max(s.data) }

pub fn ml_rl_a3c_model_to_string(s : Mlrla3cModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Mlrla3cLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_layer_make(size : Int) -> Mlrla3cLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_a3c_layer_len(s : Mlrla3cLayer) -> Int { s.size }

pub fn ml_rl_a3c_layer_get(s : Mlrla3cLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_a3c_layer_set(s : Mlrla3cLayer, i : Int, v : Double) -> Mlrla3cLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_layer_sum(s : Mlrla3cLayer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_a3c_layer_mean(s : Mlrla3cLayer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_a3c_layer_scale(s : Mlrla3cLayer, f : Double) -> Mlrla3cLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_layer_add(a : Mlrla3cLayer, b : Mlrla3cLayer) -> Mlrla3cLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_a3c_layer_copy(s : Mlrla3cLayer) -> Mlrla3cLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_layer_fill(s : Mlrla3cLayer, v : Double) -> Mlrla3cLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_layer_min(s : Mlrla3cLayer) -> Double { @_common.min(s.data) }

pub fn ml_rl_a3c_layer_max(s : Mlrla3cLayer) -> Double { @_common.max(s.data) }

pub fn ml_rl_a3c_layer_to_string(s : Mlrla3cLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Mlrla3cBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_buffer_make(size : Int) -> Mlrla3cBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_a3c_buffer_len(s : Mlrla3cBuffer) -> Int { s.size }

pub fn ml_rl_a3c_buffer_get(s : Mlrla3cBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_a3c_buffer_set(s : Mlrla3cBuffer, i : Int, v : Double) -> Mlrla3cBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_buffer_sum(s : Mlrla3cBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_rl_a3c_buffer_mean(s : Mlrla3cBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_rl_a3c_buffer_scale(s : Mlrla3cBuffer, f : Double) -> Mlrla3cBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_buffer_add(a : Mlrla3cBuffer, b : Mlrla3cBuffer) -> Mlrla3cBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_a3c_buffer_copy(s : Mlrla3cBuffer) -> Mlrla3cBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_buffer_fill(s : Mlrla3cBuffer, v : Double) -> Mlrla3cBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_buffer_min(s : Mlrla3cBuffer) -> Double { @_common.min(s.data) }

pub fn ml_rl_a3c_buffer_max(s : Mlrla3cBuffer) -> Double { @_common.max(s.data) }

pub fn ml_rl_a3c_buffer_to_string(s : Mlrla3cBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Mlrla3cCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_cursor_make(size : Int) -> Mlrla3cCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_a3c_cursor_len(s : Mlrla3cCursor) -> Int { s.size }

pub fn ml_rl_a3c_cursor_get(s : Mlrla3cCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_a3c_cursor_set(s : Mlrla3cCursor, i : Int, v : Double) -> Mlrla3cCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_cursor_sum(s : Mlrla3cCursor) -> Double { @_common.sum(s.data) }

pub fn ml_rl_a3c_cursor_mean(s : Mlrla3cCursor) -> Double { @_common.mean(s.data) }

pub fn ml_rl_a3c_cursor_scale(s : Mlrla3cCursor, f : Double) -> Mlrla3cCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_cursor_add(a : Mlrla3cCursor, b : Mlrla3cCursor) -> Mlrla3cCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_a3c_cursor_copy(s : Mlrla3cCursor) -> Mlrla3cCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_cursor_fill(s : Mlrla3cCursor, v : Double) -> Mlrla3cCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_cursor_min(s : Mlrla3cCursor) -> Double { @_common.min(s.data) }

pub fn ml_rl_a3c_cursor_max(s : Mlrla3cCursor) -> Double { @_common.max(s.data) }

pub fn ml_rl_a3c_cursor_to_string(s : Mlrla3cCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Mlrla3cView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_view_make(size : Int) -> Mlrla3cView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_a3c_view_len(s : Mlrla3cView) -> Int { s.size }

pub fn ml_rl_a3c_view_get(s : Mlrla3cView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_a3c_view_set(s : Mlrla3cView, i : Int, v : Double) -> Mlrla3cView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_view_sum(s : Mlrla3cView) -> Double { @_common.sum(s.data) }

pub fn ml_rl_a3c_view_mean(s : Mlrla3cView) -> Double { @_common.mean(s.data) }

pub fn ml_rl_a3c_view_scale(s : Mlrla3cView, f : Double) -> Mlrla3cView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_view_add(a : Mlrla3cView, b : Mlrla3cView) -> Mlrla3cView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_a3c_view_copy(s : Mlrla3cView) -> Mlrla3cView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_view_fill(s : Mlrla3cView, v : Double) -> Mlrla3cView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_view_min(s : Mlrla3cView) -> Double { @_common.min(s.data) }

pub fn ml_rl_a3c_view_max(s : Mlrla3cView) -> Double { @_common.max(s.data) }

pub fn ml_rl_a3c_view_to_string(s : Mlrla3cView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Mlrla3cRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_range_make(size : Int) -> Mlrla3cRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_a3c_range_len(s : Mlrla3cRange) -> Int { s.size }

pub fn ml_rl_a3c_range_get(s : Mlrla3cRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_a3c_range_set(s : Mlrla3cRange, i : Int, v : Double) -> Mlrla3cRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_range_sum(s : Mlrla3cRange) -> Double { @_common.sum(s.data) }

pub fn ml_rl_a3c_range_mean(s : Mlrla3cRange) -> Double { @_common.mean(s.data) }

pub fn ml_rl_a3c_range_scale(s : Mlrla3cRange, f : Double) -> Mlrla3cRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_range_add(a : Mlrla3cRange, b : Mlrla3cRange) -> Mlrla3cRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_a3c_range_copy(s : Mlrla3cRange) -> Mlrla3cRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_range_fill(s : Mlrla3cRange, v : Double) -> Mlrla3cRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_range_min(s : Mlrla3cRange) -> Double { @_common.min(s.data) }

pub fn ml_rl_a3c_range_max(s : Mlrla3cRange) -> Double { @_common.max(s.data) }

pub fn ml_rl_a3c_range_to_string(s : Mlrla3cRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Mlrla3cSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_a3c_slice_make(size : Int) -> Mlrla3cSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_a3c_slice_len(s : Mlrla3cSlice) -> Int { s.size }

pub fn ml_rl_a3c_slice_get(s : Mlrla3cSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_a3c_slice_set(s : Mlrla3cSlice, i : Int, v : Double) -> Mlrla3cSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_slice_sum(s : Mlrla3cSlice) -> Double { @_common.sum(s.data) }

pub fn ml_rl_a3c_slice_mean(s : Mlrla3cSlice) -> Double { @_common.mean(s.data) }

pub fn ml_rl_a3c_slice_scale(s : Mlrla3cSlice, f : Double) -> Mlrla3cSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_slice_add(a : Mlrla3cSlice, b : Mlrla3cSlice) -> Mlrla3cSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_rl_a3c_slice_copy(s : Mlrla3cSlice) -> Mlrla3cSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_slice_fill(s : Mlrla3cSlice, v : Double) -> Mlrla3cSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_rl_a3c_slice_min(s : Mlrla3cSlice) -> Double { @_common.min(s.data) }

pub fn ml_rl_a3c_slice_max(s : Mlrla3cSlice) -> Double { @_common.max(s.data) }

pub fn ml_rl_a3c_slice_to_string(s : Mlrla3cSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

