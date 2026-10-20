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

pub fn NlpembedgptFrame::len(self : NlpembedgptFrame) -> Int { self.size }

pub fn NlpembedgptFrame::get(self : NlpembedgptFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgptFrame::set(self : NlpembedgptFrame, i : Int, v : Double) -> NlpembedgptFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgptFrame::sum(self : NlpembedgptFrame) -> Double { @_common.sum(self.data) }

pub fn NlpembedgptFrame::mean(self : NlpembedgptFrame) -> Double { @_common.mean(self.data) }

pub fn NlpembedgptFrame::scale(self : NlpembedgptFrame, f : Double) -> NlpembedgptFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgptFrame::add(self : NlpembedgptFrame, other : NlpembedgptFrame) -> NlpembedgptFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgptFrame::copy(self : NlpembedgptFrame) -> NlpembedgptFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgptFrame::fill(self : NlpembedgptFrame, v : Double) -> NlpembedgptFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgptFrame::min(self : NlpembedgptFrame) -> Double { @_common.min(self.data) }

pub fn NlpembedgptFrame::max(self : NlpembedgptFrame) -> Double { @_common.max(self.data) }

pub fn NlpembedgptFrame::to_string(self : NlpembedgptFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgptTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_table_make(size : Int) -> NlpembedgptTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgptTable::len(self : NlpembedgptTable) -> Int { self.size }

pub fn NlpembedgptTable::get(self : NlpembedgptTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgptTable::set(self : NlpembedgptTable, i : Int, v : Double) -> NlpembedgptTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgptTable::sum(self : NlpembedgptTable) -> Double { @_common.sum(self.data) }

pub fn NlpembedgptTable::mean(self : NlpembedgptTable) -> Double { @_common.mean(self.data) }

pub fn NlpembedgptTable::scale(self : NlpembedgptTable, f : Double) -> NlpembedgptTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgptTable::add(self : NlpembedgptTable, other : NlpembedgptTable) -> NlpembedgptTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgptTable::copy(self : NlpembedgptTable) -> NlpembedgptTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgptTable::fill(self : NlpembedgptTable, v : Double) -> NlpembedgptTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgptTable::min(self : NlpembedgptTable) -> Double { @_common.min(self.data) }

pub fn NlpembedgptTable::max(self : NlpembedgptTable) -> Double { @_common.max(self.data) }

pub fn NlpembedgptTable::to_string(self : NlpembedgptTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgptGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_graphn_make(size : Int) -> NlpembedgptGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgptGraphN::len(self : NlpembedgptGraphN) -> Int { self.size }

pub fn NlpembedgptGraphN::get(self : NlpembedgptGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgptGraphN::set(self : NlpembedgptGraphN, i : Int, v : Double) -> NlpembedgptGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgptGraphN::sum(self : NlpembedgptGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpembedgptGraphN::mean(self : NlpembedgptGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpembedgptGraphN::scale(self : NlpembedgptGraphN, f : Double) -> NlpembedgptGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgptGraphN::add(self : NlpembedgptGraphN, other : NlpembedgptGraphN) -> NlpembedgptGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgptGraphN::copy(self : NlpembedgptGraphN) -> NlpembedgptGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgptGraphN::fill(self : NlpembedgptGraphN, v : Double) -> NlpembedgptGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgptGraphN::min(self : NlpembedgptGraphN) -> Double { @_common.min(self.data) }

pub fn NlpembedgptGraphN::max(self : NlpembedgptGraphN) -> Double { @_common.max(self.data) }

pub fn NlpembedgptGraphN::to_string(self : NlpembedgptGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgptNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_node_make(size : Int) -> NlpembedgptNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgptNode::len(self : NlpembedgptNode) -> Int { self.size }

pub fn NlpembedgptNode::get(self : NlpembedgptNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgptNode::set(self : NlpembedgptNode, i : Int, v : Double) -> NlpembedgptNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgptNode::sum(self : NlpembedgptNode) -> Double { @_common.sum(self.data) }

pub fn NlpembedgptNode::mean(self : NlpembedgptNode) -> Double { @_common.mean(self.data) }

pub fn NlpembedgptNode::scale(self : NlpembedgptNode, f : Double) -> NlpembedgptNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgptNode::add(self : NlpembedgptNode, other : NlpembedgptNode) -> NlpembedgptNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgptNode::copy(self : NlpembedgptNode) -> NlpembedgptNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgptNode::fill(self : NlpembedgptNode, v : Double) -> NlpembedgptNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgptNode::min(self : NlpembedgptNode) -> Double { @_common.min(self.data) }

pub fn NlpembedgptNode::max(self : NlpembedgptNode) -> Double { @_common.max(self.data) }

pub fn NlpembedgptNode::to_string(self : NlpembedgptNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgptEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_edge_make(size : Int) -> NlpembedgptEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgptEdge::len(self : NlpembedgptEdge) -> Int { self.size }

pub fn NlpembedgptEdge::get(self : NlpembedgptEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgptEdge::set(self : NlpembedgptEdge, i : Int, v : Double) -> NlpembedgptEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgptEdge::sum(self : NlpembedgptEdge) -> Double { @_common.sum(self.data) }

pub fn NlpembedgptEdge::mean(self : NlpembedgptEdge) -> Double { @_common.mean(self.data) }

pub fn NlpembedgptEdge::scale(self : NlpembedgptEdge, f : Double) -> NlpembedgptEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgptEdge::add(self : NlpembedgptEdge, other : NlpembedgptEdge) -> NlpembedgptEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgptEdge::copy(self : NlpembedgptEdge) -> NlpembedgptEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgptEdge::fill(self : NlpembedgptEdge, v : Double) -> NlpembedgptEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgptEdge::min(self : NlpembedgptEdge) -> Double { @_common.min(self.data) }

pub fn NlpembedgptEdge::max(self : NlpembedgptEdge) -> Double { @_common.max(self.data) }

pub fn NlpembedgptEdge::to_string(self : NlpembedgptEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgptPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_path_make(size : Int) -> NlpembedgptPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgptPath::len(self : NlpembedgptPath) -> Int { self.size }

pub fn NlpembedgptPath::get(self : NlpembedgptPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgptPath::set(self : NlpembedgptPath, i : Int, v : Double) -> NlpembedgptPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgptPath::sum(self : NlpembedgptPath) -> Double { @_common.sum(self.data) }

pub fn NlpembedgptPath::mean(self : NlpembedgptPath) -> Double { @_common.mean(self.data) }

pub fn NlpembedgptPath::scale(self : NlpembedgptPath, f : Double) -> NlpembedgptPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgptPath::add(self : NlpembedgptPath, other : NlpembedgptPath) -> NlpembedgptPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgptPath::copy(self : NlpembedgptPath) -> NlpembedgptPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgptPath::fill(self : NlpembedgptPath, v : Double) -> NlpembedgptPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgptPath::min(self : NlpembedgptPath) -> Double { @_common.min(self.data) }

pub fn NlpembedgptPath::max(self : NlpembedgptPath) -> Double { @_common.max(self.data) }

pub fn NlpembedgptPath::to_string(self : NlpembedgptPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgptCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_cluster_make(size : Int) -> NlpembedgptCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgptCluster::len(self : NlpembedgptCluster) -> Int { self.size }

pub fn NlpembedgptCluster::get(self : NlpembedgptCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgptCluster::set(self : NlpembedgptCluster, i : Int, v : Double) -> NlpembedgptCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgptCluster::sum(self : NlpembedgptCluster) -> Double { @_common.sum(self.data) }

pub fn NlpembedgptCluster::mean(self : NlpembedgptCluster) -> Double { @_common.mean(self.data) }

pub fn NlpembedgptCluster::scale(self : NlpembedgptCluster, f : Double) -> NlpembedgptCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgptCluster::add(self : NlpembedgptCluster, other : NlpembedgptCluster) -> NlpembedgptCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgptCluster::copy(self : NlpembedgptCluster) -> NlpembedgptCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgptCluster::fill(self : NlpembedgptCluster, v : Double) -> NlpembedgptCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgptCluster::min(self : NlpembedgptCluster) -> Double { @_common.min(self.data) }

pub fn NlpembedgptCluster::max(self : NlpembedgptCluster) -> Double { @_common.max(self.data) }

pub fn NlpembedgptCluster::to_string(self : NlpembedgptCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgptModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_model_make(size : Int) -> NlpembedgptModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgptModel::len(self : NlpembedgptModel) -> Int { self.size }

pub fn NlpembedgptModel::get(self : NlpembedgptModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgptModel::set(self : NlpembedgptModel, i : Int, v : Double) -> NlpembedgptModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgptModel::sum(self : NlpembedgptModel) -> Double { @_common.sum(self.data) }

pub fn NlpembedgptModel::mean(self : NlpembedgptModel) -> Double { @_common.mean(self.data) }

pub fn NlpembedgptModel::scale(self : NlpembedgptModel, f : Double) -> NlpembedgptModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgptModel::add(self : NlpembedgptModel, other : NlpembedgptModel) -> NlpembedgptModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgptModel::copy(self : NlpembedgptModel) -> NlpembedgptModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgptModel::fill(self : NlpembedgptModel, v : Double) -> NlpembedgptModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgptModel::min(self : NlpembedgptModel) -> Double { @_common.min(self.data) }

pub fn NlpembedgptModel::max(self : NlpembedgptModel) -> Double { @_common.max(self.data) }

pub fn NlpembedgptModel::to_string(self : NlpembedgptModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgptLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_layer_make(size : Int) -> NlpembedgptLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgptLayer::len(self : NlpembedgptLayer) -> Int { self.size }

pub fn NlpembedgptLayer::get(self : NlpembedgptLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgptLayer::set(self : NlpembedgptLayer, i : Int, v : Double) -> NlpembedgptLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgptLayer::sum(self : NlpembedgptLayer) -> Double { @_common.sum(self.data) }

pub fn NlpembedgptLayer::mean(self : NlpembedgptLayer) -> Double { @_common.mean(self.data) }

pub fn NlpembedgptLayer::scale(self : NlpembedgptLayer, f : Double) -> NlpembedgptLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgptLayer::add(self : NlpembedgptLayer, other : NlpembedgptLayer) -> NlpembedgptLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgptLayer::copy(self : NlpembedgptLayer) -> NlpembedgptLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgptLayer::fill(self : NlpembedgptLayer, v : Double) -> NlpembedgptLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgptLayer::min(self : NlpembedgptLayer) -> Double { @_common.min(self.data) }

pub fn NlpembedgptLayer::max(self : NlpembedgptLayer) -> Double { @_common.max(self.data) }

pub fn NlpembedgptLayer::to_string(self : NlpembedgptLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgptBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_buffer_make(size : Int) -> NlpembedgptBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgptBuffer::len(self : NlpembedgptBuffer) -> Int { self.size }

pub fn NlpembedgptBuffer::get(self : NlpembedgptBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgptBuffer::set(self : NlpembedgptBuffer, i : Int, v : Double) -> NlpembedgptBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgptBuffer::sum(self : NlpembedgptBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpembedgptBuffer::mean(self : NlpembedgptBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpembedgptBuffer::scale(self : NlpembedgptBuffer, f : Double) -> NlpembedgptBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgptBuffer::add(self : NlpembedgptBuffer, other : NlpembedgptBuffer) -> NlpembedgptBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgptBuffer::copy(self : NlpembedgptBuffer) -> NlpembedgptBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgptBuffer::fill(self : NlpembedgptBuffer, v : Double) -> NlpembedgptBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgptBuffer::min(self : NlpembedgptBuffer) -> Double { @_common.min(self.data) }

pub fn NlpembedgptBuffer::max(self : NlpembedgptBuffer) -> Double { @_common.max(self.data) }

pub fn NlpembedgptBuffer::to_string(self : NlpembedgptBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgptCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_cursor_make(size : Int) -> NlpembedgptCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgptCursor::len(self : NlpembedgptCursor) -> Int { self.size }

pub fn NlpembedgptCursor::get(self : NlpembedgptCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgptCursor::set(self : NlpembedgptCursor, i : Int, v : Double) -> NlpembedgptCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgptCursor::sum(self : NlpembedgptCursor) -> Double { @_common.sum(self.data) }

pub fn NlpembedgptCursor::mean(self : NlpembedgptCursor) -> Double { @_common.mean(self.data) }

pub fn NlpembedgptCursor::scale(self : NlpembedgptCursor, f : Double) -> NlpembedgptCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgptCursor::add(self : NlpembedgptCursor, other : NlpembedgptCursor) -> NlpembedgptCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgptCursor::copy(self : NlpembedgptCursor) -> NlpembedgptCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgptCursor::fill(self : NlpembedgptCursor, v : Double) -> NlpembedgptCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgptCursor::min(self : NlpembedgptCursor) -> Double { @_common.min(self.data) }

pub fn NlpembedgptCursor::max(self : NlpembedgptCursor) -> Double { @_common.max(self.data) }

pub fn NlpembedgptCursor::to_string(self : NlpembedgptCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgptView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_view_make(size : Int) -> NlpembedgptView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgptView::len(self : NlpembedgptView) -> Int { self.size }

pub fn NlpembedgptView::get(self : NlpembedgptView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgptView::set(self : NlpembedgptView, i : Int, v : Double) -> NlpembedgptView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgptView::sum(self : NlpembedgptView) -> Double { @_common.sum(self.data) }

pub fn NlpembedgptView::mean(self : NlpembedgptView) -> Double { @_common.mean(self.data) }

pub fn NlpembedgptView::scale(self : NlpembedgptView, f : Double) -> NlpembedgptView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgptView::add(self : NlpembedgptView, other : NlpembedgptView) -> NlpembedgptView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgptView::copy(self : NlpembedgptView) -> NlpembedgptView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgptView::fill(self : NlpembedgptView, v : Double) -> NlpembedgptView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgptView::min(self : NlpembedgptView) -> Double { @_common.min(self.data) }

pub fn NlpembedgptView::max(self : NlpembedgptView) -> Double { @_common.max(self.data) }

pub fn NlpembedgptView::to_string(self : NlpembedgptView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgptRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_range_make(size : Int) -> NlpembedgptRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgptRange::len(self : NlpembedgptRange) -> Int { self.size }

pub fn NlpembedgptRange::get(self : NlpembedgptRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgptRange::set(self : NlpembedgptRange, i : Int, v : Double) -> NlpembedgptRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgptRange::sum(self : NlpembedgptRange) -> Double { @_common.sum(self.data) }

pub fn NlpembedgptRange::mean(self : NlpembedgptRange) -> Double { @_common.mean(self.data) }

pub fn NlpembedgptRange::scale(self : NlpembedgptRange, f : Double) -> NlpembedgptRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgptRange::add(self : NlpembedgptRange, other : NlpembedgptRange) -> NlpembedgptRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgptRange::copy(self : NlpembedgptRange) -> NlpembedgptRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgptRange::fill(self : NlpembedgptRange, v : Double) -> NlpembedgptRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgptRange::min(self : NlpembedgptRange) -> Double { @_common.min(self.data) }

pub fn NlpembedgptRange::max(self : NlpembedgptRange) -> Double { @_common.max(self.data) }

pub fn NlpembedgptRange::to_string(self : NlpembedgptRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpembedgptSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_embed_gpt_slice_make(size : Int) -> NlpembedgptSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpembedgptSlice::len(self : NlpembedgptSlice) -> Int { self.size }

pub fn NlpembedgptSlice::get(self : NlpembedgptSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpembedgptSlice::set(self : NlpembedgptSlice, i : Int, v : Double) -> NlpembedgptSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpembedgptSlice::sum(self : NlpembedgptSlice) -> Double { @_common.sum(self.data) }

pub fn NlpembedgptSlice::mean(self : NlpembedgptSlice) -> Double { @_common.mean(self.data) }

pub fn NlpembedgptSlice::scale(self : NlpembedgptSlice, f : Double) -> NlpembedgptSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpembedgptSlice::add(self : NlpembedgptSlice, other : NlpembedgptSlice) -> NlpembedgptSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpembedgptSlice::copy(self : NlpembedgptSlice) -> NlpembedgptSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpembedgptSlice::fill(self : NlpembedgptSlice, v : Double) -> NlpembedgptSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpembedgptSlice::min(self : NlpembedgptSlice) -> Double { @_common.min(self.data) }

pub fn NlpembedgptSlice::max(self : NlpembedgptSlice) -> Double { @_common.max(self.data) }

pub fn NlpembedgptSlice::to_string(self : NlpembedgptSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

