///===
/// extcore/bio_seq_align_consistency

pub(all) struct BioseqalignconsistencyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_consistency_make_point(x : Double, y : Double) -> BioseqalignconsistencyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_consistency_make_point3(x : Double, y : Double, z : Double) -> BioseqalignconsistencyPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqalignconsistencyPoint::x(self : BioseqalignconsistencyPoint) -> Double { self.x }

pub fn BioseqalignconsistencyPoint::y(self : BioseqalignconsistencyPoint) -> Double { self.y }

pub fn BioseqalignconsistencyPoint::z(self : BioseqalignconsistencyPoint) -> Double { self.z }

pub fn BioseqalignconsistencyPoint::label(self : BioseqalignconsistencyPoint) -> Int { self.label }

pub fn BioseqalignconsistencyPoint::dist(self : BioseqalignconsistencyPoint, other : BioseqalignconsistencyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqalignconsistencyPoint::add(self : BioseqalignconsistencyPoint, other : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqalignconsistencyPoint::sub(self : BioseqalignconsistencyPoint, other : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqalignconsistencyPoint::scale(self : BioseqalignconsistencyPoint, s : Double) -> BioseqalignconsistencyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqalignconsistencyPoint::dot(self : BioseqalignconsistencyPoint, other : BioseqalignconsistencyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqalignconsistencyPoint::cross(self : BioseqalignconsistencyPoint, other : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqalignconsistencyPoint::norm(self : BioseqalignconsistencyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqalignconsistencyPoint::normalize(self : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignconsistencyPoint::negate(self : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqalignconsistencyPoint::mid(self : BioseqalignconsistencyPoint, other : BioseqalignconsistencyPoint) -> BioseqalignconsistencyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqalignconsistencyPoint::lerp(self : BioseqalignconsistencyPoint, other : BioseqalignconsistencyPoint, t : Double) -> BioseqalignconsistencyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqalignconsistencyPoint::to_string(self : BioseqalignconsistencyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqalignconsistencySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_consistency_make_series(vals : Array[Double], name : String) -> BioseqalignconsistencySeries {
  { vals, name, meta: 0 }
}

pub fn BioseqalignconsistencySeries::len(self : BioseqalignconsistencySeries) -> Int { self.vals.length() }

pub fn BioseqalignconsistencySeries::sum(self : BioseqalignconsistencySeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqalignconsistencySeries::mean(self : BioseqalignconsistencySeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqalignconsistencySeries::min(self : BioseqalignconsistencySeries) -> Double { @_common.min(self.vals) }

pub fn BioseqalignconsistencySeries::max(self : BioseqalignconsistencySeries) -> Double { @_common.max(self.vals) }

pub fn BioseqalignconsistencySeries::range(self : BioseqalignconsistencySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqalignconsistencySeries::variance(self : BioseqalignconsistencySeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqalignconsistencySeries::std(self : BioseqalignconsistencySeries) -> Double { @_common.std(self.vals) }

pub fn BioseqalignconsistencySeries::median(self : BioseqalignconsistencySeries) -> Double { @_common.median(self.vals) }

pub fn BioseqalignconsistencySeries::scale(self : BioseqalignconsistencySeries, f : Double) -> BioseqalignconsistencySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqalignconsistencySeries::add(self : BioseqalignconsistencySeries, other : BioseqalignconsistencySeries) -> BioseqalignconsistencySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqalignconsistencySeries::sub(self : BioseqalignconsistencySeries, other : BioseqalignconsistencySeries) -> BioseqalignconsistencySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqalignconsistencySeries::normalize(self : BioseqalignconsistencySeries) -> BioseqalignconsistencySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqalignconsistencySeries::cumsum(self : BioseqalignconsistencySeries) -> BioseqalignconsistencySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqalignconsistencySeries::to_string(self : BioseqalignconsistencySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignconsistencyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_consistency_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignconsistencyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_consistency_matrix_identity(n : Int) -> BioseqalignconsistencyMatrix {
  let m = bio_seq_align_consistency_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqalignconsistencyMatrix::get(self : BioseqalignconsistencyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqalignconsistencyMatrix::transpose(self : BioseqalignconsistencyMatrix) -> BioseqalignconsistencyMatrix {
  let result = bio_seq_align_consistency_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqalignconsistencyMatrix::add(self : BioseqalignconsistencyMatrix, other : BioseqalignconsistencyMatrix) -> BioseqalignconsistencyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_align_consistency_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqalignconsistencyMatrix::scale(self : BioseqalignconsistencyMatrix, s : Double) -> BioseqalignconsistencyMatrix {
  let result = bio_seq_align_consistency_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqalignconsistencyMatrix::multiply(self : BioseqalignconsistencyMatrix, other : BioseqalignconsistencyMatrix) -> BioseqalignconsistencyMatrix {
  if self.cols != other.rows { return bio_seq_align_consistency_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_align_consistency_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqalignconsistencyMatrix::trace(self : BioseqalignconsistencyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqalignconsistencyMatrix::det(self : BioseqalignconsistencyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqalignconsistencyMatrix::norm(self : BioseqalignconsistencyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqalignconsistencyMatrix::to_string(self : BioseqalignconsistencyMatrix) -> String {
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

pub(all) struct BioseqalignconsistencyVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_consistency_make_vector(comps : Array[Double]) -> BioseqalignconsistencyVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_consistency_vector_zero(dim : Int) -> BioseqalignconsistencyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqalignconsistencyVector::add(self : BioseqalignconsistencyVector, other : BioseqalignconsistencyVector) -> BioseqalignconsistencyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignconsistencyVector::sub(self : BioseqalignconsistencyVector, other : BioseqalignconsistencyVector) -> BioseqalignconsistencyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignconsistencyVector::scale(self : BioseqalignconsistencyVector, s : Double) -> BioseqalignconsistencyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqalignconsistencyVector::dot(self : BioseqalignconsistencyVector, other : BioseqalignconsistencyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqalignconsistencyVector::norm(self : BioseqalignconsistencyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqalignconsistencyVector::normalize(self : BioseqalignconsistencyVector) -> BioseqalignconsistencyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignconsistencyVector::dist(self : BioseqalignconsistencyVector, other : BioseqalignconsistencyVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqalignconsistencyVector::to_string(self : BioseqalignconsistencyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_consistency_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_consistency_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_consistency_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_consistency_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_consistency_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_consistency_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_consistency_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_consistency_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_consistency_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_consistency_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_consistency_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_consistency_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_consistency_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_consistency_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_consistency_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_consistency_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_consistency_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_consistency_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_consistency_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_consistency_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_consistency_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_consistency_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_consistency_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_consistency_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_consistency_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_consistency_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_consistency_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_consistency_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_consistency_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqalignconsistencyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_frame_make(size : Int) -> BioseqalignconsistencyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_frame_len(s : BioseqalignconsistencyFrame) -> Int { s.size }

pub fn bio_seq_align_consistency_frame_get(s : BioseqalignconsistencyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_frame_set(s : BioseqalignconsistencyFrame, i : Int, v : Double) -> BioseqalignconsistencyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_frame_sum(s : BioseqalignconsistencyFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_consistency_frame_mean(s : BioseqalignconsistencyFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_consistency_frame_scale(s : BioseqalignconsistencyFrame, f : Double) -> BioseqalignconsistencyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_frame_add(a : BioseqalignconsistencyFrame, b : BioseqalignconsistencyFrame) -> BioseqalignconsistencyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_consistency_frame_copy(s : BioseqalignconsistencyFrame) -> BioseqalignconsistencyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_frame_fill(s : BioseqalignconsistencyFrame, v : Double) -> BioseqalignconsistencyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_frame_min(s : BioseqalignconsistencyFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_consistency_frame_max(s : BioseqalignconsistencyFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_consistency_frame_to_string(s : BioseqalignconsistencyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_table_make(size : Int) -> BioseqalignconsistencyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_table_len(s : BioseqalignconsistencyTable) -> Int { s.size }

pub fn bio_seq_align_consistency_table_get(s : BioseqalignconsistencyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_table_set(s : BioseqalignconsistencyTable, i : Int, v : Double) -> BioseqalignconsistencyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_table_sum(s : BioseqalignconsistencyTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_consistency_table_mean(s : BioseqalignconsistencyTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_consistency_table_scale(s : BioseqalignconsistencyTable, f : Double) -> BioseqalignconsistencyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_table_add(a : BioseqalignconsistencyTable, b : BioseqalignconsistencyTable) -> BioseqalignconsistencyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_consistency_table_copy(s : BioseqalignconsistencyTable) -> BioseqalignconsistencyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_table_fill(s : BioseqalignconsistencyTable, v : Double) -> BioseqalignconsistencyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_table_min(s : BioseqalignconsistencyTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_consistency_table_max(s : BioseqalignconsistencyTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_consistency_table_to_string(s : BioseqalignconsistencyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_graphn_make(size : Int) -> BioseqalignconsistencyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_graphn_len(s : BioseqalignconsistencyGraphN) -> Int { s.size }

pub fn bio_seq_align_consistency_graphn_get(s : BioseqalignconsistencyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_graphn_set(s : BioseqalignconsistencyGraphN, i : Int, v : Double) -> BioseqalignconsistencyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_graphn_sum(s : BioseqalignconsistencyGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_consistency_graphn_mean(s : BioseqalignconsistencyGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_consistency_graphn_scale(s : BioseqalignconsistencyGraphN, f : Double) -> BioseqalignconsistencyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_graphn_add(a : BioseqalignconsistencyGraphN, b : BioseqalignconsistencyGraphN) -> BioseqalignconsistencyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_consistency_graphn_copy(s : BioseqalignconsistencyGraphN) -> BioseqalignconsistencyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_graphn_fill(s : BioseqalignconsistencyGraphN, v : Double) -> BioseqalignconsistencyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_graphn_min(s : BioseqalignconsistencyGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_consistency_graphn_max(s : BioseqalignconsistencyGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_consistency_graphn_to_string(s : BioseqalignconsistencyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_node_make(size : Int) -> BioseqalignconsistencyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_node_len(s : BioseqalignconsistencyNode) -> Int { s.size }

pub fn bio_seq_align_consistency_node_get(s : BioseqalignconsistencyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_node_set(s : BioseqalignconsistencyNode, i : Int, v : Double) -> BioseqalignconsistencyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_node_sum(s : BioseqalignconsistencyNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_consistency_node_mean(s : BioseqalignconsistencyNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_consistency_node_scale(s : BioseqalignconsistencyNode, f : Double) -> BioseqalignconsistencyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_node_add(a : BioseqalignconsistencyNode, b : BioseqalignconsistencyNode) -> BioseqalignconsistencyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_consistency_node_copy(s : BioseqalignconsistencyNode) -> BioseqalignconsistencyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_node_fill(s : BioseqalignconsistencyNode, v : Double) -> BioseqalignconsistencyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_node_min(s : BioseqalignconsistencyNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_consistency_node_max(s : BioseqalignconsistencyNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_consistency_node_to_string(s : BioseqalignconsistencyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_edge_make(size : Int) -> BioseqalignconsistencyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_edge_len(s : BioseqalignconsistencyEdge) -> Int { s.size }

pub fn bio_seq_align_consistency_edge_get(s : BioseqalignconsistencyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_edge_set(s : BioseqalignconsistencyEdge, i : Int, v : Double) -> BioseqalignconsistencyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_edge_sum(s : BioseqalignconsistencyEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_consistency_edge_mean(s : BioseqalignconsistencyEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_consistency_edge_scale(s : BioseqalignconsistencyEdge, f : Double) -> BioseqalignconsistencyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_edge_add(a : BioseqalignconsistencyEdge, b : BioseqalignconsistencyEdge) -> BioseqalignconsistencyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_consistency_edge_copy(s : BioseqalignconsistencyEdge) -> BioseqalignconsistencyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_edge_fill(s : BioseqalignconsistencyEdge, v : Double) -> BioseqalignconsistencyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_edge_min(s : BioseqalignconsistencyEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_consistency_edge_max(s : BioseqalignconsistencyEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_consistency_edge_to_string(s : BioseqalignconsistencyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_path_make(size : Int) -> BioseqalignconsistencyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_path_len(s : BioseqalignconsistencyPath) -> Int { s.size }

pub fn bio_seq_align_consistency_path_get(s : BioseqalignconsistencyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_path_set(s : BioseqalignconsistencyPath, i : Int, v : Double) -> BioseqalignconsistencyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_path_sum(s : BioseqalignconsistencyPath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_consistency_path_mean(s : BioseqalignconsistencyPath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_consistency_path_scale(s : BioseqalignconsistencyPath, f : Double) -> BioseqalignconsistencyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_path_add(a : BioseqalignconsistencyPath, b : BioseqalignconsistencyPath) -> BioseqalignconsistencyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_consistency_path_copy(s : BioseqalignconsistencyPath) -> BioseqalignconsistencyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_path_fill(s : BioseqalignconsistencyPath, v : Double) -> BioseqalignconsistencyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_path_min(s : BioseqalignconsistencyPath) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_consistency_path_max(s : BioseqalignconsistencyPath) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_consistency_path_to_string(s : BioseqalignconsistencyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_cluster_make(size : Int) -> BioseqalignconsistencyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_cluster_len(s : BioseqalignconsistencyCluster) -> Int { s.size }

pub fn bio_seq_align_consistency_cluster_get(s : BioseqalignconsistencyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_cluster_set(s : BioseqalignconsistencyCluster, i : Int, v : Double) -> BioseqalignconsistencyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_cluster_sum(s : BioseqalignconsistencyCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_consistency_cluster_mean(s : BioseqalignconsistencyCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_consistency_cluster_scale(s : BioseqalignconsistencyCluster, f : Double) -> BioseqalignconsistencyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_cluster_add(a : BioseqalignconsistencyCluster, b : BioseqalignconsistencyCluster) -> BioseqalignconsistencyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_consistency_cluster_copy(s : BioseqalignconsistencyCluster) -> BioseqalignconsistencyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_cluster_fill(s : BioseqalignconsistencyCluster, v : Double) -> BioseqalignconsistencyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_cluster_min(s : BioseqalignconsistencyCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_consistency_cluster_max(s : BioseqalignconsistencyCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_consistency_cluster_to_string(s : BioseqalignconsistencyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_model_make(size : Int) -> BioseqalignconsistencyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_model_len(s : BioseqalignconsistencyModel) -> Int { s.size }

pub fn bio_seq_align_consistency_model_get(s : BioseqalignconsistencyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_model_set(s : BioseqalignconsistencyModel, i : Int, v : Double) -> BioseqalignconsistencyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_model_sum(s : BioseqalignconsistencyModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_consistency_model_mean(s : BioseqalignconsistencyModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_consistency_model_scale(s : BioseqalignconsistencyModel, f : Double) -> BioseqalignconsistencyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_model_add(a : BioseqalignconsistencyModel, b : BioseqalignconsistencyModel) -> BioseqalignconsistencyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_consistency_model_copy(s : BioseqalignconsistencyModel) -> BioseqalignconsistencyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_model_fill(s : BioseqalignconsistencyModel, v : Double) -> BioseqalignconsistencyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_model_min(s : BioseqalignconsistencyModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_consistency_model_max(s : BioseqalignconsistencyModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_consistency_model_to_string(s : BioseqalignconsistencyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_layer_make(size : Int) -> BioseqalignconsistencyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_layer_len(s : BioseqalignconsistencyLayer) -> Int { s.size }

pub fn bio_seq_align_consistency_layer_get(s : BioseqalignconsistencyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_layer_set(s : BioseqalignconsistencyLayer, i : Int, v : Double) -> BioseqalignconsistencyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_layer_sum(s : BioseqalignconsistencyLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_consistency_layer_mean(s : BioseqalignconsistencyLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_consistency_layer_scale(s : BioseqalignconsistencyLayer, f : Double) -> BioseqalignconsistencyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_layer_add(a : BioseqalignconsistencyLayer, b : BioseqalignconsistencyLayer) -> BioseqalignconsistencyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_consistency_layer_copy(s : BioseqalignconsistencyLayer) -> BioseqalignconsistencyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_layer_fill(s : BioseqalignconsistencyLayer, v : Double) -> BioseqalignconsistencyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_layer_min(s : BioseqalignconsistencyLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_consistency_layer_max(s : BioseqalignconsistencyLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_consistency_layer_to_string(s : BioseqalignconsistencyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_buffer_make(size : Int) -> BioseqalignconsistencyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_buffer_len(s : BioseqalignconsistencyBuffer) -> Int { s.size }

pub fn bio_seq_align_consistency_buffer_get(s : BioseqalignconsistencyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_buffer_set(s : BioseqalignconsistencyBuffer, i : Int, v : Double) -> BioseqalignconsistencyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_buffer_sum(s : BioseqalignconsistencyBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_consistency_buffer_mean(s : BioseqalignconsistencyBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_consistency_buffer_scale(s : BioseqalignconsistencyBuffer, f : Double) -> BioseqalignconsistencyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_buffer_add(a : BioseqalignconsistencyBuffer, b : BioseqalignconsistencyBuffer) -> BioseqalignconsistencyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_consistency_buffer_copy(s : BioseqalignconsistencyBuffer) -> BioseqalignconsistencyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_buffer_fill(s : BioseqalignconsistencyBuffer, v : Double) -> BioseqalignconsistencyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_buffer_min(s : BioseqalignconsistencyBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_consistency_buffer_max(s : BioseqalignconsistencyBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_consistency_buffer_to_string(s : BioseqalignconsistencyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_cursor_make(size : Int) -> BioseqalignconsistencyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_cursor_len(s : BioseqalignconsistencyCursor) -> Int { s.size }

pub fn bio_seq_align_consistency_cursor_get(s : BioseqalignconsistencyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_cursor_set(s : BioseqalignconsistencyCursor, i : Int, v : Double) -> BioseqalignconsistencyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_cursor_sum(s : BioseqalignconsistencyCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_consistency_cursor_mean(s : BioseqalignconsistencyCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_consistency_cursor_scale(s : BioseqalignconsistencyCursor, f : Double) -> BioseqalignconsistencyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_cursor_add(a : BioseqalignconsistencyCursor, b : BioseqalignconsistencyCursor) -> BioseqalignconsistencyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_consistency_cursor_copy(s : BioseqalignconsistencyCursor) -> BioseqalignconsistencyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_cursor_fill(s : BioseqalignconsistencyCursor, v : Double) -> BioseqalignconsistencyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_cursor_min(s : BioseqalignconsistencyCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_consistency_cursor_max(s : BioseqalignconsistencyCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_consistency_cursor_to_string(s : BioseqalignconsistencyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_view_make(size : Int) -> BioseqalignconsistencyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_view_len(s : BioseqalignconsistencyView) -> Int { s.size }

pub fn bio_seq_align_consistency_view_get(s : BioseqalignconsistencyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_view_set(s : BioseqalignconsistencyView, i : Int, v : Double) -> BioseqalignconsistencyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_view_sum(s : BioseqalignconsistencyView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_consistency_view_mean(s : BioseqalignconsistencyView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_consistency_view_scale(s : BioseqalignconsistencyView, f : Double) -> BioseqalignconsistencyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_view_add(a : BioseqalignconsistencyView, b : BioseqalignconsistencyView) -> BioseqalignconsistencyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_consistency_view_copy(s : BioseqalignconsistencyView) -> BioseqalignconsistencyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_view_fill(s : BioseqalignconsistencyView, v : Double) -> BioseqalignconsistencyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_view_min(s : BioseqalignconsistencyView) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_consistency_view_max(s : BioseqalignconsistencyView) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_consistency_view_to_string(s : BioseqalignconsistencyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_range_make(size : Int) -> BioseqalignconsistencyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_range_len(s : BioseqalignconsistencyRange) -> Int { s.size }

pub fn bio_seq_align_consistency_range_get(s : BioseqalignconsistencyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_range_set(s : BioseqalignconsistencyRange, i : Int, v : Double) -> BioseqalignconsistencyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_range_sum(s : BioseqalignconsistencyRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_consistency_range_mean(s : BioseqalignconsistencyRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_consistency_range_scale(s : BioseqalignconsistencyRange, f : Double) -> BioseqalignconsistencyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_range_add(a : BioseqalignconsistencyRange, b : BioseqalignconsistencyRange) -> BioseqalignconsistencyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_consistency_range_copy(s : BioseqalignconsistencyRange) -> BioseqalignconsistencyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_range_fill(s : BioseqalignconsistencyRange, v : Double) -> BioseqalignconsistencyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_range_min(s : BioseqalignconsistencyRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_consistency_range_max(s : BioseqalignconsistencyRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_consistency_range_to_string(s : BioseqalignconsistencyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignconsistencySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_consistency_slice_make(size : Int) -> BioseqalignconsistencySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_consistency_slice_len(s : BioseqalignconsistencySlice) -> Int { s.size }

pub fn bio_seq_align_consistency_slice_get(s : BioseqalignconsistencySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_consistency_slice_set(s : BioseqalignconsistencySlice, i : Int, v : Double) -> BioseqalignconsistencySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_slice_sum(s : BioseqalignconsistencySlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_consistency_slice_mean(s : BioseqalignconsistencySlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_consistency_slice_scale(s : BioseqalignconsistencySlice, f : Double) -> BioseqalignconsistencySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_slice_add(a : BioseqalignconsistencySlice, b : BioseqalignconsistencySlice) -> BioseqalignconsistencySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_consistency_slice_copy(s : BioseqalignconsistencySlice) -> BioseqalignconsistencySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_slice_fill(s : BioseqalignconsistencySlice, v : Double) -> BioseqalignconsistencySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_consistency_slice_min(s : BioseqalignconsistencySlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_consistency_slice_max(s : BioseqalignconsistencySlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_consistency_slice_to_string(s : BioseqalignconsistencySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

