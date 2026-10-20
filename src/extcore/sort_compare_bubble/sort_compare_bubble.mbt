///===
/// extcore/sort_compare_bubble

pub(all) struct SortcomparebubblePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_bubble_make_point(x : Double, y : Double) -> SortcomparebubblePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_bubble_make_point3(x : Double, y : Double, z : Double) -> SortcomparebubblePoint {
  { x, y, z, label: 0 }
}

pub fn SortcomparebubblePoint::x(self : SortcomparebubblePoint) -> Double { self.x }

pub fn SortcomparebubblePoint::y(self : SortcomparebubblePoint) -> Double { self.y }

pub fn SortcomparebubblePoint::z(self : SortcomparebubblePoint) -> Double { self.z }

pub fn SortcomparebubblePoint::label(self : SortcomparebubblePoint) -> Int { self.label }

pub fn SortcomparebubblePoint::dist(self : SortcomparebubblePoint, other : SortcomparebubblePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcomparebubblePoint::add(self : SortcomparebubblePoint, other : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcomparebubblePoint::sub(self : SortcomparebubblePoint, other : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcomparebubblePoint::scale(self : SortcomparebubblePoint, s : Double) -> SortcomparebubblePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcomparebubblePoint::dot(self : SortcomparebubblePoint, other : SortcomparebubblePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcomparebubblePoint::cross(self : SortcomparebubblePoint, other : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcomparebubblePoint::norm(self : SortcomparebubblePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcomparebubblePoint::normalize(self : SortcomparebubblePoint) -> SortcomparebubblePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparebubblePoint::negate(self : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcomparebubblePoint::mid(self : SortcomparebubblePoint, other : SortcomparebubblePoint) -> SortcomparebubblePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcomparebubblePoint::lerp(self : SortcomparebubblePoint, other : SortcomparebubblePoint, t : Double) -> SortcomparebubblePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcomparebubblePoint::to_string(self : SortcomparebubblePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcomparebubbleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_bubble_make_series(vals : Array[Double], name : String) -> SortcomparebubbleSeries {
  { vals, name, meta: 0 }
}

pub fn SortcomparebubbleSeries::len(self : SortcomparebubbleSeries) -> Int { self.vals.length() }

pub fn SortcomparebubbleSeries::sum(self : SortcomparebubbleSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcomparebubbleSeries::mean(self : SortcomparebubbleSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcomparebubbleSeries::min(self : SortcomparebubbleSeries) -> Double { @_common.min(self.vals) }

pub fn SortcomparebubbleSeries::max(self : SortcomparebubbleSeries) -> Double { @_common.max(self.vals) }

pub fn SortcomparebubbleSeries::range(self : SortcomparebubbleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcomparebubbleSeries::variance(self : SortcomparebubbleSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcomparebubbleSeries::std(self : SortcomparebubbleSeries) -> Double { @_common.std(self.vals) }

pub fn SortcomparebubbleSeries::median(self : SortcomparebubbleSeries) -> Double { @_common.median(self.vals) }

pub fn SortcomparebubbleSeries::scale(self : SortcomparebubbleSeries, f : Double) -> SortcomparebubbleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcomparebubbleSeries::add(self : SortcomparebubbleSeries, other : SortcomparebubbleSeries) -> SortcomparebubbleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcomparebubbleSeries::sub(self : SortcomparebubbleSeries, other : SortcomparebubbleSeries) -> SortcomparebubbleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcomparebubbleSeries::normalize(self : SortcomparebubbleSeries) -> SortcomparebubbleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcomparebubbleSeries::cumsum(self : SortcomparebubbleSeries) -> SortcomparebubbleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcomparebubbleSeries::to_string(self : SortcomparebubbleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparebubbleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_bubble_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparebubbleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_bubble_matrix_identity(n : Int) -> SortcomparebubbleMatrix {
  let m = sort_compare_bubble_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcomparebubbleMatrix::get(self : SortcomparebubbleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcomparebubbleMatrix::transpose(self : SortcomparebubbleMatrix) -> SortcomparebubbleMatrix {
  let result = sort_compare_bubble_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcomparebubbleMatrix::add(self : SortcomparebubbleMatrix, other : SortcomparebubbleMatrix) -> SortcomparebubbleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_bubble_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcomparebubbleMatrix::scale(self : SortcomparebubbleMatrix, s : Double) -> SortcomparebubbleMatrix {
  let result = sort_compare_bubble_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcomparebubbleMatrix::multiply(self : SortcomparebubbleMatrix, other : SortcomparebubbleMatrix) -> SortcomparebubbleMatrix {
  if self.cols != other.rows { return sort_compare_bubble_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_bubble_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcomparebubbleMatrix::trace(self : SortcomparebubbleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcomparebubbleMatrix::det(self : SortcomparebubbleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcomparebubbleMatrix::norm(self : SortcomparebubbleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcomparebubbleMatrix::to_string(self : SortcomparebubbleMatrix) -> String {
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

pub(all) struct SortcomparebubbleVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_bubble_make_vector(comps : Array[Double]) -> SortcomparebubbleVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_bubble_vector_zero(dim : Int) -> SortcomparebubbleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcomparebubbleVector::add(self : SortcomparebubbleVector, other : SortcomparebubbleVector) -> SortcomparebubbleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparebubbleVector::sub(self : SortcomparebubbleVector, other : SortcomparebubbleVector) -> SortcomparebubbleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparebubbleVector::scale(self : SortcomparebubbleVector, s : Double) -> SortcomparebubbleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcomparebubbleVector::dot(self : SortcomparebubbleVector, other : SortcomparebubbleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcomparebubbleVector::norm(self : SortcomparebubbleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcomparebubbleVector::normalize(self : SortcomparebubbleVector) -> SortcomparebubbleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparebubbleVector::dist(self : SortcomparebubbleVector, other : SortcomparebubbleVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcomparebubbleVector::to_string(self : SortcomparebubbleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_bubble_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_bubble_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_bubble_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_bubble_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_bubble_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_bubble_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_bubble_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_bubble_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_bubble_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_bubble_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_bubble_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_bubble_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_bubble_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_bubble_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_bubble_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_bubble_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_bubble_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_bubble_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_bubble_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_bubble_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_bubble_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_bubble_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_bubble_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_bubble_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_bubble_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_bubble_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_bubble_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_bubble_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_bubble_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcomparebubbleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_frame_make(size : Int) -> SortcomparebubbleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_frame_len(s : SortcomparebubbleFrame) -> Int { s.size }

pub fn sort_compare_bubble_frame_get(s : SortcomparebubbleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_frame_set(s : SortcomparebubbleFrame, i : Int, v : Double) -> SortcomparebubbleFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_frame_sum(s : SortcomparebubbleFrame) -> Double { @_common.sum(s.data) }

pub fn sort_compare_bubble_frame_mean(s : SortcomparebubbleFrame) -> Double { @_common.mean(s.data) }

pub fn sort_compare_bubble_frame_scale(s : SortcomparebubbleFrame, f : Double) -> SortcomparebubbleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_frame_add(a : SortcomparebubbleFrame, b : SortcomparebubbleFrame) -> SortcomparebubbleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_bubble_frame_copy(s : SortcomparebubbleFrame) -> SortcomparebubbleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_frame_fill(s : SortcomparebubbleFrame, v : Double) -> SortcomparebubbleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_frame_min(s : SortcomparebubbleFrame) -> Double { @_common.min(s.data) }

pub fn sort_compare_bubble_frame_max(s : SortcomparebubbleFrame) -> Double { @_common.max(s.data) }

pub fn sort_compare_bubble_frame_to_string(s : SortcomparebubbleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_table_make(size : Int) -> SortcomparebubbleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_table_len(s : SortcomparebubbleTable) -> Int { s.size }

pub fn sort_compare_bubble_table_get(s : SortcomparebubbleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_table_set(s : SortcomparebubbleTable, i : Int, v : Double) -> SortcomparebubbleTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_table_sum(s : SortcomparebubbleTable) -> Double { @_common.sum(s.data) }

pub fn sort_compare_bubble_table_mean(s : SortcomparebubbleTable) -> Double { @_common.mean(s.data) }

pub fn sort_compare_bubble_table_scale(s : SortcomparebubbleTable, f : Double) -> SortcomparebubbleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_table_add(a : SortcomparebubbleTable, b : SortcomparebubbleTable) -> SortcomparebubbleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_bubble_table_copy(s : SortcomparebubbleTable) -> SortcomparebubbleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_table_fill(s : SortcomparebubbleTable, v : Double) -> SortcomparebubbleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_table_min(s : SortcomparebubbleTable) -> Double { @_common.min(s.data) }

pub fn sort_compare_bubble_table_max(s : SortcomparebubbleTable) -> Double { @_common.max(s.data) }

pub fn sort_compare_bubble_table_to_string(s : SortcomparebubbleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_graphn_make(size : Int) -> SortcomparebubbleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_graphn_len(s : SortcomparebubbleGraphN) -> Int { s.size }

pub fn sort_compare_bubble_graphn_get(s : SortcomparebubbleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_graphn_set(s : SortcomparebubbleGraphN, i : Int, v : Double) -> SortcomparebubbleGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_graphn_sum(s : SortcomparebubbleGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_compare_bubble_graphn_mean(s : SortcomparebubbleGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_compare_bubble_graphn_scale(s : SortcomparebubbleGraphN, f : Double) -> SortcomparebubbleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_graphn_add(a : SortcomparebubbleGraphN, b : SortcomparebubbleGraphN) -> SortcomparebubbleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_bubble_graphn_copy(s : SortcomparebubbleGraphN) -> SortcomparebubbleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_graphn_fill(s : SortcomparebubbleGraphN, v : Double) -> SortcomparebubbleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_graphn_min(s : SortcomparebubbleGraphN) -> Double { @_common.min(s.data) }

pub fn sort_compare_bubble_graphn_max(s : SortcomparebubbleGraphN) -> Double { @_common.max(s.data) }

pub fn sort_compare_bubble_graphn_to_string(s : SortcomparebubbleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_node_make(size : Int) -> SortcomparebubbleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_node_len(s : SortcomparebubbleNode) -> Int { s.size }

pub fn sort_compare_bubble_node_get(s : SortcomparebubbleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_node_set(s : SortcomparebubbleNode, i : Int, v : Double) -> SortcomparebubbleNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_node_sum(s : SortcomparebubbleNode) -> Double { @_common.sum(s.data) }

pub fn sort_compare_bubble_node_mean(s : SortcomparebubbleNode) -> Double { @_common.mean(s.data) }

pub fn sort_compare_bubble_node_scale(s : SortcomparebubbleNode, f : Double) -> SortcomparebubbleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_node_add(a : SortcomparebubbleNode, b : SortcomparebubbleNode) -> SortcomparebubbleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_bubble_node_copy(s : SortcomparebubbleNode) -> SortcomparebubbleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_node_fill(s : SortcomparebubbleNode, v : Double) -> SortcomparebubbleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_node_min(s : SortcomparebubbleNode) -> Double { @_common.min(s.data) }

pub fn sort_compare_bubble_node_max(s : SortcomparebubbleNode) -> Double { @_common.max(s.data) }

pub fn sort_compare_bubble_node_to_string(s : SortcomparebubbleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_edge_make(size : Int) -> SortcomparebubbleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_edge_len(s : SortcomparebubbleEdge) -> Int { s.size }

pub fn sort_compare_bubble_edge_get(s : SortcomparebubbleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_edge_set(s : SortcomparebubbleEdge, i : Int, v : Double) -> SortcomparebubbleEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_edge_sum(s : SortcomparebubbleEdge) -> Double { @_common.sum(s.data) }

pub fn sort_compare_bubble_edge_mean(s : SortcomparebubbleEdge) -> Double { @_common.mean(s.data) }

pub fn sort_compare_bubble_edge_scale(s : SortcomparebubbleEdge, f : Double) -> SortcomparebubbleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_edge_add(a : SortcomparebubbleEdge, b : SortcomparebubbleEdge) -> SortcomparebubbleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_bubble_edge_copy(s : SortcomparebubbleEdge) -> SortcomparebubbleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_edge_fill(s : SortcomparebubbleEdge, v : Double) -> SortcomparebubbleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_edge_min(s : SortcomparebubbleEdge) -> Double { @_common.min(s.data) }

pub fn sort_compare_bubble_edge_max(s : SortcomparebubbleEdge) -> Double { @_common.max(s.data) }

pub fn sort_compare_bubble_edge_to_string(s : SortcomparebubbleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubblePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_path_make(size : Int) -> SortcomparebubblePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_path_len(s : SortcomparebubblePath) -> Int { s.size }

pub fn sort_compare_bubble_path_get(s : SortcomparebubblePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_path_set(s : SortcomparebubblePath, i : Int, v : Double) -> SortcomparebubblePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_path_sum(s : SortcomparebubblePath) -> Double { @_common.sum(s.data) }

pub fn sort_compare_bubble_path_mean(s : SortcomparebubblePath) -> Double { @_common.mean(s.data) }

pub fn sort_compare_bubble_path_scale(s : SortcomparebubblePath, f : Double) -> SortcomparebubblePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_path_add(a : SortcomparebubblePath, b : SortcomparebubblePath) -> SortcomparebubblePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_bubble_path_copy(s : SortcomparebubblePath) -> SortcomparebubblePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_path_fill(s : SortcomparebubblePath, v : Double) -> SortcomparebubblePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_path_min(s : SortcomparebubblePath) -> Double { @_common.min(s.data) }

pub fn sort_compare_bubble_path_max(s : SortcomparebubblePath) -> Double { @_common.max(s.data) }

pub fn sort_compare_bubble_path_to_string(s : SortcomparebubblePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_cluster_make(size : Int) -> SortcomparebubbleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_cluster_len(s : SortcomparebubbleCluster) -> Int { s.size }

pub fn sort_compare_bubble_cluster_get(s : SortcomparebubbleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_cluster_set(s : SortcomparebubbleCluster, i : Int, v : Double) -> SortcomparebubbleCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_cluster_sum(s : SortcomparebubbleCluster) -> Double { @_common.sum(s.data) }

pub fn sort_compare_bubble_cluster_mean(s : SortcomparebubbleCluster) -> Double { @_common.mean(s.data) }

pub fn sort_compare_bubble_cluster_scale(s : SortcomparebubbleCluster, f : Double) -> SortcomparebubbleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_cluster_add(a : SortcomparebubbleCluster, b : SortcomparebubbleCluster) -> SortcomparebubbleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_bubble_cluster_copy(s : SortcomparebubbleCluster) -> SortcomparebubbleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_cluster_fill(s : SortcomparebubbleCluster, v : Double) -> SortcomparebubbleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_cluster_min(s : SortcomparebubbleCluster) -> Double { @_common.min(s.data) }

pub fn sort_compare_bubble_cluster_max(s : SortcomparebubbleCluster) -> Double { @_common.max(s.data) }

pub fn sort_compare_bubble_cluster_to_string(s : SortcomparebubbleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_model_make(size : Int) -> SortcomparebubbleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_model_len(s : SortcomparebubbleModel) -> Int { s.size }

pub fn sort_compare_bubble_model_get(s : SortcomparebubbleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_model_set(s : SortcomparebubbleModel, i : Int, v : Double) -> SortcomparebubbleModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_model_sum(s : SortcomparebubbleModel) -> Double { @_common.sum(s.data) }

pub fn sort_compare_bubble_model_mean(s : SortcomparebubbleModel) -> Double { @_common.mean(s.data) }

pub fn sort_compare_bubble_model_scale(s : SortcomparebubbleModel, f : Double) -> SortcomparebubbleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_model_add(a : SortcomparebubbleModel, b : SortcomparebubbleModel) -> SortcomparebubbleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_bubble_model_copy(s : SortcomparebubbleModel) -> SortcomparebubbleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_model_fill(s : SortcomparebubbleModel, v : Double) -> SortcomparebubbleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_model_min(s : SortcomparebubbleModel) -> Double { @_common.min(s.data) }

pub fn sort_compare_bubble_model_max(s : SortcomparebubbleModel) -> Double { @_common.max(s.data) }

pub fn sort_compare_bubble_model_to_string(s : SortcomparebubbleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_layer_make(size : Int) -> SortcomparebubbleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_layer_len(s : SortcomparebubbleLayer) -> Int { s.size }

pub fn sort_compare_bubble_layer_get(s : SortcomparebubbleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_layer_set(s : SortcomparebubbleLayer, i : Int, v : Double) -> SortcomparebubbleLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_layer_sum(s : SortcomparebubbleLayer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_bubble_layer_mean(s : SortcomparebubbleLayer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_bubble_layer_scale(s : SortcomparebubbleLayer, f : Double) -> SortcomparebubbleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_layer_add(a : SortcomparebubbleLayer, b : SortcomparebubbleLayer) -> SortcomparebubbleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_bubble_layer_copy(s : SortcomparebubbleLayer) -> SortcomparebubbleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_layer_fill(s : SortcomparebubbleLayer, v : Double) -> SortcomparebubbleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_layer_min(s : SortcomparebubbleLayer) -> Double { @_common.min(s.data) }

pub fn sort_compare_bubble_layer_max(s : SortcomparebubbleLayer) -> Double { @_common.max(s.data) }

pub fn sort_compare_bubble_layer_to_string(s : SortcomparebubbleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_buffer_make(size : Int) -> SortcomparebubbleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_buffer_len(s : SortcomparebubbleBuffer) -> Int { s.size }

pub fn sort_compare_bubble_buffer_get(s : SortcomparebubbleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_buffer_set(s : SortcomparebubbleBuffer, i : Int, v : Double) -> SortcomparebubbleBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_buffer_sum(s : SortcomparebubbleBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_bubble_buffer_mean(s : SortcomparebubbleBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_bubble_buffer_scale(s : SortcomparebubbleBuffer, f : Double) -> SortcomparebubbleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_buffer_add(a : SortcomparebubbleBuffer, b : SortcomparebubbleBuffer) -> SortcomparebubbleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_bubble_buffer_copy(s : SortcomparebubbleBuffer) -> SortcomparebubbleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_buffer_fill(s : SortcomparebubbleBuffer, v : Double) -> SortcomparebubbleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_buffer_min(s : SortcomparebubbleBuffer) -> Double { @_common.min(s.data) }

pub fn sort_compare_bubble_buffer_max(s : SortcomparebubbleBuffer) -> Double { @_common.max(s.data) }

pub fn sort_compare_bubble_buffer_to_string(s : SortcomparebubbleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_cursor_make(size : Int) -> SortcomparebubbleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_cursor_len(s : SortcomparebubbleCursor) -> Int { s.size }

pub fn sort_compare_bubble_cursor_get(s : SortcomparebubbleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_cursor_set(s : SortcomparebubbleCursor, i : Int, v : Double) -> SortcomparebubbleCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_cursor_sum(s : SortcomparebubbleCursor) -> Double { @_common.sum(s.data) }

pub fn sort_compare_bubble_cursor_mean(s : SortcomparebubbleCursor) -> Double { @_common.mean(s.data) }

pub fn sort_compare_bubble_cursor_scale(s : SortcomparebubbleCursor, f : Double) -> SortcomparebubbleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_cursor_add(a : SortcomparebubbleCursor, b : SortcomparebubbleCursor) -> SortcomparebubbleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_bubble_cursor_copy(s : SortcomparebubbleCursor) -> SortcomparebubbleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_cursor_fill(s : SortcomparebubbleCursor, v : Double) -> SortcomparebubbleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_cursor_min(s : SortcomparebubbleCursor) -> Double { @_common.min(s.data) }

pub fn sort_compare_bubble_cursor_max(s : SortcomparebubbleCursor) -> Double { @_common.max(s.data) }

pub fn sort_compare_bubble_cursor_to_string(s : SortcomparebubbleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_view_make(size : Int) -> SortcomparebubbleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_view_len(s : SortcomparebubbleView) -> Int { s.size }

pub fn sort_compare_bubble_view_get(s : SortcomparebubbleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_view_set(s : SortcomparebubbleView, i : Int, v : Double) -> SortcomparebubbleView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_view_sum(s : SortcomparebubbleView) -> Double { @_common.sum(s.data) }

pub fn sort_compare_bubble_view_mean(s : SortcomparebubbleView) -> Double { @_common.mean(s.data) }

pub fn sort_compare_bubble_view_scale(s : SortcomparebubbleView, f : Double) -> SortcomparebubbleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_view_add(a : SortcomparebubbleView, b : SortcomparebubbleView) -> SortcomparebubbleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_bubble_view_copy(s : SortcomparebubbleView) -> SortcomparebubbleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_view_fill(s : SortcomparebubbleView, v : Double) -> SortcomparebubbleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_view_min(s : SortcomparebubbleView) -> Double { @_common.min(s.data) }

pub fn sort_compare_bubble_view_max(s : SortcomparebubbleView) -> Double { @_common.max(s.data) }

pub fn sort_compare_bubble_view_to_string(s : SortcomparebubbleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_range_make(size : Int) -> SortcomparebubbleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_range_len(s : SortcomparebubbleRange) -> Int { s.size }

pub fn sort_compare_bubble_range_get(s : SortcomparebubbleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_range_set(s : SortcomparebubbleRange, i : Int, v : Double) -> SortcomparebubbleRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_range_sum(s : SortcomparebubbleRange) -> Double { @_common.sum(s.data) }

pub fn sort_compare_bubble_range_mean(s : SortcomparebubbleRange) -> Double { @_common.mean(s.data) }

pub fn sort_compare_bubble_range_scale(s : SortcomparebubbleRange, f : Double) -> SortcomparebubbleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_range_add(a : SortcomparebubbleRange, b : SortcomparebubbleRange) -> SortcomparebubbleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_bubble_range_copy(s : SortcomparebubbleRange) -> SortcomparebubbleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_range_fill(s : SortcomparebubbleRange, v : Double) -> SortcomparebubbleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_range_min(s : SortcomparebubbleRange) -> Double { @_common.min(s.data) }

pub fn sort_compare_bubble_range_max(s : SortcomparebubbleRange) -> Double { @_common.max(s.data) }

pub fn sort_compare_bubble_range_to_string(s : SortcomparebubbleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparebubbleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_bubble_slice_make(size : Int) -> SortcomparebubbleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_bubble_slice_len(s : SortcomparebubbleSlice) -> Int { s.size }

pub fn sort_compare_bubble_slice_get(s : SortcomparebubbleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_bubble_slice_set(s : SortcomparebubbleSlice, i : Int, v : Double) -> SortcomparebubbleSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_slice_sum(s : SortcomparebubbleSlice) -> Double { @_common.sum(s.data) }

pub fn sort_compare_bubble_slice_mean(s : SortcomparebubbleSlice) -> Double { @_common.mean(s.data) }

pub fn sort_compare_bubble_slice_scale(s : SortcomparebubbleSlice, f : Double) -> SortcomparebubbleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_slice_add(a : SortcomparebubbleSlice, b : SortcomparebubbleSlice) -> SortcomparebubbleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_bubble_slice_copy(s : SortcomparebubbleSlice) -> SortcomparebubbleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_slice_fill(s : SortcomparebubbleSlice, v : Double) -> SortcomparebubbleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_bubble_slice_min(s : SortcomparebubbleSlice) -> Double { @_common.min(s.data) }

pub fn sort_compare_bubble_slice_max(s : SortcomparebubbleSlice) -> Double { @_common.max(s.data) }

pub fn sort_compare_bubble_slice_to_string(s : SortcomparebubbleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

