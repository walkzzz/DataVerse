///===
/// extcore/ds_tree_fenwick

pub(all) struct DstreefenwickPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_tree_fenwick_make_point(x : Double, y : Double) -> DstreefenwickPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_tree_fenwick_make_point3(x : Double, y : Double, z : Double) -> DstreefenwickPoint {
  { x, y, z, label: 0 }
}

pub fn DstreefenwickPoint::x(self : DstreefenwickPoint) -> Double { self.x }

pub fn DstreefenwickPoint::y(self : DstreefenwickPoint) -> Double { self.y }

pub fn DstreefenwickPoint::z(self : DstreefenwickPoint) -> Double { self.z }

pub fn DstreefenwickPoint::label(self : DstreefenwickPoint) -> Int { self.label }

pub fn DstreefenwickPoint::dist(self : DstreefenwickPoint, other : DstreefenwickPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DstreefenwickPoint::add(self : DstreefenwickPoint, other : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DstreefenwickPoint::sub(self : DstreefenwickPoint, other : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DstreefenwickPoint::scale(self : DstreefenwickPoint, s : Double) -> DstreefenwickPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DstreefenwickPoint::dot(self : DstreefenwickPoint, other : DstreefenwickPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DstreefenwickPoint::cross(self : DstreefenwickPoint, other : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DstreefenwickPoint::norm(self : DstreefenwickPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DstreefenwickPoint::normalize(self : DstreefenwickPoint) -> DstreefenwickPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreefenwickPoint::negate(self : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DstreefenwickPoint::mid(self : DstreefenwickPoint, other : DstreefenwickPoint) -> DstreefenwickPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DstreefenwickPoint::lerp(self : DstreefenwickPoint, other : DstreefenwickPoint, t : Double) -> DstreefenwickPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DstreefenwickPoint::to_string(self : DstreefenwickPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DstreefenwickSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_tree_fenwick_make_series(vals : Array[Double], name : String) -> DstreefenwickSeries {
  { vals, name, meta: 0 }
}

pub fn DstreefenwickSeries::len(self : DstreefenwickSeries) -> Int { self.vals.length() }

pub fn DstreefenwickSeries::sum(self : DstreefenwickSeries) -> Double { @_common.sum(self.vals) }

pub fn DstreefenwickSeries::mean(self : DstreefenwickSeries) -> Double { @_common.mean(self.vals) }

pub fn DstreefenwickSeries::min(self : DstreefenwickSeries) -> Double { @_common.min(self.vals) }

pub fn DstreefenwickSeries::max(self : DstreefenwickSeries) -> Double { @_common.max(self.vals) }

pub fn DstreefenwickSeries::range(self : DstreefenwickSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DstreefenwickSeries::variance(self : DstreefenwickSeries) -> Double { @_common.variance(self.vals) }

pub fn DstreefenwickSeries::std(self : DstreefenwickSeries) -> Double { @_common.std(self.vals) }

pub fn DstreefenwickSeries::median(self : DstreefenwickSeries) -> Double { @_common.median(self.vals) }

pub fn DstreefenwickSeries::scale(self : DstreefenwickSeries, f : Double) -> DstreefenwickSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DstreefenwickSeries::add(self : DstreefenwickSeries, other : DstreefenwickSeries) -> DstreefenwickSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DstreefenwickSeries::sub(self : DstreefenwickSeries, other : DstreefenwickSeries) -> DstreefenwickSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DstreefenwickSeries::normalize(self : DstreefenwickSeries) -> DstreefenwickSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DstreefenwickSeries::cumsum(self : DstreefenwickSeries) -> DstreefenwickSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DstreefenwickSeries::to_string(self : DstreefenwickSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DstreefenwickMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_tree_fenwick_make_matrix(rows : Int, cols : Int, val : Double) -> DstreefenwickMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_tree_fenwick_matrix_identity(n : Int) -> DstreefenwickMatrix {
  let m = ds_tree_fenwick_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DstreefenwickMatrix::get(self : DstreefenwickMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DstreefenwickMatrix::transpose(self : DstreefenwickMatrix) -> DstreefenwickMatrix {
  let result = ds_tree_fenwick_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DstreefenwickMatrix::add(self : DstreefenwickMatrix, other : DstreefenwickMatrix) -> DstreefenwickMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_tree_fenwick_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DstreefenwickMatrix::scale(self : DstreefenwickMatrix, s : Double) -> DstreefenwickMatrix {
  let result = ds_tree_fenwick_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DstreefenwickMatrix::multiply(self : DstreefenwickMatrix, other : DstreefenwickMatrix) -> DstreefenwickMatrix {
  if self.cols != other.rows { return ds_tree_fenwick_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_tree_fenwick_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DstreefenwickMatrix::trace(self : DstreefenwickMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DstreefenwickMatrix::det(self : DstreefenwickMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DstreefenwickMatrix::norm(self : DstreefenwickMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DstreefenwickMatrix::to_string(self : DstreefenwickMatrix) -> String {
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

pub(all) struct DstreefenwickVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_tree_fenwick_make_vector(comps : Array[Double]) -> DstreefenwickVector {
  { comps, dim: comps.length() }
}

pub fn ds_tree_fenwick_vector_zero(dim : Int) -> DstreefenwickVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DstreefenwickVector::add(self : DstreefenwickVector, other : DstreefenwickVector) -> DstreefenwickVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DstreefenwickVector::sub(self : DstreefenwickVector, other : DstreefenwickVector) -> DstreefenwickVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DstreefenwickVector::scale(self : DstreefenwickVector, s : Double) -> DstreefenwickVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DstreefenwickVector::dot(self : DstreefenwickVector, other : DstreefenwickVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DstreefenwickVector::norm(self : DstreefenwickVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DstreefenwickVector::normalize(self : DstreefenwickVector) -> DstreefenwickVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DstreefenwickVector::dist(self : DstreefenwickVector, other : DstreefenwickVector) -> Double {
  self.sub(other).norm()
}

pub fn DstreefenwickVector::to_string(self : DstreefenwickVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_tree_fenwick_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_tree_fenwick_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_tree_fenwick_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_tree_fenwick_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_tree_fenwick_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_tree_fenwick_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_tree_fenwick_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_tree_fenwick_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_tree_fenwick_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_tree_fenwick_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_tree_fenwick_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_tree_fenwick_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_tree_fenwick_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_tree_fenwick_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_tree_fenwick_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_tree_fenwick_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_tree_fenwick_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_tree_fenwick_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_tree_fenwick_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_tree_fenwick_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_tree_fenwick_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_tree_fenwick_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_tree_fenwick_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_tree_fenwick_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_tree_fenwick_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_tree_fenwick_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_tree_fenwick_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_tree_fenwick_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_tree_fenwick_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DstreefenwickFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_frame_make(size : Int) -> DstreefenwickFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreefenwickFrame::len(self : DstreefenwickFrame) -> Int { self.size }

pub fn DstreefenwickFrame::get(self : DstreefenwickFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreefenwickFrame::set(self : DstreefenwickFrame, i : Int, v : Double) -> DstreefenwickFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreefenwickFrame::sum(self : DstreefenwickFrame) -> Double { @_common.sum(self.data) }

pub fn DstreefenwickFrame::mean(self : DstreefenwickFrame) -> Double { @_common.mean(self.data) }

pub fn DstreefenwickFrame::scale(self : DstreefenwickFrame, f : Double) -> DstreefenwickFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreefenwickFrame::add(self : DstreefenwickFrame, other : DstreefenwickFrame) -> DstreefenwickFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreefenwickFrame::copy(self : DstreefenwickFrame) -> DstreefenwickFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreefenwickFrame::fill(self : DstreefenwickFrame, v : Double) -> DstreefenwickFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreefenwickFrame::min(self : DstreefenwickFrame) -> Double { @_common.min(self.data) }

pub fn DstreefenwickFrame::max(self : DstreefenwickFrame) -> Double { @_common.max(self.data) }

pub fn DstreefenwickFrame::to_string(self : DstreefenwickFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreefenwickTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_table_make(size : Int) -> DstreefenwickTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreefenwickTable::len(self : DstreefenwickTable) -> Int { self.size }

pub fn DstreefenwickTable::get(self : DstreefenwickTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreefenwickTable::set(self : DstreefenwickTable, i : Int, v : Double) -> DstreefenwickTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreefenwickTable::sum(self : DstreefenwickTable) -> Double { @_common.sum(self.data) }

pub fn DstreefenwickTable::mean(self : DstreefenwickTable) -> Double { @_common.mean(self.data) }

pub fn DstreefenwickTable::scale(self : DstreefenwickTable, f : Double) -> DstreefenwickTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreefenwickTable::add(self : DstreefenwickTable, other : DstreefenwickTable) -> DstreefenwickTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreefenwickTable::copy(self : DstreefenwickTable) -> DstreefenwickTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreefenwickTable::fill(self : DstreefenwickTable, v : Double) -> DstreefenwickTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreefenwickTable::min(self : DstreefenwickTable) -> Double { @_common.min(self.data) }

pub fn DstreefenwickTable::max(self : DstreefenwickTable) -> Double { @_common.max(self.data) }

pub fn DstreefenwickTable::to_string(self : DstreefenwickTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreefenwickGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_graphn_make(size : Int) -> DstreefenwickGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreefenwickGraphN::len(self : DstreefenwickGraphN) -> Int { self.size }

pub fn DstreefenwickGraphN::get(self : DstreefenwickGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreefenwickGraphN::set(self : DstreefenwickGraphN, i : Int, v : Double) -> DstreefenwickGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreefenwickGraphN::sum(self : DstreefenwickGraphN) -> Double { @_common.sum(self.data) }

pub fn DstreefenwickGraphN::mean(self : DstreefenwickGraphN) -> Double { @_common.mean(self.data) }

pub fn DstreefenwickGraphN::scale(self : DstreefenwickGraphN, f : Double) -> DstreefenwickGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreefenwickGraphN::add(self : DstreefenwickGraphN, other : DstreefenwickGraphN) -> DstreefenwickGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreefenwickGraphN::copy(self : DstreefenwickGraphN) -> DstreefenwickGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreefenwickGraphN::fill(self : DstreefenwickGraphN, v : Double) -> DstreefenwickGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreefenwickGraphN::min(self : DstreefenwickGraphN) -> Double { @_common.min(self.data) }

pub fn DstreefenwickGraphN::max(self : DstreefenwickGraphN) -> Double { @_common.max(self.data) }

pub fn DstreefenwickGraphN::to_string(self : DstreefenwickGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreefenwickNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_node_make(size : Int) -> DstreefenwickNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreefenwickNode::len(self : DstreefenwickNode) -> Int { self.size }

pub fn DstreefenwickNode::get(self : DstreefenwickNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreefenwickNode::set(self : DstreefenwickNode, i : Int, v : Double) -> DstreefenwickNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreefenwickNode::sum(self : DstreefenwickNode) -> Double { @_common.sum(self.data) }

pub fn DstreefenwickNode::mean(self : DstreefenwickNode) -> Double { @_common.mean(self.data) }

pub fn DstreefenwickNode::scale(self : DstreefenwickNode, f : Double) -> DstreefenwickNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreefenwickNode::add(self : DstreefenwickNode, other : DstreefenwickNode) -> DstreefenwickNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreefenwickNode::copy(self : DstreefenwickNode) -> DstreefenwickNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreefenwickNode::fill(self : DstreefenwickNode, v : Double) -> DstreefenwickNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreefenwickNode::min(self : DstreefenwickNode) -> Double { @_common.min(self.data) }

pub fn DstreefenwickNode::max(self : DstreefenwickNode) -> Double { @_common.max(self.data) }

pub fn DstreefenwickNode::to_string(self : DstreefenwickNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreefenwickEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_edge_make(size : Int) -> DstreefenwickEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreefenwickEdge::len(self : DstreefenwickEdge) -> Int { self.size }

pub fn DstreefenwickEdge::get(self : DstreefenwickEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreefenwickEdge::set(self : DstreefenwickEdge, i : Int, v : Double) -> DstreefenwickEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreefenwickEdge::sum(self : DstreefenwickEdge) -> Double { @_common.sum(self.data) }

pub fn DstreefenwickEdge::mean(self : DstreefenwickEdge) -> Double { @_common.mean(self.data) }

pub fn DstreefenwickEdge::scale(self : DstreefenwickEdge, f : Double) -> DstreefenwickEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreefenwickEdge::add(self : DstreefenwickEdge, other : DstreefenwickEdge) -> DstreefenwickEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreefenwickEdge::copy(self : DstreefenwickEdge) -> DstreefenwickEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreefenwickEdge::fill(self : DstreefenwickEdge, v : Double) -> DstreefenwickEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreefenwickEdge::min(self : DstreefenwickEdge) -> Double { @_common.min(self.data) }

pub fn DstreefenwickEdge::max(self : DstreefenwickEdge) -> Double { @_common.max(self.data) }

pub fn DstreefenwickEdge::to_string(self : DstreefenwickEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreefenwickPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_path_make(size : Int) -> DstreefenwickPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreefenwickPath::len(self : DstreefenwickPath) -> Int { self.size }

pub fn DstreefenwickPath::get(self : DstreefenwickPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreefenwickPath::set(self : DstreefenwickPath, i : Int, v : Double) -> DstreefenwickPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreefenwickPath::sum(self : DstreefenwickPath) -> Double { @_common.sum(self.data) }

pub fn DstreefenwickPath::mean(self : DstreefenwickPath) -> Double { @_common.mean(self.data) }

pub fn DstreefenwickPath::scale(self : DstreefenwickPath, f : Double) -> DstreefenwickPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreefenwickPath::add(self : DstreefenwickPath, other : DstreefenwickPath) -> DstreefenwickPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreefenwickPath::copy(self : DstreefenwickPath) -> DstreefenwickPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreefenwickPath::fill(self : DstreefenwickPath, v : Double) -> DstreefenwickPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreefenwickPath::min(self : DstreefenwickPath) -> Double { @_common.min(self.data) }

pub fn DstreefenwickPath::max(self : DstreefenwickPath) -> Double { @_common.max(self.data) }

pub fn DstreefenwickPath::to_string(self : DstreefenwickPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreefenwickCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_cluster_make(size : Int) -> DstreefenwickCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreefenwickCluster::len(self : DstreefenwickCluster) -> Int { self.size }

pub fn DstreefenwickCluster::get(self : DstreefenwickCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreefenwickCluster::set(self : DstreefenwickCluster, i : Int, v : Double) -> DstreefenwickCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreefenwickCluster::sum(self : DstreefenwickCluster) -> Double { @_common.sum(self.data) }

pub fn DstreefenwickCluster::mean(self : DstreefenwickCluster) -> Double { @_common.mean(self.data) }

pub fn DstreefenwickCluster::scale(self : DstreefenwickCluster, f : Double) -> DstreefenwickCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreefenwickCluster::add(self : DstreefenwickCluster, other : DstreefenwickCluster) -> DstreefenwickCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreefenwickCluster::copy(self : DstreefenwickCluster) -> DstreefenwickCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreefenwickCluster::fill(self : DstreefenwickCluster, v : Double) -> DstreefenwickCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreefenwickCluster::min(self : DstreefenwickCluster) -> Double { @_common.min(self.data) }

pub fn DstreefenwickCluster::max(self : DstreefenwickCluster) -> Double { @_common.max(self.data) }

pub fn DstreefenwickCluster::to_string(self : DstreefenwickCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreefenwickModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_model_make(size : Int) -> DstreefenwickModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreefenwickModel::len(self : DstreefenwickModel) -> Int { self.size }

pub fn DstreefenwickModel::get(self : DstreefenwickModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreefenwickModel::set(self : DstreefenwickModel, i : Int, v : Double) -> DstreefenwickModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreefenwickModel::sum(self : DstreefenwickModel) -> Double { @_common.sum(self.data) }

pub fn DstreefenwickModel::mean(self : DstreefenwickModel) -> Double { @_common.mean(self.data) }

pub fn DstreefenwickModel::scale(self : DstreefenwickModel, f : Double) -> DstreefenwickModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreefenwickModel::add(self : DstreefenwickModel, other : DstreefenwickModel) -> DstreefenwickModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreefenwickModel::copy(self : DstreefenwickModel) -> DstreefenwickModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreefenwickModel::fill(self : DstreefenwickModel, v : Double) -> DstreefenwickModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreefenwickModel::min(self : DstreefenwickModel) -> Double { @_common.min(self.data) }

pub fn DstreefenwickModel::max(self : DstreefenwickModel) -> Double { @_common.max(self.data) }

pub fn DstreefenwickModel::to_string(self : DstreefenwickModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreefenwickLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_layer_make(size : Int) -> DstreefenwickLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreefenwickLayer::len(self : DstreefenwickLayer) -> Int { self.size }

pub fn DstreefenwickLayer::get(self : DstreefenwickLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreefenwickLayer::set(self : DstreefenwickLayer, i : Int, v : Double) -> DstreefenwickLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreefenwickLayer::sum(self : DstreefenwickLayer) -> Double { @_common.sum(self.data) }

pub fn DstreefenwickLayer::mean(self : DstreefenwickLayer) -> Double { @_common.mean(self.data) }

pub fn DstreefenwickLayer::scale(self : DstreefenwickLayer, f : Double) -> DstreefenwickLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreefenwickLayer::add(self : DstreefenwickLayer, other : DstreefenwickLayer) -> DstreefenwickLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreefenwickLayer::copy(self : DstreefenwickLayer) -> DstreefenwickLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreefenwickLayer::fill(self : DstreefenwickLayer, v : Double) -> DstreefenwickLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreefenwickLayer::min(self : DstreefenwickLayer) -> Double { @_common.min(self.data) }

pub fn DstreefenwickLayer::max(self : DstreefenwickLayer) -> Double { @_common.max(self.data) }

pub fn DstreefenwickLayer::to_string(self : DstreefenwickLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreefenwickBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_buffer_make(size : Int) -> DstreefenwickBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreefenwickBuffer::len(self : DstreefenwickBuffer) -> Int { self.size }

pub fn DstreefenwickBuffer::get(self : DstreefenwickBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreefenwickBuffer::set(self : DstreefenwickBuffer, i : Int, v : Double) -> DstreefenwickBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreefenwickBuffer::sum(self : DstreefenwickBuffer) -> Double { @_common.sum(self.data) }

pub fn DstreefenwickBuffer::mean(self : DstreefenwickBuffer) -> Double { @_common.mean(self.data) }

pub fn DstreefenwickBuffer::scale(self : DstreefenwickBuffer, f : Double) -> DstreefenwickBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreefenwickBuffer::add(self : DstreefenwickBuffer, other : DstreefenwickBuffer) -> DstreefenwickBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreefenwickBuffer::copy(self : DstreefenwickBuffer) -> DstreefenwickBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreefenwickBuffer::fill(self : DstreefenwickBuffer, v : Double) -> DstreefenwickBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreefenwickBuffer::min(self : DstreefenwickBuffer) -> Double { @_common.min(self.data) }

pub fn DstreefenwickBuffer::max(self : DstreefenwickBuffer) -> Double { @_common.max(self.data) }

pub fn DstreefenwickBuffer::to_string(self : DstreefenwickBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreefenwickCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_cursor_make(size : Int) -> DstreefenwickCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreefenwickCursor::len(self : DstreefenwickCursor) -> Int { self.size }

pub fn DstreefenwickCursor::get(self : DstreefenwickCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreefenwickCursor::set(self : DstreefenwickCursor, i : Int, v : Double) -> DstreefenwickCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreefenwickCursor::sum(self : DstreefenwickCursor) -> Double { @_common.sum(self.data) }

pub fn DstreefenwickCursor::mean(self : DstreefenwickCursor) -> Double { @_common.mean(self.data) }

pub fn DstreefenwickCursor::scale(self : DstreefenwickCursor, f : Double) -> DstreefenwickCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreefenwickCursor::add(self : DstreefenwickCursor, other : DstreefenwickCursor) -> DstreefenwickCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreefenwickCursor::copy(self : DstreefenwickCursor) -> DstreefenwickCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreefenwickCursor::fill(self : DstreefenwickCursor, v : Double) -> DstreefenwickCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreefenwickCursor::min(self : DstreefenwickCursor) -> Double { @_common.min(self.data) }

pub fn DstreefenwickCursor::max(self : DstreefenwickCursor) -> Double { @_common.max(self.data) }

pub fn DstreefenwickCursor::to_string(self : DstreefenwickCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreefenwickView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_view_make(size : Int) -> DstreefenwickView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreefenwickView::len(self : DstreefenwickView) -> Int { self.size }

pub fn DstreefenwickView::get(self : DstreefenwickView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreefenwickView::set(self : DstreefenwickView, i : Int, v : Double) -> DstreefenwickView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreefenwickView::sum(self : DstreefenwickView) -> Double { @_common.sum(self.data) }

pub fn DstreefenwickView::mean(self : DstreefenwickView) -> Double { @_common.mean(self.data) }

pub fn DstreefenwickView::scale(self : DstreefenwickView, f : Double) -> DstreefenwickView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreefenwickView::add(self : DstreefenwickView, other : DstreefenwickView) -> DstreefenwickView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreefenwickView::copy(self : DstreefenwickView) -> DstreefenwickView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreefenwickView::fill(self : DstreefenwickView, v : Double) -> DstreefenwickView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreefenwickView::min(self : DstreefenwickView) -> Double { @_common.min(self.data) }

pub fn DstreefenwickView::max(self : DstreefenwickView) -> Double { @_common.max(self.data) }

pub fn DstreefenwickView::to_string(self : DstreefenwickView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreefenwickRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_range_make(size : Int) -> DstreefenwickRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreefenwickRange::len(self : DstreefenwickRange) -> Int { self.size }

pub fn DstreefenwickRange::get(self : DstreefenwickRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreefenwickRange::set(self : DstreefenwickRange, i : Int, v : Double) -> DstreefenwickRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreefenwickRange::sum(self : DstreefenwickRange) -> Double { @_common.sum(self.data) }

pub fn DstreefenwickRange::mean(self : DstreefenwickRange) -> Double { @_common.mean(self.data) }

pub fn DstreefenwickRange::scale(self : DstreefenwickRange, f : Double) -> DstreefenwickRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreefenwickRange::add(self : DstreefenwickRange, other : DstreefenwickRange) -> DstreefenwickRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreefenwickRange::copy(self : DstreefenwickRange) -> DstreefenwickRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreefenwickRange::fill(self : DstreefenwickRange, v : Double) -> DstreefenwickRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreefenwickRange::min(self : DstreefenwickRange) -> Double { @_common.min(self.data) }

pub fn DstreefenwickRange::max(self : DstreefenwickRange) -> Double { @_common.max(self.data) }

pub fn DstreefenwickRange::to_string(self : DstreefenwickRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DstreefenwickSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_slice_make(size : Int) -> DstreefenwickSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DstreefenwickSlice::len(self : DstreefenwickSlice) -> Int { self.size }

pub fn DstreefenwickSlice::get(self : DstreefenwickSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DstreefenwickSlice::set(self : DstreefenwickSlice, i : Int, v : Double) -> DstreefenwickSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DstreefenwickSlice::sum(self : DstreefenwickSlice) -> Double { @_common.sum(self.data) }

pub fn DstreefenwickSlice::mean(self : DstreefenwickSlice) -> Double { @_common.mean(self.data) }

pub fn DstreefenwickSlice::scale(self : DstreefenwickSlice, f : Double) -> DstreefenwickSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DstreefenwickSlice::add(self : DstreefenwickSlice, other : DstreefenwickSlice) -> DstreefenwickSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DstreefenwickSlice::copy(self : DstreefenwickSlice) -> DstreefenwickSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DstreefenwickSlice::fill(self : DstreefenwickSlice, v : Double) -> DstreefenwickSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DstreefenwickSlice::min(self : DstreefenwickSlice) -> Double { @_common.min(self.data) }

pub fn DstreefenwickSlice::max(self : DstreefenwickSlice) -> Double { @_common.max(self.data) }

pub fn DstreefenwickSlice::to_string(self : DstreefenwickSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

