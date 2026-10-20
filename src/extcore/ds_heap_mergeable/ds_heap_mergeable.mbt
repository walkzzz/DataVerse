///===
/// extcore/ds_heap_mergeable

pub(all) struct DsheapmergeablePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_mergeable_make_point(x : Double, y : Double) -> DsheapmergeablePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_mergeable_make_point3(x : Double, y : Double, z : Double) -> DsheapmergeablePoint {
  { x, y, z, label: 0 }
}

pub fn DsheapmergeablePoint::x(self : DsheapmergeablePoint) -> Double { self.x }

pub fn DsheapmergeablePoint::y(self : DsheapmergeablePoint) -> Double { self.y }

pub fn DsheapmergeablePoint::z(self : DsheapmergeablePoint) -> Double { self.z }

pub fn DsheapmergeablePoint::label(self : DsheapmergeablePoint) -> Int { self.label }

pub fn DsheapmergeablePoint::dist(self : DsheapmergeablePoint, other : DsheapmergeablePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheapmergeablePoint::add(self : DsheapmergeablePoint, other : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheapmergeablePoint::sub(self : DsheapmergeablePoint, other : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheapmergeablePoint::scale(self : DsheapmergeablePoint, s : Double) -> DsheapmergeablePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheapmergeablePoint::dot(self : DsheapmergeablePoint, other : DsheapmergeablePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheapmergeablePoint::cross(self : DsheapmergeablePoint, other : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheapmergeablePoint::norm(self : DsheapmergeablePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheapmergeablePoint::normalize(self : DsheapmergeablePoint) -> DsheapmergeablePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapmergeablePoint::negate(self : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheapmergeablePoint::mid(self : DsheapmergeablePoint, other : DsheapmergeablePoint) -> DsheapmergeablePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheapmergeablePoint::lerp(self : DsheapmergeablePoint, other : DsheapmergeablePoint, t : Double) -> DsheapmergeablePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheapmergeablePoint::to_string(self : DsheapmergeablePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheapmergeableSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_mergeable_make_series(vals : Array[Double], name : String) -> DsheapmergeableSeries {
  { vals, name, meta: 0 }
}

pub fn DsheapmergeableSeries::len(self : DsheapmergeableSeries) -> Int { self.vals.length() }

pub fn DsheapmergeableSeries::sum(self : DsheapmergeableSeries) -> Double { @_common.sum(self.vals) }

pub fn DsheapmergeableSeries::mean(self : DsheapmergeableSeries) -> Double { @_common.mean(self.vals) }

pub fn DsheapmergeableSeries::min(self : DsheapmergeableSeries) -> Double { @_common.min(self.vals) }

pub fn DsheapmergeableSeries::max(self : DsheapmergeableSeries) -> Double { @_common.max(self.vals) }

pub fn DsheapmergeableSeries::range(self : DsheapmergeableSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheapmergeableSeries::variance(self : DsheapmergeableSeries) -> Double { @_common.variance(self.vals) }

pub fn DsheapmergeableSeries::std(self : DsheapmergeableSeries) -> Double { @_common.std(self.vals) }

pub fn DsheapmergeableSeries::median(self : DsheapmergeableSeries) -> Double { @_common.median(self.vals) }

pub fn DsheapmergeableSeries::scale(self : DsheapmergeableSeries, f : Double) -> DsheapmergeableSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheapmergeableSeries::add(self : DsheapmergeableSeries, other : DsheapmergeableSeries) -> DsheapmergeableSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheapmergeableSeries::sub(self : DsheapmergeableSeries, other : DsheapmergeableSeries) -> DsheapmergeableSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheapmergeableSeries::normalize(self : DsheapmergeableSeries) -> DsheapmergeableSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheapmergeableSeries::cumsum(self : DsheapmergeableSeries) -> DsheapmergeableSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheapmergeableSeries::to_string(self : DsheapmergeableSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapmergeableMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_mergeable_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapmergeableMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_mergeable_matrix_identity(n : Int) -> DsheapmergeableMatrix {
  let m = ds_heap_mergeable_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheapmergeableMatrix::get(self : DsheapmergeableMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheapmergeableMatrix::transpose(self : DsheapmergeableMatrix) -> DsheapmergeableMatrix {
  let result = ds_heap_mergeable_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheapmergeableMatrix::add(self : DsheapmergeableMatrix, other : DsheapmergeableMatrix) -> DsheapmergeableMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_mergeable_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheapmergeableMatrix::scale(self : DsheapmergeableMatrix, s : Double) -> DsheapmergeableMatrix {
  let result = ds_heap_mergeable_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheapmergeableMatrix::multiply(self : DsheapmergeableMatrix, other : DsheapmergeableMatrix) -> DsheapmergeableMatrix {
  if self.cols != other.rows { return ds_heap_mergeable_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_mergeable_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsheapmergeableMatrix::trace(self : DsheapmergeableMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheapmergeableMatrix::det(self : DsheapmergeableMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheapmergeableMatrix::norm(self : DsheapmergeableMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheapmergeableMatrix::to_string(self : DsheapmergeableMatrix) -> String {
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

pub(all) struct DsheapmergeableVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_mergeable_make_vector(comps : Array[Double]) -> DsheapmergeableVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_mergeable_vector_zero(dim : Int) -> DsheapmergeableVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheapmergeableVector::add(self : DsheapmergeableVector, other : DsheapmergeableVector) -> DsheapmergeableVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapmergeableVector::sub(self : DsheapmergeableVector, other : DsheapmergeableVector) -> DsheapmergeableVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapmergeableVector::scale(self : DsheapmergeableVector, s : Double) -> DsheapmergeableVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheapmergeableVector::dot(self : DsheapmergeableVector, other : DsheapmergeableVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheapmergeableVector::norm(self : DsheapmergeableVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheapmergeableVector::normalize(self : DsheapmergeableVector) -> DsheapmergeableVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapmergeableVector::dist(self : DsheapmergeableVector, other : DsheapmergeableVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheapmergeableVector::to_string(self : DsheapmergeableVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_mergeable_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_mergeable_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_mergeable_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_mergeable_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_mergeable_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_mergeable_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_mergeable_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_mergeable_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_mergeable_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_mergeable_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_mergeable_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_mergeable_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_mergeable_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_mergeable_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_mergeable_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_mergeable_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_mergeable_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_mergeable_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_mergeable_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_mergeable_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_mergeable_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_mergeable_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_mergeable_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_mergeable_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_mergeable_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_mergeable_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_mergeable_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_mergeable_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_mergeable_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapmergeableFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_frame_make(size : Int) -> DsheapmergeableFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_frame_len(s : DsheapmergeableFrame) -> Int { s.size }

pub fn ds_heap_mergeable_frame_get(s : DsheapmergeableFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_frame_set(s : DsheapmergeableFrame, i : Int, v : Double) -> DsheapmergeableFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_frame_sum(s : DsheapmergeableFrame) -> Double { @_common.sum(s.data) }

pub fn ds_heap_mergeable_frame_mean(s : DsheapmergeableFrame) -> Double { @_common.mean(s.data) }

pub fn ds_heap_mergeable_frame_scale(s : DsheapmergeableFrame, f : Double) -> DsheapmergeableFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_frame_add(a : DsheapmergeableFrame, b : DsheapmergeableFrame) -> DsheapmergeableFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_mergeable_frame_copy(s : DsheapmergeableFrame) -> DsheapmergeableFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_frame_fill(s : DsheapmergeableFrame, v : Double) -> DsheapmergeableFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_frame_min(s : DsheapmergeableFrame) -> Double { @_common.min(s.data) }

pub fn ds_heap_mergeable_frame_max(s : DsheapmergeableFrame) -> Double { @_common.max(s.data) }

pub fn ds_heap_mergeable_frame_to_string(s : DsheapmergeableFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_table_make(size : Int) -> DsheapmergeableTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_table_len(s : DsheapmergeableTable) -> Int { s.size }

pub fn ds_heap_mergeable_table_get(s : DsheapmergeableTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_table_set(s : DsheapmergeableTable, i : Int, v : Double) -> DsheapmergeableTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_table_sum(s : DsheapmergeableTable) -> Double { @_common.sum(s.data) }

pub fn ds_heap_mergeable_table_mean(s : DsheapmergeableTable) -> Double { @_common.mean(s.data) }

pub fn ds_heap_mergeable_table_scale(s : DsheapmergeableTable, f : Double) -> DsheapmergeableTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_table_add(a : DsheapmergeableTable, b : DsheapmergeableTable) -> DsheapmergeableTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_mergeable_table_copy(s : DsheapmergeableTable) -> DsheapmergeableTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_table_fill(s : DsheapmergeableTable, v : Double) -> DsheapmergeableTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_table_min(s : DsheapmergeableTable) -> Double { @_common.min(s.data) }

pub fn ds_heap_mergeable_table_max(s : DsheapmergeableTable) -> Double { @_common.max(s.data) }

pub fn ds_heap_mergeable_table_to_string(s : DsheapmergeableTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_graphn_make(size : Int) -> DsheapmergeableGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_graphn_len(s : DsheapmergeableGraphN) -> Int { s.size }

pub fn ds_heap_mergeable_graphn_get(s : DsheapmergeableGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_graphn_set(s : DsheapmergeableGraphN, i : Int, v : Double) -> DsheapmergeableGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_graphn_sum(s : DsheapmergeableGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_heap_mergeable_graphn_mean(s : DsheapmergeableGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_heap_mergeable_graphn_scale(s : DsheapmergeableGraphN, f : Double) -> DsheapmergeableGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_graphn_add(a : DsheapmergeableGraphN, b : DsheapmergeableGraphN) -> DsheapmergeableGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_mergeable_graphn_copy(s : DsheapmergeableGraphN) -> DsheapmergeableGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_graphn_fill(s : DsheapmergeableGraphN, v : Double) -> DsheapmergeableGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_graphn_min(s : DsheapmergeableGraphN) -> Double { @_common.min(s.data) }

pub fn ds_heap_mergeable_graphn_max(s : DsheapmergeableGraphN) -> Double { @_common.max(s.data) }

pub fn ds_heap_mergeable_graphn_to_string(s : DsheapmergeableGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_node_make(size : Int) -> DsheapmergeableNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_node_len(s : DsheapmergeableNode) -> Int { s.size }

pub fn ds_heap_mergeable_node_get(s : DsheapmergeableNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_node_set(s : DsheapmergeableNode, i : Int, v : Double) -> DsheapmergeableNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_node_sum(s : DsheapmergeableNode) -> Double { @_common.sum(s.data) }

pub fn ds_heap_mergeable_node_mean(s : DsheapmergeableNode) -> Double { @_common.mean(s.data) }

pub fn ds_heap_mergeable_node_scale(s : DsheapmergeableNode, f : Double) -> DsheapmergeableNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_node_add(a : DsheapmergeableNode, b : DsheapmergeableNode) -> DsheapmergeableNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_mergeable_node_copy(s : DsheapmergeableNode) -> DsheapmergeableNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_node_fill(s : DsheapmergeableNode, v : Double) -> DsheapmergeableNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_node_min(s : DsheapmergeableNode) -> Double { @_common.min(s.data) }

pub fn ds_heap_mergeable_node_max(s : DsheapmergeableNode) -> Double { @_common.max(s.data) }

pub fn ds_heap_mergeable_node_to_string(s : DsheapmergeableNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_edge_make(size : Int) -> DsheapmergeableEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_edge_len(s : DsheapmergeableEdge) -> Int { s.size }

pub fn ds_heap_mergeable_edge_get(s : DsheapmergeableEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_edge_set(s : DsheapmergeableEdge, i : Int, v : Double) -> DsheapmergeableEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_edge_sum(s : DsheapmergeableEdge) -> Double { @_common.sum(s.data) }

pub fn ds_heap_mergeable_edge_mean(s : DsheapmergeableEdge) -> Double { @_common.mean(s.data) }

pub fn ds_heap_mergeable_edge_scale(s : DsheapmergeableEdge, f : Double) -> DsheapmergeableEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_edge_add(a : DsheapmergeableEdge, b : DsheapmergeableEdge) -> DsheapmergeableEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_mergeable_edge_copy(s : DsheapmergeableEdge) -> DsheapmergeableEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_edge_fill(s : DsheapmergeableEdge, v : Double) -> DsheapmergeableEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_edge_min(s : DsheapmergeableEdge) -> Double { @_common.min(s.data) }

pub fn ds_heap_mergeable_edge_max(s : DsheapmergeableEdge) -> Double { @_common.max(s.data) }

pub fn ds_heap_mergeable_edge_to_string(s : DsheapmergeableEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeablePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_path_make(size : Int) -> DsheapmergeablePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_path_len(s : DsheapmergeablePath) -> Int { s.size }

pub fn ds_heap_mergeable_path_get(s : DsheapmergeablePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_path_set(s : DsheapmergeablePath, i : Int, v : Double) -> DsheapmergeablePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_path_sum(s : DsheapmergeablePath) -> Double { @_common.sum(s.data) }

pub fn ds_heap_mergeable_path_mean(s : DsheapmergeablePath) -> Double { @_common.mean(s.data) }

pub fn ds_heap_mergeable_path_scale(s : DsheapmergeablePath, f : Double) -> DsheapmergeablePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_path_add(a : DsheapmergeablePath, b : DsheapmergeablePath) -> DsheapmergeablePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_mergeable_path_copy(s : DsheapmergeablePath) -> DsheapmergeablePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_path_fill(s : DsheapmergeablePath, v : Double) -> DsheapmergeablePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_path_min(s : DsheapmergeablePath) -> Double { @_common.min(s.data) }

pub fn ds_heap_mergeable_path_max(s : DsheapmergeablePath) -> Double { @_common.max(s.data) }

pub fn ds_heap_mergeable_path_to_string(s : DsheapmergeablePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_cluster_make(size : Int) -> DsheapmergeableCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_cluster_len(s : DsheapmergeableCluster) -> Int { s.size }

pub fn ds_heap_mergeable_cluster_get(s : DsheapmergeableCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_cluster_set(s : DsheapmergeableCluster, i : Int, v : Double) -> DsheapmergeableCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_cluster_sum(s : DsheapmergeableCluster) -> Double { @_common.sum(s.data) }

pub fn ds_heap_mergeable_cluster_mean(s : DsheapmergeableCluster) -> Double { @_common.mean(s.data) }

pub fn ds_heap_mergeable_cluster_scale(s : DsheapmergeableCluster, f : Double) -> DsheapmergeableCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_cluster_add(a : DsheapmergeableCluster, b : DsheapmergeableCluster) -> DsheapmergeableCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_mergeable_cluster_copy(s : DsheapmergeableCluster) -> DsheapmergeableCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_cluster_fill(s : DsheapmergeableCluster, v : Double) -> DsheapmergeableCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_cluster_min(s : DsheapmergeableCluster) -> Double { @_common.min(s.data) }

pub fn ds_heap_mergeable_cluster_max(s : DsheapmergeableCluster) -> Double { @_common.max(s.data) }

pub fn ds_heap_mergeable_cluster_to_string(s : DsheapmergeableCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_model_make(size : Int) -> DsheapmergeableModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_model_len(s : DsheapmergeableModel) -> Int { s.size }

pub fn ds_heap_mergeable_model_get(s : DsheapmergeableModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_model_set(s : DsheapmergeableModel, i : Int, v : Double) -> DsheapmergeableModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_model_sum(s : DsheapmergeableModel) -> Double { @_common.sum(s.data) }

pub fn ds_heap_mergeable_model_mean(s : DsheapmergeableModel) -> Double { @_common.mean(s.data) }

pub fn ds_heap_mergeable_model_scale(s : DsheapmergeableModel, f : Double) -> DsheapmergeableModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_model_add(a : DsheapmergeableModel, b : DsheapmergeableModel) -> DsheapmergeableModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_mergeable_model_copy(s : DsheapmergeableModel) -> DsheapmergeableModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_model_fill(s : DsheapmergeableModel, v : Double) -> DsheapmergeableModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_model_min(s : DsheapmergeableModel) -> Double { @_common.min(s.data) }

pub fn ds_heap_mergeable_model_max(s : DsheapmergeableModel) -> Double { @_common.max(s.data) }

pub fn ds_heap_mergeable_model_to_string(s : DsheapmergeableModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_layer_make(size : Int) -> DsheapmergeableLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_layer_len(s : DsheapmergeableLayer) -> Int { s.size }

pub fn ds_heap_mergeable_layer_get(s : DsheapmergeableLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_layer_set(s : DsheapmergeableLayer, i : Int, v : Double) -> DsheapmergeableLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_layer_sum(s : DsheapmergeableLayer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_mergeable_layer_mean(s : DsheapmergeableLayer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_mergeable_layer_scale(s : DsheapmergeableLayer, f : Double) -> DsheapmergeableLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_layer_add(a : DsheapmergeableLayer, b : DsheapmergeableLayer) -> DsheapmergeableLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_mergeable_layer_copy(s : DsheapmergeableLayer) -> DsheapmergeableLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_layer_fill(s : DsheapmergeableLayer, v : Double) -> DsheapmergeableLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_layer_min(s : DsheapmergeableLayer) -> Double { @_common.min(s.data) }

pub fn ds_heap_mergeable_layer_max(s : DsheapmergeableLayer) -> Double { @_common.max(s.data) }

pub fn ds_heap_mergeable_layer_to_string(s : DsheapmergeableLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_buffer_make(size : Int) -> DsheapmergeableBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_buffer_len(s : DsheapmergeableBuffer) -> Int { s.size }

pub fn ds_heap_mergeable_buffer_get(s : DsheapmergeableBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_buffer_set(s : DsheapmergeableBuffer, i : Int, v : Double) -> DsheapmergeableBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_buffer_sum(s : DsheapmergeableBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_mergeable_buffer_mean(s : DsheapmergeableBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_mergeable_buffer_scale(s : DsheapmergeableBuffer, f : Double) -> DsheapmergeableBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_buffer_add(a : DsheapmergeableBuffer, b : DsheapmergeableBuffer) -> DsheapmergeableBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_mergeable_buffer_copy(s : DsheapmergeableBuffer) -> DsheapmergeableBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_buffer_fill(s : DsheapmergeableBuffer, v : Double) -> DsheapmergeableBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_buffer_min(s : DsheapmergeableBuffer) -> Double { @_common.min(s.data) }

pub fn ds_heap_mergeable_buffer_max(s : DsheapmergeableBuffer) -> Double { @_common.max(s.data) }

pub fn ds_heap_mergeable_buffer_to_string(s : DsheapmergeableBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_cursor_make(size : Int) -> DsheapmergeableCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_cursor_len(s : DsheapmergeableCursor) -> Int { s.size }

pub fn ds_heap_mergeable_cursor_get(s : DsheapmergeableCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_cursor_set(s : DsheapmergeableCursor, i : Int, v : Double) -> DsheapmergeableCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_cursor_sum(s : DsheapmergeableCursor) -> Double { @_common.sum(s.data) }

pub fn ds_heap_mergeable_cursor_mean(s : DsheapmergeableCursor) -> Double { @_common.mean(s.data) }

pub fn ds_heap_mergeable_cursor_scale(s : DsheapmergeableCursor, f : Double) -> DsheapmergeableCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_cursor_add(a : DsheapmergeableCursor, b : DsheapmergeableCursor) -> DsheapmergeableCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_mergeable_cursor_copy(s : DsheapmergeableCursor) -> DsheapmergeableCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_cursor_fill(s : DsheapmergeableCursor, v : Double) -> DsheapmergeableCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_cursor_min(s : DsheapmergeableCursor) -> Double { @_common.min(s.data) }

pub fn ds_heap_mergeable_cursor_max(s : DsheapmergeableCursor) -> Double { @_common.max(s.data) }

pub fn ds_heap_mergeable_cursor_to_string(s : DsheapmergeableCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_view_make(size : Int) -> DsheapmergeableView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_view_len(s : DsheapmergeableView) -> Int { s.size }

pub fn ds_heap_mergeable_view_get(s : DsheapmergeableView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_view_set(s : DsheapmergeableView, i : Int, v : Double) -> DsheapmergeableView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_view_sum(s : DsheapmergeableView) -> Double { @_common.sum(s.data) }

pub fn ds_heap_mergeable_view_mean(s : DsheapmergeableView) -> Double { @_common.mean(s.data) }

pub fn ds_heap_mergeable_view_scale(s : DsheapmergeableView, f : Double) -> DsheapmergeableView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_view_add(a : DsheapmergeableView, b : DsheapmergeableView) -> DsheapmergeableView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_mergeable_view_copy(s : DsheapmergeableView) -> DsheapmergeableView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_view_fill(s : DsheapmergeableView, v : Double) -> DsheapmergeableView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_view_min(s : DsheapmergeableView) -> Double { @_common.min(s.data) }

pub fn ds_heap_mergeable_view_max(s : DsheapmergeableView) -> Double { @_common.max(s.data) }

pub fn ds_heap_mergeable_view_to_string(s : DsheapmergeableView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_range_make(size : Int) -> DsheapmergeableRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_range_len(s : DsheapmergeableRange) -> Int { s.size }

pub fn ds_heap_mergeable_range_get(s : DsheapmergeableRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_range_set(s : DsheapmergeableRange, i : Int, v : Double) -> DsheapmergeableRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_range_sum(s : DsheapmergeableRange) -> Double { @_common.sum(s.data) }

pub fn ds_heap_mergeable_range_mean(s : DsheapmergeableRange) -> Double { @_common.mean(s.data) }

pub fn ds_heap_mergeable_range_scale(s : DsheapmergeableRange, f : Double) -> DsheapmergeableRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_range_add(a : DsheapmergeableRange, b : DsheapmergeableRange) -> DsheapmergeableRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_mergeable_range_copy(s : DsheapmergeableRange) -> DsheapmergeableRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_range_fill(s : DsheapmergeableRange, v : Double) -> DsheapmergeableRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_range_min(s : DsheapmergeableRange) -> Double { @_common.min(s.data) }

pub fn ds_heap_mergeable_range_max(s : DsheapmergeableRange) -> Double { @_common.max(s.data) }

pub fn ds_heap_mergeable_range_to_string(s : DsheapmergeableRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapmergeableSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_mergeable_slice_make(size : Int) -> DsheapmergeableSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_mergeable_slice_len(s : DsheapmergeableSlice) -> Int { s.size }

pub fn ds_heap_mergeable_slice_get(s : DsheapmergeableSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_mergeable_slice_set(s : DsheapmergeableSlice, i : Int, v : Double) -> DsheapmergeableSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_slice_sum(s : DsheapmergeableSlice) -> Double { @_common.sum(s.data) }

pub fn ds_heap_mergeable_slice_mean(s : DsheapmergeableSlice) -> Double { @_common.mean(s.data) }

pub fn ds_heap_mergeable_slice_scale(s : DsheapmergeableSlice, f : Double) -> DsheapmergeableSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_slice_add(a : DsheapmergeableSlice, b : DsheapmergeableSlice) -> DsheapmergeableSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_mergeable_slice_copy(s : DsheapmergeableSlice) -> DsheapmergeableSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_slice_fill(s : DsheapmergeableSlice, v : Double) -> DsheapmergeableSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_mergeable_slice_min(s : DsheapmergeableSlice) -> Double { @_common.min(s.data) }

pub fn ds_heap_mergeable_slice_max(s : DsheapmergeableSlice) -> Double { @_common.max(s.data) }

pub fn ds_heap_mergeable_slice_to_string(s : DsheapmergeableSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

