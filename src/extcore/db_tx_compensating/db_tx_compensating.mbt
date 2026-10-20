///===
/// extcore/db_tx_compensating

pub(all) struct DbtxcompensatingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_compensating_make_point(x : Double, y : Double) -> DbtxcompensatingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_compensating_make_point3(x : Double, y : Double, z : Double) -> DbtxcompensatingPoint {
  { x, y, z, label: 0 }
}

pub fn DbtxcompensatingPoint::x(self : DbtxcompensatingPoint) -> Double { self.x }

pub fn DbtxcompensatingPoint::y(self : DbtxcompensatingPoint) -> Double { self.y }

pub fn DbtxcompensatingPoint::z(self : DbtxcompensatingPoint) -> Double { self.z }

pub fn DbtxcompensatingPoint::label(self : DbtxcompensatingPoint) -> Int { self.label }

pub fn DbtxcompensatingPoint::dist(self : DbtxcompensatingPoint, other : DbtxcompensatingPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbtxcompensatingPoint::add(self : DbtxcompensatingPoint, other : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbtxcompensatingPoint::sub(self : DbtxcompensatingPoint, other : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbtxcompensatingPoint::scale(self : DbtxcompensatingPoint, s : Double) -> DbtxcompensatingPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbtxcompensatingPoint::dot(self : DbtxcompensatingPoint, other : DbtxcompensatingPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbtxcompensatingPoint::cross(self : DbtxcompensatingPoint, other : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbtxcompensatingPoint::norm(self : DbtxcompensatingPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbtxcompensatingPoint::normalize(self : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxcompensatingPoint::negate(self : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbtxcompensatingPoint::mid(self : DbtxcompensatingPoint, other : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbtxcompensatingPoint::lerp(self : DbtxcompensatingPoint, other : DbtxcompensatingPoint, t : Double) -> DbtxcompensatingPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbtxcompensatingPoint::to_string(self : DbtxcompensatingPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbtxcompensatingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_compensating_make_series(vals : Array[Double], name : String) -> DbtxcompensatingSeries {
  { vals, name, meta: 0 }
}

pub fn DbtxcompensatingSeries::len(self : DbtxcompensatingSeries) -> Int { self.vals.length() }

pub fn DbtxcompensatingSeries::sum(self : DbtxcompensatingSeries) -> Double { @_common.sum(self.vals) }

pub fn DbtxcompensatingSeries::mean(self : DbtxcompensatingSeries) -> Double { @_common.mean(self.vals) }

pub fn DbtxcompensatingSeries::min(self : DbtxcompensatingSeries) -> Double { @_common.min(self.vals) }

pub fn DbtxcompensatingSeries::max(self : DbtxcompensatingSeries) -> Double { @_common.max(self.vals) }

pub fn DbtxcompensatingSeries::range(self : DbtxcompensatingSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbtxcompensatingSeries::variance(self : DbtxcompensatingSeries) -> Double { @_common.variance(self.vals) }

pub fn DbtxcompensatingSeries::std(self : DbtxcompensatingSeries) -> Double { @_common.std(self.vals) }

pub fn DbtxcompensatingSeries::median(self : DbtxcompensatingSeries) -> Double { @_common.median(self.vals) }

pub fn DbtxcompensatingSeries::scale(self : DbtxcompensatingSeries, f : Double) -> DbtxcompensatingSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbtxcompensatingSeries::add(self : DbtxcompensatingSeries, other : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbtxcompensatingSeries::sub(self : DbtxcompensatingSeries, other : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbtxcompensatingSeries::normalize(self : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbtxcompensatingSeries::cumsum(self : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbtxcompensatingSeries::to_string(self : DbtxcompensatingSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxcompensatingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_compensating_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxcompensatingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_compensating_matrix_identity(n : Int) -> DbtxcompensatingMatrix {
  let m = db_tx_compensating_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbtxcompensatingMatrix::get(self : DbtxcompensatingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbtxcompensatingMatrix::transpose(self : DbtxcompensatingMatrix) -> DbtxcompensatingMatrix {
  let result = db_tx_compensating_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbtxcompensatingMatrix::add(self : DbtxcompensatingMatrix, other : DbtxcompensatingMatrix) -> DbtxcompensatingMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_compensating_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbtxcompensatingMatrix::scale(self : DbtxcompensatingMatrix, s : Double) -> DbtxcompensatingMatrix {
  let result = db_tx_compensating_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbtxcompensatingMatrix::multiply(self : DbtxcompensatingMatrix, other : DbtxcompensatingMatrix) -> DbtxcompensatingMatrix {
  if self.cols != other.rows { return db_tx_compensating_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_compensating_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbtxcompensatingMatrix::trace(self : DbtxcompensatingMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbtxcompensatingMatrix::det(self : DbtxcompensatingMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbtxcompensatingMatrix::norm(self : DbtxcompensatingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbtxcompensatingMatrix::to_string(self : DbtxcompensatingMatrix) -> String {
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

pub(all) struct DbtxcompensatingVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_compensating_make_vector(comps : Array[Double]) -> DbtxcompensatingVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_compensating_vector_zero(dim : Int) -> DbtxcompensatingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbtxcompensatingVector::add(self : DbtxcompensatingVector, other : DbtxcompensatingVector) -> DbtxcompensatingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxcompensatingVector::sub(self : DbtxcompensatingVector, other : DbtxcompensatingVector) -> DbtxcompensatingVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxcompensatingVector::scale(self : DbtxcompensatingVector, s : Double) -> DbtxcompensatingVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbtxcompensatingVector::dot(self : DbtxcompensatingVector, other : DbtxcompensatingVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbtxcompensatingVector::norm(self : DbtxcompensatingVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbtxcompensatingVector::normalize(self : DbtxcompensatingVector) -> DbtxcompensatingVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxcompensatingVector::dist(self : DbtxcompensatingVector, other : DbtxcompensatingVector) -> Double {
  self.sub(other).norm()
}

pub fn DbtxcompensatingVector::to_string(self : DbtxcompensatingVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_compensating_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_compensating_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_compensating_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_compensating_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_compensating_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_compensating_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_compensating_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_compensating_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_compensating_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_compensating_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_compensating_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_compensating_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_compensating_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_compensating_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_compensating_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_compensating_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_compensating_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_compensating_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_compensating_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_compensating_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_compensating_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_compensating_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_compensating_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_compensating_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_compensating_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_compensating_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_compensating_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_compensating_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_compensating_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxcompensatingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_frame_make(size : Int) -> DbtxcompensatingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxcompensatingFrame::len(self : DbtxcompensatingFrame) -> Int { self.size }

pub fn DbtxcompensatingFrame::get(self : DbtxcompensatingFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxcompensatingFrame::set(self : DbtxcompensatingFrame, i : Int, v : Double) -> DbtxcompensatingFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingFrame::sum(self : DbtxcompensatingFrame) -> Double { @_common.sum(self.data) }

pub fn DbtxcompensatingFrame::mean(self : DbtxcompensatingFrame) -> Double { @_common.mean(self.data) }

pub fn DbtxcompensatingFrame::scale(self : DbtxcompensatingFrame, f : Double) -> DbtxcompensatingFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingFrame::add(self : DbtxcompensatingFrame, other : DbtxcompensatingFrame) -> DbtxcompensatingFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxcompensatingFrame::copy(self : DbtxcompensatingFrame) -> DbtxcompensatingFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingFrame::fill(self : DbtxcompensatingFrame, v : Double) -> DbtxcompensatingFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingFrame::min(self : DbtxcompensatingFrame) -> Double { @_common.min(self.data) }

pub fn DbtxcompensatingFrame::max(self : DbtxcompensatingFrame) -> Double { @_common.max(self.data) }

pub fn DbtxcompensatingFrame::to_string(self : DbtxcompensatingFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_table_make(size : Int) -> DbtxcompensatingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxcompensatingTable::len(self : DbtxcompensatingTable) -> Int { self.size }

pub fn DbtxcompensatingTable::get(self : DbtxcompensatingTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxcompensatingTable::set(self : DbtxcompensatingTable, i : Int, v : Double) -> DbtxcompensatingTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingTable::sum(self : DbtxcompensatingTable) -> Double { @_common.sum(self.data) }

pub fn DbtxcompensatingTable::mean(self : DbtxcompensatingTable) -> Double { @_common.mean(self.data) }

pub fn DbtxcompensatingTable::scale(self : DbtxcompensatingTable, f : Double) -> DbtxcompensatingTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingTable::add(self : DbtxcompensatingTable, other : DbtxcompensatingTable) -> DbtxcompensatingTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxcompensatingTable::copy(self : DbtxcompensatingTable) -> DbtxcompensatingTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingTable::fill(self : DbtxcompensatingTable, v : Double) -> DbtxcompensatingTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingTable::min(self : DbtxcompensatingTable) -> Double { @_common.min(self.data) }

pub fn DbtxcompensatingTable::max(self : DbtxcompensatingTable) -> Double { @_common.max(self.data) }

pub fn DbtxcompensatingTable::to_string(self : DbtxcompensatingTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_graphn_make(size : Int) -> DbtxcompensatingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxcompensatingGraphN::len(self : DbtxcompensatingGraphN) -> Int { self.size }

pub fn DbtxcompensatingGraphN::get(self : DbtxcompensatingGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxcompensatingGraphN::set(self : DbtxcompensatingGraphN, i : Int, v : Double) -> DbtxcompensatingGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingGraphN::sum(self : DbtxcompensatingGraphN) -> Double { @_common.sum(self.data) }

pub fn DbtxcompensatingGraphN::mean(self : DbtxcompensatingGraphN) -> Double { @_common.mean(self.data) }

pub fn DbtxcompensatingGraphN::scale(self : DbtxcompensatingGraphN, f : Double) -> DbtxcompensatingGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingGraphN::add(self : DbtxcompensatingGraphN, other : DbtxcompensatingGraphN) -> DbtxcompensatingGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxcompensatingGraphN::copy(self : DbtxcompensatingGraphN) -> DbtxcompensatingGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingGraphN::fill(self : DbtxcompensatingGraphN, v : Double) -> DbtxcompensatingGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingGraphN::min(self : DbtxcompensatingGraphN) -> Double { @_common.min(self.data) }

pub fn DbtxcompensatingGraphN::max(self : DbtxcompensatingGraphN) -> Double { @_common.max(self.data) }

pub fn DbtxcompensatingGraphN::to_string(self : DbtxcompensatingGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_node_make(size : Int) -> DbtxcompensatingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxcompensatingNode::len(self : DbtxcompensatingNode) -> Int { self.size }

pub fn DbtxcompensatingNode::get(self : DbtxcompensatingNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxcompensatingNode::set(self : DbtxcompensatingNode, i : Int, v : Double) -> DbtxcompensatingNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingNode::sum(self : DbtxcompensatingNode) -> Double { @_common.sum(self.data) }

pub fn DbtxcompensatingNode::mean(self : DbtxcompensatingNode) -> Double { @_common.mean(self.data) }

pub fn DbtxcompensatingNode::scale(self : DbtxcompensatingNode, f : Double) -> DbtxcompensatingNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingNode::add(self : DbtxcompensatingNode, other : DbtxcompensatingNode) -> DbtxcompensatingNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxcompensatingNode::copy(self : DbtxcompensatingNode) -> DbtxcompensatingNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingNode::fill(self : DbtxcompensatingNode, v : Double) -> DbtxcompensatingNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingNode::min(self : DbtxcompensatingNode) -> Double { @_common.min(self.data) }

pub fn DbtxcompensatingNode::max(self : DbtxcompensatingNode) -> Double { @_common.max(self.data) }

pub fn DbtxcompensatingNode::to_string(self : DbtxcompensatingNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_edge_make(size : Int) -> DbtxcompensatingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxcompensatingEdge::len(self : DbtxcompensatingEdge) -> Int { self.size }

pub fn DbtxcompensatingEdge::get(self : DbtxcompensatingEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxcompensatingEdge::set(self : DbtxcompensatingEdge, i : Int, v : Double) -> DbtxcompensatingEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingEdge::sum(self : DbtxcompensatingEdge) -> Double { @_common.sum(self.data) }

pub fn DbtxcompensatingEdge::mean(self : DbtxcompensatingEdge) -> Double { @_common.mean(self.data) }

pub fn DbtxcompensatingEdge::scale(self : DbtxcompensatingEdge, f : Double) -> DbtxcompensatingEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingEdge::add(self : DbtxcompensatingEdge, other : DbtxcompensatingEdge) -> DbtxcompensatingEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxcompensatingEdge::copy(self : DbtxcompensatingEdge) -> DbtxcompensatingEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingEdge::fill(self : DbtxcompensatingEdge, v : Double) -> DbtxcompensatingEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingEdge::min(self : DbtxcompensatingEdge) -> Double { @_common.min(self.data) }

pub fn DbtxcompensatingEdge::max(self : DbtxcompensatingEdge) -> Double { @_common.max(self.data) }

pub fn DbtxcompensatingEdge::to_string(self : DbtxcompensatingEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_path_make(size : Int) -> DbtxcompensatingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxcompensatingPath::len(self : DbtxcompensatingPath) -> Int { self.size }

pub fn DbtxcompensatingPath::get(self : DbtxcompensatingPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxcompensatingPath::set(self : DbtxcompensatingPath, i : Int, v : Double) -> DbtxcompensatingPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingPath::sum(self : DbtxcompensatingPath) -> Double { @_common.sum(self.data) }

pub fn DbtxcompensatingPath::mean(self : DbtxcompensatingPath) -> Double { @_common.mean(self.data) }

pub fn DbtxcompensatingPath::scale(self : DbtxcompensatingPath, f : Double) -> DbtxcompensatingPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingPath::add(self : DbtxcompensatingPath, other : DbtxcompensatingPath) -> DbtxcompensatingPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxcompensatingPath::copy(self : DbtxcompensatingPath) -> DbtxcompensatingPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingPath::fill(self : DbtxcompensatingPath, v : Double) -> DbtxcompensatingPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingPath::min(self : DbtxcompensatingPath) -> Double { @_common.min(self.data) }

pub fn DbtxcompensatingPath::max(self : DbtxcompensatingPath) -> Double { @_common.max(self.data) }

pub fn DbtxcompensatingPath::to_string(self : DbtxcompensatingPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_cluster_make(size : Int) -> DbtxcompensatingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxcompensatingCluster::len(self : DbtxcompensatingCluster) -> Int { self.size }

pub fn DbtxcompensatingCluster::get(self : DbtxcompensatingCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxcompensatingCluster::set(self : DbtxcompensatingCluster, i : Int, v : Double) -> DbtxcompensatingCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingCluster::sum(self : DbtxcompensatingCluster) -> Double { @_common.sum(self.data) }

pub fn DbtxcompensatingCluster::mean(self : DbtxcompensatingCluster) -> Double { @_common.mean(self.data) }

pub fn DbtxcompensatingCluster::scale(self : DbtxcompensatingCluster, f : Double) -> DbtxcompensatingCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingCluster::add(self : DbtxcompensatingCluster, other : DbtxcompensatingCluster) -> DbtxcompensatingCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxcompensatingCluster::copy(self : DbtxcompensatingCluster) -> DbtxcompensatingCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingCluster::fill(self : DbtxcompensatingCluster, v : Double) -> DbtxcompensatingCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingCluster::min(self : DbtxcompensatingCluster) -> Double { @_common.min(self.data) }

pub fn DbtxcompensatingCluster::max(self : DbtxcompensatingCluster) -> Double { @_common.max(self.data) }

pub fn DbtxcompensatingCluster::to_string(self : DbtxcompensatingCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_model_make(size : Int) -> DbtxcompensatingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxcompensatingModel::len(self : DbtxcompensatingModel) -> Int { self.size }

pub fn DbtxcompensatingModel::get(self : DbtxcompensatingModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxcompensatingModel::set(self : DbtxcompensatingModel, i : Int, v : Double) -> DbtxcompensatingModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingModel::sum(self : DbtxcompensatingModel) -> Double { @_common.sum(self.data) }

pub fn DbtxcompensatingModel::mean(self : DbtxcompensatingModel) -> Double { @_common.mean(self.data) }

pub fn DbtxcompensatingModel::scale(self : DbtxcompensatingModel, f : Double) -> DbtxcompensatingModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingModel::add(self : DbtxcompensatingModel, other : DbtxcompensatingModel) -> DbtxcompensatingModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxcompensatingModel::copy(self : DbtxcompensatingModel) -> DbtxcompensatingModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingModel::fill(self : DbtxcompensatingModel, v : Double) -> DbtxcompensatingModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingModel::min(self : DbtxcompensatingModel) -> Double { @_common.min(self.data) }

pub fn DbtxcompensatingModel::max(self : DbtxcompensatingModel) -> Double { @_common.max(self.data) }

pub fn DbtxcompensatingModel::to_string(self : DbtxcompensatingModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_layer_make(size : Int) -> DbtxcompensatingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxcompensatingLayer::len(self : DbtxcompensatingLayer) -> Int { self.size }

pub fn DbtxcompensatingLayer::get(self : DbtxcompensatingLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxcompensatingLayer::set(self : DbtxcompensatingLayer, i : Int, v : Double) -> DbtxcompensatingLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingLayer::sum(self : DbtxcompensatingLayer) -> Double { @_common.sum(self.data) }

pub fn DbtxcompensatingLayer::mean(self : DbtxcompensatingLayer) -> Double { @_common.mean(self.data) }

pub fn DbtxcompensatingLayer::scale(self : DbtxcompensatingLayer, f : Double) -> DbtxcompensatingLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingLayer::add(self : DbtxcompensatingLayer, other : DbtxcompensatingLayer) -> DbtxcompensatingLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxcompensatingLayer::copy(self : DbtxcompensatingLayer) -> DbtxcompensatingLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingLayer::fill(self : DbtxcompensatingLayer, v : Double) -> DbtxcompensatingLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingLayer::min(self : DbtxcompensatingLayer) -> Double { @_common.min(self.data) }

pub fn DbtxcompensatingLayer::max(self : DbtxcompensatingLayer) -> Double { @_common.max(self.data) }

pub fn DbtxcompensatingLayer::to_string(self : DbtxcompensatingLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_buffer_make(size : Int) -> DbtxcompensatingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxcompensatingBuffer::len(self : DbtxcompensatingBuffer) -> Int { self.size }

pub fn DbtxcompensatingBuffer::get(self : DbtxcompensatingBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxcompensatingBuffer::set(self : DbtxcompensatingBuffer, i : Int, v : Double) -> DbtxcompensatingBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingBuffer::sum(self : DbtxcompensatingBuffer) -> Double { @_common.sum(self.data) }

pub fn DbtxcompensatingBuffer::mean(self : DbtxcompensatingBuffer) -> Double { @_common.mean(self.data) }

pub fn DbtxcompensatingBuffer::scale(self : DbtxcompensatingBuffer, f : Double) -> DbtxcompensatingBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingBuffer::add(self : DbtxcompensatingBuffer, other : DbtxcompensatingBuffer) -> DbtxcompensatingBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxcompensatingBuffer::copy(self : DbtxcompensatingBuffer) -> DbtxcompensatingBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingBuffer::fill(self : DbtxcompensatingBuffer, v : Double) -> DbtxcompensatingBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingBuffer::min(self : DbtxcompensatingBuffer) -> Double { @_common.min(self.data) }

pub fn DbtxcompensatingBuffer::max(self : DbtxcompensatingBuffer) -> Double { @_common.max(self.data) }

pub fn DbtxcompensatingBuffer::to_string(self : DbtxcompensatingBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_cursor_make(size : Int) -> DbtxcompensatingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxcompensatingCursor::len(self : DbtxcompensatingCursor) -> Int { self.size }

pub fn DbtxcompensatingCursor::get(self : DbtxcompensatingCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxcompensatingCursor::set(self : DbtxcompensatingCursor, i : Int, v : Double) -> DbtxcompensatingCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingCursor::sum(self : DbtxcompensatingCursor) -> Double { @_common.sum(self.data) }

pub fn DbtxcompensatingCursor::mean(self : DbtxcompensatingCursor) -> Double { @_common.mean(self.data) }

pub fn DbtxcompensatingCursor::scale(self : DbtxcompensatingCursor, f : Double) -> DbtxcompensatingCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingCursor::add(self : DbtxcompensatingCursor, other : DbtxcompensatingCursor) -> DbtxcompensatingCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxcompensatingCursor::copy(self : DbtxcompensatingCursor) -> DbtxcompensatingCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingCursor::fill(self : DbtxcompensatingCursor, v : Double) -> DbtxcompensatingCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingCursor::min(self : DbtxcompensatingCursor) -> Double { @_common.min(self.data) }

pub fn DbtxcompensatingCursor::max(self : DbtxcompensatingCursor) -> Double { @_common.max(self.data) }

pub fn DbtxcompensatingCursor::to_string(self : DbtxcompensatingCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_view_make(size : Int) -> DbtxcompensatingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxcompensatingView::len(self : DbtxcompensatingView) -> Int { self.size }

pub fn DbtxcompensatingView::get(self : DbtxcompensatingView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxcompensatingView::set(self : DbtxcompensatingView, i : Int, v : Double) -> DbtxcompensatingView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingView::sum(self : DbtxcompensatingView) -> Double { @_common.sum(self.data) }

pub fn DbtxcompensatingView::mean(self : DbtxcompensatingView) -> Double { @_common.mean(self.data) }

pub fn DbtxcompensatingView::scale(self : DbtxcompensatingView, f : Double) -> DbtxcompensatingView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingView::add(self : DbtxcompensatingView, other : DbtxcompensatingView) -> DbtxcompensatingView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxcompensatingView::copy(self : DbtxcompensatingView) -> DbtxcompensatingView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingView::fill(self : DbtxcompensatingView, v : Double) -> DbtxcompensatingView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingView::min(self : DbtxcompensatingView) -> Double { @_common.min(self.data) }

pub fn DbtxcompensatingView::max(self : DbtxcompensatingView) -> Double { @_common.max(self.data) }

pub fn DbtxcompensatingView::to_string(self : DbtxcompensatingView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_range_make(size : Int) -> DbtxcompensatingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxcompensatingRange::len(self : DbtxcompensatingRange) -> Int { self.size }

pub fn DbtxcompensatingRange::get(self : DbtxcompensatingRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxcompensatingRange::set(self : DbtxcompensatingRange, i : Int, v : Double) -> DbtxcompensatingRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingRange::sum(self : DbtxcompensatingRange) -> Double { @_common.sum(self.data) }

pub fn DbtxcompensatingRange::mean(self : DbtxcompensatingRange) -> Double { @_common.mean(self.data) }

pub fn DbtxcompensatingRange::scale(self : DbtxcompensatingRange, f : Double) -> DbtxcompensatingRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingRange::add(self : DbtxcompensatingRange, other : DbtxcompensatingRange) -> DbtxcompensatingRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxcompensatingRange::copy(self : DbtxcompensatingRange) -> DbtxcompensatingRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingRange::fill(self : DbtxcompensatingRange, v : Double) -> DbtxcompensatingRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingRange::min(self : DbtxcompensatingRange) -> Double { @_common.min(self.data) }

pub fn DbtxcompensatingRange::max(self : DbtxcompensatingRange) -> Double { @_common.max(self.data) }

pub fn DbtxcompensatingRange::to_string(self : DbtxcompensatingRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_slice_make(size : Int) -> DbtxcompensatingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxcompensatingSlice::len(self : DbtxcompensatingSlice) -> Int { self.size }

pub fn DbtxcompensatingSlice::get(self : DbtxcompensatingSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxcompensatingSlice::set(self : DbtxcompensatingSlice, i : Int, v : Double) -> DbtxcompensatingSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingSlice::sum(self : DbtxcompensatingSlice) -> Double { @_common.sum(self.data) }

pub fn DbtxcompensatingSlice::mean(self : DbtxcompensatingSlice) -> Double { @_common.mean(self.data) }

pub fn DbtxcompensatingSlice::scale(self : DbtxcompensatingSlice, f : Double) -> DbtxcompensatingSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingSlice::add(self : DbtxcompensatingSlice, other : DbtxcompensatingSlice) -> DbtxcompensatingSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxcompensatingSlice::copy(self : DbtxcompensatingSlice) -> DbtxcompensatingSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingSlice::fill(self : DbtxcompensatingSlice, v : Double) -> DbtxcompensatingSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxcompensatingSlice::min(self : DbtxcompensatingSlice) -> Double { @_common.min(self.data) }

pub fn DbtxcompensatingSlice::max(self : DbtxcompensatingSlice) -> Double { @_common.max(self.data) }

pub fn DbtxcompensatingSlice::to_string(self : DbtxcompensatingSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

