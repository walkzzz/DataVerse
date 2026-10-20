///===
/// extcore/timeseries_decomp_classical

pub(all) struct TimeseriesdecompclassicalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn timeseries_decomp_classical_make_point(x : Double, y : Double) -> TimeseriesdecompclassicalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn timeseries_decomp_classical_make_point3(x : Double, y : Double, z : Double) -> TimeseriesdecompclassicalPoint {
  { x, y, z, label: 0 }
}

pub fn TimeseriesdecompclassicalPoint::x(self : TimeseriesdecompclassicalPoint) -> Double { self.x }

pub fn TimeseriesdecompclassicalPoint::y(self : TimeseriesdecompclassicalPoint) -> Double { self.y }

pub fn TimeseriesdecompclassicalPoint::z(self : TimeseriesdecompclassicalPoint) -> Double { self.z }

pub fn TimeseriesdecompclassicalPoint::label(self : TimeseriesdecompclassicalPoint) -> Int { self.label }

pub fn TimeseriesdecompclassicalPoint::dist(self : TimeseriesdecompclassicalPoint, other : TimeseriesdecompclassicalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn TimeseriesdecompclassicalPoint::add(self : TimeseriesdecompclassicalPoint, other : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn TimeseriesdecompclassicalPoint::sub(self : TimeseriesdecompclassicalPoint, other : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn TimeseriesdecompclassicalPoint::scale(self : TimeseriesdecompclassicalPoint, s : Double) -> TimeseriesdecompclassicalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn TimeseriesdecompclassicalPoint::dot(self : TimeseriesdecompclassicalPoint, other : TimeseriesdecompclassicalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn TimeseriesdecompclassicalPoint::cross(self : TimeseriesdecompclassicalPoint, other : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn TimeseriesdecompclassicalPoint::norm(self : TimeseriesdecompclassicalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn TimeseriesdecompclassicalPoint::normalize(self : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompclassicalPoint::negate(self : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn TimeseriesdecompclassicalPoint::mid(self : TimeseriesdecompclassicalPoint, other : TimeseriesdecompclassicalPoint) -> TimeseriesdecompclassicalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn TimeseriesdecompclassicalPoint::lerp(self : TimeseriesdecompclassicalPoint, other : TimeseriesdecompclassicalPoint, t : Double) -> TimeseriesdecompclassicalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn TimeseriesdecompclassicalPoint::to_string(self : TimeseriesdecompclassicalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn timeseries_decomp_classical_make_series(vals : Array[Double], name : String) -> TimeseriesdecompclassicalSeries {
  { vals, name, meta: 0 }
}

pub fn TimeseriesdecompclassicalSeries::len(self : TimeseriesdecompclassicalSeries) -> Int { self.vals.length() }

pub fn TimeseriesdecompclassicalSeries::sum(self : TimeseriesdecompclassicalSeries) -> Double { @_common.sum(self.vals) }

pub fn TimeseriesdecompclassicalSeries::mean(self : TimeseriesdecompclassicalSeries) -> Double { @_common.mean(self.vals) }

pub fn TimeseriesdecompclassicalSeries::min(self : TimeseriesdecompclassicalSeries) -> Double { @_common.min(self.vals) }

pub fn TimeseriesdecompclassicalSeries::max(self : TimeseriesdecompclassicalSeries) -> Double { @_common.max(self.vals) }

pub fn TimeseriesdecompclassicalSeries::range(self : TimeseriesdecompclassicalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn TimeseriesdecompclassicalSeries::variance(self : TimeseriesdecompclassicalSeries) -> Double { @_common.variance(self.vals) }

pub fn TimeseriesdecompclassicalSeries::std(self : TimeseriesdecompclassicalSeries) -> Double { @_common.std(self.vals) }

pub fn TimeseriesdecompclassicalSeries::median(self : TimeseriesdecompclassicalSeries) -> Double { @_common.median(self.vals) }

pub fn TimeseriesdecompclassicalSeries::scale(self : TimeseriesdecompclassicalSeries, f : Double) -> TimeseriesdecompclassicalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn TimeseriesdecompclassicalSeries::add(self : TimeseriesdecompclassicalSeries, other : TimeseriesdecompclassicalSeries) -> TimeseriesdecompclassicalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompclassicalSeries::sub(self : TimeseriesdecompclassicalSeries, other : TimeseriesdecompclassicalSeries) -> TimeseriesdecompclassicalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn TimeseriesdecompclassicalSeries::normalize(self : TimeseriesdecompclassicalSeries) -> TimeseriesdecompclassicalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn TimeseriesdecompclassicalSeries::cumsum(self : TimeseriesdecompclassicalSeries) -> TimeseriesdecompclassicalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn TimeseriesdecompclassicalSeries::to_string(self : TimeseriesdecompclassicalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct TimeseriesdecompclassicalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn timeseries_decomp_classical_make_matrix(rows : Int, cols : Int, val : Double) -> TimeseriesdecompclassicalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn timeseries_decomp_classical_matrix_identity(n : Int) -> TimeseriesdecompclassicalMatrix {
  let m = timeseries_decomp_classical_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn TimeseriesdecompclassicalMatrix::get(self : TimeseriesdecompclassicalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn TimeseriesdecompclassicalMatrix::transpose(self : TimeseriesdecompclassicalMatrix) -> TimeseriesdecompclassicalMatrix {
  let result = timeseries_decomp_classical_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn TimeseriesdecompclassicalMatrix::add(self : TimeseriesdecompclassicalMatrix, other : TimeseriesdecompclassicalMatrix) -> TimeseriesdecompclassicalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = timeseries_decomp_classical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn TimeseriesdecompclassicalMatrix::scale(self : TimeseriesdecompclassicalMatrix, s : Double) -> TimeseriesdecompclassicalMatrix {
  let result = timeseries_decomp_classical_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn TimeseriesdecompclassicalMatrix::multiply(self : TimeseriesdecompclassicalMatrix, other : TimeseriesdecompclassicalMatrix) -> TimeseriesdecompclassicalMatrix {
  if self.cols != other.rows { return timeseries_decomp_classical_make_matrix(self.rows, other.cols, 0.0) }
  let result = timeseries_decomp_classical_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn TimeseriesdecompclassicalMatrix::trace(self : TimeseriesdecompclassicalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn TimeseriesdecompclassicalMatrix::det(self : TimeseriesdecompclassicalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn TimeseriesdecompclassicalMatrix::norm(self : TimeseriesdecompclassicalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn TimeseriesdecompclassicalMatrix::to_string(self : TimeseriesdecompclassicalMatrix) -> String {
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

pub(all) struct TimeseriesdecompclassicalVector {
  comps : Array[Double]
  dim : Int
}

pub fn timeseries_decomp_classical_make_vector(comps : Array[Double]) -> TimeseriesdecompclassicalVector {
  { comps, dim: comps.length() }
}

pub fn timeseries_decomp_classical_vector_zero(dim : Int) -> TimeseriesdecompclassicalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn TimeseriesdecompclassicalVector::add(self : TimeseriesdecompclassicalVector, other : TimeseriesdecompclassicalVector) -> TimeseriesdecompclassicalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompclassicalVector::sub(self : TimeseriesdecompclassicalVector, other : TimeseriesdecompclassicalVector) -> TimeseriesdecompclassicalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn TimeseriesdecompclassicalVector::scale(self : TimeseriesdecompclassicalVector, s : Double) -> TimeseriesdecompclassicalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn TimeseriesdecompclassicalVector::dot(self : TimeseriesdecompclassicalVector, other : TimeseriesdecompclassicalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn TimeseriesdecompclassicalVector::norm(self : TimeseriesdecompclassicalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn TimeseriesdecompclassicalVector::normalize(self : TimeseriesdecompclassicalVector) -> TimeseriesdecompclassicalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn TimeseriesdecompclassicalVector::dist(self : TimeseriesdecompclassicalVector, other : TimeseriesdecompclassicalVector) -> Double {
  self.sub(other).norm()
}

pub fn TimeseriesdecompclassicalVector::to_string(self : TimeseriesdecompclassicalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn timeseries_decomp_classical_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn timeseries_decomp_classical_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn timeseries_decomp_classical_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn timeseries_decomp_classical_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn timeseries_decomp_classical_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn timeseries_decomp_classical_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn timeseries_decomp_classical_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn timeseries_decomp_classical_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn timeseries_decomp_classical_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn timeseries_decomp_classical_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn timeseries_decomp_classical_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn timeseries_decomp_classical_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn timeseries_decomp_classical_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn timeseries_decomp_classical_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn timeseries_decomp_classical_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn timeseries_decomp_classical_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn timeseries_decomp_classical_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn timeseries_decomp_classical_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn timeseries_decomp_classical_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn timeseries_decomp_classical_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn timeseries_decomp_classical_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn timeseries_decomp_classical_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn timeseries_decomp_classical_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn timeseries_decomp_classical_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn timeseries_decomp_classical_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn timeseries_decomp_classical_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn timeseries_decomp_classical_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn timeseries_decomp_classical_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn timeseries_decomp_classical_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct TimeseriesdecompclassicalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_frame_make(size : Int) -> TimeseriesdecompclassicalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompclassicalFrame::len(self : TimeseriesdecompclassicalFrame) -> Int { self.size }

pub fn TimeseriesdecompclassicalFrame::get(self : TimeseriesdecompclassicalFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompclassicalFrame::set(self : TimeseriesdecompclassicalFrame, i : Int, v : Double) -> TimeseriesdecompclassicalFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalFrame::sum(self : TimeseriesdecompclassicalFrame) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompclassicalFrame::mean(self : TimeseriesdecompclassicalFrame) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompclassicalFrame::scale(self : TimeseriesdecompclassicalFrame, f : Double) -> TimeseriesdecompclassicalFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalFrame::add(self : TimeseriesdecompclassicalFrame, other : TimeseriesdecompclassicalFrame) -> TimeseriesdecompclassicalFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompclassicalFrame::copy(self : TimeseriesdecompclassicalFrame) -> TimeseriesdecompclassicalFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalFrame::fill(self : TimeseriesdecompclassicalFrame, v : Double) -> TimeseriesdecompclassicalFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalFrame::min(self : TimeseriesdecompclassicalFrame) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompclassicalFrame::max(self : TimeseriesdecompclassicalFrame) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompclassicalFrame::to_string(self : TimeseriesdecompclassicalFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_table_make(size : Int) -> TimeseriesdecompclassicalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompclassicalTable::len(self : TimeseriesdecompclassicalTable) -> Int { self.size }

pub fn TimeseriesdecompclassicalTable::get(self : TimeseriesdecompclassicalTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompclassicalTable::set(self : TimeseriesdecompclassicalTable, i : Int, v : Double) -> TimeseriesdecompclassicalTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalTable::sum(self : TimeseriesdecompclassicalTable) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompclassicalTable::mean(self : TimeseriesdecompclassicalTable) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompclassicalTable::scale(self : TimeseriesdecompclassicalTable, f : Double) -> TimeseriesdecompclassicalTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalTable::add(self : TimeseriesdecompclassicalTable, other : TimeseriesdecompclassicalTable) -> TimeseriesdecompclassicalTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompclassicalTable::copy(self : TimeseriesdecompclassicalTable) -> TimeseriesdecompclassicalTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalTable::fill(self : TimeseriesdecompclassicalTable, v : Double) -> TimeseriesdecompclassicalTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalTable::min(self : TimeseriesdecompclassicalTable) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompclassicalTable::max(self : TimeseriesdecompclassicalTable) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompclassicalTable::to_string(self : TimeseriesdecompclassicalTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_graphn_make(size : Int) -> TimeseriesdecompclassicalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompclassicalGraphN::len(self : TimeseriesdecompclassicalGraphN) -> Int { self.size }

pub fn TimeseriesdecompclassicalGraphN::get(self : TimeseriesdecompclassicalGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompclassicalGraphN::set(self : TimeseriesdecompclassicalGraphN, i : Int, v : Double) -> TimeseriesdecompclassicalGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalGraphN::sum(self : TimeseriesdecompclassicalGraphN) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompclassicalGraphN::mean(self : TimeseriesdecompclassicalGraphN) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompclassicalGraphN::scale(self : TimeseriesdecompclassicalGraphN, f : Double) -> TimeseriesdecompclassicalGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalGraphN::add(self : TimeseriesdecompclassicalGraphN, other : TimeseriesdecompclassicalGraphN) -> TimeseriesdecompclassicalGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompclassicalGraphN::copy(self : TimeseriesdecompclassicalGraphN) -> TimeseriesdecompclassicalGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalGraphN::fill(self : TimeseriesdecompclassicalGraphN, v : Double) -> TimeseriesdecompclassicalGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalGraphN::min(self : TimeseriesdecompclassicalGraphN) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompclassicalGraphN::max(self : TimeseriesdecompclassicalGraphN) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompclassicalGraphN::to_string(self : TimeseriesdecompclassicalGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_node_make(size : Int) -> TimeseriesdecompclassicalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompclassicalNode::len(self : TimeseriesdecompclassicalNode) -> Int { self.size }

pub fn TimeseriesdecompclassicalNode::get(self : TimeseriesdecompclassicalNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompclassicalNode::set(self : TimeseriesdecompclassicalNode, i : Int, v : Double) -> TimeseriesdecompclassicalNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalNode::sum(self : TimeseriesdecompclassicalNode) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompclassicalNode::mean(self : TimeseriesdecompclassicalNode) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompclassicalNode::scale(self : TimeseriesdecompclassicalNode, f : Double) -> TimeseriesdecompclassicalNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalNode::add(self : TimeseriesdecompclassicalNode, other : TimeseriesdecompclassicalNode) -> TimeseriesdecompclassicalNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompclassicalNode::copy(self : TimeseriesdecompclassicalNode) -> TimeseriesdecompclassicalNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalNode::fill(self : TimeseriesdecompclassicalNode, v : Double) -> TimeseriesdecompclassicalNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalNode::min(self : TimeseriesdecompclassicalNode) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompclassicalNode::max(self : TimeseriesdecompclassicalNode) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompclassicalNode::to_string(self : TimeseriesdecompclassicalNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_edge_make(size : Int) -> TimeseriesdecompclassicalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompclassicalEdge::len(self : TimeseriesdecompclassicalEdge) -> Int { self.size }

pub fn TimeseriesdecompclassicalEdge::get(self : TimeseriesdecompclassicalEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompclassicalEdge::set(self : TimeseriesdecompclassicalEdge, i : Int, v : Double) -> TimeseriesdecompclassicalEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalEdge::sum(self : TimeseriesdecompclassicalEdge) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompclassicalEdge::mean(self : TimeseriesdecompclassicalEdge) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompclassicalEdge::scale(self : TimeseriesdecompclassicalEdge, f : Double) -> TimeseriesdecompclassicalEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalEdge::add(self : TimeseriesdecompclassicalEdge, other : TimeseriesdecompclassicalEdge) -> TimeseriesdecompclassicalEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompclassicalEdge::copy(self : TimeseriesdecompclassicalEdge) -> TimeseriesdecompclassicalEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalEdge::fill(self : TimeseriesdecompclassicalEdge, v : Double) -> TimeseriesdecompclassicalEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalEdge::min(self : TimeseriesdecompclassicalEdge) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompclassicalEdge::max(self : TimeseriesdecompclassicalEdge) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompclassicalEdge::to_string(self : TimeseriesdecompclassicalEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_path_make(size : Int) -> TimeseriesdecompclassicalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompclassicalPath::len(self : TimeseriesdecompclassicalPath) -> Int { self.size }

pub fn TimeseriesdecompclassicalPath::get(self : TimeseriesdecompclassicalPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompclassicalPath::set(self : TimeseriesdecompclassicalPath, i : Int, v : Double) -> TimeseriesdecompclassicalPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalPath::sum(self : TimeseriesdecompclassicalPath) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompclassicalPath::mean(self : TimeseriesdecompclassicalPath) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompclassicalPath::scale(self : TimeseriesdecompclassicalPath, f : Double) -> TimeseriesdecompclassicalPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalPath::add(self : TimeseriesdecompclassicalPath, other : TimeseriesdecompclassicalPath) -> TimeseriesdecompclassicalPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompclassicalPath::copy(self : TimeseriesdecompclassicalPath) -> TimeseriesdecompclassicalPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalPath::fill(self : TimeseriesdecompclassicalPath, v : Double) -> TimeseriesdecompclassicalPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalPath::min(self : TimeseriesdecompclassicalPath) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompclassicalPath::max(self : TimeseriesdecompclassicalPath) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompclassicalPath::to_string(self : TimeseriesdecompclassicalPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_cluster_make(size : Int) -> TimeseriesdecompclassicalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompclassicalCluster::len(self : TimeseriesdecompclassicalCluster) -> Int { self.size }

pub fn TimeseriesdecompclassicalCluster::get(self : TimeseriesdecompclassicalCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompclassicalCluster::set(self : TimeseriesdecompclassicalCluster, i : Int, v : Double) -> TimeseriesdecompclassicalCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalCluster::sum(self : TimeseriesdecompclassicalCluster) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompclassicalCluster::mean(self : TimeseriesdecompclassicalCluster) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompclassicalCluster::scale(self : TimeseriesdecompclassicalCluster, f : Double) -> TimeseriesdecompclassicalCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalCluster::add(self : TimeseriesdecompclassicalCluster, other : TimeseriesdecompclassicalCluster) -> TimeseriesdecompclassicalCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompclassicalCluster::copy(self : TimeseriesdecompclassicalCluster) -> TimeseriesdecompclassicalCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalCluster::fill(self : TimeseriesdecompclassicalCluster, v : Double) -> TimeseriesdecompclassicalCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalCluster::min(self : TimeseriesdecompclassicalCluster) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompclassicalCluster::max(self : TimeseriesdecompclassicalCluster) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompclassicalCluster::to_string(self : TimeseriesdecompclassicalCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_model_make(size : Int) -> TimeseriesdecompclassicalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompclassicalModel::len(self : TimeseriesdecompclassicalModel) -> Int { self.size }

pub fn TimeseriesdecompclassicalModel::get(self : TimeseriesdecompclassicalModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompclassicalModel::set(self : TimeseriesdecompclassicalModel, i : Int, v : Double) -> TimeseriesdecompclassicalModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalModel::sum(self : TimeseriesdecompclassicalModel) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompclassicalModel::mean(self : TimeseriesdecompclassicalModel) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompclassicalModel::scale(self : TimeseriesdecompclassicalModel, f : Double) -> TimeseriesdecompclassicalModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalModel::add(self : TimeseriesdecompclassicalModel, other : TimeseriesdecompclassicalModel) -> TimeseriesdecompclassicalModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompclassicalModel::copy(self : TimeseriesdecompclassicalModel) -> TimeseriesdecompclassicalModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalModel::fill(self : TimeseriesdecompclassicalModel, v : Double) -> TimeseriesdecompclassicalModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalModel::min(self : TimeseriesdecompclassicalModel) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompclassicalModel::max(self : TimeseriesdecompclassicalModel) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompclassicalModel::to_string(self : TimeseriesdecompclassicalModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_layer_make(size : Int) -> TimeseriesdecompclassicalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompclassicalLayer::len(self : TimeseriesdecompclassicalLayer) -> Int { self.size }

pub fn TimeseriesdecompclassicalLayer::get(self : TimeseriesdecompclassicalLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompclassicalLayer::set(self : TimeseriesdecompclassicalLayer, i : Int, v : Double) -> TimeseriesdecompclassicalLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalLayer::sum(self : TimeseriesdecompclassicalLayer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompclassicalLayer::mean(self : TimeseriesdecompclassicalLayer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompclassicalLayer::scale(self : TimeseriesdecompclassicalLayer, f : Double) -> TimeseriesdecompclassicalLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalLayer::add(self : TimeseriesdecompclassicalLayer, other : TimeseriesdecompclassicalLayer) -> TimeseriesdecompclassicalLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompclassicalLayer::copy(self : TimeseriesdecompclassicalLayer) -> TimeseriesdecompclassicalLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalLayer::fill(self : TimeseriesdecompclassicalLayer, v : Double) -> TimeseriesdecompclassicalLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalLayer::min(self : TimeseriesdecompclassicalLayer) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompclassicalLayer::max(self : TimeseriesdecompclassicalLayer) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompclassicalLayer::to_string(self : TimeseriesdecompclassicalLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_buffer_make(size : Int) -> TimeseriesdecompclassicalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompclassicalBuffer::len(self : TimeseriesdecompclassicalBuffer) -> Int { self.size }

pub fn TimeseriesdecompclassicalBuffer::get(self : TimeseriesdecompclassicalBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompclassicalBuffer::set(self : TimeseriesdecompclassicalBuffer, i : Int, v : Double) -> TimeseriesdecompclassicalBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalBuffer::sum(self : TimeseriesdecompclassicalBuffer) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompclassicalBuffer::mean(self : TimeseriesdecompclassicalBuffer) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompclassicalBuffer::scale(self : TimeseriesdecompclassicalBuffer, f : Double) -> TimeseriesdecompclassicalBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalBuffer::add(self : TimeseriesdecompclassicalBuffer, other : TimeseriesdecompclassicalBuffer) -> TimeseriesdecompclassicalBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompclassicalBuffer::copy(self : TimeseriesdecompclassicalBuffer) -> TimeseriesdecompclassicalBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalBuffer::fill(self : TimeseriesdecompclassicalBuffer, v : Double) -> TimeseriesdecompclassicalBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalBuffer::min(self : TimeseriesdecompclassicalBuffer) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompclassicalBuffer::max(self : TimeseriesdecompclassicalBuffer) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompclassicalBuffer::to_string(self : TimeseriesdecompclassicalBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_cursor_make(size : Int) -> TimeseriesdecompclassicalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompclassicalCursor::len(self : TimeseriesdecompclassicalCursor) -> Int { self.size }

pub fn TimeseriesdecompclassicalCursor::get(self : TimeseriesdecompclassicalCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompclassicalCursor::set(self : TimeseriesdecompclassicalCursor, i : Int, v : Double) -> TimeseriesdecompclassicalCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalCursor::sum(self : TimeseriesdecompclassicalCursor) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompclassicalCursor::mean(self : TimeseriesdecompclassicalCursor) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompclassicalCursor::scale(self : TimeseriesdecompclassicalCursor, f : Double) -> TimeseriesdecompclassicalCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalCursor::add(self : TimeseriesdecompclassicalCursor, other : TimeseriesdecompclassicalCursor) -> TimeseriesdecompclassicalCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompclassicalCursor::copy(self : TimeseriesdecompclassicalCursor) -> TimeseriesdecompclassicalCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalCursor::fill(self : TimeseriesdecompclassicalCursor, v : Double) -> TimeseriesdecompclassicalCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalCursor::min(self : TimeseriesdecompclassicalCursor) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompclassicalCursor::max(self : TimeseriesdecompclassicalCursor) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompclassicalCursor::to_string(self : TimeseriesdecompclassicalCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_view_make(size : Int) -> TimeseriesdecompclassicalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompclassicalView::len(self : TimeseriesdecompclassicalView) -> Int { self.size }

pub fn TimeseriesdecompclassicalView::get(self : TimeseriesdecompclassicalView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompclassicalView::set(self : TimeseriesdecompclassicalView, i : Int, v : Double) -> TimeseriesdecompclassicalView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalView::sum(self : TimeseriesdecompclassicalView) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompclassicalView::mean(self : TimeseriesdecompclassicalView) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompclassicalView::scale(self : TimeseriesdecompclassicalView, f : Double) -> TimeseriesdecompclassicalView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalView::add(self : TimeseriesdecompclassicalView, other : TimeseriesdecompclassicalView) -> TimeseriesdecompclassicalView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompclassicalView::copy(self : TimeseriesdecompclassicalView) -> TimeseriesdecompclassicalView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalView::fill(self : TimeseriesdecompclassicalView, v : Double) -> TimeseriesdecompclassicalView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalView::min(self : TimeseriesdecompclassicalView) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompclassicalView::max(self : TimeseriesdecompclassicalView) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompclassicalView::to_string(self : TimeseriesdecompclassicalView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_range_make(size : Int) -> TimeseriesdecompclassicalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompclassicalRange::len(self : TimeseriesdecompclassicalRange) -> Int { self.size }

pub fn TimeseriesdecompclassicalRange::get(self : TimeseriesdecompclassicalRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompclassicalRange::set(self : TimeseriesdecompclassicalRange, i : Int, v : Double) -> TimeseriesdecompclassicalRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalRange::sum(self : TimeseriesdecompclassicalRange) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompclassicalRange::mean(self : TimeseriesdecompclassicalRange) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompclassicalRange::scale(self : TimeseriesdecompclassicalRange, f : Double) -> TimeseriesdecompclassicalRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalRange::add(self : TimeseriesdecompclassicalRange, other : TimeseriesdecompclassicalRange) -> TimeseriesdecompclassicalRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompclassicalRange::copy(self : TimeseriesdecompclassicalRange) -> TimeseriesdecompclassicalRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalRange::fill(self : TimeseriesdecompclassicalRange, v : Double) -> TimeseriesdecompclassicalRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalRange::min(self : TimeseriesdecompclassicalRange) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompclassicalRange::max(self : TimeseriesdecompclassicalRange) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompclassicalRange::to_string(self : TimeseriesdecompclassicalRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct TimeseriesdecompclassicalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn timeseries_decomp_classical_slice_make(size : Int) -> TimeseriesdecompclassicalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn TimeseriesdecompclassicalSlice::len(self : TimeseriesdecompclassicalSlice) -> Int { self.size }

pub fn TimeseriesdecompclassicalSlice::get(self : TimeseriesdecompclassicalSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn TimeseriesdecompclassicalSlice::set(self : TimeseriesdecompclassicalSlice, i : Int, v : Double) -> TimeseriesdecompclassicalSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalSlice::sum(self : TimeseriesdecompclassicalSlice) -> Double { @_common.sum(self.data) }

pub fn TimeseriesdecompclassicalSlice::mean(self : TimeseriesdecompclassicalSlice) -> Double { @_common.mean(self.data) }

pub fn TimeseriesdecompclassicalSlice::scale(self : TimeseriesdecompclassicalSlice, f : Double) -> TimeseriesdecompclassicalSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalSlice::add(self : TimeseriesdecompclassicalSlice, other : TimeseriesdecompclassicalSlice) -> TimeseriesdecompclassicalSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn TimeseriesdecompclassicalSlice::copy(self : TimeseriesdecompclassicalSlice) -> TimeseriesdecompclassicalSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalSlice::fill(self : TimeseriesdecompclassicalSlice, v : Double) -> TimeseriesdecompclassicalSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn TimeseriesdecompclassicalSlice::min(self : TimeseriesdecompclassicalSlice) -> Double { @_common.min(self.data) }

pub fn TimeseriesdecompclassicalSlice::max(self : TimeseriesdecompclassicalSlice) -> Double { @_common.max(self.data) }

pub fn TimeseriesdecompclassicalSlice::to_string(self : TimeseriesdecompclassicalSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

