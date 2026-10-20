///===
/// extcore/sort_compare_cycle

pub(all) struct SortcomparecyclePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_compare_cycle_make_point(x : Double, y : Double) -> SortcomparecyclePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_compare_cycle_make_point3(x : Double, y : Double, z : Double) -> SortcomparecyclePoint {
  { x, y, z, label: 0 }
}

pub fn SortcomparecyclePoint::x(self : SortcomparecyclePoint) -> Double { self.x }

pub fn SortcomparecyclePoint::y(self : SortcomparecyclePoint) -> Double { self.y }

pub fn SortcomparecyclePoint::z(self : SortcomparecyclePoint) -> Double { self.z }

pub fn SortcomparecyclePoint::label(self : SortcomparecyclePoint) -> Int { self.label }

pub fn SortcomparecyclePoint::dist(self : SortcomparecyclePoint, other : SortcomparecyclePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn SortcomparecyclePoint::add(self : SortcomparecyclePoint, other : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn SortcomparecyclePoint::sub(self : SortcomparecyclePoint, other : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn SortcomparecyclePoint::scale(self : SortcomparecyclePoint, s : Double) -> SortcomparecyclePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn SortcomparecyclePoint::dot(self : SortcomparecyclePoint, other : SortcomparecyclePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn SortcomparecyclePoint::cross(self : SortcomparecyclePoint, other : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn SortcomparecyclePoint::norm(self : SortcomparecyclePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn SortcomparecyclePoint::normalize(self : SortcomparecyclePoint) -> SortcomparecyclePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparecyclePoint::negate(self : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn SortcomparecyclePoint::mid(self : SortcomparecyclePoint, other : SortcomparecyclePoint) -> SortcomparecyclePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn SortcomparecyclePoint::lerp(self : SortcomparecyclePoint, other : SortcomparecyclePoint, t : Double) -> SortcomparecyclePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn SortcomparecyclePoint::to_string(self : SortcomparecyclePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct SortcomparecycleSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_compare_cycle_make_series(vals : Array[Double], name : String) -> SortcomparecycleSeries {
  { vals, name, meta: 0 }
}

pub fn SortcomparecycleSeries::len(self : SortcomparecycleSeries) -> Int { self.vals.length() }

pub fn SortcomparecycleSeries::sum(self : SortcomparecycleSeries) -> Double { @_common.sum(self.vals) }

pub fn SortcomparecycleSeries::mean(self : SortcomparecycleSeries) -> Double { @_common.mean(self.vals) }

pub fn SortcomparecycleSeries::min(self : SortcomparecycleSeries) -> Double { @_common.min(self.vals) }

pub fn SortcomparecycleSeries::max(self : SortcomparecycleSeries) -> Double { @_common.max(self.vals) }

pub fn SortcomparecycleSeries::range(self : SortcomparecycleSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn SortcomparecycleSeries::variance(self : SortcomparecycleSeries) -> Double { @_common.variance(self.vals) }

pub fn SortcomparecycleSeries::std(self : SortcomparecycleSeries) -> Double { @_common.std(self.vals) }

pub fn SortcomparecycleSeries::median(self : SortcomparecycleSeries) -> Double { @_common.median(self.vals) }

pub fn SortcomparecycleSeries::scale(self : SortcomparecycleSeries, f : Double) -> SortcomparecycleSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn SortcomparecycleSeries::add(self : SortcomparecycleSeries, other : SortcomparecycleSeries) -> SortcomparecycleSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn SortcomparecycleSeries::sub(self : SortcomparecycleSeries, other : SortcomparecycleSeries) -> SortcomparecycleSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn SortcomparecycleSeries::normalize(self : SortcomparecycleSeries) -> SortcomparecycleSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn SortcomparecycleSeries::cumsum(self : SortcomparecycleSeries) -> SortcomparecycleSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn SortcomparecycleSeries::to_string(self : SortcomparecycleSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SortcomparecycleMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_compare_cycle_make_matrix(rows : Int, cols : Int, val : Double) -> SortcomparecycleMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_compare_cycle_matrix_identity(n : Int) -> SortcomparecycleMatrix {
  let m = sort_compare_cycle_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn SortcomparecycleMatrix::get(self : SortcomparecycleMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn SortcomparecycleMatrix::transpose(self : SortcomparecycleMatrix) -> SortcomparecycleMatrix {
  let result = sort_compare_cycle_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn SortcomparecycleMatrix::add(self : SortcomparecycleMatrix, other : SortcomparecycleMatrix) -> SortcomparecycleMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = sort_compare_cycle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn SortcomparecycleMatrix::scale(self : SortcomparecycleMatrix, s : Double) -> SortcomparecycleMatrix {
  let result = sort_compare_cycle_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn SortcomparecycleMatrix::multiply(self : SortcomparecycleMatrix, other : SortcomparecycleMatrix) -> SortcomparecycleMatrix {
  if self.cols != other.rows { return sort_compare_cycle_make_matrix(self.rows, other.cols, 0.0) }
  let result = sort_compare_cycle_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn SortcomparecycleMatrix::trace(self : SortcomparecycleMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn SortcomparecycleMatrix::det(self : SortcomparecycleMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn SortcomparecycleMatrix::norm(self : SortcomparecycleMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn SortcomparecycleMatrix::to_string(self : SortcomparecycleMatrix) -> String {
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

pub(all) struct SortcomparecycleVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_compare_cycle_make_vector(comps : Array[Double]) -> SortcomparecycleVector {
  { comps, dim: comps.length() }
}

pub fn sort_compare_cycle_vector_zero(dim : Int) -> SortcomparecycleVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn SortcomparecycleVector::add(self : SortcomparecycleVector, other : SortcomparecycleVector) -> SortcomparecycleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparecycleVector::sub(self : SortcomparecycleVector, other : SortcomparecycleVector) -> SortcomparecycleVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn SortcomparecycleVector::scale(self : SortcomparecycleVector, s : Double) -> SortcomparecycleVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn SortcomparecycleVector::dot(self : SortcomparecycleVector, other : SortcomparecycleVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn SortcomparecycleVector::norm(self : SortcomparecycleVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn SortcomparecycleVector::normalize(self : SortcomparecycleVector) -> SortcomparecycleVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn SortcomparecycleVector::dist(self : SortcomparecycleVector, other : SortcomparecycleVector) -> Double {
  self.sub(other).norm()
}

pub fn SortcomparecycleVector::to_string(self : SortcomparecycleVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_compare_cycle_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn sort_compare_cycle_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn sort_compare_cycle_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn sort_compare_cycle_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn sort_compare_cycle_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn sort_compare_cycle_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn sort_compare_cycle_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn sort_compare_cycle_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn sort_compare_cycle_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn sort_compare_cycle_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn sort_compare_cycle_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn sort_compare_cycle_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn sort_compare_cycle_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn sort_compare_cycle_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn sort_compare_cycle_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn sort_compare_cycle_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn sort_compare_cycle_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn sort_compare_cycle_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn sort_compare_cycle_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn sort_compare_cycle_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn sort_compare_cycle_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn sort_compare_cycle_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn sort_compare_cycle_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn sort_compare_cycle_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn sort_compare_cycle_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn sort_compare_cycle_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn sort_compare_cycle_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn sort_compare_cycle_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn sort_compare_cycle_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct SortcomparecycleFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_frame_make(size : Int) -> SortcomparecycleFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_frame_len(s : SortcomparecycleFrame) -> Int { s.size }

pub fn sort_compare_cycle_frame_get(s : SortcomparecycleFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_frame_set(s : SortcomparecycleFrame, i : Int, v : Double) -> SortcomparecycleFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_frame_sum(s : SortcomparecycleFrame) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_frame_mean(s : SortcomparecycleFrame) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_frame_scale(s : SortcomparecycleFrame, f : Double) -> SortcomparecycleFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_frame_add(a : SortcomparecycleFrame, b : SortcomparecycleFrame) -> SortcomparecycleFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_frame_copy(s : SortcomparecycleFrame) -> SortcomparecycleFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_frame_fill(s : SortcomparecycleFrame, v : Double) -> SortcomparecycleFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_frame_min(s : SortcomparecycleFrame) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_frame_max(s : SortcomparecycleFrame) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_frame_to_string(s : SortcomparecycleFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_table_make(size : Int) -> SortcomparecycleTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_table_len(s : SortcomparecycleTable) -> Int { s.size }

pub fn sort_compare_cycle_table_get(s : SortcomparecycleTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_table_set(s : SortcomparecycleTable, i : Int, v : Double) -> SortcomparecycleTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_table_sum(s : SortcomparecycleTable) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_table_mean(s : SortcomparecycleTable) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_table_scale(s : SortcomparecycleTable, f : Double) -> SortcomparecycleTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_table_add(a : SortcomparecycleTable, b : SortcomparecycleTable) -> SortcomparecycleTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_table_copy(s : SortcomparecycleTable) -> SortcomparecycleTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_table_fill(s : SortcomparecycleTable, v : Double) -> SortcomparecycleTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_table_min(s : SortcomparecycleTable) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_table_max(s : SortcomparecycleTable) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_table_to_string(s : SortcomparecycleTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_graphn_make(size : Int) -> SortcomparecycleGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_graphn_len(s : SortcomparecycleGraphN) -> Int { s.size }

pub fn sort_compare_cycle_graphn_get(s : SortcomparecycleGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_graphn_set(s : SortcomparecycleGraphN, i : Int, v : Double) -> SortcomparecycleGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_graphn_sum(s : SortcomparecycleGraphN) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_graphn_mean(s : SortcomparecycleGraphN) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_graphn_scale(s : SortcomparecycleGraphN, f : Double) -> SortcomparecycleGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_graphn_add(a : SortcomparecycleGraphN, b : SortcomparecycleGraphN) -> SortcomparecycleGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_graphn_copy(s : SortcomparecycleGraphN) -> SortcomparecycleGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_graphn_fill(s : SortcomparecycleGraphN, v : Double) -> SortcomparecycleGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_graphn_min(s : SortcomparecycleGraphN) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_graphn_max(s : SortcomparecycleGraphN) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_graphn_to_string(s : SortcomparecycleGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_node_make(size : Int) -> SortcomparecycleNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_node_len(s : SortcomparecycleNode) -> Int { s.size }

pub fn sort_compare_cycle_node_get(s : SortcomparecycleNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_node_set(s : SortcomparecycleNode, i : Int, v : Double) -> SortcomparecycleNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_node_sum(s : SortcomparecycleNode) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_node_mean(s : SortcomparecycleNode) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_node_scale(s : SortcomparecycleNode, f : Double) -> SortcomparecycleNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_node_add(a : SortcomparecycleNode, b : SortcomparecycleNode) -> SortcomparecycleNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_node_copy(s : SortcomparecycleNode) -> SortcomparecycleNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_node_fill(s : SortcomparecycleNode, v : Double) -> SortcomparecycleNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_node_min(s : SortcomparecycleNode) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_node_max(s : SortcomparecycleNode) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_node_to_string(s : SortcomparecycleNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_edge_make(size : Int) -> SortcomparecycleEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_edge_len(s : SortcomparecycleEdge) -> Int { s.size }

pub fn sort_compare_cycle_edge_get(s : SortcomparecycleEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_edge_set(s : SortcomparecycleEdge, i : Int, v : Double) -> SortcomparecycleEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_edge_sum(s : SortcomparecycleEdge) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_edge_mean(s : SortcomparecycleEdge) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_edge_scale(s : SortcomparecycleEdge, f : Double) -> SortcomparecycleEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_edge_add(a : SortcomparecycleEdge, b : SortcomparecycleEdge) -> SortcomparecycleEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_edge_copy(s : SortcomparecycleEdge) -> SortcomparecycleEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_edge_fill(s : SortcomparecycleEdge, v : Double) -> SortcomparecycleEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_edge_min(s : SortcomparecycleEdge) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_edge_max(s : SortcomparecycleEdge) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_edge_to_string(s : SortcomparecycleEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecyclePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_path_make(size : Int) -> SortcomparecyclePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_path_len(s : SortcomparecyclePath) -> Int { s.size }

pub fn sort_compare_cycle_path_get(s : SortcomparecyclePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_path_set(s : SortcomparecyclePath, i : Int, v : Double) -> SortcomparecyclePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_path_sum(s : SortcomparecyclePath) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_path_mean(s : SortcomparecyclePath) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_path_scale(s : SortcomparecyclePath, f : Double) -> SortcomparecyclePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_path_add(a : SortcomparecyclePath, b : SortcomparecyclePath) -> SortcomparecyclePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_path_copy(s : SortcomparecyclePath) -> SortcomparecyclePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_path_fill(s : SortcomparecyclePath, v : Double) -> SortcomparecyclePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_path_min(s : SortcomparecyclePath) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_path_max(s : SortcomparecyclePath) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_path_to_string(s : SortcomparecyclePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_cluster_make(size : Int) -> SortcomparecycleCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_cluster_len(s : SortcomparecycleCluster) -> Int { s.size }

pub fn sort_compare_cycle_cluster_get(s : SortcomparecycleCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_cluster_set(s : SortcomparecycleCluster, i : Int, v : Double) -> SortcomparecycleCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_cluster_sum(s : SortcomparecycleCluster) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_cluster_mean(s : SortcomparecycleCluster) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_cluster_scale(s : SortcomparecycleCluster, f : Double) -> SortcomparecycleCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_cluster_add(a : SortcomparecycleCluster, b : SortcomparecycleCluster) -> SortcomparecycleCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_cluster_copy(s : SortcomparecycleCluster) -> SortcomparecycleCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_cluster_fill(s : SortcomparecycleCluster, v : Double) -> SortcomparecycleCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_cluster_min(s : SortcomparecycleCluster) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_cluster_max(s : SortcomparecycleCluster) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_cluster_to_string(s : SortcomparecycleCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_model_make(size : Int) -> SortcomparecycleModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_model_len(s : SortcomparecycleModel) -> Int { s.size }

pub fn sort_compare_cycle_model_get(s : SortcomparecycleModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_model_set(s : SortcomparecycleModel, i : Int, v : Double) -> SortcomparecycleModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_model_sum(s : SortcomparecycleModel) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_model_mean(s : SortcomparecycleModel) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_model_scale(s : SortcomparecycleModel, f : Double) -> SortcomparecycleModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_model_add(a : SortcomparecycleModel, b : SortcomparecycleModel) -> SortcomparecycleModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_model_copy(s : SortcomparecycleModel) -> SortcomparecycleModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_model_fill(s : SortcomparecycleModel, v : Double) -> SortcomparecycleModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_model_min(s : SortcomparecycleModel) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_model_max(s : SortcomparecycleModel) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_model_to_string(s : SortcomparecycleModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_layer_make(size : Int) -> SortcomparecycleLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_layer_len(s : SortcomparecycleLayer) -> Int { s.size }

pub fn sort_compare_cycle_layer_get(s : SortcomparecycleLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_layer_set(s : SortcomparecycleLayer, i : Int, v : Double) -> SortcomparecycleLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_layer_sum(s : SortcomparecycleLayer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_layer_mean(s : SortcomparecycleLayer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_layer_scale(s : SortcomparecycleLayer, f : Double) -> SortcomparecycleLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_layer_add(a : SortcomparecycleLayer, b : SortcomparecycleLayer) -> SortcomparecycleLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_layer_copy(s : SortcomparecycleLayer) -> SortcomparecycleLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_layer_fill(s : SortcomparecycleLayer, v : Double) -> SortcomparecycleLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_layer_min(s : SortcomparecycleLayer) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_layer_max(s : SortcomparecycleLayer) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_layer_to_string(s : SortcomparecycleLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_buffer_make(size : Int) -> SortcomparecycleBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_buffer_len(s : SortcomparecycleBuffer) -> Int { s.size }

pub fn sort_compare_cycle_buffer_get(s : SortcomparecycleBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_buffer_set(s : SortcomparecycleBuffer, i : Int, v : Double) -> SortcomparecycleBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_buffer_sum(s : SortcomparecycleBuffer) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_buffer_mean(s : SortcomparecycleBuffer) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_buffer_scale(s : SortcomparecycleBuffer, f : Double) -> SortcomparecycleBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_buffer_add(a : SortcomparecycleBuffer, b : SortcomparecycleBuffer) -> SortcomparecycleBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_buffer_copy(s : SortcomparecycleBuffer) -> SortcomparecycleBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_buffer_fill(s : SortcomparecycleBuffer, v : Double) -> SortcomparecycleBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_buffer_min(s : SortcomparecycleBuffer) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_buffer_max(s : SortcomparecycleBuffer) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_buffer_to_string(s : SortcomparecycleBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_cursor_make(size : Int) -> SortcomparecycleCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_cursor_len(s : SortcomparecycleCursor) -> Int { s.size }

pub fn sort_compare_cycle_cursor_get(s : SortcomparecycleCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_cursor_set(s : SortcomparecycleCursor, i : Int, v : Double) -> SortcomparecycleCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_cursor_sum(s : SortcomparecycleCursor) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_cursor_mean(s : SortcomparecycleCursor) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_cursor_scale(s : SortcomparecycleCursor, f : Double) -> SortcomparecycleCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_cursor_add(a : SortcomparecycleCursor, b : SortcomparecycleCursor) -> SortcomparecycleCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_cursor_copy(s : SortcomparecycleCursor) -> SortcomparecycleCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_cursor_fill(s : SortcomparecycleCursor, v : Double) -> SortcomparecycleCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_cursor_min(s : SortcomparecycleCursor) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_cursor_max(s : SortcomparecycleCursor) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_cursor_to_string(s : SortcomparecycleCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_view_make(size : Int) -> SortcomparecycleView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_view_len(s : SortcomparecycleView) -> Int { s.size }

pub fn sort_compare_cycle_view_get(s : SortcomparecycleView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_view_set(s : SortcomparecycleView, i : Int, v : Double) -> SortcomparecycleView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_view_sum(s : SortcomparecycleView) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_view_mean(s : SortcomparecycleView) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_view_scale(s : SortcomparecycleView, f : Double) -> SortcomparecycleView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_view_add(a : SortcomparecycleView, b : SortcomparecycleView) -> SortcomparecycleView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_view_copy(s : SortcomparecycleView) -> SortcomparecycleView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_view_fill(s : SortcomparecycleView, v : Double) -> SortcomparecycleView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_view_min(s : SortcomparecycleView) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_view_max(s : SortcomparecycleView) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_view_to_string(s : SortcomparecycleView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_range_make(size : Int) -> SortcomparecycleRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_range_len(s : SortcomparecycleRange) -> Int { s.size }

pub fn sort_compare_cycle_range_get(s : SortcomparecycleRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_range_set(s : SortcomparecycleRange, i : Int, v : Double) -> SortcomparecycleRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_range_sum(s : SortcomparecycleRange) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_range_mean(s : SortcomparecycleRange) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_range_scale(s : SortcomparecycleRange, f : Double) -> SortcomparecycleRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_range_add(a : SortcomparecycleRange, b : SortcomparecycleRange) -> SortcomparecycleRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_range_copy(s : SortcomparecycleRange) -> SortcomparecycleRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_range_fill(s : SortcomparecycleRange, v : Double) -> SortcomparecycleRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_range_min(s : SortcomparecycleRange) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_range_max(s : SortcomparecycleRange) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_range_to_string(s : SortcomparecycleRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SortcomparecycleSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_compare_cycle_slice_make(size : Int) -> SortcomparecycleSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_compare_cycle_slice_len(s : SortcomparecycleSlice) -> Int { s.size }

pub fn sort_compare_cycle_slice_get(s : SortcomparecycleSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_compare_cycle_slice_set(s : SortcomparecycleSlice, i : Int, v : Double) -> SortcomparecycleSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_slice_sum(s : SortcomparecycleSlice) -> Double { @_common.sum(s.data) }

pub fn sort_compare_cycle_slice_mean(s : SortcomparecycleSlice) -> Double { @_common.mean(s.data) }

pub fn sort_compare_cycle_slice_scale(s : SortcomparecycleSlice, f : Double) -> SortcomparecycleSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_slice_add(a : SortcomparecycleSlice, b : SortcomparecycleSlice) -> SortcomparecycleSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn sort_compare_cycle_slice_copy(s : SortcomparecycleSlice) -> SortcomparecycleSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_slice_fill(s : SortcomparecycleSlice, v : Double) -> SortcomparecycleSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn sort_compare_cycle_slice_min(s : SortcomparecycleSlice) -> Double { @_common.min(s.data) }

pub fn sort_compare_cycle_slice_max(s : SortcomparecycleSlice) -> Double { @_common.max(s.data) }

pub fn sort_compare_cycle_slice_to_string(s : SortcomparecycleSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

