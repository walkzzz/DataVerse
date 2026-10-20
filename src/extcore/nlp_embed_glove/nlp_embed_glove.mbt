///===
/// extcore/nlp_embed_glove

pub(all) struct NlpembedglovePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_glove_make_point(x : Double, y : Double) -> NlpembedglovePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_glove_make_point3(x : Double, y : Double, z : Double) -> NlpembedglovePoint {
  { x, y, z, label: 0 }
}

pub fn NlpembedglovePoint::x(self : NlpembedglovePoint) -> Double { self.x }

pub fn NlpembedglovePoint::y(self : NlpembedglovePoint) -> Double { self.y }

pub fn NlpembedglovePoint::z(self : NlpembedglovePoint) -> Double { self.z }

pub fn NlpembedglovePoint::label(self : NlpembedglovePoint) -> Int { self.label }

pub fn NlpembedglovePoint::dist(self : NlpembedglovePoint, other : NlpembedglovePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpembedglovePoint::add(self : NlpembedglovePoint, other : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpembedglovePoint::sub(self : NlpembedglovePoint, other : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpembedglovePoint::scale(self : NlpembedglovePoint, s : Double) -> NlpembedglovePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpembedglovePoint::dot(self : NlpembedglovePoint, other : NlpembedglovePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpembedglovePoint::cross(self : NlpembedglovePoint, other : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpembedglovePoint::norm(self : NlpembedglovePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpembedglovePoint::normalize(self : NlpembedglovePoint) -> NlpembedglovePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedglovePoint::negate(self : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpembedglovePoint::mid(self : NlpembedglovePoint, other : NlpembedglovePoint) -> NlpembedglovePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpembedglovePoint::lerp(self : NlpembedglovePoint, other : NlpembedglovePoint, t : Double) -> NlpembedglovePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpembedglovePoint::to_string(self : NlpembedglovePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpembedgloveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_glove_make_series(vals : Array[Double], name : String) -> NlpembedgloveSeries {
  { vals, name, meta: 0 }
}

pub fn NlpembedgloveSeries::len(self : NlpembedgloveSeries) -> Int { self.vals.length() }

pub fn NlpembedgloveSeries::sum(self : NlpembedgloveSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpembedgloveSeries::mean(self : NlpembedgloveSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpembedgloveSeries::min(self : NlpembedgloveSeries) -> Double { @_common.min(self.vals) }

pub fn NlpembedgloveSeries::max(self : NlpembedgloveSeries) -> Double { @_common.max(self.vals) }

pub fn NlpembedgloveSeries::range(self : NlpembedgloveSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpembedgloveSeries::variance(self : NlpembedgloveSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpembedgloveSeries::std(self : NlpembedgloveSeries) -> Double { @_common.std(self.vals) }

pub fn NlpembedgloveSeries::median(self : NlpembedgloveSeries) -> Double { @_common.median(self.vals) }

pub fn NlpembedgloveSeries::scale(self : NlpembedgloveSeries, f : Double) -> NlpembedgloveSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpembedgloveSeries::add(self : NlpembedgloveSeries, other : NlpembedgloveSeries) -> NlpembedgloveSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpembedgloveSeries::sub(self : NlpembedgloveSeries, other : NlpembedgloveSeries) -> NlpembedgloveSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpembedgloveSeries::normalize(self : NlpembedgloveSeries) -> NlpembedgloveSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpembedgloveSeries::cumsum(self : NlpembedgloveSeries) -> NlpembedgloveSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpembedgloveSeries::to_string(self : NlpembedgloveSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedgloveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_glove_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedgloveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_glove_matrix_identity(n : Int) -> NlpembedgloveMatrix {
  let m = nlp_embed_glove_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpembedgloveMatrix::get(self : NlpembedgloveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpembedgloveMatrix::transpose(self : NlpembedgloveMatrix) -> NlpembedgloveMatrix {
  let result = nlp_embed_glove_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpembedgloveMatrix::add(self : NlpembedgloveMatrix, other : NlpembedgloveMatrix) -> NlpembedgloveMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_glove_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpembedgloveMatrix::scale(self : NlpembedgloveMatrix, s : Double) -> NlpembedgloveMatrix {
  let result = nlp_embed_glove_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpembedgloveMatrix::multiply(self : NlpembedgloveMatrix, other : NlpembedgloveMatrix) -> NlpembedgloveMatrix {
  if self.cols != other.rows { return nlp_embed_glove_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_glove_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpembedgloveMatrix::trace(self : NlpembedgloveMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpembedgloveMatrix::det(self : NlpembedgloveMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpembedgloveMatrix::norm(self : NlpembedgloveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpembedgloveMatrix::to_string(self : NlpembedgloveMatrix) -> String {
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

pub(all) struct NlpembedgloveVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_glove_make_vector(comps : Array[Double]) -> NlpembedgloveVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_glove_vector_zero(dim : Int) -> NlpembedgloveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpembedgloveVector::add(self : NlpembedgloveVector, other : NlpembedgloveVector) -> NlpembedgloveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedgloveVector::sub(self : NlpembedgloveVector, other : NlpembedgloveVector) -> NlpembedgloveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedgloveVector::scale(self : NlpembedgloveVector, s : Double) -> NlpembedgloveVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpembedgloveVector::dot(self : NlpembedgloveVector, other : NlpembedgloveVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpembedgloveVector::norm(self : NlpembedgloveVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpembedgloveVector::normalize(self : NlpembedgloveVector) -> NlpembedgloveVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedgloveVector::dist(self : NlpembedgloveVector, other : NlpembedgloveVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpembedgloveVector::to_string(self : NlpembedgloveVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_glove_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_glove_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_glove_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_glove_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_glove_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_glove_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_glove_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_glove_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_glove_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_glove_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_glove_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_glove_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_glove_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_glove_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_glove_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_glove_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_glove_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_glove_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_glove_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_glove_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_glove_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_glove_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_glove_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_glove_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_glove_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_glove_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_glove_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_glove_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_glove_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpembedgloveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_frame_make(size : Int) -> NlpembedgloveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_frame_len(s : NlpembedgloveFrame) -> Int { s.size }

pub fn nlp_embed_glove_frame_get(s : NlpembedgloveFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_frame_set(s : NlpembedgloveFrame, i : Int, v : Double) -> NlpembedgloveFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_frame_sum(s : NlpembedgloveFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_glove_frame_mean(s : NlpembedgloveFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_glove_frame_scale(s : NlpembedgloveFrame, f : Double) -> NlpembedgloveFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_frame_add(a : NlpembedgloveFrame, b : NlpembedgloveFrame) -> NlpembedgloveFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_glove_frame_copy(s : NlpembedgloveFrame) -> NlpembedgloveFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_frame_fill(s : NlpembedgloveFrame, v : Double) -> NlpembedgloveFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_frame_min(s : NlpembedgloveFrame) -> Double { @_common.min(s.data) }

pub fn nlp_embed_glove_frame_max(s : NlpembedgloveFrame) -> Double { @_common.max(s.data) }

pub fn nlp_embed_glove_frame_to_string(s : NlpembedgloveFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_table_make(size : Int) -> NlpembedgloveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_table_len(s : NlpembedgloveTable) -> Int { s.size }

pub fn nlp_embed_glove_table_get(s : NlpembedgloveTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_table_set(s : NlpembedgloveTable, i : Int, v : Double) -> NlpembedgloveTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_table_sum(s : NlpembedgloveTable) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_glove_table_mean(s : NlpembedgloveTable) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_glove_table_scale(s : NlpembedgloveTable, f : Double) -> NlpembedgloveTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_table_add(a : NlpembedgloveTable, b : NlpembedgloveTable) -> NlpembedgloveTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_glove_table_copy(s : NlpembedgloveTable) -> NlpembedgloveTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_table_fill(s : NlpembedgloveTable, v : Double) -> NlpembedgloveTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_table_min(s : NlpembedgloveTable) -> Double { @_common.min(s.data) }

pub fn nlp_embed_glove_table_max(s : NlpembedgloveTable) -> Double { @_common.max(s.data) }

pub fn nlp_embed_glove_table_to_string(s : NlpembedgloveTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_graphn_make(size : Int) -> NlpembedgloveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_graphn_len(s : NlpembedgloveGraphN) -> Int { s.size }

pub fn nlp_embed_glove_graphn_get(s : NlpembedgloveGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_graphn_set(s : NlpembedgloveGraphN, i : Int, v : Double) -> NlpembedgloveGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_graphn_sum(s : NlpembedgloveGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_glove_graphn_mean(s : NlpembedgloveGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_glove_graphn_scale(s : NlpembedgloveGraphN, f : Double) -> NlpembedgloveGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_graphn_add(a : NlpembedgloveGraphN, b : NlpembedgloveGraphN) -> NlpembedgloveGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_glove_graphn_copy(s : NlpembedgloveGraphN) -> NlpembedgloveGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_graphn_fill(s : NlpembedgloveGraphN, v : Double) -> NlpembedgloveGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_graphn_min(s : NlpembedgloveGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_embed_glove_graphn_max(s : NlpembedgloveGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_embed_glove_graphn_to_string(s : NlpembedgloveGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_node_make(size : Int) -> NlpembedgloveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_node_len(s : NlpembedgloveNode) -> Int { s.size }

pub fn nlp_embed_glove_node_get(s : NlpembedgloveNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_node_set(s : NlpembedgloveNode, i : Int, v : Double) -> NlpembedgloveNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_node_sum(s : NlpembedgloveNode) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_glove_node_mean(s : NlpembedgloveNode) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_glove_node_scale(s : NlpembedgloveNode, f : Double) -> NlpembedgloveNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_node_add(a : NlpembedgloveNode, b : NlpembedgloveNode) -> NlpembedgloveNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_glove_node_copy(s : NlpembedgloveNode) -> NlpembedgloveNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_node_fill(s : NlpembedgloveNode, v : Double) -> NlpembedgloveNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_node_min(s : NlpembedgloveNode) -> Double { @_common.min(s.data) }

pub fn nlp_embed_glove_node_max(s : NlpembedgloveNode) -> Double { @_common.max(s.data) }

pub fn nlp_embed_glove_node_to_string(s : NlpembedgloveNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_edge_make(size : Int) -> NlpembedgloveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_edge_len(s : NlpembedgloveEdge) -> Int { s.size }

pub fn nlp_embed_glove_edge_get(s : NlpembedgloveEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_edge_set(s : NlpembedgloveEdge, i : Int, v : Double) -> NlpembedgloveEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_edge_sum(s : NlpembedgloveEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_glove_edge_mean(s : NlpembedgloveEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_glove_edge_scale(s : NlpembedgloveEdge, f : Double) -> NlpembedgloveEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_edge_add(a : NlpembedgloveEdge, b : NlpembedgloveEdge) -> NlpembedgloveEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_glove_edge_copy(s : NlpembedgloveEdge) -> NlpembedgloveEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_edge_fill(s : NlpembedgloveEdge, v : Double) -> NlpembedgloveEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_edge_min(s : NlpembedgloveEdge) -> Double { @_common.min(s.data) }

pub fn nlp_embed_glove_edge_max(s : NlpembedgloveEdge) -> Double { @_common.max(s.data) }

pub fn nlp_embed_glove_edge_to_string(s : NlpembedgloveEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedglovePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_path_make(size : Int) -> NlpembedglovePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_path_len(s : NlpembedglovePath) -> Int { s.size }

pub fn nlp_embed_glove_path_get(s : NlpembedglovePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_path_set(s : NlpembedglovePath, i : Int, v : Double) -> NlpembedglovePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_path_sum(s : NlpembedglovePath) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_glove_path_mean(s : NlpembedglovePath) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_glove_path_scale(s : NlpembedglovePath, f : Double) -> NlpembedglovePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_path_add(a : NlpembedglovePath, b : NlpembedglovePath) -> NlpembedglovePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_glove_path_copy(s : NlpembedglovePath) -> NlpembedglovePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_path_fill(s : NlpembedglovePath, v : Double) -> NlpembedglovePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_path_min(s : NlpembedglovePath) -> Double { @_common.min(s.data) }

pub fn nlp_embed_glove_path_max(s : NlpembedglovePath) -> Double { @_common.max(s.data) }

pub fn nlp_embed_glove_path_to_string(s : NlpembedglovePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_cluster_make(size : Int) -> NlpembedgloveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_cluster_len(s : NlpembedgloveCluster) -> Int { s.size }

pub fn nlp_embed_glove_cluster_get(s : NlpembedgloveCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_cluster_set(s : NlpembedgloveCluster, i : Int, v : Double) -> NlpembedgloveCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_cluster_sum(s : NlpembedgloveCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_glove_cluster_mean(s : NlpembedgloveCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_glove_cluster_scale(s : NlpembedgloveCluster, f : Double) -> NlpembedgloveCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_cluster_add(a : NlpembedgloveCluster, b : NlpembedgloveCluster) -> NlpembedgloveCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_glove_cluster_copy(s : NlpembedgloveCluster) -> NlpembedgloveCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_cluster_fill(s : NlpembedgloveCluster, v : Double) -> NlpembedgloveCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_cluster_min(s : NlpembedgloveCluster) -> Double { @_common.min(s.data) }

pub fn nlp_embed_glove_cluster_max(s : NlpembedgloveCluster) -> Double { @_common.max(s.data) }

pub fn nlp_embed_glove_cluster_to_string(s : NlpembedgloveCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_model_make(size : Int) -> NlpembedgloveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_model_len(s : NlpembedgloveModel) -> Int { s.size }

pub fn nlp_embed_glove_model_get(s : NlpembedgloveModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_model_set(s : NlpembedgloveModel, i : Int, v : Double) -> NlpembedgloveModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_model_sum(s : NlpembedgloveModel) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_glove_model_mean(s : NlpembedgloveModel) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_glove_model_scale(s : NlpembedgloveModel, f : Double) -> NlpembedgloveModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_model_add(a : NlpembedgloveModel, b : NlpembedgloveModel) -> NlpembedgloveModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_glove_model_copy(s : NlpembedgloveModel) -> NlpembedgloveModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_model_fill(s : NlpembedgloveModel, v : Double) -> NlpembedgloveModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_model_min(s : NlpembedgloveModel) -> Double { @_common.min(s.data) }

pub fn nlp_embed_glove_model_max(s : NlpembedgloveModel) -> Double { @_common.max(s.data) }

pub fn nlp_embed_glove_model_to_string(s : NlpembedgloveModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_layer_make(size : Int) -> NlpembedgloveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_layer_len(s : NlpembedgloveLayer) -> Int { s.size }

pub fn nlp_embed_glove_layer_get(s : NlpembedgloveLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_layer_set(s : NlpembedgloveLayer, i : Int, v : Double) -> NlpembedgloveLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_layer_sum(s : NlpembedgloveLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_glove_layer_mean(s : NlpembedgloveLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_glove_layer_scale(s : NlpembedgloveLayer, f : Double) -> NlpembedgloveLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_layer_add(a : NlpembedgloveLayer, b : NlpembedgloveLayer) -> NlpembedgloveLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_glove_layer_copy(s : NlpembedgloveLayer) -> NlpembedgloveLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_layer_fill(s : NlpembedgloveLayer, v : Double) -> NlpembedgloveLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_layer_min(s : NlpembedgloveLayer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_glove_layer_max(s : NlpembedgloveLayer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_glove_layer_to_string(s : NlpembedgloveLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_buffer_make(size : Int) -> NlpembedgloveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_buffer_len(s : NlpembedgloveBuffer) -> Int { s.size }

pub fn nlp_embed_glove_buffer_get(s : NlpembedgloveBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_buffer_set(s : NlpembedgloveBuffer, i : Int, v : Double) -> NlpembedgloveBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_buffer_sum(s : NlpembedgloveBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_glove_buffer_mean(s : NlpembedgloveBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_glove_buffer_scale(s : NlpembedgloveBuffer, f : Double) -> NlpembedgloveBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_buffer_add(a : NlpembedgloveBuffer, b : NlpembedgloveBuffer) -> NlpembedgloveBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_glove_buffer_copy(s : NlpembedgloveBuffer) -> NlpembedgloveBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_buffer_fill(s : NlpembedgloveBuffer, v : Double) -> NlpembedgloveBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_buffer_min(s : NlpembedgloveBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_glove_buffer_max(s : NlpembedgloveBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_glove_buffer_to_string(s : NlpembedgloveBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_cursor_make(size : Int) -> NlpembedgloveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_cursor_len(s : NlpembedgloveCursor) -> Int { s.size }

pub fn nlp_embed_glove_cursor_get(s : NlpembedgloveCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_cursor_set(s : NlpembedgloveCursor, i : Int, v : Double) -> NlpembedgloveCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_cursor_sum(s : NlpembedgloveCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_glove_cursor_mean(s : NlpembedgloveCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_glove_cursor_scale(s : NlpembedgloveCursor, f : Double) -> NlpembedgloveCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_cursor_add(a : NlpembedgloveCursor, b : NlpembedgloveCursor) -> NlpembedgloveCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_glove_cursor_copy(s : NlpembedgloveCursor) -> NlpembedgloveCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_cursor_fill(s : NlpembedgloveCursor, v : Double) -> NlpembedgloveCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_cursor_min(s : NlpembedgloveCursor) -> Double { @_common.min(s.data) }

pub fn nlp_embed_glove_cursor_max(s : NlpembedgloveCursor) -> Double { @_common.max(s.data) }

pub fn nlp_embed_glove_cursor_to_string(s : NlpembedgloveCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_view_make(size : Int) -> NlpembedgloveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_view_len(s : NlpembedgloveView) -> Int { s.size }

pub fn nlp_embed_glove_view_get(s : NlpembedgloveView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_view_set(s : NlpembedgloveView, i : Int, v : Double) -> NlpembedgloveView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_view_sum(s : NlpembedgloveView) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_glove_view_mean(s : NlpembedgloveView) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_glove_view_scale(s : NlpembedgloveView, f : Double) -> NlpembedgloveView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_view_add(a : NlpembedgloveView, b : NlpembedgloveView) -> NlpembedgloveView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_glove_view_copy(s : NlpembedgloveView) -> NlpembedgloveView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_view_fill(s : NlpembedgloveView, v : Double) -> NlpembedgloveView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_view_min(s : NlpembedgloveView) -> Double { @_common.min(s.data) }

pub fn nlp_embed_glove_view_max(s : NlpembedgloveView) -> Double { @_common.max(s.data) }

pub fn nlp_embed_glove_view_to_string(s : NlpembedgloveView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_range_make(size : Int) -> NlpembedgloveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_range_len(s : NlpembedgloveRange) -> Int { s.size }

pub fn nlp_embed_glove_range_get(s : NlpembedgloveRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_range_set(s : NlpembedgloveRange, i : Int, v : Double) -> NlpembedgloveRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_range_sum(s : NlpembedgloveRange) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_glove_range_mean(s : NlpembedgloveRange) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_glove_range_scale(s : NlpembedgloveRange, f : Double) -> NlpembedgloveRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_range_add(a : NlpembedgloveRange, b : NlpembedgloveRange) -> NlpembedgloveRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_glove_range_copy(s : NlpembedgloveRange) -> NlpembedgloveRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_range_fill(s : NlpembedgloveRange, v : Double) -> NlpembedgloveRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_range_min(s : NlpembedgloveRange) -> Double { @_common.min(s.data) }

pub fn nlp_embed_glove_range_max(s : NlpembedgloveRange) -> Double { @_common.max(s.data) }

pub fn nlp_embed_glove_range_to_string(s : NlpembedgloveRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedgloveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_glove_slice_make(size : Int) -> NlpembedgloveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_glove_slice_len(s : NlpembedgloveSlice) -> Int { s.size }

pub fn nlp_embed_glove_slice_get(s : NlpembedgloveSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_glove_slice_set(s : NlpembedgloveSlice, i : Int, v : Double) -> NlpembedgloveSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_slice_sum(s : NlpembedgloveSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_glove_slice_mean(s : NlpembedgloveSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_glove_slice_scale(s : NlpembedgloveSlice, f : Double) -> NlpembedgloveSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_slice_add(a : NlpembedgloveSlice, b : NlpembedgloveSlice) -> NlpembedgloveSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_glove_slice_copy(s : NlpembedgloveSlice) -> NlpembedgloveSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_slice_fill(s : NlpembedgloveSlice, v : Double) -> NlpembedgloveSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_glove_slice_min(s : NlpembedgloveSlice) -> Double { @_common.min(s.data) }

pub fn nlp_embed_glove_slice_max(s : NlpembedgloveSlice) -> Double { @_common.max(s.data) }

pub fn nlp_embed_glove_slice_to_string(s : NlpembedgloveSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

