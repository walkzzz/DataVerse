///===
/// extcore/nlp_embed_bert

pub(all) struct NlpembedbertPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_bert_make_point(x : Double, y : Double) -> NlpembedbertPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_bert_make_point3(x : Double, y : Double, z : Double) -> NlpembedbertPoint {
  { x, y, z, label: 0 }
}

pub fn NlpembedbertPoint::x(self : NlpembedbertPoint) -> Double { self.x }

pub fn NlpembedbertPoint::y(self : NlpembedbertPoint) -> Double { self.y }

pub fn NlpembedbertPoint::z(self : NlpembedbertPoint) -> Double { self.z }

pub fn NlpembedbertPoint::label(self : NlpembedbertPoint) -> Int { self.label }

pub fn NlpembedbertPoint::dist(self : NlpembedbertPoint, other : NlpembedbertPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpembedbertPoint::add(self : NlpembedbertPoint, other : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpembedbertPoint::sub(self : NlpembedbertPoint, other : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpembedbertPoint::scale(self : NlpembedbertPoint, s : Double) -> NlpembedbertPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpembedbertPoint::dot(self : NlpembedbertPoint, other : NlpembedbertPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpembedbertPoint::cross(self : NlpembedbertPoint, other : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpembedbertPoint::norm(self : NlpembedbertPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpembedbertPoint::normalize(self : NlpembedbertPoint) -> NlpembedbertPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedbertPoint::negate(self : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpembedbertPoint::mid(self : NlpembedbertPoint, other : NlpembedbertPoint) -> NlpembedbertPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpembedbertPoint::lerp(self : NlpembedbertPoint, other : NlpembedbertPoint, t : Double) -> NlpembedbertPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpembedbertPoint::to_string(self : NlpembedbertPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpembedbertSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_bert_make_series(vals : Array[Double], name : String) -> NlpembedbertSeries {
  { vals, name, meta: 0 }
}

pub fn NlpembedbertSeries::len(self : NlpembedbertSeries) -> Int { self.vals.length() }

pub fn NlpembedbertSeries::sum(self : NlpembedbertSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpembedbertSeries::mean(self : NlpembedbertSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpembedbertSeries::min(self : NlpembedbertSeries) -> Double { @_common.min(self.vals) }

pub fn NlpembedbertSeries::max(self : NlpembedbertSeries) -> Double { @_common.max(self.vals) }

pub fn NlpembedbertSeries::range(self : NlpembedbertSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpembedbertSeries::variance(self : NlpembedbertSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpembedbertSeries::std(self : NlpembedbertSeries) -> Double { @_common.std(self.vals) }

pub fn NlpembedbertSeries::median(self : NlpembedbertSeries) -> Double { @_common.median(self.vals) }

pub fn NlpembedbertSeries::scale(self : NlpembedbertSeries, f : Double) -> NlpembedbertSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpembedbertSeries::add(self : NlpembedbertSeries, other : NlpembedbertSeries) -> NlpembedbertSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpembedbertSeries::sub(self : NlpembedbertSeries, other : NlpembedbertSeries) -> NlpembedbertSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpembedbertSeries::normalize(self : NlpembedbertSeries) -> NlpembedbertSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpembedbertSeries::cumsum(self : NlpembedbertSeries) -> NlpembedbertSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpembedbertSeries::to_string(self : NlpembedbertSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedbertMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_bert_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedbertMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_bert_matrix_identity(n : Int) -> NlpembedbertMatrix {
  let m = nlp_embed_bert_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpembedbertMatrix::get(self : NlpembedbertMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpembedbertMatrix::transpose(self : NlpembedbertMatrix) -> NlpembedbertMatrix {
  let result = nlp_embed_bert_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpembedbertMatrix::add(self : NlpembedbertMatrix, other : NlpembedbertMatrix) -> NlpembedbertMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_bert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpembedbertMatrix::scale(self : NlpembedbertMatrix, s : Double) -> NlpembedbertMatrix {
  let result = nlp_embed_bert_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpembedbertMatrix::multiply(self : NlpembedbertMatrix, other : NlpembedbertMatrix) -> NlpembedbertMatrix {
  if self.cols != other.rows { return nlp_embed_bert_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_bert_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpembedbertMatrix::trace(self : NlpembedbertMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpembedbertMatrix::det(self : NlpembedbertMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpembedbertMatrix::norm(self : NlpembedbertMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpembedbertMatrix::to_string(self : NlpembedbertMatrix) -> String {
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

pub(all) struct NlpembedbertVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_bert_make_vector(comps : Array[Double]) -> NlpembedbertVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_bert_vector_zero(dim : Int) -> NlpembedbertVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpembedbertVector::add(self : NlpembedbertVector, other : NlpembedbertVector) -> NlpembedbertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedbertVector::sub(self : NlpembedbertVector, other : NlpembedbertVector) -> NlpembedbertVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedbertVector::scale(self : NlpembedbertVector, s : Double) -> NlpembedbertVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpembedbertVector::dot(self : NlpembedbertVector, other : NlpembedbertVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpembedbertVector::norm(self : NlpembedbertVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpembedbertVector::normalize(self : NlpembedbertVector) -> NlpembedbertVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedbertVector::dist(self : NlpembedbertVector, other : NlpembedbertVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpembedbertVector::to_string(self : NlpembedbertVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_bert_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_bert_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_bert_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_bert_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_bert_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_bert_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_bert_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_bert_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_bert_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_bert_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_bert_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_bert_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_bert_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_bert_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_bert_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_bert_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_bert_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_bert_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_bert_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_bert_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_bert_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_bert_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_bert_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_bert_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_bert_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_bert_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_bert_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_bert_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_bert_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpembedbertFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_frame_make(size : Int) -> NlpembedbertFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_frame_len(s : NlpembedbertFrame) -> Int { s.size }

pub fn nlp_embed_bert_frame_get(s : NlpembedbertFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_frame_set(s : NlpembedbertFrame, i : Int, v : Double) -> NlpembedbertFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_frame_sum(s : NlpembedbertFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_frame_mean(s : NlpembedbertFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_frame_scale(s : NlpembedbertFrame, f : Double) -> NlpembedbertFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_frame_add(a : NlpembedbertFrame, b : NlpembedbertFrame) -> NlpembedbertFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_bert_frame_copy(s : NlpembedbertFrame) -> NlpembedbertFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_frame_fill(s : NlpembedbertFrame, v : Double) -> NlpembedbertFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_frame_min(s : NlpembedbertFrame) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_frame_max(s : NlpembedbertFrame) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_frame_to_string(s : NlpembedbertFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_table_make(size : Int) -> NlpembedbertTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_table_len(s : NlpembedbertTable) -> Int { s.size }

pub fn nlp_embed_bert_table_get(s : NlpembedbertTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_table_set(s : NlpembedbertTable, i : Int, v : Double) -> NlpembedbertTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_table_sum(s : NlpembedbertTable) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_table_mean(s : NlpembedbertTable) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_table_scale(s : NlpembedbertTable, f : Double) -> NlpembedbertTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_table_add(a : NlpembedbertTable, b : NlpembedbertTable) -> NlpembedbertTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_bert_table_copy(s : NlpembedbertTable) -> NlpembedbertTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_table_fill(s : NlpembedbertTable, v : Double) -> NlpembedbertTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_table_min(s : NlpembedbertTable) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_table_max(s : NlpembedbertTable) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_table_to_string(s : NlpembedbertTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_graphn_make(size : Int) -> NlpembedbertGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_graphn_len(s : NlpembedbertGraphN) -> Int { s.size }

pub fn nlp_embed_bert_graphn_get(s : NlpembedbertGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_graphn_set(s : NlpembedbertGraphN, i : Int, v : Double) -> NlpembedbertGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_graphn_sum(s : NlpembedbertGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_graphn_mean(s : NlpembedbertGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_graphn_scale(s : NlpembedbertGraphN, f : Double) -> NlpembedbertGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_graphn_add(a : NlpembedbertGraphN, b : NlpembedbertGraphN) -> NlpembedbertGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_bert_graphn_copy(s : NlpembedbertGraphN) -> NlpembedbertGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_graphn_fill(s : NlpembedbertGraphN, v : Double) -> NlpembedbertGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_graphn_min(s : NlpembedbertGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_graphn_max(s : NlpembedbertGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_graphn_to_string(s : NlpembedbertGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_node_make(size : Int) -> NlpembedbertNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_node_len(s : NlpembedbertNode) -> Int { s.size }

pub fn nlp_embed_bert_node_get(s : NlpembedbertNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_node_set(s : NlpembedbertNode, i : Int, v : Double) -> NlpembedbertNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_node_sum(s : NlpembedbertNode) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_node_mean(s : NlpembedbertNode) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_node_scale(s : NlpembedbertNode, f : Double) -> NlpembedbertNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_node_add(a : NlpembedbertNode, b : NlpembedbertNode) -> NlpembedbertNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_bert_node_copy(s : NlpembedbertNode) -> NlpembedbertNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_node_fill(s : NlpembedbertNode, v : Double) -> NlpembedbertNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_node_min(s : NlpembedbertNode) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_node_max(s : NlpembedbertNode) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_node_to_string(s : NlpembedbertNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_edge_make(size : Int) -> NlpembedbertEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_edge_len(s : NlpembedbertEdge) -> Int { s.size }

pub fn nlp_embed_bert_edge_get(s : NlpembedbertEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_edge_set(s : NlpembedbertEdge, i : Int, v : Double) -> NlpembedbertEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_edge_sum(s : NlpembedbertEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_edge_mean(s : NlpembedbertEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_edge_scale(s : NlpembedbertEdge, f : Double) -> NlpembedbertEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_edge_add(a : NlpembedbertEdge, b : NlpembedbertEdge) -> NlpembedbertEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_bert_edge_copy(s : NlpembedbertEdge) -> NlpembedbertEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_edge_fill(s : NlpembedbertEdge, v : Double) -> NlpembedbertEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_edge_min(s : NlpembedbertEdge) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_edge_max(s : NlpembedbertEdge) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_edge_to_string(s : NlpembedbertEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_path_make(size : Int) -> NlpembedbertPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_path_len(s : NlpembedbertPath) -> Int { s.size }

pub fn nlp_embed_bert_path_get(s : NlpembedbertPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_path_set(s : NlpembedbertPath, i : Int, v : Double) -> NlpembedbertPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_path_sum(s : NlpembedbertPath) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_path_mean(s : NlpembedbertPath) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_path_scale(s : NlpembedbertPath, f : Double) -> NlpembedbertPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_path_add(a : NlpembedbertPath, b : NlpembedbertPath) -> NlpembedbertPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_bert_path_copy(s : NlpembedbertPath) -> NlpembedbertPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_path_fill(s : NlpembedbertPath, v : Double) -> NlpembedbertPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_path_min(s : NlpembedbertPath) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_path_max(s : NlpembedbertPath) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_path_to_string(s : NlpembedbertPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_cluster_make(size : Int) -> NlpembedbertCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_cluster_len(s : NlpembedbertCluster) -> Int { s.size }

pub fn nlp_embed_bert_cluster_get(s : NlpembedbertCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_cluster_set(s : NlpembedbertCluster, i : Int, v : Double) -> NlpembedbertCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_cluster_sum(s : NlpembedbertCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_cluster_mean(s : NlpembedbertCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_cluster_scale(s : NlpembedbertCluster, f : Double) -> NlpembedbertCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_cluster_add(a : NlpembedbertCluster, b : NlpembedbertCluster) -> NlpembedbertCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_bert_cluster_copy(s : NlpembedbertCluster) -> NlpembedbertCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_cluster_fill(s : NlpembedbertCluster, v : Double) -> NlpembedbertCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_cluster_min(s : NlpembedbertCluster) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_cluster_max(s : NlpembedbertCluster) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_cluster_to_string(s : NlpembedbertCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_model_make(size : Int) -> NlpembedbertModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_model_len(s : NlpembedbertModel) -> Int { s.size }

pub fn nlp_embed_bert_model_get(s : NlpembedbertModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_model_set(s : NlpembedbertModel, i : Int, v : Double) -> NlpembedbertModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_model_sum(s : NlpembedbertModel) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_model_mean(s : NlpembedbertModel) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_model_scale(s : NlpembedbertModel, f : Double) -> NlpembedbertModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_model_add(a : NlpembedbertModel, b : NlpembedbertModel) -> NlpembedbertModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_bert_model_copy(s : NlpembedbertModel) -> NlpembedbertModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_model_fill(s : NlpembedbertModel, v : Double) -> NlpembedbertModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_model_min(s : NlpembedbertModel) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_model_max(s : NlpembedbertModel) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_model_to_string(s : NlpembedbertModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_layer_make(size : Int) -> NlpembedbertLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_layer_len(s : NlpembedbertLayer) -> Int { s.size }

pub fn nlp_embed_bert_layer_get(s : NlpembedbertLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_layer_set(s : NlpembedbertLayer, i : Int, v : Double) -> NlpembedbertLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_layer_sum(s : NlpembedbertLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_layer_mean(s : NlpembedbertLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_layer_scale(s : NlpembedbertLayer, f : Double) -> NlpembedbertLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_layer_add(a : NlpembedbertLayer, b : NlpembedbertLayer) -> NlpembedbertLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_bert_layer_copy(s : NlpembedbertLayer) -> NlpembedbertLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_layer_fill(s : NlpembedbertLayer, v : Double) -> NlpembedbertLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_layer_min(s : NlpembedbertLayer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_layer_max(s : NlpembedbertLayer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_layer_to_string(s : NlpembedbertLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_buffer_make(size : Int) -> NlpembedbertBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_buffer_len(s : NlpembedbertBuffer) -> Int { s.size }

pub fn nlp_embed_bert_buffer_get(s : NlpembedbertBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_buffer_set(s : NlpembedbertBuffer, i : Int, v : Double) -> NlpembedbertBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_buffer_sum(s : NlpembedbertBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_buffer_mean(s : NlpembedbertBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_buffer_scale(s : NlpembedbertBuffer, f : Double) -> NlpembedbertBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_buffer_add(a : NlpembedbertBuffer, b : NlpembedbertBuffer) -> NlpembedbertBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_bert_buffer_copy(s : NlpembedbertBuffer) -> NlpembedbertBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_buffer_fill(s : NlpembedbertBuffer, v : Double) -> NlpembedbertBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_buffer_min(s : NlpembedbertBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_buffer_max(s : NlpembedbertBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_buffer_to_string(s : NlpembedbertBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_cursor_make(size : Int) -> NlpembedbertCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_cursor_len(s : NlpembedbertCursor) -> Int { s.size }

pub fn nlp_embed_bert_cursor_get(s : NlpembedbertCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_cursor_set(s : NlpembedbertCursor, i : Int, v : Double) -> NlpembedbertCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_cursor_sum(s : NlpembedbertCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_cursor_mean(s : NlpembedbertCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_cursor_scale(s : NlpembedbertCursor, f : Double) -> NlpembedbertCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_cursor_add(a : NlpembedbertCursor, b : NlpembedbertCursor) -> NlpembedbertCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_bert_cursor_copy(s : NlpembedbertCursor) -> NlpembedbertCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_cursor_fill(s : NlpembedbertCursor, v : Double) -> NlpembedbertCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_cursor_min(s : NlpembedbertCursor) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_cursor_max(s : NlpembedbertCursor) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_cursor_to_string(s : NlpembedbertCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_view_make(size : Int) -> NlpembedbertView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_view_len(s : NlpembedbertView) -> Int { s.size }

pub fn nlp_embed_bert_view_get(s : NlpembedbertView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_view_set(s : NlpembedbertView, i : Int, v : Double) -> NlpembedbertView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_view_sum(s : NlpembedbertView) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_view_mean(s : NlpembedbertView) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_view_scale(s : NlpembedbertView, f : Double) -> NlpembedbertView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_view_add(a : NlpembedbertView, b : NlpembedbertView) -> NlpembedbertView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_bert_view_copy(s : NlpembedbertView) -> NlpembedbertView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_view_fill(s : NlpembedbertView, v : Double) -> NlpembedbertView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_view_min(s : NlpembedbertView) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_view_max(s : NlpembedbertView) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_view_to_string(s : NlpembedbertView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_range_make(size : Int) -> NlpembedbertRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_range_len(s : NlpembedbertRange) -> Int { s.size }

pub fn nlp_embed_bert_range_get(s : NlpembedbertRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_range_set(s : NlpembedbertRange, i : Int, v : Double) -> NlpembedbertRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_range_sum(s : NlpembedbertRange) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_range_mean(s : NlpembedbertRange) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_range_scale(s : NlpembedbertRange, f : Double) -> NlpembedbertRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_range_add(a : NlpembedbertRange, b : NlpembedbertRange) -> NlpembedbertRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_bert_range_copy(s : NlpembedbertRange) -> NlpembedbertRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_range_fill(s : NlpembedbertRange, v : Double) -> NlpembedbertRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_range_min(s : NlpembedbertRange) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_range_max(s : NlpembedbertRange) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_range_to_string(s : NlpembedbertRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedbertSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_bert_slice_make(size : Int) -> NlpembedbertSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_bert_slice_len(s : NlpembedbertSlice) -> Int { s.size }

pub fn nlp_embed_bert_slice_get(s : NlpembedbertSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_bert_slice_set(s : NlpembedbertSlice, i : Int, v : Double) -> NlpembedbertSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_slice_sum(s : NlpembedbertSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_bert_slice_mean(s : NlpembedbertSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_bert_slice_scale(s : NlpembedbertSlice, f : Double) -> NlpembedbertSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_slice_add(a : NlpembedbertSlice, b : NlpembedbertSlice) -> NlpembedbertSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_bert_slice_copy(s : NlpembedbertSlice) -> NlpembedbertSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_slice_fill(s : NlpembedbertSlice, v : Double) -> NlpembedbertSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_bert_slice_min(s : NlpembedbertSlice) -> Double { @_common.min(s.data) }

pub fn nlp_embed_bert_slice_max(s : NlpembedbertSlice) -> Double { @_common.max(s.data) }

pub fn nlp_embed_bert_slice_to_string(s : NlpembedbertSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

