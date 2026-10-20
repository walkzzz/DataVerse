///===
/// extcore/ds_tree_redblack

pub(all) struct DstreeredblackPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_redblack_make_point(x : Double, y : Double) -> DstreeredblackPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_redblack_make_point3(x : Double, y : Double, z : Double) -> DstreeredblackPoint {
  { x, y, z, label: 0 }
}

pub fn DstreeredblackPoint::x(self : DstreeredblackPoint) -> Double { self.x }

pub fn DstreeredblackPoint::y(self : DstreeredblackPoint) -> Double { self.y }

pub fn DstreeredblackPoint::z(self : DstreeredblackPoint) -> Double { self.z }

pub fn DstreeredblackPoint::label(self : DstreeredblackPoint) -> Int { self.label }

pub fn DstreeredblackPoint::dist(self : DstreeredblackPoint, other : DstreeredblackPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreeredblackPoint::add(self : DstreeredblackPoint, other : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreeredblackPoint::sub(self : DstreeredblackPoint, other : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreeredblackPoint::scale(self : DstreeredblackPoint, s : Double) -> DstreeredblackPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreeredblackPoint::dot(self : DstreeredblackPoint, other : DstreeredblackPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreeredblackPoint::cross(self : DstreeredblackPoint, other : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreeredblackPoint::norm(self : DstreeredblackPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreeredblackPoint::normalize(self : DstreeredblackPoint) -> DstreeredblackPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreeredblackPoint::negate(self : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreeredblackPoint::mid(self : DstreeredblackPoint, other : DstreeredblackPoint) -> DstreeredblackPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreeredblackPoint::lerp(self : DstreeredblackPoint, other : DstreeredblackPoint, t : Double) -> DstreeredblackPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreeredblackPoint::to_string(self : DstreeredblackPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreeredblackSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_redblack_make_series(vals : Array[Double], name : String) -> DstreeredblackSeries {
  { vals, name, meta: 0 }
}

pub fn DstreeredblackSeries::len(self : DstreeredblackSeries) -> Int { self.vals.length() }

pub fn DstreeredblackSeries::sum(self : DstreeredblackSeries) -> Double { @_common.sum(self.vals) }

pub fn DstreeredblackSeries::mean(self : DstreeredblackSeries) -> Double { @_common.mean(self.vals) }

pub fn DstreeredblackSeries::min(self : DstreeredblackSeries) -> Double { @_common.min(self.vals) }

pub fn DstreeredblackSeries::max(self : DstreeredblackSeries) -> Double { @_common.max(self.vals) }

pub fn DstreeredblackSeries::range(self : DstreeredblackSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreeredblackSeries::variance(self : DstreeredblackSeries) -> Double { @_common.variance(self.vals) }

pub fn DstreeredblackSeries::std(self : DstreeredblackSeries) -> Double { @_common.std(self.vals) }

pub fn DstreeredblackSeries::median(self : DstreeredblackSeries) -> Double { @_common.median(self.vals) }

pub fn DstreeredblackSeries::scale(self : DstreeredblackSeries, f : Double) -> DstreeredblackSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreeredblackSeries::add(self : DstreeredblackSeries, other : DstreeredblackSeries) -> DstreeredblackSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreeredblackSeries::sub(self : DstreeredblackSeries, other : DstreeredblackSeries) -> DstreeredblackSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreeredblackSeries::normalize(self : DstreeredblackSeries) -> DstreeredblackSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreeredblackSeries::cumsum(self : DstreeredblackSeries) -> DstreeredblackSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreeredblackSeries::to_string(self : DstreeredblackSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreeredblackMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_redblack_make_matrix(rows : Int, cols : Int, val : Double) -> DstreeredblackMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_redblack_matrix_identity(n : Int) -> DstreeredblackMatrix {
  let m = ds_tree_redblack_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreeredblackMatrix::get(self : DstreeredblackMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreeredblackMatrix::transpose(self : DstreeredblackMatrix) -> DstreeredblackMatrix {
  let result = ds_tree_redblack_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreeredblackMatrix::add(self : DstreeredblackMatrix, other : DstreeredblackMatrix) -> DstreeredblackMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_redblack_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreeredblackMatrix::scale(self : DstreeredblackMatrix, s : Double) -> DstreeredblackMatrix {
  let result = ds_tree_redblack_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreeredblackMatrix::multiply(self : DstreeredblackMatrix, other : DstreeredblackMatrix) -> DstreeredblackMatrix {
  if self.cols != other.rows { return ds_tree_redblack_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_redblack_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DstreeredblackMatrix::trace(self : DstreeredblackMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreeredblackMatrix::det(self : DstreeredblackMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreeredblackMatrix::norm(self : DstreeredblackMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreeredblackMatrix::to_string(self : DstreeredblackMatrix) -> String {
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

pub(all) struct DstreeredblackVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_redblack_make_vector(comps : Array[Double]) -> DstreeredblackVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_redblack_vector_zero(dim : Int) -> DstreeredblackVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreeredblackVector::add(self : DstreeredblackVector, other : DstreeredblackVector) -> DstreeredblackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreeredblackVector::sub(self : DstreeredblackVector, other : DstreeredblackVector) -> DstreeredblackVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreeredblackVector::scale(self : DstreeredblackVector, s : Double) -> DstreeredblackVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreeredblackVector::dot(self : DstreeredblackVector, other : DstreeredblackVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreeredblackVector::norm(self : DstreeredblackVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreeredblackVector::normalize(self : DstreeredblackVector) -> DstreeredblackVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreeredblackVector::dist(self : DstreeredblackVector, other : DstreeredblackVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreeredblackVector::to_string(self : DstreeredblackVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_redblack_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_redblack_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_redblack_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_redblack_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_redblack_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_redblack_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_redblack_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_redblack_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_redblack_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_redblack_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_redblack_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_redblack_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_redblack_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_redblack_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_redblack_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_redblack_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_redblack_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_redblack_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_redblack_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_redblack_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_redblack_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_redblack_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_redblack_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_redblack_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_redblack_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_redblack_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_redblack_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_redblack_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_redblack_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreeredblackFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_frame_make(size : Int) -> DstreeredblackFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_frame_len(s : DstreeredblackFrame) -> Int { s.size }

pub fn ds_tree_redblack_frame_get(s : DstreeredblackFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_frame_set(s : DstreeredblackFrame, i : Int, v : Double) -> DstreeredblackFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_frame_sum(s : DstreeredblackFrame) -> Double { @_common.sum(s.data) }

pub fn ds_tree_redblack_frame_mean(s : DstreeredblackFrame) -> Double { @_common.mean(s.data) }

pub fn ds_tree_redblack_frame_scale(s : DstreeredblackFrame, f : Double) -> DstreeredblackFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_frame_add(a : DstreeredblackFrame, b : DstreeredblackFrame) -> DstreeredblackFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_redblack_frame_copy(s : DstreeredblackFrame) -> DstreeredblackFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_frame_fill(s : DstreeredblackFrame, v : Double) -> DstreeredblackFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_frame_min(s : DstreeredblackFrame) -> Double { @_common.min(s.data) }

pub fn ds_tree_redblack_frame_max(s : DstreeredblackFrame) -> Double { @_common.max(s.data) }

pub fn ds_tree_redblack_frame_to_string(s : DstreeredblackFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_table_make(size : Int) -> DstreeredblackTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_table_len(s : DstreeredblackTable) -> Int { s.size }

pub fn ds_tree_redblack_table_get(s : DstreeredblackTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_table_set(s : DstreeredblackTable, i : Int, v : Double) -> DstreeredblackTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_table_sum(s : DstreeredblackTable) -> Double { @_common.sum(s.data) }

pub fn ds_tree_redblack_table_mean(s : DstreeredblackTable) -> Double { @_common.mean(s.data) }

pub fn ds_tree_redblack_table_scale(s : DstreeredblackTable, f : Double) -> DstreeredblackTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_table_add(a : DstreeredblackTable, b : DstreeredblackTable) -> DstreeredblackTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_redblack_table_copy(s : DstreeredblackTable) -> DstreeredblackTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_table_fill(s : DstreeredblackTable, v : Double) -> DstreeredblackTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_table_min(s : DstreeredblackTable) -> Double { @_common.min(s.data) }

pub fn ds_tree_redblack_table_max(s : DstreeredblackTable) -> Double { @_common.max(s.data) }

pub fn ds_tree_redblack_table_to_string(s : DstreeredblackTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_graphn_make(size : Int) -> DstreeredblackGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_graphn_len(s : DstreeredblackGraphN) -> Int { s.size }

pub fn ds_tree_redblack_graphn_get(s : DstreeredblackGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_graphn_set(s : DstreeredblackGraphN, i : Int, v : Double) -> DstreeredblackGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_graphn_sum(s : DstreeredblackGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_tree_redblack_graphn_mean(s : DstreeredblackGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_tree_redblack_graphn_scale(s : DstreeredblackGraphN, f : Double) -> DstreeredblackGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_graphn_add(a : DstreeredblackGraphN, b : DstreeredblackGraphN) -> DstreeredblackGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_redblack_graphn_copy(s : DstreeredblackGraphN) -> DstreeredblackGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_graphn_fill(s : DstreeredblackGraphN, v : Double) -> DstreeredblackGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_graphn_min(s : DstreeredblackGraphN) -> Double { @_common.min(s.data) }

pub fn ds_tree_redblack_graphn_max(s : DstreeredblackGraphN) -> Double { @_common.max(s.data) }

pub fn ds_tree_redblack_graphn_to_string(s : DstreeredblackGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_node_make(size : Int) -> DstreeredblackNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_node_len(s : DstreeredblackNode) -> Int { s.size }

pub fn ds_tree_redblack_node_get(s : DstreeredblackNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_node_set(s : DstreeredblackNode, i : Int, v : Double) -> DstreeredblackNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_node_sum(s : DstreeredblackNode) -> Double { @_common.sum(s.data) }

pub fn ds_tree_redblack_node_mean(s : DstreeredblackNode) -> Double { @_common.mean(s.data) }

pub fn ds_tree_redblack_node_scale(s : DstreeredblackNode, f : Double) -> DstreeredblackNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_node_add(a : DstreeredblackNode, b : DstreeredblackNode) -> DstreeredblackNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_redblack_node_copy(s : DstreeredblackNode) -> DstreeredblackNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_node_fill(s : DstreeredblackNode, v : Double) -> DstreeredblackNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_node_min(s : DstreeredblackNode) -> Double { @_common.min(s.data) }

pub fn ds_tree_redblack_node_max(s : DstreeredblackNode) -> Double { @_common.max(s.data) }

pub fn ds_tree_redblack_node_to_string(s : DstreeredblackNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_edge_make(size : Int) -> DstreeredblackEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_edge_len(s : DstreeredblackEdge) -> Int { s.size }

pub fn ds_tree_redblack_edge_get(s : DstreeredblackEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_edge_set(s : DstreeredblackEdge, i : Int, v : Double) -> DstreeredblackEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_edge_sum(s : DstreeredblackEdge) -> Double { @_common.sum(s.data) }

pub fn ds_tree_redblack_edge_mean(s : DstreeredblackEdge) -> Double { @_common.mean(s.data) }

pub fn ds_tree_redblack_edge_scale(s : DstreeredblackEdge, f : Double) -> DstreeredblackEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_edge_add(a : DstreeredblackEdge, b : DstreeredblackEdge) -> DstreeredblackEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_redblack_edge_copy(s : DstreeredblackEdge) -> DstreeredblackEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_edge_fill(s : DstreeredblackEdge, v : Double) -> DstreeredblackEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_edge_min(s : DstreeredblackEdge) -> Double { @_common.min(s.data) }

pub fn ds_tree_redblack_edge_max(s : DstreeredblackEdge) -> Double { @_common.max(s.data) }

pub fn ds_tree_redblack_edge_to_string(s : DstreeredblackEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_path_make(size : Int) -> DstreeredblackPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_path_len(s : DstreeredblackPath) -> Int { s.size }

pub fn ds_tree_redblack_path_get(s : DstreeredblackPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_path_set(s : DstreeredblackPath, i : Int, v : Double) -> DstreeredblackPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_path_sum(s : DstreeredblackPath) -> Double { @_common.sum(s.data) }

pub fn ds_tree_redblack_path_mean(s : DstreeredblackPath) -> Double { @_common.mean(s.data) }

pub fn ds_tree_redblack_path_scale(s : DstreeredblackPath, f : Double) -> DstreeredblackPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_path_add(a : DstreeredblackPath, b : DstreeredblackPath) -> DstreeredblackPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_redblack_path_copy(s : DstreeredblackPath) -> DstreeredblackPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_path_fill(s : DstreeredblackPath, v : Double) -> DstreeredblackPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_path_min(s : DstreeredblackPath) -> Double { @_common.min(s.data) }

pub fn ds_tree_redblack_path_max(s : DstreeredblackPath) -> Double { @_common.max(s.data) }

pub fn ds_tree_redblack_path_to_string(s : DstreeredblackPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_cluster_make(size : Int) -> DstreeredblackCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_cluster_len(s : DstreeredblackCluster) -> Int { s.size }

pub fn ds_tree_redblack_cluster_get(s : DstreeredblackCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_cluster_set(s : DstreeredblackCluster, i : Int, v : Double) -> DstreeredblackCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_cluster_sum(s : DstreeredblackCluster) -> Double { @_common.sum(s.data) }

pub fn ds_tree_redblack_cluster_mean(s : DstreeredblackCluster) -> Double { @_common.mean(s.data) }

pub fn ds_tree_redblack_cluster_scale(s : DstreeredblackCluster, f : Double) -> DstreeredblackCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_cluster_add(a : DstreeredblackCluster, b : DstreeredblackCluster) -> DstreeredblackCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_redblack_cluster_copy(s : DstreeredblackCluster) -> DstreeredblackCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_cluster_fill(s : DstreeredblackCluster, v : Double) -> DstreeredblackCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_cluster_min(s : DstreeredblackCluster) -> Double { @_common.min(s.data) }

pub fn ds_tree_redblack_cluster_max(s : DstreeredblackCluster) -> Double { @_common.max(s.data) }

pub fn ds_tree_redblack_cluster_to_string(s : DstreeredblackCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_model_make(size : Int) -> DstreeredblackModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_model_len(s : DstreeredblackModel) -> Int { s.size }

pub fn ds_tree_redblack_model_get(s : DstreeredblackModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_model_set(s : DstreeredblackModel, i : Int, v : Double) -> DstreeredblackModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_model_sum(s : DstreeredblackModel) -> Double { @_common.sum(s.data) }

pub fn ds_tree_redblack_model_mean(s : DstreeredblackModel) -> Double { @_common.mean(s.data) }

pub fn ds_tree_redblack_model_scale(s : DstreeredblackModel, f : Double) -> DstreeredblackModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_model_add(a : DstreeredblackModel, b : DstreeredblackModel) -> DstreeredblackModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_redblack_model_copy(s : DstreeredblackModel) -> DstreeredblackModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_model_fill(s : DstreeredblackModel, v : Double) -> DstreeredblackModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_model_min(s : DstreeredblackModel) -> Double { @_common.min(s.data) }

pub fn ds_tree_redblack_model_max(s : DstreeredblackModel) -> Double { @_common.max(s.data) }

pub fn ds_tree_redblack_model_to_string(s : DstreeredblackModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_layer_make(size : Int) -> DstreeredblackLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_layer_len(s : DstreeredblackLayer) -> Int { s.size }

pub fn ds_tree_redblack_layer_get(s : DstreeredblackLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_layer_set(s : DstreeredblackLayer, i : Int, v : Double) -> DstreeredblackLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_layer_sum(s : DstreeredblackLayer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_redblack_layer_mean(s : DstreeredblackLayer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_redblack_layer_scale(s : DstreeredblackLayer, f : Double) -> DstreeredblackLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_layer_add(a : DstreeredblackLayer, b : DstreeredblackLayer) -> DstreeredblackLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_redblack_layer_copy(s : DstreeredblackLayer) -> DstreeredblackLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_layer_fill(s : DstreeredblackLayer, v : Double) -> DstreeredblackLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_layer_min(s : DstreeredblackLayer) -> Double { @_common.min(s.data) }

pub fn ds_tree_redblack_layer_max(s : DstreeredblackLayer) -> Double { @_common.max(s.data) }

pub fn ds_tree_redblack_layer_to_string(s : DstreeredblackLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_buffer_make(size : Int) -> DstreeredblackBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_buffer_len(s : DstreeredblackBuffer) -> Int { s.size }

pub fn ds_tree_redblack_buffer_get(s : DstreeredblackBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_buffer_set(s : DstreeredblackBuffer, i : Int, v : Double) -> DstreeredblackBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_buffer_sum(s : DstreeredblackBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_redblack_buffer_mean(s : DstreeredblackBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_redblack_buffer_scale(s : DstreeredblackBuffer, f : Double) -> DstreeredblackBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_buffer_add(a : DstreeredblackBuffer, b : DstreeredblackBuffer) -> DstreeredblackBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_redblack_buffer_copy(s : DstreeredblackBuffer) -> DstreeredblackBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_buffer_fill(s : DstreeredblackBuffer, v : Double) -> DstreeredblackBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_buffer_min(s : DstreeredblackBuffer) -> Double { @_common.min(s.data) }

pub fn ds_tree_redblack_buffer_max(s : DstreeredblackBuffer) -> Double { @_common.max(s.data) }

pub fn ds_tree_redblack_buffer_to_string(s : DstreeredblackBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_cursor_make(size : Int) -> DstreeredblackCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_cursor_len(s : DstreeredblackCursor) -> Int { s.size }

pub fn ds_tree_redblack_cursor_get(s : DstreeredblackCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_cursor_set(s : DstreeredblackCursor, i : Int, v : Double) -> DstreeredblackCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_cursor_sum(s : DstreeredblackCursor) -> Double { @_common.sum(s.data) }

pub fn ds_tree_redblack_cursor_mean(s : DstreeredblackCursor) -> Double { @_common.mean(s.data) }

pub fn ds_tree_redblack_cursor_scale(s : DstreeredblackCursor, f : Double) -> DstreeredblackCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_cursor_add(a : DstreeredblackCursor, b : DstreeredblackCursor) -> DstreeredblackCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_redblack_cursor_copy(s : DstreeredblackCursor) -> DstreeredblackCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_cursor_fill(s : DstreeredblackCursor, v : Double) -> DstreeredblackCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_cursor_min(s : DstreeredblackCursor) -> Double { @_common.min(s.data) }

pub fn ds_tree_redblack_cursor_max(s : DstreeredblackCursor) -> Double { @_common.max(s.data) }

pub fn ds_tree_redblack_cursor_to_string(s : DstreeredblackCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_view_make(size : Int) -> DstreeredblackView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_view_len(s : DstreeredblackView) -> Int { s.size }

pub fn ds_tree_redblack_view_get(s : DstreeredblackView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_view_set(s : DstreeredblackView, i : Int, v : Double) -> DstreeredblackView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_view_sum(s : DstreeredblackView) -> Double { @_common.sum(s.data) }

pub fn ds_tree_redblack_view_mean(s : DstreeredblackView) -> Double { @_common.mean(s.data) }

pub fn ds_tree_redblack_view_scale(s : DstreeredblackView, f : Double) -> DstreeredblackView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_view_add(a : DstreeredblackView, b : DstreeredblackView) -> DstreeredblackView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_redblack_view_copy(s : DstreeredblackView) -> DstreeredblackView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_view_fill(s : DstreeredblackView, v : Double) -> DstreeredblackView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_view_min(s : DstreeredblackView) -> Double { @_common.min(s.data) }

pub fn ds_tree_redblack_view_max(s : DstreeredblackView) -> Double { @_common.max(s.data) }

pub fn ds_tree_redblack_view_to_string(s : DstreeredblackView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_range_make(size : Int) -> DstreeredblackRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_range_len(s : DstreeredblackRange) -> Int { s.size }

pub fn ds_tree_redblack_range_get(s : DstreeredblackRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_range_set(s : DstreeredblackRange, i : Int, v : Double) -> DstreeredblackRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_range_sum(s : DstreeredblackRange) -> Double { @_common.sum(s.data) }

pub fn ds_tree_redblack_range_mean(s : DstreeredblackRange) -> Double { @_common.mean(s.data) }

pub fn ds_tree_redblack_range_scale(s : DstreeredblackRange, f : Double) -> DstreeredblackRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_range_add(a : DstreeredblackRange, b : DstreeredblackRange) -> DstreeredblackRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_redblack_range_copy(s : DstreeredblackRange) -> DstreeredblackRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_range_fill(s : DstreeredblackRange, v : Double) -> DstreeredblackRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_range_min(s : DstreeredblackRange) -> Double { @_common.min(s.data) }

pub fn ds_tree_redblack_range_max(s : DstreeredblackRange) -> Double { @_common.max(s.data) }

pub fn ds_tree_redblack_range_to_string(s : DstreeredblackRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeredblackSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_redblack_slice_make(size : Int) -> DstreeredblackSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_redblack_slice_len(s : DstreeredblackSlice) -> Int { s.size }

pub fn ds_tree_redblack_slice_get(s : DstreeredblackSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_redblack_slice_set(s : DstreeredblackSlice, i : Int, v : Double) -> DstreeredblackSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_slice_sum(s : DstreeredblackSlice) -> Double { @_common.sum(s.data) }

pub fn ds_tree_redblack_slice_mean(s : DstreeredblackSlice) -> Double { @_common.mean(s.data) }

pub fn ds_tree_redblack_slice_scale(s : DstreeredblackSlice, f : Double) -> DstreeredblackSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_slice_add(a : DstreeredblackSlice, b : DstreeredblackSlice) -> DstreeredblackSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_redblack_slice_copy(s : DstreeredblackSlice) -> DstreeredblackSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_slice_fill(s : DstreeredblackSlice, v : Double) -> DstreeredblackSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_redblack_slice_min(s : DstreeredblackSlice) -> Double { @_common.min(s.data) }

pub fn ds_tree_redblack_slice_max(s : DstreeredblackSlice) -> Double { @_common.max(s.data) }

pub fn ds_tree_redblack_slice_to_string(s : DstreeredblackSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

