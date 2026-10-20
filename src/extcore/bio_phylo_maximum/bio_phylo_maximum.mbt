///===
/// extcore/bio_phylo_maximum

pub(all) struct BiophylomaximumPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_maximum_make_point(x : Double, y : Double) -> BiophylomaximumPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_maximum_make_point3(x : Double, y : Double, z : Double) -> BiophylomaximumPoint {
  { x, y, z, label: 0 }
}

pub fn BiophylomaximumPoint::x(self : BiophylomaximumPoint) -> Double { self.x }

pub fn BiophylomaximumPoint::y(self : BiophylomaximumPoint) -> Double { self.y }

pub fn BiophylomaximumPoint::z(self : BiophylomaximumPoint) -> Double { self.z }

pub fn BiophylomaximumPoint::label(self : BiophylomaximumPoint) -> Int { self.label }

pub fn BiophylomaximumPoint::dist(self : BiophylomaximumPoint, other : BiophylomaximumPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophylomaximumPoint::add(self : BiophylomaximumPoint, other : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophylomaximumPoint::sub(self : BiophylomaximumPoint, other : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophylomaximumPoint::scale(self : BiophylomaximumPoint, s : Double) -> BiophylomaximumPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophylomaximumPoint::dot(self : BiophylomaximumPoint, other : BiophylomaximumPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophylomaximumPoint::cross(self : BiophylomaximumPoint, other : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophylomaximumPoint::norm(self : BiophylomaximumPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophylomaximumPoint::normalize(self : BiophylomaximumPoint) -> BiophylomaximumPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylomaximumPoint::negate(self : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophylomaximumPoint::mid(self : BiophylomaximumPoint, other : BiophylomaximumPoint) -> BiophylomaximumPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophylomaximumPoint::lerp(self : BiophylomaximumPoint, other : BiophylomaximumPoint, t : Double) -> BiophylomaximumPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophylomaximumPoint::to_string(self : BiophylomaximumPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophylomaximumSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_maximum_make_series(vals : Array[Double], name : String) -> BiophylomaximumSeries {
  { vals, name, meta: 0 }
}

pub fn BiophylomaximumSeries::len(self : BiophylomaximumSeries) -> Int { self.vals.length() }

pub fn BiophylomaximumSeries::sum(self : BiophylomaximumSeries) -> Double { @_common.sum(self.vals) }

pub fn BiophylomaximumSeries::mean(self : BiophylomaximumSeries) -> Double { @_common.mean(self.vals) }

pub fn BiophylomaximumSeries::min(self : BiophylomaximumSeries) -> Double { @_common.min(self.vals) }

pub fn BiophylomaximumSeries::max(self : BiophylomaximumSeries) -> Double { @_common.max(self.vals) }

pub fn BiophylomaximumSeries::range(self : BiophylomaximumSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophylomaximumSeries::variance(self : BiophylomaximumSeries) -> Double { @_common.variance(self.vals) }

pub fn BiophylomaximumSeries::std(self : BiophylomaximumSeries) -> Double { @_common.std(self.vals) }

pub fn BiophylomaximumSeries::median(self : BiophylomaximumSeries) -> Double { @_common.median(self.vals) }

pub fn BiophylomaximumSeries::scale(self : BiophylomaximumSeries, f : Double) -> BiophylomaximumSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophylomaximumSeries::add(self : BiophylomaximumSeries, other : BiophylomaximumSeries) -> BiophylomaximumSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophylomaximumSeries::sub(self : BiophylomaximumSeries, other : BiophylomaximumSeries) -> BiophylomaximumSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophylomaximumSeries::normalize(self : BiophylomaximumSeries) -> BiophylomaximumSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophylomaximumSeries::cumsum(self : BiophylomaximumSeries) -> BiophylomaximumSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophylomaximumSeries::to_string(self : BiophylomaximumSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylomaximumMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_maximum_make_matrix(rows : Int, cols : Int, val : Double) -> BiophylomaximumMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_maximum_matrix_identity(n : Int) -> BiophylomaximumMatrix {
  let m = bio_phylo_maximum_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophylomaximumMatrix::get(self : BiophylomaximumMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophylomaximumMatrix::transpose(self : BiophylomaximumMatrix) -> BiophylomaximumMatrix {
  let result = bio_phylo_maximum_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophylomaximumMatrix::add(self : BiophylomaximumMatrix, other : BiophylomaximumMatrix) -> BiophylomaximumMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_maximum_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophylomaximumMatrix::scale(self : BiophylomaximumMatrix, s : Double) -> BiophylomaximumMatrix {
  let result = bio_phylo_maximum_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophylomaximumMatrix::multiply(self : BiophylomaximumMatrix, other : BiophylomaximumMatrix) -> BiophylomaximumMatrix {
  if self.cols != other.rows { return bio_phylo_maximum_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_maximum_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiophylomaximumMatrix::trace(self : BiophylomaximumMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophylomaximumMatrix::det(self : BiophylomaximumMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophylomaximumMatrix::norm(self : BiophylomaximumMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophylomaximumMatrix::to_string(self : BiophylomaximumMatrix) -> String {
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

pub(all) struct BiophylomaximumVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_maximum_make_vector(comps : Array[Double]) -> BiophylomaximumVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_maximum_vector_zero(dim : Int) -> BiophylomaximumVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophylomaximumVector::add(self : BiophylomaximumVector, other : BiophylomaximumVector) -> BiophylomaximumVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylomaximumVector::sub(self : BiophylomaximumVector, other : BiophylomaximumVector) -> BiophylomaximumVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophylomaximumVector::scale(self : BiophylomaximumVector, s : Double) -> BiophylomaximumVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophylomaximumVector::dot(self : BiophylomaximumVector, other : BiophylomaximumVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophylomaximumVector::norm(self : BiophylomaximumVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophylomaximumVector::normalize(self : BiophylomaximumVector) -> BiophylomaximumVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophylomaximumVector::dist(self : BiophylomaximumVector, other : BiophylomaximumVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophylomaximumVector::to_string(self : BiophylomaximumVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_maximum_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_phylo_maximum_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_phylo_maximum_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_phylo_maximum_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_phylo_maximum_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_phylo_maximum_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_phylo_maximum_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_phylo_maximum_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_phylo_maximum_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_phylo_maximum_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_phylo_maximum_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_phylo_maximum_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_phylo_maximum_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_phylo_maximum_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_phylo_maximum_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_phylo_maximum_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_phylo_maximum_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_phylo_maximum_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_phylo_maximum_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_phylo_maximum_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_phylo_maximum_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_phylo_maximum_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_phylo_maximum_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_phylo_maximum_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_phylo_maximum_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_phylo_maximum_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_phylo_maximum_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_phylo_maximum_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_phylo_maximum_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiophylomaximumFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_frame_make(size : Int) -> BiophylomaximumFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_frame_len(s : BiophylomaximumFrame) -> Int { s.size }

pub fn bio_phylo_maximum_frame_get(s : BiophylomaximumFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_frame_set(s : BiophylomaximumFrame, i : Int, v : Double) -> BiophylomaximumFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_frame_sum(s : BiophylomaximumFrame) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_frame_mean(s : BiophylomaximumFrame) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_frame_scale(s : BiophylomaximumFrame, f : Double) -> BiophylomaximumFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_frame_add(a : BiophylomaximumFrame, b : BiophylomaximumFrame) -> BiophylomaximumFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_maximum_frame_copy(s : BiophylomaximumFrame) -> BiophylomaximumFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_frame_fill(s : BiophylomaximumFrame, v : Double) -> BiophylomaximumFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_frame_min(s : BiophylomaximumFrame) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_frame_max(s : BiophylomaximumFrame) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_frame_to_string(s : BiophylomaximumFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_table_make(size : Int) -> BiophylomaximumTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_table_len(s : BiophylomaximumTable) -> Int { s.size }

pub fn bio_phylo_maximum_table_get(s : BiophylomaximumTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_table_set(s : BiophylomaximumTable, i : Int, v : Double) -> BiophylomaximumTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_table_sum(s : BiophylomaximumTable) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_table_mean(s : BiophylomaximumTable) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_table_scale(s : BiophylomaximumTable, f : Double) -> BiophylomaximumTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_table_add(a : BiophylomaximumTable, b : BiophylomaximumTable) -> BiophylomaximumTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_maximum_table_copy(s : BiophylomaximumTable) -> BiophylomaximumTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_table_fill(s : BiophylomaximumTable, v : Double) -> BiophylomaximumTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_table_min(s : BiophylomaximumTable) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_table_max(s : BiophylomaximumTable) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_table_to_string(s : BiophylomaximumTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_graphn_make(size : Int) -> BiophylomaximumGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_graphn_len(s : BiophylomaximumGraphN) -> Int { s.size }

pub fn bio_phylo_maximum_graphn_get(s : BiophylomaximumGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_graphn_set(s : BiophylomaximumGraphN, i : Int, v : Double) -> BiophylomaximumGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_graphn_sum(s : BiophylomaximumGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_graphn_mean(s : BiophylomaximumGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_graphn_scale(s : BiophylomaximumGraphN, f : Double) -> BiophylomaximumGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_graphn_add(a : BiophylomaximumGraphN, b : BiophylomaximumGraphN) -> BiophylomaximumGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_maximum_graphn_copy(s : BiophylomaximumGraphN) -> BiophylomaximumGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_graphn_fill(s : BiophylomaximumGraphN, v : Double) -> BiophylomaximumGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_graphn_min(s : BiophylomaximumGraphN) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_graphn_max(s : BiophylomaximumGraphN) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_graphn_to_string(s : BiophylomaximumGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_node_make(size : Int) -> BiophylomaximumNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_node_len(s : BiophylomaximumNode) -> Int { s.size }

pub fn bio_phylo_maximum_node_get(s : BiophylomaximumNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_node_set(s : BiophylomaximumNode, i : Int, v : Double) -> BiophylomaximumNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_node_sum(s : BiophylomaximumNode) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_node_mean(s : BiophylomaximumNode) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_node_scale(s : BiophylomaximumNode, f : Double) -> BiophylomaximumNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_node_add(a : BiophylomaximumNode, b : BiophylomaximumNode) -> BiophylomaximumNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_maximum_node_copy(s : BiophylomaximumNode) -> BiophylomaximumNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_node_fill(s : BiophylomaximumNode, v : Double) -> BiophylomaximumNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_node_min(s : BiophylomaximumNode) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_node_max(s : BiophylomaximumNode) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_node_to_string(s : BiophylomaximumNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_edge_make(size : Int) -> BiophylomaximumEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_edge_len(s : BiophylomaximumEdge) -> Int { s.size }

pub fn bio_phylo_maximum_edge_get(s : BiophylomaximumEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_edge_set(s : BiophylomaximumEdge, i : Int, v : Double) -> BiophylomaximumEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_edge_sum(s : BiophylomaximumEdge) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_edge_mean(s : BiophylomaximumEdge) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_edge_scale(s : BiophylomaximumEdge, f : Double) -> BiophylomaximumEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_edge_add(a : BiophylomaximumEdge, b : BiophylomaximumEdge) -> BiophylomaximumEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_maximum_edge_copy(s : BiophylomaximumEdge) -> BiophylomaximumEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_edge_fill(s : BiophylomaximumEdge, v : Double) -> BiophylomaximumEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_edge_min(s : BiophylomaximumEdge) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_edge_max(s : BiophylomaximumEdge) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_edge_to_string(s : BiophylomaximumEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_path_make(size : Int) -> BiophylomaximumPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_path_len(s : BiophylomaximumPath) -> Int { s.size }

pub fn bio_phylo_maximum_path_get(s : BiophylomaximumPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_path_set(s : BiophylomaximumPath, i : Int, v : Double) -> BiophylomaximumPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_path_sum(s : BiophylomaximumPath) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_path_mean(s : BiophylomaximumPath) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_path_scale(s : BiophylomaximumPath, f : Double) -> BiophylomaximumPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_path_add(a : BiophylomaximumPath, b : BiophylomaximumPath) -> BiophylomaximumPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_maximum_path_copy(s : BiophylomaximumPath) -> BiophylomaximumPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_path_fill(s : BiophylomaximumPath, v : Double) -> BiophylomaximumPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_path_min(s : BiophylomaximumPath) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_path_max(s : BiophylomaximumPath) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_path_to_string(s : BiophylomaximumPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_cluster_make(size : Int) -> BiophylomaximumCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_cluster_len(s : BiophylomaximumCluster) -> Int { s.size }

pub fn bio_phylo_maximum_cluster_get(s : BiophylomaximumCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_cluster_set(s : BiophylomaximumCluster, i : Int, v : Double) -> BiophylomaximumCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_cluster_sum(s : BiophylomaximumCluster) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_cluster_mean(s : BiophylomaximumCluster) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_cluster_scale(s : BiophylomaximumCluster, f : Double) -> BiophylomaximumCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_cluster_add(a : BiophylomaximumCluster, b : BiophylomaximumCluster) -> BiophylomaximumCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_maximum_cluster_copy(s : BiophylomaximumCluster) -> BiophylomaximumCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_cluster_fill(s : BiophylomaximumCluster, v : Double) -> BiophylomaximumCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_cluster_min(s : BiophylomaximumCluster) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_cluster_max(s : BiophylomaximumCluster) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_cluster_to_string(s : BiophylomaximumCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_model_make(size : Int) -> BiophylomaximumModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_model_len(s : BiophylomaximumModel) -> Int { s.size }

pub fn bio_phylo_maximum_model_get(s : BiophylomaximumModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_model_set(s : BiophylomaximumModel, i : Int, v : Double) -> BiophylomaximumModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_model_sum(s : BiophylomaximumModel) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_model_mean(s : BiophylomaximumModel) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_model_scale(s : BiophylomaximumModel, f : Double) -> BiophylomaximumModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_model_add(a : BiophylomaximumModel, b : BiophylomaximumModel) -> BiophylomaximumModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_maximum_model_copy(s : BiophylomaximumModel) -> BiophylomaximumModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_model_fill(s : BiophylomaximumModel, v : Double) -> BiophylomaximumModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_model_min(s : BiophylomaximumModel) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_model_max(s : BiophylomaximumModel) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_model_to_string(s : BiophylomaximumModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_layer_make(size : Int) -> BiophylomaximumLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_layer_len(s : BiophylomaximumLayer) -> Int { s.size }

pub fn bio_phylo_maximum_layer_get(s : BiophylomaximumLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_layer_set(s : BiophylomaximumLayer, i : Int, v : Double) -> BiophylomaximumLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_layer_sum(s : BiophylomaximumLayer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_layer_mean(s : BiophylomaximumLayer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_layer_scale(s : BiophylomaximumLayer, f : Double) -> BiophylomaximumLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_layer_add(a : BiophylomaximumLayer, b : BiophylomaximumLayer) -> BiophylomaximumLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_maximum_layer_copy(s : BiophylomaximumLayer) -> BiophylomaximumLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_layer_fill(s : BiophylomaximumLayer, v : Double) -> BiophylomaximumLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_layer_min(s : BiophylomaximumLayer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_layer_max(s : BiophylomaximumLayer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_layer_to_string(s : BiophylomaximumLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_buffer_make(size : Int) -> BiophylomaximumBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_buffer_len(s : BiophylomaximumBuffer) -> Int { s.size }

pub fn bio_phylo_maximum_buffer_get(s : BiophylomaximumBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_buffer_set(s : BiophylomaximumBuffer, i : Int, v : Double) -> BiophylomaximumBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_buffer_sum(s : BiophylomaximumBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_buffer_mean(s : BiophylomaximumBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_buffer_scale(s : BiophylomaximumBuffer, f : Double) -> BiophylomaximumBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_buffer_add(a : BiophylomaximumBuffer, b : BiophylomaximumBuffer) -> BiophylomaximumBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_maximum_buffer_copy(s : BiophylomaximumBuffer) -> BiophylomaximumBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_buffer_fill(s : BiophylomaximumBuffer, v : Double) -> BiophylomaximumBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_buffer_min(s : BiophylomaximumBuffer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_buffer_max(s : BiophylomaximumBuffer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_buffer_to_string(s : BiophylomaximumBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_cursor_make(size : Int) -> BiophylomaximumCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_cursor_len(s : BiophylomaximumCursor) -> Int { s.size }

pub fn bio_phylo_maximum_cursor_get(s : BiophylomaximumCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_cursor_set(s : BiophylomaximumCursor, i : Int, v : Double) -> BiophylomaximumCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_cursor_sum(s : BiophylomaximumCursor) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_cursor_mean(s : BiophylomaximumCursor) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_cursor_scale(s : BiophylomaximumCursor, f : Double) -> BiophylomaximumCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_cursor_add(a : BiophylomaximumCursor, b : BiophylomaximumCursor) -> BiophylomaximumCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_maximum_cursor_copy(s : BiophylomaximumCursor) -> BiophylomaximumCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_cursor_fill(s : BiophylomaximumCursor, v : Double) -> BiophylomaximumCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_cursor_min(s : BiophylomaximumCursor) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_cursor_max(s : BiophylomaximumCursor) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_cursor_to_string(s : BiophylomaximumCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_view_make(size : Int) -> BiophylomaximumView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_view_len(s : BiophylomaximumView) -> Int { s.size }

pub fn bio_phylo_maximum_view_get(s : BiophylomaximumView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_view_set(s : BiophylomaximumView, i : Int, v : Double) -> BiophylomaximumView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_view_sum(s : BiophylomaximumView) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_view_mean(s : BiophylomaximumView) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_view_scale(s : BiophylomaximumView, f : Double) -> BiophylomaximumView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_view_add(a : BiophylomaximumView, b : BiophylomaximumView) -> BiophylomaximumView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_maximum_view_copy(s : BiophylomaximumView) -> BiophylomaximumView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_view_fill(s : BiophylomaximumView, v : Double) -> BiophylomaximumView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_view_min(s : BiophylomaximumView) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_view_max(s : BiophylomaximumView) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_view_to_string(s : BiophylomaximumView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_range_make(size : Int) -> BiophylomaximumRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_range_len(s : BiophylomaximumRange) -> Int { s.size }

pub fn bio_phylo_maximum_range_get(s : BiophylomaximumRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_range_set(s : BiophylomaximumRange, i : Int, v : Double) -> BiophylomaximumRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_range_sum(s : BiophylomaximumRange) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_range_mean(s : BiophylomaximumRange) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_range_scale(s : BiophylomaximumRange, f : Double) -> BiophylomaximumRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_range_add(a : BiophylomaximumRange, b : BiophylomaximumRange) -> BiophylomaximumRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_maximum_range_copy(s : BiophylomaximumRange) -> BiophylomaximumRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_range_fill(s : BiophylomaximumRange, v : Double) -> BiophylomaximumRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_range_min(s : BiophylomaximumRange) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_range_max(s : BiophylomaximumRange) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_range_to_string(s : BiophylomaximumRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylomaximumSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_maximum_slice_make(size : Int) -> BiophylomaximumSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_maximum_slice_len(s : BiophylomaximumSlice) -> Int { s.size }

pub fn bio_phylo_maximum_slice_get(s : BiophylomaximumSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_maximum_slice_set(s : BiophylomaximumSlice, i : Int, v : Double) -> BiophylomaximumSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_slice_sum(s : BiophylomaximumSlice) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_maximum_slice_mean(s : BiophylomaximumSlice) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_maximum_slice_scale(s : BiophylomaximumSlice, f : Double) -> BiophylomaximumSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_slice_add(a : BiophylomaximumSlice, b : BiophylomaximumSlice) -> BiophylomaximumSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_maximum_slice_copy(s : BiophylomaximumSlice) -> BiophylomaximumSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_slice_fill(s : BiophylomaximumSlice, v : Double) -> BiophylomaximumSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_maximum_slice_min(s : BiophylomaximumSlice) -> Double { @_common.min(s.data) }

pub fn bio_phylo_maximum_slice_max(s : BiophylomaximumSlice) -> Double { @_common.max(s.data) }

pub fn bio_phylo_maximum_slice_to_string(s : BiophylomaximumSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

