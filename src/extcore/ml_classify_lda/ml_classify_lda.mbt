///===
/// extcore/ml_classify_lda

pub(all) struct MlclassifyldaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_classify_lda_make_point(x : Double, y : Double) -> MlclassifyldaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_classify_lda_make_point3(x : Double, y : Double, z : Double) -> MlclassifyldaPoint {
  { x, y, z, label: 0 }
}

pub fn MlclassifyldaPoint::x(self : MlclassifyldaPoint) -> Double { self.x }

pub fn MlclassifyldaPoint::y(self : MlclassifyldaPoint) -> Double { self.y }

pub fn MlclassifyldaPoint::z(self : MlclassifyldaPoint) -> Double { self.z }

pub fn MlclassifyldaPoint::label(self : MlclassifyldaPoint) -> Int { self.label }

pub fn MlclassifyldaPoint::dist(self : MlclassifyldaPoint, other : MlclassifyldaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlclassifyldaPoint::add(self : MlclassifyldaPoint, other : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlclassifyldaPoint::sub(self : MlclassifyldaPoint, other : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlclassifyldaPoint::scale(self : MlclassifyldaPoint, s : Double) -> MlclassifyldaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlclassifyldaPoint::dot(self : MlclassifyldaPoint, other : MlclassifyldaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlclassifyldaPoint::cross(self : MlclassifyldaPoint, other : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlclassifyldaPoint::norm(self : MlclassifyldaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlclassifyldaPoint::normalize(self : MlclassifyldaPoint) -> MlclassifyldaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyldaPoint::negate(self : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlclassifyldaPoint::mid(self : MlclassifyldaPoint, other : MlclassifyldaPoint) -> MlclassifyldaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlclassifyldaPoint::lerp(self : MlclassifyldaPoint, other : MlclassifyldaPoint, t : Double) -> MlclassifyldaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlclassifyldaPoint::to_string(self : MlclassifyldaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlclassifyldaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_classify_lda_make_series(vals : Array[Double], name : String) -> MlclassifyldaSeries {
  { vals, name, meta: 0 }
}

pub fn MlclassifyldaSeries::len(self : MlclassifyldaSeries) -> Int { self.vals.length() }

pub fn MlclassifyldaSeries::sum(self : MlclassifyldaSeries) -> Double { @_common.sum(self.vals) }

pub fn MlclassifyldaSeries::mean(self : MlclassifyldaSeries) -> Double { @_common.mean(self.vals) }

pub fn MlclassifyldaSeries::min(self : MlclassifyldaSeries) -> Double { @_common.min(self.vals) }

pub fn MlclassifyldaSeries::max(self : MlclassifyldaSeries) -> Double { @_common.max(self.vals) }

pub fn MlclassifyldaSeries::range(self : MlclassifyldaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlclassifyldaSeries::variance(self : MlclassifyldaSeries) -> Double { @_common.variance(self.vals) }

pub fn MlclassifyldaSeries::std(self : MlclassifyldaSeries) -> Double { @_common.std(self.vals) }

pub fn MlclassifyldaSeries::median(self : MlclassifyldaSeries) -> Double { @_common.median(self.vals) }

pub fn MlclassifyldaSeries::scale(self : MlclassifyldaSeries, f : Double) -> MlclassifyldaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlclassifyldaSeries::add(self : MlclassifyldaSeries, other : MlclassifyldaSeries) -> MlclassifyldaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlclassifyldaSeries::sub(self : MlclassifyldaSeries, other : MlclassifyldaSeries) -> MlclassifyldaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlclassifyldaSeries::normalize(self : MlclassifyldaSeries) -> MlclassifyldaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlclassifyldaSeries::cumsum(self : MlclassifyldaSeries) -> MlclassifyldaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlclassifyldaSeries::to_string(self : MlclassifyldaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlclassifyldaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_classify_lda_make_matrix(rows : Int, cols : Int, val : Double) -> MlclassifyldaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_classify_lda_matrix_identity(n : Int) -> MlclassifyldaMatrix {
  let m = ml_classify_lda_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlclassifyldaMatrix::get(self : MlclassifyldaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlclassifyldaMatrix::transpose(self : MlclassifyldaMatrix) -> MlclassifyldaMatrix {
  let result = ml_classify_lda_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlclassifyldaMatrix::add(self : MlclassifyldaMatrix, other : MlclassifyldaMatrix) -> MlclassifyldaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_classify_lda_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlclassifyldaMatrix::scale(self : MlclassifyldaMatrix, s : Double) -> MlclassifyldaMatrix {
  let result = ml_classify_lda_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlclassifyldaMatrix::multiply(self : MlclassifyldaMatrix, other : MlclassifyldaMatrix) -> MlclassifyldaMatrix {
  if self.cols != other.rows { return ml_classify_lda_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_classify_lda_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlclassifyldaMatrix::trace(self : MlclassifyldaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlclassifyldaMatrix::det(self : MlclassifyldaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlclassifyldaMatrix::norm(self : MlclassifyldaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlclassifyldaMatrix::to_string(self : MlclassifyldaMatrix) -> String {
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

pub(all) struct MlclassifyldaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_classify_lda_make_vector(comps : Array[Double]) -> MlclassifyldaVector {
  { comps, dim: comps.length() }
}

pub fn ml_classify_lda_vector_zero(dim : Int) -> MlclassifyldaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlclassifyldaVector::add(self : MlclassifyldaVector, other : MlclassifyldaVector) -> MlclassifyldaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyldaVector::sub(self : MlclassifyldaVector, other : MlclassifyldaVector) -> MlclassifyldaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlclassifyldaVector::scale(self : MlclassifyldaVector, s : Double) -> MlclassifyldaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlclassifyldaVector::dot(self : MlclassifyldaVector, other : MlclassifyldaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlclassifyldaVector::norm(self : MlclassifyldaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlclassifyldaVector::normalize(self : MlclassifyldaVector) -> MlclassifyldaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlclassifyldaVector::dist(self : MlclassifyldaVector, other : MlclassifyldaVector) -> Double {
  self.sub(other).norm()
}

pub fn MlclassifyldaVector::to_string(self : MlclassifyldaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_classify_lda_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_classify_lda_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_classify_lda_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_classify_lda_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_classify_lda_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_classify_lda_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_classify_lda_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_classify_lda_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_classify_lda_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_classify_lda_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_classify_lda_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_classify_lda_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_classify_lda_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_classify_lda_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_classify_lda_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_classify_lda_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_classify_lda_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_classify_lda_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_classify_lda_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_classify_lda_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_classify_lda_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_classify_lda_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_classify_lda_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_classify_lda_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_classify_lda_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_classify_lda_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_classify_lda_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_classify_lda_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_classify_lda_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlclassifyldaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_frame_make(size : Int) -> MlclassifyldaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_frame_len(s : MlclassifyldaFrame) -> Int { s.size }

pub fn ml_classify_lda_frame_get(s : MlclassifyldaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_frame_set(s : MlclassifyldaFrame, i : Int, v : Double) -> MlclassifyldaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_frame_sum(s : MlclassifyldaFrame) -> Double { @_common.sum(s.data) }

pub fn ml_classify_lda_frame_mean(s : MlclassifyldaFrame) -> Double { @_common.mean(s.data) }

pub fn ml_classify_lda_frame_scale(s : MlclassifyldaFrame, f : Double) -> MlclassifyldaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_frame_add(a : MlclassifyldaFrame, b : MlclassifyldaFrame) -> MlclassifyldaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_lda_frame_copy(s : MlclassifyldaFrame) -> MlclassifyldaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_frame_fill(s : MlclassifyldaFrame, v : Double) -> MlclassifyldaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_frame_min(s : MlclassifyldaFrame) -> Double { @_common.min(s.data) }

pub fn ml_classify_lda_frame_max(s : MlclassifyldaFrame) -> Double { @_common.max(s.data) }

pub fn ml_classify_lda_frame_to_string(s : MlclassifyldaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_table_make(size : Int) -> MlclassifyldaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_table_len(s : MlclassifyldaTable) -> Int { s.size }

pub fn ml_classify_lda_table_get(s : MlclassifyldaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_table_set(s : MlclassifyldaTable, i : Int, v : Double) -> MlclassifyldaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_table_sum(s : MlclassifyldaTable) -> Double { @_common.sum(s.data) }

pub fn ml_classify_lda_table_mean(s : MlclassifyldaTable) -> Double { @_common.mean(s.data) }

pub fn ml_classify_lda_table_scale(s : MlclassifyldaTable, f : Double) -> MlclassifyldaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_table_add(a : MlclassifyldaTable, b : MlclassifyldaTable) -> MlclassifyldaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_lda_table_copy(s : MlclassifyldaTable) -> MlclassifyldaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_table_fill(s : MlclassifyldaTable, v : Double) -> MlclassifyldaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_table_min(s : MlclassifyldaTable) -> Double { @_common.min(s.data) }

pub fn ml_classify_lda_table_max(s : MlclassifyldaTable) -> Double { @_common.max(s.data) }

pub fn ml_classify_lda_table_to_string(s : MlclassifyldaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_graphn_make(size : Int) -> MlclassifyldaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_graphn_len(s : MlclassifyldaGraphN) -> Int { s.size }

pub fn ml_classify_lda_graphn_get(s : MlclassifyldaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_graphn_set(s : MlclassifyldaGraphN, i : Int, v : Double) -> MlclassifyldaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_graphn_sum(s : MlclassifyldaGraphN) -> Double { @_common.sum(s.data) }

pub fn ml_classify_lda_graphn_mean(s : MlclassifyldaGraphN) -> Double { @_common.mean(s.data) }

pub fn ml_classify_lda_graphn_scale(s : MlclassifyldaGraphN, f : Double) -> MlclassifyldaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_graphn_add(a : MlclassifyldaGraphN, b : MlclassifyldaGraphN) -> MlclassifyldaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_lda_graphn_copy(s : MlclassifyldaGraphN) -> MlclassifyldaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_graphn_fill(s : MlclassifyldaGraphN, v : Double) -> MlclassifyldaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_graphn_min(s : MlclassifyldaGraphN) -> Double { @_common.min(s.data) }

pub fn ml_classify_lda_graphn_max(s : MlclassifyldaGraphN) -> Double { @_common.max(s.data) }

pub fn ml_classify_lda_graphn_to_string(s : MlclassifyldaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_node_make(size : Int) -> MlclassifyldaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_node_len(s : MlclassifyldaNode) -> Int { s.size }

pub fn ml_classify_lda_node_get(s : MlclassifyldaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_node_set(s : MlclassifyldaNode, i : Int, v : Double) -> MlclassifyldaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_node_sum(s : MlclassifyldaNode) -> Double { @_common.sum(s.data) }

pub fn ml_classify_lda_node_mean(s : MlclassifyldaNode) -> Double { @_common.mean(s.data) }

pub fn ml_classify_lda_node_scale(s : MlclassifyldaNode, f : Double) -> MlclassifyldaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_node_add(a : MlclassifyldaNode, b : MlclassifyldaNode) -> MlclassifyldaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_lda_node_copy(s : MlclassifyldaNode) -> MlclassifyldaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_node_fill(s : MlclassifyldaNode, v : Double) -> MlclassifyldaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_node_min(s : MlclassifyldaNode) -> Double { @_common.min(s.data) }

pub fn ml_classify_lda_node_max(s : MlclassifyldaNode) -> Double { @_common.max(s.data) }

pub fn ml_classify_lda_node_to_string(s : MlclassifyldaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_edge_make(size : Int) -> MlclassifyldaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_edge_len(s : MlclassifyldaEdge) -> Int { s.size }

pub fn ml_classify_lda_edge_get(s : MlclassifyldaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_edge_set(s : MlclassifyldaEdge, i : Int, v : Double) -> MlclassifyldaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_edge_sum(s : MlclassifyldaEdge) -> Double { @_common.sum(s.data) }

pub fn ml_classify_lda_edge_mean(s : MlclassifyldaEdge) -> Double { @_common.mean(s.data) }

pub fn ml_classify_lda_edge_scale(s : MlclassifyldaEdge, f : Double) -> MlclassifyldaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_edge_add(a : MlclassifyldaEdge, b : MlclassifyldaEdge) -> MlclassifyldaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_lda_edge_copy(s : MlclassifyldaEdge) -> MlclassifyldaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_edge_fill(s : MlclassifyldaEdge, v : Double) -> MlclassifyldaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_edge_min(s : MlclassifyldaEdge) -> Double { @_common.min(s.data) }

pub fn ml_classify_lda_edge_max(s : MlclassifyldaEdge) -> Double { @_common.max(s.data) }

pub fn ml_classify_lda_edge_to_string(s : MlclassifyldaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_path_make(size : Int) -> MlclassifyldaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_path_len(s : MlclassifyldaPath) -> Int { s.size }

pub fn ml_classify_lda_path_get(s : MlclassifyldaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_path_set(s : MlclassifyldaPath, i : Int, v : Double) -> MlclassifyldaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_path_sum(s : MlclassifyldaPath) -> Double { @_common.sum(s.data) }

pub fn ml_classify_lda_path_mean(s : MlclassifyldaPath) -> Double { @_common.mean(s.data) }

pub fn ml_classify_lda_path_scale(s : MlclassifyldaPath, f : Double) -> MlclassifyldaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_path_add(a : MlclassifyldaPath, b : MlclassifyldaPath) -> MlclassifyldaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_lda_path_copy(s : MlclassifyldaPath) -> MlclassifyldaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_path_fill(s : MlclassifyldaPath, v : Double) -> MlclassifyldaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_path_min(s : MlclassifyldaPath) -> Double { @_common.min(s.data) }

pub fn ml_classify_lda_path_max(s : MlclassifyldaPath) -> Double { @_common.max(s.data) }

pub fn ml_classify_lda_path_to_string(s : MlclassifyldaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_cluster_make(size : Int) -> MlclassifyldaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_cluster_len(s : MlclassifyldaCluster) -> Int { s.size }

pub fn ml_classify_lda_cluster_get(s : MlclassifyldaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_cluster_set(s : MlclassifyldaCluster, i : Int, v : Double) -> MlclassifyldaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_cluster_sum(s : MlclassifyldaCluster) -> Double { @_common.sum(s.data) }

pub fn ml_classify_lda_cluster_mean(s : MlclassifyldaCluster) -> Double { @_common.mean(s.data) }

pub fn ml_classify_lda_cluster_scale(s : MlclassifyldaCluster, f : Double) -> MlclassifyldaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_cluster_add(a : MlclassifyldaCluster, b : MlclassifyldaCluster) -> MlclassifyldaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_lda_cluster_copy(s : MlclassifyldaCluster) -> MlclassifyldaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_cluster_fill(s : MlclassifyldaCluster, v : Double) -> MlclassifyldaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_cluster_min(s : MlclassifyldaCluster) -> Double { @_common.min(s.data) }

pub fn ml_classify_lda_cluster_max(s : MlclassifyldaCluster) -> Double { @_common.max(s.data) }

pub fn ml_classify_lda_cluster_to_string(s : MlclassifyldaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_model_make(size : Int) -> MlclassifyldaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_model_len(s : MlclassifyldaModel) -> Int { s.size }

pub fn ml_classify_lda_model_get(s : MlclassifyldaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_model_set(s : MlclassifyldaModel, i : Int, v : Double) -> MlclassifyldaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_model_sum(s : MlclassifyldaModel) -> Double { @_common.sum(s.data) }

pub fn ml_classify_lda_model_mean(s : MlclassifyldaModel) -> Double { @_common.mean(s.data) }

pub fn ml_classify_lda_model_scale(s : MlclassifyldaModel, f : Double) -> MlclassifyldaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_model_add(a : MlclassifyldaModel, b : MlclassifyldaModel) -> MlclassifyldaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_lda_model_copy(s : MlclassifyldaModel) -> MlclassifyldaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_model_fill(s : MlclassifyldaModel, v : Double) -> MlclassifyldaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_model_min(s : MlclassifyldaModel) -> Double { @_common.min(s.data) }

pub fn ml_classify_lda_model_max(s : MlclassifyldaModel) -> Double { @_common.max(s.data) }

pub fn ml_classify_lda_model_to_string(s : MlclassifyldaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_layer_make(size : Int) -> MlclassifyldaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_layer_len(s : MlclassifyldaLayer) -> Int { s.size }

pub fn ml_classify_lda_layer_get(s : MlclassifyldaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_layer_set(s : MlclassifyldaLayer, i : Int, v : Double) -> MlclassifyldaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_layer_sum(s : MlclassifyldaLayer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_lda_layer_mean(s : MlclassifyldaLayer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_lda_layer_scale(s : MlclassifyldaLayer, f : Double) -> MlclassifyldaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_layer_add(a : MlclassifyldaLayer, b : MlclassifyldaLayer) -> MlclassifyldaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_lda_layer_copy(s : MlclassifyldaLayer) -> MlclassifyldaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_layer_fill(s : MlclassifyldaLayer, v : Double) -> MlclassifyldaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_layer_min(s : MlclassifyldaLayer) -> Double { @_common.min(s.data) }

pub fn ml_classify_lda_layer_max(s : MlclassifyldaLayer) -> Double { @_common.max(s.data) }

pub fn ml_classify_lda_layer_to_string(s : MlclassifyldaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_buffer_make(size : Int) -> MlclassifyldaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_buffer_len(s : MlclassifyldaBuffer) -> Int { s.size }

pub fn ml_classify_lda_buffer_get(s : MlclassifyldaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_buffer_set(s : MlclassifyldaBuffer, i : Int, v : Double) -> MlclassifyldaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_buffer_sum(s : MlclassifyldaBuffer) -> Double { @_common.sum(s.data) }

pub fn ml_classify_lda_buffer_mean(s : MlclassifyldaBuffer) -> Double { @_common.mean(s.data) }

pub fn ml_classify_lda_buffer_scale(s : MlclassifyldaBuffer, f : Double) -> MlclassifyldaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_buffer_add(a : MlclassifyldaBuffer, b : MlclassifyldaBuffer) -> MlclassifyldaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_lda_buffer_copy(s : MlclassifyldaBuffer) -> MlclassifyldaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_buffer_fill(s : MlclassifyldaBuffer, v : Double) -> MlclassifyldaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_buffer_min(s : MlclassifyldaBuffer) -> Double { @_common.min(s.data) }

pub fn ml_classify_lda_buffer_max(s : MlclassifyldaBuffer) -> Double { @_common.max(s.data) }

pub fn ml_classify_lda_buffer_to_string(s : MlclassifyldaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_cursor_make(size : Int) -> MlclassifyldaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_cursor_len(s : MlclassifyldaCursor) -> Int { s.size }

pub fn ml_classify_lda_cursor_get(s : MlclassifyldaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_cursor_set(s : MlclassifyldaCursor, i : Int, v : Double) -> MlclassifyldaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_cursor_sum(s : MlclassifyldaCursor) -> Double { @_common.sum(s.data) }

pub fn ml_classify_lda_cursor_mean(s : MlclassifyldaCursor) -> Double { @_common.mean(s.data) }

pub fn ml_classify_lda_cursor_scale(s : MlclassifyldaCursor, f : Double) -> MlclassifyldaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_cursor_add(a : MlclassifyldaCursor, b : MlclassifyldaCursor) -> MlclassifyldaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_lda_cursor_copy(s : MlclassifyldaCursor) -> MlclassifyldaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_cursor_fill(s : MlclassifyldaCursor, v : Double) -> MlclassifyldaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_cursor_min(s : MlclassifyldaCursor) -> Double { @_common.min(s.data) }

pub fn ml_classify_lda_cursor_max(s : MlclassifyldaCursor) -> Double { @_common.max(s.data) }

pub fn ml_classify_lda_cursor_to_string(s : MlclassifyldaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_view_make(size : Int) -> MlclassifyldaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_view_len(s : MlclassifyldaView) -> Int { s.size }

pub fn ml_classify_lda_view_get(s : MlclassifyldaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_view_set(s : MlclassifyldaView, i : Int, v : Double) -> MlclassifyldaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_view_sum(s : MlclassifyldaView) -> Double { @_common.sum(s.data) }

pub fn ml_classify_lda_view_mean(s : MlclassifyldaView) -> Double { @_common.mean(s.data) }

pub fn ml_classify_lda_view_scale(s : MlclassifyldaView, f : Double) -> MlclassifyldaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_view_add(a : MlclassifyldaView, b : MlclassifyldaView) -> MlclassifyldaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_lda_view_copy(s : MlclassifyldaView) -> MlclassifyldaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_view_fill(s : MlclassifyldaView, v : Double) -> MlclassifyldaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_view_min(s : MlclassifyldaView) -> Double { @_common.min(s.data) }

pub fn ml_classify_lda_view_max(s : MlclassifyldaView) -> Double { @_common.max(s.data) }

pub fn ml_classify_lda_view_to_string(s : MlclassifyldaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_range_make(size : Int) -> MlclassifyldaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_range_len(s : MlclassifyldaRange) -> Int { s.size }

pub fn ml_classify_lda_range_get(s : MlclassifyldaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_range_set(s : MlclassifyldaRange, i : Int, v : Double) -> MlclassifyldaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_range_sum(s : MlclassifyldaRange) -> Double { @_common.sum(s.data) }

pub fn ml_classify_lda_range_mean(s : MlclassifyldaRange) -> Double { @_common.mean(s.data) }

pub fn ml_classify_lda_range_scale(s : MlclassifyldaRange, f : Double) -> MlclassifyldaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_range_add(a : MlclassifyldaRange, b : MlclassifyldaRange) -> MlclassifyldaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_lda_range_copy(s : MlclassifyldaRange) -> MlclassifyldaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_range_fill(s : MlclassifyldaRange, v : Double) -> MlclassifyldaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_range_min(s : MlclassifyldaRange) -> Double { @_common.min(s.data) }

pub fn ml_classify_lda_range_max(s : MlclassifyldaRange) -> Double { @_common.max(s.data) }

pub fn ml_classify_lda_range_to_string(s : MlclassifyldaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlclassifyldaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_classify_lda_slice_make(size : Int) -> MlclassifyldaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_classify_lda_slice_len(s : MlclassifyldaSlice) -> Int { s.size }

pub fn ml_classify_lda_slice_get(s : MlclassifyldaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_classify_lda_slice_set(s : MlclassifyldaSlice, i : Int, v : Double) -> MlclassifyldaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_slice_sum(s : MlclassifyldaSlice) -> Double { @_common.sum(s.data) }

pub fn ml_classify_lda_slice_mean(s : MlclassifyldaSlice) -> Double { @_common.mean(s.data) }

pub fn ml_classify_lda_slice_scale(s : MlclassifyldaSlice, f : Double) -> MlclassifyldaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_slice_add(a : MlclassifyldaSlice, b : MlclassifyldaSlice) -> MlclassifyldaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ml_classify_lda_slice_copy(s : MlclassifyldaSlice) -> MlclassifyldaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_slice_fill(s : MlclassifyldaSlice, v : Double) -> MlclassifyldaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ml_classify_lda_slice_min(s : MlclassifyldaSlice) -> Double { @_common.min(s.data) }

pub fn ml_classify_lda_slice_max(s : MlclassifyldaSlice) -> Double { @_common.max(s.data) }

pub fn ml_classify_lda_slice_to_string(s : MlclassifyldaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

