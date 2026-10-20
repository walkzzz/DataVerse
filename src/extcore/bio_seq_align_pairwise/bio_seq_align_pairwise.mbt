///===
/// extcore/bio_seq_align_pairwise

pub(all) struct BioseqalignpairwisePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_pairwise_make_point(x : Double, y : Double) -> BioseqalignpairwisePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_pairwise_make_point3(x : Double, y : Double, z : Double) -> BioseqalignpairwisePoint {
  { x, y, z, label: 0 }
}

pub fn BioseqalignpairwisePoint::x(self : BioseqalignpairwisePoint) -> Double { self.x }

pub fn BioseqalignpairwisePoint::y(self : BioseqalignpairwisePoint) -> Double { self.y }

pub fn BioseqalignpairwisePoint::z(self : BioseqalignpairwisePoint) -> Double { self.z }

pub fn BioseqalignpairwisePoint::label(self : BioseqalignpairwisePoint) -> Int { self.label }

pub fn BioseqalignpairwisePoint::dist(self : BioseqalignpairwisePoint, other : BioseqalignpairwisePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqalignpairwisePoint::add(self : BioseqalignpairwisePoint, other : BioseqalignpairwisePoint) -> BioseqalignpairwisePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqalignpairwisePoint::sub(self : BioseqalignpairwisePoint, other : BioseqalignpairwisePoint) -> BioseqalignpairwisePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqalignpairwisePoint::scale(self : BioseqalignpairwisePoint, s : Double) -> BioseqalignpairwisePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqalignpairwisePoint::dot(self : BioseqalignpairwisePoint, other : BioseqalignpairwisePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqalignpairwisePoint::cross(self : BioseqalignpairwisePoint, other : BioseqalignpairwisePoint) -> BioseqalignpairwisePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqalignpairwisePoint::norm(self : BioseqalignpairwisePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqalignpairwisePoint::normalize(self : BioseqalignpairwisePoint) -> BioseqalignpairwisePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignpairwisePoint::negate(self : BioseqalignpairwisePoint) -> BioseqalignpairwisePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqalignpairwisePoint::mid(self : BioseqalignpairwisePoint, other : BioseqalignpairwisePoint) -> BioseqalignpairwisePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqalignpairwisePoint::lerp(self : BioseqalignpairwisePoint, other : BioseqalignpairwisePoint, t : Double) -> BioseqalignpairwisePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqalignpairwisePoint::to_string(self : BioseqalignpairwisePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_pairwise_make_series(vals : Array[Double], name : String) -> BioseqalignpairwiseSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqalignpairwiseSeries::len(self : BioseqalignpairwiseSeries) -> Int { self.vals.length() }

pub fn BioseqalignpairwiseSeries::sum(self : BioseqalignpairwiseSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqalignpairwiseSeries::mean(self : BioseqalignpairwiseSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqalignpairwiseSeries::min(self : BioseqalignpairwiseSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqalignpairwiseSeries::max(self : BioseqalignpairwiseSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqalignpairwiseSeries::range(self : BioseqalignpairwiseSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqalignpairwiseSeries::variance(self : BioseqalignpairwiseSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqalignpairwiseSeries::std(self : BioseqalignpairwiseSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqalignpairwiseSeries::median(self : BioseqalignpairwiseSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqalignpairwiseSeries::scale(self : BioseqalignpairwiseSeries, f : Double) -> BioseqalignpairwiseSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqalignpairwiseSeries::add(self : BioseqalignpairwiseSeries, other : BioseqalignpairwiseSeries) -> BioseqalignpairwiseSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqalignpairwiseSeries::sub(self : BioseqalignpairwiseSeries, other : BioseqalignpairwiseSeries) -> BioseqalignpairwiseSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqalignpairwiseSeries::normalize(self : BioseqalignpairwiseSeries) -> BioseqalignpairwiseSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqalignpairwiseSeries::cumsum(self : BioseqalignpairwiseSeries) -> BioseqalignpairwiseSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqalignpairwiseSeries::to_string(self : BioseqalignpairwiseSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignpairwiseMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_pairwise_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignpairwiseMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_pairwise_matrix_identity(n : Int) -> BioseqalignpairwiseMatrix {
  let m = bio_seq_align_pairwise_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqalignpairwiseMatrix::get(self : BioseqalignpairwiseMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqalignpairwiseMatrix::transpose(self : BioseqalignpairwiseMatrix) -> BioseqalignpairwiseMatrix {
  let result = bio_seq_align_pairwise_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqalignpairwiseMatrix::add(self : BioseqalignpairwiseMatrix, other : BioseqalignpairwiseMatrix) -> BioseqalignpairwiseMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_align_pairwise_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqalignpairwiseMatrix::scale(self : BioseqalignpairwiseMatrix, s : Double) -> BioseqalignpairwiseMatrix {
  let result = bio_seq_align_pairwise_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqalignpairwiseMatrix::multiply(self : BioseqalignpairwiseMatrix, other : BioseqalignpairwiseMatrix) -> BioseqalignpairwiseMatrix {
  if self.cols != other.rows { return bio_seq_align_pairwise_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_align_pairwise_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqalignpairwiseMatrix::trace(self : BioseqalignpairwiseMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqalignpairwiseMatrix::det(self : BioseqalignpairwiseMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqalignpairwiseMatrix::norm(self : BioseqalignpairwiseMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqalignpairwiseMatrix::to_string(self : BioseqalignpairwiseMatrix) -> String {
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

pub(all) struct BioseqalignpairwiseVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_pairwise_make_vector(comps : Array[Double]) -> BioseqalignpairwiseVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_pairwise_vector_zero(dim : Int) -> BioseqalignpairwiseVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqalignpairwiseVector::add(self : BioseqalignpairwiseVector, other : BioseqalignpairwiseVector) -> BioseqalignpairwiseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignpairwiseVector::sub(self : BioseqalignpairwiseVector, other : BioseqalignpairwiseVector) -> BioseqalignpairwiseVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignpairwiseVector::scale(self : BioseqalignpairwiseVector, s : Double) -> BioseqalignpairwiseVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqalignpairwiseVector::dot(self : BioseqalignpairwiseVector, other : BioseqalignpairwiseVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqalignpairwiseVector::norm(self : BioseqalignpairwiseVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqalignpairwiseVector::normalize(self : BioseqalignpairwiseVector) -> BioseqalignpairwiseVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignpairwiseVector::dist(self : BioseqalignpairwiseVector, other : BioseqalignpairwiseVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqalignpairwiseVector::to_string(self : BioseqalignpairwiseVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_pairwise_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_pairwise_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_pairwise_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_pairwise_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_pairwise_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_pairwise_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_pairwise_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_pairwise_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_pairwise_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_pairwise_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_pairwise_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_pairwise_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_pairwise_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_pairwise_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_pairwise_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_pairwise_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_pairwise_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_pairwise_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_pairwise_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_pairwise_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_pairwise_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_pairwise_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_pairwise_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_pairwise_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_pairwise_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_pairwise_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_pairwise_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_pairwise_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_pairwise_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqalignpairwiseFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_frame_make(size : Int) -> BioseqalignpairwiseFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_frame_len(s : BioseqalignpairwiseFrame) -> Int { s.size }

pub fn bio_seq_align_pairwise_frame_get(s : BioseqalignpairwiseFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_frame_set(s : BioseqalignpairwiseFrame, i : Int, v : Double) -> BioseqalignpairwiseFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_frame_sum(s : BioseqalignpairwiseFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_pairwise_frame_mean(s : BioseqalignpairwiseFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_pairwise_frame_scale(s : BioseqalignpairwiseFrame, f : Double) -> BioseqalignpairwiseFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_frame_add(a : BioseqalignpairwiseFrame, b : BioseqalignpairwiseFrame) -> BioseqalignpairwiseFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_pairwise_frame_copy(s : BioseqalignpairwiseFrame) -> BioseqalignpairwiseFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_frame_fill(s : BioseqalignpairwiseFrame, v : Double) -> BioseqalignpairwiseFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_frame_min(s : BioseqalignpairwiseFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_pairwise_frame_max(s : BioseqalignpairwiseFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_pairwise_frame_to_string(s : BioseqalignpairwiseFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_table_make(size : Int) -> BioseqalignpairwiseTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_table_len(s : BioseqalignpairwiseTable) -> Int { s.size }

pub fn bio_seq_align_pairwise_table_get(s : BioseqalignpairwiseTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_table_set(s : BioseqalignpairwiseTable, i : Int, v : Double) -> BioseqalignpairwiseTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_table_sum(s : BioseqalignpairwiseTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_pairwise_table_mean(s : BioseqalignpairwiseTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_pairwise_table_scale(s : BioseqalignpairwiseTable, f : Double) -> BioseqalignpairwiseTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_table_add(a : BioseqalignpairwiseTable, b : BioseqalignpairwiseTable) -> BioseqalignpairwiseTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_pairwise_table_copy(s : BioseqalignpairwiseTable) -> BioseqalignpairwiseTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_table_fill(s : BioseqalignpairwiseTable, v : Double) -> BioseqalignpairwiseTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_table_min(s : BioseqalignpairwiseTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_pairwise_table_max(s : BioseqalignpairwiseTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_pairwise_table_to_string(s : BioseqalignpairwiseTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_graphn_make(size : Int) -> BioseqalignpairwiseGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_graphn_len(s : BioseqalignpairwiseGraphN) -> Int { s.size }

pub fn bio_seq_align_pairwise_graphn_get(s : BioseqalignpairwiseGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_graphn_set(s : BioseqalignpairwiseGraphN, i : Int, v : Double) -> BioseqalignpairwiseGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_graphn_sum(s : BioseqalignpairwiseGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_pairwise_graphn_mean(s : BioseqalignpairwiseGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_pairwise_graphn_scale(s : BioseqalignpairwiseGraphN, f : Double) -> BioseqalignpairwiseGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_graphn_add(a : BioseqalignpairwiseGraphN, b : BioseqalignpairwiseGraphN) -> BioseqalignpairwiseGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_pairwise_graphn_copy(s : BioseqalignpairwiseGraphN) -> BioseqalignpairwiseGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_graphn_fill(s : BioseqalignpairwiseGraphN, v : Double) -> BioseqalignpairwiseGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_graphn_min(s : BioseqalignpairwiseGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_pairwise_graphn_max(s : BioseqalignpairwiseGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_pairwise_graphn_to_string(s : BioseqalignpairwiseGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_node_make(size : Int) -> BioseqalignpairwiseNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_node_len(s : BioseqalignpairwiseNode) -> Int { s.size }

pub fn bio_seq_align_pairwise_node_get(s : BioseqalignpairwiseNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_node_set(s : BioseqalignpairwiseNode, i : Int, v : Double) -> BioseqalignpairwiseNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_node_sum(s : BioseqalignpairwiseNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_pairwise_node_mean(s : BioseqalignpairwiseNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_pairwise_node_scale(s : BioseqalignpairwiseNode, f : Double) -> BioseqalignpairwiseNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_node_add(a : BioseqalignpairwiseNode, b : BioseqalignpairwiseNode) -> BioseqalignpairwiseNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_pairwise_node_copy(s : BioseqalignpairwiseNode) -> BioseqalignpairwiseNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_node_fill(s : BioseqalignpairwiseNode, v : Double) -> BioseqalignpairwiseNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_node_min(s : BioseqalignpairwiseNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_pairwise_node_max(s : BioseqalignpairwiseNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_pairwise_node_to_string(s : BioseqalignpairwiseNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_edge_make(size : Int) -> BioseqalignpairwiseEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_edge_len(s : BioseqalignpairwiseEdge) -> Int { s.size }

pub fn bio_seq_align_pairwise_edge_get(s : BioseqalignpairwiseEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_edge_set(s : BioseqalignpairwiseEdge, i : Int, v : Double) -> BioseqalignpairwiseEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_edge_sum(s : BioseqalignpairwiseEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_pairwise_edge_mean(s : BioseqalignpairwiseEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_pairwise_edge_scale(s : BioseqalignpairwiseEdge, f : Double) -> BioseqalignpairwiseEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_edge_add(a : BioseqalignpairwiseEdge, b : BioseqalignpairwiseEdge) -> BioseqalignpairwiseEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_pairwise_edge_copy(s : BioseqalignpairwiseEdge) -> BioseqalignpairwiseEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_edge_fill(s : BioseqalignpairwiseEdge, v : Double) -> BioseqalignpairwiseEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_edge_min(s : BioseqalignpairwiseEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_pairwise_edge_max(s : BioseqalignpairwiseEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_pairwise_edge_to_string(s : BioseqalignpairwiseEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwisePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_path_make(size : Int) -> BioseqalignpairwisePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_path_len(s : BioseqalignpairwisePath) -> Int { s.size }

pub fn bio_seq_align_pairwise_path_get(s : BioseqalignpairwisePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_path_set(s : BioseqalignpairwisePath, i : Int, v : Double) -> BioseqalignpairwisePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_path_sum(s : BioseqalignpairwisePath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_pairwise_path_mean(s : BioseqalignpairwisePath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_pairwise_path_scale(s : BioseqalignpairwisePath, f : Double) -> BioseqalignpairwisePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_path_add(a : BioseqalignpairwisePath, b : BioseqalignpairwisePath) -> BioseqalignpairwisePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_pairwise_path_copy(s : BioseqalignpairwisePath) -> BioseqalignpairwisePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_path_fill(s : BioseqalignpairwisePath, v : Double) -> BioseqalignpairwisePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_path_min(s : BioseqalignpairwisePath) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_pairwise_path_max(s : BioseqalignpairwisePath) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_pairwise_path_to_string(s : BioseqalignpairwisePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_cluster_make(size : Int) -> BioseqalignpairwiseCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_cluster_len(s : BioseqalignpairwiseCluster) -> Int { s.size }

pub fn bio_seq_align_pairwise_cluster_get(s : BioseqalignpairwiseCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_cluster_set(s : BioseqalignpairwiseCluster, i : Int, v : Double) -> BioseqalignpairwiseCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_cluster_sum(s : BioseqalignpairwiseCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_pairwise_cluster_mean(s : BioseqalignpairwiseCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_pairwise_cluster_scale(s : BioseqalignpairwiseCluster, f : Double) -> BioseqalignpairwiseCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_cluster_add(a : BioseqalignpairwiseCluster, b : BioseqalignpairwiseCluster) -> BioseqalignpairwiseCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_pairwise_cluster_copy(s : BioseqalignpairwiseCluster) -> BioseqalignpairwiseCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_cluster_fill(s : BioseqalignpairwiseCluster, v : Double) -> BioseqalignpairwiseCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_cluster_min(s : BioseqalignpairwiseCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_pairwise_cluster_max(s : BioseqalignpairwiseCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_pairwise_cluster_to_string(s : BioseqalignpairwiseCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_model_make(size : Int) -> BioseqalignpairwiseModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_model_len(s : BioseqalignpairwiseModel) -> Int { s.size }

pub fn bio_seq_align_pairwise_model_get(s : BioseqalignpairwiseModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_model_set(s : BioseqalignpairwiseModel, i : Int, v : Double) -> BioseqalignpairwiseModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_model_sum(s : BioseqalignpairwiseModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_pairwise_model_mean(s : BioseqalignpairwiseModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_pairwise_model_scale(s : BioseqalignpairwiseModel, f : Double) -> BioseqalignpairwiseModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_model_add(a : BioseqalignpairwiseModel, b : BioseqalignpairwiseModel) -> BioseqalignpairwiseModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_pairwise_model_copy(s : BioseqalignpairwiseModel) -> BioseqalignpairwiseModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_model_fill(s : BioseqalignpairwiseModel, v : Double) -> BioseqalignpairwiseModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_model_min(s : BioseqalignpairwiseModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_pairwise_model_max(s : BioseqalignpairwiseModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_pairwise_model_to_string(s : BioseqalignpairwiseModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_layer_make(size : Int) -> BioseqalignpairwiseLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_layer_len(s : BioseqalignpairwiseLayer) -> Int { s.size }

pub fn bio_seq_align_pairwise_layer_get(s : BioseqalignpairwiseLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_layer_set(s : BioseqalignpairwiseLayer, i : Int, v : Double) -> BioseqalignpairwiseLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_layer_sum(s : BioseqalignpairwiseLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_pairwise_layer_mean(s : BioseqalignpairwiseLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_pairwise_layer_scale(s : BioseqalignpairwiseLayer, f : Double) -> BioseqalignpairwiseLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_layer_add(a : BioseqalignpairwiseLayer, b : BioseqalignpairwiseLayer) -> BioseqalignpairwiseLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_pairwise_layer_copy(s : BioseqalignpairwiseLayer) -> BioseqalignpairwiseLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_layer_fill(s : BioseqalignpairwiseLayer, v : Double) -> BioseqalignpairwiseLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_layer_min(s : BioseqalignpairwiseLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_pairwise_layer_max(s : BioseqalignpairwiseLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_pairwise_layer_to_string(s : BioseqalignpairwiseLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_buffer_make(size : Int) -> BioseqalignpairwiseBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_buffer_len(s : BioseqalignpairwiseBuffer) -> Int { s.size }

pub fn bio_seq_align_pairwise_buffer_get(s : BioseqalignpairwiseBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_buffer_set(s : BioseqalignpairwiseBuffer, i : Int, v : Double) -> BioseqalignpairwiseBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_buffer_sum(s : BioseqalignpairwiseBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_pairwise_buffer_mean(s : BioseqalignpairwiseBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_pairwise_buffer_scale(s : BioseqalignpairwiseBuffer, f : Double) -> BioseqalignpairwiseBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_buffer_add(a : BioseqalignpairwiseBuffer, b : BioseqalignpairwiseBuffer) -> BioseqalignpairwiseBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_pairwise_buffer_copy(s : BioseqalignpairwiseBuffer) -> BioseqalignpairwiseBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_buffer_fill(s : BioseqalignpairwiseBuffer, v : Double) -> BioseqalignpairwiseBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_buffer_min(s : BioseqalignpairwiseBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_pairwise_buffer_max(s : BioseqalignpairwiseBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_pairwise_buffer_to_string(s : BioseqalignpairwiseBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_cursor_make(size : Int) -> BioseqalignpairwiseCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_cursor_len(s : BioseqalignpairwiseCursor) -> Int { s.size }

pub fn bio_seq_align_pairwise_cursor_get(s : BioseqalignpairwiseCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_cursor_set(s : BioseqalignpairwiseCursor, i : Int, v : Double) -> BioseqalignpairwiseCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_cursor_sum(s : BioseqalignpairwiseCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_pairwise_cursor_mean(s : BioseqalignpairwiseCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_pairwise_cursor_scale(s : BioseqalignpairwiseCursor, f : Double) -> BioseqalignpairwiseCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_cursor_add(a : BioseqalignpairwiseCursor, b : BioseqalignpairwiseCursor) -> BioseqalignpairwiseCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_pairwise_cursor_copy(s : BioseqalignpairwiseCursor) -> BioseqalignpairwiseCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_cursor_fill(s : BioseqalignpairwiseCursor, v : Double) -> BioseqalignpairwiseCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_cursor_min(s : BioseqalignpairwiseCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_pairwise_cursor_max(s : BioseqalignpairwiseCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_pairwise_cursor_to_string(s : BioseqalignpairwiseCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_view_make(size : Int) -> BioseqalignpairwiseView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_view_len(s : BioseqalignpairwiseView) -> Int { s.size }

pub fn bio_seq_align_pairwise_view_get(s : BioseqalignpairwiseView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_view_set(s : BioseqalignpairwiseView, i : Int, v : Double) -> BioseqalignpairwiseView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_view_sum(s : BioseqalignpairwiseView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_pairwise_view_mean(s : BioseqalignpairwiseView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_pairwise_view_scale(s : BioseqalignpairwiseView, f : Double) -> BioseqalignpairwiseView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_view_add(a : BioseqalignpairwiseView, b : BioseqalignpairwiseView) -> BioseqalignpairwiseView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_pairwise_view_copy(s : BioseqalignpairwiseView) -> BioseqalignpairwiseView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_view_fill(s : BioseqalignpairwiseView, v : Double) -> BioseqalignpairwiseView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_view_min(s : BioseqalignpairwiseView) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_pairwise_view_max(s : BioseqalignpairwiseView) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_pairwise_view_to_string(s : BioseqalignpairwiseView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_range_make(size : Int) -> BioseqalignpairwiseRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_range_len(s : BioseqalignpairwiseRange) -> Int { s.size }

pub fn bio_seq_align_pairwise_range_get(s : BioseqalignpairwiseRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_range_set(s : BioseqalignpairwiseRange, i : Int, v : Double) -> BioseqalignpairwiseRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_range_sum(s : BioseqalignpairwiseRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_pairwise_range_mean(s : BioseqalignpairwiseRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_pairwise_range_scale(s : BioseqalignpairwiseRange, f : Double) -> BioseqalignpairwiseRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_range_add(a : BioseqalignpairwiseRange, b : BioseqalignpairwiseRange) -> BioseqalignpairwiseRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_pairwise_range_copy(s : BioseqalignpairwiseRange) -> BioseqalignpairwiseRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_range_fill(s : BioseqalignpairwiseRange, v : Double) -> BioseqalignpairwiseRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_range_min(s : BioseqalignpairwiseRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_pairwise_range_max(s : BioseqalignpairwiseRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_pairwise_range_to_string(s : BioseqalignpairwiseRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignpairwiseSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_pairwise_slice_make(size : Int) -> BioseqalignpairwiseSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_pairwise_slice_len(s : BioseqalignpairwiseSlice) -> Int { s.size }

pub fn bio_seq_align_pairwise_slice_get(s : BioseqalignpairwiseSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_pairwise_slice_set(s : BioseqalignpairwiseSlice, i : Int, v : Double) -> BioseqalignpairwiseSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_slice_sum(s : BioseqalignpairwiseSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_pairwise_slice_mean(s : BioseqalignpairwiseSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_pairwise_slice_scale(s : BioseqalignpairwiseSlice, f : Double) -> BioseqalignpairwiseSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_slice_add(a : BioseqalignpairwiseSlice, b : BioseqalignpairwiseSlice) -> BioseqalignpairwiseSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_pairwise_slice_copy(s : BioseqalignpairwiseSlice) -> BioseqalignpairwiseSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_slice_fill(s : BioseqalignpairwiseSlice, v : Double) -> BioseqalignpairwiseSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_pairwise_slice_min(s : BioseqalignpairwiseSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_pairwise_slice_max(s : BioseqalignpairwiseSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_pairwise_slice_to_string(s : BioseqalignpairwiseSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

