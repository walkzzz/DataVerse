///===
/// extcore/bio_seq_assembly_hybrid

pub(all) struct BioseqassemblyhybridPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_hybrid_make_point(x : Double, y : Double) -> BioseqassemblyhybridPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_hybrid_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblyhybridPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblyhybridPoint::x(self : BioseqassemblyhybridPoint) -> Double { self.x }

pub fn BioseqassemblyhybridPoint::y(self : BioseqassemblyhybridPoint) -> Double { self.y }

pub fn BioseqassemblyhybridPoint::z(self : BioseqassemblyhybridPoint) -> Double { self.z }

pub fn BioseqassemblyhybridPoint::label(self : BioseqassemblyhybridPoint) -> Int { self.label }

pub fn BioseqassemblyhybridPoint::dist(self : BioseqassemblyhybridPoint, other : BioseqassemblyhybridPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblyhybridPoint::add(self : BioseqassemblyhybridPoint, other : BioseqassemblyhybridPoint) -> BioseqassemblyhybridPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblyhybridPoint::sub(self : BioseqassemblyhybridPoint, other : BioseqassemblyhybridPoint) -> BioseqassemblyhybridPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblyhybridPoint::scale(self : BioseqassemblyhybridPoint, s : Double) -> BioseqassemblyhybridPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblyhybridPoint::dot(self : BioseqassemblyhybridPoint, other : BioseqassemblyhybridPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblyhybridPoint::cross(self : BioseqassemblyhybridPoint, other : BioseqassemblyhybridPoint) -> BioseqassemblyhybridPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblyhybridPoint::norm(self : BioseqassemblyhybridPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblyhybridPoint::normalize(self : BioseqassemblyhybridPoint) -> BioseqassemblyhybridPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblyhybridPoint::negate(self : BioseqassemblyhybridPoint) -> BioseqassemblyhybridPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblyhybridPoint::mid(self : BioseqassemblyhybridPoint, other : BioseqassemblyhybridPoint) -> BioseqassemblyhybridPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblyhybridPoint::lerp(self : BioseqassemblyhybridPoint, other : BioseqassemblyhybridPoint, t : Double) -> BioseqassemblyhybridPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblyhybridPoint::to_string(self : BioseqassemblyhybridPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_hybrid_make_series(vals : Array[Double], name : String) -> BioseqassemblyhybridSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblyhybridSeries::len(self : BioseqassemblyhybridSeries) -> Int { self.vals.length() }

pub fn BioseqassemblyhybridSeries::sum(self : BioseqassemblyhybridSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblyhybridSeries::mean(self : BioseqassemblyhybridSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblyhybridSeries::min(self : BioseqassemblyhybridSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblyhybridSeries::max(self : BioseqassemblyhybridSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblyhybridSeries::range(self : BioseqassemblyhybridSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblyhybridSeries::variance(self : BioseqassemblyhybridSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblyhybridSeries::std(self : BioseqassemblyhybridSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblyhybridSeries::median(self : BioseqassemblyhybridSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblyhybridSeries::scale(self : BioseqassemblyhybridSeries, f : Double) -> BioseqassemblyhybridSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblyhybridSeries::add(self : BioseqassemblyhybridSeries, other : BioseqassemblyhybridSeries) -> BioseqassemblyhybridSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblyhybridSeries::sub(self : BioseqassemblyhybridSeries, other : BioseqassemblyhybridSeries) -> BioseqassemblyhybridSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblyhybridSeries::normalize(self : BioseqassemblyhybridSeries) -> BioseqassemblyhybridSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblyhybridSeries::cumsum(self : BioseqassemblyhybridSeries) -> BioseqassemblyhybridSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblyhybridSeries::to_string(self : BioseqassemblyhybridSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblyhybridMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_hybrid_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblyhybridMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_hybrid_matrix_identity(n : Int) -> BioseqassemblyhybridMatrix {
  let m = bio_seq_assembly_hybrid_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblyhybridMatrix::get(self : BioseqassemblyhybridMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblyhybridMatrix::transpose(self : BioseqassemblyhybridMatrix) -> BioseqassemblyhybridMatrix {
  let result = bio_seq_assembly_hybrid_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblyhybridMatrix::add(self : BioseqassemblyhybridMatrix, other : BioseqassemblyhybridMatrix) -> BioseqassemblyhybridMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_hybrid_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblyhybridMatrix::scale(self : BioseqassemblyhybridMatrix, s : Double) -> BioseqassemblyhybridMatrix {
  let result = bio_seq_assembly_hybrid_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblyhybridMatrix::multiply(self : BioseqassemblyhybridMatrix, other : BioseqassemblyhybridMatrix) -> BioseqassemblyhybridMatrix {
  if self.cols != other.rows { return bio_seq_assembly_hybrid_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_hybrid_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqassemblyhybridMatrix::trace(self : BioseqassemblyhybridMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblyhybridMatrix::det(self : BioseqassemblyhybridMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblyhybridMatrix::norm(self : BioseqassemblyhybridMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblyhybridMatrix::to_string(self : BioseqassemblyhybridMatrix) -> String {
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

pub(all) struct BioseqassemblyhybridVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_hybrid_make_vector(comps : Array[Double]) -> BioseqassemblyhybridVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_hybrid_vector_zero(dim : Int) -> BioseqassemblyhybridVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblyhybridVector::add(self : BioseqassemblyhybridVector, other : BioseqassemblyhybridVector) -> BioseqassemblyhybridVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblyhybridVector::sub(self : BioseqassemblyhybridVector, other : BioseqassemblyhybridVector) -> BioseqassemblyhybridVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblyhybridVector::scale(self : BioseqassemblyhybridVector, s : Double) -> BioseqassemblyhybridVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblyhybridVector::dot(self : BioseqassemblyhybridVector, other : BioseqassemblyhybridVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblyhybridVector::norm(self : BioseqassemblyhybridVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblyhybridVector::normalize(self : BioseqassemblyhybridVector) -> BioseqassemblyhybridVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblyhybridVector::dist(self : BioseqassemblyhybridVector, other : BioseqassemblyhybridVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblyhybridVector::to_string(self : BioseqassemblyhybridVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_hybrid_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_assembly_hybrid_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_assembly_hybrid_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_assembly_hybrid_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_assembly_hybrid_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_assembly_hybrid_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_assembly_hybrid_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_assembly_hybrid_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_assembly_hybrid_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_assembly_hybrid_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_assembly_hybrid_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_assembly_hybrid_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_assembly_hybrid_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_assembly_hybrid_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_assembly_hybrid_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_assembly_hybrid_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_assembly_hybrid_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_assembly_hybrid_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_assembly_hybrid_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_assembly_hybrid_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_assembly_hybrid_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_assembly_hybrid_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_assembly_hybrid_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_assembly_hybrid_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_assembly_hybrid_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_assembly_hybrid_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_assembly_hybrid_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_assembly_hybrid_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_assembly_hybrid_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqassemblyhybridFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_frame_make(size : Int) -> BioseqassemblyhybridFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_frame_len(s : BioseqassemblyhybridFrame) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_frame_get(s : BioseqassemblyhybridFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_frame_set(s : BioseqassemblyhybridFrame, i : Int, v : Double) -> BioseqassemblyhybridFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_frame_sum(s : BioseqassemblyhybridFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_hybrid_frame_mean(s : BioseqassemblyhybridFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_hybrid_frame_scale(s : BioseqassemblyhybridFrame, f : Double) -> BioseqassemblyhybridFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_frame_add(a : BioseqassemblyhybridFrame, b : BioseqassemblyhybridFrame) -> BioseqassemblyhybridFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_hybrid_frame_copy(s : BioseqassemblyhybridFrame) -> BioseqassemblyhybridFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_frame_fill(s : BioseqassemblyhybridFrame, v : Double) -> BioseqassemblyhybridFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_frame_min(s : BioseqassemblyhybridFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_hybrid_frame_max(s : BioseqassemblyhybridFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_hybrid_frame_to_string(s : BioseqassemblyhybridFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_table_make(size : Int) -> BioseqassemblyhybridTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_table_len(s : BioseqassemblyhybridTable) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_table_get(s : BioseqassemblyhybridTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_table_set(s : BioseqassemblyhybridTable, i : Int, v : Double) -> BioseqassemblyhybridTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_table_sum(s : BioseqassemblyhybridTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_hybrid_table_mean(s : BioseqassemblyhybridTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_hybrid_table_scale(s : BioseqassemblyhybridTable, f : Double) -> BioseqassemblyhybridTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_table_add(a : BioseqassemblyhybridTable, b : BioseqassemblyhybridTable) -> BioseqassemblyhybridTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_hybrid_table_copy(s : BioseqassemblyhybridTable) -> BioseqassemblyhybridTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_table_fill(s : BioseqassemblyhybridTable, v : Double) -> BioseqassemblyhybridTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_table_min(s : BioseqassemblyhybridTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_hybrid_table_max(s : BioseqassemblyhybridTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_hybrid_table_to_string(s : BioseqassemblyhybridTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_graphn_make(size : Int) -> BioseqassemblyhybridGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_graphn_len(s : BioseqassemblyhybridGraphN) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_graphn_get(s : BioseqassemblyhybridGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_graphn_set(s : BioseqassemblyhybridGraphN, i : Int, v : Double) -> BioseqassemblyhybridGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_graphn_sum(s : BioseqassemblyhybridGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_hybrid_graphn_mean(s : BioseqassemblyhybridGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_hybrid_graphn_scale(s : BioseqassemblyhybridGraphN, f : Double) -> BioseqassemblyhybridGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_graphn_add(a : BioseqassemblyhybridGraphN, b : BioseqassemblyhybridGraphN) -> BioseqassemblyhybridGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_hybrid_graphn_copy(s : BioseqassemblyhybridGraphN) -> BioseqassemblyhybridGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_graphn_fill(s : BioseqassemblyhybridGraphN, v : Double) -> BioseqassemblyhybridGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_graphn_min(s : BioseqassemblyhybridGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_hybrid_graphn_max(s : BioseqassemblyhybridGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_hybrid_graphn_to_string(s : BioseqassemblyhybridGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_node_make(size : Int) -> BioseqassemblyhybridNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_node_len(s : BioseqassemblyhybridNode) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_node_get(s : BioseqassemblyhybridNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_node_set(s : BioseqassemblyhybridNode, i : Int, v : Double) -> BioseqassemblyhybridNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_node_sum(s : BioseqassemblyhybridNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_hybrid_node_mean(s : BioseqassemblyhybridNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_hybrid_node_scale(s : BioseqassemblyhybridNode, f : Double) -> BioseqassemblyhybridNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_node_add(a : BioseqassemblyhybridNode, b : BioseqassemblyhybridNode) -> BioseqassemblyhybridNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_hybrid_node_copy(s : BioseqassemblyhybridNode) -> BioseqassemblyhybridNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_node_fill(s : BioseqassemblyhybridNode, v : Double) -> BioseqassemblyhybridNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_node_min(s : BioseqassemblyhybridNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_hybrid_node_max(s : BioseqassemblyhybridNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_hybrid_node_to_string(s : BioseqassemblyhybridNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_edge_make(size : Int) -> BioseqassemblyhybridEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_edge_len(s : BioseqassemblyhybridEdge) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_edge_get(s : BioseqassemblyhybridEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_edge_set(s : BioseqassemblyhybridEdge, i : Int, v : Double) -> BioseqassemblyhybridEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_edge_sum(s : BioseqassemblyhybridEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_hybrid_edge_mean(s : BioseqassemblyhybridEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_hybrid_edge_scale(s : BioseqassemblyhybridEdge, f : Double) -> BioseqassemblyhybridEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_edge_add(a : BioseqassemblyhybridEdge, b : BioseqassemblyhybridEdge) -> BioseqassemblyhybridEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_hybrid_edge_copy(s : BioseqassemblyhybridEdge) -> BioseqassemblyhybridEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_edge_fill(s : BioseqassemblyhybridEdge, v : Double) -> BioseqassemblyhybridEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_edge_min(s : BioseqassemblyhybridEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_hybrid_edge_max(s : BioseqassemblyhybridEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_hybrid_edge_to_string(s : BioseqassemblyhybridEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_path_make(size : Int) -> BioseqassemblyhybridPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_path_len(s : BioseqassemblyhybridPath) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_path_get(s : BioseqassemblyhybridPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_path_set(s : BioseqassemblyhybridPath, i : Int, v : Double) -> BioseqassemblyhybridPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_path_sum(s : BioseqassemblyhybridPath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_hybrid_path_mean(s : BioseqassemblyhybridPath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_hybrid_path_scale(s : BioseqassemblyhybridPath, f : Double) -> BioseqassemblyhybridPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_path_add(a : BioseqassemblyhybridPath, b : BioseqassemblyhybridPath) -> BioseqassemblyhybridPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_hybrid_path_copy(s : BioseqassemblyhybridPath) -> BioseqassemblyhybridPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_path_fill(s : BioseqassemblyhybridPath, v : Double) -> BioseqassemblyhybridPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_path_min(s : BioseqassemblyhybridPath) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_hybrid_path_max(s : BioseqassemblyhybridPath) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_hybrid_path_to_string(s : BioseqassemblyhybridPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_cluster_make(size : Int) -> BioseqassemblyhybridCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_cluster_len(s : BioseqassemblyhybridCluster) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_cluster_get(s : BioseqassemblyhybridCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_cluster_set(s : BioseqassemblyhybridCluster, i : Int, v : Double) -> BioseqassemblyhybridCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_cluster_sum(s : BioseqassemblyhybridCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_hybrid_cluster_mean(s : BioseqassemblyhybridCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_hybrid_cluster_scale(s : BioseqassemblyhybridCluster, f : Double) -> BioseqassemblyhybridCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_cluster_add(a : BioseqassemblyhybridCluster, b : BioseqassemblyhybridCluster) -> BioseqassemblyhybridCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_hybrid_cluster_copy(s : BioseqassemblyhybridCluster) -> BioseqassemblyhybridCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_cluster_fill(s : BioseqassemblyhybridCluster, v : Double) -> BioseqassemblyhybridCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_cluster_min(s : BioseqassemblyhybridCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_hybrid_cluster_max(s : BioseqassemblyhybridCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_hybrid_cluster_to_string(s : BioseqassemblyhybridCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_model_make(size : Int) -> BioseqassemblyhybridModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_model_len(s : BioseqassemblyhybridModel) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_model_get(s : BioseqassemblyhybridModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_model_set(s : BioseqassemblyhybridModel, i : Int, v : Double) -> BioseqassemblyhybridModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_model_sum(s : BioseqassemblyhybridModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_hybrid_model_mean(s : BioseqassemblyhybridModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_hybrid_model_scale(s : BioseqassemblyhybridModel, f : Double) -> BioseqassemblyhybridModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_model_add(a : BioseqassemblyhybridModel, b : BioseqassemblyhybridModel) -> BioseqassemblyhybridModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_hybrid_model_copy(s : BioseqassemblyhybridModel) -> BioseqassemblyhybridModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_model_fill(s : BioseqassemblyhybridModel, v : Double) -> BioseqassemblyhybridModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_model_min(s : BioseqassemblyhybridModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_hybrid_model_max(s : BioseqassemblyhybridModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_hybrid_model_to_string(s : BioseqassemblyhybridModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_layer_make(size : Int) -> BioseqassemblyhybridLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_layer_len(s : BioseqassemblyhybridLayer) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_layer_get(s : BioseqassemblyhybridLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_layer_set(s : BioseqassemblyhybridLayer, i : Int, v : Double) -> BioseqassemblyhybridLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_layer_sum(s : BioseqassemblyhybridLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_hybrid_layer_mean(s : BioseqassemblyhybridLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_hybrid_layer_scale(s : BioseqassemblyhybridLayer, f : Double) -> BioseqassemblyhybridLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_layer_add(a : BioseqassemblyhybridLayer, b : BioseqassemblyhybridLayer) -> BioseqassemblyhybridLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_hybrid_layer_copy(s : BioseqassemblyhybridLayer) -> BioseqassemblyhybridLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_layer_fill(s : BioseqassemblyhybridLayer, v : Double) -> BioseqassemblyhybridLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_layer_min(s : BioseqassemblyhybridLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_hybrid_layer_max(s : BioseqassemblyhybridLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_hybrid_layer_to_string(s : BioseqassemblyhybridLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_buffer_make(size : Int) -> BioseqassemblyhybridBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_buffer_len(s : BioseqassemblyhybridBuffer) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_buffer_get(s : BioseqassemblyhybridBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_buffer_set(s : BioseqassemblyhybridBuffer, i : Int, v : Double) -> BioseqassemblyhybridBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_buffer_sum(s : BioseqassemblyhybridBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_hybrid_buffer_mean(s : BioseqassemblyhybridBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_hybrid_buffer_scale(s : BioseqassemblyhybridBuffer, f : Double) -> BioseqassemblyhybridBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_buffer_add(a : BioseqassemblyhybridBuffer, b : BioseqassemblyhybridBuffer) -> BioseqassemblyhybridBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_hybrid_buffer_copy(s : BioseqassemblyhybridBuffer) -> BioseqassemblyhybridBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_buffer_fill(s : BioseqassemblyhybridBuffer, v : Double) -> BioseqassemblyhybridBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_buffer_min(s : BioseqassemblyhybridBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_hybrid_buffer_max(s : BioseqassemblyhybridBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_hybrid_buffer_to_string(s : BioseqassemblyhybridBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_cursor_make(size : Int) -> BioseqassemblyhybridCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_cursor_len(s : BioseqassemblyhybridCursor) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_cursor_get(s : BioseqassemblyhybridCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_cursor_set(s : BioseqassemblyhybridCursor, i : Int, v : Double) -> BioseqassemblyhybridCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_cursor_sum(s : BioseqassemblyhybridCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_hybrid_cursor_mean(s : BioseqassemblyhybridCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_hybrid_cursor_scale(s : BioseqassemblyhybridCursor, f : Double) -> BioseqassemblyhybridCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_cursor_add(a : BioseqassemblyhybridCursor, b : BioseqassemblyhybridCursor) -> BioseqassemblyhybridCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_hybrid_cursor_copy(s : BioseqassemblyhybridCursor) -> BioseqassemblyhybridCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_cursor_fill(s : BioseqassemblyhybridCursor, v : Double) -> BioseqassemblyhybridCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_cursor_min(s : BioseqassemblyhybridCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_hybrid_cursor_max(s : BioseqassemblyhybridCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_hybrid_cursor_to_string(s : BioseqassemblyhybridCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_view_make(size : Int) -> BioseqassemblyhybridView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_view_len(s : BioseqassemblyhybridView) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_view_get(s : BioseqassemblyhybridView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_view_set(s : BioseqassemblyhybridView, i : Int, v : Double) -> BioseqassemblyhybridView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_view_sum(s : BioseqassemblyhybridView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_hybrid_view_mean(s : BioseqassemblyhybridView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_hybrid_view_scale(s : BioseqassemblyhybridView, f : Double) -> BioseqassemblyhybridView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_view_add(a : BioseqassemblyhybridView, b : BioseqassemblyhybridView) -> BioseqassemblyhybridView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_hybrid_view_copy(s : BioseqassemblyhybridView) -> BioseqassemblyhybridView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_view_fill(s : BioseqassemblyhybridView, v : Double) -> BioseqassemblyhybridView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_view_min(s : BioseqassemblyhybridView) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_hybrid_view_max(s : BioseqassemblyhybridView) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_hybrid_view_to_string(s : BioseqassemblyhybridView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_range_make(size : Int) -> BioseqassemblyhybridRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_range_len(s : BioseqassemblyhybridRange) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_range_get(s : BioseqassemblyhybridRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_range_set(s : BioseqassemblyhybridRange, i : Int, v : Double) -> BioseqassemblyhybridRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_range_sum(s : BioseqassemblyhybridRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_hybrid_range_mean(s : BioseqassemblyhybridRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_hybrid_range_scale(s : BioseqassemblyhybridRange, f : Double) -> BioseqassemblyhybridRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_range_add(a : BioseqassemblyhybridRange, b : BioseqassemblyhybridRange) -> BioseqassemblyhybridRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_hybrid_range_copy(s : BioseqassemblyhybridRange) -> BioseqassemblyhybridRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_range_fill(s : BioseqassemblyhybridRange, v : Double) -> BioseqassemblyhybridRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_range_min(s : BioseqassemblyhybridRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_hybrid_range_max(s : BioseqassemblyhybridRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_hybrid_range_to_string(s : BioseqassemblyhybridRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_slice_make(size : Int) -> BioseqassemblyhybridSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_slice_len(s : BioseqassemblyhybridSlice) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_slice_get(s : BioseqassemblyhybridSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_slice_set(s : BioseqassemblyhybridSlice, i : Int, v : Double) -> BioseqassemblyhybridSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_slice_sum(s : BioseqassemblyhybridSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_hybrid_slice_mean(s : BioseqassemblyhybridSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_hybrid_slice_scale(s : BioseqassemblyhybridSlice, f : Double) -> BioseqassemblyhybridSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_slice_add(a : BioseqassemblyhybridSlice, b : BioseqassemblyhybridSlice) -> BioseqassemblyhybridSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_hybrid_slice_copy(s : BioseqassemblyhybridSlice) -> BioseqassemblyhybridSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_slice_fill(s : BioseqassemblyhybridSlice, v : Double) -> BioseqassemblyhybridSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_hybrid_slice_min(s : BioseqassemblyhybridSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_hybrid_slice_max(s : BioseqassemblyhybridSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_hybrid_slice_to_string(s : BioseqassemblyhybridSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

