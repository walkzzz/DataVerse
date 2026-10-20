///===
/// extcore/ds_tree_segment

pub(all) struct DstreesegmentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_segment_make_point(x : Double, y : Double) -> DstreesegmentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_segment_make_point3(x : Double, y : Double, z : Double) -> DstreesegmentPoint {
  { x, y, z, label: 0 }
}

pub fn DstreesegmentPoint::x(self : DstreesegmentPoint) -> Double { self.x }

pub fn DstreesegmentPoint::y(self : DstreesegmentPoint) -> Double { self.y }

pub fn DstreesegmentPoint::z(self : DstreesegmentPoint) -> Double { self.z }

pub fn DstreesegmentPoint::label(self : DstreesegmentPoint) -> Int { self.label }

pub fn DstreesegmentPoint::dist(self : DstreesegmentPoint, other : DstreesegmentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreesegmentPoint::add(self : DstreesegmentPoint, other : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreesegmentPoint::sub(self : DstreesegmentPoint, other : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreesegmentPoint::scale(self : DstreesegmentPoint, s : Double) -> DstreesegmentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreesegmentPoint::dot(self : DstreesegmentPoint, other : DstreesegmentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreesegmentPoint::cross(self : DstreesegmentPoint, other : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreesegmentPoint::norm(self : DstreesegmentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreesegmentPoint::normalize(self : DstreesegmentPoint) -> DstreesegmentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreesegmentPoint::negate(self : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreesegmentPoint::mid(self : DstreesegmentPoint, other : DstreesegmentPoint) -> DstreesegmentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreesegmentPoint::lerp(self : DstreesegmentPoint, other : DstreesegmentPoint, t : Double) -> DstreesegmentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreesegmentPoint::to_string(self : DstreesegmentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreesegmentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_segment_make_series(vals : Array[Double], name : String) -> DstreesegmentSeries {
  { vals, name, meta: 0 }
}

pub fn DstreesegmentSeries::len(self : DstreesegmentSeries) -> Int { self.vals.length() }

pub fn DstreesegmentSeries::sum(self : DstreesegmentSeries) -> Double { @_common.sum(self.vals) }

pub fn DstreesegmentSeries::mean(self : DstreesegmentSeries) -> Double { @_common.mean(self.vals) }

pub fn DstreesegmentSeries::min(self : DstreesegmentSeries) -> Double { @_common.min(self.vals) }

pub fn DstreesegmentSeries::max(self : DstreesegmentSeries) -> Double { @_common.max(self.vals) }

pub fn DstreesegmentSeries::range(self : DstreesegmentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreesegmentSeries::variance(self : DstreesegmentSeries) -> Double { @_common.variance(self.vals) }

pub fn DstreesegmentSeries::std(self : DstreesegmentSeries) -> Double { @_common.std(self.vals) }

pub fn DstreesegmentSeries::median(self : DstreesegmentSeries) -> Double { @_common.median(self.vals) }

pub fn DstreesegmentSeries::scale(self : DstreesegmentSeries, f : Double) -> DstreesegmentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreesegmentSeries::add(self : DstreesegmentSeries, other : DstreesegmentSeries) -> DstreesegmentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreesegmentSeries::sub(self : DstreesegmentSeries, other : DstreesegmentSeries) -> DstreesegmentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreesegmentSeries::normalize(self : DstreesegmentSeries) -> DstreesegmentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreesegmentSeries::cumsum(self : DstreesegmentSeries) -> DstreesegmentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreesegmentSeries::to_string(self : DstreesegmentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreesegmentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_segment_make_matrix(rows : Int, cols : Int, val : Double) -> DstreesegmentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_segment_matrix_identity(n : Int) -> DstreesegmentMatrix {
  let m = ds_tree_segment_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreesegmentMatrix::get(self : DstreesegmentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreesegmentMatrix::transpose(self : DstreesegmentMatrix) -> DstreesegmentMatrix {
  let result = ds_tree_segment_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreesegmentMatrix::add(self : DstreesegmentMatrix, other : DstreesegmentMatrix) -> DstreesegmentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_segment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreesegmentMatrix::scale(self : DstreesegmentMatrix, s : Double) -> DstreesegmentMatrix {
  let result = ds_tree_segment_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreesegmentMatrix::multiply(self : DstreesegmentMatrix, other : DstreesegmentMatrix) -> DstreesegmentMatrix {
  if self.cols != other.rows { return ds_tree_segment_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_segment_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DstreesegmentMatrix::trace(self : DstreesegmentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreesegmentMatrix::det(self : DstreesegmentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreesegmentMatrix::norm(self : DstreesegmentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreesegmentMatrix::to_string(self : DstreesegmentMatrix) -> String {
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

pub(all) struct DstreesegmentVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_segment_make_vector(comps : Array[Double]) -> DstreesegmentVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_segment_vector_zero(dim : Int) -> DstreesegmentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreesegmentVector::add(self : DstreesegmentVector, other : DstreesegmentVector) -> DstreesegmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreesegmentVector::sub(self : DstreesegmentVector, other : DstreesegmentVector) -> DstreesegmentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreesegmentVector::scale(self : DstreesegmentVector, s : Double) -> DstreesegmentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreesegmentVector::dot(self : DstreesegmentVector, other : DstreesegmentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreesegmentVector::norm(self : DstreesegmentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreesegmentVector::normalize(self : DstreesegmentVector) -> DstreesegmentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreesegmentVector::dist(self : DstreesegmentVector, other : DstreesegmentVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreesegmentVector::to_string(self : DstreesegmentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_segment_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_segment_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_segment_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_segment_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_segment_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_segment_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_segment_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_segment_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_segment_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_segment_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_segment_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_segment_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_segment_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_segment_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_segment_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_segment_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_segment_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_segment_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_segment_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_segment_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_segment_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_segment_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_segment_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_segment_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_segment_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_segment_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_segment_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_segment_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_segment_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreesegmentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_frame_make(size : Int) -> DstreesegmentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_frame_len(s : DstreesegmentFrame) -> Int { s.size }

pub fn ds_tree_segment_frame_get(s : DstreesegmentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_frame_set(s : DstreesegmentFrame, i : Int, v : Double) -> DstreesegmentFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_frame_sum(s : DstreesegmentFrame) -> Double { @_common.sum(s.data) }

pub fn ds_tree_segment_frame_mean(s : DstreesegmentFrame) -> Double { @_common.mean(s.data) }

pub fn ds_tree_segment_frame_scale(s : DstreesegmentFrame, f : Double) -> DstreesegmentFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_frame_add(a : DstreesegmentFrame, b : DstreesegmentFrame) -> DstreesegmentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_segment_frame_copy(s : DstreesegmentFrame) -> DstreesegmentFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_frame_fill(s : DstreesegmentFrame, v : Double) -> DstreesegmentFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_frame_min(s : DstreesegmentFrame) -> Double { @_common.min(s.data) }

pub fn ds_tree_segment_frame_max(s : DstreesegmentFrame) -> Double { @_common.max(s.data) }

pub fn ds_tree_segment_frame_to_string(s : DstreesegmentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_table_make(size : Int) -> DstreesegmentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_table_len(s : DstreesegmentTable) -> Int { s.size }

pub fn ds_tree_segment_table_get(s : DstreesegmentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_table_set(s : DstreesegmentTable, i : Int, v : Double) -> DstreesegmentTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_table_sum(s : DstreesegmentTable) -> Double { @_common.sum(s.data) }

pub fn ds_tree_segment_table_mean(s : DstreesegmentTable) -> Double { @_common.mean(s.data) }

pub fn ds_tree_segment_table_scale(s : DstreesegmentTable, f : Double) -> DstreesegmentTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_table_add(a : DstreesegmentTable, b : DstreesegmentTable) -> DstreesegmentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_segment_table_copy(s : DstreesegmentTable) -> DstreesegmentTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_table_fill(s : DstreesegmentTable, v : Double) -> DstreesegmentTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_table_min(s : DstreesegmentTable) -> Double { @_common.min(s.data) }

pub fn ds_tree_segment_table_max(s : DstreesegmentTable) -> Double { @_common.max(s.data) }

pub fn ds_tree_segment_table_to_string(s : DstreesegmentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_graphn_make(size : Int) -> DstreesegmentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_graphn_len(s : DstreesegmentGraphN) -> Int { s.size }

pub fn ds_tree_segment_graphn_get(s : DstreesegmentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_graphn_set(s : DstreesegmentGraphN, i : Int, v : Double) -> DstreesegmentGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_graphn_sum(s : DstreesegmentGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_tree_segment_graphn_mean(s : DstreesegmentGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_tree_segment_graphn_scale(s : DstreesegmentGraphN, f : Double) -> DstreesegmentGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_graphn_add(a : DstreesegmentGraphN, b : DstreesegmentGraphN) -> DstreesegmentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_segment_graphn_copy(s : DstreesegmentGraphN) -> DstreesegmentGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_graphn_fill(s : DstreesegmentGraphN, v : Double) -> DstreesegmentGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_graphn_min(s : DstreesegmentGraphN) -> Double { @_common.min(s.data) }

pub fn ds_tree_segment_graphn_max(s : DstreesegmentGraphN) -> Double { @_common.max(s.data) }

pub fn ds_tree_segment_graphn_to_string(s : DstreesegmentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_node_make(size : Int) -> DstreesegmentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_node_len(s : DstreesegmentNode) -> Int { s.size }

pub fn ds_tree_segment_node_get(s : DstreesegmentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_node_set(s : DstreesegmentNode, i : Int, v : Double) -> DstreesegmentNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_node_sum(s : DstreesegmentNode) -> Double { @_common.sum(s.data) }

pub fn ds_tree_segment_node_mean(s : DstreesegmentNode) -> Double { @_common.mean(s.data) }

pub fn ds_tree_segment_node_scale(s : DstreesegmentNode, f : Double) -> DstreesegmentNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_node_add(a : DstreesegmentNode, b : DstreesegmentNode) -> DstreesegmentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_segment_node_copy(s : DstreesegmentNode) -> DstreesegmentNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_node_fill(s : DstreesegmentNode, v : Double) -> DstreesegmentNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_node_min(s : DstreesegmentNode) -> Double { @_common.min(s.data) }

pub fn ds_tree_segment_node_max(s : DstreesegmentNode) -> Double { @_common.max(s.data) }

pub fn ds_tree_segment_node_to_string(s : DstreesegmentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_edge_make(size : Int) -> DstreesegmentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_edge_len(s : DstreesegmentEdge) -> Int { s.size }

pub fn ds_tree_segment_edge_get(s : DstreesegmentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_edge_set(s : DstreesegmentEdge, i : Int, v : Double) -> DstreesegmentEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_edge_sum(s : DstreesegmentEdge) -> Double { @_common.sum(s.data) }

pub fn ds_tree_segment_edge_mean(s : DstreesegmentEdge) -> Double { @_common.mean(s.data) }

pub fn ds_tree_segment_edge_scale(s : DstreesegmentEdge, f : Double) -> DstreesegmentEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_edge_add(a : DstreesegmentEdge, b : DstreesegmentEdge) -> DstreesegmentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_segment_edge_copy(s : DstreesegmentEdge) -> DstreesegmentEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_edge_fill(s : DstreesegmentEdge, v : Double) -> DstreesegmentEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_edge_min(s : DstreesegmentEdge) -> Double { @_common.min(s.data) }

pub fn ds_tree_segment_edge_max(s : DstreesegmentEdge) -> Double { @_common.max(s.data) }

pub fn ds_tree_segment_edge_to_string(s : DstreesegmentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_path_make(size : Int) -> DstreesegmentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_path_len(s : DstreesegmentPath) -> Int { s.size }

pub fn ds_tree_segment_path_get(s : DstreesegmentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_path_set(s : DstreesegmentPath, i : Int, v : Double) -> DstreesegmentPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_path_sum(s : DstreesegmentPath) -> Double { @_common.sum(s.data) }

pub fn ds_tree_segment_path_mean(s : DstreesegmentPath) -> Double { @_common.mean(s.data) }

pub fn ds_tree_segment_path_scale(s : DstreesegmentPath, f : Double) -> DstreesegmentPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_path_add(a : DstreesegmentPath, b : DstreesegmentPath) -> DstreesegmentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_segment_path_copy(s : DstreesegmentPath) -> DstreesegmentPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_path_fill(s : DstreesegmentPath, v : Double) -> DstreesegmentPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_path_min(s : DstreesegmentPath) -> Double { @_common.min(s.data) }

pub fn ds_tree_segment_path_max(s : DstreesegmentPath) -> Double { @_common.max(s.data) }

pub fn ds_tree_segment_path_to_string(s : DstreesegmentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_cluster_make(size : Int) -> DstreesegmentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_cluster_len(s : DstreesegmentCluster) -> Int { s.size }

pub fn ds_tree_segment_cluster_get(s : DstreesegmentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_cluster_set(s : DstreesegmentCluster, i : Int, v : Double) -> DstreesegmentCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_cluster_sum(s : DstreesegmentCluster) -> Double { @_common.sum(s.data) }

pub fn ds_tree_segment_cluster_mean(s : DstreesegmentCluster) -> Double { @_common.mean(s.data) }

pub fn ds_tree_segment_cluster_scale(s : DstreesegmentCluster, f : Double) -> DstreesegmentCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_cluster_add(a : DstreesegmentCluster, b : DstreesegmentCluster) -> DstreesegmentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_segment_cluster_copy(s : DstreesegmentCluster) -> DstreesegmentCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_cluster_fill(s : DstreesegmentCluster, v : Double) -> DstreesegmentCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_cluster_min(s : DstreesegmentCluster) -> Double { @_common.min(s.data) }

pub fn ds_tree_segment_cluster_max(s : DstreesegmentCluster) -> Double { @_common.max(s.data) }

pub fn ds_tree_segment_cluster_to_string(s : DstreesegmentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_model_make(size : Int) -> DstreesegmentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_model_len(s : DstreesegmentModel) -> Int { s.size }

pub fn ds_tree_segment_model_get(s : DstreesegmentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_model_set(s : DstreesegmentModel, i : Int, v : Double) -> DstreesegmentModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_model_sum(s : DstreesegmentModel) -> Double { @_common.sum(s.data) }

pub fn ds_tree_segment_model_mean(s : DstreesegmentModel) -> Double { @_common.mean(s.data) }

pub fn ds_tree_segment_model_scale(s : DstreesegmentModel, f : Double) -> DstreesegmentModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_model_add(a : DstreesegmentModel, b : DstreesegmentModel) -> DstreesegmentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_segment_model_copy(s : DstreesegmentModel) -> DstreesegmentModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_model_fill(s : DstreesegmentModel, v : Double) -> DstreesegmentModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_model_min(s : DstreesegmentModel) -> Double { @_common.min(s.data) }

pub fn ds_tree_segment_model_max(s : DstreesegmentModel) -> Double { @_common.max(s.data) }

pub fn ds_tree_segment_model_to_string(s : DstreesegmentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_layer_make(size : Int) -> DstreesegmentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_layer_len(s : DstreesegmentLayer) -> Int { s.size }

pub fn ds_tree_segment_layer_get(s : DstreesegmentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_layer_set(s : DstreesegmentLayer, i : Int, v : Double) -> DstreesegmentLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_layer_sum(s : DstreesegmentLayer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_segment_layer_mean(s : DstreesegmentLayer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_segment_layer_scale(s : DstreesegmentLayer, f : Double) -> DstreesegmentLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_layer_add(a : DstreesegmentLayer, b : DstreesegmentLayer) -> DstreesegmentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_segment_layer_copy(s : DstreesegmentLayer) -> DstreesegmentLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_layer_fill(s : DstreesegmentLayer, v : Double) -> DstreesegmentLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_layer_min(s : DstreesegmentLayer) -> Double { @_common.min(s.data) }

pub fn ds_tree_segment_layer_max(s : DstreesegmentLayer) -> Double { @_common.max(s.data) }

pub fn ds_tree_segment_layer_to_string(s : DstreesegmentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_buffer_make(size : Int) -> DstreesegmentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_buffer_len(s : DstreesegmentBuffer) -> Int { s.size }

pub fn ds_tree_segment_buffer_get(s : DstreesegmentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_buffer_set(s : DstreesegmentBuffer, i : Int, v : Double) -> DstreesegmentBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_buffer_sum(s : DstreesegmentBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_segment_buffer_mean(s : DstreesegmentBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_segment_buffer_scale(s : DstreesegmentBuffer, f : Double) -> DstreesegmentBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_buffer_add(a : DstreesegmentBuffer, b : DstreesegmentBuffer) -> DstreesegmentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_segment_buffer_copy(s : DstreesegmentBuffer) -> DstreesegmentBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_buffer_fill(s : DstreesegmentBuffer, v : Double) -> DstreesegmentBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_buffer_min(s : DstreesegmentBuffer) -> Double { @_common.min(s.data) }

pub fn ds_tree_segment_buffer_max(s : DstreesegmentBuffer) -> Double { @_common.max(s.data) }

pub fn ds_tree_segment_buffer_to_string(s : DstreesegmentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_cursor_make(size : Int) -> DstreesegmentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_cursor_len(s : DstreesegmentCursor) -> Int { s.size }

pub fn ds_tree_segment_cursor_get(s : DstreesegmentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_cursor_set(s : DstreesegmentCursor, i : Int, v : Double) -> DstreesegmentCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_cursor_sum(s : DstreesegmentCursor) -> Double { @_common.sum(s.data) }

pub fn ds_tree_segment_cursor_mean(s : DstreesegmentCursor) -> Double { @_common.mean(s.data) }

pub fn ds_tree_segment_cursor_scale(s : DstreesegmentCursor, f : Double) -> DstreesegmentCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_cursor_add(a : DstreesegmentCursor, b : DstreesegmentCursor) -> DstreesegmentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_segment_cursor_copy(s : DstreesegmentCursor) -> DstreesegmentCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_cursor_fill(s : DstreesegmentCursor, v : Double) -> DstreesegmentCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_cursor_min(s : DstreesegmentCursor) -> Double { @_common.min(s.data) }

pub fn ds_tree_segment_cursor_max(s : DstreesegmentCursor) -> Double { @_common.max(s.data) }

pub fn ds_tree_segment_cursor_to_string(s : DstreesegmentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_view_make(size : Int) -> DstreesegmentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_view_len(s : DstreesegmentView) -> Int { s.size }

pub fn ds_tree_segment_view_get(s : DstreesegmentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_view_set(s : DstreesegmentView, i : Int, v : Double) -> DstreesegmentView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_view_sum(s : DstreesegmentView) -> Double { @_common.sum(s.data) }

pub fn ds_tree_segment_view_mean(s : DstreesegmentView) -> Double { @_common.mean(s.data) }

pub fn ds_tree_segment_view_scale(s : DstreesegmentView, f : Double) -> DstreesegmentView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_view_add(a : DstreesegmentView, b : DstreesegmentView) -> DstreesegmentView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_segment_view_copy(s : DstreesegmentView) -> DstreesegmentView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_view_fill(s : DstreesegmentView, v : Double) -> DstreesegmentView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_view_min(s : DstreesegmentView) -> Double { @_common.min(s.data) }

pub fn ds_tree_segment_view_max(s : DstreesegmentView) -> Double { @_common.max(s.data) }

pub fn ds_tree_segment_view_to_string(s : DstreesegmentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_range_make(size : Int) -> DstreesegmentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_range_len(s : DstreesegmentRange) -> Int { s.size }

pub fn ds_tree_segment_range_get(s : DstreesegmentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_range_set(s : DstreesegmentRange, i : Int, v : Double) -> DstreesegmentRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_range_sum(s : DstreesegmentRange) -> Double { @_common.sum(s.data) }

pub fn ds_tree_segment_range_mean(s : DstreesegmentRange) -> Double { @_common.mean(s.data) }

pub fn ds_tree_segment_range_scale(s : DstreesegmentRange, f : Double) -> DstreesegmentRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_range_add(a : DstreesegmentRange, b : DstreesegmentRange) -> DstreesegmentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_segment_range_copy(s : DstreesegmentRange) -> DstreesegmentRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_range_fill(s : DstreesegmentRange, v : Double) -> DstreesegmentRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_range_min(s : DstreesegmentRange) -> Double { @_common.min(s.data) }

pub fn ds_tree_segment_range_max(s : DstreesegmentRange) -> Double { @_common.max(s.data) }

pub fn ds_tree_segment_range_to_string(s : DstreesegmentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreesegmentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_segment_slice_make(size : Int) -> DstreesegmentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_segment_slice_len(s : DstreesegmentSlice) -> Int { s.size }

pub fn ds_tree_segment_slice_get(s : DstreesegmentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_segment_slice_set(s : DstreesegmentSlice, i : Int, v : Double) -> DstreesegmentSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_slice_sum(s : DstreesegmentSlice) -> Double { @_common.sum(s.data) }

pub fn ds_tree_segment_slice_mean(s : DstreesegmentSlice) -> Double { @_common.mean(s.data) }

pub fn ds_tree_segment_slice_scale(s : DstreesegmentSlice, f : Double) -> DstreesegmentSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_slice_add(a : DstreesegmentSlice, b : DstreesegmentSlice) -> DstreesegmentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_segment_slice_copy(s : DstreesegmentSlice) -> DstreesegmentSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_slice_fill(s : DstreesegmentSlice, v : Double) -> DstreesegmentSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_segment_slice_min(s : DstreesegmentSlice) -> Double { @_common.min(s.data) }

pub fn ds_tree_segment_slice_max(s : DstreesegmentSlice) -> Double { @_common.max(s.data) }

pub fn ds_tree_segment_slice_to_string(s : DstreesegmentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

