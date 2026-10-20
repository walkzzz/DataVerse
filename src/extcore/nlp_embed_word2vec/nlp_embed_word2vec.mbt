///===
/// extcore/nlp_embed_word2vec

pub(all) struct Nlpembedword2vecPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_word2vec_make_point(x : Double, y : Double) -> Nlpembedword2vecPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_word2vec_make_point3(x : Double, y : Double, z : Double) -> Nlpembedword2vecPoint {
  { x, y, z, label: 0 }
}

pub fn Nlpembedword2vecPoint::x(self : Nlpembedword2vecPoint) -> Double { self.x }

pub fn Nlpembedword2vecPoint::y(self : Nlpembedword2vecPoint) -> Double { self.y }

pub fn Nlpembedword2vecPoint::z(self : Nlpembedword2vecPoint) -> Double { self.z }

pub fn Nlpembedword2vecPoint::label(self : Nlpembedword2vecPoint) -> Int { self.label }

pub fn Nlpembedword2vecPoint::dist(self : Nlpembedword2vecPoint, other : Nlpembedword2vecPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Nlpembedword2vecPoint::add(self : Nlpembedword2vecPoint, other : Nlpembedword2vecPoint) -> Nlpembedword2vecPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Nlpembedword2vecPoint::sub(self : Nlpembedword2vecPoint, other : Nlpembedword2vecPoint) -> Nlpembedword2vecPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Nlpembedword2vecPoint::scale(self : Nlpembedword2vecPoint, s : Double) -> Nlpembedword2vecPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Nlpembedword2vecPoint::dot(self : Nlpembedword2vecPoint, other : Nlpembedword2vecPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Nlpembedword2vecPoint::cross(self : Nlpembedword2vecPoint, other : Nlpembedword2vecPoint) -> Nlpembedword2vecPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Nlpembedword2vecPoint::norm(self : Nlpembedword2vecPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Nlpembedword2vecPoint::normalize(self : Nlpembedword2vecPoint) -> Nlpembedword2vecPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Nlpembedword2vecPoint::negate(self : Nlpembedword2vecPoint) -> Nlpembedword2vecPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Nlpembedword2vecPoint::mid(self : Nlpembedword2vecPoint, other : Nlpembedword2vecPoint) -> Nlpembedword2vecPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Nlpembedword2vecPoint::lerp(self : Nlpembedword2vecPoint, other : Nlpembedword2vecPoint, t : Double) -> Nlpembedword2vecPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Nlpembedword2vecPoint::to_string(self : Nlpembedword2vecPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Nlpembedword2vecSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_word2vec_make_series(vals : Array[Double], name : String) -> Nlpembedword2vecSeries {
  { vals, name, meta: 0 }
}

pub fn Nlpembedword2vecSeries::len(self : Nlpembedword2vecSeries) -> Int { self.vals.length() }

pub fn Nlpembedword2vecSeries::sum(self : Nlpembedword2vecSeries) -> Double { @_common.sum(self.vals) }

pub fn Nlpembedword2vecSeries::mean(self : Nlpembedword2vecSeries) -> Double { @_common.mean(self.vals) }

pub fn Nlpembedword2vecSeries::min(self : Nlpembedword2vecSeries) -> Double { @_common.min(self.vals) }

pub fn Nlpembedword2vecSeries::max(self : Nlpembedword2vecSeries) -> Double { @_common.max(self.vals) }

pub fn Nlpembedword2vecSeries::range(self : Nlpembedword2vecSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Nlpembedword2vecSeries::variance(self : Nlpembedword2vecSeries) -> Double { @_common.variance(self.vals) }

pub fn Nlpembedword2vecSeries::std(self : Nlpembedword2vecSeries) -> Double { @_common.std(self.vals) }

pub fn Nlpembedword2vecSeries::median(self : Nlpembedword2vecSeries) -> Double { @_common.median(self.vals) }

pub fn Nlpembedword2vecSeries::scale(self : Nlpembedword2vecSeries, f : Double) -> Nlpembedword2vecSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Nlpembedword2vecSeries::add(self : Nlpembedword2vecSeries, other : Nlpembedword2vecSeries) -> Nlpembedword2vecSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Nlpembedword2vecSeries::sub(self : Nlpembedword2vecSeries, other : Nlpembedword2vecSeries) -> Nlpembedword2vecSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Nlpembedword2vecSeries::normalize(self : Nlpembedword2vecSeries) -> Nlpembedword2vecSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Nlpembedword2vecSeries::cumsum(self : Nlpembedword2vecSeries) -> Nlpembedword2vecSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Nlpembedword2vecSeries::to_string(self : Nlpembedword2vecSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Nlpembedword2vecMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_word2vec_make_matrix(rows : Int, cols : Int, val : Double) -> Nlpembedword2vecMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_word2vec_matrix_identity(n : Int) -> Nlpembedword2vecMatrix {
  let m = nlp_embed_word2vec_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Nlpembedword2vecMatrix::get(self : Nlpembedword2vecMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Nlpembedword2vecMatrix::transpose(self : Nlpembedword2vecMatrix) -> Nlpembedword2vecMatrix {
  let result = nlp_embed_word2vec_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Nlpembedword2vecMatrix::add(self : Nlpembedword2vecMatrix, other : Nlpembedword2vecMatrix) -> Nlpembedword2vecMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_word2vec_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Nlpembedword2vecMatrix::scale(self : Nlpembedword2vecMatrix, s : Double) -> Nlpembedword2vecMatrix {
  let result = nlp_embed_word2vec_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Nlpembedword2vecMatrix::multiply(self : Nlpembedword2vecMatrix, other : Nlpembedword2vecMatrix) -> Nlpembedword2vecMatrix {
  if self.cols != other.rows { return nlp_embed_word2vec_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_word2vec_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Nlpembedword2vecMatrix::trace(self : Nlpembedword2vecMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Nlpembedword2vecMatrix::det(self : Nlpembedword2vecMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Nlpembedword2vecMatrix::norm(self : Nlpembedword2vecMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Nlpembedword2vecMatrix::to_string(self : Nlpembedword2vecMatrix) -> String {
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

pub(all) struct Nlpembedword2vecVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_word2vec_make_vector(comps : Array[Double]) -> Nlpembedword2vecVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_word2vec_vector_zero(dim : Int) -> Nlpembedword2vecVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Nlpembedword2vecVector::add(self : Nlpembedword2vecVector, other : Nlpembedword2vecVector) -> Nlpembedword2vecVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Nlpembedword2vecVector::sub(self : Nlpembedword2vecVector, other : Nlpembedword2vecVector) -> Nlpembedword2vecVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Nlpembedword2vecVector::scale(self : Nlpembedword2vecVector, s : Double) -> Nlpembedword2vecVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Nlpembedword2vecVector::dot(self : Nlpembedword2vecVector, other : Nlpembedword2vecVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Nlpembedword2vecVector::norm(self : Nlpembedword2vecVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Nlpembedword2vecVector::normalize(self : Nlpembedword2vecVector) -> Nlpembedword2vecVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Nlpembedword2vecVector::dist(self : Nlpembedword2vecVector, other : Nlpembedword2vecVector) -> Double {
  self.sub(other).norm()
}

pub fn Nlpembedword2vecVector::to_string(self : Nlpembedword2vecVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_word2vec_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_word2vec_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_word2vec_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_word2vec_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_word2vec_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_word2vec_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_word2vec_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_word2vec_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_word2vec_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_word2vec_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_word2vec_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_word2vec_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_word2vec_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_word2vec_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_word2vec_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_word2vec_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_word2vec_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_word2vec_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_word2vec_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_word2vec_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_word2vec_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_word2vec_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_word2vec_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_word2vec_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_word2vec_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_word2vec_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_word2vec_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_word2vec_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_word2vec_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Nlpembedword2vecFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_word2vec_frame_make(size : Int) -> Nlpembedword2vecFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_word2vec_frame_len(s : Nlpembedword2vecFrame) -> Int { s.size }

pub fn nlp_embed_word2vec_frame_get(s : Nlpembedword2vecFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_word2vec_frame_set(s : Nlpembedword2vecFrame, i : Int, v : Double) -> Nlpembedword2vecFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_frame_sum(s : Nlpembedword2vecFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_word2vec_frame_mean(s : Nlpembedword2vecFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_word2vec_frame_scale(s : Nlpembedword2vecFrame, f : Double) -> Nlpembedword2vecFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_frame_add(a : Nlpembedword2vecFrame, b : Nlpembedword2vecFrame) -> Nlpembedword2vecFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_word2vec_frame_copy(s : Nlpembedword2vecFrame) -> Nlpembedword2vecFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_frame_fill(s : Nlpembedword2vecFrame, v : Double) -> Nlpembedword2vecFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_frame_min(s : Nlpembedword2vecFrame) -> Double { @_common.min(s.data) }

pub fn nlp_embed_word2vec_frame_max(s : Nlpembedword2vecFrame) -> Double { @_common.max(s.data) }

pub fn nlp_embed_word2vec_frame_to_string(s : Nlpembedword2vecFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedword2vecTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_word2vec_table_make(size : Int) -> Nlpembedword2vecTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_word2vec_table_len(s : Nlpembedword2vecTable) -> Int { s.size }

pub fn nlp_embed_word2vec_table_get(s : Nlpembedword2vecTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_word2vec_table_set(s : Nlpembedword2vecTable, i : Int, v : Double) -> Nlpembedword2vecTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_table_sum(s : Nlpembedword2vecTable) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_word2vec_table_mean(s : Nlpembedword2vecTable) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_word2vec_table_scale(s : Nlpembedword2vecTable, f : Double) -> Nlpembedword2vecTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_table_add(a : Nlpembedword2vecTable, b : Nlpembedword2vecTable) -> Nlpembedword2vecTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_word2vec_table_copy(s : Nlpembedword2vecTable) -> Nlpembedword2vecTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_table_fill(s : Nlpembedword2vecTable, v : Double) -> Nlpembedword2vecTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_table_min(s : Nlpembedword2vecTable) -> Double { @_common.min(s.data) }

pub fn nlp_embed_word2vec_table_max(s : Nlpembedword2vecTable) -> Double { @_common.max(s.data) }

pub fn nlp_embed_word2vec_table_to_string(s : Nlpembedword2vecTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedword2vecGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_word2vec_graphn_make(size : Int) -> Nlpembedword2vecGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_word2vec_graphn_len(s : Nlpembedword2vecGraphN) -> Int { s.size }

pub fn nlp_embed_word2vec_graphn_get(s : Nlpembedword2vecGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_word2vec_graphn_set(s : Nlpembedword2vecGraphN, i : Int, v : Double) -> Nlpembedword2vecGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_graphn_sum(s : Nlpembedword2vecGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_word2vec_graphn_mean(s : Nlpembedword2vecGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_word2vec_graphn_scale(s : Nlpembedword2vecGraphN, f : Double) -> Nlpembedword2vecGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_graphn_add(a : Nlpembedword2vecGraphN, b : Nlpembedword2vecGraphN) -> Nlpembedword2vecGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_word2vec_graphn_copy(s : Nlpembedword2vecGraphN) -> Nlpembedword2vecGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_graphn_fill(s : Nlpembedword2vecGraphN, v : Double) -> Nlpembedword2vecGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_graphn_min(s : Nlpembedword2vecGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_embed_word2vec_graphn_max(s : Nlpembedword2vecGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_embed_word2vec_graphn_to_string(s : Nlpembedword2vecGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedword2vecNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_word2vec_node_make(size : Int) -> Nlpembedword2vecNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_word2vec_node_len(s : Nlpembedword2vecNode) -> Int { s.size }

pub fn nlp_embed_word2vec_node_get(s : Nlpembedword2vecNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_word2vec_node_set(s : Nlpembedword2vecNode, i : Int, v : Double) -> Nlpembedword2vecNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_node_sum(s : Nlpembedword2vecNode) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_word2vec_node_mean(s : Nlpembedword2vecNode) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_word2vec_node_scale(s : Nlpembedword2vecNode, f : Double) -> Nlpembedword2vecNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_node_add(a : Nlpembedword2vecNode, b : Nlpembedword2vecNode) -> Nlpembedword2vecNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_word2vec_node_copy(s : Nlpembedword2vecNode) -> Nlpembedword2vecNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_node_fill(s : Nlpembedword2vecNode, v : Double) -> Nlpembedword2vecNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_node_min(s : Nlpembedword2vecNode) -> Double { @_common.min(s.data) }

pub fn nlp_embed_word2vec_node_max(s : Nlpembedword2vecNode) -> Double { @_common.max(s.data) }

pub fn nlp_embed_word2vec_node_to_string(s : Nlpembedword2vecNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedword2vecEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_word2vec_edge_make(size : Int) -> Nlpembedword2vecEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_word2vec_edge_len(s : Nlpembedword2vecEdge) -> Int { s.size }

pub fn nlp_embed_word2vec_edge_get(s : Nlpembedword2vecEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_word2vec_edge_set(s : Nlpembedword2vecEdge, i : Int, v : Double) -> Nlpembedword2vecEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_edge_sum(s : Nlpembedword2vecEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_word2vec_edge_mean(s : Nlpembedword2vecEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_word2vec_edge_scale(s : Nlpembedword2vecEdge, f : Double) -> Nlpembedword2vecEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_edge_add(a : Nlpembedword2vecEdge, b : Nlpembedword2vecEdge) -> Nlpembedword2vecEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_word2vec_edge_copy(s : Nlpembedword2vecEdge) -> Nlpembedword2vecEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_edge_fill(s : Nlpembedword2vecEdge, v : Double) -> Nlpembedword2vecEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_edge_min(s : Nlpembedword2vecEdge) -> Double { @_common.min(s.data) }

pub fn nlp_embed_word2vec_edge_max(s : Nlpembedword2vecEdge) -> Double { @_common.max(s.data) }

pub fn nlp_embed_word2vec_edge_to_string(s : Nlpembedword2vecEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedword2vecPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_word2vec_path_make(size : Int) -> Nlpembedword2vecPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_word2vec_path_len(s : Nlpembedword2vecPath) -> Int { s.size }

pub fn nlp_embed_word2vec_path_get(s : Nlpembedword2vecPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_word2vec_path_set(s : Nlpembedword2vecPath, i : Int, v : Double) -> Nlpembedword2vecPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_path_sum(s : Nlpembedword2vecPath) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_word2vec_path_mean(s : Nlpembedword2vecPath) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_word2vec_path_scale(s : Nlpembedword2vecPath, f : Double) -> Nlpembedword2vecPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_path_add(a : Nlpembedword2vecPath, b : Nlpembedword2vecPath) -> Nlpembedword2vecPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_word2vec_path_copy(s : Nlpembedword2vecPath) -> Nlpembedword2vecPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_path_fill(s : Nlpembedword2vecPath, v : Double) -> Nlpembedword2vecPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_path_min(s : Nlpembedword2vecPath) -> Double { @_common.min(s.data) }

pub fn nlp_embed_word2vec_path_max(s : Nlpembedword2vecPath) -> Double { @_common.max(s.data) }

pub fn nlp_embed_word2vec_path_to_string(s : Nlpembedword2vecPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedword2vecCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_word2vec_cluster_make(size : Int) -> Nlpembedword2vecCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_word2vec_cluster_len(s : Nlpembedword2vecCluster) -> Int { s.size }

pub fn nlp_embed_word2vec_cluster_get(s : Nlpembedword2vecCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_word2vec_cluster_set(s : Nlpembedword2vecCluster, i : Int, v : Double) -> Nlpembedword2vecCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_cluster_sum(s : Nlpembedword2vecCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_word2vec_cluster_mean(s : Nlpembedword2vecCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_word2vec_cluster_scale(s : Nlpembedword2vecCluster, f : Double) -> Nlpembedword2vecCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_cluster_add(a : Nlpembedword2vecCluster, b : Nlpembedword2vecCluster) -> Nlpembedword2vecCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_word2vec_cluster_copy(s : Nlpembedword2vecCluster) -> Nlpembedword2vecCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_cluster_fill(s : Nlpembedword2vecCluster, v : Double) -> Nlpembedword2vecCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_cluster_min(s : Nlpembedword2vecCluster) -> Double { @_common.min(s.data) }

pub fn nlp_embed_word2vec_cluster_max(s : Nlpembedword2vecCluster) -> Double { @_common.max(s.data) }

pub fn nlp_embed_word2vec_cluster_to_string(s : Nlpembedword2vecCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedword2vecModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_word2vec_model_make(size : Int) -> Nlpembedword2vecModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_word2vec_model_len(s : Nlpembedword2vecModel) -> Int { s.size }

pub fn nlp_embed_word2vec_model_get(s : Nlpembedword2vecModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_word2vec_model_set(s : Nlpembedword2vecModel, i : Int, v : Double) -> Nlpembedword2vecModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_model_sum(s : Nlpembedword2vecModel) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_word2vec_model_mean(s : Nlpembedword2vecModel) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_word2vec_model_scale(s : Nlpembedword2vecModel, f : Double) -> Nlpembedword2vecModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_model_add(a : Nlpembedword2vecModel, b : Nlpembedword2vecModel) -> Nlpembedword2vecModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_word2vec_model_copy(s : Nlpembedword2vecModel) -> Nlpembedword2vecModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_model_fill(s : Nlpembedword2vecModel, v : Double) -> Nlpembedword2vecModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_model_min(s : Nlpembedword2vecModel) -> Double { @_common.min(s.data) }

pub fn nlp_embed_word2vec_model_max(s : Nlpembedword2vecModel) -> Double { @_common.max(s.data) }

pub fn nlp_embed_word2vec_model_to_string(s : Nlpembedword2vecModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedword2vecLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_word2vec_layer_make(size : Int) -> Nlpembedword2vecLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_word2vec_layer_len(s : Nlpembedword2vecLayer) -> Int { s.size }

pub fn nlp_embed_word2vec_layer_get(s : Nlpembedword2vecLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_word2vec_layer_set(s : Nlpembedword2vecLayer, i : Int, v : Double) -> Nlpembedword2vecLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_layer_sum(s : Nlpembedword2vecLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_word2vec_layer_mean(s : Nlpembedword2vecLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_word2vec_layer_scale(s : Nlpembedword2vecLayer, f : Double) -> Nlpembedword2vecLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_layer_add(a : Nlpembedword2vecLayer, b : Nlpembedword2vecLayer) -> Nlpembedword2vecLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_word2vec_layer_copy(s : Nlpembedword2vecLayer) -> Nlpembedword2vecLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_layer_fill(s : Nlpembedword2vecLayer, v : Double) -> Nlpembedword2vecLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_layer_min(s : Nlpembedword2vecLayer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_word2vec_layer_max(s : Nlpembedword2vecLayer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_word2vec_layer_to_string(s : Nlpembedword2vecLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedword2vecBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_word2vec_buffer_make(size : Int) -> Nlpembedword2vecBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_word2vec_buffer_len(s : Nlpembedword2vecBuffer) -> Int { s.size }

pub fn nlp_embed_word2vec_buffer_get(s : Nlpembedword2vecBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_word2vec_buffer_set(s : Nlpembedword2vecBuffer, i : Int, v : Double) -> Nlpembedword2vecBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_buffer_sum(s : Nlpembedword2vecBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_word2vec_buffer_mean(s : Nlpembedword2vecBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_word2vec_buffer_scale(s : Nlpembedword2vecBuffer, f : Double) -> Nlpembedword2vecBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_buffer_add(a : Nlpembedword2vecBuffer, b : Nlpembedword2vecBuffer) -> Nlpembedword2vecBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_word2vec_buffer_copy(s : Nlpembedword2vecBuffer) -> Nlpembedword2vecBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_buffer_fill(s : Nlpembedword2vecBuffer, v : Double) -> Nlpembedword2vecBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_buffer_min(s : Nlpembedword2vecBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_word2vec_buffer_max(s : Nlpembedword2vecBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_word2vec_buffer_to_string(s : Nlpembedword2vecBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedword2vecCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_word2vec_cursor_make(size : Int) -> Nlpembedword2vecCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_word2vec_cursor_len(s : Nlpembedword2vecCursor) -> Int { s.size }

pub fn nlp_embed_word2vec_cursor_get(s : Nlpembedword2vecCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_word2vec_cursor_set(s : Nlpembedword2vecCursor, i : Int, v : Double) -> Nlpembedword2vecCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_cursor_sum(s : Nlpembedword2vecCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_word2vec_cursor_mean(s : Nlpembedword2vecCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_word2vec_cursor_scale(s : Nlpembedword2vecCursor, f : Double) -> Nlpembedword2vecCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_cursor_add(a : Nlpembedword2vecCursor, b : Nlpembedword2vecCursor) -> Nlpembedword2vecCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_word2vec_cursor_copy(s : Nlpembedword2vecCursor) -> Nlpembedword2vecCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_cursor_fill(s : Nlpembedword2vecCursor, v : Double) -> Nlpembedword2vecCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_cursor_min(s : Nlpembedword2vecCursor) -> Double { @_common.min(s.data) }

pub fn nlp_embed_word2vec_cursor_max(s : Nlpembedword2vecCursor) -> Double { @_common.max(s.data) }

pub fn nlp_embed_word2vec_cursor_to_string(s : Nlpembedword2vecCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedword2vecView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_word2vec_view_make(size : Int) -> Nlpembedword2vecView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_word2vec_view_len(s : Nlpembedword2vecView) -> Int { s.size }

pub fn nlp_embed_word2vec_view_get(s : Nlpembedword2vecView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_word2vec_view_set(s : Nlpembedword2vecView, i : Int, v : Double) -> Nlpembedword2vecView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_view_sum(s : Nlpembedword2vecView) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_word2vec_view_mean(s : Nlpembedword2vecView) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_word2vec_view_scale(s : Nlpembedword2vecView, f : Double) -> Nlpembedword2vecView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_view_add(a : Nlpembedword2vecView, b : Nlpembedword2vecView) -> Nlpembedword2vecView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_word2vec_view_copy(s : Nlpembedword2vecView) -> Nlpembedword2vecView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_view_fill(s : Nlpembedword2vecView, v : Double) -> Nlpembedword2vecView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_view_min(s : Nlpembedword2vecView) -> Double { @_common.min(s.data) }

pub fn nlp_embed_word2vec_view_max(s : Nlpembedword2vecView) -> Double { @_common.max(s.data) }

pub fn nlp_embed_word2vec_view_to_string(s : Nlpembedword2vecView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedword2vecRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_word2vec_range_make(size : Int) -> Nlpembedword2vecRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_word2vec_range_len(s : Nlpembedword2vecRange) -> Int { s.size }

pub fn nlp_embed_word2vec_range_get(s : Nlpembedword2vecRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_word2vec_range_set(s : Nlpembedword2vecRange, i : Int, v : Double) -> Nlpembedword2vecRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_range_sum(s : Nlpembedword2vecRange) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_word2vec_range_mean(s : Nlpembedword2vecRange) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_word2vec_range_scale(s : Nlpembedword2vecRange, f : Double) -> Nlpembedword2vecRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_range_add(a : Nlpembedword2vecRange, b : Nlpembedword2vecRange) -> Nlpembedword2vecRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_word2vec_range_copy(s : Nlpembedword2vecRange) -> Nlpembedword2vecRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_range_fill(s : Nlpembedword2vecRange, v : Double) -> Nlpembedword2vecRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_range_min(s : Nlpembedword2vecRange) -> Double { @_common.min(s.data) }

pub fn nlp_embed_word2vec_range_max(s : Nlpembedword2vecRange) -> Double { @_common.max(s.data) }

pub fn nlp_embed_word2vec_range_to_string(s : Nlpembedword2vecRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembedword2vecSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_word2vec_slice_make(size : Int) -> Nlpembedword2vecSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_word2vec_slice_len(s : Nlpembedword2vecSlice) -> Int { s.size }

pub fn nlp_embed_word2vec_slice_get(s : Nlpembedword2vecSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_word2vec_slice_set(s : Nlpembedword2vecSlice, i : Int, v : Double) -> Nlpembedword2vecSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_slice_sum(s : Nlpembedword2vecSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_word2vec_slice_mean(s : Nlpembedword2vecSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_word2vec_slice_scale(s : Nlpembedword2vecSlice, f : Double) -> Nlpembedword2vecSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_slice_add(a : Nlpembedword2vecSlice, b : Nlpembedword2vecSlice) -> Nlpembedword2vecSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_word2vec_slice_copy(s : Nlpembedword2vecSlice) -> Nlpembedword2vecSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_slice_fill(s : Nlpembedword2vecSlice, v : Double) -> Nlpembedword2vecSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_word2vec_slice_min(s : Nlpembedword2vecSlice) -> Double { @_common.min(s.data) }

pub fn nlp_embed_word2vec_slice_max(s : Nlpembedword2vecSlice) -> Double { @_common.max(s.data) }

pub fn nlp_embed_word2vec_slice_to_string(s : Nlpembedword2vecSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

