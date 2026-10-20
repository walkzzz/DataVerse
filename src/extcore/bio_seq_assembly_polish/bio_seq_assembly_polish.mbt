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

pub fn BioseqassemblypolishFrame::len(self : BioseqassemblypolishFrame) -> Int { self.size }

pub fn BioseqassemblypolishFrame::get(self : BioseqassemblypolishFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblypolishFrame::set(self : BioseqassemblypolishFrame, i : Int, v : Double) -> BioseqassemblypolishFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishFrame::sum(self : BioseqassemblypolishFrame) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblypolishFrame::mean(self : BioseqassemblypolishFrame) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblypolishFrame::scale(self : BioseqassemblypolishFrame, f : Double) -> BioseqassemblypolishFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishFrame::add(self : BioseqassemblypolishFrame, other : BioseqassemblypolishFrame) -> BioseqassemblypolishFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblypolishFrame::copy(self : BioseqassemblypolishFrame) -> BioseqassemblypolishFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishFrame::fill(self : BioseqassemblypolishFrame, v : Double) -> BioseqassemblypolishFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishFrame::min(self : BioseqassemblypolishFrame) -> Double { @_common.min(self.data) }

pub fn BioseqassemblypolishFrame::max(self : BioseqassemblypolishFrame) -> Double { @_common.max(self.data) }

pub fn BioseqassemblypolishFrame::to_string(self : BioseqassemblypolishFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_table_make(size : Int) -> BioseqassemblypolishTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblypolishTable::len(self : BioseqassemblypolishTable) -> Int { self.size }

pub fn BioseqassemblypolishTable::get(self : BioseqassemblypolishTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblypolishTable::set(self : BioseqassemblypolishTable, i : Int, v : Double) -> BioseqassemblypolishTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishTable::sum(self : BioseqassemblypolishTable) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblypolishTable::mean(self : BioseqassemblypolishTable) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblypolishTable::scale(self : BioseqassemblypolishTable, f : Double) -> BioseqassemblypolishTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishTable::add(self : BioseqassemblypolishTable, other : BioseqassemblypolishTable) -> BioseqassemblypolishTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblypolishTable::copy(self : BioseqassemblypolishTable) -> BioseqassemblypolishTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishTable::fill(self : BioseqassemblypolishTable, v : Double) -> BioseqassemblypolishTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishTable::min(self : BioseqassemblypolishTable) -> Double { @_common.min(self.data) }

pub fn BioseqassemblypolishTable::max(self : BioseqassemblypolishTable) -> Double { @_common.max(self.data) }

pub fn BioseqassemblypolishTable::to_string(self : BioseqassemblypolishTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_graphn_make(size : Int) -> BioseqassemblypolishGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblypolishGraphN::len(self : BioseqassemblypolishGraphN) -> Int { self.size }

pub fn BioseqassemblypolishGraphN::get(self : BioseqassemblypolishGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblypolishGraphN::set(self : BioseqassemblypolishGraphN, i : Int, v : Double) -> BioseqassemblypolishGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishGraphN::sum(self : BioseqassemblypolishGraphN) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblypolishGraphN::mean(self : BioseqassemblypolishGraphN) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblypolishGraphN::scale(self : BioseqassemblypolishGraphN, f : Double) -> BioseqassemblypolishGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishGraphN::add(self : BioseqassemblypolishGraphN, other : BioseqassemblypolishGraphN) -> BioseqassemblypolishGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblypolishGraphN::copy(self : BioseqassemblypolishGraphN) -> BioseqassemblypolishGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishGraphN::fill(self : BioseqassemblypolishGraphN, v : Double) -> BioseqassemblypolishGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishGraphN::min(self : BioseqassemblypolishGraphN) -> Double { @_common.min(self.data) }

pub fn BioseqassemblypolishGraphN::max(self : BioseqassemblypolishGraphN) -> Double { @_common.max(self.data) }

pub fn BioseqassemblypolishGraphN::to_string(self : BioseqassemblypolishGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_node_make(size : Int) -> BioseqassemblypolishNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblypolishNode::len(self : BioseqassemblypolishNode) -> Int { self.size }

pub fn BioseqassemblypolishNode::get(self : BioseqassemblypolishNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblypolishNode::set(self : BioseqassemblypolishNode, i : Int, v : Double) -> BioseqassemblypolishNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishNode::sum(self : BioseqassemblypolishNode) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblypolishNode::mean(self : BioseqassemblypolishNode) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblypolishNode::scale(self : BioseqassemblypolishNode, f : Double) -> BioseqassemblypolishNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishNode::add(self : BioseqassemblypolishNode, other : BioseqassemblypolishNode) -> BioseqassemblypolishNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblypolishNode::copy(self : BioseqassemblypolishNode) -> BioseqassemblypolishNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishNode::fill(self : BioseqassemblypolishNode, v : Double) -> BioseqassemblypolishNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishNode::min(self : BioseqassemblypolishNode) -> Double { @_common.min(self.data) }

pub fn BioseqassemblypolishNode::max(self : BioseqassemblypolishNode) -> Double { @_common.max(self.data) }

pub fn BioseqassemblypolishNode::to_string(self : BioseqassemblypolishNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_edge_make(size : Int) -> BioseqassemblypolishEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblypolishEdge::len(self : BioseqassemblypolishEdge) -> Int { self.size }

pub fn BioseqassemblypolishEdge::get(self : BioseqassemblypolishEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblypolishEdge::set(self : BioseqassemblypolishEdge, i : Int, v : Double) -> BioseqassemblypolishEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishEdge::sum(self : BioseqassemblypolishEdge) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblypolishEdge::mean(self : BioseqassemblypolishEdge) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblypolishEdge::scale(self : BioseqassemblypolishEdge, f : Double) -> BioseqassemblypolishEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishEdge::add(self : BioseqassemblypolishEdge, other : BioseqassemblypolishEdge) -> BioseqassemblypolishEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblypolishEdge::copy(self : BioseqassemblypolishEdge) -> BioseqassemblypolishEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishEdge::fill(self : BioseqassemblypolishEdge, v : Double) -> BioseqassemblypolishEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishEdge::min(self : BioseqassemblypolishEdge) -> Double { @_common.min(self.data) }

pub fn BioseqassemblypolishEdge::max(self : BioseqassemblypolishEdge) -> Double { @_common.max(self.data) }

pub fn BioseqassemblypolishEdge::to_string(self : BioseqassemblypolishEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_path_make(size : Int) -> BioseqassemblypolishPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblypolishPath::len(self : BioseqassemblypolishPath) -> Int { self.size }

pub fn BioseqassemblypolishPath::get(self : BioseqassemblypolishPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblypolishPath::set(self : BioseqassemblypolishPath, i : Int, v : Double) -> BioseqassemblypolishPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishPath::sum(self : BioseqassemblypolishPath) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblypolishPath::mean(self : BioseqassemblypolishPath) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblypolishPath::scale(self : BioseqassemblypolishPath, f : Double) -> BioseqassemblypolishPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishPath::add(self : BioseqassemblypolishPath, other : BioseqassemblypolishPath) -> BioseqassemblypolishPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblypolishPath::copy(self : BioseqassemblypolishPath) -> BioseqassemblypolishPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishPath::fill(self : BioseqassemblypolishPath, v : Double) -> BioseqassemblypolishPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishPath::min(self : BioseqassemblypolishPath) -> Double { @_common.min(self.data) }

pub fn BioseqassemblypolishPath::max(self : BioseqassemblypolishPath) -> Double { @_common.max(self.data) }

pub fn BioseqassemblypolishPath::to_string(self : BioseqassemblypolishPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_cluster_make(size : Int) -> BioseqassemblypolishCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblypolishCluster::len(self : BioseqassemblypolishCluster) -> Int { self.size }

pub fn BioseqassemblypolishCluster::get(self : BioseqassemblypolishCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblypolishCluster::set(self : BioseqassemblypolishCluster, i : Int, v : Double) -> BioseqassemblypolishCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishCluster::sum(self : BioseqassemblypolishCluster) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblypolishCluster::mean(self : BioseqassemblypolishCluster) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblypolishCluster::scale(self : BioseqassemblypolishCluster, f : Double) -> BioseqassemblypolishCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishCluster::add(self : BioseqassemblypolishCluster, other : BioseqassemblypolishCluster) -> BioseqassemblypolishCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblypolishCluster::copy(self : BioseqassemblypolishCluster) -> BioseqassemblypolishCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishCluster::fill(self : BioseqassemblypolishCluster, v : Double) -> BioseqassemblypolishCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishCluster::min(self : BioseqassemblypolishCluster) -> Double { @_common.min(self.data) }

pub fn BioseqassemblypolishCluster::max(self : BioseqassemblypolishCluster) -> Double { @_common.max(self.data) }

pub fn BioseqassemblypolishCluster::to_string(self : BioseqassemblypolishCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_model_make(size : Int) -> BioseqassemblypolishModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblypolishModel::len(self : BioseqassemblypolishModel) -> Int { self.size }

pub fn BioseqassemblypolishModel::get(self : BioseqassemblypolishModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblypolishModel::set(self : BioseqassemblypolishModel, i : Int, v : Double) -> BioseqassemblypolishModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishModel::sum(self : BioseqassemblypolishModel) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblypolishModel::mean(self : BioseqassemblypolishModel) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblypolishModel::scale(self : BioseqassemblypolishModel, f : Double) -> BioseqassemblypolishModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishModel::add(self : BioseqassemblypolishModel, other : BioseqassemblypolishModel) -> BioseqassemblypolishModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblypolishModel::copy(self : BioseqassemblypolishModel) -> BioseqassemblypolishModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishModel::fill(self : BioseqassemblypolishModel, v : Double) -> BioseqassemblypolishModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishModel::min(self : BioseqassemblypolishModel) -> Double { @_common.min(self.data) }

pub fn BioseqassemblypolishModel::max(self : BioseqassemblypolishModel) -> Double { @_common.max(self.data) }

pub fn BioseqassemblypolishModel::to_string(self : BioseqassemblypolishModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_layer_make(size : Int) -> BioseqassemblypolishLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblypolishLayer::len(self : BioseqassemblypolishLayer) -> Int { self.size }

pub fn BioseqassemblypolishLayer::get(self : BioseqassemblypolishLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblypolishLayer::set(self : BioseqassemblypolishLayer, i : Int, v : Double) -> BioseqassemblypolishLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishLayer::sum(self : BioseqassemblypolishLayer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblypolishLayer::mean(self : BioseqassemblypolishLayer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblypolishLayer::scale(self : BioseqassemblypolishLayer, f : Double) -> BioseqassemblypolishLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishLayer::add(self : BioseqassemblypolishLayer, other : BioseqassemblypolishLayer) -> BioseqassemblypolishLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblypolishLayer::copy(self : BioseqassemblypolishLayer) -> BioseqassemblypolishLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishLayer::fill(self : BioseqassemblypolishLayer, v : Double) -> BioseqassemblypolishLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishLayer::min(self : BioseqassemblypolishLayer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblypolishLayer::max(self : BioseqassemblypolishLayer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblypolishLayer::to_string(self : BioseqassemblypolishLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_buffer_make(size : Int) -> BioseqassemblypolishBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblypolishBuffer::len(self : BioseqassemblypolishBuffer) -> Int { self.size }

pub fn BioseqassemblypolishBuffer::get(self : BioseqassemblypolishBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblypolishBuffer::set(self : BioseqassemblypolishBuffer, i : Int, v : Double) -> BioseqassemblypolishBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishBuffer::sum(self : BioseqassemblypolishBuffer) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblypolishBuffer::mean(self : BioseqassemblypolishBuffer) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblypolishBuffer::scale(self : BioseqassemblypolishBuffer, f : Double) -> BioseqassemblypolishBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishBuffer::add(self : BioseqassemblypolishBuffer, other : BioseqassemblypolishBuffer) -> BioseqassemblypolishBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblypolishBuffer::copy(self : BioseqassemblypolishBuffer) -> BioseqassemblypolishBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishBuffer::fill(self : BioseqassemblypolishBuffer, v : Double) -> BioseqassemblypolishBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishBuffer::min(self : BioseqassemblypolishBuffer) -> Double { @_common.min(self.data) }

pub fn BioseqassemblypolishBuffer::max(self : BioseqassemblypolishBuffer) -> Double { @_common.max(self.data) }

pub fn BioseqassemblypolishBuffer::to_string(self : BioseqassemblypolishBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_cursor_make(size : Int) -> BioseqassemblypolishCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblypolishCursor::len(self : BioseqassemblypolishCursor) -> Int { self.size }

pub fn BioseqassemblypolishCursor::get(self : BioseqassemblypolishCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblypolishCursor::set(self : BioseqassemblypolishCursor, i : Int, v : Double) -> BioseqassemblypolishCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishCursor::sum(self : BioseqassemblypolishCursor) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblypolishCursor::mean(self : BioseqassemblypolishCursor) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblypolishCursor::scale(self : BioseqassemblypolishCursor, f : Double) -> BioseqassemblypolishCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishCursor::add(self : BioseqassemblypolishCursor, other : BioseqassemblypolishCursor) -> BioseqassemblypolishCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblypolishCursor::copy(self : BioseqassemblypolishCursor) -> BioseqassemblypolishCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishCursor::fill(self : BioseqassemblypolishCursor, v : Double) -> BioseqassemblypolishCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishCursor::min(self : BioseqassemblypolishCursor) -> Double { @_common.min(self.data) }

pub fn BioseqassemblypolishCursor::max(self : BioseqassemblypolishCursor) -> Double { @_common.max(self.data) }

pub fn BioseqassemblypolishCursor::to_string(self : BioseqassemblypolishCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_view_make(size : Int) -> BioseqassemblypolishView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblypolishView::len(self : BioseqassemblypolishView) -> Int { self.size }

pub fn BioseqassemblypolishView::get(self : BioseqassemblypolishView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblypolishView::set(self : BioseqassemblypolishView, i : Int, v : Double) -> BioseqassemblypolishView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishView::sum(self : BioseqassemblypolishView) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblypolishView::mean(self : BioseqassemblypolishView) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblypolishView::scale(self : BioseqassemblypolishView, f : Double) -> BioseqassemblypolishView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishView::add(self : BioseqassemblypolishView, other : BioseqassemblypolishView) -> BioseqassemblypolishView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblypolishView::copy(self : BioseqassemblypolishView) -> BioseqassemblypolishView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishView::fill(self : BioseqassemblypolishView, v : Double) -> BioseqassemblypolishView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishView::min(self : BioseqassemblypolishView) -> Double { @_common.min(self.data) }

pub fn BioseqassemblypolishView::max(self : BioseqassemblypolishView) -> Double { @_common.max(self.data) }

pub fn BioseqassemblypolishView::to_string(self : BioseqassemblypolishView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_range_make(size : Int) -> BioseqassemblypolishRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblypolishRange::len(self : BioseqassemblypolishRange) -> Int { self.size }

pub fn BioseqassemblypolishRange::get(self : BioseqassemblypolishRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblypolishRange::set(self : BioseqassemblypolishRange, i : Int, v : Double) -> BioseqassemblypolishRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishRange::sum(self : BioseqassemblypolishRange) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblypolishRange::mean(self : BioseqassemblypolishRange) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblypolishRange::scale(self : BioseqassemblypolishRange, f : Double) -> BioseqassemblypolishRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishRange::add(self : BioseqassemblypolishRange, other : BioseqassemblypolishRange) -> BioseqassemblypolishRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblypolishRange::copy(self : BioseqassemblypolishRange) -> BioseqassemblypolishRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishRange::fill(self : BioseqassemblypolishRange, v : Double) -> BioseqassemblypolishRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishRange::min(self : BioseqassemblypolishRange) -> Double { @_common.min(self.data) }

pub fn BioseqassemblypolishRange::max(self : BioseqassemblypolishRange) -> Double { @_common.max(self.data) }

pub fn BioseqassemblypolishRange::to_string(self : BioseqassemblypolishRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct BioseqassemblypolishSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_polish_slice_make(size : Int) -> BioseqassemblypolishSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn BioseqassemblypolishSlice::len(self : BioseqassemblypolishSlice) -> Int { self.size }

pub fn BioseqassemblypolishSlice::get(self : BioseqassemblypolishSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn BioseqassemblypolishSlice::set(self : BioseqassemblypolishSlice, i : Int, v : Double) -> BioseqassemblypolishSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishSlice::sum(self : BioseqassemblypolishSlice) -> Double { @_common.sum(self.data) }

pub fn BioseqassemblypolishSlice::mean(self : BioseqassemblypolishSlice) -> Double { @_common.mean(self.data) }

pub fn BioseqassemblypolishSlice::scale(self : BioseqassemblypolishSlice, f : Double) -> BioseqassemblypolishSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishSlice::add(self : BioseqassemblypolishSlice, other : BioseqassemblypolishSlice) -> BioseqassemblypolishSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn BioseqassemblypolishSlice::copy(self : BioseqassemblypolishSlice) -> BioseqassemblypolishSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishSlice::fill(self : BioseqassemblypolishSlice, v : Double) -> BioseqassemblypolishSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn BioseqassemblypolishSlice::min(self : BioseqassemblypolishSlice) -> Double { @_common.min(self.data) }

pub fn BioseqassemblypolishSlice::max(self : BioseqassemblypolishSlice) -> Double { @_common.max(self.data) }

pub fn BioseqassemblypolishSlice::to_string(self : BioseqassemblypolishSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

