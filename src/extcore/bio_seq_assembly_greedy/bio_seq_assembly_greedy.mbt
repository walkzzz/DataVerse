///===
/// extcore/bio_seq_assembly_greedy

pub(all) struct BioseqassemblygreedyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_greedy_make_point(x : Double, y : Double) -> BioseqassemblygreedyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_greedy_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblygreedyPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblygreedyPoint::x(self : BioseqassemblygreedyPoint) -> Double { self.x }

pub fn BioseqassemblygreedyPoint::y(self : BioseqassemblygreedyPoint) -> Double { self.y }

pub fn BioseqassemblygreedyPoint::z(self : BioseqassemblygreedyPoint) -> Double { self.z }

pub fn BioseqassemblygreedyPoint::label(self : BioseqassemblygreedyPoint) -> Int { self.label }

pub fn BioseqassemblygreedyPoint::dist(self : BioseqassemblygreedyPoint, other : BioseqassemblygreedyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblygreedyPoint::add(self : BioseqassemblygreedyPoint, other : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblygreedyPoint::sub(self : BioseqassemblygreedyPoint, other : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblygreedyPoint::scale(self : BioseqassemblygreedyPoint, s : Double) -> BioseqassemblygreedyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblygreedyPoint::dot(self : BioseqassemblygreedyPoint, other : BioseqassemblygreedyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblygreedyPoint::cross(self : BioseqassemblygreedyPoint, other : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblygreedyPoint::norm(self : BioseqassemblygreedyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblygreedyPoint::normalize(self : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblygreedyPoint::negate(self : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblygreedyPoint::mid(self : BioseqassemblygreedyPoint, other : BioseqassemblygreedyPoint) -> BioseqassemblygreedyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblygreedyPoint::lerp(self : BioseqassemblygreedyPoint, other : BioseqassemblygreedyPoint, t : Double) -> BioseqassemblygreedyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblygreedyPoint::to_string(self : BioseqassemblygreedyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblygreedySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_greedy_make_series(vals : Array[Double], name : String) -> BioseqassemblygreedySeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblygreedySeries::len(self : BioseqassemblygreedySeries) -> Int { self.vals.length() }

pub fn BioseqassemblygreedySeries::sum(self : BioseqassemblygreedySeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblygreedySeries::mean(self : BioseqassemblygreedySeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblygreedySeries::min(self : BioseqassemblygreedySeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblygreedySeries::max(self : BioseqassemblygreedySeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblygreedySeries::range(self : BioseqassemblygreedySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblygreedySeries::variance(self : BioseqassemblygreedySeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblygreedySeries::std(self : BioseqassemblygreedySeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblygreedySeries::median(self : BioseqassemblygreedySeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblygreedySeries::scale(self : BioseqassemblygreedySeries, f : Double) -> BioseqassemblygreedySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblygreedySeries::add(self : BioseqassemblygreedySeries, other : BioseqassemblygreedySeries) -> BioseqassemblygreedySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblygreedySeries::sub(self : BioseqassemblygreedySeries, other : BioseqassemblygreedySeries) -> BioseqassemblygreedySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblygreedySeries::normalize(self : BioseqassemblygreedySeries) -> BioseqassemblygreedySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblygreedySeries::cumsum(self : BioseqassemblygreedySeries) -> BioseqassemblygreedySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblygreedySeries::to_string(self : BioseqassemblygreedySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblygreedyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_greedy_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblygreedyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_greedy_matrix_identity(n : Int) -> BioseqassemblygreedyMatrix {
  let m = bio_seq_assembly_greedy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblygreedyMatrix::get(self : BioseqassemblygreedyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblygreedyMatrix::transpose(self : BioseqassemblygreedyMatrix) -> BioseqassemblygreedyMatrix {
  let result = bio_seq_assembly_greedy_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblygreedyMatrix::add(self : BioseqassemblygreedyMatrix, other : BioseqassemblygreedyMatrix) -> BioseqassemblygreedyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_greedy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblygreedyMatrix::scale(self : BioseqassemblygreedyMatrix, s : Double) -> BioseqassemblygreedyMatrix {
  let result = bio_seq_assembly_greedy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblygreedyMatrix::multiply(self : BioseqassemblygreedyMatrix, other : BioseqassemblygreedyMatrix) -> BioseqassemblygreedyMatrix {
  if self.cols != other.rows { return bio_seq_assembly_greedy_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_greedy_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqassemblygreedyMatrix::trace(self : BioseqassemblygreedyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblygreedyMatrix::det(self : BioseqassemblygreedyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblygreedyMatrix::norm(self : BioseqassemblygreedyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblygreedyMatrix::to_string(self : BioseqassemblygreedyMatrix) -> String {
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

pub(all) struct BioseqassemblygreedyVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_greedy_make_vector(comps : Array[Double]) -> BioseqassemblygreedyVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_greedy_vector_zero(dim : Int) -> BioseqassemblygreedyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblygreedyVector::add(self : BioseqassemblygreedyVector, other : BioseqassemblygreedyVector) -> BioseqassemblygreedyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblygreedyVector::sub(self : BioseqassemblygreedyVector, other : BioseqassemblygreedyVector) -> BioseqassemblygreedyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblygreedyVector::scale(self : BioseqassemblygreedyVector, s : Double) -> BioseqassemblygreedyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblygreedyVector::dot(self : BioseqassemblygreedyVector, other : BioseqassemblygreedyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblygreedyVector::norm(self : BioseqassemblygreedyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblygreedyVector::normalize(self : BioseqassemblygreedyVector) -> BioseqassemblygreedyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblygreedyVector::dist(self : BioseqassemblygreedyVector, other : BioseqassemblygreedyVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblygreedyVector::to_string(self : BioseqassemblygreedyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_greedy_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_assembly_greedy_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_assembly_greedy_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_assembly_greedy_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_assembly_greedy_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_assembly_greedy_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_assembly_greedy_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_assembly_greedy_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_assembly_greedy_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_assembly_greedy_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_assembly_greedy_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_assembly_greedy_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_assembly_greedy_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_assembly_greedy_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_assembly_greedy_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_assembly_greedy_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_assembly_greedy_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_assembly_greedy_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_assembly_greedy_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_assembly_greedy_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_assembly_greedy_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_assembly_greedy_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_assembly_greedy_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_assembly_greedy_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_assembly_greedy_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_assembly_greedy_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_assembly_greedy_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_assembly_greedy_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_assembly_greedy_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqassemblygreedyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_frame_make(size : Int) -> BioseqassemblygreedyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_frame_len(s : BioseqassemblygreedyFrame) -> Int { s.size }

pub fn bio_seq_assembly_greedy_frame_get(s : BioseqassemblygreedyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_frame_set(s : BioseqassemblygreedyFrame, i : Int, v : Double) -> BioseqassemblygreedyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_frame_sum(s : BioseqassemblygreedyFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_frame_mean(s : BioseqassemblygreedyFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_frame_scale(s : BioseqassemblygreedyFrame, f : Double) -> BioseqassemblygreedyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_frame_add(a : BioseqassemblygreedyFrame, b : BioseqassemblygreedyFrame) -> BioseqassemblygreedyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_greedy_frame_copy(s : BioseqassemblygreedyFrame) -> BioseqassemblygreedyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_frame_fill(s : BioseqassemblygreedyFrame, v : Double) -> BioseqassemblygreedyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_frame_min(s : BioseqassemblygreedyFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_frame_max(s : BioseqassemblygreedyFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_frame_to_string(s : BioseqassemblygreedyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_table_make(size : Int) -> BioseqassemblygreedyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_table_len(s : BioseqassemblygreedyTable) -> Int { s.size }

pub fn bio_seq_assembly_greedy_table_get(s : BioseqassemblygreedyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_table_set(s : BioseqassemblygreedyTable, i : Int, v : Double) -> BioseqassemblygreedyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_table_sum(s : BioseqassemblygreedyTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_table_mean(s : BioseqassemblygreedyTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_table_scale(s : BioseqassemblygreedyTable, f : Double) -> BioseqassemblygreedyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_table_add(a : BioseqassemblygreedyTable, b : BioseqassemblygreedyTable) -> BioseqassemblygreedyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_greedy_table_copy(s : BioseqassemblygreedyTable) -> BioseqassemblygreedyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_table_fill(s : BioseqassemblygreedyTable, v : Double) -> BioseqassemblygreedyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_table_min(s : BioseqassemblygreedyTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_table_max(s : BioseqassemblygreedyTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_table_to_string(s : BioseqassemblygreedyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_graphn_make(size : Int) -> BioseqassemblygreedyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_graphn_len(s : BioseqassemblygreedyGraphN) -> Int { s.size }

pub fn bio_seq_assembly_greedy_graphn_get(s : BioseqassemblygreedyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_graphn_set(s : BioseqassemblygreedyGraphN, i : Int, v : Double) -> BioseqassemblygreedyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_graphn_sum(s : BioseqassemblygreedyGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_graphn_mean(s : BioseqassemblygreedyGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_graphn_scale(s : BioseqassemblygreedyGraphN, f : Double) -> BioseqassemblygreedyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_graphn_add(a : BioseqassemblygreedyGraphN, b : BioseqassemblygreedyGraphN) -> BioseqassemblygreedyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_greedy_graphn_copy(s : BioseqassemblygreedyGraphN) -> BioseqassemblygreedyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_graphn_fill(s : BioseqassemblygreedyGraphN, v : Double) -> BioseqassemblygreedyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_graphn_min(s : BioseqassemblygreedyGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_graphn_max(s : BioseqassemblygreedyGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_graphn_to_string(s : BioseqassemblygreedyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_node_make(size : Int) -> BioseqassemblygreedyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_node_len(s : BioseqassemblygreedyNode) -> Int { s.size }

pub fn bio_seq_assembly_greedy_node_get(s : BioseqassemblygreedyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_node_set(s : BioseqassemblygreedyNode, i : Int, v : Double) -> BioseqassemblygreedyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_node_sum(s : BioseqassemblygreedyNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_node_mean(s : BioseqassemblygreedyNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_node_scale(s : BioseqassemblygreedyNode, f : Double) -> BioseqassemblygreedyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_node_add(a : BioseqassemblygreedyNode, b : BioseqassemblygreedyNode) -> BioseqassemblygreedyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_greedy_node_copy(s : BioseqassemblygreedyNode) -> BioseqassemblygreedyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_node_fill(s : BioseqassemblygreedyNode, v : Double) -> BioseqassemblygreedyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_node_min(s : BioseqassemblygreedyNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_node_max(s : BioseqassemblygreedyNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_node_to_string(s : BioseqassemblygreedyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_edge_make(size : Int) -> BioseqassemblygreedyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_edge_len(s : BioseqassemblygreedyEdge) -> Int { s.size }

pub fn bio_seq_assembly_greedy_edge_get(s : BioseqassemblygreedyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_edge_set(s : BioseqassemblygreedyEdge, i : Int, v : Double) -> BioseqassemblygreedyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_edge_sum(s : BioseqassemblygreedyEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_edge_mean(s : BioseqassemblygreedyEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_edge_scale(s : BioseqassemblygreedyEdge, f : Double) -> BioseqassemblygreedyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_edge_add(a : BioseqassemblygreedyEdge, b : BioseqassemblygreedyEdge) -> BioseqassemblygreedyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_greedy_edge_copy(s : BioseqassemblygreedyEdge) -> BioseqassemblygreedyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_edge_fill(s : BioseqassemblygreedyEdge, v : Double) -> BioseqassemblygreedyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_edge_min(s : BioseqassemblygreedyEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_edge_max(s : BioseqassemblygreedyEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_edge_to_string(s : BioseqassemblygreedyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_path_make(size : Int) -> BioseqassemblygreedyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_path_len(s : BioseqassemblygreedyPath) -> Int { s.size }

pub fn bio_seq_assembly_greedy_path_get(s : BioseqassemblygreedyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_path_set(s : BioseqassemblygreedyPath, i : Int, v : Double) -> BioseqassemblygreedyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_path_sum(s : BioseqassemblygreedyPath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_path_mean(s : BioseqassemblygreedyPath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_path_scale(s : BioseqassemblygreedyPath, f : Double) -> BioseqassemblygreedyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_path_add(a : BioseqassemblygreedyPath, b : BioseqassemblygreedyPath) -> BioseqassemblygreedyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_greedy_path_copy(s : BioseqassemblygreedyPath) -> BioseqassemblygreedyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_path_fill(s : BioseqassemblygreedyPath, v : Double) -> BioseqassemblygreedyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_path_min(s : BioseqassemblygreedyPath) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_path_max(s : BioseqassemblygreedyPath) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_path_to_string(s : BioseqassemblygreedyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_cluster_make(size : Int) -> BioseqassemblygreedyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_cluster_len(s : BioseqassemblygreedyCluster) -> Int { s.size }

pub fn bio_seq_assembly_greedy_cluster_get(s : BioseqassemblygreedyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_cluster_set(s : BioseqassemblygreedyCluster, i : Int, v : Double) -> BioseqassemblygreedyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_cluster_sum(s : BioseqassemblygreedyCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_cluster_mean(s : BioseqassemblygreedyCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_cluster_scale(s : BioseqassemblygreedyCluster, f : Double) -> BioseqassemblygreedyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_cluster_add(a : BioseqassemblygreedyCluster, b : BioseqassemblygreedyCluster) -> BioseqassemblygreedyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_greedy_cluster_copy(s : BioseqassemblygreedyCluster) -> BioseqassemblygreedyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_cluster_fill(s : BioseqassemblygreedyCluster, v : Double) -> BioseqassemblygreedyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_cluster_min(s : BioseqassemblygreedyCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_cluster_max(s : BioseqassemblygreedyCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_cluster_to_string(s : BioseqassemblygreedyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_model_make(size : Int) -> BioseqassemblygreedyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_model_len(s : BioseqassemblygreedyModel) -> Int { s.size }

pub fn bio_seq_assembly_greedy_model_get(s : BioseqassemblygreedyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_model_set(s : BioseqassemblygreedyModel, i : Int, v : Double) -> BioseqassemblygreedyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_model_sum(s : BioseqassemblygreedyModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_model_mean(s : BioseqassemblygreedyModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_model_scale(s : BioseqassemblygreedyModel, f : Double) -> BioseqassemblygreedyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_model_add(a : BioseqassemblygreedyModel, b : BioseqassemblygreedyModel) -> BioseqassemblygreedyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_greedy_model_copy(s : BioseqassemblygreedyModel) -> BioseqassemblygreedyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_model_fill(s : BioseqassemblygreedyModel, v : Double) -> BioseqassemblygreedyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_model_min(s : BioseqassemblygreedyModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_model_max(s : BioseqassemblygreedyModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_model_to_string(s : BioseqassemblygreedyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_layer_make(size : Int) -> BioseqassemblygreedyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_layer_len(s : BioseqassemblygreedyLayer) -> Int { s.size }

pub fn bio_seq_assembly_greedy_layer_get(s : BioseqassemblygreedyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_layer_set(s : BioseqassemblygreedyLayer, i : Int, v : Double) -> BioseqassemblygreedyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_layer_sum(s : BioseqassemblygreedyLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_layer_mean(s : BioseqassemblygreedyLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_layer_scale(s : BioseqassemblygreedyLayer, f : Double) -> BioseqassemblygreedyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_layer_add(a : BioseqassemblygreedyLayer, b : BioseqassemblygreedyLayer) -> BioseqassemblygreedyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_greedy_layer_copy(s : BioseqassemblygreedyLayer) -> BioseqassemblygreedyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_layer_fill(s : BioseqassemblygreedyLayer, v : Double) -> BioseqassemblygreedyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_layer_min(s : BioseqassemblygreedyLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_layer_max(s : BioseqassemblygreedyLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_layer_to_string(s : BioseqassemblygreedyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_buffer_make(size : Int) -> BioseqassemblygreedyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_buffer_len(s : BioseqassemblygreedyBuffer) -> Int { s.size }

pub fn bio_seq_assembly_greedy_buffer_get(s : BioseqassemblygreedyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_buffer_set(s : BioseqassemblygreedyBuffer, i : Int, v : Double) -> BioseqassemblygreedyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_buffer_sum(s : BioseqassemblygreedyBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_buffer_mean(s : BioseqassemblygreedyBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_buffer_scale(s : BioseqassemblygreedyBuffer, f : Double) -> BioseqassemblygreedyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_buffer_add(a : BioseqassemblygreedyBuffer, b : BioseqassemblygreedyBuffer) -> BioseqassemblygreedyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_greedy_buffer_copy(s : BioseqassemblygreedyBuffer) -> BioseqassemblygreedyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_buffer_fill(s : BioseqassemblygreedyBuffer, v : Double) -> BioseqassemblygreedyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_buffer_min(s : BioseqassemblygreedyBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_buffer_max(s : BioseqassemblygreedyBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_buffer_to_string(s : BioseqassemblygreedyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_cursor_make(size : Int) -> BioseqassemblygreedyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_cursor_len(s : BioseqassemblygreedyCursor) -> Int { s.size }

pub fn bio_seq_assembly_greedy_cursor_get(s : BioseqassemblygreedyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_cursor_set(s : BioseqassemblygreedyCursor, i : Int, v : Double) -> BioseqassemblygreedyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_cursor_sum(s : BioseqassemblygreedyCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_cursor_mean(s : BioseqassemblygreedyCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_cursor_scale(s : BioseqassemblygreedyCursor, f : Double) -> BioseqassemblygreedyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_cursor_add(a : BioseqassemblygreedyCursor, b : BioseqassemblygreedyCursor) -> BioseqassemblygreedyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_greedy_cursor_copy(s : BioseqassemblygreedyCursor) -> BioseqassemblygreedyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_cursor_fill(s : BioseqassemblygreedyCursor, v : Double) -> BioseqassemblygreedyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_cursor_min(s : BioseqassemblygreedyCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_cursor_max(s : BioseqassemblygreedyCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_cursor_to_string(s : BioseqassemblygreedyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_view_make(size : Int) -> BioseqassemblygreedyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_view_len(s : BioseqassemblygreedyView) -> Int { s.size }

pub fn bio_seq_assembly_greedy_view_get(s : BioseqassemblygreedyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_view_set(s : BioseqassemblygreedyView, i : Int, v : Double) -> BioseqassemblygreedyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_view_sum(s : BioseqassemblygreedyView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_view_mean(s : BioseqassemblygreedyView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_view_scale(s : BioseqassemblygreedyView, f : Double) -> BioseqassemblygreedyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_view_add(a : BioseqassemblygreedyView, b : BioseqassemblygreedyView) -> BioseqassemblygreedyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_greedy_view_copy(s : BioseqassemblygreedyView) -> BioseqassemblygreedyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_view_fill(s : BioseqassemblygreedyView, v : Double) -> BioseqassemblygreedyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_view_min(s : BioseqassemblygreedyView) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_view_max(s : BioseqassemblygreedyView) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_view_to_string(s : BioseqassemblygreedyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_range_make(size : Int) -> BioseqassemblygreedyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_range_len(s : BioseqassemblygreedyRange) -> Int { s.size }

pub fn bio_seq_assembly_greedy_range_get(s : BioseqassemblygreedyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_range_set(s : BioseqassemblygreedyRange, i : Int, v : Double) -> BioseqassemblygreedyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_range_sum(s : BioseqassemblygreedyRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_range_mean(s : BioseqassemblygreedyRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_range_scale(s : BioseqassemblygreedyRange, f : Double) -> BioseqassemblygreedyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_range_add(a : BioseqassemblygreedyRange, b : BioseqassemblygreedyRange) -> BioseqassemblygreedyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_greedy_range_copy(s : BioseqassemblygreedyRange) -> BioseqassemblygreedyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_range_fill(s : BioseqassemblygreedyRange, v : Double) -> BioseqassemblygreedyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_range_min(s : BioseqassemblygreedyRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_range_max(s : BioseqassemblygreedyRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_range_to_string(s : BioseqassemblygreedyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygreedySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_greedy_slice_make(size : Int) -> BioseqassemblygreedySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_greedy_slice_len(s : BioseqassemblygreedySlice) -> Int { s.size }

pub fn bio_seq_assembly_greedy_slice_get(s : BioseqassemblygreedySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_greedy_slice_set(s : BioseqassemblygreedySlice, i : Int, v : Double) -> BioseqassemblygreedySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_slice_sum(s : BioseqassemblygreedySlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_greedy_slice_mean(s : BioseqassemblygreedySlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_greedy_slice_scale(s : BioseqassemblygreedySlice, f : Double) -> BioseqassemblygreedySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_slice_add(a : BioseqassemblygreedySlice, b : BioseqassemblygreedySlice) -> BioseqassemblygreedySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_greedy_slice_copy(s : BioseqassemblygreedySlice) -> BioseqassemblygreedySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_slice_fill(s : BioseqassemblygreedySlice, v : Double) -> BioseqassemblygreedySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_greedy_slice_min(s : BioseqassemblygreedySlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_greedy_slice_max(s : BioseqassemblygreedySlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_greedy_slice_to_string(s : BioseqassemblygreedySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

