///===
/// extcore/nlp_embed_fasttext

pub(all) struct NlpembedfasttextPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_fasttext_make_point(x : Double, y : Double) -> NlpembedfasttextPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_fasttext_make_point3(x : Double, y : Double, z : Double) -> NlpembedfasttextPoint {
  { x, y, z, label: 0 }
}

pub fn NlpembedfasttextPoint::x(self : NlpembedfasttextPoint) -> Double { self.x }

pub fn NlpembedfasttextPoint::y(self : NlpembedfasttextPoint) -> Double { self.y }

pub fn NlpembedfasttextPoint::z(self : NlpembedfasttextPoint) -> Double { self.z }

pub fn NlpembedfasttextPoint::label(self : NlpembedfasttextPoint) -> Int { self.label }

pub fn NlpembedfasttextPoint::dist(self : NlpembedfasttextPoint, other : NlpembedfasttextPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpembedfasttextPoint::add(self : NlpembedfasttextPoint, other : NlpembedfasttextPoint) -> NlpembedfasttextPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpembedfasttextPoint::sub(self : NlpembedfasttextPoint, other : NlpembedfasttextPoint) -> NlpembedfasttextPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpembedfasttextPoint::scale(self : NlpembedfasttextPoint, s : Double) -> NlpembedfasttextPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpembedfasttextPoint::dot(self : NlpembedfasttextPoint, other : NlpembedfasttextPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpembedfasttextPoint::cross(self : NlpembedfasttextPoint, other : NlpembedfasttextPoint) -> NlpembedfasttextPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpembedfasttextPoint::norm(self : NlpembedfasttextPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpembedfasttextPoint::normalize(self : NlpembedfasttextPoint) -> NlpembedfasttextPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedfasttextPoint::negate(self : NlpembedfasttextPoint) -> NlpembedfasttextPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpembedfasttextPoint::mid(self : NlpembedfasttextPoint, other : NlpembedfasttextPoint) -> NlpembedfasttextPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpembedfasttextPoint::lerp(self : NlpembedfasttextPoint, other : NlpembedfasttextPoint, t : Double) -> NlpembedfasttextPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpembedfasttextPoint::to_string(self : NlpembedfasttextPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpembedfasttextSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_fasttext_make_series(vals : Array[Double], name : String) -> NlpembedfasttextSeries {
  { vals, name, meta: 0 }
}

pub fn NlpembedfasttextSeries::len(self : NlpembedfasttextSeries) -> Int { self.vals.length() }

pub fn NlpembedfasttextSeries::sum(self : NlpembedfasttextSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpembedfasttextSeries::mean(self : NlpembedfasttextSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpembedfasttextSeries::min(self : NlpembedfasttextSeries) -> Double { @_common.min(self.vals) }

pub fn NlpembedfasttextSeries::max(self : NlpembedfasttextSeries) -> Double { @_common.max(self.vals) }

pub fn NlpembedfasttextSeries::range(self : NlpembedfasttextSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpembedfasttextSeries::variance(self : NlpembedfasttextSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpembedfasttextSeries::std(self : NlpembedfasttextSeries) -> Double { @_common.std(self.vals) }

pub fn NlpembedfasttextSeries::median(self : NlpembedfasttextSeries) -> Double { @_common.median(self.vals) }

pub fn NlpembedfasttextSeries::scale(self : NlpembedfasttextSeries, f : Double) -> NlpembedfasttextSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpembedfasttextSeries::add(self : NlpembedfasttextSeries, other : NlpembedfasttextSeries) -> NlpembedfasttextSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpembedfasttextSeries::sub(self : NlpembedfasttextSeries, other : NlpembedfasttextSeries) -> NlpembedfasttextSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpembedfasttextSeries::normalize(self : NlpembedfasttextSeries) -> NlpembedfasttextSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpembedfasttextSeries::cumsum(self : NlpembedfasttextSeries) -> NlpembedfasttextSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpembedfasttextSeries::to_string(self : NlpembedfasttextSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedfasttextMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_fasttext_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedfasttextMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_fasttext_matrix_identity(n : Int) -> NlpembedfasttextMatrix {
  let m = nlp_embed_fasttext_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpembedfasttextMatrix::get(self : NlpembedfasttextMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpembedfasttextMatrix::transpose(self : NlpembedfasttextMatrix) -> NlpembedfasttextMatrix {
  let result = nlp_embed_fasttext_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpembedfasttextMatrix::add(self : NlpembedfasttextMatrix, other : NlpembedfasttextMatrix) -> NlpembedfasttextMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_fasttext_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpembedfasttextMatrix::scale(self : NlpembedfasttextMatrix, s : Double) -> NlpembedfasttextMatrix {
  let result = nlp_embed_fasttext_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpembedfasttextMatrix::multiply(self : NlpembedfasttextMatrix, other : NlpembedfasttextMatrix) -> NlpembedfasttextMatrix {
  if self.cols != other.rows { return nlp_embed_fasttext_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_fasttext_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpembedfasttextMatrix::trace(self : NlpembedfasttextMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpembedfasttextMatrix::det(self : NlpembedfasttextMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpembedfasttextMatrix::norm(self : NlpembedfasttextMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpembedfasttextMatrix::to_string(self : NlpembedfasttextMatrix) -> String {
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

pub(all) struct NlpembedfasttextVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_fasttext_make_vector(comps : Array[Double]) -> NlpembedfasttextVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_fasttext_vector_zero(dim : Int) -> NlpembedfasttextVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpembedfasttextVector::add(self : NlpembedfasttextVector, other : NlpembedfasttextVector) -> NlpembedfasttextVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedfasttextVector::sub(self : NlpembedfasttextVector, other : NlpembedfasttextVector) -> NlpembedfasttextVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedfasttextVector::scale(self : NlpembedfasttextVector, s : Double) -> NlpembedfasttextVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpembedfasttextVector::dot(self : NlpembedfasttextVector, other : NlpembedfasttextVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpembedfasttextVector::norm(self : NlpembedfasttextVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpembedfasttextVector::normalize(self : NlpembedfasttextVector) -> NlpembedfasttextVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedfasttextVector::dist(self : NlpembedfasttextVector, other : NlpembedfasttextVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpembedfasttextVector::to_string(self : NlpembedfasttextVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_fasttext_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_fasttext_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_fasttext_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_fasttext_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_fasttext_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_fasttext_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_fasttext_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_fasttext_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_fasttext_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_fasttext_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_fasttext_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_fasttext_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_fasttext_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_fasttext_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_fasttext_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_fasttext_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_fasttext_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_fasttext_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_fasttext_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_fasttext_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_fasttext_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_fasttext_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_fasttext_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_fasttext_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_fasttext_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_fasttext_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_fasttext_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_fasttext_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_fasttext_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpembedfasttextFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_frame_make(size : Int) -> NlpembedfasttextFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_fasttext_frame_len(s : NlpembedfasttextFrame) -> Int { s.size }

pub fn nlp_embed_fasttext_frame_get(s : NlpembedfasttextFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_fasttext_frame_set(s : NlpembedfasttextFrame, i : Int, v : Double) -> NlpembedfasttextFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_frame_sum(s : NlpembedfasttextFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_fasttext_frame_mean(s : NlpembedfasttextFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_fasttext_frame_scale(s : NlpembedfasttextFrame, f : Double) -> NlpembedfasttextFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_frame_add(a : NlpembedfasttextFrame, b : NlpembedfasttextFrame) -> NlpembedfasttextFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_fasttext_frame_copy(s : NlpembedfasttextFrame) -> NlpembedfasttextFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_frame_fill(s : NlpembedfasttextFrame, v : Double) -> NlpembedfasttextFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_frame_min(s : NlpembedfasttextFrame) -> Double { @_common.min(s.data) }

pub fn nlp_embed_fasttext_frame_max(s : NlpembedfasttextFrame) -> Double { @_common.max(s.data) }

pub fn nlp_embed_fasttext_frame_to_string(s : NlpembedfasttextFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_table_make(size : Int) -> NlpembedfasttextTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_fasttext_table_len(s : NlpembedfasttextTable) -> Int { s.size }

pub fn nlp_embed_fasttext_table_get(s : NlpembedfasttextTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_fasttext_table_set(s : NlpembedfasttextTable, i : Int, v : Double) -> NlpembedfasttextTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_table_sum(s : NlpembedfasttextTable) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_fasttext_table_mean(s : NlpembedfasttextTable) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_fasttext_table_scale(s : NlpembedfasttextTable, f : Double) -> NlpembedfasttextTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_table_add(a : NlpembedfasttextTable, b : NlpembedfasttextTable) -> NlpembedfasttextTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_fasttext_table_copy(s : NlpembedfasttextTable) -> NlpembedfasttextTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_table_fill(s : NlpembedfasttextTable, v : Double) -> NlpembedfasttextTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_table_min(s : NlpembedfasttextTable) -> Double { @_common.min(s.data) }

pub fn nlp_embed_fasttext_table_max(s : NlpembedfasttextTable) -> Double { @_common.max(s.data) }

pub fn nlp_embed_fasttext_table_to_string(s : NlpembedfasttextTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_graphn_make(size : Int) -> NlpembedfasttextGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_fasttext_graphn_len(s : NlpembedfasttextGraphN) -> Int { s.size }

pub fn nlp_embed_fasttext_graphn_get(s : NlpembedfasttextGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_fasttext_graphn_set(s : NlpembedfasttextGraphN, i : Int, v : Double) -> NlpembedfasttextGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_graphn_sum(s : NlpembedfasttextGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_fasttext_graphn_mean(s : NlpembedfasttextGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_fasttext_graphn_scale(s : NlpembedfasttextGraphN, f : Double) -> NlpembedfasttextGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_graphn_add(a : NlpembedfasttextGraphN, b : NlpembedfasttextGraphN) -> NlpembedfasttextGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_fasttext_graphn_copy(s : NlpembedfasttextGraphN) -> NlpembedfasttextGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_graphn_fill(s : NlpembedfasttextGraphN, v : Double) -> NlpembedfasttextGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_graphn_min(s : NlpembedfasttextGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_embed_fasttext_graphn_max(s : NlpembedfasttextGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_embed_fasttext_graphn_to_string(s : NlpembedfasttextGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_node_make(size : Int) -> NlpembedfasttextNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_fasttext_node_len(s : NlpembedfasttextNode) -> Int { s.size }

pub fn nlp_embed_fasttext_node_get(s : NlpembedfasttextNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_fasttext_node_set(s : NlpembedfasttextNode, i : Int, v : Double) -> NlpembedfasttextNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_node_sum(s : NlpembedfasttextNode) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_fasttext_node_mean(s : NlpembedfasttextNode) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_fasttext_node_scale(s : NlpembedfasttextNode, f : Double) -> NlpembedfasttextNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_node_add(a : NlpembedfasttextNode, b : NlpembedfasttextNode) -> NlpembedfasttextNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_fasttext_node_copy(s : NlpembedfasttextNode) -> NlpembedfasttextNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_node_fill(s : NlpembedfasttextNode, v : Double) -> NlpembedfasttextNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_node_min(s : NlpembedfasttextNode) -> Double { @_common.min(s.data) }

pub fn nlp_embed_fasttext_node_max(s : NlpembedfasttextNode) -> Double { @_common.max(s.data) }

pub fn nlp_embed_fasttext_node_to_string(s : NlpembedfasttextNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_edge_make(size : Int) -> NlpembedfasttextEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_fasttext_edge_len(s : NlpembedfasttextEdge) -> Int { s.size }

pub fn nlp_embed_fasttext_edge_get(s : NlpembedfasttextEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_fasttext_edge_set(s : NlpembedfasttextEdge, i : Int, v : Double) -> NlpembedfasttextEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_edge_sum(s : NlpembedfasttextEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_fasttext_edge_mean(s : NlpembedfasttextEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_fasttext_edge_scale(s : NlpembedfasttextEdge, f : Double) -> NlpembedfasttextEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_edge_add(a : NlpembedfasttextEdge, b : NlpembedfasttextEdge) -> NlpembedfasttextEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_fasttext_edge_copy(s : NlpembedfasttextEdge) -> NlpembedfasttextEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_edge_fill(s : NlpembedfasttextEdge, v : Double) -> NlpembedfasttextEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_edge_min(s : NlpembedfasttextEdge) -> Double { @_common.min(s.data) }

pub fn nlp_embed_fasttext_edge_max(s : NlpembedfasttextEdge) -> Double { @_common.max(s.data) }

pub fn nlp_embed_fasttext_edge_to_string(s : NlpembedfasttextEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_path_make(size : Int) -> NlpembedfasttextPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_fasttext_path_len(s : NlpembedfasttextPath) -> Int { s.size }

pub fn nlp_embed_fasttext_path_get(s : NlpembedfasttextPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_fasttext_path_set(s : NlpembedfasttextPath, i : Int, v : Double) -> NlpembedfasttextPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_path_sum(s : NlpembedfasttextPath) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_fasttext_path_mean(s : NlpembedfasttextPath) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_fasttext_path_scale(s : NlpembedfasttextPath, f : Double) -> NlpembedfasttextPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_path_add(a : NlpembedfasttextPath, b : NlpembedfasttextPath) -> NlpembedfasttextPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_fasttext_path_copy(s : NlpembedfasttextPath) -> NlpembedfasttextPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_path_fill(s : NlpembedfasttextPath, v : Double) -> NlpembedfasttextPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_path_min(s : NlpembedfasttextPath) -> Double { @_common.min(s.data) }

pub fn nlp_embed_fasttext_path_max(s : NlpembedfasttextPath) -> Double { @_common.max(s.data) }

pub fn nlp_embed_fasttext_path_to_string(s : NlpembedfasttextPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_cluster_make(size : Int) -> NlpembedfasttextCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_fasttext_cluster_len(s : NlpembedfasttextCluster) -> Int { s.size }

pub fn nlp_embed_fasttext_cluster_get(s : NlpembedfasttextCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_fasttext_cluster_set(s : NlpembedfasttextCluster, i : Int, v : Double) -> NlpembedfasttextCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_cluster_sum(s : NlpembedfasttextCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_fasttext_cluster_mean(s : NlpembedfasttextCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_fasttext_cluster_scale(s : NlpembedfasttextCluster, f : Double) -> NlpembedfasttextCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_cluster_add(a : NlpembedfasttextCluster, b : NlpembedfasttextCluster) -> NlpembedfasttextCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_fasttext_cluster_copy(s : NlpembedfasttextCluster) -> NlpembedfasttextCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_cluster_fill(s : NlpembedfasttextCluster, v : Double) -> NlpembedfasttextCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_cluster_min(s : NlpembedfasttextCluster) -> Double { @_common.min(s.data) }

pub fn nlp_embed_fasttext_cluster_max(s : NlpembedfasttextCluster) -> Double { @_common.max(s.data) }

pub fn nlp_embed_fasttext_cluster_to_string(s : NlpembedfasttextCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_model_make(size : Int) -> NlpembedfasttextModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_fasttext_model_len(s : NlpembedfasttextModel) -> Int { s.size }

pub fn nlp_embed_fasttext_model_get(s : NlpembedfasttextModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_fasttext_model_set(s : NlpembedfasttextModel, i : Int, v : Double) -> NlpembedfasttextModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_model_sum(s : NlpembedfasttextModel) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_fasttext_model_mean(s : NlpembedfasttextModel) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_fasttext_model_scale(s : NlpembedfasttextModel, f : Double) -> NlpembedfasttextModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_model_add(a : NlpembedfasttextModel, b : NlpembedfasttextModel) -> NlpembedfasttextModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_fasttext_model_copy(s : NlpembedfasttextModel) -> NlpembedfasttextModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_model_fill(s : NlpembedfasttextModel, v : Double) -> NlpembedfasttextModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_model_min(s : NlpembedfasttextModel) -> Double { @_common.min(s.data) }

pub fn nlp_embed_fasttext_model_max(s : NlpembedfasttextModel) -> Double { @_common.max(s.data) }

pub fn nlp_embed_fasttext_model_to_string(s : NlpembedfasttextModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_layer_make(size : Int) -> NlpembedfasttextLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_fasttext_layer_len(s : NlpembedfasttextLayer) -> Int { s.size }

pub fn nlp_embed_fasttext_layer_get(s : NlpembedfasttextLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_fasttext_layer_set(s : NlpembedfasttextLayer, i : Int, v : Double) -> NlpembedfasttextLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_layer_sum(s : NlpembedfasttextLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_fasttext_layer_mean(s : NlpembedfasttextLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_fasttext_layer_scale(s : NlpembedfasttextLayer, f : Double) -> NlpembedfasttextLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_layer_add(a : NlpembedfasttextLayer, b : NlpembedfasttextLayer) -> NlpembedfasttextLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_fasttext_layer_copy(s : NlpembedfasttextLayer) -> NlpembedfasttextLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_layer_fill(s : NlpembedfasttextLayer, v : Double) -> NlpembedfasttextLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_layer_min(s : NlpembedfasttextLayer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_fasttext_layer_max(s : NlpembedfasttextLayer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_fasttext_layer_to_string(s : NlpembedfasttextLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_buffer_make(size : Int) -> NlpembedfasttextBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_fasttext_buffer_len(s : NlpembedfasttextBuffer) -> Int { s.size }

pub fn nlp_embed_fasttext_buffer_get(s : NlpembedfasttextBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_fasttext_buffer_set(s : NlpembedfasttextBuffer, i : Int, v : Double) -> NlpembedfasttextBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_buffer_sum(s : NlpembedfasttextBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_fasttext_buffer_mean(s : NlpembedfasttextBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_fasttext_buffer_scale(s : NlpembedfasttextBuffer, f : Double) -> NlpembedfasttextBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_buffer_add(a : NlpembedfasttextBuffer, b : NlpembedfasttextBuffer) -> NlpembedfasttextBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_fasttext_buffer_copy(s : NlpembedfasttextBuffer) -> NlpembedfasttextBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_buffer_fill(s : NlpembedfasttextBuffer, v : Double) -> NlpembedfasttextBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_buffer_min(s : NlpembedfasttextBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_fasttext_buffer_max(s : NlpembedfasttextBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_fasttext_buffer_to_string(s : NlpembedfasttextBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_cursor_make(size : Int) -> NlpembedfasttextCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_fasttext_cursor_len(s : NlpembedfasttextCursor) -> Int { s.size }

pub fn nlp_embed_fasttext_cursor_get(s : NlpembedfasttextCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_fasttext_cursor_set(s : NlpembedfasttextCursor, i : Int, v : Double) -> NlpembedfasttextCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_cursor_sum(s : NlpembedfasttextCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_fasttext_cursor_mean(s : NlpembedfasttextCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_fasttext_cursor_scale(s : NlpembedfasttextCursor, f : Double) -> NlpembedfasttextCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_cursor_add(a : NlpembedfasttextCursor, b : NlpembedfasttextCursor) -> NlpembedfasttextCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_fasttext_cursor_copy(s : NlpembedfasttextCursor) -> NlpembedfasttextCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_cursor_fill(s : NlpembedfasttextCursor, v : Double) -> NlpembedfasttextCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_cursor_min(s : NlpembedfasttextCursor) -> Double { @_common.min(s.data) }

pub fn nlp_embed_fasttext_cursor_max(s : NlpembedfasttextCursor) -> Double { @_common.max(s.data) }

pub fn nlp_embed_fasttext_cursor_to_string(s : NlpembedfasttextCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_view_make(size : Int) -> NlpembedfasttextView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_fasttext_view_len(s : NlpembedfasttextView) -> Int { s.size }

pub fn nlp_embed_fasttext_view_get(s : NlpembedfasttextView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_fasttext_view_set(s : NlpembedfasttextView, i : Int, v : Double) -> NlpembedfasttextView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_view_sum(s : NlpembedfasttextView) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_fasttext_view_mean(s : NlpembedfasttextView) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_fasttext_view_scale(s : NlpembedfasttextView, f : Double) -> NlpembedfasttextView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_view_add(a : NlpembedfasttextView, b : NlpembedfasttextView) -> NlpembedfasttextView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_fasttext_view_copy(s : NlpembedfasttextView) -> NlpembedfasttextView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_view_fill(s : NlpembedfasttextView, v : Double) -> NlpembedfasttextView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_view_min(s : NlpembedfasttextView) -> Double { @_common.min(s.data) }

pub fn nlp_embed_fasttext_view_max(s : NlpembedfasttextView) -> Double { @_common.max(s.data) }

pub fn nlp_embed_fasttext_view_to_string(s : NlpembedfasttextView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_range_make(size : Int) -> NlpembedfasttextRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_fasttext_range_len(s : NlpembedfasttextRange) -> Int { s.size }

pub fn nlp_embed_fasttext_range_get(s : NlpembedfasttextRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_fasttext_range_set(s : NlpembedfasttextRange, i : Int, v : Double) -> NlpembedfasttextRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_range_sum(s : NlpembedfasttextRange) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_fasttext_range_mean(s : NlpembedfasttextRange) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_fasttext_range_scale(s : NlpembedfasttextRange, f : Double) -> NlpembedfasttextRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_range_add(a : NlpembedfasttextRange, b : NlpembedfasttextRange) -> NlpembedfasttextRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_fasttext_range_copy(s : NlpembedfasttextRange) -> NlpembedfasttextRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_range_fill(s : NlpembedfasttextRange, v : Double) -> NlpembedfasttextRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_range_min(s : NlpembedfasttextRange) -> Double { @_common.min(s.data) }

pub fn nlp_embed_fasttext_range_max(s : NlpembedfasttextRange) -> Double { @_common.max(s.data) }

pub fn nlp_embed_fasttext_range_to_string(s : NlpembedfasttextRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedfasttextSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_fasttext_slice_make(size : Int) -> NlpembedfasttextSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_fasttext_slice_len(s : NlpembedfasttextSlice) -> Int { s.size }

pub fn nlp_embed_fasttext_slice_get(s : NlpembedfasttextSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_fasttext_slice_set(s : NlpembedfasttextSlice, i : Int, v : Double) -> NlpembedfasttextSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_slice_sum(s : NlpembedfasttextSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_fasttext_slice_mean(s : NlpembedfasttextSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_fasttext_slice_scale(s : NlpembedfasttextSlice, f : Double) -> NlpembedfasttextSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_slice_add(a : NlpembedfasttextSlice, b : NlpembedfasttextSlice) -> NlpembedfasttextSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_fasttext_slice_copy(s : NlpembedfasttextSlice) -> NlpembedfasttextSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_slice_fill(s : NlpembedfasttextSlice, v : Double) -> NlpembedfasttextSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_fasttext_slice_min(s : NlpembedfasttextSlice) -> Double { @_common.min(s.data) }

pub fn nlp_embed_fasttext_slice_max(s : NlpembedfasttextSlice) -> Double { @_common.max(s.data) }

pub fn nlp_embed_fasttext_slice_to_string(s : NlpembedfasttextSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

