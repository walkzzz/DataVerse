///===
/// extcore/ml_regress_lasso

pub(all) struct MlregresslassoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_regress_lasso_make_point(x : Double, y : Double) -> MlregresslassoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_regress_lasso_make_point3(x : Double, y : Double, z : Double) -> MlregresslassoPoint {
  { x, y, z, label: 0 }
}

pub fn MlregresslassoPoint::x(self : MlregresslassoPoint) -> Double { self.x }

pub fn MlregresslassoPoint::y(self : MlregresslassoPoint) -> Double { self.y }

pub fn MlregresslassoPoint::z(self : MlregresslassoPoint) -> Double { self.z }

pub fn MlregresslassoPoint::label(self : MlregresslassoPoint) -> Int { self.label }

pub fn MlregresslassoPoint::dist(self : MlregresslassoPoint, other : MlregresslassoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlregresslassoPoint::add(self : MlregresslassoPoint, other : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlregresslassoPoint::sub(self : MlregresslassoPoint, other : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlregresslassoPoint::scale(self : MlregresslassoPoint, s : Double) -> MlregresslassoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlregresslassoPoint::dot(self : MlregresslassoPoint, other : MlregresslassoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlregresslassoPoint::cross(self : MlregresslassoPoint, other : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlregresslassoPoint::norm(self : MlregresslassoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlregresslassoPoint::normalize(self : MlregresslassoPoint) -> MlregresslassoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresslassoPoint::negate(self : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlregresslassoPoint::mid(self : MlregresslassoPoint, other : MlregresslassoPoint) -> MlregresslassoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlregresslassoPoint::lerp(self : MlregresslassoPoint, other : MlregresslassoPoint, t : Double) -> MlregresslassoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlregresslassoPoint::to_string(self : MlregresslassoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlregresslassoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_regress_lasso_make_series(vals : Array[Double], name : String) -> MlregresslassoSeries {
  { vals, name, meta: 0 }
}

pub fn MlregresslassoSeries::len(self : MlregresslassoSeries) -> Int { self.vals.length() }

pub fn MlregresslassoSeries::sum(self : MlregresslassoSeries) -> Double { @_common.sum(self.vals) }

pub fn MlregresslassoSeries::mean(self : MlregresslassoSeries) -> Double { @_common.mean(self.vals) }

pub fn MlregresslassoSeries::min(self : MlregresslassoSeries) -> Double { @_common.min(self.vals) }

pub fn MlregresslassoSeries::max(self : MlregresslassoSeries) -> Double { @_common.max(self.vals) }

pub fn MlregresslassoSeries::range(self : MlregresslassoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlregresslassoSeries::variance(self : MlregresslassoSeries) -> Double { @_common.variance(self.vals) }

pub fn MlregresslassoSeries::std(self : MlregresslassoSeries) -> Double { @_common.std(self.vals) }

pub fn MlregresslassoSeries::median(self : MlregresslassoSeries) -> Double { @_common.median(self.vals) }

pub fn MlregresslassoSeries::scale(self : MlregresslassoSeries, f : Double) -> MlregresslassoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlregresslassoSeries::add(self : MlregresslassoSeries, other : MlregresslassoSeries) -> MlregresslassoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlregresslassoSeries::sub(self : MlregresslassoSeries, other : MlregresslassoSeries) -> MlregresslassoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlregresslassoSeries::normalize(self : MlregresslassoSeries) -> MlregresslassoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlregresslassoSeries::cumsum(self : MlregresslassoSeries) -> MlregresslassoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlregresslassoSeries::to_string(self : MlregresslassoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlregresslassoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_regress_lasso_make_matrix(rows : Int, cols : Int, val : Double) -> MlregresslassoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_regress_lasso_matrix_identity(n : Int) -> MlregresslassoMatrix {
  let m = ml_regress_lasso_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlregresslassoMatrix::get(self : MlregresslassoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlregresslassoMatrix::transpose(self : MlregresslassoMatrix) -> MlregresslassoMatrix {
  let result = ml_regress_lasso_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlregresslassoMatrix::add(self : MlregresslassoMatrix, other : MlregresslassoMatrix) -> MlregresslassoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_regress_lasso_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlregresslassoMatrix::scale(self : MlregresslassoMatrix, s : Double) -> MlregresslassoMatrix {
  let result = ml_regress_lasso_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlregresslassoMatrix::multiply(self : MlregresslassoMatrix, other : MlregresslassoMatrix) -> MlregresslassoMatrix {
  if self.cols != other.rows { return ml_regress_lasso_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_regress_lasso_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlregresslassoMatrix::trace(self : MlregresslassoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlregresslassoMatrix::det(self : MlregresslassoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlregresslassoMatrix::norm(self : MlregresslassoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlregresslassoMatrix::to_string(self : MlregresslassoMatrix) -> String {
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

pub(all) struct MlregresslassoVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_regress_lasso_make_vector(comps : Array[Double]) -> MlregresslassoVector {
  { comps, dim: comps.length() }
}

pub fn ml_regress_lasso_vector_zero(dim : Int) -> MlregresslassoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlregresslassoVector::add(self : MlregresslassoVector, other : MlregresslassoVector) -> MlregresslassoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresslassoVector::sub(self : MlregresslassoVector, other : MlregresslassoVector) -> MlregresslassoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlregresslassoVector::scale(self : MlregresslassoVector, s : Double) -> MlregresslassoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlregresslassoVector::dot(self : MlregresslassoVector, other : MlregresslassoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlregresslassoVector::norm(self : MlregresslassoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlregresslassoVector::normalize(self : MlregresslassoVector) -> MlregresslassoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlregresslassoVector::dist(self : MlregresslassoVector, other : MlregresslassoVector) -> Double {
  self.sub(other).norm()
}

pub fn MlregresslassoVector::to_string(self : MlregresslassoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_regress_lasso_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_regress_lasso_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_regress_lasso_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_regress_lasso_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_regress_lasso_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_regress_lasso_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_regress_lasso_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_regress_lasso_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_regress_lasso_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_regress_lasso_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_regress_lasso_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_regress_lasso_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_regress_lasso_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_regress_lasso_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_regress_lasso_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_regress_lasso_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_regress_lasso_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_regress_lasso_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_regress_lasso_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_regress_lasso_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_regress_lasso_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_regress_lasso_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_regress_lasso_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_regress_lasso_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_regress_lasso_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_regress_lasso_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_regress_lasso_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_regress_lasso_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_regress_lasso_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlregresslassoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_frame_make(size : Int) -> MlregresslassoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_frame_len(s : MlregresslassoFrame) -> Int { s.size }

pub fn ml_regress_lasso_frame_get(s : MlregresslassoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_frame_set(s : MlregresslassoFrame, i : Int, v : Double) -> MlregresslassoFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_frame_sum(s : MlregresslassoFrame) -> Double { @_common.sum(s.data) }

pub fn ml_regress_lasso_frame_mean(s : MlregresslassoFrame) -> Double { @_common.mean(s.data) }

pub fn ml_regress_lasso_frame_scale(s : MlregresslassoFrame, f : Double) -> MlregresslassoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_frame_add(a : MlregresslassoFrame, b : MlregresslassoFrame) -> MlregresslassoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_lasso_frame_copy(s : MlregresslassoFrame) -> MlregresslassoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_frame_fill(s : MlregresslassoFrame, v : Double) -> MlregresslassoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_frame_min(s : MlregresslassoFrame) -> Double { @_common.min(s.data) }

pub fn ml_regress_lasso_frame_max(s : MlregresslassoFrame) -> Double { @_common.max(s.data) }

pub fn ml_regress_lasso_frame_to_string(s : MlregresslassoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_table_make(size : Int) -> MlregresslassoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_table_len(s : MlregresslassoTable) -> Int { s.size }

pub fn ml_regress_lasso_table_get(s : MlregresslassoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_table_set(s : MlregresslassoTable, i : Int, v : Double) -> MlregresslassoTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_table_sum(s : MlregresslassoTable) -> Double { @_common.sum(s.data) }

pub fn ml_regress_lasso_table_mean(s : MlregresslassoTable) -> Double { @_common.mean(s.data) }

pub fn ml_regress_lasso_table_scale(s : MlregresslassoTable, f : Double) -> MlregresslassoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_table_add(a : MlregresslassoTable, b : MlregresslassoTable) -> MlregresslassoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_lasso_table_copy(s : MlregresslassoTable) -> MlregresslassoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_table_fill(s : MlregresslassoTable, v : Double) -> MlregresslassoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_table_min(s : MlregresslassoTable) -> Double { @_common.min(s.data) }

pub fn ml_regress_lasso_table_max(s : MlregresslassoTable) -> Double { @_common.max(s.data) }

pub fn ml_regress_lasso_table_to_string(s : MlregresslassoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_graphn_make(size : Int) -> MlregresslassoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_graphn_len(s : MlregresslassoGraphN) -> Int { s.size }

pub fn ml_regress_lasso_graphn_get(s : MlregresslassoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_graphn_set(s : MlregresslassoGraphN, i : Int, v : Double) -> MlregresslassoGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_graphn_sum(s : MlregresslassoGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_regress_lasso_graphn_mean(s : MlregresslassoGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_regress_lasso_graphn_scale(s : MlregresslassoGraphN, f : Double) -> MlregresslassoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_graphn_add(a : MlregresslassoGraphN, b : MlregresslassoGraphN) -> MlregresslassoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_lasso_graphn_copy(s : MlregresslassoGraphN) -> MlregresslassoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_graphn_fill(s : MlregresslassoGraphN, v : Double) -> MlregresslassoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_graphn_min(s : MlregresslassoGraphN) -> Double { @_common.min(s.data) }

pub fn ml_regress_lasso_graphn_max(s : MlregresslassoGraphN) -> Double { @_common.max(s.data) }

pub fn ml_regress_lasso_graphn_to_string(s : MlregresslassoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_node_make(size : Int) -> MlregresslassoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_node_len(s : MlregresslassoNode) -> Int { s.size }

pub fn ml_regress_lasso_node_get(s : MlregresslassoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_node_set(s : MlregresslassoNode, i : Int, v : Double) -> MlregresslassoNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_node_sum(s : MlregresslassoNode) -> Double { @_common.sum(s.data) }

pub fn ml_regress_lasso_node_mean(s : MlregresslassoNode) -> Double { @_common.mean(s.data) }

pub fn ml_regress_lasso_node_scale(s : MlregresslassoNode, f : Double) -> MlregresslassoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_node_add(a : MlregresslassoNode, b : MlregresslassoNode) -> MlregresslassoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_lasso_node_copy(s : MlregresslassoNode) -> MlregresslassoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_node_fill(s : MlregresslassoNode, v : Double) -> MlregresslassoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_node_min(s : MlregresslassoNode) -> Double { @_common.min(s.data) }

pub fn ml_regress_lasso_node_max(s : MlregresslassoNode) -> Double { @_common.max(s.data) }

pub fn ml_regress_lasso_node_to_string(s : MlregresslassoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_edge_make(size : Int) -> MlregresslassoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_edge_len(s : MlregresslassoEdge) -> Int { s.size }

pub fn ml_regress_lasso_edge_get(s : MlregresslassoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_edge_set(s : MlregresslassoEdge, i : Int, v : Double) -> MlregresslassoEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_edge_sum(s : MlregresslassoEdge) -> Double { @_common.sum(s.data) }

pub fn ml_regress_lasso_edge_mean(s : MlregresslassoEdge) -> Double { @_common.mean(s.data) }

pub fn ml_regress_lasso_edge_scale(s : MlregresslassoEdge, f : Double) -> MlregresslassoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_edge_add(a : MlregresslassoEdge, b : MlregresslassoEdge) -> MlregresslassoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_lasso_edge_copy(s : MlregresslassoEdge) -> MlregresslassoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_edge_fill(s : MlregresslassoEdge, v : Double) -> MlregresslassoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_edge_min(s : MlregresslassoEdge) -> Double { @_common.min(s.data) }

pub fn ml_regress_lasso_edge_max(s : MlregresslassoEdge) -> Double { @_common.max(s.data) }

pub fn ml_regress_lasso_edge_to_string(s : MlregresslassoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_path_make(size : Int) -> MlregresslassoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_path_len(s : MlregresslassoPath) -> Int { s.size }

pub fn ml_regress_lasso_path_get(s : MlregresslassoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_path_set(s : MlregresslassoPath, i : Int, v : Double) -> MlregresslassoPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_path_sum(s : MlregresslassoPath) -> Double { @_common.sum(s.data) }

pub fn ml_regress_lasso_path_mean(s : MlregresslassoPath) -> Double { @_common.mean(s.data) }

pub fn ml_regress_lasso_path_scale(s : MlregresslassoPath, f : Double) -> MlregresslassoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_path_add(a : MlregresslassoPath, b : MlregresslassoPath) -> MlregresslassoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_lasso_path_copy(s : MlregresslassoPath) -> MlregresslassoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_path_fill(s : MlregresslassoPath, v : Double) -> MlregresslassoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_path_min(s : MlregresslassoPath) -> Double { @_common.min(s.data) }

pub fn ml_regress_lasso_path_max(s : MlregresslassoPath) -> Double { @_common.max(s.data) }

pub fn ml_regress_lasso_path_to_string(s : MlregresslassoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_cluster_make(size : Int) -> MlregresslassoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_cluster_len(s : MlregresslassoCluster) -> Int { s.size }

pub fn ml_regress_lasso_cluster_get(s : MlregresslassoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_cluster_set(s : MlregresslassoCluster, i : Int, v : Double) -> MlregresslassoCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_cluster_sum(s : MlregresslassoCluster) -> Double { @_common.sum(s.data) }

pub fn ml_regress_lasso_cluster_mean(s : MlregresslassoCluster) -> Double { @_common.mean(s.data) }

pub fn ml_regress_lasso_cluster_scale(s : MlregresslassoCluster, f : Double) -> MlregresslassoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_cluster_add(a : MlregresslassoCluster, b : MlregresslassoCluster) -> MlregresslassoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_lasso_cluster_copy(s : MlregresslassoCluster) -> MlregresslassoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_cluster_fill(s : MlregresslassoCluster, v : Double) -> MlregresslassoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_cluster_min(s : MlregresslassoCluster) -> Double { @_common.min(s.data) }

pub fn ml_regress_lasso_cluster_max(s : MlregresslassoCluster) -> Double { @_common.max(s.data) }

pub fn ml_regress_lasso_cluster_to_string(s : MlregresslassoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_model_make(size : Int) -> MlregresslassoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_model_len(s : MlregresslassoModel) -> Int { s.size }

pub fn ml_regress_lasso_model_get(s : MlregresslassoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_model_set(s : MlregresslassoModel, i : Int, v : Double) -> MlregresslassoModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_model_sum(s : MlregresslassoModel) -> Double { @_common.sum(s.data) }

pub fn ml_regress_lasso_model_mean(s : MlregresslassoModel) -> Double { @_common.mean(s.data) }

pub fn ml_regress_lasso_model_scale(s : MlregresslassoModel, f : Double) -> MlregresslassoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_model_add(a : MlregresslassoModel, b : MlregresslassoModel) -> MlregresslassoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_lasso_model_copy(s : MlregresslassoModel) -> MlregresslassoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_model_fill(s : MlregresslassoModel, v : Double) -> MlregresslassoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_model_min(s : MlregresslassoModel) -> Double { @_common.min(s.data) }

pub fn ml_regress_lasso_model_max(s : MlregresslassoModel) -> Double { @_common.max(s.data) }

pub fn ml_regress_lasso_model_to_string(s : MlregresslassoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_layer_make(size : Int) -> MlregresslassoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_layer_len(s : MlregresslassoLayer) -> Int { s.size }

pub fn ml_regress_lasso_layer_get(s : MlregresslassoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_layer_set(s : MlregresslassoLayer, i : Int, v : Double) -> MlregresslassoLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_layer_sum(s : MlregresslassoLayer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_lasso_layer_mean(s : MlregresslassoLayer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_lasso_layer_scale(s : MlregresslassoLayer, f : Double) -> MlregresslassoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_layer_add(a : MlregresslassoLayer, b : MlregresslassoLayer) -> MlregresslassoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_lasso_layer_copy(s : MlregresslassoLayer) -> MlregresslassoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_layer_fill(s : MlregresslassoLayer, v : Double) -> MlregresslassoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_layer_min(s : MlregresslassoLayer) -> Double { @_common.min(s.data) }

pub fn ml_regress_lasso_layer_max(s : MlregresslassoLayer) -> Double { @_common.max(s.data) }

pub fn ml_regress_lasso_layer_to_string(s : MlregresslassoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_buffer_make(size : Int) -> MlregresslassoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_buffer_len(s : MlregresslassoBuffer) -> Int { s.size }

pub fn ml_regress_lasso_buffer_get(s : MlregresslassoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_buffer_set(s : MlregresslassoBuffer, i : Int, v : Double) -> MlregresslassoBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_buffer_sum(s : MlregresslassoBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_regress_lasso_buffer_mean(s : MlregresslassoBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_regress_lasso_buffer_scale(s : MlregresslassoBuffer, f : Double) -> MlregresslassoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_buffer_add(a : MlregresslassoBuffer, b : MlregresslassoBuffer) -> MlregresslassoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_lasso_buffer_copy(s : MlregresslassoBuffer) -> MlregresslassoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_buffer_fill(s : MlregresslassoBuffer, v : Double) -> MlregresslassoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_buffer_min(s : MlregresslassoBuffer) -> Double { @_common.min(s.data) }

pub fn ml_regress_lasso_buffer_max(s : MlregresslassoBuffer) -> Double { @_common.max(s.data) }

pub fn ml_regress_lasso_buffer_to_string(s : MlregresslassoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_cursor_make(size : Int) -> MlregresslassoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_cursor_len(s : MlregresslassoCursor) -> Int { s.size }

pub fn ml_regress_lasso_cursor_get(s : MlregresslassoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_cursor_set(s : MlregresslassoCursor, i : Int, v : Double) -> MlregresslassoCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_cursor_sum(s : MlregresslassoCursor) -> Double { @_common.sum(s.data) }

pub fn ml_regress_lasso_cursor_mean(s : MlregresslassoCursor) -> Double { @_common.mean(s.data) }

pub fn ml_regress_lasso_cursor_scale(s : MlregresslassoCursor, f : Double) -> MlregresslassoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_cursor_add(a : MlregresslassoCursor, b : MlregresslassoCursor) -> MlregresslassoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_lasso_cursor_copy(s : MlregresslassoCursor) -> MlregresslassoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_cursor_fill(s : MlregresslassoCursor, v : Double) -> MlregresslassoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_cursor_min(s : MlregresslassoCursor) -> Double { @_common.min(s.data) }

pub fn ml_regress_lasso_cursor_max(s : MlregresslassoCursor) -> Double { @_common.max(s.data) }

pub fn ml_regress_lasso_cursor_to_string(s : MlregresslassoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_view_make(size : Int) -> MlregresslassoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_view_len(s : MlregresslassoView) -> Int { s.size }

pub fn ml_regress_lasso_view_get(s : MlregresslassoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_view_set(s : MlregresslassoView, i : Int, v : Double) -> MlregresslassoView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_view_sum(s : MlregresslassoView) -> Double { @_common.sum(s.data) }

pub fn ml_regress_lasso_view_mean(s : MlregresslassoView) -> Double { @_common.mean(s.data) }

pub fn ml_regress_lasso_view_scale(s : MlregresslassoView, f : Double) -> MlregresslassoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_view_add(a : MlregresslassoView, b : MlregresslassoView) -> MlregresslassoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_lasso_view_copy(s : MlregresslassoView) -> MlregresslassoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_view_fill(s : MlregresslassoView, v : Double) -> MlregresslassoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_view_min(s : MlregresslassoView) -> Double { @_common.min(s.data) }

pub fn ml_regress_lasso_view_max(s : MlregresslassoView) -> Double { @_common.max(s.data) }

pub fn ml_regress_lasso_view_to_string(s : MlregresslassoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_range_make(size : Int) -> MlregresslassoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_range_len(s : MlregresslassoRange) -> Int { s.size }

pub fn ml_regress_lasso_range_get(s : MlregresslassoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_range_set(s : MlregresslassoRange, i : Int, v : Double) -> MlregresslassoRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_range_sum(s : MlregresslassoRange) -> Double { @_common.sum(s.data) }

pub fn ml_regress_lasso_range_mean(s : MlregresslassoRange) -> Double { @_common.mean(s.data) }

pub fn ml_regress_lasso_range_scale(s : MlregresslassoRange, f : Double) -> MlregresslassoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_range_add(a : MlregresslassoRange, b : MlregresslassoRange) -> MlregresslassoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_lasso_range_copy(s : MlregresslassoRange) -> MlregresslassoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_range_fill(s : MlregresslassoRange, v : Double) -> MlregresslassoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_range_min(s : MlregresslassoRange) -> Double { @_common.min(s.data) }

pub fn ml_regress_lasso_range_max(s : MlregresslassoRange) -> Double { @_common.max(s.data) }

pub fn ml_regress_lasso_range_to_string(s : MlregresslassoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlregresslassoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_regress_lasso_slice_make(size : Int) -> MlregresslassoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_regress_lasso_slice_len(s : MlregresslassoSlice) -> Int { s.size }

pub fn ml_regress_lasso_slice_get(s : MlregresslassoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_regress_lasso_slice_set(s : MlregresslassoSlice, i : Int, v : Double) -> MlregresslassoSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_slice_sum(s : MlregresslassoSlice) -> Double { @_common.sum(s.data) }

pub fn ml_regress_lasso_slice_mean(s : MlregresslassoSlice) -> Double { @_common.mean(s.data) }

pub fn ml_regress_lasso_slice_scale(s : MlregresslassoSlice, f : Double) -> MlregresslassoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_slice_add(a : MlregresslassoSlice, b : MlregresslassoSlice) -> MlregresslassoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_regress_lasso_slice_copy(s : MlregresslassoSlice) -> MlregresslassoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_slice_fill(s : MlregresslassoSlice, v : Double) -> MlregresslassoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_regress_lasso_slice_min(s : MlregresslassoSlice) -> Double { @_common.min(s.data) }

pub fn ml_regress_lasso_slice_max(s : MlregresslassoSlice) -> Double { @_common.max(s.data) }

pub fn ml_regress_lasso_slice_to_string(s : MlregresslassoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

