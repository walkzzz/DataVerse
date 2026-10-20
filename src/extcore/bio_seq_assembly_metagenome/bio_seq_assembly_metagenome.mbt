///===
/// extcore/bio_seq_assembly_metagenome

pub(all) struct BioseqassemblymetagenomePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_metagenome_make_point(x : Double, y : Double) -> BioseqassemblymetagenomePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_metagenome_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblymetagenomePoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblymetagenomePoint::x(self : BioseqassemblymetagenomePoint) -> Double { self.x }

pub fn BioseqassemblymetagenomePoint::y(self : BioseqassemblymetagenomePoint) -> Double { self.y }

pub fn BioseqassemblymetagenomePoint::z(self : BioseqassemblymetagenomePoint) -> Double { self.z }

pub fn BioseqassemblymetagenomePoint::label(self : BioseqassemblymetagenomePoint) -> Int { self.label }

pub fn BioseqassemblymetagenomePoint::dist(self : BioseqassemblymetagenomePoint, other : BioseqassemblymetagenomePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblymetagenomePoint::add(self : BioseqassemblymetagenomePoint, other : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblymetagenomePoint::sub(self : BioseqassemblymetagenomePoint, other : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblymetagenomePoint::scale(self : BioseqassemblymetagenomePoint, s : Double) -> BioseqassemblymetagenomePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblymetagenomePoint::dot(self : BioseqassemblymetagenomePoint, other : BioseqassemblymetagenomePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblymetagenomePoint::cross(self : BioseqassemblymetagenomePoint, other : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblymetagenomePoint::norm(self : BioseqassemblymetagenomePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblymetagenomePoint::normalize(self : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblymetagenomePoint::negate(self : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblymetagenomePoint::mid(self : BioseqassemblymetagenomePoint, other : BioseqassemblymetagenomePoint) -> BioseqassemblymetagenomePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblymetagenomePoint::lerp(self : BioseqassemblymetagenomePoint, other : BioseqassemblymetagenomePoint, t : Double) -> BioseqassemblymetagenomePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblymetagenomePoint::to_string(self : BioseqassemblymetagenomePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_metagenome_make_series(vals : Array[Double], name : String) -> BioseqassemblymetagenomeSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblymetagenomeSeries::len(self : BioseqassemblymetagenomeSeries) -> Int { self.vals.length() }

pub fn BioseqassemblymetagenomeSeries::sum(self : BioseqassemblymetagenomeSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblymetagenomeSeries::mean(self : BioseqassemblymetagenomeSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblymetagenomeSeries::min(self : BioseqassemblymetagenomeSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblymetagenomeSeries::max(self : BioseqassemblymetagenomeSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblymetagenomeSeries::range(self : BioseqassemblymetagenomeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblymetagenomeSeries::variance(self : BioseqassemblymetagenomeSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblymetagenomeSeries::std(self : BioseqassemblymetagenomeSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblymetagenomeSeries::median(self : BioseqassemblymetagenomeSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblymetagenomeSeries::scale(self : BioseqassemblymetagenomeSeries, f : Double) -> BioseqassemblymetagenomeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblymetagenomeSeries::add(self : BioseqassemblymetagenomeSeries, other : BioseqassemblymetagenomeSeries) -> BioseqassemblymetagenomeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblymetagenomeSeries::sub(self : BioseqassemblymetagenomeSeries, other : BioseqassemblymetagenomeSeries) -> BioseqassemblymetagenomeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblymetagenomeSeries::normalize(self : BioseqassemblymetagenomeSeries) -> BioseqassemblymetagenomeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblymetagenomeSeries::cumsum(self : BioseqassemblymetagenomeSeries) -> BioseqassemblymetagenomeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblymetagenomeSeries::to_string(self : BioseqassemblymetagenomeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblymetagenomeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_metagenome_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblymetagenomeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_metagenome_matrix_identity(n : Int) -> BioseqassemblymetagenomeMatrix {
  let m = bio_seq_assembly_metagenome_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblymetagenomeMatrix::get(self : BioseqassemblymetagenomeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblymetagenomeMatrix::transpose(self : BioseqassemblymetagenomeMatrix) -> BioseqassemblymetagenomeMatrix {
  let result = bio_seq_assembly_metagenome_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblymetagenomeMatrix::add(self : BioseqassemblymetagenomeMatrix, other : BioseqassemblymetagenomeMatrix) -> BioseqassemblymetagenomeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_metagenome_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblymetagenomeMatrix::scale(self : BioseqassemblymetagenomeMatrix, s : Double) -> BioseqassemblymetagenomeMatrix {
  let result = bio_seq_assembly_metagenome_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblymetagenomeMatrix::multiply(self : BioseqassemblymetagenomeMatrix, other : BioseqassemblymetagenomeMatrix) -> BioseqassemblymetagenomeMatrix {
  if self.cols != other.rows { return bio_seq_assembly_metagenome_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_metagenome_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqassemblymetagenomeMatrix::trace(self : BioseqassemblymetagenomeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblymetagenomeMatrix::det(self : BioseqassemblymetagenomeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblymetagenomeMatrix::norm(self : BioseqassemblymetagenomeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblymetagenomeMatrix::to_string(self : BioseqassemblymetagenomeMatrix) -> String {
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

pub(all) struct BioseqassemblymetagenomeVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_metagenome_make_vector(comps : Array[Double]) -> BioseqassemblymetagenomeVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_metagenome_vector_zero(dim : Int) -> BioseqassemblymetagenomeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblymetagenomeVector::add(self : BioseqassemblymetagenomeVector, other : BioseqassemblymetagenomeVector) -> BioseqassemblymetagenomeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblymetagenomeVector::sub(self : BioseqassemblymetagenomeVector, other : BioseqassemblymetagenomeVector) -> BioseqassemblymetagenomeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblymetagenomeVector::scale(self : BioseqassemblymetagenomeVector, s : Double) -> BioseqassemblymetagenomeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblymetagenomeVector::dot(self : BioseqassemblymetagenomeVector, other : BioseqassemblymetagenomeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblymetagenomeVector::norm(self : BioseqassemblymetagenomeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblymetagenomeVector::normalize(self : BioseqassemblymetagenomeVector) -> BioseqassemblymetagenomeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblymetagenomeVector::dist(self : BioseqassemblymetagenomeVector, other : BioseqassemblymetagenomeVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblymetagenomeVector::to_string(self : BioseqassemblymetagenomeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_metagenome_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_assembly_metagenome_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_assembly_metagenome_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_assembly_metagenome_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_assembly_metagenome_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_assembly_metagenome_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_assembly_metagenome_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_assembly_metagenome_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_assembly_metagenome_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_assembly_metagenome_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_assembly_metagenome_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_assembly_metagenome_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_assembly_metagenome_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_assembly_metagenome_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_assembly_metagenome_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_assembly_metagenome_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_assembly_metagenome_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_assembly_metagenome_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_assembly_metagenome_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_assembly_metagenome_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_assembly_metagenome_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_assembly_metagenome_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_assembly_metagenome_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_assembly_metagenome_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_assembly_metagenome_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_assembly_metagenome_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_assembly_metagenome_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_assembly_metagenome_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_assembly_metagenome_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqassemblymetagenomeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_frame_make(size : Int) -> BioseqassemblymetagenomeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_frame_len(s : BioseqassemblymetagenomeFrame) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_frame_get(s : BioseqassemblymetagenomeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_frame_set(s : BioseqassemblymetagenomeFrame, i : Int, v : Double) -> BioseqassemblymetagenomeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_frame_sum(s : BioseqassemblymetagenomeFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_metagenome_frame_mean(s : BioseqassemblymetagenomeFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_metagenome_frame_scale(s : BioseqassemblymetagenomeFrame, f : Double) -> BioseqassemblymetagenomeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_frame_add(a : BioseqassemblymetagenomeFrame, b : BioseqassemblymetagenomeFrame) -> BioseqassemblymetagenomeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_metagenome_frame_copy(s : BioseqassemblymetagenomeFrame) -> BioseqassemblymetagenomeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_frame_fill(s : BioseqassemblymetagenomeFrame, v : Double) -> BioseqassemblymetagenomeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_frame_min(s : BioseqassemblymetagenomeFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_metagenome_frame_max(s : BioseqassemblymetagenomeFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_metagenome_frame_to_string(s : BioseqassemblymetagenomeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_table_make(size : Int) -> BioseqassemblymetagenomeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_table_len(s : BioseqassemblymetagenomeTable) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_table_get(s : BioseqassemblymetagenomeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_table_set(s : BioseqassemblymetagenomeTable, i : Int, v : Double) -> BioseqassemblymetagenomeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_table_sum(s : BioseqassemblymetagenomeTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_metagenome_table_mean(s : BioseqassemblymetagenomeTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_metagenome_table_scale(s : BioseqassemblymetagenomeTable, f : Double) -> BioseqassemblymetagenomeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_table_add(a : BioseqassemblymetagenomeTable, b : BioseqassemblymetagenomeTable) -> BioseqassemblymetagenomeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_metagenome_table_copy(s : BioseqassemblymetagenomeTable) -> BioseqassemblymetagenomeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_table_fill(s : BioseqassemblymetagenomeTable, v : Double) -> BioseqassemblymetagenomeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_table_min(s : BioseqassemblymetagenomeTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_metagenome_table_max(s : BioseqassemblymetagenomeTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_metagenome_table_to_string(s : BioseqassemblymetagenomeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_graphn_make(size : Int) -> BioseqassemblymetagenomeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_graphn_len(s : BioseqassemblymetagenomeGraphN) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_graphn_get(s : BioseqassemblymetagenomeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_graphn_set(s : BioseqassemblymetagenomeGraphN, i : Int, v : Double) -> BioseqassemblymetagenomeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_graphn_sum(s : BioseqassemblymetagenomeGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_metagenome_graphn_mean(s : BioseqassemblymetagenomeGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_metagenome_graphn_scale(s : BioseqassemblymetagenomeGraphN, f : Double) -> BioseqassemblymetagenomeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_graphn_add(a : BioseqassemblymetagenomeGraphN, b : BioseqassemblymetagenomeGraphN) -> BioseqassemblymetagenomeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_metagenome_graphn_copy(s : BioseqassemblymetagenomeGraphN) -> BioseqassemblymetagenomeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_graphn_fill(s : BioseqassemblymetagenomeGraphN, v : Double) -> BioseqassemblymetagenomeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_graphn_min(s : BioseqassemblymetagenomeGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_metagenome_graphn_max(s : BioseqassemblymetagenomeGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_metagenome_graphn_to_string(s : BioseqassemblymetagenomeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_node_make(size : Int) -> BioseqassemblymetagenomeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_node_len(s : BioseqassemblymetagenomeNode) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_node_get(s : BioseqassemblymetagenomeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_node_set(s : BioseqassemblymetagenomeNode, i : Int, v : Double) -> BioseqassemblymetagenomeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_node_sum(s : BioseqassemblymetagenomeNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_metagenome_node_mean(s : BioseqassemblymetagenomeNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_metagenome_node_scale(s : BioseqassemblymetagenomeNode, f : Double) -> BioseqassemblymetagenomeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_node_add(a : BioseqassemblymetagenomeNode, b : BioseqassemblymetagenomeNode) -> BioseqassemblymetagenomeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_metagenome_node_copy(s : BioseqassemblymetagenomeNode) -> BioseqassemblymetagenomeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_node_fill(s : BioseqassemblymetagenomeNode, v : Double) -> BioseqassemblymetagenomeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_node_min(s : BioseqassemblymetagenomeNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_metagenome_node_max(s : BioseqassemblymetagenomeNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_metagenome_node_to_string(s : BioseqassemblymetagenomeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_edge_make(size : Int) -> BioseqassemblymetagenomeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_edge_len(s : BioseqassemblymetagenomeEdge) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_edge_get(s : BioseqassemblymetagenomeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_edge_set(s : BioseqassemblymetagenomeEdge, i : Int, v : Double) -> BioseqassemblymetagenomeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_edge_sum(s : BioseqassemblymetagenomeEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_metagenome_edge_mean(s : BioseqassemblymetagenomeEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_metagenome_edge_scale(s : BioseqassemblymetagenomeEdge, f : Double) -> BioseqassemblymetagenomeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_edge_add(a : BioseqassemblymetagenomeEdge, b : BioseqassemblymetagenomeEdge) -> BioseqassemblymetagenomeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_metagenome_edge_copy(s : BioseqassemblymetagenomeEdge) -> BioseqassemblymetagenomeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_edge_fill(s : BioseqassemblymetagenomeEdge, v : Double) -> BioseqassemblymetagenomeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_edge_min(s : BioseqassemblymetagenomeEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_metagenome_edge_max(s : BioseqassemblymetagenomeEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_metagenome_edge_to_string(s : BioseqassemblymetagenomeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_path_make(size : Int) -> BioseqassemblymetagenomePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_path_len(s : BioseqassemblymetagenomePath) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_path_get(s : BioseqassemblymetagenomePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_path_set(s : BioseqassemblymetagenomePath, i : Int, v : Double) -> BioseqassemblymetagenomePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_path_sum(s : BioseqassemblymetagenomePath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_metagenome_path_mean(s : BioseqassemblymetagenomePath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_metagenome_path_scale(s : BioseqassemblymetagenomePath, f : Double) -> BioseqassemblymetagenomePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_path_add(a : BioseqassemblymetagenomePath, b : BioseqassemblymetagenomePath) -> BioseqassemblymetagenomePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_metagenome_path_copy(s : BioseqassemblymetagenomePath) -> BioseqassemblymetagenomePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_path_fill(s : BioseqassemblymetagenomePath, v : Double) -> BioseqassemblymetagenomePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_path_min(s : BioseqassemblymetagenomePath) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_metagenome_path_max(s : BioseqassemblymetagenomePath) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_metagenome_path_to_string(s : BioseqassemblymetagenomePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_cluster_make(size : Int) -> BioseqassemblymetagenomeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_cluster_len(s : BioseqassemblymetagenomeCluster) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_cluster_get(s : BioseqassemblymetagenomeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_cluster_set(s : BioseqassemblymetagenomeCluster, i : Int, v : Double) -> BioseqassemblymetagenomeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_cluster_sum(s : BioseqassemblymetagenomeCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_metagenome_cluster_mean(s : BioseqassemblymetagenomeCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_metagenome_cluster_scale(s : BioseqassemblymetagenomeCluster, f : Double) -> BioseqassemblymetagenomeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_cluster_add(a : BioseqassemblymetagenomeCluster, b : BioseqassemblymetagenomeCluster) -> BioseqassemblymetagenomeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_metagenome_cluster_copy(s : BioseqassemblymetagenomeCluster) -> BioseqassemblymetagenomeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_cluster_fill(s : BioseqassemblymetagenomeCluster, v : Double) -> BioseqassemblymetagenomeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_cluster_min(s : BioseqassemblymetagenomeCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_metagenome_cluster_max(s : BioseqassemblymetagenomeCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_metagenome_cluster_to_string(s : BioseqassemblymetagenomeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_model_make(size : Int) -> BioseqassemblymetagenomeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_model_len(s : BioseqassemblymetagenomeModel) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_model_get(s : BioseqassemblymetagenomeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_model_set(s : BioseqassemblymetagenomeModel, i : Int, v : Double) -> BioseqassemblymetagenomeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_model_sum(s : BioseqassemblymetagenomeModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_metagenome_model_mean(s : BioseqassemblymetagenomeModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_metagenome_model_scale(s : BioseqassemblymetagenomeModel, f : Double) -> BioseqassemblymetagenomeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_model_add(a : BioseqassemblymetagenomeModel, b : BioseqassemblymetagenomeModel) -> BioseqassemblymetagenomeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_metagenome_model_copy(s : BioseqassemblymetagenomeModel) -> BioseqassemblymetagenomeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_model_fill(s : BioseqassemblymetagenomeModel, v : Double) -> BioseqassemblymetagenomeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_model_min(s : BioseqassemblymetagenomeModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_metagenome_model_max(s : BioseqassemblymetagenomeModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_metagenome_model_to_string(s : BioseqassemblymetagenomeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_layer_make(size : Int) -> BioseqassemblymetagenomeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_layer_len(s : BioseqassemblymetagenomeLayer) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_layer_get(s : BioseqassemblymetagenomeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_layer_set(s : BioseqassemblymetagenomeLayer, i : Int, v : Double) -> BioseqassemblymetagenomeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_layer_sum(s : BioseqassemblymetagenomeLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_metagenome_layer_mean(s : BioseqassemblymetagenomeLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_metagenome_layer_scale(s : BioseqassemblymetagenomeLayer, f : Double) -> BioseqassemblymetagenomeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_layer_add(a : BioseqassemblymetagenomeLayer, b : BioseqassemblymetagenomeLayer) -> BioseqassemblymetagenomeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_metagenome_layer_copy(s : BioseqassemblymetagenomeLayer) -> BioseqassemblymetagenomeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_layer_fill(s : BioseqassemblymetagenomeLayer, v : Double) -> BioseqassemblymetagenomeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_layer_min(s : BioseqassemblymetagenomeLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_metagenome_layer_max(s : BioseqassemblymetagenomeLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_metagenome_layer_to_string(s : BioseqassemblymetagenomeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_buffer_make(size : Int) -> BioseqassemblymetagenomeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_buffer_len(s : BioseqassemblymetagenomeBuffer) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_buffer_get(s : BioseqassemblymetagenomeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_buffer_set(s : BioseqassemblymetagenomeBuffer, i : Int, v : Double) -> BioseqassemblymetagenomeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_buffer_sum(s : BioseqassemblymetagenomeBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_metagenome_buffer_mean(s : BioseqassemblymetagenomeBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_metagenome_buffer_scale(s : BioseqassemblymetagenomeBuffer, f : Double) -> BioseqassemblymetagenomeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_buffer_add(a : BioseqassemblymetagenomeBuffer, b : BioseqassemblymetagenomeBuffer) -> BioseqassemblymetagenomeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_metagenome_buffer_copy(s : BioseqassemblymetagenomeBuffer) -> BioseqassemblymetagenomeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_buffer_fill(s : BioseqassemblymetagenomeBuffer, v : Double) -> BioseqassemblymetagenomeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_buffer_min(s : BioseqassemblymetagenomeBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_metagenome_buffer_max(s : BioseqassemblymetagenomeBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_metagenome_buffer_to_string(s : BioseqassemblymetagenomeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_cursor_make(size : Int) -> BioseqassemblymetagenomeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_cursor_len(s : BioseqassemblymetagenomeCursor) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_cursor_get(s : BioseqassemblymetagenomeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_cursor_set(s : BioseqassemblymetagenomeCursor, i : Int, v : Double) -> BioseqassemblymetagenomeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_cursor_sum(s : BioseqassemblymetagenomeCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_metagenome_cursor_mean(s : BioseqassemblymetagenomeCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_metagenome_cursor_scale(s : BioseqassemblymetagenomeCursor, f : Double) -> BioseqassemblymetagenomeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_cursor_add(a : BioseqassemblymetagenomeCursor, b : BioseqassemblymetagenomeCursor) -> BioseqassemblymetagenomeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_metagenome_cursor_copy(s : BioseqassemblymetagenomeCursor) -> BioseqassemblymetagenomeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_cursor_fill(s : BioseqassemblymetagenomeCursor, v : Double) -> BioseqassemblymetagenomeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_cursor_min(s : BioseqassemblymetagenomeCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_metagenome_cursor_max(s : BioseqassemblymetagenomeCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_metagenome_cursor_to_string(s : BioseqassemblymetagenomeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_view_make(size : Int) -> BioseqassemblymetagenomeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_view_len(s : BioseqassemblymetagenomeView) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_view_get(s : BioseqassemblymetagenomeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_view_set(s : BioseqassemblymetagenomeView, i : Int, v : Double) -> BioseqassemblymetagenomeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_view_sum(s : BioseqassemblymetagenomeView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_metagenome_view_mean(s : BioseqassemblymetagenomeView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_metagenome_view_scale(s : BioseqassemblymetagenomeView, f : Double) -> BioseqassemblymetagenomeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_view_add(a : BioseqassemblymetagenomeView, b : BioseqassemblymetagenomeView) -> BioseqassemblymetagenomeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_metagenome_view_copy(s : BioseqassemblymetagenomeView) -> BioseqassemblymetagenomeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_view_fill(s : BioseqassemblymetagenomeView, v : Double) -> BioseqassemblymetagenomeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_view_min(s : BioseqassemblymetagenomeView) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_metagenome_view_max(s : BioseqassemblymetagenomeView) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_metagenome_view_to_string(s : BioseqassemblymetagenomeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_range_make(size : Int) -> BioseqassemblymetagenomeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_range_len(s : BioseqassemblymetagenomeRange) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_range_get(s : BioseqassemblymetagenomeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_range_set(s : BioseqassemblymetagenomeRange, i : Int, v : Double) -> BioseqassemblymetagenomeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_range_sum(s : BioseqassemblymetagenomeRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_metagenome_range_mean(s : BioseqassemblymetagenomeRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_metagenome_range_scale(s : BioseqassemblymetagenomeRange, f : Double) -> BioseqassemblymetagenomeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_range_add(a : BioseqassemblymetagenomeRange, b : BioseqassemblymetagenomeRange) -> BioseqassemblymetagenomeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_metagenome_range_copy(s : BioseqassemblymetagenomeRange) -> BioseqassemblymetagenomeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_range_fill(s : BioseqassemblymetagenomeRange, v : Double) -> BioseqassemblymetagenomeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_range_min(s : BioseqassemblymetagenomeRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_metagenome_range_max(s : BioseqassemblymetagenomeRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_metagenome_range_to_string(s : BioseqassemblymetagenomeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblymetagenomeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_metagenome_slice_make(size : Int) -> BioseqassemblymetagenomeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_metagenome_slice_len(s : BioseqassemblymetagenomeSlice) -> Int { s.size }

pub fn bio_seq_assembly_metagenome_slice_get(s : BioseqassemblymetagenomeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_metagenome_slice_set(s : BioseqassemblymetagenomeSlice, i : Int, v : Double) -> BioseqassemblymetagenomeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_slice_sum(s : BioseqassemblymetagenomeSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_metagenome_slice_mean(s : BioseqassemblymetagenomeSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_metagenome_slice_scale(s : BioseqassemblymetagenomeSlice, f : Double) -> BioseqassemblymetagenomeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_slice_add(a : BioseqassemblymetagenomeSlice, b : BioseqassemblymetagenomeSlice) -> BioseqassemblymetagenomeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_metagenome_slice_copy(s : BioseqassemblymetagenomeSlice) -> BioseqassemblymetagenomeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_slice_fill(s : BioseqassemblymetagenomeSlice, v : Double) -> BioseqassemblymetagenomeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_metagenome_slice_min(s : BioseqassemblymetagenomeSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_metagenome_slice_max(s : BioseqassemblymetagenomeSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_metagenome_slice_to_string(s : BioseqassemblymetagenomeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

