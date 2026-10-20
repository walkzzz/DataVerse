///===
/// extcore/bio_seq_align_iterative

pub(all) struct BioseqaligniterativePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_iterative_make_point(x : Double, y : Double) -> BioseqaligniterativePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_iterative_make_point3(x : Double, y : Double, z : Double) -> BioseqaligniterativePoint {
  { x, y, z, label: 0 }
}

pub fn BioseqaligniterativePoint::x(self : BioseqaligniterativePoint) -> Double { self.x }

pub fn BioseqaligniterativePoint::y(self : BioseqaligniterativePoint) -> Double { self.y }

pub fn BioseqaligniterativePoint::z(self : BioseqaligniterativePoint) -> Double { self.z }

pub fn BioseqaligniterativePoint::label(self : BioseqaligniterativePoint) -> Int { self.label }

pub fn BioseqaligniterativePoint::dist(self : BioseqaligniterativePoint, other : BioseqaligniterativePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqaligniterativePoint::add(self : BioseqaligniterativePoint, other : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqaligniterativePoint::sub(self : BioseqaligniterativePoint, other : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqaligniterativePoint::scale(self : BioseqaligniterativePoint, s : Double) -> BioseqaligniterativePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqaligniterativePoint::dot(self : BioseqaligniterativePoint, other : BioseqaligniterativePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqaligniterativePoint::cross(self : BioseqaligniterativePoint, other : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqaligniterativePoint::norm(self : BioseqaligniterativePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqaligniterativePoint::normalize(self : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqaligniterativePoint::negate(self : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqaligniterativePoint::mid(self : BioseqaligniterativePoint, other : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqaligniterativePoint::lerp(self : BioseqaligniterativePoint, other : BioseqaligniterativePoint, t : Double) -> BioseqaligniterativePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqaligniterativePoint::to_string(self : BioseqaligniterativePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqaligniterativeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_iterative_make_series(vals : Array[Double], name : String) -> BioseqaligniterativeSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqaligniterativeSeries::len(self : BioseqaligniterativeSeries) -> Int { self.vals.length() }

pub fn BioseqaligniterativeSeries::sum(self : BioseqaligniterativeSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqaligniterativeSeries::mean(self : BioseqaligniterativeSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqaligniterativeSeries::min(self : BioseqaligniterativeSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqaligniterativeSeries::max(self : BioseqaligniterativeSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqaligniterativeSeries::range(self : BioseqaligniterativeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqaligniterativeSeries::variance(self : BioseqaligniterativeSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqaligniterativeSeries::std(self : BioseqaligniterativeSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqaligniterativeSeries::median(self : BioseqaligniterativeSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqaligniterativeSeries::scale(self : BioseqaligniterativeSeries, f : Double) -> BioseqaligniterativeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqaligniterativeSeries::add(self : BioseqaligniterativeSeries, other : BioseqaligniterativeSeries) -> BioseqaligniterativeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqaligniterativeSeries::sub(self : BioseqaligniterativeSeries, other : BioseqaligniterativeSeries) -> BioseqaligniterativeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqaligniterativeSeries::normalize(self : BioseqaligniterativeSeries) -> BioseqaligniterativeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqaligniterativeSeries::cumsum(self : BioseqaligniterativeSeries) -> BioseqaligniterativeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqaligniterativeSeries::to_string(self : BioseqaligniterativeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqaligniterativeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_iterative_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqaligniterativeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_iterative_matrix_identity(n : Int) -> BioseqaligniterativeMatrix {
  let m = bio_seq_align_iterative_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqaligniterativeMatrix::get(self : BioseqaligniterativeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqaligniterativeMatrix::transpose(self : BioseqaligniterativeMatrix) -> BioseqaligniterativeMatrix {
  let result = bio_seq_align_iterative_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqaligniterativeMatrix::add(self : BioseqaligniterativeMatrix, other : BioseqaligniterativeMatrix) -> BioseqaligniterativeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_align_iterative_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqaligniterativeMatrix::scale(self : BioseqaligniterativeMatrix, s : Double) -> BioseqaligniterativeMatrix {
  let result = bio_seq_align_iterative_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqaligniterativeMatrix::multiply(self : BioseqaligniterativeMatrix, other : BioseqaligniterativeMatrix) -> BioseqaligniterativeMatrix {
  if self.cols != other.rows { return bio_seq_align_iterative_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_align_iterative_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqaligniterativeMatrix::trace(self : BioseqaligniterativeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqaligniterativeMatrix::det(self : BioseqaligniterativeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqaligniterativeMatrix::norm(self : BioseqaligniterativeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqaligniterativeMatrix::to_string(self : BioseqaligniterativeMatrix) -> String {
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

pub(all) struct BioseqaligniterativeVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_iterative_make_vector(comps : Array[Double]) -> BioseqaligniterativeVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_iterative_vector_zero(dim : Int) -> BioseqaligniterativeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqaligniterativeVector::add(self : BioseqaligniterativeVector, other : BioseqaligniterativeVector) -> BioseqaligniterativeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqaligniterativeVector::sub(self : BioseqaligniterativeVector, other : BioseqaligniterativeVector) -> BioseqaligniterativeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqaligniterativeVector::scale(self : BioseqaligniterativeVector, s : Double) -> BioseqaligniterativeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqaligniterativeVector::dot(self : BioseqaligniterativeVector, other : BioseqaligniterativeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqaligniterativeVector::norm(self : BioseqaligniterativeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqaligniterativeVector::normalize(self : BioseqaligniterativeVector) -> BioseqaligniterativeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqaligniterativeVector::dist(self : BioseqaligniterativeVector, other : BioseqaligniterativeVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqaligniterativeVector::to_string(self : BioseqaligniterativeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_iterative_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_iterative_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_iterative_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_iterative_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_iterative_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_iterative_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_iterative_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_iterative_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_iterative_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_iterative_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_iterative_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_iterative_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_iterative_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_iterative_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_iterative_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_iterative_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_iterative_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_iterative_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_iterative_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_iterative_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_iterative_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_iterative_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_iterative_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_iterative_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_iterative_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_iterative_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_iterative_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_iterative_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_iterative_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqaligniterativeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_frame_make(size : Int) -> BioseqaligniterativeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_frame_len(s : BioseqaligniterativeFrame) -> Int { s.size }

pub fn bio_seq_align_iterative_frame_get(s : BioseqaligniterativeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_frame_set(s : BioseqaligniterativeFrame, i : Int, v : Double) -> BioseqaligniterativeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_frame_sum(s : BioseqaligniterativeFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_frame_mean(s : BioseqaligniterativeFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_frame_scale(s : BioseqaligniterativeFrame, f : Double) -> BioseqaligniterativeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_frame_add(a : BioseqaligniterativeFrame, b : BioseqaligniterativeFrame) -> BioseqaligniterativeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_frame_copy(s : BioseqaligniterativeFrame) -> BioseqaligniterativeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_frame_fill(s : BioseqaligniterativeFrame, v : Double) -> BioseqaligniterativeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_frame_min(s : BioseqaligniterativeFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_frame_max(s : BioseqaligniterativeFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_frame_to_string(s : BioseqaligniterativeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_table_make(size : Int) -> BioseqaligniterativeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_table_len(s : BioseqaligniterativeTable) -> Int { s.size }

pub fn bio_seq_align_iterative_table_get(s : BioseqaligniterativeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_table_set(s : BioseqaligniterativeTable, i : Int, v : Double) -> BioseqaligniterativeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_table_sum(s : BioseqaligniterativeTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_table_mean(s : BioseqaligniterativeTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_table_scale(s : BioseqaligniterativeTable, f : Double) -> BioseqaligniterativeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_table_add(a : BioseqaligniterativeTable, b : BioseqaligniterativeTable) -> BioseqaligniterativeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_table_copy(s : BioseqaligniterativeTable) -> BioseqaligniterativeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_table_fill(s : BioseqaligniterativeTable, v : Double) -> BioseqaligniterativeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_table_min(s : BioseqaligniterativeTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_table_max(s : BioseqaligniterativeTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_table_to_string(s : BioseqaligniterativeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_graphn_make(size : Int) -> BioseqaligniterativeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_graphn_len(s : BioseqaligniterativeGraphN) -> Int { s.size }

pub fn bio_seq_align_iterative_graphn_get(s : BioseqaligniterativeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_graphn_set(s : BioseqaligniterativeGraphN, i : Int, v : Double) -> BioseqaligniterativeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_graphn_sum(s : BioseqaligniterativeGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_graphn_mean(s : BioseqaligniterativeGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_graphn_scale(s : BioseqaligniterativeGraphN, f : Double) -> BioseqaligniterativeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_graphn_add(a : BioseqaligniterativeGraphN, b : BioseqaligniterativeGraphN) -> BioseqaligniterativeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_graphn_copy(s : BioseqaligniterativeGraphN) -> BioseqaligniterativeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_graphn_fill(s : BioseqaligniterativeGraphN, v : Double) -> BioseqaligniterativeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_graphn_min(s : BioseqaligniterativeGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_graphn_max(s : BioseqaligniterativeGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_graphn_to_string(s : BioseqaligniterativeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_node_make(size : Int) -> BioseqaligniterativeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_node_len(s : BioseqaligniterativeNode) -> Int { s.size }

pub fn bio_seq_align_iterative_node_get(s : BioseqaligniterativeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_node_set(s : BioseqaligniterativeNode, i : Int, v : Double) -> BioseqaligniterativeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_node_sum(s : BioseqaligniterativeNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_node_mean(s : BioseqaligniterativeNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_node_scale(s : BioseqaligniterativeNode, f : Double) -> BioseqaligniterativeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_node_add(a : BioseqaligniterativeNode, b : BioseqaligniterativeNode) -> BioseqaligniterativeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_node_copy(s : BioseqaligniterativeNode) -> BioseqaligniterativeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_node_fill(s : BioseqaligniterativeNode, v : Double) -> BioseqaligniterativeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_node_min(s : BioseqaligniterativeNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_node_max(s : BioseqaligniterativeNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_node_to_string(s : BioseqaligniterativeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_edge_make(size : Int) -> BioseqaligniterativeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_edge_len(s : BioseqaligniterativeEdge) -> Int { s.size }

pub fn bio_seq_align_iterative_edge_get(s : BioseqaligniterativeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_edge_set(s : BioseqaligniterativeEdge, i : Int, v : Double) -> BioseqaligniterativeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_edge_sum(s : BioseqaligniterativeEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_edge_mean(s : BioseqaligniterativeEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_edge_scale(s : BioseqaligniterativeEdge, f : Double) -> BioseqaligniterativeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_edge_add(a : BioseqaligniterativeEdge, b : BioseqaligniterativeEdge) -> BioseqaligniterativeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_edge_copy(s : BioseqaligniterativeEdge) -> BioseqaligniterativeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_edge_fill(s : BioseqaligniterativeEdge, v : Double) -> BioseqaligniterativeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_edge_min(s : BioseqaligniterativeEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_edge_max(s : BioseqaligniterativeEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_edge_to_string(s : BioseqaligniterativeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_path_make(size : Int) -> BioseqaligniterativePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_path_len(s : BioseqaligniterativePath) -> Int { s.size }

pub fn bio_seq_align_iterative_path_get(s : BioseqaligniterativePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_path_set(s : BioseqaligniterativePath, i : Int, v : Double) -> BioseqaligniterativePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_path_sum(s : BioseqaligniterativePath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_path_mean(s : BioseqaligniterativePath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_path_scale(s : BioseqaligniterativePath, f : Double) -> BioseqaligniterativePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_path_add(a : BioseqaligniterativePath, b : BioseqaligniterativePath) -> BioseqaligniterativePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_path_copy(s : BioseqaligniterativePath) -> BioseqaligniterativePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_path_fill(s : BioseqaligniterativePath, v : Double) -> BioseqaligniterativePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_path_min(s : BioseqaligniterativePath) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_path_max(s : BioseqaligniterativePath) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_path_to_string(s : BioseqaligniterativePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_cluster_make(size : Int) -> BioseqaligniterativeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_cluster_len(s : BioseqaligniterativeCluster) -> Int { s.size }

pub fn bio_seq_align_iterative_cluster_get(s : BioseqaligniterativeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_cluster_set(s : BioseqaligniterativeCluster, i : Int, v : Double) -> BioseqaligniterativeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cluster_sum(s : BioseqaligniterativeCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_cluster_mean(s : BioseqaligniterativeCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_cluster_scale(s : BioseqaligniterativeCluster, f : Double) -> BioseqaligniterativeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cluster_add(a : BioseqaligniterativeCluster, b : BioseqaligniterativeCluster) -> BioseqaligniterativeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_cluster_copy(s : BioseqaligniterativeCluster) -> BioseqaligniterativeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cluster_fill(s : BioseqaligniterativeCluster, v : Double) -> BioseqaligniterativeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cluster_min(s : BioseqaligniterativeCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_cluster_max(s : BioseqaligniterativeCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_cluster_to_string(s : BioseqaligniterativeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_model_make(size : Int) -> BioseqaligniterativeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_model_len(s : BioseqaligniterativeModel) -> Int { s.size }

pub fn bio_seq_align_iterative_model_get(s : BioseqaligniterativeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_model_set(s : BioseqaligniterativeModel, i : Int, v : Double) -> BioseqaligniterativeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_model_sum(s : BioseqaligniterativeModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_model_mean(s : BioseqaligniterativeModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_model_scale(s : BioseqaligniterativeModel, f : Double) -> BioseqaligniterativeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_model_add(a : BioseqaligniterativeModel, b : BioseqaligniterativeModel) -> BioseqaligniterativeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_model_copy(s : BioseqaligniterativeModel) -> BioseqaligniterativeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_model_fill(s : BioseqaligniterativeModel, v : Double) -> BioseqaligniterativeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_model_min(s : BioseqaligniterativeModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_model_max(s : BioseqaligniterativeModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_model_to_string(s : BioseqaligniterativeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_layer_make(size : Int) -> BioseqaligniterativeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_layer_len(s : BioseqaligniterativeLayer) -> Int { s.size }

pub fn bio_seq_align_iterative_layer_get(s : BioseqaligniterativeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_layer_set(s : BioseqaligniterativeLayer, i : Int, v : Double) -> BioseqaligniterativeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_layer_sum(s : BioseqaligniterativeLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_layer_mean(s : BioseqaligniterativeLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_layer_scale(s : BioseqaligniterativeLayer, f : Double) -> BioseqaligniterativeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_layer_add(a : BioseqaligniterativeLayer, b : BioseqaligniterativeLayer) -> BioseqaligniterativeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_layer_copy(s : BioseqaligniterativeLayer) -> BioseqaligniterativeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_layer_fill(s : BioseqaligniterativeLayer, v : Double) -> BioseqaligniterativeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_layer_min(s : BioseqaligniterativeLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_layer_max(s : BioseqaligniterativeLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_layer_to_string(s : BioseqaligniterativeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_buffer_make(size : Int) -> BioseqaligniterativeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_buffer_len(s : BioseqaligniterativeBuffer) -> Int { s.size }

pub fn bio_seq_align_iterative_buffer_get(s : BioseqaligniterativeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_buffer_set(s : BioseqaligniterativeBuffer, i : Int, v : Double) -> BioseqaligniterativeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_buffer_sum(s : BioseqaligniterativeBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_buffer_mean(s : BioseqaligniterativeBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_buffer_scale(s : BioseqaligniterativeBuffer, f : Double) -> BioseqaligniterativeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_buffer_add(a : BioseqaligniterativeBuffer, b : BioseqaligniterativeBuffer) -> BioseqaligniterativeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_buffer_copy(s : BioseqaligniterativeBuffer) -> BioseqaligniterativeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_buffer_fill(s : BioseqaligniterativeBuffer, v : Double) -> BioseqaligniterativeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_buffer_min(s : BioseqaligniterativeBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_buffer_max(s : BioseqaligniterativeBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_buffer_to_string(s : BioseqaligniterativeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_cursor_make(size : Int) -> BioseqaligniterativeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_cursor_len(s : BioseqaligniterativeCursor) -> Int { s.size }

pub fn bio_seq_align_iterative_cursor_get(s : BioseqaligniterativeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_cursor_set(s : BioseqaligniterativeCursor, i : Int, v : Double) -> BioseqaligniterativeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cursor_sum(s : BioseqaligniterativeCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_cursor_mean(s : BioseqaligniterativeCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_cursor_scale(s : BioseqaligniterativeCursor, f : Double) -> BioseqaligniterativeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cursor_add(a : BioseqaligniterativeCursor, b : BioseqaligniterativeCursor) -> BioseqaligniterativeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_cursor_copy(s : BioseqaligniterativeCursor) -> BioseqaligniterativeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cursor_fill(s : BioseqaligniterativeCursor, v : Double) -> BioseqaligniterativeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_cursor_min(s : BioseqaligniterativeCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_cursor_max(s : BioseqaligniterativeCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_cursor_to_string(s : BioseqaligniterativeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_view_make(size : Int) -> BioseqaligniterativeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_view_len(s : BioseqaligniterativeView) -> Int { s.size }

pub fn bio_seq_align_iterative_view_get(s : BioseqaligniterativeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_view_set(s : BioseqaligniterativeView, i : Int, v : Double) -> BioseqaligniterativeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_view_sum(s : BioseqaligniterativeView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_view_mean(s : BioseqaligniterativeView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_view_scale(s : BioseqaligniterativeView, f : Double) -> BioseqaligniterativeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_view_add(a : BioseqaligniterativeView, b : BioseqaligniterativeView) -> BioseqaligniterativeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_view_copy(s : BioseqaligniterativeView) -> BioseqaligniterativeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_view_fill(s : BioseqaligniterativeView, v : Double) -> BioseqaligniterativeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_view_min(s : BioseqaligniterativeView) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_view_max(s : BioseqaligniterativeView) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_view_to_string(s : BioseqaligniterativeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_range_make(size : Int) -> BioseqaligniterativeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_range_len(s : BioseqaligniterativeRange) -> Int { s.size }

pub fn bio_seq_align_iterative_range_get(s : BioseqaligniterativeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_range_set(s : BioseqaligniterativeRange, i : Int, v : Double) -> BioseqaligniterativeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_range_sum(s : BioseqaligniterativeRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_range_mean(s : BioseqaligniterativeRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_range_scale(s : BioseqaligniterativeRange, f : Double) -> BioseqaligniterativeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_range_add(a : BioseqaligniterativeRange, b : BioseqaligniterativeRange) -> BioseqaligniterativeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_range_copy(s : BioseqaligniterativeRange) -> BioseqaligniterativeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_range_fill(s : BioseqaligniterativeRange, v : Double) -> BioseqaligniterativeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_range_min(s : BioseqaligniterativeRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_range_max(s : BioseqaligniterativeRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_range_to_string(s : BioseqaligniterativeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_slice_make(size : Int) -> BioseqaligniterativeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_iterative_slice_len(s : BioseqaligniterativeSlice) -> Int { s.size }

pub fn bio_seq_align_iterative_slice_get(s : BioseqaligniterativeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_iterative_slice_set(s : BioseqaligniterativeSlice, i : Int, v : Double) -> BioseqaligniterativeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_slice_sum(s : BioseqaligniterativeSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_iterative_slice_mean(s : BioseqaligniterativeSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_iterative_slice_scale(s : BioseqaligniterativeSlice, f : Double) -> BioseqaligniterativeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_slice_add(a : BioseqaligniterativeSlice, b : BioseqaligniterativeSlice) -> BioseqaligniterativeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_iterative_slice_copy(s : BioseqaligniterativeSlice) -> BioseqaligniterativeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_slice_fill(s : BioseqaligniterativeSlice, v : Double) -> BioseqaligniterativeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_iterative_slice_min(s : BioseqaligniterativeSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_iterative_slice_max(s : BioseqaligniterativeSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_iterative_slice_to_string(s : BioseqaligniterativeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

