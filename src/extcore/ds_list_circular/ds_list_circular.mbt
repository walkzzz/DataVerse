///===
/// extcore/ds_list_circular

pub(all) struct DslistcircularPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_circular_make_point(x : Double, y : Double) -> DslistcircularPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_circular_make_point3(x : Double, y : Double, z : Double) -> DslistcircularPoint {
  { x, y, z, label: 0 }
}

pub fn DslistcircularPoint::x(self : DslistcircularPoint) -> Double { self.x }

pub fn DslistcircularPoint::y(self : DslistcircularPoint) -> Double { self.y }

pub fn DslistcircularPoint::z(self : DslistcircularPoint) -> Double { self.z }

pub fn DslistcircularPoint::label(self : DslistcircularPoint) -> Int { self.label }

pub fn DslistcircularPoint::dist(self : DslistcircularPoint, other : DslistcircularPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistcircularPoint::add(self : DslistcircularPoint, other : DslistcircularPoint) -> DslistcircularPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistcircularPoint::sub(self : DslistcircularPoint, other : DslistcircularPoint) -> DslistcircularPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistcircularPoint::scale(self : DslistcircularPoint, s : Double) -> DslistcircularPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistcircularPoint::dot(self : DslistcircularPoint, other : DslistcircularPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistcircularPoint::cross(self : DslistcircularPoint, other : DslistcircularPoint) -> DslistcircularPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistcircularPoint::norm(self : DslistcircularPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistcircularPoint::normalize(self : DslistcircularPoint) -> DslistcircularPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistcircularPoint::negate(self : DslistcircularPoint) -> DslistcircularPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistcircularPoint::mid(self : DslistcircularPoint, other : DslistcircularPoint) -> DslistcircularPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistcircularPoint::lerp(self : DslistcircularPoint, other : DslistcircularPoint, t : Double) -> DslistcircularPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistcircularPoint::to_string(self : DslistcircularPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistcircularSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_circular_make_series(vals : Array[Double], name : String) -> DslistcircularSeries {
  { vals, name, meta: 0 }
}

pub fn DslistcircularSeries::len(self : DslistcircularSeries) -> Int { self.vals.length() }

pub fn DslistcircularSeries::sum(self : DslistcircularSeries) -> Double { @_common.sum(self.vals) }

pub fn DslistcircularSeries::mean(self : DslistcircularSeries) -> Double { @_common.mean(self.vals) }

pub fn DslistcircularSeries::min(self : DslistcircularSeries) -> Double { @_common.min(self.vals) }

pub fn DslistcircularSeries::max(self : DslistcircularSeries) -> Double { @_common.max(self.vals) }

pub fn DslistcircularSeries::range(self : DslistcircularSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistcircularSeries::variance(self : DslistcircularSeries) -> Double { @_common.variance(self.vals) }

pub fn DslistcircularSeries::std(self : DslistcircularSeries) -> Double { @_common.std(self.vals) }

pub fn DslistcircularSeries::median(self : DslistcircularSeries) -> Double { @_common.median(self.vals) }

pub fn DslistcircularSeries::scale(self : DslistcircularSeries, f : Double) -> DslistcircularSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistcircularSeries::add(self : DslistcircularSeries, other : DslistcircularSeries) -> DslistcircularSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistcircularSeries::sub(self : DslistcircularSeries, other : DslistcircularSeries) -> DslistcircularSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistcircularSeries::normalize(self : DslistcircularSeries) -> DslistcircularSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistcircularSeries::cumsum(self : DslistcircularSeries) -> DslistcircularSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistcircularSeries::to_string(self : DslistcircularSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistcircularMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_circular_make_matrix(rows : Int, cols : Int, val : Double) -> DslistcircularMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_circular_matrix_identity(n : Int) -> DslistcircularMatrix {
  let m = ds_list_circular_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistcircularMatrix::get(self : DslistcircularMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistcircularMatrix::transpose(self : DslistcircularMatrix) -> DslistcircularMatrix {
  let result = ds_list_circular_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistcircularMatrix::add(self : DslistcircularMatrix, other : DslistcircularMatrix) -> DslistcircularMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_circular_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistcircularMatrix::scale(self : DslistcircularMatrix, s : Double) -> DslistcircularMatrix {
  let result = ds_list_circular_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistcircularMatrix::multiply(self : DslistcircularMatrix, other : DslistcircularMatrix) -> DslistcircularMatrix {
  if self.cols != other.rows { return ds_list_circular_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_circular_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistcircularMatrix::trace(self : DslistcircularMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistcircularMatrix::det(self : DslistcircularMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistcircularMatrix::norm(self : DslistcircularMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistcircularMatrix::to_string(self : DslistcircularMatrix) -> String {
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

pub(all) struct DslistcircularVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_circular_make_vector(comps : Array[Double]) -> DslistcircularVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_circular_vector_zero(dim : Int) -> DslistcircularVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistcircularVector::add(self : DslistcircularVector, other : DslistcircularVector) -> DslistcircularVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistcircularVector::sub(self : DslistcircularVector, other : DslistcircularVector) -> DslistcircularVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistcircularVector::scale(self : DslistcircularVector, s : Double) -> DslistcircularVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistcircularVector::dot(self : DslistcircularVector, other : DslistcircularVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistcircularVector::norm(self : DslistcircularVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistcircularVector::normalize(self : DslistcircularVector) -> DslistcircularVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistcircularVector::dist(self : DslistcircularVector, other : DslistcircularVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistcircularVector::to_string(self : DslistcircularVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_circular_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_circular_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_circular_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_circular_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_circular_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_circular_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_circular_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_circular_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_circular_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_circular_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_circular_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_circular_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_circular_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_circular_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_circular_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_circular_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_circular_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_circular_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_circular_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_circular_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_circular_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_circular_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_circular_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_circular_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_circular_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_circular_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_circular_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_circular_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_circular_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistcircularFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_frame_make(size : Int) -> DslistcircularFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_frame_len(s : DslistcircularFrame) -> Int { s.size }

pub fn ds_list_circular_frame_get(s : DslistcircularFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_frame_set(s : DslistcircularFrame, i : Int, v : Double) -> DslistcircularFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_circular_frame_sum(s : DslistcircularFrame) -> Double { @_common.sum(s.data) }

pub fn ds_list_circular_frame_mean(s : DslistcircularFrame) -> Double { @_common.mean(s.data) }

pub fn ds_list_circular_frame_scale(s : DslistcircularFrame, f : Double) -> DslistcircularFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_frame_add(a : DslistcircularFrame, b : DslistcircularFrame) -> DslistcircularFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_circular_frame_copy(s : DslistcircularFrame) -> DslistcircularFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_frame_fill(s : DslistcircularFrame, v : Double) -> DslistcircularFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_frame_min(s : DslistcircularFrame) -> Double { @_common.min(s.data) }

pub fn ds_list_circular_frame_max(s : DslistcircularFrame) -> Double { @_common.max(s.data) }

pub fn ds_list_circular_frame_to_string(s : DslistcircularFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_table_make(size : Int) -> DslistcircularTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_table_len(s : DslistcircularTable) -> Int { s.size }

pub fn ds_list_circular_table_get(s : DslistcircularTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_table_set(s : DslistcircularTable, i : Int, v : Double) -> DslistcircularTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_circular_table_sum(s : DslistcircularTable) -> Double { @_common.sum(s.data) }

pub fn ds_list_circular_table_mean(s : DslistcircularTable) -> Double { @_common.mean(s.data) }

pub fn ds_list_circular_table_scale(s : DslistcircularTable, f : Double) -> DslistcircularTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_table_add(a : DslistcircularTable, b : DslistcircularTable) -> DslistcircularTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_circular_table_copy(s : DslistcircularTable) -> DslistcircularTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_table_fill(s : DslistcircularTable, v : Double) -> DslistcircularTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_table_min(s : DslistcircularTable) -> Double { @_common.min(s.data) }

pub fn ds_list_circular_table_max(s : DslistcircularTable) -> Double { @_common.max(s.data) }

pub fn ds_list_circular_table_to_string(s : DslistcircularTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_graphn_make(size : Int) -> DslistcircularGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_graphn_len(s : DslistcircularGraphN) -> Int { s.size }

pub fn ds_list_circular_graphn_get(s : DslistcircularGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_graphn_set(s : DslistcircularGraphN, i : Int, v : Double) -> DslistcircularGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_circular_graphn_sum(s : DslistcircularGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_list_circular_graphn_mean(s : DslistcircularGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_list_circular_graphn_scale(s : DslistcircularGraphN, f : Double) -> DslistcircularGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_graphn_add(a : DslistcircularGraphN, b : DslistcircularGraphN) -> DslistcircularGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_circular_graphn_copy(s : DslistcircularGraphN) -> DslistcircularGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_graphn_fill(s : DslistcircularGraphN, v : Double) -> DslistcircularGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_graphn_min(s : DslistcircularGraphN) -> Double { @_common.min(s.data) }

pub fn ds_list_circular_graphn_max(s : DslistcircularGraphN) -> Double { @_common.max(s.data) }

pub fn ds_list_circular_graphn_to_string(s : DslistcircularGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_node_make(size : Int) -> DslistcircularNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_node_len(s : DslistcircularNode) -> Int { s.size }

pub fn ds_list_circular_node_get(s : DslistcircularNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_node_set(s : DslistcircularNode, i : Int, v : Double) -> DslistcircularNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_circular_node_sum(s : DslistcircularNode) -> Double { @_common.sum(s.data) }

pub fn ds_list_circular_node_mean(s : DslistcircularNode) -> Double { @_common.mean(s.data) }

pub fn ds_list_circular_node_scale(s : DslistcircularNode, f : Double) -> DslistcircularNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_node_add(a : DslistcircularNode, b : DslistcircularNode) -> DslistcircularNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_circular_node_copy(s : DslistcircularNode) -> DslistcircularNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_node_fill(s : DslistcircularNode, v : Double) -> DslistcircularNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_node_min(s : DslistcircularNode) -> Double { @_common.min(s.data) }

pub fn ds_list_circular_node_max(s : DslistcircularNode) -> Double { @_common.max(s.data) }

pub fn ds_list_circular_node_to_string(s : DslistcircularNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_edge_make(size : Int) -> DslistcircularEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_edge_len(s : DslistcircularEdge) -> Int { s.size }

pub fn ds_list_circular_edge_get(s : DslistcircularEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_edge_set(s : DslistcircularEdge, i : Int, v : Double) -> DslistcircularEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_circular_edge_sum(s : DslistcircularEdge) -> Double { @_common.sum(s.data) }

pub fn ds_list_circular_edge_mean(s : DslistcircularEdge) -> Double { @_common.mean(s.data) }

pub fn ds_list_circular_edge_scale(s : DslistcircularEdge, f : Double) -> DslistcircularEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_edge_add(a : DslistcircularEdge, b : DslistcircularEdge) -> DslistcircularEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_circular_edge_copy(s : DslistcircularEdge) -> DslistcircularEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_edge_fill(s : DslistcircularEdge, v : Double) -> DslistcircularEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_edge_min(s : DslistcircularEdge) -> Double { @_common.min(s.data) }

pub fn ds_list_circular_edge_max(s : DslistcircularEdge) -> Double { @_common.max(s.data) }

pub fn ds_list_circular_edge_to_string(s : DslistcircularEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_path_make(size : Int) -> DslistcircularPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_path_len(s : DslistcircularPath) -> Int { s.size }

pub fn ds_list_circular_path_get(s : DslistcircularPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_path_set(s : DslistcircularPath, i : Int, v : Double) -> DslistcircularPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_circular_path_sum(s : DslistcircularPath) -> Double { @_common.sum(s.data) }

pub fn ds_list_circular_path_mean(s : DslistcircularPath) -> Double { @_common.mean(s.data) }

pub fn ds_list_circular_path_scale(s : DslistcircularPath, f : Double) -> DslistcircularPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_path_add(a : DslistcircularPath, b : DslistcircularPath) -> DslistcircularPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_circular_path_copy(s : DslistcircularPath) -> DslistcircularPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_path_fill(s : DslistcircularPath, v : Double) -> DslistcircularPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_path_min(s : DslistcircularPath) -> Double { @_common.min(s.data) }

pub fn ds_list_circular_path_max(s : DslistcircularPath) -> Double { @_common.max(s.data) }

pub fn ds_list_circular_path_to_string(s : DslistcircularPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_cluster_make(size : Int) -> DslistcircularCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_cluster_len(s : DslistcircularCluster) -> Int { s.size }

pub fn ds_list_circular_cluster_get(s : DslistcircularCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_cluster_set(s : DslistcircularCluster, i : Int, v : Double) -> DslistcircularCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_circular_cluster_sum(s : DslistcircularCluster) -> Double { @_common.sum(s.data) }

pub fn ds_list_circular_cluster_mean(s : DslistcircularCluster) -> Double { @_common.mean(s.data) }

pub fn ds_list_circular_cluster_scale(s : DslistcircularCluster, f : Double) -> DslistcircularCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_cluster_add(a : DslistcircularCluster, b : DslistcircularCluster) -> DslistcircularCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_circular_cluster_copy(s : DslistcircularCluster) -> DslistcircularCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_cluster_fill(s : DslistcircularCluster, v : Double) -> DslistcircularCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_cluster_min(s : DslistcircularCluster) -> Double { @_common.min(s.data) }

pub fn ds_list_circular_cluster_max(s : DslistcircularCluster) -> Double { @_common.max(s.data) }

pub fn ds_list_circular_cluster_to_string(s : DslistcircularCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_model_make(size : Int) -> DslistcircularModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_model_len(s : DslistcircularModel) -> Int { s.size }

pub fn ds_list_circular_model_get(s : DslistcircularModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_model_set(s : DslistcircularModel, i : Int, v : Double) -> DslistcircularModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_circular_model_sum(s : DslistcircularModel) -> Double { @_common.sum(s.data) }

pub fn ds_list_circular_model_mean(s : DslistcircularModel) -> Double { @_common.mean(s.data) }

pub fn ds_list_circular_model_scale(s : DslistcircularModel, f : Double) -> DslistcircularModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_model_add(a : DslistcircularModel, b : DslistcircularModel) -> DslistcircularModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_circular_model_copy(s : DslistcircularModel) -> DslistcircularModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_model_fill(s : DslistcircularModel, v : Double) -> DslistcircularModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_model_min(s : DslistcircularModel) -> Double { @_common.min(s.data) }

pub fn ds_list_circular_model_max(s : DslistcircularModel) -> Double { @_common.max(s.data) }

pub fn ds_list_circular_model_to_string(s : DslistcircularModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_layer_make(size : Int) -> DslistcircularLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_layer_len(s : DslistcircularLayer) -> Int { s.size }

pub fn ds_list_circular_layer_get(s : DslistcircularLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_layer_set(s : DslistcircularLayer, i : Int, v : Double) -> DslistcircularLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_circular_layer_sum(s : DslistcircularLayer) -> Double { @_common.sum(s.data) }

pub fn ds_list_circular_layer_mean(s : DslistcircularLayer) -> Double { @_common.mean(s.data) }

pub fn ds_list_circular_layer_scale(s : DslistcircularLayer, f : Double) -> DslistcircularLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_layer_add(a : DslistcircularLayer, b : DslistcircularLayer) -> DslistcircularLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_circular_layer_copy(s : DslistcircularLayer) -> DslistcircularLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_layer_fill(s : DslistcircularLayer, v : Double) -> DslistcircularLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_layer_min(s : DslistcircularLayer) -> Double { @_common.min(s.data) }

pub fn ds_list_circular_layer_max(s : DslistcircularLayer) -> Double { @_common.max(s.data) }

pub fn ds_list_circular_layer_to_string(s : DslistcircularLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_buffer_make(size : Int) -> DslistcircularBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_buffer_len(s : DslistcircularBuffer) -> Int { s.size }

pub fn ds_list_circular_buffer_get(s : DslistcircularBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_buffer_set(s : DslistcircularBuffer, i : Int, v : Double) -> DslistcircularBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_circular_buffer_sum(s : DslistcircularBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_list_circular_buffer_mean(s : DslistcircularBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_list_circular_buffer_scale(s : DslistcircularBuffer, f : Double) -> DslistcircularBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_buffer_add(a : DslistcircularBuffer, b : DslistcircularBuffer) -> DslistcircularBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_circular_buffer_copy(s : DslistcircularBuffer) -> DslistcircularBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_buffer_fill(s : DslistcircularBuffer, v : Double) -> DslistcircularBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_buffer_min(s : DslistcircularBuffer) -> Double { @_common.min(s.data) }

pub fn ds_list_circular_buffer_max(s : DslistcircularBuffer) -> Double { @_common.max(s.data) }

pub fn ds_list_circular_buffer_to_string(s : DslistcircularBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_cursor_make(size : Int) -> DslistcircularCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_cursor_len(s : DslistcircularCursor) -> Int { s.size }

pub fn ds_list_circular_cursor_get(s : DslistcircularCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_cursor_set(s : DslistcircularCursor, i : Int, v : Double) -> DslistcircularCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_circular_cursor_sum(s : DslistcircularCursor) -> Double { @_common.sum(s.data) }

pub fn ds_list_circular_cursor_mean(s : DslistcircularCursor) -> Double { @_common.mean(s.data) }

pub fn ds_list_circular_cursor_scale(s : DslistcircularCursor, f : Double) -> DslistcircularCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_cursor_add(a : DslistcircularCursor, b : DslistcircularCursor) -> DslistcircularCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_circular_cursor_copy(s : DslistcircularCursor) -> DslistcircularCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_cursor_fill(s : DslistcircularCursor, v : Double) -> DslistcircularCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_cursor_min(s : DslistcircularCursor) -> Double { @_common.min(s.data) }

pub fn ds_list_circular_cursor_max(s : DslistcircularCursor) -> Double { @_common.max(s.data) }

pub fn ds_list_circular_cursor_to_string(s : DslistcircularCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_view_make(size : Int) -> DslistcircularView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_view_len(s : DslistcircularView) -> Int { s.size }

pub fn ds_list_circular_view_get(s : DslistcircularView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_view_set(s : DslistcircularView, i : Int, v : Double) -> DslistcircularView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_circular_view_sum(s : DslistcircularView) -> Double { @_common.sum(s.data) }

pub fn ds_list_circular_view_mean(s : DslistcircularView) -> Double { @_common.mean(s.data) }

pub fn ds_list_circular_view_scale(s : DslistcircularView, f : Double) -> DslistcircularView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_view_add(a : DslistcircularView, b : DslistcircularView) -> DslistcircularView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_circular_view_copy(s : DslistcircularView) -> DslistcircularView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_view_fill(s : DslistcircularView, v : Double) -> DslistcircularView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_view_min(s : DslistcircularView) -> Double { @_common.min(s.data) }

pub fn ds_list_circular_view_max(s : DslistcircularView) -> Double { @_common.max(s.data) }

pub fn ds_list_circular_view_to_string(s : DslistcircularView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_range_make(size : Int) -> DslistcircularRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_range_len(s : DslistcircularRange) -> Int { s.size }

pub fn ds_list_circular_range_get(s : DslistcircularRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_range_set(s : DslistcircularRange, i : Int, v : Double) -> DslistcircularRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_circular_range_sum(s : DslistcircularRange) -> Double { @_common.sum(s.data) }

pub fn ds_list_circular_range_mean(s : DslistcircularRange) -> Double { @_common.mean(s.data) }

pub fn ds_list_circular_range_scale(s : DslistcircularRange, f : Double) -> DslistcircularRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_range_add(a : DslistcircularRange, b : DslistcircularRange) -> DslistcircularRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_circular_range_copy(s : DslistcircularRange) -> DslistcircularRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_range_fill(s : DslistcircularRange, v : Double) -> DslistcircularRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_range_min(s : DslistcircularRange) -> Double { @_common.min(s.data) }

pub fn ds_list_circular_range_max(s : DslistcircularRange) -> Double { @_common.max(s.data) }

pub fn ds_list_circular_range_to_string(s : DslistcircularRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistcircularSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_slice_make(size : Int) -> DslistcircularSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_circular_slice_len(s : DslistcircularSlice) -> Int { s.size }

pub fn ds_list_circular_slice_get(s : DslistcircularSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_circular_slice_set(s : DslistcircularSlice, i : Int, v : Double) -> DslistcircularSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_circular_slice_sum(s : DslistcircularSlice) -> Double { @_common.sum(s.data) }

pub fn ds_list_circular_slice_mean(s : DslistcircularSlice) -> Double { @_common.mean(s.data) }

pub fn ds_list_circular_slice_scale(s : DslistcircularSlice, f : Double) -> DslistcircularSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_slice_add(a : DslistcircularSlice, b : DslistcircularSlice) -> DslistcircularSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_circular_slice_copy(s : DslistcircularSlice) -> DslistcircularSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_slice_fill(s : DslistcircularSlice, v : Double) -> DslistcircularSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_circular_slice_min(s : DslistcircularSlice) -> Double { @_common.min(s.data) }

pub fn ds_list_circular_slice_max(s : DslistcircularSlice) -> Double { @_common.max(s.data) }

pub fn ds_list_circular_slice_to_string(s : DslistcircularSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

