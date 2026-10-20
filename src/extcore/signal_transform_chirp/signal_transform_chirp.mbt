///===
/// extcore/signal_transform_chirp

pub(all) struct SignaltransformchirpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn signal_transform_chirp_make_point(x : Double, y : Double) -> SignaltransformchirpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn signal_transform_chirp_make_point3(x : Double, y : Double, z : Double) -> SignaltransformchirpPoint {
  { x, y, z, label: 0 }
}

pub fn SignaltransformchirpPoint::x(self : SignaltransformchirpPoint) -> Double { self.x }

pub fn SignaltransformchirpPoint::y(self : SignaltransformchirpPoint) -> Double { self.y }

pub fn SignaltransformchirpPoint::z(self : SignaltransformchirpPoint) -> Double { self.z }

pub fn SignaltransformchirpPoint::label(self : SignaltransformchirpPoint) -> Int { self.label }

pub fn SignaltransformchirpPoint::dist(self : SignaltransformchirpPoint, other : SignaltransformchirpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SignaltransformchirpPoint::add(self : SignaltransformchirpPoint, other : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SignaltransformchirpPoint::sub(self : SignaltransformchirpPoint, other : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SignaltransformchirpPoint::scale(self : SignaltransformchirpPoint, s : Double) -> SignaltransformchirpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SignaltransformchirpPoint::dot(self : SignaltransformchirpPoint, other : SignaltransformchirpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SignaltransformchirpPoint::cross(self : SignaltransformchirpPoint, other : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SignaltransformchirpPoint::norm(self : SignaltransformchirpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SignaltransformchirpPoint::normalize(self : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformchirpPoint::negate(self : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SignaltransformchirpPoint::mid(self : SignaltransformchirpPoint, other : SignaltransformchirpPoint) -> SignaltransformchirpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SignaltransformchirpPoint::lerp(self : SignaltransformchirpPoint, other : SignaltransformchirpPoint, t : Double) -> SignaltransformchirpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SignaltransformchirpPoint::to_string(self : SignaltransformchirpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SignaltransformchirpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn signal_transform_chirp_make_series(vals : Array[Double], name : String) -> SignaltransformchirpSeries {
  { vals, name, meta: 0 }
}

pub fn SignaltransformchirpSeries::len(self : SignaltransformchirpSeries) -> Int { self.vals.length() }

pub fn SignaltransformchirpSeries::sum(self : SignaltransformchirpSeries) -> Double { @_common.sum(self.vals) }

pub fn SignaltransformchirpSeries::mean(self : SignaltransformchirpSeries) -> Double { @_common.mean(self.vals) }

pub fn SignaltransformchirpSeries::min(self : SignaltransformchirpSeries) -> Double { @_common.min(self.vals) }

pub fn SignaltransformchirpSeries::max(self : SignaltransformchirpSeries) -> Double { @_common.max(self.vals) }

pub fn SignaltransformchirpSeries::range(self : SignaltransformchirpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SignaltransformchirpSeries::variance(self : SignaltransformchirpSeries) -> Double { @_common.variance(self.vals) }

pub fn SignaltransformchirpSeries::std(self : SignaltransformchirpSeries) -> Double { @_common.std(self.vals) }

pub fn SignaltransformchirpSeries::median(self : SignaltransformchirpSeries) -> Double { @_common.median(self.vals) }

pub fn SignaltransformchirpSeries::scale(self : SignaltransformchirpSeries, f : Double) -> SignaltransformchirpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SignaltransformchirpSeries::add(self : SignaltransformchirpSeries, other : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SignaltransformchirpSeries::sub(self : SignaltransformchirpSeries, other : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SignaltransformchirpSeries::normalize(self : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SignaltransformchirpSeries::cumsum(self : SignaltransformchirpSeries) -> SignaltransformchirpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SignaltransformchirpSeries::to_string(self : SignaltransformchirpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SignaltransformchirpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn signal_transform_chirp_make_matrix(rows : Int, cols : Int, val : Double) -> SignaltransformchirpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn signal_transform_chirp_matrix_identity(n : Int) -> SignaltransformchirpMatrix {
  let m = signal_transform_chirp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SignaltransformchirpMatrix::get(self : SignaltransformchirpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SignaltransformchirpMatrix::transpose(self : SignaltransformchirpMatrix) -> SignaltransformchirpMatrix {
  let result = signal_transform_chirp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SignaltransformchirpMatrix::add(self : SignaltransformchirpMatrix, other : SignaltransformchirpMatrix) -> SignaltransformchirpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = signal_transform_chirp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SignaltransformchirpMatrix::scale(self : SignaltransformchirpMatrix, s : Double) -> SignaltransformchirpMatrix {
  let result = signal_transform_chirp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SignaltransformchirpMatrix::multiply(self : SignaltransformchirpMatrix, other : SignaltransformchirpMatrix) -> SignaltransformchirpMatrix {
  if self.cols != other.rows { return signal_transform_chirp_make_matrix(self.rows, other.cols, 0.0) }
  let result = signal_transform_chirp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SignaltransformchirpMatrix::trace(self : SignaltransformchirpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SignaltransformchirpMatrix::det(self : SignaltransformchirpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SignaltransformchirpMatrix::norm(self : SignaltransformchirpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SignaltransformchirpMatrix::to_string(self : SignaltransformchirpMatrix) -> String {
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

pub(all) struct SignaltransformchirpVector {
  comps : Array[Double]
  dim : Int
}

pub fn signal_transform_chirp_make_vector(comps : Array[Double]) -> SignaltransformchirpVector {
  { comps, dim: comps.length() }
}

pub fn signal_transform_chirp_vector_zero(dim : Int) -> SignaltransformchirpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SignaltransformchirpVector::add(self : SignaltransformchirpVector, other : SignaltransformchirpVector) -> SignaltransformchirpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformchirpVector::sub(self : SignaltransformchirpVector, other : SignaltransformchirpVector) -> SignaltransformchirpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SignaltransformchirpVector::scale(self : SignaltransformchirpVector, s : Double) -> SignaltransformchirpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SignaltransformchirpVector::dot(self : SignaltransformchirpVector, other : SignaltransformchirpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SignaltransformchirpVector::norm(self : SignaltransformchirpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SignaltransformchirpVector::normalize(self : SignaltransformchirpVector) -> SignaltransformchirpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SignaltransformchirpVector::dist(self : SignaltransformchirpVector, other : SignaltransformchirpVector) -> Double {
  self.sub(other).norm()
}

pub fn SignaltransformchirpVector::to_string(self : SignaltransformchirpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn signal_transform_chirp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn signal_transform_chirp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn signal_transform_chirp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn signal_transform_chirp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn signal_transform_chirp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn signal_transform_chirp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn signal_transform_chirp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn signal_transform_chirp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn signal_transform_chirp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn signal_transform_chirp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn signal_transform_chirp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn signal_transform_chirp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn signal_transform_chirp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn signal_transform_chirp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn signal_transform_chirp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn signal_transform_chirp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn signal_transform_chirp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn signal_transform_chirp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn signal_transform_chirp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn signal_transform_chirp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn signal_transform_chirp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn signal_transform_chirp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn signal_transform_chirp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn signal_transform_chirp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn signal_transform_chirp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn signal_transform_chirp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn signal_transform_chirp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn signal_transform_chirp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn signal_transform_chirp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SignaltransformchirpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_frame_make(size : Int) -> SignaltransformchirpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformchirpFrame::len(self : SignaltransformchirpFrame) -> Int { self.size }

pub fn SignaltransformchirpFrame::get(self : SignaltransformchirpFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformchirpFrame::set(self : SignaltransformchirpFrame, i : Int, v : Double) -> SignaltransformchirpFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpFrame::sum(self : SignaltransformchirpFrame) -> Double { @_common.sum(self.data) }

pub fn SignaltransformchirpFrame::mean(self : SignaltransformchirpFrame) -> Double { @_common.mean(self.data) }

pub fn SignaltransformchirpFrame::scale(self : SignaltransformchirpFrame, f : Double) -> SignaltransformchirpFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpFrame::add(self : SignaltransformchirpFrame, other : SignaltransformchirpFrame) -> SignaltransformchirpFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformchirpFrame::copy(self : SignaltransformchirpFrame) -> SignaltransformchirpFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpFrame::fill(self : SignaltransformchirpFrame, v : Double) -> SignaltransformchirpFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpFrame::min(self : SignaltransformchirpFrame) -> Double { @_common.min(self.data) }

pub fn SignaltransformchirpFrame::max(self : SignaltransformchirpFrame) -> Double { @_common.max(self.data) }

pub fn SignaltransformchirpFrame::to_string(self : SignaltransformchirpFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_table_make(size : Int) -> SignaltransformchirpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformchirpTable::len(self : SignaltransformchirpTable) -> Int { self.size }

pub fn SignaltransformchirpTable::get(self : SignaltransformchirpTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformchirpTable::set(self : SignaltransformchirpTable, i : Int, v : Double) -> SignaltransformchirpTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpTable::sum(self : SignaltransformchirpTable) -> Double { @_common.sum(self.data) }

pub fn SignaltransformchirpTable::mean(self : SignaltransformchirpTable) -> Double { @_common.mean(self.data) }

pub fn SignaltransformchirpTable::scale(self : SignaltransformchirpTable, f : Double) -> SignaltransformchirpTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpTable::add(self : SignaltransformchirpTable, other : SignaltransformchirpTable) -> SignaltransformchirpTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformchirpTable::copy(self : SignaltransformchirpTable) -> SignaltransformchirpTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpTable::fill(self : SignaltransformchirpTable, v : Double) -> SignaltransformchirpTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpTable::min(self : SignaltransformchirpTable) -> Double { @_common.min(self.data) }

pub fn SignaltransformchirpTable::max(self : SignaltransformchirpTable) -> Double { @_common.max(self.data) }

pub fn SignaltransformchirpTable::to_string(self : SignaltransformchirpTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_graphn_make(size : Int) -> SignaltransformchirpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformchirpGraphN::len(self : SignaltransformchirpGraphN) -> Int { self.size }

pub fn SignaltransformchirpGraphN::get(self : SignaltransformchirpGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformchirpGraphN::set(self : SignaltransformchirpGraphN, i : Int, v : Double) -> SignaltransformchirpGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpGraphN::sum(self : SignaltransformchirpGraphN) -> Double { @_common.sum(self.data) }

pub fn SignaltransformchirpGraphN::mean(self : SignaltransformchirpGraphN) -> Double { @_common.mean(self.data) }

pub fn SignaltransformchirpGraphN::scale(self : SignaltransformchirpGraphN, f : Double) -> SignaltransformchirpGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpGraphN::add(self : SignaltransformchirpGraphN, other : SignaltransformchirpGraphN) -> SignaltransformchirpGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformchirpGraphN::copy(self : SignaltransformchirpGraphN) -> SignaltransformchirpGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpGraphN::fill(self : SignaltransformchirpGraphN, v : Double) -> SignaltransformchirpGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpGraphN::min(self : SignaltransformchirpGraphN) -> Double { @_common.min(self.data) }

pub fn SignaltransformchirpGraphN::max(self : SignaltransformchirpGraphN) -> Double { @_common.max(self.data) }

pub fn SignaltransformchirpGraphN::to_string(self : SignaltransformchirpGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_node_make(size : Int) -> SignaltransformchirpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformchirpNode::len(self : SignaltransformchirpNode) -> Int { self.size }

pub fn SignaltransformchirpNode::get(self : SignaltransformchirpNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformchirpNode::set(self : SignaltransformchirpNode, i : Int, v : Double) -> SignaltransformchirpNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpNode::sum(self : SignaltransformchirpNode) -> Double { @_common.sum(self.data) }

pub fn SignaltransformchirpNode::mean(self : SignaltransformchirpNode) -> Double { @_common.mean(self.data) }

pub fn SignaltransformchirpNode::scale(self : SignaltransformchirpNode, f : Double) -> SignaltransformchirpNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpNode::add(self : SignaltransformchirpNode, other : SignaltransformchirpNode) -> SignaltransformchirpNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformchirpNode::copy(self : SignaltransformchirpNode) -> SignaltransformchirpNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpNode::fill(self : SignaltransformchirpNode, v : Double) -> SignaltransformchirpNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpNode::min(self : SignaltransformchirpNode) -> Double { @_common.min(self.data) }

pub fn SignaltransformchirpNode::max(self : SignaltransformchirpNode) -> Double { @_common.max(self.data) }

pub fn SignaltransformchirpNode::to_string(self : SignaltransformchirpNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_edge_make(size : Int) -> SignaltransformchirpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformchirpEdge::len(self : SignaltransformchirpEdge) -> Int { self.size }

pub fn SignaltransformchirpEdge::get(self : SignaltransformchirpEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformchirpEdge::set(self : SignaltransformchirpEdge, i : Int, v : Double) -> SignaltransformchirpEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpEdge::sum(self : SignaltransformchirpEdge) -> Double { @_common.sum(self.data) }

pub fn SignaltransformchirpEdge::mean(self : SignaltransformchirpEdge) -> Double { @_common.mean(self.data) }

pub fn SignaltransformchirpEdge::scale(self : SignaltransformchirpEdge, f : Double) -> SignaltransformchirpEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpEdge::add(self : SignaltransformchirpEdge, other : SignaltransformchirpEdge) -> SignaltransformchirpEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformchirpEdge::copy(self : SignaltransformchirpEdge) -> SignaltransformchirpEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpEdge::fill(self : SignaltransformchirpEdge, v : Double) -> SignaltransformchirpEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpEdge::min(self : SignaltransformchirpEdge) -> Double { @_common.min(self.data) }

pub fn SignaltransformchirpEdge::max(self : SignaltransformchirpEdge) -> Double { @_common.max(self.data) }

pub fn SignaltransformchirpEdge::to_string(self : SignaltransformchirpEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_path_make(size : Int) -> SignaltransformchirpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformchirpPath::len(self : SignaltransformchirpPath) -> Int { self.size }

pub fn SignaltransformchirpPath::get(self : SignaltransformchirpPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformchirpPath::set(self : SignaltransformchirpPath, i : Int, v : Double) -> SignaltransformchirpPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpPath::sum(self : SignaltransformchirpPath) -> Double { @_common.sum(self.data) }

pub fn SignaltransformchirpPath::mean(self : SignaltransformchirpPath) -> Double { @_common.mean(self.data) }

pub fn SignaltransformchirpPath::scale(self : SignaltransformchirpPath, f : Double) -> SignaltransformchirpPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpPath::add(self : SignaltransformchirpPath, other : SignaltransformchirpPath) -> SignaltransformchirpPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformchirpPath::copy(self : SignaltransformchirpPath) -> SignaltransformchirpPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpPath::fill(self : SignaltransformchirpPath, v : Double) -> SignaltransformchirpPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpPath::min(self : SignaltransformchirpPath) -> Double { @_common.min(self.data) }

pub fn SignaltransformchirpPath::max(self : SignaltransformchirpPath) -> Double { @_common.max(self.data) }

pub fn SignaltransformchirpPath::to_string(self : SignaltransformchirpPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_cluster_make(size : Int) -> SignaltransformchirpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformchirpCluster::len(self : SignaltransformchirpCluster) -> Int { self.size }

pub fn SignaltransformchirpCluster::get(self : SignaltransformchirpCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformchirpCluster::set(self : SignaltransformchirpCluster, i : Int, v : Double) -> SignaltransformchirpCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpCluster::sum(self : SignaltransformchirpCluster) -> Double { @_common.sum(self.data) }

pub fn SignaltransformchirpCluster::mean(self : SignaltransformchirpCluster) -> Double { @_common.mean(self.data) }

pub fn SignaltransformchirpCluster::scale(self : SignaltransformchirpCluster, f : Double) -> SignaltransformchirpCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpCluster::add(self : SignaltransformchirpCluster, other : SignaltransformchirpCluster) -> SignaltransformchirpCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformchirpCluster::copy(self : SignaltransformchirpCluster) -> SignaltransformchirpCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpCluster::fill(self : SignaltransformchirpCluster, v : Double) -> SignaltransformchirpCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpCluster::min(self : SignaltransformchirpCluster) -> Double { @_common.min(self.data) }

pub fn SignaltransformchirpCluster::max(self : SignaltransformchirpCluster) -> Double { @_common.max(self.data) }

pub fn SignaltransformchirpCluster::to_string(self : SignaltransformchirpCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_model_make(size : Int) -> SignaltransformchirpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformchirpModel::len(self : SignaltransformchirpModel) -> Int { self.size }

pub fn SignaltransformchirpModel::get(self : SignaltransformchirpModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformchirpModel::set(self : SignaltransformchirpModel, i : Int, v : Double) -> SignaltransformchirpModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpModel::sum(self : SignaltransformchirpModel) -> Double { @_common.sum(self.data) }

pub fn SignaltransformchirpModel::mean(self : SignaltransformchirpModel) -> Double { @_common.mean(self.data) }

pub fn SignaltransformchirpModel::scale(self : SignaltransformchirpModel, f : Double) -> SignaltransformchirpModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpModel::add(self : SignaltransformchirpModel, other : SignaltransformchirpModel) -> SignaltransformchirpModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformchirpModel::copy(self : SignaltransformchirpModel) -> SignaltransformchirpModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpModel::fill(self : SignaltransformchirpModel, v : Double) -> SignaltransformchirpModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpModel::min(self : SignaltransformchirpModel) -> Double { @_common.min(self.data) }

pub fn SignaltransformchirpModel::max(self : SignaltransformchirpModel) -> Double { @_common.max(self.data) }

pub fn SignaltransformchirpModel::to_string(self : SignaltransformchirpModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_layer_make(size : Int) -> SignaltransformchirpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformchirpLayer::len(self : SignaltransformchirpLayer) -> Int { self.size }

pub fn SignaltransformchirpLayer::get(self : SignaltransformchirpLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformchirpLayer::set(self : SignaltransformchirpLayer, i : Int, v : Double) -> SignaltransformchirpLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpLayer::sum(self : SignaltransformchirpLayer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformchirpLayer::mean(self : SignaltransformchirpLayer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformchirpLayer::scale(self : SignaltransformchirpLayer, f : Double) -> SignaltransformchirpLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpLayer::add(self : SignaltransformchirpLayer, other : SignaltransformchirpLayer) -> SignaltransformchirpLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformchirpLayer::copy(self : SignaltransformchirpLayer) -> SignaltransformchirpLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpLayer::fill(self : SignaltransformchirpLayer, v : Double) -> SignaltransformchirpLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpLayer::min(self : SignaltransformchirpLayer) -> Double { @_common.min(self.data) }

pub fn SignaltransformchirpLayer::max(self : SignaltransformchirpLayer) -> Double { @_common.max(self.data) }

pub fn SignaltransformchirpLayer::to_string(self : SignaltransformchirpLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_buffer_make(size : Int) -> SignaltransformchirpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformchirpBuffer::len(self : SignaltransformchirpBuffer) -> Int { self.size }

pub fn SignaltransformchirpBuffer::get(self : SignaltransformchirpBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformchirpBuffer::set(self : SignaltransformchirpBuffer, i : Int, v : Double) -> SignaltransformchirpBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpBuffer::sum(self : SignaltransformchirpBuffer) -> Double { @_common.sum(self.data) }

pub fn SignaltransformchirpBuffer::mean(self : SignaltransformchirpBuffer) -> Double { @_common.mean(self.data) }

pub fn SignaltransformchirpBuffer::scale(self : SignaltransformchirpBuffer, f : Double) -> SignaltransformchirpBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpBuffer::add(self : SignaltransformchirpBuffer, other : SignaltransformchirpBuffer) -> SignaltransformchirpBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformchirpBuffer::copy(self : SignaltransformchirpBuffer) -> SignaltransformchirpBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpBuffer::fill(self : SignaltransformchirpBuffer, v : Double) -> SignaltransformchirpBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpBuffer::min(self : SignaltransformchirpBuffer) -> Double { @_common.min(self.data) }

pub fn SignaltransformchirpBuffer::max(self : SignaltransformchirpBuffer) -> Double { @_common.max(self.data) }

pub fn SignaltransformchirpBuffer::to_string(self : SignaltransformchirpBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_cursor_make(size : Int) -> SignaltransformchirpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformchirpCursor::len(self : SignaltransformchirpCursor) -> Int { self.size }

pub fn SignaltransformchirpCursor::get(self : SignaltransformchirpCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformchirpCursor::set(self : SignaltransformchirpCursor, i : Int, v : Double) -> SignaltransformchirpCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpCursor::sum(self : SignaltransformchirpCursor) -> Double { @_common.sum(self.data) }

pub fn SignaltransformchirpCursor::mean(self : SignaltransformchirpCursor) -> Double { @_common.mean(self.data) }

pub fn SignaltransformchirpCursor::scale(self : SignaltransformchirpCursor, f : Double) -> SignaltransformchirpCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpCursor::add(self : SignaltransformchirpCursor, other : SignaltransformchirpCursor) -> SignaltransformchirpCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformchirpCursor::copy(self : SignaltransformchirpCursor) -> SignaltransformchirpCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpCursor::fill(self : SignaltransformchirpCursor, v : Double) -> SignaltransformchirpCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpCursor::min(self : SignaltransformchirpCursor) -> Double { @_common.min(self.data) }

pub fn SignaltransformchirpCursor::max(self : SignaltransformchirpCursor) -> Double { @_common.max(self.data) }

pub fn SignaltransformchirpCursor::to_string(self : SignaltransformchirpCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_view_make(size : Int) -> SignaltransformchirpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformchirpView::len(self : SignaltransformchirpView) -> Int { self.size }

pub fn SignaltransformchirpView::get(self : SignaltransformchirpView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformchirpView::set(self : SignaltransformchirpView, i : Int, v : Double) -> SignaltransformchirpView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpView::sum(self : SignaltransformchirpView) -> Double { @_common.sum(self.data) }

pub fn SignaltransformchirpView::mean(self : SignaltransformchirpView) -> Double { @_common.mean(self.data) }

pub fn SignaltransformchirpView::scale(self : SignaltransformchirpView, f : Double) -> SignaltransformchirpView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpView::add(self : SignaltransformchirpView, other : SignaltransformchirpView) -> SignaltransformchirpView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformchirpView::copy(self : SignaltransformchirpView) -> SignaltransformchirpView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpView::fill(self : SignaltransformchirpView, v : Double) -> SignaltransformchirpView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpView::min(self : SignaltransformchirpView) -> Double { @_common.min(self.data) }

pub fn SignaltransformchirpView::max(self : SignaltransformchirpView) -> Double { @_common.max(self.data) }

pub fn SignaltransformchirpView::to_string(self : SignaltransformchirpView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_range_make(size : Int) -> SignaltransformchirpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformchirpRange::len(self : SignaltransformchirpRange) -> Int { self.size }

pub fn SignaltransformchirpRange::get(self : SignaltransformchirpRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformchirpRange::set(self : SignaltransformchirpRange, i : Int, v : Double) -> SignaltransformchirpRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpRange::sum(self : SignaltransformchirpRange) -> Double { @_common.sum(self.data) }

pub fn SignaltransformchirpRange::mean(self : SignaltransformchirpRange) -> Double { @_common.mean(self.data) }

pub fn SignaltransformchirpRange::scale(self : SignaltransformchirpRange, f : Double) -> SignaltransformchirpRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpRange::add(self : SignaltransformchirpRange, other : SignaltransformchirpRange) -> SignaltransformchirpRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformchirpRange::copy(self : SignaltransformchirpRange) -> SignaltransformchirpRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpRange::fill(self : SignaltransformchirpRange, v : Double) -> SignaltransformchirpRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpRange::min(self : SignaltransformchirpRange) -> Double { @_common.min(self.data) }

pub fn SignaltransformchirpRange::max(self : SignaltransformchirpRange) -> Double { @_common.max(self.data) }

pub fn SignaltransformchirpRange::to_string(self : SignaltransformchirpRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SignaltransformchirpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn signal_transform_chirp_slice_make(size : Int) -> SignaltransformchirpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SignaltransformchirpSlice::len(self : SignaltransformchirpSlice) -> Int { self.size }

pub fn SignaltransformchirpSlice::get(self : SignaltransformchirpSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SignaltransformchirpSlice::set(self : SignaltransformchirpSlice, i : Int, v : Double) -> SignaltransformchirpSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpSlice::sum(self : SignaltransformchirpSlice) -> Double { @_common.sum(self.data) }

pub fn SignaltransformchirpSlice::mean(self : SignaltransformchirpSlice) -> Double { @_common.mean(self.data) }

pub fn SignaltransformchirpSlice::scale(self : SignaltransformchirpSlice, f : Double) -> SignaltransformchirpSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpSlice::add(self : SignaltransformchirpSlice, other : SignaltransformchirpSlice) -> SignaltransformchirpSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SignaltransformchirpSlice::copy(self : SignaltransformchirpSlice) -> SignaltransformchirpSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpSlice::fill(self : SignaltransformchirpSlice, v : Double) -> SignaltransformchirpSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SignaltransformchirpSlice::min(self : SignaltransformchirpSlice) -> Double { @_common.min(self.data) }

pub fn SignaltransformchirpSlice::max(self : SignaltransformchirpSlice) -> Double { @_common.max(self.data) }

pub fn SignaltransformchirpSlice::to_string(self : SignaltransformchirpSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

