///===
/// extcore/ds_heap_interval

pub(all) struct DsheapintervalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_interval_make_point(x : Double, y : Double) -> DsheapintervalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_interval_make_point3(x : Double, y : Double, z : Double) -> DsheapintervalPoint {
  { x, y, z, label: 0 }
}

pub fn DsheapintervalPoint::x(self : DsheapintervalPoint) -> Double { self.x }

pub fn DsheapintervalPoint::y(self : DsheapintervalPoint) -> Double { self.y }

pub fn DsheapintervalPoint::z(self : DsheapintervalPoint) -> Double { self.z }

pub fn DsheapintervalPoint::label(self : DsheapintervalPoint) -> Int { self.label }

pub fn DsheapintervalPoint::dist(self : DsheapintervalPoint, other : DsheapintervalPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheapintervalPoint::add(self : DsheapintervalPoint, other : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheapintervalPoint::sub(self : DsheapintervalPoint, other : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheapintervalPoint::scale(self : DsheapintervalPoint, s : Double) -> DsheapintervalPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheapintervalPoint::dot(self : DsheapintervalPoint, other : DsheapintervalPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheapintervalPoint::cross(self : DsheapintervalPoint, other : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheapintervalPoint::norm(self : DsheapintervalPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheapintervalPoint::normalize(self : DsheapintervalPoint) -> DsheapintervalPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapintervalPoint::negate(self : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheapintervalPoint::mid(self : DsheapintervalPoint, other : DsheapintervalPoint) -> DsheapintervalPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheapintervalPoint::lerp(self : DsheapintervalPoint, other : DsheapintervalPoint, t : Double) -> DsheapintervalPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheapintervalPoint::to_string(self : DsheapintervalPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheapintervalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_interval_make_series(vals : Array[Double], name : String) -> DsheapintervalSeries {
  { vals, name, meta: 0 }
}

pub fn DsheapintervalSeries::len(self : DsheapintervalSeries) -> Int { self.vals.length() }

pub fn DsheapintervalSeries::sum(self : DsheapintervalSeries) -> Double { @_common.sum(self.vals) }

pub fn DsheapintervalSeries::mean(self : DsheapintervalSeries) -> Double { @_common.mean(self.vals) }

pub fn DsheapintervalSeries::min(self : DsheapintervalSeries) -> Double { @_common.min(self.vals) }

pub fn DsheapintervalSeries::max(self : DsheapintervalSeries) -> Double { @_common.max(self.vals) }

pub fn DsheapintervalSeries::range(self : DsheapintervalSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheapintervalSeries::variance(self : DsheapintervalSeries) -> Double { @_common.variance(self.vals) }

pub fn DsheapintervalSeries::std(self : DsheapintervalSeries) -> Double { @_common.std(self.vals) }

pub fn DsheapintervalSeries::median(self : DsheapintervalSeries) -> Double { @_common.median(self.vals) }

pub fn DsheapintervalSeries::scale(self : DsheapintervalSeries, f : Double) -> DsheapintervalSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheapintervalSeries::add(self : DsheapintervalSeries, other : DsheapintervalSeries) -> DsheapintervalSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheapintervalSeries::sub(self : DsheapintervalSeries, other : DsheapintervalSeries) -> DsheapintervalSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheapintervalSeries::normalize(self : DsheapintervalSeries) -> DsheapintervalSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheapintervalSeries::cumsum(self : DsheapintervalSeries) -> DsheapintervalSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheapintervalSeries::to_string(self : DsheapintervalSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapintervalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_interval_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapintervalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_interval_matrix_identity(n : Int) -> DsheapintervalMatrix {
  let m = ds_heap_interval_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheapintervalMatrix::get(self : DsheapintervalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheapintervalMatrix::transpose(self : DsheapintervalMatrix) -> DsheapintervalMatrix {
  let result = ds_heap_interval_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheapintervalMatrix::add(self : DsheapintervalMatrix, other : DsheapintervalMatrix) -> DsheapintervalMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_interval_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheapintervalMatrix::scale(self : DsheapintervalMatrix, s : Double) -> DsheapintervalMatrix {
  let result = ds_heap_interval_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheapintervalMatrix::multiply(self : DsheapintervalMatrix, other : DsheapintervalMatrix) -> DsheapintervalMatrix {
  if self.cols != other.rows { return ds_heap_interval_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_interval_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsheapintervalMatrix::trace(self : DsheapintervalMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheapintervalMatrix::det(self : DsheapintervalMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheapintervalMatrix::norm(self : DsheapintervalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheapintervalMatrix::to_string(self : DsheapintervalMatrix) -> String {
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

pub(all) struct DsheapintervalVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_interval_make_vector(comps : Array[Double]) -> DsheapintervalVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_interval_vector_zero(dim : Int) -> DsheapintervalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheapintervalVector::add(self : DsheapintervalVector, other : DsheapintervalVector) -> DsheapintervalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapintervalVector::sub(self : DsheapintervalVector, other : DsheapintervalVector) -> DsheapintervalVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapintervalVector::scale(self : DsheapintervalVector, s : Double) -> DsheapintervalVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheapintervalVector::dot(self : DsheapintervalVector, other : DsheapintervalVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheapintervalVector::norm(self : DsheapintervalVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheapintervalVector::normalize(self : DsheapintervalVector) -> DsheapintervalVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapintervalVector::dist(self : DsheapintervalVector, other : DsheapintervalVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheapintervalVector::to_string(self : DsheapintervalVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_interval_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_interval_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_interval_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_interval_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_interval_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_interval_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_interval_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_interval_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_interval_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_interval_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_interval_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_interval_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_interval_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_interval_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_interval_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_interval_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_interval_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_interval_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_interval_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_interval_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_interval_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_interval_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_interval_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_interval_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_interval_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_interval_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_interval_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_interval_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_interval_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapintervalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_frame_make(size : Int) -> DsheapintervalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_frame_len(s : DsheapintervalFrame) -> Int { s.size }

pub fn ds_heap_interval_frame_get(s : DsheapintervalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_frame_set(s : DsheapintervalFrame, i : Int, v : Double) -> DsheapintervalFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_frame_sum(s : DsheapintervalFrame) -> Double { @_common.sum(s.data) }

pub fn ds_heap_interval_frame_mean(s : DsheapintervalFrame) -> Double { @_common.mean(s.data) }

pub fn ds_heap_interval_frame_scale(s : DsheapintervalFrame, f : Double) -> DsheapintervalFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_frame_add(a : DsheapintervalFrame, b : DsheapintervalFrame) -> DsheapintervalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_interval_frame_copy(s : DsheapintervalFrame) -> DsheapintervalFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_frame_fill(s : DsheapintervalFrame, v : Double) -> DsheapintervalFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_frame_min(s : DsheapintervalFrame) -> Double { @_common.min(s.data) }

pub fn ds_heap_interval_frame_max(s : DsheapintervalFrame) -> Double { @_common.max(s.data) }

pub fn ds_heap_interval_frame_to_string(s : DsheapintervalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_table_make(size : Int) -> DsheapintervalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_table_len(s : DsheapintervalTable) -> Int { s.size }

pub fn ds_heap_interval_table_get(s : DsheapintervalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_table_set(s : DsheapintervalTable, i : Int, v : Double) -> DsheapintervalTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_table_sum(s : DsheapintervalTable) -> Double { @_common.sum(s.data) }

pub fn ds_heap_interval_table_mean(s : DsheapintervalTable) -> Double { @_common.mean(s.data) }

pub fn ds_heap_interval_table_scale(s : DsheapintervalTable, f : Double) -> DsheapintervalTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_table_add(a : DsheapintervalTable, b : DsheapintervalTable) -> DsheapintervalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_interval_table_copy(s : DsheapintervalTable) -> DsheapintervalTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_table_fill(s : DsheapintervalTable, v : Double) -> DsheapintervalTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_table_min(s : DsheapintervalTable) -> Double { @_common.min(s.data) }

pub fn ds_heap_interval_table_max(s : DsheapintervalTable) -> Double { @_common.max(s.data) }

pub fn ds_heap_interval_table_to_string(s : DsheapintervalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_graphn_make(size : Int) -> DsheapintervalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_graphn_len(s : DsheapintervalGraphN) -> Int { s.size }

pub fn ds_heap_interval_graphn_get(s : DsheapintervalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_graphn_set(s : DsheapintervalGraphN, i : Int, v : Double) -> DsheapintervalGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_graphn_sum(s : DsheapintervalGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_heap_interval_graphn_mean(s : DsheapintervalGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_heap_interval_graphn_scale(s : DsheapintervalGraphN, f : Double) -> DsheapintervalGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_graphn_add(a : DsheapintervalGraphN, b : DsheapintervalGraphN) -> DsheapintervalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_interval_graphn_copy(s : DsheapintervalGraphN) -> DsheapintervalGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_graphn_fill(s : DsheapintervalGraphN, v : Double) -> DsheapintervalGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_graphn_min(s : DsheapintervalGraphN) -> Double { @_common.min(s.data) }

pub fn ds_heap_interval_graphn_max(s : DsheapintervalGraphN) -> Double { @_common.max(s.data) }

pub fn ds_heap_interval_graphn_to_string(s : DsheapintervalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_node_make(size : Int) -> DsheapintervalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_node_len(s : DsheapintervalNode) -> Int { s.size }

pub fn ds_heap_interval_node_get(s : DsheapintervalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_node_set(s : DsheapintervalNode, i : Int, v : Double) -> DsheapintervalNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_node_sum(s : DsheapintervalNode) -> Double { @_common.sum(s.data) }

pub fn ds_heap_interval_node_mean(s : DsheapintervalNode) -> Double { @_common.mean(s.data) }

pub fn ds_heap_interval_node_scale(s : DsheapintervalNode, f : Double) -> DsheapintervalNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_node_add(a : DsheapintervalNode, b : DsheapintervalNode) -> DsheapintervalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_interval_node_copy(s : DsheapintervalNode) -> DsheapintervalNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_node_fill(s : DsheapintervalNode, v : Double) -> DsheapintervalNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_node_min(s : DsheapintervalNode) -> Double { @_common.min(s.data) }

pub fn ds_heap_interval_node_max(s : DsheapintervalNode) -> Double { @_common.max(s.data) }

pub fn ds_heap_interval_node_to_string(s : DsheapintervalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_edge_make(size : Int) -> DsheapintervalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_edge_len(s : DsheapintervalEdge) -> Int { s.size }

pub fn ds_heap_interval_edge_get(s : DsheapintervalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_edge_set(s : DsheapintervalEdge, i : Int, v : Double) -> DsheapintervalEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_edge_sum(s : DsheapintervalEdge) -> Double { @_common.sum(s.data) }

pub fn ds_heap_interval_edge_mean(s : DsheapintervalEdge) -> Double { @_common.mean(s.data) }

pub fn ds_heap_interval_edge_scale(s : DsheapintervalEdge, f : Double) -> DsheapintervalEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_edge_add(a : DsheapintervalEdge, b : DsheapintervalEdge) -> DsheapintervalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_interval_edge_copy(s : DsheapintervalEdge) -> DsheapintervalEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_edge_fill(s : DsheapintervalEdge, v : Double) -> DsheapintervalEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_edge_min(s : DsheapintervalEdge) -> Double { @_common.min(s.data) }

pub fn ds_heap_interval_edge_max(s : DsheapintervalEdge) -> Double { @_common.max(s.data) }

pub fn ds_heap_interval_edge_to_string(s : DsheapintervalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_path_make(size : Int) -> DsheapintervalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_path_len(s : DsheapintervalPath) -> Int { s.size }

pub fn ds_heap_interval_path_get(s : DsheapintervalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_path_set(s : DsheapintervalPath, i : Int, v : Double) -> DsheapintervalPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_path_sum(s : DsheapintervalPath) -> Double { @_common.sum(s.data) }

pub fn ds_heap_interval_path_mean(s : DsheapintervalPath) -> Double { @_common.mean(s.data) }

pub fn ds_heap_interval_path_scale(s : DsheapintervalPath, f : Double) -> DsheapintervalPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_path_add(a : DsheapintervalPath, b : DsheapintervalPath) -> DsheapintervalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_interval_path_copy(s : DsheapintervalPath) -> DsheapintervalPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_path_fill(s : DsheapintervalPath, v : Double) -> DsheapintervalPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_path_min(s : DsheapintervalPath) -> Double { @_common.min(s.data) }

pub fn ds_heap_interval_path_max(s : DsheapintervalPath) -> Double { @_common.max(s.data) }

pub fn ds_heap_interval_path_to_string(s : DsheapintervalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_cluster_make(size : Int) -> DsheapintervalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_cluster_len(s : DsheapintervalCluster) -> Int { s.size }

pub fn ds_heap_interval_cluster_get(s : DsheapintervalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_cluster_set(s : DsheapintervalCluster, i : Int, v : Double) -> DsheapintervalCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_cluster_sum(s : DsheapintervalCluster) -> Double { @_common.sum(s.data) }

pub fn ds_heap_interval_cluster_mean(s : DsheapintervalCluster) -> Double { @_common.mean(s.data) }

pub fn ds_heap_interval_cluster_scale(s : DsheapintervalCluster, f : Double) -> DsheapintervalCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_cluster_add(a : DsheapintervalCluster, b : DsheapintervalCluster) -> DsheapintervalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_interval_cluster_copy(s : DsheapintervalCluster) -> DsheapintervalCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_cluster_fill(s : DsheapintervalCluster, v : Double) -> DsheapintervalCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_cluster_min(s : DsheapintervalCluster) -> Double { @_common.min(s.data) }

pub fn ds_heap_interval_cluster_max(s : DsheapintervalCluster) -> Double { @_common.max(s.data) }

pub fn ds_heap_interval_cluster_to_string(s : DsheapintervalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_model_make(size : Int) -> DsheapintervalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_model_len(s : DsheapintervalModel) -> Int { s.size }

pub fn ds_heap_interval_model_get(s : DsheapintervalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_model_set(s : DsheapintervalModel, i : Int, v : Double) -> DsheapintervalModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_model_sum(s : DsheapintervalModel) -> Double { @_common.sum(s.data) }

pub fn ds_heap_interval_model_mean(s : DsheapintervalModel) -> Double { @_common.mean(s.data) }

pub fn ds_heap_interval_model_scale(s : DsheapintervalModel, f : Double) -> DsheapintervalModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_model_add(a : DsheapintervalModel, b : DsheapintervalModel) -> DsheapintervalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_interval_model_copy(s : DsheapintervalModel) -> DsheapintervalModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_model_fill(s : DsheapintervalModel, v : Double) -> DsheapintervalModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_model_min(s : DsheapintervalModel) -> Double { @_common.min(s.data) }

pub fn ds_heap_interval_model_max(s : DsheapintervalModel) -> Double { @_common.max(s.data) }

pub fn ds_heap_interval_model_to_string(s : DsheapintervalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_layer_make(size : Int) -> DsheapintervalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_layer_len(s : DsheapintervalLayer) -> Int { s.size }

pub fn ds_heap_interval_layer_get(s : DsheapintervalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_layer_set(s : DsheapintervalLayer, i : Int, v : Double) -> DsheapintervalLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_layer_sum(s : DsheapintervalLayer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_interval_layer_mean(s : DsheapintervalLayer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_interval_layer_scale(s : DsheapintervalLayer, f : Double) -> DsheapintervalLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_layer_add(a : DsheapintervalLayer, b : DsheapintervalLayer) -> DsheapintervalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_interval_layer_copy(s : DsheapintervalLayer) -> DsheapintervalLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_layer_fill(s : DsheapintervalLayer, v : Double) -> DsheapintervalLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_layer_min(s : DsheapintervalLayer) -> Double { @_common.min(s.data) }

pub fn ds_heap_interval_layer_max(s : DsheapintervalLayer) -> Double { @_common.max(s.data) }

pub fn ds_heap_interval_layer_to_string(s : DsheapintervalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_buffer_make(size : Int) -> DsheapintervalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_buffer_len(s : DsheapintervalBuffer) -> Int { s.size }

pub fn ds_heap_interval_buffer_get(s : DsheapintervalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_buffer_set(s : DsheapintervalBuffer, i : Int, v : Double) -> DsheapintervalBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_buffer_sum(s : DsheapintervalBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_heap_interval_buffer_mean(s : DsheapintervalBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_heap_interval_buffer_scale(s : DsheapintervalBuffer, f : Double) -> DsheapintervalBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_buffer_add(a : DsheapintervalBuffer, b : DsheapintervalBuffer) -> DsheapintervalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_interval_buffer_copy(s : DsheapintervalBuffer) -> DsheapintervalBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_buffer_fill(s : DsheapintervalBuffer, v : Double) -> DsheapintervalBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_buffer_min(s : DsheapintervalBuffer) -> Double { @_common.min(s.data) }

pub fn ds_heap_interval_buffer_max(s : DsheapintervalBuffer) -> Double { @_common.max(s.data) }

pub fn ds_heap_interval_buffer_to_string(s : DsheapintervalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_cursor_make(size : Int) -> DsheapintervalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_cursor_len(s : DsheapintervalCursor) -> Int { s.size }

pub fn ds_heap_interval_cursor_get(s : DsheapintervalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_cursor_set(s : DsheapintervalCursor, i : Int, v : Double) -> DsheapintervalCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_cursor_sum(s : DsheapintervalCursor) -> Double { @_common.sum(s.data) }

pub fn ds_heap_interval_cursor_mean(s : DsheapintervalCursor) -> Double { @_common.mean(s.data) }

pub fn ds_heap_interval_cursor_scale(s : DsheapintervalCursor, f : Double) -> DsheapintervalCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_cursor_add(a : DsheapintervalCursor, b : DsheapintervalCursor) -> DsheapintervalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_interval_cursor_copy(s : DsheapintervalCursor) -> DsheapintervalCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_cursor_fill(s : DsheapintervalCursor, v : Double) -> DsheapintervalCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_cursor_min(s : DsheapintervalCursor) -> Double { @_common.min(s.data) }

pub fn ds_heap_interval_cursor_max(s : DsheapintervalCursor) -> Double { @_common.max(s.data) }

pub fn ds_heap_interval_cursor_to_string(s : DsheapintervalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_view_make(size : Int) -> DsheapintervalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_view_len(s : DsheapintervalView) -> Int { s.size }

pub fn ds_heap_interval_view_get(s : DsheapintervalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_view_set(s : DsheapintervalView, i : Int, v : Double) -> DsheapintervalView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_view_sum(s : DsheapintervalView) -> Double { @_common.sum(s.data) }

pub fn ds_heap_interval_view_mean(s : DsheapintervalView) -> Double { @_common.mean(s.data) }

pub fn ds_heap_interval_view_scale(s : DsheapintervalView, f : Double) -> DsheapintervalView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_view_add(a : DsheapintervalView, b : DsheapintervalView) -> DsheapintervalView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_interval_view_copy(s : DsheapintervalView) -> DsheapintervalView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_view_fill(s : DsheapintervalView, v : Double) -> DsheapintervalView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_view_min(s : DsheapintervalView) -> Double { @_common.min(s.data) }

pub fn ds_heap_interval_view_max(s : DsheapintervalView) -> Double { @_common.max(s.data) }

pub fn ds_heap_interval_view_to_string(s : DsheapintervalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_range_make(size : Int) -> DsheapintervalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_range_len(s : DsheapintervalRange) -> Int { s.size }

pub fn ds_heap_interval_range_get(s : DsheapintervalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_range_set(s : DsheapintervalRange, i : Int, v : Double) -> DsheapintervalRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_range_sum(s : DsheapintervalRange) -> Double { @_common.sum(s.data) }

pub fn ds_heap_interval_range_mean(s : DsheapintervalRange) -> Double { @_common.mean(s.data) }

pub fn ds_heap_interval_range_scale(s : DsheapintervalRange, f : Double) -> DsheapintervalRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_range_add(a : DsheapintervalRange, b : DsheapintervalRange) -> DsheapintervalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_interval_range_copy(s : DsheapintervalRange) -> DsheapintervalRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_range_fill(s : DsheapintervalRange, v : Double) -> DsheapintervalRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_range_min(s : DsheapintervalRange) -> Double { @_common.min(s.data) }

pub fn ds_heap_interval_range_max(s : DsheapintervalRange) -> Double { @_common.max(s.data) }

pub fn ds_heap_interval_range_to_string(s : DsheapintervalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsheapintervalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_interval_slice_make(size : Int) -> DsheapintervalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_heap_interval_slice_len(s : DsheapintervalSlice) -> Int { s.size }

pub fn ds_heap_interval_slice_get(s : DsheapintervalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_heap_interval_slice_set(s : DsheapintervalSlice, i : Int, v : Double) -> DsheapintervalSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_slice_sum(s : DsheapintervalSlice) -> Double { @_common.sum(s.data) }

pub fn ds_heap_interval_slice_mean(s : DsheapintervalSlice) -> Double { @_common.mean(s.data) }

pub fn ds_heap_interval_slice_scale(s : DsheapintervalSlice, f : Double) -> DsheapintervalSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_slice_add(a : DsheapintervalSlice, b : DsheapintervalSlice) -> DsheapintervalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_heap_interval_slice_copy(s : DsheapintervalSlice) -> DsheapintervalSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_slice_fill(s : DsheapintervalSlice, v : Double) -> DsheapintervalSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_heap_interval_slice_min(s : DsheapintervalSlice) -> Double { @_common.min(s.data) }

pub fn ds_heap_interval_slice_max(s : DsheapintervalSlice) -> Double { @_common.max(s.data) }

pub fn ds_heap_interval_slice_to_string(s : DsheapintervalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

