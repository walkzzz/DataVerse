///===
/// extcore/bio_seq_assembly_overlap

pub(all) struct BioseqassemblyoverlapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_overlap_make_point(x : Double, y : Double) -> BioseqassemblyoverlapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_overlap_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblyoverlapPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblyoverlapPoint::x(self : BioseqassemblyoverlapPoint) -> Double { self.x }

pub fn BioseqassemblyoverlapPoint::y(self : BioseqassemblyoverlapPoint) -> Double { self.y }

pub fn BioseqassemblyoverlapPoint::z(self : BioseqassemblyoverlapPoint) -> Double { self.z }

pub fn BioseqassemblyoverlapPoint::label(self : BioseqassemblyoverlapPoint) -> Int { self.label }

pub fn BioseqassemblyoverlapPoint::dist(self : BioseqassemblyoverlapPoint, other : BioseqassemblyoverlapPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblyoverlapPoint::add(self : BioseqassemblyoverlapPoint, other : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblyoverlapPoint::sub(self : BioseqassemblyoverlapPoint, other : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblyoverlapPoint::scale(self : BioseqassemblyoverlapPoint, s : Double) -> BioseqassemblyoverlapPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblyoverlapPoint::dot(self : BioseqassemblyoverlapPoint, other : BioseqassemblyoverlapPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblyoverlapPoint::cross(self : BioseqassemblyoverlapPoint, other : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblyoverlapPoint::norm(self : BioseqassemblyoverlapPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblyoverlapPoint::normalize(self : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblyoverlapPoint::negate(self : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblyoverlapPoint::mid(self : BioseqassemblyoverlapPoint, other : BioseqassemblyoverlapPoint) -> BioseqassemblyoverlapPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblyoverlapPoint::lerp(self : BioseqassemblyoverlapPoint, other : BioseqassemblyoverlapPoint, t : Double) -> BioseqassemblyoverlapPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblyoverlapPoint::to_string(self : BioseqassemblyoverlapPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_overlap_make_series(vals : Array[Double], name : String) -> BioseqassemblyoverlapSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblyoverlapSeries::len(self : BioseqassemblyoverlapSeries) -> Int { self.vals.length() }

pub fn BioseqassemblyoverlapSeries::sum(self : BioseqassemblyoverlapSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblyoverlapSeries::mean(self : BioseqassemblyoverlapSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblyoverlapSeries::min(self : BioseqassemblyoverlapSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblyoverlapSeries::max(self : BioseqassemblyoverlapSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblyoverlapSeries::range(self : BioseqassemblyoverlapSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblyoverlapSeries::variance(self : BioseqassemblyoverlapSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblyoverlapSeries::std(self : BioseqassemblyoverlapSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblyoverlapSeries::median(self : BioseqassemblyoverlapSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblyoverlapSeries::scale(self : BioseqassemblyoverlapSeries, f : Double) -> BioseqassemblyoverlapSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblyoverlapSeries::add(self : BioseqassemblyoverlapSeries, other : BioseqassemblyoverlapSeries) -> BioseqassemblyoverlapSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblyoverlapSeries::sub(self : BioseqassemblyoverlapSeries, other : BioseqassemblyoverlapSeries) -> BioseqassemblyoverlapSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblyoverlapSeries::normalize(self : BioseqassemblyoverlapSeries) -> BioseqassemblyoverlapSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblyoverlapSeries::cumsum(self : BioseqassemblyoverlapSeries) -> BioseqassemblyoverlapSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblyoverlapSeries::to_string(self : BioseqassemblyoverlapSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblyoverlapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_overlap_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblyoverlapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_overlap_matrix_identity(n : Int) -> BioseqassemblyoverlapMatrix {
  let m = bio_seq_assembly_overlap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblyoverlapMatrix::get(self : BioseqassemblyoverlapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblyoverlapMatrix::transpose(self : BioseqassemblyoverlapMatrix) -> BioseqassemblyoverlapMatrix {
  let result = bio_seq_assembly_overlap_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblyoverlapMatrix::add(self : BioseqassemblyoverlapMatrix, other : BioseqassemblyoverlapMatrix) -> BioseqassemblyoverlapMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_overlap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblyoverlapMatrix::scale(self : BioseqassemblyoverlapMatrix, s : Double) -> BioseqassemblyoverlapMatrix {
  let result = bio_seq_assembly_overlap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblyoverlapMatrix::multiply(self : BioseqassemblyoverlapMatrix, other : BioseqassemblyoverlapMatrix) -> BioseqassemblyoverlapMatrix {
  if self.cols != other.rows { return bio_seq_assembly_overlap_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_overlap_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqassemblyoverlapMatrix::trace(self : BioseqassemblyoverlapMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblyoverlapMatrix::det(self : BioseqassemblyoverlapMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblyoverlapMatrix::norm(self : BioseqassemblyoverlapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblyoverlapMatrix::to_string(self : BioseqassemblyoverlapMatrix) -> String {
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

pub(all) struct BioseqassemblyoverlapVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_overlap_make_vector(comps : Array[Double]) -> BioseqassemblyoverlapVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_overlap_vector_zero(dim : Int) -> BioseqassemblyoverlapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblyoverlapVector::add(self : BioseqassemblyoverlapVector, other : BioseqassemblyoverlapVector) -> BioseqassemblyoverlapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblyoverlapVector::sub(self : BioseqassemblyoverlapVector, other : BioseqassemblyoverlapVector) -> BioseqassemblyoverlapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblyoverlapVector::scale(self : BioseqassemblyoverlapVector, s : Double) -> BioseqassemblyoverlapVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblyoverlapVector::dot(self : BioseqassemblyoverlapVector, other : BioseqassemblyoverlapVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblyoverlapVector::norm(self : BioseqassemblyoverlapVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblyoverlapVector::normalize(self : BioseqassemblyoverlapVector) -> BioseqassemblyoverlapVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblyoverlapVector::dist(self : BioseqassemblyoverlapVector, other : BioseqassemblyoverlapVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblyoverlapVector::to_string(self : BioseqassemblyoverlapVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_overlap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_assembly_overlap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_assembly_overlap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_assembly_overlap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_assembly_overlap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_assembly_overlap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_assembly_overlap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_assembly_overlap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_assembly_overlap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_assembly_overlap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_assembly_overlap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_assembly_overlap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_assembly_overlap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_assembly_overlap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_assembly_overlap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_assembly_overlap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_assembly_overlap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_assembly_overlap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_assembly_overlap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_assembly_overlap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_assembly_overlap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_assembly_overlap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_assembly_overlap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_assembly_overlap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_assembly_overlap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_assembly_overlap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_assembly_overlap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_assembly_overlap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_assembly_overlap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqassemblyoverlapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_frame_make(size : Int) -> BioseqassemblyoverlapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_frame_len(s : BioseqassemblyoverlapFrame) -> Int { s.size }

pub fn bio_seq_assembly_overlap_frame_get(s : BioseqassemblyoverlapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_frame_set(s : BioseqassemblyoverlapFrame, i : Int, v : Double) -> BioseqassemblyoverlapFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_frame_sum(s : BioseqassemblyoverlapFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_overlap_frame_mean(s : BioseqassemblyoverlapFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_overlap_frame_scale(s : BioseqassemblyoverlapFrame, f : Double) -> BioseqassemblyoverlapFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_frame_add(a : BioseqassemblyoverlapFrame, b : BioseqassemblyoverlapFrame) -> BioseqassemblyoverlapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_overlap_frame_copy(s : BioseqassemblyoverlapFrame) -> BioseqassemblyoverlapFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_frame_fill(s : BioseqassemblyoverlapFrame, v : Double) -> BioseqassemblyoverlapFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_frame_min(s : BioseqassemblyoverlapFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_overlap_frame_max(s : BioseqassemblyoverlapFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_overlap_frame_to_string(s : BioseqassemblyoverlapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_table_make(size : Int) -> BioseqassemblyoverlapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_table_len(s : BioseqassemblyoverlapTable) -> Int { s.size }

pub fn bio_seq_assembly_overlap_table_get(s : BioseqassemblyoverlapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_table_set(s : BioseqassemblyoverlapTable, i : Int, v : Double) -> BioseqassemblyoverlapTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_table_sum(s : BioseqassemblyoverlapTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_overlap_table_mean(s : BioseqassemblyoverlapTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_overlap_table_scale(s : BioseqassemblyoverlapTable, f : Double) -> BioseqassemblyoverlapTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_table_add(a : BioseqassemblyoverlapTable, b : BioseqassemblyoverlapTable) -> BioseqassemblyoverlapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_overlap_table_copy(s : BioseqassemblyoverlapTable) -> BioseqassemblyoverlapTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_table_fill(s : BioseqassemblyoverlapTable, v : Double) -> BioseqassemblyoverlapTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_table_min(s : BioseqassemblyoverlapTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_overlap_table_max(s : BioseqassemblyoverlapTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_overlap_table_to_string(s : BioseqassemblyoverlapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_graphn_make(size : Int) -> BioseqassemblyoverlapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_graphn_len(s : BioseqassemblyoverlapGraphN) -> Int { s.size }

pub fn bio_seq_assembly_overlap_graphn_get(s : BioseqassemblyoverlapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_graphn_set(s : BioseqassemblyoverlapGraphN, i : Int, v : Double) -> BioseqassemblyoverlapGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_graphn_sum(s : BioseqassemblyoverlapGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_overlap_graphn_mean(s : BioseqassemblyoverlapGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_overlap_graphn_scale(s : BioseqassemblyoverlapGraphN, f : Double) -> BioseqassemblyoverlapGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_graphn_add(a : BioseqassemblyoverlapGraphN, b : BioseqassemblyoverlapGraphN) -> BioseqassemblyoverlapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_overlap_graphn_copy(s : BioseqassemblyoverlapGraphN) -> BioseqassemblyoverlapGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_graphn_fill(s : BioseqassemblyoverlapGraphN, v : Double) -> BioseqassemblyoverlapGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_graphn_min(s : BioseqassemblyoverlapGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_overlap_graphn_max(s : BioseqassemblyoverlapGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_overlap_graphn_to_string(s : BioseqassemblyoverlapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_node_make(size : Int) -> BioseqassemblyoverlapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_node_len(s : BioseqassemblyoverlapNode) -> Int { s.size }

pub fn bio_seq_assembly_overlap_node_get(s : BioseqassemblyoverlapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_node_set(s : BioseqassemblyoverlapNode, i : Int, v : Double) -> BioseqassemblyoverlapNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_node_sum(s : BioseqassemblyoverlapNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_overlap_node_mean(s : BioseqassemblyoverlapNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_overlap_node_scale(s : BioseqassemblyoverlapNode, f : Double) -> BioseqassemblyoverlapNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_node_add(a : BioseqassemblyoverlapNode, b : BioseqassemblyoverlapNode) -> BioseqassemblyoverlapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_overlap_node_copy(s : BioseqassemblyoverlapNode) -> BioseqassemblyoverlapNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_node_fill(s : BioseqassemblyoverlapNode, v : Double) -> BioseqassemblyoverlapNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_node_min(s : BioseqassemblyoverlapNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_overlap_node_max(s : BioseqassemblyoverlapNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_overlap_node_to_string(s : BioseqassemblyoverlapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_edge_make(size : Int) -> BioseqassemblyoverlapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_edge_len(s : BioseqassemblyoverlapEdge) -> Int { s.size }

pub fn bio_seq_assembly_overlap_edge_get(s : BioseqassemblyoverlapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_edge_set(s : BioseqassemblyoverlapEdge, i : Int, v : Double) -> BioseqassemblyoverlapEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_edge_sum(s : BioseqassemblyoverlapEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_overlap_edge_mean(s : BioseqassemblyoverlapEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_overlap_edge_scale(s : BioseqassemblyoverlapEdge, f : Double) -> BioseqassemblyoverlapEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_edge_add(a : BioseqassemblyoverlapEdge, b : BioseqassemblyoverlapEdge) -> BioseqassemblyoverlapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_overlap_edge_copy(s : BioseqassemblyoverlapEdge) -> BioseqassemblyoverlapEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_edge_fill(s : BioseqassemblyoverlapEdge, v : Double) -> BioseqassemblyoverlapEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_edge_min(s : BioseqassemblyoverlapEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_overlap_edge_max(s : BioseqassemblyoverlapEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_overlap_edge_to_string(s : BioseqassemblyoverlapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_path_make(size : Int) -> BioseqassemblyoverlapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_path_len(s : BioseqassemblyoverlapPath) -> Int { s.size }

pub fn bio_seq_assembly_overlap_path_get(s : BioseqassemblyoverlapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_path_set(s : BioseqassemblyoverlapPath, i : Int, v : Double) -> BioseqassemblyoverlapPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_path_sum(s : BioseqassemblyoverlapPath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_overlap_path_mean(s : BioseqassemblyoverlapPath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_overlap_path_scale(s : BioseqassemblyoverlapPath, f : Double) -> BioseqassemblyoverlapPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_path_add(a : BioseqassemblyoverlapPath, b : BioseqassemblyoverlapPath) -> BioseqassemblyoverlapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_overlap_path_copy(s : BioseqassemblyoverlapPath) -> BioseqassemblyoverlapPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_path_fill(s : BioseqassemblyoverlapPath, v : Double) -> BioseqassemblyoverlapPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_path_min(s : BioseqassemblyoverlapPath) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_overlap_path_max(s : BioseqassemblyoverlapPath) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_overlap_path_to_string(s : BioseqassemblyoverlapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_cluster_make(size : Int) -> BioseqassemblyoverlapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_cluster_len(s : BioseqassemblyoverlapCluster) -> Int { s.size }

pub fn bio_seq_assembly_overlap_cluster_get(s : BioseqassemblyoverlapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_cluster_set(s : BioseqassemblyoverlapCluster, i : Int, v : Double) -> BioseqassemblyoverlapCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_cluster_sum(s : BioseqassemblyoverlapCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_overlap_cluster_mean(s : BioseqassemblyoverlapCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_overlap_cluster_scale(s : BioseqassemblyoverlapCluster, f : Double) -> BioseqassemblyoverlapCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_cluster_add(a : BioseqassemblyoverlapCluster, b : BioseqassemblyoverlapCluster) -> BioseqassemblyoverlapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_overlap_cluster_copy(s : BioseqassemblyoverlapCluster) -> BioseqassemblyoverlapCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_cluster_fill(s : BioseqassemblyoverlapCluster, v : Double) -> BioseqassemblyoverlapCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_cluster_min(s : BioseqassemblyoverlapCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_overlap_cluster_max(s : BioseqassemblyoverlapCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_overlap_cluster_to_string(s : BioseqassemblyoverlapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_model_make(size : Int) -> BioseqassemblyoverlapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_model_len(s : BioseqassemblyoverlapModel) -> Int { s.size }

pub fn bio_seq_assembly_overlap_model_get(s : BioseqassemblyoverlapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_model_set(s : BioseqassemblyoverlapModel, i : Int, v : Double) -> BioseqassemblyoverlapModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_model_sum(s : BioseqassemblyoverlapModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_overlap_model_mean(s : BioseqassemblyoverlapModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_overlap_model_scale(s : BioseqassemblyoverlapModel, f : Double) -> BioseqassemblyoverlapModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_model_add(a : BioseqassemblyoverlapModel, b : BioseqassemblyoverlapModel) -> BioseqassemblyoverlapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_overlap_model_copy(s : BioseqassemblyoverlapModel) -> BioseqassemblyoverlapModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_model_fill(s : BioseqassemblyoverlapModel, v : Double) -> BioseqassemblyoverlapModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_model_min(s : BioseqassemblyoverlapModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_overlap_model_max(s : BioseqassemblyoverlapModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_overlap_model_to_string(s : BioseqassemblyoverlapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_layer_make(size : Int) -> BioseqassemblyoverlapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_layer_len(s : BioseqassemblyoverlapLayer) -> Int { s.size }

pub fn bio_seq_assembly_overlap_layer_get(s : BioseqassemblyoverlapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_layer_set(s : BioseqassemblyoverlapLayer, i : Int, v : Double) -> BioseqassemblyoverlapLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_layer_sum(s : BioseqassemblyoverlapLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_overlap_layer_mean(s : BioseqassemblyoverlapLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_overlap_layer_scale(s : BioseqassemblyoverlapLayer, f : Double) -> BioseqassemblyoverlapLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_layer_add(a : BioseqassemblyoverlapLayer, b : BioseqassemblyoverlapLayer) -> BioseqassemblyoverlapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_overlap_layer_copy(s : BioseqassemblyoverlapLayer) -> BioseqassemblyoverlapLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_layer_fill(s : BioseqassemblyoverlapLayer, v : Double) -> BioseqassemblyoverlapLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_layer_min(s : BioseqassemblyoverlapLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_overlap_layer_max(s : BioseqassemblyoverlapLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_overlap_layer_to_string(s : BioseqassemblyoverlapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_buffer_make(size : Int) -> BioseqassemblyoverlapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_buffer_len(s : BioseqassemblyoverlapBuffer) -> Int { s.size }

pub fn bio_seq_assembly_overlap_buffer_get(s : BioseqassemblyoverlapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_buffer_set(s : BioseqassemblyoverlapBuffer, i : Int, v : Double) -> BioseqassemblyoverlapBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_buffer_sum(s : BioseqassemblyoverlapBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_overlap_buffer_mean(s : BioseqassemblyoverlapBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_overlap_buffer_scale(s : BioseqassemblyoverlapBuffer, f : Double) -> BioseqassemblyoverlapBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_buffer_add(a : BioseqassemblyoverlapBuffer, b : BioseqassemblyoverlapBuffer) -> BioseqassemblyoverlapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_overlap_buffer_copy(s : BioseqassemblyoverlapBuffer) -> BioseqassemblyoverlapBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_buffer_fill(s : BioseqassemblyoverlapBuffer, v : Double) -> BioseqassemblyoverlapBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_buffer_min(s : BioseqassemblyoverlapBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_overlap_buffer_max(s : BioseqassemblyoverlapBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_overlap_buffer_to_string(s : BioseqassemblyoverlapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_cursor_make(size : Int) -> BioseqassemblyoverlapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_cursor_len(s : BioseqassemblyoverlapCursor) -> Int { s.size }

pub fn bio_seq_assembly_overlap_cursor_get(s : BioseqassemblyoverlapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_cursor_set(s : BioseqassemblyoverlapCursor, i : Int, v : Double) -> BioseqassemblyoverlapCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_cursor_sum(s : BioseqassemblyoverlapCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_overlap_cursor_mean(s : BioseqassemblyoverlapCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_overlap_cursor_scale(s : BioseqassemblyoverlapCursor, f : Double) -> BioseqassemblyoverlapCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_cursor_add(a : BioseqassemblyoverlapCursor, b : BioseqassemblyoverlapCursor) -> BioseqassemblyoverlapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_overlap_cursor_copy(s : BioseqassemblyoverlapCursor) -> BioseqassemblyoverlapCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_cursor_fill(s : BioseqassemblyoverlapCursor, v : Double) -> BioseqassemblyoverlapCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_cursor_min(s : BioseqassemblyoverlapCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_overlap_cursor_max(s : BioseqassemblyoverlapCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_overlap_cursor_to_string(s : BioseqassemblyoverlapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_view_make(size : Int) -> BioseqassemblyoverlapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_view_len(s : BioseqassemblyoverlapView) -> Int { s.size }

pub fn bio_seq_assembly_overlap_view_get(s : BioseqassemblyoverlapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_view_set(s : BioseqassemblyoverlapView, i : Int, v : Double) -> BioseqassemblyoverlapView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_view_sum(s : BioseqassemblyoverlapView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_overlap_view_mean(s : BioseqassemblyoverlapView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_overlap_view_scale(s : BioseqassemblyoverlapView, f : Double) -> BioseqassemblyoverlapView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_view_add(a : BioseqassemblyoverlapView, b : BioseqassemblyoverlapView) -> BioseqassemblyoverlapView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_overlap_view_copy(s : BioseqassemblyoverlapView) -> BioseqassemblyoverlapView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_view_fill(s : BioseqassemblyoverlapView, v : Double) -> BioseqassemblyoverlapView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_view_min(s : BioseqassemblyoverlapView) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_overlap_view_max(s : BioseqassemblyoverlapView) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_overlap_view_to_string(s : BioseqassemblyoverlapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_range_make(size : Int) -> BioseqassemblyoverlapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_range_len(s : BioseqassemblyoverlapRange) -> Int { s.size }

pub fn bio_seq_assembly_overlap_range_get(s : BioseqassemblyoverlapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_range_set(s : BioseqassemblyoverlapRange, i : Int, v : Double) -> BioseqassemblyoverlapRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_range_sum(s : BioseqassemblyoverlapRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_overlap_range_mean(s : BioseqassemblyoverlapRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_overlap_range_scale(s : BioseqassemblyoverlapRange, f : Double) -> BioseqassemblyoverlapRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_range_add(a : BioseqassemblyoverlapRange, b : BioseqassemblyoverlapRange) -> BioseqassemblyoverlapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_overlap_range_copy(s : BioseqassemblyoverlapRange) -> BioseqassemblyoverlapRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_range_fill(s : BioseqassemblyoverlapRange, v : Double) -> BioseqassemblyoverlapRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_range_min(s : BioseqassemblyoverlapRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_overlap_range_max(s : BioseqassemblyoverlapRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_overlap_range_to_string(s : BioseqassemblyoverlapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyoverlapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_overlap_slice_make(size : Int) -> BioseqassemblyoverlapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_overlap_slice_len(s : BioseqassemblyoverlapSlice) -> Int { s.size }

pub fn bio_seq_assembly_overlap_slice_get(s : BioseqassemblyoverlapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_overlap_slice_set(s : BioseqassemblyoverlapSlice, i : Int, v : Double) -> BioseqassemblyoverlapSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_slice_sum(s : BioseqassemblyoverlapSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_overlap_slice_mean(s : BioseqassemblyoverlapSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_overlap_slice_scale(s : BioseqassemblyoverlapSlice, f : Double) -> BioseqassemblyoverlapSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_slice_add(a : BioseqassemblyoverlapSlice, b : BioseqassemblyoverlapSlice) -> BioseqassemblyoverlapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_overlap_slice_copy(s : BioseqassemblyoverlapSlice) -> BioseqassemblyoverlapSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_slice_fill(s : BioseqassemblyoverlapSlice, v : Double) -> BioseqassemblyoverlapSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_overlap_slice_min(s : BioseqassemblyoverlapSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_overlap_slice_max(s : BioseqassemblyoverlapSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_overlap_slice_to_string(s : BioseqassemblyoverlapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

