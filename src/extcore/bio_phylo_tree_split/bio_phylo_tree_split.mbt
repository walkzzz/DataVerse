///===
/// extcore/bio_phylo_tree_split

pub(all) struct BiophylotreesplitPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_tree_split_make_point(x : Double, y : Double) -> BiophylotreesplitPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_tree_split_make_point3(x : Double, y : Double, z : Double) -> BiophylotreesplitPoint {
  { x, y, z, label: 0 }
}

pub fn BiophylotreesplitPoint::x(self : BiophylotreesplitPoint) -> Double { self.x }

pub fn BiophylotreesplitPoint::y(self : BiophylotreesplitPoint) -> Double { self.y }

pub fn BiophylotreesplitPoint::z(self : BiophylotreesplitPoint) -> Double { self.z }

pub fn BiophylotreesplitPoint::label(self : BiophylotreesplitPoint) -> Int { self.label }

pub fn BiophylotreesplitPoint::dist(self : BiophylotreesplitPoint, other : BiophylotreesplitPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophylotreesplitPoint::add(self : BiophylotreesplitPoint, other : BiophylotreesplitPoint) -> BiophylotreesplitPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophylotreesplitPoint::sub(self : BiophylotreesplitPoint, other : BiophylotreesplitPoint) -> BiophylotreesplitPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophylotreesplitPoint::scale(self : BiophylotreesplitPoint, s : Double) -> BiophylotreesplitPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophylotreesplitPoint::dot(self : BiophylotreesplitPoint, other : BiophylotreesplitPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophylotreesplitPoint::cross(self : BiophylotreesplitPoint, other : BiophylotreesplitPoint) -> BiophylotreesplitPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophylotreesplitPoint::norm(self : BiophylotreesplitPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophylotreesplitPoint::normalize(self : BiophylotreesplitPoint) -> BiophylotreesplitPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylotreesplitPoint::negate(self : BiophylotreesplitPoint) -> BiophylotreesplitPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophylotreesplitPoint::mid(self : BiophylotreesplitPoint, other : BiophylotreesplitPoint) -> BiophylotreesplitPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophylotreesplitPoint::lerp(self : BiophylotreesplitPoint, other : BiophylotreesplitPoint, t : Double) -> BiophylotreesplitPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophylotreesplitPoint::to_string(self : BiophylotreesplitPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophylotreesplitSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_tree_split_make_series(vals : Array[Double], name : String) -> BiophylotreesplitSeries {
  { vals, name, meta: 0 }
}

pub fn BiophylotreesplitSeries::len(self : BiophylotreesplitSeries) -> Int { self.vals.length() }

pub fn BiophylotreesplitSeries::sum(self : BiophylotreesplitSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophylotreesplitSeries::mean(self : BiophylotreesplitSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophylotreesplitSeries::min(self : BiophylotreesplitSeries) -> Double { @_common.min(self.vals) }

pub fn BiophylotreesplitSeries::max(self : BiophylotreesplitSeries) -> Double { @_common.max(self.vals) }

pub fn BiophylotreesplitSeries::range(self : BiophylotreesplitSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophylotreesplitSeries::variance(self : BiophylotreesplitSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophylotreesplitSeries::std(self : BiophylotreesplitSeries) -> Double { @_common.std(self.vals) }

pub fn BiophylotreesplitSeries::median(self : BiophylotreesplitSeries) -> Double { @_common.median(self.vals) }

pub fn BiophylotreesplitSeries::scale(self : BiophylotreesplitSeries, f : Double) -> BiophylotreesplitSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophylotreesplitSeries::add(self : BiophylotreesplitSeries, other : BiophylotreesplitSeries) -> BiophylotreesplitSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophylotreesplitSeries::sub(self : BiophylotreesplitSeries, other : BiophylotreesplitSeries) -> BiophylotreesplitSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophylotreesplitSeries::normalize(self : BiophylotreesplitSeries) -> BiophylotreesplitSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophylotreesplitSeries::cumsum(self : BiophylotreesplitSeries) -> BiophylotreesplitSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophylotreesplitSeries::to_string(self : BiophylotreesplitSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylotreesplitMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_tree_split_make_matrix(rows : Int, cols : Int, val : Double) -> BiophylotreesplitMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_tree_split_matrix_identity(n : Int) -> BiophylotreesplitMatrix {
  let m = bio_phylo_tree_split_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophylotreesplitMatrix::get(self : BiophylotreesplitMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophylotreesplitMatrix::transpose(self : BiophylotreesplitMatrix) -> BiophylotreesplitMatrix {
  let result = bio_phylo_tree_split_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophylotreesplitMatrix::add(self : BiophylotreesplitMatrix, other : BiophylotreesplitMatrix) -> BiophylotreesplitMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_tree_split_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophylotreesplitMatrix::scale(self : BiophylotreesplitMatrix, s : Double) -> BiophylotreesplitMatrix {
  let result = bio_phylo_tree_split_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophylotreesplitMatrix::multiply(self : BiophylotreesplitMatrix, other : BiophylotreesplitMatrix) -> BiophylotreesplitMatrix {
  if self.cols != other.rows { return bio_phylo_tree_split_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_tree_split_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiophylotreesplitMatrix::trace(self : BiophylotreesplitMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophylotreesplitMatrix::det(self : BiophylotreesplitMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophylotreesplitMatrix::norm(self : BiophylotreesplitMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophylotreesplitMatrix::to_string(self : BiophylotreesplitMatrix) -> String {
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

pub(all) struct BiophylotreesplitVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_tree_split_make_vector(comps : Array[Double]) -> BiophylotreesplitVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_tree_split_vector_zero(dim : Int) -> BiophylotreesplitVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophylotreesplitVector::add(self : BiophylotreesplitVector, other : BiophylotreesplitVector) -> BiophylotreesplitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylotreesplitVector::sub(self : BiophylotreesplitVector, other : BiophylotreesplitVector) -> BiophylotreesplitVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylotreesplitVector::scale(self : BiophylotreesplitVector, s : Double) -> BiophylotreesplitVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophylotreesplitVector::dot(self : BiophylotreesplitVector, other : BiophylotreesplitVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophylotreesplitVector::norm(self : BiophylotreesplitVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophylotreesplitVector::normalize(self : BiophylotreesplitVector) -> BiophylotreesplitVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylotreesplitVector::dist(self : BiophylotreesplitVector, other : BiophylotreesplitVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophylotreesplitVector::to_string(self : BiophylotreesplitVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_tree_split_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_phylo_tree_split_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_phylo_tree_split_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_phylo_tree_split_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_phylo_tree_split_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_phylo_tree_split_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_phylo_tree_split_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_phylo_tree_split_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_phylo_tree_split_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_phylo_tree_split_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_phylo_tree_split_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_phylo_tree_split_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_phylo_tree_split_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_phylo_tree_split_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_phylo_tree_split_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_phylo_tree_split_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_phylo_tree_split_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_phylo_tree_split_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_phylo_tree_split_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_phylo_tree_split_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_phylo_tree_split_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_phylo_tree_split_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_phylo_tree_split_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_phylo_tree_split_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_phylo_tree_split_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_phylo_tree_split_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_phylo_tree_split_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_phylo_tree_split_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_phylo_tree_split_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiophylotreesplitFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_frame_make(size : Int) -> BiophylotreesplitFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_frame_len(s : BiophylotreesplitFrame) -> Int { s.size }

pub fn bio_phylo_tree_split_frame_get(s : BiophylotreesplitFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_frame_set(s : BiophylotreesplitFrame, i : Int, v : Double) -> BiophylotreesplitFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_frame_sum(s : BiophylotreesplitFrame) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_tree_split_frame_mean(s : BiophylotreesplitFrame) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_tree_split_frame_scale(s : BiophylotreesplitFrame, f : Double) -> BiophylotreesplitFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_frame_add(a : BiophylotreesplitFrame, b : BiophylotreesplitFrame) -> BiophylotreesplitFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_tree_split_frame_copy(s : BiophylotreesplitFrame) -> BiophylotreesplitFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_frame_fill(s : BiophylotreesplitFrame, v : Double) -> BiophylotreesplitFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_frame_min(s : BiophylotreesplitFrame) -> Double { @_common.min(s.data) }

pub fn bio_phylo_tree_split_frame_max(s : BiophylotreesplitFrame) -> Double { @_common.max(s.data) }

pub fn bio_phylo_tree_split_frame_to_string(s : BiophylotreesplitFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_table_make(size : Int) -> BiophylotreesplitTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_table_len(s : BiophylotreesplitTable) -> Int { s.size }

pub fn bio_phylo_tree_split_table_get(s : BiophylotreesplitTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_table_set(s : BiophylotreesplitTable, i : Int, v : Double) -> BiophylotreesplitTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_table_sum(s : BiophylotreesplitTable) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_tree_split_table_mean(s : BiophylotreesplitTable) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_tree_split_table_scale(s : BiophylotreesplitTable, f : Double) -> BiophylotreesplitTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_table_add(a : BiophylotreesplitTable, b : BiophylotreesplitTable) -> BiophylotreesplitTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_tree_split_table_copy(s : BiophylotreesplitTable) -> BiophylotreesplitTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_table_fill(s : BiophylotreesplitTable, v : Double) -> BiophylotreesplitTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_table_min(s : BiophylotreesplitTable) -> Double { @_common.min(s.data) }

pub fn bio_phylo_tree_split_table_max(s : BiophylotreesplitTable) -> Double { @_common.max(s.data) }

pub fn bio_phylo_tree_split_table_to_string(s : BiophylotreesplitTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_graphn_make(size : Int) -> BiophylotreesplitGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_graphn_len(s : BiophylotreesplitGraphN) -> Int { s.size }

pub fn bio_phylo_tree_split_graphn_get(s : BiophylotreesplitGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_graphn_set(s : BiophylotreesplitGraphN, i : Int, v : Double) -> BiophylotreesplitGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_graphn_sum(s : BiophylotreesplitGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_tree_split_graphn_mean(s : BiophylotreesplitGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_tree_split_graphn_scale(s : BiophylotreesplitGraphN, f : Double) -> BiophylotreesplitGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_graphn_add(a : BiophylotreesplitGraphN, b : BiophylotreesplitGraphN) -> BiophylotreesplitGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_tree_split_graphn_copy(s : BiophylotreesplitGraphN) -> BiophylotreesplitGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_graphn_fill(s : BiophylotreesplitGraphN, v : Double) -> BiophylotreesplitGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_graphn_min(s : BiophylotreesplitGraphN) -> Double { @_common.min(s.data) }

pub fn bio_phylo_tree_split_graphn_max(s : BiophylotreesplitGraphN) -> Double { @_common.max(s.data) }

pub fn bio_phylo_tree_split_graphn_to_string(s : BiophylotreesplitGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_node_make(size : Int) -> BiophylotreesplitNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_node_len(s : BiophylotreesplitNode) -> Int { s.size }

pub fn bio_phylo_tree_split_node_get(s : BiophylotreesplitNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_node_set(s : BiophylotreesplitNode, i : Int, v : Double) -> BiophylotreesplitNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_node_sum(s : BiophylotreesplitNode) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_tree_split_node_mean(s : BiophylotreesplitNode) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_tree_split_node_scale(s : BiophylotreesplitNode, f : Double) -> BiophylotreesplitNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_node_add(a : BiophylotreesplitNode, b : BiophylotreesplitNode) -> BiophylotreesplitNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_tree_split_node_copy(s : BiophylotreesplitNode) -> BiophylotreesplitNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_node_fill(s : BiophylotreesplitNode, v : Double) -> BiophylotreesplitNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_node_min(s : BiophylotreesplitNode) -> Double { @_common.min(s.data) }

pub fn bio_phylo_tree_split_node_max(s : BiophylotreesplitNode) -> Double { @_common.max(s.data) }

pub fn bio_phylo_tree_split_node_to_string(s : BiophylotreesplitNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_edge_make(size : Int) -> BiophylotreesplitEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_edge_len(s : BiophylotreesplitEdge) -> Int { s.size }

pub fn bio_phylo_tree_split_edge_get(s : BiophylotreesplitEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_edge_set(s : BiophylotreesplitEdge, i : Int, v : Double) -> BiophylotreesplitEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_edge_sum(s : BiophylotreesplitEdge) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_tree_split_edge_mean(s : BiophylotreesplitEdge) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_tree_split_edge_scale(s : BiophylotreesplitEdge, f : Double) -> BiophylotreesplitEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_edge_add(a : BiophylotreesplitEdge, b : BiophylotreesplitEdge) -> BiophylotreesplitEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_tree_split_edge_copy(s : BiophylotreesplitEdge) -> BiophylotreesplitEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_edge_fill(s : BiophylotreesplitEdge, v : Double) -> BiophylotreesplitEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_edge_min(s : BiophylotreesplitEdge) -> Double { @_common.min(s.data) }

pub fn bio_phylo_tree_split_edge_max(s : BiophylotreesplitEdge) -> Double { @_common.max(s.data) }

pub fn bio_phylo_tree_split_edge_to_string(s : BiophylotreesplitEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_path_make(size : Int) -> BiophylotreesplitPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_path_len(s : BiophylotreesplitPath) -> Int { s.size }

pub fn bio_phylo_tree_split_path_get(s : BiophylotreesplitPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_path_set(s : BiophylotreesplitPath, i : Int, v : Double) -> BiophylotreesplitPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_path_sum(s : BiophylotreesplitPath) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_tree_split_path_mean(s : BiophylotreesplitPath) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_tree_split_path_scale(s : BiophylotreesplitPath, f : Double) -> BiophylotreesplitPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_path_add(a : BiophylotreesplitPath, b : BiophylotreesplitPath) -> BiophylotreesplitPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_tree_split_path_copy(s : BiophylotreesplitPath) -> BiophylotreesplitPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_path_fill(s : BiophylotreesplitPath, v : Double) -> BiophylotreesplitPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_path_min(s : BiophylotreesplitPath) -> Double { @_common.min(s.data) }

pub fn bio_phylo_tree_split_path_max(s : BiophylotreesplitPath) -> Double { @_common.max(s.data) }

pub fn bio_phylo_tree_split_path_to_string(s : BiophylotreesplitPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_cluster_make(size : Int) -> BiophylotreesplitCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_cluster_len(s : BiophylotreesplitCluster) -> Int { s.size }

pub fn bio_phylo_tree_split_cluster_get(s : BiophylotreesplitCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_cluster_set(s : BiophylotreesplitCluster, i : Int, v : Double) -> BiophylotreesplitCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_cluster_sum(s : BiophylotreesplitCluster) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_tree_split_cluster_mean(s : BiophylotreesplitCluster) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_tree_split_cluster_scale(s : BiophylotreesplitCluster, f : Double) -> BiophylotreesplitCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_cluster_add(a : BiophylotreesplitCluster, b : BiophylotreesplitCluster) -> BiophylotreesplitCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_tree_split_cluster_copy(s : BiophylotreesplitCluster) -> BiophylotreesplitCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_cluster_fill(s : BiophylotreesplitCluster, v : Double) -> BiophylotreesplitCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_cluster_min(s : BiophylotreesplitCluster) -> Double { @_common.min(s.data) }

pub fn bio_phylo_tree_split_cluster_max(s : BiophylotreesplitCluster) -> Double { @_common.max(s.data) }

pub fn bio_phylo_tree_split_cluster_to_string(s : BiophylotreesplitCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_model_make(size : Int) -> BiophylotreesplitModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_model_len(s : BiophylotreesplitModel) -> Int { s.size }

pub fn bio_phylo_tree_split_model_get(s : BiophylotreesplitModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_model_set(s : BiophylotreesplitModel, i : Int, v : Double) -> BiophylotreesplitModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_model_sum(s : BiophylotreesplitModel) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_tree_split_model_mean(s : BiophylotreesplitModel) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_tree_split_model_scale(s : BiophylotreesplitModel, f : Double) -> BiophylotreesplitModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_model_add(a : BiophylotreesplitModel, b : BiophylotreesplitModel) -> BiophylotreesplitModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_tree_split_model_copy(s : BiophylotreesplitModel) -> BiophylotreesplitModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_model_fill(s : BiophylotreesplitModel, v : Double) -> BiophylotreesplitModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_model_min(s : BiophylotreesplitModel) -> Double { @_common.min(s.data) }

pub fn bio_phylo_tree_split_model_max(s : BiophylotreesplitModel) -> Double { @_common.max(s.data) }

pub fn bio_phylo_tree_split_model_to_string(s : BiophylotreesplitModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_layer_make(size : Int) -> BiophylotreesplitLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_layer_len(s : BiophylotreesplitLayer) -> Int { s.size }

pub fn bio_phylo_tree_split_layer_get(s : BiophylotreesplitLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_layer_set(s : BiophylotreesplitLayer, i : Int, v : Double) -> BiophylotreesplitLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_layer_sum(s : BiophylotreesplitLayer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_tree_split_layer_mean(s : BiophylotreesplitLayer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_tree_split_layer_scale(s : BiophylotreesplitLayer, f : Double) -> BiophylotreesplitLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_layer_add(a : BiophylotreesplitLayer, b : BiophylotreesplitLayer) -> BiophylotreesplitLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_tree_split_layer_copy(s : BiophylotreesplitLayer) -> BiophylotreesplitLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_layer_fill(s : BiophylotreesplitLayer, v : Double) -> BiophylotreesplitLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_layer_min(s : BiophylotreesplitLayer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_tree_split_layer_max(s : BiophylotreesplitLayer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_tree_split_layer_to_string(s : BiophylotreesplitLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_buffer_make(size : Int) -> BiophylotreesplitBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_buffer_len(s : BiophylotreesplitBuffer) -> Int { s.size }

pub fn bio_phylo_tree_split_buffer_get(s : BiophylotreesplitBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_buffer_set(s : BiophylotreesplitBuffer, i : Int, v : Double) -> BiophylotreesplitBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_buffer_sum(s : BiophylotreesplitBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_tree_split_buffer_mean(s : BiophylotreesplitBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_tree_split_buffer_scale(s : BiophylotreesplitBuffer, f : Double) -> BiophylotreesplitBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_buffer_add(a : BiophylotreesplitBuffer, b : BiophylotreesplitBuffer) -> BiophylotreesplitBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_tree_split_buffer_copy(s : BiophylotreesplitBuffer) -> BiophylotreesplitBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_buffer_fill(s : BiophylotreesplitBuffer, v : Double) -> BiophylotreesplitBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_buffer_min(s : BiophylotreesplitBuffer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_tree_split_buffer_max(s : BiophylotreesplitBuffer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_tree_split_buffer_to_string(s : BiophylotreesplitBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_cursor_make(size : Int) -> BiophylotreesplitCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_cursor_len(s : BiophylotreesplitCursor) -> Int { s.size }

pub fn bio_phylo_tree_split_cursor_get(s : BiophylotreesplitCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_cursor_set(s : BiophylotreesplitCursor, i : Int, v : Double) -> BiophylotreesplitCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_cursor_sum(s : BiophylotreesplitCursor) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_tree_split_cursor_mean(s : BiophylotreesplitCursor) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_tree_split_cursor_scale(s : BiophylotreesplitCursor, f : Double) -> BiophylotreesplitCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_cursor_add(a : BiophylotreesplitCursor, b : BiophylotreesplitCursor) -> BiophylotreesplitCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_tree_split_cursor_copy(s : BiophylotreesplitCursor) -> BiophylotreesplitCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_cursor_fill(s : BiophylotreesplitCursor, v : Double) -> BiophylotreesplitCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_cursor_min(s : BiophylotreesplitCursor) -> Double { @_common.min(s.data) }

pub fn bio_phylo_tree_split_cursor_max(s : BiophylotreesplitCursor) -> Double { @_common.max(s.data) }

pub fn bio_phylo_tree_split_cursor_to_string(s : BiophylotreesplitCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_view_make(size : Int) -> BiophylotreesplitView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_view_len(s : BiophylotreesplitView) -> Int { s.size }

pub fn bio_phylo_tree_split_view_get(s : BiophylotreesplitView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_view_set(s : BiophylotreesplitView, i : Int, v : Double) -> BiophylotreesplitView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_view_sum(s : BiophylotreesplitView) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_tree_split_view_mean(s : BiophylotreesplitView) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_tree_split_view_scale(s : BiophylotreesplitView, f : Double) -> BiophylotreesplitView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_view_add(a : BiophylotreesplitView, b : BiophylotreesplitView) -> BiophylotreesplitView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_tree_split_view_copy(s : BiophylotreesplitView) -> BiophylotreesplitView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_view_fill(s : BiophylotreesplitView, v : Double) -> BiophylotreesplitView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_view_min(s : BiophylotreesplitView) -> Double { @_common.min(s.data) }

pub fn bio_phylo_tree_split_view_max(s : BiophylotreesplitView) -> Double { @_common.max(s.data) }

pub fn bio_phylo_tree_split_view_to_string(s : BiophylotreesplitView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_range_make(size : Int) -> BiophylotreesplitRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_range_len(s : BiophylotreesplitRange) -> Int { s.size }

pub fn bio_phylo_tree_split_range_get(s : BiophylotreesplitRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_range_set(s : BiophylotreesplitRange, i : Int, v : Double) -> BiophylotreesplitRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_range_sum(s : BiophylotreesplitRange) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_tree_split_range_mean(s : BiophylotreesplitRange) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_tree_split_range_scale(s : BiophylotreesplitRange, f : Double) -> BiophylotreesplitRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_range_add(a : BiophylotreesplitRange, b : BiophylotreesplitRange) -> BiophylotreesplitRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_tree_split_range_copy(s : BiophylotreesplitRange) -> BiophylotreesplitRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_range_fill(s : BiophylotreesplitRange, v : Double) -> BiophylotreesplitRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_range_min(s : BiophylotreesplitRange) -> Double { @_common.min(s.data) }

pub fn bio_phylo_tree_split_range_max(s : BiophylotreesplitRange) -> Double { @_common.max(s.data) }

pub fn bio_phylo_tree_split_range_to_string(s : BiophylotreesplitRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylotreesplitSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_tree_split_slice_make(size : Int) -> BiophylotreesplitSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_tree_split_slice_len(s : BiophylotreesplitSlice) -> Int { s.size }

pub fn bio_phylo_tree_split_slice_get(s : BiophylotreesplitSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_tree_split_slice_set(s : BiophylotreesplitSlice, i : Int, v : Double) -> BiophylotreesplitSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_slice_sum(s : BiophylotreesplitSlice) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_tree_split_slice_mean(s : BiophylotreesplitSlice) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_tree_split_slice_scale(s : BiophylotreesplitSlice, f : Double) -> BiophylotreesplitSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_slice_add(a : BiophylotreesplitSlice, b : BiophylotreesplitSlice) -> BiophylotreesplitSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_tree_split_slice_copy(s : BiophylotreesplitSlice) -> BiophylotreesplitSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_slice_fill(s : BiophylotreesplitSlice, v : Double) -> BiophylotreesplitSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_tree_split_slice_min(s : BiophylotreesplitSlice) -> Double { @_common.min(s.data) }

pub fn bio_phylo_tree_split_slice_max(s : BiophylotreesplitSlice) -> Double { @_common.max(s.data) }

pub fn bio_phylo_tree_split_slice_to_string(s : BiophylotreesplitSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

