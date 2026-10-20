///===
/// extcore/nlp_pos_crf

pub(all) struct NlpposcrfPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_crf_make_point(x : Double, y : Double) -> NlpposcrfPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_crf_make_point3(x : Double, y : Double, z : Double) -> NlpposcrfPoint {
  { x, y, z, label: 0 }
}

pub fn NlpposcrfPoint::x(self : NlpposcrfPoint) -> Double { self.x }

pub fn NlpposcrfPoint::y(self : NlpposcrfPoint) -> Double { self.y }

pub fn NlpposcrfPoint::z(self : NlpposcrfPoint) -> Double { self.z }

pub fn NlpposcrfPoint::label(self : NlpposcrfPoint) -> Int { self.label }

pub fn NlpposcrfPoint::dist(self : NlpposcrfPoint, other : NlpposcrfPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpposcrfPoint::add(self : NlpposcrfPoint, other : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpposcrfPoint::sub(self : NlpposcrfPoint, other : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpposcrfPoint::scale(self : NlpposcrfPoint, s : Double) -> NlpposcrfPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpposcrfPoint::dot(self : NlpposcrfPoint, other : NlpposcrfPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpposcrfPoint::cross(self : NlpposcrfPoint, other : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpposcrfPoint::norm(self : NlpposcrfPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpposcrfPoint::normalize(self : NlpposcrfPoint) -> NlpposcrfPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposcrfPoint::negate(self : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpposcrfPoint::mid(self : NlpposcrfPoint, other : NlpposcrfPoint) -> NlpposcrfPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpposcrfPoint::lerp(self : NlpposcrfPoint, other : NlpposcrfPoint, t : Double) -> NlpposcrfPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpposcrfPoint::to_string(self : NlpposcrfPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpposcrfSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_crf_make_series(vals : Array[Double], name : String) -> NlpposcrfSeries {
  { vals, name, meta: 0 }
}

pub fn NlpposcrfSeries::len(self : NlpposcrfSeries) -> Int { self.vals.length() }

pub fn NlpposcrfSeries::sum(self : NlpposcrfSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpposcrfSeries::mean(self : NlpposcrfSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpposcrfSeries::min(self : NlpposcrfSeries) -> Double { @_common.min(self.vals) }

pub fn NlpposcrfSeries::max(self : NlpposcrfSeries) -> Double { @_common.max(self.vals) }

pub fn NlpposcrfSeries::range(self : NlpposcrfSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpposcrfSeries::variance(self : NlpposcrfSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpposcrfSeries::std(self : NlpposcrfSeries) -> Double { @_common.std(self.vals) }

pub fn NlpposcrfSeries::median(self : NlpposcrfSeries) -> Double { @_common.median(self.vals) }

pub fn NlpposcrfSeries::scale(self : NlpposcrfSeries, f : Double) -> NlpposcrfSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpposcrfSeries::add(self : NlpposcrfSeries, other : NlpposcrfSeries) -> NlpposcrfSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpposcrfSeries::sub(self : NlpposcrfSeries, other : NlpposcrfSeries) -> NlpposcrfSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpposcrfSeries::normalize(self : NlpposcrfSeries) -> NlpposcrfSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpposcrfSeries::cumsum(self : NlpposcrfSeries) -> NlpposcrfSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpposcrfSeries::to_string(self : NlpposcrfSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposcrfMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_crf_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposcrfMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_crf_matrix_identity(n : Int) -> NlpposcrfMatrix {
  let m = nlp_pos_crf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpposcrfMatrix::get(self : NlpposcrfMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpposcrfMatrix::transpose(self : NlpposcrfMatrix) -> NlpposcrfMatrix {
  let result = nlp_pos_crf_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpposcrfMatrix::add(self : NlpposcrfMatrix, other : NlpposcrfMatrix) -> NlpposcrfMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_crf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpposcrfMatrix::scale(self : NlpposcrfMatrix, s : Double) -> NlpposcrfMatrix {
  let result = nlp_pos_crf_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpposcrfMatrix::multiply(self : NlpposcrfMatrix, other : NlpposcrfMatrix) -> NlpposcrfMatrix {
  if self.cols != other.rows { return nlp_pos_crf_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_crf_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpposcrfMatrix::trace(self : NlpposcrfMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpposcrfMatrix::det(self : NlpposcrfMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpposcrfMatrix::norm(self : NlpposcrfMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpposcrfMatrix::to_string(self : NlpposcrfMatrix) -> String {
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

pub(all) struct NlpposcrfVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_crf_make_vector(comps : Array[Double]) -> NlpposcrfVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_crf_vector_zero(dim : Int) -> NlpposcrfVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpposcrfVector::add(self : NlpposcrfVector, other : NlpposcrfVector) -> NlpposcrfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposcrfVector::sub(self : NlpposcrfVector, other : NlpposcrfVector) -> NlpposcrfVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposcrfVector::scale(self : NlpposcrfVector, s : Double) -> NlpposcrfVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpposcrfVector::dot(self : NlpposcrfVector, other : NlpposcrfVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpposcrfVector::norm(self : NlpposcrfVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpposcrfVector::normalize(self : NlpposcrfVector) -> NlpposcrfVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposcrfVector::dist(self : NlpposcrfVector, other : NlpposcrfVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpposcrfVector::to_string(self : NlpposcrfVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_crf_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_crf_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_crf_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_crf_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_crf_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_crf_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_crf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_crf_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_crf_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_crf_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_crf_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_crf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_crf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_crf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_crf_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_crf_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_crf_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_crf_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_crf_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_crf_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_crf_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_crf_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_crf_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_crf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_crf_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_crf_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_crf_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_crf_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_crf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpposcrfFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_frame_make(size : Int) -> NlpposcrfFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_frame_len(s : NlpposcrfFrame) -> Int { s.size }

pub fn nlp_pos_crf_frame_get(s : NlpposcrfFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_frame_set(s : NlpposcrfFrame, i : Int, v : Double) -> NlpposcrfFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_frame_sum(s : NlpposcrfFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_crf_frame_mean(s : NlpposcrfFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_crf_frame_scale(s : NlpposcrfFrame, f : Double) -> NlpposcrfFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_frame_add(a : NlpposcrfFrame, b : NlpposcrfFrame) -> NlpposcrfFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_crf_frame_copy(s : NlpposcrfFrame) -> NlpposcrfFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_frame_fill(s : NlpposcrfFrame, v : Double) -> NlpposcrfFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_frame_min(s : NlpposcrfFrame) -> Double { @_common.min(s.data) }

pub fn nlp_pos_crf_frame_max(s : NlpposcrfFrame) -> Double { @_common.max(s.data) }

pub fn nlp_pos_crf_frame_to_string(s : NlpposcrfFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_table_make(size : Int) -> NlpposcrfTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_table_len(s : NlpposcrfTable) -> Int { s.size }

pub fn nlp_pos_crf_table_get(s : NlpposcrfTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_table_set(s : NlpposcrfTable, i : Int, v : Double) -> NlpposcrfTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_table_sum(s : NlpposcrfTable) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_crf_table_mean(s : NlpposcrfTable) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_crf_table_scale(s : NlpposcrfTable, f : Double) -> NlpposcrfTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_table_add(a : NlpposcrfTable, b : NlpposcrfTable) -> NlpposcrfTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_crf_table_copy(s : NlpposcrfTable) -> NlpposcrfTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_table_fill(s : NlpposcrfTable, v : Double) -> NlpposcrfTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_table_min(s : NlpposcrfTable) -> Double { @_common.min(s.data) }

pub fn nlp_pos_crf_table_max(s : NlpposcrfTable) -> Double { @_common.max(s.data) }

pub fn nlp_pos_crf_table_to_string(s : NlpposcrfTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_graphn_make(size : Int) -> NlpposcrfGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_graphn_len(s : NlpposcrfGraphN) -> Int { s.size }

pub fn nlp_pos_crf_graphn_get(s : NlpposcrfGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_graphn_set(s : NlpposcrfGraphN, i : Int, v : Double) -> NlpposcrfGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_graphn_sum(s : NlpposcrfGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_crf_graphn_mean(s : NlpposcrfGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_crf_graphn_scale(s : NlpposcrfGraphN, f : Double) -> NlpposcrfGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_graphn_add(a : NlpposcrfGraphN, b : NlpposcrfGraphN) -> NlpposcrfGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_crf_graphn_copy(s : NlpposcrfGraphN) -> NlpposcrfGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_graphn_fill(s : NlpposcrfGraphN, v : Double) -> NlpposcrfGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_graphn_min(s : NlpposcrfGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_pos_crf_graphn_max(s : NlpposcrfGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_pos_crf_graphn_to_string(s : NlpposcrfGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_node_make(size : Int) -> NlpposcrfNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_node_len(s : NlpposcrfNode) -> Int { s.size }

pub fn nlp_pos_crf_node_get(s : NlpposcrfNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_node_set(s : NlpposcrfNode, i : Int, v : Double) -> NlpposcrfNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_node_sum(s : NlpposcrfNode) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_crf_node_mean(s : NlpposcrfNode) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_crf_node_scale(s : NlpposcrfNode, f : Double) -> NlpposcrfNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_node_add(a : NlpposcrfNode, b : NlpposcrfNode) -> NlpposcrfNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_crf_node_copy(s : NlpposcrfNode) -> NlpposcrfNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_node_fill(s : NlpposcrfNode, v : Double) -> NlpposcrfNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_node_min(s : NlpposcrfNode) -> Double { @_common.min(s.data) }

pub fn nlp_pos_crf_node_max(s : NlpposcrfNode) -> Double { @_common.max(s.data) }

pub fn nlp_pos_crf_node_to_string(s : NlpposcrfNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_edge_make(size : Int) -> NlpposcrfEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_edge_len(s : NlpposcrfEdge) -> Int { s.size }

pub fn nlp_pos_crf_edge_get(s : NlpposcrfEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_edge_set(s : NlpposcrfEdge, i : Int, v : Double) -> NlpposcrfEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_edge_sum(s : NlpposcrfEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_crf_edge_mean(s : NlpposcrfEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_crf_edge_scale(s : NlpposcrfEdge, f : Double) -> NlpposcrfEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_edge_add(a : NlpposcrfEdge, b : NlpposcrfEdge) -> NlpposcrfEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_crf_edge_copy(s : NlpposcrfEdge) -> NlpposcrfEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_edge_fill(s : NlpposcrfEdge, v : Double) -> NlpposcrfEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_edge_min(s : NlpposcrfEdge) -> Double { @_common.min(s.data) }

pub fn nlp_pos_crf_edge_max(s : NlpposcrfEdge) -> Double { @_common.max(s.data) }

pub fn nlp_pos_crf_edge_to_string(s : NlpposcrfEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_path_make(size : Int) -> NlpposcrfPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_path_len(s : NlpposcrfPath) -> Int { s.size }

pub fn nlp_pos_crf_path_get(s : NlpposcrfPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_path_set(s : NlpposcrfPath, i : Int, v : Double) -> NlpposcrfPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_path_sum(s : NlpposcrfPath) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_crf_path_mean(s : NlpposcrfPath) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_crf_path_scale(s : NlpposcrfPath, f : Double) -> NlpposcrfPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_path_add(a : NlpposcrfPath, b : NlpposcrfPath) -> NlpposcrfPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_crf_path_copy(s : NlpposcrfPath) -> NlpposcrfPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_path_fill(s : NlpposcrfPath, v : Double) -> NlpposcrfPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_path_min(s : NlpposcrfPath) -> Double { @_common.min(s.data) }

pub fn nlp_pos_crf_path_max(s : NlpposcrfPath) -> Double { @_common.max(s.data) }

pub fn nlp_pos_crf_path_to_string(s : NlpposcrfPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_cluster_make(size : Int) -> NlpposcrfCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_cluster_len(s : NlpposcrfCluster) -> Int { s.size }

pub fn nlp_pos_crf_cluster_get(s : NlpposcrfCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_cluster_set(s : NlpposcrfCluster, i : Int, v : Double) -> NlpposcrfCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_cluster_sum(s : NlpposcrfCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_crf_cluster_mean(s : NlpposcrfCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_crf_cluster_scale(s : NlpposcrfCluster, f : Double) -> NlpposcrfCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_cluster_add(a : NlpposcrfCluster, b : NlpposcrfCluster) -> NlpposcrfCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_crf_cluster_copy(s : NlpposcrfCluster) -> NlpposcrfCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_cluster_fill(s : NlpposcrfCluster, v : Double) -> NlpposcrfCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_cluster_min(s : NlpposcrfCluster) -> Double { @_common.min(s.data) }

pub fn nlp_pos_crf_cluster_max(s : NlpposcrfCluster) -> Double { @_common.max(s.data) }

pub fn nlp_pos_crf_cluster_to_string(s : NlpposcrfCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_model_make(size : Int) -> NlpposcrfModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_model_len(s : NlpposcrfModel) -> Int { s.size }

pub fn nlp_pos_crf_model_get(s : NlpposcrfModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_model_set(s : NlpposcrfModel, i : Int, v : Double) -> NlpposcrfModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_model_sum(s : NlpposcrfModel) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_crf_model_mean(s : NlpposcrfModel) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_crf_model_scale(s : NlpposcrfModel, f : Double) -> NlpposcrfModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_model_add(a : NlpposcrfModel, b : NlpposcrfModel) -> NlpposcrfModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_crf_model_copy(s : NlpposcrfModel) -> NlpposcrfModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_model_fill(s : NlpposcrfModel, v : Double) -> NlpposcrfModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_model_min(s : NlpposcrfModel) -> Double { @_common.min(s.data) }

pub fn nlp_pos_crf_model_max(s : NlpposcrfModel) -> Double { @_common.max(s.data) }

pub fn nlp_pos_crf_model_to_string(s : NlpposcrfModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_layer_make(size : Int) -> NlpposcrfLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_layer_len(s : NlpposcrfLayer) -> Int { s.size }

pub fn nlp_pos_crf_layer_get(s : NlpposcrfLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_layer_set(s : NlpposcrfLayer, i : Int, v : Double) -> NlpposcrfLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_layer_sum(s : NlpposcrfLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_crf_layer_mean(s : NlpposcrfLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_crf_layer_scale(s : NlpposcrfLayer, f : Double) -> NlpposcrfLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_layer_add(a : NlpposcrfLayer, b : NlpposcrfLayer) -> NlpposcrfLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_crf_layer_copy(s : NlpposcrfLayer) -> NlpposcrfLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_layer_fill(s : NlpposcrfLayer, v : Double) -> NlpposcrfLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_layer_min(s : NlpposcrfLayer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_crf_layer_max(s : NlpposcrfLayer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_crf_layer_to_string(s : NlpposcrfLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_buffer_make(size : Int) -> NlpposcrfBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_buffer_len(s : NlpposcrfBuffer) -> Int { s.size }

pub fn nlp_pos_crf_buffer_get(s : NlpposcrfBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_buffer_set(s : NlpposcrfBuffer, i : Int, v : Double) -> NlpposcrfBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_buffer_sum(s : NlpposcrfBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_crf_buffer_mean(s : NlpposcrfBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_crf_buffer_scale(s : NlpposcrfBuffer, f : Double) -> NlpposcrfBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_buffer_add(a : NlpposcrfBuffer, b : NlpposcrfBuffer) -> NlpposcrfBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_crf_buffer_copy(s : NlpposcrfBuffer) -> NlpposcrfBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_buffer_fill(s : NlpposcrfBuffer, v : Double) -> NlpposcrfBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_buffer_min(s : NlpposcrfBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_crf_buffer_max(s : NlpposcrfBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_crf_buffer_to_string(s : NlpposcrfBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_cursor_make(size : Int) -> NlpposcrfCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_cursor_len(s : NlpposcrfCursor) -> Int { s.size }

pub fn nlp_pos_crf_cursor_get(s : NlpposcrfCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_cursor_set(s : NlpposcrfCursor, i : Int, v : Double) -> NlpposcrfCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_cursor_sum(s : NlpposcrfCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_crf_cursor_mean(s : NlpposcrfCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_crf_cursor_scale(s : NlpposcrfCursor, f : Double) -> NlpposcrfCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_cursor_add(a : NlpposcrfCursor, b : NlpposcrfCursor) -> NlpposcrfCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_crf_cursor_copy(s : NlpposcrfCursor) -> NlpposcrfCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_cursor_fill(s : NlpposcrfCursor, v : Double) -> NlpposcrfCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_cursor_min(s : NlpposcrfCursor) -> Double { @_common.min(s.data) }

pub fn nlp_pos_crf_cursor_max(s : NlpposcrfCursor) -> Double { @_common.max(s.data) }

pub fn nlp_pos_crf_cursor_to_string(s : NlpposcrfCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_view_make(size : Int) -> NlpposcrfView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_view_len(s : NlpposcrfView) -> Int { s.size }

pub fn nlp_pos_crf_view_get(s : NlpposcrfView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_view_set(s : NlpposcrfView, i : Int, v : Double) -> NlpposcrfView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_view_sum(s : NlpposcrfView) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_crf_view_mean(s : NlpposcrfView) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_crf_view_scale(s : NlpposcrfView, f : Double) -> NlpposcrfView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_view_add(a : NlpposcrfView, b : NlpposcrfView) -> NlpposcrfView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_crf_view_copy(s : NlpposcrfView) -> NlpposcrfView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_view_fill(s : NlpposcrfView, v : Double) -> NlpposcrfView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_view_min(s : NlpposcrfView) -> Double { @_common.min(s.data) }

pub fn nlp_pos_crf_view_max(s : NlpposcrfView) -> Double { @_common.max(s.data) }

pub fn nlp_pos_crf_view_to_string(s : NlpposcrfView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_range_make(size : Int) -> NlpposcrfRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_range_len(s : NlpposcrfRange) -> Int { s.size }

pub fn nlp_pos_crf_range_get(s : NlpposcrfRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_range_set(s : NlpposcrfRange, i : Int, v : Double) -> NlpposcrfRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_range_sum(s : NlpposcrfRange) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_crf_range_mean(s : NlpposcrfRange) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_crf_range_scale(s : NlpposcrfRange, f : Double) -> NlpposcrfRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_range_add(a : NlpposcrfRange, b : NlpposcrfRange) -> NlpposcrfRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_crf_range_copy(s : NlpposcrfRange) -> NlpposcrfRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_range_fill(s : NlpposcrfRange, v : Double) -> NlpposcrfRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_range_min(s : NlpposcrfRange) -> Double { @_common.min(s.data) }

pub fn nlp_pos_crf_range_max(s : NlpposcrfRange) -> Double { @_common.max(s.data) }

pub fn nlp_pos_crf_range_to_string(s : NlpposcrfRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpposcrfSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_crf_slice_make(size : Int) -> NlpposcrfSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_crf_slice_len(s : NlpposcrfSlice) -> Int { s.size }

pub fn nlp_pos_crf_slice_get(s : NlpposcrfSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_crf_slice_set(s : NlpposcrfSlice, i : Int, v : Double) -> NlpposcrfSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_slice_sum(s : NlpposcrfSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_crf_slice_mean(s : NlpposcrfSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_crf_slice_scale(s : NlpposcrfSlice, f : Double) -> NlpposcrfSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_slice_add(a : NlpposcrfSlice, b : NlpposcrfSlice) -> NlpposcrfSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_crf_slice_copy(s : NlpposcrfSlice) -> NlpposcrfSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_slice_fill(s : NlpposcrfSlice, v : Double) -> NlpposcrfSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_crf_slice_min(s : NlpposcrfSlice) -> Double { @_common.min(s.data) }

pub fn nlp_pos_crf_slice_max(s : NlpposcrfSlice) -> Double { @_common.max(s.data) }

pub fn nlp_pos_crf_slice_to_string(s : NlpposcrfSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

