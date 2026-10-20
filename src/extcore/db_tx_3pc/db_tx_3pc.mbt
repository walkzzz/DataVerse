///===
/// extcore/db_tx_3pc

pub(all) struct Dbtx3pcPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_3pc_make_point(x : Double, y : Double) -> Dbtx3pcPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_3pc_make_point3(x : Double, y : Double, z : Double) -> Dbtx3pcPoint {
  { x, y, z, label: 0 }
}

pub fn Dbtx3pcPoint::x(self : Dbtx3pcPoint) -> Double { self.x }

pub fn Dbtx3pcPoint::y(self : Dbtx3pcPoint) -> Double { self.y }

pub fn Dbtx3pcPoint::z(self : Dbtx3pcPoint) -> Double { self.z }

pub fn Dbtx3pcPoint::label(self : Dbtx3pcPoint) -> Int { self.label }

pub fn Dbtx3pcPoint::dist(self : Dbtx3pcPoint, other : Dbtx3pcPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn Dbtx3pcPoint::add(self : Dbtx3pcPoint, other : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn Dbtx3pcPoint::sub(self : Dbtx3pcPoint, other : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn Dbtx3pcPoint::scale(self : Dbtx3pcPoint, s : Double) -> Dbtx3pcPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn Dbtx3pcPoint::dot(self : Dbtx3pcPoint, other : Dbtx3pcPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn Dbtx3pcPoint::cross(self : Dbtx3pcPoint, other : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn Dbtx3pcPoint::norm(self : Dbtx3pcPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn Dbtx3pcPoint::normalize(self : Dbtx3pcPoint) -> Dbtx3pcPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Dbtx3pcPoint::negate(self : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn Dbtx3pcPoint::mid(self : Dbtx3pcPoint, other : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn Dbtx3pcPoint::lerp(self : Dbtx3pcPoint, other : Dbtx3pcPoint, t : Double) -> Dbtx3pcPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn Dbtx3pcPoint::to_string(self : Dbtx3pcPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct Dbtx3pcSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_3pc_make_series(vals : Array[Double], name : String) -> Dbtx3pcSeries {
  { vals, name, meta: 0 }
}

pub fn Dbtx3pcSeries::len(self : Dbtx3pcSeries) -> Int { self.vals.length() }

pub fn Dbtx3pcSeries::sum(self : Dbtx3pcSeries) -> Double { @_common.sum(self.vals) }

pub fn Dbtx3pcSeries::mean(self : Dbtx3pcSeries) -> Double { @_common.mean(self.vals) }

pub fn Dbtx3pcSeries::min(self : Dbtx3pcSeries) -> Double { @_common.min(self.vals) }

pub fn Dbtx3pcSeries::max(self : Dbtx3pcSeries) -> Double { @_common.max(self.vals) }

pub fn Dbtx3pcSeries::range(self : Dbtx3pcSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn Dbtx3pcSeries::variance(self : Dbtx3pcSeries) -> Double { @_common.variance(self.vals) }

pub fn Dbtx3pcSeries::std(self : Dbtx3pcSeries) -> Double { @_common.std(self.vals) }

pub fn Dbtx3pcSeries::median(self : Dbtx3pcSeries) -> Double { @_common.median(self.vals) }

pub fn Dbtx3pcSeries::scale(self : Dbtx3pcSeries, f : Double) -> Dbtx3pcSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn Dbtx3pcSeries::add(self : Dbtx3pcSeries, other : Dbtx3pcSeries) -> Dbtx3pcSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn Dbtx3pcSeries::sub(self : Dbtx3pcSeries, other : Dbtx3pcSeries) -> Dbtx3pcSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn Dbtx3pcSeries::normalize(self : Dbtx3pcSeries) -> Dbtx3pcSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn Dbtx3pcSeries::cumsum(self : Dbtx3pcSeries) -> Dbtx3pcSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn Dbtx3pcSeries::to_string(self : Dbtx3pcSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Dbtx3pcMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_3pc_make_matrix(rows : Int, cols : Int, val : Double) -> Dbtx3pcMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_3pc_matrix_identity(n : Int) -> Dbtx3pcMatrix {
  let m = db_tx_3pc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn Dbtx3pcMatrix::get(self : Dbtx3pcMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn Dbtx3pcMatrix::transpose(self : Dbtx3pcMatrix) -> Dbtx3pcMatrix {
  let result = db_tx_3pc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn Dbtx3pcMatrix::add(self : Dbtx3pcMatrix, other : Dbtx3pcMatrix) -> Dbtx3pcMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = db_tx_3pc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn Dbtx3pcMatrix::scale(self : Dbtx3pcMatrix, s : Double) -> Dbtx3pcMatrix {
  let result = db_tx_3pc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn Dbtx3pcMatrix::multiply(self : Dbtx3pcMatrix, other : Dbtx3pcMatrix) -> Dbtx3pcMatrix {
  if self.cols != other.rows { return db_tx_3pc_make_matrix(self.rows, other.cols, 0.0) }
  let result = db_tx_3pc_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn Dbtx3pcMatrix::trace(self : Dbtx3pcMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn Dbtx3pcMatrix::det(self : Dbtx3pcMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn Dbtx3pcMatrix::norm(self : Dbtx3pcMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn Dbtx3pcMatrix::to_string(self : Dbtx3pcMatrix) -> String {
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

pub(all) struct Dbtx3pcVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_3pc_make_vector(comps : Array[Double]) -> Dbtx3pcVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_3pc_vector_zero(dim : Int) -> Dbtx3pcVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn Dbtx3pcVector::add(self : Dbtx3pcVector, other : Dbtx3pcVector) -> Dbtx3pcVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn Dbtx3pcVector::sub(self : Dbtx3pcVector, other : Dbtx3pcVector) -> Dbtx3pcVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn Dbtx3pcVector::scale(self : Dbtx3pcVector, s : Double) -> Dbtx3pcVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn Dbtx3pcVector::dot(self : Dbtx3pcVector, other : Dbtx3pcVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn Dbtx3pcVector::norm(self : Dbtx3pcVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn Dbtx3pcVector::normalize(self : Dbtx3pcVector) -> Dbtx3pcVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn Dbtx3pcVector::dist(self : Dbtx3pcVector, other : Dbtx3pcVector) -> Double {
  self.sub(other).norm()
}

pub fn Dbtx3pcVector::to_string(self : Dbtx3pcVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_3pc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn db_tx_3pc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn db_tx_3pc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn db_tx_3pc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn db_tx_3pc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn db_tx_3pc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn db_tx_3pc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn db_tx_3pc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn db_tx_3pc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn db_tx_3pc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn db_tx_3pc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn db_tx_3pc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn db_tx_3pc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn db_tx_3pc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn db_tx_3pc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn db_tx_3pc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn db_tx_3pc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn db_tx_3pc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn db_tx_3pc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn db_tx_3pc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn db_tx_3pc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn db_tx_3pc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn db_tx_3pc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn db_tx_3pc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn db_tx_3pc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn db_tx_3pc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn db_tx_3pc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn db_tx_3pc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn db_tx_3pc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct Dbtx3pcFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_frame_make(size : Int) -> Dbtx3pcFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Dbtx3pcFrame::len(self : Dbtx3pcFrame) -> Int { self.size }

pub fn Dbtx3pcFrame::get(self : Dbtx3pcFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Dbtx3pcFrame::set(self : Dbtx3pcFrame, i : Int, v : Double) -> Dbtx3pcFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Dbtx3pcFrame::sum(self : Dbtx3pcFrame) -> Double { @_common.sum(self.data) }

pub fn Dbtx3pcFrame::mean(self : Dbtx3pcFrame) -> Double { @_common.mean(self.data) }

pub fn Dbtx3pcFrame::scale(self : Dbtx3pcFrame, f : Double) -> Dbtx3pcFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcFrame::add(self : Dbtx3pcFrame, other : Dbtx3pcFrame) -> Dbtx3pcFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Dbtx3pcFrame::copy(self : Dbtx3pcFrame) -> Dbtx3pcFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcFrame::fill(self : Dbtx3pcFrame, v : Double) -> Dbtx3pcFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcFrame::min(self : Dbtx3pcFrame) -> Double { @_common.min(self.data) }

pub fn Dbtx3pcFrame::max(self : Dbtx3pcFrame) -> Double { @_common.max(self.data) }

pub fn Dbtx3pcFrame::to_string(self : Dbtx3pcFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_table_make(size : Int) -> Dbtx3pcTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Dbtx3pcTable::len(self : Dbtx3pcTable) -> Int { self.size }

pub fn Dbtx3pcTable::get(self : Dbtx3pcTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Dbtx3pcTable::set(self : Dbtx3pcTable, i : Int, v : Double) -> Dbtx3pcTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Dbtx3pcTable::sum(self : Dbtx3pcTable) -> Double { @_common.sum(self.data) }

pub fn Dbtx3pcTable::mean(self : Dbtx3pcTable) -> Double { @_common.mean(self.data) }

pub fn Dbtx3pcTable::scale(self : Dbtx3pcTable, f : Double) -> Dbtx3pcTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcTable::add(self : Dbtx3pcTable, other : Dbtx3pcTable) -> Dbtx3pcTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Dbtx3pcTable::copy(self : Dbtx3pcTable) -> Dbtx3pcTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcTable::fill(self : Dbtx3pcTable, v : Double) -> Dbtx3pcTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcTable::min(self : Dbtx3pcTable) -> Double { @_common.min(self.data) }

pub fn Dbtx3pcTable::max(self : Dbtx3pcTable) -> Double { @_common.max(self.data) }

pub fn Dbtx3pcTable::to_string(self : Dbtx3pcTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_graphn_make(size : Int) -> Dbtx3pcGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Dbtx3pcGraphN::len(self : Dbtx3pcGraphN) -> Int { self.size }

pub fn Dbtx3pcGraphN::get(self : Dbtx3pcGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Dbtx3pcGraphN::set(self : Dbtx3pcGraphN, i : Int, v : Double) -> Dbtx3pcGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Dbtx3pcGraphN::sum(self : Dbtx3pcGraphN) -> Double { @_common.sum(self.data) }

pub fn Dbtx3pcGraphN::mean(self : Dbtx3pcGraphN) -> Double { @_common.mean(self.data) }

pub fn Dbtx3pcGraphN::scale(self : Dbtx3pcGraphN, f : Double) -> Dbtx3pcGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcGraphN::add(self : Dbtx3pcGraphN, other : Dbtx3pcGraphN) -> Dbtx3pcGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Dbtx3pcGraphN::copy(self : Dbtx3pcGraphN) -> Dbtx3pcGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcGraphN::fill(self : Dbtx3pcGraphN, v : Double) -> Dbtx3pcGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcGraphN::min(self : Dbtx3pcGraphN) -> Double { @_common.min(self.data) }

pub fn Dbtx3pcGraphN::max(self : Dbtx3pcGraphN) -> Double { @_common.max(self.data) }

pub fn Dbtx3pcGraphN::to_string(self : Dbtx3pcGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_node_make(size : Int) -> Dbtx3pcNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Dbtx3pcNode::len(self : Dbtx3pcNode) -> Int { self.size }

pub fn Dbtx3pcNode::get(self : Dbtx3pcNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Dbtx3pcNode::set(self : Dbtx3pcNode, i : Int, v : Double) -> Dbtx3pcNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Dbtx3pcNode::sum(self : Dbtx3pcNode) -> Double { @_common.sum(self.data) }

pub fn Dbtx3pcNode::mean(self : Dbtx3pcNode) -> Double { @_common.mean(self.data) }

pub fn Dbtx3pcNode::scale(self : Dbtx3pcNode, f : Double) -> Dbtx3pcNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcNode::add(self : Dbtx3pcNode, other : Dbtx3pcNode) -> Dbtx3pcNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Dbtx3pcNode::copy(self : Dbtx3pcNode) -> Dbtx3pcNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcNode::fill(self : Dbtx3pcNode, v : Double) -> Dbtx3pcNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcNode::min(self : Dbtx3pcNode) -> Double { @_common.min(self.data) }

pub fn Dbtx3pcNode::max(self : Dbtx3pcNode) -> Double { @_common.max(self.data) }

pub fn Dbtx3pcNode::to_string(self : Dbtx3pcNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_edge_make(size : Int) -> Dbtx3pcEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Dbtx3pcEdge::len(self : Dbtx3pcEdge) -> Int { self.size }

pub fn Dbtx3pcEdge::get(self : Dbtx3pcEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Dbtx3pcEdge::set(self : Dbtx3pcEdge, i : Int, v : Double) -> Dbtx3pcEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Dbtx3pcEdge::sum(self : Dbtx3pcEdge) -> Double { @_common.sum(self.data) }

pub fn Dbtx3pcEdge::mean(self : Dbtx3pcEdge) -> Double { @_common.mean(self.data) }

pub fn Dbtx3pcEdge::scale(self : Dbtx3pcEdge, f : Double) -> Dbtx3pcEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcEdge::add(self : Dbtx3pcEdge, other : Dbtx3pcEdge) -> Dbtx3pcEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Dbtx3pcEdge::copy(self : Dbtx3pcEdge) -> Dbtx3pcEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcEdge::fill(self : Dbtx3pcEdge, v : Double) -> Dbtx3pcEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcEdge::min(self : Dbtx3pcEdge) -> Double { @_common.min(self.data) }

pub fn Dbtx3pcEdge::max(self : Dbtx3pcEdge) -> Double { @_common.max(self.data) }

pub fn Dbtx3pcEdge::to_string(self : Dbtx3pcEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_path_make(size : Int) -> Dbtx3pcPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Dbtx3pcPath::len(self : Dbtx3pcPath) -> Int { self.size }

pub fn Dbtx3pcPath::get(self : Dbtx3pcPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Dbtx3pcPath::set(self : Dbtx3pcPath, i : Int, v : Double) -> Dbtx3pcPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Dbtx3pcPath::sum(self : Dbtx3pcPath) -> Double { @_common.sum(self.data) }

pub fn Dbtx3pcPath::mean(self : Dbtx3pcPath) -> Double { @_common.mean(self.data) }

pub fn Dbtx3pcPath::scale(self : Dbtx3pcPath, f : Double) -> Dbtx3pcPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcPath::add(self : Dbtx3pcPath, other : Dbtx3pcPath) -> Dbtx3pcPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Dbtx3pcPath::copy(self : Dbtx3pcPath) -> Dbtx3pcPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcPath::fill(self : Dbtx3pcPath, v : Double) -> Dbtx3pcPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcPath::min(self : Dbtx3pcPath) -> Double { @_common.min(self.data) }

pub fn Dbtx3pcPath::max(self : Dbtx3pcPath) -> Double { @_common.max(self.data) }

pub fn Dbtx3pcPath::to_string(self : Dbtx3pcPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_cluster_make(size : Int) -> Dbtx3pcCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Dbtx3pcCluster::len(self : Dbtx3pcCluster) -> Int { self.size }

pub fn Dbtx3pcCluster::get(self : Dbtx3pcCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Dbtx3pcCluster::set(self : Dbtx3pcCluster, i : Int, v : Double) -> Dbtx3pcCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Dbtx3pcCluster::sum(self : Dbtx3pcCluster) -> Double { @_common.sum(self.data) }

pub fn Dbtx3pcCluster::mean(self : Dbtx3pcCluster) -> Double { @_common.mean(self.data) }

pub fn Dbtx3pcCluster::scale(self : Dbtx3pcCluster, f : Double) -> Dbtx3pcCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcCluster::add(self : Dbtx3pcCluster, other : Dbtx3pcCluster) -> Dbtx3pcCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Dbtx3pcCluster::copy(self : Dbtx3pcCluster) -> Dbtx3pcCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcCluster::fill(self : Dbtx3pcCluster, v : Double) -> Dbtx3pcCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcCluster::min(self : Dbtx3pcCluster) -> Double { @_common.min(self.data) }

pub fn Dbtx3pcCluster::max(self : Dbtx3pcCluster) -> Double { @_common.max(self.data) }

pub fn Dbtx3pcCluster::to_string(self : Dbtx3pcCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_model_make(size : Int) -> Dbtx3pcModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Dbtx3pcModel::len(self : Dbtx3pcModel) -> Int { self.size }

pub fn Dbtx3pcModel::get(self : Dbtx3pcModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Dbtx3pcModel::set(self : Dbtx3pcModel, i : Int, v : Double) -> Dbtx3pcModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Dbtx3pcModel::sum(self : Dbtx3pcModel) -> Double { @_common.sum(self.data) }

pub fn Dbtx3pcModel::mean(self : Dbtx3pcModel) -> Double { @_common.mean(self.data) }

pub fn Dbtx3pcModel::scale(self : Dbtx3pcModel, f : Double) -> Dbtx3pcModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcModel::add(self : Dbtx3pcModel, other : Dbtx3pcModel) -> Dbtx3pcModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Dbtx3pcModel::copy(self : Dbtx3pcModel) -> Dbtx3pcModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcModel::fill(self : Dbtx3pcModel, v : Double) -> Dbtx3pcModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcModel::min(self : Dbtx3pcModel) -> Double { @_common.min(self.data) }

pub fn Dbtx3pcModel::max(self : Dbtx3pcModel) -> Double { @_common.max(self.data) }

pub fn Dbtx3pcModel::to_string(self : Dbtx3pcModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_layer_make(size : Int) -> Dbtx3pcLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Dbtx3pcLayer::len(self : Dbtx3pcLayer) -> Int { self.size }

pub fn Dbtx3pcLayer::get(self : Dbtx3pcLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Dbtx3pcLayer::set(self : Dbtx3pcLayer, i : Int, v : Double) -> Dbtx3pcLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Dbtx3pcLayer::sum(self : Dbtx3pcLayer) -> Double { @_common.sum(self.data) }

pub fn Dbtx3pcLayer::mean(self : Dbtx3pcLayer) -> Double { @_common.mean(self.data) }

pub fn Dbtx3pcLayer::scale(self : Dbtx3pcLayer, f : Double) -> Dbtx3pcLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcLayer::add(self : Dbtx3pcLayer, other : Dbtx3pcLayer) -> Dbtx3pcLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Dbtx3pcLayer::copy(self : Dbtx3pcLayer) -> Dbtx3pcLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcLayer::fill(self : Dbtx3pcLayer, v : Double) -> Dbtx3pcLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcLayer::min(self : Dbtx3pcLayer) -> Double { @_common.min(self.data) }

pub fn Dbtx3pcLayer::max(self : Dbtx3pcLayer) -> Double { @_common.max(self.data) }

pub fn Dbtx3pcLayer::to_string(self : Dbtx3pcLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_buffer_make(size : Int) -> Dbtx3pcBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Dbtx3pcBuffer::len(self : Dbtx3pcBuffer) -> Int { self.size }

pub fn Dbtx3pcBuffer::get(self : Dbtx3pcBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Dbtx3pcBuffer::set(self : Dbtx3pcBuffer, i : Int, v : Double) -> Dbtx3pcBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Dbtx3pcBuffer::sum(self : Dbtx3pcBuffer) -> Double { @_common.sum(self.data) }

pub fn Dbtx3pcBuffer::mean(self : Dbtx3pcBuffer) -> Double { @_common.mean(self.data) }

pub fn Dbtx3pcBuffer::scale(self : Dbtx3pcBuffer, f : Double) -> Dbtx3pcBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcBuffer::add(self : Dbtx3pcBuffer, other : Dbtx3pcBuffer) -> Dbtx3pcBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Dbtx3pcBuffer::copy(self : Dbtx3pcBuffer) -> Dbtx3pcBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcBuffer::fill(self : Dbtx3pcBuffer, v : Double) -> Dbtx3pcBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcBuffer::min(self : Dbtx3pcBuffer) -> Double { @_common.min(self.data) }

pub fn Dbtx3pcBuffer::max(self : Dbtx3pcBuffer) -> Double { @_common.max(self.data) }

pub fn Dbtx3pcBuffer::to_string(self : Dbtx3pcBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_cursor_make(size : Int) -> Dbtx3pcCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Dbtx3pcCursor::len(self : Dbtx3pcCursor) -> Int { self.size }

pub fn Dbtx3pcCursor::get(self : Dbtx3pcCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Dbtx3pcCursor::set(self : Dbtx3pcCursor, i : Int, v : Double) -> Dbtx3pcCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Dbtx3pcCursor::sum(self : Dbtx3pcCursor) -> Double { @_common.sum(self.data) }

pub fn Dbtx3pcCursor::mean(self : Dbtx3pcCursor) -> Double { @_common.mean(self.data) }

pub fn Dbtx3pcCursor::scale(self : Dbtx3pcCursor, f : Double) -> Dbtx3pcCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcCursor::add(self : Dbtx3pcCursor, other : Dbtx3pcCursor) -> Dbtx3pcCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Dbtx3pcCursor::copy(self : Dbtx3pcCursor) -> Dbtx3pcCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcCursor::fill(self : Dbtx3pcCursor, v : Double) -> Dbtx3pcCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcCursor::min(self : Dbtx3pcCursor) -> Double { @_common.min(self.data) }

pub fn Dbtx3pcCursor::max(self : Dbtx3pcCursor) -> Double { @_common.max(self.data) }

pub fn Dbtx3pcCursor::to_string(self : Dbtx3pcCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_view_make(size : Int) -> Dbtx3pcView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Dbtx3pcView::len(self : Dbtx3pcView) -> Int { self.size }

pub fn Dbtx3pcView::get(self : Dbtx3pcView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Dbtx3pcView::set(self : Dbtx3pcView, i : Int, v : Double) -> Dbtx3pcView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Dbtx3pcView::sum(self : Dbtx3pcView) -> Double { @_common.sum(self.data) }

pub fn Dbtx3pcView::mean(self : Dbtx3pcView) -> Double { @_common.mean(self.data) }

pub fn Dbtx3pcView::scale(self : Dbtx3pcView, f : Double) -> Dbtx3pcView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcView::add(self : Dbtx3pcView, other : Dbtx3pcView) -> Dbtx3pcView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Dbtx3pcView::copy(self : Dbtx3pcView) -> Dbtx3pcView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcView::fill(self : Dbtx3pcView, v : Double) -> Dbtx3pcView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcView::min(self : Dbtx3pcView) -> Double { @_common.min(self.data) }

pub fn Dbtx3pcView::max(self : Dbtx3pcView) -> Double { @_common.max(self.data) }

pub fn Dbtx3pcView::to_string(self : Dbtx3pcView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_range_make(size : Int) -> Dbtx3pcRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Dbtx3pcRange::len(self : Dbtx3pcRange) -> Int { self.size }

pub fn Dbtx3pcRange::get(self : Dbtx3pcRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Dbtx3pcRange::set(self : Dbtx3pcRange, i : Int, v : Double) -> Dbtx3pcRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Dbtx3pcRange::sum(self : Dbtx3pcRange) -> Double { @_common.sum(self.data) }

pub fn Dbtx3pcRange::mean(self : Dbtx3pcRange) -> Double { @_common.mean(self.data) }

pub fn Dbtx3pcRange::scale(self : Dbtx3pcRange, f : Double) -> Dbtx3pcRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcRange::add(self : Dbtx3pcRange, other : Dbtx3pcRange) -> Dbtx3pcRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Dbtx3pcRange::copy(self : Dbtx3pcRange) -> Dbtx3pcRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcRange::fill(self : Dbtx3pcRange, v : Double) -> Dbtx3pcRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcRange::min(self : Dbtx3pcRange) -> Double { @_common.min(self.data) }

pub fn Dbtx3pcRange::max(self : Dbtx3pcRange) -> Double { @_common.max(self.data) }

pub fn Dbtx3pcRange::to_string(self : Dbtx3pcRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_slice_make(size : Int) -> Dbtx3pcSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn Dbtx3pcSlice::len(self : Dbtx3pcSlice) -> Int { self.size }

pub fn Dbtx3pcSlice::get(self : Dbtx3pcSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn Dbtx3pcSlice::set(self : Dbtx3pcSlice, i : Int, v : Double) -> Dbtx3pcSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn Dbtx3pcSlice::sum(self : Dbtx3pcSlice) -> Double { @_common.sum(self.data) }

pub fn Dbtx3pcSlice::mean(self : Dbtx3pcSlice) -> Double { @_common.mean(self.data) }

pub fn Dbtx3pcSlice::scale(self : Dbtx3pcSlice, f : Double) -> Dbtx3pcSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcSlice::add(self : Dbtx3pcSlice, other : Dbtx3pcSlice) -> Dbtx3pcSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn Dbtx3pcSlice::copy(self : Dbtx3pcSlice) -> Dbtx3pcSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcSlice::fill(self : Dbtx3pcSlice, v : Double) -> Dbtx3pcSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn Dbtx3pcSlice::min(self : Dbtx3pcSlice) -> Double { @_common.min(self.data) }

pub fn Dbtx3pcSlice::max(self : Dbtx3pcSlice) -> Double { @_common.max(self.data) }

pub fn Dbtx3pcSlice::to_string(self : Dbtx3pcSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

