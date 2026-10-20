///===
/// extcore/bio_seq_align_iterative

pub(all) struct BioseqaligniterativePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_iterative_make_point(x : Double, y : Double) -> BioseqaligniterativePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_iterative_make_point3(x : Double, y : Double, z : Double) -> BioseqaligniterativePoint {
  { x, y, z, label: 0 }
}

pub fn BioseqaligniterativePoint::x(self : BioseqaligniterativePoint) -> Double { self.x }

pub fn BioseqaligniterativePoint::y(self : BioseqaligniterativePoint) -> Double { self.y }

pub fn BioseqaligniterativePoint::z(self : BioseqaligniterativePoint) -> Double { self.z }

pub fn BioseqaligniterativePoint::label(self : BioseqaligniterativePoint) -> Int { self.label }

pub fn BioseqaligniterativePoint::dist(self : BioseqaligniterativePoint, other : BioseqaligniterativePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BioseqaligniterativePoint::add(self : BioseqaligniterativePoint, other : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BioseqaligniterativePoint::sub(self : BioseqaligniterativePoint, other : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BioseqaligniterativePoint::scale(self : BioseqaligniterativePoint, s : Double) -> BioseqaligniterativePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BioseqaligniterativePoint::dot(self : BioseqaligniterativePoint, other : BioseqaligniterativePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BioseqaligniterativePoint::cross(self : BioseqaligniterativePoint, other : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BioseqaligniterativePoint::norm(self : BioseqaligniterativePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BioseqaligniterativePoint::normalize(self : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqaligniterativePoint::negate(self : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BioseqaligniterativePoint::mid(self : BioseqaligniterativePoint, other : BioseqaligniterativePoint) -> BioseqaligniterativePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BioseqaligniterativePoint::lerp(self : BioseqaligniterativePoint, other : BioseqaligniterativePoint, t : Double) -> BioseqaligniterativePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BioseqaligniterativePoint::to_string(self : BioseqaligniterativePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BioseqaligniterativeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_iterative_make_series(vals : Array[Double], name : String) -> BioseqaligniterativeSeries {
  { vals, name, meta: 0 }
}

pub fn BioseqaligniterativeSeries::len(self : BioseqaligniterativeSeries) -> Int { self.vals.length() }

pub fn BioseqaligniterativeSeries::sum(self : BioseqaligniterativeSeries) -> Double { @_common.sum(self.vals) }

pub fn BioseqaligniterativeSeries::mean(self : BioseqaligniterativeSeries) -> Double { @_common.mean(self.vals) }

pub fn BioseqaligniterativeSeries::min(self : BioseqaligniterativeSeries) -> Double { @_common.min(self.vals) }

pub fn BioseqaligniterativeSeries::max(self : BioseqaligniterativeSeries) -> Double { @_common.max(self.vals) }

pub fn BioseqaligniterativeSeries::range(self : BioseqaligniterativeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BioseqaligniterativeSeries::variance(self : BioseqaligniterativeSeries) -> Double { @_common.variance(self.vals) }

pub fn BioseqaligniterativeSeries::std(self : BioseqaligniterativeSeries) -> Double { @_common.std(self.vals) }

pub fn BioseqaligniterativeSeries::median(self : BioseqaligniterativeSeries) -> Double { @_common.median(self.vals) }

pub fn BioseqaligniterativeSeries::scale(self : BioseqaligniterativeSeries, f : Double) -> BioseqaligniterativeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BioseqaligniterativeSeries::add(self : BioseqaligniterativeSeries, other : BioseqaligniterativeSeries) -> BioseqaligniterativeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BioseqaligniterativeSeries::sub(self : BioseqaligniterativeSeries, other : BioseqaligniterativeSeries) -> BioseqaligniterativeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BioseqaligniterativeSeries::normalize(self : BioseqaligniterativeSeries) -> BioseqaligniterativeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BioseqaligniterativeSeries::cumsum(self : BioseqaligniterativeSeries) -> BioseqaligniterativeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BioseqaligniterativeSeries::to_string(self : BioseqaligniterativeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqaligniterativeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_iterative_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqaligniterativeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_iterative_matrix_identity(n : Int) -> BioseqaligniterativeMatrix {
  let m = bio_seq_align_iterative_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BioseqaligniterativeMatrix::get(self : BioseqaligniterativeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BioseqaligniterativeMatrix::transpose(self : BioseqaligniterativeMatrix) -> BioseqaligniterativeMatrix {
  let result = bio_seq_align_iterative_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BioseqaligniterativeMatrix::add(self : BioseqaligniterativeMatrix, other : BioseqaligniterativeMatrix) -> BioseqaligniterativeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_seq_align_iterative_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BioseqaligniterativeMatrix::scale(self : BioseqaligniterativeMatrix, s : Double) -> BioseqaligniterativeMatrix {
  let result = bio_seq_align_iterative_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BioseqaligniterativeMatrix::multiply(self : BioseqaligniterativeMatrix, other : BioseqaligniterativeMatrix) -> BioseqaligniterativeMatrix {
  if self.cols != other.rows { return bio_seq_align_iterative_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_seq_align_iterative_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BioseqaligniterativeMatrix::trace(self : BioseqaligniterativeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BioseqaligniterativeMatrix::det(self : BioseqaligniterativeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BioseqaligniterativeMatrix::norm(self : BioseqaligniterativeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BioseqaligniterativeMatrix::to_string(self : BioseqaligniterativeMatrix) -> String {
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

pub(all) struct BioseqaligniterativeVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_iterative_make_vector(comps : Array[Double]) -> BioseqaligniterativeVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_iterative_vector_zero(dim : Int) -> BioseqaligniterativeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BioseqaligniterativeVector::add(self : BioseqaligniterativeVector, other : BioseqaligniterativeVector) -> BioseqaligniterativeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqaligniterativeVector::sub(self : BioseqaligniterativeVector, other : BioseqaligniterativeVector) -> BioseqaligniterativeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BioseqaligniterativeVector::scale(self : BioseqaligniterativeVector, s : Double) -> BioseqaligniterativeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BioseqaligniterativeVector::dot(self : BioseqaligniterativeVector, other : BioseqaligniterativeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BioseqaligniterativeVector::norm(self : BioseqaligniterativeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BioseqaligniterativeVector::normalize(self : BioseqaligniterativeVector) -> BioseqaligniterativeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BioseqaligniterativeVector::dist(self : BioseqaligniterativeVector, other : BioseqaligniterativeVector) -> Double {
  self.sub(other).norm()
}

pub fn BioseqaligniterativeVector::to_string(self : BioseqaligniterativeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_iterative_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_seq_align_iterative_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_seq_align_iterative_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_seq_align_iterative_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_seq_align_iterative_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_seq_align_iterative_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_seq_align_iterative_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_seq_align_iterative_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_seq_align_iterative_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_seq_align_iterative_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_seq_align_iterative_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_seq_align_iterative_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_seq_align_iterative_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_seq_align_iterative_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_seq_align_iterative_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_seq_align_iterative_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_seq_align_iterative_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_seq_align_iterative_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_seq_align_iterative_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_seq_align_iterative_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_seq_align_iterative_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_seq_align_iterative_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_seq_align_iterative_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_seq_align_iterative_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_seq_align_iterative_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_seq_align_iterative_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_seq_align_iterative_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_seq_align_iterative_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_seq_align_iterative_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BioseqaligniterativeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_frame_make(size : Int) -> BioseqaligniterativeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqaligniterativeFrame::len(self : BioseqaligniterativeFrame) -> Int { self.size }

pub fn BioseqaligniterativeFrame::get(self : BioseqaligniterativeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqaligniterativeFrame::set(self : BioseqaligniterativeFrame, i : Int, v : Double) -> BioseqaligniterativeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeFrame::sum(self : BioseqaligniterativeFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqaligniterativeFrame::mean(self : BioseqaligniterativeFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqaligniterativeFrame::scale(self : BioseqaligniterativeFrame, f : Double) -> BioseqaligniterativeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeFrame::add(self : BioseqaligniterativeFrame, other : BioseqaligniterativeFrame) -> BioseqaligniterativeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqaligniterativeFrame::copy(self : BioseqaligniterativeFrame) -> BioseqaligniterativeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeFrame::fill(self : BioseqaligniterativeFrame, v : Double) -> BioseqaligniterativeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeFrame::min(self : BioseqaligniterativeFrame) -> Double { @_common.min(self.data) }

pub fn BioseqaligniterativeFrame::max(self : BioseqaligniterativeFrame) -> Double { @_common.max(self.data) }

pub fn BioseqaligniterativeFrame::to_string(self : BioseqaligniterativeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_table_make(size : Int) -> BioseqaligniterativeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqaligniterativeTable::len(self : BioseqaligniterativeTable) -> Int { self.size }

pub fn BioseqaligniterativeTable::get(self : BioseqaligniterativeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqaligniterativeTable::set(self : BioseqaligniterativeTable, i : Int, v : Double) -> BioseqaligniterativeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeTable::sum(self : BioseqaligniterativeTable) -> Double { @_common.sum(self.data) }

pub fn BioseqaligniterativeTable::mean(self : BioseqaligniterativeTable) -> Double { @_common.mean(self.data) }

pub fn BioseqaligniterativeTable::scale(self : BioseqaligniterativeTable, f : Double) -> BioseqaligniterativeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeTable::add(self : BioseqaligniterativeTable, other : BioseqaligniterativeTable) -> BioseqaligniterativeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqaligniterativeTable::copy(self : BioseqaligniterativeTable) -> BioseqaligniterativeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeTable::fill(self : BioseqaligniterativeTable, v : Double) -> BioseqaligniterativeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeTable::min(self : BioseqaligniterativeTable) -> Double { @_common.min(self.data) }

pub fn BioseqaligniterativeTable::max(self : BioseqaligniterativeTable) -> Double { @_common.max(self.data) }

pub fn BioseqaligniterativeTable::to_string(self : BioseqaligniterativeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_graphn_make(size : Int) -> BioseqaligniterativeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqaligniterativeGraphN::len(self : BioseqaligniterativeGraphN) -> Int { self.size }

pub fn BioseqaligniterativeGraphN::get(self : BioseqaligniterativeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqaligniterativeGraphN::set(self : BioseqaligniterativeGraphN, i : Int, v : Double) -> BioseqaligniterativeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeGraphN::sum(self : BioseqaligniterativeGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqaligniterativeGraphN::mean(self : BioseqaligniterativeGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqaligniterativeGraphN::scale(self : BioseqaligniterativeGraphN, f : Double) -> BioseqaligniterativeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeGraphN::add(self : BioseqaligniterativeGraphN, other : BioseqaligniterativeGraphN) -> BioseqaligniterativeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqaligniterativeGraphN::copy(self : BioseqaligniterativeGraphN) -> BioseqaligniterativeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeGraphN::fill(self : BioseqaligniterativeGraphN, v : Double) -> BioseqaligniterativeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeGraphN::min(self : BioseqaligniterativeGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqaligniterativeGraphN::max(self : BioseqaligniterativeGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqaligniterativeGraphN::to_string(self : BioseqaligniterativeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_node_make(size : Int) -> BioseqaligniterativeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqaligniterativeNode::len(self : BioseqaligniterativeNode) -> Int { self.size }

pub fn BioseqaligniterativeNode::get(self : BioseqaligniterativeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqaligniterativeNode::set(self : BioseqaligniterativeNode, i : Int, v : Double) -> BioseqaligniterativeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeNode::sum(self : BioseqaligniterativeNode) -> Double { @_common.sum(self.data) }

pub fn BioseqaligniterativeNode::mean(self : BioseqaligniterativeNode) -> Double { @_common.mean(self.data) }

pub fn BioseqaligniterativeNode::scale(self : BioseqaligniterativeNode, f : Double) -> BioseqaligniterativeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeNode::add(self : BioseqaligniterativeNode, other : BioseqaligniterativeNode) -> BioseqaligniterativeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqaligniterativeNode::copy(self : BioseqaligniterativeNode) -> BioseqaligniterativeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeNode::fill(self : BioseqaligniterativeNode, v : Double) -> BioseqaligniterativeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeNode::min(self : BioseqaligniterativeNode) -> Double { @_common.min(self.data) }

pub fn BioseqaligniterativeNode::max(self : BioseqaligniterativeNode) -> Double { @_common.max(self.data) }

pub fn BioseqaligniterativeNode::to_string(self : BioseqaligniterativeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_edge_make(size : Int) -> BioseqaligniterativeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqaligniterativeEdge::len(self : BioseqaligniterativeEdge) -> Int { self.size }

pub fn BioseqaligniterativeEdge::get(self : BioseqaligniterativeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqaligniterativeEdge::set(self : BioseqaligniterativeEdge, i : Int, v : Double) -> BioseqaligniterativeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeEdge::sum(self : BioseqaligniterativeEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqaligniterativeEdge::mean(self : BioseqaligniterativeEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqaligniterativeEdge::scale(self : BioseqaligniterativeEdge, f : Double) -> BioseqaligniterativeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeEdge::add(self : BioseqaligniterativeEdge, other : BioseqaligniterativeEdge) -> BioseqaligniterativeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqaligniterativeEdge::copy(self : BioseqaligniterativeEdge) -> BioseqaligniterativeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeEdge::fill(self : BioseqaligniterativeEdge, v : Double) -> BioseqaligniterativeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeEdge::min(self : BioseqaligniterativeEdge) -> Double { @_common.min(self.data) }

pub fn BioseqaligniterativeEdge::max(self : BioseqaligniterativeEdge) -> Double { @_common.max(self.data) }

pub fn BioseqaligniterativeEdge::to_string(self : BioseqaligniterativeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_path_make(size : Int) -> BioseqaligniterativePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqaligniterativePath::len(self : BioseqaligniterativePath) -> Int { self.size }

pub fn BioseqaligniterativePath::get(self : BioseqaligniterativePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqaligniterativePath::set(self : BioseqaligniterativePath, i : Int, v : Double) -> BioseqaligniterativePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativePath::sum(self : BioseqaligniterativePath) -> Double { @_common.sum(self.data) }

pub fn BioseqaligniterativePath::mean(self : BioseqaligniterativePath) -> Double { @_common.mean(self.data) }

pub fn BioseqaligniterativePath::scale(self : BioseqaligniterativePath, f : Double) -> BioseqaligniterativePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativePath::add(self : BioseqaligniterativePath, other : BioseqaligniterativePath) -> BioseqaligniterativePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqaligniterativePath::copy(self : BioseqaligniterativePath) -> BioseqaligniterativePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativePath::fill(self : BioseqaligniterativePath, v : Double) -> BioseqaligniterativePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativePath::min(self : BioseqaligniterativePath) -> Double { @_common.min(self.data) }

pub fn BioseqaligniterativePath::max(self : BioseqaligniterativePath) -> Double { @_common.max(self.data) }

pub fn BioseqaligniterativePath::to_string(self : BioseqaligniterativePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_cluster_make(size : Int) -> BioseqaligniterativeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqaligniterativeCluster::len(self : BioseqaligniterativeCluster) -> Int { self.size }

pub fn BioseqaligniterativeCluster::get(self : BioseqaligniterativeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqaligniterativeCluster::set(self : BioseqaligniterativeCluster, i : Int, v : Double) -> BioseqaligniterativeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeCluster::sum(self : BioseqaligniterativeCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqaligniterativeCluster::mean(self : BioseqaligniterativeCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqaligniterativeCluster::scale(self : BioseqaligniterativeCluster, f : Double) -> BioseqaligniterativeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeCluster::add(self : BioseqaligniterativeCluster, other : BioseqaligniterativeCluster) -> BioseqaligniterativeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqaligniterativeCluster::copy(self : BioseqaligniterativeCluster) -> BioseqaligniterativeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeCluster::fill(self : BioseqaligniterativeCluster, v : Double) -> BioseqaligniterativeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeCluster::min(self : BioseqaligniterativeCluster) -> Double { @_common.min(self.data) }

pub fn BioseqaligniterativeCluster::max(self : BioseqaligniterativeCluster) -> Double { @_common.max(self.data) }

pub fn BioseqaligniterativeCluster::to_string(self : BioseqaligniterativeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_model_make(size : Int) -> BioseqaligniterativeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqaligniterativeModel::len(self : BioseqaligniterativeModel) -> Int { self.size }

pub fn BioseqaligniterativeModel::get(self : BioseqaligniterativeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqaligniterativeModel::set(self : BioseqaligniterativeModel, i : Int, v : Double) -> BioseqaligniterativeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeModel::sum(self : BioseqaligniterativeModel) -> Double { @_common.sum(self.data) }

pub fn BioseqaligniterativeModel::mean(self : BioseqaligniterativeModel) -> Double { @_common.mean(self.data) }

pub fn BioseqaligniterativeModel::scale(self : BioseqaligniterativeModel, f : Double) -> BioseqaligniterativeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeModel::add(self : BioseqaligniterativeModel, other : BioseqaligniterativeModel) -> BioseqaligniterativeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqaligniterativeModel::copy(self : BioseqaligniterativeModel) -> BioseqaligniterativeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeModel::fill(self : BioseqaligniterativeModel, v : Double) -> BioseqaligniterativeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeModel::min(self : BioseqaligniterativeModel) -> Double { @_common.min(self.data) }

pub fn BioseqaligniterativeModel::max(self : BioseqaligniterativeModel) -> Double { @_common.max(self.data) }

pub fn BioseqaligniterativeModel::to_string(self : BioseqaligniterativeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_layer_make(size : Int) -> BioseqaligniterativeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqaligniterativeLayer::len(self : BioseqaligniterativeLayer) -> Int { self.size }

pub fn BioseqaligniterativeLayer::get(self : BioseqaligniterativeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqaligniterativeLayer::set(self : BioseqaligniterativeLayer, i : Int, v : Double) -> BioseqaligniterativeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeLayer::sum(self : BioseqaligniterativeLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqaligniterativeLayer::mean(self : BioseqaligniterativeLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqaligniterativeLayer::scale(self : BioseqaligniterativeLayer, f : Double) -> BioseqaligniterativeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeLayer::add(self : BioseqaligniterativeLayer, other : BioseqaligniterativeLayer) -> BioseqaligniterativeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqaligniterativeLayer::copy(self : BioseqaligniterativeLayer) -> BioseqaligniterativeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeLayer::fill(self : BioseqaligniterativeLayer, v : Double) -> BioseqaligniterativeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeLayer::min(self : BioseqaligniterativeLayer) -> Double { @_common.min(self.data) }

pub fn BioseqaligniterativeLayer::max(self : BioseqaligniterativeLayer) -> Double { @_common.max(self.data) }

pub fn BioseqaligniterativeLayer::to_string(self : BioseqaligniterativeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_buffer_make(size : Int) -> BioseqaligniterativeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqaligniterativeBuffer::len(self : BioseqaligniterativeBuffer) -> Int { self.size }

pub fn BioseqaligniterativeBuffer::get(self : BioseqaligniterativeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqaligniterativeBuffer::set(self : BioseqaligniterativeBuffer, i : Int, v : Double) -> BioseqaligniterativeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeBuffer::sum(self : BioseqaligniterativeBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqaligniterativeBuffer::mean(self : BioseqaligniterativeBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqaligniterativeBuffer::scale(self : BioseqaligniterativeBuffer, f : Double) -> BioseqaligniterativeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeBuffer::add(self : BioseqaligniterativeBuffer, other : BioseqaligniterativeBuffer) -> BioseqaligniterativeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqaligniterativeBuffer::copy(self : BioseqaligniterativeBuffer) -> BioseqaligniterativeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeBuffer::fill(self : BioseqaligniterativeBuffer, v : Double) -> BioseqaligniterativeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeBuffer::min(self : BioseqaligniterativeBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqaligniterativeBuffer::max(self : BioseqaligniterativeBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqaligniterativeBuffer::to_string(self : BioseqaligniterativeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_cursor_make(size : Int) -> BioseqaligniterativeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqaligniterativeCursor::len(self : BioseqaligniterativeCursor) -> Int { self.size }

pub fn BioseqaligniterativeCursor::get(self : BioseqaligniterativeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqaligniterativeCursor::set(self : BioseqaligniterativeCursor, i : Int, v : Double) -> BioseqaligniterativeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeCursor::sum(self : BioseqaligniterativeCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqaligniterativeCursor::mean(self : BioseqaligniterativeCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqaligniterativeCursor::scale(self : BioseqaligniterativeCursor, f : Double) -> BioseqaligniterativeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeCursor::add(self : BioseqaligniterativeCursor, other : BioseqaligniterativeCursor) -> BioseqaligniterativeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqaligniterativeCursor::copy(self : BioseqaligniterativeCursor) -> BioseqaligniterativeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeCursor::fill(self : BioseqaligniterativeCursor, v : Double) -> BioseqaligniterativeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeCursor::min(self : BioseqaligniterativeCursor) -> Double { @_common.min(self.data) }

pub fn BioseqaligniterativeCursor::max(self : BioseqaligniterativeCursor) -> Double { @_common.max(self.data) }

pub fn BioseqaligniterativeCursor::to_string(self : BioseqaligniterativeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_view_make(size : Int) -> BioseqaligniterativeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqaligniterativeView::len(self : BioseqaligniterativeView) -> Int { self.size }

pub fn BioseqaligniterativeView::get(self : BioseqaligniterativeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqaligniterativeView::set(self : BioseqaligniterativeView, i : Int, v : Double) -> BioseqaligniterativeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeView::sum(self : BioseqaligniterativeView) -> Double { @_common.sum(self.data) }

pub fn BioseqaligniterativeView::mean(self : BioseqaligniterativeView) -> Double { @_common.mean(self.data) }

pub fn BioseqaligniterativeView::scale(self : BioseqaligniterativeView, f : Double) -> BioseqaligniterativeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeView::add(self : BioseqaligniterativeView, other : BioseqaligniterativeView) -> BioseqaligniterativeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqaligniterativeView::copy(self : BioseqaligniterativeView) -> BioseqaligniterativeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeView::fill(self : BioseqaligniterativeView, v : Double) -> BioseqaligniterativeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeView::min(self : BioseqaligniterativeView) -> Double { @_common.min(self.data) }

pub fn BioseqaligniterativeView::max(self : BioseqaligniterativeView) -> Double { @_common.max(self.data) }

pub fn BioseqaligniterativeView::to_string(self : BioseqaligniterativeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_range_make(size : Int) -> BioseqaligniterativeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqaligniterativeRange::len(self : BioseqaligniterativeRange) -> Int { self.size }

pub fn BioseqaligniterativeRange::get(self : BioseqaligniterativeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqaligniterativeRange::set(self : BioseqaligniterativeRange, i : Int, v : Double) -> BioseqaligniterativeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeRange::sum(self : BioseqaligniterativeRange) -> Double { @_common.sum(self.data) }

pub fn BioseqaligniterativeRange::mean(self : BioseqaligniterativeRange) -> Double { @_common.mean(self.data) }

pub fn BioseqaligniterativeRange::scale(self : BioseqaligniterativeRange, f : Double) -> BioseqaligniterativeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeRange::add(self : BioseqaligniterativeRange, other : BioseqaligniterativeRange) -> BioseqaligniterativeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqaligniterativeRange::copy(self : BioseqaligniterativeRange) -> BioseqaligniterativeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeRange::fill(self : BioseqaligniterativeRange, v : Double) -> BioseqaligniterativeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeRange::min(self : BioseqaligniterativeRange) -> Double { @_common.min(self.data) }

pub fn BioseqaligniterativeRange::max(self : BioseqaligniterativeRange) -> Double { @_common.max(self.data) }

pub fn BioseqaligniterativeRange::to_string(self : BioseqaligniterativeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqaligniterativeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_iterative_slice_make(size : Int) -> BioseqaligniterativeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqaligniterativeSlice::len(self : BioseqaligniterativeSlice) -> Int { self.size }

pub fn BioseqaligniterativeSlice::get(self : BioseqaligniterativeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqaligniterativeSlice::set(self : BioseqaligniterativeSlice, i : Int, v : Double) -> BioseqaligniterativeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeSlice::sum(self : BioseqaligniterativeSlice) -> Double { @_common.sum(self.data) }

pub fn BioseqaligniterativeSlice::mean(self : BioseqaligniterativeSlice) -> Double { @_common.mean(self.data) }

pub fn BioseqaligniterativeSlice::scale(self : BioseqaligniterativeSlice, f : Double) -> BioseqaligniterativeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeSlice::add(self : BioseqaligniterativeSlice, other : BioseqaligniterativeSlice) -> BioseqaligniterativeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqaligniterativeSlice::copy(self : BioseqaligniterativeSlice) -> BioseqaligniterativeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeSlice::fill(self : BioseqaligniterativeSlice, v : Double) -> BioseqaligniterativeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqaligniterativeSlice::min(self : BioseqaligniterativeSlice) -> Double { @_common.min(self.data) }

pub fn BioseqaligniterativeSlice::max(self : BioseqaligniterativeSlice) -> Double { @_common.max(self.data) }

pub fn BioseqaligniterativeSlice::to_string(self : BioseqaligniterativeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

