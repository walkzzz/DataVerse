///===
/// extcore/db_tx_pessimistic

pub(all) struct DbtxpessimisticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_pessimistic_make_point(x : Double, y : Double) -> DbtxpessimisticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_pessimistic_make_point3(x : Double, y : Double, z : Double) -> DbtxpessimisticPoint {
  { x, y, z, label: 0 }
}

pub fn DbtxpessimisticPoint::x(self : DbtxpessimisticPoint) -> Double { self.x }

pub fn DbtxpessimisticPoint::y(self : DbtxpessimisticPoint) -> Double { self.y }

pub fn DbtxpessimisticPoint::z(self : DbtxpessimisticPoint) -> Double { self.z }

pub fn DbtxpessimisticPoint::label(self : DbtxpessimisticPoint) -> Int { self.label }

pub fn DbtxpessimisticPoint::dist(self : DbtxpessimisticPoint, other : DbtxpessimisticPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DbtxpessimisticPoint::add(self : DbtxpessimisticPoint, other : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DbtxpessimisticPoint::sub(self : DbtxpessimisticPoint, other : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DbtxpessimisticPoint::scale(self : DbtxpessimisticPoint, s : Double) -> DbtxpessimisticPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DbtxpessimisticPoint::dot(self : DbtxpessimisticPoint, other : DbtxpessimisticPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DbtxpessimisticPoint::cross(self : DbtxpessimisticPoint, other : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DbtxpessimisticPoint::norm(self : DbtxpessimisticPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DbtxpessimisticPoint::normalize(self : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxpessimisticPoint::negate(self : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DbtxpessimisticPoint::mid(self : DbtxpessimisticPoint, other : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DbtxpessimisticPoint::lerp(self : DbtxpessimisticPoint, other : DbtxpessimisticPoint, t : Double) -> DbtxpessimisticPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DbtxpessimisticPoint::to_string(self : DbtxpessimisticPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DbtxpessimisticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_pessimistic_make_series(vals : Array[Double], name : String) -> DbtxpessimisticSeries {
  { vals, name, meta: 0 }
}

pub fn DbtxpessimisticSeries::len(self : DbtxpessimisticSeries) -> Int { self.vals.length() }

pub fn DbtxpessimisticSeries::sum(self : DbtxpessimisticSeries) -> Double { @_common.sum(self.vals) }

pub fn DbtxpessimisticSeries::mean(self : DbtxpessimisticSeries) -> Double { @_common.mean(self.vals) }

pub fn DbtxpessimisticSeries::min(self : DbtxpessimisticSeries) -> Double { @_common.min(self.vals) }

pub fn DbtxpessimisticSeries::max(self : DbtxpessimisticSeries) -> Double { @_common.max(self.vals) }

pub fn DbtxpessimisticSeries::range(self : DbtxpessimisticSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DbtxpessimisticSeries::variance(self : DbtxpessimisticSeries) -> Double { @_common.variance(self.vals) }

pub fn DbtxpessimisticSeries::std(self : DbtxpessimisticSeries) -> Double { @_common.std(self.vals) }

pub fn DbtxpessimisticSeries::median(self : DbtxpessimisticSeries) -> Double { @_common.median(self.vals) }

pub fn DbtxpessimisticSeries::scale(self : DbtxpessimisticSeries, f : Double) -> DbtxpessimisticSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DbtxpessimisticSeries::add(self : DbtxpessimisticSeries, other : DbtxpessimisticSeries) -> DbtxpessimisticSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DbtxpessimisticSeries::sub(self : DbtxpessimisticSeries, other : DbtxpessimisticSeries) -> DbtxpessimisticSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DbtxpessimisticSeries::normalize(self : DbtxpessimisticSeries) -> DbtxpessimisticSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DbtxpessimisticSeries::cumsum(self : DbtxpessimisticSeries) -> DbtxpessimisticSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DbtxpessimisticSeries::to_string(self : DbtxpessimisticSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxpessimisticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_pessimistic_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxpessimisticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_pessimistic_matrix_identity(n : Int) -> DbtxpessimisticMatrix {
  let m = db_tx_pessimistic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DbtxpessimisticMatrix::get(self : DbtxpessimisticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DbtxpessimisticMatrix::transpose(self : DbtxpessimisticMatrix) -> DbtxpessimisticMatrix {
  let result = db_tx_pessimistic_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DbtxpessimisticMatrix::add(self : DbtxpessimisticMatrix, other : DbtxpessimisticMatrix) -> DbtxpessimisticMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_pessimistic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DbtxpessimisticMatrix::scale(self : DbtxpessimisticMatrix, s : Double) -> DbtxpessimisticMatrix {
  let result = db_tx_pessimistic_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DbtxpessimisticMatrix::multiply(self : DbtxpessimisticMatrix, other : DbtxpessimisticMatrix) -> DbtxpessimisticMatrix {
  if self.cols != other.rows { return db_tx_pessimistic_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_pessimistic_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DbtxpessimisticMatrix::trace(self : DbtxpessimisticMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DbtxpessimisticMatrix::det(self : DbtxpessimisticMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DbtxpessimisticMatrix::norm(self : DbtxpessimisticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DbtxpessimisticMatrix::to_string(self : DbtxpessimisticMatrix) -> String {
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

pub(all) struct DbtxpessimisticVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_pessimistic_make_vector(comps : Array[Double]) -> DbtxpessimisticVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_pessimistic_vector_zero(dim : Int) -> DbtxpessimisticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DbtxpessimisticVector::add(self : DbtxpessimisticVector, other : DbtxpessimisticVector) -> DbtxpessimisticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxpessimisticVector::sub(self : DbtxpessimisticVector, other : DbtxpessimisticVector) -> DbtxpessimisticVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DbtxpessimisticVector::scale(self : DbtxpessimisticVector, s : Double) -> DbtxpessimisticVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DbtxpessimisticVector::dot(self : DbtxpessimisticVector, other : DbtxpessimisticVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DbtxpessimisticVector::norm(self : DbtxpessimisticVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DbtxpessimisticVector::normalize(self : DbtxpessimisticVector) -> DbtxpessimisticVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DbtxpessimisticVector::dist(self : DbtxpessimisticVector, other : DbtxpessimisticVector) -> Double {
  self.sub(other).norm()
}

pub fn DbtxpessimisticVector::to_string(self : DbtxpessimisticVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_pessimistic_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_pessimistic_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_pessimistic_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_pessimistic_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_pessimistic_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_pessimistic_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_pessimistic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_pessimistic_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_pessimistic_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_pessimistic_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_pessimistic_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_pessimistic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_pessimistic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_pessimistic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_pessimistic_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_pessimistic_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_pessimistic_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_pessimistic_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_pessimistic_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_pessimistic_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_pessimistic_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_pessimistic_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_pessimistic_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_pessimistic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_pessimistic_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_pessimistic_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_pessimistic_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_pessimistic_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_pessimistic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DbtxpessimisticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_frame_make(size : Int) -> DbtxpessimisticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxpessimisticFrame::len(self : DbtxpessimisticFrame) -> Int { self.size }

pub fn DbtxpessimisticFrame::get(self : DbtxpessimisticFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxpessimisticFrame::set(self : DbtxpessimisticFrame, i : Int, v : Double) -> DbtxpessimisticFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticFrame::sum(self : DbtxpessimisticFrame) -> Double { @_common.sum(self.data) }

pub fn DbtxpessimisticFrame::mean(self : DbtxpessimisticFrame) -> Double { @_common.mean(self.data) }

pub fn DbtxpessimisticFrame::scale(self : DbtxpessimisticFrame, f : Double) -> DbtxpessimisticFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticFrame::add(self : DbtxpessimisticFrame, other : DbtxpessimisticFrame) -> DbtxpessimisticFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxpessimisticFrame::copy(self : DbtxpessimisticFrame) -> DbtxpessimisticFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticFrame::fill(self : DbtxpessimisticFrame, v : Double) -> DbtxpessimisticFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticFrame::min(self : DbtxpessimisticFrame) -> Double { @_common.min(self.data) }

pub fn DbtxpessimisticFrame::max(self : DbtxpessimisticFrame) -> Double { @_common.max(self.data) }

pub fn DbtxpessimisticFrame::to_string(self : DbtxpessimisticFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_table_make(size : Int) -> DbtxpessimisticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxpessimisticTable::len(self : DbtxpessimisticTable) -> Int { self.size }

pub fn DbtxpessimisticTable::get(self : DbtxpessimisticTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxpessimisticTable::set(self : DbtxpessimisticTable, i : Int, v : Double) -> DbtxpessimisticTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticTable::sum(self : DbtxpessimisticTable) -> Double { @_common.sum(self.data) }

pub fn DbtxpessimisticTable::mean(self : DbtxpessimisticTable) -> Double { @_common.mean(self.data) }

pub fn DbtxpessimisticTable::scale(self : DbtxpessimisticTable, f : Double) -> DbtxpessimisticTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticTable::add(self : DbtxpessimisticTable, other : DbtxpessimisticTable) -> DbtxpessimisticTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxpessimisticTable::copy(self : DbtxpessimisticTable) -> DbtxpessimisticTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticTable::fill(self : DbtxpessimisticTable, v : Double) -> DbtxpessimisticTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticTable::min(self : DbtxpessimisticTable) -> Double { @_common.min(self.data) }

pub fn DbtxpessimisticTable::max(self : DbtxpessimisticTable) -> Double { @_common.max(self.data) }

pub fn DbtxpessimisticTable::to_string(self : DbtxpessimisticTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_graphn_make(size : Int) -> DbtxpessimisticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxpessimisticGraphN::len(self : DbtxpessimisticGraphN) -> Int { self.size }

pub fn DbtxpessimisticGraphN::get(self : DbtxpessimisticGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxpessimisticGraphN::set(self : DbtxpessimisticGraphN, i : Int, v : Double) -> DbtxpessimisticGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticGraphN::sum(self : DbtxpessimisticGraphN) -> Double { @_common.sum(self.data) }

pub fn DbtxpessimisticGraphN::mean(self : DbtxpessimisticGraphN) -> Double { @_common.mean(self.data) }

pub fn DbtxpessimisticGraphN::scale(self : DbtxpessimisticGraphN, f : Double) -> DbtxpessimisticGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticGraphN::add(self : DbtxpessimisticGraphN, other : DbtxpessimisticGraphN) -> DbtxpessimisticGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxpessimisticGraphN::copy(self : DbtxpessimisticGraphN) -> DbtxpessimisticGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticGraphN::fill(self : DbtxpessimisticGraphN, v : Double) -> DbtxpessimisticGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticGraphN::min(self : DbtxpessimisticGraphN) -> Double { @_common.min(self.data) }

pub fn DbtxpessimisticGraphN::max(self : DbtxpessimisticGraphN) -> Double { @_common.max(self.data) }

pub fn DbtxpessimisticGraphN::to_string(self : DbtxpessimisticGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_node_make(size : Int) -> DbtxpessimisticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxpessimisticNode::len(self : DbtxpessimisticNode) -> Int { self.size }

pub fn DbtxpessimisticNode::get(self : DbtxpessimisticNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxpessimisticNode::set(self : DbtxpessimisticNode, i : Int, v : Double) -> DbtxpessimisticNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticNode::sum(self : DbtxpessimisticNode) -> Double { @_common.sum(self.data) }

pub fn DbtxpessimisticNode::mean(self : DbtxpessimisticNode) -> Double { @_common.mean(self.data) }

pub fn DbtxpessimisticNode::scale(self : DbtxpessimisticNode, f : Double) -> DbtxpessimisticNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticNode::add(self : DbtxpessimisticNode, other : DbtxpessimisticNode) -> DbtxpessimisticNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxpessimisticNode::copy(self : DbtxpessimisticNode) -> DbtxpessimisticNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticNode::fill(self : DbtxpessimisticNode, v : Double) -> DbtxpessimisticNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticNode::min(self : DbtxpessimisticNode) -> Double { @_common.min(self.data) }

pub fn DbtxpessimisticNode::max(self : DbtxpessimisticNode) -> Double { @_common.max(self.data) }

pub fn DbtxpessimisticNode::to_string(self : DbtxpessimisticNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_edge_make(size : Int) -> DbtxpessimisticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxpessimisticEdge::len(self : DbtxpessimisticEdge) -> Int { self.size }

pub fn DbtxpessimisticEdge::get(self : DbtxpessimisticEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxpessimisticEdge::set(self : DbtxpessimisticEdge, i : Int, v : Double) -> DbtxpessimisticEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticEdge::sum(self : DbtxpessimisticEdge) -> Double { @_common.sum(self.data) }

pub fn DbtxpessimisticEdge::mean(self : DbtxpessimisticEdge) -> Double { @_common.mean(self.data) }

pub fn DbtxpessimisticEdge::scale(self : DbtxpessimisticEdge, f : Double) -> DbtxpessimisticEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticEdge::add(self : DbtxpessimisticEdge, other : DbtxpessimisticEdge) -> DbtxpessimisticEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxpessimisticEdge::copy(self : DbtxpessimisticEdge) -> DbtxpessimisticEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticEdge::fill(self : DbtxpessimisticEdge, v : Double) -> DbtxpessimisticEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticEdge::min(self : DbtxpessimisticEdge) -> Double { @_common.min(self.data) }

pub fn DbtxpessimisticEdge::max(self : DbtxpessimisticEdge) -> Double { @_common.max(self.data) }

pub fn DbtxpessimisticEdge::to_string(self : DbtxpessimisticEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_path_make(size : Int) -> DbtxpessimisticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxpessimisticPath::len(self : DbtxpessimisticPath) -> Int { self.size }

pub fn DbtxpessimisticPath::get(self : DbtxpessimisticPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxpessimisticPath::set(self : DbtxpessimisticPath, i : Int, v : Double) -> DbtxpessimisticPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticPath::sum(self : DbtxpessimisticPath) -> Double { @_common.sum(self.data) }

pub fn DbtxpessimisticPath::mean(self : DbtxpessimisticPath) -> Double { @_common.mean(self.data) }

pub fn DbtxpessimisticPath::scale(self : DbtxpessimisticPath, f : Double) -> DbtxpessimisticPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticPath::add(self : DbtxpessimisticPath, other : DbtxpessimisticPath) -> DbtxpessimisticPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxpessimisticPath::copy(self : DbtxpessimisticPath) -> DbtxpessimisticPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticPath::fill(self : DbtxpessimisticPath, v : Double) -> DbtxpessimisticPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticPath::min(self : DbtxpessimisticPath) -> Double { @_common.min(self.data) }

pub fn DbtxpessimisticPath::max(self : DbtxpessimisticPath) -> Double { @_common.max(self.data) }

pub fn DbtxpessimisticPath::to_string(self : DbtxpessimisticPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_cluster_make(size : Int) -> DbtxpessimisticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxpessimisticCluster::len(self : DbtxpessimisticCluster) -> Int { self.size }

pub fn DbtxpessimisticCluster::get(self : DbtxpessimisticCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxpessimisticCluster::set(self : DbtxpessimisticCluster, i : Int, v : Double) -> DbtxpessimisticCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticCluster::sum(self : DbtxpessimisticCluster) -> Double { @_common.sum(self.data) }

pub fn DbtxpessimisticCluster::mean(self : DbtxpessimisticCluster) -> Double { @_common.mean(self.data) }

pub fn DbtxpessimisticCluster::scale(self : DbtxpessimisticCluster, f : Double) -> DbtxpessimisticCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticCluster::add(self : DbtxpessimisticCluster, other : DbtxpessimisticCluster) -> DbtxpessimisticCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxpessimisticCluster::copy(self : DbtxpessimisticCluster) -> DbtxpessimisticCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticCluster::fill(self : DbtxpessimisticCluster, v : Double) -> DbtxpessimisticCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticCluster::min(self : DbtxpessimisticCluster) -> Double { @_common.min(self.data) }

pub fn DbtxpessimisticCluster::max(self : DbtxpessimisticCluster) -> Double { @_common.max(self.data) }

pub fn DbtxpessimisticCluster::to_string(self : DbtxpessimisticCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_model_make(size : Int) -> DbtxpessimisticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxpessimisticModel::len(self : DbtxpessimisticModel) -> Int { self.size }

pub fn DbtxpessimisticModel::get(self : DbtxpessimisticModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxpessimisticModel::set(self : DbtxpessimisticModel, i : Int, v : Double) -> DbtxpessimisticModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticModel::sum(self : DbtxpessimisticModel) -> Double { @_common.sum(self.data) }

pub fn DbtxpessimisticModel::mean(self : DbtxpessimisticModel) -> Double { @_common.mean(self.data) }

pub fn DbtxpessimisticModel::scale(self : DbtxpessimisticModel, f : Double) -> DbtxpessimisticModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticModel::add(self : DbtxpessimisticModel, other : DbtxpessimisticModel) -> DbtxpessimisticModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxpessimisticModel::copy(self : DbtxpessimisticModel) -> DbtxpessimisticModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticModel::fill(self : DbtxpessimisticModel, v : Double) -> DbtxpessimisticModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticModel::min(self : DbtxpessimisticModel) -> Double { @_common.min(self.data) }

pub fn DbtxpessimisticModel::max(self : DbtxpessimisticModel) -> Double { @_common.max(self.data) }

pub fn DbtxpessimisticModel::to_string(self : DbtxpessimisticModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_layer_make(size : Int) -> DbtxpessimisticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxpessimisticLayer::len(self : DbtxpessimisticLayer) -> Int { self.size }

pub fn DbtxpessimisticLayer::get(self : DbtxpessimisticLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxpessimisticLayer::set(self : DbtxpessimisticLayer, i : Int, v : Double) -> DbtxpessimisticLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticLayer::sum(self : DbtxpessimisticLayer) -> Double { @_common.sum(self.data) }

pub fn DbtxpessimisticLayer::mean(self : DbtxpessimisticLayer) -> Double { @_common.mean(self.data) }

pub fn DbtxpessimisticLayer::scale(self : DbtxpessimisticLayer, f : Double) -> DbtxpessimisticLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticLayer::add(self : DbtxpessimisticLayer, other : DbtxpessimisticLayer) -> DbtxpessimisticLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxpessimisticLayer::copy(self : DbtxpessimisticLayer) -> DbtxpessimisticLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticLayer::fill(self : DbtxpessimisticLayer, v : Double) -> DbtxpessimisticLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticLayer::min(self : DbtxpessimisticLayer) -> Double { @_common.min(self.data) }

pub fn DbtxpessimisticLayer::max(self : DbtxpessimisticLayer) -> Double { @_common.max(self.data) }

pub fn DbtxpessimisticLayer::to_string(self : DbtxpessimisticLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_buffer_make(size : Int) -> DbtxpessimisticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxpessimisticBuffer::len(self : DbtxpessimisticBuffer) -> Int { self.size }

pub fn DbtxpessimisticBuffer::get(self : DbtxpessimisticBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxpessimisticBuffer::set(self : DbtxpessimisticBuffer, i : Int, v : Double) -> DbtxpessimisticBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticBuffer::sum(self : DbtxpessimisticBuffer) -> Double { @_common.sum(self.data) }

pub fn DbtxpessimisticBuffer::mean(self : DbtxpessimisticBuffer) -> Double { @_common.mean(self.data) }

pub fn DbtxpessimisticBuffer::scale(self : DbtxpessimisticBuffer, f : Double) -> DbtxpessimisticBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticBuffer::add(self : DbtxpessimisticBuffer, other : DbtxpessimisticBuffer) -> DbtxpessimisticBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxpessimisticBuffer::copy(self : DbtxpessimisticBuffer) -> DbtxpessimisticBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticBuffer::fill(self : DbtxpessimisticBuffer, v : Double) -> DbtxpessimisticBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticBuffer::min(self : DbtxpessimisticBuffer) -> Double { @_common.min(self.data) }

pub fn DbtxpessimisticBuffer::max(self : DbtxpessimisticBuffer) -> Double { @_common.max(self.data) }

pub fn DbtxpessimisticBuffer::to_string(self : DbtxpessimisticBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_cursor_make(size : Int) -> DbtxpessimisticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxpessimisticCursor::len(self : DbtxpessimisticCursor) -> Int { self.size }

pub fn DbtxpessimisticCursor::get(self : DbtxpessimisticCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxpessimisticCursor::set(self : DbtxpessimisticCursor, i : Int, v : Double) -> DbtxpessimisticCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticCursor::sum(self : DbtxpessimisticCursor) -> Double { @_common.sum(self.data) }

pub fn DbtxpessimisticCursor::mean(self : DbtxpessimisticCursor) -> Double { @_common.mean(self.data) }

pub fn DbtxpessimisticCursor::scale(self : DbtxpessimisticCursor, f : Double) -> DbtxpessimisticCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticCursor::add(self : DbtxpessimisticCursor, other : DbtxpessimisticCursor) -> DbtxpessimisticCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxpessimisticCursor::copy(self : DbtxpessimisticCursor) -> DbtxpessimisticCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticCursor::fill(self : DbtxpessimisticCursor, v : Double) -> DbtxpessimisticCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticCursor::min(self : DbtxpessimisticCursor) -> Double { @_common.min(self.data) }

pub fn DbtxpessimisticCursor::max(self : DbtxpessimisticCursor) -> Double { @_common.max(self.data) }

pub fn DbtxpessimisticCursor::to_string(self : DbtxpessimisticCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_view_make(size : Int) -> DbtxpessimisticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxpessimisticView::len(self : DbtxpessimisticView) -> Int { self.size }

pub fn DbtxpessimisticView::get(self : DbtxpessimisticView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxpessimisticView::set(self : DbtxpessimisticView, i : Int, v : Double) -> DbtxpessimisticView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticView::sum(self : DbtxpessimisticView) -> Double { @_common.sum(self.data) }

pub fn DbtxpessimisticView::mean(self : DbtxpessimisticView) -> Double { @_common.mean(self.data) }

pub fn DbtxpessimisticView::scale(self : DbtxpessimisticView, f : Double) -> DbtxpessimisticView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticView::add(self : DbtxpessimisticView, other : DbtxpessimisticView) -> DbtxpessimisticView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxpessimisticView::copy(self : DbtxpessimisticView) -> DbtxpessimisticView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticView::fill(self : DbtxpessimisticView, v : Double) -> DbtxpessimisticView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticView::min(self : DbtxpessimisticView) -> Double { @_common.min(self.data) }

pub fn DbtxpessimisticView::max(self : DbtxpessimisticView) -> Double { @_common.max(self.data) }

pub fn DbtxpessimisticView::to_string(self : DbtxpessimisticView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_range_make(size : Int) -> DbtxpessimisticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxpessimisticRange::len(self : DbtxpessimisticRange) -> Int { self.size }

pub fn DbtxpessimisticRange::get(self : DbtxpessimisticRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxpessimisticRange::set(self : DbtxpessimisticRange, i : Int, v : Double) -> DbtxpessimisticRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticRange::sum(self : DbtxpessimisticRange) -> Double { @_common.sum(self.data) }

pub fn DbtxpessimisticRange::mean(self : DbtxpessimisticRange) -> Double { @_common.mean(self.data) }

pub fn DbtxpessimisticRange::scale(self : DbtxpessimisticRange, f : Double) -> DbtxpessimisticRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticRange::add(self : DbtxpessimisticRange, other : DbtxpessimisticRange) -> DbtxpessimisticRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxpessimisticRange::copy(self : DbtxpessimisticRange) -> DbtxpessimisticRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticRange::fill(self : DbtxpessimisticRange, v : Double) -> DbtxpessimisticRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticRange::min(self : DbtxpessimisticRange) -> Double { @_common.min(self.data) }

pub fn DbtxpessimisticRange::max(self : DbtxpessimisticRange) -> Double { @_common.max(self.data) }

pub fn DbtxpessimisticRange::to_string(self : DbtxpessimisticRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_slice_make(size : Int) -> DbtxpessimisticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DbtxpessimisticSlice::len(self : DbtxpessimisticSlice) -> Int { self.size }

pub fn DbtxpessimisticSlice::get(self : DbtxpessimisticSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DbtxpessimisticSlice::set(self : DbtxpessimisticSlice, i : Int, v : Double) -> DbtxpessimisticSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticSlice::sum(self : DbtxpessimisticSlice) -> Double { @_common.sum(self.data) }

pub fn DbtxpessimisticSlice::mean(self : DbtxpessimisticSlice) -> Double { @_common.mean(self.data) }

pub fn DbtxpessimisticSlice::scale(self : DbtxpessimisticSlice, f : Double) -> DbtxpessimisticSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticSlice::add(self : DbtxpessimisticSlice, other : DbtxpessimisticSlice) -> DbtxpessimisticSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DbtxpessimisticSlice::copy(self : DbtxpessimisticSlice) -> DbtxpessimisticSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticSlice::fill(self : DbtxpessimisticSlice, v : Double) -> DbtxpessimisticSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DbtxpessimisticSlice::min(self : DbtxpessimisticSlice) -> Double { @_common.min(self.data) }

pub fn DbtxpessimisticSlice::max(self : DbtxpessimisticSlice) -> Double { @_common.max(self.data) }

pub fn DbtxpessimisticSlice::to_string(self : DbtxpessimisticSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

