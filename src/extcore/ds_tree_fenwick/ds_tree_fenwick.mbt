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

pub fn ds_tree_fenwick_frame_len(s : DstreefenwickFrame) -> Int { s.size }

pub fn ds_tree_fenwick_frame_get(s : DstreefenwickFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_frame_set(s : DstreefenwickFrame, i : Int, v : Double) -> DstreefenwickFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_frame_sum(s : DstreefenwickFrame) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_frame_mean(s : DstreefenwickFrame) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_frame_scale(s : DstreefenwickFrame, f : Double) -> DstreefenwickFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_frame_add(a : DstreefenwickFrame, b : DstreefenwickFrame) -> DstreefenwickFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_frame_copy(s : DstreefenwickFrame) -> DstreefenwickFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_frame_fill(s : DstreefenwickFrame, v : Double) -> DstreefenwickFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_frame_min(s : DstreefenwickFrame) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_frame_max(s : DstreefenwickFrame) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_frame_to_string(s : DstreefenwickFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_table_make(size : Int) -> DstreefenwickTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_table_len(s : DstreefenwickTable) -> Int { s.size }

pub fn ds_tree_fenwick_table_get(s : DstreefenwickTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_table_set(s : DstreefenwickTable, i : Int, v : Double) -> DstreefenwickTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_table_sum(s : DstreefenwickTable) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_table_mean(s : DstreefenwickTable) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_table_scale(s : DstreefenwickTable, f : Double) -> DstreefenwickTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_table_add(a : DstreefenwickTable, b : DstreefenwickTable) -> DstreefenwickTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_table_copy(s : DstreefenwickTable) -> DstreefenwickTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_table_fill(s : DstreefenwickTable, v : Double) -> DstreefenwickTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_table_min(s : DstreefenwickTable) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_table_max(s : DstreefenwickTable) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_table_to_string(s : DstreefenwickTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_graphn_make(size : Int) -> DstreefenwickGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_graphn_len(s : DstreefenwickGraphN) -> Int { s.size }

pub fn ds_tree_fenwick_graphn_get(s : DstreefenwickGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_graphn_set(s : DstreefenwickGraphN, i : Int, v : Double) -> DstreefenwickGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_graphn_sum(s : DstreefenwickGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_graphn_mean(s : DstreefenwickGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_graphn_scale(s : DstreefenwickGraphN, f : Double) -> DstreefenwickGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_graphn_add(a : DstreefenwickGraphN, b : DstreefenwickGraphN) -> DstreefenwickGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_graphn_copy(s : DstreefenwickGraphN) -> DstreefenwickGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_graphn_fill(s : DstreefenwickGraphN, v : Double) -> DstreefenwickGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_graphn_min(s : DstreefenwickGraphN) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_graphn_max(s : DstreefenwickGraphN) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_graphn_to_string(s : DstreefenwickGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_node_make(size : Int) -> DstreefenwickNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_node_len(s : DstreefenwickNode) -> Int { s.size }

pub fn ds_tree_fenwick_node_get(s : DstreefenwickNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_node_set(s : DstreefenwickNode, i : Int, v : Double) -> DstreefenwickNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_node_sum(s : DstreefenwickNode) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_node_mean(s : DstreefenwickNode) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_node_scale(s : DstreefenwickNode, f : Double) -> DstreefenwickNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_node_add(a : DstreefenwickNode, b : DstreefenwickNode) -> DstreefenwickNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_node_copy(s : DstreefenwickNode) -> DstreefenwickNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_node_fill(s : DstreefenwickNode, v : Double) -> DstreefenwickNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_node_min(s : DstreefenwickNode) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_node_max(s : DstreefenwickNode) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_node_to_string(s : DstreefenwickNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_edge_make(size : Int) -> DstreefenwickEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_edge_len(s : DstreefenwickEdge) -> Int { s.size }

pub fn ds_tree_fenwick_edge_get(s : DstreefenwickEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_edge_set(s : DstreefenwickEdge, i : Int, v : Double) -> DstreefenwickEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_edge_sum(s : DstreefenwickEdge) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_edge_mean(s : DstreefenwickEdge) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_edge_scale(s : DstreefenwickEdge, f : Double) -> DstreefenwickEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_edge_add(a : DstreefenwickEdge, b : DstreefenwickEdge) -> DstreefenwickEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_edge_copy(s : DstreefenwickEdge) -> DstreefenwickEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_edge_fill(s : DstreefenwickEdge, v : Double) -> DstreefenwickEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_edge_min(s : DstreefenwickEdge) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_edge_max(s : DstreefenwickEdge) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_edge_to_string(s : DstreefenwickEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_path_make(size : Int) -> DstreefenwickPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_path_len(s : DstreefenwickPath) -> Int { s.size }

pub fn ds_tree_fenwick_path_get(s : DstreefenwickPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_path_set(s : DstreefenwickPath, i : Int, v : Double) -> DstreefenwickPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_path_sum(s : DstreefenwickPath) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_path_mean(s : DstreefenwickPath) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_path_scale(s : DstreefenwickPath, f : Double) -> DstreefenwickPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_path_add(a : DstreefenwickPath, b : DstreefenwickPath) -> DstreefenwickPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_path_copy(s : DstreefenwickPath) -> DstreefenwickPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_path_fill(s : DstreefenwickPath, v : Double) -> DstreefenwickPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_path_min(s : DstreefenwickPath) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_path_max(s : DstreefenwickPath) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_path_to_string(s : DstreefenwickPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_cluster_make(size : Int) -> DstreefenwickCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_cluster_len(s : DstreefenwickCluster) -> Int { s.size }

pub fn ds_tree_fenwick_cluster_get(s : DstreefenwickCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_cluster_set(s : DstreefenwickCluster, i : Int, v : Double) -> DstreefenwickCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cluster_sum(s : DstreefenwickCluster) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_cluster_mean(s : DstreefenwickCluster) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_cluster_scale(s : DstreefenwickCluster, f : Double) -> DstreefenwickCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cluster_add(a : DstreefenwickCluster, b : DstreefenwickCluster) -> DstreefenwickCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_cluster_copy(s : DstreefenwickCluster) -> DstreefenwickCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cluster_fill(s : DstreefenwickCluster, v : Double) -> DstreefenwickCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cluster_min(s : DstreefenwickCluster) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_cluster_max(s : DstreefenwickCluster) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_cluster_to_string(s : DstreefenwickCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_model_make(size : Int) -> DstreefenwickModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_model_len(s : DstreefenwickModel) -> Int { s.size }

pub fn ds_tree_fenwick_model_get(s : DstreefenwickModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_model_set(s : DstreefenwickModel, i : Int, v : Double) -> DstreefenwickModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_model_sum(s : DstreefenwickModel) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_model_mean(s : DstreefenwickModel) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_model_scale(s : DstreefenwickModel, f : Double) -> DstreefenwickModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_model_add(a : DstreefenwickModel, b : DstreefenwickModel) -> DstreefenwickModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_model_copy(s : DstreefenwickModel) -> DstreefenwickModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_model_fill(s : DstreefenwickModel, v : Double) -> DstreefenwickModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_model_min(s : DstreefenwickModel) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_model_max(s : DstreefenwickModel) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_model_to_string(s : DstreefenwickModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_layer_make(size : Int) -> DstreefenwickLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_layer_len(s : DstreefenwickLayer) -> Int { s.size }

pub fn ds_tree_fenwick_layer_get(s : DstreefenwickLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_layer_set(s : DstreefenwickLayer, i : Int, v : Double) -> DstreefenwickLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_layer_sum(s : DstreefenwickLayer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_layer_mean(s : DstreefenwickLayer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_layer_scale(s : DstreefenwickLayer, f : Double) -> DstreefenwickLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_layer_add(a : DstreefenwickLayer, b : DstreefenwickLayer) -> DstreefenwickLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_layer_copy(s : DstreefenwickLayer) -> DstreefenwickLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_layer_fill(s : DstreefenwickLayer, v : Double) -> DstreefenwickLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_layer_min(s : DstreefenwickLayer) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_layer_max(s : DstreefenwickLayer) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_layer_to_string(s : DstreefenwickLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_buffer_make(size : Int) -> DstreefenwickBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_buffer_len(s : DstreefenwickBuffer) -> Int { s.size }

pub fn ds_tree_fenwick_buffer_get(s : DstreefenwickBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_buffer_set(s : DstreefenwickBuffer, i : Int, v : Double) -> DstreefenwickBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_buffer_sum(s : DstreefenwickBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_buffer_mean(s : DstreefenwickBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_buffer_scale(s : DstreefenwickBuffer, f : Double) -> DstreefenwickBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_buffer_add(a : DstreefenwickBuffer, b : DstreefenwickBuffer) -> DstreefenwickBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_buffer_copy(s : DstreefenwickBuffer) -> DstreefenwickBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_buffer_fill(s : DstreefenwickBuffer, v : Double) -> DstreefenwickBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_buffer_min(s : DstreefenwickBuffer) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_buffer_max(s : DstreefenwickBuffer) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_buffer_to_string(s : DstreefenwickBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_cursor_make(size : Int) -> DstreefenwickCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_cursor_len(s : DstreefenwickCursor) -> Int { s.size }

pub fn ds_tree_fenwick_cursor_get(s : DstreefenwickCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_cursor_set(s : DstreefenwickCursor, i : Int, v : Double) -> DstreefenwickCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cursor_sum(s : DstreefenwickCursor) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_cursor_mean(s : DstreefenwickCursor) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_cursor_scale(s : DstreefenwickCursor, f : Double) -> DstreefenwickCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cursor_add(a : DstreefenwickCursor, b : DstreefenwickCursor) -> DstreefenwickCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_cursor_copy(s : DstreefenwickCursor) -> DstreefenwickCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cursor_fill(s : DstreefenwickCursor, v : Double) -> DstreefenwickCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_cursor_min(s : DstreefenwickCursor) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_cursor_max(s : DstreefenwickCursor) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_cursor_to_string(s : DstreefenwickCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_view_make(size : Int) -> DstreefenwickView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_view_len(s : DstreefenwickView) -> Int { s.size }

pub fn ds_tree_fenwick_view_get(s : DstreefenwickView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_view_set(s : DstreefenwickView, i : Int, v : Double) -> DstreefenwickView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_view_sum(s : DstreefenwickView) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_view_mean(s : DstreefenwickView) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_view_scale(s : DstreefenwickView, f : Double) -> DstreefenwickView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_view_add(a : DstreefenwickView, b : DstreefenwickView) -> DstreefenwickView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_view_copy(s : DstreefenwickView) -> DstreefenwickView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_view_fill(s : DstreefenwickView, v : Double) -> DstreefenwickView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_view_min(s : DstreefenwickView) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_view_max(s : DstreefenwickView) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_view_to_string(s : DstreefenwickView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_range_make(size : Int) -> DstreefenwickRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_range_len(s : DstreefenwickRange) -> Int { s.size }

pub fn ds_tree_fenwick_range_get(s : DstreefenwickRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_range_set(s : DstreefenwickRange, i : Int, v : Double) -> DstreefenwickRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_range_sum(s : DstreefenwickRange) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_range_mean(s : DstreefenwickRange) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_range_scale(s : DstreefenwickRange, f : Double) -> DstreefenwickRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_range_add(a : DstreefenwickRange, b : DstreefenwickRange) -> DstreefenwickRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_range_copy(s : DstreefenwickRange) -> DstreefenwickRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_range_fill(s : DstreefenwickRange, v : Double) -> DstreefenwickRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_range_min(s : DstreefenwickRange) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_range_max(s : DstreefenwickRange) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_range_to_string(s : DstreefenwickRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DstreefenwickSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_tree_fenwick_slice_make(size : Int) -> DstreefenwickSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_tree_fenwick_slice_len(s : DstreefenwickSlice) -> Int { s.size }

pub fn ds_tree_fenwick_slice_get(s : DstreefenwickSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_tree_fenwick_slice_set(s : DstreefenwickSlice, i : Int, v : Double) -> DstreefenwickSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_slice_sum(s : DstreefenwickSlice) -> Double { @_common.sum(s.data) }

pub fn ds_tree_fenwick_slice_mean(s : DstreefenwickSlice) -> Double { @_common.mean(s.data) }

pub fn ds_tree_fenwick_slice_scale(s : DstreefenwickSlice, f : Double) -> DstreefenwickSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_slice_add(a : DstreefenwickSlice, b : DstreefenwickSlice) -> DstreefenwickSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_tree_fenwick_slice_copy(s : DstreefenwickSlice) -> DstreefenwickSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_slice_fill(s : DstreefenwickSlice, v : Double) -> DstreefenwickSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_tree_fenwick_slice_min(s : DstreefenwickSlice) -> Double { @_common.min(s.data) }

pub fn ds_tree_fenwick_slice_max(s : DstreefenwickSlice) -> Double { @_common.max(s.data) }

pub fn ds_tree_fenwick_slice_to_string(s : DstreefenwickSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

