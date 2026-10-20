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

pub fn DstreebtreeFrame::len(self : DstreebtreeFrame) -> Int { self.size }

pub fn DstreebtreeFrame::get(self : DstreebtreeFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebtreeFrame::set(self : DstreebtreeFrame, i : Int, v : Double) -> DstreebtreeFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebtreeFrame::sum(self : DstreebtreeFrame) -> Double { @_common.sum(self.data) }

pub fn DstreebtreeFrame::mean(self : DstreebtreeFrame) -> Double { @_common.mean(self.data) }

pub fn DstreebtreeFrame::scale(self : DstreebtreeFrame, f : Double) -> DstreebtreeFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebtreeFrame::add(self : DstreebtreeFrame, other : DstreebtreeFrame) -> DstreebtreeFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebtreeFrame::copy(self : DstreebtreeFrame) -> DstreebtreeFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebtreeFrame::fill(self : DstreebtreeFrame, v : Double) -> DstreebtreeFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebtreeFrame::min(self : DstreebtreeFrame) -> Double { @_common.min(self.data) }

pub fn DstreebtreeFrame::max(self : DstreebtreeFrame) -> Double { @_common.max(self.data) }

pub fn DstreebtreeFrame::to_string(self : DstreebtreeFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebtreeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_table_make(size : Int) -> DstreebtreeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebtreeTable::len(self : DstreebtreeTable) -> Int { self.size }

pub fn DstreebtreeTable::get(self : DstreebtreeTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebtreeTable::set(self : DstreebtreeTable, i : Int, v : Double) -> DstreebtreeTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebtreeTable::sum(self : DstreebtreeTable) -> Double { @_common.sum(self.data) }

pub fn DstreebtreeTable::mean(self : DstreebtreeTable) -> Double { @_common.mean(self.data) }

pub fn DstreebtreeTable::scale(self : DstreebtreeTable, f : Double) -> DstreebtreeTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebtreeTable::add(self : DstreebtreeTable, other : DstreebtreeTable) -> DstreebtreeTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebtreeTable::copy(self : DstreebtreeTable) -> DstreebtreeTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebtreeTable::fill(self : DstreebtreeTable, v : Double) -> DstreebtreeTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebtreeTable::min(self : DstreebtreeTable) -> Double { @_common.min(self.data) }

pub fn DstreebtreeTable::max(self : DstreebtreeTable) -> Double { @_common.max(self.data) }

pub fn DstreebtreeTable::to_string(self : DstreebtreeTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebtreeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_graphn_make(size : Int) -> DstreebtreeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebtreeGraphN::len(self : DstreebtreeGraphN) -> Int { self.size }

pub fn DstreebtreeGraphN::get(self : DstreebtreeGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebtreeGraphN::set(self : DstreebtreeGraphN, i : Int, v : Double) -> DstreebtreeGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebtreeGraphN::sum(self : DstreebtreeGraphN) -> Double { @_common.sum(self.data) }

pub fn DstreebtreeGraphN::mean(self : DstreebtreeGraphN) -> Double { @_common.mean(self.data) }

pub fn DstreebtreeGraphN::scale(self : DstreebtreeGraphN, f : Double) -> DstreebtreeGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebtreeGraphN::add(self : DstreebtreeGraphN, other : DstreebtreeGraphN) -> DstreebtreeGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebtreeGraphN::copy(self : DstreebtreeGraphN) -> DstreebtreeGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebtreeGraphN::fill(self : DstreebtreeGraphN, v : Double) -> DstreebtreeGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebtreeGraphN::min(self : DstreebtreeGraphN) -> Double { @_common.min(self.data) }

pub fn DstreebtreeGraphN::max(self : DstreebtreeGraphN) -> Double { @_common.max(self.data) }

pub fn DstreebtreeGraphN::to_string(self : DstreebtreeGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebtreeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_node_make(size : Int) -> DstreebtreeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebtreeNode::len(self : DstreebtreeNode) -> Int { self.size }

pub fn DstreebtreeNode::get(self : DstreebtreeNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebtreeNode::set(self : DstreebtreeNode, i : Int, v : Double) -> DstreebtreeNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebtreeNode::sum(self : DstreebtreeNode) -> Double { @_common.sum(self.data) }

pub fn DstreebtreeNode::mean(self : DstreebtreeNode) -> Double { @_common.mean(self.data) }

pub fn DstreebtreeNode::scale(self : DstreebtreeNode, f : Double) -> DstreebtreeNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebtreeNode::add(self : DstreebtreeNode, other : DstreebtreeNode) -> DstreebtreeNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebtreeNode::copy(self : DstreebtreeNode) -> DstreebtreeNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebtreeNode::fill(self : DstreebtreeNode, v : Double) -> DstreebtreeNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebtreeNode::min(self : DstreebtreeNode) -> Double { @_common.min(self.data) }

pub fn DstreebtreeNode::max(self : DstreebtreeNode) -> Double { @_common.max(self.data) }

pub fn DstreebtreeNode::to_string(self : DstreebtreeNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebtreeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_edge_make(size : Int) -> DstreebtreeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebtreeEdge::len(self : DstreebtreeEdge) -> Int { self.size }

pub fn DstreebtreeEdge::get(self : DstreebtreeEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebtreeEdge::set(self : DstreebtreeEdge, i : Int, v : Double) -> DstreebtreeEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebtreeEdge::sum(self : DstreebtreeEdge) -> Double { @_common.sum(self.data) }

pub fn DstreebtreeEdge::mean(self : DstreebtreeEdge) -> Double { @_common.mean(self.data) }

pub fn DstreebtreeEdge::scale(self : DstreebtreeEdge, f : Double) -> DstreebtreeEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebtreeEdge::add(self : DstreebtreeEdge, other : DstreebtreeEdge) -> DstreebtreeEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebtreeEdge::copy(self : DstreebtreeEdge) -> DstreebtreeEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebtreeEdge::fill(self : DstreebtreeEdge, v : Double) -> DstreebtreeEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebtreeEdge::min(self : DstreebtreeEdge) -> Double { @_common.min(self.data) }

pub fn DstreebtreeEdge::max(self : DstreebtreeEdge) -> Double { @_common.max(self.data) }

pub fn DstreebtreeEdge::to_string(self : DstreebtreeEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebtreePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_path_make(size : Int) -> DstreebtreePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebtreePath::len(self : DstreebtreePath) -> Int { self.size }

pub fn DstreebtreePath::get(self : DstreebtreePath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebtreePath::set(self : DstreebtreePath, i : Int, v : Double) -> DstreebtreePath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebtreePath::sum(self : DstreebtreePath) -> Double { @_common.sum(self.data) }

pub fn DstreebtreePath::mean(self : DstreebtreePath) -> Double { @_common.mean(self.data) }

pub fn DstreebtreePath::scale(self : DstreebtreePath, f : Double) -> DstreebtreePath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebtreePath::add(self : DstreebtreePath, other : DstreebtreePath) -> DstreebtreePath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebtreePath::copy(self : DstreebtreePath) -> DstreebtreePath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebtreePath::fill(self : DstreebtreePath, v : Double) -> DstreebtreePath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebtreePath::min(self : DstreebtreePath) -> Double { @_common.min(self.data) }

pub fn DstreebtreePath::max(self : DstreebtreePath) -> Double { @_common.max(self.data) }

pub fn DstreebtreePath::to_string(self : DstreebtreePath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebtreeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_cluster_make(size : Int) -> DstreebtreeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebtreeCluster::len(self : DstreebtreeCluster) -> Int { self.size }

pub fn DstreebtreeCluster::get(self : DstreebtreeCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebtreeCluster::set(self : DstreebtreeCluster, i : Int, v : Double) -> DstreebtreeCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebtreeCluster::sum(self : DstreebtreeCluster) -> Double { @_common.sum(self.data) }

pub fn DstreebtreeCluster::mean(self : DstreebtreeCluster) -> Double { @_common.mean(self.data) }

pub fn DstreebtreeCluster::scale(self : DstreebtreeCluster, f : Double) -> DstreebtreeCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebtreeCluster::add(self : DstreebtreeCluster, other : DstreebtreeCluster) -> DstreebtreeCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebtreeCluster::copy(self : DstreebtreeCluster) -> DstreebtreeCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebtreeCluster::fill(self : DstreebtreeCluster, v : Double) -> DstreebtreeCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebtreeCluster::min(self : DstreebtreeCluster) -> Double { @_common.min(self.data) }

pub fn DstreebtreeCluster::max(self : DstreebtreeCluster) -> Double { @_common.max(self.data) }

pub fn DstreebtreeCluster::to_string(self : DstreebtreeCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebtreeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_model_make(size : Int) -> DstreebtreeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebtreeModel::len(self : DstreebtreeModel) -> Int { self.size }

pub fn DstreebtreeModel::get(self : DstreebtreeModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebtreeModel::set(self : DstreebtreeModel, i : Int, v : Double) -> DstreebtreeModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebtreeModel::sum(self : DstreebtreeModel) -> Double { @_common.sum(self.data) }

pub fn DstreebtreeModel::mean(self : DstreebtreeModel) -> Double { @_common.mean(self.data) }

pub fn DstreebtreeModel::scale(self : DstreebtreeModel, f : Double) -> DstreebtreeModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebtreeModel::add(self : DstreebtreeModel, other : DstreebtreeModel) -> DstreebtreeModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebtreeModel::copy(self : DstreebtreeModel) -> DstreebtreeModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebtreeModel::fill(self : DstreebtreeModel, v : Double) -> DstreebtreeModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebtreeModel::min(self : DstreebtreeModel) -> Double { @_common.min(self.data) }

pub fn DstreebtreeModel::max(self : DstreebtreeModel) -> Double { @_common.max(self.data) }

pub fn DstreebtreeModel::to_string(self : DstreebtreeModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebtreeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_layer_make(size : Int) -> DstreebtreeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebtreeLayer::len(self : DstreebtreeLayer) -> Int { self.size }

pub fn DstreebtreeLayer::get(self : DstreebtreeLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebtreeLayer::set(self : DstreebtreeLayer, i : Int, v : Double) -> DstreebtreeLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebtreeLayer::sum(self : DstreebtreeLayer) -> Double { @_common.sum(self.data) }

pub fn DstreebtreeLayer::mean(self : DstreebtreeLayer) -> Double { @_common.mean(self.data) }

pub fn DstreebtreeLayer::scale(self : DstreebtreeLayer, f : Double) -> DstreebtreeLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebtreeLayer::add(self : DstreebtreeLayer, other : DstreebtreeLayer) -> DstreebtreeLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebtreeLayer::copy(self : DstreebtreeLayer) -> DstreebtreeLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebtreeLayer::fill(self : DstreebtreeLayer, v : Double) -> DstreebtreeLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebtreeLayer::min(self : DstreebtreeLayer) -> Double { @_common.min(self.data) }

pub fn DstreebtreeLayer::max(self : DstreebtreeLayer) -> Double { @_common.max(self.data) }

pub fn DstreebtreeLayer::to_string(self : DstreebtreeLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebtreeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_buffer_make(size : Int) -> DstreebtreeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebtreeBuffer::len(self : DstreebtreeBuffer) -> Int { self.size }

pub fn DstreebtreeBuffer::get(self : DstreebtreeBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebtreeBuffer::set(self : DstreebtreeBuffer, i : Int, v : Double) -> DstreebtreeBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebtreeBuffer::sum(self : DstreebtreeBuffer) -> Double { @_common.sum(self.data) }

pub fn DstreebtreeBuffer::mean(self : DstreebtreeBuffer) -> Double { @_common.mean(self.data) }

pub fn DstreebtreeBuffer::scale(self : DstreebtreeBuffer, f : Double) -> DstreebtreeBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebtreeBuffer::add(self : DstreebtreeBuffer, other : DstreebtreeBuffer) -> DstreebtreeBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebtreeBuffer::copy(self : DstreebtreeBuffer) -> DstreebtreeBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebtreeBuffer::fill(self : DstreebtreeBuffer, v : Double) -> DstreebtreeBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebtreeBuffer::min(self : DstreebtreeBuffer) -> Double { @_common.min(self.data) }

pub fn DstreebtreeBuffer::max(self : DstreebtreeBuffer) -> Double { @_common.max(self.data) }

pub fn DstreebtreeBuffer::to_string(self : DstreebtreeBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebtreeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_cursor_make(size : Int) -> DstreebtreeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebtreeCursor::len(self : DstreebtreeCursor) -> Int { self.size }

pub fn DstreebtreeCursor::get(self : DstreebtreeCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebtreeCursor::set(self : DstreebtreeCursor, i : Int, v : Double) -> DstreebtreeCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebtreeCursor::sum(self : DstreebtreeCursor) -> Double { @_common.sum(self.data) }

pub fn DstreebtreeCursor::mean(self : DstreebtreeCursor) -> Double { @_common.mean(self.data) }

pub fn DstreebtreeCursor::scale(self : DstreebtreeCursor, f : Double) -> DstreebtreeCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebtreeCursor::add(self : DstreebtreeCursor, other : DstreebtreeCursor) -> DstreebtreeCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebtreeCursor::copy(self : DstreebtreeCursor) -> DstreebtreeCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebtreeCursor::fill(self : DstreebtreeCursor, v : Double) -> DstreebtreeCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebtreeCursor::min(self : DstreebtreeCursor) -> Double { @_common.min(self.data) }

pub fn DstreebtreeCursor::max(self : DstreebtreeCursor) -> Double { @_common.max(self.data) }

pub fn DstreebtreeCursor::to_string(self : DstreebtreeCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebtreeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_view_make(size : Int) -> DstreebtreeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebtreeView::len(self : DstreebtreeView) -> Int { self.size }

pub fn DstreebtreeView::get(self : DstreebtreeView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebtreeView::set(self : DstreebtreeView, i : Int, v : Double) -> DstreebtreeView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebtreeView::sum(self : DstreebtreeView) -> Double { @_common.sum(self.data) }

pub fn DstreebtreeView::mean(self : DstreebtreeView) -> Double { @_common.mean(self.data) }

pub fn DstreebtreeView::scale(self : DstreebtreeView, f : Double) -> DstreebtreeView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebtreeView::add(self : DstreebtreeView, other : DstreebtreeView) -> DstreebtreeView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebtreeView::copy(self : DstreebtreeView) -> DstreebtreeView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebtreeView::fill(self : DstreebtreeView, v : Double) -> DstreebtreeView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebtreeView::min(self : DstreebtreeView) -> Double { @_common.min(self.data) }

pub fn DstreebtreeView::max(self : DstreebtreeView) -> Double { @_common.max(self.data) }

pub fn DstreebtreeView::to_string(self : DstreebtreeView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebtreeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_range_make(size : Int) -> DstreebtreeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebtreeRange::len(self : DstreebtreeRange) -> Int { self.size }

pub fn DstreebtreeRange::get(self : DstreebtreeRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebtreeRange::set(self : DstreebtreeRange, i : Int, v : Double) -> DstreebtreeRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebtreeRange::sum(self : DstreebtreeRange) -> Double { @_common.sum(self.data) }

pub fn DstreebtreeRange::mean(self : DstreebtreeRange) -> Double { @_common.mean(self.data) }

pub fn DstreebtreeRange::scale(self : DstreebtreeRange, f : Double) -> DstreebtreeRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebtreeRange::add(self : DstreebtreeRange, other : DstreebtreeRange) -> DstreebtreeRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebtreeRange::copy(self : DstreebtreeRange) -> DstreebtreeRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebtreeRange::fill(self : DstreebtreeRange, v : Double) -> DstreebtreeRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebtreeRange::min(self : DstreebtreeRange) -> Double { @_common.min(self.data) }

pub fn DstreebtreeRange::max(self : DstreebtreeRange) -> Double { @_common.max(self.data) }

pub fn DstreebtreeRange::to_string(self : DstreebtreeRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreebtreeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_btree_slice_make(size : Int) -> DstreebtreeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreebtreeSlice::len(self : DstreebtreeSlice) -> Int { self.size }

pub fn DstreebtreeSlice::get(self : DstreebtreeSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreebtreeSlice::set(self : DstreebtreeSlice, i : Int, v : Double) -> DstreebtreeSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreebtreeSlice::sum(self : DstreebtreeSlice) -> Double { @_common.sum(self.data) }

pub fn DstreebtreeSlice::mean(self : DstreebtreeSlice) -> Double { @_common.mean(self.data) }

pub fn DstreebtreeSlice::scale(self : DstreebtreeSlice, f : Double) -> DstreebtreeSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreebtreeSlice::add(self : DstreebtreeSlice, other : DstreebtreeSlice) -> DstreebtreeSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreebtreeSlice::copy(self : DstreebtreeSlice) -> DstreebtreeSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreebtreeSlice::fill(self : DstreebtreeSlice, v : Double) -> DstreebtreeSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreebtreeSlice::min(self : DstreebtreeSlice) -> Double { @_common.min(self.data) }

pub fn DstreebtreeSlice::max(self : DstreebtreeSlice) -> Double { @_common.max(self.data) }

pub fn DstreebtreeSlice::to_string(self : DstreebtreeSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

