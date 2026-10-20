///===
/// extcore/sort_exchange_strand

pub(all) struct SortexchangestrandPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_exchange_strand_make_point(x : Double, y : Double) -> SortexchangestrandPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_exchange_strand_make_point3(x : Double, y : Double, z : Double) -> SortexchangestrandPoint {
  { x, y, z, label: 0 }
}

pub fn SortexchangestrandPoint::x(self : SortexchangestrandPoint) -> Double { self.x }

pub fn SortexchangestrandPoint::y(self : SortexchangestrandPoint) -> Double { self.y }

pub fn SortexchangestrandPoint::z(self : SortexchangestrandPoint) -> Double { self.z }

pub fn SortexchangestrandPoint::label(self : SortexchangestrandPoint) -> Int { self.label }

pub fn SortexchangestrandPoint::dist(self : SortexchangestrandPoint, other : SortexchangestrandPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortexchangestrandPoint::add(self : SortexchangestrandPoint, other : SortexchangestrandPoint) -> SortexchangestrandPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortexchangestrandPoint::sub(self : SortexchangestrandPoint, other : SortexchangestrandPoint) -> SortexchangestrandPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortexchangestrandPoint::scale(self : SortexchangestrandPoint, s : Double) -> SortexchangestrandPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortexchangestrandPoint::dot(self : SortexchangestrandPoint, other : SortexchangestrandPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortexchangestrandPoint::cross(self : SortexchangestrandPoint, other : SortexchangestrandPoint) -> SortexchangestrandPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortexchangestrandPoint::norm(self : SortexchangestrandPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortexchangestrandPoint::normalize(self : SortexchangestrandPoint) -> SortexchangestrandPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangestrandPoint::negate(self : SortexchangestrandPoint) -> SortexchangestrandPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortexchangestrandPoint::mid(self : SortexchangestrandPoint, other : SortexchangestrandPoint) -> SortexchangestrandPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortexchangestrandPoint::lerp(self : SortexchangestrandPoint, other : SortexchangestrandPoint, t : Double) -> SortexchangestrandPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortexchangestrandPoint::to_string(self : SortexchangestrandPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortexchangestrandSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_exchange_strand_make_series(vals : Array[Double], name : String) -> SortexchangestrandSeries {
  { vals, name, meta: 0 }
}

pub fn SortexchangestrandSeries::len(self : SortexchangestrandSeries) -> Int { self.vals.length() }

pub fn SortexchangestrandSeries::sum(self : SortexchangestrandSeries) -> Double { @_common.sum(self.vals) }

pub fn SortexchangestrandSeries::mean(self : SortexchangestrandSeries) -> Double { @_common.mean(self.vals) }

pub fn SortexchangestrandSeries::min(self : SortexchangestrandSeries) -> Double { @_common.min(self.vals) }

pub fn SortexchangestrandSeries::max(self : SortexchangestrandSeries) -> Double { @_common.max(self.vals) }

pub fn SortexchangestrandSeries::range(self : SortexchangestrandSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortexchangestrandSeries::variance(self : SortexchangestrandSeries) -> Double { @_common.variance(self.vals) }

pub fn SortexchangestrandSeries::std(self : SortexchangestrandSeries) -> Double { @_common.std(self.vals) }

pub fn SortexchangestrandSeries::median(self : SortexchangestrandSeries) -> Double { @_common.median(self.vals) }

pub fn SortexchangestrandSeries::scale(self : SortexchangestrandSeries, f : Double) -> SortexchangestrandSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortexchangestrandSeries::add(self : SortexchangestrandSeries, other : SortexchangestrandSeries) -> SortexchangestrandSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortexchangestrandSeries::sub(self : SortexchangestrandSeries, other : SortexchangestrandSeries) -> SortexchangestrandSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortexchangestrandSeries::normalize(self : SortexchangestrandSeries) -> SortexchangestrandSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortexchangestrandSeries::cumsum(self : SortexchangestrandSeries) -> SortexchangestrandSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortexchangestrandSeries::to_string(self : SortexchangestrandSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortexchangestrandMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_exchange_strand_make_matrix(rows : Int, cols : Int, val : Double) -> SortexchangestrandMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_exchange_strand_matrix_identity(n : Int) -> SortexchangestrandMatrix {
  let m = sort_exchange_strand_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortexchangestrandMatrix::get(self : SortexchangestrandMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortexchangestrandMatrix::transpose(self : SortexchangestrandMatrix) -> SortexchangestrandMatrix {
  let result = sort_exchange_strand_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortexchangestrandMatrix::add(self : SortexchangestrandMatrix, other : SortexchangestrandMatrix) -> SortexchangestrandMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_exchange_strand_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortexchangestrandMatrix::scale(self : SortexchangestrandMatrix, s : Double) -> SortexchangestrandMatrix {
  let result = sort_exchange_strand_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortexchangestrandMatrix::multiply(self : SortexchangestrandMatrix, other : SortexchangestrandMatrix) -> SortexchangestrandMatrix {
  if self.cols != other.rows { return sort_exchange_strand_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_exchange_strand_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortexchangestrandMatrix::trace(self : SortexchangestrandMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortexchangestrandMatrix::det(self : SortexchangestrandMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortexchangestrandMatrix::norm(self : SortexchangestrandMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortexchangestrandMatrix::to_string(self : SortexchangestrandMatrix) -> String {
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

pub(all) struct SortexchangestrandVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_exchange_strand_make_vector(comps : Array[Double]) -> SortexchangestrandVector {
  { comps, dim: comps.length() }
}

pub fn sort_exchange_strand_vector_zero(dim : Int) -> SortexchangestrandVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortexchangestrandVector::add(self : SortexchangestrandVector, other : SortexchangestrandVector) -> SortexchangestrandVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangestrandVector::sub(self : SortexchangestrandVector, other : SortexchangestrandVector) -> SortexchangestrandVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortexchangestrandVector::scale(self : SortexchangestrandVector, s : Double) -> SortexchangestrandVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortexchangestrandVector::dot(self : SortexchangestrandVector, other : SortexchangestrandVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortexchangestrandVector::norm(self : SortexchangestrandVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortexchangestrandVector::normalize(self : SortexchangestrandVector) -> SortexchangestrandVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortexchangestrandVector::dist(self : SortexchangestrandVector, other : SortexchangestrandVector) -> Double {
  self.sub(other).norm()
}

pub fn SortexchangestrandVector::to_string(self : SortexchangestrandVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_exchange_strand_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_exchange_strand_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_exchange_strand_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_exchange_strand_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_exchange_strand_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_exchange_strand_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_exchange_strand_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_exchange_strand_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_exchange_strand_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_exchange_strand_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_exchange_strand_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_exchange_strand_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_exchange_strand_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_exchange_strand_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_exchange_strand_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_exchange_strand_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_exchange_strand_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_exchange_strand_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_exchange_strand_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_exchange_strand_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_exchange_strand_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_exchange_strand_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_exchange_strand_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_exchange_strand_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_exchange_strand_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_exchange_strand_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_exchange_strand_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_exchange_strand_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_exchange_strand_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortexchangestrandFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_frame_make(size : Int) -> SortexchangestrandFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestrandFrame::len(self : SortexchangestrandFrame) -> Int { self.size }

pub fn SortexchangestrandFrame::get(self : SortexchangestrandFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestrandFrame::set(self : SortexchangestrandFrame, i : Int, v : Double) -> SortexchangestrandFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestrandFrame::sum(self : SortexchangestrandFrame) -> Double { @_common.sum(self.data) }

pub fn SortexchangestrandFrame::mean(self : SortexchangestrandFrame) -> Double { @_common.mean(self.data) }

pub fn SortexchangestrandFrame::scale(self : SortexchangestrandFrame, f : Double) -> SortexchangestrandFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandFrame::add(self : SortexchangestrandFrame, other : SortexchangestrandFrame) -> SortexchangestrandFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestrandFrame::copy(self : SortexchangestrandFrame) -> SortexchangestrandFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandFrame::fill(self : SortexchangestrandFrame, v : Double) -> SortexchangestrandFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandFrame::min(self : SortexchangestrandFrame) -> Double { @_common.min(self.data) }

pub fn SortexchangestrandFrame::max(self : SortexchangestrandFrame) -> Double { @_common.max(self.data) }

pub fn SortexchangestrandFrame::to_string(self : SortexchangestrandFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_table_make(size : Int) -> SortexchangestrandTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestrandTable::len(self : SortexchangestrandTable) -> Int { self.size }

pub fn SortexchangestrandTable::get(self : SortexchangestrandTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestrandTable::set(self : SortexchangestrandTable, i : Int, v : Double) -> SortexchangestrandTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestrandTable::sum(self : SortexchangestrandTable) -> Double { @_common.sum(self.data) }

pub fn SortexchangestrandTable::mean(self : SortexchangestrandTable) -> Double { @_common.mean(self.data) }

pub fn SortexchangestrandTable::scale(self : SortexchangestrandTable, f : Double) -> SortexchangestrandTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandTable::add(self : SortexchangestrandTable, other : SortexchangestrandTable) -> SortexchangestrandTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestrandTable::copy(self : SortexchangestrandTable) -> SortexchangestrandTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandTable::fill(self : SortexchangestrandTable, v : Double) -> SortexchangestrandTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandTable::min(self : SortexchangestrandTable) -> Double { @_common.min(self.data) }

pub fn SortexchangestrandTable::max(self : SortexchangestrandTable) -> Double { @_common.max(self.data) }

pub fn SortexchangestrandTable::to_string(self : SortexchangestrandTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_graphn_make(size : Int) -> SortexchangestrandGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestrandGraphN::len(self : SortexchangestrandGraphN) -> Int { self.size }

pub fn SortexchangestrandGraphN::get(self : SortexchangestrandGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestrandGraphN::set(self : SortexchangestrandGraphN, i : Int, v : Double) -> SortexchangestrandGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestrandGraphN::sum(self : SortexchangestrandGraphN) -> Double { @_common.sum(self.data) }

pub fn SortexchangestrandGraphN::mean(self : SortexchangestrandGraphN) -> Double { @_common.mean(self.data) }

pub fn SortexchangestrandGraphN::scale(self : SortexchangestrandGraphN, f : Double) -> SortexchangestrandGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandGraphN::add(self : SortexchangestrandGraphN, other : SortexchangestrandGraphN) -> SortexchangestrandGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestrandGraphN::copy(self : SortexchangestrandGraphN) -> SortexchangestrandGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandGraphN::fill(self : SortexchangestrandGraphN, v : Double) -> SortexchangestrandGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandGraphN::min(self : SortexchangestrandGraphN) -> Double { @_common.min(self.data) }

pub fn SortexchangestrandGraphN::max(self : SortexchangestrandGraphN) -> Double { @_common.max(self.data) }

pub fn SortexchangestrandGraphN::to_string(self : SortexchangestrandGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_node_make(size : Int) -> SortexchangestrandNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestrandNode::len(self : SortexchangestrandNode) -> Int { self.size }

pub fn SortexchangestrandNode::get(self : SortexchangestrandNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestrandNode::set(self : SortexchangestrandNode, i : Int, v : Double) -> SortexchangestrandNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestrandNode::sum(self : SortexchangestrandNode) -> Double { @_common.sum(self.data) }

pub fn SortexchangestrandNode::mean(self : SortexchangestrandNode) -> Double { @_common.mean(self.data) }

pub fn SortexchangestrandNode::scale(self : SortexchangestrandNode, f : Double) -> SortexchangestrandNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandNode::add(self : SortexchangestrandNode, other : SortexchangestrandNode) -> SortexchangestrandNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestrandNode::copy(self : SortexchangestrandNode) -> SortexchangestrandNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandNode::fill(self : SortexchangestrandNode, v : Double) -> SortexchangestrandNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandNode::min(self : SortexchangestrandNode) -> Double { @_common.min(self.data) }

pub fn SortexchangestrandNode::max(self : SortexchangestrandNode) -> Double { @_common.max(self.data) }

pub fn SortexchangestrandNode::to_string(self : SortexchangestrandNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_edge_make(size : Int) -> SortexchangestrandEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestrandEdge::len(self : SortexchangestrandEdge) -> Int { self.size }

pub fn SortexchangestrandEdge::get(self : SortexchangestrandEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestrandEdge::set(self : SortexchangestrandEdge, i : Int, v : Double) -> SortexchangestrandEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestrandEdge::sum(self : SortexchangestrandEdge) -> Double { @_common.sum(self.data) }

pub fn SortexchangestrandEdge::mean(self : SortexchangestrandEdge) -> Double { @_common.mean(self.data) }

pub fn SortexchangestrandEdge::scale(self : SortexchangestrandEdge, f : Double) -> SortexchangestrandEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandEdge::add(self : SortexchangestrandEdge, other : SortexchangestrandEdge) -> SortexchangestrandEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestrandEdge::copy(self : SortexchangestrandEdge) -> SortexchangestrandEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandEdge::fill(self : SortexchangestrandEdge, v : Double) -> SortexchangestrandEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandEdge::min(self : SortexchangestrandEdge) -> Double { @_common.min(self.data) }

pub fn SortexchangestrandEdge::max(self : SortexchangestrandEdge) -> Double { @_common.max(self.data) }

pub fn SortexchangestrandEdge::to_string(self : SortexchangestrandEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_path_make(size : Int) -> SortexchangestrandPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestrandPath::len(self : SortexchangestrandPath) -> Int { self.size }

pub fn SortexchangestrandPath::get(self : SortexchangestrandPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestrandPath::set(self : SortexchangestrandPath, i : Int, v : Double) -> SortexchangestrandPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestrandPath::sum(self : SortexchangestrandPath) -> Double { @_common.sum(self.data) }

pub fn SortexchangestrandPath::mean(self : SortexchangestrandPath) -> Double { @_common.mean(self.data) }

pub fn SortexchangestrandPath::scale(self : SortexchangestrandPath, f : Double) -> SortexchangestrandPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandPath::add(self : SortexchangestrandPath, other : SortexchangestrandPath) -> SortexchangestrandPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestrandPath::copy(self : SortexchangestrandPath) -> SortexchangestrandPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandPath::fill(self : SortexchangestrandPath, v : Double) -> SortexchangestrandPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandPath::min(self : SortexchangestrandPath) -> Double { @_common.min(self.data) }

pub fn SortexchangestrandPath::max(self : SortexchangestrandPath) -> Double { @_common.max(self.data) }

pub fn SortexchangestrandPath::to_string(self : SortexchangestrandPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_cluster_make(size : Int) -> SortexchangestrandCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestrandCluster::len(self : SortexchangestrandCluster) -> Int { self.size }

pub fn SortexchangestrandCluster::get(self : SortexchangestrandCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestrandCluster::set(self : SortexchangestrandCluster, i : Int, v : Double) -> SortexchangestrandCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestrandCluster::sum(self : SortexchangestrandCluster) -> Double { @_common.sum(self.data) }

pub fn SortexchangestrandCluster::mean(self : SortexchangestrandCluster) -> Double { @_common.mean(self.data) }

pub fn SortexchangestrandCluster::scale(self : SortexchangestrandCluster, f : Double) -> SortexchangestrandCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandCluster::add(self : SortexchangestrandCluster, other : SortexchangestrandCluster) -> SortexchangestrandCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestrandCluster::copy(self : SortexchangestrandCluster) -> SortexchangestrandCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandCluster::fill(self : SortexchangestrandCluster, v : Double) -> SortexchangestrandCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandCluster::min(self : SortexchangestrandCluster) -> Double { @_common.min(self.data) }

pub fn SortexchangestrandCluster::max(self : SortexchangestrandCluster) -> Double { @_common.max(self.data) }

pub fn SortexchangestrandCluster::to_string(self : SortexchangestrandCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_model_make(size : Int) -> SortexchangestrandModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestrandModel::len(self : SortexchangestrandModel) -> Int { self.size }

pub fn SortexchangestrandModel::get(self : SortexchangestrandModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestrandModel::set(self : SortexchangestrandModel, i : Int, v : Double) -> SortexchangestrandModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestrandModel::sum(self : SortexchangestrandModel) -> Double { @_common.sum(self.data) }

pub fn SortexchangestrandModel::mean(self : SortexchangestrandModel) -> Double { @_common.mean(self.data) }

pub fn SortexchangestrandModel::scale(self : SortexchangestrandModel, f : Double) -> SortexchangestrandModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandModel::add(self : SortexchangestrandModel, other : SortexchangestrandModel) -> SortexchangestrandModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestrandModel::copy(self : SortexchangestrandModel) -> SortexchangestrandModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandModel::fill(self : SortexchangestrandModel, v : Double) -> SortexchangestrandModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandModel::min(self : SortexchangestrandModel) -> Double { @_common.min(self.data) }

pub fn SortexchangestrandModel::max(self : SortexchangestrandModel) -> Double { @_common.max(self.data) }

pub fn SortexchangestrandModel::to_string(self : SortexchangestrandModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_layer_make(size : Int) -> SortexchangestrandLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestrandLayer::len(self : SortexchangestrandLayer) -> Int { self.size }

pub fn SortexchangestrandLayer::get(self : SortexchangestrandLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestrandLayer::set(self : SortexchangestrandLayer, i : Int, v : Double) -> SortexchangestrandLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestrandLayer::sum(self : SortexchangestrandLayer) -> Double { @_common.sum(self.data) }

pub fn SortexchangestrandLayer::mean(self : SortexchangestrandLayer) -> Double { @_common.mean(self.data) }

pub fn SortexchangestrandLayer::scale(self : SortexchangestrandLayer, f : Double) -> SortexchangestrandLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandLayer::add(self : SortexchangestrandLayer, other : SortexchangestrandLayer) -> SortexchangestrandLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestrandLayer::copy(self : SortexchangestrandLayer) -> SortexchangestrandLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandLayer::fill(self : SortexchangestrandLayer, v : Double) -> SortexchangestrandLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandLayer::min(self : SortexchangestrandLayer) -> Double { @_common.min(self.data) }

pub fn SortexchangestrandLayer::max(self : SortexchangestrandLayer) -> Double { @_common.max(self.data) }

pub fn SortexchangestrandLayer::to_string(self : SortexchangestrandLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_buffer_make(size : Int) -> SortexchangestrandBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestrandBuffer::len(self : SortexchangestrandBuffer) -> Int { self.size }

pub fn SortexchangestrandBuffer::get(self : SortexchangestrandBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestrandBuffer::set(self : SortexchangestrandBuffer, i : Int, v : Double) -> SortexchangestrandBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestrandBuffer::sum(self : SortexchangestrandBuffer) -> Double { @_common.sum(self.data) }

pub fn SortexchangestrandBuffer::mean(self : SortexchangestrandBuffer) -> Double { @_common.mean(self.data) }

pub fn SortexchangestrandBuffer::scale(self : SortexchangestrandBuffer, f : Double) -> SortexchangestrandBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandBuffer::add(self : SortexchangestrandBuffer, other : SortexchangestrandBuffer) -> SortexchangestrandBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestrandBuffer::copy(self : SortexchangestrandBuffer) -> SortexchangestrandBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandBuffer::fill(self : SortexchangestrandBuffer, v : Double) -> SortexchangestrandBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandBuffer::min(self : SortexchangestrandBuffer) -> Double { @_common.min(self.data) }

pub fn SortexchangestrandBuffer::max(self : SortexchangestrandBuffer) -> Double { @_common.max(self.data) }

pub fn SortexchangestrandBuffer::to_string(self : SortexchangestrandBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_cursor_make(size : Int) -> SortexchangestrandCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestrandCursor::len(self : SortexchangestrandCursor) -> Int { self.size }

pub fn SortexchangestrandCursor::get(self : SortexchangestrandCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestrandCursor::set(self : SortexchangestrandCursor, i : Int, v : Double) -> SortexchangestrandCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestrandCursor::sum(self : SortexchangestrandCursor) -> Double { @_common.sum(self.data) }

pub fn SortexchangestrandCursor::mean(self : SortexchangestrandCursor) -> Double { @_common.mean(self.data) }

pub fn SortexchangestrandCursor::scale(self : SortexchangestrandCursor, f : Double) -> SortexchangestrandCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandCursor::add(self : SortexchangestrandCursor, other : SortexchangestrandCursor) -> SortexchangestrandCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestrandCursor::copy(self : SortexchangestrandCursor) -> SortexchangestrandCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandCursor::fill(self : SortexchangestrandCursor, v : Double) -> SortexchangestrandCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandCursor::min(self : SortexchangestrandCursor) -> Double { @_common.min(self.data) }

pub fn SortexchangestrandCursor::max(self : SortexchangestrandCursor) -> Double { @_common.max(self.data) }

pub fn SortexchangestrandCursor::to_string(self : SortexchangestrandCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_view_make(size : Int) -> SortexchangestrandView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestrandView::len(self : SortexchangestrandView) -> Int { self.size }

pub fn SortexchangestrandView::get(self : SortexchangestrandView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestrandView::set(self : SortexchangestrandView, i : Int, v : Double) -> SortexchangestrandView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestrandView::sum(self : SortexchangestrandView) -> Double { @_common.sum(self.data) }

pub fn SortexchangestrandView::mean(self : SortexchangestrandView) -> Double { @_common.mean(self.data) }

pub fn SortexchangestrandView::scale(self : SortexchangestrandView, f : Double) -> SortexchangestrandView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandView::add(self : SortexchangestrandView, other : SortexchangestrandView) -> SortexchangestrandView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestrandView::copy(self : SortexchangestrandView) -> SortexchangestrandView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandView::fill(self : SortexchangestrandView, v : Double) -> SortexchangestrandView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandView::min(self : SortexchangestrandView) -> Double { @_common.min(self.data) }

pub fn SortexchangestrandView::max(self : SortexchangestrandView) -> Double { @_common.max(self.data) }

pub fn SortexchangestrandView::to_string(self : SortexchangestrandView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_range_make(size : Int) -> SortexchangestrandRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestrandRange::len(self : SortexchangestrandRange) -> Int { self.size }

pub fn SortexchangestrandRange::get(self : SortexchangestrandRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestrandRange::set(self : SortexchangestrandRange, i : Int, v : Double) -> SortexchangestrandRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestrandRange::sum(self : SortexchangestrandRange) -> Double { @_common.sum(self.data) }

pub fn SortexchangestrandRange::mean(self : SortexchangestrandRange) -> Double { @_common.mean(self.data) }

pub fn SortexchangestrandRange::scale(self : SortexchangestrandRange, f : Double) -> SortexchangestrandRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandRange::add(self : SortexchangestrandRange, other : SortexchangestrandRange) -> SortexchangestrandRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestrandRange::copy(self : SortexchangestrandRange) -> SortexchangestrandRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandRange::fill(self : SortexchangestrandRange, v : Double) -> SortexchangestrandRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandRange::min(self : SortexchangestrandRange) -> Double { @_common.min(self.data) }

pub fn SortexchangestrandRange::max(self : SortexchangestrandRange) -> Double { @_common.max(self.data) }

pub fn SortexchangestrandRange::to_string(self : SortexchangestrandRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_slice_make(size : Int) -> SortexchangestrandSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn SortexchangestrandSlice::len(self : SortexchangestrandSlice) -> Int { self.size }

pub fn SortexchangestrandSlice::get(self : SortexchangestrandSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn SortexchangestrandSlice::set(self : SortexchangestrandSlice, i : Int, v : Double) -> SortexchangestrandSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn SortexchangestrandSlice::sum(self : SortexchangestrandSlice) -> Double { @_common.sum(self.data) }

pub fn SortexchangestrandSlice::mean(self : SortexchangestrandSlice) -> Double { @_common.mean(self.data) }

pub fn SortexchangestrandSlice::scale(self : SortexchangestrandSlice, f : Double) -> SortexchangestrandSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandSlice::add(self : SortexchangestrandSlice, other : SortexchangestrandSlice) -> SortexchangestrandSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn SortexchangestrandSlice::copy(self : SortexchangestrandSlice) -> SortexchangestrandSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandSlice::fill(self : SortexchangestrandSlice, v : Double) -> SortexchangestrandSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn SortexchangestrandSlice::min(self : SortexchangestrandSlice) -> Double { @_common.min(self.data) }

pub fn SortexchangestrandSlice::max(self : SortexchangestrandSlice) -> Double { @_common.max(self.data) }

pub fn SortexchangestrandSlice::to_string(self : SortexchangestrandSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

