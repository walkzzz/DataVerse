///===
/// extcore/nlp_embed_doc2vec

pub(all) struct Nlpembeddoc2vecPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_doc2vec_make_point(x : Double, y : Double) -> Nlpembeddoc2vecPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_doc2vec_make_point3(x : Double, y : Double, z : Double) -> Nlpembeddoc2vecPoint {
  { x, y, z, label: 0 }
}

pub fn Nlpembeddoc2vecPoint::x(self : Nlpembeddoc2vecPoint) -> Double { self.x }

pub fn Nlpembeddoc2vecPoint::y(self : Nlpembeddoc2vecPoint) -> Double { self.y }

pub fn Nlpembeddoc2vecPoint::z(self : Nlpembeddoc2vecPoint) -> Double { self.z }

pub fn Nlpembeddoc2vecPoint::label(self : Nlpembeddoc2vecPoint) -> Int { self.label }

pub fn Nlpembeddoc2vecPoint::dist(self : Nlpembeddoc2vecPoint, other : Nlpembeddoc2vecPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Nlpembeddoc2vecPoint::add(self : Nlpembeddoc2vecPoint, other : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Nlpembeddoc2vecPoint::sub(self : Nlpembeddoc2vecPoint, other : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Nlpembeddoc2vecPoint::scale(self : Nlpembeddoc2vecPoint, s : Double) -> Nlpembeddoc2vecPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Nlpembeddoc2vecPoint::dot(self : Nlpembeddoc2vecPoint, other : Nlpembeddoc2vecPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Nlpembeddoc2vecPoint::cross(self : Nlpembeddoc2vecPoint, other : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Nlpembeddoc2vecPoint::norm(self : Nlpembeddoc2vecPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Nlpembeddoc2vecPoint::normalize(self : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Nlpembeddoc2vecPoint::negate(self : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Nlpembeddoc2vecPoint::mid(self : Nlpembeddoc2vecPoint, other : Nlpembeddoc2vecPoint) -> Nlpembeddoc2vecPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Nlpembeddoc2vecPoint::lerp(self : Nlpembeddoc2vecPoint, other : Nlpembeddoc2vecPoint, t : Double) -> Nlpembeddoc2vecPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Nlpembeddoc2vecPoint::to_string(self : Nlpembeddoc2vecPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_doc2vec_make_series(vals : Array[Double], name : String) -> Nlpembeddoc2vecSeries {
  { vals, name, meta: 0 }
}

pub fn Nlpembeddoc2vecSeries::len(self : Nlpembeddoc2vecSeries) -> Int { self.vals.length() }

pub fn Nlpembeddoc2vecSeries::sum(self : Nlpembeddoc2vecSeries) -> Double { @_common.sum(self.vals) }

pub fn Nlpembeddoc2vecSeries::mean(self : Nlpembeddoc2vecSeries) -> Double { @_common.mean(self.vals) }

pub fn Nlpembeddoc2vecSeries::min(self : Nlpembeddoc2vecSeries) -> Double { @_common.min(self.vals) }

pub fn Nlpembeddoc2vecSeries::max(self : Nlpembeddoc2vecSeries) -> Double { @_common.max(self.vals) }

pub fn Nlpembeddoc2vecSeries::range(self : Nlpembeddoc2vecSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Nlpembeddoc2vecSeries::variance(self : Nlpembeddoc2vecSeries) -> Double { @_common.variance(self.vals) }

pub fn Nlpembeddoc2vecSeries::std(self : Nlpembeddoc2vecSeries) -> Double { @_common.std(self.vals) }

pub fn Nlpembeddoc2vecSeries::median(self : Nlpembeddoc2vecSeries) -> Double { @_common.median(self.vals) }

pub fn Nlpembeddoc2vecSeries::scale(self : Nlpembeddoc2vecSeries, f : Double) -> Nlpembeddoc2vecSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Nlpembeddoc2vecSeries::add(self : Nlpembeddoc2vecSeries, other : Nlpembeddoc2vecSeries) -> Nlpembeddoc2vecSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Nlpembeddoc2vecSeries::sub(self : Nlpembeddoc2vecSeries, other : Nlpembeddoc2vecSeries) -> Nlpembeddoc2vecSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Nlpembeddoc2vecSeries::normalize(self : Nlpembeddoc2vecSeries) -> Nlpembeddoc2vecSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Nlpembeddoc2vecSeries::cumsum(self : Nlpembeddoc2vecSeries) -> Nlpembeddoc2vecSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Nlpembeddoc2vecSeries::to_string(self : Nlpembeddoc2vecSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Nlpembeddoc2vecMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_doc2vec_make_matrix(rows : Int, cols : Int, val : Double) -> Nlpembeddoc2vecMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_doc2vec_matrix_identity(n : Int) -> Nlpembeddoc2vecMatrix {
  let m = nlp_embed_doc2vec_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Nlpembeddoc2vecMatrix::get(self : Nlpembeddoc2vecMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Nlpembeddoc2vecMatrix::transpose(self : Nlpembeddoc2vecMatrix) -> Nlpembeddoc2vecMatrix {
  let result = nlp_embed_doc2vec_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Nlpembeddoc2vecMatrix::add(self : Nlpembeddoc2vecMatrix, other : Nlpembeddoc2vecMatrix) -> Nlpembeddoc2vecMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_doc2vec_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Nlpembeddoc2vecMatrix::scale(self : Nlpembeddoc2vecMatrix, s : Double) -> Nlpembeddoc2vecMatrix {
  let result = nlp_embed_doc2vec_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Nlpembeddoc2vecMatrix::multiply(self : Nlpembeddoc2vecMatrix, other : Nlpembeddoc2vecMatrix) -> Nlpembeddoc2vecMatrix {
  if self.cols != other.rows { return nlp_embed_doc2vec_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_doc2vec_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Nlpembeddoc2vecMatrix::trace(self : Nlpembeddoc2vecMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Nlpembeddoc2vecMatrix::det(self : Nlpembeddoc2vecMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Nlpembeddoc2vecMatrix::norm(self : Nlpembeddoc2vecMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Nlpembeddoc2vecMatrix::to_string(self : Nlpembeddoc2vecMatrix) -> String {
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

pub(all) struct Nlpembeddoc2vecVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_doc2vec_make_vector(comps : Array[Double]) -> Nlpembeddoc2vecVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_doc2vec_vector_zero(dim : Int) -> Nlpembeddoc2vecVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Nlpembeddoc2vecVector::add(self : Nlpembeddoc2vecVector, other : Nlpembeddoc2vecVector) -> Nlpembeddoc2vecVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Nlpembeddoc2vecVector::sub(self : Nlpembeddoc2vecVector, other : Nlpembeddoc2vecVector) -> Nlpembeddoc2vecVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Nlpembeddoc2vecVector::scale(self : Nlpembeddoc2vecVector, s : Double) -> Nlpembeddoc2vecVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Nlpembeddoc2vecVector::dot(self : Nlpembeddoc2vecVector, other : Nlpembeddoc2vecVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Nlpembeddoc2vecVector::norm(self : Nlpembeddoc2vecVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Nlpembeddoc2vecVector::normalize(self : Nlpembeddoc2vecVector) -> Nlpembeddoc2vecVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Nlpembeddoc2vecVector::dist(self : Nlpembeddoc2vecVector, other : Nlpembeddoc2vecVector) -> Double {
  self.sub(other).norm()
}

pub fn Nlpembeddoc2vecVector::to_string(self : Nlpembeddoc2vecVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_doc2vec_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_doc2vec_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_doc2vec_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_doc2vec_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_doc2vec_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_doc2vec_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_doc2vec_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_doc2vec_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_doc2vec_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_doc2vec_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_doc2vec_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_doc2vec_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_doc2vec_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_doc2vec_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_doc2vec_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_doc2vec_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_doc2vec_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_doc2vec_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_doc2vec_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_doc2vec_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_doc2vec_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_doc2vec_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_doc2vec_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_doc2vec_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_doc2vec_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_doc2vec_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_doc2vec_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_doc2vec_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_doc2vec_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Nlpembeddoc2vecFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_frame_make(size : Int) -> Nlpembeddoc2vecFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_frame_len(s : Nlpembeddoc2vecFrame) -> Int { s.size }

pub fn nlp_embed_doc2vec_frame_get(s : Nlpembeddoc2vecFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_frame_set(s : Nlpembeddoc2vecFrame, i : Int, v : Double) -> Nlpembeddoc2vecFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_frame_sum(s : Nlpembeddoc2vecFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_frame_mean(s : Nlpembeddoc2vecFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_frame_scale(s : Nlpembeddoc2vecFrame, f : Double) -> Nlpembeddoc2vecFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_frame_add(a : Nlpembeddoc2vecFrame, b : Nlpembeddoc2vecFrame) -> Nlpembeddoc2vecFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_frame_copy(s : Nlpembeddoc2vecFrame) -> Nlpembeddoc2vecFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_frame_fill(s : Nlpembeddoc2vecFrame, v : Double) -> Nlpembeddoc2vecFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_frame_min(s : Nlpembeddoc2vecFrame) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_frame_max(s : Nlpembeddoc2vecFrame) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_frame_to_string(s : Nlpembeddoc2vecFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_table_make(size : Int) -> Nlpembeddoc2vecTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_table_len(s : Nlpembeddoc2vecTable) -> Int { s.size }

pub fn nlp_embed_doc2vec_table_get(s : Nlpembeddoc2vecTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_table_set(s : Nlpembeddoc2vecTable, i : Int, v : Double) -> Nlpembeddoc2vecTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_table_sum(s : Nlpembeddoc2vecTable) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_table_mean(s : Nlpembeddoc2vecTable) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_table_scale(s : Nlpembeddoc2vecTable, f : Double) -> Nlpembeddoc2vecTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_table_add(a : Nlpembeddoc2vecTable, b : Nlpembeddoc2vecTable) -> Nlpembeddoc2vecTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_table_copy(s : Nlpembeddoc2vecTable) -> Nlpembeddoc2vecTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_table_fill(s : Nlpembeddoc2vecTable, v : Double) -> Nlpembeddoc2vecTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_table_min(s : Nlpembeddoc2vecTable) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_table_max(s : Nlpembeddoc2vecTable) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_table_to_string(s : Nlpembeddoc2vecTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_graphn_make(size : Int) -> Nlpembeddoc2vecGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_graphn_len(s : Nlpembeddoc2vecGraphN) -> Int { s.size }

pub fn nlp_embed_doc2vec_graphn_get(s : Nlpembeddoc2vecGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_graphn_set(s : Nlpembeddoc2vecGraphN, i : Int, v : Double) -> Nlpembeddoc2vecGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_graphn_sum(s : Nlpembeddoc2vecGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_graphn_mean(s : Nlpembeddoc2vecGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_graphn_scale(s : Nlpembeddoc2vecGraphN, f : Double) -> Nlpembeddoc2vecGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_graphn_add(a : Nlpembeddoc2vecGraphN, b : Nlpembeddoc2vecGraphN) -> Nlpembeddoc2vecGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_graphn_copy(s : Nlpembeddoc2vecGraphN) -> Nlpembeddoc2vecGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_graphn_fill(s : Nlpembeddoc2vecGraphN, v : Double) -> Nlpembeddoc2vecGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_graphn_min(s : Nlpembeddoc2vecGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_graphn_max(s : Nlpembeddoc2vecGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_graphn_to_string(s : Nlpembeddoc2vecGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_node_make(size : Int) -> Nlpembeddoc2vecNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_node_len(s : Nlpembeddoc2vecNode) -> Int { s.size }

pub fn nlp_embed_doc2vec_node_get(s : Nlpembeddoc2vecNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_node_set(s : Nlpembeddoc2vecNode, i : Int, v : Double) -> Nlpembeddoc2vecNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_node_sum(s : Nlpembeddoc2vecNode) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_node_mean(s : Nlpembeddoc2vecNode) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_node_scale(s : Nlpembeddoc2vecNode, f : Double) -> Nlpembeddoc2vecNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_node_add(a : Nlpembeddoc2vecNode, b : Nlpembeddoc2vecNode) -> Nlpembeddoc2vecNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_node_copy(s : Nlpembeddoc2vecNode) -> Nlpembeddoc2vecNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_node_fill(s : Nlpembeddoc2vecNode, v : Double) -> Nlpembeddoc2vecNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_node_min(s : Nlpembeddoc2vecNode) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_node_max(s : Nlpembeddoc2vecNode) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_node_to_string(s : Nlpembeddoc2vecNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_edge_make(size : Int) -> Nlpembeddoc2vecEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_edge_len(s : Nlpembeddoc2vecEdge) -> Int { s.size }

pub fn nlp_embed_doc2vec_edge_get(s : Nlpembeddoc2vecEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_edge_set(s : Nlpembeddoc2vecEdge, i : Int, v : Double) -> Nlpembeddoc2vecEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_edge_sum(s : Nlpembeddoc2vecEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_edge_mean(s : Nlpembeddoc2vecEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_edge_scale(s : Nlpembeddoc2vecEdge, f : Double) -> Nlpembeddoc2vecEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_edge_add(a : Nlpembeddoc2vecEdge, b : Nlpembeddoc2vecEdge) -> Nlpembeddoc2vecEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_edge_copy(s : Nlpembeddoc2vecEdge) -> Nlpembeddoc2vecEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_edge_fill(s : Nlpembeddoc2vecEdge, v : Double) -> Nlpembeddoc2vecEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_edge_min(s : Nlpembeddoc2vecEdge) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_edge_max(s : Nlpembeddoc2vecEdge) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_edge_to_string(s : Nlpembeddoc2vecEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_path_make(size : Int) -> Nlpembeddoc2vecPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_path_len(s : Nlpembeddoc2vecPath) -> Int { s.size }

pub fn nlp_embed_doc2vec_path_get(s : Nlpembeddoc2vecPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_path_set(s : Nlpembeddoc2vecPath, i : Int, v : Double) -> Nlpembeddoc2vecPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_path_sum(s : Nlpembeddoc2vecPath) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_path_mean(s : Nlpembeddoc2vecPath) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_path_scale(s : Nlpembeddoc2vecPath, f : Double) -> Nlpembeddoc2vecPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_path_add(a : Nlpembeddoc2vecPath, b : Nlpembeddoc2vecPath) -> Nlpembeddoc2vecPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_path_copy(s : Nlpembeddoc2vecPath) -> Nlpembeddoc2vecPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_path_fill(s : Nlpembeddoc2vecPath, v : Double) -> Nlpembeddoc2vecPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_path_min(s : Nlpembeddoc2vecPath) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_path_max(s : Nlpembeddoc2vecPath) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_path_to_string(s : Nlpembeddoc2vecPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_cluster_make(size : Int) -> Nlpembeddoc2vecCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_cluster_len(s : Nlpembeddoc2vecCluster) -> Int { s.size }

pub fn nlp_embed_doc2vec_cluster_get(s : Nlpembeddoc2vecCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_cluster_set(s : Nlpembeddoc2vecCluster, i : Int, v : Double) -> Nlpembeddoc2vecCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cluster_sum(s : Nlpembeddoc2vecCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_cluster_mean(s : Nlpembeddoc2vecCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_cluster_scale(s : Nlpembeddoc2vecCluster, f : Double) -> Nlpembeddoc2vecCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cluster_add(a : Nlpembeddoc2vecCluster, b : Nlpembeddoc2vecCluster) -> Nlpembeddoc2vecCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_cluster_copy(s : Nlpembeddoc2vecCluster) -> Nlpembeddoc2vecCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cluster_fill(s : Nlpembeddoc2vecCluster, v : Double) -> Nlpembeddoc2vecCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cluster_min(s : Nlpembeddoc2vecCluster) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_cluster_max(s : Nlpembeddoc2vecCluster) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_cluster_to_string(s : Nlpembeddoc2vecCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_model_make(size : Int) -> Nlpembeddoc2vecModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_model_len(s : Nlpembeddoc2vecModel) -> Int { s.size }

pub fn nlp_embed_doc2vec_model_get(s : Nlpembeddoc2vecModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_model_set(s : Nlpembeddoc2vecModel, i : Int, v : Double) -> Nlpembeddoc2vecModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_model_sum(s : Nlpembeddoc2vecModel) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_model_mean(s : Nlpembeddoc2vecModel) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_model_scale(s : Nlpembeddoc2vecModel, f : Double) -> Nlpembeddoc2vecModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_model_add(a : Nlpembeddoc2vecModel, b : Nlpembeddoc2vecModel) -> Nlpembeddoc2vecModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_model_copy(s : Nlpembeddoc2vecModel) -> Nlpembeddoc2vecModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_model_fill(s : Nlpembeddoc2vecModel, v : Double) -> Nlpembeddoc2vecModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_model_min(s : Nlpembeddoc2vecModel) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_model_max(s : Nlpembeddoc2vecModel) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_model_to_string(s : Nlpembeddoc2vecModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_layer_make(size : Int) -> Nlpembeddoc2vecLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_layer_len(s : Nlpembeddoc2vecLayer) -> Int { s.size }

pub fn nlp_embed_doc2vec_layer_get(s : Nlpembeddoc2vecLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_layer_set(s : Nlpembeddoc2vecLayer, i : Int, v : Double) -> Nlpembeddoc2vecLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_layer_sum(s : Nlpembeddoc2vecLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_layer_mean(s : Nlpembeddoc2vecLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_layer_scale(s : Nlpembeddoc2vecLayer, f : Double) -> Nlpembeddoc2vecLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_layer_add(a : Nlpembeddoc2vecLayer, b : Nlpembeddoc2vecLayer) -> Nlpembeddoc2vecLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_layer_copy(s : Nlpembeddoc2vecLayer) -> Nlpembeddoc2vecLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_layer_fill(s : Nlpembeddoc2vecLayer, v : Double) -> Nlpembeddoc2vecLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_layer_min(s : Nlpembeddoc2vecLayer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_layer_max(s : Nlpembeddoc2vecLayer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_layer_to_string(s : Nlpembeddoc2vecLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_buffer_make(size : Int) -> Nlpembeddoc2vecBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_buffer_len(s : Nlpembeddoc2vecBuffer) -> Int { s.size }

pub fn nlp_embed_doc2vec_buffer_get(s : Nlpembeddoc2vecBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_buffer_set(s : Nlpembeddoc2vecBuffer, i : Int, v : Double) -> Nlpembeddoc2vecBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_buffer_sum(s : Nlpembeddoc2vecBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_buffer_mean(s : Nlpembeddoc2vecBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_buffer_scale(s : Nlpembeddoc2vecBuffer, f : Double) -> Nlpembeddoc2vecBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_buffer_add(a : Nlpembeddoc2vecBuffer, b : Nlpembeddoc2vecBuffer) -> Nlpembeddoc2vecBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_buffer_copy(s : Nlpembeddoc2vecBuffer) -> Nlpembeddoc2vecBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_buffer_fill(s : Nlpembeddoc2vecBuffer, v : Double) -> Nlpembeddoc2vecBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_buffer_min(s : Nlpembeddoc2vecBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_buffer_max(s : Nlpembeddoc2vecBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_buffer_to_string(s : Nlpembeddoc2vecBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_cursor_make(size : Int) -> Nlpembeddoc2vecCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_cursor_len(s : Nlpembeddoc2vecCursor) -> Int { s.size }

pub fn nlp_embed_doc2vec_cursor_get(s : Nlpembeddoc2vecCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_cursor_set(s : Nlpembeddoc2vecCursor, i : Int, v : Double) -> Nlpembeddoc2vecCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cursor_sum(s : Nlpembeddoc2vecCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_cursor_mean(s : Nlpembeddoc2vecCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_cursor_scale(s : Nlpembeddoc2vecCursor, f : Double) -> Nlpembeddoc2vecCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cursor_add(a : Nlpembeddoc2vecCursor, b : Nlpembeddoc2vecCursor) -> Nlpembeddoc2vecCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_cursor_copy(s : Nlpembeddoc2vecCursor) -> Nlpembeddoc2vecCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cursor_fill(s : Nlpembeddoc2vecCursor, v : Double) -> Nlpembeddoc2vecCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_cursor_min(s : Nlpembeddoc2vecCursor) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_cursor_max(s : Nlpembeddoc2vecCursor) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_cursor_to_string(s : Nlpembeddoc2vecCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_view_make(size : Int) -> Nlpembeddoc2vecView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_view_len(s : Nlpembeddoc2vecView) -> Int { s.size }

pub fn nlp_embed_doc2vec_view_get(s : Nlpembeddoc2vecView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_view_set(s : Nlpembeddoc2vecView, i : Int, v : Double) -> Nlpembeddoc2vecView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_view_sum(s : Nlpembeddoc2vecView) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_view_mean(s : Nlpembeddoc2vecView) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_view_scale(s : Nlpembeddoc2vecView, f : Double) -> Nlpembeddoc2vecView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_view_add(a : Nlpembeddoc2vecView, b : Nlpembeddoc2vecView) -> Nlpembeddoc2vecView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_view_copy(s : Nlpembeddoc2vecView) -> Nlpembeddoc2vecView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_view_fill(s : Nlpembeddoc2vecView, v : Double) -> Nlpembeddoc2vecView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_view_min(s : Nlpembeddoc2vecView) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_view_max(s : Nlpembeddoc2vecView) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_view_to_string(s : Nlpembeddoc2vecView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_range_make(size : Int) -> Nlpembeddoc2vecRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_range_len(s : Nlpembeddoc2vecRange) -> Int { s.size }

pub fn nlp_embed_doc2vec_range_get(s : Nlpembeddoc2vecRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_range_set(s : Nlpembeddoc2vecRange, i : Int, v : Double) -> Nlpembeddoc2vecRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_range_sum(s : Nlpembeddoc2vecRange) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_range_mean(s : Nlpembeddoc2vecRange) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_range_scale(s : Nlpembeddoc2vecRange, f : Double) -> Nlpembeddoc2vecRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_range_add(a : Nlpembeddoc2vecRange, b : Nlpembeddoc2vecRange) -> Nlpembeddoc2vecRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_range_copy(s : Nlpembeddoc2vecRange) -> Nlpembeddoc2vecRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_range_fill(s : Nlpembeddoc2vecRange, v : Double) -> Nlpembeddoc2vecRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_range_min(s : Nlpembeddoc2vecRange) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_range_max(s : Nlpembeddoc2vecRange) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_range_to_string(s : Nlpembeddoc2vecRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Nlpembeddoc2vecSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_doc2vec_slice_make(size : Int) -> Nlpembeddoc2vecSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_doc2vec_slice_len(s : Nlpembeddoc2vecSlice) -> Int { s.size }

pub fn nlp_embed_doc2vec_slice_get(s : Nlpembeddoc2vecSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_doc2vec_slice_set(s : Nlpembeddoc2vecSlice, i : Int, v : Double) -> Nlpembeddoc2vecSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_slice_sum(s : Nlpembeddoc2vecSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_doc2vec_slice_mean(s : Nlpembeddoc2vecSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_doc2vec_slice_scale(s : Nlpembeddoc2vecSlice, f : Double) -> Nlpembeddoc2vecSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_slice_add(a : Nlpembeddoc2vecSlice, b : Nlpembeddoc2vecSlice) -> Nlpembeddoc2vecSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_doc2vec_slice_copy(s : Nlpembeddoc2vecSlice) -> Nlpembeddoc2vecSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_slice_fill(s : Nlpembeddoc2vecSlice, v : Double) -> Nlpembeddoc2vecSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_doc2vec_slice_min(s : Nlpembeddoc2vecSlice) -> Double { @_common.min(s.data) }

pub fn nlp_embed_doc2vec_slice_max(s : Nlpembeddoc2vecSlice) -> Double { @_common.max(s.data) }

pub fn nlp_embed_doc2vec_slice_to_string(s : Nlpembeddoc2vecSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

