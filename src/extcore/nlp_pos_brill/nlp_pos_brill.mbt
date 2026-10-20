///===
/// extcore/nlp_pos_brill

pub(all) struct NlpposbrillPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_brill_make_point(x : Double, y : Double) -> NlpposbrillPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_brill_make_point3(x : Double, y : Double, z : Double) -> NlpposbrillPoint {
  { x, y, z, label: 0 }
}

pub fn NlpposbrillPoint::x(self : NlpposbrillPoint) -> Double { self.x }

pub fn NlpposbrillPoint::y(self : NlpposbrillPoint) -> Double { self.y }

pub fn NlpposbrillPoint::z(self : NlpposbrillPoint) -> Double { self.z }

pub fn NlpposbrillPoint::label(self : NlpposbrillPoint) -> Int { self.label }

pub fn NlpposbrillPoint::dist(self : NlpposbrillPoint, other : NlpposbrillPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn NlpposbrillPoint::add(self : NlpposbrillPoint, other : NlpposbrillPoint) -> NlpposbrillPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn NlpposbrillPoint::sub(self : NlpposbrillPoint, other : NlpposbrillPoint) -> NlpposbrillPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn NlpposbrillPoint::scale(self : NlpposbrillPoint, s : Double) -> NlpposbrillPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn NlpposbrillPoint::dot(self : NlpposbrillPoint, other : NlpposbrillPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn NlpposbrillPoint::cross(self : NlpposbrillPoint, other : NlpposbrillPoint) -> NlpposbrillPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn NlpposbrillPoint::norm(self : NlpposbrillPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn NlpposbrillPoint::normalize(self : NlpposbrillPoint) -> NlpposbrillPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposbrillPoint::negate(self : NlpposbrillPoint) -> NlpposbrillPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn NlpposbrillPoint::mid(self : NlpposbrillPoint, other : NlpposbrillPoint) -> NlpposbrillPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn NlpposbrillPoint::lerp(self : NlpposbrillPoint, other : NlpposbrillPoint, t : Double) -> NlpposbrillPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn NlpposbrillPoint::to_string(self : NlpposbrillPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct NlpposbrillSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_brill_make_series(vals : Array[Double], name : String) -> NlpposbrillSeries {
  { vals, name, meta: 0 }
}

pub fn NlpposbrillSeries::len(self : NlpposbrillSeries) -> Int { self.vals.length() }

pub fn NlpposbrillSeries::sum(self : NlpposbrillSeries) -> Double { @_common.sum(self.vals) }

pub fn NlpposbrillSeries::mean(self : NlpposbrillSeries) -> Double { @_common.mean(self.vals) }

pub fn NlpposbrillSeries::min(self : NlpposbrillSeries) -> Double { @_common.min(self.vals) }

pub fn NlpposbrillSeries::max(self : NlpposbrillSeries) -> Double { @_common.max(self.vals) }

pub fn NlpposbrillSeries::range(self : NlpposbrillSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn NlpposbrillSeries::variance(self : NlpposbrillSeries) -> Double { @_common.variance(self.vals) }

pub fn NlpposbrillSeries::std(self : NlpposbrillSeries) -> Double { @_common.std(self.vals) }

pub fn NlpposbrillSeries::median(self : NlpposbrillSeries) -> Double { @_common.median(self.vals) }

pub fn NlpposbrillSeries::scale(self : NlpposbrillSeries, f : Double) -> NlpposbrillSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn NlpposbrillSeries::add(self : NlpposbrillSeries, other : NlpposbrillSeries) -> NlpposbrillSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn NlpposbrillSeries::sub(self : NlpposbrillSeries, other : NlpposbrillSeries) -> NlpposbrillSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn NlpposbrillSeries::normalize(self : NlpposbrillSeries) -> NlpposbrillSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn NlpposbrillSeries::cumsum(self : NlpposbrillSeries) -> NlpposbrillSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn NlpposbrillSeries::to_string(self : NlpposbrillSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpposbrillMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_brill_make_matrix(rows : Int, cols : Int, val : Double) -> NlpposbrillMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_brill_matrix_identity(n : Int) -> NlpposbrillMatrix {
  let m = nlp_pos_brill_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn NlpposbrillMatrix::get(self : NlpposbrillMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn NlpposbrillMatrix::transpose(self : NlpposbrillMatrix) -> NlpposbrillMatrix {
  let result = nlp_pos_brill_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn NlpposbrillMatrix::add(self : NlpposbrillMatrix, other : NlpposbrillMatrix) -> NlpposbrillMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = nlp_pos_brill_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn NlpposbrillMatrix::scale(self : NlpposbrillMatrix, s : Double) -> NlpposbrillMatrix {
  let result = nlp_pos_brill_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn NlpposbrillMatrix::multiply(self : NlpposbrillMatrix, other : NlpposbrillMatrix) -> NlpposbrillMatrix {
  if self.cols != other.rows { return nlp_pos_brill_make_matrix(self.rows, other.cols, 0.0) }
  let result = nlp_pos_brill_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn NlpposbrillMatrix::trace(self : NlpposbrillMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn NlpposbrillMatrix::det(self : NlpposbrillMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn NlpposbrillMatrix::norm(self : NlpposbrillMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn NlpposbrillMatrix::to_string(self : NlpposbrillMatrix) -> String {
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

pub(all) struct NlpposbrillVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_brill_make_vector(comps : Array[Double]) -> NlpposbrillVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_brill_vector_zero(dim : Int) -> NlpposbrillVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn NlpposbrillVector::add(self : NlpposbrillVector, other : NlpposbrillVector) -> NlpposbrillVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposbrillVector::sub(self : NlpposbrillVector, other : NlpposbrillVector) -> NlpposbrillVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn NlpposbrillVector::scale(self : NlpposbrillVector, s : Double) -> NlpposbrillVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn NlpposbrillVector::dot(self : NlpposbrillVector, other : NlpposbrillVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn NlpposbrillVector::norm(self : NlpposbrillVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn NlpposbrillVector::normalize(self : NlpposbrillVector) -> NlpposbrillVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn NlpposbrillVector::dist(self : NlpposbrillVector, other : NlpposbrillVector) -> Double {
  self.sub(other).norm()
}

pub fn NlpposbrillVector::to_string(self : NlpposbrillVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_brill_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn nlp_pos_brill_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn nlp_pos_brill_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn nlp_pos_brill_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn nlp_pos_brill_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn nlp_pos_brill_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn nlp_pos_brill_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn nlp_pos_brill_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn nlp_pos_brill_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn nlp_pos_brill_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn nlp_pos_brill_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn nlp_pos_brill_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn nlp_pos_brill_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn nlp_pos_brill_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn nlp_pos_brill_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn nlp_pos_brill_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn nlp_pos_brill_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn nlp_pos_brill_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn nlp_pos_brill_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn nlp_pos_brill_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn nlp_pos_brill_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn nlp_pos_brill_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn nlp_pos_brill_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn nlp_pos_brill_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn nlp_pos_brill_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn nlp_pos_brill_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn nlp_pos_brill_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn nlp_pos_brill_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn nlp_pos_brill_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct NlpposbrillFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_frame_make(size : Int) -> NlpposbrillFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbrillFrame::len(self : NlpposbrillFrame) -> Int { self.size }

pub fn NlpposbrillFrame::get(self : NlpposbrillFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbrillFrame::set(self : NlpposbrillFrame, i : Int, v : Double) -> NlpposbrillFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbrillFrame::sum(self : NlpposbrillFrame) -> Double { @_common.sum(self.data) }

pub fn NlpposbrillFrame::mean(self : NlpposbrillFrame) -> Double { @_common.mean(self.data) }

pub fn NlpposbrillFrame::scale(self : NlpposbrillFrame, f : Double) -> NlpposbrillFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbrillFrame::add(self : NlpposbrillFrame, other : NlpposbrillFrame) -> NlpposbrillFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbrillFrame::copy(self : NlpposbrillFrame) -> NlpposbrillFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbrillFrame::fill(self : NlpposbrillFrame, v : Double) -> NlpposbrillFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbrillFrame::min(self : NlpposbrillFrame) -> Double { @_common.min(self.data) }

pub fn NlpposbrillFrame::max(self : NlpposbrillFrame) -> Double { @_common.max(self.data) }

pub fn NlpposbrillFrame::to_string(self : NlpposbrillFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbrillTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_table_make(size : Int) -> NlpposbrillTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbrillTable::len(self : NlpposbrillTable) -> Int { self.size }

pub fn NlpposbrillTable::get(self : NlpposbrillTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbrillTable::set(self : NlpposbrillTable, i : Int, v : Double) -> NlpposbrillTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbrillTable::sum(self : NlpposbrillTable) -> Double { @_common.sum(self.data) }

pub fn NlpposbrillTable::mean(self : NlpposbrillTable) -> Double { @_common.mean(self.data) }

pub fn NlpposbrillTable::scale(self : NlpposbrillTable, f : Double) -> NlpposbrillTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbrillTable::add(self : NlpposbrillTable, other : NlpposbrillTable) -> NlpposbrillTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbrillTable::copy(self : NlpposbrillTable) -> NlpposbrillTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbrillTable::fill(self : NlpposbrillTable, v : Double) -> NlpposbrillTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbrillTable::min(self : NlpposbrillTable) -> Double { @_common.min(self.data) }

pub fn NlpposbrillTable::max(self : NlpposbrillTable) -> Double { @_common.max(self.data) }

pub fn NlpposbrillTable::to_string(self : NlpposbrillTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbrillGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_graphn_make(size : Int) -> NlpposbrillGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbrillGraphN::len(self : NlpposbrillGraphN) -> Int { self.size }

pub fn NlpposbrillGraphN::get(self : NlpposbrillGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbrillGraphN::set(self : NlpposbrillGraphN, i : Int, v : Double) -> NlpposbrillGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbrillGraphN::sum(self : NlpposbrillGraphN) -> Double { @_common.sum(self.data) }

pub fn NlpposbrillGraphN::mean(self : NlpposbrillGraphN) -> Double { @_common.mean(self.data) }

pub fn NlpposbrillGraphN::scale(self : NlpposbrillGraphN, f : Double) -> NlpposbrillGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbrillGraphN::add(self : NlpposbrillGraphN, other : NlpposbrillGraphN) -> NlpposbrillGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbrillGraphN::copy(self : NlpposbrillGraphN) -> NlpposbrillGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbrillGraphN::fill(self : NlpposbrillGraphN, v : Double) -> NlpposbrillGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbrillGraphN::min(self : NlpposbrillGraphN) -> Double { @_common.min(self.data) }

pub fn NlpposbrillGraphN::max(self : NlpposbrillGraphN) -> Double { @_common.max(self.data) }

pub fn NlpposbrillGraphN::to_string(self : NlpposbrillGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbrillNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_node_make(size : Int) -> NlpposbrillNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbrillNode::len(self : NlpposbrillNode) -> Int { self.size }

pub fn NlpposbrillNode::get(self : NlpposbrillNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbrillNode::set(self : NlpposbrillNode, i : Int, v : Double) -> NlpposbrillNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbrillNode::sum(self : NlpposbrillNode) -> Double { @_common.sum(self.data) }

pub fn NlpposbrillNode::mean(self : NlpposbrillNode) -> Double { @_common.mean(self.data) }

pub fn NlpposbrillNode::scale(self : NlpposbrillNode, f : Double) -> NlpposbrillNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbrillNode::add(self : NlpposbrillNode, other : NlpposbrillNode) -> NlpposbrillNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbrillNode::copy(self : NlpposbrillNode) -> NlpposbrillNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbrillNode::fill(self : NlpposbrillNode, v : Double) -> NlpposbrillNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbrillNode::min(self : NlpposbrillNode) -> Double { @_common.min(self.data) }

pub fn NlpposbrillNode::max(self : NlpposbrillNode) -> Double { @_common.max(self.data) }

pub fn NlpposbrillNode::to_string(self : NlpposbrillNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbrillEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_edge_make(size : Int) -> NlpposbrillEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbrillEdge::len(self : NlpposbrillEdge) -> Int { self.size }

pub fn NlpposbrillEdge::get(self : NlpposbrillEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbrillEdge::set(self : NlpposbrillEdge, i : Int, v : Double) -> NlpposbrillEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbrillEdge::sum(self : NlpposbrillEdge) -> Double { @_common.sum(self.data) }

pub fn NlpposbrillEdge::mean(self : NlpposbrillEdge) -> Double { @_common.mean(self.data) }

pub fn NlpposbrillEdge::scale(self : NlpposbrillEdge, f : Double) -> NlpposbrillEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbrillEdge::add(self : NlpposbrillEdge, other : NlpposbrillEdge) -> NlpposbrillEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbrillEdge::copy(self : NlpposbrillEdge) -> NlpposbrillEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbrillEdge::fill(self : NlpposbrillEdge, v : Double) -> NlpposbrillEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbrillEdge::min(self : NlpposbrillEdge) -> Double { @_common.min(self.data) }

pub fn NlpposbrillEdge::max(self : NlpposbrillEdge) -> Double { @_common.max(self.data) }

pub fn NlpposbrillEdge::to_string(self : NlpposbrillEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbrillPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_path_make(size : Int) -> NlpposbrillPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbrillPath::len(self : NlpposbrillPath) -> Int { self.size }

pub fn NlpposbrillPath::get(self : NlpposbrillPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbrillPath::set(self : NlpposbrillPath, i : Int, v : Double) -> NlpposbrillPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbrillPath::sum(self : NlpposbrillPath) -> Double { @_common.sum(self.data) }

pub fn NlpposbrillPath::mean(self : NlpposbrillPath) -> Double { @_common.mean(self.data) }

pub fn NlpposbrillPath::scale(self : NlpposbrillPath, f : Double) -> NlpposbrillPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbrillPath::add(self : NlpposbrillPath, other : NlpposbrillPath) -> NlpposbrillPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbrillPath::copy(self : NlpposbrillPath) -> NlpposbrillPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbrillPath::fill(self : NlpposbrillPath, v : Double) -> NlpposbrillPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbrillPath::min(self : NlpposbrillPath) -> Double { @_common.min(self.data) }

pub fn NlpposbrillPath::max(self : NlpposbrillPath) -> Double { @_common.max(self.data) }

pub fn NlpposbrillPath::to_string(self : NlpposbrillPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbrillCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_cluster_make(size : Int) -> NlpposbrillCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbrillCluster::len(self : NlpposbrillCluster) -> Int { self.size }

pub fn NlpposbrillCluster::get(self : NlpposbrillCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbrillCluster::set(self : NlpposbrillCluster, i : Int, v : Double) -> NlpposbrillCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbrillCluster::sum(self : NlpposbrillCluster) -> Double { @_common.sum(self.data) }

pub fn NlpposbrillCluster::mean(self : NlpposbrillCluster) -> Double { @_common.mean(self.data) }

pub fn NlpposbrillCluster::scale(self : NlpposbrillCluster, f : Double) -> NlpposbrillCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbrillCluster::add(self : NlpposbrillCluster, other : NlpposbrillCluster) -> NlpposbrillCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbrillCluster::copy(self : NlpposbrillCluster) -> NlpposbrillCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbrillCluster::fill(self : NlpposbrillCluster, v : Double) -> NlpposbrillCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbrillCluster::min(self : NlpposbrillCluster) -> Double { @_common.min(self.data) }

pub fn NlpposbrillCluster::max(self : NlpposbrillCluster) -> Double { @_common.max(self.data) }

pub fn NlpposbrillCluster::to_string(self : NlpposbrillCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbrillModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_model_make(size : Int) -> NlpposbrillModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbrillModel::len(self : NlpposbrillModel) -> Int { self.size }

pub fn NlpposbrillModel::get(self : NlpposbrillModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbrillModel::set(self : NlpposbrillModel, i : Int, v : Double) -> NlpposbrillModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbrillModel::sum(self : NlpposbrillModel) -> Double { @_common.sum(self.data) }

pub fn NlpposbrillModel::mean(self : NlpposbrillModel) -> Double { @_common.mean(self.data) }

pub fn NlpposbrillModel::scale(self : NlpposbrillModel, f : Double) -> NlpposbrillModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbrillModel::add(self : NlpposbrillModel, other : NlpposbrillModel) -> NlpposbrillModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbrillModel::copy(self : NlpposbrillModel) -> NlpposbrillModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbrillModel::fill(self : NlpposbrillModel, v : Double) -> NlpposbrillModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbrillModel::min(self : NlpposbrillModel) -> Double { @_common.min(self.data) }

pub fn NlpposbrillModel::max(self : NlpposbrillModel) -> Double { @_common.max(self.data) }

pub fn NlpposbrillModel::to_string(self : NlpposbrillModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbrillLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_layer_make(size : Int) -> NlpposbrillLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbrillLayer::len(self : NlpposbrillLayer) -> Int { self.size }

pub fn NlpposbrillLayer::get(self : NlpposbrillLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbrillLayer::set(self : NlpposbrillLayer, i : Int, v : Double) -> NlpposbrillLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbrillLayer::sum(self : NlpposbrillLayer) -> Double { @_common.sum(self.data) }

pub fn NlpposbrillLayer::mean(self : NlpposbrillLayer) -> Double { @_common.mean(self.data) }

pub fn NlpposbrillLayer::scale(self : NlpposbrillLayer, f : Double) -> NlpposbrillLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbrillLayer::add(self : NlpposbrillLayer, other : NlpposbrillLayer) -> NlpposbrillLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbrillLayer::copy(self : NlpposbrillLayer) -> NlpposbrillLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbrillLayer::fill(self : NlpposbrillLayer, v : Double) -> NlpposbrillLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbrillLayer::min(self : NlpposbrillLayer) -> Double { @_common.min(self.data) }

pub fn NlpposbrillLayer::max(self : NlpposbrillLayer) -> Double { @_common.max(self.data) }

pub fn NlpposbrillLayer::to_string(self : NlpposbrillLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbrillBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_buffer_make(size : Int) -> NlpposbrillBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbrillBuffer::len(self : NlpposbrillBuffer) -> Int { self.size }

pub fn NlpposbrillBuffer::get(self : NlpposbrillBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbrillBuffer::set(self : NlpposbrillBuffer, i : Int, v : Double) -> NlpposbrillBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbrillBuffer::sum(self : NlpposbrillBuffer) -> Double { @_common.sum(self.data) }

pub fn NlpposbrillBuffer::mean(self : NlpposbrillBuffer) -> Double { @_common.mean(self.data) }

pub fn NlpposbrillBuffer::scale(self : NlpposbrillBuffer, f : Double) -> NlpposbrillBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbrillBuffer::add(self : NlpposbrillBuffer, other : NlpposbrillBuffer) -> NlpposbrillBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbrillBuffer::copy(self : NlpposbrillBuffer) -> NlpposbrillBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbrillBuffer::fill(self : NlpposbrillBuffer, v : Double) -> NlpposbrillBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbrillBuffer::min(self : NlpposbrillBuffer) -> Double { @_common.min(self.data) }

pub fn NlpposbrillBuffer::max(self : NlpposbrillBuffer) -> Double { @_common.max(self.data) }

pub fn NlpposbrillBuffer::to_string(self : NlpposbrillBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbrillCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_cursor_make(size : Int) -> NlpposbrillCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbrillCursor::len(self : NlpposbrillCursor) -> Int { self.size }

pub fn NlpposbrillCursor::get(self : NlpposbrillCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbrillCursor::set(self : NlpposbrillCursor, i : Int, v : Double) -> NlpposbrillCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbrillCursor::sum(self : NlpposbrillCursor) -> Double { @_common.sum(self.data) }

pub fn NlpposbrillCursor::mean(self : NlpposbrillCursor) -> Double { @_common.mean(self.data) }

pub fn NlpposbrillCursor::scale(self : NlpposbrillCursor, f : Double) -> NlpposbrillCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbrillCursor::add(self : NlpposbrillCursor, other : NlpposbrillCursor) -> NlpposbrillCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbrillCursor::copy(self : NlpposbrillCursor) -> NlpposbrillCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbrillCursor::fill(self : NlpposbrillCursor, v : Double) -> NlpposbrillCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbrillCursor::min(self : NlpposbrillCursor) -> Double { @_common.min(self.data) }

pub fn NlpposbrillCursor::max(self : NlpposbrillCursor) -> Double { @_common.max(self.data) }

pub fn NlpposbrillCursor::to_string(self : NlpposbrillCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbrillView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_view_make(size : Int) -> NlpposbrillView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbrillView::len(self : NlpposbrillView) -> Int { self.size }

pub fn NlpposbrillView::get(self : NlpposbrillView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbrillView::set(self : NlpposbrillView, i : Int, v : Double) -> NlpposbrillView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbrillView::sum(self : NlpposbrillView) -> Double { @_common.sum(self.data) }

pub fn NlpposbrillView::mean(self : NlpposbrillView) -> Double { @_common.mean(self.data) }

pub fn NlpposbrillView::scale(self : NlpposbrillView, f : Double) -> NlpposbrillView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbrillView::add(self : NlpposbrillView, other : NlpposbrillView) -> NlpposbrillView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbrillView::copy(self : NlpposbrillView) -> NlpposbrillView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbrillView::fill(self : NlpposbrillView, v : Double) -> NlpposbrillView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbrillView::min(self : NlpposbrillView) -> Double { @_common.min(self.data) }

pub fn NlpposbrillView::max(self : NlpposbrillView) -> Double { @_common.max(self.data) }

pub fn NlpposbrillView::to_string(self : NlpposbrillView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbrillRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_range_make(size : Int) -> NlpposbrillRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbrillRange::len(self : NlpposbrillRange) -> Int { self.size }

pub fn NlpposbrillRange::get(self : NlpposbrillRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbrillRange::set(self : NlpposbrillRange, i : Int, v : Double) -> NlpposbrillRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbrillRange::sum(self : NlpposbrillRange) -> Double { @_common.sum(self.data) }

pub fn NlpposbrillRange::mean(self : NlpposbrillRange) -> Double { @_common.mean(self.data) }

pub fn NlpposbrillRange::scale(self : NlpposbrillRange, f : Double) -> NlpposbrillRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbrillRange::add(self : NlpposbrillRange, other : NlpposbrillRange) -> NlpposbrillRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbrillRange::copy(self : NlpposbrillRange) -> NlpposbrillRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbrillRange::fill(self : NlpposbrillRange, v : Double) -> NlpposbrillRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbrillRange::min(self : NlpposbrillRange) -> Double { @_common.min(self.data) }

pub fn NlpposbrillRange::max(self : NlpposbrillRange) -> Double { @_common.max(self.data) }

pub fn NlpposbrillRange::to_string(self : NlpposbrillRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct NlpposbrillSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_brill_slice_make(size : Int) -> NlpposbrillSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn NlpposbrillSlice::len(self : NlpposbrillSlice) -> Int { self.size }

pub fn NlpposbrillSlice::get(self : NlpposbrillSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn NlpposbrillSlice::set(self : NlpposbrillSlice, i : Int, v : Double) -> NlpposbrillSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn NlpposbrillSlice::sum(self : NlpposbrillSlice) -> Double { @_common.sum(self.data) }

pub fn NlpposbrillSlice::mean(self : NlpposbrillSlice) -> Double { @_common.mean(self.data) }

pub fn NlpposbrillSlice::scale(self : NlpposbrillSlice, f : Double) -> NlpposbrillSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn NlpposbrillSlice::add(self : NlpposbrillSlice, other : NlpposbrillSlice) -> NlpposbrillSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn NlpposbrillSlice::copy(self : NlpposbrillSlice) -> NlpposbrillSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn NlpposbrillSlice::fill(self : NlpposbrillSlice, v : Double) -> NlpposbrillSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn NlpposbrillSlice::min(self : NlpposbrillSlice) -> Double { @_common.min(self.data) }

pub fn NlpposbrillSlice::max(self : NlpposbrillSlice) -> Double { @_common.max(self.data) }

pub fn NlpposbrillSlice::to_string(self : NlpposbrillSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

