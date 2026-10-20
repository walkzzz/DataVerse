///===
/// extcore/bio_seq_align_structural

pub(all) struct BioseqalignstructuralPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_structural_make_point(x : Double, y : Double) -> BioseqalignstructuralPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_structural_make_point3(x : Double, y : Double, z : Double) -> BioseqalignstructuralPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqalignstructuralPoint::x(self : BioseqalignstructuralPoint) -> Double { self.x }

pub fn BioseqalignstructuralPoint::y(self : BioseqalignstructuralPoint) -> Double { self.y }

pub fn BioseqalignstructuralPoint::z(self : BioseqalignstructuralPoint) -> Double { self.z }

pub fn BioseqalignstructuralPoint::label(self : BioseqalignstructuralPoint) -> Int { self.label }

pub fn BioseqalignstructuralPoint::dist(self : BioseqalignstructuralPoint, other : BioseqalignstructuralPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqalignstructuralPoint::add(self : BioseqalignstructuralPoint, other : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqalignstructuralPoint::sub(self : BioseqalignstructuralPoint, other : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqalignstructuralPoint::scale(self : BioseqalignstructuralPoint, s : Double) -> BioseqalignstructuralPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqalignstructuralPoint::dot(self : BioseqalignstructuralPoint, other : BioseqalignstructuralPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqalignstructuralPoint::cross(self : BioseqalignstructuralPoint, other : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqalignstructuralPoint::norm(self : BioseqalignstructuralPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqalignstructuralPoint::normalize(self : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignstructuralPoint::negate(self : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqalignstructuralPoint::mid(self : BioseqalignstructuralPoint, other : BioseqalignstructuralPoint) -> BioseqalignstructuralPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqalignstructuralPoint::lerp(self : BioseqalignstructuralPoint, other : BioseqalignstructuralPoint, t : Double) -> BioseqalignstructuralPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqalignstructuralPoint::to_string(self : BioseqalignstructuralPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqalignstructuralSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_structural_make_series(vals : Array[Double], name : String) -> BioseqalignstructuralSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqalignstructuralSeries::len(self : BioseqalignstructuralSeries) -> Int { self.vals.length() }

pub fn BioseqalignstructuralSeries::sum(self : BioseqalignstructuralSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqalignstructuralSeries::mean(self : BioseqalignstructuralSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqalignstructuralSeries::min(self : BioseqalignstructuralSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqalignstructuralSeries::max(self : BioseqalignstructuralSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqalignstructuralSeries::range(self : BioseqalignstructuralSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqalignstructuralSeries::variance(self : BioseqalignstructuralSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqalignstructuralSeries::std(self : BioseqalignstructuralSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqalignstructuralSeries::median(self : BioseqalignstructuralSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqalignstructuralSeries::scale(self : BioseqalignstructuralSeries, f : Double) -> BioseqalignstructuralSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqalignstructuralSeries::add(self : BioseqalignstructuralSeries, other : BioseqalignstructuralSeries) -> BioseqalignstructuralSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqalignstructuralSeries::sub(self : BioseqalignstructuralSeries, other : BioseqalignstructuralSeries) -> BioseqalignstructuralSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqalignstructuralSeries::normalize(self : BioseqalignstructuralSeries) -> BioseqalignstructuralSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqalignstructuralSeries::cumsum(self : BioseqalignstructuralSeries) -> BioseqalignstructuralSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqalignstructuralSeries::to_string(self : BioseqalignstructuralSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignstructuralMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_structural_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignstructuralMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_structural_matrix_identity(n : Int) -> BioseqalignstructuralMatrix {
  let m = bio_seq_align_structural_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqalignstructuralMatrix::get(self : BioseqalignstructuralMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqalignstructuralMatrix::transpose(self : BioseqalignstructuralMatrix) -> BioseqalignstructuralMatrix {
  let result = bio_seq_align_structural_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqalignstructuralMatrix::add(self : BioseqalignstructuralMatrix, other : BioseqalignstructuralMatrix) -> BioseqalignstructuralMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_align_structural_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqalignstructuralMatrix::scale(self : BioseqalignstructuralMatrix, s : Double) -> BioseqalignstructuralMatrix {
  let result = bio_seq_align_structural_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqalignstructuralMatrix::multiply(self : BioseqalignstructuralMatrix, other : BioseqalignstructuralMatrix) -> BioseqalignstructuralMatrix {
  if self.cols != other.rows { return bio_seq_align_structural_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_align_structural_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqalignstructuralMatrix::trace(self : BioseqalignstructuralMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqalignstructuralMatrix::det(self : BioseqalignstructuralMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqalignstructuralMatrix::norm(self : BioseqalignstructuralMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqalignstructuralMatrix::to_string(self : BioseqalignstructuralMatrix) -> String {
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

pub(all) struct BioseqalignstructuralVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_structural_make_vector(comps : Array[Double]) -> BioseqalignstructuralVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_structural_vector_zero(dim : Int) -> BioseqalignstructuralVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqalignstructuralVector::add(self : BioseqalignstructuralVector, other : BioseqalignstructuralVector) -> BioseqalignstructuralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignstructuralVector::sub(self : BioseqalignstructuralVector, other : BioseqalignstructuralVector) -> BioseqalignstructuralVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignstructuralVector::scale(self : BioseqalignstructuralVector, s : Double) -> BioseqalignstructuralVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqalignstructuralVector::dot(self : BioseqalignstructuralVector, other : BioseqalignstructuralVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqalignstructuralVector::norm(self : BioseqalignstructuralVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqalignstructuralVector::normalize(self : BioseqalignstructuralVector) -> BioseqalignstructuralVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignstructuralVector::dist(self : BioseqalignstructuralVector, other : BioseqalignstructuralVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqalignstructuralVector::to_string(self : BioseqalignstructuralVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_structural_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_structural_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_structural_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_structural_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_structural_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_structural_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_structural_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_structural_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_structural_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_structural_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_structural_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_structural_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_structural_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_structural_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_structural_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_structural_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_structural_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_structural_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_structural_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_structural_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_structural_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_structural_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_structural_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_structural_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_structural_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_structural_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_structural_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_structural_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_structural_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqalignstructuralFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_frame_make(size : Int) -> BioseqalignstructuralFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_frame_len(s : BioseqalignstructuralFrame) -> Int { s.size }

pub fn bio_seq_align_structural_frame_get(s : BioseqalignstructuralFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_frame_set(s : BioseqalignstructuralFrame, i : Int, v : Double) -> BioseqalignstructuralFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_frame_sum(s : BioseqalignstructuralFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_structural_frame_mean(s : BioseqalignstructuralFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_structural_frame_scale(s : BioseqalignstructuralFrame, f : Double) -> BioseqalignstructuralFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_frame_add(a : BioseqalignstructuralFrame, b : BioseqalignstructuralFrame) -> BioseqalignstructuralFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_structural_frame_copy(s : BioseqalignstructuralFrame) -> BioseqalignstructuralFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_frame_fill(s : BioseqalignstructuralFrame, v : Double) -> BioseqalignstructuralFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_frame_min(s : BioseqalignstructuralFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_structural_frame_max(s : BioseqalignstructuralFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_structural_frame_to_string(s : BioseqalignstructuralFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_table_make(size : Int) -> BioseqalignstructuralTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_table_len(s : BioseqalignstructuralTable) -> Int { s.size }

pub fn bio_seq_align_structural_table_get(s : BioseqalignstructuralTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_table_set(s : BioseqalignstructuralTable, i : Int, v : Double) -> BioseqalignstructuralTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_table_sum(s : BioseqalignstructuralTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_structural_table_mean(s : BioseqalignstructuralTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_structural_table_scale(s : BioseqalignstructuralTable, f : Double) -> BioseqalignstructuralTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_table_add(a : BioseqalignstructuralTable, b : BioseqalignstructuralTable) -> BioseqalignstructuralTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_structural_table_copy(s : BioseqalignstructuralTable) -> BioseqalignstructuralTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_table_fill(s : BioseqalignstructuralTable, v : Double) -> BioseqalignstructuralTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_table_min(s : BioseqalignstructuralTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_structural_table_max(s : BioseqalignstructuralTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_structural_table_to_string(s : BioseqalignstructuralTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_graphn_make(size : Int) -> BioseqalignstructuralGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_graphn_len(s : BioseqalignstructuralGraphN) -> Int { s.size }

pub fn bio_seq_align_structural_graphn_get(s : BioseqalignstructuralGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_graphn_set(s : BioseqalignstructuralGraphN, i : Int, v : Double) -> BioseqalignstructuralGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_graphn_sum(s : BioseqalignstructuralGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_structural_graphn_mean(s : BioseqalignstructuralGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_structural_graphn_scale(s : BioseqalignstructuralGraphN, f : Double) -> BioseqalignstructuralGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_graphn_add(a : BioseqalignstructuralGraphN, b : BioseqalignstructuralGraphN) -> BioseqalignstructuralGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_structural_graphn_copy(s : BioseqalignstructuralGraphN) -> BioseqalignstructuralGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_graphn_fill(s : BioseqalignstructuralGraphN, v : Double) -> BioseqalignstructuralGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_graphn_min(s : BioseqalignstructuralGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_structural_graphn_max(s : BioseqalignstructuralGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_structural_graphn_to_string(s : BioseqalignstructuralGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_node_make(size : Int) -> BioseqalignstructuralNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_node_len(s : BioseqalignstructuralNode) -> Int { s.size }

pub fn bio_seq_align_structural_node_get(s : BioseqalignstructuralNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_node_set(s : BioseqalignstructuralNode, i : Int, v : Double) -> BioseqalignstructuralNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_node_sum(s : BioseqalignstructuralNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_structural_node_mean(s : BioseqalignstructuralNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_structural_node_scale(s : BioseqalignstructuralNode, f : Double) -> BioseqalignstructuralNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_node_add(a : BioseqalignstructuralNode, b : BioseqalignstructuralNode) -> BioseqalignstructuralNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_structural_node_copy(s : BioseqalignstructuralNode) -> BioseqalignstructuralNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_node_fill(s : BioseqalignstructuralNode, v : Double) -> BioseqalignstructuralNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_node_min(s : BioseqalignstructuralNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_structural_node_max(s : BioseqalignstructuralNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_structural_node_to_string(s : BioseqalignstructuralNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_edge_make(size : Int) -> BioseqalignstructuralEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_edge_len(s : BioseqalignstructuralEdge) -> Int { s.size }

pub fn bio_seq_align_structural_edge_get(s : BioseqalignstructuralEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_edge_set(s : BioseqalignstructuralEdge, i : Int, v : Double) -> BioseqalignstructuralEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_edge_sum(s : BioseqalignstructuralEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_structural_edge_mean(s : BioseqalignstructuralEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_structural_edge_scale(s : BioseqalignstructuralEdge, f : Double) -> BioseqalignstructuralEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_edge_add(a : BioseqalignstructuralEdge, b : BioseqalignstructuralEdge) -> BioseqalignstructuralEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_structural_edge_copy(s : BioseqalignstructuralEdge) -> BioseqalignstructuralEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_edge_fill(s : BioseqalignstructuralEdge, v : Double) -> BioseqalignstructuralEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_edge_min(s : BioseqalignstructuralEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_structural_edge_max(s : BioseqalignstructuralEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_structural_edge_to_string(s : BioseqalignstructuralEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_path_make(size : Int) -> BioseqalignstructuralPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_path_len(s : BioseqalignstructuralPath) -> Int { s.size }

pub fn bio_seq_align_structural_path_get(s : BioseqalignstructuralPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_path_set(s : BioseqalignstructuralPath, i : Int, v : Double) -> BioseqalignstructuralPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_path_sum(s : BioseqalignstructuralPath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_structural_path_mean(s : BioseqalignstructuralPath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_structural_path_scale(s : BioseqalignstructuralPath, f : Double) -> BioseqalignstructuralPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_path_add(a : BioseqalignstructuralPath, b : BioseqalignstructuralPath) -> BioseqalignstructuralPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_structural_path_copy(s : BioseqalignstructuralPath) -> BioseqalignstructuralPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_path_fill(s : BioseqalignstructuralPath, v : Double) -> BioseqalignstructuralPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_path_min(s : BioseqalignstructuralPath) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_structural_path_max(s : BioseqalignstructuralPath) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_structural_path_to_string(s : BioseqalignstructuralPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_cluster_make(size : Int) -> BioseqalignstructuralCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_cluster_len(s : BioseqalignstructuralCluster) -> Int { s.size }

pub fn bio_seq_align_structural_cluster_get(s : BioseqalignstructuralCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_cluster_set(s : BioseqalignstructuralCluster, i : Int, v : Double) -> BioseqalignstructuralCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_cluster_sum(s : BioseqalignstructuralCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_structural_cluster_mean(s : BioseqalignstructuralCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_structural_cluster_scale(s : BioseqalignstructuralCluster, f : Double) -> BioseqalignstructuralCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_cluster_add(a : BioseqalignstructuralCluster, b : BioseqalignstructuralCluster) -> BioseqalignstructuralCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_structural_cluster_copy(s : BioseqalignstructuralCluster) -> BioseqalignstructuralCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_cluster_fill(s : BioseqalignstructuralCluster, v : Double) -> BioseqalignstructuralCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_cluster_min(s : BioseqalignstructuralCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_structural_cluster_max(s : BioseqalignstructuralCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_structural_cluster_to_string(s : BioseqalignstructuralCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_model_make(size : Int) -> BioseqalignstructuralModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_model_len(s : BioseqalignstructuralModel) -> Int { s.size }

pub fn bio_seq_align_structural_model_get(s : BioseqalignstructuralModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_model_set(s : BioseqalignstructuralModel, i : Int, v : Double) -> BioseqalignstructuralModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_model_sum(s : BioseqalignstructuralModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_structural_model_mean(s : BioseqalignstructuralModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_structural_model_scale(s : BioseqalignstructuralModel, f : Double) -> BioseqalignstructuralModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_model_add(a : BioseqalignstructuralModel, b : BioseqalignstructuralModel) -> BioseqalignstructuralModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_structural_model_copy(s : BioseqalignstructuralModel) -> BioseqalignstructuralModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_model_fill(s : BioseqalignstructuralModel, v : Double) -> BioseqalignstructuralModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_model_min(s : BioseqalignstructuralModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_structural_model_max(s : BioseqalignstructuralModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_structural_model_to_string(s : BioseqalignstructuralModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_layer_make(size : Int) -> BioseqalignstructuralLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_layer_len(s : BioseqalignstructuralLayer) -> Int { s.size }

pub fn bio_seq_align_structural_layer_get(s : BioseqalignstructuralLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_layer_set(s : BioseqalignstructuralLayer, i : Int, v : Double) -> BioseqalignstructuralLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_layer_sum(s : BioseqalignstructuralLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_structural_layer_mean(s : BioseqalignstructuralLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_structural_layer_scale(s : BioseqalignstructuralLayer, f : Double) -> BioseqalignstructuralLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_layer_add(a : BioseqalignstructuralLayer, b : BioseqalignstructuralLayer) -> BioseqalignstructuralLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_structural_layer_copy(s : BioseqalignstructuralLayer) -> BioseqalignstructuralLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_layer_fill(s : BioseqalignstructuralLayer, v : Double) -> BioseqalignstructuralLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_layer_min(s : BioseqalignstructuralLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_structural_layer_max(s : BioseqalignstructuralLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_structural_layer_to_string(s : BioseqalignstructuralLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_buffer_make(size : Int) -> BioseqalignstructuralBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_buffer_len(s : BioseqalignstructuralBuffer) -> Int { s.size }

pub fn bio_seq_align_structural_buffer_get(s : BioseqalignstructuralBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_buffer_set(s : BioseqalignstructuralBuffer, i : Int, v : Double) -> BioseqalignstructuralBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_buffer_sum(s : BioseqalignstructuralBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_structural_buffer_mean(s : BioseqalignstructuralBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_structural_buffer_scale(s : BioseqalignstructuralBuffer, f : Double) -> BioseqalignstructuralBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_buffer_add(a : BioseqalignstructuralBuffer, b : BioseqalignstructuralBuffer) -> BioseqalignstructuralBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_structural_buffer_copy(s : BioseqalignstructuralBuffer) -> BioseqalignstructuralBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_buffer_fill(s : BioseqalignstructuralBuffer, v : Double) -> BioseqalignstructuralBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_buffer_min(s : BioseqalignstructuralBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_structural_buffer_max(s : BioseqalignstructuralBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_structural_buffer_to_string(s : BioseqalignstructuralBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_cursor_make(size : Int) -> BioseqalignstructuralCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_cursor_len(s : BioseqalignstructuralCursor) -> Int { s.size }

pub fn bio_seq_align_structural_cursor_get(s : BioseqalignstructuralCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_cursor_set(s : BioseqalignstructuralCursor, i : Int, v : Double) -> BioseqalignstructuralCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_cursor_sum(s : BioseqalignstructuralCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_structural_cursor_mean(s : BioseqalignstructuralCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_structural_cursor_scale(s : BioseqalignstructuralCursor, f : Double) -> BioseqalignstructuralCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_cursor_add(a : BioseqalignstructuralCursor, b : BioseqalignstructuralCursor) -> BioseqalignstructuralCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_structural_cursor_copy(s : BioseqalignstructuralCursor) -> BioseqalignstructuralCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_cursor_fill(s : BioseqalignstructuralCursor, v : Double) -> BioseqalignstructuralCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_cursor_min(s : BioseqalignstructuralCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_structural_cursor_max(s : BioseqalignstructuralCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_structural_cursor_to_string(s : BioseqalignstructuralCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_view_make(size : Int) -> BioseqalignstructuralView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_view_len(s : BioseqalignstructuralView) -> Int { s.size }

pub fn bio_seq_align_structural_view_get(s : BioseqalignstructuralView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_view_set(s : BioseqalignstructuralView, i : Int, v : Double) -> BioseqalignstructuralView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_view_sum(s : BioseqalignstructuralView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_structural_view_mean(s : BioseqalignstructuralView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_structural_view_scale(s : BioseqalignstructuralView, f : Double) -> BioseqalignstructuralView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_view_add(a : BioseqalignstructuralView, b : BioseqalignstructuralView) -> BioseqalignstructuralView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_structural_view_copy(s : BioseqalignstructuralView) -> BioseqalignstructuralView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_view_fill(s : BioseqalignstructuralView, v : Double) -> BioseqalignstructuralView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_view_min(s : BioseqalignstructuralView) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_structural_view_max(s : BioseqalignstructuralView) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_structural_view_to_string(s : BioseqalignstructuralView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_range_make(size : Int) -> BioseqalignstructuralRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_range_len(s : BioseqalignstructuralRange) -> Int { s.size }

pub fn bio_seq_align_structural_range_get(s : BioseqalignstructuralRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_range_set(s : BioseqalignstructuralRange, i : Int, v : Double) -> BioseqalignstructuralRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_range_sum(s : BioseqalignstructuralRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_structural_range_mean(s : BioseqalignstructuralRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_structural_range_scale(s : BioseqalignstructuralRange, f : Double) -> BioseqalignstructuralRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_range_add(a : BioseqalignstructuralRange, b : BioseqalignstructuralRange) -> BioseqalignstructuralRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_structural_range_copy(s : BioseqalignstructuralRange) -> BioseqalignstructuralRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_range_fill(s : BioseqalignstructuralRange, v : Double) -> BioseqalignstructuralRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_range_min(s : BioseqalignstructuralRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_structural_range_max(s : BioseqalignstructuralRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_structural_range_to_string(s : BioseqalignstructuralRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignstructuralSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_structural_slice_make(size : Int) -> BioseqalignstructuralSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_structural_slice_len(s : BioseqalignstructuralSlice) -> Int { s.size }

pub fn bio_seq_align_structural_slice_get(s : BioseqalignstructuralSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_structural_slice_set(s : BioseqalignstructuralSlice, i : Int, v : Double) -> BioseqalignstructuralSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_slice_sum(s : BioseqalignstructuralSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_structural_slice_mean(s : BioseqalignstructuralSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_structural_slice_scale(s : BioseqalignstructuralSlice, f : Double) -> BioseqalignstructuralSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_slice_add(a : BioseqalignstructuralSlice, b : BioseqalignstructuralSlice) -> BioseqalignstructuralSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_structural_slice_copy(s : BioseqalignstructuralSlice) -> BioseqalignstructuralSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_slice_fill(s : BioseqalignstructuralSlice, v : Double) -> BioseqalignstructuralSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_structural_slice_min(s : BioseqalignstructuralSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_structural_slice_max(s : BioseqalignstructuralSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_structural_slice_to_string(s : BioseqalignstructuralSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

