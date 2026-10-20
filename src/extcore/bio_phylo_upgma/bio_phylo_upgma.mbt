///===
/// extcore/bio_phylo_upgma

pub(all) struct BiophyloupgmaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_upgma_make_point(x : Double, y : Double) -> BiophyloupgmaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_upgma_make_point3(x : Double, y : Double, z : Double) -> BiophyloupgmaPoint {
  { x, y, z, label: 0 }
}

pub fn BiophyloupgmaPoint::x(self : BiophyloupgmaPoint) -> Double { self.x }

pub fn BiophyloupgmaPoint::y(self : BiophyloupgmaPoint) -> Double { self.y }

pub fn BiophyloupgmaPoint::z(self : BiophyloupgmaPoint) -> Double { self.z }

pub fn BiophyloupgmaPoint::label(self : BiophyloupgmaPoint) -> Int { self.label }

pub fn BiophyloupgmaPoint::dist(self : BiophyloupgmaPoint, other : BiophyloupgmaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophyloupgmaPoint::add(self : BiophyloupgmaPoint, other : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophyloupgmaPoint::sub(self : BiophyloupgmaPoint, other : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophyloupgmaPoint::scale(self : BiophyloupgmaPoint, s : Double) -> BiophyloupgmaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophyloupgmaPoint::dot(self : BiophyloupgmaPoint, other : BiophyloupgmaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophyloupgmaPoint::cross(self : BiophyloupgmaPoint, other : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophyloupgmaPoint::norm(self : BiophyloupgmaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophyloupgmaPoint::normalize(self : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloupgmaPoint::negate(self : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophyloupgmaPoint::mid(self : BiophyloupgmaPoint, other : BiophyloupgmaPoint) -> BiophyloupgmaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophyloupgmaPoint::lerp(self : BiophyloupgmaPoint, other : BiophyloupgmaPoint, t : Double) -> BiophyloupgmaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophyloupgmaPoint::to_string(self : BiophyloupgmaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophyloupgmaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_upgma_make_series(vals : Array[Double], name : String) -> BiophyloupgmaSeries {
  { vals, name, meta: 0 }
}

pub fn BiophyloupgmaSeries::len(self : BiophyloupgmaSeries) -> Int { self.vals.length() }

pub fn BiophyloupgmaSeries::sum(self : BiophyloupgmaSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophyloupgmaSeries::mean(self : BiophyloupgmaSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophyloupgmaSeries::min(self : BiophyloupgmaSeries) -> Double { @_common.min(self.vals) }

pub fn BiophyloupgmaSeries::max(self : BiophyloupgmaSeries) -> Double { @_common.max(self.vals) }

pub fn BiophyloupgmaSeries::range(self : BiophyloupgmaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophyloupgmaSeries::variance(self : BiophyloupgmaSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophyloupgmaSeries::std(self : BiophyloupgmaSeries) -> Double { @_common.std(self.vals) }

pub fn BiophyloupgmaSeries::median(self : BiophyloupgmaSeries) -> Double { @_common.median(self.vals) }

pub fn BiophyloupgmaSeries::scale(self : BiophyloupgmaSeries, f : Double) -> BiophyloupgmaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophyloupgmaSeries::add(self : BiophyloupgmaSeries, other : BiophyloupgmaSeries) -> BiophyloupgmaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophyloupgmaSeries::sub(self : BiophyloupgmaSeries, other : BiophyloupgmaSeries) -> BiophyloupgmaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophyloupgmaSeries::normalize(self : BiophyloupgmaSeries) -> BiophyloupgmaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophyloupgmaSeries::cumsum(self : BiophyloupgmaSeries) -> BiophyloupgmaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophyloupgmaSeries::to_string(self : BiophyloupgmaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloupgmaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_upgma_make_matrix(rows : Int, cols : Int, val : Double) -> BiophyloupgmaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_upgma_matrix_identity(n : Int) -> BiophyloupgmaMatrix {
  let m = bio_phylo_upgma_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophyloupgmaMatrix::get(self : BiophyloupgmaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophyloupgmaMatrix::transpose(self : BiophyloupgmaMatrix) -> BiophyloupgmaMatrix {
  let result = bio_phylo_upgma_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophyloupgmaMatrix::add(self : BiophyloupgmaMatrix, other : BiophyloupgmaMatrix) -> BiophyloupgmaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_upgma_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophyloupgmaMatrix::scale(self : BiophyloupgmaMatrix, s : Double) -> BiophyloupgmaMatrix {
  let result = bio_phylo_upgma_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophyloupgmaMatrix::multiply(self : BiophyloupgmaMatrix, other : BiophyloupgmaMatrix) -> BiophyloupgmaMatrix {
  if self.cols != other.rows { return bio_phylo_upgma_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_upgma_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiophyloupgmaMatrix::trace(self : BiophyloupgmaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophyloupgmaMatrix::det(self : BiophyloupgmaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophyloupgmaMatrix::norm(self : BiophyloupgmaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophyloupgmaMatrix::to_string(self : BiophyloupgmaMatrix) -> String {
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

pub(all) struct BiophyloupgmaVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_upgma_make_vector(comps : Array[Double]) -> BiophyloupgmaVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_upgma_vector_zero(dim : Int) -> BiophyloupgmaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophyloupgmaVector::add(self : BiophyloupgmaVector, other : BiophyloupgmaVector) -> BiophyloupgmaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloupgmaVector::sub(self : BiophyloupgmaVector, other : BiophyloupgmaVector) -> BiophyloupgmaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloupgmaVector::scale(self : BiophyloupgmaVector, s : Double) -> BiophyloupgmaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophyloupgmaVector::dot(self : BiophyloupgmaVector, other : BiophyloupgmaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophyloupgmaVector::norm(self : BiophyloupgmaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophyloupgmaVector::normalize(self : BiophyloupgmaVector) -> BiophyloupgmaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloupgmaVector::dist(self : BiophyloupgmaVector, other : BiophyloupgmaVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophyloupgmaVector::to_string(self : BiophyloupgmaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_upgma_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_phylo_upgma_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_phylo_upgma_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_phylo_upgma_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_phylo_upgma_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_phylo_upgma_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_phylo_upgma_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_phylo_upgma_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_phylo_upgma_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_phylo_upgma_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_phylo_upgma_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_phylo_upgma_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_phylo_upgma_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_phylo_upgma_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_phylo_upgma_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_phylo_upgma_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_phylo_upgma_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_phylo_upgma_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_phylo_upgma_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_phylo_upgma_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_phylo_upgma_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_phylo_upgma_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_phylo_upgma_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_phylo_upgma_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_phylo_upgma_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_phylo_upgma_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_phylo_upgma_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_phylo_upgma_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_phylo_upgma_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiophyloupgmaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_frame_make(size : Int) -> BiophyloupgmaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_frame_len(s : BiophyloupgmaFrame) -> Int { s.size }

pub fn bio_phylo_upgma_frame_get(s : BiophyloupgmaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_frame_set(s : BiophyloupgmaFrame, i : Int, v : Double) -> BiophyloupgmaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_frame_sum(s : BiophyloupgmaFrame) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_upgma_frame_mean(s : BiophyloupgmaFrame) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_upgma_frame_scale(s : BiophyloupgmaFrame, f : Double) -> BiophyloupgmaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_frame_add(a : BiophyloupgmaFrame, b : BiophyloupgmaFrame) -> BiophyloupgmaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_upgma_frame_copy(s : BiophyloupgmaFrame) -> BiophyloupgmaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_frame_fill(s : BiophyloupgmaFrame, v : Double) -> BiophyloupgmaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_frame_min(s : BiophyloupgmaFrame) -> Double { @_common.min(s.data) }

pub fn bio_phylo_upgma_frame_max(s : BiophyloupgmaFrame) -> Double { @_common.max(s.data) }

pub fn bio_phylo_upgma_frame_to_string(s : BiophyloupgmaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_table_make(size : Int) -> BiophyloupgmaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_table_len(s : BiophyloupgmaTable) -> Int { s.size }

pub fn bio_phylo_upgma_table_get(s : BiophyloupgmaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_table_set(s : BiophyloupgmaTable, i : Int, v : Double) -> BiophyloupgmaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_table_sum(s : BiophyloupgmaTable) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_upgma_table_mean(s : BiophyloupgmaTable) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_upgma_table_scale(s : BiophyloupgmaTable, f : Double) -> BiophyloupgmaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_table_add(a : BiophyloupgmaTable, b : BiophyloupgmaTable) -> BiophyloupgmaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_upgma_table_copy(s : BiophyloupgmaTable) -> BiophyloupgmaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_table_fill(s : BiophyloupgmaTable, v : Double) -> BiophyloupgmaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_table_min(s : BiophyloupgmaTable) -> Double { @_common.min(s.data) }

pub fn bio_phylo_upgma_table_max(s : BiophyloupgmaTable) -> Double { @_common.max(s.data) }

pub fn bio_phylo_upgma_table_to_string(s : BiophyloupgmaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_graphn_make(size : Int) -> BiophyloupgmaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_graphn_len(s : BiophyloupgmaGraphN) -> Int { s.size }

pub fn bio_phylo_upgma_graphn_get(s : BiophyloupgmaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_graphn_set(s : BiophyloupgmaGraphN, i : Int, v : Double) -> BiophyloupgmaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_graphn_sum(s : BiophyloupgmaGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_upgma_graphn_mean(s : BiophyloupgmaGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_upgma_graphn_scale(s : BiophyloupgmaGraphN, f : Double) -> BiophyloupgmaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_graphn_add(a : BiophyloupgmaGraphN, b : BiophyloupgmaGraphN) -> BiophyloupgmaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_upgma_graphn_copy(s : BiophyloupgmaGraphN) -> BiophyloupgmaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_graphn_fill(s : BiophyloupgmaGraphN, v : Double) -> BiophyloupgmaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_graphn_min(s : BiophyloupgmaGraphN) -> Double { @_common.min(s.data) }

pub fn bio_phylo_upgma_graphn_max(s : BiophyloupgmaGraphN) -> Double { @_common.max(s.data) }

pub fn bio_phylo_upgma_graphn_to_string(s : BiophyloupgmaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_node_make(size : Int) -> BiophyloupgmaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_node_len(s : BiophyloupgmaNode) -> Int { s.size }

pub fn bio_phylo_upgma_node_get(s : BiophyloupgmaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_node_set(s : BiophyloupgmaNode, i : Int, v : Double) -> BiophyloupgmaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_node_sum(s : BiophyloupgmaNode) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_upgma_node_mean(s : BiophyloupgmaNode) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_upgma_node_scale(s : BiophyloupgmaNode, f : Double) -> BiophyloupgmaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_node_add(a : BiophyloupgmaNode, b : BiophyloupgmaNode) -> BiophyloupgmaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_upgma_node_copy(s : BiophyloupgmaNode) -> BiophyloupgmaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_node_fill(s : BiophyloupgmaNode, v : Double) -> BiophyloupgmaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_node_min(s : BiophyloupgmaNode) -> Double { @_common.min(s.data) }

pub fn bio_phylo_upgma_node_max(s : BiophyloupgmaNode) -> Double { @_common.max(s.data) }

pub fn bio_phylo_upgma_node_to_string(s : BiophyloupgmaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_edge_make(size : Int) -> BiophyloupgmaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_edge_len(s : BiophyloupgmaEdge) -> Int { s.size }

pub fn bio_phylo_upgma_edge_get(s : BiophyloupgmaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_edge_set(s : BiophyloupgmaEdge, i : Int, v : Double) -> BiophyloupgmaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_edge_sum(s : BiophyloupgmaEdge) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_upgma_edge_mean(s : BiophyloupgmaEdge) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_upgma_edge_scale(s : BiophyloupgmaEdge, f : Double) -> BiophyloupgmaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_edge_add(a : BiophyloupgmaEdge, b : BiophyloupgmaEdge) -> BiophyloupgmaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_upgma_edge_copy(s : BiophyloupgmaEdge) -> BiophyloupgmaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_edge_fill(s : BiophyloupgmaEdge, v : Double) -> BiophyloupgmaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_edge_min(s : BiophyloupgmaEdge) -> Double { @_common.min(s.data) }

pub fn bio_phylo_upgma_edge_max(s : BiophyloupgmaEdge) -> Double { @_common.max(s.data) }

pub fn bio_phylo_upgma_edge_to_string(s : BiophyloupgmaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_path_make(size : Int) -> BiophyloupgmaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_path_len(s : BiophyloupgmaPath) -> Int { s.size }

pub fn bio_phylo_upgma_path_get(s : BiophyloupgmaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_path_set(s : BiophyloupgmaPath, i : Int, v : Double) -> BiophyloupgmaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_path_sum(s : BiophyloupgmaPath) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_upgma_path_mean(s : BiophyloupgmaPath) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_upgma_path_scale(s : BiophyloupgmaPath, f : Double) -> BiophyloupgmaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_path_add(a : BiophyloupgmaPath, b : BiophyloupgmaPath) -> BiophyloupgmaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_upgma_path_copy(s : BiophyloupgmaPath) -> BiophyloupgmaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_path_fill(s : BiophyloupgmaPath, v : Double) -> BiophyloupgmaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_path_min(s : BiophyloupgmaPath) -> Double { @_common.min(s.data) }

pub fn bio_phylo_upgma_path_max(s : BiophyloupgmaPath) -> Double { @_common.max(s.data) }

pub fn bio_phylo_upgma_path_to_string(s : BiophyloupgmaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_cluster_make(size : Int) -> BiophyloupgmaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_cluster_len(s : BiophyloupgmaCluster) -> Int { s.size }

pub fn bio_phylo_upgma_cluster_get(s : BiophyloupgmaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_cluster_set(s : BiophyloupgmaCluster, i : Int, v : Double) -> BiophyloupgmaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_cluster_sum(s : BiophyloupgmaCluster) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_upgma_cluster_mean(s : BiophyloupgmaCluster) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_upgma_cluster_scale(s : BiophyloupgmaCluster, f : Double) -> BiophyloupgmaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_cluster_add(a : BiophyloupgmaCluster, b : BiophyloupgmaCluster) -> BiophyloupgmaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_upgma_cluster_copy(s : BiophyloupgmaCluster) -> BiophyloupgmaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_cluster_fill(s : BiophyloupgmaCluster, v : Double) -> BiophyloupgmaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_cluster_min(s : BiophyloupgmaCluster) -> Double { @_common.min(s.data) }

pub fn bio_phylo_upgma_cluster_max(s : BiophyloupgmaCluster) -> Double { @_common.max(s.data) }

pub fn bio_phylo_upgma_cluster_to_string(s : BiophyloupgmaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_model_make(size : Int) -> BiophyloupgmaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_model_len(s : BiophyloupgmaModel) -> Int { s.size }

pub fn bio_phylo_upgma_model_get(s : BiophyloupgmaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_model_set(s : BiophyloupgmaModel, i : Int, v : Double) -> BiophyloupgmaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_model_sum(s : BiophyloupgmaModel) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_upgma_model_mean(s : BiophyloupgmaModel) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_upgma_model_scale(s : BiophyloupgmaModel, f : Double) -> BiophyloupgmaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_model_add(a : BiophyloupgmaModel, b : BiophyloupgmaModel) -> BiophyloupgmaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_upgma_model_copy(s : BiophyloupgmaModel) -> BiophyloupgmaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_model_fill(s : BiophyloupgmaModel, v : Double) -> BiophyloupgmaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_model_min(s : BiophyloupgmaModel) -> Double { @_common.min(s.data) }

pub fn bio_phylo_upgma_model_max(s : BiophyloupgmaModel) -> Double { @_common.max(s.data) }

pub fn bio_phylo_upgma_model_to_string(s : BiophyloupgmaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_layer_make(size : Int) -> BiophyloupgmaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_layer_len(s : BiophyloupgmaLayer) -> Int { s.size }

pub fn bio_phylo_upgma_layer_get(s : BiophyloupgmaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_layer_set(s : BiophyloupgmaLayer, i : Int, v : Double) -> BiophyloupgmaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_layer_sum(s : BiophyloupgmaLayer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_upgma_layer_mean(s : BiophyloupgmaLayer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_upgma_layer_scale(s : BiophyloupgmaLayer, f : Double) -> BiophyloupgmaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_layer_add(a : BiophyloupgmaLayer, b : BiophyloupgmaLayer) -> BiophyloupgmaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_upgma_layer_copy(s : BiophyloupgmaLayer) -> BiophyloupgmaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_layer_fill(s : BiophyloupgmaLayer, v : Double) -> BiophyloupgmaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_layer_min(s : BiophyloupgmaLayer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_upgma_layer_max(s : BiophyloupgmaLayer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_upgma_layer_to_string(s : BiophyloupgmaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_buffer_make(size : Int) -> BiophyloupgmaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_buffer_len(s : BiophyloupgmaBuffer) -> Int { s.size }

pub fn bio_phylo_upgma_buffer_get(s : BiophyloupgmaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_buffer_set(s : BiophyloupgmaBuffer, i : Int, v : Double) -> BiophyloupgmaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_buffer_sum(s : BiophyloupgmaBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_upgma_buffer_mean(s : BiophyloupgmaBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_upgma_buffer_scale(s : BiophyloupgmaBuffer, f : Double) -> BiophyloupgmaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_buffer_add(a : BiophyloupgmaBuffer, b : BiophyloupgmaBuffer) -> BiophyloupgmaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_upgma_buffer_copy(s : BiophyloupgmaBuffer) -> BiophyloupgmaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_buffer_fill(s : BiophyloupgmaBuffer, v : Double) -> BiophyloupgmaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_buffer_min(s : BiophyloupgmaBuffer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_upgma_buffer_max(s : BiophyloupgmaBuffer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_upgma_buffer_to_string(s : BiophyloupgmaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_cursor_make(size : Int) -> BiophyloupgmaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_cursor_len(s : BiophyloupgmaCursor) -> Int { s.size }

pub fn bio_phylo_upgma_cursor_get(s : BiophyloupgmaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_cursor_set(s : BiophyloupgmaCursor, i : Int, v : Double) -> BiophyloupgmaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_cursor_sum(s : BiophyloupgmaCursor) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_upgma_cursor_mean(s : BiophyloupgmaCursor) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_upgma_cursor_scale(s : BiophyloupgmaCursor, f : Double) -> BiophyloupgmaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_cursor_add(a : BiophyloupgmaCursor, b : BiophyloupgmaCursor) -> BiophyloupgmaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_upgma_cursor_copy(s : BiophyloupgmaCursor) -> BiophyloupgmaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_cursor_fill(s : BiophyloupgmaCursor, v : Double) -> BiophyloupgmaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_cursor_min(s : BiophyloupgmaCursor) -> Double { @_common.min(s.data) }

pub fn bio_phylo_upgma_cursor_max(s : BiophyloupgmaCursor) -> Double { @_common.max(s.data) }

pub fn bio_phylo_upgma_cursor_to_string(s : BiophyloupgmaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_view_make(size : Int) -> BiophyloupgmaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_view_len(s : BiophyloupgmaView) -> Int { s.size }

pub fn bio_phylo_upgma_view_get(s : BiophyloupgmaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_view_set(s : BiophyloupgmaView, i : Int, v : Double) -> BiophyloupgmaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_view_sum(s : BiophyloupgmaView) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_upgma_view_mean(s : BiophyloupgmaView) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_upgma_view_scale(s : BiophyloupgmaView, f : Double) -> BiophyloupgmaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_view_add(a : BiophyloupgmaView, b : BiophyloupgmaView) -> BiophyloupgmaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_upgma_view_copy(s : BiophyloupgmaView) -> BiophyloupgmaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_view_fill(s : BiophyloupgmaView, v : Double) -> BiophyloupgmaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_view_min(s : BiophyloupgmaView) -> Double { @_common.min(s.data) }

pub fn bio_phylo_upgma_view_max(s : BiophyloupgmaView) -> Double { @_common.max(s.data) }

pub fn bio_phylo_upgma_view_to_string(s : BiophyloupgmaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_range_make(size : Int) -> BiophyloupgmaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_range_len(s : BiophyloupgmaRange) -> Int { s.size }

pub fn bio_phylo_upgma_range_get(s : BiophyloupgmaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_range_set(s : BiophyloupgmaRange, i : Int, v : Double) -> BiophyloupgmaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_range_sum(s : BiophyloupgmaRange) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_upgma_range_mean(s : BiophyloupgmaRange) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_upgma_range_scale(s : BiophyloupgmaRange, f : Double) -> BiophyloupgmaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_range_add(a : BiophyloupgmaRange, b : BiophyloupgmaRange) -> BiophyloupgmaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_upgma_range_copy(s : BiophyloupgmaRange) -> BiophyloupgmaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_range_fill(s : BiophyloupgmaRange, v : Double) -> BiophyloupgmaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_range_min(s : BiophyloupgmaRange) -> Double { @_common.min(s.data) }

pub fn bio_phylo_upgma_range_max(s : BiophyloupgmaRange) -> Double { @_common.max(s.data) }

pub fn bio_phylo_upgma_range_to_string(s : BiophyloupgmaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloupgmaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_upgma_slice_make(size : Int) -> BiophyloupgmaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_upgma_slice_len(s : BiophyloupgmaSlice) -> Int { s.size }

pub fn bio_phylo_upgma_slice_get(s : BiophyloupgmaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_upgma_slice_set(s : BiophyloupgmaSlice, i : Int, v : Double) -> BiophyloupgmaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_slice_sum(s : BiophyloupgmaSlice) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_upgma_slice_mean(s : BiophyloupgmaSlice) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_upgma_slice_scale(s : BiophyloupgmaSlice, f : Double) -> BiophyloupgmaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_slice_add(a : BiophyloupgmaSlice, b : BiophyloupgmaSlice) -> BiophyloupgmaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_upgma_slice_copy(s : BiophyloupgmaSlice) -> BiophyloupgmaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_slice_fill(s : BiophyloupgmaSlice, v : Double) -> BiophyloupgmaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_upgma_slice_min(s : BiophyloupgmaSlice) -> Double { @_common.min(s.data) }

pub fn bio_phylo_upgma_slice_max(s : BiophyloupgmaSlice) -> Double { @_common.max(s.data) }

pub fn bio_phylo_upgma_slice_to_string(s : BiophyloupgmaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

