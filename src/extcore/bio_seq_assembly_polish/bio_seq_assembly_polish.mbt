///===
/// extcore/bio_seq_assembly_polish

pub(all) struct BioseqassemblypolishPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_polish_make_point(x : Double, y : Double) -> BioseqassemblypolishPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_polish_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblypolishPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqassemblypolishPoint::x(self : BioseqassemblypolishPoint) -> Double { self.x }

pub fn BioseqassemblypolishPoint::y(self : BioseqassemblypolishPoint) -> Double { self.y }

pub fn BioseqassemblypolishPoint::z(self : BioseqassemblypolishPoint) -> Double { self.z }

pub fn BioseqassemblypolishPoint::label(self : BioseqassemblypolishPoint) -> Int { self.label }

pub fn BioseqassemblypolishPoint::dist(self : BioseqassemblypolishPoint, other : BioseqassemblypolishPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqassemblypolishPoint::add(self : BioseqassemblypolishPoint, other : BioseqassemblypolishPoint) -> BioseqassemblypolishPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqassemblypolishPoint::sub(self : BioseqassemblypolishPoint, other : BioseqassemblypolishPoint) -> BioseqassemblypolishPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqassemblypolishPoint::scale(self : BioseqassemblypolishPoint, s : Double) -> BioseqassemblypolishPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqassemblypolishPoint::dot(self : BioseqassemblypolishPoint, other : BioseqassemblypolishPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqassemblypolishPoint::cross(self : BioseqassemblypolishPoint, other : BioseqassemblypolishPoint) -> BioseqassemblypolishPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqassemblypolishPoint::norm(self : BioseqassemblypolishPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqassemblypolishPoint::normalize(self : BioseqassemblypolishPoint) -> BioseqassemblypolishPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblypolishPoint::negate(self : BioseqassemblypolishPoint) -> BioseqassemblypolishPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqassemblypolishPoint::mid(self : BioseqassemblypolishPoint, other : BioseqassemblypolishPoint) -> BioseqassemblypolishPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqassemblypolishPoint::lerp(self : BioseqassemblypolishPoint, other : BioseqassemblypolishPoint, t : Double) -> BioseqassemblypolishPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqassemblypolishPoint::to_string(self : BioseqassemblypolishPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqassemblypolishSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_polish_make_series(vals : Array[Double], name : String) -> BioseqassemblypolishSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqassemblypolishSeries::len(self : BioseqassemblypolishSeries) -> Int { self.vals.length() }

pub fn BioseqassemblypolishSeries::sum(self : BioseqassemblypolishSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqassemblypolishSeries::mean(self : BioseqassemblypolishSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqassemblypolishSeries::min(self : BioseqassemblypolishSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqassemblypolishSeries::max(self : BioseqassemblypolishSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqassemblypolishSeries::range(self : BioseqassemblypolishSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqassemblypolishSeries::variance(self : BioseqassemblypolishSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqassemblypolishSeries::std(self : BioseqassemblypolishSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqassemblypolishSeries::median(self : BioseqassemblypolishSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqassemblypolishSeries::scale(self : BioseqassemblypolishSeries, f : Double) -> BioseqassemblypolishSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqassemblypolishSeries::add(self : BioseqassemblypolishSeries, other : BioseqassemblypolishSeries) -> BioseqassemblypolishSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqassemblypolishSeries::sub(self : BioseqassemblypolishSeries, other : BioseqassemblypolishSeries) -> BioseqassemblypolishSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqassemblypolishSeries::normalize(self : BioseqassemblypolishSeries) -> BioseqassemblypolishSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqassemblypolishSeries::cumsum(self : BioseqassemblypolishSeries) -> BioseqassemblypolishSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqassemblypolishSeries::to_string(self : BioseqassemblypolishSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblypolishMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_polish_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblypolishMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_polish_matrix_identity(n : Int) -> BioseqassemblypolishMatrix {
  let m = bio_seq_assembly_polish_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqassemblypolishMatrix::get(self : BioseqassemblypolishMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqassemblypolishMatrix::transpose(self : BioseqassemblypolishMatrix) -> BioseqassemblypolishMatrix {
  let result = bio_seq_assembly_polish_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqassemblypolishMatrix::add(self : BioseqassemblypolishMatrix, other : BioseqassemblypolishMatrix) -> BioseqassemblypolishMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_assembly_polish_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqassemblypolishMatrix::scale(self : BioseqassemblypolishMatrix, s : Double) -> BioseqassemblypolishMatrix {
  let result = bio_seq_assembly_polish_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqassemblypolishMatrix::multiply(self : BioseqassemblypolishMatrix, other : BioseqassemblypolishMatrix) -> BioseqassemblypolishMatrix {
  if self.cols != other.rows { return bio_seq_assembly_polish_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_assembly_polish_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqassemblypolishMatrix::trace(self : BioseqassemblypolishMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqassemblypolishMatrix::det(self : BioseqassemblypolishMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqassemblypolishMatrix::norm(self : BioseqassemblypolishMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqassemblypolishMatrix::to_string(self : BioseqassemblypolishMatrix) -> String {
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

pub(all) struct BioseqassemblypolishVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_polish_make_vector(comps : Array[Double]) -> BioseqassemblypolishVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_polish_vector_zero(dim : Int) -> BioseqassemblypolishVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqassemblypolishVector::add(self : BioseqassemblypolishVector, other : BioseqassemblypolishVector) -> BioseqassemblypolishVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblypolishVector::sub(self : BioseqassemblypolishVector, other : BioseqassemblypolishVector) -> BioseqassemblypolishVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqassemblypolishVector::scale(self : BioseqassemblypolishVector, s : Double) -> BioseqassemblypolishVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqassemblypolishVector::dot(self : BioseqassemblypolishVector, other : BioseqassemblypolishVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqassemblypolishVector::norm(self : BioseqassemblypolishVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqassemblypolishVector::normalize(self : BioseqassemblypolishVector) -> BioseqassemblypolishVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqassemblypolishVector::dist(self : BioseqassemblypolishVector, other : BioseqassemblypolishVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqassemblypolishVector::to_string(self : BioseqassemblypolishVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_polish_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_assembly_polish_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_assembly_polish_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_assembly_polish_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_assembly_polish_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_assembly_polish_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_assembly_polish_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_assembly_polish_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_assembly_polish_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_assembly_polish_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_assembly_polish_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_assembly_polish_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_assembly_polish_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_assembly_polish_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_assembly_polish_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_assembly_polish_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_assembly_polish_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_assembly_polish_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_assembly_polish_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_assembly_polish_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_assembly_polish_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_assembly_polish_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_assembly_polish_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_assembly_polish_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_assembly_polish_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_assembly_polish_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_assembly_polish_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_assembly_polish_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_assembly_polish_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqassemblypolishFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_frame_make(size : Int) -> BioseqassemblypolishFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_frame_len(s : BioseqassemblypolishFrame) -> Int { s.size }

pub fn bio_seq_assembly_polish_frame_get(s : BioseqassemblypolishFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_frame_set(s : BioseqassemblypolishFrame, i : Int, v : Double) -> BioseqassemblypolishFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_frame_sum(s : BioseqassemblypolishFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_polish_frame_mean(s : BioseqassemblypolishFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_polish_frame_scale(s : BioseqassemblypolishFrame, f : Double) -> BioseqassemblypolishFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_frame_add(a : BioseqassemblypolishFrame, b : BioseqassemblypolishFrame) -> BioseqassemblypolishFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_polish_frame_copy(s : BioseqassemblypolishFrame) -> BioseqassemblypolishFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_frame_fill(s : BioseqassemblypolishFrame, v : Double) -> BioseqassemblypolishFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_frame_min(s : BioseqassemblypolishFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_polish_frame_max(s : BioseqassemblypolishFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_polish_frame_to_string(s : BioseqassemblypolishFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_table_make(size : Int) -> BioseqassemblypolishTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_table_len(s : BioseqassemblypolishTable) -> Int { s.size }

pub fn bio_seq_assembly_polish_table_get(s : BioseqassemblypolishTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_table_set(s : BioseqassemblypolishTable, i : Int, v : Double) -> BioseqassemblypolishTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_table_sum(s : BioseqassemblypolishTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_polish_table_mean(s : BioseqassemblypolishTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_polish_table_scale(s : BioseqassemblypolishTable, f : Double) -> BioseqassemblypolishTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_table_add(a : BioseqassemblypolishTable, b : BioseqassemblypolishTable) -> BioseqassemblypolishTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_polish_table_copy(s : BioseqassemblypolishTable) -> BioseqassemblypolishTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_table_fill(s : BioseqassemblypolishTable, v : Double) -> BioseqassemblypolishTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_table_min(s : BioseqassemblypolishTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_polish_table_max(s : BioseqassemblypolishTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_polish_table_to_string(s : BioseqassemblypolishTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_graphn_make(size : Int) -> BioseqassemblypolishGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_graphn_len(s : BioseqassemblypolishGraphN) -> Int { s.size }

pub fn bio_seq_assembly_polish_graphn_get(s : BioseqassemblypolishGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_graphn_set(s : BioseqassemblypolishGraphN, i : Int, v : Double) -> BioseqassemblypolishGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_graphn_sum(s : BioseqassemblypolishGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_polish_graphn_mean(s : BioseqassemblypolishGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_polish_graphn_scale(s : BioseqassemblypolishGraphN, f : Double) -> BioseqassemblypolishGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_graphn_add(a : BioseqassemblypolishGraphN, b : BioseqassemblypolishGraphN) -> BioseqassemblypolishGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_polish_graphn_copy(s : BioseqassemblypolishGraphN) -> BioseqassemblypolishGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_graphn_fill(s : BioseqassemblypolishGraphN, v : Double) -> BioseqassemblypolishGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_graphn_min(s : BioseqassemblypolishGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_polish_graphn_max(s : BioseqassemblypolishGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_polish_graphn_to_string(s : BioseqassemblypolishGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_node_make(size : Int) -> BioseqassemblypolishNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_node_len(s : BioseqassemblypolishNode) -> Int { s.size }

pub fn bio_seq_assembly_polish_node_get(s : BioseqassemblypolishNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_node_set(s : BioseqassemblypolishNode, i : Int, v : Double) -> BioseqassemblypolishNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_node_sum(s : BioseqassemblypolishNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_polish_node_mean(s : BioseqassemblypolishNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_polish_node_scale(s : BioseqassemblypolishNode, f : Double) -> BioseqassemblypolishNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_node_add(a : BioseqassemblypolishNode, b : BioseqassemblypolishNode) -> BioseqassemblypolishNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_polish_node_copy(s : BioseqassemblypolishNode) -> BioseqassemblypolishNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_node_fill(s : BioseqassemblypolishNode, v : Double) -> BioseqassemblypolishNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_node_min(s : BioseqassemblypolishNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_polish_node_max(s : BioseqassemblypolishNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_polish_node_to_string(s : BioseqassemblypolishNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_edge_make(size : Int) -> BioseqassemblypolishEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_edge_len(s : BioseqassemblypolishEdge) -> Int { s.size }

pub fn bio_seq_assembly_polish_edge_get(s : BioseqassemblypolishEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_edge_set(s : BioseqassemblypolishEdge, i : Int, v : Double) -> BioseqassemblypolishEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_edge_sum(s : BioseqassemblypolishEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_polish_edge_mean(s : BioseqassemblypolishEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_polish_edge_scale(s : BioseqassemblypolishEdge, f : Double) -> BioseqassemblypolishEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_edge_add(a : BioseqassemblypolishEdge, b : BioseqassemblypolishEdge) -> BioseqassemblypolishEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_polish_edge_copy(s : BioseqassemblypolishEdge) -> BioseqassemblypolishEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_edge_fill(s : BioseqassemblypolishEdge, v : Double) -> BioseqassemblypolishEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_edge_min(s : BioseqassemblypolishEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_polish_edge_max(s : BioseqassemblypolishEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_polish_edge_to_string(s : BioseqassemblypolishEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_path_make(size : Int) -> BioseqassemblypolishPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_path_len(s : BioseqassemblypolishPath) -> Int { s.size }

pub fn bio_seq_assembly_polish_path_get(s : BioseqassemblypolishPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_path_set(s : BioseqassemblypolishPath, i : Int, v : Double) -> BioseqassemblypolishPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_path_sum(s : BioseqassemblypolishPath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_polish_path_mean(s : BioseqassemblypolishPath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_polish_path_scale(s : BioseqassemblypolishPath, f : Double) -> BioseqassemblypolishPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_path_add(a : BioseqassemblypolishPath, b : BioseqassemblypolishPath) -> BioseqassemblypolishPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_polish_path_copy(s : BioseqassemblypolishPath) -> BioseqassemblypolishPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_path_fill(s : BioseqassemblypolishPath, v : Double) -> BioseqassemblypolishPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_path_min(s : BioseqassemblypolishPath) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_polish_path_max(s : BioseqassemblypolishPath) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_polish_path_to_string(s : BioseqassemblypolishPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_cluster_make(size : Int) -> BioseqassemblypolishCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_cluster_len(s : BioseqassemblypolishCluster) -> Int { s.size }

pub fn bio_seq_assembly_polish_cluster_get(s : BioseqassemblypolishCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_cluster_set(s : BioseqassemblypolishCluster, i : Int, v : Double) -> BioseqassemblypolishCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_cluster_sum(s : BioseqassemblypolishCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_polish_cluster_mean(s : BioseqassemblypolishCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_polish_cluster_scale(s : BioseqassemblypolishCluster, f : Double) -> BioseqassemblypolishCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_cluster_add(a : BioseqassemblypolishCluster, b : BioseqassemblypolishCluster) -> BioseqassemblypolishCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_polish_cluster_copy(s : BioseqassemblypolishCluster) -> BioseqassemblypolishCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_cluster_fill(s : BioseqassemblypolishCluster, v : Double) -> BioseqassemblypolishCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_cluster_min(s : BioseqassemblypolishCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_polish_cluster_max(s : BioseqassemblypolishCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_polish_cluster_to_string(s : BioseqassemblypolishCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_model_make(size : Int) -> BioseqassemblypolishModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_model_len(s : BioseqassemblypolishModel) -> Int { s.size }

pub fn bio_seq_assembly_polish_model_get(s : BioseqassemblypolishModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_model_set(s : BioseqassemblypolishModel, i : Int, v : Double) -> BioseqassemblypolishModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_model_sum(s : BioseqassemblypolishModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_polish_model_mean(s : BioseqassemblypolishModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_polish_model_scale(s : BioseqassemblypolishModel, f : Double) -> BioseqassemblypolishModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_model_add(a : BioseqassemblypolishModel, b : BioseqassemblypolishModel) -> BioseqassemblypolishModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_polish_model_copy(s : BioseqassemblypolishModel) -> BioseqassemblypolishModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_model_fill(s : BioseqassemblypolishModel, v : Double) -> BioseqassemblypolishModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_model_min(s : BioseqassemblypolishModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_polish_model_max(s : BioseqassemblypolishModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_polish_model_to_string(s : BioseqassemblypolishModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_layer_make(size : Int) -> BioseqassemblypolishLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_layer_len(s : BioseqassemblypolishLayer) -> Int { s.size }

pub fn bio_seq_assembly_polish_layer_get(s : BioseqassemblypolishLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_layer_set(s : BioseqassemblypolishLayer, i : Int, v : Double) -> BioseqassemblypolishLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_layer_sum(s : BioseqassemblypolishLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_polish_layer_mean(s : BioseqassemblypolishLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_polish_layer_scale(s : BioseqassemblypolishLayer, f : Double) -> BioseqassemblypolishLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_layer_add(a : BioseqassemblypolishLayer, b : BioseqassemblypolishLayer) -> BioseqassemblypolishLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_polish_layer_copy(s : BioseqassemblypolishLayer) -> BioseqassemblypolishLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_layer_fill(s : BioseqassemblypolishLayer, v : Double) -> BioseqassemblypolishLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_layer_min(s : BioseqassemblypolishLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_polish_layer_max(s : BioseqassemblypolishLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_polish_layer_to_string(s : BioseqassemblypolishLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_buffer_make(size : Int) -> BioseqassemblypolishBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_buffer_len(s : BioseqassemblypolishBuffer) -> Int { s.size }

pub fn bio_seq_assembly_polish_buffer_get(s : BioseqassemblypolishBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_buffer_set(s : BioseqassemblypolishBuffer, i : Int, v : Double) -> BioseqassemblypolishBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_buffer_sum(s : BioseqassemblypolishBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_polish_buffer_mean(s : BioseqassemblypolishBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_polish_buffer_scale(s : BioseqassemblypolishBuffer, f : Double) -> BioseqassemblypolishBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_buffer_add(a : BioseqassemblypolishBuffer, b : BioseqassemblypolishBuffer) -> BioseqassemblypolishBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_polish_buffer_copy(s : BioseqassemblypolishBuffer) -> BioseqassemblypolishBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_buffer_fill(s : BioseqassemblypolishBuffer, v : Double) -> BioseqassemblypolishBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_buffer_min(s : BioseqassemblypolishBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_polish_buffer_max(s : BioseqassemblypolishBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_polish_buffer_to_string(s : BioseqassemblypolishBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_cursor_make(size : Int) -> BioseqassemblypolishCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_cursor_len(s : BioseqassemblypolishCursor) -> Int { s.size }

pub fn bio_seq_assembly_polish_cursor_get(s : BioseqassemblypolishCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_cursor_set(s : BioseqassemblypolishCursor, i : Int, v : Double) -> BioseqassemblypolishCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_cursor_sum(s : BioseqassemblypolishCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_polish_cursor_mean(s : BioseqassemblypolishCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_polish_cursor_scale(s : BioseqassemblypolishCursor, f : Double) -> BioseqassemblypolishCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_cursor_add(a : BioseqassemblypolishCursor, b : BioseqassemblypolishCursor) -> BioseqassemblypolishCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_polish_cursor_copy(s : BioseqassemblypolishCursor) -> BioseqassemblypolishCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_cursor_fill(s : BioseqassemblypolishCursor, v : Double) -> BioseqassemblypolishCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_cursor_min(s : BioseqassemblypolishCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_polish_cursor_max(s : BioseqassemblypolishCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_polish_cursor_to_string(s : BioseqassemblypolishCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_view_make(size : Int) -> BioseqassemblypolishView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_view_len(s : BioseqassemblypolishView) -> Int { s.size }

pub fn bio_seq_assembly_polish_view_get(s : BioseqassemblypolishView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_view_set(s : BioseqassemblypolishView, i : Int, v : Double) -> BioseqassemblypolishView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_view_sum(s : BioseqassemblypolishView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_polish_view_mean(s : BioseqassemblypolishView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_polish_view_scale(s : BioseqassemblypolishView, f : Double) -> BioseqassemblypolishView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_view_add(a : BioseqassemblypolishView, b : BioseqassemblypolishView) -> BioseqassemblypolishView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_polish_view_copy(s : BioseqassemblypolishView) -> BioseqassemblypolishView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_view_fill(s : BioseqassemblypolishView, v : Double) -> BioseqassemblypolishView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_view_min(s : BioseqassemblypolishView) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_polish_view_max(s : BioseqassemblypolishView) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_polish_view_to_string(s : BioseqassemblypolishView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_range_make(size : Int) -> BioseqassemblypolishRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_range_len(s : BioseqassemblypolishRange) -> Int { s.size }

pub fn bio_seq_assembly_polish_range_get(s : BioseqassemblypolishRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_range_set(s : BioseqassemblypolishRange, i : Int, v : Double) -> BioseqassemblypolishRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_range_sum(s : BioseqassemblypolishRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_polish_range_mean(s : BioseqassemblypolishRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_polish_range_scale(s : BioseqassemblypolishRange, f : Double) -> BioseqassemblypolishRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_range_add(a : BioseqassemblypolishRange, b : BioseqassemblypolishRange) -> BioseqassemblypolishRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_polish_range_copy(s : BioseqassemblypolishRange) -> BioseqassemblypolishRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_range_fill(s : BioseqassemblypolishRange, v : Double) -> BioseqassemblypolishRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_range_min(s : BioseqassemblypolishRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_polish_range_max(s : BioseqassemblypolishRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_polish_range_to_string(s : BioseqassemblypolishRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_slice_make(size : Int) -> BioseqassemblypolishSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_polish_slice_len(s : BioseqassemblypolishSlice) -> Int { s.size }

pub fn bio_seq_assembly_polish_slice_get(s : BioseqassemblypolishSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_polish_slice_set(s : BioseqassemblypolishSlice, i : Int, v : Double) -> BioseqassemblypolishSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_slice_sum(s : BioseqassemblypolishSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_assembly_polish_slice_mean(s : BioseqassemblypolishSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_assembly_polish_slice_scale(s : BioseqassemblypolishSlice, f : Double) -> BioseqassemblypolishSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_slice_add(a : BioseqassemblypolishSlice, b : BioseqassemblypolishSlice) -> BioseqassemblypolishSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_assembly_polish_slice_copy(s : BioseqassemblypolishSlice) -> BioseqassemblypolishSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_slice_fill(s : BioseqassemblypolishSlice, v : Double) -> BioseqassemblypolishSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_assembly_polish_slice_min(s : BioseqassemblypolishSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_assembly_polish_slice_max(s : BioseqassemblypolishSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_assembly_polish_slice_to_string(s : BioseqassemblypolishSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

