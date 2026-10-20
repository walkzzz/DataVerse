///===
/// extcore/ds_tree_btree

pub(all) struct DstreebtreePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_btree_make_point(x : Double, y : Double) -> DstreebtreePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_btree_make_point3(x : Double, y : Double, z : Double) -> DstreebtreePoint {
  { x, y, z, label: 0 }
}

pub fn DstreebtreePoint::x(self : DstreebtreePoint) -> Double { self.x }

pub fn DstreebtreePoint::y(self : DstreebtreePoint) -> Double { self.y }

pub fn DstreebtreePoint::z(self : DstreebtreePoint) -> Double { self.z }

pub fn DstreebtreePoint::label(self : DstreebtreePoint) -> Int { self.label }

pub fn DstreebtreePoint::dist(self : DstreebtreePoint, other : DstreebtreePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreebtreePoint::add(self : DstreebtreePoint, other : DstreebtreePoint) -> DstreebtreePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreebtreePoint::sub(self : DstreebtreePoint, other : DstreebtreePoint) -> DstreebtreePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreebtreePoint::scale(self : DstreebtreePoint, s : Double) -> DstreebtreePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreebtreePoint::dot(self : DstreebtreePoint, other : DstreebtreePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreebtreePoint::cross(self : DstreebtreePoint, other : DstreebtreePoint) -> DstreebtreePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreebtreePoint::norm(self : DstreebtreePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreebtreePoint::normalize(self : DstreebtreePoint) -> DstreebtreePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreebtreePoint::negate(self : DstreebtreePoint) -> DstreebtreePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreebtreePoint::mid(self : DstreebtreePoint, other : DstreebtreePoint) -> DstreebtreePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreebtreePoint::lerp(self : DstreebtreePoint, other : DstreebtreePoint, t : Double) -> DstreebtreePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreebtreePoint::to_string(self : DstreebtreePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreebtreeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_btree_make_series(vals : Array[Double], name : String) -> DstreebtreeSeries {
  { vals, name, meta: 0 }
}

pub fn DstreebtreeSeries::len(self : DstreebtreeSeries) -> Int { self.vals.length() }

pub fn DstreebtreeSeries::sum(self : DstreebtreeSeries) -> Double { @_common.sum(self.vals) }

pub fn DstreebtreeSeries::mean(self : DstreebtreeSeries) -> Double { @_common.mean(self.vals) }

pub fn DstreebtreeSeries::min(self : DstreebtreeSeries) -> Double { @_common.min(self.vals) }

pub fn DstreebtreeSeries::max(self : DstreebtreeSeries) -> Double { @_common.max(self.vals) }

pub fn DstreebtreeSeries::range(self : DstreebtreeSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreebtreeSeries::variance(self : DstreebtreeSeries) -> Double { @_common.variance(self.vals) }

pub fn DstreebtreeSeries::std(self : DstreebtreeSeries) -> Double { @_common.std(self.vals) }

pub fn DstreebtreeSeries::median(self : DstreebtreeSeries) -> Double { @_common.median(self.vals) }

pub fn DstreebtreeSeries::scale(self : DstreebtreeSeries, f : Double) -> DstreebtreeSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreebtreeSeries::add(self : DstreebtreeSeries, other : DstreebtreeSeries) -> DstreebtreeSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreebtreeSeries::sub(self : DstreebtreeSeries, other : DstreebtreeSeries) -> DstreebtreeSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreebtreeSeries::normalize(self : DstreebtreeSeries) -> DstreebtreeSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreebtreeSeries::cumsum(self : DstreebtreeSeries) -> DstreebtreeSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreebtreeSeries::to_string(self : DstreebtreeSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreebtreeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_btree_make_matrix(rows : Int, cols : Int, val : Double) -> DstreebtreeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_btree_matrix_identity(n : Int) -> DstreebtreeMatrix {
  let m = ds_tree_btree_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreebtreeMatrix::get(self : DstreebtreeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreebtreeMatrix::transpose(self : DstreebtreeMatrix) -> DstreebtreeMatrix {
  let result = ds_tree_btree_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreebtreeMatrix::add(self : DstreebtreeMatrix, other : DstreebtreeMatrix) -> DstreebtreeMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_btree_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreebtreeMatrix::scale(self : DstreebtreeMatrix, s : Double) -> DstreebtreeMatrix {
  let result = ds_tree_btree_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreebtreeMatrix::multiply(self : DstreebtreeMatrix, other : DstreebtreeMatrix) -> DstreebtreeMatrix {
  if self.cols != other.rows { return ds_tree_btree_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_btree_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DstreebtreeMatrix::trace(self : DstreebtreeMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreebtreeMatrix::det(self : DstreebtreeMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreebtreeMatrix::norm(self : DstreebtreeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreebtreeMatrix::to_string(self : DstreebtreeMatrix) -> String {
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

pub(all) struct DstreebtreeVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_btree_make_vector(comps : Array[Double]) -> DstreebtreeVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_btree_vector_zero(dim : Int) -> DstreebtreeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreebtreeVector::add(self : DstreebtreeVector, other : DstreebtreeVector) -> DstreebtreeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreebtreeVector::sub(self : DstreebtreeVector, other : DstreebtreeVector) -> DstreebtreeVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreebtreeVector::scale(self : DstreebtreeVector, s : Double) -> DstreebtreeVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreebtreeVector::dot(self : DstreebtreeVector, other : DstreebtreeVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreebtreeVector::norm(self : DstreebtreeVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreebtreeVector::normalize(self : DstreebtreeVector) -> DstreebtreeVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreebtreeVector::dist(self : DstreebtreeVector, other : DstreebtreeVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreebtreeVector::to_string(self : DstreebtreeVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_btree_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_btree_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_btree_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_btree_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_btree_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_btree_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_btree_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_btree_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_btree_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_btree_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_btree_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_btree_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_btree_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_btree_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_btree_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_btree_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_btree_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_btree_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_btree_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_btree_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_btree_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_btree_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_btree_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_btree_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_btree_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_btree_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_btree_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_btree_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_btree_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreebtreeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_frame_make(size : Int) -> DstreebtreeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_frame_len(s : DstreebtreeFrame) -> Int { s.size }

pub fn ds_tree_btree_frame_get(s : DstreebtreeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_frame_set(s : DstreebtreeFrame, i : Int, v : Double) -> DstreebtreeFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_frame_sum(s : DstreebtreeFrame) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_frame_mean(s : DstreebtreeFrame) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_frame_scale(s : DstreebtreeFrame, f : Double) -> DstreebtreeFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_frame_add(a : DstreebtreeFrame, b : DstreebtreeFrame) -> DstreebtreeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_btree_frame_copy(s : DstreebtreeFrame) -> DstreebtreeFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_frame_fill(s : DstreebtreeFrame, v : Double) -> DstreebtreeFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_frame_min(s : DstreebtreeFrame) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_frame_max(s : DstreebtreeFrame) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_frame_to_string(s : DstreebtreeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_table_make(size : Int) -> DstreebtreeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_table_len(s : DstreebtreeTable) -> Int { s.size }

pub fn ds_tree_btree_table_get(s : DstreebtreeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_table_set(s : DstreebtreeTable, i : Int, v : Double) -> DstreebtreeTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_table_sum(s : DstreebtreeTable) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_table_mean(s : DstreebtreeTable) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_table_scale(s : DstreebtreeTable, f : Double) -> DstreebtreeTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_table_add(a : DstreebtreeTable, b : DstreebtreeTable) -> DstreebtreeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_btree_table_copy(s : DstreebtreeTable) -> DstreebtreeTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_table_fill(s : DstreebtreeTable, v : Double) -> DstreebtreeTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_table_min(s : DstreebtreeTable) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_table_max(s : DstreebtreeTable) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_table_to_string(s : DstreebtreeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_graphn_make(size : Int) -> DstreebtreeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_graphn_len(s : DstreebtreeGraphN) -> Int { s.size }

pub fn ds_tree_btree_graphn_get(s : DstreebtreeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_graphn_set(s : DstreebtreeGraphN, i : Int, v : Double) -> DstreebtreeGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_graphn_sum(s : DstreebtreeGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_graphn_mean(s : DstreebtreeGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_graphn_scale(s : DstreebtreeGraphN, f : Double) -> DstreebtreeGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_graphn_add(a : DstreebtreeGraphN, b : DstreebtreeGraphN) -> DstreebtreeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_btree_graphn_copy(s : DstreebtreeGraphN) -> DstreebtreeGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_graphn_fill(s : DstreebtreeGraphN, v : Double) -> DstreebtreeGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_graphn_min(s : DstreebtreeGraphN) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_graphn_max(s : DstreebtreeGraphN) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_graphn_to_string(s : DstreebtreeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_node_make(size : Int) -> DstreebtreeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_node_len(s : DstreebtreeNode) -> Int { s.size }

pub fn ds_tree_btree_node_get(s : DstreebtreeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_node_set(s : DstreebtreeNode, i : Int, v : Double) -> DstreebtreeNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_node_sum(s : DstreebtreeNode) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_node_mean(s : DstreebtreeNode) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_node_scale(s : DstreebtreeNode, f : Double) -> DstreebtreeNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_node_add(a : DstreebtreeNode, b : DstreebtreeNode) -> DstreebtreeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_btree_node_copy(s : DstreebtreeNode) -> DstreebtreeNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_node_fill(s : DstreebtreeNode, v : Double) -> DstreebtreeNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_node_min(s : DstreebtreeNode) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_node_max(s : DstreebtreeNode) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_node_to_string(s : DstreebtreeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_edge_make(size : Int) -> DstreebtreeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_edge_len(s : DstreebtreeEdge) -> Int { s.size }

pub fn ds_tree_btree_edge_get(s : DstreebtreeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_edge_set(s : DstreebtreeEdge, i : Int, v : Double) -> DstreebtreeEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_edge_sum(s : DstreebtreeEdge) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_edge_mean(s : DstreebtreeEdge) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_edge_scale(s : DstreebtreeEdge, f : Double) -> DstreebtreeEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_edge_add(a : DstreebtreeEdge, b : DstreebtreeEdge) -> DstreebtreeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_btree_edge_copy(s : DstreebtreeEdge) -> DstreebtreeEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_edge_fill(s : DstreebtreeEdge, v : Double) -> DstreebtreeEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_edge_min(s : DstreebtreeEdge) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_edge_max(s : DstreebtreeEdge) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_edge_to_string(s : DstreebtreeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_path_make(size : Int) -> DstreebtreePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_path_len(s : DstreebtreePath) -> Int { s.size }

pub fn ds_tree_btree_path_get(s : DstreebtreePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_path_set(s : DstreebtreePath, i : Int, v : Double) -> DstreebtreePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_path_sum(s : DstreebtreePath) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_path_mean(s : DstreebtreePath) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_path_scale(s : DstreebtreePath, f : Double) -> DstreebtreePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_path_add(a : DstreebtreePath, b : DstreebtreePath) -> DstreebtreePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_btree_path_copy(s : DstreebtreePath) -> DstreebtreePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_path_fill(s : DstreebtreePath, v : Double) -> DstreebtreePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_path_min(s : DstreebtreePath) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_path_max(s : DstreebtreePath) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_path_to_string(s : DstreebtreePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_cluster_make(size : Int) -> DstreebtreeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_cluster_len(s : DstreebtreeCluster) -> Int { s.size }

pub fn ds_tree_btree_cluster_get(s : DstreebtreeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_cluster_set(s : DstreebtreeCluster, i : Int, v : Double) -> DstreebtreeCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_cluster_sum(s : DstreebtreeCluster) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_cluster_mean(s : DstreebtreeCluster) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_cluster_scale(s : DstreebtreeCluster, f : Double) -> DstreebtreeCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_cluster_add(a : DstreebtreeCluster, b : DstreebtreeCluster) -> DstreebtreeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_btree_cluster_copy(s : DstreebtreeCluster) -> DstreebtreeCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_cluster_fill(s : DstreebtreeCluster, v : Double) -> DstreebtreeCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_cluster_min(s : DstreebtreeCluster) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_cluster_max(s : DstreebtreeCluster) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_cluster_to_string(s : DstreebtreeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_model_make(size : Int) -> DstreebtreeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_model_len(s : DstreebtreeModel) -> Int { s.size }

pub fn ds_tree_btree_model_get(s : DstreebtreeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_model_set(s : DstreebtreeModel, i : Int, v : Double) -> DstreebtreeModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_model_sum(s : DstreebtreeModel) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_model_mean(s : DstreebtreeModel) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_model_scale(s : DstreebtreeModel, f : Double) -> DstreebtreeModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_model_add(a : DstreebtreeModel, b : DstreebtreeModel) -> DstreebtreeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_btree_model_copy(s : DstreebtreeModel) -> DstreebtreeModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_model_fill(s : DstreebtreeModel, v : Double) -> DstreebtreeModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_model_min(s : DstreebtreeModel) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_model_max(s : DstreebtreeModel) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_model_to_string(s : DstreebtreeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_layer_make(size : Int) -> DstreebtreeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_layer_len(s : DstreebtreeLayer) -> Int { s.size }

pub fn ds_tree_btree_layer_get(s : DstreebtreeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_layer_set(s : DstreebtreeLayer, i : Int, v : Double) -> DstreebtreeLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_layer_sum(s : DstreebtreeLayer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_layer_mean(s : DstreebtreeLayer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_layer_scale(s : DstreebtreeLayer, f : Double) -> DstreebtreeLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_layer_add(a : DstreebtreeLayer, b : DstreebtreeLayer) -> DstreebtreeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_btree_layer_copy(s : DstreebtreeLayer) -> DstreebtreeLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_layer_fill(s : DstreebtreeLayer, v : Double) -> DstreebtreeLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_layer_min(s : DstreebtreeLayer) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_layer_max(s : DstreebtreeLayer) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_layer_to_string(s : DstreebtreeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_buffer_make(size : Int) -> DstreebtreeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_buffer_len(s : DstreebtreeBuffer) -> Int { s.size }

pub fn ds_tree_btree_buffer_get(s : DstreebtreeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_buffer_set(s : DstreebtreeBuffer, i : Int, v : Double) -> DstreebtreeBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_buffer_sum(s : DstreebtreeBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_buffer_mean(s : DstreebtreeBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_buffer_scale(s : DstreebtreeBuffer, f : Double) -> DstreebtreeBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_buffer_add(a : DstreebtreeBuffer, b : DstreebtreeBuffer) -> DstreebtreeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_btree_buffer_copy(s : DstreebtreeBuffer) -> DstreebtreeBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_buffer_fill(s : DstreebtreeBuffer, v : Double) -> DstreebtreeBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_buffer_min(s : DstreebtreeBuffer) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_buffer_max(s : DstreebtreeBuffer) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_buffer_to_string(s : DstreebtreeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_cursor_make(size : Int) -> DstreebtreeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_cursor_len(s : DstreebtreeCursor) -> Int { s.size }

pub fn ds_tree_btree_cursor_get(s : DstreebtreeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_cursor_set(s : DstreebtreeCursor, i : Int, v : Double) -> DstreebtreeCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_cursor_sum(s : DstreebtreeCursor) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_cursor_mean(s : DstreebtreeCursor) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_cursor_scale(s : DstreebtreeCursor, f : Double) -> DstreebtreeCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_cursor_add(a : DstreebtreeCursor, b : DstreebtreeCursor) -> DstreebtreeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_btree_cursor_copy(s : DstreebtreeCursor) -> DstreebtreeCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_cursor_fill(s : DstreebtreeCursor, v : Double) -> DstreebtreeCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_cursor_min(s : DstreebtreeCursor) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_cursor_max(s : DstreebtreeCursor) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_cursor_to_string(s : DstreebtreeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_view_make(size : Int) -> DstreebtreeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_view_len(s : DstreebtreeView) -> Int { s.size }

pub fn ds_tree_btree_view_get(s : DstreebtreeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_view_set(s : DstreebtreeView, i : Int, v : Double) -> DstreebtreeView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_view_sum(s : DstreebtreeView) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_view_mean(s : DstreebtreeView) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_view_scale(s : DstreebtreeView, f : Double) -> DstreebtreeView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_view_add(a : DstreebtreeView, b : DstreebtreeView) -> DstreebtreeView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_btree_view_copy(s : DstreebtreeView) -> DstreebtreeView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_view_fill(s : DstreebtreeView, v : Double) -> DstreebtreeView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_view_min(s : DstreebtreeView) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_view_max(s : DstreebtreeView) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_view_to_string(s : DstreebtreeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_range_make(size : Int) -> DstreebtreeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_range_len(s : DstreebtreeRange) -> Int { s.size }

pub fn ds_tree_btree_range_get(s : DstreebtreeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_range_set(s : DstreebtreeRange, i : Int, v : Double) -> DstreebtreeRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_range_sum(s : DstreebtreeRange) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_range_mean(s : DstreebtreeRange) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_range_scale(s : DstreebtreeRange, f : Double) -> DstreebtreeRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_range_add(a : DstreebtreeRange, b : DstreebtreeRange) -> DstreebtreeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_btree_range_copy(s : DstreebtreeRange) -> DstreebtreeRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_range_fill(s : DstreebtreeRange, v : Double) -> DstreebtreeRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_range_min(s : DstreebtreeRange) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_range_max(s : DstreebtreeRange) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_range_to_string(s : DstreebtreeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreebtreeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_slice_make(size : Int) -> DstreebtreeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_btree_slice_len(s : DstreebtreeSlice) -> Int { s.size }

pub fn ds_tree_btree_slice_get(s : DstreebtreeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_btree_slice_set(s : DstreebtreeSlice, i : Int, v : Double) -> DstreebtreeSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_slice_sum(s : DstreebtreeSlice) -> Double { @_common.sum(s.data) }

pub fn ds_tree_btree_slice_mean(s : DstreebtreeSlice) -> Double { @_common.mean(s.data) }

pub fn ds_tree_btree_slice_scale(s : DstreebtreeSlice, f : Double) -> DstreebtreeSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_slice_add(a : DstreebtreeSlice, b : DstreebtreeSlice) -> DstreebtreeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_btree_slice_copy(s : DstreebtreeSlice) -> DstreebtreeSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_slice_fill(s : DstreebtreeSlice, v : Double) -> DstreebtreeSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_btree_slice_min(s : DstreebtreeSlice) -> Double { @_common.min(s.data) }

pub fn ds_tree_btree_slice_max(s : DstreebtreeSlice) -> Double { @_common.max(s.data) }

pub fn ds_tree_btree_slice_to_string(s : DstreebtreeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

