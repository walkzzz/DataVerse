///===
/// extcore/ds_hash_robin

pub(all) struct DshashrobinPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_robin_make_point(x : Double, y : Double) -> DshashrobinPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_robin_make_point3(x : Double, y : Double, z : Double) -> DshashrobinPoint {
  { x, y, z, label: 0 }
}

pub fn DshashrobinPoint::x(self : DshashrobinPoint) -> Double { self.x }

pub fn DshashrobinPoint::y(self : DshashrobinPoint) -> Double { self.y }

pub fn DshashrobinPoint::z(self : DshashrobinPoint) -> Double { self.z }

pub fn DshashrobinPoint::label(self : DshashrobinPoint) -> Int { self.label }

pub fn DshashrobinPoint::dist(self : DshashrobinPoint, other : DshashrobinPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashrobinPoint::add(self : DshashrobinPoint, other : DshashrobinPoint) -> DshashrobinPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashrobinPoint::sub(self : DshashrobinPoint, other : DshashrobinPoint) -> DshashrobinPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashrobinPoint::scale(self : DshashrobinPoint, s : Double) -> DshashrobinPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashrobinPoint::dot(self : DshashrobinPoint, other : DshashrobinPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashrobinPoint::cross(self : DshashrobinPoint, other : DshashrobinPoint) -> DshashrobinPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashrobinPoint::norm(self : DshashrobinPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashrobinPoint::normalize(self : DshashrobinPoint) -> DshashrobinPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashrobinPoint::negate(self : DshashrobinPoint) -> DshashrobinPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashrobinPoint::mid(self : DshashrobinPoint, other : DshashrobinPoint) -> DshashrobinPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashrobinPoint::lerp(self : DshashrobinPoint, other : DshashrobinPoint, t : Double) -> DshashrobinPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashrobinPoint::to_string(self : DshashrobinPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashrobinSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_robin_make_series(vals : Array[Double], name : String) -> DshashrobinSeries {
  { vals, name, meta: 0 }
}

pub fn DshashrobinSeries::len(self : DshashrobinSeries) -> Int { self.vals.length() }

pub fn DshashrobinSeries::sum(self : DshashrobinSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashrobinSeries::mean(self : DshashrobinSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashrobinSeries::min(self : DshashrobinSeries) -> Double { @_common.min(self.vals) }

pub fn DshashrobinSeries::max(self : DshashrobinSeries) -> Double { @_common.max(self.vals) }

pub fn DshashrobinSeries::range(self : DshashrobinSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashrobinSeries::variance(self : DshashrobinSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashrobinSeries::std(self : DshashrobinSeries) -> Double { @_common.std(self.vals) }

pub fn DshashrobinSeries::median(self : DshashrobinSeries) -> Double { @_common.median(self.vals) }

pub fn DshashrobinSeries::scale(self : DshashrobinSeries, f : Double) -> DshashrobinSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashrobinSeries::add(self : DshashrobinSeries, other : DshashrobinSeries) -> DshashrobinSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashrobinSeries::sub(self : DshashrobinSeries, other : DshashrobinSeries) -> DshashrobinSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashrobinSeries::normalize(self : DshashrobinSeries) -> DshashrobinSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashrobinSeries::cumsum(self : DshashrobinSeries) -> DshashrobinSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashrobinSeries::to_string(self : DshashrobinSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashrobinMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_robin_make_matrix(rows : Int, cols : Int, val : Double) -> DshashrobinMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_robin_matrix_identity(n : Int) -> DshashrobinMatrix {
  let m = ds_hash_robin_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashrobinMatrix::get(self : DshashrobinMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashrobinMatrix::transpose(self : DshashrobinMatrix) -> DshashrobinMatrix {
  let result = ds_hash_robin_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashrobinMatrix::add(self : DshashrobinMatrix, other : DshashrobinMatrix) -> DshashrobinMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_robin_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashrobinMatrix::scale(self : DshashrobinMatrix, s : Double) -> DshashrobinMatrix {
  let result = ds_hash_robin_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashrobinMatrix::multiply(self : DshashrobinMatrix, other : DshashrobinMatrix) -> DshashrobinMatrix {
  if self.cols != other.rows { return ds_hash_robin_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_robin_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DshashrobinMatrix::trace(self : DshashrobinMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashrobinMatrix::det(self : DshashrobinMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashrobinMatrix::norm(self : DshashrobinMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashrobinMatrix::to_string(self : DshashrobinMatrix) -> String {
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

pub(all) struct DshashrobinVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_robin_make_vector(comps : Array[Double]) -> DshashrobinVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_robin_vector_zero(dim : Int) -> DshashrobinVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashrobinVector::add(self : DshashrobinVector, other : DshashrobinVector) -> DshashrobinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashrobinVector::sub(self : DshashrobinVector, other : DshashrobinVector) -> DshashrobinVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashrobinVector::scale(self : DshashrobinVector, s : Double) -> DshashrobinVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashrobinVector::dot(self : DshashrobinVector, other : DshashrobinVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashrobinVector::norm(self : DshashrobinVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashrobinVector::normalize(self : DshashrobinVector) -> DshashrobinVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashrobinVector::dist(self : DshashrobinVector, other : DshashrobinVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashrobinVector::to_string(self : DshashrobinVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_robin_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_robin_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_robin_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_robin_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_robin_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_robin_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_robin_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_robin_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_robin_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_robin_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_robin_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_robin_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_robin_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_robin_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_robin_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_robin_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_robin_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_robin_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_robin_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_robin_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_robin_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_robin_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_robin_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_robin_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_robin_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_robin_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_robin_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_robin_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_robin_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashrobinFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_frame_make(size : Int) -> DshashrobinFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_frame_len(s : DshashrobinFrame) -> Int { s.size }

pub fn ds_hash_robin_frame_get(s : DshashrobinFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_frame_set(s : DshashrobinFrame, i : Int, v : Double) -> DshashrobinFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_frame_sum(s : DshashrobinFrame) -> Double { @_common.sum(s.data) }

pub fn ds_hash_robin_frame_mean(s : DshashrobinFrame) -> Double { @_common.mean(s.data) }

pub fn ds_hash_robin_frame_scale(s : DshashrobinFrame, f : Double) -> DshashrobinFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_frame_add(a : DshashrobinFrame, b : DshashrobinFrame) -> DshashrobinFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_robin_frame_copy(s : DshashrobinFrame) -> DshashrobinFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_frame_fill(s : DshashrobinFrame, v : Double) -> DshashrobinFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_frame_min(s : DshashrobinFrame) -> Double { @_common.min(s.data) }

pub fn ds_hash_robin_frame_max(s : DshashrobinFrame) -> Double { @_common.max(s.data) }

pub fn ds_hash_robin_frame_to_string(s : DshashrobinFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_table_make(size : Int) -> DshashrobinTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_table_len(s : DshashrobinTable) -> Int { s.size }

pub fn ds_hash_robin_table_get(s : DshashrobinTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_table_set(s : DshashrobinTable, i : Int, v : Double) -> DshashrobinTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_table_sum(s : DshashrobinTable) -> Double { @_common.sum(s.data) }

pub fn ds_hash_robin_table_mean(s : DshashrobinTable) -> Double { @_common.mean(s.data) }

pub fn ds_hash_robin_table_scale(s : DshashrobinTable, f : Double) -> DshashrobinTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_table_add(a : DshashrobinTable, b : DshashrobinTable) -> DshashrobinTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_robin_table_copy(s : DshashrobinTable) -> DshashrobinTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_table_fill(s : DshashrobinTable, v : Double) -> DshashrobinTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_table_min(s : DshashrobinTable) -> Double { @_common.min(s.data) }

pub fn ds_hash_robin_table_max(s : DshashrobinTable) -> Double { @_common.max(s.data) }

pub fn ds_hash_robin_table_to_string(s : DshashrobinTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_graphn_make(size : Int) -> DshashrobinGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_graphn_len(s : DshashrobinGraphN) -> Int { s.size }

pub fn ds_hash_robin_graphn_get(s : DshashrobinGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_graphn_set(s : DshashrobinGraphN, i : Int, v : Double) -> DshashrobinGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_graphn_sum(s : DshashrobinGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_hash_robin_graphn_mean(s : DshashrobinGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_hash_robin_graphn_scale(s : DshashrobinGraphN, f : Double) -> DshashrobinGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_graphn_add(a : DshashrobinGraphN, b : DshashrobinGraphN) -> DshashrobinGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_robin_graphn_copy(s : DshashrobinGraphN) -> DshashrobinGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_graphn_fill(s : DshashrobinGraphN, v : Double) -> DshashrobinGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_graphn_min(s : DshashrobinGraphN) -> Double { @_common.min(s.data) }

pub fn ds_hash_robin_graphn_max(s : DshashrobinGraphN) -> Double { @_common.max(s.data) }

pub fn ds_hash_robin_graphn_to_string(s : DshashrobinGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_node_make(size : Int) -> DshashrobinNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_node_len(s : DshashrobinNode) -> Int { s.size }

pub fn ds_hash_robin_node_get(s : DshashrobinNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_node_set(s : DshashrobinNode, i : Int, v : Double) -> DshashrobinNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_node_sum(s : DshashrobinNode) -> Double { @_common.sum(s.data) }

pub fn ds_hash_robin_node_mean(s : DshashrobinNode) -> Double { @_common.mean(s.data) }

pub fn ds_hash_robin_node_scale(s : DshashrobinNode, f : Double) -> DshashrobinNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_node_add(a : DshashrobinNode, b : DshashrobinNode) -> DshashrobinNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_robin_node_copy(s : DshashrobinNode) -> DshashrobinNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_node_fill(s : DshashrobinNode, v : Double) -> DshashrobinNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_node_min(s : DshashrobinNode) -> Double { @_common.min(s.data) }

pub fn ds_hash_robin_node_max(s : DshashrobinNode) -> Double { @_common.max(s.data) }

pub fn ds_hash_robin_node_to_string(s : DshashrobinNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_edge_make(size : Int) -> DshashrobinEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_edge_len(s : DshashrobinEdge) -> Int { s.size }

pub fn ds_hash_robin_edge_get(s : DshashrobinEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_edge_set(s : DshashrobinEdge, i : Int, v : Double) -> DshashrobinEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_edge_sum(s : DshashrobinEdge) -> Double { @_common.sum(s.data) }

pub fn ds_hash_robin_edge_mean(s : DshashrobinEdge) -> Double { @_common.mean(s.data) }

pub fn ds_hash_robin_edge_scale(s : DshashrobinEdge, f : Double) -> DshashrobinEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_edge_add(a : DshashrobinEdge, b : DshashrobinEdge) -> DshashrobinEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_robin_edge_copy(s : DshashrobinEdge) -> DshashrobinEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_edge_fill(s : DshashrobinEdge, v : Double) -> DshashrobinEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_edge_min(s : DshashrobinEdge) -> Double { @_common.min(s.data) }

pub fn ds_hash_robin_edge_max(s : DshashrobinEdge) -> Double { @_common.max(s.data) }

pub fn ds_hash_robin_edge_to_string(s : DshashrobinEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_path_make(size : Int) -> DshashrobinPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_path_len(s : DshashrobinPath) -> Int { s.size }

pub fn ds_hash_robin_path_get(s : DshashrobinPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_path_set(s : DshashrobinPath, i : Int, v : Double) -> DshashrobinPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_path_sum(s : DshashrobinPath) -> Double { @_common.sum(s.data) }

pub fn ds_hash_robin_path_mean(s : DshashrobinPath) -> Double { @_common.mean(s.data) }

pub fn ds_hash_robin_path_scale(s : DshashrobinPath, f : Double) -> DshashrobinPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_path_add(a : DshashrobinPath, b : DshashrobinPath) -> DshashrobinPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_robin_path_copy(s : DshashrobinPath) -> DshashrobinPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_path_fill(s : DshashrobinPath, v : Double) -> DshashrobinPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_path_min(s : DshashrobinPath) -> Double { @_common.min(s.data) }

pub fn ds_hash_robin_path_max(s : DshashrobinPath) -> Double { @_common.max(s.data) }

pub fn ds_hash_robin_path_to_string(s : DshashrobinPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_cluster_make(size : Int) -> DshashrobinCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_cluster_len(s : DshashrobinCluster) -> Int { s.size }

pub fn ds_hash_robin_cluster_get(s : DshashrobinCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_cluster_set(s : DshashrobinCluster, i : Int, v : Double) -> DshashrobinCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_cluster_sum(s : DshashrobinCluster) -> Double { @_common.sum(s.data) }

pub fn ds_hash_robin_cluster_mean(s : DshashrobinCluster) -> Double { @_common.mean(s.data) }

pub fn ds_hash_robin_cluster_scale(s : DshashrobinCluster, f : Double) -> DshashrobinCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_cluster_add(a : DshashrobinCluster, b : DshashrobinCluster) -> DshashrobinCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_robin_cluster_copy(s : DshashrobinCluster) -> DshashrobinCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_cluster_fill(s : DshashrobinCluster, v : Double) -> DshashrobinCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_cluster_min(s : DshashrobinCluster) -> Double { @_common.min(s.data) }

pub fn ds_hash_robin_cluster_max(s : DshashrobinCluster) -> Double { @_common.max(s.data) }

pub fn ds_hash_robin_cluster_to_string(s : DshashrobinCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_model_make(size : Int) -> DshashrobinModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_model_len(s : DshashrobinModel) -> Int { s.size }

pub fn ds_hash_robin_model_get(s : DshashrobinModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_model_set(s : DshashrobinModel, i : Int, v : Double) -> DshashrobinModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_model_sum(s : DshashrobinModel) -> Double { @_common.sum(s.data) }

pub fn ds_hash_robin_model_mean(s : DshashrobinModel) -> Double { @_common.mean(s.data) }

pub fn ds_hash_robin_model_scale(s : DshashrobinModel, f : Double) -> DshashrobinModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_model_add(a : DshashrobinModel, b : DshashrobinModel) -> DshashrobinModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_robin_model_copy(s : DshashrobinModel) -> DshashrobinModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_model_fill(s : DshashrobinModel, v : Double) -> DshashrobinModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_model_min(s : DshashrobinModel) -> Double { @_common.min(s.data) }

pub fn ds_hash_robin_model_max(s : DshashrobinModel) -> Double { @_common.max(s.data) }

pub fn ds_hash_robin_model_to_string(s : DshashrobinModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_layer_make(size : Int) -> DshashrobinLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_layer_len(s : DshashrobinLayer) -> Int { s.size }

pub fn ds_hash_robin_layer_get(s : DshashrobinLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_layer_set(s : DshashrobinLayer, i : Int, v : Double) -> DshashrobinLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_layer_sum(s : DshashrobinLayer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_robin_layer_mean(s : DshashrobinLayer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_robin_layer_scale(s : DshashrobinLayer, f : Double) -> DshashrobinLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_layer_add(a : DshashrobinLayer, b : DshashrobinLayer) -> DshashrobinLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_robin_layer_copy(s : DshashrobinLayer) -> DshashrobinLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_layer_fill(s : DshashrobinLayer, v : Double) -> DshashrobinLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_layer_min(s : DshashrobinLayer) -> Double { @_common.min(s.data) }

pub fn ds_hash_robin_layer_max(s : DshashrobinLayer) -> Double { @_common.max(s.data) }

pub fn ds_hash_robin_layer_to_string(s : DshashrobinLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_buffer_make(size : Int) -> DshashrobinBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_buffer_len(s : DshashrobinBuffer) -> Int { s.size }

pub fn ds_hash_robin_buffer_get(s : DshashrobinBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_buffer_set(s : DshashrobinBuffer, i : Int, v : Double) -> DshashrobinBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_buffer_sum(s : DshashrobinBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_robin_buffer_mean(s : DshashrobinBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_robin_buffer_scale(s : DshashrobinBuffer, f : Double) -> DshashrobinBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_buffer_add(a : DshashrobinBuffer, b : DshashrobinBuffer) -> DshashrobinBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_robin_buffer_copy(s : DshashrobinBuffer) -> DshashrobinBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_buffer_fill(s : DshashrobinBuffer, v : Double) -> DshashrobinBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_buffer_min(s : DshashrobinBuffer) -> Double { @_common.min(s.data) }

pub fn ds_hash_robin_buffer_max(s : DshashrobinBuffer) -> Double { @_common.max(s.data) }

pub fn ds_hash_robin_buffer_to_string(s : DshashrobinBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_cursor_make(size : Int) -> DshashrobinCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_cursor_len(s : DshashrobinCursor) -> Int { s.size }

pub fn ds_hash_robin_cursor_get(s : DshashrobinCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_cursor_set(s : DshashrobinCursor, i : Int, v : Double) -> DshashrobinCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_cursor_sum(s : DshashrobinCursor) -> Double { @_common.sum(s.data) }

pub fn ds_hash_robin_cursor_mean(s : DshashrobinCursor) -> Double { @_common.mean(s.data) }

pub fn ds_hash_robin_cursor_scale(s : DshashrobinCursor, f : Double) -> DshashrobinCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_cursor_add(a : DshashrobinCursor, b : DshashrobinCursor) -> DshashrobinCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_robin_cursor_copy(s : DshashrobinCursor) -> DshashrobinCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_cursor_fill(s : DshashrobinCursor, v : Double) -> DshashrobinCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_cursor_min(s : DshashrobinCursor) -> Double { @_common.min(s.data) }

pub fn ds_hash_robin_cursor_max(s : DshashrobinCursor) -> Double { @_common.max(s.data) }

pub fn ds_hash_robin_cursor_to_string(s : DshashrobinCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_view_make(size : Int) -> DshashrobinView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_view_len(s : DshashrobinView) -> Int { s.size }

pub fn ds_hash_robin_view_get(s : DshashrobinView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_view_set(s : DshashrobinView, i : Int, v : Double) -> DshashrobinView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_view_sum(s : DshashrobinView) -> Double { @_common.sum(s.data) }

pub fn ds_hash_robin_view_mean(s : DshashrobinView) -> Double { @_common.mean(s.data) }

pub fn ds_hash_robin_view_scale(s : DshashrobinView, f : Double) -> DshashrobinView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_view_add(a : DshashrobinView, b : DshashrobinView) -> DshashrobinView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_robin_view_copy(s : DshashrobinView) -> DshashrobinView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_view_fill(s : DshashrobinView, v : Double) -> DshashrobinView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_view_min(s : DshashrobinView) -> Double { @_common.min(s.data) }

pub fn ds_hash_robin_view_max(s : DshashrobinView) -> Double { @_common.max(s.data) }

pub fn ds_hash_robin_view_to_string(s : DshashrobinView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_range_make(size : Int) -> DshashrobinRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_range_len(s : DshashrobinRange) -> Int { s.size }

pub fn ds_hash_robin_range_get(s : DshashrobinRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_range_set(s : DshashrobinRange, i : Int, v : Double) -> DshashrobinRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_range_sum(s : DshashrobinRange) -> Double { @_common.sum(s.data) }

pub fn ds_hash_robin_range_mean(s : DshashrobinRange) -> Double { @_common.mean(s.data) }

pub fn ds_hash_robin_range_scale(s : DshashrobinRange, f : Double) -> DshashrobinRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_range_add(a : DshashrobinRange, b : DshashrobinRange) -> DshashrobinRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_robin_range_copy(s : DshashrobinRange) -> DshashrobinRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_range_fill(s : DshashrobinRange, v : Double) -> DshashrobinRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_range_min(s : DshashrobinRange) -> Double { @_common.min(s.data) }

pub fn ds_hash_robin_range_max(s : DshashrobinRange) -> Double { @_common.max(s.data) }

pub fn ds_hash_robin_range_to_string(s : DshashrobinRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashrobinSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_robin_slice_make(size : Int) -> DshashrobinSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_robin_slice_len(s : DshashrobinSlice) -> Int { s.size }

pub fn ds_hash_robin_slice_get(s : DshashrobinSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_robin_slice_set(s : DshashrobinSlice, i : Int, v : Double) -> DshashrobinSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_slice_sum(s : DshashrobinSlice) -> Double { @_common.sum(s.data) }

pub fn ds_hash_robin_slice_mean(s : DshashrobinSlice) -> Double { @_common.mean(s.data) }

pub fn ds_hash_robin_slice_scale(s : DshashrobinSlice, f : Double) -> DshashrobinSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_slice_add(a : DshashrobinSlice, b : DshashrobinSlice) -> DshashrobinSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_robin_slice_copy(s : DshashrobinSlice) -> DshashrobinSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_slice_fill(s : DshashrobinSlice, v : Double) -> DshashrobinSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_robin_slice_min(s : DshashrobinSlice) -> Double { @_common.min(s.data) }

pub fn ds_hash_robin_slice_max(s : DshashrobinSlice) -> Double { @_common.max(s.data) }

pub fn ds_hash_robin_slice_to_string(s : DshashrobinSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

