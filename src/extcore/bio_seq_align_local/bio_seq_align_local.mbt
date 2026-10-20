///===
/// extcore/bio_seq_align_local

pub(all) struct BioseqalignlocalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_local_make_point(x : Double, y : Double) -> BioseqalignlocalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_local_make_point3(x : Double, y : Double, z : Double) -> BioseqalignlocalPoint {
  { x, y, z, label: 0 }
}

pub fn BioseqalignlocalPoint::x(self : BioseqalignlocalPoint) -> Double { self.x }

pub fn BioseqalignlocalPoint::y(self : BioseqalignlocalPoint) -> Double { self.y }

pub fn BioseqalignlocalPoint::z(self : BioseqalignlocalPoint) -> Double { self.z }

pub fn BioseqalignlocalPoint::label(self : BioseqalignlocalPoint) -> Int { self.label }

pub fn BioseqalignlocalPoint::dist(self : BioseqalignlocalPoint, other : BioseqalignlocalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqalignlocalPoint::add(self : BioseqalignlocalPoint, other : BioseqalignlocalPoint) -> BioseqalignlocalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqalignlocalPoint::sub(self : BioseqalignlocalPoint, other : BioseqalignlocalPoint) -> BioseqalignlocalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqalignlocalPoint::scale(self : BioseqalignlocalPoint, s : Double) -> BioseqalignlocalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqalignlocalPoint::dot(self : BioseqalignlocalPoint, other : BioseqalignlocalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqalignlocalPoint::cross(self : BioseqalignlocalPoint, other : BioseqalignlocalPoint) -> BioseqalignlocalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqalignlocalPoint::norm(self : BioseqalignlocalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqalignlocalPoint::normalize(self : BioseqalignlocalPoint) -> BioseqalignlocalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignlocalPoint::negate(self : BioseqalignlocalPoint) -> BioseqalignlocalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqalignlocalPoint::mid(self : BioseqalignlocalPoint, other : BioseqalignlocalPoint) -> BioseqalignlocalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqalignlocalPoint::lerp(self : BioseqalignlocalPoint, other : BioseqalignlocalPoint, t : Double) -> BioseqalignlocalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqalignlocalPoint::to_string(self : BioseqalignlocalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqalignlocalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_local_make_series(vals : Array[Double], name : String) -> BioseqalignlocalSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqalignlocalSeries::len(self : BioseqalignlocalSeries) -> Int { self.vals.length() }

pub fn BioseqalignlocalSeries::sum(self : BioseqalignlocalSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqalignlocalSeries::mean(self : BioseqalignlocalSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqalignlocalSeries::min(self : BioseqalignlocalSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqalignlocalSeries::max(self : BioseqalignlocalSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqalignlocalSeries::range(self : BioseqalignlocalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqalignlocalSeries::variance(self : BioseqalignlocalSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqalignlocalSeries::std(self : BioseqalignlocalSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqalignlocalSeries::median(self : BioseqalignlocalSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqalignlocalSeries::scale(self : BioseqalignlocalSeries, f : Double) -> BioseqalignlocalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqalignlocalSeries::add(self : BioseqalignlocalSeries, other : BioseqalignlocalSeries) -> BioseqalignlocalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqalignlocalSeries::sub(self : BioseqalignlocalSeries, other : BioseqalignlocalSeries) -> BioseqalignlocalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqalignlocalSeries::normalize(self : BioseqalignlocalSeries) -> BioseqalignlocalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqalignlocalSeries::cumsum(self : BioseqalignlocalSeries) -> BioseqalignlocalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqalignlocalSeries::to_string(self : BioseqalignlocalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignlocalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_local_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignlocalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_local_matrix_identity(n : Int) -> BioseqalignlocalMatrix {
  let m = bio_seq_align_local_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqalignlocalMatrix::get(self : BioseqalignlocalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqalignlocalMatrix::transpose(self : BioseqalignlocalMatrix) -> BioseqalignlocalMatrix {
  let result = bio_seq_align_local_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqalignlocalMatrix::add(self : BioseqalignlocalMatrix, other : BioseqalignlocalMatrix) -> BioseqalignlocalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_align_local_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqalignlocalMatrix::scale(self : BioseqalignlocalMatrix, s : Double) -> BioseqalignlocalMatrix {
  let result = bio_seq_align_local_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqalignlocalMatrix::multiply(self : BioseqalignlocalMatrix, other : BioseqalignlocalMatrix) -> BioseqalignlocalMatrix {
  if self.cols != other.rows { return bio_seq_align_local_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_align_local_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqalignlocalMatrix::trace(self : BioseqalignlocalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqalignlocalMatrix::det(self : BioseqalignlocalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqalignlocalMatrix::norm(self : BioseqalignlocalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqalignlocalMatrix::to_string(self : BioseqalignlocalMatrix) -> String {
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

pub(all) struct BioseqalignlocalVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_local_make_vector(comps : Array[Double]) -> BioseqalignlocalVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_local_vector_zero(dim : Int) -> BioseqalignlocalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqalignlocalVector::add(self : BioseqalignlocalVector, other : BioseqalignlocalVector) -> BioseqalignlocalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignlocalVector::sub(self : BioseqalignlocalVector, other : BioseqalignlocalVector) -> BioseqalignlocalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqalignlocalVector::scale(self : BioseqalignlocalVector, s : Double) -> BioseqalignlocalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqalignlocalVector::dot(self : BioseqalignlocalVector, other : BioseqalignlocalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqalignlocalVector::norm(self : BioseqalignlocalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqalignlocalVector::normalize(self : BioseqalignlocalVector) -> BioseqalignlocalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqalignlocalVector::dist(self : BioseqalignlocalVector, other : BioseqalignlocalVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqalignlocalVector::to_string(self : BioseqalignlocalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_local_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_local_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_local_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_local_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_local_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_local_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_local_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_local_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_local_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_local_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_local_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_local_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_local_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_local_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_local_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_local_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_local_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_local_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_local_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_local_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_local_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_local_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_local_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_local_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_local_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_local_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_local_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_local_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_local_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqalignlocalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_frame_make(size : Int) -> BioseqalignlocalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_frame_len(s : BioseqalignlocalFrame) -> Int { s.size }

pub fn bio_seq_align_local_frame_get(s : BioseqalignlocalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_frame_set(s : BioseqalignlocalFrame, i : Int, v : Double) -> BioseqalignlocalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_frame_sum(s : BioseqalignlocalFrame) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_frame_mean(s : BioseqalignlocalFrame) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_frame_scale(s : BioseqalignlocalFrame, f : Double) -> BioseqalignlocalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_frame_add(a : BioseqalignlocalFrame, b : BioseqalignlocalFrame) -> BioseqalignlocalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_frame_copy(s : BioseqalignlocalFrame) -> BioseqalignlocalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_frame_fill(s : BioseqalignlocalFrame, v : Double) -> BioseqalignlocalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_frame_min(s : BioseqalignlocalFrame) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_frame_max(s : BioseqalignlocalFrame) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_frame_to_string(s : BioseqalignlocalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_table_make(size : Int) -> BioseqalignlocalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_table_len(s : BioseqalignlocalTable) -> Int { s.size }

pub fn bio_seq_align_local_table_get(s : BioseqalignlocalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_table_set(s : BioseqalignlocalTable, i : Int, v : Double) -> BioseqalignlocalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_table_sum(s : BioseqalignlocalTable) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_table_mean(s : BioseqalignlocalTable) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_table_scale(s : BioseqalignlocalTable, f : Double) -> BioseqalignlocalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_table_add(a : BioseqalignlocalTable, b : BioseqalignlocalTable) -> BioseqalignlocalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_table_copy(s : BioseqalignlocalTable) -> BioseqalignlocalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_table_fill(s : BioseqalignlocalTable, v : Double) -> BioseqalignlocalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_table_min(s : BioseqalignlocalTable) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_table_max(s : BioseqalignlocalTable) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_table_to_string(s : BioseqalignlocalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_graphn_make(size : Int) -> BioseqalignlocalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_graphn_len(s : BioseqalignlocalGraphN) -> Int { s.size }

pub fn bio_seq_align_local_graphn_get(s : BioseqalignlocalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_graphn_set(s : BioseqalignlocalGraphN, i : Int, v : Double) -> BioseqalignlocalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_graphn_sum(s : BioseqalignlocalGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_graphn_mean(s : BioseqalignlocalGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_graphn_scale(s : BioseqalignlocalGraphN, f : Double) -> BioseqalignlocalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_graphn_add(a : BioseqalignlocalGraphN, b : BioseqalignlocalGraphN) -> BioseqalignlocalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_graphn_copy(s : BioseqalignlocalGraphN) -> BioseqalignlocalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_graphn_fill(s : BioseqalignlocalGraphN, v : Double) -> BioseqalignlocalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_graphn_min(s : BioseqalignlocalGraphN) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_graphn_max(s : BioseqalignlocalGraphN) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_graphn_to_string(s : BioseqalignlocalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_node_make(size : Int) -> BioseqalignlocalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_node_len(s : BioseqalignlocalNode) -> Int { s.size }

pub fn bio_seq_align_local_node_get(s : BioseqalignlocalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_node_set(s : BioseqalignlocalNode, i : Int, v : Double) -> BioseqalignlocalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_node_sum(s : BioseqalignlocalNode) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_node_mean(s : BioseqalignlocalNode) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_node_scale(s : BioseqalignlocalNode, f : Double) -> BioseqalignlocalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_node_add(a : BioseqalignlocalNode, b : BioseqalignlocalNode) -> BioseqalignlocalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_node_copy(s : BioseqalignlocalNode) -> BioseqalignlocalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_node_fill(s : BioseqalignlocalNode, v : Double) -> BioseqalignlocalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_node_min(s : BioseqalignlocalNode) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_node_max(s : BioseqalignlocalNode) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_node_to_string(s : BioseqalignlocalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_edge_make(size : Int) -> BioseqalignlocalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_edge_len(s : BioseqalignlocalEdge) -> Int { s.size }

pub fn bio_seq_align_local_edge_get(s : BioseqalignlocalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_edge_set(s : BioseqalignlocalEdge, i : Int, v : Double) -> BioseqalignlocalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_edge_sum(s : BioseqalignlocalEdge) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_edge_mean(s : BioseqalignlocalEdge) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_edge_scale(s : BioseqalignlocalEdge, f : Double) -> BioseqalignlocalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_edge_add(a : BioseqalignlocalEdge, b : BioseqalignlocalEdge) -> BioseqalignlocalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_edge_copy(s : BioseqalignlocalEdge) -> BioseqalignlocalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_edge_fill(s : BioseqalignlocalEdge, v : Double) -> BioseqalignlocalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_edge_min(s : BioseqalignlocalEdge) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_edge_max(s : BioseqalignlocalEdge) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_edge_to_string(s : BioseqalignlocalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_path_make(size : Int) -> BioseqalignlocalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_path_len(s : BioseqalignlocalPath) -> Int { s.size }

pub fn bio_seq_align_local_path_get(s : BioseqalignlocalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_path_set(s : BioseqalignlocalPath, i : Int, v : Double) -> BioseqalignlocalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_path_sum(s : BioseqalignlocalPath) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_path_mean(s : BioseqalignlocalPath) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_path_scale(s : BioseqalignlocalPath, f : Double) -> BioseqalignlocalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_path_add(a : BioseqalignlocalPath, b : BioseqalignlocalPath) -> BioseqalignlocalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_path_copy(s : BioseqalignlocalPath) -> BioseqalignlocalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_path_fill(s : BioseqalignlocalPath, v : Double) -> BioseqalignlocalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_path_min(s : BioseqalignlocalPath) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_path_max(s : BioseqalignlocalPath) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_path_to_string(s : BioseqalignlocalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_cluster_make(size : Int) -> BioseqalignlocalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_cluster_len(s : BioseqalignlocalCluster) -> Int { s.size }

pub fn bio_seq_align_local_cluster_get(s : BioseqalignlocalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_cluster_set(s : BioseqalignlocalCluster, i : Int, v : Double) -> BioseqalignlocalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cluster_sum(s : BioseqalignlocalCluster) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_cluster_mean(s : BioseqalignlocalCluster) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_cluster_scale(s : BioseqalignlocalCluster, f : Double) -> BioseqalignlocalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cluster_add(a : BioseqalignlocalCluster, b : BioseqalignlocalCluster) -> BioseqalignlocalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_cluster_copy(s : BioseqalignlocalCluster) -> BioseqalignlocalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cluster_fill(s : BioseqalignlocalCluster, v : Double) -> BioseqalignlocalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cluster_min(s : BioseqalignlocalCluster) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_cluster_max(s : BioseqalignlocalCluster) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_cluster_to_string(s : BioseqalignlocalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_model_make(size : Int) -> BioseqalignlocalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_model_len(s : BioseqalignlocalModel) -> Int { s.size }

pub fn bio_seq_align_local_model_get(s : BioseqalignlocalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_model_set(s : BioseqalignlocalModel, i : Int, v : Double) -> BioseqalignlocalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_model_sum(s : BioseqalignlocalModel) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_model_mean(s : BioseqalignlocalModel) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_model_scale(s : BioseqalignlocalModel, f : Double) -> BioseqalignlocalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_model_add(a : BioseqalignlocalModel, b : BioseqalignlocalModel) -> BioseqalignlocalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_model_copy(s : BioseqalignlocalModel) -> BioseqalignlocalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_model_fill(s : BioseqalignlocalModel, v : Double) -> BioseqalignlocalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_model_min(s : BioseqalignlocalModel) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_model_max(s : BioseqalignlocalModel) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_model_to_string(s : BioseqalignlocalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_layer_make(size : Int) -> BioseqalignlocalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_layer_len(s : BioseqalignlocalLayer) -> Int { s.size }

pub fn bio_seq_align_local_layer_get(s : BioseqalignlocalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_layer_set(s : BioseqalignlocalLayer, i : Int, v : Double) -> BioseqalignlocalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_layer_sum(s : BioseqalignlocalLayer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_layer_mean(s : BioseqalignlocalLayer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_layer_scale(s : BioseqalignlocalLayer, f : Double) -> BioseqalignlocalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_layer_add(a : BioseqalignlocalLayer, b : BioseqalignlocalLayer) -> BioseqalignlocalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_layer_copy(s : BioseqalignlocalLayer) -> BioseqalignlocalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_layer_fill(s : BioseqalignlocalLayer, v : Double) -> BioseqalignlocalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_layer_min(s : BioseqalignlocalLayer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_layer_max(s : BioseqalignlocalLayer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_layer_to_string(s : BioseqalignlocalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_buffer_make(size : Int) -> BioseqalignlocalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_buffer_len(s : BioseqalignlocalBuffer) -> Int { s.size }

pub fn bio_seq_align_local_buffer_get(s : BioseqalignlocalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_buffer_set(s : BioseqalignlocalBuffer, i : Int, v : Double) -> BioseqalignlocalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_buffer_sum(s : BioseqalignlocalBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_buffer_mean(s : BioseqalignlocalBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_buffer_scale(s : BioseqalignlocalBuffer, f : Double) -> BioseqalignlocalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_buffer_add(a : BioseqalignlocalBuffer, b : BioseqalignlocalBuffer) -> BioseqalignlocalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_buffer_copy(s : BioseqalignlocalBuffer) -> BioseqalignlocalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_buffer_fill(s : BioseqalignlocalBuffer, v : Double) -> BioseqalignlocalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_buffer_min(s : BioseqalignlocalBuffer) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_buffer_max(s : BioseqalignlocalBuffer) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_buffer_to_string(s : BioseqalignlocalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_cursor_make(size : Int) -> BioseqalignlocalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_cursor_len(s : BioseqalignlocalCursor) -> Int { s.size }

pub fn bio_seq_align_local_cursor_get(s : BioseqalignlocalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_cursor_set(s : BioseqalignlocalCursor, i : Int, v : Double) -> BioseqalignlocalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cursor_sum(s : BioseqalignlocalCursor) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_cursor_mean(s : BioseqalignlocalCursor) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_cursor_scale(s : BioseqalignlocalCursor, f : Double) -> BioseqalignlocalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cursor_add(a : BioseqalignlocalCursor, b : BioseqalignlocalCursor) -> BioseqalignlocalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_cursor_copy(s : BioseqalignlocalCursor) -> BioseqalignlocalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cursor_fill(s : BioseqalignlocalCursor, v : Double) -> BioseqalignlocalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_cursor_min(s : BioseqalignlocalCursor) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_cursor_max(s : BioseqalignlocalCursor) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_cursor_to_string(s : BioseqalignlocalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_view_make(size : Int) -> BioseqalignlocalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_view_len(s : BioseqalignlocalView) -> Int { s.size }

pub fn bio_seq_align_local_view_get(s : BioseqalignlocalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_view_set(s : BioseqalignlocalView, i : Int, v : Double) -> BioseqalignlocalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_view_sum(s : BioseqalignlocalView) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_view_mean(s : BioseqalignlocalView) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_view_scale(s : BioseqalignlocalView, f : Double) -> BioseqalignlocalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_view_add(a : BioseqalignlocalView, b : BioseqalignlocalView) -> BioseqalignlocalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_view_copy(s : BioseqalignlocalView) -> BioseqalignlocalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_view_fill(s : BioseqalignlocalView, v : Double) -> BioseqalignlocalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_view_min(s : BioseqalignlocalView) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_view_max(s : BioseqalignlocalView) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_view_to_string(s : BioseqalignlocalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_range_make(size : Int) -> BioseqalignlocalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_range_len(s : BioseqalignlocalRange) -> Int { s.size }

pub fn bio_seq_align_local_range_get(s : BioseqalignlocalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_range_set(s : BioseqalignlocalRange, i : Int, v : Double) -> BioseqalignlocalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_range_sum(s : BioseqalignlocalRange) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_range_mean(s : BioseqalignlocalRange) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_range_scale(s : BioseqalignlocalRange, f : Double) -> BioseqalignlocalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_range_add(a : BioseqalignlocalRange, b : BioseqalignlocalRange) -> BioseqalignlocalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_range_copy(s : BioseqalignlocalRange) -> BioseqalignlocalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_range_fill(s : BioseqalignlocalRange, v : Double) -> BioseqalignlocalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_range_min(s : BioseqalignlocalRange) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_range_max(s : BioseqalignlocalRange) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_range_to_string(s : BioseqalignlocalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignlocalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_local_slice_make(size : Int) -> BioseqalignlocalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_local_slice_len(s : BioseqalignlocalSlice) -> Int { s.size }

pub fn bio_seq_align_local_slice_get(s : BioseqalignlocalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_local_slice_set(s : BioseqalignlocalSlice, i : Int, v : Double) -> BioseqalignlocalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_slice_sum(s : BioseqalignlocalSlice) -> Double { @_common.sum(s.data) }

pub fn bio_seq_align_local_slice_mean(s : BioseqalignlocalSlice) -> Double { @_common.mean(s.data) }

pub fn bio_seq_align_local_slice_scale(s : BioseqalignlocalSlice, f : Double) -> BioseqalignlocalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_slice_add(a : BioseqalignlocalSlice, b : BioseqalignlocalSlice) -> BioseqalignlocalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_seq_align_local_slice_copy(s : BioseqalignlocalSlice) -> BioseqalignlocalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_slice_fill(s : BioseqalignlocalSlice, v : Double) -> BioseqalignlocalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_seq_align_local_slice_min(s : BioseqalignlocalSlice) -> Double { @_common.min(s.data) }

pub fn bio_seq_align_local_slice_max(s : BioseqalignlocalSlice) -> Double { @_common.max(s.data) }

pub fn bio_seq_align_local_slice_to_string(s : BioseqalignlocalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

