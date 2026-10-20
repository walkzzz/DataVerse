///===
/// extcore/sort_compare_patience

pub(all) struct SortcomparepatiencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_patience_make_point(x : Double, y : Double) -> SortcomparepatiencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_patience_make_point3(x : Double, y : Double, z : Double) -> SortcomparepatiencePoint {
  { x, y, z, label: 0 }
}

pub fn SortcomparepatiencePoint::x(self : SortcomparepatiencePoint) -> Double { self.x }

pub fn SortcomparepatiencePoint::y(self : SortcomparepatiencePoint) -> Double { self.y }

pub fn SortcomparepatiencePoint::z(self : SortcomparepatiencePoint) -> Double { self.z }

pub fn SortcomparepatiencePoint::label(self : SortcomparepatiencePoint) -> Int { self.label }

pub fn SortcomparepatiencePoint::dist(self : SortcomparepatiencePoint, other : SortcomparepatiencePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcomparepatiencePoint::add(self : SortcomparepatiencePoint, other : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcomparepatiencePoint::sub(self : SortcomparepatiencePoint, other : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcomparepatiencePoint::scale(self : SortcomparepatiencePoint, s : Double) -> SortcomparepatiencePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcomparepatiencePoint::dot(self : SortcomparepatiencePoint, other : SortcomparepatiencePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcomparepatiencePoint::cross(self : SortcomparepatiencePoint, other : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcomparepatiencePoint::norm(self : SortcomparepatiencePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcomparepatiencePoint::normalize(self : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparepatiencePoint::negate(self : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcomparepatiencePoint::mid(self : SortcomparepatiencePoint, other : SortcomparepatiencePoint) -> SortcomparepatiencePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcomparepatiencePoint::lerp(self : SortcomparepatiencePoint, other : SortcomparepatiencePoint, t : Double) -> SortcomparepatiencePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcomparepatiencePoint::to_string(self : SortcomparepatiencePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcomparepatienceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_patience_make_series(vals : Array[Double], name : String) -> SortcomparepatienceSeries {
  { vals, name, meta: 0 }
}

pub fn SortcomparepatienceSeries::len(self : SortcomparepatienceSeries) -> Int { self.vals.length() }

pub fn SortcomparepatienceSeries::sum(self : SortcomparepatienceSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcomparepatienceSeries::mean(self : SortcomparepatienceSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcomparepatienceSeries::min(self : SortcomparepatienceSeries) -> Double { @_common.min(self.vals) }

pub fn SortcomparepatienceSeries::max(self : SortcomparepatienceSeries) -> Double { @_common.max(self.vals) }

pub fn SortcomparepatienceSeries::range(self : SortcomparepatienceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcomparepatienceSeries::variance(self : SortcomparepatienceSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcomparepatienceSeries::std(self : SortcomparepatienceSeries) -> Double { @_common.std(self.vals) }

pub fn SortcomparepatienceSeries::median(self : SortcomparepatienceSeries) -> Double { @_common.median(self.vals) }

pub fn SortcomparepatienceSeries::scale(self : SortcomparepatienceSeries, f : Double) -> SortcomparepatienceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcomparepatienceSeries::add(self : SortcomparepatienceSeries, other : SortcomparepatienceSeries) -> SortcomparepatienceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcomparepatienceSeries::sub(self : SortcomparepatienceSeries, other : SortcomparepatienceSeries) -> SortcomparepatienceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcomparepatienceSeries::normalize(self : SortcomparepatienceSeries) -> SortcomparepatienceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcomparepatienceSeries::cumsum(self : SortcomparepatienceSeries) -> SortcomparepatienceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcomparepatienceSeries::to_string(self : SortcomparepatienceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparepatienceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_patience_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparepatienceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_patience_matrix_identity(n : Int) -> SortcomparepatienceMatrix {
  let m = sort_compare_patience_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcomparepatienceMatrix::get(self : SortcomparepatienceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcomparepatienceMatrix::transpose(self : SortcomparepatienceMatrix) -> SortcomparepatienceMatrix {
  let result = sort_compare_patience_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcomparepatienceMatrix::add(self : SortcomparepatienceMatrix, other : SortcomparepatienceMatrix) -> SortcomparepatienceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_patience_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcomparepatienceMatrix::scale(self : SortcomparepatienceMatrix, s : Double) -> SortcomparepatienceMatrix {
  let result = sort_compare_patience_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcomparepatienceMatrix::multiply(self : SortcomparepatienceMatrix, other : SortcomparepatienceMatrix) -> SortcomparepatienceMatrix {
  if self.cols != other.rows { return sort_compare_patience_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_patience_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcomparepatienceMatrix::trace(self : SortcomparepatienceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcomparepatienceMatrix::det(self : SortcomparepatienceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcomparepatienceMatrix::norm(self : SortcomparepatienceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcomparepatienceMatrix::to_string(self : SortcomparepatienceMatrix) -> String {
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

pub(all) struct SortcomparepatienceVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_patience_make_vector(comps : Array[Double]) -> SortcomparepatienceVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_patience_vector_zero(dim : Int) -> SortcomparepatienceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcomparepatienceVector::add(self : SortcomparepatienceVector, other : SortcomparepatienceVector) -> SortcomparepatienceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparepatienceVector::sub(self : SortcomparepatienceVector, other : SortcomparepatienceVector) -> SortcomparepatienceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparepatienceVector::scale(self : SortcomparepatienceVector, s : Double) -> SortcomparepatienceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcomparepatienceVector::dot(self : SortcomparepatienceVector, other : SortcomparepatienceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcomparepatienceVector::norm(self : SortcomparepatienceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcomparepatienceVector::normalize(self : SortcomparepatienceVector) -> SortcomparepatienceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparepatienceVector::dist(self : SortcomparepatienceVector, other : SortcomparepatienceVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcomparepatienceVector::to_string(self : SortcomparepatienceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_patience_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_patience_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_patience_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_patience_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_patience_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_patience_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_patience_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_patience_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_patience_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_patience_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_patience_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_patience_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_patience_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_patience_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_patience_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_patience_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_patience_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_patience_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_patience_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_patience_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_patience_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_patience_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_patience_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_patience_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_patience_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_patience_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_patience_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_patience_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_patience_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcomparepatienceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_frame_make(size : Int) -> SortcomparepatienceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_frame_len(s : SortcomparepatienceFrame) -> Int { s.size }

pub fn sort_compare_patience_frame_get(s : SortcomparepatienceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_frame_set(s : SortcomparepatienceFrame, i : Int, v : Double) -> SortcomparepatienceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_frame_sum(s : SortcomparepatienceFrame) -> Double { @_common.sum(s.data) }

pub fn sort_compare_patience_frame_mean(s : SortcomparepatienceFrame) -> Double { @_common.mean(s.data) }

pub fn sort_compare_patience_frame_scale(s : SortcomparepatienceFrame, f : Double) -> SortcomparepatienceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_frame_add(a : SortcomparepatienceFrame, b : SortcomparepatienceFrame) -> SortcomparepatienceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_patience_frame_copy(s : SortcomparepatienceFrame) -> SortcomparepatienceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_frame_fill(s : SortcomparepatienceFrame, v : Double) -> SortcomparepatienceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_frame_min(s : SortcomparepatienceFrame) -> Double { @_common.min(s.data) }

pub fn sort_compare_patience_frame_max(s : SortcomparepatienceFrame) -> Double { @_common.max(s.data) }

pub fn sort_compare_patience_frame_to_string(s : SortcomparepatienceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_table_make(size : Int) -> SortcomparepatienceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_table_len(s : SortcomparepatienceTable) -> Int { s.size }

pub fn sort_compare_patience_table_get(s : SortcomparepatienceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_table_set(s : SortcomparepatienceTable, i : Int, v : Double) -> SortcomparepatienceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_table_sum(s : SortcomparepatienceTable) -> Double { @_common.sum(s.data) }

pub fn sort_compare_patience_table_mean(s : SortcomparepatienceTable) -> Double { @_common.mean(s.data) }

pub fn sort_compare_patience_table_scale(s : SortcomparepatienceTable, f : Double) -> SortcomparepatienceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_table_add(a : SortcomparepatienceTable, b : SortcomparepatienceTable) -> SortcomparepatienceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_patience_table_copy(s : SortcomparepatienceTable) -> SortcomparepatienceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_table_fill(s : SortcomparepatienceTable, v : Double) -> SortcomparepatienceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_table_min(s : SortcomparepatienceTable) -> Double { @_common.min(s.data) }

pub fn sort_compare_patience_table_max(s : SortcomparepatienceTable) -> Double { @_common.max(s.data) }

pub fn sort_compare_patience_table_to_string(s : SortcomparepatienceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_graphn_make(size : Int) -> SortcomparepatienceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_graphn_len(s : SortcomparepatienceGraphN) -> Int { s.size }

pub fn sort_compare_patience_graphn_get(s : SortcomparepatienceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_graphn_set(s : SortcomparepatienceGraphN, i : Int, v : Double) -> SortcomparepatienceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_graphn_sum(s : SortcomparepatienceGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_compare_patience_graphn_mean(s : SortcomparepatienceGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_compare_patience_graphn_scale(s : SortcomparepatienceGraphN, f : Double) -> SortcomparepatienceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_graphn_add(a : SortcomparepatienceGraphN, b : SortcomparepatienceGraphN) -> SortcomparepatienceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_patience_graphn_copy(s : SortcomparepatienceGraphN) -> SortcomparepatienceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_graphn_fill(s : SortcomparepatienceGraphN, v : Double) -> SortcomparepatienceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_graphn_min(s : SortcomparepatienceGraphN) -> Double { @_common.min(s.data) }

pub fn sort_compare_patience_graphn_max(s : SortcomparepatienceGraphN) -> Double { @_common.max(s.data) }

pub fn sort_compare_patience_graphn_to_string(s : SortcomparepatienceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_node_make(size : Int) -> SortcomparepatienceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_node_len(s : SortcomparepatienceNode) -> Int { s.size }

pub fn sort_compare_patience_node_get(s : SortcomparepatienceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_node_set(s : SortcomparepatienceNode, i : Int, v : Double) -> SortcomparepatienceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_node_sum(s : SortcomparepatienceNode) -> Double { @_common.sum(s.data) }

pub fn sort_compare_patience_node_mean(s : SortcomparepatienceNode) -> Double { @_common.mean(s.data) }

pub fn sort_compare_patience_node_scale(s : SortcomparepatienceNode, f : Double) -> SortcomparepatienceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_node_add(a : SortcomparepatienceNode, b : SortcomparepatienceNode) -> SortcomparepatienceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_patience_node_copy(s : SortcomparepatienceNode) -> SortcomparepatienceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_node_fill(s : SortcomparepatienceNode, v : Double) -> SortcomparepatienceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_node_min(s : SortcomparepatienceNode) -> Double { @_common.min(s.data) }

pub fn sort_compare_patience_node_max(s : SortcomparepatienceNode) -> Double { @_common.max(s.data) }

pub fn sort_compare_patience_node_to_string(s : SortcomparepatienceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_edge_make(size : Int) -> SortcomparepatienceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_edge_len(s : SortcomparepatienceEdge) -> Int { s.size }

pub fn sort_compare_patience_edge_get(s : SortcomparepatienceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_edge_set(s : SortcomparepatienceEdge, i : Int, v : Double) -> SortcomparepatienceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_edge_sum(s : SortcomparepatienceEdge) -> Double { @_common.sum(s.data) }

pub fn sort_compare_patience_edge_mean(s : SortcomparepatienceEdge) -> Double { @_common.mean(s.data) }

pub fn sort_compare_patience_edge_scale(s : SortcomparepatienceEdge, f : Double) -> SortcomparepatienceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_edge_add(a : SortcomparepatienceEdge, b : SortcomparepatienceEdge) -> SortcomparepatienceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_patience_edge_copy(s : SortcomparepatienceEdge) -> SortcomparepatienceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_edge_fill(s : SortcomparepatienceEdge, v : Double) -> SortcomparepatienceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_edge_min(s : SortcomparepatienceEdge) -> Double { @_common.min(s.data) }

pub fn sort_compare_patience_edge_max(s : SortcomparepatienceEdge) -> Double { @_common.max(s.data) }

pub fn sort_compare_patience_edge_to_string(s : SortcomparepatienceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatiencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_path_make(size : Int) -> SortcomparepatiencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_path_len(s : SortcomparepatiencePath) -> Int { s.size }

pub fn sort_compare_patience_path_get(s : SortcomparepatiencePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_path_set(s : SortcomparepatiencePath, i : Int, v : Double) -> SortcomparepatiencePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_path_sum(s : SortcomparepatiencePath) -> Double { @_common.sum(s.data) }

pub fn sort_compare_patience_path_mean(s : SortcomparepatiencePath) -> Double { @_common.mean(s.data) }

pub fn sort_compare_patience_path_scale(s : SortcomparepatiencePath, f : Double) -> SortcomparepatiencePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_path_add(a : SortcomparepatiencePath, b : SortcomparepatiencePath) -> SortcomparepatiencePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_patience_path_copy(s : SortcomparepatiencePath) -> SortcomparepatiencePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_path_fill(s : SortcomparepatiencePath, v : Double) -> SortcomparepatiencePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_path_min(s : SortcomparepatiencePath) -> Double { @_common.min(s.data) }

pub fn sort_compare_patience_path_max(s : SortcomparepatiencePath) -> Double { @_common.max(s.data) }

pub fn sort_compare_patience_path_to_string(s : SortcomparepatiencePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_cluster_make(size : Int) -> SortcomparepatienceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_cluster_len(s : SortcomparepatienceCluster) -> Int { s.size }

pub fn sort_compare_patience_cluster_get(s : SortcomparepatienceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_cluster_set(s : SortcomparepatienceCluster, i : Int, v : Double) -> SortcomparepatienceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_cluster_sum(s : SortcomparepatienceCluster) -> Double { @_common.sum(s.data) }

pub fn sort_compare_patience_cluster_mean(s : SortcomparepatienceCluster) -> Double { @_common.mean(s.data) }

pub fn sort_compare_patience_cluster_scale(s : SortcomparepatienceCluster, f : Double) -> SortcomparepatienceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_cluster_add(a : SortcomparepatienceCluster, b : SortcomparepatienceCluster) -> SortcomparepatienceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_patience_cluster_copy(s : SortcomparepatienceCluster) -> SortcomparepatienceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_cluster_fill(s : SortcomparepatienceCluster, v : Double) -> SortcomparepatienceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_cluster_min(s : SortcomparepatienceCluster) -> Double { @_common.min(s.data) }

pub fn sort_compare_patience_cluster_max(s : SortcomparepatienceCluster) -> Double { @_common.max(s.data) }

pub fn sort_compare_patience_cluster_to_string(s : SortcomparepatienceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_model_make(size : Int) -> SortcomparepatienceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_model_len(s : SortcomparepatienceModel) -> Int { s.size }

pub fn sort_compare_patience_model_get(s : SortcomparepatienceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_model_set(s : SortcomparepatienceModel, i : Int, v : Double) -> SortcomparepatienceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_model_sum(s : SortcomparepatienceModel) -> Double { @_common.sum(s.data) }

pub fn sort_compare_patience_model_mean(s : SortcomparepatienceModel) -> Double { @_common.mean(s.data) }

pub fn sort_compare_patience_model_scale(s : SortcomparepatienceModel, f : Double) -> SortcomparepatienceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_model_add(a : SortcomparepatienceModel, b : SortcomparepatienceModel) -> SortcomparepatienceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_patience_model_copy(s : SortcomparepatienceModel) -> SortcomparepatienceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_model_fill(s : SortcomparepatienceModel, v : Double) -> SortcomparepatienceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_model_min(s : SortcomparepatienceModel) -> Double { @_common.min(s.data) }

pub fn sort_compare_patience_model_max(s : SortcomparepatienceModel) -> Double { @_common.max(s.data) }

pub fn sort_compare_patience_model_to_string(s : SortcomparepatienceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_layer_make(size : Int) -> SortcomparepatienceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_layer_len(s : SortcomparepatienceLayer) -> Int { s.size }

pub fn sort_compare_patience_layer_get(s : SortcomparepatienceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_layer_set(s : SortcomparepatienceLayer, i : Int, v : Double) -> SortcomparepatienceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_layer_sum(s : SortcomparepatienceLayer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_patience_layer_mean(s : SortcomparepatienceLayer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_patience_layer_scale(s : SortcomparepatienceLayer, f : Double) -> SortcomparepatienceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_layer_add(a : SortcomparepatienceLayer, b : SortcomparepatienceLayer) -> SortcomparepatienceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_patience_layer_copy(s : SortcomparepatienceLayer) -> SortcomparepatienceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_layer_fill(s : SortcomparepatienceLayer, v : Double) -> SortcomparepatienceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_layer_min(s : SortcomparepatienceLayer) -> Double { @_common.min(s.data) }

pub fn sort_compare_patience_layer_max(s : SortcomparepatienceLayer) -> Double { @_common.max(s.data) }

pub fn sort_compare_patience_layer_to_string(s : SortcomparepatienceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_buffer_make(size : Int) -> SortcomparepatienceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_buffer_len(s : SortcomparepatienceBuffer) -> Int { s.size }

pub fn sort_compare_patience_buffer_get(s : SortcomparepatienceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_buffer_set(s : SortcomparepatienceBuffer, i : Int, v : Double) -> SortcomparepatienceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_buffer_sum(s : SortcomparepatienceBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_patience_buffer_mean(s : SortcomparepatienceBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_patience_buffer_scale(s : SortcomparepatienceBuffer, f : Double) -> SortcomparepatienceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_buffer_add(a : SortcomparepatienceBuffer, b : SortcomparepatienceBuffer) -> SortcomparepatienceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_patience_buffer_copy(s : SortcomparepatienceBuffer) -> SortcomparepatienceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_buffer_fill(s : SortcomparepatienceBuffer, v : Double) -> SortcomparepatienceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_buffer_min(s : SortcomparepatienceBuffer) -> Double { @_common.min(s.data) }

pub fn sort_compare_patience_buffer_max(s : SortcomparepatienceBuffer) -> Double { @_common.max(s.data) }

pub fn sort_compare_patience_buffer_to_string(s : SortcomparepatienceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_cursor_make(size : Int) -> SortcomparepatienceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_cursor_len(s : SortcomparepatienceCursor) -> Int { s.size }

pub fn sort_compare_patience_cursor_get(s : SortcomparepatienceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_cursor_set(s : SortcomparepatienceCursor, i : Int, v : Double) -> SortcomparepatienceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_cursor_sum(s : SortcomparepatienceCursor) -> Double { @_common.sum(s.data) }

pub fn sort_compare_patience_cursor_mean(s : SortcomparepatienceCursor) -> Double { @_common.mean(s.data) }

pub fn sort_compare_patience_cursor_scale(s : SortcomparepatienceCursor, f : Double) -> SortcomparepatienceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_cursor_add(a : SortcomparepatienceCursor, b : SortcomparepatienceCursor) -> SortcomparepatienceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_patience_cursor_copy(s : SortcomparepatienceCursor) -> SortcomparepatienceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_cursor_fill(s : SortcomparepatienceCursor, v : Double) -> SortcomparepatienceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_cursor_min(s : SortcomparepatienceCursor) -> Double { @_common.min(s.data) }

pub fn sort_compare_patience_cursor_max(s : SortcomparepatienceCursor) -> Double { @_common.max(s.data) }

pub fn sort_compare_patience_cursor_to_string(s : SortcomparepatienceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_view_make(size : Int) -> SortcomparepatienceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_view_len(s : SortcomparepatienceView) -> Int { s.size }

pub fn sort_compare_patience_view_get(s : SortcomparepatienceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_view_set(s : SortcomparepatienceView, i : Int, v : Double) -> SortcomparepatienceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_view_sum(s : SortcomparepatienceView) -> Double { @_common.sum(s.data) }

pub fn sort_compare_patience_view_mean(s : SortcomparepatienceView) -> Double { @_common.mean(s.data) }

pub fn sort_compare_patience_view_scale(s : SortcomparepatienceView, f : Double) -> SortcomparepatienceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_view_add(a : SortcomparepatienceView, b : SortcomparepatienceView) -> SortcomparepatienceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_patience_view_copy(s : SortcomparepatienceView) -> SortcomparepatienceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_view_fill(s : SortcomparepatienceView, v : Double) -> SortcomparepatienceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_view_min(s : SortcomparepatienceView) -> Double { @_common.min(s.data) }

pub fn sort_compare_patience_view_max(s : SortcomparepatienceView) -> Double { @_common.max(s.data) }

pub fn sort_compare_patience_view_to_string(s : SortcomparepatienceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_range_make(size : Int) -> SortcomparepatienceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_range_len(s : SortcomparepatienceRange) -> Int { s.size }

pub fn sort_compare_patience_range_get(s : SortcomparepatienceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_range_set(s : SortcomparepatienceRange, i : Int, v : Double) -> SortcomparepatienceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_range_sum(s : SortcomparepatienceRange) -> Double { @_common.sum(s.data) }

pub fn sort_compare_patience_range_mean(s : SortcomparepatienceRange) -> Double { @_common.mean(s.data) }

pub fn sort_compare_patience_range_scale(s : SortcomparepatienceRange, f : Double) -> SortcomparepatienceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_range_add(a : SortcomparepatienceRange, b : SortcomparepatienceRange) -> SortcomparepatienceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_patience_range_copy(s : SortcomparepatienceRange) -> SortcomparepatienceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_range_fill(s : SortcomparepatienceRange, v : Double) -> SortcomparepatienceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_range_min(s : SortcomparepatienceRange) -> Double { @_common.min(s.data) }

pub fn sort_compare_patience_range_max(s : SortcomparepatienceRange) -> Double { @_common.max(s.data) }

pub fn sort_compare_patience_range_to_string(s : SortcomparepatienceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparepatienceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_patience_slice_make(size : Int) -> SortcomparepatienceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_patience_slice_len(s : SortcomparepatienceSlice) -> Int { s.size }

pub fn sort_compare_patience_slice_get(s : SortcomparepatienceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_patience_slice_set(s : SortcomparepatienceSlice, i : Int, v : Double) -> SortcomparepatienceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_slice_sum(s : SortcomparepatienceSlice) -> Double { @_common.sum(s.data) }

pub fn sort_compare_patience_slice_mean(s : SortcomparepatienceSlice) -> Double { @_common.mean(s.data) }

pub fn sort_compare_patience_slice_scale(s : SortcomparepatienceSlice, f : Double) -> SortcomparepatienceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_slice_add(a : SortcomparepatienceSlice, b : SortcomparepatienceSlice) -> SortcomparepatienceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_patience_slice_copy(s : SortcomparepatienceSlice) -> SortcomparepatienceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_slice_fill(s : SortcomparepatienceSlice, v : Double) -> SortcomparepatienceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_patience_slice_min(s : SortcomparepatienceSlice) -> Double { @_common.min(s.data) }

pub fn sort_compare_patience_slice_max(s : SortcomparepatienceSlice) -> Double { @_common.max(s.data) }

pub fn sort_compare_patience_slice_to_string(s : SortcomparepatienceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

