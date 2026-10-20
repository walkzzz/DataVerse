///===
/// extcore/nlp_embed_elmo

pub(all) struct NlpembedelmoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_elmo_make_point(x : Double, y : Double) -> NlpembedelmoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_elmo_make_point3(x : Double, y : Double, z : Double) -> NlpembedelmoPoint {
  { x, y, z, label: 0 }
}

pub fn NlpembedelmoPoint::x(self : NlpembedelmoPoint) -> Double { self.x }

pub fn NlpembedelmoPoint::y(self : NlpembedelmoPoint) -> Double { self.y }

pub fn NlpembedelmoPoint::z(self : NlpembedelmoPoint) -> Double { self.z }

pub fn NlpembedelmoPoint::label(self : NlpembedelmoPoint) -> Int { self.label }

pub fn NlpembedelmoPoint::dist(self : NlpembedelmoPoint, other : NlpembedelmoPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpembedelmoPoint::add(self : NlpembedelmoPoint, other : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpembedelmoPoint::sub(self : NlpembedelmoPoint, other : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpembedelmoPoint::scale(self : NlpembedelmoPoint, s : Double) -> NlpembedelmoPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpembedelmoPoint::dot(self : NlpembedelmoPoint, other : NlpembedelmoPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpembedelmoPoint::cross(self : NlpembedelmoPoint, other : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpembedelmoPoint::norm(self : NlpembedelmoPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpembedelmoPoint::normalize(self : NlpembedelmoPoint) -> NlpembedelmoPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedelmoPoint::negate(self : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpembedelmoPoint::mid(self : NlpembedelmoPoint, other : NlpembedelmoPoint) -> NlpembedelmoPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpembedelmoPoint::lerp(self : NlpembedelmoPoint, other : NlpembedelmoPoint, t : Double) -> NlpembedelmoPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpembedelmoPoint::to_string(self : NlpembedelmoPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpembedelmoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_elmo_make_series(vals : Array[Double], name : String) -> NlpembedelmoSeries {
  { vals, name, meta: 0 }
}

pub fn NlpembedelmoSeries::len(self : NlpembedelmoSeries) -> Int { self.vals.length() }

pub fn NlpembedelmoSeries::sum(self : NlpembedelmoSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpembedelmoSeries::mean(self : NlpembedelmoSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpembedelmoSeries::min(self : NlpembedelmoSeries) -> Double { @_common.min(self.vals) }

pub fn NlpembedelmoSeries::max(self : NlpembedelmoSeries) -> Double { @_common.max(self.vals) }

pub fn NlpembedelmoSeries::range(self : NlpembedelmoSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpembedelmoSeries::variance(self : NlpembedelmoSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpembedelmoSeries::std(self : NlpembedelmoSeries) -> Double { @_common.std(self.vals) }

pub fn NlpembedelmoSeries::median(self : NlpembedelmoSeries) -> Double { @_common.median(self.vals) }

pub fn NlpembedelmoSeries::scale(self : NlpembedelmoSeries, f : Double) -> NlpembedelmoSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpembedelmoSeries::add(self : NlpembedelmoSeries, other : NlpembedelmoSeries) -> NlpembedelmoSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpembedelmoSeries::sub(self : NlpembedelmoSeries, other : NlpembedelmoSeries) -> NlpembedelmoSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpembedelmoSeries::normalize(self : NlpembedelmoSeries) -> NlpembedelmoSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpembedelmoSeries::cumsum(self : NlpembedelmoSeries) -> NlpembedelmoSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpembedelmoSeries::to_string(self : NlpembedelmoSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedelmoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_elmo_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedelmoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_elmo_matrix_identity(n : Int) -> NlpembedelmoMatrix {
  let m = nlp_embed_elmo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpembedelmoMatrix::get(self : NlpembedelmoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpembedelmoMatrix::transpose(self : NlpembedelmoMatrix) -> NlpembedelmoMatrix {
  let result = nlp_embed_elmo_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpembedelmoMatrix::add(self : NlpembedelmoMatrix, other : NlpembedelmoMatrix) -> NlpembedelmoMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_elmo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpembedelmoMatrix::scale(self : NlpembedelmoMatrix, s : Double) -> NlpembedelmoMatrix {
  let result = nlp_embed_elmo_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpembedelmoMatrix::multiply(self : NlpembedelmoMatrix, other : NlpembedelmoMatrix) -> NlpembedelmoMatrix {
  if self.cols != other.rows { return nlp_embed_elmo_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_elmo_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpembedelmoMatrix::trace(self : NlpembedelmoMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpembedelmoMatrix::det(self : NlpembedelmoMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpembedelmoMatrix::norm(self : NlpembedelmoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpembedelmoMatrix::to_string(self : NlpembedelmoMatrix) -> String {
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

pub(all) struct NlpembedelmoVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_elmo_make_vector(comps : Array[Double]) -> NlpembedelmoVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_elmo_vector_zero(dim : Int) -> NlpembedelmoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpembedelmoVector::add(self : NlpembedelmoVector, other : NlpembedelmoVector) -> NlpembedelmoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedelmoVector::sub(self : NlpembedelmoVector, other : NlpembedelmoVector) -> NlpembedelmoVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedelmoVector::scale(self : NlpembedelmoVector, s : Double) -> NlpembedelmoVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpembedelmoVector::dot(self : NlpembedelmoVector, other : NlpembedelmoVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpembedelmoVector::norm(self : NlpembedelmoVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpembedelmoVector::normalize(self : NlpembedelmoVector) -> NlpembedelmoVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedelmoVector::dist(self : NlpembedelmoVector, other : NlpembedelmoVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpembedelmoVector::to_string(self : NlpembedelmoVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_elmo_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_elmo_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_elmo_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_elmo_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_elmo_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_elmo_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_elmo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_elmo_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_elmo_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_elmo_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_elmo_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_elmo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_elmo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_elmo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_elmo_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_elmo_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_elmo_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_elmo_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_elmo_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_elmo_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_elmo_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_elmo_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_elmo_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_elmo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_elmo_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_elmo_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_elmo_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_elmo_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_elmo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpembedelmoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_frame_make(size : Int) -> NlpembedelmoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_frame_len(s : NlpembedelmoFrame) -> Int { s.size }

pub fn nlp_embed_elmo_frame_get(s : NlpembedelmoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_frame_set(s : NlpembedelmoFrame, i : Int, v : Double) -> NlpembedelmoFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_frame_sum(s : NlpembedelmoFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_frame_mean(s : NlpembedelmoFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_frame_scale(s : NlpembedelmoFrame, f : Double) -> NlpembedelmoFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_frame_add(a : NlpembedelmoFrame, b : NlpembedelmoFrame) -> NlpembedelmoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_elmo_frame_copy(s : NlpembedelmoFrame) -> NlpembedelmoFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_frame_fill(s : NlpembedelmoFrame, v : Double) -> NlpembedelmoFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_frame_min(s : NlpembedelmoFrame) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_frame_max(s : NlpembedelmoFrame) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_frame_to_string(s : NlpembedelmoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_table_make(size : Int) -> NlpembedelmoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_table_len(s : NlpembedelmoTable) -> Int { s.size }

pub fn nlp_embed_elmo_table_get(s : NlpembedelmoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_table_set(s : NlpembedelmoTable, i : Int, v : Double) -> NlpembedelmoTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_table_sum(s : NlpembedelmoTable) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_table_mean(s : NlpembedelmoTable) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_table_scale(s : NlpembedelmoTable, f : Double) -> NlpembedelmoTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_table_add(a : NlpembedelmoTable, b : NlpembedelmoTable) -> NlpembedelmoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_elmo_table_copy(s : NlpembedelmoTable) -> NlpembedelmoTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_table_fill(s : NlpembedelmoTable, v : Double) -> NlpembedelmoTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_table_min(s : NlpembedelmoTable) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_table_max(s : NlpembedelmoTable) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_table_to_string(s : NlpembedelmoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_graphn_make(size : Int) -> NlpembedelmoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_graphn_len(s : NlpembedelmoGraphN) -> Int { s.size }

pub fn nlp_embed_elmo_graphn_get(s : NlpembedelmoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_graphn_set(s : NlpembedelmoGraphN, i : Int, v : Double) -> NlpembedelmoGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_graphn_sum(s : NlpembedelmoGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_graphn_mean(s : NlpembedelmoGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_graphn_scale(s : NlpembedelmoGraphN, f : Double) -> NlpembedelmoGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_graphn_add(a : NlpembedelmoGraphN, b : NlpembedelmoGraphN) -> NlpembedelmoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_elmo_graphn_copy(s : NlpembedelmoGraphN) -> NlpembedelmoGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_graphn_fill(s : NlpembedelmoGraphN, v : Double) -> NlpembedelmoGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_graphn_min(s : NlpembedelmoGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_graphn_max(s : NlpembedelmoGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_graphn_to_string(s : NlpembedelmoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_node_make(size : Int) -> NlpembedelmoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_node_len(s : NlpembedelmoNode) -> Int { s.size }

pub fn nlp_embed_elmo_node_get(s : NlpembedelmoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_node_set(s : NlpembedelmoNode, i : Int, v : Double) -> NlpembedelmoNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_node_sum(s : NlpembedelmoNode) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_node_mean(s : NlpembedelmoNode) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_node_scale(s : NlpembedelmoNode, f : Double) -> NlpembedelmoNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_node_add(a : NlpembedelmoNode, b : NlpembedelmoNode) -> NlpembedelmoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_elmo_node_copy(s : NlpembedelmoNode) -> NlpembedelmoNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_node_fill(s : NlpembedelmoNode, v : Double) -> NlpembedelmoNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_node_min(s : NlpembedelmoNode) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_node_max(s : NlpembedelmoNode) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_node_to_string(s : NlpembedelmoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_edge_make(size : Int) -> NlpembedelmoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_edge_len(s : NlpembedelmoEdge) -> Int { s.size }

pub fn nlp_embed_elmo_edge_get(s : NlpembedelmoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_edge_set(s : NlpembedelmoEdge, i : Int, v : Double) -> NlpembedelmoEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_edge_sum(s : NlpembedelmoEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_edge_mean(s : NlpembedelmoEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_edge_scale(s : NlpembedelmoEdge, f : Double) -> NlpembedelmoEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_edge_add(a : NlpembedelmoEdge, b : NlpembedelmoEdge) -> NlpembedelmoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_elmo_edge_copy(s : NlpembedelmoEdge) -> NlpembedelmoEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_edge_fill(s : NlpembedelmoEdge, v : Double) -> NlpembedelmoEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_edge_min(s : NlpembedelmoEdge) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_edge_max(s : NlpembedelmoEdge) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_edge_to_string(s : NlpembedelmoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_path_make(size : Int) -> NlpembedelmoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_path_len(s : NlpembedelmoPath) -> Int { s.size }

pub fn nlp_embed_elmo_path_get(s : NlpembedelmoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_path_set(s : NlpembedelmoPath, i : Int, v : Double) -> NlpembedelmoPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_path_sum(s : NlpembedelmoPath) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_path_mean(s : NlpembedelmoPath) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_path_scale(s : NlpembedelmoPath, f : Double) -> NlpembedelmoPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_path_add(a : NlpembedelmoPath, b : NlpembedelmoPath) -> NlpembedelmoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_elmo_path_copy(s : NlpembedelmoPath) -> NlpembedelmoPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_path_fill(s : NlpembedelmoPath, v : Double) -> NlpembedelmoPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_path_min(s : NlpembedelmoPath) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_path_max(s : NlpembedelmoPath) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_path_to_string(s : NlpembedelmoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_cluster_make(size : Int) -> NlpembedelmoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_cluster_len(s : NlpembedelmoCluster) -> Int { s.size }

pub fn nlp_embed_elmo_cluster_get(s : NlpembedelmoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_cluster_set(s : NlpembedelmoCluster, i : Int, v : Double) -> NlpembedelmoCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_cluster_sum(s : NlpembedelmoCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_cluster_mean(s : NlpembedelmoCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_cluster_scale(s : NlpembedelmoCluster, f : Double) -> NlpembedelmoCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_cluster_add(a : NlpembedelmoCluster, b : NlpembedelmoCluster) -> NlpembedelmoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_elmo_cluster_copy(s : NlpembedelmoCluster) -> NlpembedelmoCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_cluster_fill(s : NlpembedelmoCluster, v : Double) -> NlpembedelmoCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_cluster_min(s : NlpembedelmoCluster) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_cluster_max(s : NlpembedelmoCluster) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_cluster_to_string(s : NlpembedelmoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_model_make(size : Int) -> NlpembedelmoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_model_len(s : NlpembedelmoModel) -> Int { s.size }

pub fn nlp_embed_elmo_model_get(s : NlpembedelmoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_model_set(s : NlpembedelmoModel, i : Int, v : Double) -> NlpembedelmoModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_model_sum(s : NlpembedelmoModel) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_model_mean(s : NlpembedelmoModel) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_model_scale(s : NlpembedelmoModel, f : Double) -> NlpembedelmoModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_model_add(a : NlpembedelmoModel, b : NlpembedelmoModel) -> NlpembedelmoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_elmo_model_copy(s : NlpembedelmoModel) -> NlpembedelmoModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_model_fill(s : NlpembedelmoModel, v : Double) -> NlpembedelmoModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_model_min(s : NlpembedelmoModel) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_model_max(s : NlpembedelmoModel) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_model_to_string(s : NlpembedelmoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_layer_make(size : Int) -> NlpembedelmoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_layer_len(s : NlpembedelmoLayer) -> Int { s.size }

pub fn nlp_embed_elmo_layer_get(s : NlpembedelmoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_layer_set(s : NlpembedelmoLayer, i : Int, v : Double) -> NlpembedelmoLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_layer_sum(s : NlpembedelmoLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_layer_mean(s : NlpembedelmoLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_layer_scale(s : NlpembedelmoLayer, f : Double) -> NlpembedelmoLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_layer_add(a : NlpembedelmoLayer, b : NlpembedelmoLayer) -> NlpembedelmoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_elmo_layer_copy(s : NlpembedelmoLayer) -> NlpembedelmoLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_layer_fill(s : NlpembedelmoLayer, v : Double) -> NlpembedelmoLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_layer_min(s : NlpembedelmoLayer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_layer_max(s : NlpembedelmoLayer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_layer_to_string(s : NlpembedelmoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_buffer_make(size : Int) -> NlpembedelmoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_buffer_len(s : NlpembedelmoBuffer) -> Int { s.size }

pub fn nlp_embed_elmo_buffer_get(s : NlpembedelmoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_buffer_set(s : NlpembedelmoBuffer, i : Int, v : Double) -> NlpembedelmoBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_buffer_sum(s : NlpembedelmoBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_buffer_mean(s : NlpembedelmoBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_buffer_scale(s : NlpembedelmoBuffer, f : Double) -> NlpembedelmoBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_buffer_add(a : NlpembedelmoBuffer, b : NlpembedelmoBuffer) -> NlpembedelmoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_elmo_buffer_copy(s : NlpembedelmoBuffer) -> NlpembedelmoBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_buffer_fill(s : NlpembedelmoBuffer, v : Double) -> NlpembedelmoBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_buffer_min(s : NlpembedelmoBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_buffer_max(s : NlpembedelmoBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_buffer_to_string(s : NlpembedelmoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_cursor_make(size : Int) -> NlpembedelmoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_cursor_len(s : NlpembedelmoCursor) -> Int { s.size }

pub fn nlp_embed_elmo_cursor_get(s : NlpembedelmoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_cursor_set(s : NlpembedelmoCursor, i : Int, v : Double) -> NlpembedelmoCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_cursor_sum(s : NlpembedelmoCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_cursor_mean(s : NlpembedelmoCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_cursor_scale(s : NlpembedelmoCursor, f : Double) -> NlpembedelmoCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_cursor_add(a : NlpembedelmoCursor, b : NlpembedelmoCursor) -> NlpembedelmoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_elmo_cursor_copy(s : NlpembedelmoCursor) -> NlpembedelmoCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_cursor_fill(s : NlpembedelmoCursor, v : Double) -> NlpembedelmoCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_cursor_min(s : NlpembedelmoCursor) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_cursor_max(s : NlpembedelmoCursor) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_cursor_to_string(s : NlpembedelmoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_view_make(size : Int) -> NlpembedelmoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_view_len(s : NlpembedelmoView) -> Int { s.size }

pub fn nlp_embed_elmo_view_get(s : NlpembedelmoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_view_set(s : NlpembedelmoView, i : Int, v : Double) -> NlpembedelmoView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_view_sum(s : NlpembedelmoView) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_view_mean(s : NlpembedelmoView) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_view_scale(s : NlpembedelmoView, f : Double) -> NlpembedelmoView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_view_add(a : NlpembedelmoView, b : NlpembedelmoView) -> NlpembedelmoView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_elmo_view_copy(s : NlpembedelmoView) -> NlpembedelmoView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_view_fill(s : NlpembedelmoView, v : Double) -> NlpembedelmoView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_view_min(s : NlpembedelmoView) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_view_max(s : NlpembedelmoView) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_view_to_string(s : NlpembedelmoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_range_make(size : Int) -> NlpembedelmoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_range_len(s : NlpembedelmoRange) -> Int { s.size }

pub fn nlp_embed_elmo_range_get(s : NlpembedelmoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_range_set(s : NlpembedelmoRange, i : Int, v : Double) -> NlpembedelmoRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_range_sum(s : NlpembedelmoRange) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_range_mean(s : NlpembedelmoRange) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_range_scale(s : NlpembedelmoRange, f : Double) -> NlpembedelmoRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_range_add(a : NlpembedelmoRange, b : NlpembedelmoRange) -> NlpembedelmoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_elmo_range_copy(s : NlpembedelmoRange) -> NlpembedelmoRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_range_fill(s : NlpembedelmoRange, v : Double) -> NlpembedelmoRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_range_min(s : NlpembedelmoRange) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_range_max(s : NlpembedelmoRange) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_range_to_string(s : NlpembedelmoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedelmoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_elmo_slice_make(size : Int) -> NlpembedelmoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_elmo_slice_len(s : NlpembedelmoSlice) -> Int { s.size }

pub fn nlp_embed_elmo_slice_get(s : NlpembedelmoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_elmo_slice_set(s : NlpembedelmoSlice, i : Int, v : Double) -> NlpembedelmoSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_slice_sum(s : NlpembedelmoSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_elmo_slice_mean(s : NlpembedelmoSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_elmo_slice_scale(s : NlpembedelmoSlice, f : Double) -> NlpembedelmoSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_slice_add(a : NlpembedelmoSlice, b : NlpembedelmoSlice) -> NlpembedelmoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_elmo_slice_copy(s : NlpembedelmoSlice) -> NlpembedelmoSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_slice_fill(s : NlpembedelmoSlice, v : Double) -> NlpembedelmoSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_elmo_slice_min(s : NlpembedelmoSlice) -> Double { @_common.min(s.data) }

pub fn nlp_embed_elmo_slice_max(s : NlpembedelmoSlice) -> Double { @_common.max(s.data) }

pub fn nlp_embed_elmo_slice_to_string(s : NlpembedelmoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

