///===
/// extcore/nlp_embed_universal

pub(all) struct NlpembeduniversalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_universal_make_point(x : Double, y : Double) -> NlpembeduniversalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_universal_make_point3(x : Double, y : Double, z : Double) -> NlpembeduniversalPoint {
  { x, y, z, label: 0 }
}

pub fn NlpembeduniversalPoint::x(self : NlpembeduniversalPoint) -> Double { self.x }

pub fn NlpembeduniversalPoint::y(self : NlpembeduniversalPoint) -> Double { self.y }

pub fn NlpembeduniversalPoint::z(self : NlpembeduniversalPoint) -> Double { self.z }

pub fn NlpembeduniversalPoint::label(self : NlpembeduniversalPoint) -> Int { self.label }

pub fn NlpembeduniversalPoint::dist(self : NlpembeduniversalPoint, other : NlpembeduniversalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpembeduniversalPoint::add(self : NlpembeduniversalPoint, other : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpembeduniversalPoint::sub(self : NlpembeduniversalPoint, other : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpembeduniversalPoint::scale(self : NlpembeduniversalPoint, s : Double) -> NlpembeduniversalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpembeduniversalPoint::dot(self : NlpembeduniversalPoint, other : NlpembeduniversalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpembeduniversalPoint::cross(self : NlpembeduniversalPoint, other : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpembeduniversalPoint::norm(self : NlpembeduniversalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpembeduniversalPoint::normalize(self : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembeduniversalPoint::negate(self : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpembeduniversalPoint::mid(self : NlpembeduniversalPoint, other : NlpembeduniversalPoint) -> NlpembeduniversalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpembeduniversalPoint::lerp(self : NlpembeduniversalPoint, other : NlpembeduniversalPoint, t : Double) -> NlpembeduniversalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpembeduniversalPoint::to_string(self : NlpembeduniversalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpembeduniversalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_universal_make_series(vals : Array[Double], name : String) -> NlpembeduniversalSeries {
  { vals, name, meta: 0 }
}

pub fn NlpembeduniversalSeries::len(self : NlpembeduniversalSeries) -> Int { self.vals.length() }

pub fn NlpembeduniversalSeries::sum(self : NlpembeduniversalSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpembeduniversalSeries::mean(self : NlpembeduniversalSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpembeduniversalSeries::min(self : NlpembeduniversalSeries) -> Double { @_common.min(self.vals) }

pub fn NlpembeduniversalSeries::max(self : NlpembeduniversalSeries) -> Double { @_common.max(self.vals) }

pub fn NlpembeduniversalSeries::range(self : NlpembeduniversalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpembeduniversalSeries::variance(self : NlpembeduniversalSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpembeduniversalSeries::std(self : NlpembeduniversalSeries) -> Double { @_common.std(self.vals) }

pub fn NlpembeduniversalSeries::median(self : NlpembeduniversalSeries) -> Double { @_common.median(self.vals) }

pub fn NlpembeduniversalSeries::scale(self : NlpembeduniversalSeries, f : Double) -> NlpembeduniversalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpembeduniversalSeries::add(self : NlpembeduniversalSeries, other : NlpembeduniversalSeries) -> NlpembeduniversalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpembeduniversalSeries::sub(self : NlpembeduniversalSeries, other : NlpembeduniversalSeries) -> NlpembeduniversalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpembeduniversalSeries::normalize(self : NlpembeduniversalSeries) -> NlpembeduniversalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpembeduniversalSeries::cumsum(self : NlpembeduniversalSeries) -> NlpembeduniversalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpembeduniversalSeries::to_string(self : NlpembeduniversalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembeduniversalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_universal_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembeduniversalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_universal_matrix_identity(n : Int) -> NlpembeduniversalMatrix {
  let m = nlp_embed_universal_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpembeduniversalMatrix::get(self : NlpembeduniversalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpembeduniversalMatrix::transpose(self : NlpembeduniversalMatrix) -> NlpembeduniversalMatrix {
  let result = nlp_embed_universal_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpembeduniversalMatrix::add(self : NlpembeduniversalMatrix, other : NlpembeduniversalMatrix) -> NlpembeduniversalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_universal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpembeduniversalMatrix::scale(self : NlpembeduniversalMatrix, s : Double) -> NlpembeduniversalMatrix {
  let result = nlp_embed_universal_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpembeduniversalMatrix::multiply(self : NlpembeduniversalMatrix, other : NlpembeduniversalMatrix) -> NlpembeduniversalMatrix {
  if self.cols != other.rows { return nlp_embed_universal_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_universal_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpembeduniversalMatrix::trace(self : NlpembeduniversalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpembeduniversalMatrix::det(self : NlpembeduniversalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpembeduniversalMatrix::norm(self : NlpembeduniversalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpembeduniversalMatrix::to_string(self : NlpembeduniversalMatrix) -> String {
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

pub(all) struct NlpembeduniversalVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_universal_make_vector(comps : Array[Double]) -> NlpembeduniversalVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_universal_vector_zero(dim : Int) -> NlpembeduniversalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpembeduniversalVector::add(self : NlpembeduniversalVector, other : NlpembeduniversalVector) -> NlpembeduniversalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembeduniversalVector::sub(self : NlpembeduniversalVector, other : NlpembeduniversalVector) -> NlpembeduniversalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembeduniversalVector::scale(self : NlpembeduniversalVector, s : Double) -> NlpembeduniversalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpembeduniversalVector::dot(self : NlpembeduniversalVector, other : NlpembeduniversalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpembeduniversalVector::norm(self : NlpembeduniversalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpembeduniversalVector::normalize(self : NlpembeduniversalVector) -> NlpembeduniversalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembeduniversalVector::dist(self : NlpembeduniversalVector, other : NlpembeduniversalVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpembeduniversalVector::to_string(self : NlpembeduniversalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_universal_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_universal_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_universal_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_universal_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_universal_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_universal_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_universal_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_universal_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_universal_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_universal_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_universal_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_universal_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_universal_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_universal_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_universal_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_universal_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_universal_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_universal_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_universal_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_universal_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_universal_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_universal_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_universal_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_universal_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_universal_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_universal_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_universal_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_universal_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_universal_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpembeduniversalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_frame_make(size : Int) -> NlpembeduniversalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_frame_len(s : NlpembeduniversalFrame) -> Int { s.size }

pub fn nlp_embed_universal_frame_get(s : NlpembeduniversalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_frame_set(s : NlpembeduniversalFrame, i : Int, v : Double) -> NlpembeduniversalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_frame_sum(s : NlpembeduniversalFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_universal_frame_mean(s : NlpembeduniversalFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_universal_frame_scale(s : NlpembeduniversalFrame, f : Double) -> NlpembeduniversalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_frame_add(a : NlpembeduniversalFrame, b : NlpembeduniversalFrame) -> NlpembeduniversalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_universal_frame_copy(s : NlpembeduniversalFrame) -> NlpembeduniversalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_frame_fill(s : NlpembeduniversalFrame, v : Double) -> NlpembeduniversalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_frame_min(s : NlpembeduniversalFrame) -> Double { @_common.min(s.data) }

pub fn nlp_embed_universal_frame_max(s : NlpembeduniversalFrame) -> Double { @_common.max(s.data) }

pub fn nlp_embed_universal_frame_to_string(s : NlpembeduniversalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_table_make(size : Int) -> NlpembeduniversalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_table_len(s : NlpembeduniversalTable) -> Int { s.size }

pub fn nlp_embed_universal_table_get(s : NlpembeduniversalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_table_set(s : NlpembeduniversalTable, i : Int, v : Double) -> NlpembeduniversalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_table_sum(s : NlpembeduniversalTable) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_universal_table_mean(s : NlpembeduniversalTable) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_universal_table_scale(s : NlpembeduniversalTable, f : Double) -> NlpembeduniversalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_table_add(a : NlpembeduniversalTable, b : NlpembeduniversalTable) -> NlpembeduniversalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_universal_table_copy(s : NlpembeduniversalTable) -> NlpembeduniversalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_table_fill(s : NlpembeduniversalTable, v : Double) -> NlpembeduniversalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_table_min(s : NlpembeduniversalTable) -> Double { @_common.min(s.data) }

pub fn nlp_embed_universal_table_max(s : NlpembeduniversalTable) -> Double { @_common.max(s.data) }

pub fn nlp_embed_universal_table_to_string(s : NlpembeduniversalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_graphn_make(size : Int) -> NlpembeduniversalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_graphn_len(s : NlpembeduniversalGraphN) -> Int { s.size }

pub fn nlp_embed_universal_graphn_get(s : NlpembeduniversalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_graphn_set(s : NlpembeduniversalGraphN, i : Int, v : Double) -> NlpembeduniversalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_graphn_sum(s : NlpembeduniversalGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_universal_graphn_mean(s : NlpembeduniversalGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_universal_graphn_scale(s : NlpembeduniversalGraphN, f : Double) -> NlpembeduniversalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_graphn_add(a : NlpembeduniversalGraphN, b : NlpembeduniversalGraphN) -> NlpembeduniversalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_universal_graphn_copy(s : NlpembeduniversalGraphN) -> NlpembeduniversalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_graphn_fill(s : NlpembeduniversalGraphN, v : Double) -> NlpembeduniversalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_graphn_min(s : NlpembeduniversalGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_embed_universal_graphn_max(s : NlpembeduniversalGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_embed_universal_graphn_to_string(s : NlpembeduniversalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_node_make(size : Int) -> NlpembeduniversalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_node_len(s : NlpembeduniversalNode) -> Int { s.size }

pub fn nlp_embed_universal_node_get(s : NlpembeduniversalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_node_set(s : NlpembeduniversalNode, i : Int, v : Double) -> NlpembeduniversalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_node_sum(s : NlpembeduniversalNode) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_universal_node_mean(s : NlpembeduniversalNode) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_universal_node_scale(s : NlpembeduniversalNode, f : Double) -> NlpembeduniversalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_node_add(a : NlpembeduniversalNode, b : NlpembeduniversalNode) -> NlpembeduniversalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_universal_node_copy(s : NlpembeduniversalNode) -> NlpembeduniversalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_node_fill(s : NlpembeduniversalNode, v : Double) -> NlpembeduniversalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_node_min(s : NlpembeduniversalNode) -> Double { @_common.min(s.data) }

pub fn nlp_embed_universal_node_max(s : NlpembeduniversalNode) -> Double { @_common.max(s.data) }

pub fn nlp_embed_universal_node_to_string(s : NlpembeduniversalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_edge_make(size : Int) -> NlpembeduniversalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_edge_len(s : NlpembeduniversalEdge) -> Int { s.size }

pub fn nlp_embed_universal_edge_get(s : NlpembeduniversalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_edge_set(s : NlpembeduniversalEdge, i : Int, v : Double) -> NlpembeduniversalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_edge_sum(s : NlpembeduniversalEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_universal_edge_mean(s : NlpembeduniversalEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_universal_edge_scale(s : NlpembeduniversalEdge, f : Double) -> NlpembeduniversalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_edge_add(a : NlpembeduniversalEdge, b : NlpembeduniversalEdge) -> NlpembeduniversalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_universal_edge_copy(s : NlpembeduniversalEdge) -> NlpembeduniversalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_edge_fill(s : NlpembeduniversalEdge, v : Double) -> NlpembeduniversalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_edge_min(s : NlpembeduniversalEdge) -> Double { @_common.min(s.data) }

pub fn nlp_embed_universal_edge_max(s : NlpembeduniversalEdge) -> Double { @_common.max(s.data) }

pub fn nlp_embed_universal_edge_to_string(s : NlpembeduniversalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_path_make(size : Int) -> NlpembeduniversalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_path_len(s : NlpembeduniversalPath) -> Int { s.size }

pub fn nlp_embed_universal_path_get(s : NlpembeduniversalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_path_set(s : NlpembeduniversalPath, i : Int, v : Double) -> NlpembeduniversalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_path_sum(s : NlpembeduniversalPath) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_universal_path_mean(s : NlpembeduniversalPath) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_universal_path_scale(s : NlpembeduniversalPath, f : Double) -> NlpembeduniversalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_path_add(a : NlpembeduniversalPath, b : NlpembeduniversalPath) -> NlpembeduniversalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_universal_path_copy(s : NlpembeduniversalPath) -> NlpembeduniversalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_path_fill(s : NlpembeduniversalPath, v : Double) -> NlpembeduniversalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_path_min(s : NlpembeduniversalPath) -> Double { @_common.min(s.data) }

pub fn nlp_embed_universal_path_max(s : NlpembeduniversalPath) -> Double { @_common.max(s.data) }

pub fn nlp_embed_universal_path_to_string(s : NlpembeduniversalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_cluster_make(size : Int) -> NlpembeduniversalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_cluster_len(s : NlpembeduniversalCluster) -> Int { s.size }

pub fn nlp_embed_universal_cluster_get(s : NlpembeduniversalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_cluster_set(s : NlpembeduniversalCluster, i : Int, v : Double) -> NlpembeduniversalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_cluster_sum(s : NlpembeduniversalCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_universal_cluster_mean(s : NlpembeduniversalCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_universal_cluster_scale(s : NlpembeduniversalCluster, f : Double) -> NlpembeduniversalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_cluster_add(a : NlpembeduniversalCluster, b : NlpembeduniversalCluster) -> NlpembeduniversalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_universal_cluster_copy(s : NlpembeduniversalCluster) -> NlpembeduniversalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_cluster_fill(s : NlpembeduniversalCluster, v : Double) -> NlpembeduniversalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_cluster_min(s : NlpembeduniversalCluster) -> Double { @_common.min(s.data) }

pub fn nlp_embed_universal_cluster_max(s : NlpembeduniversalCluster) -> Double { @_common.max(s.data) }

pub fn nlp_embed_universal_cluster_to_string(s : NlpembeduniversalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_model_make(size : Int) -> NlpembeduniversalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_model_len(s : NlpembeduniversalModel) -> Int { s.size }

pub fn nlp_embed_universal_model_get(s : NlpembeduniversalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_model_set(s : NlpembeduniversalModel, i : Int, v : Double) -> NlpembeduniversalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_model_sum(s : NlpembeduniversalModel) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_universal_model_mean(s : NlpembeduniversalModel) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_universal_model_scale(s : NlpembeduniversalModel, f : Double) -> NlpembeduniversalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_model_add(a : NlpembeduniversalModel, b : NlpembeduniversalModel) -> NlpembeduniversalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_universal_model_copy(s : NlpembeduniversalModel) -> NlpembeduniversalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_model_fill(s : NlpembeduniversalModel, v : Double) -> NlpembeduniversalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_model_min(s : NlpembeduniversalModel) -> Double { @_common.min(s.data) }

pub fn nlp_embed_universal_model_max(s : NlpembeduniversalModel) -> Double { @_common.max(s.data) }

pub fn nlp_embed_universal_model_to_string(s : NlpembeduniversalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_layer_make(size : Int) -> NlpembeduniversalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_layer_len(s : NlpembeduniversalLayer) -> Int { s.size }

pub fn nlp_embed_universal_layer_get(s : NlpembeduniversalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_layer_set(s : NlpembeduniversalLayer, i : Int, v : Double) -> NlpembeduniversalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_layer_sum(s : NlpembeduniversalLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_universal_layer_mean(s : NlpembeduniversalLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_universal_layer_scale(s : NlpembeduniversalLayer, f : Double) -> NlpembeduniversalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_layer_add(a : NlpembeduniversalLayer, b : NlpembeduniversalLayer) -> NlpembeduniversalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_universal_layer_copy(s : NlpembeduniversalLayer) -> NlpembeduniversalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_layer_fill(s : NlpembeduniversalLayer, v : Double) -> NlpembeduniversalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_layer_min(s : NlpembeduniversalLayer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_universal_layer_max(s : NlpembeduniversalLayer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_universal_layer_to_string(s : NlpembeduniversalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_buffer_make(size : Int) -> NlpembeduniversalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_buffer_len(s : NlpembeduniversalBuffer) -> Int { s.size }

pub fn nlp_embed_universal_buffer_get(s : NlpembeduniversalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_buffer_set(s : NlpembeduniversalBuffer, i : Int, v : Double) -> NlpembeduniversalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_buffer_sum(s : NlpembeduniversalBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_universal_buffer_mean(s : NlpembeduniversalBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_universal_buffer_scale(s : NlpembeduniversalBuffer, f : Double) -> NlpembeduniversalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_buffer_add(a : NlpembeduniversalBuffer, b : NlpembeduniversalBuffer) -> NlpembeduniversalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_universal_buffer_copy(s : NlpembeduniversalBuffer) -> NlpembeduniversalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_buffer_fill(s : NlpembeduniversalBuffer, v : Double) -> NlpembeduniversalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_buffer_min(s : NlpembeduniversalBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_universal_buffer_max(s : NlpembeduniversalBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_universal_buffer_to_string(s : NlpembeduniversalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_cursor_make(size : Int) -> NlpembeduniversalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_cursor_len(s : NlpembeduniversalCursor) -> Int { s.size }

pub fn nlp_embed_universal_cursor_get(s : NlpembeduniversalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_cursor_set(s : NlpembeduniversalCursor, i : Int, v : Double) -> NlpembeduniversalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_cursor_sum(s : NlpembeduniversalCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_universal_cursor_mean(s : NlpembeduniversalCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_universal_cursor_scale(s : NlpembeduniversalCursor, f : Double) -> NlpembeduniversalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_cursor_add(a : NlpembeduniversalCursor, b : NlpembeduniversalCursor) -> NlpembeduniversalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_universal_cursor_copy(s : NlpembeduniversalCursor) -> NlpembeduniversalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_cursor_fill(s : NlpembeduniversalCursor, v : Double) -> NlpembeduniversalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_cursor_min(s : NlpembeduniversalCursor) -> Double { @_common.min(s.data) }

pub fn nlp_embed_universal_cursor_max(s : NlpembeduniversalCursor) -> Double { @_common.max(s.data) }

pub fn nlp_embed_universal_cursor_to_string(s : NlpembeduniversalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_view_make(size : Int) -> NlpembeduniversalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_view_len(s : NlpembeduniversalView) -> Int { s.size }

pub fn nlp_embed_universal_view_get(s : NlpembeduniversalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_view_set(s : NlpembeduniversalView, i : Int, v : Double) -> NlpembeduniversalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_view_sum(s : NlpembeduniversalView) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_universal_view_mean(s : NlpembeduniversalView) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_universal_view_scale(s : NlpembeduniversalView, f : Double) -> NlpembeduniversalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_view_add(a : NlpembeduniversalView, b : NlpembeduniversalView) -> NlpembeduniversalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_universal_view_copy(s : NlpembeduniversalView) -> NlpembeduniversalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_view_fill(s : NlpembeduniversalView, v : Double) -> NlpembeduniversalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_view_min(s : NlpembeduniversalView) -> Double { @_common.min(s.data) }

pub fn nlp_embed_universal_view_max(s : NlpembeduniversalView) -> Double { @_common.max(s.data) }

pub fn nlp_embed_universal_view_to_string(s : NlpembeduniversalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_range_make(size : Int) -> NlpembeduniversalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_range_len(s : NlpembeduniversalRange) -> Int { s.size }

pub fn nlp_embed_universal_range_get(s : NlpembeduniversalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_range_set(s : NlpembeduniversalRange, i : Int, v : Double) -> NlpembeduniversalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_range_sum(s : NlpembeduniversalRange) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_universal_range_mean(s : NlpembeduniversalRange) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_universal_range_scale(s : NlpembeduniversalRange, f : Double) -> NlpembeduniversalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_range_add(a : NlpembeduniversalRange, b : NlpembeduniversalRange) -> NlpembeduniversalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_universal_range_copy(s : NlpembeduniversalRange) -> NlpembeduniversalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_range_fill(s : NlpembeduniversalRange, v : Double) -> NlpembeduniversalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_range_min(s : NlpembeduniversalRange) -> Double { @_common.min(s.data) }

pub fn nlp_embed_universal_range_max(s : NlpembeduniversalRange) -> Double { @_common.max(s.data) }

pub fn nlp_embed_universal_range_to_string(s : NlpembeduniversalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembeduniversalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_universal_slice_make(size : Int) -> NlpembeduniversalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_universal_slice_len(s : NlpembeduniversalSlice) -> Int { s.size }

pub fn nlp_embed_universal_slice_get(s : NlpembeduniversalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_universal_slice_set(s : NlpembeduniversalSlice, i : Int, v : Double) -> NlpembeduniversalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_slice_sum(s : NlpembeduniversalSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_universal_slice_mean(s : NlpembeduniversalSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_universal_slice_scale(s : NlpembeduniversalSlice, f : Double) -> NlpembeduniversalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_slice_add(a : NlpembeduniversalSlice, b : NlpembeduniversalSlice) -> NlpembeduniversalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_universal_slice_copy(s : NlpembeduniversalSlice) -> NlpembeduniversalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_slice_fill(s : NlpembeduniversalSlice, v : Double) -> NlpembeduniversalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_universal_slice_min(s : NlpembeduniversalSlice) -> Double { @_common.min(s.data) }

pub fn nlp_embed_universal_slice_max(s : NlpembeduniversalSlice) -> Double { @_common.max(s.data) }

pub fn nlp_embed_universal_slice_to_string(s : NlpembeduniversalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

