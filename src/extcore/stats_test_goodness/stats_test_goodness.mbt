///===
/// extcore/stats_test_goodness

pub(all) struct StatstestgoodnessPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn stats_test_goodness_make_point(x : Double, y : Double) -> StatstestgoodnessPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn stats_test_goodness_make_point3(x : Double, y : Double, z : Double) -> StatstestgoodnessPoint {
  { x, y, z, label: 0 }
}

pub fn StatstestgoodnessPoint::x(self : StatstestgoodnessPoint) -> Double { self.x }

pub fn StatstestgoodnessPoint::y(self : StatstestgoodnessPoint) -> Double { self.y }

pub fn StatstestgoodnessPoint::z(self : StatstestgoodnessPoint) -> Double { self.z }

pub fn StatstestgoodnessPoint::label(self : StatstestgoodnessPoint) -> Int { self.label }

pub fn StatstestgoodnessPoint::dist(self : StatstestgoodnessPoint, other : StatstestgoodnessPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn StatstestgoodnessPoint::add(self : StatstestgoodnessPoint, other : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn StatstestgoodnessPoint::sub(self : StatstestgoodnessPoint, other : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn StatstestgoodnessPoint::scale(self : StatstestgoodnessPoint, s : Double) -> StatstestgoodnessPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn StatstestgoodnessPoint::dot(self : StatstestgoodnessPoint, other : StatstestgoodnessPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn StatstestgoodnessPoint::cross(self : StatstestgoodnessPoint, other : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn StatstestgoodnessPoint::norm(self : StatstestgoodnessPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn StatstestgoodnessPoint::normalize(self : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestgoodnessPoint::negate(self : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn StatstestgoodnessPoint::mid(self : StatstestgoodnessPoint, other : StatstestgoodnessPoint) -> StatstestgoodnessPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn StatstestgoodnessPoint::lerp(self : StatstestgoodnessPoint, other : StatstestgoodnessPoint, t : Double) -> StatstestgoodnessPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn StatstestgoodnessPoint::to_string(self : StatstestgoodnessPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct StatstestgoodnessSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn stats_test_goodness_make_series(vals : Array[Double], name : String) -> StatstestgoodnessSeries {
  { vals, name, meta: 0 }
}

pub fn StatstestgoodnessSeries::len(self : StatstestgoodnessSeries) -> Int { self.vals.length() }

pub fn StatstestgoodnessSeries::sum(self : StatstestgoodnessSeries) -> Double { @_common.sum(self.vals) }

pub fn StatstestgoodnessSeries::mean(self : StatstestgoodnessSeries) -> Double { @_common.mean(self.vals) }

pub fn StatstestgoodnessSeries::min(self : StatstestgoodnessSeries) -> Double { @_common.min(self.vals) }

pub fn StatstestgoodnessSeries::max(self : StatstestgoodnessSeries) -> Double { @_common.max(self.vals) }

pub fn StatstestgoodnessSeries::range(self : StatstestgoodnessSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn StatstestgoodnessSeries::variance(self : StatstestgoodnessSeries) -> Double { @_common.variance(self.vals) }

pub fn StatstestgoodnessSeries::std(self : StatstestgoodnessSeries) -> Double { @_common.std(self.vals) }

pub fn StatstestgoodnessSeries::median(self : StatstestgoodnessSeries) -> Double { @_common.median(self.vals) }

pub fn StatstestgoodnessSeries::scale(self : StatstestgoodnessSeries, f : Double) -> StatstestgoodnessSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn StatstestgoodnessSeries::add(self : StatstestgoodnessSeries, other : StatstestgoodnessSeries) -> StatstestgoodnessSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn StatstestgoodnessSeries::sub(self : StatstestgoodnessSeries, other : StatstestgoodnessSeries) -> StatstestgoodnessSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn StatstestgoodnessSeries::normalize(self : StatstestgoodnessSeries) -> StatstestgoodnessSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn StatstestgoodnessSeries::cumsum(self : StatstestgoodnessSeries) -> StatstestgoodnessSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn StatstestgoodnessSeries::to_string(self : StatstestgoodnessSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct StatstestgoodnessMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn stats_test_goodness_make_matrix(rows : Int, cols : Int, val : Double) -> StatstestgoodnessMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn stats_test_goodness_matrix_identity(n : Int) -> StatstestgoodnessMatrix {
  let m = stats_test_goodness_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn StatstestgoodnessMatrix::get(self : StatstestgoodnessMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn StatstestgoodnessMatrix::transpose(self : StatstestgoodnessMatrix) -> StatstestgoodnessMatrix {
  let result = stats_test_goodness_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn StatstestgoodnessMatrix::add(self : StatstestgoodnessMatrix, other : StatstestgoodnessMatrix) -> StatstestgoodnessMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = stats_test_goodness_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn StatstestgoodnessMatrix::scale(self : StatstestgoodnessMatrix, s : Double) -> StatstestgoodnessMatrix {
  let result = stats_test_goodness_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn StatstestgoodnessMatrix::multiply(self : StatstestgoodnessMatrix, other : StatstestgoodnessMatrix) -> StatstestgoodnessMatrix {
  if self.cols != other.rows { return stats_test_goodness_make_matrix(self.rows, other.cols, 0.0) }
  let result = stats_test_goodness_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn StatstestgoodnessMatrix::trace(self : StatstestgoodnessMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn StatstestgoodnessMatrix::det(self : StatstestgoodnessMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn StatstestgoodnessMatrix::norm(self : StatstestgoodnessMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn StatstestgoodnessMatrix::to_string(self : StatstestgoodnessMatrix) -> String {
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

pub(all) struct StatstestgoodnessVector {
  comps : Array[Double]
  dim : Int
}

pub fn stats_test_goodness_make_vector(comps : Array[Double]) -> StatstestgoodnessVector {
  { comps, dim: comps.length() }
}

pub fn stats_test_goodness_vector_zero(dim : Int) -> StatstestgoodnessVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn StatstestgoodnessVector::add(self : StatstestgoodnessVector, other : StatstestgoodnessVector) -> StatstestgoodnessVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestgoodnessVector::sub(self : StatstestgoodnessVector, other : StatstestgoodnessVector) -> StatstestgoodnessVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn StatstestgoodnessVector::scale(self : StatstestgoodnessVector, s : Double) -> StatstestgoodnessVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn StatstestgoodnessVector::dot(self : StatstestgoodnessVector, other : StatstestgoodnessVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn StatstestgoodnessVector::norm(self : StatstestgoodnessVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn StatstestgoodnessVector::normalize(self : StatstestgoodnessVector) -> StatstestgoodnessVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn StatstestgoodnessVector::dist(self : StatstestgoodnessVector, other : StatstestgoodnessVector) -> Double {
  self.sub(other).norm()
}

pub fn StatstestgoodnessVector::to_string(self : StatstestgoodnessVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn stats_test_goodness_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn stats_test_goodness_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn stats_test_goodness_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn stats_test_goodness_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn stats_test_goodness_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn stats_test_goodness_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn stats_test_goodness_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn stats_test_goodness_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn stats_test_goodness_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn stats_test_goodness_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn stats_test_goodness_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn stats_test_goodness_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn stats_test_goodness_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn stats_test_goodness_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn stats_test_goodness_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn stats_test_goodness_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn stats_test_goodness_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn stats_test_goodness_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn stats_test_goodness_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn stats_test_goodness_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn stats_test_goodness_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn stats_test_goodness_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn stats_test_goodness_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn stats_test_goodness_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn stats_test_goodness_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn stats_test_goodness_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn stats_test_goodness_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn stats_test_goodness_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn stats_test_goodness_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct StatstestgoodnessFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_frame_make(size : Int) -> StatstestgoodnessFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_frame_len(s : StatstestgoodnessFrame) -> Int { s.size }

pub fn stats_test_goodness_frame_get(s : StatstestgoodnessFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_frame_set(s : StatstestgoodnessFrame, i : Int, v : Double) -> StatstestgoodnessFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_frame_sum(s : StatstestgoodnessFrame) -> Double { @_common.sum(s.data) }

pub fn stats_test_goodness_frame_mean(s : StatstestgoodnessFrame) -> Double { @_common.mean(s.data) }

pub fn stats_test_goodness_frame_scale(s : StatstestgoodnessFrame, f : Double) -> StatstestgoodnessFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_frame_add(a : StatstestgoodnessFrame, b : StatstestgoodnessFrame) -> StatstestgoodnessFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_goodness_frame_copy(s : StatstestgoodnessFrame) -> StatstestgoodnessFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_frame_fill(s : StatstestgoodnessFrame, v : Double) -> StatstestgoodnessFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_frame_min(s : StatstestgoodnessFrame) -> Double { @_common.min(s.data) }

pub fn stats_test_goodness_frame_max(s : StatstestgoodnessFrame) -> Double { @_common.max(s.data) }

pub fn stats_test_goodness_frame_to_string(s : StatstestgoodnessFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_table_make(size : Int) -> StatstestgoodnessTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_table_len(s : StatstestgoodnessTable) -> Int { s.size }

pub fn stats_test_goodness_table_get(s : StatstestgoodnessTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_table_set(s : StatstestgoodnessTable, i : Int, v : Double) -> StatstestgoodnessTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_table_sum(s : StatstestgoodnessTable) -> Double { @_common.sum(s.data) }

pub fn stats_test_goodness_table_mean(s : StatstestgoodnessTable) -> Double { @_common.mean(s.data) }

pub fn stats_test_goodness_table_scale(s : StatstestgoodnessTable, f : Double) -> StatstestgoodnessTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_table_add(a : StatstestgoodnessTable, b : StatstestgoodnessTable) -> StatstestgoodnessTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_goodness_table_copy(s : StatstestgoodnessTable) -> StatstestgoodnessTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_table_fill(s : StatstestgoodnessTable, v : Double) -> StatstestgoodnessTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_table_min(s : StatstestgoodnessTable) -> Double { @_common.min(s.data) }

pub fn stats_test_goodness_table_max(s : StatstestgoodnessTable) -> Double { @_common.max(s.data) }

pub fn stats_test_goodness_table_to_string(s : StatstestgoodnessTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_graphn_make(size : Int) -> StatstestgoodnessGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_graphn_len(s : StatstestgoodnessGraphN) -> Int { s.size }

pub fn stats_test_goodness_graphn_get(s : StatstestgoodnessGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_graphn_set(s : StatstestgoodnessGraphN, i : Int, v : Double) -> StatstestgoodnessGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_graphn_sum(s : StatstestgoodnessGraphN) -> Double { @_common.sum(s.data) }

pub fn stats_test_goodness_graphn_mean(s : StatstestgoodnessGraphN) -> Double { @_common.mean(s.data) }

pub fn stats_test_goodness_graphn_scale(s : StatstestgoodnessGraphN, f : Double) -> StatstestgoodnessGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_graphn_add(a : StatstestgoodnessGraphN, b : StatstestgoodnessGraphN) -> StatstestgoodnessGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_goodness_graphn_copy(s : StatstestgoodnessGraphN) -> StatstestgoodnessGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_graphn_fill(s : StatstestgoodnessGraphN, v : Double) -> StatstestgoodnessGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_graphn_min(s : StatstestgoodnessGraphN) -> Double { @_common.min(s.data) }

pub fn stats_test_goodness_graphn_max(s : StatstestgoodnessGraphN) -> Double { @_common.max(s.data) }

pub fn stats_test_goodness_graphn_to_string(s : StatstestgoodnessGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_node_make(size : Int) -> StatstestgoodnessNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_node_len(s : StatstestgoodnessNode) -> Int { s.size }

pub fn stats_test_goodness_node_get(s : StatstestgoodnessNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_node_set(s : StatstestgoodnessNode, i : Int, v : Double) -> StatstestgoodnessNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_node_sum(s : StatstestgoodnessNode) -> Double { @_common.sum(s.data) }

pub fn stats_test_goodness_node_mean(s : StatstestgoodnessNode) -> Double { @_common.mean(s.data) }

pub fn stats_test_goodness_node_scale(s : StatstestgoodnessNode, f : Double) -> StatstestgoodnessNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_node_add(a : StatstestgoodnessNode, b : StatstestgoodnessNode) -> StatstestgoodnessNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_goodness_node_copy(s : StatstestgoodnessNode) -> StatstestgoodnessNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_node_fill(s : StatstestgoodnessNode, v : Double) -> StatstestgoodnessNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_node_min(s : StatstestgoodnessNode) -> Double { @_common.min(s.data) }

pub fn stats_test_goodness_node_max(s : StatstestgoodnessNode) -> Double { @_common.max(s.data) }

pub fn stats_test_goodness_node_to_string(s : StatstestgoodnessNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_edge_make(size : Int) -> StatstestgoodnessEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_edge_len(s : StatstestgoodnessEdge) -> Int { s.size }

pub fn stats_test_goodness_edge_get(s : StatstestgoodnessEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_edge_set(s : StatstestgoodnessEdge, i : Int, v : Double) -> StatstestgoodnessEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_edge_sum(s : StatstestgoodnessEdge) -> Double { @_common.sum(s.data) }

pub fn stats_test_goodness_edge_mean(s : StatstestgoodnessEdge) -> Double { @_common.mean(s.data) }

pub fn stats_test_goodness_edge_scale(s : StatstestgoodnessEdge, f : Double) -> StatstestgoodnessEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_edge_add(a : StatstestgoodnessEdge, b : StatstestgoodnessEdge) -> StatstestgoodnessEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_goodness_edge_copy(s : StatstestgoodnessEdge) -> StatstestgoodnessEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_edge_fill(s : StatstestgoodnessEdge, v : Double) -> StatstestgoodnessEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_edge_min(s : StatstestgoodnessEdge) -> Double { @_common.min(s.data) }

pub fn stats_test_goodness_edge_max(s : StatstestgoodnessEdge) -> Double { @_common.max(s.data) }

pub fn stats_test_goodness_edge_to_string(s : StatstestgoodnessEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_path_make(size : Int) -> StatstestgoodnessPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_path_len(s : StatstestgoodnessPath) -> Int { s.size }

pub fn stats_test_goodness_path_get(s : StatstestgoodnessPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_path_set(s : StatstestgoodnessPath, i : Int, v : Double) -> StatstestgoodnessPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_path_sum(s : StatstestgoodnessPath) -> Double { @_common.sum(s.data) }

pub fn stats_test_goodness_path_mean(s : StatstestgoodnessPath) -> Double { @_common.mean(s.data) }

pub fn stats_test_goodness_path_scale(s : StatstestgoodnessPath, f : Double) -> StatstestgoodnessPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_path_add(a : StatstestgoodnessPath, b : StatstestgoodnessPath) -> StatstestgoodnessPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_goodness_path_copy(s : StatstestgoodnessPath) -> StatstestgoodnessPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_path_fill(s : StatstestgoodnessPath, v : Double) -> StatstestgoodnessPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_path_min(s : StatstestgoodnessPath) -> Double { @_common.min(s.data) }

pub fn stats_test_goodness_path_max(s : StatstestgoodnessPath) -> Double { @_common.max(s.data) }

pub fn stats_test_goodness_path_to_string(s : StatstestgoodnessPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_cluster_make(size : Int) -> StatstestgoodnessCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_cluster_len(s : StatstestgoodnessCluster) -> Int { s.size }

pub fn stats_test_goodness_cluster_get(s : StatstestgoodnessCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_cluster_set(s : StatstestgoodnessCluster, i : Int, v : Double) -> StatstestgoodnessCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_cluster_sum(s : StatstestgoodnessCluster) -> Double { @_common.sum(s.data) }

pub fn stats_test_goodness_cluster_mean(s : StatstestgoodnessCluster) -> Double { @_common.mean(s.data) }

pub fn stats_test_goodness_cluster_scale(s : StatstestgoodnessCluster, f : Double) -> StatstestgoodnessCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_cluster_add(a : StatstestgoodnessCluster, b : StatstestgoodnessCluster) -> StatstestgoodnessCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_goodness_cluster_copy(s : StatstestgoodnessCluster) -> StatstestgoodnessCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_cluster_fill(s : StatstestgoodnessCluster, v : Double) -> StatstestgoodnessCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_cluster_min(s : StatstestgoodnessCluster) -> Double { @_common.min(s.data) }

pub fn stats_test_goodness_cluster_max(s : StatstestgoodnessCluster) -> Double { @_common.max(s.data) }

pub fn stats_test_goodness_cluster_to_string(s : StatstestgoodnessCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_model_make(size : Int) -> StatstestgoodnessModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_model_len(s : StatstestgoodnessModel) -> Int { s.size }

pub fn stats_test_goodness_model_get(s : StatstestgoodnessModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_model_set(s : StatstestgoodnessModel, i : Int, v : Double) -> StatstestgoodnessModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_model_sum(s : StatstestgoodnessModel) -> Double { @_common.sum(s.data) }

pub fn stats_test_goodness_model_mean(s : StatstestgoodnessModel) -> Double { @_common.mean(s.data) }

pub fn stats_test_goodness_model_scale(s : StatstestgoodnessModel, f : Double) -> StatstestgoodnessModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_model_add(a : StatstestgoodnessModel, b : StatstestgoodnessModel) -> StatstestgoodnessModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_goodness_model_copy(s : StatstestgoodnessModel) -> StatstestgoodnessModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_model_fill(s : StatstestgoodnessModel, v : Double) -> StatstestgoodnessModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_model_min(s : StatstestgoodnessModel) -> Double { @_common.min(s.data) }

pub fn stats_test_goodness_model_max(s : StatstestgoodnessModel) -> Double { @_common.max(s.data) }

pub fn stats_test_goodness_model_to_string(s : StatstestgoodnessModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_layer_make(size : Int) -> StatstestgoodnessLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_layer_len(s : StatstestgoodnessLayer) -> Int { s.size }

pub fn stats_test_goodness_layer_get(s : StatstestgoodnessLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_layer_set(s : StatstestgoodnessLayer, i : Int, v : Double) -> StatstestgoodnessLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_layer_sum(s : StatstestgoodnessLayer) -> Double { @_common.sum(s.data) }

pub fn stats_test_goodness_layer_mean(s : StatstestgoodnessLayer) -> Double { @_common.mean(s.data) }

pub fn stats_test_goodness_layer_scale(s : StatstestgoodnessLayer, f : Double) -> StatstestgoodnessLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_layer_add(a : StatstestgoodnessLayer, b : StatstestgoodnessLayer) -> StatstestgoodnessLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_goodness_layer_copy(s : StatstestgoodnessLayer) -> StatstestgoodnessLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_layer_fill(s : StatstestgoodnessLayer, v : Double) -> StatstestgoodnessLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_layer_min(s : StatstestgoodnessLayer) -> Double { @_common.min(s.data) }

pub fn stats_test_goodness_layer_max(s : StatstestgoodnessLayer) -> Double { @_common.max(s.data) }

pub fn stats_test_goodness_layer_to_string(s : StatstestgoodnessLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_buffer_make(size : Int) -> StatstestgoodnessBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_buffer_len(s : StatstestgoodnessBuffer) -> Int { s.size }

pub fn stats_test_goodness_buffer_get(s : StatstestgoodnessBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_buffer_set(s : StatstestgoodnessBuffer, i : Int, v : Double) -> StatstestgoodnessBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_buffer_sum(s : StatstestgoodnessBuffer) -> Double { @_common.sum(s.data) }

pub fn stats_test_goodness_buffer_mean(s : StatstestgoodnessBuffer) -> Double { @_common.mean(s.data) }

pub fn stats_test_goodness_buffer_scale(s : StatstestgoodnessBuffer, f : Double) -> StatstestgoodnessBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_buffer_add(a : StatstestgoodnessBuffer, b : StatstestgoodnessBuffer) -> StatstestgoodnessBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_goodness_buffer_copy(s : StatstestgoodnessBuffer) -> StatstestgoodnessBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_buffer_fill(s : StatstestgoodnessBuffer, v : Double) -> StatstestgoodnessBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_buffer_min(s : StatstestgoodnessBuffer) -> Double { @_common.min(s.data) }

pub fn stats_test_goodness_buffer_max(s : StatstestgoodnessBuffer) -> Double { @_common.max(s.data) }

pub fn stats_test_goodness_buffer_to_string(s : StatstestgoodnessBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_cursor_make(size : Int) -> StatstestgoodnessCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_cursor_len(s : StatstestgoodnessCursor) -> Int { s.size }

pub fn stats_test_goodness_cursor_get(s : StatstestgoodnessCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_cursor_set(s : StatstestgoodnessCursor, i : Int, v : Double) -> StatstestgoodnessCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_cursor_sum(s : StatstestgoodnessCursor) -> Double { @_common.sum(s.data) }

pub fn stats_test_goodness_cursor_mean(s : StatstestgoodnessCursor) -> Double { @_common.mean(s.data) }

pub fn stats_test_goodness_cursor_scale(s : StatstestgoodnessCursor, f : Double) -> StatstestgoodnessCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_cursor_add(a : StatstestgoodnessCursor, b : StatstestgoodnessCursor) -> StatstestgoodnessCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_goodness_cursor_copy(s : StatstestgoodnessCursor) -> StatstestgoodnessCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_cursor_fill(s : StatstestgoodnessCursor, v : Double) -> StatstestgoodnessCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_cursor_min(s : StatstestgoodnessCursor) -> Double { @_common.min(s.data) }

pub fn stats_test_goodness_cursor_max(s : StatstestgoodnessCursor) -> Double { @_common.max(s.data) }

pub fn stats_test_goodness_cursor_to_string(s : StatstestgoodnessCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_view_make(size : Int) -> StatstestgoodnessView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_view_len(s : StatstestgoodnessView) -> Int { s.size }

pub fn stats_test_goodness_view_get(s : StatstestgoodnessView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_view_set(s : StatstestgoodnessView, i : Int, v : Double) -> StatstestgoodnessView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_view_sum(s : StatstestgoodnessView) -> Double { @_common.sum(s.data) }

pub fn stats_test_goodness_view_mean(s : StatstestgoodnessView) -> Double { @_common.mean(s.data) }

pub fn stats_test_goodness_view_scale(s : StatstestgoodnessView, f : Double) -> StatstestgoodnessView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_view_add(a : StatstestgoodnessView, b : StatstestgoodnessView) -> StatstestgoodnessView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_goodness_view_copy(s : StatstestgoodnessView) -> StatstestgoodnessView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_view_fill(s : StatstestgoodnessView, v : Double) -> StatstestgoodnessView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_view_min(s : StatstestgoodnessView) -> Double { @_common.min(s.data) }

pub fn stats_test_goodness_view_max(s : StatstestgoodnessView) -> Double { @_common.max(s.data) }

pub fn stats_test_goodness_view_to_string(s : StatstestgoodnessView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_range_make(size : Int) -> StatstestgoodnessRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_range_len(s : StatstestgoodnessRange) -> Int { s.size }

pub fn stats_test_goodness_range_get(s : StatstestgoodnessRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_range_set(s : StatstestgoodnessRange, i : Int, v : Double) -> StatstestgoodnessRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_range_sum(s : StatstestgoodnessRange) -> Double { @_common.sum(s.data) }

pub fn stats_test_goodness_range_mean(s : StatstestgoodnessRange) -> Double { @_common.mean(s.data) }

pub fn stats_test_goodness_range_scale(s : StatstestgoodnessRange, f : Double) -> StatstestgoodnessRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_range_add(a : StatstestgoodnessRange, b : StatstestgoodnessRange) -> StatstestgoodnessRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_goodness_range_copy(s : StatstestgoodnessRange) -> StatstestgoodnessRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_range_fill(s : StatstestgoodnessRange, v : Double) -> StatstestgoodnessRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_range_min(s : StatstestgoodnessRange) -> Double { @_common.min(s.data) }

pub fn stats_test_goodness_range_max(s : StatstestgoodnessRange) -> Double { @_common.max(s.data) }

pub fn stats_test_goodness_range_to_string(s : StatstestgoodnessRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct StatstestgoodnessSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn stats_test_goodness_slice_make(size : Int) -> StatstestgoodnessSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn stats_test_goodness_slice_len(s : StatstestgoodnessSlice) -> Int { s.size }

pub fn stats_test_goodness_slice_get(s : StatstestgoodnessSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn stats_test_goodness_slice_set(s : StatstestgoodnessSlice, i : Int, v : Double) -> StatstestgoodnessSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_slice_sum(s : StatstestgoodnessSlice) -> Double { @_common.sum(s.data) }

pub fn stats_test_goodness_slice_mean(s : StatstestgoodnessSlice) -> Double { @_common.mean(s.data) }

pub fn stats_test_goodness_slice_scale(s : StatstestgoodnessSlice, f : Double) -> StatstestgoodnessSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_slice_add(a : StatstestgoodnessSlice, b : StatstestgoodnessSlice) -> StatstestgoodnessSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn stats_test_goodness_slice_copy(s : StatstestgoodnessSlice) -> StatstestgoodnessSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_slice_fill(s : StatstestgoodnessSlice, v : Double) -> StatstestgoodnessSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn stats_test_goodness_slice_min(s : StatstestgoodnessSlice) -> Double { @_common.min(s.data) }

pub fn stats_test_goodness_slice_max(s : StatstestgoodnessSlice) -> Double { @_common.max(s.data) }

pub fn stats_test_goodness_slice_to_string(s : StatstestgoodnessSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

