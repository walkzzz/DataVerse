///===
/// extcore/ml_feature_lda

pub(all) struct MlfeatureldaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_feature_lda_make_point(x : Double, y : Double) -> MlfeatureldaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_feature_lda_make_point3(x : Double, y : Double, z : Double) -> MlfeatureldaPoint {
  { x, y, z, label: 0 }
}

pub fn MlfeatureldaPoint::x(self : MlfeatureldaPoint) -> Double { self.x }

pub fn MlfeatureldaPoint::y(self : MlfeatureldaPoint) -> Double { self.y }

pub fn MlfeatureldaPoint::z(self : MlfeatureldaPoint) -> Double { self.z }

pub fn MlfeatureldaPoint::label(self : MlfeatureldaPoint) -> Int { self.label }

pub fn MlfeatureldaPoint::dist(self : MlfeatureldaPoint, other : MlfeatureldaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlfeatureldaPoint::add(self : MlfeatureldaPoint, other : MlfeatureldaPoint) -> MlfeatureldaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlfeatureldaPoint::sub(self : MlfeatureldaPoint, other : MlfeatureldaPoint) -> MlfeatureldaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlfeatureldaPoint::scale(self : MlfeatureldaPoint, s : Double) -> MlfeatureldaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlfeatureldaPoint::dot(self : MlfeatureldaPoint, other : MlfeatureldaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlfeatureldaPoint::cross(self : MlfeatureldaPoint, other : MlfeatureldaPoint) -> MlfeatureldaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlfeatureldaPoint::norm(self : MlfeatureldaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlfeatureldaPoint::normalize(self : MlfeatureldaPoint) -> MlfeatureldaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureldaPoint::negate(self : MlfeatureldaPoint) -> MlfeatureldaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlfeatureldaPoint::mid(self : MlfeatureldaPoint, other : MlfeatureldaPoint) -> MlfeatureldaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlfeatureldaPoint::lerp(self : MlfeatureldaPoint, other : MlfeatureldaPoint, t : Double) -> MlfeatureldaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlfeatureldaPoint::to_string(self : MlfeatureldaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlfeatureldaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_feature_lda_make_series(vals : Array[Double], name : String) -> MlfeatureldaSeries {
  { vals, name, meta: 0 }
}

pub fn MlfeatureldaSeries::len(self : MlfeatureldaSeries) -> Int { self.vals.length() }

pub fn MlfeatureldaSeries::sum(self : MlfeatureldaSeries) -> Double { @_common.sum(self.vals) }

pub fn MlfeatureldaSeries::mean(self : MlfeatureldaSeries) -> Double { @_common.mean(self.vals) }

pub fn MlfeatureldaSeries::min(self : MlfeatureldaSeries) -> Double { @_common.min(self.vals) }

pub fn MlfeatureldaSeries::max(self : MlfeatureldaSeries) -> Double { @_common.max(self.vals) }

pub fn MlfeatureldaSeries::range(self : MlfeatureldaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlfeatureldaSeries::variance(self : MlfeatureldaSeries) -> Double { @_common.variance(self.vals) }

pub fn MlfeatureldaSeries::std(self : MlfeatureldaSeries) -> Double { @_common.std(self.vals) }

pub fn MlfeatureldaSeries::median(self : MlfeatureldaSeries) -> Double { @_common.median(self.vals) }

pub fn MlfeatureldaSeries::scale(self : MlfeatureldaSeries, f : Double) -> MlfeatureldaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlfeatureldaSeries::add(self : MlfeatureldaSeries, other : MlfeatureldaSeries) -> MlfeatureldaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlfeatureldaSeries::sub(self : MlfeatureldaSeries, other : MlfeatureldaSeries) -> MlfeatureldaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlfeatureldaSeries::normalize(self : MlfeatureldaSeries) -> MlfeatureldaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlfeatureldaSeries::cumsum(self : MlfeatureldaSeries) -> MlfeatureldaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlfeatureldaSeries::to_string(self : MlfeatureldaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlfeatureldaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_feature_lda_make_matrix(rows : Int, cols : Int, val : Double) -> MlfeatureldaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_feature_lda_matrix_identity(n : Int) -> MlfeatureldaMatrix {
  let m = ml_feature_lda_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlfeatureldaMatrix::get(self : MlfeatureldaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlfeatureldaMatrix::transpose(self : MlfeatureldaMatrix) -> MlfeatureldaMatrix {
  let result = ml_feature_lda_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlfeatureldaMatrix::add(self : MlfeatureldaMatrix, other : MlfeatureldaMatrix) -> MlfeatureldaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_feature_lda_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlfeatureldaMatrix::scale(self : MlfeatureldaMatrix, s : Double) -> MlfeatureldaMatrix {
  let result = ml_feature_lda_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlfeatureldaMatrix::multiply(self : MlfeatureldaMatrix, other : MlfeatureldaMatrix) -> MlfeatureldaMatrix {
  if self.cols != other.rows { return ml_feature_lda_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_feature_lda_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlfeatureldaMatrix::trace(self : MlfeatureldaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlfeatureldaMatrix::det(self : MlfeatureldaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlfeatureldaMatrix::norm(self : MlfeatureldaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlfeatureldaMatrix::to_string(self : MlfeatureldaMatrix) -> String {
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

pub(all) struct MlfeatureldaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_feature_lda_make_vector(comps : Array[Double]) -> MlfeatureldaVector {
  { comps, dim: comps.length() }
}

pub fn ml_feature_lda_vector_zero(dim : Int) -> MlfeatureldaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlfeatureldaVector::add(self : MlfeatureldaVector, other : MlfeatureldaVector) -> MlfeatureldaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureldaVector::sub(self : MlfeatureldaVector, other : MlfeatureldaVector) -> MlfeatureldaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlfeatureldaVector::scale(self : MlfeatureldaVector, s : Double) -> MlfeatureldaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlfeatureldaVector::dot(self : MlfeatureldaVector, other : MlfeatureldaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlfeatureldaVector::norm(self : MlfeatureldaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlfeatureldaVector::normalize(self : MlfeatureldaVector) -> MlfeatureldaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlfeatureldaVector::dist(self : MlfeatureldaVector, other : MlfeatureldaVector) -> Double {
  self.sub(other).norm()
}

pub fn MlfeatureldaVector::to_string(self : MlfeatureldaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_feature_lda_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_feature_lda_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_feature_lda_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_feature_lda_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_feature_lda_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_feature_lda_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_feature_lda_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_feature_lda_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_feature_lda_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_feature_lda_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_feature_lda_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_feature_lda_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_feature_lda_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_feature_lda_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_feature_lda_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_feature_lda_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_feature_lda_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_feature_lda_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_feature_lda_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_feature_lda_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_feature_lda_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_feature_lda_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_feature_lda_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_feature_lda_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_feature_lda_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_feature_lda_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_feature_lda_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_feature_lda_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_feature_lda_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlfeatureldaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_frame_make(size : Int) -> MlfeatureldaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_frame_len(s : MlfeatureldaFrame) -> Int { s.size }

pub fn ml_feature_lda_frame_get(s : MlfeatureldaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_frame_set(s : MlfeatureldaFrame, i : Int, v : Double) -> MlfeatureldaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_frame_sum(s : MlfeatureldaFrame) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_frame_mean(s : MlfeatureldaFrame) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_frame_scale(s : MlfeatureldaFrame, f : Double) -> MlfeatureldaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_frame_add(a : MlfeatureldaFrame, b : MlfeatureldaFrame) -> MlfeatureldaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_lda_frame_copy(s : MlfeatureldaFrame) -> MlfeatureldaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_frame_fill(s : MlfeatureldaFrame, v : Double) -> MlfeatureldaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_frame_min(s : MlfeatureldaFrame) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_frame_max(s : MlfeatureldaFrame) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_frame_to_string(s : MlfeatureldaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_table_make(size : Int) -> MlfeatureldaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_table_len(s : MlfeatureldaTable) -> Int { s.size }

pub fn ml_feature_lda_table_get(s : MlfeatureldaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_table_set(s : MlfeatureldaTable, i : Int, v : Double) -> MlfeatureldaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_table_sum(s : MlfeatureldaTable) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_table_mean(s : MlfeatureldaTable) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_table_scale(s : MlfeatureldaTable, f : Double) -> MlfeatureldaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_table_add(a : MlfeatureldaTable, b : MlfeatureldaTable) -> MlfeatureldaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_lda_table_copy(s : MlfeatureldaTable) -> MlfeatureldaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_table_fill(s : MlfeatureldaTable, v : Double) -> MlfeatureldaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_table_min(s : MlfeatureldaTable) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_table_max(s : MlfeatureldaTable) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_table_to_string(s : MlfeatureldaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_graphn_make(size : Int) -> MlfeatureldaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_graphn_len(s : MlfeatureldaGraphN) -> Int { s.size }

pub fn ml_feature_lda_graphn_get(s : MlfeatureldaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_graphn_set(s : MlfeatureldaGraphN, i : Int, v : Double) -> MlfeatureldaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_graphn_sum(s : MlfeatureldaGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_graphn_mean(s : MlfeatureldaGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_graphn_scale(s : MlfeatureldaGraphN, f : Double) -> MlfeatureldaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_graphn_add(a : MlfeatureldaGraphN, b : MlfeatureldaGraphN) -> MlfeatureldaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_lda_graphn_copy(s : MlfeatureldaGraphN) -> MlfeatureldaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_graphn_fill(s : MlfeatureldaGraphN, v : Double) -> MlfeatureldaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_graphn_min(s : MlfeatureldaGraphN) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_graphn_max(s : MlfeatureldaGraphN) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_graphn_to_string(s : MlfeatureldaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_node_make(size : Int) -> MlfeatureldaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_node_len(s : MlfeatureldaNode) -> Int { s.size }

pub fn ml_feature_lda_node_get(s : MlfeatureldaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_node_set(s : MlfeatureldaNode, i : Int, v : Double) -> MlfeatureldaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_node_sum(s : MlfeatureldaNode) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_node_mean(s : MlfeatureldaNode) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_node_scale(s : MlfeatureldaNode, f : Double) -> MlfeatureldaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_node_add(a : MlfeatureldaNode, b : MlfeatureldaNode) -> MlfeatureldaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_lda_node_copy(s : MlfeatureldaNode) -> MlfeatureldaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_node_fill(s : MlfeatureldaNode, v : Double) -> MlfeatureldaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_node_min(s : MlfeatureldaNode) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_node_max(s : MlfeatureldaNode) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_node_to_string(s : MlfeatureldaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_edge_make(size : Int) -> MlfeatureldaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_edge_len(s : MlfeatureldaEdge) -> Int { s.size }

pub fn ml_feature_lda_edge_get(s : MlfeatureldaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_edge_set(s : MlfeatureldaEdge, i : Int, v : Double) -> MlfeatureldaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_edge_sum(s : MlfeatureldaEdge) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_edge_mean(s : MlfeatureldaEdge) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_edge_scale(s : MlfeatureldaEdge, f : Double) -> MlfeatureldaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_edge_add(a : MlfeatureldaEdge, b : MlfeatureldaEdge) -> MlfeatureldaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_lda_edge_copy(s : MlfeatureldaEdge) -> MlfeatureldaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_edge_fill(s : MlfeatureldaEdge, v : Double) -> MlfeatureldaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_edge_min(s : MlfeatureldaEdge) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_edge_max(s : MlfeatureldaEdge) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_edge_to_string(s : MlfeatureldaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_path_make(size : Int) -> MlfeatureldaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_path_len(s : MlfeatureldaPath) -> Int { s.size }

pub fn ml_feature_lda_path_get(s : MlfeatureldaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_path_set(s : MlfeatureldaPath, i : Int, v : Double) -> MlfeatureldaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_path_sum(s : MlfeatureldaPath) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_path_mean(s : MlfeatureldaPath) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_path_scale(s : MlfeatureldaPath, f : Double) -> MlfeatureldaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_path_add(a : MlfeatureldaPath, b : MlfeatureldaPath) -> MlfeatureldaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_lda_path_copy(s : MlfeatureldaPath) -> MlfeatureldaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_path_fill(s : MlfeatureldaPath, v : Double) -> MlfeatureldaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_path_min(s : MlfeatureldaPath) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_path_max(s : MlfeatureldaPath) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_path_to_string(s : MlfeatureldaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_cluster_make(size : Int) -> MlfeatureldaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_cluster_len(s : MlfeatureldaCluster) -> Int { s.size }

pub fn ml_feature_lda_cluster_get(s : MlfeatureldaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_cluster_set(s : MlfeatureldaCluster, i : Int, v : Double) -> MlfeatureldaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_cluster_sum(s : MlfeatureldaCluster) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_cluster_mean(s : MlfeatureldaCluster) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_cluster_scale(s : MlfeatureldaCluster, f : Double) -> MlfeatureldaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_cluster_add(a : MlfeatureldaCluster, b : MlfeatureldaCluster) -> MlfeatureldaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_lda_cluster_copy(s : MlfeatureldaCluster) -> MlfeatureldaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_cluster_fill(s : MlfeatureldaCluster, v : Double) -> MlfeatureldaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_cluster_min(s : MlfeatureldaCluster) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_cluster_max(s : MlfeatureldaCluster) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_cluster_to_string(s : MlfeatureldaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_model_make(size : Int) -> MlfeatureldaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_model_len(s : MlfeatureldaModel) -> Int { s.size }

pub fn ml_feature_lda_model_get(s : MlfeatureldaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_model_set(s : MlfeatureldaModel, i : Int, v : Double) -> MlfeatureldaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_model_sum(s : MlfeatureldaModel) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_model_mean(s : MlfeatureldaModel) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_model_scale(s : MlfeatureldaModel, f : Double) -> MlfeatureldaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_model_add(a : MlfeatureldaModel, b : MlfeatureldaModel) -> MlfeatureldaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_lda_model_copy(s : MlfeatureldaModel) -> MlfeatureldaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_model_fill(s : MlfeatureldaModel, v : Double) -> MlfeatureldaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_model_min(s : MlfeatureldaModel) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_model_max(s : MlfeatureldaModel) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_model_to_string(s : MlfeatureldaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_layer_make(size : Int) -> MlfeatureldaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_layer_len(s : MlfeatureldaLayer) -> Int { s.size }

pub fn ml_feature_lda_layer_get(s : MlfeatureldaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_layer_set(s : MlfeatureldaLayer, i : Int, v : Double) -> MlfeatureldaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_layer_sum(s : MlfeatureldaLayer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_layer_mean(s : MlfeatureldaLayer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_layer_scale(s : MlfeatureldaLayer, f : Double) -> MlfeatureldaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_layer_add(a : MlfeatureldaLayer, b : MlfeatureldaLayer) -> MlfeatureldaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_lda_layer_copy(s : MlfeatureldaLayer) -> MlfeatureldaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_layer_fill(s : MlfeatureldaLayer, v : Double) -> MlfeatureldaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_layer_min(s : MlfeatureldaLayer) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_layer_max(s : MlfeatureldaLayer) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_layer_to_string(s : MlfeatureldaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_buffer_make(size : Int) -> MlfeatureldaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_buffer_len(s : MlfeatureldaBuffer) -> Int { s.size }

pub fn ml_feature_lda_buffer_get(s : MlfeatureldaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_buffer_set(s : MlfeatureldaBuffer, i : Int, v : Double) -> MlfeatureldaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_buffer_sum(s : MlfeatureldaBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_buffer_mean(s : MlfeatureldaBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_buffer_scale(s : MlfeatureldaBuffer, f : Double) -> MlfeatureldaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_buffer_add(a : MlfeatureldaBuffer, b : MlfeatureldaBuffer) -> MlfeatureldaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_lda_buffer_copy(s : MlfeatureldaBuffer) -> MlfeatureldaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_buffer_fill(s : MlfeatureldaBuffer, v : Double) -> MlfeatureldaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_buffer_min(s : MlfeatureldaBuffer) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_buffer_max(s : MlfeatureldaBuffer) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_buffer_to_string(s : MlfeatureldaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_cursor_make(size : Int) -> MlfeatureldaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_cursor_len(s : MlfeatureldaCursor) -> Int { s.size }

pub fn ml_feature_lda_cursor_get(s : MlfeatureldaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_cursor_set(s : MlfeatureldaCursor, i : Int, v : Double) -> MlfeatureldaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_cursor_sum(s : MlfeatureldaCursor) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_cursor_mean(s : MlfeatureldaCursor) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_cursor_scale(s : MlfeatureldaCursor, f : Double) -> MlfeatureldaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_cursor_add(a : MlfeatureldaCursor, b : MlfeatureldaCursor) -> MlfeatureldaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_lda_cursor_copy(s : MlfeatureldaCursor) -> MlfeatureldaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_cursor_fill(s : MlfeatureldaCursor, v : Double) -> MlfeatureldaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_cursor_min(s : MlfeatureldaCursor) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_cursor_max(s : MlfeatureldaCursor) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_cursor_to_string(s : MlfeatureldaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_view_make(size : Int) -> MlfeatureldaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_view_len(s : MlfeatureldaView) -> Int { s.size }

pub fn ml_feature_lda_view_get(s : MlfeatureldaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_view_set(s : MlfeatureldaView, i : Int, v : Double) -> MlfeatureldaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_view_sum(s : MlfeatureldaView) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_view_mean(s : MlfeatureldaView) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_view_scale(s : MlfeatureldaView, f : Double) -> MlfeatureldaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_view_add(a : MlfeatureldaView, b : MlfeatureldaView) -> MlfeatureldaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_lda_view_copy(s : MlfeatureldaView) -> MlfeatureldaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_view_fill(s : MlfeatureldaView, v : Double) -> MlfeatureldaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_view_min(s : MlfeatureldaView) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_view_max(s : MlfeatureldaView) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_view_to_string(s : MlfeatureldaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_range_make(size : Int) -> MlfeatureldaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_range_len(s : MlfeatureldaRange) -> Int { s.size }

pub fn ml_feature_lda_range_get(s : MlfeatureldaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_range_set(s : MlfeatureldaRange, i : Int, v : Double) -> MlfeatureldaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_range_sum(s : MlfeatureldaRange) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_range_mean(s : MlfeatureldaRange) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_range_scale(s : MlfeatureldaRange, f : Double) -> MlfeatureldaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_range_add(a : MlfeatureldaRange, b : MlfeatureldaRange) -> MlfeatureldaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_lda_range_copy(s : MlfeatureldaRange) -> MlfeatureldaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_range_fill(s : MlfeatureldaRange, v : Double) -> MlfeatureldaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_range_min(s : MlfeatureldaRange) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_range_max(s : MlfeatureldaRange) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_range_to_string(s : MlfeatureldaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlfeatureldaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_feature_lda_slice_make(size : Int) -> MlfeatureldaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_feature_lda_slice_len(s : MlfeatureldaSlice) -> Int { s.size }

pub fn ml_feature_lda_slice_get(s : MlfeatureldaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_feature_lda_slice_set(s : MlfeatureldaSlice, i : Int, v : Double) -> MlfeatureldaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_slice_sum(s : MlfeatureldaSlice) -> Double { @_common.sum(s.data) }

pub fn ml_feature_lda_slice_mean(s : MlfeatureldaSlice) -> Double { @_common.mean(s.data) }

pub fn ml_feature_lda_slice_scale(s : MlfeatureldaSlice, f : Double) -> MlfeatureldaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_slice_add(a : MlfeatureldaSlice, b : MlfeatureldaSlice) -> MlfeatureldaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_feature_lda_slice_copy(s : MlfeatureldaSlice) -> MlfeatureldaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_slice_fill(s : MlfeatureldaSlice, v : Double) -> MlfeatureldaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_feature_lda_slice_min(s : MlfeatureldaSlice) -> Double { @_common.min(s.data) }

pub fn ml_feature_lda_slice_max(s : MlfeatureldaSlice) -> Double { @_common.max(s.data) }

pub fn ml_feature_lda_slice_to_string(s : MlfeatureldaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

