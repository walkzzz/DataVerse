///===
/// extcore/ds_hash_perfect

pub(all) struct DshashperfectPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_perfect_make_point(x : Double, y : Double) -> DshashperfectPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_perfect_make_point3(x : Double, y : Double, z : Double) -> DshashperfectPoint {
  { x, y, z, label: 0 }
}

pub fn DshashperfectPoint::x(self : DshashperfectPoint) -> Double { self.x }

pub fn DshashperfectPoint::y(self : DshashperfectPoint) -> Double { self.y }

pub fn DshashperfectPoint::z(self : DshashperfectPoint) -> Double { self.z }

pub fn DshashperfectPoint::label(self : DshashperfectPoint) -> Int { self.label }

pub fn DshashperfectPoint::dist(self : DshashperfectPoint, other : DshashperfectPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashperfectPoint::add(self : DshashperfectPoint, other : DshashperfectPoint) -> DshashperfectPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashperfectPoint::sub(self : DshashperfectPoint, other : DshashperfectPoint) -> DshashperfectPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashperfectPoint::scale(self : DshashperfectPoint, s : Double) -> DshashperfectPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashperfectPoint::dot(self : DshashperfectPoint, other : DshashperfectPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashperfectPoint::cross(self : DshashperfectPoint, other : DshashperfectPoint) -> DshashperfectPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashperfectPoint::norm(self : DshashperfectPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashperfectPoint::normalize(self : DshashperfectPoint) -> DshashperfectPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashperfectPoint::negate(self : DshashperfectPoint) -> DshashperfectPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashperfectPoint::mid(self : DshashperfectPoint, other : DshashperfectPoint) -> DshashperfectPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashperfectPoint::lerp(self : DshashperfectPoint, other : DshashperfectPoint, t : Double) -> DshashperfectPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashperfectPoint::to_string(self : DshashperfectPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashperfectSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_perfect_make_series(vals : Array[Double], name : String) -> DshashperfectSeries {
  { vals, name, meta: 0 }
}

pub fn DshashperfectSeries::len(self : DshashperfectSeries) -> Int { self.vals.length() }

pub fn DshashperfectSeries::sum(self : DshashperfectSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashperfectSeries::mean(self : DshashperfectSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashperfectSeries::min(self : DshashperfectSeries) -> Double { @_common.min(self.vals) }

pub fn DshashperfectSeries::max(self : DshashperfectSeries) -> Double { @_common.max(self.vals) }

pub fn DshashperfectSeries::range(self : DshashperfectSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashperfectSeries::variance(self : DshashperfectSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashperfectSeries::std(self : DshashperfectSeries) -> Double { @_common.std(self.vals) }

pub fn DshashperfectSeries::median(self : DshashperfectSeries) -> Double { @_common.median(self.vals) }

pub fn DshashperfectSeries::scale(self : DshashperfectSeries, f : Double) -> DshashperfectSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashperfectSeries::add(self : DshashperfectSeries, other : DshashperfectSeries) -> DshashperfectSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashperfectSeries::sub(self : DshashperfectSeries, other : DshashperfectSeries) -> DshashperfectSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashperfectSeries::normalize(self : DshashperfectSeries) -> DshashperfectSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashperfectSeries::cumsum(self : DshashperfectSeries) -> DshashperfectSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashperfectSeries::to_string(self : DshashperfectSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashperfectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_perfect_make_matrix(rows : Int, cols : Int, val : Double) -> DshashperfectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_perfect_matrix_identity(n : Int) -> DshashperfectMatrix {
  let m = ds_hash_perfect_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashperfectMatrix::get(self : DshashperfectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashperfectMatrix::transpose(self : DshashperfectMatrix) -> DshashperfectMatrix {
  let result = ds_hash_perfect_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashperfectMatrix::add(self : DshashperfectMatrix, other : DshashperfectMatrix) -> DshashperfectMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_perfect_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashperfectMatrix::scale(self : DshashperfectMatrix, s : Double) -> DshashperfectMatrix {
  let result = ds_hash_perfect_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashperfectMatrix::multiply(self : DshashperfectMatrix, other : DshashperfectMatrix) -> DshashperfectMatrix {
  if self.cols != other.rows { return ds_hash_perfect_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_perfect_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DshashperfectMatrix::trace(self : DshashperfectMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashperfectMatrix::det(self : DshashperfectMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashperfectMatrix::norm(self : DshashperfectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashperfectMatrix::to_string(self : DshashperfectMatrix) -> String {
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

pub(all) struct DshashperfectVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_perfect_make_vector(comps : Array[Double]) -> DshashperfectVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_perfect_vector_zero(dim : Int) -> DshashperfectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashperfectVector::add(self : DshashperfectVector, other : DshashperfectVector) -> DshashperfectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashperfectVector::sub(self : DshashperfectVector, other : DshashperfectVector) -> DshashperfectVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashperfectVector::scale(self : DshashperfectVector, s : Double) -> DshashperfectVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashperfectVector::dot(self : DshashperfectVector, other : DshashperfectVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashperfectVector::norm(self : DshashperfectVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashperfectVector::normalize(self : DshashperfectVector) -> DshashperfectVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashperfectVector::dist(self : DshashperfectVector, other : DshashperfectVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashperfectVector::to_string(self : DshashperfectVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_perfect_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_perfect_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_perfect_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_perfect_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_perfect_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_perfect_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_perfect_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_perfect_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_perfect_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_perfect_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_perfect_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_perfect_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_perfect_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_perfect_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_perfect_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_perfect_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_perfect_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_perfect_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_perfect_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_perfect_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_perfect_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_perfect_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_perfect_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_perfect_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_perfect_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_perfect_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_perfect_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_perfect_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_perfect_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashperfectFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_frame_make(size : Int) -> DshashperfectFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_frame_len(s : DshashperfectFrame) -> Int { s.size }

pub fn ds_hash_perfect_frame_get(s : DshashperfectFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_frame_set(s : DshashperfectFrame, i : Int, v : Double) -> DshashperfectFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_frame_sum(s : DshashperfectFrame) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_frame_mean(s : DshashperfectFrame) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_frame_scale(s : DshashperfectFrame, f : Double) -> DshashperfectFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_frame_add(a : DshashperfectFrame, b : DshashperfectFrame) -> DshashperfectFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_frame_copy(s : DshashperfectFrame) -> DshashperfectFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_frame_fill(s : DshashperfectFrame, v : Double) -> DshashperfectFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_frame_min(s : DshashperfectFrame) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_frame_max(s : DshashperfectFrame) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_frame_to_string(s : DshashperfectFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_table_make(size : Int) -> DshashperfectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_table_len(s : DshashperfectTable) -> Int { s.size }

pub fn ds_hash_perfect_table_get(s : DshashperfectTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_table_set(s : DshashperfectTable, i : Int, v : Double) -> DshashperfectTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_table_sum(s : DshashperfectTable) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_table_mean(s : DshashperfectTable) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_table_scale(s : DshashperfectTable, f : Double) -> DshashperfectTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_table_add(a : DshashperfectTable, b : DshashperfectTable) -> DshashperfectTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_table_copy(s : DshashperfectTable) -> DshashperfectTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_table_fill(s : DshashperfectTable, v : Double) -> DshashperfectTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_table_min(s : DshashperfectTable) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_table_max(s : DshashperfectTable) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_table_to_string(s : DshashperfectTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_graphn_make(size : Int) -> DshashperfectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_graphn_len(s : DshashperfectGraphN) -> Int { s.size }

pub fn ds_hash_perfect_graphn_get(s : DshashperfectGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_graphn_set(s : DshashperfectGraphN, i : Int, v : Double) -> DshashperfectGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_graphn_sum(s : DshashperfectGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_graphn_mean(s : DshashperfectGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_graphn_scale(s : DshashperfectGraphN, f : Double) -> DshashperfectGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_graphn_add(a : DshashperfectGraphN, b : DshashperfectGraphN) -> DshashperfectGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_graphn_copy(s : DshashperfectGraphN) -> DshashperfectGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_graphn_fill(s : DshashperfectGraphN, v : Double) -> DshashperfectGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_graphn_min(s : DshashperfectGraphN) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_graphn_max(s : DshashperfectGraphN) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_graphn_to_string(s : DshashperfectGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_node_make(size : Int) -> DshashperfectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_node_len(s : DshashperfectNode) -> Int { s.size }

pub fn ds_hash_perfect_node_get(s : DshashperfectNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_node_set(s : DshashperfectNode, i : Int, v : Double) -> DshashperfectNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_node_sum(s : DshashperfectNode) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_node_mean(s : DshashperfectNode) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_node_scale(s : DshashperfectNode, f : Double) -> DshashperfectNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_node_add(a : DshashperfectNode, b : DshashperfectNode) -> DshashperfectNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_node_copy(s : DshashperfectNode) -> DshashperfectNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_node_fill(s : DshashperfectNode, v : Double) -> DshashperfectNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_node_min(s : DshashperfectNode) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_node_max(s : DshashperfectNode) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_node_to_string(s : DshashperfectNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_edge_make(size : Int) -> DshashperfectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_edge_len(s : DshashperfectEdge) -> Int { s.size }

pub fn ds_hash_perfect_edge_get(s : DshashperfectEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_edge_set(s : DshashperfectEdge, i : Int, v : Double) -> DshashperfectEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_edge_sum(s : DshashperfectEdge) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_edge_mean(s : DshashperfectEdge) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_edge_scale(s : DshashperfectEdge, f : Double) -> DshashperfectEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_edge_add(a : DshashperfectEdge, b : DshashperfectEdge) -> DshashperfectEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_edge_copy(s : DshashperfectEdge) -> DshashperfectEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_edge_fill(s : DshashperfectEdge, v : Double) -> DshashperfectEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_edge_min(s : DshashperfectEdge) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_edge_max(s : DshashperfectEdge) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_edge_to_string(s : DshashperfectEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_path_make(size : Int) -> DshashperfectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_path_len(s : DshashperfectPath) -> Int { s.size }

pub fn ds_hash_perfect_path_get(s : DshashperfectPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_path_set(s : DshashperfectPath, i : Int, v : Double) -> DshashperfectPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_path_sum(s : DshashperfectPath) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_path_mean(s : DshashperfectPath) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_path_scale(s : DshashperfectPath, f : Double) -> DshashperfectPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_path_add(a : DshashperfectPath, b : DshashperfectPath) -> DshashperfectPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_path_copy(s : DshashperfectPath) -> DshashperfectPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_path_fill(s : DshashperfectPath, v : Double) -> DshashperfectPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_path_min(s : DshashperfectPath) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_path_max(s : DshashperfectPath) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_path_to_string(s : DshashperfectPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_cluster_make(size : Int) -> DshashperfectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_cluster_len(s : DshashperfectCluster) -> Int { s.size }

pub fn ds_hash_perfect_cluster_get(s : DshashperfectCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_cluster_set(s : DshashperfectCluster, i : Int, v : Double) -> DshashperfectCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_cluster_sum(s : DshashperfectCluster) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_cluster_mean(s : DshashperfectCluster) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_cluster_scale(s : DshashperfectCluster, f : Double) -> DshashperfectCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_cluster_add(a : DshashperfectCluster, b : DshashperfectCluster) -> DshashperfectCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_cluster_copy(s : DshashperfectCluster) -> DshashperfectCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_cluster_fill(s : DshashperfectCluster, v : Double) -> DshashperfectCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_cluster_min(s : DshashperfectCluster) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_cluster_max(s : DshashperfectCluster) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_cluster_to_string(s : DshashperfectCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_model_make(size : Int) -> DshashperfectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_model_len(s : DshashperfectModel) -> Int { s.size }

pub fn ds_hash_perfect_model_get(s : DshashperfectModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_model_set(s : DshashperfectModel, i : Int, v : Double) -> DshashperfectModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_model_sum(s : DshashperfectModel) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_model_mean(s : DshashperfectModel) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_model_scale(s : DshashperfectModel, f : Double) -> DshashperfectModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_model_add(a : DshashperfectModel, b : DshashperfectModel) -> DshashperfectModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_model_copy(s : DshashperfectModel) -> DshashperfectModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_model_fill(s : DshashperfectModel, v : Double) -> DshashperfectModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_model_min(s : DshashperfectModel) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_model_max(s : DshashperfectModel) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_model_to_string(s : DshashperfectModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_layer_make(size : Int) -> DshashperfectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_layer_len(s : DshashperfectLayer) -> Int { s.size }

pub fn ds_hash_perfect_layer_get(s : DshashperfectLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_layer_set(s : DshashperfectLayer, i : Int, v : Double) -> DshashperfectLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_layer_sum(s : DshashperfectLayer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_layer_mean(s : DshashperfectLayer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_layer_scale(s : DshashperfectLayer, f : Double) -> DshashperfectLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_layer_add(a : DshashperfectLayer, b : DshashperfectLayer) -> DshashperfectLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_layer_copy(s : DshashperfectLayer) -> DshashperfectLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_layer_fill(s : DshashperfectLayer, v : Double) -> DshashperfectLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_layer_min(s : DshashperfectLayer) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_layer_max(s : DshashperfectLayer) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_layer_to_string(s : DshashperfectLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_buffer_make(size : Int) -> DshashperfectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_buffer_len(s : DshashperfectBuffer) -> Int { s.size }

pub fn ds_hash_perfect_buffer_get(s : DshashperfectBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_buffer_set(s : DshashperfectBuffer, i : Int, v : Double) -> DshashperfectBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_buffer_sum(s : DshashperfectBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_buffer_mean(s : DshashperfectBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_buffer_scale(s : DshashperfectBuffer, f : Double) -> DshashperfectBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_buffer_add(a : DshashperfectBuffer, b : DshashperfectBuffer) -> DshashperfectBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_buffer_copy(s : DshashperfectBuffer) -> DshashperfectBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_buffer_fill(s : DshashperfectBuffer, v : Double) -> DshashperfectBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_buffer_min(s : DshashperfectBuffer) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_buffer_max(s : DshashperfectBuffer) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_buffer_to_string(s : DshashperfectBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_cursor_make(size : Int) -> DshashperfectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_cursor_len(s : DshashperfectCursor) -> Int { s.size }

pub fn ds_hash_perfect_cursor_get(s : DshashperfectCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_cursor_set(s : DshashperfectCursor, i : Int, v : Double) -> DshashperfectCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_cursor_sum(s : DshashperfectCursor) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_cursor_mean(s : DshashperfectCursor) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_cursor_scale(s : DshashperfectCursor, f : Double) -> DshashperfectCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_cursor_add(a : DshashperfectCursor, b : DshashperfectCursor) -> DshashperfectCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_cursor_copy(s : DshashperfectCursor) -> DshashperfectCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_cursor_fill(s : DshashperfectCursor, v : Double) -> DshashperfectCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_cursor_min(s : DshashperfectCursor) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_cursor_max(s : DshashperfectCursor) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_cursor_to_string(s : DshashperfectCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_view_make(size : Int) -> DshashperfectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_view_len(s : DshashperfectView) -> Int { s.size }

pub fn ds_hash_perfect_view_get(s : DshashperfectView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_view_set(s : DshashperfectView, i : Int, v : Double) -> DshashperfectView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_view_sum(s : DshashperfectView) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_view_mean(s : DshashperfectView) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_view_scale(s : DshashperfectView, f : Double) -> DshashperfectView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_view_add(a : DshashperfectView, b : DshashperfectView) -> DshashperfectView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_view_copy(s : DshashperfectView) -> DshashperfectView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_view_fill(s : DshashperfectView, v : Double) -> DshashperfectView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_view_min(s : DshashperfectView) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_view_max(s : DshashperfectView) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_view_to_string(s : DshashperfectView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_range_make(size : Int) -> DshashperfectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_range_len(s : DshashperfectRange) -> Int { s.size }

pub fn ds_hash_perfect_range_get(s : DshashperfectRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_range_set(s : DshashperfectRange, i : Int, v : Double) -> DshashperfectRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_range_sum(s : DshashperfectRange) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_range_mean(s : DshashperfectRange) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_range_scale(s : DshashperfectRange, f : Double) -> DshashperfectRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_range_add(a : DshashperfectRange, b : DshashperfectRange) -> DshashperfectRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_range_copy(s : DshashperfectRange) -> DshashperfectRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_range_fill(s : DshashperfectRange, v : Double) -> DshashperfectRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_range_min(s : DshashperfectRange) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_range_max(s : DshashperfectRange) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_range_to_string(s : DshashperfectRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashperfectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_perfect_slice_make(size : Int) -> DshashperfectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_perfect_slice_len(s : DshashperfectSlice) -> Int { s.size }

pub fn ds_hash_perfect_slice_get(s : DshashperfectSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_perfect_slice_set(s : DshashperfectSlice, i : Int, v : Double) -> DshashperfectSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_slice_sum(s : DshashperfectSlice) -> Double { @_common.sum(s.data) }

pub fn ds_hash_perfect_slice_mean(s : DshashperfectSlice) -> Double { @_common.mean(s.data) }

pub fn ds_hash_perfect_slice_scale(s : DshashperfectSlice, f : Double) -> DshashperfectSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_slice_add(a : DshashperfectSlice, b : DshashperfectSlice) -> DshashperfectSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_hash_perfect_slice_copy(s : DshashperfectSlice) -> DshashperfectSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_slice_fill(s : DshashperfectSlice, v : Double) -> DshashperfectSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_hash_perfect_slice_min(s : DshashperfectSlice) -> Double { @_common.min(s.data) }

pub fn ds_hash_perfect_slice_max(s : DshashperfectSlice) -> Double { @_common.max(s.data) }

pub fn ds_hash_perfect_slice_to_string(s : DshashperfectSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

