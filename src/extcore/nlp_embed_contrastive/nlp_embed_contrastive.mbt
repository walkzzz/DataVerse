///===
/// extcore/nlp_embed_contrastive

pub(all) struct NlpembedcontrastivePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_embed_contrastive_make_point(x : Double, y : Double) -> NlpembedcontrastivePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_embed_contrastive_make_point3(x : Double, y : Double, z : Double) -> NlpembedcontrastivePoint {
  { x, y, z, label: 0 }
}

pub fn NlpembedcontrastivePoint::x(self : NlpembedcontrastivePoint) -> Double { self.x }

pub fn NlpembedcontrastivePoint::y(self : NlpembedcontrastivePoint) -> Double { self.y }

pub fn NlpembedcontrastivePoint::z(self : NlpembedcontrastivePoint) -> Double { self.z }

pub fn NlpembedcontrastivePoint::label(self : NlpembedcontrastivePoint) -> Int { self.label }

pub fn NlpembedcontrastivePoint::dist(self : NlpembedcontrastivePoint, other : NlpembedcontrastivePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpembedcontrastivePoint::add(self : NlpembedcontrastivePoint, other : NlpembedcontrastivePoint) -> NlpembedcontrastivePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpembedcontrastivePoint::sub(self : NlpembedcontrastivePoint, other : NlpembedcontrastivePoint) -> NlpembedcontrastivePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpembedcontrastivePoint::scale(self : NlpembedcontrastivePoint, s : Double) -> NlpembedcontrastivePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpembedcontrastivePoint::dot(self : NlpembedcontrastivePoint, other : NlpembedcontrastivePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpembedcontrastivePoint::cross(self : NlpembedcontrastivePoint, other : NlpembedcontrastivePoint) -> NlpembedcontrastivePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpembedcontrastivePoint::norm(self : NlpembedcontrastivePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpembedcontrastivePoint::normalize(self : NlpembedcontrastivePoint) -> NlpembedcontrastivePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedcontrastivePoint::negate(self : NlpembedcontrastivePoint) -> NlpembedcontrastivePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpembedcontrastivePoint::mid(self : NlpembedcontrastivePoint, other : NlpembedcontrastivePoint) -> NlpembedcontrastivePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpembedcontrastivePoint::lerp(self : NlpembedcontrastivePoint, other : NlpembedcontrastivePoint, t : Double) -> NlpembedcontrastivePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpembedcontrastivePoint::to_string(self : NlpembedcontrastivePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_embed_contrastive_make_series(vals : Array[Double], name : String) -> NlpembedcontrastiveSeries {
  { vals, name, meta: 0 }
}

pub fn NlpembedcontrastiveSeries::len(self : NlpembedcontrastiveSeries) -> Int { self.vals.length() }

pub fn NlpembedcontrastiveSeries::sum(self : NlpembedcontrastiveSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpembedcontrastiveSeries::mean(self : NlpembedcontrastiveSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpembedcontrastiveSeries::min(self : NlpembedcontrastiveSeries) -> Double { @_common.min(self.vals) }

pub fn NlpembedcontrastiveSeries::max(self : NlpembedcontrastiveSeries) -> Double { @_common.max(self.vals) }

pub fn NlpembedcontrastiveSeries::range(self : NlpembedcontrastiveSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpembedcontrastiveSeries::variance(self : NlpembedcontrastiveSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpembedcontrastiveSeries::std(self : NlpembedcontrastiveSeries) -> Double { @_common.std(self.vals) }

pub fn NlpembedcontrastiveSeries::median(self : NlpembedcontrastiveSeries) -> Double { @_common.median(self.vals) }

pub fn NlpembedcontrastiveSeries::scale(self : NlpembedcontrastiveSeries, f : Double) -> NlpembedcontrastiveSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpembedcontrastiveSeries::add(self : NlpembedcontrastiveSeries, other : NlpembedcontrastiveSeries) -> NlpembedcontrastiveSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpembedcontrastiveSeries::sub(self : NlpembedcontrastiveSeries, other : NlpembedcontrastiveSeries) -> NlpembedcontrastiveSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpembedcontrastiveSeries::normalize(self : NlpembedcontrastiveSeries) -> NlpembedcontrastiveSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpembedcontrastiveSeries::cumsum(self : NlpembedcontrastiveSeries) -> NlpembedcontrastiveSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpembedcontrastiveSeries::to_string(self : NlpembedcontrastiveSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpembedcontrastiveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_embed_contrastive_make_matrix(rows : Int, cols : Int, val : Double) -> NlpembedcontrastiveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_embed_contrastive_matrix_identity(n : Int) -> NlpembedcontrastiveMatrix {
  let m = nlp_embed_contrastive_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpembedcontrastiveMatrix::get(self : NlpembedcontrastiveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpembedcontrastiveMatrix::transpose(self : NlpembedcontrastiveMatrix) -> NlpembedcontrastiveMatrix {
  let result = nlp_embed_contrastive_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpembedcontrastiveMatrix::add(self : NlpembedcontrastiveMatrix, other : NlpembedcontrastiveMatrix) -> NlpembedcontrastiveMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_embed_contrastive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpembedcontrastiveMatrix::scale(self : NlpembedcontrastiveMatrix, s : Double) -> NlpembedcontrastiveMatrix {
  let result = nlp_embed_contrastive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpembedcontrastiveMatrix::multiply(self : NlpembedcontrastiveMatrix, other : NlpembedcontrastiveMatrix) -> NlpembedcontrastiveMatrix {
  if self.cols != other.rows { return nlp_embed_contrastive_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_embed_contrastive_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpembedcontrastiveMatrix::trace(self : NlpembedcontrastiveMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpembedcontrastiveMatrix::det(self : NlpembedcontrastiveMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpembedcontrastiveMatrix::norm(self : NlpembedcontrastiveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpembedcontrastiveMatrix::to_string(self : NlpembedcontrastiveMatrix) -> String {
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

pub(all) struct NlpembedcontrastiveVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_embed_contrastive_make_vector(comps : Array[Double]) -> NlpembedcontrastiveVector {
  { comps, dim: comps.length() }
}

pub fn nlp_embed_contrastive_vector_zero(dim : Int) -> NlpembedcontrastiveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpembedcontrastiveVector::add(self : NlpembedcontrastiveVector, other : NlpembedcontrastiveVector) -> NlpembedcontrastiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedcontrastiveVector::sub(self : NlpembedcontrastiveVector, other : NlpembedcontrastiveVector) -> NlpembedcontrastiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpembedcontrastiveVector::scale(self : NlpembedcontrastiveVector, s : Double) -> NlpembedcontrastiveVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpembedcontrastiveVector::dot(self : NlpembedcontrastiveVector, other : NlpembedcontrastiveVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpembedcontrastiveVector::norm(self : NlpembedcontrastiveVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpembedcontrastiveVector::normalize(self : NlpembedcontrastiveVector) -> NlpembedcontrastiveVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpembedcontrastiveVector::dist(self : NlpembedcontrastiveVector, other : NlpembedcontrastiveVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpembedcontrastiveVector::to_string(self : NlpembedcontrastiveVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_embed_contrastive_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_embed_contrastive_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_embed_contrastive_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_embed_contrastive_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_embed_contrastive_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_embed_contrastive_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_embed_contrastive_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_embed_contrastive_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_embed_contrastive_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_embed_contrastive_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_embed_contrastive_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_embed_contrastive_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_embed_contrastive_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_embed_contrastive_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_embed_contrastive_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_embed_contrastive_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_embed_contrastive_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_embed_contrastive_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_embed_contrastive_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_embed_contrastive_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_embed_contrastive_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_embed_contrastive_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_embed_contrastive_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_embed_contrastive_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_embed_contrastive_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_embed_contrastive_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_embed_contrastive_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_embed_contrastive_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_embed_contrastive_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpembedcontrastiveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_frame_make(size : Int) -> NlpembedcontrastiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_frame_len(s : NlpembedcontrastiveFrame) -> Int { s.size }

pub fn nlp_embed_contrastive_frame_get(s : NlpembedcontrastiveFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_frame_set(s : NlpembedcontrastiveFrame, i : Int, v : Double) -> NlpembedcontrastiveFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_frame_sum(s : NlpembedcontrastiveFrame) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_contrastive_frame_mean(s : NlpembedcontrastiveFrame) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_contrastive_frame_scale(s : NlpembedcontrastiveFrame, f : Double) -> NlpembedcontrastiveFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_frame_add(a : NlpembedcontrastiveFrame, b : NlpembedcontrastiveFrame) -> NlpembedcontrastiveFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_contrastive_frame_copy(s : NlpembedcontrastiveFrame) -> NlpembedcontrastiveFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_frame_fill(s : NlpembedcontrastiveFrame, v : Double) -> NlpembedcontrastiveFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_frame_min(s : NlpembedcontrastiveFrame) -> Double { @_common.min(s.data) }

pub fn nlp_embed_contrastive_frame_max(s : NlpembedcontrastiveFrame) -> Double { @_common.max(s.data) }

pub fn nlp_embed_contrastive_frame_to_string(s : NlpembedcontrastiveFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_table_make(size : Int) -> NlpembedcontrastiveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_table_len(s : NlpembedcontrastiveTable) -> Int { s.size }

pub fn nlp_embed_contrastive_table_get(s : NlpembedcontrastiveTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_table_set(s : NlpembedcontrastiveTable, i : Int, v : Double) -> NlpembedcontrastiveTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_table_sum(s : NlpembedcontrastiveTable) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_contrastive_table_mean(s : NlpembedcontrastiveTable) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_contrastive_table_scale(s : NlpembedcontrastiveTable, f : Double) -> NlpembedcontrastiveTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_table_add(a : NlpembedcontrastiveTable, b : NlpembedcontrastiveTable) -> NlpembedcontrastiveTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_contrastive_table_copy(s : NlpembedcontrastiveTable) -> NlpembedcontrastiveTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_table_fill(s : NlpembedcontrastiveTable, v : Double) -> NlpembedcontrastiveTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_table_min(s : NlpembedcontrastiveTable) -> Double { @_common.min(s.data) }

pub fn nlp_embed_contrastive_table_max(s : NlpembedcontrastiveTable) -> Double { @_common.max(s.data) }

pub fn nlp_embed_contrastive_table_to_string(s : NlpembedcontrastiveTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_graphn_make(size : Int) -> NlpembedcontrastiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_graphn_len(s : NlpembedcontrastiveGraphN) -> Int { s.size }

pub fn nlp_embed_contrastive_graphn_get(s : NlpembedcontrastiveGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_graphn_set(s : NlpembedcontrastiveGraphN, i : Int, v : Double) -> NlpembedcontrastiveGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_graphn_sum(s : NlpembedcontrastiveGraphN) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_contrastive_graphn_mean(s : NlpembedcontrastiveGraphN) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_contrastive_graphn_scale(s : NlpembedcontrastiveGraphN, f : Double) -> NlpembedcontrastiveGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_graphn_add(a : NlpembedcontrastiveGraphN, b : NlpembedcontrastiveGraphN) -> NlpembedcontrastiveGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_contrastive_graphn_copy(s : NlpembedcontrastiveGraphN) -> NlpembedcontrastiveGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_graphn_fill(s : NlpembedcontrastiveGraphN, v : Double) -> NlpembedcontrastiveGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_graphn_min(s : NlpembedcontrastiveGraphN) -> Double { @_common.min(s.data) }

pub fn nlp_embed_contrastive_graphn_max(s : NlpembedcontrastiveGraphN) -> Double { @_common.max(s.data) }

pub fn nlp_embed_contrastive_graphn_to_string(s : NlpembedcontrastiveGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_node_make(size : Int) -> NlpembedcontrastiveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_node_len(s : NlpembedcontrastiveNode) -> Int { s.size }

pub fn nlp_embed_contrastive_node_get(s : NlpembedcontrastiveNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_node_set(s : NlpembedcontrastiveNode, i : Int, v : Double) -> NlpembedcontrastiveNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_node_sum(s : NlpembedcontrastiveNode) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_contrastive_node_mean(s : NlpembedcontrastiveNode) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_contrastive_node_scale(s : NlpembedcontrastiveNode, f : Double) -> NlpembedcontrastiveNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_node_add(a : NlpembedcontrastiveNode, b : NlpembedcontrastiveNode) -> NlpembedcontrastiveNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_contrastive_node_copy(s : NlpembedcontrastiveNode) -> NlpembedcontrastiveNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_node_fill(s : NlpembedcontrastiveNode, v : Double) -> NlpembedcontrastiveNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_node_min(s : NlpembedcontrastiveNode) -> Double { @_common.min(s.data) }

pub fn nlp_embed_contrastive_node_max(s : NlpembedcontrastiveNode) -> Double { @_common.max(s.data) }

pub fn nlp_embed_contrastive_node_to_string(s : NlpembedcontrastiveNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_edge_make(size : Int) -> NlpembedcontrastiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_edge_len(s : NlpembedcontrastiveEdge) -> Int { s.size }

pub fn nlp_embed_contrastive_edge_get(s : NlpembedcontrastiveEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_edge_set(s : NlpembedcontrastiveEdge, i : Int, v : Double) -> NlpembedcontrastiveEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_edge_sum(s : NlpembedcontrastiveEdge) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_contrastive_edge_mean(s : NlpembedcontrastiveEdge) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_contrastive_edge_scale(s : NlpembedcontrastiveEdge, f : Double) -> NlpembedcontrastiveEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_edge_add(a : NlpembedcontrastiveEdge, b : NlpembedcontrastiveEdge) -> NlpembedcontrastiveEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_contrastive_edge_copy(s : NlpembedcontrastiveEdge) -> NlpembedcontrastiveEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_edge_fill(s : NlpembedcontrastiveEdge, v : Double) -> NlpembedcontrastiveEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_edge_min(s : NlpembedcontrastiveEdge) -> Double { @_common.min(s.data) }

pub fn nlp_embed_contrastive_edge_max(s : NlpembedcontrastiveEdge) -> Double { @_common.max(s.data) }

pub fn nlp_embed_contrastive_edge_to_string(s : NlpembedcontrastiveEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastivePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_path_make(size : Int) -> NlpembedcontrastivePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_path_len(s : NlpembedcontrastivePath) -> Int { s.size }

pub fn nlp_embed_contrastive_path_get(s : NlpembedcontrastivePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_path_set(s : NlpembedcontrastivePath, i : Int, v : Double) -> NlpembedcontrastivePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_path_sum(s : NlpembedcontrastivePath) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_contrastive_path_mean(s : NlpembedcontrastivePath) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_contrastive_path_scale(s : NlpembedcontrastivePath, f : Double) -> NlpembedcontrastivePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_path_add(a : NlpembedcontrastivePath, b : NlpembedcontrastivePath) -> NlpembedcontrastivePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_contrastive_path_copy(s : NlpembedcontrastivePath) -> NlpembedcontrastivePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_path_fill(s : NlpembedcontrastivePath, v : Double) -> NlpembedcontrastivePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_path_min(s : NlpembedcontrastivePath) -> Double { @_common.min(s.data) }

pub fn nlp_embed_contrastive_path_max(s : NlpembedcontrastivePath) -> Double { @_common.max(s.data) }

pub fn nlp_embed_contrastive_path_to_string(s : NlpembedcontrastivePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_cluster_make(size : Int) -> NlpembedcontrastiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_cluster_len(s : NlpembedcontrastiveCluster) -> Int { s.size }

pub fn nlp_embed_contrastive_cluster_get(s : NlpembedcontrastiveCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_cluster_set(s : NlpembedcontrastiveCluster, i : Int, v : Double) -> NlpembedcontrastiveCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_cluster_sum(s : NlpembedcontrastiveCluster) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_contrastive_cluster_mean(s : NlpembedcontrastiveCluster) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_contrastive_cluster_scale(s : NlpembedcontrastiveCluster, f : Double) -> NlpembedcontrastiveCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_cluster_add(a : NlpembedcontrastiveCluster, b : NlpembedcontrastiveCluster) -> NlpembedcontrastiveCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_contrastive_cluster_copy(s : NlpembedcontrastiveCluster) -> NlpembedcontrastiveCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_cluster_fill(s : NlpembedcontrastiveCluster, v : Double) -> NlpembedcontrastiveCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_cluster_min(s : NlpembedcontrastiveCluster) -> Double { @_common.min(s.data) }

pub fn nlp_embed_contrastive_cluster_max(s : NlpembedcontrastiveCluster) -> Double { @_common.max(s.data) }

pub fn nlp_embed_contrastive_cluster_to_string(s : NlpembedcontrastiveCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_model_make(size : Int) -> NlpembedcontrastiveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_model_len(s : NlpembedcontrastiveModel) -> Int { s.size }

pub fn nlp_embed_contrastive_model_get(s : NlpembedcontrastiveModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_model_set(s : NlpembedcontrastiveModel, i : Int, v : Double) -> NlpembedcontrastiveModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_model_sum(s : NlpembedcontrastiveModel) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_contrastive_model_mean(s : NlpembedcontrastiveModel) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_contrastive_model_scale(s : NlpembedcontrastiveModel, f : Double) -> NlpembedcontrastiveModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_model_add(a : NlpembedcontrastiveModel, b : NlpembedcontrastiveModel) -> NlpembedcontrastiveModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_contrastive_model_copy(s : NlpembedcontrastiveModel) -> NlpembedcontrastiveModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_model_fill(s : NlpembedcontrastiveModel, v : Double) -> NlpembedcontrastiveModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_model_min(s : NlpembedcontrastiveModel) -> Double { @_common.min(s.data) }

pub fn nlp_embed_contrastive_model_max(s : NlpembedcontrastiveModel) -> Double { @_common.max(s.data) }

pub fn nlp_embed_contrastive_model_to_string(s : NlpembedcontrastiveModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_layer_make(size : Int) -> NlpembedcontrastiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_layer_len(s : NlpembedcontrastiveLayer) -> Int { s.size }

pub fn nlp_embed_contrastive_layer_get(s : NlpembedcontrastiveLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_layer_set(s : NlpembedcontrastiveLayer, i : Int, v : Double) -> NlpembedcontrastiveLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_layer_sum(s : NlpembedcontrastiveLayer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_contrastive_layer_mean(s : NlpembedcontrastiveLayer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_contrastive_layer_scale(s : NlpembedcontrastiveLayer, f : Double) -> NlpembedcontrastiveLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_layer_add(a : NlpembedcontrastiveLayer, b : NlpembedcontrastiveLayer) -> NlpembedcontrastiveLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_contrastive_layer_copy(s : NlpembedcontrastiveLayer) -> NlpembedcontrastiveLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_layer_fill(s : NlpembedcontrastiveLayer, v : Double) -> NlpembedcontrastiveLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_layer_min(s : NlpembedcontrastiveLayer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_contrastive_layer_max(s : NlpembedcontrastiveLayer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_contrastive_layer_to_string(s : NlpembedcontrastiveLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_buffer_make(size : Int) -> NlpembedcontrastiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_buffer_len(s : NlpembedcontrastiveBuffer) -> Int { s.size }

pub fn nlp_embed_contrastive_buffer_get(s : NlpembedcontrastiveBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_buffer_set(s : NlpembedcontrastiveBuffer, i : Int, v : Double) -> NlpembedcontrastiveBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_buffer_sum(s : NlpembedcontrastiveBuffer) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_contrastive_buffer_mean(s : NlpembedcontrastiveBuffer) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_contrastive_buffer_scale(s : NlpembedcontrastiveBuffer, f : Double) -> NlpembedcontrastiveBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_buffer_add(a : NlpembedcontrastiveBuffer, b : NlpembedcontrastiveBuffer) -> NlpembedcontrastiveBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_contrastive_buffer_copy(s : NlpembedcontrastiveBuffer) -> NlpembedcontrastiveBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_buffer_fill(s : NlpembedcontrastiveBuffer, v : Double) -> NlpembedcontrastiveBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_buffer_min(s : NlpembedcontrastiveBuffer) -> Double { @_common.min(s.data) }

pub fn nlp_embed_contrastive_buffer_max(s : NlpembedcontrastiveBuffer) -> Double { @_common.max(s.data) }

pub fn nlp_embed_contrastive_buffer_to_string(s : NlpembedcontrastiveBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_cursor_make(size : Int) -> NlpembedcontrastiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_cursor_len(s : NlpembedcontrastiveCursor) -> Int { s.size }

pub fn nlp_embed_contrastive_cursor_get(s : NlpembedcontrastiveCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_cursor_set(s : NlpembedcontrastiveCursor, i : Int, v : Double) -> NlpembedcontrastiveCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_cursor_sum(s : NlpembedcontrastiveCursor) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_contrastive_cursor_mean(s : NlpembedcontrastiveCursor) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_contrastive_cursor_scale(s : NlpembedcontrastiveCursor, f : Double) -> NlpembedcontrastiveCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_cursor_add(a : NlpembedcontrastiveCursor, b : NlpembedcontrastiveCursor) -> NlpembedcontrastiveCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_contrastive_cursor_copy(s : NlpembedcontrastiveCursor) -> NlpembedcontrastiveCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_cursor_fill(s : NlpembedcontrastiveCursor, v : Double) -> NlpembedcontrastiveCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_cursor_min(s : NlpembedcontrastiveCursor) -> Double { @_common.min(s.data) }

pub fn nlp_embed_contrastive_cursor_max(s : NlpembedcontrastiveCursor) -> Double { @_common.max(s.data) }

pub fn nlp_embed_contrastive_cursor_to_string(s : NlpembedcontrastiveCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_view_make(size : Int) -> NlpembedcontrastiveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_view_len(s : NlpembedcontrastiveView) -> Int { s.size }

pub fn nlp_embed_contrastive_view_get(s : NlpembedcontrastiveView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_view_set(s : NlpembedcontrastiveView, i : Int, v : Double) -> NlpembedcontrastiveView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_view_sum(s : NlpembedcontrastiveView) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_contrastive_view_mean(s : NlpembedcontrastiveView) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_contrastive_view_scale(s : NlpembedcontrastiveView, f : Double) -> NlpembedcontrastiveView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_view_add(a : NlpembedcontrastiveView, b : NlpembedcontrastiveView) -> NlpembedcontrastiveView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_contrastive_view_copy(s : NlpembedcontrastiveView) -> NlpembedcontrastiveView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_view_fill(s : NlpembedcontrastiveView, v : Double) -> NlpembedcontrastiveView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_view_min(s : NlpembedcontrastiveView) -> Double { @_common.min(s.data) }

pub fn nlp_embed_contrastive_view_max(s : NlpembedcontrastiveView) -> Double { @_common.max(s.data) }

pub fn nlp_embed_contrastive_view_to_string(s : NlpembedcontrastiveView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_range_make(size : Int) -> NlpembedcontrastiveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_range_len(s : NlpembedcontrastiveRange) -> Int { s.size }

pub fn nlp_embed_contrastive_range_get(s : NlpembedcontrastiveRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_range_set(s : NlpembedcontrastiveRange, i : Int, v : Double) -> NlpembedcontrastiveRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_range_sum(s : NlpembedcontrastiveRange) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_contrastive_range_mean(s : NlpembedcontrastiveRange) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_contrastive_range_scale(s : NlpembedcontrastiveRange, f : Double) -> NlpembedcontrastiveRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_range_add(a : NlpembedcontrastiveRange, b : NlpembedcontrastiveRange) -> NlpembedcontrastiveRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_contrastive_range_copy(s : NlpembedcontrastiveRange) -> NlpembedcontrastiveRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_range_fill(s : NlpembedcontrastiveRange, v : Double) -> NlpembedcontrastiveRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_range_min(s : NlpembedcontrastiveRange) -> Double { @_common.min(s.data) }

pub fn nlp_embed_contrastive_range_max(s : NlpembedcontrastiveRange) -> Double { @_common.max(s.data) }

pub fn nlp_embed_contrastive_range_to_string(s : NlpembedcontrastiveRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpembedcontrastiveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_contrastive_slice_make(size : Int) -> NlpembedcontrastiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_embed_contrastive_slice_len(s : NlpembedcontrastiveSlice) -> Int { s.size }

pub fn nlp_embed_contrastive_slice_get(s : NlpembedcontrastiveSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_embed_contrastive_slice_set(s : NlpembedcontrastiveSlice, i : Int, v : Double) -> NlpembedcontrastiveSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_slice_sum(s : NlpembedcontrastiveSlice) -> Double { @_common.sum(s.data) }

pub fn nlp_embed_contrastive_slice_mean(s : NlpembedcontrastiveSlice) -> Double { @_common.mean(s.data) }

pub fn nlp_embed_contrastive_slice_scale(s : NlpembedcontrastiveSlice, f : Double) -> NlpembedcontrastiveSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_slice_add(a : NlpembedcontrastiveSlice, b : NlpembedcontrastiveSlice) -> NlpembedcontrastiveSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn nlp_embed_contrastive_slice_copy(s : NlpembedcontrastiveSlice) -> NlpembedcontrastiveSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_slice_fill(s : NlpembedcontrastiveSlice, v : Double) -> NlpembedcontrastiveSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn nlp_embed_contrastive_slice_min(s : NlpembedcontrastiveSlice) -> Double { @_common.min(s.data) }

pub fn nlp_embed_contrastive_slice_max(s : NlpembedcontrastiveSlice) -> Double { @_common.max(s.data) }

pub fn nlp_embed_contrastive_slice_to_string(s : NlpembedcontrastiveSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

