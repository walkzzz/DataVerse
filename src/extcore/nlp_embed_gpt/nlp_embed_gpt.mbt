///===
/// extcore/nlp_embed_gpt

pub(all) struct NlpembedgptPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_gpt_make_point(x : Double, y : Double) -> NlpembedgptPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_gpt_make_point3(x : Double, y : Double, z : Double) -> NlpembedgptPoint {
  { x, y, z, label: 0 }
}

pub fn NlpembedgptPoint::x(self : NlpembedgptPoint) -> Double { self.x }

pub fn NlpembedgptPoint::y(self : NlpembedgptPoint) -> Double { self.y }

pub fn NlpembedgptPoint::z(self : NlpembedgptPoint) -> Double { self.z }

pub fn NlpembedgptPoint::label(self : NlpembedgptPoint) -> Int { self.label }

pub fn NlpembedgptPoint::dist(self : NlpembedgptPoint, other : NlpembedgptPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpembedgptPoint::add(self : NlpembedgptPoint, other : NlpembedgptPoint) -> NlpembedgptPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpembedgptPoint::sub(self : NlpembedgptPoint, other : NlpembedgptPoint) -> NlpembedgptPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpembedgptPoint::scale(self : NlpembedgptPoint, s : Double) -> NlpembedgptPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpembedgptPoint::dot(self : NlpembedgptPoint, other : NlpembedgptPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpembedgptPoint::cross(self : NlpembedgptPoint, other : NlpembedgptPoint) -> NlpembedgptPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpembedgptPoint::norm(self : NlpembedgptPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpembedgptPoint::normalize(self : NlpembedgptPoint) -> NlpembedgptPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedgptPoint::negate(self : NlpembedgptPoint) -> NlpembedgptPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpembedgptPoint::mid(self : NlpembedgptPoint, other : NlpembedgptPoint) -> NlpembedgptPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpembedgptPoint::lerp(self : NlpembedgptPoint, other : NlpembedgptPoint, t : Double) -> NlpembedgptPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpembedgptPoint::to_string(self : NlpembedgptPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpembedgptSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_gpt_make_series(vals : Array[Double], name : String) -> NlpembedgptSeries {
  { vals, name, meta: 0 }
}

pub fn NlpembedgptSeries::len(self : NlpembedgptSeries) -> Int { self.vals.length() }

pub fn NlpembedgptSeries::sum(self : NlpembedgptSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpembedgptSeries::mean(self : NlpembedgptSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpembedgptSeries::min(self : NlpembedgptSeries) -> Double { @_common.min(self.vals) }

pub fn NlpembedgptSeries::max(self : NlpembedgptSeries) -> Double { @_common.max(self.vals) }

pub fn NlpembedgptSeries::range(self : NlpembedgptSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpembedgptSeries::variance(self : NlpembedgptSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpembedgptSeries::std(self : NlpembedgptSeries) -> Double { @_common.std(self.vals) }

pub fn NlpembedgptSeries::median(self : NlpembedgptSeries) -> Double { @_common.median(self.vals) }

pub fn NlpembedgptSeries::scale(self : NlpembedgptSeries, f : Double) -> NlpembedgptSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpembedgptSeries::add(self : NlpembedgptSeries, other : NlpembedgptSeries) -> NlpembedgptSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpembedgptSeries::sub(self : NlpembedgptSeries, other : NlpembedgptSeries) -> NlpembedgptSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpembedgptSeries::normalize(self : NlpembedgptSeries) -> NlpembedgptSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpembedgptSeries::cumsum(self : NlpembedgptSeries) -> NlpembedgptSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpembedgptSeries::to_string(self : NlpembedgptSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedgptMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_gpt_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedgptMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_gpt_matrix_identity(n : Int) -> NlpembedgptMatrix {
  let m = nlp_embed_gpt_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpembedgptMatrix::get(self : NlpembedgptMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpembedgptMatrix::transpose(self : NlpembedgptMatrix) -> NlpembedgptMatrix {
  let result = nlp_embed_gpt_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpembedgptMatrix::add(self : NlpembedgptMatrix, other : NlpembedgptMatrix) -> NlpembedgptMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_gpt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpembedgptMatrix::scale(self : NlpembedgptMatrix, s : Double) -> NlpembedgptMatrix {
  let result = nlp_embed_gpt_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpembedgptMatrix::multiply(self : NlpembedgptMatrix, other : NlpembedgptMatrix) -> NlpembedgptMatrix {
  if self.cols != other.rows { return nlp_embed_gpt_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_gpt_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpembedgptMatrix::trace(self : NlpembedgptMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpembedgptMatrix::det(self : NlpembedgptMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpembedgptMatrix::norm(self : NlpembedgptMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpembedgptMatrix::to_string(self : NlpembedgptMatrix) -> String {
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

pub(all) struct NlpembedgptVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_gpt_make_vector(comps : Array[Double]) -> NlpembedgptVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_gpt_vector_zero(dim : Int) -> NlpembedgptVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpembedgptVector::add(self : NlpembedgptVector, other : NlpembedgptVector) -> NlpembedgptVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedgptVector::sub(self : NlpembedgptVector, other : NlpembedgptVector) -> NlpembedgptVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedgptVector::scale(self : NlpembedgptVector, s : Double) -> NlpembedgptVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpembedgptVector::dot(self : NlpembedgptVector, other : NlpembedgptVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpembedgptVector::norm(self : NlpembedgptVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpembedgptVector::normalize(self : NlpembedgptVector) -> NlpembedgptVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedgptVector::dist(self : NlpembedgptVector, other : NlpembedgptVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpembedgptVector::to_string(self : NlpembedgptVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_gpt_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_gpt_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_gpt_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_gpt_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_gpt_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_gpt_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_gpt_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_gpt_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_gpt_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_gpt_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_gpt_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_gpt_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_gpt_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_gpt_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_gpt_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_gpt_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_gpt_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_gpt_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_gpt_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_gpt_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_gpt_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_gpt_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_gpt_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_gpt_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_gpt_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_gpt_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_gpt_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_gpt_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_gpt_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpembedgptFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_frame_make(size : Int) -> NlpembedgptFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_frame_len(s : NlpembedgptFrame) -> Int { s.size }

pub fn nlp_embed_gpt_frame_get(s : NlpembedgptFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_frame_set(s : NlpembedgptFrame, i : Int, v : Double) -> NlpembedgptFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_frame_sum(s : NlpembedgptFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_frame_mean(s : NlpembedgptFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_frame_scale(s : NlpembedgptFrame, f : Double) -> NlpembedgptFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_frame_add(a : NlpembedgptFrame, b : NlpembedgptFrame) -> NlpembedgptFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_frame_copy(s : NlpembedgptFrame) -> NlpembedgptFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_frame_fill(s : NlpembedgptFrame, v : Double) -> NlpembedgptFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_frame_min(s : NlpembedgptFrame) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_frame_max(s : NlpembedgptFrame) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_frame_to_string(s : NlpembedgptFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_table_make(size : Int) -> NlpembedgptTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_table_len(s : NlpembedgptTable) -> Int { s.size }

pub fn nlp_embed_gpt_table_get(s : NlpembedgptTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_table_set(s : NlpembedgptTable, i : Int, v : Double) -> NlpembedgptTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_table_sum(s : NlpembedgptTable) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_table_mean(s : NlpembedgptTable) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_table_scale(s : NlpembedgptTable, f : Double) -> NlpembedgptTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_table_add(a : NlpembedgptTable, b : NlpembedgptTable) -> NlpembedgptTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_table_copy(s : NlpembedgptTable) -> NlpembedgptTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_table_fill(s : NlpembedgptTable, v : Double) -> NlpembedgptTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_table_min(s : NlpembedgptTable) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_table_max(s : NlpembedgptTable) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_table_to_string(s : NlpembedgptTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_graphn_make(size : Int) -> NlpembedgptGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_graphn_len(s : NlpembedgptGraphN) -> Int { s.size }

pub fn nlp_embed_gpt_graphn_get(s : NlpembedgptGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_graphn_set(s : NlpembedgptGraphN, i : Int, v : Double) -> NlpembedgptGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_graphn_sum(s : NlpembedgptGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_graphn_mean(s : NlpembedgptGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_graphn_scale(s : NlpembedgptGraphN, f : Double) -> NlpembedgptGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_graphn_add(a : NlpembedgptGraphN, b : NlpembedgptGraphN) -> NlpembedgptGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_graphn_copy(s : NlpembedgptGraphN) -> NlpembedgptGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_graphn_fill(s : NlpembedgptGraphN, v : Double) -> NlpembedgptGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_graphn_min(s : NlpembedgptGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_graphn_max(s : NlpembedgptGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_graphn_to_string(s : NlpembedgptGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_node_make(size : Int) -> NlpembedgptNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_node_len(s : NlpembedgptNode) -> Int { s.size }

pub fn nlp_embed_gpt_node_get(s : NlpembedgptNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_node_set(s : NlpembedgptNode, i : Int, v : Double) -> NlpembedgptNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_node_sum(s : NlpembedgptNode) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_node_mean(s : NlpembedgptNode) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_node_scale(s : NlpembedgptNode, f : Double) -> NlpembedgptNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_node_add(a : NlpembedgptNode, b : NlpembedgptNode) -> NlpembedgptNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_node_copy(s : NlpembedgptNode) -> NlpembedgptNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_node_fill(s : NlpembedgptNode, v : Double) -> NlpembedgptNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_node_min(s : NlpembedgptNode) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_node_max(s : NlpembedgptNode) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_node_to_string(s : NlpembedgptNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_edge_make(size : Int) -> NlpembedgptEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_edge_len(s : NlpembedgptEdge) -> Int { s.size }

pub fn nlp_embed_gpt_edge_get(s : NlpembedgptEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_edge_set(s : NlpembedgptEdge, i : Int, v : Double) -> NlpembedgptEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_edge_sum(s : NlpembedgptEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_edge_mean(s : NlpembedgptEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_edge_scale(s : NlpembedgptEdge, f : Double) -> NlpembedgptEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_edge_add(a : NlpembedgptEdge, b : NlpembedgptEdge) -> NlpembedgptEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_edge_copy(s : NlpembedgptEdge) -> NlpembedgptEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_edge_fill(s : NlpembedgptEdge, v : Double) -> NlpembedgptEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_edge_min(s : NlpembedgptEdge) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_edge_max(s : NlpembedgptEdge) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_edge_to_string(s : NlpembedgptEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_path_make(size : Int) -> NlpembedgptPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_path_len(s : NlpembedgptPath) -> Int { s.size }

pub fn nlp_embed_gpt_path_get(s : NlpembedgptPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_path_set(s : NlpembedgptPath, i : Int, v : Double) -> NlpembedgptPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_path_sum(s : NlpembedgptPath) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_path_mean(s : NlpembedgptPath) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_path_scale(s : NlpembedgptPath, f : Double) -> NlpembedgptPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_path_add(a : NlpembedgptPath, b : NlpembedgptPath) -> NlpembedgptPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_path_copy(s : NlpembedgptPath) -> NlpembedgptPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_path_fill(s : NlpembedgptPath, v : Double) -> NlpembedgptPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_path_min(s : NlpembedgptPath) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_path_max(s : NlpembedgptPath) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_path_to_string(s : NlpembedgptPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_cluster_make(size : Int) -> NlpembedgptCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_cluster_len(s : NlpembedgptCluster) -> Int { s.size }

pub fn nlp_embed_gpt_cluster_get(s : NlpembedgptCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_cluster_set(s : NlpembedgptCluster, i : Int, v : Double) -> NlpembedgptCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cluster_sum(s : NlpembedgptCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_cluster_mean(s : NlpembedgptCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_cluster_scale(s : NlpembedgptCluster, f : Double) -> NlpembedgptCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cluster_add(a : NlpembedgptCluster, b : NlpembedgptCluster) -> NlpembedgptCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_cluster_copy(s : NlpembedgptCluster) -> NlpembedgptCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cluster_fill(s : NlpembedgptCluster, v : Double) -> NlpembedgptCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cluster_min(s : NlpembedgptCluster) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_cluster_max(s : NlpembedgptCluster) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_cluster_to_string(s : NlpembedgptCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_model_make(size : Int) -> NlpembedgptModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_model_len(s : NlpembedgptModel) -> Int { s.size }

pub fn nlp_embed_gpt_model_get(s : NlpembedgptModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_model_set(s : NlpembedgptModel, i : Int, v : Double) -> NlpembedgptModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_model_sum(s : NlpembedgptModel) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_model_mean(s : NlpembedgptModel) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_model_scale(s : NlpembedgptModel, f : Double) -> NlpembedgptModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_model_add(a : NlpembedgptModel, b : NlpembedgptModel) -> NlpembedgptModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_model_copy(s : NlpembedgptModel) -> NlpembedgptModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_model_fill(s : NlpembedgptModel, v : Double) -> NlpembedgptModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_model_min(s : NlpembedgptModel) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_model_max(s : NlpembedgptModel) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_model_to_string(s : NlpembedgptModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_layer_make(size : Int) -> NlpembedgptLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_layer_len(s : NlpembedgptLayer) -> Int { s.size }

pub fn nlp_embed_gpt_layer_get(s : NlpembedgptLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_layer_set(s : NlpembedgptLayer, i : Int, v : Double) -> NlpembedgptLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_layer_sum(s : NlpembedgptLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_layer_mean(s : NlpembedgptLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_layer_scale(s : NlpembedgptLayer, f : Double) -> NlpembedgptLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_layer_add(a : NlpembedgptLayer, b : NlpembedgptLayer) -> NlpembedgptLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_layer_copy(s : NlpembedgptLayer) -> NlpembedgptLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_layer_fill(s : NlpembedgptLayer, v : Double) -> NlpembedgptLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_layer_min(s : NlpembedgptLayer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_layer_max(s : NlpembedgptLayer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_layer_to_string(s : NlpembedgptLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_buffer_make(size : Int) -> NlpembedgptBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_buffer_len(s : NlpembedgptBuffer) -> Int { s.size }

pub fn nlp_embed_gpt_buffer_get(s : NlpembedgptBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_buffer_set(s : NlpembedgptBuffer, i : Int, v : Double) -> NlpembedgptBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_buffer_sum(s : NlpembedgptBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_buffer_mean(s : NlpembedgptBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_buffer_scale(s : NlpembedgptBuffer, f : Double) -> NlpembedgptBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_buffer_add(a : NlpembedgptBuffer, b : NlpembedgptBuffer) -> NlpembedgptBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_buffer_copy(s : NlpembedgptBuffer) -> NlpembedgptBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_buffer_fill(s : NlpembedgptBuffer, v : Double) -> NlpembedgptBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_buffer_min(s : NlpembedgptBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_buffer_max(s : NlpembedgptBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_buffer_to_string(s : NlpembedgptBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_cursor_make(size : Int) -> NlpembedgptCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_cursor_len(s : NlpembedgptCursor) -> Int { s.size }

pub fn nlp_embed_gpt_cursor_get(s : NlpembedgptCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_cursor_set(s : NlpembedgptCursor, i : Int, v : Double) -> NlpembedgptCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cursor_sum(s : NlpembedgptCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_cursor_mean(s : NlpembedgptCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_cursor_scale(s : NlpembedgptCursor, f : Double) -> NlpembedgptCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cursor_add(a : NlpembedgptCursor, b : NlpembedgptCursor) -> NlpembedgptCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_cursor_copy(s : NlpembedgptCursor) -> NlpembedgptCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cursor_fill(s : NlpembedgptCursor, v : Double) -> NlpembedgptCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_cursor_min(s : NlpembedgptCursor) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_cursor_max(s : NlpembedgptCursor) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_cursor_to_string(s : NlpembedgptCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_view_make(size : Int) -> NlpembedgptView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_view_len(s : NlpembedgptView) -> Int { s.size }

pub fn nlp_embed_gpt_view_get(s : NlpembedgptView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_view_set(s : NlpembedgptView, i : Int, v : Double) -> NlpembedgptView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_view_sum(s : NlpembedgptView) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_view_mean(s : NlpembedgptView) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_view_scale(s : NlpembedgptView, f : Double) -> NlpembedgptView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_view_add(a : NlpembedgptView, b : NlpembedgptView) -> NlpembedgptView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_view_copy(s : NlpembedgptView) -> NlpembedgptView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_view_fill(s : NlpembedgptView, v : Double) -> NlpembedgptView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_view_min(s : NlpembedgptView) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_view_max(s : NlpembedgptView) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_view_to_string(s : NlpembedgptView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_range_make(size : Int) -> NlpembedgptRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_range_len(s : NlpembedgptRange) -> Int { s.size }

pub fn nlp_embed_gpt_range_get(s : NlpembedgptRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_range_set(s : NlpembedgptRange, i : Int, v : Double) -> NlpembedgptRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_range_sum(s : NlpembedgptRange) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_range_mean(s : NlpembedgptRange) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_range_scale(s : NlpembedgptRange, f : Double) -> NlpembedgptRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_range_add(a : NlpembedgptRange, b : NlpembedgptRange) -> NlpembedgptRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_range_copy(s : NlpembedgptRange) -> NlpembedgptRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_range_fill(s : NlpembedgptRange, v : Double) -> NlpembedgptRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_range_min(s : NlpembedgptRange) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_range_max(s : NlpembedgptRange) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_range_to_string(s : NlpembedgptRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgptSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_slice_make(size : Int) -> NlpembedgptSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_gpt_slice_len(s : NlpembedgptSlice) -> Int { s.size }

pub fn nlp_embed_gpt_slice_get(s : NlpembedgptSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_gpt_slice_set(s : NlpembedgptSlice, i : Int, v : Double) -> NlpembedgptSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_slice_sum(s : NlpembedgptSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_gpt_slice_mean(s : NlpembedgptSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_gpt_slice_scale(s : NlpembedgptSlice, f : Double) -> NlpembedgptSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_slice_add(a : NlpembedgptSlice, b : NlpembedgptSlice) -> NlpembedgptSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_gpt_slice_copy(s : NlpembedgptSlice) -> NlpembedgptSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_slice_fill(s : NlpembedgptSlice, v : Double) -> NlpembedgptSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_gpt_slice_min(s : NlpembedgptSlice) -> Double { @_common.min(s.data) }

pub fn nlp_embed_gpt_slice_max(s : NlpembedgptSlice) -> Double { @_common.max(s.data) }

pub fn nlp_embed_gpt_slice_to_string(s : NlpembedgptSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

