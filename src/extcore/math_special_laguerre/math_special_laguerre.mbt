///===
/// extcore/math_special_laguerre

pub(all) struct MathspeciallaguerrePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_laguerre_make_point(x : Double, y : Double) -> MathspeciallaguerrePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_laguerre_make_point3(x : Double, y : Double, z : Double) -> MathspeciallaguerrePoint {
  { x, y, z, label: 0 }
}

pub fn MathspeciallaguerrePoint::x(self : MathspeciallaguerrePoint) -> Double { self.x }

pub fn MathspeciallaguerrePoint::y(self : MathspeciallaguerrePoint) -> Double { self.y }

pub fn MathspeciallaguerrePoint::z(self : MathspeciallaguerrePoint) -> Double { self.z }

pub fn MathspeciallaguerrePoint::label(self : MathspeciallaguerrePoint) -> Int { self.label }

pub fn MathspeciallaguerrePoint::dist(self : MathspeciallaguerrePoint, other : MathspeciallaguerrePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspeciallaguerrePoint::add(self : MathspeciallaguerrePoint, other : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspeciallaguerrePoint::sub(self : MathspeciallaguerrePoint, other : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspeciallaguerrePoint::scale(self : MathspeciallaguerrePoint, s : Double) -> MathspeciallaguerrePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspeciallaguerrePoint::dot(self : MathspeciallaguerrePoint, other : MathspeciallaguerrePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspeciallaguerrePoint::cross(self : MathspeciallaguerrePoint, other : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspeciallaguerrePoint::norm(self : MathspeciallaguerrePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspeciallaguerrePoint::normalize(self : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspeciallaguerrePoint::negate(self : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspeciallaguerrePoint::mid(self : MathspeciallaguerrePoint, other : MathspeciallaguerrePoint) -> MathspeciallaguerrePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspeciallaguerrePoint::lerp(self : MathspeciallaguerrePoint, other : MathspeciallaguerrePoint, t : Double) -> MathspeciallaguerrePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspeciallaguerrePoint::to_string(self : MathspeciallaguerrePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspeciallaguerreSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_laguerre_make_series(vals : Array[Double], name : String) -> MathspeciallaguerreSeries {
  { vals, name, meta: 0 }
}

pub fn MathspeciallaguerreSeries::len(self : MathspeciallaguerreSeries) -> Int { self.vals.length() }

pub fn MathspeciallaguerreSeries::sum(self : MathspeciallaguerreSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspeciallaguerreSeries::mean(self : MathspeciallaguerreSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspeciallaguerreSeries::min(self : MathspeciallaguerreSeries) -> Double { @_common.min(self.vals) }

pub fn MathspeciallaguerreSeries::max(self : MathspeciallaguerreSeries) -> Double { @_common.max(self.vals) }

pub fn MathspeciallaguerreSeries::range(self : MathspeciallaguerreSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspeciallaguerreSeries::variance(self : MathspeciallaguerreSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspeciallaguerreSeries::std(self : MathspeciallaguerreSeries) -> Double { @_common.std(self.vals) }

pub fn MathspeciallaguerreSeries::median(self : MathspeciallaguerreSeries) -> Double { @_common.median(self.vals) }

pub fn MathspeciallaguerreSeries::scale(self : MathspeciallaguerreSeries, f : Double) -> MathspeciallaguerreSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspeciallaguerreSeries::add(self : MathspeciallaguerreSeries, other : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspeciallaguerreSeries::sub(self : MathspeciallaguerreSeries, other : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspeciallaguerreSeries::normalize(self : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspeciallaguerreSeries::cumsum(self : MathspeciallaguerreSeries) -> MathspeciallaguerreSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspeciallaguerreSeries::to_string(self : MathspeciallaguerreSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspeciallaguerreMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_laguerre_make_matrix(rows : Int, cols : Int, val : Double) -> MathspeciallaguerreMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_laguerre_matrix_identity(n : Int) -> MathspeciallaguerreMatrix {
  let m = math_special_laguerre_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspeciallaguerreMatrix::get(self : MathspeciallaguerreMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspeciallaguerreMatrix::transpose(self : MathspeciallaguerreMatrix) -> MathspeciallaguerreMatrix {
  let result = math_special_laguerre_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspeciallaguerreMatrix::add(self : MathspeciallaguerreMatrix, other : MathspeciallaguerreMatrix) -> MathspeciallaguerreMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_laguerre_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspeciallaguerreMatrix::scale(self : MathspeciallaguerreMatrix, s : Double) -> MathspeciallaguerreMatrix {
  let result = math_special_laguerre_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspeciallaguerreMatrix::multiply(self : MathspeciallaguerreMatrix, other : MathspeciallaguerreMatrix) -> MathspeciallaguerreMatrix {
  if self.cols != other.rows { return math_special_laguerre_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_laguerre_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathspeciallaguerreMatrix::trace(self : MathspeciallaguerreMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspeciallaguerreMatrix::det(self : MathspeciallaguerreMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspeciallaguerreMatrix::norm(self : MathspeciallaguerreMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspeciallaguerreMatrix::to_string(self : MathspeciallaguerreMatrix) -> String {
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

pub(all) struct MathspeciallaguerreVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_laguerre_make_vector(comps : Array[Double]) -> MathspeciallaguerreVector {
  { comps, dim: comps.length() }
}

pub fn math_special_laguerre_vector_zero(dim : Int) -> MathspeciallaguerreVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspeciallaguerreVector::add(self : MathspeciallaguerreVector, other : MathspeciallaguerreVector) -> MathspeciallaguerreVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspeciallaguerreVector::sub(self : MathspeciallaguerreVector, other : MathspeciallaguerreVector) -> MathspeciallaguerreVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspeciallaguerreVector::scale(self : MathspeciallaguerreVector, s : Double) -> MathspeciallaguerreVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspeciallaguerreVector::dot(self : MathspeciallaguerreVector, other : MathspeciallaguerreVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspeciallaguerreVector::norm(self : MathspeciallaguerreVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspeciallaguerreVector::normalize(self : MathspeciallaguerreVector) -> MathspeciallaguerreVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspeciallaguerreVector::dist(self : MathspeciallaguerreVector, other : MathspeciallaguerreVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspeciallaguerreVector::to_string(self : MathspeciallaguerreVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_laguerre_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_laguerre_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_laguerre_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_laguerre_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_laguerre_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_laguerre_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_laguerre_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_laguerre_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_laguerre_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_laguerre_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_laguerre_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_laguerre_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_laguerre_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_laguerre_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_laguerre_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_laguerre_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_laguerre_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_laguerre_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_laguerre_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_laguerre_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_laguerre_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_laguerre_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_laguerre_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_laguerre_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_laguerre_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_laguerre_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_laguerre_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_laguerre_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_laguerre_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspeciallaguerreFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_frame_make(size : Int) -> MathspeciallaguerreFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_frame_len(s : MathspeciallaguerreFrame) -> Int { s.size }

pub fn math_special_laguerre_frame_get(s : MathspeciallaguerreFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_frame_set(s : MathspeciallaguerreFrame, i : Int, v : Double) -> MathspeciallaguerreFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_frame_sum(s : MathspeciallaguerreFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_frame_mean(s : MathspeciallaguerreFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_frame_scale(s : MathspeciallaguerreFrame, f : Double) -> MathspeciallaguerreFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_frame_add(a : MathspeciallaguerreFrame, b : MathspeciallaguerreFrame) -> MathspeciallaguerreFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_frame_copy(s : MathspeciallaguerreFrame) -> MathspeciallaguerreFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_frame_fill(s : MathspeciallaguerreFrame, v : Double) -> MathspeciallaguerreFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_frame_min(s : MathspeciallaguerreFrame) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_frame_max(s : MathspeciallaguerreFrame) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_frame_to_string(s : MathspeciallaguerreFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_table_make(size : Int) -> MathspeciallaguerreTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_table_len(s : MathspeciallaguerreTable) -> Int { s.size }

pub fn math_special_laguerre_table_get(s : MathspeciallaguerreTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_table_set(s : MathspeciallaguerreTable, i : Int, v : Double) -> MathspeciallaguerreTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_table_sum(s : MathspeciallaguerreTable) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_table_mean(s : MathspeciallaguerreTable) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_table_scale(s : MathspeciallaguerreTable, f : Double) -> MathspeciallaguerreTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_table_add(a : MathspeciallaguerreTable, b : MathspeciallaguerreTable) -> MathspeciallaguerreTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_table_copy(s : MathspeciallaguerreTable) -> MathspeciallaguerreTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_table_fill(s : MathspeciallaguerreTable, v : Double) -> MathspeciallaguerreTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_table_min(s : MathspeciallaguerreTable) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_table_max(s : MathspeciallaguerreTable) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_table_to_string(s : MathspeciallaguerreTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_graphn_make(size : Int) -> MathspeciallaguerreGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_graphn_len(s : MathspeciallaguerreGraphN) -> Int { s.size }

pub fn math_special_laguerre_graphn_get(s : MathspeciallaguerreGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_graphn_set(s : MathspeciallaguerreGraphN, i : Int, v : Double) -> MathspeciallaguerreGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_graphn_sum(s : MathspeciallaguerreGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_graphn_mean(s : MathspeciallaguerreGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_graphn_scale(s : MathspeciallaguerreGraphN, f : Double) -> MathspeciallaguerreGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_graphn_add(a : MathspeciallaguerreGraphN, b : MathspeciallaguerreGraphN) -> MathspeciallaguerreGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_graphn_copy(s : MathspeciallaguerreGraphN) -> MathspeciallaguerreGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_graphn_fill(s : MathspeciallaguerreGraphN, v : Double) -> MathspeciallaguerreGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_graphn_min(s : MathspeciallaguerreGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_graphn_max(s : MathspeciallaguerreGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_graphn_to_string(s : MathspeciallaguerreGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_node_make(size : Int) -> MathspeciallaguerreNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_node_len(s : MathspeciallaguerreNode) -> Int { s.size }

pub fn math_special_laguerre_node_get(s : MathspeciallaguerreNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_node_set(s : MathspeciallaguerreNode, i : Int, v : Double) -> MathspeciallaguerreNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_node_sum(s : MathspeciallaguerreNode) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_node_mean(s : MathspeciallaguerreNode) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_node_scale(s : MathspeciallaguerreNode, f : Double) -> MathspeciallaguerreNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_node_add(a : MathspeciallaguerreNode, b : MathspeciallaguerreNode) -> MathspeciallaguerreNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_node_copy(s : MathspeciallaguerreNode) -> MathspeciallaguerreNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_node_fill(s : MathspeciallaguerreNode, v : Double) -> MathspeciallaguerreNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_node_min(s : MathspeciallaguerreNode) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_node_max(s : MathspeciallaguerreNode) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_node_to_string(s : MathspeciallaguerreNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_edge_make(size : Int) -> MathspeciallaguerreEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_edge_len(s : MathspeciallaguerreEdge) -> Int { s.size }

pub fn math_special_laguerre_edge_get(s : MathspeciallaguerreEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_edge_set(s : MathspeciallaguerreEdge, i : Int, v : Double) -> MathspeciallaguerreEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_edge_sum(s : MathspeciallaguerreEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_edge_mean(s : MathspeciallaguerreEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_edge_scale(s : MathspeciallaguerreEdge, f : Double) -> MathspeciallaguerreEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_edge_add(a : MathspeciallaguerreEdge, b : MathspeciallaguerreEdge) -> MathspeciallaguerreEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_edge_copy(s : MathspeciallaguerreEdge) -> MathspeciallaguerreEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_edge_fill(s : MathspeciallaguerreEdge, v : Double) -> MathspeciallaguerreEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_edge_min(s : MathspeciallaguerreEdge) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_edge_max(s : MathspeciallaguerreEdge) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_edge_to_string(s : MathspeciallaguerreEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerrePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_path_make(size : Int) -> MathspeciallaguerrePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_path_len(s : MathspeciallaguerrePath) -> Int { s.size }

pub fn math_special_laguerre_path_get(s : MathspeciallaguerrePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_path_set(s : MathspeciallaguerrePath, i : Int, v : Double) -> MathspeciallaguerrePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_path_sum(s : MathspeciallaguerrePath) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_path_mean(s : MathspeciallaguerrePath) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_path_scale(s : MathspeciallaguerrePath, f : Double) -> MathspeciallaguerrePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_path_add(a : MathspeciallaguerrePath, b : MathspeciallaguerrePath) -> MathspeciallaguerrePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_path_copy(s : MathspeciallaguerrePath) -> MathspeciallaguerrePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_path_fill(s : MathspeciallaguerrePath, v : Double) -> MathspeciallaguerrePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_path_min(s : MathspeciallaguerrePath) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_path_max(s : MathspeciallaguerrePath) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_path_to_string(s : MathspeciallaguerrePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_cluster_make(size : Int) -> MathspeciallaguerreCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_cluster_len(s : MathspeciallaguerreCluster) -> Int { s.size }

pub fn math_special_laguerre_cluster_get(s : MathspeciallaguerreCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_cluster_set(s : MathspeciallaguerreCluster, i : Int, v : Double) -> MathspeciallaguerreCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cluster_sum(s : MathspeciallaguerreCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_cluster_mean(s : MathspeciallaguerreCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_cluster_scale(s : MathspeciallaguerreCluster, f : Double) -> MathspeciallaguerreCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cluster_add(a : MathspeciallaguerreCluster, b : MathspeciallaguerreCluster) -> MathspeciallaguerreCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_cluster_copy(s : MathspeciallaguerreCluster) -> MathspeciallaguerreCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cluster_fill(s : MathspeciallaguerreCluster, v : Double) -> MathspeciallaguerreCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cluster_min(s : MathspeciallaguerreCluster) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_cluster_max(s : MathspeciallaguerreCluster) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_cluster_to_string(s : MathspeciallaguerreCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_model_make(size : Int) -> MathspeciallaguerreModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_model_len(s : MathspeciallaguerreModel) -> Int { s.size }

pub fn math_special_laguerre_model_get(s : MathspeciallaguerreModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_model_set(s : MathspeciallaguerreModel, i : Int, v : Double) -> MathspeciallaguerreModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_model_sum(s : MathspeciallaguerreModel) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_model_mean(s : MathspeciallaguerreModel) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_model_scale(s : MathspeciallaguerreModel, f : Double) -> MathspeciallaguerreModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_model_add(a : MathspeciallaguerreModel, b : MathspeciallaguerreModel) -> MathspeciallaguerreModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_model_copy(s : MathspeciallaguerreModel) -> MathspeciallaguerreModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_model_fill(s : MathspeciallaguerreModel, v : Double) -> MathspeciallaguerreModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_model_min(s : MathspeciallaguerreModel) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_model_max(s : MathspeciallaguerreModel) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_model_to_string(s : MathspeciallaguerreModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_layer_make(size : Int) -> MathspeciallaguerreLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_layer_len(s : MathspeciallaguerreLayer) -> Int { s.size }

pub fn math_special_laguerre_layer_get(s : MathspeciallaguerreLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_layer_set(s : MathspeciallaguerreLayer, i : Int, v : Double) -> MathspeciallaguerreLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_layer_sum(s : MathspeciallaguerreLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_layer_mean(s : MathspeciallaguerreLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_layer_scale(s : MathspeciallaguerreLayer, f : Double) -> MathspeciallaguerreLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_layer_add(a : MathspeciallaguerreLayer, b : MathspeciallaguerreLayer) -> MathspeciallaguerreLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_layer_copy(s : MathspeciallaguerreLayer) -> MathspeciallaguerreLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_layer_fill(s : MathspeciallaguerreLayer, v : Double) -> MathspeciallaguerreLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_layer_min(s : MathspeciallaguerreLayer) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_layer_max(s : MathspeciallaguerreLayer) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_layer_to_string(s : MathspeciallaguerreLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_buffer_make(size : Int) -> MathspeciallaguerreBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_buffer_len(s : MathspeciallaguerreBuffer) -> Int { s.size }

pub fn math_special_laguerre_buffer_get(s : MathspeciallaguerreBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_buffer_set(s : MathspeciallaguerreBuffer, i : Int, v : Double) -> MathspeciallaguerreBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_buffer_sum(s : MathspeciallaguerreBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_buffer_mean(s : MathspeciallaguerreBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_buffer_scale(s : MathspeciallaguerreBuffer, f : Double) -> MathspeciallaguerreBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_buffer_add(a : MathspeciallaguerreBuffer, b : MathspeciallaguerreBuffer) -> MathspeciallaguerreBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_buffer_copy(s : MathspeciallaguerreBuffer) -> MathspeciallaguerreBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_buffer_fill(s : MathspeciallaguerreBuffer, v : Double) -> MathspeciallaguerreBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_buffer_min(s : MathspeciallaguerreBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_buffer_max(s : MathspeciallaguerreBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_buffer_to_string(s : MathspeciallaguerreBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_cursor_make(size : Int) -> MathspeciallaguerreCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_cursor_len(s : MathspeciallaguerreCursor) -> Int { s.size }

pub fn math_special_laguerre_cursor_get(s : MathspeciallaguerreCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_cursor_set(s : MathspeciallaguerreCursor, i : Int, v : Double) -> MathspeciallaguerreCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cursor_sum(s : MathspeciallaguerreCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_cursor_mean(s : MathspeciallaguerreCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_cursor_scale(s : MathspeciallaguerreCursor, f : Double) -> MathspeciallaguerreCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cursor_add(a : MathspeciallaguerreCursor, b : MathspeciallaguerreCursor) -> MathspeciallaguerreCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_cursor_copy(s : MathspeciallaguerreCursor) -> MathspeciallaguerreCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cursor_fill(s : MathspeciallaguerreCursor, v : Double) -> MathspeciallaguerreCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_cursor_min(s : MathspeciallaguerreCursor) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_cursor_max(s : MathspeciallaguerreCursor) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_cursor_to_string(s : MathspeciallaguerreCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_view_make(size : Int) -> MathspeciallaguerreView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_view_len(s : MathspeciallaguerreView) -> Int { s.size }

pub fn math_special_laguerre_view_get(s : MathspeciallaguerreView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_view_set(s : MathspeciallaguerreView, i : Int, v : Double) -> MathspeciallaguerreView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_view_sum(s : MathspeciallaguerreView) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_view_mean(s : MathspeciallaguerreView) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_view_scale(s : MathspeciallaguerreView, f : Double) -> MathspeciallaguerreView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_view_add(a : MathspeciallaguerreView, b : MathspeciallaguerreView) -> MathspeciallaguerreView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_view_copy(s : MathspeciallaguerreView) -> MathspeciallaguerreView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_view_fill(s : MathspeciallaguerreView, v : Double) -> MathspeciallaguerreView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_view_min(s : MathspeciallaguerreView) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_view_max(s : MathspeciallaguerreView) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_view_to_string(s : MathspeciallaguerreView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_range_make(size : Int) -> MathspeciallaguerreRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_range_len(s : MathspeciallaguerreRange) -> Int { s.size }

pub fn math_special_laguerre_range_get(s : MathspeciallaguerreRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_range_set(s : MathspeciallaguerreRange, i : Int, v : Double) -> MathspeciallaguerreRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_range_sum(s : MathspeciallaguerreRange) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_range_mean(s : MathspeciallaguerreRange) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_range_scale(s : MathspeciallaguerreRange, f : Double) -> MathspeciallaguerreRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_range_add(a : MathspeciallaguerreRange, b : MathspeciallaguerreRange) -> MathspeciallaguerreRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_range_copy(s : MathspeciallaguerreRange) -> MathspeciallaguerreRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_range_fill(s : MathspeciallaguerreRange, v : Double) -> MathspeciallaguerreRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_range_min(s : MathspeciallaguerreRange) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_range_max(s : MathspeciallaguerreRange) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_range_to_string(s : MathspeciallaguerreRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspeciallaguerreSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_laguerre_slice_make(size : Int) -> MathspeciallaguerreSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_laguerre_slice_len(s : MathspeciallaguerreSlice) -> Int { s.size }

pub fn math_special_laguerre_slice_get(s : MathspeciallaguerreSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_laguerre_slice_set(s : MathspeciallaguerreSlice, i : Int, v : Double) -> MathspeciallaguerreSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_slice_sum(s : MathspeciallaguerreSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_laguerre_slice_mean(s : MathspeciallaguerreSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_laguerre_slice_scale(s : MathspeciallaguerreSlice, f : Double) -> MathspeciallaguerreSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_slice_add(a : MathspeciallaguerreSlice, b : MathspeciallaguerreSlice) -> MathspeciallaguerreSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_laguerre_slice_copy(s : MathspeciallaguerreSlice) -> MathspeciallaguerreSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_slice_fill(s : MathspeciallaguerreSlice, v : Double) -> MathspeciallaguerreSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_laguerre_slice_min(s : MathspeciallaguerreSlice) -> Double { @_common.min(s.data) }

pub fn math_special_laguerre_slice_max(s : MathspeciallaguerreSlice) -> Double { @_common.max(s.data) }

pub fn math_special_laguerre_slice_to_string(s : MathspeciallaguerreSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

