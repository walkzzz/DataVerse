///===
/// extcore/bio_seq_align_global

pub(all) struct BioseqalignglobalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_global_make_point(x : Double, y : Double) -> BioseqalignglobalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_global_make_point3(x : Double, y : Double, z : Double) -> BioseqalignglobalPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqalignglobalPoint::x(self : BioseqalignglobalPoint) -> Double { self.x }

pub fn BioseqalignglobalPoint::y(self : BioseqalignglobalPoint) -> Double { self.y }

pub fn BioseqalignglobalPoint::z(self : BioseqalignglobalPoint) -> Double { self.z }

pub fn BioseqalignglobalPoint::label(self : BioseqalignglobalPoint) -> Int { self.label }

pub fn BioseqalignglobalPoint::dist(self : BioseqalignglobalPoint, other : BioseqalignglobalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqalignglobalPoint::add(self : BioseqalignglobalPoint, other : BioseqalignglobalPoint) -> BioseqalignglobalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqalignglobalPoint::sub(self : BioseqalignglobalPoint, other : BioseqalignglobalPoint) -> BioseqalignglobalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqalignglobalPoint::scale(self : BioseqalignglobalPoint, s : Double) -> BioseqalignglobalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqalignglobalPoint::dot(self : BioseqalignglobalPoint, other : BioseqalignglobalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqalignglobalPoint::cross(self : BioseqalignglobalPoint, other : BioseqalignglobalPoint) -> BioseqalignglobalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqalignglobalPoint::norm(self : BioseqalignglobalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqalignglobalPoint::normalize(self : BioseqalignglobalPoint) -> BioseqalignglobalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignglobalPoint::negate(self : BioseqalignglobalPoint) -> BioseqalignglobalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqalignglobalPoint::mid(self : BioseqalignglobalPoint, other : BioseqalignglobalPoint) -> BioseqalignglobalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqalignglobalPoint::lerp(self : BioseqalignglobalPoint, other : BioseqalignglobalPoint, t : Double) -> BioseqalignglobalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqalignglobalPoint::to_string(self : BioseqalignglobalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqalignglobalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_global_make_series(vals : Array[Double], name : String) -> BioseqalignglobalSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqalignglobalSeries::len(self : BioseqalignglobalSeries) -> Int { self.vals.length() }

pub fn BioseqalignglobalSeries::sum(self : BioseqalignglobalSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqalignglobalSeries::mean(self : BioseqalignglobalSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqalignglobalSeries::min(self : BioseqalignglobalSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqalignglobalSeries::max(self : BioseqalignglobalSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqalignglobalSeries::range(self : BioseqalignglobalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqalignglobalSeries::variance(self : BioseqalignglobalSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqalignglobalSeries::std(self : BioseqalignglobalSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqalignglobalSeries::median(self : BioseqalignglobalSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqalignglobalSeries::scale(self : BioseqalignglobalSeries, f : Double) -> BioseqalignglobalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqalignglobalSeries::add(self : BioseqalignglobalSeries, other : BioseqalignglobalSeries) -> BioseqalignglobalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqalignglobalSeries::sub(self : BioseqalignglobalSeries, other : BioseqalignglobalSeries) -> BioseqalignglobalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqalignglobalSeries::normalize(self : BioseqalignglobalSeries) -> BioseqalignglobalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqalignglobalSeries::cumsum(self : BioseqalignglobalSeries) -> BioseqalignglobalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqalignglobalSeries::to_string(self : BioseqalignglobalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignglobalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_global_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignglobalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_global_matrix_identity(n : Int) -> BioseqalignglobalMatrix {
  let m = bio_seq_align_global_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqalignglobalMatrix::get(self : BioseqalignglobalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqalignglobalMatrix::transpose(self : BioseqalignglobalMatrix) -> BioseqalignglobalMatrix {
  let result = bio_seq_align_global_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqalignglobalMatrix::add(self : BioseqalignglobalMatrix, other : BioseqalignglobalMatrix) -> BioseqalignglobalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_align_global_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqalignglobalMatrix::scale(self : BioseqalignglobalMatrix, s : Double) -> BioseqalignglobalMatrix {
  let result = bio_seq_align_global_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqalignglobalMatrix::multiply(self : BioseqalignglobalMatrix, other : BioseqalignglobalMatrix) -> BioseqalignglobalMatrix {
  if self.cols != other.rows { return bio_seq_align_global_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_align_global_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqalignglobalMatrix::trace(self : BioseqalignglobalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqalignglobalMatrix::det(self : BioseqalignglobalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqalignglobalMatrix::norm(self : BioseqalignglobalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqalignglobalMatrix::to_string(self : BioseqalignglobalMatrix) -> String {
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

pub(all) struct BioseqalignglobalVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_global_make_vector(comps : Array[Double]) -> BioseqalignglobalVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_global_vector_zero(dim : Int) -> BioseqalignglobalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqalignglobalVector::add(self : BioseqalignglobalVector, other : BioseqalignglobalVector) -> BioseqalignglobalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignglobalVector::sub(self : BioseqalignglobalVector, other : BioseqalignglobalVector) -> BioseqalignglobalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignglobalVector::scale(self : BioseqalignglobalVector, s : Double) -> BioseqalignglobalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqalignglobalVector::dot(self : BioseqalignglobalVector, other : BioseqalignglobalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqalignglobalVector::norm(self : BioseqalignglobalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqalignglobalVector::normalize(self : BioseqalignglobalVector) -> BioseqalignglobalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignglobalVector::dist(self : BioseqalignglobalVector, other : BioseqalignglobalVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqalignglobalVector::to_string(self : BioseqalignglobalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_global_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_global_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_global_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_global_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_global_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_global_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_global_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_global_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_global_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_global_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_global_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_global_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_global_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_global_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_global_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_global_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_global_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_global_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_global_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_global_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_global_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_global_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_global_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_global_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_global_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_global_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_global_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_global_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_global_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqalignglobalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_frame_make(size : Int) -> BioseqalignglobalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_frame_len(s : BioseqalignglobalFrame) -> Int { s.size }

pub fn bio_seq_align_global_frame_get(s : BioseqalignglobalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_frame_set(s : BioseqalignglobalFrame, i : Int, v : Double) -> BioseqalignglobalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_frame_sum(s : BioseqalignglobalFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_global_frame_mean(s : BioseqalignglobalFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_global_frame_scale(s : BioseqalignglobalFrame, f : Double) -> BioseqalignglobalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_frame_add(a : BioseqalignglobalFrame, b : BioseqalignglobalFrame) -> BioseqalignglobalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_global_frame_copy(s : BioseqalignglobalFrame) -> BioseqalignglobalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_frame_fill(s : BioseqalignglobalFrame, v : Double) -> BioseqalignglobalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_frame_min(s : BioseqalignglobalFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_global_frame_max(s : BioseqalignglobalFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_global_frame_to_string(s : BioseqalignglobalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_table_make(size : Int) -> BioseqalignglobalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_table_len(s : BioseqalignglobalTable) -> Int { s.size }

pub fn bio_seq_align_global_table_get(s : BioseqalignglobalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_table_set(s : BioseqalignglobalTable, i : Int, v : Double) -> BioseqalignglobalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_table_sum(s : BioseqalignglobalTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_global_table_mean(s : BioseqalignglobalTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_global_table_scale(s : BioseqalignglobalTable, f : Double) -> BioseqalignglobalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_table_add(a : BioseqalignglobalTable, b : BioseqalignglobalTable) -> BioseqalignglobalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_global_table_copy(s : BioseqalignglobalTable) -> BioseqalignglobalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_table_fill(s : BioseqalignglobalTable, v : Double) -> BioseqalignglobalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_table_min(s : BioseqalignglobalTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_global_table_max(s : BioseqalignglobalTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_global_table_to_string(s : BioseqalignglobalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_graphn_make(size : Int) -> BioseqalignglobalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_graphn_len(s : BioseqalignglobalGraphN) -> Int { s.size }

pub fn bio_seq_align_global_graphn_get(s : BioseqalignglobalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_graphn_set(s : BioseqalignglobalGraphN, i : Int, v : Double) -> BioseqalignglobalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_graphn_sum(s : BioseqalignglobalGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_global_graphn_mean(s : BioseqalignglobalGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_global_graphn_scale(s : BioseqalignglobalGraphN, f : Double) -> BioseqalignglobalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_graphn_add(a : BioseqalignglobalGraphN, b : BioseqalignglobalGraphN) -> BioseqalignglobalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_global_graphn_copy(s : BioseqalignglobalGraphN) -> BioseqalignglobalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_graphn_fill(s : BioseqalignglobalGraphN, v : Double) -> BioseqalignglobalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_graphn_min(s : BioseqalignglobalGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_global_graphn_max(s : BioseqalignglobalGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_global_graphn_to_string(s : BioseqalignglobalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_node_make(size : Int) -> BioseqalignglobalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_node_len(s : BioseqalignglobalNode) -> Int { s.size }

pub fn bio_seq_align_global_node_get(s : BioseqalignglobalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_node_set(s : BioseqalignglobalNode, i : Int, v : Double) -> BioseqalignglobalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_node_sum(s : BioseqalignglobalNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_global_node_mean(s : BioseqalignglobalNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_global_node_scale(s : BioseqalignglobalNode, f : Double) -> BioseqalignglobalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_node_add(a : BioseqalignglobalNode, b : BioseqalignglobalNode) -> BioseqalignglobalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_global_node_copy(s : BioseqalignglobalNode) -> BioseqalignglobalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_node_fill(s : BioseqalignglobalNode, v : Double) -> BioseqalignglobalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_node_min(s : BioseqalignglobalNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_global_node_max(s : BioseqalignglobalNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_global_node_to_string(s : BioseqalignglobalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_edge_make(size : Int) -> BioseqalignglobalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_edge_len(s : BioseqalignglobalEdge) -> Int { s.size }

pub fn bio_seq_align_global_edge_get(s : BioseqalignglobalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_edge_set(s : BioseqalignglobalEdge, i : Int, v : Double) -> BioseqalignglobalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_edge_sum(s : BioseqalignglobalEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_global_edge_mean(s : BioseqalignglobalEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_global_edge_scale(s : BioseqalignglobalEdge, f : Double) -> BioseqalignglobalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_edge_add(a : BioseqalignglobalEdge, b : BioseqalignglobalEdge) -> BioseqalignglobalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_global_edge_copy(s : BioseqalignglobalEdge) -> BioseqalignglobalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_edge_fill(s : BioseqalignglobalEdge, v : Double) -> BioseqalignglobalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_edge_min(s : BioseqalignglobalEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_global_edge_max(s : BioseqalignglobalEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_global_edge_to_string(s : BioseqalignglobalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_path_make(size : Int) -> BioseqalignglobalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_path_len(s : BioseqalignglobalPath) -> Int { s.size }

pub fn bio_seq_align_global_path_get(s : BioseqalignglobalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_path_set(s : BioseqalignglobalPath, i : Int, v : Double) -> BioseqalignglobalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_path_sum(s : BioseqalignglobalPath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_global_path_mean(s : BioseqalignglobalPath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_global_path_scale(s : BioseqalignglobalPath, f : Double) -> BioseqalignglobalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_path_add(a : BioseqalignglobalPath, b : BioseqalignglobalPath) -> BioseqalignglobalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_global_path_copy(s : BioseqalignglobalPath) -> BioseqalignglobalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_path_fill(s : BioseqalignglobalPath, v : Double) -> BioseqalignglobalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_path_min(s : BioseqalignglobalPath) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_global_path_max(s : BioseqalignglobalPath) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_global_path_to_string(s : BioseqalignglobalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_cluster_make(size : Int) -> BioseqalignglobalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_cluster_len(s : BioseqalignglobalCluster) -> Int { s.size }

pub fn bio_seq_align_global_cluster_get(s : BioseqalignglobalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_cluster_set(s : BioseqalignglobalCluster, i : Int, v : Double) -> BioseqalignglobalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_cluster_sum(s : BioseqalignglobalCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_global_cluster_mean(s : BioseqalignglobalCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_global_cluster_scale(s : BioseqalignglobalCluster, f : Double) -> BioseqalignglobalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_cluster_add(a : BioseqalignglobalCluster, b : BioseqalignglobalCluster) -> BioseqalignglobalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_global_cluster_copy(s : BioseqalignglobalCluster) -> BioseqalignglobalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_cluster_fill(s : BioseqalignglobalCluster, v : Double) -> BioseqalignglobalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_cluster_min(s : BioseqalignglobalCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_global_cluster_max(s : BioseqalignglobalCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_global_cluster_to_string(s : BioseqalignglobalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_model_make(size : Int) -> BioseqalignglobalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_model_len(s : BioseqalignglobalModel) -> Int { s.size }

pub fn bio_seq_align_global_model_get(s : BioseqalignglobalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_model_set(s : BioseqalignglobalModel, i : Int, v : Double) -> BioseqalignglobalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_model_sum(s : BioseqalignglobalModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_global_model_mean(s : BioseqalignglobalModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_global_model_scale(s : BioseqalignglobalModel, f : Double) -> BioseqalignglobalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_model_add(a : BioseqalignglobalModel, b : BioseqalignglobalModel) -> BioseqalignglobalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_global_model_copy(s : BioseqalignglobalModel) -> BioseqalignglobalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_model_fill(s : BioseqalignglobalModel, v : Double) -> BioseqalignglobalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_model_min(s : BioseqalignglobalModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_global_model_max(s : BioseqalignglobalModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_global_model_to_string(s : BioseqalignglobalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_layer_make(size : Int) -> BioseqalignglobalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_layer_len(s : BioseqalignglobalLayer) -> Int { s.size }

pub fn bio_seq_align_global_layer_get(s : BioseqalignglobalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_layer_set(s : BioseqalignglobalLayer, i : Int, v : Double) -> BioseqalignglobalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_layer_sum(s : BioseqalignglobalLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_global_layer_mean(s : BioseqalignglobalLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_global_layer_scale(s : BioseqalignglobalLayer, f : Double) -> BioseqalignglobalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_layer_add(a : BioseqalignglobalLayer, b : BioseqalignglobalLayer) -> BioseqalignglobalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_global_layer_copy(s : BioseqalignglobalLayer) -> BioseqalignglobalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_layer_fill(s : BioseqalignglobalLayer, v : Double) -> BioseqalignglobalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_layer_min(s : BioseqalignglobalLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_global_layer_max(s : BioseqalignglobalLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_global_layer_to_string(s : BioseqalignglobalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_buffer_make(size : Int) -> BioseqalignglobalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_buffer_len(s : BioseqalignglobalBuffer) -> Int { s.size }

pub fn bio_seq_align_global_buffer_get(s : BioseqalignglobalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_buffer_set(s : BioseqalignglobalBuffer, i : Int, v : Double) -> BioseqalignglobalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_buffer_sum(s : BioseqalignglobalBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_global_buffer_mean(s : BioseqalignglobalBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_global_buffer_scale(s : BioseqalignglobalBuffer, f : Double) -> BioseqalignglobalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_buffer_add(a : BioseqalignglobalBuffer, b : BioseqalignglobalBuffer) -> BioseqalignglobalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_global_buffer_copy(s : BioseqalignglobalBuffer) -> BioseqalignglobalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_buffer_fill(s : BioseqalignglobalBuffer, v : Double) -> BioseqalignglobalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_buffer_min(s : BioseqalignglobalBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_global_buffer_max(s : BioseqalignglobalBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_global_buffer_to_string(s : BioseqalignglobalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_cursor_make(size : Int) -> BioseqalignglobalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_cursor_len(s : BioseqalignglobalCursor) -> Int { s.size }

pub fn bio_seq_align_global_cursor_get(s : BioseqalignglobalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_cursor_set(s : BioseqalignglobalCursor, i : Int, v : Double) -> BioseqalignglobalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_cursor_sum(s : BioseqalignglobalCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_global_cursor_mean(s : BioseqalignglobalCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_global_cursor_scale(s : BioseqalignglobalCursor, f : Double) -> BioseqalignglobalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_cursor_add(a : BioseqalignglobalCursor, b : BioseqalignglobalCursor) -> BioseqalignglobalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_global_cursor_copy(s : BioseqalignglobalCursor) -> BioseqalignglobalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_cursor_fill(s : BioseqalignglobalCursor, v : Double) -> BioseqalignglobalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_cursor_min(s : BioseqalignglobalCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_global_cursor_max(s : BioseqalignglobalCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_global_cursor_to_string(s : BioseqalignglobalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_view_make(size : Int) -> BioseqalignglobalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_view_len(s : BioseqalignglobalView) -> Int { s.size }

pub fn bio_seq_align_global_view_get(s : BioseqalignglobalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_view_set(s : BioseqalignglobalView, i : Int, v : Double) -> BioseqalignglobalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_view_sum(s : BioseqalignglobalView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_global_view_mean(s : BioseqalignglobalView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_global_view_scale(s : BioseqalignglobalView, f : Double) -> BioseqalignglobalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_view_add(a : BioseqalignglobalView, b : BioseqalignglobalView) -> BioseqalignglobalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_global_view_copy(s : BioseqalignglobalView) -> BioseqalignglobalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_view_fill(s : BioseqalignglobalView, v : Double) -> BioseqalignglobalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_view_min(s : BioseqalignglobalView) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_global_view_max(s : BioseqalignglobalView) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_global_view_to_string(s : BioseqalignglobalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_range_make(size : Int) -> BioseqalignglobalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_range_len(s : BioseqalignglobalRange) -> Int { s.size }

pub fn bio_seq_align_global_range_get(s : BioseqalignglobalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_range_set(s : BioseqalignglobalRange, i : Int, v : Double) -> BioseqalignglobalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_range_sum(s : BioseqalignglobalRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_global_range_mean(s : BioseqalignglobalRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_global_range_scale(s : BioseqalignglobalRange, f : Double) -> BioseqalignglobalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_range_add(a : BioseqalignglobalRange, b : BioseqalignglobalRange) -> BioseqalignglobalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_global_range_copy(s : BioseqalignglobalRange) -> BioseqalignglobalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_range_fill(s : BioseqalignglobalRange, v : Double) -> BioseqalignglobalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_range_min(s : BioseqalignglobalRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_global_range_max(s : BioseqalignglobalRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_global_range_to_string(s : BioseqalignglobalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_slice_make(size : Int) -> BioseqalignglobalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_slice_len(s : BioseqalignglobalSlice) -> Int { s.size }

pub fn bio_seq_align_global_slice_get(s : BioseqalignglobalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_slice_set(s : BioseqalignglobalSlice, i : Int, v : Double) -> BioseqalignglobalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_slice_sum(s : BioseqalignglobalSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_global_slice_mean(s : BioseqalignglobalSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_global_slice_scale(s : BioseqalignglobalSlice, f : Double) -> BioseqalignglobalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_slice_add(a : BioseqalignglobalSlice, b : BioseqalignglobalSlice) -> BioseqalignglobalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_global_slice_copy(s : BioseqalignglobalSlice) -> BioseqalignglobalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_slice_fill(s : BioseqalignglobalSlice, v : Double) -> BioseqalignglobalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_global_slice_min(s : BioseqalignglobalSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_global_slice_max(s : BioseqalignglobalSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_global_slice_to_string(s : BioseqalignglobalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

