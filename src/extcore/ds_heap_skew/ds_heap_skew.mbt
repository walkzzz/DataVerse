///===
/// extcore/ds_heap_skew

pub(all) struct DsheapskewPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_skew_make_point(x : Double, y : Double) -> DsheapskewPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_skew_make_point3(x : Double, y : Double, z : Double) -> DsheapskewPoint {
  { x, y, z, label: 0 }
}

pub fn DsheapskewPoint::x(self : DsheapskewPoint) -> Double { self.x }

pub fn DsheapskewPoint::y(self : DsheapskewPoint) -> Double { self.y }

pub fn DsheapskewPoint::z(self : DsheapskewPoint) -> Double { self.z }

pub fn DsheapskewPoint::label(self : DsheapskewPoint) -> Int { self.label }

pub fn DsheapskewPoint::dist(self : DsheapskewPoint, other : DsheapskewPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheapskewPoint::add(self : DsheapskewPoint, other : DsheapskewPoint) -> DsheapskewPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheapskewPoint::sub(self : DsheapskewPoint, other : DsheapskewPoint) -> DsheapskewPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheapskewPoint::scale(self : DsheapskewPoint, s : Double) -> DsheapskewPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheapskewPoint::dot(self : DsheapskewPoint, other : DsheapskewPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheapskewPoint::cross(self : DsheapskewPoint, other : DsheapskewPoint) -> DsheapskewPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheapskewPoint::norm(self : DsheapskewPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheapskewPoint::normalize(self : DsheapskewPoint) -> DsheapskewPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapskewPoint::negate(self : DsheapskewPoint) -> DsheapskewPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheapskewPoint::mid(self : DsheapskewPoint, other : DsheapskewPoint) -> DsheapskewPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheapskewPoint::lerp(self : DsheapskewPoint, other : DsheapskewPoint, t : Double) -> DsheapskewPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheapskewPoint::to_string(self : DsheapskewPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheapskewSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_skew_make_series(vals : Array[Double], name : String) -> DsheapskewSeries {
  { vals, name, meta: 0 }
}

pub fn DsheapskewSeries::len(self : DsheapskewSeries) -> Int { self.vals.length() }

pub fn DsheapskewSeries::sum(self : DsheapskewSeries) -> Double { @_common.sum(self.vals) }

pub fn DsheapskewSeries::mean(self : DsheapskewSeries) -> Double { @_common.mean(self.vals) }

pub fn DsheapskewSeries::min(self : DsheapskewSeries) -> Double { @_common.min(self.vals) }

pub fn DsheapskewSeries::max(self : DsheapskewSeries) -> Double { @_common.max(self.vals) }

pub fn DsheapskewSeries::range(self : DsheapskewSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheapskewSeries::variance(self : DsheapskewSeries) -> Double { @_common.variance(self.vals) }

pub fn DsheapskewSeries::std(self : DsheapskewSeries) -> Double { @_common.std(self.vals) }

pub fn DsheapskewSeries::median(self : DsheapskewSeries) -> Double { @_common.median(self.vals) }

pub fn DsheapskewSeries::scale(self : DsheapskewSeries, f : Double) -> DsheapskewSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheapskewSeries::add(self : DsheapskewSeries, other : DsheapskewSeries) -> DsheapskewSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheapskewSeries::sub(self : DsheapskewSeries, other : DsheapskewSeries) -> DsheapskewSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheapskewSeries::normalize(self : DsheapskewSeries) -> DsheapskewSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheapskewSeries::cumsum(self : DsheapskewSeries) -> DsheapskewSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheapskewSeries::to_string(self : DsheapskewSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapskewMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_skew_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapskewMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_skew_matrix_identity(n : Int) -> DsheapskewMatrix {
  let m = ds_heap_skew_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheapskewMatrix::get(self : DsheapskewMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheapskewMatrix::transpose(self : DsheapskewMatrix) -> DsheapskewMatrix {
  let result = ds_heap_skew_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheapskewMatrix::add(self : DsheapskewMatrix, other : DsheapskewMatrix) -> DsheapskewMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_skew_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheapskewMatrix::scale(self : DsheapskewMatrix, s : Double) -> DsheapskewMatrix {
  let result = ds_heap_skew_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheapskewMatrix::multiply(self : DsheapskewMatrix, other : DsheapskewMatrix) -> DsheapskewMatrix {
  if self.cols != other.rows { return ds_heap_skew_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_skew_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsheapskewMatrix::trace(self : DsheapskewMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheapskewMatrix::det(self : DsheapskewMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheapskewMatrix::norm(self : DsheapskewMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheapskewMatrix::to_string(self : DsheapskewMatrix) -> String {
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

pub(all) struct DsheapskewVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_skew_make_vector(comps : Array[Double]) -> DsheapskewVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_skew_vector_zero(dim : Int) -> DsheapskewVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheapskewVector::add(self : DsheapskewVector, other : DsheapskewVector) -> DsheapskewVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapskewVector::sub(self : DsheapskewVector, other : DsheapskewVector) -> DsheapskewVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapskewVector::scale(self : DsheapskewVector, s : Double) -> DsheapskewVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheapskewVector::dot(self : DsheapskewVector, other : DsheapskewVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheapskewVector::norm(self : DsheapskewVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheapskewVector::normalize(self : DsheapskewVector) -> DsheapskewVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapskewVector::dist(self : DsheapskewVector, other : DsheapskewVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheapskewVector::to_string(self : DsheapskewVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_skew_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_skew_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_skew_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_skew_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_skew_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_skew_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_skew_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_skew_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_skew_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_skew_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_skew_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_skew_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_skew_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_skew_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_skew_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_skew_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_skew_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_skew_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_skew_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_skew_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_skew_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_skew_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_skew_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_skew_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_skew_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_skew_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_skew_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_skew_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_skew_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapskewFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_frame_make(size : Int) -> DsheapskewFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_frame_len(s : DsheapskewFrame) -> Int { s.size }

pub fn ds_heap_skew_frame_get(s : DsheapskewFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_frame_set(s : DsheapskewFrame, i : Int, v : Double) -> DsheapskewFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_frame_sum(s : DsheapskewFrame) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_frame_mean(s : DsheapskewFrame) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_frame_scale(s : DsheapskewFrame, f : Double) -> DsheapskewFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_frame_add(a : DsheapskewFrame, b : DsheapskewFrame) -> DsheapskewFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_frame_copy(s : DsheapskewFrame) -> DsheapskewFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_frame_fill(s : DsheapskewFrame, v : Double) -> DsheapskewFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_frame_min(s : DsheapskewFrame) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_frame_max(s : DsheapskewFrame) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_frame_to_string(s : DsheapskewFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_table_make(size : Int) -> DsheapskewTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_table_len(s : DsheapskewTable) -> Int { s.size }

pub fn ds_heap_skew_table_get(s : DsheapskewTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_table_set(s : DsheapskewTable, i : Int, v : Double) -> DsheapskewTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_table_sum(s : DsheapskewTable) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_table_mean(s : DsheapskewTable) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_table_scale(s : DsheapskewTable, f : Double) -> DsheapskewTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_table_add(a : DsheapskewTable, b : DsheapskewTable) -> DsheapskewTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_table_copy(s : DsheapskewTable) -> DsheapskewTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_table_fill(s : DsheapskewTable, v : Double) -> DsheapskewTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_table_min(s : DsheapskewTable) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_table_max(s : DsheapskewTable) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_table_to_string(s : DsheapskewTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_graphn_make(size : Int) -> DsheapskewGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_graphn_len(s : DsheapskewGraphN) -> Int { s.size }

pub fn ds_heap_skew_graphn_get(s : DsheapskewGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_graphn_set(s : DsheapskewGraphN, i : Int, v : Double) -> DsheapskewGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_graphn_sum(s : DsheapskewGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_graphn_mean(s : DsheapskewGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_graphn_scale(s : DsheapskewGraphN, f : Double) -> DsheapskewGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_graphn_add(a : DsheapskewGraphN, b : DsheapskewGraphN) -> DsheapskewGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_graphn_copy(s : DsheapskewGraphN) -> DsheapskewGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_graphn_fill(s : DsheapskewGraphN, v : Double) -> DsheapskewGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_graphn_min(s : DsheapskewGraphN) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_graphn_max(s : DsheapskewGraphN) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_graphn_to_string(s : DsheapskewGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_node_make(size : Int) -> DsheapskewNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_node_len(s : DsheapskewNode) -> Int { s.size }

pub fn ds_heap_skew_node_get(s : DsheapskewNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_node_set(s : DsheapskewNode, i : Int, v : Double) -> DsheapskewNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_node_sum(s : DsheapskewNode) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_node_mean(s : DsheapskewNode) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_node_scale(s : DsheapskewNode, f : Double) -> DsheapskewNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_node_add(a : DsheapskewNode, b : DsheapskewNode) -> DsheapskewNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_node_copy(s : DsheapskewNode) -> DsheapskewNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_node_fill(s : DsheapskewNode, v : Double) -> DsheapskewNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_node_min(s : DsheapskewNode) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_node_max(s : DsheapskewNode) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_node_to_string(s : DsheapskewNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_edge_make(size : Int) -> DsheapskewEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_edge_len(s : DsheapskewEdge) -> Int { s.size }

pub fn ds_heap_skew_edge_get(s : DsheapskewEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_edge_set(s : DsheapskewEdge, i : Int, v : Double) -> DsheapskewEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_edge_sum(s : DsheapskewEdge) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_edge_mean(s : DsheapskewEdge) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_edge_scale(s : DsheapskewEdge, f : Double) -> DsheapskewEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_edge_add(a : DsheapskewEdge, b : DsheapskewEdge) -> DsheapskewEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_edge_copy(s : DsheapskewEdge) -> DsheapskewEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_edge_fill(s : DsheapskewEdge, v : Double) -> DsheapskewEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_edge_min(s : DsheapskewEdge) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_edge_max(s : DsheapskewEdge) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_edge_to_string(s : DsheapskewEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_path_make(size : Int) -> DsheapskewPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_path_len(s : DsheapskewPath) -> Int { s.size }

pub fn ds_heap_skew_path_get(s : DsheapskewPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_path_set(s : DsheapskewPath, i : Int, v : Double) -> DsheapskewPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_path_sum(s : DsheapskewPath) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_path_mean(s : DsheapskewPath) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_path_scale(s : DsheapskewPath, f : Double) -> DsheapskewPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_path_add(a : DsheapskewPath, b : DsheapskewPath) -> DsheapskewPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_path_copy(s : DsheapskewPath) -> DsheapskewPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_path_fill(s : DsheapskewPath, v : Double) -> DsheapskewPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_path_min(s : DsheapskewPath) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_path_max(s : DsheapskewPath) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_path_to_string(s : DsheapskewPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_cluster_make(size : Int) -> DsheapskewCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_cluster_len(s : DsheapskewCluster) -> Int { s.size }

pub fn ds_heap_skew_cluster_get(s : DsheapskewCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_cluster_set(s : DsheapskewCluster, i : Int, v : Double) -> DsheapskewCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_cluster_sum(s : DsheapskewCluster) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_cluster_mean(s : DsheapskewCluster) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_cluster_scale(s : DsheapskewCluster, f : Double) -> DsheapskewCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_cluster_add(a : DsheapskewCluster, b : DsheapskewCluster) -> DsheapskewCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_cluster_copy(s : DsheapskewCluster) -> DsheapskewCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_cluster_fill(s : DsheapskewCluster, v : Double) -> DsheapskewCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_cluster_min(s : DsheapskewCluster) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_cluster_max(s : DsheapskewCluster) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_cluster_to_string(s : DsheapskewCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_model_make(size : Int) -> DsheapskewModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_model_len(s : DsheapskewModel) -> Int { s.size }

pub fn ds_heap_skew_model_get(s : DsheapskewModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_model_set(s : DsheapskewModel, i : Int, v : Double) -> DsheapskewModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_model_sum(s : DsheapskewModel) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_model_mean(s : DsheapskewModel) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_model_scale(s : DsheapskewModel, f : Double) -> DsheapskewModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_model_add(a : DsheapskewModel, b : DsheapskewModel) -> DsheapskewModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_model_copy(s : DsheapskewModel) -> DsheapskewModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_model_fill(s : DsheapskewModel, v : Double) -> DsheapskewModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_model_min(s : DsheapskewModel) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_model_max(s : DsheapskewModel) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_model_to_string(s : DsheapskewModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_layer_make(size : Int) -> DsheapskewLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_layer_len(s : DsheapskewLayer) -> Int { s.size }

pub fn ds_heap_skew_layer_get(s : DsheapskewLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_layer_set(s : DsheapskewLayer, i : Int, v : Double) -> DsheapskewLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_layer_sum(s : DsheapskewLayer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_layer_mean(s : DsheapskewLayer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_layer_scale(s : DsheapskewLayer, f : Double) -> DsheapskewLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_layer_add(a : DsheapskewLayer, b : DsheapskewLayer) -> DsheapskewLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_layer_copy(s : DsheapskewLayer) -> DsheapskewLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_layer_fill(s : DsheapskewLayer, v : Double) -> DsheapskewLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_layer_min(s : DsheapskewLayer) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_layer_max(s : DsheapskewLayer) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_layer_to_string(s : DsheapskewLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_buffer_make(size : Int) -> DsheapskewBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_buffer_len(s : DsheapskewBuffer) -> Int { s.size }

pub fn ds_heap_skew_buffer_get(s : DsheapskewBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_buffer_set(s : DsheapskewBuffer, i : Int, v : Double) -> DsheapskewBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_buffer_sum(s : DsheapskewBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_buffer_mean(s : DsheapskewBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_buffer_scale(s : DsheapskewBuffer, f : Double) -> DsheapskewBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_buffer_add(a : DsheapskewBuffer, b : DsheapskewBuffer) -> DsheapskewBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_buffer_copy(s : DsheapskewBuffer) -> DsheapskewBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_buffer_fill(s : DsheapskewBuffer, v : Double) -> DsheapskewBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_buffer_min(s : DsheapskewBuffer) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_buffer_max(s : DsheapskewBuffer) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_buffer_to_string(s : DsheapskewBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_cursor_make(size : Int) -> DsheapskewCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_cursor_len(s : DsheapskewCursor) -> Int { s.size }

pub fn ds_heap_skew_cursor_get(s : DsheapskewCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_cursor_set(s : DsheapskewCursor, i : Int, v : Double) -> DsheapskewCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_cursor_sum(s : DsheapskewCursor) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_cursor_mean(s : DsheapskewCursor) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_cursor_scale(s : DsheapskewCursor, f : Double) -> DsheapskewCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_cursor_add(a : DsheapskewCursor, b : DsheapskewCursor) -> DsheapskewCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_cursor_copy(s : DsheapskewCursor) -> DsheapskewCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_cursor_fill(s : DsheapskewCursor, v : Double) -> DsheapskewCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_cursor_min(s : DsheapskewCursor) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_cursor_max(s : DsheapskewCursor) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_cursor_to_string(s : DsheapskewCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_view_make(size : Int) -> DsheapskewView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_view_len(s : DsheapskewView) -> Int { s.size }

pub fn ds_heap_skew_view_get(s : DsheapskewView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_view_set(s : DsheapskewView, i : Int, v : Double) -> DsheapskewView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_view_sum(s : DsheapskewView) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_view_mean(s : DsheapskewView) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_view_scale(s : DsheapskewView, f : Double) -> DsheapskewView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_view_add(a : DsheapskewView, b : DsheapskewView) -> DsheapskewView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_view_copy(s : DsheapskewView) -> DsheapskewView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_view_fill(s : DsheapskewView, v : Double) -> DsheapskewView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_view_min(s : DsheapskewView) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_view_max(s : DsheapskewView) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_view_to_string(s : DsheapskewView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_range_make(size : Int) -> DsheapskewRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_range_len(s : DsheapskewRange) -> Int { s.size }

pub fn ds_heap_skew_range_get(s : DsheapskewRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_range_set(s : DsheapskewRange, i : Int, v : Double) -> DsheapskewRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_range_sum(s : DsheapskewRange) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_range_mean(s : DsheapskewRange) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_range_scale(s : DsheapskewRange, f : Double) -> DsheapskewRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_range_add(a : DsheapskewRange, b : DsheapskewRange) -> DsheapskewRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_range_copy(s : DsheapskewRange) -> DsheapskewRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_range_fill(s : DsheapskewRange, v : Double) -> DsheapskewRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_range_min(s : DsheapskewRange) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_range_max(s : DsheapskewRange) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_range_to_string(s : DsheapskewRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapskewSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_slice_make(size : Int) -> DsheapskewSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_skew_slice_len(s : DsheapskewSlice) -> Int { s.size }

pub fn ds_heap_skew_slice_get(s : DsheapskewSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_skew_slice_set(s : DsheapskewSlice, i : Int, v : Double) -> DsheapskewSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_slice_sum(s : DsheapskewSlice) -> Double { @_common.sum(s.data) }

pub fn ds_heap_skew_slice_mean(s : DsheapskewSlice) -> Double { @_common.mean(s.data) }

pub fn ds_heap_skew_slice_scale(s : DsheapskewSlice, f : Double) -> DsheapskewSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_slice_add(a : DsheapskewSlice, b : DsheapskewSlice) -> DsheapskewSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_skew_slice_copy(s : DsheapskewSlice) -> DsheapskewSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_slice_fill(s : DsheapskewSlice, v : Double) -> DsheapskewSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_skew_slice_min(s : DsheapskewSlice) -> Double { @_common.min(s.data) }

pub fn ds_heap_skew_slice_max(s : DsheapskewSlice) -> Double { @_common.max(s.data) }

pub fn ds_heap_skew_slice_to_string(s : DsheapskewSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

