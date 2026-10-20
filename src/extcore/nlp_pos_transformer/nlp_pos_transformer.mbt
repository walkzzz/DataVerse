///===
/// extcore/nlp_pos_transformer

pub(all) struct NlppostransformerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_transformer_make_point(x : Double, y : Double) -> NlppostransformerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_transformer_make_point3(x : Double, y : Double, z : Double) -> NlppostransformerPoint {
  { x, y, z, label: 0 }
}

pub fn NlppostransformerPoint::x(self : NlppostransformerPoint) -> Double { self.x }

pub fn NlppostransformerPoint::y(self : NlppostransformerPoint) -> Double { self.y }

pub fn NlppostransformerPoint::z(self : NlppostransformerPoint) -> Double { self.z }

pub fn NlppostransformerPoint::label(self : NlppostransformerPoint) -> Int { self.label }

pub fn NlppostransformerPoint::dist(self : NlppostransformerPoint, other : NlppostransformerPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlppostransformerPoint::add(self : NlppostransformerPoint, other : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlppostransformerPoint::sub(self : NlppostransformerPoint, other : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlppostransformerPoint::scale(self : NlppostransformerPoint, s : Double) -> NlppostransformerPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlppostransformerPoint::dot(self : NlppostransformerPoint, other : NlppostransformerPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlppostransformerPoint::cross(self : NlppostransformerPoint, other : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlppostransformerPoint::norm(self : NlppostransformerPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlppostransformerPoint::normalize(self : NlppostransformerPoint) -> NlppostransformerPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlppostransformerPoint::negate(self : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlppostransformerPoint::mid(self : NlppostransformerPoint, other : NlppostransformerPoint) -> NlppostransformerPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlppostransformerPoint::lerp(self : NlppostransformerPoint, other : NlppostransformerPoint, t : Double) -> NlppostransformerPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlppostransformerPoint::to_string(self : NlppostransformerPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlppostransformerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_transformer_make_series(vals : Array[Double], name : String) -> NlppostransformerSeries {
  { vals, name, meta: 0 }
}

pub fn NlppostransformerSeries::len(self : NlppostransformerSeries) -> Int { self.vals.length() }

pub fn NlppostransformerSeries::sum(self : NlppostransformerSeries) -> Double { @_common.sum(self.vals) }

pub fn NlppostransformerSeries::mean(self : NlppostransformerSeries) -> Double { @_common.mean(self.vals) }

pub fn NlppostransformerSeries::min(self : NlppostransformerSeries) -> Double { @_common.min(self.vals) }

pub fn NlppostransformerSeries::max(self : NlppostransformerSeries) -> Double { @_common.max(self.vals) }

pub fn NlppostransformerSeries::range(self : NlppostransformerSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlppostransformerSeries::variance(self : NlppostransformerSeries) -> Double { @_common.variance(self.vals) }

pub fn NlppostransformerSeries::std(self : NlppostransformerSeries) -> Double { @_common.std(self.vals) }

pub fn NlppostransformerSeries::median(self : NlppostransformerSeries) -> Double { @_common.median(self.vals) }

pub fn NlppostransformerSeries::scale(self : NlppostransformerSeries, f : Double) -> NlppostransformerSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlppostransformerSeries::add(self : NlppostransformerSeries, other : NlppostransformerSeries) -> NlppostransformerSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlppostransformerSeries::sub(self : NlppostransformerSeries, other : NlppostransformerSeries) -> NlppostransformerSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlppostransformerSeries::normalize(self : NlppostransformerSeries) -> NlppostransformerSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlppostransformerSeries::cumsum(self : NlppostransformerSeries) -> NlppostransformerSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlppostransformerSeries::to_string(self : NlppostransformerSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlppostransformerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_transformer_make_matrix(rows : Int, cols : Int, val : Double) -> NlppostransformerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_transformer_matrix_identity(n : Int) -> NlppostransformerMatrix {
  let m = nlp_pos_transformer_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlppostransformerMatrix::get(self : NlppostransformerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlppostransformerMatrix::transpose(self : NlppostransformerMatrix) -> NlppostransformerMatrix {
  let result = nlp_pos_transformer_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlppostransformerMatrix::add(self : NlppostransformerMatrix, other : NlppostransformerMatrix) -> NlppostransformerMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_transformer_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlppostransformerMatrix::scale(self : NlppostransformerMatrix, s : Double) -> NlppostransformerMatrix {
  let result = nlp_pos_transformer_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlppostransformerMatrix::multiply(self : NlppostransformerMatrix, other : NlppostransformerMatrix) -> NlppostransformerMatrix {
  if self.cols != other.rows { return nlp_pos_transformer_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_transformer_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlppostransformerMatrix::trace(self : NlppostransformerMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlppostransformerMatrix::det(self : NlppostransformerMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlppostransformerMatrix::norm(self : NlppostransformerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlppostransformerMatrix::to_string(self : NlppostransformerMatrix) -> String {
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

pub(all) struct NlppostransformerVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_transformer_make_vector(comps : Array[Double]) -> NlppostransformerVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_transformer_vector_zero(dim : Int) -> NlppostransformerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlppostransformerVector::add(self : NlppostransformerVector, other : NlppostransformerVector) -> NlppostransformerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlppostransformerVector::sub(self : NlppostransformerVector, other : NlppostransformerVector) -> NlppostransformerVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlppostransformerVector::scale(self : NlppostransformerVector, s : Double) -> NlppostransformerVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlppostransformerVector::dot(self : NlppostransformerVector, other : NlppostransformerVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlppostransformerVector::norm(self : NlppostransformerVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlppostransformerVector::normalize(self : NlppostransformerVector) -> NlppostransformerVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlppostransformerVector::dist(self : NlppostransformerVector, other : NlppostransformerVector) -> Double {
  self.sub(other).norm()
}

pub fn NlppostransformerVector::to_string(self : NlppostransformerVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_transformer_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_transformer_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_transformer_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_transformer_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_transformer_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_transformer_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_transformer_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_transformer_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_transformer_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_transformer_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_transformer_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_transformer_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_transformer_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_transformer_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_transformer_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_transformer_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_transformer_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_transformer_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_transformer_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_transformer_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_transformer_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_transformer_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_transformer_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_transformer_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_transformer_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_transformer_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_transformer_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_transformer_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_transformer_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlppostransformerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_frame_make(size : Int) -> NlppostransformerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_frame_len(s : NlppostransformerFrame) -> Int { s.size }

pub fn nlp_pos_transformer_frame_get(s : NlppostransformerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_frame_set(s : NlppostransformerFrame, i : Int, v : Double) -> NlppostransformerFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_frame_sum(s : NlppostransformerFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_transformer_frame_mean(s : NlppostransformerFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_transformer_frame_scale(s : NlppostransformerFrame, f : Double) -> NlppostransformerFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_frame_add(a : NlppostransformerFrame, b : NlppostransformerFrame) -> NlppostransformerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_transformer_frame_copy(s : NlppostransformerFrame) -> NlppostransformerFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_frame_fill(s : NlppostransformerFrame, v : Double) -> NlppostransformerFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_frame_min(s : NlppostransformerFrame) -> Double { @_common.min(s.data) }

pub fn nlp_pos_transformer_frame_max(s : NlppostransformerFrame) -> Double { @_common.max(s.data) }

pub fn nlp_pos_transformer_frame_to_string(s : NlppostransformerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_table_make(size : Int) -> NlppostransformerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_table_len(s : NlppostransformerTable) -> Int { s.size }

pub fn nlp_pos_transformer_table_get(s : NlppostransformerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_table_set(s : NlppostransformerTable, i : Int, v : Double) -> NlppostransformerTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_table_sum(s : NlppostransformerTable) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_transformer_table_mean(s : NlppostransformerTable) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_transformer_table_scale(s : NlppostransformerTable, f : Double) -> NlppostransformerTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_table_add(a : NlppostransformerTable, b : NlppostransformerTable) -> NlppostransformerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_transformer_table_copy(s : NlppostransformerTable) -> NlppostransformerTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_table_fill(s : NlppostransformerTable, v : Double) -> NlppostransformerTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_table_min(s : NlppostransformerTable) -> Double { @_common.min(s.data) }

pub fn nlp_pos_transformer_table_max(s : NlppostransformerTable) -> Double { @_common.max(s.data) }

pub fn nlp_pos_transformer_table_to_string(s : NlppostransformerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_graphn_make(size : Int) -> NlppostransformerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_graphn_len(s : NlppostransformerGraphN) -> Int { s.size }

pub fn nlp_pos_transformer_graphn_get(s : NlppostransformerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_graphn_set(s : NlppostransformerGraphN, i : Int, v : Double) -> NlppostransformerGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_graphn_sum(s : NlppostransformerGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_transformer_graphn_mean(s : NlppostransformerGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_transformer_graphn_scale(s : NlppostransformerGraphN, f : Double) -> NlppostransformerGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_graphn_add(a : NlppostransformerGraphN, b : NlppostransformerGraphN) -> NlppostransformerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_transformer_graphn_copy(s : NlppostransformerGraphN) -> NlppostransformerGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_graphn_fill(s : NlppostransformerGraphN, v : Double) -> NlppostransformerGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_graphn_min(s : NlppostransformerGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_pos_transformer_graphn_max(s : NlppostransformerGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_pos_transformer_graphn_to_string(s : NlppostransformerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_node_make(size : Int) -> NlppostransformerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_node_len(s : NlppostransformerNode) -> Int { s.size }

pub fn nlp_pos_transformer_node_get(s : NlppostransformerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_node_set(s : NlppostransformerNode, i : Int, v : Double) -> NlppostransformerNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_node_sum(s : NlppostransformerNode) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_transformer_node_mean(s : NlppostransformerNode) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_transformer_node_scale(s : NlppostransformerNode, f : Double) -> NlppostransformerNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_node_add(a : NlppostransformerNode, b : NlppostransformerNode) -> NlppostransformerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_transformer_node_copy(s : NlppostransformerNode) -> NlppostransformerNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_node_fill(s : NlppostransformerNode, v : Double) -> NlppostransformerNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_node_min(s : NlppostransformerNode) -> Double { @_common.min(s.data) }

pub fn nlp_pos_transformer_node_max(s : NlppostransformerNode) -> Double { @_common.max(s.data) }

pub fn nlp_pos_transformer_node_to_string(s : NlppostransformerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_edge_make(size : Int) -> NlppostransformerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_edge_len(s : NlppostransformerEdge) -> Int { s.size }

pub fn nlp_pos_transformer_edge_get(s : NlppostransformerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_edge_set(s : NlppostransformerEdge, i : Int, v : Double) -> NlppostransformerEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_edge_sum(s : NlppostransformerEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_transformer_edge_mean(s : NlppostransformerEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_transformer_edge_scale(s : NlppostransformerEdge, f : Double) -> NlppostransformerEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_edge_add(a : NlppostransformerEdge, b : NlppostransformerEdge) -> NlppostransformerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_transformer_edge_copy(s : NlppostransformerEdge) -> NlppostransformerEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_edge_fill(s : NlppostransformerEdge, v : Double) -> NlppostransformerEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_edge_min(s : NlppostransformerEdge) -> Double { @_common.min(s.data) }

pub fn nlp_pos_transformer_edge_max(s : NlppostransformerEdge) -> Double { @_common.max(s.data) }

pub fn nlp_pos_transformer_edge_to_string(s : NlppostransformerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_path_make(size : Int) -> NlppostransformerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_path_len(s : NlppostransformerPath) -> Int { s.size }

pub fn nlp_pos_transformer_path_get(s : NlppostransformerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_path_set(s : NlppostransformerPath, i : Int, v : Double) -> NlppostransformerPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_path_sum(s : NlppostransformerPath) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_transformer_path_mean(s : NlppostransformerPath) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_transformer_path_scale(s : NlppostransformerPath, f : Double) -> NlppostransformerPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_path_add(a : NlppostransformerPath, b : NlppostransformerPath) -> NlppostransformerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_transformer_path_copy(s : NlppostransformerPath) -> NlppostransformerPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_path_fill(s : NlppostransformerPath, v : Double) -> NlppostransformerPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_path_min(s : NlppostransformerPath) -> Double { @_common.min(s.data) }

pub fn nlp_pos_transformer_path_max(s : NlppostransformerPath) -> Double { @_common.max(s.data) }

pub fn nlp_pos_transformer_path_to_string(s : NlppostransformerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_cluster_make(size : Int) -> NlppostransformerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_cluster_len(s : NlppostransformerCluster) -> Int { s.size }

pub fn nlp_pos_transformer_cluster_get(s : NlppostransformerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_cluster_set(s : NlppostransformerCluster, i : Int, v : Double) -> NlppostransformerCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_cluster_sum(s : NlppostransformerCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_transformer_cluster_mean(s : NlppostransformerCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_transformer_cluster_scale(s : NlppostransformerCluster, f : Double) -> NlppostransformerCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_cluster_add(a : NlppostransformerCluster, b : NlppostransformerCluster) -> NlppostransformerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_transformer_cluster_copy(s : NlppostransformerCluster) -> NlppostransformerCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_cluster_fill(s : NlppostransformerCluster, v : Double) -> NlppostransformerCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_cluster_min(s : NlppostransformerCluster) -> Double { @_common.min(s.data) }

pub fn nlp_pos_transformer_cluster_max(s : NlppostransformerCluster) -> Double { @_common.max(s.data) }

pub fn nlp_pos_transformer_cluster_to_string(s : NlppostransformerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_model_make(size : Int) -> NlppostransformerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_model_len(s : NlppostransformerModel) -> Int { s.size }

pub fn nlp_pos_transformer_model_get(s : NlppostransformerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_model_set(s : NlppostransformerModel, i : Int, v : Double) -> NlppostransformerModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_model_sum(s : NlppostransformerModel) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_transformer_model_mean(s : NlppostransformerModel) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_transformer_model_scale(s : NlppostransformerModel, f : Double) -> NlppostransformerModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_model_add(a : NlppostransformerModel, b : NlppostransformerModel) -> NlppostransformerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_transformer_model_copy(s : NlppostransformerModel) -> NlppostransformerModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_model_fill(s : NlppostransformerModel, v : Double) -> NlppostransformerModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_model_min(s : NlppostransformerModel) -> Double { @_common.min(s.data) }

pub fn nlp_pos_transformer_model_max(s : NlppostransformerModel) -> Double { @_common.max(s.data) }

pub fn nlp_pos_transformer_model_to_string(s : NlppostransformerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_layer_make(size : Int) -> NlppostransformerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_layer_len(s : NlppostransformerLayer) -> Int { s.size }

pub fn nlp_pos_transformer_layer_get(s : NlppostransformerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_layer_set(s : NlppostransformerLayer, i : Int, v : Double) -> NlppostransformerLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_layer_sum(s : NlppostransformerLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_transformer_layer_mean(s : NlppostransformerLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_transformer_layer_scale(s : NlppostransformerLayer, f : Double) -> NlppostransformerLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_layer_add(a : NlppostransformerLayer, b : NlppostransformerLayer) -> NlppostransformerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_transformer_layer_copy(s : NlppostransformerLayer) -> NlppostransformerLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_layer_fill(s : NlppostransformerLayer, v : Double) -> NlppostransformerLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_layer_min(s : NlppostransformerLayer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_transformer_layer_max(s : NlppostransformerLayer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_transformer_layer_to_string(s : NlppostransformerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_buffer_make(size : Int) -> NlppostransformerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_buffer_len(s : NlppostransformerBuffer) -> Int { s.size }

pub fn nlp_pos_transformer_buffer_get(s : NlppostransformerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_buffer_set(s : NlppostransformerBuffer, i : Int, v : Double) -> NlppostransformerBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_buffer_sum(s : NlppostransformerBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_transformer_buffer_mean(s : NlppostransformerBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_transformer_buffer_scale(s : NlppostransformerBuffer, f : Double) -> NlppostransformerBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_buffer_add(a : NlppostransformerBuffer, b : NlppostransformerBuffer) -> NlppostransformerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_transformer_buffer_copy(s : NlppostransformerBuffer) -> NlppostransformerBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_buffer_fill(s : NlppostransformerBuffer, v : Double) -> NlppostransformerBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_buffer_min(s : NlppostransformerBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_pos_transformer_buffer_max(s : NlppostransformerBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_pos_transformer_buffer_to_string(s : NlppostransformerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_cursor_make(size : Int) -> NlppostransformerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_cursor_len(s : NlppostransformerCursor) -> Int { s.size }

pub fn nlp_pos_transformer_cursor_get(s : NlppostransformerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_cursor_set(s : NlppostransformerCursor, i : Int, v : Double) -> NlppostransformerCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_cursor_sum(s : NlppostransformerCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_transformer_cursor_mean(s : NlppostransformerCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_transformer_cursor_scale(s : NlppostransformerCursor, f : Double) -> NlppostransformerCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_cursor_add(a : NlppostransformerCursor, b : NlppostransformerCursor) -> NlppostransformerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_transformer_cursor_copy(s : NlppostransformerCursor) -> NlppostransformerCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_cursor_fill(s : NlppostransformerCursor, v : Double) -> NlppostransformerCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_cursor_min(s : NlppostransformerCursor) -> Double { @_common.min(s.data) }

pub fn nlp_pos_transformer_cursor_max(s : NlppostransformerCursor) -> Double { @_common.max(s.data) }

pub fn nlp_pos_transformer_cursor_to_string(s : NlppostransformerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_view_make(size : Int) -> NlppostransformerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_view_len(s : NlppostransformerView) -> Int { s.size }

pub fn nlp_pos_transformer_view_get(s : NlppostransformerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_view_set(s : NlppostransformerView, i : Int, v : Double) -> NlppostransformerView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_view_sum(s : NlppostransformerView) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_transformer_view_mean(s : NlppostransformerView) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_transformer_view_scale(s : NlppostransformerView, f : Double) -> NlppostransformerView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_view_add(a : NlppostransformerView, b : NlppostransformerView) -> NlppostransformerView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_transformer_view_copy(s : NlppostransformerView) -> NlppostransformerView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_view_fill(s : NlppostransformerView, v : Double) -> NlppostransformerView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_view_min(s : NlppostransformerView) -> Double { @_common.min(s.data) }

pub fn nlp_pos_transformer_view_max(s : NlppostransformerView) -> Double { @_common.max(s.data) }

pub fn nlp_pos_transformer_view_to_string(s : NlppostransformerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_range_make(size : Int) -> NlppostransformerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_range_len(s : NlppostransformerRange) -> Int { s.size }

pub fn nlp_pos_transformer_range_get(s : NlppostransformerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_range_set(s : NlppostransformerRange, i : Int, v : Double) -> NlppostransformerRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_range_sum(s : NlppostransformerRange) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_transformer_range_mean(s : NlppostransformerRange) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_transformer_range_scale(s : NlppostransformerRange, f : Double) -> NlppostransformerRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_range_add(a : NlppostransformerRange, b : NlppostransformerRange) -> NlppostransformerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_transformer_range_copy(s : NlppostransformerRange) -> NlppostransformerRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_range_fill(s : NlppostransformerRange, v : Double) -> NlppostransformerRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_range_min(s : NlppostransformerRange) -> Double { @_common.min(s.data) }

pub fn nlp_pos_transformer_range_max(s : NlppostransformerRange) -> Double { @_common.max(s.data) }

pub fn nlp_pos_transformer_range_to_string(s : NlppostransformerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostransformerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_transformer_slice_make(size : Int) -> NlppostransformerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_transformer_slice_len(s : NlppostransformerSlice) -> Int { s.size }

pub fn nlp_pos_transformer_slice_get(s : NlppostransformerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_transformer_slice_set(s : NlppostransformerSlice, i : Int, v : Double) -> NlppostransformerSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_slice_sum(s : NlppostransformerSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_pos_transformer_slice_mean(s : NlppostransformerSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_pos_transformer_slice_scale(s : NlppostransformerSlice, f : Double) -> NlppostransformerSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_slice_add(a : NlppostransformerSlice, b : NlppostransformerSlice) -> NlppostransformerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_pos_transformer_slice_copy(s : NlppostransformerSlice) -> NlppostransformerSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_slice_fill(s : NlppostransformerSlice, v : Double) -> NlppostransformerSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_pos_transformer_slice_min(s : NlppostransformerSlice) -> Double { @_common.min(s.data) }

pub fn nlp_pos_transformer_slice_max(s : NlppostransformerSlice) -> Double { @_common.max(s.data) }

pub fn nlp_pos_transformer_slice_to_string(s : NlppostransformerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

