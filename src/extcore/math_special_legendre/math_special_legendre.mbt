///===
/// extcore/math_special_legendre

pub(all) struct MathspeciallegendrePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_legendre_make_point(x : Double, y : Double) -> MathspeciallegendrePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_legendre_make_point3(x : Double, y : Double, z : Double) -> MathspeciallegendrePoint {
  { x, y, z, label: 0 }
}

pub fn MathspeciallegendrePoint::x(self : MathspeciallegendrePoint) -> Double { self.x }

pub fn MathspeciallegendrePoint::y(self : MathspeciallegendrePoint) -> Double { self.y }

pub fn MathspeciallegendrePoint::z(self : MathspeciallegendrePoint) -> Double { self.z }

pub fn MathspeciallegendrePoint::label(self : MathspeciallegendrePoint) -> Int { self.label }

pub fn MathspeciallegendrePoint::dist(self : MathspeciallegendrePoint, other : MathspeciallegendrePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspeciallegendrePoint::add(self : MathspeciallegendrePoint, other : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspeciallegendrePoint::sub(self : MathspeciallegendrePoint, other : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspeciallegendrePoint::scale(self : MathspeciallegendrePoint, s : Double) -> MathspeciallegendrePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspeciallegendrePoint::dot(self : MathspeciallegendrePoint, other : MathspeciallegendrePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspeciallegendrePoint::cross(self : MathspeciallegendrePoint, other : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspeciallegendrePoint::norm(self : MathspeciallegendrePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspeciallegendrePoint::normalize(self : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspeciallegendrePoint::negate(self : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspeciallegendrePoint::mid(self : MathspeciallegendrePoint, other : MathspeciallegendrePoint) -> MathspeciallegendrePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspeciallegendrePoint::lerp(self : MathspeciallegendrePoint, other : MathspeciallegendrePoint, t : Double) -> MathspeciallegendrePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspeciallegendrePoint::to_string(self : MathspeciallegendrePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspeciallegendreSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_legendre_make_series(vals : Array[Double], name : String) -> MathspeciallegendreSeries {
  { vals, name, meta: 0 }
}

pub fn MathspeciallegendreSeries::len(self : MathspeciallegendreSeries) -> Int { self.vals.length() }

pub fn MathspeciallegendreSeries::sum(self : MathspeciallegendreSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspeciallegendreSeries::mean(self : MathspeciallegendreSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspeciallegendreSeries::min(self : MathspeciallegendreSeries) -> Double { @_common.min(self.vals) }

pub fn MathspeciallegendreSeries::max(self : MathspeciallegendreSeries) -> Double { @_common.max(self.vals) }

pub fn MathspeciallegendreSeries::range(self : MathspeciallegendreSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspeciallegendreSeries::variance(self : MathspeciallegendreSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspeciallegendreSeries::std(self : MathspeciallegendreSeries) -> Double { @_common.std(self.vals) }

pub fn MathspeciallegendreSeries::median(self : MathspeciallegendreSeries) -> Double { @_common.median(self.vals) }

pub fn MathspeciallegendreSeries::scale(self : MathspeciallegendreSeries, f : Double) -> MathspeciallegendreSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspeciallegendreSeries::add(self : MathspeciallegendreSeries, other : MathspeciallegendreSeries) -> MathspeciallegendreSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspeciallegendreSeries::sub(self : MathspeciallegendreSeries, other : MathspeciallegendreSeries) -> MathspeciallegendreSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspeciallegendreSeries::normalize(self : MathspeciallegendreSeries) -> MathspeciallegendreSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspeciallegendreSeries::cumsum(self : MathspeciallegendreSeries) -> MathspeciallegendreSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspeciallegendreSeries::to_string(self : MathspeciallegendreSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspeciallegendreMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_legendre_make_matrix(rows : Int, cols : Int, val : Double) -> MathspeciallegendreMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_legendre_matrix_identity(n : Int) -> MathspeciallegendreMatrix {
  let m = math_special_legendre_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspeciallegendreMatrix::get(self : MathspeciallegendreMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspeciallegendreMatrix::transpose(self : MathspeciallegendreMatrix) -> MathspeciallegendreMatrix {
  let result = math_special_legendre_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspeciallegendreMatrix::add(self : MathspeciallegendreMatrix, other : MathspeciallegendreMatrix) -> MathspeciallegendreMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_legendre_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspeciallegendreMatrix::scale(self : MathspeciallegendreMatrix, s : Double) -> MathspeciallegendreMatrix {
  let result = math_special_legendre_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspeciallegendreMatrix::multiply(self : MathspeciallegendreMatrix, other : MathspeciallegendreMatrix) -> MathspeciallegendreMatrix {
  if self.cols != other.rows { return math_special_legendre_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_legendre_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathspeciallegendreMatrix::trace(self : MathspeciallegendreMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspeciallegendreMatrix::det(self : MathspeciallegendreMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspeciallegendreMatrix::norm(self : MathspeciallegendreMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspeciallegendreMatrix::to_string(self : MathspeciallegendreMatrix) -> String {
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

pub(all) struct MathspeciallegendreVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_legendre_make_vector(comps : Array[Double]) -> MathspeciallegendreVector {
  { comps, dim: comps.length() }
}

pub fn math_special_legendre_vector_zero(dim : Int) -> MathspeciallegendreVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspeciallegendreVector::add(self : MathspeciallegendreVector, other : MathspeciallegendreVector) -> MathspeciallegendreVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspeciallegendreVector::sub(self : MathspeciallegendreVector, other : MathspeciallegendreVector) -> MathspeciallegendreVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspeciallegendreVector::scale(self : MathspeciallegendreVector, s : Double) -> MathspeciallegendreVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspeciallegendreVector::dot(self : MathspeciallegendreVector, other : MathspeciallegendreVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspeciallegendreVector::norm(self : MathspeciallegendreVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspeciallegendreVector::normalize(self : MathspeciallegendreVector) -> MathspeciallegendreVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspeciallegendreVector::dist(self : MathspeciallegendreVector, other : MathspeciallegendreVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspeciallegendreVector::to_string(self : MathspeciallegendreVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_legendre_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_legendre_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_legendre_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_legendre_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_legendre_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_legendre_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_legendre_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_legendre_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_legendre_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_legendre_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_legendre_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_legendre_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_legendre_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_legendre_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_legendre_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_legendre_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_legendre_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_legendre_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_legendre_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_legendre_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_legendre_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_legendre_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_legendre_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_legendre_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_legendre_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_legendre_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_legendre_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_legendre_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_legendre_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspeciallegendreFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_frame_make(size : Int) -> MathspeciallegendreFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_frame_len(s : MathspeciallegendreFrame) -> Int { s.size }

pub fn math_special_legendre_frame_get(s : MathspeciallegendreFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_frame_set(s : MathspeciallegendreFrame, i : Int, v : Double) -> MathspeciallegendreFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_frame_sum(s : MathspeciallegendreFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_frame_mean(s : MathspeciallegendreFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_frame_scale(s : MathspeciallegendreFrame, f : Double) -> MathspeciallegendreFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_frame_add(a : MathspeciallegendreFrame, b : MathspeciallegendreFrame) -> MathspeciallegendreFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_frame_copy(s : MathspeciallegendreFrame) -> MathspeciallegendreFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_frame_fill(s : MathspeciallegendreFrame, v : Double) -> MathspeciallegendreFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_frame_min(s : MathspeciallegendreFrame) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_frame_max(s : MathspeciallegendreFrame) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_frame_to_string(s : MathspeciallegendreFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_table_make(size : Int) -> MathspeciallegendreTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_table_len(s : MathspeciallegendreTable) -> Int { s.size }

pub fn math_special_legendre_table_get(s : MathspeciallegendreTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_table_set(s : MathspeciallegendreTable, i : Int, v : Double) -> MathspeciallegendreTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_table_sum(s : MathspeciallegendreTable) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_table_mean(s : MathspeciallegendreTable) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_table_scale(s : MathspeciallegendreTable, f : Double) -> MathspeciallegendreTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_table_add(a : MathspeciallegendreTable, b : MathspeciallegendreTable) -> MathspeciallegendreTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_table_copy(s : MathspeciallegendreTable) -> MathspeciallegendreTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_table_fill(s : MathspeciallegendreTable, v : Double) -> MathspeciallegendreTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_table_min(s : MathspeciallegendreTable) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_table_max(s : MathspeciallegendreTable) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_table_to_string(s : MathspeciallegendreTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_graphn_make(size : Int) -> MathspeciallegendreGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_graphn_len(s : MathspeciallegendreGraphN) -> Int { s.size }

pub fn math_special_legendre_graphn_get(s : MathspeciallegendreGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_graphn_set(s : MathspeciallegendreGraphN, i : Int, v : Double) -> MathspeciallegendreGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_graphn_sum(s : MathspeciallegendreGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_graphn_mean(s : MathspeciallegendreGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_graphn_scale(s : MathspeciallegendreGraphN, f : Double) -> MathspeciallegendreGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_graphn_add(a : MathspeciallegendreGraphN, b : MathspeciallegendreGraphN) -> MathspeciallegendreGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_graphn_copy(s : MathspeciallegendreGraphN) -> MathspeciallegendreGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_graphn_fill(s : MathspeciallegendreGraphN, v : Double) -> MathspeciallegendreGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_graphn_min(s : MathspeciallegendreGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_graphn_max(s : MathspeciallegendreGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_graphn_to_string(s : MathspeciallegendreGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_node_make(size : Int) -> MathspeciallegendreNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_node_len(s : MathspeciallegendreNode) -> Int { s.size }

pub fn math_special_legendre_node_get(s : MathspeciallegendreNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_node_set(s : MathspeciallegendreNode, i : Int, v : Double) -> MathspeciallegendreNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_node_sum(s : MathspeciallegendreNode) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_node_mean(s : MathspeciallegendreNode) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_node_scale(s : MathspeciallegendreNode, f : Double) -> MathspeciallegendreNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_node_add(a : MathspeciallegendreNode, b : MathspeciallegendreNode) -> MathspeciallegendreNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_node_copy(s : MathspeciallegendreNode) -> MathspeciallegendreNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_node_fill(s : MathspeciallegendreNode, v : Double) -> MathspeciallegendreNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_node_min(s : MathspeciallegendreNode) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_node_max(s : MathspeciallegendreNode) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_node_to_string(s : MathspeciallegendreNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_edge_make(size : Int) -> MathspeciallegendreEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_edge_len(s : MathspeciallegendreEdge) -> Int { s.size }

pub fn math_special_legendre_edge_get(s : MathspeciallegendreEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_edge_set(s : MathspeciallegendreEdge, i : Int, v : Double) -> MathspeciallegendreEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_edge_sum(s : MathspeciallegendreEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_edge_mean(s : MathspeciallegendreEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_edge_scale(s : MathspeciallegendreEdge, f : Double) -> MathspeciallegendreEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_edge_add(a : MathspeciallegendreEdge, b : MathspeciallegendreEdge) -> MathspeciallegendreEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_edge_copy(s : MathspeciallegendreEdge) -> MathspeciallegendreEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_edge_fill(s : MathspeciallegendreEdge, v : Double) -> MathspeciallegendreEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_edge_min(s : MathspeciallegendreEdge) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_edge_max(s : MathspeciallegendreEdge) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_edge_to_string(s : MathspeciallegendreEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendrePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_path_make(size : Int) -> MathspeciallegendrePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_path_len(s : MathspeciallegendrePath) -> Int { s.size }

pub fn math_special_legendre_path_get(s : MathspeciallegendrePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_path_set(s : MathspeciallegendrePath, i : Int, v : Double) -> MathspeciallegendrePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_path_sum(s : MathspeciallegendrePath) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_path_mean(s : MathspeciallegendrePath) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_path_scale(s : MathspeciallegendrePath, f : Double) -> MathspeciallegendrePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_path_add(a : MathspeciallegendrePath, b : MathspeciallegendrePath) -> MathspeciallegendrePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_path_copy(s : MathspeciallegendrePath) -> MathspeciallegendrePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_path_fill(s : MathspeciallegendrePath, v : Double) -> MathspeciallegendrePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_path_min(s : MathspeciallegendrePath) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_path_max(s : MathspeciallegendrePath) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_path_to_string(s : MathspeciallegendrePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_cluster_make(size : Int) -> MathspeciallegendreCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_cluster_len(s : MathspeciallegendreCluster) -> Int { s.size }

pub fn math_special_legendre_cluster_get(s : MathspeciallegendreCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_cluster_set(s : MathspeciallegendreCluster, i : Int, v : Double) -> MathspeciallegendreCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cluster_sum(s : MathspeciallegendreCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_cluster_mean(s : MathspeciallegendreCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_cluster_scale(s : MathspeciallegendreCluster, f : Double) -> MathspeciallegendreCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cluster_add(a : MathspeciallegendreCluster, b : MathspeciallegendreCluster) -> MathspeciallegendreCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_cluster_copy(s : MathspeciallegendreCluster) -> MathspeciallegendreCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cluster_fill(s : MathspeciallegendreCluster, v : Double) -> MathspeciallegendreCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cluster_min(s : MathspeciallegendreCluster) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_cluster_max(s : MathspeciallegendreCluster) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_cluster_to_string(s : MathspeciallegendreCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_model_make(size : Int) -> MathspeciallegendreModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_model_len(s : MathspeciallegendreModel) -> Int { s.size }

pub fn math_special_legendre_model_get(s : MathspeciallegendreModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_model_set(s : MathspeciallegendreModel, i : Int, v : Double) -> MathspeciallegendreModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_model_sum(s : MathspeciallegendreModel) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_model_mean(s : MathspeciallegendreModel) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_model_scale(s : MathspeciallegendreModel, f : Double) -> MathspeciallegendreModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_model_add(a : MathspeciallegendreModel, b : MathspeciallegendreModel) -> MathspeciallegendreModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_model_copy(s : MathspeciallegendreModel) -> MathspeciallegendreModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_model_fill(s : MathspeciallegendreModel, v : Double) -> MathspeciallegendreModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_model_min(s : MathspeciallegendreModel) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_model_max(s : MathspeciallegendreModel) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_model_to_string(s : MathspeciallegendreModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_layer_make(size : Int) -> MathspeciallegendreLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_layer_len(s : MathspeciallegendreLayer) -> Int { s.size }

pub fn math_special_legendre_layer_get(s : MathspeciallegendreLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_layer_set(s : MathspeciallegendreLayer, i : Int, v : Double) -> MathspeciallegendreLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_layer_sum(s : MathspeciallegendreLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_layer_mean(s : MathspeciallegendreLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_layer_scale(s : MathspeciallegendreLayer, f : Double) -> MathspeciallegendreLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_layer_add(a : MathspeciallegendreLayer, b : MathspeciallegendreLayer) -> MathspeciallegendreLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_layer_copy(s : MathspeciallegendreLayer) -> MathspeciallegendreLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_layer_fill(s : MathspeciallegendreLayer, v : Double) -> MathspeciallegendreLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_layer_min(s : MathspeciallegendreLayer) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_layer_max(s : MathspeciallegendreLayer) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_layer_to_string(s : MathspeciallegendreLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_buffer_make(size : Int) -> MathspeciallegendreBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_buffer_len(s : MathspeciallegendreBuffer) -> Int { s.size }

pub fn math_special_legendre_buffer_get(s : MathspeciallegendreBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_buffer_set(s : MathspeciallegendreBuffer, i : Int, v : Double) -> MathspeciallegendreBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_buffer_sum(s : MathspeciallegendreBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_buffer_mean(s : MathspeciallegendreBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_buffer_scale(s : MathspeciallegendreBuffer, f : Double) -> MathspeciallegendreBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_buffer_add(a : MathspeciallegendreBuffer, b : MathspeciallegendreBuffer) -> MathspeciallegendreBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_buffer_copy(s : MathspeciallegendreBuffer) -> MathspeciallegendreBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_buffer_fill(s : MathspeciallegendreBuffer, v : Double) -> MathspeciallegendreBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_buffer_min(s : MathspeciallegendreBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_buffer_max(s : MathspeciallegendreBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_buffer_to_string(s : MathspeciallegendreBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_cursor_make(size : Int) -> MathspeciallegendreCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_cursor_len(s : MathspeciallegendreCursor) -> Int { s.size }

pub fn math_special_legendre_cursor_get(s : MathspeciallegendreCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_cursor_set(s : MathspeciallegendreCursor, i : Int, v : Double) -> MathspeciallegendreCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cursor_sum(s : MathspeciallegendreCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_cursor_mean(s : MathspeciallegendreCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_cursor_scale(s : MathspeciallegendreCursor, f : Double) -> MathspeciallegendreCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cursor_add(a : MathspeciallegendreCursor, b : MathspeciallegendreCursor) -> MathspeciallegendreCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_cursor_copy(s : MathspeciallegendreCursor) -> MathspeciallegendreCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cursor_fill(s : MathspeciallegendreCursor, v : Double) -> MathspeciallegendreCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_cursor_min(s : MathspeciallegendreCursor) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_cursor_max(s : MathspeciallegendreCursor) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_cursor_to_string(s : MathspeciallegendreCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_view_make(size : Int) -> MathspeciallegendreView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_view_len(s : MathspeciallegendreView) -> Int { s.size }

pub fn math_special_legendre_view_get(s : MathspeciallegendreView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_view_set(s : MathspeciallegendreView, i : Int, v : Double) -> MathspeciallegendreView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_view_sum(s : MathspeciallegendreView) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_view_mean(s : MathspeciallegendreView) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_view_scale(s : MathspeciallegendreView, f : Double) -> MathspeciallegendreView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_view_add(a : MathspeciallegendreView, b : MathspeciallegendreView) -> MathspeciallegendreView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_view_copy(s : MathspeciallegendreView) -> MathspeciallegendreView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_view_fill(s : MathspeciallegendreView, v : Double) -> MathspeciallegendreView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_view_min(s : MathspeciallegendreView) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_view_max(s : MathspeciallegendreView) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_view_to_string(s : MathspeciallegendreView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_range_make(size : Int) -> MathspeciallegendreRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_range_len(s : MathspeciallegendreRange) -> Int { s.size }

pub fn math_special_legendre_range_get(s : MathspeciallegendreRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_range_set(s : MathspeciallegendreRange, i : Int, v : Double) -> MathspeciallegendreRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_range_sum(s : MathspeciallegendreRange) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_range_mean(s : MathspeciallegendreRange) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_range_scale(s : MathspeciallegendreRange, f : Double) -> MathspeciallegendreRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_range_add(a : MathspeciallegendreRange, b : MathspeciallegendreRange) -> MathspeciallegendreRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_range_copy(s : MathspeciallegendreRange) -> MathspeciallegendreRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_range_fill(s : MathspeciallegendreRange, v : Double) -> MathspeciallegendreRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_range_min(s : MathspeciallegendreRange) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_range_max(s : MathspeciallegendreRange) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_range_to_string(s : MathspeciallegendreRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallegendreSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_legendre_slice_make(size : Int) -> MathspeciallegendreSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_legendre_slice_len(s : MathspeciallegendreSlice) -> Int { s.size }

pub fn math_special_legendre_slice_get(s : MathspeciallegendreSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_legendre_slice_set(s : MathspeciallegendreSlice, i : Int, v : Double) -> MathspeciallegendreSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_legendre_slice_sum(s : MathspeciallegendreSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_legendre_slice_mean(s : MathspeciallegendreSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_legendre_slice_scale(s : MathspeciallegendreSlice, f : Double) -> MathspeciallegendreSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_slice_add(a : MathspeciallegendreSlice, b : MathspeciallegendreSlice) -> MathspeciallegendreSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_legendre_slice_copy(s : MathspeciallegendreSlice) -> MathspeciallegendreSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_slice_fill(s : MathspeciallegendreSlice, v : Double) -> MathspeciallegendreSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_legendre_slice_min(s : MathspeciallegendreSlice) -> Double { @_common.min(s.data) }

pub fn math_special_legendre_slice_max(s : MathspeciallegendreSlice) -> Double { @_common.max(s.data) }

pub fn math_special_legendre_slice_to_string(s : MathspeciallegendreSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

