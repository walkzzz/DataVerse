///===
/// extcore/math_special_elliptic

pub(all) struct MathspecialellipticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn math_special_elliptic_make_point(x : Double, y : Double) -> MathspecialellipticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn math_special_elliptic_make_point3(x : Double, y : Double, z : Double) -> MathspecialellipticPoint {
  { x, y, z, label: 0 }
}

pub fn MathspecialellipticPoint::x(self : MathspecialellipticPoint) -> Double { self.x }

pub fn MathspecialellipticPoint::y(self : MathspecialellipticPoint) -> Double { self.y }

pub fn MathspecialellipticPoint::z(self : MathspecialellipticPoint) -> Double { self.z }

pub fn MathspecialellipticPoint::label(self : MathspecialellipticPoint) -> Int { self.label }

pub fn MathspecialellipticPoint::dist(self : MathspecialellipticPoint, other : MathspecialellipticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MathspecialellipticPoint::add(self : MathspecialellipticPoint, other : MathspecialellipticPoint) -> MathspecialellipticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MathspecialellipticPoint::sub(self : MathspecialellipticPoint, other : MathspecialellipticPoint) -> MathspecialellipticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MathspecialellipticPoint::scale(self : MathspecialellipticPoint, s : Double) -> MathspecialellipticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MathspecialellipticPoint::dot(self : MathspecialellipticPoint, other : MathspecialellipticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MathspecialellipticPoint::cross(self : MathspecialellipticPoint, other : MathspecialellipticPoint) -> MathspecialellipticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MathspecialellipticPoint::norm(self : MathspecialellipticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MathspecialellipticPoint::normalize(self : MathspecialellipticPoint) -> MathspecialellipticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialellipticPoint::negate(self : MathspecialellipticPoint) -> MathspecialellipticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MathspecialellipticPoint::mid(self : MathspecialellipticPoint, other : MathspecialellipticPoint) -> MathspecialellipticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MathspecialellipticPoint::lerp(self : MathspecialellipticPoint, other : MathspecialellipticPoint, t : Double) -> MathspecialellipticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MathspecialellipticPoint::to_string(self : MathspecialellipticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MathspecialellipticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn math_special_elliptic_make_series(vals : Array[Double], name : String) -> MathspecialellipticSeries {
  { vals, name, meta: 0 }
}

pub fn MathspecialellipticSeries::len(self : MathspecialellipticSeries) -> Int { self.vals.length() }

pub fn MathspecialellipticSeries::sum(self : MathspecialellipticSeries) -> Double { @_common.sum(self.vals) }

pub fn MathspecialellipticSeries::mean(self : MathspecialellipticSeries) -> Double { @_common.mean(self.vals) }

pub fn MathspecialellipticSeries::min(self : MathspecialellipticSeries) -> Double { @_common.min(self.vals) }

pub fn MathspecialellipticSeries::max(self : MathspecialellipticSeries) -> Double { @_common.max(self.vals) }

pub fn MathspecialellipticSeries::range(self : MathspecialellipticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MathspecialellipticSeries::variance(self : MathspecialellipticSeries) -> Double { @_common.variance(self.vals) }

pub fn MathspecialellipticSeries::std(self : MathspecialellipticSeries) -> Double { @_common.std(self.vals) }

pub fn MathspecialellipticSeries::median(self : MathspecialellipticSeries) -> Double { @_common.median(self.vals) }

pub fn MathspecialellipticSeries::scale(self : MathspecialellipticSeries, f : Double) -> MathspecialellipticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MathspecialellipticSeries::add(self : MathspecialellipticSeries, other : MathspecialellipticSeries) -> MathspecialellipticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MathspecialellipticSeries::sub(self : MathspecialellipticSeries, other : MathspecialellipticSeries) -> MathspecialellipticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MathspecialellipticSeries::normalize(self : MathspecialellipticSeries) -> MathspecialellipticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MathspecialellipticSeries::cumsum(self : MathspecialellipticSeries) -> MathspecialellipticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MathspecialellipticSeries::to_string(self : MathspecialellipticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MathspecialellipticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn math_special_elliptic_make_matrix(rows : Int, cols : Int, val : Double) -> MathspecialellipticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn math_special_elliptic_matrix_identity(n : Int) -> MathspecialellipticMatrix {
  let m = math_special_elliptic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MathspecialellipticMatrix::get(self : MathspecialellipticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MathspecialellipticMatrix::transpose(self : MathspecialellipticMatrix) -> MathspecialellipticMatrix {
  let result = math_special_elliptic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MathspecialellipticMatrix::add(self : MathspecialellipticMatrix, other : MathspecialellipticMatrix) -> MathspecialellipticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = math_special_elliptic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MathspecialellipticMatrix::scale(self : MathspecialellipticMatrix, s : Double) -> MathspecialellipticMatrix {
  let result = math_special_elliptic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MathspecialellipticMatrix::multiply(self : MathspecialellipticMatrix, other : MathspecialellipticMatrix) -> MathspecialellipticMatrix {
  if self.cols != other.rows { return math_special_elliptic_make_matrix(self.rows, other.cols, 0.0) }
  let result = math_special_elliptic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MathspecialellipticMatrix::trace(self : MathspecialellipticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MathspecialellipticMatrix::det(self : MathspecialellipticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MathspecialellipticMatrix::norm(self : MathspecialellipticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MathspecialellipticMatrix::to_string(self : MathspecialellipticMatrix) -> String {
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

pub(all) struct MathspecialellipticVector {
  comps : Array[Double]
  dim : Int
}

pub fn math_special_elliptic_make_vector(comps : Array[Double]) -> MathspecialellipticVector {
  { comps, dim: comps.length() }
}

pub fn math_special_elliptic_vector_zero(dim : Int) -> MathspecialellipticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MathspecialellipticVector::add(self : MathspecialellipticVector, other : MathspecialellipticVector) -> MathspecialellipticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialellipticVector::sub(self : MathspecialellipticVector, other : MathspecialellipticVector) -> MathspecialellipticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MathspecialellipticVector::scale(self : MathspecialellipticVector, s : Double) -> MathspecialellipticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MathspecialellipticVector::dot(self : MathspecialellipticVector, other : MathspecialellipticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MathspecialellipticVector::norm(self : MathspecialellipticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MathspecialellipticVector::normalize(self : MathspecialellipticVector) -> MathspecialellipticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MathspecialellipticVector::dist(self : MathspecialellipticVector, other : MathspecialellipticVector) -> Double {
  self.sub(other).norm()
}

pub fn MathspecialellipticVector::to_string(self : MathspecialellipticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn math_special_elliptic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn math_special_elliptic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn math_special_elliptic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn math_special_elliptic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn math_special_elliptic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn math_special_elliptic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn math_special_elliptic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn math_special_elliptic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn math_special_elliptic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn math_special_elliptic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn math_special_elliptic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn math_special_elliptic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn math_special_elliptic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn math_special_elliptic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn math_special_elliptic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn math_special_elliptic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn math_special_elliptic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn math_special_elliptic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn math_special_elliptic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn math_special_elliptic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn math_special_elliptic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn math_special_elliptic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn math_special_elliptic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn math_special_elliptic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn math_special_elliptic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn math_special_elliptic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn math_special_elliptic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn math_special_elliptic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn math_special_elliptic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MathspecialellipticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_frame_make(size : Int) -> MathspecialellipticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_frame_len(s : MathspecialellipticFrame) -> Int { s.size }

pub fn math_special_elliptic_frame_get(s : MathspecialellipticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_frame_set(s : MathspecialellipticFrame, i : Int, v : Double) -> MathspecialellipticFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_frame_sum(s : MathspecialellipticFrame) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_frame_mean(s : MathspecialellipticFrame) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_frame_scale(s : MathspecialellipticFrame, f : Double) -> MathspecialellipticFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_frame_add(a : MathspecialellipticFrame, b : MathspecialellipticFrame) -> MathspecialellipticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_elliptic_frame_copy(s : MathspecialellipticFrame) -> MathspecialellipticFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_frame_fill(s : MathspecialellipticFrame, v : Double) -> MathspecialellipticFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_frame_min(s : MathspecialellipticFrame) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_frame_max(s : MathspecialellipticFrame) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_frame_to_string(s : MathspecialellipticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_table_make(size : Int) -> MathspecialellipticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_table_len(s : MathspecialellipticTable) -> Int { s.size }

pub fn math_special_elliptic_table_get(s : MathspecialellipticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_table_set(s : MathspecialellipticTable, i : Int, v : Double) -> MathspecialellipticTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_table_sum(s : MathspecialellipticTable) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_table_mean(s : MathspecialellipticTable) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_table_scale(s : MathspecialellipticTable, f : Double) -> MathspecialellipticTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_table_add(a : MathspecialellipticTable, b : MathspecialellipticTable) -> MathspecialellipticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_elliptic_table_copy(s : MathspecialellipticTable) -> MathspecialellipticTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_table_fill(s : MathspecialellipticTable, v : Double) -> MathspecialellipticTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_table_min(s : MathspecialellipticTable) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_table_max(s : MathspecialellipticTable) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_table_to_string(s : MathspecialellipticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_graphn_make(size : Int) -> MathspecialellipticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_graphn_len(s : MathspecialellipticGraphN) -> Int { s.size }

pub fn math_special_elliptic_graphn_get(s : MathspecialellipticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_graphn_set(s : MathspecialellipticGraphN, i : Int, v : Double) -> MathspecialellipticGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_graphn_sum(s : MathspecialellipticGraphN) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_graphn_mean(s : MathspecialellipticGraphN) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_graphn_scale(s : MathspecialellipticGraphN, f : Double) -> MathspecialellipticGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_graphn_add(a : MathspecialellipticGraphN, b : MathspecialellipticGraphN) -> MathspecialellipticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_elliptic_graphn_copy(s : MathspecialellipticGraphN) -> MathspecialellipticGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_graphn_fill(s : MathspecialellipticGraphN, v : Double) -> MathspecialellipticGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_graphn_min(s : MathspecialellipticGraphN) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_graphn_max(s : MathspecialellipticGraphN) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_graphn_to_string(s : MathspecialellipticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_node_make(size : Int) -> MathspecialellipticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_node_len(s : MathspecialellipticNode) -> Int { s.size }

pub fn math_special_elliptic_node_get(s : MathspecialellipticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_node_set(s : MathspecialellipticNode, i : Int, v : Double) -> MathspecialellipticNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_node_sum(s : MathspecialellipticNode) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_node_mean(s : MathspecialellipticNode) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_node_scale(s : MathspecialellipticNode, f : Double) -> MathspecialellipticNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_node_add(a : MathspecialellipticNode, b : MathspecialellipticNode) -> MathspecialellipticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_elliptic_node_copy(s : MathspecialellipticNode) -> MathspecialellipticNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_node_fill(s : MathspecialellipticNode, v : Double) -> MathspecialellipticNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_node_min(s : MathspecialellipticNode) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_node_max(s : MathspecialellipticNode) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_node_to_string(s : MathspecialellipticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_edge_make(size : Int) -> MathspecialellipticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_edge_len(s : MathspecialellipticEdge) -> Int { s.size }

pub fn math_special_elliptic_edge_get(s : MathspecialellipticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_edge_set(s : MathspecialellipticEdge, i : Int, v : Double) -> MathspecialellipticEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_edge_sum(s : MathspecialellipticEdge) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_edge_mean(s : MathspecialellipticEdge) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_edge_scale(s : MathspecialellipticEdge, f : Double) -> MathspecialellipticEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_edge_add(a : MathspecialellipticEdge, b : MathspecialellipticEdge) -> MathspecialellipticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_elliptic_edge_copy(s : MathspecialellipticEdge) -> MathspecialellipticEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_edge_fill(s : MathspecialellipticEdge, v : Double) -> MathspecialellipticEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_edge_min(s : MathspecialellipticEdge) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_edge_max(s : MathspecialellipticEdge) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_edge_to_string(s : MathspecialellipticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_path_make(size : Int) -> MathspecialellipticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_path_len(s : MathspecialellipticPath) -> Int { s.size }

pub fn math_special_elliptic_path_get(s : MathspecialellipticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_path_set(s : MathspecialellipticPath, i : Int, v : Double) -> MathspecialellipticPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_path_sum(s : MathspecialellipticPath) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_path_mean(s : MathspecialellipticPath) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_path_scale(s : MathspecialellipticPath, f : Double) -> MathspecialellipticPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_path_add(a : MathspecialellipticPath, b : MathspecialellipticPath) -> MathspecialellipticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_elliptic_path_copy(s : MathspecialellipticPath) -> MathspecialellipticPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_path_fill(s : MathspecialellipticPath, v : Double) -> MathspecialellipticPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_path_min(s : MathspecialellipticPath) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_path_max(s : MathspecialellipticPath) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_path_to_string(s : MathspecialellipticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_cluster_make(size : Int) -> MathspecialellipticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_cluster_len(s : MathspecialellipticCluster) -> Int { s.size }

pub fn math_special_elliptic_cluster_get(s : MathspecialellipticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_cluster_set(s : MathspecialellipticCluster, i : Int, v : Double) -> MathspecialellipticCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_cluster_sum(s : MathspecialellipticCluster) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_cluster_mean(s : MathspecialellipticCluster) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_cluster_scale(s : MathspecialellipticCluster, f : Double) -> MathspecialellipticCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_cluster_add(a : MathspecialellipticCluster, b : MathspecialellipticCluster) -> MathspecialellipticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_elliptic_cluster_copy(s : MathspecialellipticCluster) -> MathspecialellipticCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_cluster_fill(s : MathspecialellipticCluster, v : Double) -> MathspecialellipticCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_cluster_min(s : MathspecialellipticCluster) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_cluster_max(s : MathspecialellipticCluster) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_cluster_to_string(s : MathspecialellipticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_model_make(size : Int) -> MathspecialellipticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_model_len(s : MathspecialellipticModel) -> Int { s.size }

pub fn math_special_elliptic_model_get(s : MathspecialellipticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_model_set(s : MathspecialellipticModel, i : Int, v : Double) -> MathspecialellipticModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_model_sum(s : MathspecialellipticModel) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_model_mean(s : MathspecialellipticModel) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_model_scale(s : MathspecialellipticModel, f : Double) -> MathspecialellipticModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_model_add(a : MathspecialellipticModel, b : MathspecialellipticModel) -> MathspecialellipticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_elliptic_model_copy(s : MathspecialellipticModel) -> MathspecialellipticModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_model_fill(s : MathspecialellipticModel, v : Double) -> MathspecialellipticModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_model_min(s : MathspecialellipticModel) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_model_max(s : MathspecialellipticModel) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_model_to_string(s : MathspecialellipticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_layer_make(size : Int) -> MathspecialellipticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_layer_len(s : MathspecialellipticLayer) -> Int { s.size }

pub fn math_special_elliptic_layer_get(s : MathspecialellipticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_layer_set(s : MathspecialellipticLayer, i : Int, v : Double) -> MathspecialellipticLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_layer_sum(s : MathspecialellipticLayer) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_layer_mean(s : MathspecialellipticLayer) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_layer_scale(s : MathspecialellipticLayer, f : Double) -> MathspecialellipticLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_layer_add(a : MathspecialellipticLayer, b : MathspecialellipticLayer) -> MathspecialellipticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_elliptic_layer_copy(s : MathspecialellipticLayer) -> MathspecialellipticLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_layer_fill(s : MathspecialellipticLayer, v : Double) -> MathspecialellipticLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_layer_min(s : MathspecialellipticLayer) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_layer_max(s : MathspecialellipticLayer) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_layer_to_string(s : MathspecialellipticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_buffer_make(size : Int) -> MathspecialellipticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_buffer_len(s : MathspecialellipticBuffer) -> Int { s.size }

pub fn math_special_elliptic_buffer_get(s : MathspecialellipticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_buffer_set(s : MathspecialellipticBuffer, i : Int, v : Double) -> MathspecialellipticBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_buffer_sum(s : MathspecialellipticBuffer) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_buffer_mean(s : MathspecialellipticBuffer) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_buffer_scale(s : MathspecialellipticBuffer, f : Double) -> MathspecialellipticBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_buffer_add(a : MathspecialellipticBuffer, b : MathspecialellipticBuffer) -> MathspecialellipticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_elliptic_buffer_copy(s : MathspecialellipticBuffer) -> MathspecialellipticBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_buffer_fill(s : MathspecialellipticBuffer, v : Double) -> MathspecialellipticBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_buffer_min(s : MathspecialellipticBuffer) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_buffer_max(s : MathspecialellipticBuffer) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_buffer_to_string(s : MathspecialellipticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_cursor_make(size : Int) -> MathspecialellipticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_cursor_len(s : MathspecialellipticCursor) -> Int { s.size }

pub fn math_special_elliptic_cursor_get(s : MathspecialellipticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_cursor_set(s : MathspecialellipticCursor, i : Int, v : Double) -> MathspecialellipticCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_cursor_sum(s : MathspecialellipticCursor) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_cursor_mean(s : MathspecialellipticCursor) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_cursor_scale(s : MathspecialellipticCursor, f : Double) -> MathspecialellipticCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_cursor_add(a : MathspecialellipticCursor, b : MathspecialellipticCursor) -> MathspecialellipticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_elliptic_cursor_copy(s : MathspecialellipticCursor) -> MathspecialellipticCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_cursor_fill(s : MathspecialellipticCursor, v : Double) -> MathspecialellipticCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_cursor_min(s : MathspecialellipticCursor) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_cursor_max(s : MathspecialellipticCursor) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_cursor_to_string(s : MathspecialellipticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_view_make(size : Int) -> MathspecialellipticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_view_len(s : MathspecialellipticView) -> Int { s.size }

pub fn math_special_elliptic_view_get(s : MathspecialellipticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_view_set(s : MathspecialellipticView, i : Int, v : Double) -> MathspecialellipticView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_view_sum(s : MathspecialellipticView) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_view_mean(s : MathspecialellipticView) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_view_scale(s : MathspecialellipticView, f : Double) -> MathspecialellipticView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_view_add(a : MathspecialellipticView, b : MathspecialellipticView) -> MathspecialellipticView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_elliptic_view_copy(s : MathspecialellipticView) -> MathspecialellipticView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_view_fill(s : MathspecialellipticView, v : Double) -> MathspecialellipticView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_view_min(s : MathspecialellipticView) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_view_max(s : MathspecialellipticView) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_view_to_string(s : MathspecialellipticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_range_make(size : Int) -> MathspecialellipticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_range_len(s : MathspecialellipticRange) -> Int { s.size }

pub fn math_special_elliptic_range_get(s : MathspecialellipticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_range_set(s : MathspecialellipticRange, i : Int, v : Double) -> MathspecialellipticRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_range_sum(s : MathspecialellipticRange) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_range_mean(s : MathspecialellipticRange) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_range_scale(s : MathspecialellipticRange, f : Double) -> MathspecialellipticRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_range_add(a : MathspecialellipticRange, b : MathspecialellipticRange) -> MathspecialellipticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_elliptic_range_copy(s : MathspecialellipticRange) -> MathspecialellipticRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_range_fill(s : MathspecialellipticRange, v : Double) -> MathspecialellipticRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_range_min(s : MathspecialellipticRange) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_range_max(s : MathspecialellipticRange) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_range_to_string(s : MathspecialellipticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MathspecialellipticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn math_special_elliptic_slice_make(size : Int) -> MathspecialellipticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn math_special_elliptic_slice_len(s : MathspecialellipticSlice) -> Int { s.size }

pub fn math_special_elliptic_slice_get(s : MathspecialellipticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn math_special_elliptic_slice_set(s : MathspecialellipticSlice, i : Int, v : Double) -> MathspecialellipticSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_slice_sum(s : MathspecialellipticSlice) -> Double { @_common.sum(s.data) }

pub fn math_special_elliptic_slice_mean(s : MathspecialellipticSlice) -> Double { @_common.mean(s.data) }

pub fn math_special_elliptic_slice_scale(s : MathspecialellipticSlice, f : Double) -> MathspecialellipticSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_slice_add(a : MathspecialellipticSlice, b : MathspecialellipticSlice) -> MathspecialellipticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn math_special_elliptic_slice_copy(s : MathspecialellipticSlice) -> MathspecialellipticSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_slice_fill(s : MathspecialellipticSlice, v : Double) -> MathspecialellipticSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn math_special_elliptic_slice_min(s : MathspecialellipticSlice) -> Double { @_common.min(s.data) }

pub fn math_special_elliptic_slice_max(s : MathspecialellipticSlice) -> Double { @_common.max(s.data) }

pub fn math_special_elliptic_slice_to_string(s : MathspecialellipticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

