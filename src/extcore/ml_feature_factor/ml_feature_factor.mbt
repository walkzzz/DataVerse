///===
/// extcore/ml_feature_factor

pub(all) struct MlfeaturefactorPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_factor_make_point(x : Double, y : Double) -> MlfeaturefactorPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_factor_make_point3(x : Double, y : Double, z : Double) -> MlfeaturefactorPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeaturefactorPoint::x(self : MlfeaturefactorPoint) -> Double { self.x }

pub fn MlfeaturefactorPoint::y(self : MlfeaturefactorPoint) -> Double { self.y }

pub fn MlfeaturefactorPoint::z(self : MlfeaturefactorPoint) -> Double { self.z }

pub fn MlfeaturefactorPoint::label(self : MlfeaturefactorPoint) -> Int { self.label }

pub fn MlfeaturefactorPoint::dist(self : MlfeaturefactorPoint, other : MlfeaturefactorPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeaturefactorPoint::add(self : MlfeaturefactorPoint, other : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeaturefactorPoint::sub(self : MlfeaturefactorPoint, other : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeaturefactorPoint::scale(self : MlfeaturefactorPoint, s : Double) -> MlfeaturefactorPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeaturefactorPoint::dot(self : MlfeaturefactorPoint, other : MlfeaturefactorPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeaturefactorPoint::cross(self : MlfeaturefactorPoint, other : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeaturefactorPoint::norm(self : MlfeaturefactorPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeaturefactorPoint::normalize(self : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturefactorPoint::negate(self : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeaturefactorPoint::mid(self : MlfeaturefactorPoint, other : MlfeaturefactorPoint) -> MlfeaturefactorPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeaturefactorPoint::lerp(self : MlfeaturefactorPoint, other : MlfeaturefactorPoint, t : Double) -> MlfeaturefactorPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeaturefactorPoint::to_string(self : MlfeaturefactorPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeaturefactorSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_factor_make_series(vals : Array[Double], name : String) -> MlfeaturefactorSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeaturefactorSeries::len(self : MlfeaturefactorSeries) -> Int { self.vals.length() }

pub fn MlfeaturefactorSeries::sum(self : MlfeaturefactorSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeaturefactorSeries::mean(self : MlfeaturefactorSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeaturefactorSeries::min(self : MlfeaturefactorSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeaturefactorSeries::max(self : MlfeaturefactorSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeaturefactorSeries::range(self : MlfeaturefactorSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeaturefactorSeries::variance(self : MlfeaturefactorSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeaturefactorSeries::std(self : MlfeaturefactorSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeaturefactorSeries::median(self : MlfeaturefactorSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeaturefactorSeries::scale(self : MlfeaturefactorSeries, f : Double) -> MlfeaturefactorSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeaturefactorSeries::add(self : MlfeaturefactorSeries, other : MlfeaturefactorSeries) -> MlfeaturefactorSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeaturefactorSeries::sub(self : MlfeaturefactorSeries, other : MlfeaturefactorSeries) -> MlfeaturefactorSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeaturefactorSeries::normalize(self : MlfeaturefactorSeries) -> MlfeaturefactorSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeaturefactorSeries::cumsum(self : MlfeaturefactorSeries) -> MlfeaturefactorSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeaturefactorSeries::to_string(self : MlfeaturefactorSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeaturefactorMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_factor_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeaturefactorMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_factor_matrix_identity(n : Int) -> MlfeaturefactorMatrix {
  let m = ml_feature_factor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeaturefactorMatrix::get(self : MlfeaturefactorMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeaturefactorMatrix::transpose(self : MlfeaturefactorMatrix) -> MlfeaturefactorMatrix {
  let result = ml_feature_factor_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeaturefactorMatrix::add(self : MlfeaturefactorMatrix, other : MlfeaturefactorMatrix) -> MlfeaturefactorMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_factor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeaturefactorMatrix::scale(self : MlfeaturefactorMatrix, s : Double) -> MlfeaturefactorMatrix {
  let result = ml_feature_factor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeaturefactorMatrix::multiply(self : MlfeaturefactorMatrix, other : MlfeaturefactorMatrix) -> MlfeaturefactorMatrix {
  if self.cols != other.rows { return ml_feature_factor_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_factor_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeaturefactorMatrix::trace(self : MlfeaturefactorMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeaturefactorMatrix::det(self : MlfeaturefactorMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeaturefactorMatrix::norm(self : MlfeaturefactorMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeaturefactorMatrix::to_string(self : MlfeaturefactorMatrix) -> String {
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

pub(all) struct MlfeaturefactorVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_factor_make_vector(comps : Array[Double]) -> MlfeaturefactorVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_factor_vector_zero(dim : Int) -> MlfeaturefactorVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeaturefactorVector::add(self : MlfeaturefactorVector, other : MlfeaturefactorVector) -> MlfeaturefactorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturefactorVector::sub(self : MlfeaturefactorVector, other : MlfeaturefactorVector) -> MlfeaturefactorVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeaturefactorVector::scale(self : MlfeaturefactorVector, s : Double) -> MlfeaturefactorVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeaturefactorVector::dot(self : MlfeaturefactorVector, other : MlfeaturefactorVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeaturefactorVector::norm(self : MlfeaturefactorVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeaturefactorVector::normalize(self : MlfeaturefactorVector) -> MlfeaturefactorVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeaturefactorVector::dist(self : MlfeaturefactorVector, other : MlfeaturefactorVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeaturefactorVector::to_string(self : MlfeaturefactorVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_factor_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_factor_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_factor_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_factor_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_factor_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_factor_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_factor_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_factor_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_factor_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_factor_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_factor_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_factor_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_factor_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_factor_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_factor_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_factor_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_factor_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_factor_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_factor_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_factor_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_factor_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_factor_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_factor_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_factor_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_factor_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_factor_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_factor_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_factor_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_factor_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeaturefactorFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_frame_make(size : Int) -> MlfeaturefactorFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_frame_len(s : MlfeaturefactorFrame) -> Int { s.size }

pub fn ml_feature_factor_frame_get(s : MlfeaturefactorFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_frame_set(s : MlfeaturefactorFrame, i : Int, v : Double) -> MlfeaturefactorFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_frame_sum(s : MlfeaturefactorFrame) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_frame_mean(s : MlfeaturefactorFrame) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_frame_scale(s : MlfeaturefactorFrame, f : Double) -> MlfeaturefactorFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_frame_add(a : MlfeaturefactorFrame, b : MlfeaturefactorFrame) -> MlfeaturefactorFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_factor_frame_copy(s : MlfeaturefactorFrame) -> MlfeaturefactorFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_frame_fill(s : MlfeaturefactorFrame, v : Double) -> MlfeaturefactorFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_frame_min(s : MlfeaturefactorFrame) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_frame_max(s : MlfeaturefactorFrame) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_frame_to_string(s : MlfeaturefactorFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_table_make(size : Int) -> MlfeaturefactorTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_table_len(s : MlfeaturefactorTable) -> Int { s.size }

pub fn ml_feature_factor_table_get(s : MlfeaturefactorTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_table_set(s : MlfeaturefactorTable, i : Int, v : Double) -> MlfeaturefactorTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_table_sum(s : MlfeaturefactorTable) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_table_mean(s : MlfeaturefactorTable) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_table_scale(s : MlfeaturefactorTable, f : Double) -> MlfeaturefactorTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_table_add(a : MlfeaturefactorTable, b : MlfeaturefactorTable) -> MlfeaturefactorTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_factor_table_copy(s : MlfeaturefactorTable) -> MlfeaturefactorTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_table_fill(s : MlfeaturefactorTable, v : Double) -> MlfeaturefactorTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_table_min(s : MlfeaturefactorTable) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_table_max(s : MlfeaturefactorTable) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_table_to_string(s : MlfeaturefactorTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_graphn_make(size : Int) -> MlfeaturefactorGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_graphn_len(s : MlfeaturefactorGraphN) -> Int { s.size }

pub fn ml_feature_factor_graphn_get(s : MlfeaturefactorGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_graphn_set(s : MlfeaturefactorGraphN, i : Int, v : Double) -> MlfeaturefactorGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_graphn_sum(s : MlfeaturefactorGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_graphn_mean(s : MlfeaturefactorGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_graphn_scale(s : MlfeaturefactorGraphN, f : Double) -> MlfeaturefactorGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_graphn_add(a : MlfeaturefactorGraphN, b : MlfeaturefactorGraphN) -> MlfeaturefactorGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_factor_graphn_copy(s : MlfeaturefactorGraphN) -> MlfeaturefactorGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_graphn_fill(s : MlfeaturefactorGraphN, v : Double) -> MlfeaturefactorGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_graphn_min(s : MlfeaturefactorGraphN) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_graphn_max(s : MlfeaturefactorGraphN) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_graphn_to_string(s : MlfeaturefactorGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_node_make(size : Int) -> MlfeaturefactorNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_node_len(s : MlfeaturefactorNode) -> Int { s.size }

pub fn ml_feature_factor_node_get(s : MlfeaturefactorNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_node_set(s : MlfeaturefactorNode, i : Int, v : Double) -> MlfeaturefactorNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_node_sum(s : MlfeaturefactorNode) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_node_mean(s : MlfeaturefactorNode) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_node_scale(s : MlfeaturefactorNode, f : Double) -> MlfeaturefactorNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_node_add(a : MlfeaturefactorNode, b : MlfeaturefactorNode) -> MlfeaturefactorNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_factor_node_copy(s : MlfeaturefactorNode) -> MlfeaturefactorNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_node_fill(s : MlfeaturefactorNode, v : Double) -> MlfeaturefactorNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_node_min(s : MlfeaturefactorNode) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_node_max(s : MlfeaturefactorNode) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_node_to_string(s : MlfeaturefactorNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_edge_make(size : Int) -> MlfeaturefactorEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_edge_len(s : MlfeaturefactorEdge) -> Int { s.size }

pub fn ml_feature_factor_edge_get(s : MlfeaturefactorEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_edge_set(s : MlfeaturefactorEdge, i : Int, v : Double) -> MlfeaturefactorEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_edge_sum(s : MlfeaturefactorEdge) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_edge_mean(s : MlfeaturefactorEdge) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_edge_scale(s : MlfeaturefactorEdge, f : Double) -> MlfeaturefactorEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_edge_add(a : MlfeaturefactorEdge, b : MlfeaturefactorEdge) -> MlfeaturefactorEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_factor_edge_copy(s : MlfeaturefactorEdge) -> MlfeaturefactorEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_edge_fill(s : MlfeaturefactorEdge, v : Double) -> MlfeaturefactorEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_edge_min(s : MlfeaturefactorEdge) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_edge_max(s : MlfeaturefactorEdge) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_edge_to_string(s : MlfeaturefactorEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_path_make(size : Int) -> MlfeaturefactorPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_path_len(s : MlfeaturefactorPath) -> Int { s.size }

pub fn ml_feature_factor_path_get(s : MlfeaturefactorPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_path_set(s : MlfeaturefactorPath, i : Int, v : Double) -> MlfeaturefactorPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_path_sum(s : MlfeaturefactorPath) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_path_mean(s : MlfeaturefactorPath) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_path_scale(s : MlfeaturefactorPath, f : Double) -> MlfeaturefactorPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_path_add(a : MlfeaturefactorPath, b : MlfeaturefactorPath) -> MlfeaturefactorPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_factor_path_copy(s : MlfeaturefactorPath) -> MlfeaturefactorPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_path_fill(s : MlfeaturefactorPath, v : Double) -> MlfeaturefactorPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_path_min(s : MlfeaturefactorPath) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_path_max(s : MlfeaturefactorPath) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_path_to_string(s : MlfeaturefactorPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_cluster_make(size : Int) -> MlfeaturefactorCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_cluster_len(s : MlfeaturefactorCluster) -> Int { s.size }

pub fn ml_feature_factor_cluster_get(s : MlfeaturefactorCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_cluster_set(s : MlfeaturefactorCluster, i : Int, v : Double) -> MlfeaturefactorCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_cluster_sum(s : MlfeaturefactorCluster) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_cluster_mean(s : MlfeaturefactorCluster) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_cluster_scale(s : MlfeaturefactorCluster, f : Double) -> MlfeaturefactorCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_cluster_add(a : MlfeaturefactorCluster, b : MlfeaturefactorCluster) -> MlfeaturefactorCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_factor_cluster_copy(s : MlfeaturefactorCluster) -> MlfeaturefactorCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_cluster_fill(s : MlfeaturefactorCluster, v : Double) -> MlfeaturefactorCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_cluster_min(s : MlfeaturefactorCluster) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_cluster_max(s : MlfeaturefactorCluster) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_cluster_to_string(s : MlfeaturefactorCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_model_make(size : Int) -> MlfeaturefactorModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_model_len(s : MlfeaturefactorModel) -> Int { s.size }

pub fn ml_feature_factor_model_get(s : MlfeaturefactorModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_model_set(s : MlfeaturefactorModel, i : Int, v : Double) -> MlfeaturefactorModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_model_sum(s : MlfeaturefactorModel) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_model_mean(s : MlfeaturefactorModel) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_model_scale(s : MlfeaturefactorModel, f : Double) -> MlfeaturefactorModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_model_add(a : MlfeaturefactorModel, b : MlfeaturefactorModel) -> MlfeaturefactorModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_factor_model_copy(s : MlfeaturefactorModel) -> MlfeaturefactorModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_model_fill(s : MlfeaturefactorModel, v : Double) -> MlfeaturefactorModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_model_min(s : MlfeaturefactorModel) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_model_max(s : MlfeaturefactorModel) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_model_to_string(s : MlfeaturefactorModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_layer_make(size : Int) -> MlfeaturefactorLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_layer_len(s : MlfeaturefactorLayer) -> Int { s.size }

pub fn ml_feature_factor_layer_get(s : MlfeaturefactorLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_layer_set(s : MlfeaturefactorLayer, i : Int, v : Double) -> MlfeaturefactorLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_layer_sum(s : MlfeaturefactorLayer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_layer_mean(s : MlfeaturefactorLayer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_layer_scale(s : MlfeaturefactorLayer, f : Double) -> MlfeaturefactorLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_layer_add(a : MlfeaturefactorLayer, b : MlfeaturefactorLayer) -> MlfeaturefactorLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_factor_layer_copy(s : MlfeaturefactorLayer) -> MlfeaturefactorLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_layer_fill(s : MlfeaturefactorLayer, v : Double) -> MlfeaturefactorLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_layer_min(s : MlfeaturefactorLayer) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_layer_max(s : MlfeaturefactorLayer) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_layer_to_string(s : MlfeaturefactorLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_buffer_make(size : Int) -> MlfeaturefactorBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_buffer_len(s : MlfeaturefactorBuffer) -> Int { s.size }

pub fn ml_feature_factor_buffer_get(s : MlfeaturefactorBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_buffer_set(s : MlfeaturefactorBuffer, i : Int, v : Double) -> MlfeaturefactorBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_buffer_sum(s : MlfeaturefactorBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_buffer_mean(s : MlfeaturefactorBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_buffer_scale(s : MlfeaturefactorBuffer, f : Double) -> MlfeaturefactorBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_buffer_add(a : MlfeaturefactorBuffer, b : MlfeaturefactorBuffer) -> MlfeaturefactorBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_factor_buffer_copy(s : MlfeaturefactorBuffer) -> MlfeaturefactorBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_buffer_fill(s : MlfeaturefactorBuffer, v : Double) -> MlfeaturefactorBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_buffer_min(s : MlfeaturefactorBuffer) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_buffer_max(s : MlfeaturefactorBuffer) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_buffer_to_string(s : MlfeaturefactorBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_cursor_make(size : Int) -> MlfeaturefactorCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_cursor_len(s : MlfeaturefactorCursor) -> Int { s.size }

pub fn ml_feature_factor_cursor_get(s : MlfeaturefactorCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_cursor_set(s : MlfeaturefactorCursor, i : Int, v : Double) -> MlfeaturefactorCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_cursor_sum(s : MlfeaturefactorCursor) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_cursor_mean(s : MlfeaturefactorCursor) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_cursor_scale(s : MlfeaturefactorCursor, f : Double) -> MlfeaturefactorCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_cursor_add(a : MlfeaturefactorCursor, b : MlfeaturefactorCursor) -> MlfeaturefactorCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_factor_cursor_copy(s : MlfeaturefactorCursor) -> MlfeaturefactorCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_cursor_fill(s : MlfeaturefactorCursor, v : Double) -> MlfeaturefactorCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_cursor_min(s : MlfeaturefactorCursor) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_cursor_max(s : MlfeaturefactorCursor) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_cursor_to_string(s : MlfeaturefactorCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_view_make(size : Int) -> MlfeaturefactorView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_view_len(s : MlfeaturefactorView) -> Int { s.size }

pub fn ml_feature_factor_view_get(s : MlfeaturefactorView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_view_set(s : MlfeaturefactorView, i : Int, v : Double) -> MlfeaturefactorView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_view_sum(s : MlfeaturefactorView) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_view_mean(s : MlfeaturefactorView) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_view_scale(s : MlfeaturefactorView, f : Double) -> MlfeaturefactorView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_view_add(a : MlfeaturefactorView, b : MlfeaturefactorView) -> MlfeaturefactorView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_factor_view_copy(s : MlfeaturefactorView) -> MlfeaturefactorView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_view_fill(s : MlfeaturefactorView, v : Double) -> MlfeaturefactorView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_view_min(s : MlfeaturefactorView) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_view_max(s : MlfeaturefactorView) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_view_to_string(s : MlfeaturefactorView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_range_make(size : Int) -> MlfeaturefactorRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_range_len(s : MlfeaturefactorRange) -> Int { s.size }

pub fn ml_feature_factor_range_get(s : MlfeaturefactorRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_range_set(s : MlfeaturefactorRange, i : Int, v : Double) -> MlfeaturefactorRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_range_sum(s : MlfeaturefactorRange) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_range_mean(s : MlfeaturefactorRange) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_range_scale(s : MlfeaturefactorRange, f : Double) -> MlfeaturefactorRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_range_add(a : MlfeaturefactorRange, b : MlfeaturefactorRange) -> MlfeaturefactorRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_factor_range_copy(s : MlfeaturefactorRange) -> MlfeaturefactorRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_range_fill(s : MlfeaturefactorRange, v : Double) -> MlfeaturefactorRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_range_min(s : MlfeaturefactorRange) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_range_max(s : MlfeaturefactorRange) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_range_to_string(s : MlfeaturefactorRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeaturefactorSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_factor_slice_make(size : Int) -> MlfeaturefactorSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_factor_slice_len(s : MlfeaturefactorSlice) -> Int { s.size }

pub fn ml_feature_factor_slice_get(s : MlfeaturefactorSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_factor_slice_set(s : MlfeaturefactorSlice, i : Int, v : Double) -> MlfeaturefactorSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_slice_sum(s : MlfeaturefactorSlice) -> Double { @_common.sum(s.data) }

pub fn ml_feature_factor_slice_mean(s : MlfeaturefactorSlice) -> Double { @_common.mean(s.data) }

pub fn ml_feature_factor_slice_scale(s : MlfeaturefactorSlice, f : Double) -> MlfeaturefactorSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_slice_add(a : MlfeaturefactorSlice, b : MlfeaturefactorSlice) -> MlfeaturefactorSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_factor_slice_copy(s : MlfeaturefactorSlice) -> MlfeaturefactorSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_slice_fill(s : MlfeaturefactorSlice, v : Double) -> MlfeaturefactorSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_factor_slice_min(s : MlfeaturefactorSlice) -> Double { @_common.min(s.data) }

pub fn ml_feature_factor_slice_max(s : MlfeaturefactorSlice) -> Double { @_common.max(s.data) }

pub fn ml_feature_factor_slice_to_string(s : MlfeaturefactorSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

