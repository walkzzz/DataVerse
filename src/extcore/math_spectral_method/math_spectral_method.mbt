///===
/// extcore/math_spectral_method

pub(all) struct MathspectralmethodPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_spectral_method_make_point(x : Double, y : Double) -> MathspectralmethodPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_spectral_method_make_point3(x : Double, y : Double, z : Double) -> MathspectralmethodPoint {
  { x, y, z, label: 0 }
}

pub fn MathspectralmethodPoint::x(self : MathspectralmethodPoint) -> Double { self.x }

pub fn MathspectralmethodPoint::y(self : MathspectralmethodPoint) -> Double { self.y }

pub fn MathspectralmethodPoint::z(self : MathspectralmethodPoint) -> Double { self.z }

pub fn MathspectralmethodPoint::label(self : MathspectralmethodPoint) -> Int { self.label }

pub fn MathspectralmethodPoint::dist(self : MathspectralmethodPoint, other : MathspectralmethodPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspectralmethodPoint::add(self : MathspectralmethodPoint, other : MathspectralmethodPoint) -> MathspectralmethodPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspectralmethodPoint::sub(self : MathspectralmethodPoint, other : MathspectralmethodPoint) -> MathspectralmethodPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspectralmethodPoint::scale(self : MathspectralmethodPoint, s : Double) -> MathspectralmethodPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspectralmethodPoint::dot(self : MathspectralmethodPoint, other : MathspectralmethodPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspectralmethodPoint::cross(self : MathspectralmethodPoint, other : MathspectralmethodPoint) -> MathspectralmethodPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspectralmethodPoint::norm(self : MathspectralmethodPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspectralmethodPoint::normalize(self : MathspectralmethodPoint) -> MathspectralmethodPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspectralmethodPoint::negate(self : MathspectralmethodPoint) -> MathspectralmethodPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspectralmethodPoint::mid(self : MathspectralmethodPoint, other : MathspectralmethodPoint) -> MathspectralmethodPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspectralmethodPoint::lerp(self : MathspectralmethodPoint, other : MathspectralmethodPoint, t : Double) -> MathspectralmethodPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspectralmethodPoint::to_string(self : MathspectralmethodPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspectralmethodSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_spectral_method_make_series(vals : Array[Double], name : String) -> MathspectralmethodSeries {
  { vals, name, meta: 0 }
}

pub fn MathspectralmethodSeries::len(self : MathspectralmethodSeries) -> Int { self.vals.length() }

pub fn MathspectralmethodSeries::sum(self : MathspectralmethodSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspectralmethodSeries::mean(self : MathspectralmethodSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspectralmethodSeries::min(self : MathspectralmethodSeries) -> Double { @_common.min(self.vals) }

pub fn MathspectralmethodSeries::max(self : MathspectralmethodSeries) -> Double { @_common.max(self.vals) }

pub fn MathspectralmethodSeries::range(self : MathspectralmethodSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspectralmethodSeries::variance(self : MathspectralmethodSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspectralmethodSeries::std(self : MathspectralmethodSeries) -> Double { @_common.std(self.vals) }

pub fn MathspectralmethodSeries::median(self : MathspectralmethodSeries) -> Double { @_common.median(self.vals) }

pub fn MathspectralmethodSeries::scale(self : MathspectralmethodSeries, f : Double) -> MathspectralmethodSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspectralmethodSeries::add(self : MathspectralmethodSeries, other : MathspectralmethodSeries) -> MathspectralmethodSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspectralmethodSeries::sub(self : MathspectralmethodSeries, other : MathspectralmethodSeries) -> MathspectralmethodSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspectralmethodSeries::normalize(self : MathspectralmethodSeries) -> MathspectralmethodSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspectralmethodSeries::cumsum(self : MathspectralmethodSeries) -> MathspectralmethodSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspectralmethodSeries::to_string(self : MathspectralmethodSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspectralmethodMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_spectral_method_make_matrix(rows : Int, cols : Int, val : Double) -> MathspectralmethodMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_spectral_method_matrix_identity(n : Int) -> MathspectralmethodMatrix {
  let m = math_spectral_method_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspectralmethodMatrix::get(self : MathspectralmethodMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspectralmethodMatrix::transpose(self : MathspectralmethodMatrix) -> MathspectralmethodMatrix {
  let result = math_spectral_method_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspectralmethodMatrix::add(self : MathspectralmethodMatrix, other : MathspectralmethodMatrix) -> MathspectralmethodMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_spectral_method_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspectralmethodMatrix::scale(self : MathspectralmethodMatrix, s : Double) -> MathspectralmethodMatrix {
  let result = math_spectral_method_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspectralmethodMatrix::multiply(self : MathspectralmethodMatrix, other : MathspectralmethodMatrix) -> MathspectralmethodMatrix {
  if self.cols != other.rows { return math_spectral_method_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_spectral_method_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathspectralmethodMatrix::trace(self : MathspectralmethodMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspectralmethodMatrix::det(self : MathspectralmethodMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspectralmethodMatrix::norm(self : MathspectralmethodMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspectralmethodMatrix::to_string(self : MathspectralmethodMatrix) -> String {
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

pub(all) struct MathspectralmethodVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_spectral_method_make_vector(comps : Array[Double]) -> MathspectralmethodVector {
  { comps, dim: comps.length() }
}

pub fn math_spectral_method_vector_zero(dim : Int) -> MathspectralmethodVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspectralmethodVector::add(self : MathspectralmethodVector, other : MathspectralmethodVector) -> MathspectralmethodVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspectralmethodVector::sub(self : MathspectralmethodVector, other : MathspectralmethodVector) -> MathspectralmethodVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspectralmethodVector::scale(self : MathspectralmethodVector, s : Double) -> MathspectralmethodVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspectralmethodVector::dot(self : MathspectralmethodVector, other : MathspectralmethodVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspectralmethodVector::norm(self : MathspectralmethodVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspectralmethodVector::normalize(self : MathspectralmethodVector) -> MathspectralmethodVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspectralmethodVector::dist(self : MathspectralmethodVector, other : MathspectralmethodVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspectralmethodVector::to_string(self : MathspectralmethodVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_spectral_method_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_spectral_method_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_spectral_method_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_spectral_method_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_spectral_method_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_spectral_method_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_spectral_method_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_spectral_method_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_spectral_method_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_spectral_method_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_spectral_method_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_spectral_method_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_spectral_method_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_spectral_method_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_spectral_method_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_spectral_method_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_spectral_method_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_spectral_method_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_spectral_method_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_spectral_method_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_spectral_method_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_spectral_method_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_spectral_method_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_spectral_method_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_spectral_method_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_spectral_method_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_spectral_method_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_spectral_method_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_spectral_method_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspectralmethodFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_frame_make(size : Int) -> MathspectralmethodFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_frame_len(s : MathspectralmethodFrame) -> Int { s.size }

pub fn math_spectral_method_frame_get(s : MathspectralmethodFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_frame_set(s : MathspectralmethodFrame, i : Int, v : Double) -> MathspectralmethodFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_spectral_method_frame_sum(s : MathspectralmethodFrame) -> Double { @_common.sum(s.data) }

pub fn math_spectral_method_frame_mean(s : MathspectralmethodFrame) -> Double { @_common.mean(s.data) }

pub fn math_spectral_method_frame_scale(s : MathspectralmethodFrame, f : Double) -> MathspectralmethodFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_frame_add(a : MathspectralmethodFrame, b : MathspectralmethodFrame) -> MathspectralmethodFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_spectral_method_frame_copy(s : MathspectralmethodFrame) -> MathspectralmethodFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_frame_fill(s : MathspectralmethodFrame, v : Double) -> MathspectralmethodFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_frame_min(s : MathspectralmethodFrame) -> Double { @_common.min(s.data) }

pub fn math_spectral_method_frame_max(s : MathspectralmethodFrame) -> Double { @_common.max(s.data) }

pub fn math_spectral_method_frame_to_string(s : MathspectralmethodFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_table_make(size : Int) -> MathspectralmethodTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_table_len(s : MathspectralmethodTable) -> Int { s.size }

pub fn math_spectral_method_table_get(s : MathspectralmethodTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_table_set(s : MathspectralmethodTable, i : Int, v : Double) -> MathspectralmethodTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_spectral_method_table_sum(s : MathspectralmethodTable) -> Double { @_common.sum(s.data) }

pub fn math_spectral_method_table_mean(s : MathspectralmethodTable) -> Double { @_common.mean(s.data) }

pub fn math_spectral_method_table_scale(s : MathspectralmethodTable, f : Double) -> MathspectralmethodTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_table_add(a : MathspectralmethodTable, b : MathspectralmethodTable) -> MathspectralmethodTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_spectral_method_table_copy(s : MathspectralmethodTable) -> MathspectralmethodTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_table_fill(s : MathspectralmethodTable, v : Double) -> MathspectralmethodTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_table_min(s : MathspectralmethodTable) -> Double { @_common.min(s.data) }

pub fn math_spectral_method_table_max(s : MathspectralmethodTable) -> Double { @_common.max(s.data) }

pub fn math_spectral_method_table_to_string(s : MathspectralmethodTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_graphn_make(size : Int) -> MathspectralmethodGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_graphn_len(s : MathspectralmethodGraphN) -> Int { s.size }

pub fn math_spectral_method_graphn_get(s : MathspectralmethodGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_graphn_set(s : MathspectralmethodGraphN, i : Int, v : Double) -> MathspectralmethodGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_spectral_method_graphn_sum(s : MathspectralmethodGraphN) -> Double { @_common.sum(s.data) }

pub fn math_spectral_method_graphn_mean(s : MathspectralmethodGraphN) -> Double { @_common.mean(s.data) }

pub fn math_spectral_method_graphn_scale(s : MathspectralmethodGraphN, f : Double) -> MathspectralmethodGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_graphn_add(a : MathspectralmethodGraphN, b : MathspectralmethodGraphN) -> MathspectralmethodGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_spectral_method_graphn_copy(s : MathspectralmethodGraphN) -> MathspectralmethodGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_graphn_fill(s : MathspectralmethodGraphN, v : Double) -> MathspectralmethodGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_graphn_min(s : MathspectralmethodGraphN) -> Double { @_common.min(s.data) }

pub fn math_spectral_method_graphn_max(s : MathspectralmethodGraphN) -> Double { @_common.max(s.data) }

pub fn math_spectral_method_graphn_to_string(s : MathspectralmethodGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_node_make(size : Int) -> MathspectralmethodNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_node_len(s : MathspectralmethodNode) -> Int { s.size }

pub fn math_spectral_method_node_get(s : MathspectralmethodNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_node_set(s : MathspectralmethodNode, i : Int, v : Double) -> MathspectralmethodNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_spectral_method_node_sum(s : MathspectralmethodNode) -> Double { @_common.sum(s.data) }

pub fn math_spectral_method_node_mean(s : MathspectralmethodNode) -> Double { @_common.mean(s.data) }

pub fn math_spectral_method_node_scale(s : MathspectralmethodNode, f : Double) -> MathspectralmethodNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_node_add(a : MathspectralmethodNode, b : MathspectralmethodNode) -> MathspectralmethodNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_spectral_method_node_copy(s : MathspectralmethodNode) -> MathspectralmethodNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_node_fill(s : MathspectralmethodNode, v : Double) -> MathspectralmethodNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_node_min(s : MathspectralmethodNode) -> Double { @_common.min(s.data) }

pub fn math_spectral_method_node_max(s : MathspectralmethodNode) -> Double { @_common.max(s.data) }

pub fn math_spectral_method_node_to_string(s : MathspectralmethodNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_edge_make(size : Int) -> MathspectralmethodEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_edge_len(s : MathspectralmethodEdge) -> Int { s.size }

pub fn math_spectral_method_edge_get(s : MathspectralmethodEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_edge_set(s : MathspectralmethodEdge, i : Int, v : Double) -> MathspectralmethodEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_spectral_method_edge_sum(s : MathspectralmethodEdge) -> Double { @_common.sum(s.data) }

pub fn math_spectral_method_edge_mean(s : MathspectralmethodEdge) -> Double { @_common.mean(s.data) }

pub fn math_spectral_method_edge_scale(s : MathspectralmethodEdge, f : Double) -> MathspectralmethodEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_edge_add(a : MathspectralmethodEdge, b : MathspectralmethodEdge) -> MathspectralmethodEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_spectral_method_edge_copy(s : MathspectralmethodEdge) -> MathspectralmethodEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_edge_fill(s : MathspectralmethodEdge, v : Double) -> MathspectralmethodEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_edge_min(s : MathspectralmethodEdge) -> Double { @_common.min(s.data) }

pub fn math_spectral_method_edge_max(s : MathspectralmethodEdge) -> Double { @_common.max(s.data) }

pub fn math_spectral_method_edge_to_string(s : MathspectralmethodEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_path_make(size : Int) -> MathspectralmethodPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_path_len(s : MathspectralmethodPath) -> Int { s.size }

pub fn math_spectral_method_path_get(s : MathspectralmethodPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_path_set(s : MathspectralmethodPath, i : Int, v : Double) -> MathspectralmethodPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_spectral_method_path_sum(s : MathspectralmethodPath) -> Double { @_common.sum(s.data) }

pub fn math_spectral_method_path_mean(s : MathspectralmethodPath) -> Double { @_common.mean(s.data) }

pub fn math_spectral_method_path_scale(s : MathspectralmethodPath, f : Double) -> MathspectralmethodPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_path_add(a : MathspectralmethodPath, b : MathspectralmethodPath) -> MathspectralmethodPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_spectral_method_path_copy(s : MathspectralmethodPath) -> MathspectralmethodPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_path_fill(s : MathspectralmethodPath, v : Double) -> MathspectralmethodPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_path_min(s : MathspectralmethodPath) -> Double { @_common.min(s.data) }

pub fn math_spectral_method_path_max(s : MathspectralmethodPath) -> Double { @_common.max(s.data) }

pub fn math_spectral_method_path_to_string(s : MathspectralmethodPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_cluster_make(size : Int) -> MathspectralmethodCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_cluster_len(s : MathspectralmethodCluster) -> Int { s.size }

pub fn math_spectral_method_cluster_get(s : MathspectralmethodCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_cluster_set(s : MathspectralmethodCluster, i : Int, v : Double) -> MathspectralmethodCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_spectral_method_cluster_sum(s : MathspectralmethodCluster) -> Double { @_common.sum(s.data) }

pub fn math_spectral_method_cluster_mean(s : MathspectralmethodCluster) -> Double { @_common.mean(s.data) }

pub fn math_spectral_method_cluster_scale(s : MathspectralmethodCluster, f : Double) -> MathspectralmethodCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_cluster_add(a : MathspectralmethodCluster, b : MathspectralmethodCluster) -> MathspectralmethodCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_spectral_method_cluster_copy(s : MathspectralmethodCluster) -> MathspectralmethodCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_cluster_fill(s : MathspectralmethodCluster, v : Double) -> MathspectralmethodCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_cluster_min(s : MathspectralmethodCluster) -> Double { @_common.min(s.data) }

pub fn math_spectral_method_cluster_max(s : MathspectralmethodCluster) -> Double { @_common.max(s.data) }

pub fn math_spectral_method_cluster_to_string(s : MathspectralmethodCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_model_make(size : Int) -> MathspectralmethodModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_model_len(s : MathspectralmethodModel) -> Int { s.size }

pub fn math_spectral_method_model_get(s : MathspectralmethodModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_model_set(s : MathspectralmethodModel, i : Int, v : Double) -> MathspectralmethodModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_spectral_method_model_sum(s : MathspectralmethodModel) -> Double { @_common.sum(s.data) }

pub fn math_spectral_method_model_mean(s : MathspectralmethodModel) -> Double { @_common.mean(s.data) }

pub fn math_spectral_method_model_scale(s : MathspectralmethodModel, f : Double) -> MathspectralmethodModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_model_add(a : MathspectralmethodModel, b : MathspectralmethodModel) -> MathspectralmethodModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_spectral_method_model_copy(s : MathspectralmethodModel) -> MathspectralmethodModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_model_fill(s : MathspectralmethodModel, v : Double) -> MathspectralmethodModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_model_min(s : MathspectralmethodModel) -> Double { @_common.min(s.data) }

pub fn math_spectral_method_model_max(s : MathspectralmethodModel) -> Double { @_common.max(s.data) }

pub fn math_spectral_method_model_to_string(s : MathspectralmethodModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_layer_make(size : Int) -> MathspectralmethodLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_layer_len(s : MathspectralmethodLayer) -> Int { s.size }

pub fn math_spectral_method_layer_get(s : MathspectralmethodLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_layer_set(s : MathspectralmethodLayer, i : Int, v : Double) -> MathspectralmethodLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_spectral_method_layer_sum(s : MathspectralmethodLayer) -> Double { @_common.sum(s.data) }

pub fn math_spectral_method_layer_mean(s : MathspectralmethodLayer) -> Double { @_common.mean(s.data) }

pub fn math_spectral_method_layer_scale(s : MathspectralmethodLayer, f : Double) -> MathspectralmethodLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_layer_add(a : MathspectralmethodLayer, b : MathspectralmethodLayer) -> MathspectralmethodLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_spectral_method_layer_copy(s : MathspectralmethodLayer) -> MathspectralmethodLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_layer_fill(s : MathspectralmethodLayer, v : Double) -> MathspectralmethodLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_layer_min(s : MathspectralmethodLayer) -> Double { @_common.min(s.data) }

pub fn math_spectral_method_layer_max(s : MathspectralmethodLayer) -> Double { @_common.max(s.data) }

pub fn math_spectral_method_layer_to_string(s : MathspectralmethodLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_buffer_make(size : Int) -> MathspectralmethodBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_buffer_len(s : MathspectralmethodBuffer) -> Int { s.size }

pub fn math_spectral_method_buffer_get(s : MathspectralmethodBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_buffer_set(s : MathspectralmethodBuffer, i : Int, v : Double) -> MathspectralmethodBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_spectral_method_buffer_sum(s : MathspectralmethodBuffer) -> Double { @_common.sum(s.data) }

pub fn math_spectral_method_buffer_mean(s : MathspectralmethodBuffer) -> Double { @_common.mean(s.data) }

pub fn math_spectral_method_buffer_scale(s : MathspectralmethodBuffer, f : Double) -> MathspectralmethodBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_buffer_add(a : MathspectralmethodBuffer, b : MathspectralmethodBuffer) -> MathspectralmethodBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_spectral_method_buffer_copy(s : MathspectralmethodBuffer) -> MathspectralmethodBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_buffer_fill(s : MathspectralmethodBuffer, v : Double) -> MathspectralmethodBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_buffer_min(s : MathspectralmethodBuffer) -> Double { @_common.min(s.data) }

pub fn math_spectral_method_buffer_max(s : MathspectralmethodBuffer) -> Double { @_common.max(s.data) }

pub fn math_spectral_method_buffer_to_string(s : MathspectralmethodBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_cursor_make(size : Int) -> MathspectralmethodCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_cursor_len(s : MathspectralmethodCursor) -> Int { s.size }

pub fn math_spectral_method_cursor_get(s : MathspectralmethodCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_cursor_set(s : MathspectralmethodCursor, i : Int, v : Double) -> MathspectralmethodCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_spectral_method_cursor_sum(s : MathspectralmethodCursor) -> Double { @_common.sum(s.data) }

pub fn math_spectral_method_cursor_mean(s : MathspectralmethodCursor) -> Double { @_common.mean(s.data) }

pub fn math_spectral_method_cursor_scale(s : MathspectralmethodCursor, f : Double) -> MathspectralmethodCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_cursor_add(a : MathspectralmethodCursor, b : MathspectralmethodCursor) -> MathspectralmethodCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_spectral_method_cursor_copy(s : MathspectralmethodCursor) -> MathspectralmethodCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_cursor_fill(s : MathspectralmethodCursor, v : Double) -> MathspectralmethodCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_cursor_min(s : MathspectralmethodCursor) -> Double { @_common.min(s.data) }

pub fn math_spectral_method_cursor_max(s : MathspectralmethodCursor) -> Double { @_common.max(s.data) }

pub fn math_spectral_method_cursor_to_string(s : MathspectralmethodCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_view_make(size : Int) -> MathspectralmethodView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_view_len(s : MathspectralmethodView) -> Int { s.size }

pub fn math_spectral_method_view_get(s : MathspectralmethodView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_view_set(s : MathspectralmethodView, i : Int, v : Double) -> MathspectralmethodView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_spectral_method_view_sum(s : MathspectralmethodView) -> Double { @_common.sum(s.data) }

pub fn math_spectral_method_view_mean(s : MathspectralmethodView) -> Double { @_common.mean(s.data) }

pub fn math_spectral_method_view_scale(s : MathspectralmethodView, f : Double) -> MathspectralmethodView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_view_add(a : MathspectralmethodView, b : MathspectralmethodView) -> MathspectralmethodView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_spectral_method_view_copy(s : MathspectralmethodView) -> MathspectralmethodView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_view_fill(s : MathspectralmethodView, v : Double) -> MathspectralmethodView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_view_min(s : MathspectralmethodView) -> Double { @_common.min(s.data) }

pub fn math_spectral_method_view_max(s : MathspectralmethodView) -> Double { @_common.max(s.data) }

pub fn math_spectral_method_view_to_string(s : MathspectralmethodView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_range_make(size : Int) -> MathspectralmethodRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_range_len(s : MathspectralmethodRange) -> Int { s.size }

pub fn math_spectral_method_range_get(s : MathspectralmethodRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_range_set(s : MathspectralmethodRange, i : Int, v : Double) -> MathspectralmethodRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_spectral_method_range_sum(s : MathspectralmethodRange) -> Double { @_common.sum(s.data) }

pub fn math_spectral_method_range_mean(s : MathspectralmethodRange) -> Double { @_common.mean(s.data) }

pub fn math_spectral_method_range_scale(s : MathspectralmethodRange, f : Double) -> MathspectralmethodRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_range_add(a : MathspectralmethodRange, b : MathspectralmethodRange) -> MathspectralmethodRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_spectral_method_range_copy(s : MathspectralmethodRange) -> MathspectralmethodRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_range_fill(s : MathspectralmethodRange, v : Double) -> MathspectralmethodRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_range_min(s : MathspectralmethodRange) -> Double { @_common.min(s.data) }

pub fn math_spectral_method_range_max(s : MathspectralmethodRange) -> Double { @_common.max(s.data) }

pub fn math_spectral_method_range_to_string(s : MathspectralmethodRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspectralmethodSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_spectral_method_slice_make(size : Int) -> MathspectralmethodSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_spectral_method_slice_len(s : MathspectralmethodSlice) -> Int { s.size }

pub fn math_spectral_method_slice_get(s : MathspectralmethodSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_spectral_method_slice_set(s : MathspectralmethodSlice, i : Int, v : Double) -> MathspectralmethodSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_spectral_method_slice_sum(s : MathspectralmethodSlice) -> Double { @_common.sum(s.data) }

pub fn math_spectral_method_slice_mean(s : MathspectralmethodSlice) -> Double { @_common.mean(s.data) }

pub fn math_spectral_method_slice_scale(s : MathspectralmethodSlice, f : Double) -> MathspectralmethodSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_slice_add(a : MathspectralmethodSlice, b : MathspectralmethodSlice) -> MathspectralmethodSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_spectral_method_slice_copy(s : MathspectralmethodSlice) -> MathspectralmethodSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_slice_fill(s : MathspectralmethodSlice, v : Double) -> MathspectralmethodSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_spectral_method_slice_min(s : MathspectralmethodSlice) -> Double { @_common.min(s.data) }

pub fn math_spectral_method_slice_max(s : MathspectralmethodSlice) -> Double { @_common.max(s.data) }

pub fn math_spectral_method_slice_to_string(s : MathspectralmethodSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

