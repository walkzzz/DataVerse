///===
/// extcore/bio_phylo_reconcile

pub(all) struct BiophyloreconcilePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_reconcile_make_point(x : Double, y : Double) -> BiophyloreconcilePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_reconcile_make_point3(x : Double, y : Double, z : Double) -> BiophyloreconcilePoint {
  { x, y, z, label: 0 }
}

pub fn BiophyloreconcilePoint::x(self : BiophyloreconcilePoint) -> Double { self.x }

pub fn BiophyloreconcilePoint::y(self : BiophyloreconcilePoint) -> Double { self.y }

pub fn BiophyloreconcilePoint::z(self : BiophyloreconcilePoint) -> Double { self.z }

pub fn BiophyloreconcilePoint::label(self : BiophyloreconcilePoint) -> Int { self.label }

pub fn BiophyloreconcilePoint::dist(self : BiophyloreconcilePoint, other : BiophyloreconcilePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophyloreconcilePoint::add(self : BiophyloreconcilePoint, other : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophyloreconcilePoint::sub(self : BiophyloreconcilePoint, other : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophyloreconcilePoint::scale(self : BiophyloreconcilePoint, s : Double) -> BiophyloreconcilePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophyloreconcilePoint::dot(self : BiophyloreconcilePoint, other : BiophyloreconcilePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophyloreconcilePoint::cross(self : BiophyloreconcilePoint, other : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophyloreconcilePoint::norm(self : BiophyloreconcilePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophyloreconcilePoint::normalize(self : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloreconcilePoint::negate(self : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophyloreconcilePoint::mid(self : BiophyloreconcilePoint, other : BiophyloreconcilePoint) -> BiophyloreconcilePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophyloreconcilePoint::lerp(self : BiophyloreconcilePoint, other : BiophyloreconcilePoint, t : Double) -> BiophyloreconcilePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophyloreconcilePoint::to_string(self : BiophyloreconcilePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophyloreconcileSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_reconcile_make_series(vals : Array[Double], name : String) -> BiophyloreconcileSeries {
  { vals, name, meta: 0 }
}

pub fn BiophyloreconcileSeries::len(self : BiophyloreconcileSeries) -> Int { self.vals.length() }

pub fn BiophyloreconcileSeries::sum(self : BiophyloreconcileSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophyloreconcileSeries::mean(self : BiophyloreconcileSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophyloreconcileSeries::min(self : BiophyloreconcileSeries) -> Double { @_common.min(self.vals) }

pub fn BiophyloreconcileSeries::max(self : BiophyloreconcileSeries) -> Double { @_common.max(self.vals) }

pub fn BiophyloreconcileSeries::range(self : BiophyloreconcileSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophyloreconcileSeries::variance(self : BiophyloreconcileSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophyloreconcileSeries::std(self : BiophyloreconcileSeries) -> Double { @_common.std(self.vals) }

pub fn BiophyloreconcileSeries::median(self : BiophyloreconcileSeries) -> Double { @_common.median(self.vals) }

pub fn BiophyloreconcileSeries::scale(self : BiophyloreconcileSeries, f : Double) -> BiophyloreconcileSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophyloreconcileSeries::add(self : BiophyloreconcileSeries, other : BiophyloreconcileSeries) -> BiophyloreconcileSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophyloreconcileSeries::sub(self : BiophyloreconcileSeries, other : BiophyloreconcileSeries) -> BiophyloreconcileSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophyloreconcileSeries::normalize(self : BiophyloreconcileSeries) -> BiophyloreconcileSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophyloreconcileSeries::cumsum(self : BiophyloreconcileSeries) -> BiophyloreconcileSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophyloreconcileSeries::to_string(self : BiophyloreconcileSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloreconcileMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_reconcile_make_matrix(rows : Int, cols : Int, val : Double) -> BiophyloreconcileMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_reconcile_matrix_identity(n : Int) -> BiophyloreconcileMatrix {
  let m = bio_phylo_reconcile_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophyloreconcileMatrix::get(self : BiophyloreconcileMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophyloreconcileMatrix::transpose(self : BiophyloreconcileMatrix) -> BiophyloreconcileMatrix {
  let result = bio_phylo_reconcile_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophyloreconcileMatrix::add(self : BiophyloreconcileMatrix, other : BiophyloreconcileMatrix) -> BiophyloreconcileMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_reconcile_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophyloreconcileMatrix::scale(self : BiophyloreconcileMatrix, s : Double) -> BiophyloreconcileMatrix {
  let result = bio_phylo_reconcile_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophyloreconcileMatrix::multiply(self : BiophyloreconcileMatrix, other : BiophyloreconcileMatrix) -> BiophyloreconcileMatrix {
  if self.cols != other.rows { return bio_phylo_reconcile_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_reconcile_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiophyloreconcileMatrix::trace(self : BiophyloreconcileMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophyloreconcileMatrix::det(self : BiophyloreconcileMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophyloreconcileMatrix::norm(self : BiophyloreconcileMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophyloreconcileMatrix::to_string(self : BiophyloreconcileMatrix) -> String {
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

pub(all) struct BiophyloreconcileVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_reconcile_make_vector(comps : Array[Double]) -> BiophyloreconcileVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_reconcile_vector_zero(dim : Int) -> BiophyloreconcileVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophyloreconcileVector::add(self : BiophyloreconcileVector, other : BiophyloreconcileVector) -> BiophyloreconcileVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloreconcileVector::sub(self : BiophyloreconcileVector, other : BiophyloreconcileVector) -> BiophyloreconcileVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloreconcileVector::scale(self : BiophyloreconcileVector, s : Double) -> BiophyloreconcileVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophyloreconcileVector::dot(self : BiophyloreconcileVector, other : BiophyloreconcileVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophyloreconcileVector::norm(self : BiophyloreconcileVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophyloreconcileVector::normalize(self : BiophyloreconcileVector) -> BiophyloreconcileVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloreconcileVector::dist(self : BiophyloreconcileVector, other : BiophyloreconcileVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophyloreconcileVector::to_string(self : BiophyloreconcileVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_reconcile_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_phylo_reconcile_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_phylo_reconcile_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_phylo_reconcile_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_phylo_reconcile_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_phylo_reconcile_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_phylo_reconcile_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_phylo_reconcile_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_phylo_reconcile_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_phylo_reconcile_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_phylo_reconcile_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_phylo_reconcile_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_phylo_reconcile_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_phylo_reconcile_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_phylo_reconcile_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_phylo_reconcile_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_phylo_reconcile_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_phylo_reconcile_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_phylo_reconcile_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_phylo_reconcile_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_phylo_reconcile_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_phylo_reconcile_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_phylo_reconcile_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_phylo_reconcile_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_phylo_reconcile_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_phylo_reconcile_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_phylo_reconcile_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_phylo_reconcile_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_phylo_reconcile_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiophyloreconcileFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_frame_make(size : Int) -> BiophyloreconcileFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_frame_len(s : BiophyloreconcileFrame) -> Int { s.size }

pub fn bio_phylo_reconcile_frame_get(s : BiophyloreconcileFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_frame_set(s : BiophyloreconcileFrame, i : Int, v : Double) -> BiophyloreconcileFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_frame_sum(s : BiophyloreconcileFrame) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_frame_mean(s : BiophyloreconcileFrame) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_frame_scale(s : BiophyloreconcileFrame, f : Double) -> BiophyloreconcileFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_frame_add(a : BiophyloreconcileFrame, b : BiophyloreconcileFrame) -> BiophyloreconcileFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_frame_copy(s : BiophyloreconcileFrame) -> BiophyloreconcileFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_frame_fill(s : BiophyloreconcileFrame, v : Double) -> BiophyloreconcileFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_frame_min(s : BiophyloreconcileFrame) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_frame_max(s : BiophyloreconcileFrame) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_frame_to_string(s : BiophyloreconcileFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_table_make(size : Int) -> BiophyloreconcileTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_table_len(s : BiophyloreconcileTable) -> Int { s.size }

pub fn bio_phylo_reconcile_table_get(s : BiophyloreconcileTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_table_set(s : BiophyloreconcileTable, i : Int, v : Double) -> BiophyloreconcileTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_table_sum(s : BiophyloreconcileTable) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_table_mean(s : BiophyloreconcileTable) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_table_scale(s : BiophyloreconcileTable, f : Double) -> BiophyloreconcileTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_table_add(a : BiophyloreconcileTable, b : BiophyloreconcileTable) -> BiophyloreconcileTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_table_copy(s : BiophyloreconcileTable) -> BiophyloreconcileTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_table_fill(s : BiophyloreconcileTable, v : Double) -> BiophyloreconcileTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_table_min(s : BiophyloreconcileTable) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_table_max(s : BiophyloreconcileTable) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_table_to_string(s : BiophyloreconcileTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_graphn_make(size : Int) -> BiophyloreconcileGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_graphn_len(s : BiophyloreconcileGraphN) -> Int { s.size }

pub fn bio_phylo_reconcile_graphn_get(s : BiophyloreconcileGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_graphn_set(s : BiophyloreconcileGraphN, i : Int, v : Double) -> BiophyloreconcileGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_graphn_sum(s : BiophyloreconcileGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_graphn_mean(s : BiophyloreconcileGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_graphn_scale(s : BiophyloreconcileGraphN, f : Double) -> BiophyloreconcileGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_graphn_add(a : BiophyloreconcileGraphN, b : BiophyloreconcileGraphN) -> BiophyloreconcileGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_graphn_copy(s : BiophyloreconcileGraphN) -> BiophyloreconcileGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_graphn_fill(s : BiophyloreconcileGraphN, v : Double) -> BiophyloreconcileGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_graphn_min(s : BiophyloreconcileGraphN) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_graphn_max(s : BiophyloreconcileGraphN) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_graphn_to_string(s : BiophyloreconcileGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_node_make(size : Int) -> BiophyloreconcileNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_node_len(s : BiophyloreconcileNode) -> Int { s.size }

pub fn bio_phylo_reconcile_node_get(s : BiophyloreconcileNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_node_set(s : BiophyloreconcileNode, i : Int, v : Double) -> BiophyloreconcileNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_node_sum(s : BiophyloreconcileNode) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_node_mean(s : BiophyloreconcileNode) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_node_scale(s : BiophyloreconcileNode, f : Double) -> BiophyloreconcileNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_node_add(a : BiophyloreconcileNode, b : BiophyloreconcileNode) -> BiophyloreconcileNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_node_copy(s : BiophyloreconcileNode) -> BiophyloreconcileNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_node_fill(s : BiophyloreconcileNode, v : Double) -> BiophyloreconcileNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_node_min(s : BiophyloreconcileNode) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_node_max(s : BiophyloreconcileNode) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_node_to_string(s : BiophyloreconcileNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_edge_make(size : Int) -> BiophyloreconcileEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_edge_len(s : BiophyloreconcileEdge) -> Int { s.size }

pub fn bio_phylo_reconcile_edge_get(s : BiophyloreconcileEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_edge_set(s : BiophyloreconcileEdge, i : Int, v : Double) -> BiophyloreconcileEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_edge_sum(s : BiophyloreconcileEdge) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_edge_mean(s : BiophyloreconcileEdge) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_edge_scale(s : BiophyloreconcileEdge, f : Double) -> BiophyloreconcileEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_edge_add(a : BiophyloreconcileEdge, b : BiophyloreconcileEdge) -> BiophyloreconcileEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_edge_copy(s : BiophyloreconcileEdge) -> BiophyloreconcileEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_edge_fill(s : BiophyloreconcileEdge, v : Double) -> BiophyloreconcileEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_edge_min(s : BiophyloreconcileEdge) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_edge_max(s : BiophyloreconcileEdge) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_edge_to_string(s : BiophyloreconcileEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcilePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_path_make(size : Int) -> BiophyloreconcilePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_path_len(s : BiophyloreconcilePath) -> Int { s.size }

pub fn bio_phylo_reconcile_path_get(s : BiophyloreconcilePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_path_set(s : BiophyloreconcilePath, i : Int, v : Double) -> BiophyloreconcilePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_path_sum(s : BiophyloreconcilePath) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_path_mean(s : BiophyloreconcilePath) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_path_scale(s : BiophyloreconcilePath, f : Double) -> BiophyloreconcilePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_path_add(a : BiophyloreconcilePath, b : BiophyloreconcilePath) -> BiophyloreconcilePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_path_copy(s : BiophyloreconcilePath) -> BiophyloreconcilePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_path_fill(s : BiophyloreconcilePath, v : Double) -> BiophyloreconcilePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_path_min(s : BiophyloreconcilePath) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_path_max(s : BiophyloreconcilePath) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_path_to_string(s : BiophyloreconcilePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_cluster_make(size : Int) -> BiophyloreconcileCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_cluster_len(s : BiophyloreconcileCluster) -> Int { s.size }

pub fn bio_phylo_reconcile_cluster_get(s : BiophyloreconcileCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_cluster_set(s : BiophyloreconcileCluster, i : Int, v : Double) -> BiophyloreconcileCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cluster_sum(s : BiophyloreconcileCluster) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_cluster_mean(s : BiophyloreconcileCluster) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_cluster_scale(s : BiophyloreconcileCluster, f : Double) -> BiophyloreconcileCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cluster_add(a : BiophyloreconcileCluster, b : BiophyloreconcileCluster) -> BiophyloreconcileCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_cluster_copy(s : BiophyloreconcileCluster) -> BiophyloreconcileCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cluster_fill(s : BiophyloreconcileCluster, v : Double) -> BiophyloreconcileCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cluster_min(s : BiophyloreconcileCluster) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_cluster_max(s : BiophyloreconcileCluster) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_cluster_to_string(s : BiophyloreconcileCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_model_make(size : Int) -> BiophyloreconcileModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_model_len(s : BiophyloreconcileModel) -> Int { s.size }

pub fn bio_phylo_reconcile_model_get(s : BiophyloreconcileModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_model_set(s : BiophyloreconcileModel, i : Int, v : Double) -> BiophyloreconcileModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_model_sum(s : BiophyloreconcileModel) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_model_mean(s : BiophyloreconcileModel) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_model_scale(s : BiophyloreconcileModel, f : Double) -> BiophyloreconcileModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_model_add(a : BiophyloreconcileModel, b : BiophyloreconcileModel) -> BiophyloreconcileModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_model_copy(s : BiophyloreconcileModel) -> BiophyloreconcileModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_model_fill(s : BiophyloreconcileModel, v : Double) -> BiophyloreconcileModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_model_min(s : BiophyloreconcileModel) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_model_max(s : BiophyloreconcileModel) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_model_to_string(s : BiophyloreconcileModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_layer_make(size : Int) -> BiophyloreconcileLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_layer_len(s : BiophyloreconcileLayer) -> Int { s.size }

pub fn bio_phylo_reconcile_layer_get(s : BiophyloreconcileLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_layer_set(s : BiophyloreconcileLayer, i : Int, v : Double) -> BiophyloreconcileLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_layer_sum(s : BiophyloreconcileLayer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_layer_mean(s : BiophyloreconcileLayer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_layer_scale(s : BiophyloreconcileLayer, f : Double) -> BiophyloreconcileLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_layer_add(a : BiophyloreconcileLayer, b : BiophyloreconcileLayer) -> BiophyloreconcileLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_layer_copy(s : BiophyloreconcileLayer) -> BiophyloreconcileLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_layer_fill(s : BiophyloreconcileLayer, v : Double) -> BiophyloreconcileLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_layer_min(s : BiophyloreconcileLayer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_layer_max(s : BiophyloreconcileLayer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_layer_to_string(s : BiophyloreconcileLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_buffer_make(size : Int) -> BiophyloreconcileBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_buffer_len(s : BiophyloreconcileBuffer) -> Int { s.size }

pub fn bio_phylo_reconcile_buffer_get(s : BiophyloreconcileBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_buffer_set(s : BiophyloreconcileBuffer, i : Int, v : Double) -> BiophyloreconcileBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_buffer_sum(s : BiophyloreconcileBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_buffer_mean(s : BiophyloreconcileBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_buffer_scale(s : BiophyloreconcileBuffer, f : Double) -> BiophyloreconcileBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_buffer_add(a : BiophyloreconcileBuffer, b : BiophyloreconcileBuffer) -> BiophyloreconcileBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_buffer_copy(s : BiophyloreconcileBuffer) -> BiophyloreconcileBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_buffer_fill(s : BiophyloreconcileBuffer, v : Double) -> BiophyloreconcileBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_buffer_min(s : BiophyloreconcileBuffer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_buffer_max(s : BiophyloreconcileBuffer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_buffer_to_string(s : BiophyloreconcileBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_cursor_make(size : Int) -> BiophyloreconcileCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_cursor_len(s : BiophyloreconcileCursor) -> Int { s.size }

pub fn bio_phylo_reconcile_cursor_get(s : BiophyloreconcileCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_cursor_set(s : BiophyloreconcileCursor, i : Int, v : Double) -> BiophyloreconcileCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cursor_sum(s : BiophyloreconcileCursor) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_cursor_mean(s : BiophyloreconcileCursor) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_cursor_scale(s : BiophyloreconcileCursor, f : Double) -> BiophyloreconcileCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cursor_add(a : BiophyloreconcileCursor, b : BiophyloreconcileCursor) -> BiophyloreconcileCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_cursor_copy(s : BiophyloreconcileCursor) -> BiophyloreconcileCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cursor_fill(s : BiophyloreconcileCursor, v : Double) -> BiophyloreconcileCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_cursor_min(s : BiophyloreconcileCursor) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_cursor_max(s : BiophyloreconcileCursor) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_cursor_to_string(s : BiophyloreconcileCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_view_make(size : Int) -> BiophyloreconcileView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_view_len(s : BiophyloreconcileView) -> Int { s.size }

pub fn bio_phylo_reconcile_view_get(s : BiophyloreconcileView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_view_set(s : BiophyloreconcileView, i : Int, v : Double) -> BiophyloreconcileView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_view_sum(s : BiophyloreconcileView) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_view_mean(s : BiophyloreconcileView) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_view_scale(s : BiophyloreconcileView, f : Double) -> BiophyloreconcileView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_view_add(a : BiophyloreconcileView, b : BiophyloreconcileView) -> BiophyloreconcileView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_view_copy(s : BiophyloreconcileView) -> BiophyloreconcileView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_view_fill(s : BiophyloreconcileView, v : Double) -> BiophyloreconcileView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_view_min(s : BiophyloreconcileView) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_view_max(s : BiophyloreconcileView) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_view_to_string(s : BiophyloreconcileView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_range_make(size : Int) -> BiophyloreconcileRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_range_len(s : BiophyloreconcileRange) -> Int { s.size }

pub fn bio_phylo_reconcile_range_get(s : BiophyloreconcileRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_range_set(s : BiophyloreconcileRange, i : Int, v : Double) -> BiophyloreconcileRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_range_sum(s : BiophyloreconcileRange) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_range_mean(s : BiophyloreconcileRange) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_range_scale(s : BiophyloreconcileRange, f : Double) -> BiophyloreconcileRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_range_add(a : BiophyloreconcileRange, b : BiophyloreconcileRange) -> BiophyloreconcileRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_range_copy(s : BiophyloreconcileRange) -> BiophyloreconcileRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_range_fill(s : BiophyloreconcileRange, v : Double) -> BiophyloreconcileRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_range_min(s : BiophyloreconcileRange) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_range_max(s : BiophyloreconcileRange) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_range_to_string(s : BiophyloreconcileRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloreconcileSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_reconcile_slice_make(size : Int) -> BiophyloreconcileSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_reconcile_slice_len(s : BiophyloreconcileSlice) -> Int { s.size }

pub fn bio_phylo_reconcile_slice_get(s : BiophyloreconcileSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_reconcile_slice_set(s : BiophyloreconcileSlice, i : Int, v : Double) -> BiophyloreconcileSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_slice_sum(s : BiophyloreconcileSlice) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_reconcile_slice_mean(s : BiophyloreconcileSlice) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_reconcile_slice_scale(s : BiophyloreconcileSlice, f : Double) -> BiophyloreconcileSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_slice_add(a : BiophyloreconcileSlice, b : BiophyloreconcileSlice) -> BiophyloreconcileSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_reconcile_slice_copy(s : BiophyloreconcileSlice) -> BiophyloreconcileSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_slice_fill(s : BiophyloreconcileSlice, v : Double) -> BiophyloreconcileSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_reconcile_slice_min(s : BiophyloreconcileSlice) -> Double { @_common.min(s.data) }

pub fn bio_phylo_reconcile_slice_max(s : BiophyloreconcileSlice) -> Double { @_common.max(s.data) }

pub fn bio_phylo_reconcile_slice_to_string(s : BiophyloreconcileSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

