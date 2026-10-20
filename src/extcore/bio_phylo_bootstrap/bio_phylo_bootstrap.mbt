///===
/// extcore/bio_phylo_bootstrap

pub(all) struct BiophylobootstrapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_bootstrap_make_point(x : Double, y : Double) -> BiophylobootstrapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_bootstrap_make_point3(x : Double, y : Double, z : Double) -> BiophylobootstrapPoint {
  { x, y, z, label: 0 }
}

pub fn BiophylobootstrapPoint::x(self : BiophylobootstrapPoint) -> Double { self.x }

pub fn BiophylobootstrapPoint::y(self : BiophylobootstrapPoint) -> Double { self.y }

pub fn BiophylobootstrapPoint::z(self : BiophylobootstrapPoint) -> Double { self.z }

pub fn BiophylobootstrapPoint::label(self : BiophylobootstrapPoint) -> Int { self.label }

pub fn BiophylobootstrapPoint::dist(self : BiophylobootstrapPoint, other : BiophylobootstrapPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophylobootstrapPoint::add(self : BiophylobootstrapPoint, other : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophylobootstrapPoint::sub(self : BiophylobootstrapPoint, other : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophylobootstrapPoint::scale(self : BiophylobootstrapPoint, s : Double) -> BiophylobootstrapPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophylobootstrapPoint::dot(self : BiophylobootstrapPoint, other : BiophylobootstrapPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophylobootstrapPoint::cross(self : BiophylobootstrapPoint, other : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophylobootstrapPoint::norm(self : BiophylobootstrapPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophylobootstrapPoint::normalize(self : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylobootstrapPoint::negate(self : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophylobootstrapPoint::mid(self : BiophylobootstrapPoint, other : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophylobootstrapPoint::lerp(self : BiophylobootstrapPoint, other : BiophylobootstrapPoint, t : Double) -> BiophylobootstrapPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophylobootstrapPoint::to_string(self : BiophylobootstrapPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophylobootstrapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_bootstrap_make_series(vals : Array[Double], name : String) -> BiophylobootstrapSeries {
  { vals, name, meta: 0 }
}

pub fn BiophylobootstrapSeries::len(self : BiophylobootstrapSeries) -> Int { self.vals.length() }

pub fn BiophylobootstrapSeries::sum(self : BiophylobootstrapSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophylobootstrapSeries::mean(self : BiophylobootstrapSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophylobootstrapSeries::min(self : BiophylobootstrapSeries) -> Double { @_common.min(self.vals) }

pub fn BiophylobootstrapSeries::max(self : BiophylobootstrapSeries) -> Double { @_common.max(self.vals) }

pub fn BiophylobootstrapSeries::range(self : BiophylobootstrapSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophylobootstrapSeries::variance(self : BiophylobootstrapSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophylobootstrapSeries::std(self : BiophylobootstrapSeries) -> Double { @_common.std(self.vals) }

pub fn BiophylobootstrapSeries::median(self : BiophylobootstrapSeries) -> Double { @_common.median(self.vals) }

pub fn BiophylobootstrapSeries::scale(self : BiophylobootstrapSeries, f : Double) -> BiophylobootstrapSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophylobootstrapSeries::add(self : BiophylobootstrapSeries, other : BiophylobootstrapSeries) -> BiophylobootstrapSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophylobootstrapSeries::sub(self : BiophylobootstrapSeries, other : BiophylobootstrapSeries) -> BiophylobootstrapSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophylobootstrapSeries::normalize(self : BiophylobootstrapSeries) -> BiophylobootstrapSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophylobootstrapSeries::cumsum(self : BiophylobootstrapSeries) -> BiophylobootstrapSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophylobootstrapSeries::to_string(self : BiophylobootstrapSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylobootstrapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_bootstrap_make_matrix(rows : Int, cols : Int, val : Double) -> BiophylobootstrapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_bootstrap_matrix_identity(n : Int) -> BiophylobootstrapMatrix {
  let m = bio_phylo_bootstrap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophylobootstrapMatrix::get(self : BiophylobootstrapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophylobootstrapMatrix::transpose(self : BiophylobootstrapMatrix) -> BiophylobootstrapMatrix {
  let result = bio_phylo_bootstrap_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophylobootstrapMatrix::add(self : BiophylobootstrapMatrix, other : BiophylobootstrapMatrix) -> BiophylobootstrapMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_bootstrap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophylobootstrapMatrix::scale(self : BiophylobootstrapMatrix, s : Double) -> BiophylobootstrapMatrix {
  let result = bio_phylo_bootstrap_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophylobootstrapMatrix::multiply(self : BiophylobootstrapMatrix, other : BiophylobootstrapMatrix) -> BiophylobootstrapMatrix {
  if self.cols != other.rows { return bio_phylo_bootstrap_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_bootstrap_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiophylobootstrapMatrix::trace(self : BiophylobootstrapMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophylobootstrapMatrix::det(self : BiophylobootstrapMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophylobootstrapMatrix::norm(self : BiophylobootstrapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophylobootstrapMatrix::to_string(self : BiophylobootstrapMatrix) -> String {
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

pub(all) struct BiophylobootstrapVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_bootstrap_make_vector(comps : Array[Double]) -> BiophylobootstrapVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_bootstrap_vector_zero(dim : Int) -> BiophylobootstrapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophylobootstrapVector::add(self : BiophylobootstrapVector, other : BiophylobootstrapVector) -> BiophylobootstrapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylobootstrapVector::sub(self : BiophylobootstrapVector, other : BiophylobootstrapVector) -> BiophylobootstrapVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylobootstrapVector::scale(self : BiophylobootstrapVector, s : Double) -> BiophylobootstrapVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophylobootstrapVector::dot(self : BiophylobootstrapVector, other : BiophylobootstrapVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophylobootstrapVector::norm(self : BiophylobootstrapVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophylobootstrapVector::normalize(self : BiophylobootstrapVector) -> BiophylobootstrapVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylobootstrapVector::dist(self : BiophylobootstrapVector, other : BiophylobootstrapVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophylobootstrapVector::to_string(self : BiophylobootstrapVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_bootstrap_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_phylo_bootstrap_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_phylo_bootstrap_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_phylo_bootstrap_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_phylo_bootstrap_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_phylo_bootstrap_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_phylo_bootstrap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_phylo_bootstrap_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_phylo_bootstrap_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_phylo_bootstrap_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_phylo_bootstrap_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_phylo_bootstrap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_phylo_bootstrap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_phylo_bootstrap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_phylo_bootstrap_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_phylo_bootstrap_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_phylo_bootstrap_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_phylo_bootstrap_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_phylo_bootstrap_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_phylo_bootstrap_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_phylo_bootstrap_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_phylo_bootstrap_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_phylo_bootstrap_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_phylo_bootstrap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_phylo_bootstrap_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_phylo_bootstrap_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_phylo_bootstrap_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_phylo_bootstrap_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_phylo_bootstrap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiophylobootstrapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_frame_make(size : Int) -> BiophylobootstrapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_frame_len(s : BiophylobootstrapFrame) -> Int { s.size }

pub fn bio_phylo_bootstrap_frame_get(s : BiophylobootstrapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_frame_set(s : BiophylobootstrapFrame, i : Int, v : Double) -> BiophylobootstrapFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_frame_sum(s : BiophylobootstrapFrame) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bootstrap_frame_mean(s : BiophylobootstrapFrame) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bootstrap_frame_scale(s : BiophylobootstrapFrame, f : Double) -> BiophylobootstrapFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_frame_add(a : BiophylobootstrapFrame, b : BiophylobootstrapFrame) -> BiophylobootstrapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bootstrap_frame_copy(s : BiophylobootstrapFrame) -> BiophylobootstrapFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_frame_fill(s : BiophylobootstrapFrame, v : Double) -> BiophylobootstrapFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_frame_min(s : BiophylobootstrapFrame) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bootstrap_frame_max(s : BiophylobootstrapFrame) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bootstrap_frame_to_string(s : BiophylobootstrapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_table_make(size : Int) -> BiophylobootstrapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_table_len(s : BiophylobootstrapTable) -> Int { s.size }

pub fn bio_phylo_bootstrap_table_get(s : BiophylobootstrapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_table_set(s : BiophylobootstrapTable, i : Int, v : Double) -> BiophylobootstrapTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_table_sum(s : BiophylobootstrapTable) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bootstrap_table_mean(s : BiophylobootstrapTable) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bootstrap_table_scale(s : BiophylobootstrapTable, f : Double) -> BiophylobootstrapTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_table_add(a : BiophylobootstrapTable, b : BiophylobootstrapTable) -> BiophylobootstrapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bootstrap_table_copy(s : BiophylobootstrapTable) -> BiophylobootstrapTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_table_fill(s : BiophylobootstrapTable, v : Double) -> BiophylobootstrapTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_table_min(s : BiophylobootstrapTable) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bootstrap_table_max(s : BiophylobootstrapTable) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bootstrap_table_to_string(s : BiophylobootstrapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_graphn_make(size : Int) -> BiophylobootstrapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_graphn_len(s : BiophylobootstrapGraphN) -> Int { s.size }

pub fn bio_phylo_bootstrap_graphn_get(s : BiophylobootstrapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_graphn_set(s : BiophylobootstrapGraphN, i : Int, v : Double) -> BiophylobootstrapGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_graphn_sum(s : BiophylobootstrapGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bootstrap_graphn_mean(s : BiophylobootstrapGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bootstrap_graphn_scale(s : BiophylobootstrapGraphN, f : Double) -> BiophylobootstrapGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_graphn_add(a : BiophylobootstrapGraphN, b : BiophylobootstrapGraphN) -> BiophylobootstrapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bootstrap_graphn_copy(s : BiophylobootstrapGraphN) -> BiophylobootstrapGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_graphn_fill(s : BiophylobootstrapGraphN, v : Double) -> BiophylobootstrapGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_graphn_min(s : BiophylobootstrapGraphN) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bootstrap_graphn_max(s : BiophylobootstrapGraphN) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bootstrap_graphn_to_string(s : BiophylobootstrapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_node_make(size : Int) -> BiophylobootstrapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_node_len(s : BiophylobootstrapNode) -> Int { s.size }

pub fn bio_phylo_bootstrap_node_get(s : BiophylobootstrapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_node_set(s : BiophylobootstrapNode, i : Int, v : Double) -> BiophylobootstrapNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_node_sum(s : BiophylobootstrapNode) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bootstrap_node_mean(s : BiophylobootstrapNode) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bootstrap_node_scale(s : BiophylobootstrapNode, f : Double) -> BiophylobootstrapNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_node_add(a : BiophylobootstrapNode, b : BiophylobootstrapNode) -> BiophylobootstrapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bootstrap_node_copy(s : BiophylobootstrapNode) -> BiophylobootstrapNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_node_fill(s : BiophylobootstrapNode, v : Double) -> BiophylobootstrapNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_node_min(s : BiophylobootstrapNode) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bootstrap_node_max(s : BiophylobootstrapNode) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bootstrap_node_to_string(s : BiophylobootstrapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_edge_make(size : Int) -> BiophylobootstrapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_edge_len(s : BiophylobootstrapEdge) -> Int { s.size }

pub fn bio_phylo_bootstrap_edge_get(s : BiophylobootstrapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_edge_set(s : BiophylobootstrapEdge, i : Int, v : Double) -> BiophylobootstrapEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_edge_sum(s : BiophylobootstrapEdge) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bootstrap_edge_mean(s : BiophylobootstrapEdge) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bootstrap_edge_scale(s : BiophylobootstrapEdge, f : Double) -> BiophylobootstrapEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_edge_add(a : BiophylobootstrapEdge, b : BiophylobootstrapEdge) -> BiophylobootstrapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bootstrap_edge_copy(s : BiophylobootstrapEdge) -> BiophylobootstrapEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_edge_fill(s : BiophylobootstrapEdge, v : Double) -> BiophylobootstrapEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_edge_min(s : BiophylobootstrapEdge) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bootstrap_edge_max(s : BiophylobootstrapEdge) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bootstrap_edge_to_string(s : BiophylobootstrapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_path_make(size : Int) -> BiophylobootstrapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_path_len(s : BiophylobootstrapPath) -> Int { s.size }

pub fn bio_phylo_bootstrap_path_get(s : BiophylobootstrapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_path_set(s : BiophylobootstrapPath, i : Int, v : Double) -> BiophylobootstrapPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_path_sum(s : BiophylobootstrapPath) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bootstrap_path_mean(s : BiophylobootstrapPath) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bootstrap_path_scale(s : BiophylobootstrapPath, f : Double) -> BiophylobootstrapPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_path_add(a : BiophylobootstrapPath, b : BiophylobootstrapPath) -> BiophylobootstrapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bootstrap_path_copy(s : BiophylobootstrapPath) -> BiophylobootstrapPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_path_fill(s : BiophylobootstrapPath, v : Double) -> BiophylobootstrapPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_path_min(s : BiophylobootstrapPath) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bootstrap_path_max(s : BiophylobootstrapPath) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bootstrap_path_to_string(s : BiophylobootstrapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_cluster_make(size : Int) -> BiophylobootstrapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_cluster_len(s : BiophylobootstrapCluster) -> Int { s.size }

pub fn bio_phylo_bootstrap_cluster_get(s : BiophylobootstrapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_cluster_set(s : BiophylobootstrapCluster, i : Int, v : Double) -> BiophylobootstrapCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_cluster_sum(s : BiophylobootstrapCluster) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bootstrap_cluster_mean(s : BiophylobootstrapCluster) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bootstrap_cluster_scale(s : BiophylobootstrapCluster, f : Double) -> BiophylobootstrapCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_cluster_add(a : BiophylobootstrapCluster, b : BiophylobootstrapCluster) -> BiophylobootstrapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bootstrap_cluster_copy(s : BiophylobootstrapCluster) -> BiophylobootstrapCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_cluster_fill(s : BiophylobootstrapCluster, v : Double) -> BiophylobootstrapCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_cluster_min(s : BiophylobootstrapCluster) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bootstrap_cluster_max(s : BiophylobootstrapCluster) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bootstrap_cluster_to_string(s : BiophylobootstrapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_model_make(size : Int) -> BiophylobootstrapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_model_len(s : BiophylobootstrapModel) -> Int { s.size }

pub fn bio_phylo_bootstrap_model_get(s : BiophylobootstrapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_model_set(s : BiophylobootstrapModel, i : Int, v : Double) -> BiophylobootstrapModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_model_sum(s : BiophylobootstrapModel) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bootstrap_model_mean(s : BiophylobootstrapModel) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bootstrap_model_scale(s : BiophylobootstrapModel, f : Double) -> BiophylobootstrapModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_model_add(a : BiophylobootstrapModel, b : BiophylobootstrapModel) -> BiophylobootstrapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bootstrap_model_copy(s : BiophylobootstrapModel) -> BiophylobootstrapModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_model_fill(s : BiophylobootstrapModel, v : Double) -> BiophylobootstrapModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_model_min(s : BiophylobootstrapModel) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bootstrap_model_max(s : BiophylobootstrapModel) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bootstrap_model_to_string(s : BiophylobootstrapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_layer_make(size : Int) -> BiophylobootstrapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_layer_len(s : BiophylobootstrapLayer) -> Int { s.size }

pub fn bio_phylo_bootstrap_layer_get(s : BiophylobootstrapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_layer_set(s : BiophylobootstrapLayer, i : Int, v : Double) -> BiophylobootstrapLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_layer_sum(s : BiophylobootstrapLayer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bootstrap_layer_mean(s : BiophylobootstrapLayer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bootstrap_layer_scale(s : BiophylobootstrapLayer, f : Double) -> BiophylobootstrapLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_layer_add(a : BiophylobootstrapLayer, b : BiophylobootstrapLayer) -> BiophylobootstrapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bootstrap_layer_copy(s : BiophylobootstrapLayer) -> BiophylobootstrapLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_layer_fill(s : BiophylobootstrapLayer, v : Double) -> BiophylobootstrapLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_layer_min(s : BiophylobootstrapLayer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bootstrap_layer_max(s : BiophylobootstrapLayer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bootstrap_layer_to_string(s : BiophylobootstrapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_buffer_make(size : Int) -> BiophylobootstrapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_buffer_len(s : BiophylobootstrapBuffer) -> Int { s.size }

pub fn bio_phylo_bootstrap_buffer_get(s : BiophylobootstrapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_buffer_set(s : BiophylobootstrapBuffer, i : Int, v : Double) -> BiophylobootstrapBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_buffer_sum(s : BiophylobootstrapBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bootstrap_buffer_mean(s : BiophylobootstrapBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bootstrap_buffer_scale(s : BiophylobootstrapBuffer, f : Double) -> BiophylobootstrapBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_buffer_add(a : BiophylobootstrapBuffer, b : BiophylobootstrapBuffer) -> BiophylobootstrapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bootstrap_buffer_copy(s : BiophylobootstrapBuffer) -> BiophylobootstrapBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_buffer_fill(s : BiophylobootstrapBuffer, v : Double) -> BiophylobootstrapBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_buffer_min(s : BiophylobootstrapBuffer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bootstrap_buffer_max(s : BiophylobootstrapBuffer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bootstrap_buffer_to_string(s : BiophylobootstrapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_cursor_make(size : Int) -> BiophylobootstrapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_cursor_len(s : BiophylobootstrapCursor) -> Int { s.size }

pub fn bio_phylo_bootstrap_cursor_get(s : BiophylobootstrapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_cursor_set(s : BiophylobootstrapCursor, i : Int, v : Double) -> BiophylobootstrapCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_cursor_sum(s : BiophylobootstrapCursor) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bootstrap_cursor_mean(s : BiophylobootstrapCursor) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bootstrap_cursor_scale(s : BiophylobootstrapCursor, f : Double) -> BiophylobootstrapCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_cursor_add(a : BiophylobootstrapCursor, b : BiophylobootstrapCursor) -> BiophylobootstrapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bootstrap_cursor_copy(s : BiophylobootstrapCursor) -> BiophylobootstrapCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_cursor_fill(s : BiophylobootstrapCursor, v : Double) -> BiophylobootstrapCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_cursor_min(s : BiophylobootstrapCursor) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bootstrap_cursor_max(s : BiophylobootstrapCursor) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bootstrap_cursor_to_string(s : BiophylobootstrapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_view_make(size : Int) -> BiophylobootstrapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_view_len(s : BiophylobootstrapView) -> Int { s.size }

pub fn bio_phylo_bootstrap_view_get(s : BiophylobootstrapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_view_set(s : BiophylobootstrapView, i : Int, v : Double) -> BiophylobootstrapView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_view_sum(s : BiophylobootstrapView) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bootstrap_view_mean(s : BiophylobootstrapView) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bootstrap_view_scale(s : BiophylobootstrapView, f : Double) -> BiophylobootstrapView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_view_add(a : BiophylobootstrapView, b : BiophylobootstrapView) -> BiophylobootstrapView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bootstrap_view_copy(s : BiophylobootstrapView) -> BiophylobootstrapView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_view_fill(s : BiophylobootstrapView, v : Double) -> BiophylobootstrapView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_view_min(s : BiophylobootstrapView) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bootstrap_view_max(s : BiophylobootstrapView) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bootstrap_view_to_string(s : BiophylobootstrapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_range_make(size : Int) -> BiophylobootstrapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_range_len(s : BiophylobootstrapRange) -> Int { s.size }

pub fn bio_phylo_bootstrap_range_get(s : BiophylobootstrapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_range_set(s : BiophylobootstrapRange, i : Int, v : Double) -> BiophylobootstrapRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_range_sum(s : BiophylobootstrapRange) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bootstrap_range_mean(s : BiophylobootstrapRange) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bootstrap_range_scale(s : BiophylobootstrapRange, f : Double) -> BiophylobootstrapRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_range_add(a : BiophylobootstrapRange, b : BiophylobootstrapRange) -> BiophylobootstrapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bootstrap_range_copy(s : BiophylobootstrapRange) -> BiophylobootstrapRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_range_fill(s : BiophylobootstrapRange, v : Double) -> BiophylobootstrapRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_range_min(s : BiophylobootstrapRange) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bootstrap_range_max(s : BiophylobootstrapRange) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bootstrap_range_to_string(s : BiophylobootstrapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_slice_make(size : Int) -> BiophylobootstrapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_slice_len(s : BiophylobootstrapSlice) -> Int { s.size }

pub fn bio_phylo_bootstrap_slice_get(s : BiophylobootstrapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_slice_set(s : BiophylobootstrapSlice, i : Int, v : Double) -> BiophylobootstrapSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_slice_sum(s : BiophylobootstrapSlice) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_bootstrap_slice_mean(s : BiophylobootstrapSlice) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_bootstrap_slice_scale(s : BiophylobootstrapSlice, f : Double) -> BiophylobootstrapSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_slice_add(a : BiophylobootstrapSlice, b : BiophylobootstrapSlice) -> BiophylobootstrapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_bootstrap_slice_copy(s : BiophylobootstrapSlice) -> BiophylobootstrapSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_slice_fill(s : BiophylobootstrapSlice, v : Double) -> BiophylobootstrapSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_bootstrap_slice_min(s : BiophylobootstrapSlice) -> Double { @_common.min(s.data) }

pub fn bio_phylo_bootstrap_slice_max(s : BiophylobootstrapSlice) -> Double { @_common.max(s.data) }

pub fn bio_phylo_bootstrap_slice_to_string(s : BiophylobootstrapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

