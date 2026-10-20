///===
/// extcore/nlp_pos_averaged

pub(all) struct NlpposaveragedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_averaged_make_point(x : Double, y : Double) -> NlpposaveragedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_averaged_make_point3(x : Double, y : Double, z : Double) -> NlpposaveragedPoint {
  { x, y, z, label: 0 }
}

pub fn NlpposaveragedPoint::x(self : NlpposaveragedPoint) -> Double { self.x }

pub fn NlpposaveragedPoint::y(self : NlpposaveragedPoint) -> Double { self.y }

pub fn NlpposaveragedPoint::z(self : NlpposaveragedPoint) -> Double { self.z }

pub fn NlpposaveragedPoint::label(self : NlpposaveragedPoint) -> Int { self.label }

pub fn NlpposaveragedPoint::dist(self : NlpposaveragedPoint, other : NlpposaveragedPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpposaveragedPoint::add(self : NlpposaveragedPoint, other : NlpposaveragedPoint) -> NlpposaveragedPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpposaveragedPoint::sub(self : NlpposaveragedPoint, other : NlpposaveragedPoint) -> NlpposaveragedPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpposaveragedPoint::scale(self : NlpposaveragedPoint, s : Double) -> NlpposaveragedPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpposaveragedPoint::dot(self : NlpposaveragedPoint, other : NlpposaveragedPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpposaveragedPoint::cross(self : NlpposaveragedPoint, other : NlpposaveragedPoint) -> NlpposaveragedPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpposaveragedPoint::norm(self : NlpposaveragedPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpposaveragedPoint::normalize(self : NlpposaveragedPoint) -> NlpposaveragedPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposaveragedPoint::negate(self : NlpposaveragedPoint) -> NlpposaveragedPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpposaveragedPoint::mid(self : NlpposaveragedPoint, other : NlpposaveragedPoint) -> NlpposaveragedPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpposaveragedPoint::lerp(self : NlpposaveragedPoint, other : NlpposaveragedPoint, t : Double) -> NlpposaveragedPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpposaveragedPoint::to_string(self : NlpposaveragedPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpposaveragedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_averaged_make_series(vals : Array[Double], name : String) -> NlpposaveragedSeries {
  { vals, name, meta: 0 }
}

pub fn NlpposaveragedSeries::len(self : NlpposaveragedSeries) -> Int { self.vals.length() }

pub fn NlpposaveragedSeries::sum(self : NlpposaveragedSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpposaveragedSeries::mean(self : NlpposaveragedSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpposaveragedSeries::min(self : NlpposaveragedSeries) -> Double { @_common.min(self.vals) }

pub fn NlpposaveragedSeries::max(self : NlpposaveragedSeries) -> Double { @_common.max(self.vals) }

pub fn NlpposaveragedSeries::range(self : NlpposaveragedSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpposaveragedSeries::variance(self : NlpposaveragedSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpposaveragedSeries::std(self : NlpposaveragedSeries) -> Double { @_common.std(self.vals) }

pub fn NlpposaveragedSeries::median(self : NlpposaveragedSeries) -> Double { @_common.median(self.vals) }

pub fn NlpposaveragedSeries::scale(self : NlpposaveragedSeries, f : Double) -> NlpposaveragedSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpposaveragedSeries::add(self : NlpposaveragedSeries, other : NlpposaveragedSeries) -> NlpposaveragedSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpposaveragedSeries::sub(self : NlpposaveragedSeries, other : NlpposaveragedSeries) -> NlpposaveragedSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpposaveragedSeries::normalize(self : NlpposaveragedSeries) -> NlpposaveragedSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpposaveragedSeries::cumsum(self : NlpposaveragedSeries) -> NlpposaveragedSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpposaveragedSeries::to_string(self : NlpposaveragedSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposaveragedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_averaged_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposaveragedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_averaged_matrix_identity(n : Int) -> NlpposaveragedMatrix {
  let m = nlp_pos_averaged_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpposaveragedMatrix::get(self : NlpposaveragedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpposaveragedMatrix::transpose(self : NlpposaveragedMatrix) -> NlpposaveragedMatrix {
  let result = nlp_pos_averaged_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpposaveragedMatrix::add(self : NlpposaveragedMatrix, other : NlpposaveragedMatrix) -> NlpposaveragedMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_averaged_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpposaveragedMatrix::scale(self : NlpposaveragedMatrix, s : Double) -> NlpposaveragedMatrix {
  let result = nlp_pos_averaged_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpposaveragedMatrix::multiply(self : NlpposaveragedMatrix, other : NlpposaveragedMatrix) -> NlpposaveragedMatrix {
  if self.cols != other.rows { return nlp_pos_averaged_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_averaged_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpposaveragedMatrix::trace(self : NlpposaveragedMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpposaveragedMatrix::det(self : NlpposaveragedMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpposaveragedMatrix::norm(self : NlpposaveragedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpposaveragedMatrix::to_string(self : NlpposaveragedMatrix) -> String {
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

pub(all) struct NlpposaveragedVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_averaged_make_vector(comps : Array[Double]) -> NlpposaveragedVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_averaged_vector_zero(dim : Int) -> NlpposaveragedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpposaveragedVector::add(self : NlpposaveragedVector, other : NlpposaveragedVector) -> NlpposaveragedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposaveragedVector::sub(self : NlpposaveragedVector, other : NlpposaveragedVector) -> NlpposaveragedVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposaveragedVector::scale(self : NlpposaveragedVector, s : Double) -> NlpposaveragedVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpposaveragedVector::dot(self : NlpposaveragedVector, other : NlpposaveragedVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpposaveragedVector::norm(self : NlpposaveragedVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpposaveragedVector::normalize(self : NlpposaveragedVector) -> NlpposaveragedVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposaveragedVector::dist(self : NlpposaveragedVector, other : NlpposaveragedVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpposaveragedVector::to_string(self : NlpposaveragedVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_averaged_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_averaged_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_averaged_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_averaged_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_averaged_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_averaged_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_averaged_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_averaged_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_averaged_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_averaged_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_averaged_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_averaged_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_averaged_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_averaged_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_averaged_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_averaged_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_averaged_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_averaged_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_averaged_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_averaged_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_averaged_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_averaged_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_averaged_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_averaged_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_averaged_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_averaged_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_averaged_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_averaged_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_averaged_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpposaveragedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_frame_make(size : Int) -> NlpposaveragedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_frame_len(s : NlpposaveragedFrame) -> Int { s.size }

pub fn nlp_pos_averaged_frame_get(s : NlpposaveragedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_frame_set(s : NlpposaveragedFrame, i : Int, v : Double) -> NlpposaveragedFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_frame_sum(s : NlpposaveragedFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_averaged_frame_mean(s : NlpposaveragedFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_averaged_frame_scale(s : NlpposaveragedFrame, f : Double) -> NlpposaveragedFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_frame_add(a : NlpposaveragedFrame, b : NlpposaveragedFrame) -> NlpposaveragedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_averaged_frame_copy(s : NlpposaveragedFrame) -> NlpposaveragedFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_frame_fill(s : NlpposaveragedFrame, v : Double) -> NlpposaveragedFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_frame_min(s : NlpposaveragedFrame) -> Double { @_common.min(s.data) }

pub fn nlp_pos_averaged_frame_max(s : NlpposaveragedFrame) -> Double { @_common.max(s.data) }

pub fn nlp_pos_averaged_frame_to_string(s : NlpposaveragedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_table_make(size : Int) -> NlpposaveragedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_table_len(s : NlpposaveragedTable) -> Int { s.size }

pub fn nlp_pos_averaged_table_get(s : NlpposaveragedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_table_set(s : NlpposaveragedTable, i : Int, v : Double) -> NlpposaveragedTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_table_sum(s : NlpposaveragedTable) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_averaged_table_mean(s : NlpposaveragedTable) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_averaged_table_scale(s : NlpposaveragedTable, f : Double) -> NlpposaveragedTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_table_add(a : NlpposaveragedTable, b : NlpposaveragedTable) -> NlpposaveragedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_averaged_table_copy(s : NlpposaveragedTable) -> NlpposaveragedTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_table_fill(s : NlpposaveragedTable, v : Double) -> NlpposaveragedTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_table_min(s : NlpposaveragedTable) -> Double { @_common.min(s.data) }

pub fn nlp_pos_averaged_table_max(s : NlpposaveragedTable) -> Double { @_common.max(s.data) }

pub fn nlp_pos_averaged_table_to_string(s : NlpposaveragedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_graphn_make(size : Int) -> NlpposaveragedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_graphn_len(s : NlpposaveragedGraphN) -> Int { s.size }

pub fn nlp_pos_averaged_graphn_get(s : NlpposaveragedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_graphn_set(s : NlpposaveragedGraphN, i : Int, v : Double) -> NlpposaveragedGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_graphn_sum(s : NlpposaveragedGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_averaged_graphn_mean(s : NlpposaveragedGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_averaged_graphn_scale(s : NlpposaveragedGraphN, f : Double) -> NlpposaveragedGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_graphn_add(a : NlpposaveragedGraphN, b : NlpposaveragedGraphN) -> NlpposaveragedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_averaged_graphn_copy(s : NlpposaveragedGraphN) -> NlpposaveragedGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_graphn_fill(s : NlpposaveragedGraphN, v : Double) -> NlpposaveragedGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_graphn_min(s : NlpposaveragedGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_pos_averaged_graphn_max(s : NlpposaveragedGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_pos_averaged_graphn_to_string(s : NlpposaveragedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_node_make(size : Int) -> NlpposaveragedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_node_len(s : NlpposaveragedNode) -> Int { s.size }

pub fn nlp_pos_averaged_node_get(s : NlpposaveragedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_node_set(s : NlpposaveragedNode, i : Int, v : Double) -> NlpposaveragedNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_node_sum(s : NlpposaveragedNode) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_averaged_node_mean(s : NlpposaveragedNode) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_averaged_node_scale(s : NlpposaveragedNode, f : Double) -> NlpposaveragedNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_node_add(a : NlpposaveragedNode, b : NlpposaveragedNode) -> NlpposaveragedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_averaged_node_copy(s : NlpposaveragedNode) -> NlpposaveragedNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_node_fill(s : NlpposaveragedNode, v : Double) -> NlpposaveragedNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_node_min(s : NlpposaveragedNode) -> Double { @_common.min(s.data) }

pub fn nlp_pos_averaged_node_max(s : NlpposaveragedNode) -> Double { @_common.max(s.data) }

pub fn nlp_pos_averaged_node_to_string(s : NlpposaveragedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_edge_make(size : Int) -> NlpposaveragedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_edge_len(s : NlpposaveragedEdge) -> Int { s.size }

pub fn nlp_pos_averaged_edge_get(s : NlpposaveragedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_edge_set(s : NlpposaveragedEdge, i : Int, v : Double) -> NlpposaveragedEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_edge_sum(s : NlpposaveragedEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_averaged_edge_mean(s : NlpposaveragedEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_averaged_edge_scale(s : NlpposaveragedEdge, f : Double) -> NlpposaveragedEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_edge_add(a : NlpposaveragedEdge, b : NlpposaveragedEdge) -> NlpposaveragedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_averaged_edge_copy(s : NlpposaveragedEdge) -> NlpposaveragedEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_edge_fill(s : NlpposaveragedEdge, v : Double) -> NlpposaveragedEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_edge_min(s : NlpposaveragedEdge) -> Double { @_common.min(s.data) }

pub fn nlp_pos_averaged_edge_max(s : NlpposaveragedEdge) -> Double { @_common.max(s.data) }

pub fn nlp_pos_averaged_edge_to_string(s : NlpposaveragedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_path_make(size : Int) -> NlpposaveragedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_path_len(s : NlpposaveragedPath) -> Int { s.size }

pub fn nlp_pos_averaged_path_get(s : NlpposaveragedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_path_set(s : NlpposaveragedPath, i : Int, v : Double) -> NlpposaveragedPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_path_sum(s : NlpposaveragedPath) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_averaged_path_mean(s : NlpposaveragedPath) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_averaged_path_scale(s : NlpposaveragedPath, f : Double) -> NlpposaveragedPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_path_add(a : NlpposaveragedPath, b : NlpposaveragedPath) -> NlpposaveragedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_averaged_path_copy(s : NlpposaveragedPath) -> NlpposaveragedPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_path_fill(s : NlpposaveragedPath, v : Double) -> NlpposaveragedPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_path_min(s : NlpposaveragedPath) -> Double { @_common.min(s.data) }

pub fn nlp_pos_averaged_path_max(s : NlpposaveragedPath) -> Double { @_common.max(s.data) }

pub fn nlp_pos_averaged_path_to_string(s : NlpposaveragedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_cluster_make(size : Int) -> NlpposaveragedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_cluster_len(s : NlpposaveragedCluster) -> Int { s.size }

pub fn nlp_pos_averaged_cluster_get(s : NlpposaveragedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_cluster_set(s : NlpposaveragedCluster, i : Int, v : Double) -> NlpposaveragedCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_cluster_sum(s : NlpposaveragedCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_averaged_cluster_mean(s : NlpposaveragedCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_averaged_cluster_scale(s : NlpposaveragedCluster, f : Double) -> NlpposaveragedCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_cluster_add(a : NlpposaveragedCluster, b : NlpposaveragedCluster) -> NlpposaveragedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_averaged_cluster_copy(s : NlpposaveragedCluster) -> NlpposaveragedCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_cluster_fill(s : NlpposaveragedCluster, v : Double) -> NlpposaveragedCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_cluster_min(s : NlpposaveragedCluster) -> Double { @_common.min(s.data) }

pub fn nlp_pos_averaged_cluster_max(s : NlpposaveragedCluster) -> Double { @_common.max(s.data) }

pub fn nlp_pos_averaged_cluster_to_string(s : NlpposaveragedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_model_make(size : Int) -> NlpposaveragedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_model_len(s : NlpposaveragedModel) -> Int { s.size }

pub fn nlp_pos_averaged_model_get(s : NlpposaveragedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_model_set(s : NlpposaveragedModel, i : Int, v : Double) -> NlpposaveragedModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_model_sum(s : NlpposaveragedModel) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_averaged_model_mean(s : NlpposaveragedModel) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_averaged_model_scale(s : NlpposaveragedModel, f : Double) -> NlpposaveragedModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_model_add(a : NlpposaveragedModel, b : NlpposaveragedModel) -> NlpposaveragedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_averaged_model_copy(s : NlpposaveragedModel) -> NlpposaveragedModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_model_fill(s : NlpposaveragedModel, v : Double) -> NlpposaveragedModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_model_min(s : NlpposaveragedModel) -> Double { @_common.min(s.data) }

pub fn nlp_pos_averaged_model_max(s : NlpposaveragedModel) -> Double { @_common.max(s.data) }

pub fn nlp_pos_averaged_model_to_string(s : NlpposaveragedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_layer_make(size : Int) -> NlpposaveragedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_layer_len(s : NlpposaveragedLayer) -> Int { s.size }

pub fn nlp_pos_averaged_layer_get(s : NlpposaveragedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_layer_set(s : NlpposaveragedLayer, i : Int, v : Double) -> NlpposaveragedLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_layer_sum(s : NlpposaveragedLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_averaged_layer_mean(s : NlpposaveragedLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_averaged_layer_scale(s : NlpposaveragedLayer, f : Double) -> NlpposaveragedLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_layer_add(a : NlpposaveragedLayer, b : NlpposaveragedLayer) -> NlpposaveragedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_averaged_layer_copy(s : NlpposaveragedLayer) -> NlpposaveragedLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_layer_fill(s : NlpposaveragedLayer, v : Double) -> NlpposaveragedLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_layer_min(s : NlpposaveragedLayer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_averaged_layer_max(s : NlpposaveragedLayer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_averaged_layer_to_string(s : NlpposaveragedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_buffer_make(size : Int) -> NlpposaveragedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_buffer_len(s : NlpposaveragedBuffer) -> Int { s.size }

pub fn nlp_pos_averaged_buffer_get(s : NlpposaveragedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_buffer_set(s : NlpposaveragedBuffer, i : Int, v : Double) -> NlpposaveragedBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_buffer_sum(s : NlpposaveragedBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_averaged_buffer_mean(s : NlpposaveragedBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_averaged_buffer_scale(s : NlpposaveragedBuffer, f : Double) -> NlpposaveragedBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_buffer_add(a : NlpposaveragedBuffer, b : NlpposaveragedBuffer) -> NlpposaveragedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_averaged_buffer_copy(s : NlpposaveragedBuffer) -> NlpposaveragedBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_buffer_fill(s : NlpposaveragedBuffer, v : Double) -> NlpposaveragedBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_buffer_min(s : NlpposaveragedBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_averaged_buffer_max(s : NlpposaveragedBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_averaged_buffer_to_string(s : NlpposaveragedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_cursor_make(size : Int) -> NlpposaveragedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_cursor_len(s : NlpposaveragedCursor) -> Int { s.size }

pub fn nlp_pos_averaged_cursor_get(s : NlpposaveragedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_cursor_set(s : NlpposaveragedCursor, i : Int, v : Double) -> NlpposaveragedCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_cursor_sum(s : NlpposaveragedCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_averaged_cursor_mean(s : NlpposaveragedCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_averaged_cursor_scale(s : NlpposaveragedCursor, f : Double) -> NlpposaveragedCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_cursor_add(a : NlpposaveragedCursor, b : NlpposaveragedCursor) -> NlpposaveragedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_averaged_cursor_copy(s : NlpposaveragedCursor) -> NlpposaveragedCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_cursor_fill(s : NlpposaveragedCursor, v : Double) -> NlpposaveragedCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_cursor_min(s : NlpposaveragedCursor) -> Double { @_common.min(s.data) }

pub fn nlp_pos_averaged_cursor_max(s : NlpposaveragedCursor) -> Double { @_common.max(s.data) }

pub fn nlp_pos_averaged_cursor_to_string(s : NlpposaveragedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_view_make(size : Int) -> NlpposaveragedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_view_len(s : NlpposaveragedView) -> Int { s.size }

pub fn nlp_pos_averaged_view_get(s : NlpposaveragedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_view_set(s : NlpposaveragedView, i : Int, v : Double) -> NlpposaveragedView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_view_sum(s : NlpposaveragedView) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_averaged_view_mean(s : NlpposaveragedView) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_averaged_view_scale(s : NlpposaveragedView, f : Double) -> NlpposaveragedView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_view_add(a : NlpposaveragedView, b : NlpposaveragedView) -> NlpposaveragedView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_averaged_view_copy(s : NlpposaveragedView) -> NlpposaveragedView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_view_fill(s : NlpposaveragedView, v : Double) -> NlpposaveragedView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_view_min(s : NlpposaveragedView) -> Double { @_common.min(s.data) }

pub fn nlp_pos_averaged_view_max(s : NlpposaveragedView) -> Double { @_common.max(s.data) }

pub fn nlp_pos_averaged_view_to_string(s : NlpposaveragedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_range_make(size : Int) -> NlpposaveragedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_range_len(s : NlpposaveragedRange) -> Int { s.size }

pub fn nlp_pos_averaged_range_get(s : NlpposaveragedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_range_set(s : NlpposaveragedRange, i : Int, v : Double) -> NlpposaveragedRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_range_sum(s : NlpposaveragedRange) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_averaged_range_mean(s : NlpposaveragedRange) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_averaged_range_scale(s : NlpposaveragedRange, f : Double) -> NlpposaveragedRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_range_add(a : NlpposaveragedRange, b : NlpposaveragedRange) -> NlpposaveragedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_averaged_range_copy(s : NlpposaveragedRange) -> NlpposaveragedRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_range_fill(s : NlpposaveragedRange, v : Double) -> NlpposaveragedRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_range_min(s : NlpposaveragedRange) -> Double { @_common.min(s.data) }

pub fn nlp_pos_averaged_range_max(s : NlpposaveragedRange) -> Double { @_common.max(s.data) }

pub fn nlp_pos_averaged_range_to_string(s : NlpposaveragedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposaveragedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_averaged_slice_make(size : Int) -> NlpposaveragedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_averaged_slice_len(s : NlpposaveragedSlice) -> Int { s.size }

pub fn nlp_pos_averaged_slice_get(s : NlpposaveragedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_averaged_slice_set(s : NlpposaveragedSlice, i : Int, v : Double) -> NlpposaveragedSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_slice_sum(s : NlpposaveragedSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_averaged_slice_mean(s : NlpposaveragedSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_averaged_slice_scale(s : NlpposaveragedSlice, f : Double) -> NlpposaveragedSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_slice_add(a : NlpposaveragedSlice, b : NlpposaveragedSlice) -> NlpposaveragedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_averaged_slice_copy(s : NlpposaveragedSlice) -> NlpposaveragedSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_slice_fill(s : NlpposaveragedSlice, v : Double) -> NlpposaveragedSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_averaged_slice_min(s : NlpposaveragedSlice) -> Double { @_common.min(s.data) }

pub fn nlp_pos_averaged_slice_max(s : NlpposaveragedSlice) -> Double { @_common.max(s.data) }

pub fn nlp_pos_averaged_slice_to_string(s : NlpposaveragedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

