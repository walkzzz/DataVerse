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

pub fn sort_exchange_strand_frame_len(s : SortexchangestrandFrame) -> Int { s.size }

pub fn sort_exchange_strand_frame_get(s : SortexchangestrandFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_frame_set(s : SortexchangestrandFrame, i : Int, v : Double) -> SortexchangestrandFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_frame_sum(s : SortexchangestrandFrame) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_strand_frame_mean(s : SortexchangestrandFrame) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_strand_frame_scale(s : SortexchangestrandFrame, f : Double) -> SortexchangestrandFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_frame_add(a : SortexchangestrandFrame, b : SortexchangestrandFrame) -> SortexchangestrandFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_strand_frame_copy(s : SortexchangestrandFrame) -> SortexchangestrandFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_frame_fill(s : SortexchangestrandFrame, v : Double) -> SortexchangestrandFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_frame_min(s : SortexchangestrandFrame) -> Double { @_common.min(s.data) }

pub fn sort_exchange_strand_frame_max(s : SortexchangestrandFrame) -> Double { @_common.max(s.data) }

pub fn sort_exchange_strand_frame_to_string(s : SortexchangestrandFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_table_make(size : Int) -> SortexchangestrandTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_table_len(s : SortexchangestrandTable) -> Int { s.size }

pub fn sort_exchange_strand_table_get(s : SortexchangestrandTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_table_set(s : SortexchangestrandTable, i : Int, v : Double) -> SortexchangestrandTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_table_sum(s : SortexchangestrandTable) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_strand_table_mean(s : SortexchangestrandTable) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_strand_table_scale(s : SortexchangestrandTable, f : Double) -> SortexchangestrandTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_table_add(a : SortexchangestrandTable, b : SortexchangestrandTable) -> SortexchangestrandTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_strand_table_copy(s : SortexchangestrandTable) -> SortexchangestrandTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_table_fill(s : SortexchangestrandTable, v : Double) -> SortexchangestrandTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_table_min(s : SortexchangestrandTable) -> Double { @_common.min(s.data) }

pub fn sort_exchange_strand_table_max(s : SortexchangestrandTable) -> Double { @_common.max(s.data) }

pub fn sort_exchange_strand_table_to_string(s : SortexchangestrandTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_graphn_make(size : Int) -> SortexchangestrandGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_graphn_len(s : SortexchangestrandGraphN) -> Int { s.size }

pub fn sort_exchange_strand_graphn_get(s : SortexchangestrandGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_graphn_set(s : SortexchangestrandGraphN, i : Int, v : Double) -> SortexchangestrandGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_graphn_sum(s : SortexchangestrandGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_strand_graphn_mean(s : SortexchangestrandGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_strand_graphn_scale(s : SortexchangestrandGraphN, f : Double) -> SortexchangestrandGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_graphn_add(a : SortexchangestrandGraphN, b : SortexchangestrandGraphN) -> SortexchangestrandGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_strand_graphn_copy(s : SortexchangestrandGraphN) -> SortexchangestrandGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_graphn_fill(s : SortexchangestrandGraphN, v : Double) -> SortexchangestrandGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_graphn_min(s : SortexchangestrandGraphN) -> Double { @_common.min(s.data) }

pub fn sort_exchange_strand_graphn_max(s : SortexchangestrandGraphN) -> Double { @_common.max(s.data) }

pub fn sort_exchange_strand_graphn_to_string(s : SortexchangestrandGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_node_make(size : Int) -> SortexchangestrandNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_node_len(s : SortexchangestrandNode) -> Int { s.size }

pub fn sort_exchange_strand_node_get(s : SortexchangestrandNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_node_set(s : SortexchangestrandNode, i : Int, v : Double) -> SortexchangestrandNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_node_sum(s : SortexchangestrandNode) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_strand_node_mean(s : SortexchangestrandNode) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_strand_node_scale(s : SortexchangestrandNode, f : Double) -> SortexchangestrandNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_node_add(a : SortexchangestrandNode, b : SortexchangestrandNode) -> SortexchangestrandNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_strand_node_copy(s : SortexchangestrandNode) -> SortexchangestrandNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_node_fill(s : SortexchangestrandNode, v : Double) -> SortexchangestrandNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_node_min(s : SortexchangestrandNode) -> Double { @_common.min(s.data) }

pub fn sort_exchange_strand_node_max(s : SortexchangestrandNode) -> Double { @_common.max(s.data) }

pub fn sort_exchange_strand_node_to_string(s : SortexchangestrandNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_edge_make(size : Int) -> SortexchangestrandEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_edge_len(s : SortexchangestrandEdge) -> Int { s.size }

pub fn sort_exchange_strand_edge_get(s : SortexchangestrandEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_edge_set(s : SortexchangestrandEdge, i : Int, v : Double) -> SortexchangestrandEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_edge_sum(s : SortexchangestrandEdge) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_strand_edge_mean(s : SortexchangestrandEdge) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_strand_edge_scale(s : SortexchangestrandEdge, f : Double) -> SortexchangestrandEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_edge_add(a : SortexchangestrandEdge, b : SortexchangestrandEdge) -> SortexchangestrandEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_strand_edge_copy(s : SortexchangestrandEdge) -> SortexchangestrandEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_edge_fill(s : SortexchangestrandEdge, v : Double) -> SortexchangestrandEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_edge_min(s : SortexchangestrandEdge) -> Double { @_common.min(s.data) }

pub fn sort_exchange_strand_edge_max(s : SortexchangestrandEdge) -> Double { @_common.max(s.data) }

pub fn sort_exchange_strand_edge_to_string(s : SortexchangestrandEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_path_make(size : Int) -> SortexchangestrandPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_path_len(s : SortexchangestrandPath) -> Int { s.size }

pub fn sort_exchange_strand_path_get(s : SortexchangestrandPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_path_set(s : SortexchangestrandPath, i : Int, v : Double) -> SortexchangestrandPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_path_sum(s : SortexchangestrandPath) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_strand_path_mean(s : SortexchangestrandPath) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_strand_path_scale(s : SortexchangestrandPath, f : Double) -> SortexchangestrandPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_path_add(a : SortexchangestrandPath, b : SortexchangestrandPath) -> SortexchangestrandPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_strand_path_copy(s : SortexchangestrandPath) -> SortexchangestrandPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_path_fill(s : SortexchangestrandPath, v : Double) -> SortexchangestrandPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_path_min(s : SortexchangestrandPath) -> Double { @_common.min(s.data) }

pub fn sort_exchange_strand_path_max(s : SortexchangestrandPath) -> Double { @_common.max(s.data) }

pub fn sort_exchange_strand_path_to_string(s : SortexchangestrandPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_cluster_make(size : Int) -> SortexchangestrandCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_cluster_len(s : SortexchangestrandCluster) -> Int { s.size }

pub fn sort_exchange_strand_cluster_get(s : SortexchangestrandCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_cluster_set(s : SortexchangestrandCluster, i : Int, v : Double) -> SortexchangestrandCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_cluster_sum(s : SortexchangestrandCluster) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_strand_cluster_mean(s : SortexchangestrandCluster) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_strand_cluster_scale(s : SortexchangestrandCluster, f : Double) -> SortexchangestrandCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_cluster_add(a : SortexchangestrandCluster, b : SortexchangestrandCluster) -> SortexchangestrandCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_strand_cluster_copy(s : SortexchangestrandCluster) -> SortexchangestrandCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_cluster_fill(s : SortexchangestrandCluster, v : Double) -> SortexchangestrandCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_cluster_min(s : SortexchangestrandCluster) -> Double { @_common.min(s.data) }

pub fn sort_exchange_strand_cluster_max(s : SortexchangestrandCluster) -> Double { @_common.max(s.data) }

pub fn sort_exchange_strand_cluster_to_string(s : SortexchangestrandCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_model_make(size : Int) -> SortexchangestrandModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_model_len(s : SortexchangestrandModel) -> Int { s.size }

pub fn sort_exchange_strand_model_get(s : SortexchangestrandModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_model_set(s : SortexchangestrandModel, i : Int, v : Double) -> SortexchangestrandModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_model_sum(s : SortexchangestrandModel) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_strand_model_mean(s : SortexchangestrandModel) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_strand_model_scale(s : SortexchangestrandModel, f : Double) -> SortexchangestrandModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_model_add(a : SortexchangestrandModel, b : SortexchangestrandModel) -> SortexchangestrandModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_strand_model_copy(s : SortexchangestrandModel) -> SortexchangestrandModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_model_fill(s : SortexchangestrandModel, v : Double) -> SortexchangestrandModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_model_min(s : SortexchangestrandModel) -> Double { @_common.min(s.data) }

pub fn sort_exchange_strand_model_max(s : SortexchangestrandModel) -> Double { @_common.max(s.data) }

pub fn sort_exchange_strand_model_to_string(s : SortexchangestrandModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_layer_make(size : Int) -> SortexchangestrandLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_layer_len(s : SortexchangestrandLayer) -> Int { s.size }

pub fn sort_exchange_strand_layer_get(s : SortexchangestrandLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_layer_set(s : SortexchangestrandLayer, i : Int, v : Double) -> SortexchangestrandLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_layer_sum(s : SortexchangestrandLayer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_strand_layer_mean(s : SortexchangestrandLayer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_strand_layer_scale(s : SortexchangestrandLayer, f : Double) -> SortexchangestrandLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_layer_add(a : SortexchangestrandLayer, b : SortexchangestrandLayer) -> SortexchangestrandLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_strand_layer_copy(s : SortexchangestrandLayer) -> SortexchangestrandLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_layer_fill(s : SortexchangestrandLayer, v : Double) -> SortexchangestrandLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_layer_min(s : SortexchangestrandLayer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_strand_layer_max(s : SortexchangestrandLayer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_strand_layer_to_string(s : SortexchangestrandLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_buffer_make(size : Int) -> SortexchangestrandBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_buffer_len(s : SortexchangestrandBuffer) -> Int { s.size }

pub fn sort_exchange_strand_buffer_get(s : SortexchangestrandBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_buffer_set(s : SortexchangestrandBuffer, i : Int, v : Double) -> SortexchangestrandBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_buffer_sum(s : SortexchangestrandBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_strand_buffer_mean(s : SortexchangestrandBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_strand_buffer_scale(s : SortexchangestrandBuffer, f : Double) -> SortexchangestrandBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_buffer_add(a : SortexchangestrandBuffer, b : SortexchangestrandBuffer) -> SortexchangestrandBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_strand_buffer_copy(s : SortexchangestrandBuffer) -> SortexchangestrandBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_buffer_fill(s : SortexchangestrandBuffer, v : Double) -> SortexchangestrandBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_buffer_min(s : SortexchangestrandBuffer) -> Double { @_common.min(s.data) }

pub fn sort_exchange_strand_buffer_max(s : SortexchangestrandBuffer) -> Double { @_common.max(s.data) }

pub fn sort_exchange_strand_buffer_to_string(s : SortexchangestrandBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_cursor_make(size : Int) -> SortexchangestrandCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_cursor_len(s : SortexchangestrandCursor) -> Int { s.size }

pub fn sort_exchange_strand_cursor_get(s : SortexchangestrandCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_cursor_set(s : SortexchangestrandCursor, i : Int, v : Double) -> SortexchangestrandCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_cursor_sum(s : SortexchangestrandCursor) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_strand_cursor_mean(s : SortexchangestrandCursor) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_strand_cursor_scale(s : SortexchangestrandCursor, f : Double) -> SortexchangestrandCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_cursor_add(a : SortexchangestrandCursor, b : SortexchangestrandCursor) -> SortexchangestrandCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_strand_cursor_copy(s : SortexchangestrandCursor) -> SortexchangestrandCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_cursor_fill(s : SortexchangestrandCursor, v : Double) -> SortexchangestrandCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_cursor_min(s : SortexchangestrandCursor) -> Double { @_common.min(s.data) }

pub fn sort_exchange_strand_cursor_max(s : SortexchangestrandCursor) -> Double { @_common.max(s.data) }

pub fn sort_exchange_strand_cursor_to_string(s : SortexchangestrandCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_view_make(size : Int) -> SortexchangestrandView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_view_len(s : SortexchangestrandView) -> Int { s.size }

pub fn sort_exchange_strand_view_get(s : SortexchangestrandView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_view_set(s : SortexchangestrandView, i : Int, v : Double) -> SortexchangestrandView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_view_sum(s : SortexchangestrandView) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_strand_view_mean(s : SortexchangestrandView) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_strand_view_scale(s : SortexchangestrandView, f : Double) -> SortexchangestrandView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_view_add(a : SortexchangestrandView, b : SortexchangestrandView) -> SortexchangestrandView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_strand_view_copy(s : SortexchangestrandView) -> SortexchangestrandView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_view_fill(s : SortexchangestrandView, v : Double) -> SortexchangestrandView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_view_min(s : SortexchangestrandView) -> Double { @_common.min(s.data) }

pub fn sort_exchange_strand_view_max(s : SortexchangestrandView) -> Double { @_common.max(s.data) }

pub fn sort_exchange_strand_view_to_string(s : SortexchangestrandView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_range_make(size : Int) -> SortexchangestrandRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_range_len(s : SortexchangestrandRange) -> Int { s.size }

pub fn sort_exchange_strand_range_get(s : SortexchangestrandRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_range_set(s : SortexchangestrandRange, i : Int, v : Double) -> SortexchangestrandRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_range_sum(s : SortexchangestrandRange) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_strand_range_mean(s : SortexchangestrandRange) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_strand_range_scale(s : SortexchangestrandRange, f : Double) -> SortexchangestrandRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_range_add(a : SortexchangestrandRange, b : SortexchangestrandRange) -> SortexchangestrandRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_strand_range_copy(s : SortexchangestrandRange) -> SortexchangestrandRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_range_fill(s : SortexchangestrandRange, v : Double) -> SortexchangestrandRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_range_min(s : SortexchangestrandRange) -> Double { @_common.min(s.data) }

pub fn sort_exchange_strand_range_max(s : SortexchangestrandRange) -> Double { @_common.max(s.data) }

pub fn sort_exchange_strand_range_to_string(s : SortexchangestrandRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortexchangestrandSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_exchange_strand_slice_make(size : Int) -> SortexchangestrandSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_exchange_strand_slice_len(s : SortexchangestrandSlice) -> Int { s.size }

pub fn sort_exchange_strand_slice_get(s : SortexchangestrandSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_exchange_strand_slice_set(s : SortexchangestrandSlice, i : Int, v : Double) -> SortexchangestrandSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_slice_sum(s : SortexchangestrandSlice) -> Double { @_common.sum(s.data) }

pub fn sort_exchange_strand_slice_mean(s : SortexchangestrandSlice) -> Double { @_common.mean(s.data) }

pub fn sort_exchange_strand_slice_scale(s : SortexchangestrandSlice, f : Double) -> SortexchangestrandSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_slice_add(a : SortexchangestrandSlice, b : SortexchangestrandSlice) -> SortexchangestrandSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_exchange_strand_slice_copy(s : SortexchangestrandSlice) -> SortexchangestrandSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_slice_fill(s : SortexchangestrandSlice, v : Double) -> SortexchangestrandSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_exchange_strand_slice_min(s : SortexchangestrandSlice) -> Double { @_common.min(s.data) }

pub fn sort_exchange_strand_slice_max(s : SortexchangestrandSlice) -> Double { @_common.max(s.data) }

pub fn sort_exchange_strand_slice_to_string(s : SortexchangestrandSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

