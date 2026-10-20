///===
/// extcore/bio_seq_assembly_gap

pub(all) struct BioseqassemblygapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_gap_make_point(x : Double, y : Double) -> BioseqassemblygapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_gap_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblygapPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblygapPoint::x(self : BioseqassemblygapPoint) -> Double { self.x }

pub fn BioseqassemblygapPoint::y(self : BioseqassemblygapPoint) -> Double { self.y }

pub fn BioseqassemblygapPoint::z(self : BioseqassemblygapPoint) -> Double { self.z }

pub fn BioseqassemblygapPoint::label(self : BioseqassemblygapPoint) -> Int { self.label }

pub fn BioseqassemblygapPoint::dist(self : BioseqassemblygapPoint, other : BioseqassemblygapPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblygapPoint::add(self : BioseqassemblygapPoint, other : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblygapPoint::sub(self : BioseqassemblygapPoint, other : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblygapPoint::scale(self : BioseqassemblygapPoint, s : Double) -> BioseqassemblygapPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblygapPoint::dot(self : BioseqassemblygapPoint, other : BioseqassemblygapPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblygapPoint::cross(self : BioseqassemblygapPoint, other : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblygapPoint::norm(self : BioseqassemblygapPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblygapPoint::normalize(self : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblygapPoint::negate(self : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblygapPoint::mid(self : BioseqassemblygapPoint, other : BioseqassemblygapPoint) -> BioseqassemblygapPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblygapPoint::lerp(self : BioseqassemblygapPoint, other : BioseqassemblygapPoint, t : Double) -> BioseqassemblygapPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblygapPoint::to_string(self : BioseqassemblygapPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblygapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_gap_make_series(vals : Array[Double], name : String) -> BioseqassemblygapSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblygapSeries::len(self : BioseqassemblygapSeries) -> Int { self.vals.length() }

pub fn BioseqassemblygapSeries::sum(self : BioseqassemblygapSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblygapSeries::mean(self : BioseqassemblygapSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblygapSeries::min(self : BioseqassemblygapSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblygapSeries::max(self : BioseqassemblygapSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblygapSeries::range(self : BioseqassemblygapSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblygapSeries::variance(self : BioseqassemblygapSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblygapSeries::std(self : BioseqassemblygapSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblygapSeries::median(self : BioseqassemblygapSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblygapSeries::scale(self : BioseqassemblygapSeries, f : Double) -> BioseqassemblygapSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblygapSeries::add(self : BioseqassemblygapSeries, other : BioseqassemblygapSeries) -> BioseqassemblygapSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblygapSeries::sub(self : BioseqassemblygapSeries, other : BioseqassemblygapSeries) -> BioseqassemblygapSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblygapSeries::normalize(self : BioseqassemblygapSeries) -> BioseqassemblygapSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblygapSeries::cumsum(self : BioseqassemblygapSeries) -> BioseqassemblygapSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblygapSeries::to_string(self : BioseqassemblygapSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblygapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_gap_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblygapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_gap_matrix_identity(n : Int) -> BioseqassemblygapMatrix {
  let m = bio_seq_assembly_gap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblygapMatrix::get(self : BioseqassemblygapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblygapMatrix::transpose(self : BioseqassemblygapMatrix) -> BioseqassemblygapMatrix {
  let result = bio_seq_assembly_gap_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblygapMatrix::add(self : BioseqassemblygapMatrix, other : BioseqassemblygapMatrix) -> BioseqassemblygapMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_gap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblygapMatrix::scale(self : BioseqassemblygapMatrix, s : Double) -> BioseqassemblygapMatrix {
  let result = bio_seq_assembly_gap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblygapMatrix::multiply(self : BioseqassemblygapMatrix, other : BioseqassemblygapMatrix) -> BioseqassemblygapMatrix {
  if self.cols != other.rows { return bio_seq_assembly_gap_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_gap_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqassemblygapMatrix::trace(self : BioseqassemblygapMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblygapMatrix::det(self : BioseqassemblygapMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblygapMatrix::norm(self : BioseqassemblygapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblygapMatrix::to_string(self : BioseqassemblygapMatrix) -> String {
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

pub(all) struct BioseqassemblygapVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_gap_make_vector(comps : Array[Double]) -> BioseqassemblygapVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_gap_vector_zero(dim : Int) -> BioseqassemblygapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblygapVector::add(self : BioseqassemblygapVector, other : BioseqassemblygapVector) -> BioseqassemblygapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblygapVector::sub(self : BioseqassemblygapVector, other : BioseqassemblygapVector) -> BioseqassemblygapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblygapVector::scale(self : BioseqassemblygapVector, s : Double) -> BioseqassemblygapVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblygapVector::dot(self : BioseqassemblygapVector, other : BioseqassemblygapVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblygapVector::norm(self : BioseqassemblygapVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblygapVector::normalize(self : BioseqassemblygapVector) -> BioseqassemblygapVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblygapVector::dist(self : BioseqassemblygapVector, other : BioseqassemblygapVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblygapVector::to_string(self : BioseqassemblygapVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_gap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_assembly_gap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_assembly_gap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_assembly_gap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_assembly_gap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_assembly_gap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_assembly_gap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_assembly_gap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_assembly_gap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_assembly_gap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_assembly_gap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_assembly_gap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_assembly_gap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_assembly_gap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_assembly_gap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_assembly_gap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_assembly_gap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_assembly_gap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_assembly_gap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_assembly_gap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_assembly_gap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_assembly_gap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_assembly_gap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_assembly_gap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_assembly_gap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_assembly_gap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_assembly_gap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_assembly_gap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_assembly_gap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqassemblygapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_frame_make(size : Int) -> BioseqassemblygapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_frame_len(s : BioseqassemblygapFrame) -> Int { s.size }

pub fn bio_seq_assembly_gap_frame_get(s : BioseqassemblygapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_frame_set(s : BioseqassemblygapFrame, i : Int, v : Double) -> BioseqassemblygapFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_frame_sum(s : BioseqassemblygapFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_frame_mean(s : BioseqassemblygapFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_frame_scale(s : BioseqassemblygapFrame, f : Double) -> BioseqassemblygapFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_frame_add(a : BioseqassemblygapFrame, b : BioseqassemblygapFrame) -> BioseqassemblygapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_gap_frame_copy(s : BioseqassemblygapFrame) -> BioseqassemblygapFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_frame_fill(s : BioseqassemblygapFrame, v : Double) -> BioseqassemblygapFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_frame_min(s : BioseqassemblygapFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_frame_max(s : BioseqassemblygapFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_frame_to_string(s : BioseqassemblygapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_table_make(size : Int) -> BioseqassemblygapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_table_len(s : BioseqassemblygapTable) -> Int { s.size }

pub fn bio_seq_assembly_gap_table_get(s : BioseqassemblygapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_table_set(s : BioseqassemblygapTable, i : Int, v : Double) -> BioseqassemblygapTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_table_sum(s : BioseqassemblygapTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_table_mean(s : BioseqassemblygapTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_table_scale(s : BioseqassemblygapTable, f : Double) -> BioseqassemblygapTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_table_add(a : BioseqassemblygapTable, b : BioseqassemblygapTable) -> BioseqassemblygapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_gap_table_copy(s : BioseqassemblygapTable) -> BioseqassemblygapTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_table_fill(s : BioseqassemblygapTable, v : Double) -> BioseqassemblygapTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_table_min(s : BioseqassemblygapTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_table_max(s : BioseqassemblygapTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_table_to_string(s : BioseqassemblygapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_graphn_make(size : Int) -> BioseqassemblygapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_graphn_len(s : BioseqassemblygapGraphN) -> Int { s.size }

pub fn bio_seq_assembly_gap_graphn_get(s : BioseqassemblygapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_graphn_set(s : BioseqassemblygapGraphN, i : Int, v : Double) -> BioseqassemblygapGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_graphn_sum(s : BioseqassemblygapGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_graphn_mean(s : BioseqassemblygapGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_graphn_scale(s : BioseqassemblygapGraphN, f : Double) -> BioseqassemblygapGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_graphn_add(a : BioseqassemblygapGraphN, b : BioseqassemblygapGraphN) -> BioseqassemblygapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_gap_graphn_copy(s : BioseqassemblygapGraphN) -> BioseqassemblygapGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_graphn_fill(s : BioseqassemblygapGraphN, v : Double) -> BioseqassemblygapGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_graphn_min(s : BioseqassemblygapGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_graphn_max(s : BioseqassemblygapGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_graphn_to_string(s : BioseqassemblygapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_node_make(size : Int) -> BioseqassemblygapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_node_len(s : BioseqassemblygapNode) -> Int { s.size }

pub fn bio_seq_assembly_gap_node_get(s : BioseqassemblygapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_node_set(s : BioseqassemblygapNode, i : Int, v : Double) -> BioseqassemblygapNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_node_sum(s : BioseqassemblygapNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_node_mean(s : BioseqassemblygapNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_node_scale(s : BioseqassemblygapNode, f : Double) -> BioseqassemblygapNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_node_add(a : BioseqassemblygapNode, b : BioseqassemblygapNode) -> BioseqassemblygapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_gap_node_copy(s : BioseqassemblygapNode) -> BioseqassemblygapNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_node_fill(s : BioseqassemblygapNode, v : Double) -> BioseqassemblygapNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_node_min(s : BioseqassemblygapNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_node_max(s : BioseqassemblygapNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_node_to_string(s : BioseqassemblygapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_edge_make(size : Int) -> BioseqassemblygapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_edge_len(s : BioseqassemblygapEdge) -> Int { s.size }

pub fn bio_seq_assembly_gap_edge_get(s : BioseqassemblygapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_edge_set(s : BioseqassemblygapEdge, i : Int, v : Double) -> BioseqassemblygapEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_edge_sum(s : BioseqassemblygapEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_edge_mean(s : BioseqassemblygapEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_edge_scale(s : BioseqassemblygapEdge, f : Double) -> BioseqassemblygapEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_edge_add(a : BioseqassemblygapEdge, b : BioseqassemblygapEdge) -> BioseqassemblygapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_gap_edge_copy(s : BioseqassemblygapEdge) -> BioseqassemblygapEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_edge_fill(s : BioseqassemblygapEdge, v : Double) -> BioseqassemblygapEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_edge_min(s : BioseqassemblygapEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_edge_max(s : BioseqassemblygapEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_edge_to_string(s : BioseqassemblygapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_path_make(size : Int) -> BioseqassemblygapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_path_len(s : BioseqassemblygapPath) -> Int { s.size }

pub fn bio_seq_assembly_gap_path_get(s : BioseqassemblygapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_path_set(s : BioseqassemblygapPath, i : Int, v : Double) -> BioseqassemblygapPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_path_sum(s : BioseqassemblygapPath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_path_mean(s : BioseqassemblygapPath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_path_scale(s : BioseqassemblygapPath, f : Double) -> BioseqassemblygapPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_path_add(a : BioseqassemblygapPath, b : BioseqassemblygapPath) -> BioseqassemblygapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_gap_path_copy(s : BioseqassemblygapPath) -> BioseqassemblygapPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_path_fill(s : BioseqassemblygapPath, v : Double) -> BioseqassemblygapPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_path_min(s : BioseqassemblygapPath) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_path_max(s : BioseqassemblygapPath) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_path_to_string(s : BioseqassemblygapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_cluster_make(size : Int) -> BioseqassemblygapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_cluster_len(s : BioseqassemblygapCluster) -> Int { s.size }

pub fn bio_seq_assembly_gap_cluster_get(s : BioseqassemblygapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_cluster_set(s : BioseqassemblygapCluster, i : Int, v : Double) -> BioseqassemblygapCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_cluster_sum(s : BioseqassemblygapCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_cluster_mean(s : BioseqassemblygapCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_cluster_scale(s : BioseqassemblygapCluster, f : Double) -> BioseqassemblygapCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_cluster_add(a : BioseqassemblygapCluster, b : BioseqassemblygapCluster) -> BioseqassemblygapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_gap_cluster_copy(s : BioseqassemblygapCluster) -> BioseqassemblygapCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_cluster_fill(s : BioseqassemblygapCluster, v : Double) -> BioseqassemblygapCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_cluster_min(s : BioseqassemblygapCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_cluster_max(s : BioseqassemblygapCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_cluster_to_string(s : BioseqassemblygapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_model_make(size : Int) -> BioseqassemblygapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_model_len(s : BioseqassemblygapModel) -> Int { s.size }

pub fn bio_seq_assembly_gap_model_get(s : BioseqassemblygapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_model_set(s : BioseqassemblygapModel, i : Int, v : Double) -> BioseqassemblygapModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_model_sum(s : BioseqassemblygapModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_model_mean(s : BioseqassemblygapModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_model_scale(s : BioseqassemblygapModel, f : Double) -> BioseqassemblygapModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_model_add(a : BioseqassemblygapModel, b : BioseqassemblygapModel) -> BioseqassemblygapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_gap_model_copy(s : BioseqassemblygapModel) -> BioseqassemblygapModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_model_fill(s : BioseqassemblygapModel, v : Double) -> BioseqassemblygapModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_model_min(s : BioseqassemblygapModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_model_max(s : BioseqassemblygapModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_model_to_string(s : BioseqassemblygapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_layer_make(size : Int) -> BioseqassemblygapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_layer_len(s : BioseqassemblygapLayer) -> Int { s.size }

pub fn bio_seq_assembly_gap_layer_get(s : BioseqassemblygapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_layer_set(s : BioseqassemblygapLayer, i : Int, v : Double) -> BioseqassemblygapLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_layer_sum(s : BioseqassemblygapLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_layer_mean(s : BioseqassemblygapLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_layer_scale(s : BioseqassemblygapLayer, f : Double) -> BioseqassemblygapLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_layer_add(a : BioseqassemblygapLayer, b : BioseqassemblygapLayer) -> BioseqassemblygapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_gap_layer_copy(s : BioseqassemblygapLayer) -> BioseqassemblygapLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_layer_fill(s : BioseqassemblygapLayer, v : Double) -> BioseqassemblygapLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_layer_min(s : BioseqassemblygapLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_layer_max(s : BioseqassemblygapLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_layer_to_string(s : BioseqassemblygapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_buffer_make(size : Int) -> BioseqassemblygapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_buffer_len(s : BioseqassemblygapBuffer) -> Int { s.size }

pub fn bio_seq_assembly_gap_buffer_get(s : BioseqassemblygapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_buffer_set(s : BioseqassemblygapBuffer, i : Int, v : Double) -> BioseqassemblygapBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_buffer_sum(s : BioseqassemblygapBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_buffer_mean(s : BioseqassemblygapBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_buffer_scale(s : BioseqassemblygapBuffer, f : Double) -> BioseqassemblygapBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_buffer_add(a : BioseqassemblygapBuffer, b : BioseqassemblygapBuffer) -> BioseqassemblygapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_gap_buffer_copy(s : BioseqassemblygapBuffer) -> BioseqassemblygapBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_buffer_fill(s : BioseqassemblygapBuffer, v : Double) -> BioseqassemblygapBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_buffer_min(s : BioseqassemblygapBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_buffer_max(s : BioseqassemblygapBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_buffer_to_string(s : BioseqassemblygapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_cursor_make(size : Int) -> BioseqassemblygapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_cursor_len(s : BioseqassemblygapCursor) -> Int { s.size }

pub fn bio_seq_assembly_gap_cursor_get(s : BioseqassemblygapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_cursor_set(s : BioseqassemblygapCursor, i : Int, v : Double) -> BioseqassemblygapCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_cursor_sum(s : BioseqassemblygapCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_cursor_mean(s : BioseqassemblygapCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_cursor_scale(s : BioseqassemblygapCursor, f : Double) -> BioseqassemblygapCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_cursor_add(a : BioseqassemblygapCursor, b : BioseqassemblygapCursor) -> BioseqassemblygapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_gap_cursor_copy(s : BioseqassemblygapCursor) -> BioseqassemblygapCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_cursor_fill(s : BioseqassemblygapCursor, v : Double) -> BioseqassemblygapCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_cursor_min(s : BioseqassemblygapCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_cursor_max(s : BioseqassemblygapCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_cursor_to_string(s : BioseqassemblygapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_view_make(size : Int) -> BioseqassemblygapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_view_len(s : BioseqassemblygapView) -> Int { s.size }

pub fn bio_seq_assembly_gap_view_get(s : BioseqassemblygapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_view_set(s : BioseqassemblygapView, i : Int, v : Double) -> BioseqassemblygapView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_view_sum(s : BioseqassemblygapView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_view_mean(s : BioseqassemblygapView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_view_scale(s : BioseqassemblygapView, f : Double) -> BioseqassemblygapView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_view_add(a : BioseqassemblygapView, b : BioseqassemblygapView) -> BioseqassemblygapView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_gap_view_copy(s : BioseqassemblygapView) -> BioseqassemblygapView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_view_fill(s : BioseqassemblygapView, v : Double) -> BioseqassemblygapView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_view_min(s : BioseqassemblygapView) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_view_max(s : BioseqassemblygapView) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_view_to_string(s : BioseqassemblygapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_range_make(size : Int) -> BioseqassemblygapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_range_len(s : BioseqassemblygapRange) -> Int { s.size }

pub fn bio_seq_assembly_gap_range_get(s : BioseqassemblygapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_range_set(s : BioseqassemblygapRange, i : Int, v : Double) -> BioseqassemblygapRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_range_sum(s : BioseqassemblygapRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_range_mean(s : BioseqassemblygapRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_range_scale(s : BioseqassemblygapRange, f : Double) -> BioseqassemblygapRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_range_add(a : BioseqassemblygapRange, b : BioseqassemblygapRange) -> BioseqassemblygapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_gap_range_copy(s : BioseqassemblygapRange) -> BioseqassemblygapRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_range_fill(s : BioseqassemblygapRange, v : Double) -> BioseqassemblygapRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_range_min(s : BioseqassemblygapRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_range_max(s : BioseqassemblygapRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_range_to_string(s : BioseqassemblygapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblygapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_gap_slice_make(size : Int) -> BioseqassemblygapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_gap_slice_len(s : BioseqassemblygapSlice) -> Int { s.size }

pub fn bio_seq_assembly_gap_slice_get(s : BioseqassemblygapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_gap_slice_set(s : BioseqassemblygapSlice, i : Int, v : Double) -> BioseqassemblygapSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_slice_sum(s : BioseqassemblygapSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_gap_slice_mean(s : BioseqassemblygapSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_gap_slice_scale(s : BioseqassemblygapSlice, f : Double) -> BioseqassemblygapSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_slice_add(a : BioseqassemblygapSlice, b : BioseqassemblygapSlice) -> BioseqassemblygapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_gap_slice_copy(s : BioseqassemblygapSlice) -> BioseqassemblygapSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_slice_fill(s : BioseqassemblygapSlice, v : Double) -> BioseqassemblygapSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_gap_slice_min(s : BioseqassemblygapSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_gap_slice_max(s : BioseqassemblygapSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_gap_slice_to_string(s : BioseqassemblygapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

