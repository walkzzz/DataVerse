///===
/// extcore/ds_tree_avl

pub(all) struct DstreeavlPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_avl_make_point(x : Double, y : Double) -> DstreeavlPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_avl_make_point3(x : Double, y : Double, z : Double) -> DstreeavlPoint {
  { x, y, z, label: 0 }
}

pub fn DstreeavlPoint::x(self : DstreeavlPoint) -> Double { self.x }

pub fn DstreeavlPoint::y(self : DstreeavlPoint) -> Double { self.y }

pub fn DstreeavlPoint::z(self : DstreeavlPoint) -> Double { self.z }

pub fn DstreeavlPoint::label(self : DstreeavlPoint) -> Int { self.label }

pub fn DstreeavlPoint::dist(self : DstreeavlPoint, other : DstreeavlPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreeavlPoint::add(self : DstreeavlPoint, other : DstreeavlPoint) -> DstreeavlPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreeavlPoint::sub(self : DstreeavlPoint, other : DstreeavlPoint) -> DstreeavlPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreeavlPoint::scale(self : DstreeavlPoint, s : Double) -> DstreeavlPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreeavlPoint::dot(self : DstreeavlPoint, other : DstreeavlPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreeavlPoint::cross(self : DstreeavlPoint, other : DstreeavlPoint) -> DstreeavlPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreeavlPoint::norm(self : DstreeavlPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreeavlPoint::normalize(self : DstreeavlPoint) -> DstreeavlPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreeavlPoint::negate(self : DstreeavlPoint) -> DstreeavlPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreeavlPoint::mid(self : DstreeavlPoint, other : DstreeavlPoint) -> DstreeavlPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreeavlPoint::lerp(self : DstreeavlPoint, other : DstreeavlPoint, t : Double) -> DstreeavlPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreeavlPoint::to_string(self : DstreeavlPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreeavlSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_avl_make_series(vals : Array[Double], name : String) -> DstreeavlSeries {
  { vals, name, meta: 0 }
}

pub fn DstreeavlSeries::len(self : DstreeavlSeries) -> Int { self.vals.length() }

pub fn DstreeavlSeries::sum(self : DstreeavlSeries) -> Double { @_common.sum(self.vals) }

pub fn DstreeavlSeries::mean(self : DstreeavlSeries) -> Double { @_common.mean(self.vals) }

pub fn DstreeavlSeries::min(self : DstreeavlSeries) -> Double { @_common.min(self.vals) }

pub fn DstreeavlSeries::max(self : DstreeavlSeries) -> Double { @_common.max(self.vals) }

pub fn DstreeavlSeries::range(self : DstreeavlSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreeavlSeries::variance(self : DstreeavlSeries) -> Double { @_common.variance(self.vals) }

pub fn DstreeavlSeries::std(self : DstreeavlSeries) -> Double { @_common.std(self.vals) }

pub fn DstreeavlSeries::median(self : DstreeavlSeries) -> Double { @_common.median(self.vals) }

pub fn DstreeavlSeries::scale(self : DstreeavlSeries, f : Double) -> DstreeavlSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreeavlSeries::add(self : DstreeavlSeries, other : DstreeavlSeries) -> DstreeavlSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreeavlSeries::sub(self : DstreeavlSeries, other : DstreeavlSeries) -> DstreeavlSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreeavlSeries::normalize(self : DstreeavlSeries) -> DstreeavlSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreeavlSeries::cumsum(self : DstreeavlSeries) -> DstreeavlSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreeavlSeries::to_string(self : DstreeavlSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreeavlMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_avl_make_matrix(rows : Int, cols : Int, val : Double) -> DstreeavlMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_avl_matrix_identity(n : Int) -> DstreeavlMatrix {
  let m = ds_tree_avl_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreeavlMatrix::get(self : DstreeavlMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreeavlMatrix::transpose(self : DstreeavlMatrix) -> DstreeavlMatrix {
  let result = ds_tree_avl_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreeavlMatrix::add(self : DstreeavlMatrix, other : DstreeavlMatrix) -> DstreeavlMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_avl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreeavlMatrix::scale(self : DstreeavlMatrix, s : Double) -> DstreeavlMatrix {
  let result = ds_tree_avl_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreeavlMatrix::multiply(self : DstreeavlMatrix, other : DstreeavlMatrix) -> DstreeavlMatrix {
  if self.cols != other.rows { return ds_tree_avl_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_avl_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DstreeavlMatrix::trace(self : DstreeavlMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreeavlMatrix::det(self : DstreeavlMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreeavlMatrix::norm(self : DstreeavlMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreeavlMatrix::to_string(self : DstreeavlMatrix) -> String {
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

pub(all) struct DstreeavlVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_avl_make_vector(comps : Array[Double]) -> DstreeavlVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_avl_vector_zero(dim : Int) -> DstreeavlVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreeavlVector::add(self : DstreeavlVector, other : DstreeavlVector) -> DstreeavlVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreeavlVector::sub(self : DstreeavlVector, other : DstreeavlVector) -> DstreeavlVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreeavlVector::scale(self : DstreeavlVector, s : Double) -> DstreeavlVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreeavlVector::dot(self : DstreeavlVector, other : DstreeavlVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreeavlVector::norm(self : DstreeavlVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreeavlVector::normalize(self : DstreeavlVector) -> DstreeavlVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreeavlVector::dist(self : DstreeavlVector, other : DstreeavlVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreeavlVector::to_string(self : DstreeavlVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_avl_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_avl_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_avl_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_avl_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_avl_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_avl_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_avl_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_avl_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_avl_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_avl_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_avl_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_avl_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_avl_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_avl_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_avl_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_avl_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_avl_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_avl_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_avl_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_avl_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_avl_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_avl_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_avl_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_avl_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_avl_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_avl_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_avl_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_avl_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_avl_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreeavlFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_frame_make(size : Int) -> DstreeavlFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_frame_len(s : DstreeavlFrame) -> Int { s.size }

pub fn ds_tree_avl_frame_get(s : DstreeavlFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_frame_set(s : DstreeavlFrame, i : Int, v : Double) -> DstreeavlFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_frame_sum(s : DstreeavlFrame) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_frame_mean(s : DstreeavlFrame) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_frame_scale(s : DstreeavlFrame, f : Double) -> DstreeavlFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_frame_add(a : DstreeavlFrame, b : DstreeavlFrame) -> DstreeavlFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_avl_frame_copy(s : DstreeavlFrame) -> DstreeavlFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_frame_fill(s : DstreeavlFrame, v : Double) -> DstreeavlFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_frame_min(s : DstreeavlFrame) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_frame_max(s : DstreeavlFrame) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_frame_to_string(s : DstreeavlFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_table_make(size : Int) -> DstreeavlTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_table_len(s : DstreeavlTable) -> Int { s.size }

pub fn ds_tree_avl_table_get(s : DstreeavlTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_table_set(s : DstreeavlTable, i : Int, v : Double) -> DstreeavlTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_table_sum(s : DstreeavlTable) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_table_mean(s : DstreeavlTable) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_table_scale(s : DstreeavlTable, f : Double) -> DstreeavlTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_table_add(a : DstreeavlTable, b : DstreeavlTable) -> DstreeavlTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_avl_table_copy(s : DstreeavlTable) -> DstreeavlTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_table_fill(s : DstreeavlTable, v : Double) -> DstreeavlTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_table_min(s : DstreeavlTable) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_table_max(s : DstreeavlTable) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_table_to_string(s : DstreeavlTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_graphn_make(size : Int) -> DstreeavlGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_graphn_len(s : DstreeavlGraphN) -> Int { s.size }

pub fn ds_tree_avl_graphn_get(s : DstreeavlGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_graphn_set(s : DstreeavlGraphN, i : Int, v : Double) -> DstreeavlGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_graphn_sum(s : DstreeavlGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_graphn_mean(s : DstreeavlGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_graphn_scale(s : DstreeavlGraphN, f : Double) -> DstreeavlGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_graphn_add(a : DstreeavlGraphN, b : DstreeavlGraphN) -> DstreeavlGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_avl_graphn_copy(s : DstreeavlGraphN) -> DstreeavlGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_graphn_fill(s : DstreeavlGraphN, v : Double) -> DstreeavlGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_graphn_min(s : DstreeavlGraphN) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_graphn_max(s : DstreeavlGraphN) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_graphn_to_string(s : DstreeavlGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_node_make(size : Int) -> DstreeavlNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_node_len(s : DstreeavlNode) -> Int { s.size }

pub fn ds_tree_avl_node_get(s : DstreeavlNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_node_set(s : DstreeavlNode, i : Int, v : Double) -> DstreeavlNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_node_sum(s : DstreeavlNode) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_node_mean(s : DstreeavlNode) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_node_scale(s : DstreeavlNode, f : Double) -> DstreeavlNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_node_add(a : DstreeavlNode, b : DstreeavlNode) -> DstreeavlNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_avl_node_copy(s : DstreeavlNode) -> DstreeavlNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_node_fill(s : DstreeavlNode, v : Double) -> DstreeavlNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_node_min(s : DstreeavlNode) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_node_max(s : DstreeavlNode) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_node_to_string(s : DstreeavlNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_edge_make(size : Int) -> DstreeavlEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_edge_len(s : DstreeavlEdge) -> Int { s.size }

pub fn ds_tree_avl_edge_get(s : DstreeavlEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_edge_set(s : DstreeavlEdge, i : Int, v : Double) -> DstreeavlEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_edge_sum(s : DstreeavlEdge) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_edge_mean(s : DstreeavlEdge) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_edge_scale(s : DstreeavlEdge, f : Double) -> DstreeavlEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_edge_add(a : DstreeavlEdge, b : DstreeavlEdge) -> DstreeavlEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_avl_edge_copy(s : DstreeavlEdge) -> DstreeavlEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_edge_fill(s : DstreeavlEdge, v : Double) -> DstreeavlEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_edge_min(s : DstreeavlEdge) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_edge_max(s : DstreeavlEdge) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_edge_to_string(s : DstreeavlEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_path_make(size : Int) -> DstreeavlPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_path_len(s : DstreeavlPath) -> Int { s.size }

pub fn ds_tree_avl_path_get(s : DstreeavlPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_path_set(s : DstreeavlPath, i : Int, v : Double) -> DstreeavlPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_path_sum(s : DstreeavlPath) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_path_mean(s : DstreeavlPath) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_path_scale(s : DstreeavlPath, f : Double) -> DstreeavlPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_path_add(a : DstreeavlPath, b : DstreeavlPath) -> DstreeavlPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_avl_path_copy(s : DstreeavlPath) -> DstreeavlPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_path_fill(s : DstreeavlPath, v : Double) -> DstreeavlPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_path_min(s : DstreeavlPath) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_path_max(s : DstreeavlPath) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_path_to_string(s : DstreeavlPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_cluster_make(size : Int) -> DstreeavlCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_cluster_len(s : DstreeavlCluster) -> Int { s.size }

pub fn ds_tree_avl_cluster_get(s : DstreeavlCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_cluster_set(s : DstreeavlCluster, i : Int, v : Double) -> DstreeavlCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_cluster_sum(s : DstreeavlCluster) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_cluster_mean(s : DstreeavlCluster) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_cluster_scale(s : DstreeavlCluster, f : Double) -> DstreeavlCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_cluster_add(a : DstreeavlCluster, b : DstreeavlCluster) -> DstreeavlCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_avl_cluster_copy(s : DstreeavlCluster) -> DstreeavlCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_cluster_fill(s : DstreeavlCluster, v : Double) -> DstreeavlCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_cluster_min(s : DstreeavlCluster) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_cluster_max(s : DstreeavlCluster) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_cluster_to_string(s : DstreeavlCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_model_make(size : Int) -> DstreeavlModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_model_len(s : DstreeavlModel) -> Int { s.size }

pub fn ds_tree_avl_model_get(s : DstreeavlModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_model_set(s : DstreeavlModel, i : Int, v : Double) -> DstreeavlModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_model_sum(s : DstreeavlModel) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_model_mean(s : DstreeavlModel) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_model_scale(s : DstreeavlModel, f : Double) -> DstreeavlModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_model_add(a : DstreeavlModel, b : DstreeavlModel) -> DstreeavlModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_avl_model_copy(s : DstreeavlModel) -> DstreeavlModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_model_fill(s : DstreeavlModel, v : Double) -> DstreeavlModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_model_min(s : DstreeavlModel) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_model_max(s : DstreeavlModel) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_model_to_string(s : DstreeavlModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_layer_make(size : Int) -> DstreeavlLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_layer_len(s : DstreeavlLayer) -> Int { s.size }

pub fn ds_tree_avl_layer_get(s : DstreeavlLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_layer_set(s : DstreeavlLayer, i : Int, v : Double) -> DstreeavlLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_layer_sum(s : DstreeavlLayer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_layer_mean(s : DstreeavlLayer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_layer_scale(s : DstreeavlLayer, f : Double) -> DstreeavlLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_layer_add(a : DstreeavlLayer, b : DstreeavlLayer) -> DstreeavlLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_avl_layer_copy(s : DstreeavlLayer) -> DstreeavlLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_layer_fill(s : DstreeavlLayer, v : Double) -> DstreeavlLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_layer_min(s : DstreeavlLayer) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_layer_max(s : DstreeavlLayer) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_layer_to_string(s : DstreeavlLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_buffer_make(size : Int) -> DstreeavlBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_buffer_len(s : DstreeavlBuffer) -> Int { s.size }

pub fn ds_tree_avl_buffer_get(s : DstreeavlBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_buffer_set(s : DstreeavlBuffer, i : Int, v : Double) -> DstreeavlBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_buffer_sum(s : DstreeavlBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_buffer_mean(s : DstreeavlBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_buffer_scale(s : DstreeavlBuffer, f : Double) -> DstreeavlBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_buffer_add(a : DstreeavlBuffer, b : DstreeavlBuffer) -> DstreeavlBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_avl_buffer_copy(s : DstreeavlBuffer) -> DstreeavlBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_buffer_fill(s : DstreeavlBuffer, v : Double) -> DstreeavlBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_buffer_min(s : DstreeavlBuffer) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_buffer_max(s : DstreeavlBuffer) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_buffer_to_string(s : DstreeavlBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_cursor_make(size : Int) -> DstreeavlCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_cursor_len(s : DstreeavlCursor) -> Int { s.size }

pub fn ds_tree_avl_cursor_get(s : DstreeavlCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_cursor_set(s : DstreeavlCursor, i : Int, v : Double) -> DstreeavlCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_cursor_sum(s : DstreeavlCursor) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_cursor_mean(s : DstreeavlCursor) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_cursor_scale(s : DstreeavlCursor, f : Double) -> DstreeavlCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_cursor_add(a : DstreeavlCursor, b : DstreeavlCursor) -> DstreeavlCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_avl_cursor_copy(s : DstreeavlCursor) -> DstreeavlCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_cursor_fill(s : DstreeavlCursor, v : Double) -> DstreeavlCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_cursor_min(s : DstreeavlCursor) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_cursor_max(s : DstreeavlCursor) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_cursor_to_string(s : DstreeavlCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_view_make(size : Int) -> DstreeavlView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_view_len(s : DstreeavlView) -> Int { s.size }

pub fn ds_tree_avl_view_get(s : DstreeavlView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_view_set(s : DstreeavlView, i : Int, v : Double) -> DstreeavlView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_view_sum(s : DstreeavlView) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_view_mean(s : DstreeavlView) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_view_scale(s : DstreeavlView, f : Double) -> DstreeavlView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_view_add(a : DstreeavlView, b : DstreeavlView) -> DstreeavlView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_avl_view_copy(s : DstreeavlView) -> DstreeavlView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_view_fill(s : DstreeavlView, v : Double) -> DstreeavlView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_view_min(s : DstreeavlView) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_view_max(s : DstreeavlView) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_view_to_string(s : DstreeavlView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_range_make(size : Int) -> DstreeavlRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_range_len(s : DstreeavlRange) -> Int { s.size }

pub fn ds_tree_avl_range_get(s : DstreeavlRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_range_set(s : DstreeavlRange, i : Int, v : Double) -> DstreeavlRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_range_sum(s : DstreeavlRange) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_range_mean(s : DstreeavlRange) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_range_scale(s : DstreeavlRange, f : Double) -> DstreeavlRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_range_add(a : DstreeavlRange, b : DstreeavlRange) -> DstreeavlRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_avl_range_copy(s : DstreeavlRange) -> DstreeavlRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_range_fill(s : DstreeavlRange, v : Double) -> DstreeavlRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_range_min(s : DstreeavlRange) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_range_max(s : DstreeavlRange) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_range_to_string(s : DstreeavlRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreeavlSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_avl_slice_make(size : Int) -> DstreeavlSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_avl_slice_len(s : DstreeavlSlice) -> Int { s.size }

pub fn ds_tree_avl_slice_get(s : DstreeavlSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_avl_slice_set(s : DstreeavlSlice, i : Int, v : Double) -> DstreeavlSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_slice_sum(s : DstreeavlSlice) -> Double { @_common.sum(s.data) }

pub fn ds_tree_avl_slice_mean(s : DstreeavlSlice) -> Double { @_common.mean(s.data) }

pub fn ds_tree_avl_slice_scale(s : DstreeavlSlice, f : Double) -> DstreeavlSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_slice_add(a : DstreeavlSlice, b : DstreeavlSlice) -> DstreeavlSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_avl_slice_copy(s : DstreeavlSlice) -> DstreeavlSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_slice_fill(s : DstreeavlSlice, v : Double) -> DstreeavlSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_avl_slice_min(s : DstreeavlSlice) -> Double { @_common.min(s.data) }

pub fn ds_tree_avl_slice_max(s : DstreeavlSlice) -> Double { @_common.max(s.data) }

pub fn ds_tree_avl_slice_to_string(s : DstreeavlSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

