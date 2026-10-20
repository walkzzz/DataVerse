///===
/// extcore/bio_phylo_neighbor

pub(all) struct BiophyloneighborPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_neighbor_make_point(x : Double, y : Double) -> BiophyloneighborPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_neighbor_make_point3(x : Double, y : Double, z : Double) -> BiophyloneighborPoint {
  { x, y, z, label: 0 }
}

pub fn BiophyloneighborPoint::x(self : BiophyloneighborPoint) -> Double { self.x }

pub fn BiophyloneighborPoint::y(self : BiophyloneighborPoint) -> Double { self.y }

pub fn BiophyloneighborPoint::z(self : BiophyloneighborPoint) -> Double { self.z }

pub fn BiophyloneighborPoint::label(self : BiophyloneighborPoint) -> Int { self.label }

pub fn BiophyloneighborPoint::dist(self : BiophyloneighborPoint, other : BiophyloneighborPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophyloneighborPoint::add(self : BiophyloneighborPoint, other : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophyloneighborPoint::sub(self : BiophyloneighborPoint, other : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophyloneighborPoint::scale(self : BiophyloneighborPoint, s : Double) -> BiophyloneighborPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophyloneighborPoint::dot(self : BiophyloneighborPoint, other : BiophyloneighborPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophyloneighborPoint::cross(self : BiophyloneighborPoint, other : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophyloneighborPoint::norm(self : BiophyloneighborPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophyloneighborPoint::normalize(self : BiophyloneighborPoint) -> BiophyloneighborPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloneighborPoint::negate(self : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophyloneighborPoint::mid(self : BiophyloneighborPoint, other : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophyloneighborPoint::lerp(self : BiophyloneighborPoint, other : BiophyloneighborPoint, t : Double) -> BiophyloneighborPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophyloneighborPoint::to_string(self : BiophyloneighborPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophyloneighborSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_neighbor_make_series(vals : Array[Double], name : String) -> BiophyloneighborSeries {
  { vals, name, meta: 0 }
}

pub fn BiophyloneighborSeries::len(self : BiophyloneighborSeries) -> Int { self.vals.length() }

pub fn BiophyloneighborSeries::sum(self : BiophyloneighborSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophyloneighborSeries::mean(self : BiophyloneighborSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophyloneighborSeries::min(self : BiophyloneighborSeries) -> Double { @_common.min(self.vals) }

pub fn BiophyloneighborSeries::max(self : BiophyloneighborSeries) -> Double { @_common.max(self.vals) }

pub fn BiophyloneighborSeries::range(self : BiophyloneighborSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophyloneighborSeries::variance(self : BiophyloneighborSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophyloneighborSeries::std(self : BiophyloneighborSeries) -> Double { @_common.std(self.vals) }

pub fn BiophyloneighborSeries::median(self : BiophyloneighborSeries) -> Double { @_common.median(self.vals) }

pub fn BiophyloneighborSeries::scale(self : BiophyloneighborSeries, f : Double) -> BiophyloneighborSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophyloneighborSeries::add(self : BiophyloneighborSeries, other : BiophyloneighborSeries) -> BiophyloneighborSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophyloneighborSeries::sub(self : BiophyloneighborSeries, other : BiophyloneighborSeries) -> BiophyloneighborSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophyloneighborSeries::normalize(self : BiophyloneighborSeries) -> BiophyloneighborSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophyloneighborSeries::cumsum(self : BiophyloneighborSeries) -> BiophyloneighborSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophyloneighborSeries::to_string(self : BiophyloneighborSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloneighborMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_neighbor_make_matrix(rows : Int, cols : Int, val : Double) -> BiophyloneighborMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_neighbor_matrix_identity(n : Int) -> BiophyloneighborMatrix {
  let m = bio_phylo_neighbor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophyloneighborMatrix::get(self : BiophyloneighborMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophyloneighborMatrix::transpose(self : BiophyloneighborMatrix) -> BiophyloneighborMatrix {
  let result = bio_phylo_neighbor_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophyloneighborMatrix::add(self : BiophyloneighborMatrix, other : BiophyloneighborMatrix) -> BiophyloneighborMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_neighbor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophyloneighborMatrix::scale(self : BiophyloneighborMatrix, s : Double) -> BiophyloneighborMatrix {
  let result = bio_phylo_neighbor_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophyloneighborMatrix::multiply(self : BiophyloneighborMatrix, other : BiophyloneighborMatrix) -> BiophyloneighborMatrix {
  if self.cols != other.rows { return bio_phylo_neighbor_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_neighbor_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiophyloneighborMatrix::trace(self : BiophyloneighborMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophyloneighborMatrix::det(self : BiophyloneighborMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophyloneighborMatrix::norm(self : BiophyloneighborMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophyloneighborMatrix::to_string(self : BiophyloneighborMatrix) -> String {
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

pub(all) struct BiophyloneighborVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_neighbor_make_vector(comps : Array[Double]) -> BiophyloneighborVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_neighbor_vector_zero(dim : Int) -> BiophyloneighborVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophyloneighborVector::add(self : BiophyloneighborVector, other : BiophyloneighborVector) -> BiophyloneighborVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloneighborVector::sub(self : BiophyloneighborVector, other : BiophyloneighborVector) -> BiophyloneighborVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloneighborVector::scale(self : BiophyloneighborVector, s : Double) -> BiophyloneighborVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophyloneighborVector::dot(self : BiophyloneighborVector, other : BiophyloneighborVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophyloneighborVector::norm(self : BiophyloneighborVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophyloneighborVector::normalize(self : BiophyloneighborVector) -> BiophyloneighborVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloneighborVector::dist(self : BiophyloneighborVector, other : BiophyloneighborVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophyloneighborVector::to_string(self : BiophyloneighborVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_neighbor_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_phylo_neighbor_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_phylo_neighbor_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_phylo_neighbor_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_phylo_neighbor_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_phylo_neighbor_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_phylo_neighbor_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_phylo_neighbor_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_phylo_neighbor_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_phylo_neighbor_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_phylo_neighbor_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_phylo_neighbor_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_phylo_neighbor_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_phylo_neighbor_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_phylo_neighbor_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_phylo_neighbor_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_phylo_neighbor_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_phylo_neighbor_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_phylo_neighbor_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_phylo_neighbor_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_phylo_neighbor_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_phylo_neighbor_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_phylo_neighbor_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_phylo_neighbor_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_phylo_neighbor_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_phylo_neighbor_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_phylo_neighbor_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_phylo_neighbor_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_phylo_neighbor_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiophyloneighborFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_frame_make(size : Int) -> BiophyloneighborFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_frame_len(s : BiophyloneighborFrame) -> Int { s.size }

pub fn bio_phylo_neighbor_frame_get(s : BiophyloneighborFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_frame_set(s : BiophyloneighborFrame, i : Int, v : Double) -> BiophyloneighborFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_frame_sum(s : BiophyloneighborFrame) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_neighbor_frame_mean(s : BiophyloneighborFrame) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_neighbor_frame_scale(s : BiophyloneighborFrame, f : Double) -> BiophyloneighborFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_frame_add(a : BiophyloneighborFrame, b : BiophyloneighborFrame) -> BiophyloneighborFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_neighbor_frame_copy(s : BiophyloneighborFrame) -> BiophyloneighborFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_frame_fill(s : BiophyloneighborFrame, v : Double) -> BiophyloneighborFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_frame_min(s : BiophyloneighborFrame) -> Double { @_common.min(s.data) }

pub fn bio_phylo_neighbor_frame_max(s : BiophyloneighborFrame) -> Double { @_common.max(s.data) }

pub fn bio_phylo_neighbor_frame_to_string(s : BiophyloneighborFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_table_make(size : Int) -> BiophyloneighborTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_table_len(s : BiophyloneighborTable) -> Int { s.size }

pub fn bio_phylo_neighbor_table_get(s : BiophyloneighborTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_table_set(s : BiophyloneighborTable, i : Int, v : Double) -> BiophyloneighborTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_table_sum(s : BiophyloneighborTable) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_neighbor_table_mean(s : BiophyloneighborTable) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_neighbor_table_scale(s : BiophyloneighborTable, f : Double) -> BiophyloneighborTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_table_add(a : BiophyloneighborTable, b : BiophyloneighborTable) -> BiophyloneighborTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_neighbor_table_copy(s : BiophyloneighborTable) -> BiophyloneighborTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_table_fill(s : BiophyloneighborTable, v : Double) -> BiophyloneighborTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_table_min(s : BiophyloneighborTable) -> Double { @_common.min(s.data) }

pub fn bio_phylo_neighbor_table_max(s : BiophyloneighborTable) -> Double { @_common.max(s.data) }

pub fn bio_phylo_neighbor_table_to_string(s : BiophyloneighborTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_graphn_make(size : Int) -> BiophyloneighborGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_graphn_len(s : BiophyloneighborGraphN) -> Int { s.size }

pub fn bio_phylo_neighbor_graphn_get(s : BiophyloneighborGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_graphn_set(s : BiophyloneighborGraphN, i : Int, v : Double) -> BiophyloneighborGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_graphn_sum(s : BiophyloneighborGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_neighbor_graphn_mean(s : BiophyloneighborGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_neighbor_graphn_scale(s : BiophyloneighborGraphN, f : Double) -> BiophyloneighborGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_graphn_add(a : BiophyloneighborGraphN, b : BiophyloneighborGraphN) -> BiophyloneighborGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_neighbor_graphn_copy(s : BiophyloneighborGraphN) -> BiophyloneighborGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_graphn_fill(s : BiophyloneighborGraphN, v : Double) -> BiophyloneighborGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_graphn_min(s : BiophyloneighborGraphN) -> Double { @_common.min(s.data) }

pub fn bio_phylo_neighbor_graphn_max(s : BiophyloneighborGraphN) -> Double { @_common.max(s.data) }

pub fn bio_phylo_neighbor_graphn_to_string(s : BiophyloneighborGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_node_make(size : Int) -> BiophyloneighborNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_node_len(s : BiophyloneighborNode) -> Int { s.size }

pub fn bio_phylo_neighbor_node_get(s : BiophyloneighborNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_node_set(s : BiophyloneighborNode, i : Int, v : Double) -> BiophyloneighborNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_node_sum(s : BiophyloneighborNode) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_neighbor_node_mean(s : BiophyloneighborNode) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_neighbor_node_scale(s : BiophyloneighborNode, f : Double) -> BiophyloneighborNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_node_add(a : BiophyloneighborNode, b : BiophyloneighborNode) -> BiophyloneighborNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_neighbor_node_copy(s : BiophyloneighborNode) -> BiophyloneighborNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_node_fill(s : BiophyloneighborNode, v : Double) -> BiophyloneighborNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_node_min(s : BiophyloneighborNode) -> Double { @_common.min(s.data) }

pub fn bio_phylo_neighbor_node_max(s : BiophyloneighborNode) -> Double { @_common.max(s.data) }

pub fn bio_phylo_neighbor_node_to_string(s : BiophyloneighborNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_edge_make(size : Int) -> BiophyloneighborEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_edge_len(s : BiophyloneighborEdge) -> Int { s.size }

pub fn bio_phylo_neighbor_edge_get(s : BiophyloneighborEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_edge_set(s : BiophyloneighborEdge, i : Int, v : Double) -> BiophyloneighborEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_edge_sum(s : BiophyloneighborEdge) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_neighbor_edge_mean(s : BiophyloneighborEdge) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_neighbor_edge_scale(s : BiophyloneighborEdge, f : Double) -> BiophyloneighborEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_edge_add(a : BiophyloneighborEdge, b : BiophyloneighborEdge) -> BiophyloneighborEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_neighbor_edge_copy(s : BiophyloneighborEdge) -> BiophyloneighborEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_edge_fill(s : BiophyloneighborEdge, v : Double) -> BiophyloneighborEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_edge_min(s : BiophyloneighborEdge) -> Double { @_common.min(s.data) }

pub fn bio_phylo_neighbor_edge_max(s : BiophyloneighborEdge) -> Double { @_common.max(s.data) }

pub fn bio_phylo_neighbor_edge_to_string(s : BiophyloneighborEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_path_make(size : Int) -> BiophyloneighborPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_path_len(s : BiophyloneighborPath) -> Int { s.size }

pub fn bio_phylo_neighbor_path_get(s : BiophyloneighborPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_path_set(s : BiophyloneighborPath, i : Int, v : Double) -> BiophyloneighborPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_path_sum(s : BiophyloneighborPath) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_neighbor_path_mean(s : BiophyloneighborPath) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_neighbor_path_scale(s : BiophyloneighborPath, f : Double) -> BiophyloneighborPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_path_add(a : BiophyloneighborPath, b : BiophyloneighborPath) -> BiophyloneighborPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_neighbor_path_copy(s : BiophyloneighborPath) -> BiophyloneighborPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_path_fill(s : BiophyloneighborPath, v : Double) -> BiophyloneighborPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_path_min(s : BiophyloneighborPath) -> Double { @_common.min(s.data) }

pub fn bio_phylo_neighbor_path_max(s : BiophyloneighborPath) -> Double { @_common.max(s.data) }

pub fn bio_phylo_neighbor_path_to_string(s : BiophyloneighborPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_cluster_make(size : Int) -> BiophyloneighborCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_cluster_len(s : BiophyloneighborCluster) -> Int { s.size }

pub fn bio_phylo_neighbor_cluster_get(s : BiophyloneighborCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_cluster_set(s : BiophyloneighborCluster, i : Int, v : Double) -> BiophyloneighborCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_cluster_sum(s : BiophyloneighborCluster) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_neighbor_cluster_mean(s : BiophyloneighborCluster) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_neighbor_cluster_scale(s : BiophyloneighborCluster, f : Double) -> BiophyloneighborCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_cluster_add(a : BiophyloneighborCluster, b : BiophyloneighborCluster) -> BiophyloneighborCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_neighbor_cluster_copy(s : BiophyloneighborCluster) -> BiophyloneighborCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_cluster_fill(s : BiophyloneighborCluster, v : Double) -> BiophyloneighborCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_cluster_min(s : BiophyloneighborCluster) -> Double { @_common.min(s.data) }

pub fn bio_phylo_neighbor_cluster_max(s : BiophyloneighborCluster) -> Double { @_common.max(s.data) }

pub fn bio_phylo_neighbor_cluster_to_string(s : BiophyloneighborCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_model_make(size : Int) -> BiophyloneighborModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_model_len(s : BiophyloneighborModel) -> Int { s.size }

pub fn bio_phylo_neighbor_model_get(s : BiophyloneighborModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_model_set(s : BiophyloneighborModel, i : Int, v : Double) -> BiophyloneighborModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_model_sum(s : BiophyloneighborModel) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_neighbor_model_mean(s : BiophyloneighborModel) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_neighbor_model_scale(s : BiophyloneighborModel, f : Double) -> BiophyloneighborModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_model_add(a : BiophyloneighborModel, b : BiophyloneighborModel) -> BiophyloneighborModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_neighbor_model_copy(s : BiophyloneighborModel) -> BiophyloneighborModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_model_fill(s : BiophyloneighborModel, v : Double) -> BiophyloneighborModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_model_min(s : BiophyloneighborModel) -> Double { @_common.min(s.data) }

pub fn bio_phylo_neighbor_model_max(s : BiophyloneighborModel) -> Double { @_common.max(s.data) }

pub fn bio_phylo_neighbor_model_to_string(s : BiophyloneighborModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_layer_make(size : Int) -> BiophyloneighborLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_layer_len(s : BiophyloneighborLayer) -> Int { s.size }

pub fn bio_phylo_neighbor_layer_get(s : BiophyloneighborLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_layer_set(s : BiophyloneighborLayer, i : Int, v : Double) -> BiophyloneighborLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_layer_sum(s : BiophyloneighborLayer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_neighbor_layer_mean(s : BiophyloneighborLayer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_neighbor_layer_scale(s : BiophyloneighborLayer, f : Double) -> BiophyloneighborLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_layer_add(a : BiophyloneighborLayer, b : BiophyloneighborLayer) -> BiophyloneighborLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_neighbor_layer_copy(s : BiophyloneighborLayer) -> BiophyloneighborLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_layer_fill(s : BiophyloneighborLayer, v : Double) -> BiophyloneighborLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_layer_min(s : BiophyloneighborLayer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_neighbor_layer_max(s : BiophyloneighborLayer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_neighbor_layer_to_string(s : BiophyloneighborLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_buffer_make(size : Int) -> BiophyloneighborBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_buffer_len(s : BiophyloneighborBuffer) -> Int { s.size }

pub fn bio_phylo_neighbor_buffer_get(s : BiophyloneighborBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_buffer_set(s : BiophyloneighborBuffer, i : Int, v : Double) -> BiophyloneighborBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_buffer_sum(s : BiophyloneighborBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_neighbor_buffer_mean(s : BiophyloneighborBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_neighbor_buffer_scale(s : BiophyloneighborBuffer, f : Double) -> BiophyloneighborBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_buffer_add(a : BiophyloneighborBuffer, b : BiophyloneighborBuffer) -> BiophyloneighborBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_neighbor_buffer_copy(s : BiophyloneighborBuffer) -> BiophyloneighborBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_buffer_fill(s : BiophyloneighborBuffer, v : Double) -> BiophyloneighborBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_buffer_min(s : BiophyloneighborBuffer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_neighbor_buffer_max(s : BiophyloneighborBuffer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_neighbor_buffer_to_string(s : BiophyloneighborBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_cursor_make(size : Int) -> BiophyloneighborCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_cursor_len(s : BiophyloneighborCursor) -> Int { s.size }

pub fn bio_phylo_neighbor_cursor_get(s : BiophyloneighborCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_cursor_set(s : BiophyloneighborCursor, i : Int, v : Double) -> BiophyloneighborCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_cursor_sum(s : BiophyloneighborCursor) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_neighbor_cursor_mean(s : BiophyloneighborCursor) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_neighbor_cursor_scale(s : BiophyloneighborCursor, f : Double) -> BiophyloneighborCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_cursor_add(a : BiophyloneighborCursor, b : BiophyloneighborCursor) -> BiophyloneighborCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_neighbor_cursor_copy(s : BiophyloneighborCursor) -> BiophyloneighborCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_cursor_fill(s : BiophyloneighborCursor, v : Double) -> BiophyloneighborCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_cursor_min(s : BiophyloneighborCursor) -> Double { @_common.min(s.data) }

pub fn bio_phylo_neighbor_cursor_max(s : BiophyloneighborCursor) -> Double { @_common.max(s.data) }

pub fn bio_phylo_neighbor_cursor_to_string(s : BiophyloneighborCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_view_make(size : Int) -> BiophyloneighborView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_view_len(s : BiophyloneighborView) -> Int { s.size }

pub fn bio_phylo_neighbor_view_get(s : BiophyloneighborView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_view_set(s : BiophyloneighborView, i : Int, v : Double) -> BiophyloneighborView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_view_sum(s : BiophyloneighborView) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_neighbor_view_mean(s : BiophyloneighborView) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_neighbor_view_scale(s : BiophyloneighborView, f : Double) -> BiophyloneighborView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_view_add(a : BiophyloneighborView, b : BiophyloneighborView) -> BiophyloneighborView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_neighbor_view_copy(s : BiophyloneighborView) -> BiophyloneighborView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_view_fill(s : BiophyloneighborView, v : Double) -> BiophyloneighborView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_view_min(s : BiophyloneighborView) -> Double { @_common.min(s.data) }

pub fn bio_phylo_neighbor_view_max(s : BiophyloneighborView) -> Double { @_common.max(s.data) }

pub fn bio_phylo_neighbor_view_to_string(s : BiophyloneighborView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_range_make(size : Int) -> BiophyloneighborRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_range_len(s : BiophyloneighborRange) -> Int { s.size }

pub fn bio_phylo_neighbor_range_get(s : BiophyloneighborRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_range_set(s : BiophyloneighborRange, i : Int, v : Double) -> BiophyloneighborRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_range_sum(s : BiophyloneighborRange) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_neighbor_range_mean(s : BiophyloneighborRange) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_neighbor_range_scale(s : BiophyloneighborRange, f : Double) -> BiophyloneighborRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_range_add(a : BiophyloneighborRange, b : BiophyloneighborRange) -> BiophyloneighborRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_neighbor_range_copy(s : BiophyloneighborRange) -> BiophyloneighborRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_range_fill(s : BiophyloneighborRange, v : Double) -> BiophyloneighborRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_range_min(s : BiophyloneighborRange) -> Double { @_common.min(s.data) }

pub fn bio_phylo_neighbor_range_max(s : BiophyloneighborRange) -> Double { @_common.max(s.data) }

pub fn bio_phylo_neighbor_range_to_string(s : BiophyloneighborRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_slice_make(size : Int) -> BiophyloneighborSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_slice_len(s : BiophyloneighborSlice) -> Int { s.size }

pub fn bio_phylo_neighbor_slice_get(s : BiophyloneighborSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_slice_set(s : BiophyloneighborSlice, i : Int, v : Double) -> BiophyloneighborSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_slice_sum(s : BiophyloneighborSlice) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_neighbor_slice_mean(s : BiophyloneighborSlice) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_neighbor_slice_scale(s : BiophyloneighborSlice, f : Double) -> BiophyloneighborSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_slice_add(a : BiophyloneighborSlice, b : BiophyloneighborSlice) -> BiophyloneighborSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_neighbor_slice_copy(s : BiophyloneighborSlice) -> BiophyloneighborSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_slice_fill(s : BiophyloneighborSlice, v : Double) -> BiophyloneighborSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_neighbor_slice_min(s : BiophyloneighborSlice) -> Double { @_common.min(s.data) }

pub fn bio_phylo_neighbor_slice_max(s : BiophyloneighborSlice) -> Double { @_common.max(s.data) }

pub fn bio_phylo_neighbor_slice_to_string(s : BiophyloneighborSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

