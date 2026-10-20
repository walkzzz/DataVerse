///===
/// extcore/bio_seq_align_progressive

pub(all) struct BioseqalignprogressivePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_progressive_make_point(x : Double, y : Double) -> BioseqalignprogressivePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_progressive_make_point3(x : Double, y : Double, z : Double) -> BioseqalignprogressivePoint {
  { x, y, z, label: 0 }
}

pub fn BioseqalignprogressivePoint::x(self : BioseqalignprogressivePoint) -> Double { self.x }

pub fn BioseqalignprogressivePoint::y(self : BioseqalignprogressivePoint) -> Double { self.y }

pub fn BioseqalignprogressivePoint::z(self : BioseqalignprogressivePoint) -> Double { self.z }

pub fn BioseqalignprogressivePoint::label(self : BioseqalignprogressivePoint) -> Int { self.label }

pub fn BioseqalignprogressivePoint::dist(self : BioseqalignprogressivePoint, other : BioseqalignprogressivePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqalignprogressivePoint::add(self : BioseqalignprogressivePoint, other : BioseqalignprogressivePoint) -> BioseqalignprogressivePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqalignprogressivePoint::sub(self : BioseqalignprogressivePoint, other : BioseqalignprogressivePoint) -> BioseqalignprogressivePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqalignprogressivePoint::scale(self : BioseqalignprogressivePoint, s : Double) -> BioseqalignprogressivePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqalignprogressivePoint::dot(self : BioseqalignprogressivePoint, other : BioseqalignprogressivePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqalignprogressivePoint::cross(self : BioseqalignprogressivePoint, other : BioseqalignprogressivePoint) -> BioseqalignprogressivePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqalignprogressivePoint::norm(self : BioseqalignprogressivePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqalignprogressivePoint::normalize(self : BioseqalignprogressivePoint) -> BioseqalignprogressivePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignprogressivePoint::negate(self : BioseqalignprogressivePoint) -> BioseqalignprogressivePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqalignprogressivePoint::mid(self : BioseqalignprogressivePoint, other : BioseqalignprogressivePoint) -> BioseqalignprogressivePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqalignprogressivePoint::lerp(self : BioseqalignprogressivePoint, other : BioseqalignprogressivePoint, t : Double) -> BioseqalignprogressivePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqalignprogressivePoint::to_string(self : BioseqalignprogressivePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_progressive_make_series(vals : Array[Double], name : String) -> BioseqalignprogressiveSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqalignprogressiveSeries::len(self : BioseqalignprogressiveSeries) -> Int { self.vals.length() }

pub fn BioseqalignprogressiveSeries::sum(self : BioseqalignprogressiveSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqalignprogressiveSeries::mean(self : BioseqalignprogressiveSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqalignprogressiveSeries::min(self : BioseqalignprogressiveSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqalignprogressiveSeries::max(self : BioseqalignprogressiveSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqalignprogressiveSeries::range(self : BioseqalignprogressiveSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqalignprogressiveSeries::variance(self : BioseqalignprogressiveSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqalignprogressiveSeries::std(self : BioseqalignprogressiveSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqalignprogressiveSeries::median(self : BioseqalignprogressiveSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqalignprogressiveSeries::scale(self : BioseqalignprogressiveSeries, f : Double) -> BioseqalignprogressiveSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqalignprogressiveSeries::add(self : BioseqalignprogressiveSeries, other : BioseqalignprogressiveSeries) -> BioseqalignprogressiveSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqalignprogressiveSeries::sub(self : BioseqalignprogressiveSeries, other : BioseqalignprogressiveSeries) -> BioseqalignprogressiveSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqalignprogressiveSeries::normalize(self : BioseqalignprogressiveSeries) -> BioseqalignprogressiveSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqalignprogressiveSeries::cumsum(self : BioseqalignprogressiveSeries) -> BioseqalignprogressiveSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqalignprogressiveSeries::to_string(self : BioseqalignprogressiveSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignprogressiveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_progressive_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignprogressiveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_progressive_matrix_identity(n : Int) -> BioseqalignprogressiveMatrix {
  let m = bio_seq_align_progressive_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqalignprogressiveMatrix::get(self : BioseqalignprogressiveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqalignprogressiveMatrix::transpose(self : BioseqalignprogressiveMatrix) -> BioseqalignprogressiveMatrix {
  let result = bio_seq_align_progressive_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqalignprogressiveMatrix::add(self : BioseqalignprogressiveMatrix, other : BioseqalignprogressiveMatrix) -> BioseqalignprogressiveMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_align_progressive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqalignprogressiveMatrix::scale(self : BioseqalignprogressiveMatrix, s : Double) -> BioseqalignprogressiveMatrix {
  let result = bio_seq_align_progressive_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqalignprogressiveMatrix::multiply(self : BioseqalignprogressiveMatrix, other : BioseqalignprogressiveMatrix) -> BioseqalignprogressiveMatrix {
  if self.cols != other.rows { return bio_seq_align_progressive_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_align_progressive_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqalignprogressiveMatrix::trace(self : BioseqalignprogressiveMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqalignprogressiveMatrix::det(self : BioseqalignprogressiveMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqalignprogressiveMatrix::norm(self : BioseqalignprogressiveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqalignprogressiveMatrix::to_string(self : BioseqalignprogressiveMatrix) -> String {
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

pub(all) struct BioseqalignprogressiveVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_progressive_make_vector(comps : Array[Double]) -> BioseqalignprogressiveVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_progressive_vector_zero(dim : Int) -> BioseqalignprogressiveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqalignprogressiveVector::add(self : BioseqalignprogressiveVector, other : BioseqalignprogressiveVector) -> BioseqalignprogressiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignprogressiveVector::sub(self : BioseqalignprogressiveVector, other : BioseqalignprogressiveVector) -> BioseqalignprogressiveVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignprogressiveVector::scale(self : BioseqalignprogressiveVector, s : Double) -> BioseqalignprogressiveVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqalignprogressiveVector::dot(self : BioseqalignprogressiveVector, other : BioseqalignprogressiveVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqalignprogressiveVector::norm(self : BioseqalignprogressiveVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqalignprogressiveVector::normalize(self : BioseqalignprogressiveVector) -> BioseqalignprogressiveVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignprogressiveVector::dist(self : BioseqalignprogressiveVector, other : BioseqalignprogressiveVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqalignprogressiveVector::to_string(self : BioseqalignprogressiveVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_progressive_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_progressive_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_progressive_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_progressive_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_progressive_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_progressive_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_progressive_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_progressive_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_progressive_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_progressive_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_progressive_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_progressive_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_progressive_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_progressive_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_progressive_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_progressive_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_progressive_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_progressive_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_progressive_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_progressive_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_progressive_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_progressive_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_progressive_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_progressive_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_progressive_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_progressive_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_progressive_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_progressive_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_progressive_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqalignprogressiveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_frame_make(size : Int) -> BioseqalignprogressiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_frame_len(s : BioseqalignprogressiveFrame) -> Int { s.size }

pub fn bio_seq_align_progressive_frame_get(s : BioseqalignprogressiveFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_frame_set(s : BioseqalignprogressiveFrame, i : Int, v : Double) -> BioseqalignprogressiveFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_frame_sum(s : BioseqalignprogressiveFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_frame_mean(s : BioseqalignprogressiveFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_frame_scale(s : BioseqalignprogressiveFrame, f : Double) -> BioseqalignprogressiveFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_frame_add(a : BioseqalignprogressiveFrame, b : BioseqalignprogressiveFrame) -> BioseqalignprogressiveFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_progressive_frame_copy(s : BioseqalignprogressiveFrame) -> BioseqalignprogressiveFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_frame_fill(s : BioseqalignprogressiveFrame, v : Double) -> BioseqalignprogressiveFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_frame_min(s : BioseqalignprogressiveFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_frame_max(s : BioseqalignprogressiveFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_frame_to_string(s : BioseqalignprogressiveFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_table_make(size : Int) -> BioseqalignprogressiveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_table_len(s : BioseqalignprogressiveTable) -> Int { s.size }

pub fn bio_seq_align_progressive_table_get(s : BioseqalignprogressiveTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_table_set(s : BioseqalignprogressiveTable, i : Int, v : Double) -> BioseqalignprogressiveTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_table_sum(s : BioseqalignprogressiveTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_table_mean(s : BioseqalignprogressiveTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_table_scale(s : BioseqalignprogressiveTable, f : Double) -> BioseqalignprogressiveTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_table_add(a : BioseqalignprogressiveTable, b : BioseqalignprogressiveTable) -> BioseqalignprogressiveTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_progressive_table_copy(s : BioseqalignprogressiveTable) -> BioseqalignprogressiveTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_table_fill(s : BioseqalignprogressiveTable, v : Double) -> BioseqalignprogressiveTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_table_min(s : BioseqalignprogressiveTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_table_max(s : BioseqalignprogressiveTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_table_to_string(s : BioseqalignprogressiveTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_graphn_make(size : Int) -> BioseqalignprogressiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_graphn_len(s : BioseqalignprogressiveGraphN) -> Int { s.size }

pub fn bio_seq_align_progressive_graphn_get(s : BioseqalignprogressiveGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_graphn_set(s : BioseqalignprogressiveGraphN, i : Int, v : Double) -> BioseqalignprogressiveGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_graphn_sum(s : BioseqalignprogressiveGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_graphn_mean(s : BioseqalignprogressiveGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_graphn_scale(s : BioseqalignprogressiveGraphN, f : Double) -> BioseqalignprogressiveGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_graphn_add(a : BioseqalignprogressiveGraphN, b : BioseqalignprogressiveGraphN) -> BioseqalignprogressiveGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_progressive_graphn_copy(s : BioseqalignprogressiveGraphN) -> BioseqalignprogressiveGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_graphn_fill(s : BioseqalignprogressiveGraphN, v : Double) -> BioseqalignprogressiveGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_graphn_min(s : BioseqalignprogressiveGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_graphn_max(s : BioseqalignprogressiveGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_graphn_to_string(s : BioseqalignprogressiveGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_node_make(size : Int) -> BioseqalignprogressiveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_node_len(s : BioseqalignprogressiveNode) -> Int { s.size }

pub fn bio_seq_align_progressive_node_get(s : BioseqalignprogressiveNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_node_set(s : BioseqalignprogressiveNode, i : Int, v : Double) -> BioseqalignprogressiveNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_node_sum(s : BioseqalignprogressiveNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_node_mean(s : BioseqalignprogressiveNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_node_scale(s : BioseqalignprogressiveNode, f : Double) -> BioseqalignprogressiveNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_node_add(a : BioseqalignprogressiveNode, b : BioseqalignprogressiveNode) -> BioseqalignprogressiveNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_progressive_node_copy(s : BioseqalignprogressiveNode) -> BioseqalignprogressiveNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_node_fill(s : BioseqalignprogressiveNode, v : Double) -> BioseqalignprogressiveNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_node_min(s : BioseqalignprogressiveNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_node_max(s : BioseqalignprogressiveNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_node_to_string(s : BioseqalignprogressiveNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_edge_make(size : Int) -> BioseqalignprogressiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_edge_len(s : BioseqalignprogressiveEdge) -> Int { s.size }

pub fn bio_seq_align_progressive_edge_get(s : BioseqalignprogressiveEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_edge_set(s : BioseqalignprogressiveEdge, i : Int, v : Double) -> BioseqalignprogressiveEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_edge_sum(s : BioseqalignprogressiveEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_edge_mean(s : BioseqalignprogressiveEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_edge_scale(s : BioseqalignprogressiveEdge, f : Double) -> BioseqalignprogressiveEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_edge_add(a : BioseqalignprogressiveEdge, b : BioseqalignprogressiveEdge) -> BioseqalignprogressiveEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_progressive_edge_copy(s : BioseqalignprogressiveEdge) -> BioseqalignprogressiveEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_edge_fill(s : BioseqalignprogressiveEdge, v : Double) -> BioseqalignprogressiveEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_edge_min(s : BioseqalignprogressiveEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_edge_max(s : BioseqalignprogressiveEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_edge_to_string(s : BioseqalignprogressiveEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressivePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_path_make(size : Int) -> BioseqalignprogressivePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_path_len(s : BioseqalignprogressivePath) -> Int { s.size }

pub fn bio_seq_align_progressive_path_get(s : BioseqalignprogressivePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_path_set(s : BioseqalignprogressivePath, i : Int, v : Double) -> BioseqalignprogressivePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_path_sum(s : BioseqalignprogressivePath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_path_mean(s : BioseqalignprogressivePath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_path_scale(s : BioseqalignprogressivePath, f : Double) -> BioseqalignprogressivePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_path_add(a : BioseqalignprogressivePath, b : BioseqalignprogressivePath) -> BioseqalignprogressivePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_progressive_path_copy(s : BioseqalignprogressivePath) -> BioseqalignprogressivePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_path_fill(s : BioseqalignprogressivePath, v : Double) -> BioseqalignprogressivePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_path_min(s : BioseqalignprogressivePath) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_path_max(s : BioseqalignprogressivePath) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_path_to_string(s : BioseqalignprogressivePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_cluster_make(size : Int) -> BioseqalignprogressiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_cluster_len(s : BioseqalignprogressiveCluster) -> Int { s.size }

pub fn bio_seq_align_progressive_cluster_get(s : BioseqalignprogressiveCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_cluster_set(s : BioseqalignprogressiveCluster, i : Int, v : Double) -> BioseqalignprogressiveCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_cluster_sum(s : BioseqalignprogressiveCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_cluster_mean(s : BioseqalignprogressiveCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_cluster_scale(s : BioseqalignprogressiveCluster, f : Double) -> BioseqalignprogressiveCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_cluster_add(a : BioseqalignprogressiveCluster, b : BioseqalignprogressiveCluster) -> BioseqalignprogressiveCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_progressive_cluster_copy(s : BioseqalignprogressiveCluster) -> BioseqalignprogressiveCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_cluster_fill(s : BioseqalignprogressiveCluster, v : Double) -> BioseqalignprogressiveCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_cluster_min(s : BioseqalignprogressiveCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_cluster_max(s : BioseqalignprogressiveCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_cluster_to_string(s : BioseqalignprogressiveCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_model_make(size : Int) -> BioseqalignprogressiveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_model_len(s : BioseqalignprogressiveModel) -> Int { s.size }

pub fn bio_seq_align_progressive_model_get(s : BioseqalignprogressiveModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_model_set(s : BioseqalignprogressiveModel, i : Int, v : Double) -> BioseqalignprogressiveModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_model_sum(s : BioseqalignprogressiveModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_model_mean(s : BioseqalignprogressiveModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_model_scale(s : BioseqalignprogressiveModel, f : Double) -> BioseqalignprogressiveModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_model_add(a : BioseqalignprogressiveModel, b : BioseqalignprogressiveModel) -> BioseqalignprogressiveModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_progressive_model_copy(s : BioseqalignprogressiveModel) -> BioseqalignprogressiveModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_model_fill(s : BioseqalignprogressiveModel, v : Double) -> BioseqalignprogressiveModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_model_min(s : BioseqalignprogressiveModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_model_max(s : BioseqalignprogressiveModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_model_to_string(s : BioseqalignprogressiveModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_layer_make(size : Int) -> BioseqalignprogressiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_layer_len(s : BioseqalignprogressiveLayer) -> Int { s.size }

pub fn bio_seq_align_progressive_layer_get(s : BioseqalignprogressiveLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_layer_set(s : BioseqalignprogressiveLayer, i : Int, v : Double) -> BioseqalignprogressiveLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_layer_sum(s : BioseqalignprogressiveLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_layer_mean(s : BioseqalignprogressiveLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_layer_scale(s : BioseqalignprogressiveLayer, f : Double) -> BioseqalignprogressiveLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_layer_add(a : BioseqalignprogressiveLayer, b : BioseqalignprogressiveLayer) -> BioseqalignprogressiveLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_progressive_layer_copy(s : BioseqalignprogressiveLayer) -> BioseqalignprogressiveLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_layer_fill(s : BioseqalignprogressiveLayer, v : Double) -> BioseqalignprogressiveLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_layer_min(s : BioseqalignprogressiveLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_layer_max(s : BioseqalignprogressiveLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_layer_to_string(s : BioseqalignprogressiveLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_buffer_make(size : Int) -> BioseqalignprogressiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_buffer_len(s : BioseqalignprogressiveBuffer) -> Int { s.size }

pub fn bio_seq_align_progressive_buffer_get(s : BioseqalignprogressiveBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_buffer_set(s : BioseqalignprogressiveBuffer, i : Int, v : Double) -> BioseqalignprogressiveBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_buffer_sum(s : BioseqalignprogressiveBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_buffer_mean(s : BioseqalignprogressiveBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_buffer_scale(s : BioseqalignprogressiveBuffer, f : Double) -> BioseqalignprogressiveBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_buffer_add(a : BioseqalignprogressiveBuffer, b : BioseqalignprogressiveBuffer) -> BioseqalignprogressiveBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_progressive_buffer_copy(s : BioseqalignprogressiveBuffer) -> BioseqalignprogressiveBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_buffer_fill(s : BioseqalignprogressiveBuffer, v : Double) -> BioseqalignprogressiveBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_buffer_min(s : BioseqalignprogressiveBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_buffer_max(s : BioseqalignprogressiveBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_buffer_to_string(s : BioseqalignprogressiveBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_cursor_make(size : Int) -> BioseqalignprogressiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_cursor_len(s : BioseqalignprogressiveCursor) -> Int { s.size }

pub fn bio_seq_align_progressive_cursor_get(s : BioseqalignprogressiveCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_cursor_set(s : BioseqalignprogressiveCursor, i : Int, v : Double) -> BioseqalignprogressiveCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_cursor_sum(s : BioseqalignprogressiveCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_cursor_mean(s : BioseqalignprogressiveCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_cursor_scale(s : BioseqalignprogressiveCursor, f : Double) -> BioseqalignprogressiveCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_cursor_add(a : BioseqalignprogressiveCursor, b : BioseqalignprogressiveCursor) -> BioseqalignprogressiveCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_progressive_cursor_copy(s : BioseqalignprogressiveCursor) -> BioseqalignprogressiveCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_cursor_fill(s : BioseqalignprogressiveCursor, v : Double) -> BioseqalignprogressiveCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_cursor_min(s : BioseqalignprogressiveCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_cursor_max(s : BioseqalignprogressiveCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_cursor_to_string(s : BioseqalignprogressiveCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_view_make(size : Int) -> BioseqalignprogressiveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_view_len(s : BioseqalignprogressiveView) -> Int { s.size }

pub fn bio_seq_align_progressive_view_get(s : BioseqalignprogressiveView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_view_set(s : BioseqalignprogressiveView, i : Int, v : Double) -> BioseqalignprogressiveView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_view_sum(s : BioseqalignprogressiveView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_view_mean(s : BioseqalignprogressiveView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_view_scale(s : BioseqalignprogressiveView, f : Double) -> BioseqalignprogressiveView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_view_add(a : BioseqalignprogressiveView, b : BioseqalignprogressiveView) -> BioseqalignprogressiveView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_progressive_view_copy(s : BioseqalignprogressiveView) -> BioseqalignprogressiveView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_view_fill(s : BioseqalignprogressiveView, v : Double) -> BioseqalignprogressiveView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_view_min(s : BioseqalignprogressiveView) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_view_max(s : BioseqalignprogressiveView) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_view_to_string(s : BioseqalignprogressiveView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_range_make(size : Int) -> BioseqalignprogressiveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_range_len(s : BioseqalignprogressiveRange) -> Int { s.size }

pub fn bio_seq_align_progressive_range_get(s : BioseqalignprogressiveRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_range_set(s : BioseqalignprogressiveRange, i : Int, v : Double) -> BioseqalignprogressiveRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_range_sum(s : BioseqalignprogressiveRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_range_mean(s : BioseqalignprogressiveRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_range_scale(s : BioseqalignprogressiveRange, f : Double) -> BioseqalignprogressiveRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_range_add(a : BioseqalignprogressiveRange, b : BioseqalignprogressiveRange) -> BioseqalignprogressiveRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_progressive_range_copy(s : BioseqalignprogressiveRange) -> BioseqalignprogressiveRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_range_fill(s : BioseqalignprogressiveRange, v : Double) -> BioseqalignprogressiveRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_range_min(s : BioseqalignprogressiveRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_range_max(s : BioseqalignprogressiveRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_range_to_string(s : BioseqalignprogressiveRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignprogressiveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_progressive_slice_make(size : Int) -> BioseqalignprogressiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_progressive_slice_len(s : BioseqalignprogressiveSlice) -> Int { s.size }

pub fn bio_seq_align_progressive_slice_get(s : BioseqalignprogressiveSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_progressive_slice_set(s : BioseqalignprogressiveSlice, i : Int, v : Double) -> BioseqalignprogressiveSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_slice_sum(s : BioseqalignprogressiveSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_progressive_slice_mean(s : BioseqalignprogressiveSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_progressive_slice_scale(s : BioseqalignprogressiveSlice, f : Double) -> BioseqalignprogressiveSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_slice_add(a : BioseqalignprogressiveSlice, b : BioseqalignprogressiveSlice) -> BioseqalignprogressiveSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_progressive_slice_copy(s : BioseqalignprogressiveSlice) -> BioseqalignprogressiveSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_slice_fill(s : BioseqalignprogressiveSlice, v : Double) -> BioseqalignprogressiveSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_progressive_slice_min(s : BioseqalignprogressiveSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_progressive_slice_max(s : BioseqalignprogressiveSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_progressive_slice_to_string(s : BioseqalignprogressiveSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

