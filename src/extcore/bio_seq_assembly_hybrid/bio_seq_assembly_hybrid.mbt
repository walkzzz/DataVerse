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

pub fn BioseqassemblyhybridFrame::len(self : BioseqassemblyhybridFrame) -> Int { self.size }

pub fn BioseqassemblyhybridFrame::get(self : BioseqassemblyhybridFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyhybridFrame::set(self : BioseqassemblyhybridFrame, i : Int, v : Double) -> BioseqassemblyhybridFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridFrame::sum(self : BioseqassemblyhybridFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyhybridFrame::mean(self : BioseqassemblyhybridFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyhybridFrame::scale(self : BioseqassemblyhybridFrame, f : Double) -> BioseqassemblyhybridFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridFrame::add(self : BioseqassemblyhybridFrame, other : BioseqassemblyhybridFrame) -> BioseqassemblyhybridFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyhybridFrame::copy(self : BioseqassemblyhybridFrame) -> BioseqassemblyhybridFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridFrame::fill(self : BioseqassemblyhybridFrame, v : Double) -> BioseqassemblyhybridFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridFrame::min(self : BioseqassemblyhybridFrame) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyhybridFrame::max(self : BioseqassemblyhybridFrame) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyhybridFrame::to_string(self : BioseqassemblyhybridFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_table_make(size : Int) -> BioseqassemblyhybridTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyhybridTable::len(self : BioseqassemblyhybridTable) -> Int { self.size }

pub fn BioseqassemblyhybridTable::get(self : BioseqassemblyhybridTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyhybridTable::set(self : BioseqassemblyhybridTable, i : Int, v : Double) -> BioseqassemblyhybridTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridTable::sum(self : BioseqassemblyhybridTable) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyhybridTable::mean(self : BioseqassemblyhybridTable) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyhybridTable::scale(self : BioseqassemblyhybridTable, f : Double) -> BioseqassemblyhybridTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridTable::add(self : BioseqassemblyhybridTable, other : BioseqassemblyhybridTable) -> BioseqassemblyhybridTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyhybridTable::copy(self : BioseqassemblyhybridTable) -> BioseqassemblyhybridTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridTable::fill(self : BioseqassemblyhybridTable, v : Double) -> BioseqassemblyhybridTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridTable::min(self : BioseqassemblyhybridTable) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyhybridTable::max(self : BioseqassemblyhybridTable) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyhybridTable::to_string(self : BioseqassemblyhybridTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_graphn_make(size : Int) -> BioseqassemblyhybridGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyhybridGraphN::len(self : BioseqassemblyhybridGraphN) -> Int { self.size }

pub fn BioseqassemblyhybridGraphN::get(self : BioseqassemblyhybridGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyhybridGraphN::set(self : BioseqassemblyhybridGraphN, i : Int, v : Double) -> BioseqassemblyhybridGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridGraphN::sum(self : BioseqassemblyhybridGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyhybridGraphN::mean(self : BioseqassemblyhybridGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyhybridGraphN::scale(self : BioseqassemblyhybridGraphN, f : Double) -> BioseqassemblyhybridGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridGraphN::add(self : BioseqassemblyhybridGraphN, other : BioseqassemblyhybridGraphN) -> BioseqassemblyhybridGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyhybridGraphN::copy(self : BioseqassemblyhybridGraphN) -> BioseqassemblyhybridGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridGraphN::fill(self : BioseqassemblyhybridGraphN, v : Double) -> BioseqassemblyhybridGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridGraphN::min(self : BioseqassemblyhybridGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyhybridGraphN::max(self : BioseqassemblyhybridGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyhybridGraphN::to_string(self : BioseqassemblyhybridGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_node_make(size : Int) -> BioseqassemblyhybridNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyhybridNode::len(self : BioseqassemblyhybridNode) -> Int { self.size }

pub fn BioseqassemblyhybridNode::get(self : BioseqassemblyhybridNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyhybridNode::set(self : BioseqassemblyhybridNode, i : Int, v : Double) -> BioseqassemblyhybridNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridNode::sum(self : BioseqassemblyhybridNode) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyhybridNode::mean(self : BioseqassemblyhybridNode) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyhybridNode::scale(self : BioseqassemblyhybridNode, f : Double) -> BioseqassemblyhybridNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridNode::add(self : BioseqassemblyhybridNode, other : BioseqassemblyhybridNode) -> BioseqassemblyhybridNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyhybridNode::copy(self : BioseqassemblyhybridNode) -> BioseqassemblyhybridNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridNode::fill(self : BioseqassemblyhybridNode, v : Double) -> BioseqassemblyhybridNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridNode::min(self : BioseqassemblyhybridNode) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyhybridNode::max(self : BioseqassemblyhybridNode) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyhybridNode::to_string(self : BioseqassemblyhybridNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_edge_make(size : Int) -> BioseqassemblyhybridEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyhybridEdge::len(self : BioseqassemblyhybridEdge) -> Int { self.size }

pub fn BioseqassemblyhybridEdge::get(self : BioseqassemblyhybridEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyhybridEdge::set(self : BioseqassemblyhybridEdge, i : Int, v : Double) -> BioseqassemblyhybridEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridEdge::sum(self : BioseqassemblyhybridEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyhybridEdge::mean(self : BioseqassemblyhybridEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyhybridEdge::scale(self : BioseqassemblyhybridEdge, f : Double) -> BioseqassemblyhybridEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridEdge::add(self : BioseqassemblyhybridEdge, other : BioseqassemblyhybridEdge) -> BioseqassemblyhybridEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyhybridEdge::copy(self : BioseqassemblyhybridEdge) -> BioseqassemblyhybridEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridEdge::fill(self : BioseqassemblyhybridEdge, v : Double) -> BioseqassemblyhybridEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridEdge::min(self : BioseqassemblyhybridEdge) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyhybridEdge::max(self : BioseqassemblyhybridEdge) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyhybridEdge::to_string(self : BioseqassemblyhybridEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_path_make(size : Int) -> BioseqassemblyhybridPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyhybridPath::len(self : BioseqassemblyhybridPath) -> Int { self.size }

pub fn BioseqassemblyhybridPath::get(self : BioseqassemblyhybridPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyhybridPath::set(self : BioseqassemblyhybridPath, i : Int, v : Double) -> BioseqassemblyhybridPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridPath::sum(self : BioseqassemblyhybridPath) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyhybridPath::mean(self : BioseqassemblyhybridPath) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyhybridPath::scale(self : BioseqassemblyhybridPath, f : Double) -> BioseqassemblyhybridPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridPath::add(self : BioseqassemblyhybridPath, other : BioseqassemblyhybridPath) -> BioseqassemblyhybridPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyhybridPath::copy(self : BioseqassemblyhybridPath) -> BioseqassemblyhybridPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridPath::fill(self : BioseqassemblyhybridPath, v : Double) -> BioseqassemblyhybridPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridPath::min(self : BioseqassemblyhybridPath) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyhybridPath::max(self : BioseqassemblyhybridPath) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyhybridPath::to_string(self : BioseqassemblyhybridPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_cluster_make(size : Int) -> BioseqassemblyhybridCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyhybridCluster::len(self : BioseqassemblyhybridCluster) -> Int { self.size }

pub fn BioseqassemblyhybridCluster::get(self : BioseqassemblyhybridCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyhybridCluster::set(self : BioseqassemblyhybridCluster, i : Int, v : Double) -> BioseqassemblyhybridCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridCluster::sum(self : BioseqassemblyhybridCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyhybridCluster::mean(self : BioseqassemblyhybridCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyhybridCluster::scale(self : BioseqassemblyhybridCluster, f : Double) -> BioseqassemblyhybridCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridCluster::add(self : BioseqassemblyhybridCluster, other : BioseqassemblyhybridCluster) -> BioseqassemblyhybridCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyhybridCluster::copy(self : BioseqassemblyhybridCluster) -> BioseqassemblyhybridCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridCluster::fill(self : BioseqassemblyhybridCluster, v : Double) -> BioseqassemblyhybridCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridCluster::min(self : BioseqassemblyhybridCluster) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyhybridCluster::max(self : BioseqassemblyhybridCluster) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyhybridCluster::to_string(self : BioseqassemblyhybridCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_model_make(size : Int) -> BioseqassemblyhybridModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyhybridModel::len(self : BioseqassemblyhybridModel) -> Int { self.size }

pub fn BioseqassemblyhybridModel::get(self : BioseqassemblyhybridModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyhybridModel::set(self : BioseqassemblyhybridModel, i : Int, v : Double) -> BioseqassemblyhybridModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridModel::sum(self : BioseqassemblyhybridModel) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyhybridModel::mean(self : BioseqassemblyhybridModel) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyhybridModel::scale(self : BioseqassemblyhybridModel, f : Double) -> BioseqassemblyhybridModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridModel::add(self : BioseqassemblyhybridModel, other : BioseqassemblyhybridModel) -> BioseqassemblyhybridModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyhybridModel::copy(self : BioseqassemblyhybridModel) -> BioseqassemblyhybridModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridModel::fill(self : BioseqassemblyhybridModel, v : Double) -> BioseqassemblyhybridModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridModel::min(self : BioseqassemblyhybridModel) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyhybridModel::max(self : BioseqassemblyhybridModel) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyhybridModel::to_string(self : BioseqassemblyhybridModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_layer_make(size : Int) -> BioseqassemblyhybridLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyhybridLayer::len(self : BioseqassemblyhybridLayer) -> Int { self.size }

pub fn BioseqassemblyhybridLayer::get(self : BioseqassemblyhybridLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyhybridLayer::set(self : BioseqassemblyhybridLayer, i : Int, v : Double) -> BioseqassemblyhybridLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridLayer::sum(self : BioseqassemblyhybridLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyhybridLayer::mean(self : BioseqassemblyhybridLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyhybridLayer::scale(self : BioseqassemblyhybridLayer, f : Double) -> BioseqassemblyhybridLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridLayer::add(self : BioseqassemblyhybridLayer, other : BioseqassemblyhybridLayer) -> BioseqassemblyhybridLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyhybridLayer::copy(self : BioseqassemblyhybridLayer) -> BioseqassemblyhybridLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridLayer::fill(self : BioseqassemblyhybridLayer, v : Double) -> BioseqassemblyhybridLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridLayer::min(self : BioseqassemblyhybridLayer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyhybridLayer::max(self : BioseqassemblyhybridLayer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyhybridLayer::to_string(self : BioseqassemblyhybridLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_buffer_make(size : Int) -> BioseqassemblyhybridBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyhybridBuffer::len(self : BioseqassemblyhybridBuffer) -> Int { self.size }

pub fn BioseqassemblyhybridBuffer::get(self : BioseqassemblyhybridBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyhybridBuffer::set(self : BioseqassemblyhybridBuffer, i : Int, v : Double) -> BioseqassemblyhybridBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridBuffer::sum(self : BioseqassemblyhybridBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyhybridBuffer::mean(self : BioseqassemblyhybridBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyhybridBuffer::scale(self : BioseqassemblyhybridBuffer, f : Double) -> BioseqassemblyhybridBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridBuffer::add(self : BioseqassemblyhybridBuffer, other : BioseqassemblyhybridBuffer) -> BioseqassemblyhybridBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyhybridBuffer::copy(self : BioseqassemblyhybridBuffer) -> BioseqassemblyhybridBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridBuffer::fill(self : BioseqassemblyhybridBuffer, v : Double) -> BioseqassemblyhybridBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridBuffer::min(self : BioseqassemblyhybridBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyhybridBuffer::max(self : BioseqassemblyhybridBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyhybridBuffer::to_string(self : BioseqassemblyhybridBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_cursor_make(size : Int) -> BioseqassemblyhybridCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyhybridCursor::len(self : BioseqassemblyhybridCursor) -> Int { self.size }

pub fn BioseqassemblyhybridCursor::get(self : BioseqassemblyhybridCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyhybridCursor::set(self : BioseqassemblyhybridCursor, i : Int, v : Double) -> BioseqassemblyhybridCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridCursor::sum(self : BioseqassemblyhybridCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyhybridCursor::mean(self : BioseqassemblyhybridCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyhybridCursor::scale(self : BioseqassemblyhybridCursor, f : Double) -> BioseqassemblyhybridCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridCursor::add(self : BioseqassemblyhybridCursor, other : BioseqassemblyhybridCursor) -> BioseqassemblyhybridCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyhybridCursor::copy(self : BioseqassemblyhybridCursor) -> BioseqassemblyhybridCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridCursor::fill(self : BioseqassemblyhybridCursor, v : Double) -> BioseqassemblyhybridCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridCursor::min(self : BioseqassemblyhybridCursor) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyhybridCursor::max(self : BioseqassemblyhybridCursor) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyhybridCursor::to_string(self : BioseqassemblyhybridCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_view_make(size : Int) -> BioseqassemblyhybridView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyhybridView::len(self : BioseqassemblyhybridView) -> Int { self.size }

pub fn BioseqassemblyhybridView::get(self : BioseqassemblyhybridView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyhybridView::set(self : BioseqassemblyhybridView, i : Int, v : Double) -> BioseqassemblyhybridView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridView::sum(self : BioseqassemblyhybridView) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyhybridView::mean(self : BioseqassemblyhybridView) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyhybridView::scale(self : BioseqassemblyhybridView, f : Double) -> BioseqassemblyhybridView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridView::add(self : BioseqassemblyhybridView, other : BioseqassemblyhybridView) -> BioseqassemblyhybridView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyhybridView::copy(self : BioseqassemblyhybridView) -> BioseqassemblyhybridView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridView::fill(self : BioseqassemblyhybridView, v : Double) -> BioseqassemblyhybridView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridView::min(self : BioseqassemblyhybridView) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyhybridView::max(self : BioseqassemblyhybridView) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyhybridView::to_string(self : BioseqassemblyhybridView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_range_make(size : Int) -> BioseqassemblyhybridRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyhybridRange::len(self : BioseqassemblyhybridRange) -> Int { self.size }

pub fn BioseqassemblyhybridRange::get(self : BioseqassemblyhybridRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyhybridRange::set(self : BioseqassemblyhybridRange, i : Int, v : Double) -> BioseqassemblyhybridRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridRange::sum(self : BioseqassemblyhybridRange) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyhybridRange::mean(self : BioseqassemblyhybridRange) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyhybridRange::scale(self : BioseqassemblyhybridRange, f : Double) -> BioseqassemblyhybridRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridRange::add(self : BioseqassemblyhybridRange, other : BioseqassemblyhybridRange) -> BioseqassemblyhybridRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyhybridRange::copy(self : BioseqassemblyhybridRange) -> BioseqassemblyhybridRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridRange::fill(self : BioseqassemblyhybridRange, v : Double) -> BioseqassemblyhybridRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridRange::min(self : BioseqassemblyhybridRange) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyhybridRange::max(self : BioseqassemblyhybridRange) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyhybridRange::to_string(self : BioseqassemblyhybridRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_slice_make(size : Int) -> BioseqassemblyhybridSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblyhybridSlice::len(self : BioseqassemblyhybridSlice) -> Int { self.size }

pub fn BioseqassemblyhybridSlice::get(self : BioseqassemblyhybridSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblyhybridSlice::set(self : BioseqassemblyhybridSlice, i : Int, v : Double) -> BioseqassemblyhybridSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridSlice::sum(self : BioseqassemblyhybridSlice) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblyhybridSlice::mean(self : BioseqassemblyhybridSlice) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblyhybridSlice::scale(self : BioseqassemblyhybridSlice, f : Double) -> BioseqassemblyhybridSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridSlice::add(self : BioseqassemblyhybridSlice, other : BioseqassemblyhybridSlice) -> BioseqassemblyhybridSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblyhybridSlice::copy(self : BioseqassemblyhybridSlice) -> BioseqassemblyhybridSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridSlice::fill(self : BioseqassemblyhybridSlice, v : Double) -> BioseqassemblyhybridSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblyhybridSlice::min(self : BioseqassemblyhybridSlice) -> Double { @_common.min(self.data) }

pub fn BioseqassemblyhybridSlice::max(self : BioseqassemblyhybridSlice) -> Double { @_common.max(self.data) }

pub fn BioseqassemblyhybridSlice::to_string(self : BioseqassemblyhybridSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

