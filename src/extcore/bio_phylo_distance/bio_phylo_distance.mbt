///===
/// extcore/bio_phylo_distance

pub(all) struct BiophylodistancePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_distance_make_point(x : Double, y : Double) -> BiophylodistancePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_distance_make_point3(x : Double, y : Double, z : Double) -> BiophylodistancePoint {
  { x, y, z, label: 0 }
}

pub fn BiophylodistancePoint::x(self : BiophylodistancePoint) -> Double { self.x }

pub fn BiophylodistancePoint::y(self : BiophylodistancePoint) -> Double { self.y }

pub fn BiophylodistancePoint::z(self : BiophylodistancePoint) -> Double { self.z }

pub fn BiophylodistancePoint::label(self : BiophylodistancePoint) -> Int { self.label }

pub fn BiophylodistancePoint::dist(self : BiophylodistancePoint, other : BiophylodistancePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophylodistancePoint::add(self : BiophylodistancePoint, other : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophylodistancePoint::sub(self : BiophylodistancePoint, other : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophylodistancePoint::scale(self : BiophylodistancePoint, s : Double) -> BiophylodistancePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophylodistancePoint::dot(self : BiophylodistancePoint, other : BiophylodistancePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophylodistancePoint::cross(self : BiophylodistancePoint, other : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophylodistancePoint::norm(self : BiophylodistancePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophylodistancePoint::normalize(self : BiophylodistancePoint) -> BiophylodistancePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylodistancePoint::negate(self : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophylodistancePoint::mid(self : BiophylodistancePoint, other : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophylodistancePoint::lerp(self : BiophylodistancePoint, other : BiophylodistancePoint, t : Double) -> BiophylodistancePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophylodistancePoint::to_string(self : BiophylodistancePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophylodistanceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_distance_make_series(vals : Array[Double], name : String) -> BiophylodistanceSeries {
  { vals, name, meta: 0 }
}

pub fn BiophylodistanceSeries::len(self : BiophylodistanceSeries) -> Int { self.vals.length() }

pub fn BiophylodistanceSeries::sum(self : BiophylodistanceSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophylodistanceSeries::mean(self : BiophylodistanceSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophylodistanceSeries::min(self : BiophylodistanceSeries) -> Double { @_common.min(self.vals) }

pub fn BiophylodistanceSeries::max(self : BiophylodistanceSeries) -> Double { @_common.max(self.vals) }

pub fn BiophylodistanceSeries::range(self : BiophylodistanceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophylodistanceSeries::variance(self : BiophylodistanceSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophylodistanceSeries::std(self : BiophylodistanceSeries) -> Double { @_common.std(self.vals) }

pub fn BiophylodistanceSeries::median(self : BiophylodistanceSeries) -> Double { @_common.median(self.vals) }

pub fn BiophylodistanceSeries::scale(self : BiophylodistanceSeries, f : Double) -> BiophylodistanceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophylodistanceSeries::add(self : BiophylodistanceSeries, other : BiophylodistanceSeries) -> BiophylodistanceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophylodistanceSeries::sub(self : BiophylodistanceSeries, other : BiophylodistanceSeries) -> BiophylodistanceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophylodistanceSeries::normalize(self : BiophylodistanceSeries) -> BiophylodistanceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophylodistanceSeries::cumsum(self : BiophylodistanceSeries) -> BiophylodistanceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophylodistanceSeries::to_string(self : BiophylodistanceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylodistanceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_distance_make_matrix(rows : Int, cols : Int, val : Double) -> BiophylodistanceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_distance_matrix_identity(n : Int) -> BiophylodistanceMatrix {
  let m = bio_phylo_distance_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophylodistanceMatrix::get(self : BiophylodistanceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophylodistanceMatrix::transpose(self : BiophylodistanceMatrix) -> BiophylodistanceMatrix {
  let result = bio_phylo_distance_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophylodistanceMatrix::add(self : BiophylodistanceMatrix, other : BiophylodistanceMatrix) -> BiophylodistanceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_distance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophylodistanceMatrix::scale(self : BiophylodistanceMatrix, s : Double) -> BiophylodistanceMatrix {
  let result = bio_phylo_distance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophylodistanceMatrix::multiply(self : BiophylodistanceMatrix, other : BiophylodistanceMatrix) -> BiophylodistanceMatrix {
  if self.cols != other.rows { return bio_phylo_distance_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_distance_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiophylodistanceMatrix::trace(self : BiophylodistanceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophylodistanceMatrix::det(self : BiophylodistanceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophylodistanceMatrix::norm(self : BiophylodistanceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophylodistanceMatrix::to_string(self : BiophylodistanceMatrix) -> String {
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

pub(all) struct BiophylodistanceVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_distance_make_vector(comps : Array[Double]) -> BiophylodistanceVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_distance_vector_zero(dim : Int) -> BiophylodistanceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophylodistanceVector::add(self : BiophylodistanceVector, other : BiophylodistanceVector) -> BiophylodistanceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylodistanceVector::sub(self : BiophylodistanceVector, other : BiophylodistanceVector) -> BiophylodistanceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylodistanceVector::scale(self : BiophylodistanceVector, s : Double) -> BiophylodistanceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophylodistanceVector::dot(self : BiophylodistanceVector, other : BiophylodistanceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophylodistanceVector::norm(self : BiophylodistanceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophylodistanceVector::normalize(self : BiophylodistanceVector) -> BiophylodistanceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylodistanceVector::dist(self : BiophylodistanceVector, other : BiophylodistanceVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophylodistanceVector::to_string(self : BiophylodistanceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_distance_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_phylo_distance_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_phylo_distance_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_phylo_distance_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_phylo_distance_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_phylo_distance_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_phylo_distance_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_phylo_distance_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_phylo_distance_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_phylo_distance_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_phylo_distance_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_phylo_distance_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_phylo_distance_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_phylo_distance_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_phylo_distance_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_phylo_distance_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_phylo_distance_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_phylo_distance_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_phylo_distance_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_phylo_distance_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_phylo_distance_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_phylo_distance_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_phylo_distance_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_phylo_distance_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_phylo_distance_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_phylo_distance_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_phylo_distance_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_phylo_distance_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_phylo_distance_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiophylodistanceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_frame_make(size : Int) -> BiophylodistanceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_frame_len(s : BiophylodistanceFrame) -> Int { s.size }

pub fn bio_phylo_distance_frame_get(s : BiophylodistanceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_frame_set(s : BiophylodistanceFrame, i : Int, v : Double) -> BiophylodistanceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_frame_sum(s : BiophylodistanceFrame) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_distance_frame_mean(s : BiophylodistanceFrame) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_distance_frame_scale(s : BiophylodistanceFrame, f : Double) -> BiophylodistanceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_frame_add(a : BiophylodistanceFrame, b : BiophylodistanceFrame) -> BiophylodistanceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_distance_frame_copy(s : BiophylodistanceFrame) -> BiophylodistanceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_frame_fill(s : BiophylodistanceFrame, v : Double) -> BiophylodistanceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_frame_min(s : BiophylodistanceFrame) -> Double { @_common.min(s.data) }

pub fn bio_phylo_distance_frame_max(s : BiophylodistanceFrame) -> Double { @_common.max(s.data) }

pub fn bio_phylo_distance_frame_to_string(s : BiophylodistanceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_table_make(size : Int) -> BiophylodistanceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_table_len(s : BiophylodistanceTable) -> Int { s.size }

pub fn bio_phylo_distance_table_get(s : BiophylodistanceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_table_set(s : BiophylodistanceTable, i : Int, v : Double) -> BiophylodistanceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_table_sum(s : BiophylodistanceTable) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_distance_table_mean(s : BiophylodistanceTable) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_distance_table_scale(s : BiophylodistanceTable, f : Double) -> BiophylodistanceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_table_add(a : BiophylodistanceTable, b : BiophylodistanceTable) -> BiophylodistanceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_distance_table_copy(s : BiophylodistanceTable) -> BiophylodistanceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_table_fill(s : BiophylodistanceTable, v : Double) -> BiophylodistanceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_table_min(s : BiophylodistanceTable) -> Double { @_common.min(s.data) }

pub fn bio_phylo_distance_table_max(s : BiophylodistanceTable) -> Double { @_common.max(s.data) }

pub fn bio_phylo_distance_table_to_string(s : BiophylodistanceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_graphn_make(size : Int) -> BiophylodistanceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_graphn_len(s : BiophylodistanceGraphN) -> Int { s.size }

pub fn bio_phylo_distance_graphn_get(s : BiophylodistanceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_graphn_set(s : BiophylodistanceGraphN, i : Int, v : Double) -> BiophylodistanceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_graphn_sum(s : BiophylodistanceGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_distance_graphn_mean(s : BiophylodistanceGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_distance_graphn_scale(s : BiophylodistanceGraphN, f : Double) -> BiophylodistanceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_graphn_add(a : BiophylodistanceGraphN, b : BiophylodistanceGraphN) -> BiophylodistanceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_distance_graphn_copy(s : BiophylodistanceGraphN) -> BiophylodistanceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_graphn_fill(s : BiophylodistanceGraphN, v : Double) -> BiophylodistanceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_graphn_min(s : BiophylodistanceGraphN) -> Double { @_common.min(s.data) }

pub fn bio_phylo_distance_graphn_max(s : BiophylodistanceGraphN) -> Double { @_common.max(s.data) }

pub fn bio_phylo_distance_graphn_to_string(s : BiophylodistanceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_node_make(size : Int) -> BiophylodistanceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_node_len(s : BiophylodistanceNode) -> Int { s.size }

pub fn bio_phylo_distance_node_get(s : BiophylodistanceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_node_set(s : BiophylodistanceNode, i : Int, v : Double) -> BiophylodistanceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_node_sum(s : BiophylodistanceNode) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_distance_node_mean(s : BiophylodistanceNode) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_distance_node_scale(s : BiophylodistanceNode, f : Double) -> BiophylodistanceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_node_add(a : BiophylodistanceNode, b : BiophylodistanceNode) -> BiophylodistanceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_distance_node_copy(s : BiophylodistanceNode) -> BiophylodistanceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_node_fill(s : BiophylodistanceNode, v : Double) -> BiophylodistanceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_node_min(s : BiophylodistanceNode) -> Double { @_common.min(s.data) }

pub fn bio_phylo_distance_node_max(s : BiophylodistanceNode) -> Double { @_common.max(s.data) }

pub fn bio_phylo_distance_node_to_string(s : BiophylodistanceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_edge_make(size : Int) -> BiophylodistanceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_edge_len(s : BiophylodistanceEdge) -> Int { s.size }

pub fn bio_phylo_distance_edge_get(s : BiophylodistanceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_edge_set(s : BiophylodistanceEdge, i : Int, v : Double) -> BiophylodistanceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_edge_sum(s : BiophylodistanceEdge) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_distance_edge_mean(s : BiophylodistanceEdge) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_distance_edge_scale(s : BiophylodistanceEdge, f : Double) -> BiophylodistanceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_edge_add(a : BiophylodistanceEdge, b : BiophylodistanceEdge) -> BiophylodistanceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_distance_edge_copy(s : BiophylodistanceEdge) -> BiophylodistanceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_edge_fill(s : BiophylodistanceEdge, v : Double) -> BiophylodistanceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_edge_min(s : BiophylodistanceEdge) -> Double { @_common.min(s.data) }

pub fn bio_phylo_distance_edge_max(s : BiophylodistanceEdge) -> Double { @_common.max(s.data) }

pub fn bio_phylo_distance_edge_to_string(s : BiophylodistanceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistancePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_path_make(size : Int) -> BiophylodistancePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_path_len(s : BiophylodistancePath) -> Int { s.size }

pub fn bio_phylo_distance_path_get(s : BiophylodistancePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_path_set(s : BiophylodistancePath, i : Int, v : Double) -> BiophylodistancePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_path_sum(s : BiophylodistancePath) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_distance_path_mean(s : BiophylodistancePath) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_distance_path_scale(s : BiophylodistancePath, f : Double) -> BiophylodistancePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_path_add(a : BiophylodistancePath, b : BiophylodistancePath) -> BiophylodistancePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_distance_path_copy(s : BiophylodistancePath) -> BiophylodistancePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_path_fill(s : BiophylodistancePath, v : Double) -> BiophylodistancePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_path_min(s : BiophylodistancePath) -> Double { @_common.min(s.data) }

pub fn bio_phylo_distance_path_max(s : BiophylodistancePath) -> Double { @_common.max(s.data) }

pub fn bio_phylo_distance_path_to_string(s : BiophylodistancePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_cluster_make(size : Int) -> BiophylodistanceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_cluster_len(s : BiophylodistanceCluster) -> Int { s.size }

pub fn bio_phylo_distance_cluster_get(s : BiophylodistanceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_cluster_set(s : BiophylodistanceCluster, i : Int, v : Double) -> BiophylodistanceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_cluster_sum(s : BiophylodistanceCluster) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_distance_cluster_mean(s : BiophylodistanceCluster) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_distance_cluster_scale(s : BiophylodistanceCluster, f : Double) -> BiophylodistanceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_cluster_add(a : BiophylodistanceCluster, b : BiophylodistanceCluster) -> BiophylodistanceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_distance_cluster_copy(s : BiophylodistanceCluster) -> BiophylodistanceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_cluster_fill(s : BiophylodistanceCluster, v : Double) -> BiophylodistanceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_cluster_min(s : BiophylodistanceCluster) -> Double { @_common.min(s.data) }

pub fn bio_phylo_distance_cluster_max(s : BiophylodistanceCluster) -> Double { @_common.max(s.data) }

pub fn bio_phylo_distance_cluster_to_string(s : BiophylodistanceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_model_make(size : Int) -> BiophylodistanceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_model_len(s : BiophylodistanceModel) -> Int { s.size }

pub fn bio_phylo_distance_model_get(s : BiophylodistanceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_model_set(s : BiophylodistanceModel, i : Int, v : Double) -> BiophylodistanceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_model_sum(s : BiophylodistanceModel) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_distance_model_mean(s : BiophylodistanceModel) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_distance_model_scale(s : BiophylodistanceModel, f : Double) -> BiophylodistanceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_model_add(a : BiophylodistanceModel, b : BiophylodistanceModel) -> BiophylodistanceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_distance_model_copy(s : BiophylodistanceModel) -> BiophylodistanceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_model_fill(s : BiophylodistanceModel, v : Double) -> BiophylodistanceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_model_min(s : BiophylodistanceModel) -> Double { @_common.min(s.data) }

pub fn bio_phylo_distance_model_max(s : BiophylodistanceModel) -> Double { @_common.max(s.data) }

pub fn bio_phylo_distance_model_to_string(s : BiophylodistanceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_layer_make(size : Int) -> BiophylodistanceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_layer_len(s : BiophylodistanceLayer) -> Int { s.size }

pub fn bio_phylo_distance_layer_get(s : BiophylodistanceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_layer_set(s : BiophylodistanceLayer, i : Int, v : Double) -> BiophylodistanceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_layer_sum(s : BiophylodistanceLayer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_distance_layer_mean(s : BiophylodistanceLayer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_distance_layer_scale(s : BiophylodistanceLayer, f : Double) -> BiophylodistanceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_layer_add(a : BiophylodistanceLayer, b : BiophylodistanceLayer) -> BiophylodistanceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_distance_layer_copy(s : BiophylodistanceLayer) -> BiophylodistanceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_layer_fill(s : BiophylodistanceLayer, v : Double) -> BiophylodistanceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_layer_min(s : BiophylodistanceLayer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_distance_layer_max(s : BiophylodistanceLayer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_distance_layer_to_string(s : BiophylodistanceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_buffer_make(size : Int) -> BiophylodistanceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_buffer_len(s : BiophylodistanceBuffer) -> Int { s.size }

pub fn bio_phylo_distance_buffer_get(s : BiophylodistanceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_buffer_set(s : BiophylodistanceBuffer, i : Int, v : Double) -> BiophylodistanceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_buffer_sum(s : BiophylodistanceBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_distance_buffer_mean(s : BiophylodistanceBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_distance_buffer_scale(s : BiophylodistanceBuffer, f : Double) -> BiophylodistanceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_buffer_add(a : BiophylodistanceBuffer, b : BiophylodistanceBuffer) -> BiophylodistanceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_distance_buffer_copy(s : BiophylodistanceBuffer) -> BiophylodistanceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_buffer_fill(s : BiophylodistanceBuffer, v : Double) -> BiophylodistanceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_buffer_min(s : BiophylodistanceBuffer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_distance_buffer_max(s : BiophylodistanceBuffer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_distance_buffer_to_string(s : BiophylodistanceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_cursor_make(size : Int) -> BiophylodistanceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_cursor_len(s : BiophylodistanceCursor) -> Int { s.size }

pub fn bio_phylo_distance_cursor_get(s : BiophylodistanceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_cursor_set(s : BiophylodistanceCursor, i : Int, v : Double) -> BiophylodistanceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_cursor_sum(s : BiophylodistanceCursor) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_distance_cursor_mean(s : BiophylodistanceCursor) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_distance_cursor_scale(s : BiophylodistanceCursor, f : Double) -> BiophylodistanceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_cursor_add(a : BiophylodistanceCursor, b : BiophylodistanceCursor) -> BiophylodistanceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_distance_cursor_copy(s : BiophylodistanceCursor) -> BiophylodistanceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_cursor_fill(s : BiophylodistanceCursor, v : Double) -> BiophylodistanceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_cursor_min(s : BiophylodistanceCursor) -> Double { @_common.min(s.data) }

pub fn bio_phylo_distance_cursor_max(s : BiophylodistanceCursor) -> Double { @_common.max(s.data) }

pub fn bio_phylo_distance_cursor_to_string(s : BiophylodistanceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_view_make(size : Int) -> BiophylodistanceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_view_len(s : BiophylodistanceView) -> Int { s.size }

pub fn bio_phylo_distance_view_get(s : BiophylodistanceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_view_set(s : BiophylodistanceView, i : Int, v : Double) -> BiophylodistanceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_view_sum(s : BiophylodistanceView) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_distance_view_mean(s : BiophylodistanceView) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_distance_view_scale(s : BiophylodistanceView, f : Double) -> BiophylodistanceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_view_add(a : BiophylodistanceView, b : BiophylodistanceView) -> BiophylodistanceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_distance_view_copy(s : BiophylodistanceView) -> BiophylodistanceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_view_fill(s : BiophylodistanceView, v : Double) -> BiophylodistanceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_view_min(s : BiophylodistanceView) -> Double { @_common.min(s.data) }

pub fn bio_phylo_distance_view_max(s : BiophylodistanceView) -> Double { @_common.max(s.data) }

pub fn bio_phylo_distance_view_to_string(s : BiophylodistanceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_range_make(size : Int) -> BiophylodistanceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_range_len(s : BiophylodistanceRange) -> Int { s.size }

pub fn bio_phylo_distance_range_get(s : BiophylodistanceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_range_set(s : BiophylodistanceRange, i : Int, v : Double) -> BiophylodistanceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_range_sum(s : BiophylodistanceRange) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_distance_range_mean(s : BiophylodistanceRange) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_distance_range_scale(s : BiophylodistanceRange, f : Double) -> BiophylodistanceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_range_add(a : BiophylodistanceRange, b : BiophylodistanceRange) -> BiophylodistanceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_distance_range_copy(s : BiophylodistanceRange) -> BiophylodistanceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_range_fill(s : BiophylodistanceRange, v : Double) -> BiophylodistanceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_range_min(s : BiophylodistanceRange) -> Double { @_common.min(s.data) }

pub fn bio_phylo_distance_range_max(s : BiophylodistanceRange) -> Double { @_common.max(s.data) }

pub fn bio_phylo_distance_range_to_string(s : BiophylodistanceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_slice_make(size : Int) -> BiophylodistanceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_slice_len(s : BiophylodistanceSlice) -> Int { s.size }

pub fn bio_phylo_distance_slice_get(s : BiophylodistanceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_slice_set(s : BiophylodistanceSlice, i : Int, v : Double) -> BiophylodistanceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_slice_sum(s : BiophylodistanceSlice) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_distance_slice_mean(s : BiophylodistanceSlice) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_distance_slice_scale(s : BiophylodistanceSlice, f : Double) -> BiophylodistanceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_slice_add(a : BiophylodistanceSlice, b : BiophylodistanceSlice) -> BiophylodistanceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_distance_slice_copy(s : BiophylodistanceSlice) -> BiophylodistanceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_slice_fill(s : BiophylodistanceSlice, v : Double) -> BiophylodistanceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_distance_slice_min(s : BiophylodistanceSlice) -> Double { @_common.min(s.data) }

pub fn bio_phylo_distance_slice_max(s : BiophylodistanceSlice) -> Double { @_common.max(s.data) }

pub fn bio_phylo_distance_slice_to_string(s : BiophylodistanceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

