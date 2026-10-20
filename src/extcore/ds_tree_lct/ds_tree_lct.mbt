///===
/// extcore/ds_tree_lct

pub(all) struct DstreelctPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_lct_make_point(x : Double, y : Double) -> DstreelctPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_lct_make_point3(x : Double, y : Double, z : Double) -> DstreelctPoint {
  { x, y, z, label: 0 }
}

pub fn DstreelctPoint::x(self : DstreelctPoint) -> Double { self.x }

pub fn DstreelctPoint::y(self : DstreelctPoint) -> Double { self.y }

pub fn DstreelctPoint::z(self : DstreelctPoint) -> Double { self.z }

pub fn DstreelctPoint::label(self : DstreelctPoint) -> Int { self.label }

pub fn DstreelctPoint::dist(self : DstreelctPoint, other : DstreelctPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreelctPoint::add(self : DstreelctPoint, other : DstreelctPoint) -> DstreelctPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreelctPoint::sub(self : DstreelctPoint, other : DstreelctPoint) -> DstreelctPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreelctPoint::scale(self : DstreelctPoint, s : Double) -> DstreelctPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreelctPoint::dot(self : DstreelctPoint, other : DstreelctPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreelctPoint::cross(self : DstreelctPoint, other : DstreelctPoint) -> DstreelctPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreelctPoint::norm(self : DstreelctPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreelctPoint::normalize(self : DstreelctPoint) -> DstreelctPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreelctPoint::negate(self : DstreelctPoint) -> DstreelctPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreelctPoint::mid(self : DstreelctPoint, other : DstreelctPoint) -> DstreelctPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreelctPoint::lerp(self : DstreelctPoint, other : DstreelctPoint, t : Double) -> DstreelctPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreelctPoint::to_string(self : DstreelctPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreelctSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_lct_make_series(vals : Array[Double], name : String) -> DstreelctSeries {
  { vals, name, meta: 0 }
}

pub fn DstreelctSeries::len(self : DstreelctSeries) -> Int { self.vals.length() }

pub fn DstreelctSeries::sum(self : DstreelctSeries) -> Double { @_common.sum(self.vals) }

pub fn DstreelctSeries::mean(self : DstreelctSeries) -> Double { @_common.mean(self.vals) }

pub fn DstreelctSeries::min(self : DstreelctSeries) -> Double { @_common.min(self.vals) }

pub fn DstreelctSeries::max(self : DstreelctSeries) -> Double { @_common.max(self.vals) }

pub fn DstreelctSeries::range(self : DstreelctSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreelctSeries::variance(self : DstreelctSeries) -> Double { @_common.variance(self.vals) }

pub fn DstreelctSeries::std(self : DstreelctSeries) -> Double { @_common.std(self.vals) }

pub fn DstreelctSeries::median(self : DstreelctSeries) -> Double { @_common.median(self.vals) }

pub fn DstreelctSeries::scale(self : DstreelctSeries, f : Double) -> DstreelctSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreelctSeries::add(self : DstreelctSeries, other : DstreelctSeries) -> DstreelctSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreelctSeries::sub(self : DstreelctSeries, other : DstreelctSeries) -> DstreelctSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreelctSeries::normalize(self : DstreelctSeries) -> DstreelctSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreelctSeries::cumsum(self : DstreelctSeries) -> DstreelctSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreelctSeries::to_string(self : DstreelctSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreelctMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_lct_make_matrix(rows : Int, cols : Int, val : Double) -> DstreelctMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_lct_matrix_identity(n : Int) -> DstreelctMatrix {
  let m = ds_tree_lct_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreelctMatrix::get(self : DstreelctMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreelctMatrix::transpose(self : DstreelctMatrix) -> DstreelctMatrix {
  let result = ds_tree_lct_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreelctMatrix::add(self : DstreelctMatrix, other : DstreelctMatrix) -> DstreelctMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_lct_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreelctMatrix::scale(self : DstreelctMatrix, s : Double) -> DstreelctMatrix {
  let result = ds_tree_lct_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreelctMatrix::multiply(self : DstreelctMatrix, other : DstreelctMatrix) -> DstreelctMatrix {
  if self.cols != other.rows { return ds_tree_lct_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_lct_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DstreelctMatrix::trace(self : DstreelctMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreelctMatrix::det(self : DstreelctMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreelctMatrix::norm(self : DstreelctMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreelctMatrix::to_string(self : DstreelctMatrix) -> String {
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

pub(all) struct DstreelctVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_lct_make_vector(comps : Array[Double]) -> DstreelctVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_lct_vector_zero(dim : Int) -> DstreelctVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreelctVector::add(self : DstreelctVector, other : DstreelctVector) -> DstreelctVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreelctVector::sub(self : DstreelctVector, other : DstreelctVector) -> DstreelctVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreelctVector::scale(self : DstreelctVector, s : Double) -> DstreelctVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreelctVector::dot(self : DstreelctVector, other : DstreelctVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreelctVector::norm(self : DstreelctVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreelctVector::normalize(self : DstreelctVector) -> DstreelctVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreelctVector::dist(self : DstreelctVector, other : DstreelctVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreelctVector::to_string(self : DstreelctVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_lct_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_lct_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_lct_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_lct_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_lct_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_lct_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_lct_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_lct_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_lct_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_lct_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_lct_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_lct_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_lct_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_lct_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_lct_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_lct_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_lct_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_lct_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_lct_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_lct_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_lct_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_lct_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_lct_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_lct_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_lct_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_lct_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_lct_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_lct_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_lct_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreelctFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_frame_make(size : Int) -> DstreelctFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_frame_len(s : DstreelctFrame) -> Int { s.size }

pub fn ds_tree_lct_frame_get(s : DstreelctFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_frame_set(s : DstreelctFrame, i : Int, v : Double) -> DstreelctFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_frame_sum(s : DstreelctFrame) -> Double { @_common.sum(s.data) }

pub fn ds_tree_lct_frame_mean(s : DstreelctFrame) -> Double { @_common.mean(s.data) }

pub fn ds_tree_lct_frame_scale(s : DstreelctFrame, f : Double) -> DstreelctFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_frame_add(a : DstreelctFrame, b : DstreelctFrame) -> DstreelctFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_lct_frame_copy(s : DstreelctFrame) -> DstreelctFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_frame_fill(s : DstreelctFrame, v : Double) -> DstreelctFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_frame_min(s : DstreelctFrame) -> Double { @_common.min(s.data) }

pub fn ds_tree_lct_frame_max(s : DstreelctFrame) -> Double { @_common.max(s.data) }

pub fn ds_tree_lct_frame_to_string(s : DstreelctFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_table_make(size : Int) -> DstreelctTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_table_len(s : DstreelctTable) -> Int { s.size }

pub fn ds_tree_lct_table_get(s : DstreelctTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_table_set(s : DstreelctTable, i : Int, v : Double) -> DstreelctTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_table_sum(s : DstreelctTable) -> Double { @_common.sum(s.data) }

pub fn ds_tree_lct_table_mean(s : DstreelctTable) -> Double { @_common.mean(s.data) }

pub fn ds_tree_lct_table_scale(s : DstreelctTable, f : Double) -> DstreelctTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_table_add(a : DstreelctTable, b : DstreelctTable) -> DstreelctTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_lct_table_copy(s : DstreelctTable) -> DstreelctTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_table_fill(s : DstreelctTable, v : Double) -> DstreelctTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_table_min(s : DstreelctTable) -> Double { @_common.min(s.data) }

pub fn ds_tree_lct_table_max(s : DstreelctTable) -> Double { @_common.max(s.data) }

pub fn ds_tree_lct_table_to_string(s : DstreelctTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_graphn_make(size : Int) -> DstreelctGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_graphn_len(s : DstreelctGraphN) -> Int { s.size }

pub fn ds_tree_lct_graphn_get(s : DstreelctGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_graphn_set(s : DstreelctGraphN, i : Int, v : Double) -> DstreelctGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_graphn_sum(s : DstreelctGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_tree_lct_graphn_mean(s : DstreelctGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_tree_lct_graphn_scale(s : DstreelctGraphN, f : Double) -> DstreelctGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_graphn_add(a : DstreelctGraphN, b : DstreelctGraphN) -> DstreelctGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_lct_graphn_copy(s : DstreelctGraphN) -> DstreelctGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_graphn_fill(s : DstreelctGraphN, v : Double) -> DstreelctGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_graphn_min(s : DstreelctGraphN) -> Double { @_common.min(s.data) }

pub fn ds_tree_lct_graphn_max(s : DstreelctGraphN) -> Double { @_common.max(s.data) }

pub fn ds_tree_lct_graphn_to_string(s : DstreelctGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_node_make(size : Int) -> DstreelctNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_node_len(s : DstreelctNode) -> Int { s.size }

pub fn ds_tree_lct_node_get(s : DstreelctNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_node_set(s : DstreelctNode, i : Int, v : Double) -> DstreelctNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_node_sum(s : DstreelctNode) -> Double { @_common.sum(s.data) }

pub fn ds_tree_lct_node_mean(s : DstreelctNode) -> Double { @_common.mean(s.data) }

pub fn ds_tree_lct_node_scale(s : DstreelctNode, f : Double) -> DstreelctNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_node_add(a : DstreelctNode, b : DstreelctNode) -> DstreelctNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_lct_node_copy(s : DstreelctNode) -> DstreelctNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_node_fill(s : DstreelctNode, v : Double) -> DstreelctNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_node_min(s : DstreelctNode) -> Double { @_common.min(s.data) }

pub fn ds_tree_lct_node_max(s : DstreelctNode) -> Double { @_common.max(s.data) }

pub fn ds_tree_lct_node_to_string(s : DstreelctNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_edge_make(size : Int) -> DstreelctEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_edge_len(s : DstreelctEdge) -> Int { s.size }

pub fn ds_tree_lct_edge_get(s : DstreelctEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_edge_set(s : DstreelctEdge, i : Int, v : Double) -> DstreelctEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_edge_sum(s : DstreelctEdge) -> Double { @_common.sum(s.data) }

pub fn ds_tree_lct_edge_mean(s : DstreelctEdge) -> Double { @_common.mean(s.data) }

pub fn ds_tree_lct_edge_scale(s : DstreelctEdge, f : Double) -> DstreelctEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_edge_add(a : DstreelctEdge, b : DstreelctEdge) -> DstreelctEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_lct_edge_copy(s : DstreelctEdge) -> DstreelctEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_edge_fill(s : DstreelctEdge, v : Double) -> DstreelctEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_edge_min(s : DstreelctEdge) -> Double { @_common.min(s.data) }

pub fn ds_tree_lct_edge_max(s : DstreelctEdge) -> Double { @_common.max(s.data) }

pub fn ds_tree_lct_edge_to_string(s : DstreelctEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_path_make(size : Int) -> DstreelctPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_path_len(s : DstreelctPath) -> Int { s.size }

pub fn ds_tree_lct_path_get(s : DstreelctPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_path_set(s : DstreelctPath, i : Int, v : Double) -> DstreelctPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_path_sum(s : DstreelctPath) -> Double { @_common.sum(s.data) }

pub fn ds_tree_lct_path_mean(s : DstreelctPath) -> Double { @_common.mean(s.data) }

pub fn ds_tree_lct_path_scale(s : DstreelctPath, f : Double) -> DstreelctPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_path_add(a : DstreelctPath, b : DstreelctPath) -> DstreelctPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_lct_path_copy(s : DstreelctPath) -> DstreelctPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_path_fill(s : DstreelctPath, v : Double) -> DstreelctPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_path_min(s : DstreelctPath) -> Double { @_common.min(s.data) }

pub fn ds_tree_lct_path_max(s : DstreelctPath) -> Double { @_common.max(s.data) }

pub fn ds_tree_lct_path_to_string(s : DstreelctPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_cluster_make(size : Int) -> DstreelctCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_cluster_len(s : DstreelctCluster) -> Int { s.size }

pub fn ds_tree_lct_cluster_get(s : DstreelctCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_cluster_set(s : DstreelctCluster, i : Int, v : Double) -> DstreelctCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_cluster_sum(s : DstreelctCluster) -> Double { @_common.sum(s.data) }

pub fn ds_tree_lct_cluster_mean(s : DstreelctCluster) -> Double { @_common.mean(s.data) }

pub fn ds_tree_lct_cluster_scale(s : DstreelctCluster, f : Double) -> DstreelctCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_cluster_add(a : DstreelctCluster, b : DstreelctCluster) -> DstreelctCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_lct_cluster_copy(s : DstreelctCluster) -> DstreelctCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_cluster_fill(s : DstreelctCluster, v : Double) -> DstreelctCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_cluster_min(s : DstreelctCluster) -> Double { @_common.min(s.data) }

pub fn ds_tree_lct_cluster_max(s : DstreelctCluster) -> Double { @_common.max(s.data) }

pub fn ds_tree_lct_cluster_to_string(s : DstreelctCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_model_make(size : Int) -> DstreelctModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_model_len(s : DstreelctModel) -> Int { s.size }

pub fn ds_tree_lct_model_get(s : DstreelctModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_model_set(s : DstreelctModel, i : Int, v : Double) -> DstreelctModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_model_sum(s : DstreelctModel) -> Double { @_common.sum(s.data) }

pub fn ds_tree_lct_model_mean(s : DstreelctModel) -> Double { @_common.mean(s.data) }

pub fn ds_tree_lct_model_scale(s : DstreelctModel, f : Double) -> DstreelctModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_model_add(a : DstreelctModel, b : DstreelctModel) -> DstreelctModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_lct_model_copy(s : DstreelctModel) -> DstreelctModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_model_fill(s : DstreelctModel, v : Double) -> DstreelctModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_model_min(s : DstreelctModel) -> Double { @_common.min(s.data) }

pub fn ds_tree_lct_model_max(s : DstreelctModel) -> Double { @_common.max(s.data) }

pub fn ds_tree_lct_model_to_string(s : DstreelctModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_layer_make(size : Int) -> DstreelctLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_layer_len(s : DstreelctLayer) -> Int { s.size }

pub fn ds_tree_lct_layer_get(s : DstreelctLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_layer_set(s : DstreelctLayer, i : Int, v : Double) -> DstreelctLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_layer_sum(s : DstreelctLayer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_lct_layer_mean(s : DstreelctLayer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_lct_layer_scale(s : DstreelctLayer, f : Double) -> DstreelctLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_layer_add(a : DstreelctLayer, b : DstreelctLayer) -> DstreelctLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_lct_layer_copy(s : DstreelctLayer) -> DstreelctLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_layer_fill(s : DstreelctLayer, v : Double) -> DstreelctLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_layer_min(s : DstreelctLayer) -> Double { @_common.min(s.data) }

pub fn ds_tree_lct_layer_max(s : DstreelctLayer) -> Double { @_common.max(s.data) }

pub fn ds_tree_lct_layer_to_string(s : DstreelctLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_buffer_make(size : Int) -> DstreelctBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_buffer_len(s : DstreelctBuffer) -> Int { s.size }

pub fn ds_tree_lct_buffer_get(s : DstreelctBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_buffer_set(s : DstreelctBuffer, i : Int, v : Double) -> DstreelctBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_buffer_sum(s : DstreelctBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_lct_buffer_mean(s : DstreelctBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_lct_buffer_scale(s : DstreelctBuffer, f : Double) -> DstreelctBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_buffer_add(a : DstreelctBuffer, b : DstreelctBuffer) -> DstreelctBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_lct_buffer_copy(s : DstreelctBuffer) -> DstreelctBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_buffer_fill(s : DstreelctBuffer, v : Double) -> DstreelctBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_buffer_min(s : DstreelctBuffer) -> Double { @_common.min(s.data) }

pub fn ds_tree_lct_buffer_max(s : DstreelctBuffer) -> Double { @_common.max(s.data) }

pub fn ds_tree_lct_buffer_to_string(s : DstreelctBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_cursor_make(size : Int) -> DstreelctCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_cursor_len(s : DstreelctCursor) -> Int { s.size }

pub fn ds_tree_lct_cursor_get(s : DstreelctCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_cursor_set(s : DstreelctCursor, i : Int, v : Double) -> DstreelctCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_cursor_sum(s : DstreelctCursor) -> Double { @_common.sum(s.data) }

pub fn ds_tree_lct_cursor_mean(s : DstreelctCursor) -> Double { @_common.mean(s.data) }

pub fn ds_tree_lct_cursor_scale(s : DstreelctCursor, f : Double) -> DstreelctCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_cursor_add(a : DstreelctCursor, b : DstreelctCursor) -> DstreelctCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_lct_cursor_copy(s : DstreelctCursor) -> DstreelctCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_cursor_fill(s : DstreelctCursor, v : Double) -> DstreelctCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_cursor_min(s : DstreelctCursor) -> Double { @_common.min(s.data) }

pub fn ds_tree_lct_cursor_max(s : DstreelctCursor) -> Double { @_common.max(s.data) }

pub fn ds_tree_lct_cursor_to_string(s : DstreelctCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_view_make(size : Int) -> DstreelctView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_view_len(s : DstreelctView) -> Int { s.size }

pub fn ds_tree_lct_view_get(s : DstreelctView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_view_set(s : DstreelctView, i : Int, v : Double) -> DstreelctView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_view_sum(s : DstreelctView) -> Double { @_common.sum(s.data) }

pub fn ds_tree_lct_view_mean(s : DstreelctView) -> Double { @_common.mean(s.data) }

pub fn ds_tree_lct_view_scale(s : DstreelctView, f : Double) -> DstreelctView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_view_add(a : DstreelctView, b : DstreelctView) -> DstreelctView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_lct_view_copy(s : DstreelctView) -> DstreelctView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_view_fill(s : DstreelctView, v : Double) -> DstreelctView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_view_min(s : DstreelctView) -> Double { @_common.min(s.data) }

pub fn ds_tree_lct_view_max(s : DstreelctView) -> Double { @_common.max(s.data) }

pub fn ds_tree_lct_view_to_string(s : DstreelctView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_range_make(size : Int) -> DstreelctRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_range_len(s : DstreelctRange) -> Int { s.size }

pub fn ds_tree_lct_range_get(s : DstreelctRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_range_set(s : DstreelctRange, i : Int, v : Double) -> DstreelctRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_range_sum(s : DstreelctRange) -> Double { @_common.sum(s.data) }

pub fn ds_tree_lct_range_mean(s : DstreelctRange) -> Double { @_common.mean(s.data) }

pub fn ds_tree_lct_range_scale(s : DstreelctRange, f : Double) -> DstreelctRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_range_add(a : DstreelctRange, b : DstreelctRange) -> DstreelctRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_lct_range_copy(s : DstreelctRange) -> DstreelctRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_range_fill(s : DstreelctRange, v : Double) -> DstreelctRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_range_min(s : DstreelctRange) -> Double { @_common.min(s.data) }

pub fn ds_tree_lct_range_max(s : DstreelctRange) -> Double { @_common.max(s.data) }

pub fn ds_tree_lct_range_to_string(s : DstreelctRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreelctSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_lct_slice_make(size : Int) -> DstreelctSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_lct_slice_len(s : DstreelctSlice) -> Int { s.size }

pub fn ds_tree_lct_slice_get(s : DstreelctSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_lct_slice_set(s : DstreelctSlice, i : Int, v : Double) -> DstreelctSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_slice_sum(s : DstreelctSlice) -> Double { @_common.sum(s.data) }

pub fn ds_tree_lct_slice_mean(s : DstreelctSlice) -> Double { @_common.mean(s.data) }

pub fn ds_tree_lct_slice_scale(s : DstreelctSlice, f : Double) -> DstreelctSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_slice_add(a : DstreelctSlice, b : DstreelctSlice) -> DstreelctSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_lct_slice_copy(s : DstreelctSlice) -> DstreelctSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_slice_fill(s : DstreelctSlice, v : Double) -> DstreelctSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_lct_slice_min(s : DstreelctSlice) -> Double { @_common.min(s.data) }

pub fn ds_tree_lct_slice_max(s : DstreelctSlice) -> Double { @_common.max(s.data) }

pub fn ds_tree_lct_slice_to_string(s : DstreelctSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

