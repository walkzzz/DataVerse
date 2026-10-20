///===
/// extcore/bio_phylo_parsimony

pub(all) struct BiophyloparsimonyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_parsimony_make_point(x : Double, y : Double) -> BiophyloparsimonyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_parsimony_make_point3(x : Double, y : Double, z : Double) -> BiophyloparsimonyPoint {
  { x, y, z, label: 0 }
}

pub fn BiophyloparsimonyPoint::x(self : BiophyloparsimonyPoint) -> Double { self.x }

pub fn BiophyloparsimonyPoint::y(self : BiophyloparsimonyPoint) -> Double { self.y }

pub fn BiophyloparsimonyPoint::z(self : BiophyloparsimonyPoint) -> Double { self.z }

pub fn BiophyloparsimonyPoint::label(self : BiophyloparsimonyPoint) -> Int { self.label }

pub fn BiophyloparsimonyPoint::dist(self : BiophyloparsimonyPoint, other : BiophyloparsimonyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiophyloparsimonyPoint::add(self : BiophyloparsimonyPoint, other : BiophyloparsimonyPoint) -> BiophyloparsimonyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiophyloparsimonyPoint::sub(self : BiophyloparsimonyPoint, other : BiophyloparsimonyPoint) -> BiophyloparsimonyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiophyloparsimonyPoint::scale(self : BiophyloparsimonyPoint, s : Double) -> BiophyloparsimonyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiophyloparsimonyPoint::dot(self : BiophyloparsimonyPoint, other : BiophyloparsimonyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiophyloparsimonyPoint::cross(self : BiophyloparsimonyPoint, other : BiophyloparsimonyPoint) -> BiophyloparsimonyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiophyloparsimonyPoint::norm(self : BiophyloparsimonyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiophyloparsimonyPoint::normalize(self : BiophyloparsimonyPoint) -> BiophyloparsimonyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloparsimonyPoint::negate(self : BiophyloparsimonyPoint) -> BiophyloparsimonyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiophyloparsimonyPoint::mid(self : BiophyloparsimonyPoint, other : BiophyloparsimonyPoint) -> BiophyloparsimonyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiophyloparsimonyPoint::lerp(self : BiophyloparsimonyPoint, other : BiophyloparsimonyPoint, t : Double) -> BiophyloparsimonyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiophyloparsimonyPoint::to_string(self : BiophyloparsimonyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiophyloparsimonySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_parsimony_make_series(vals : Array[Double], name : String) -> BiophyloparsimonySeries {
  { vals, name, meta: 0 }
}

pub fn BiophyloparsimonySeries::len(self : BiophyloparsimonySeries) -> Int { self.vals.length() }

pub fn BiophyloparsimonySeries::sum(self : BiophyloparsimonySeries) -> Double { @_common.sum(self.vals) }

pub fn BiophyloparsimonySeries::mean(self : BiophyloparsimonySeries) -> Double { @_common.mean(self.vals) }

pub fn BiophyloparsimonySeries::min(self : BiophyloparsimonySeries) -> Double { @_common.min(self.vals) }

pub fn BiophyloparsimonySeries::max(self : BiophyloparsimonySeries) -> Double { @_common.max(self.vals) }

pub fn BiophyloparsimonySeries::range(self : BiophyloparsimonySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiophyloparsimonySeries::variance(self : BiophyloparsimonySeries) -> Double { @_common.variance(self.vals) }

pub fn BiophyloparsimonySeries::std(self : BiophyloparsimonySeries) -> Double { @_common.std(self.vals) }

pub fn BiophyloparsimonySeries::median(self : BiophyloparsimonySeries) -> Double { @_common.median(self.vals) }

pub fn BiophyloparsimonySeries::scale(self : BiophyloparsimonySeries, f : Double) -> BiophyloparsimonySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiophyloparsimonySeries::add(self : BiophyloparsimonySeries, other : BiophyloparsimonySeries) -> BiophyloparsimonySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiophyloparsimonySeries::sub(self : BiophyloparsimonySeries, other : BiophyloparsimonySeries) -> BiophyloparsimonySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiophyloparsimonySeries::normalize(self : BiophyloparsimonySeries) -> BiophyloparsimonySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiophyloparsimonySeries::cumsum(self : BiophyloparsimonySeries) -> BiophyloparsimonySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiophyloparsimonySeries::to_string(self : BiophyloparsimonySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloparsimonyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_parsimony_make_matrix(rows : Int, cols : Int, val : Double) -> BiophyloparsimonyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_parsimony_matrix_identity(n : Int) -> BiophyloparsimonyMatrix {
  let m = bio_phylo_parsimony_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiophyloparsimonyMatrix::get(self : BiophyloparsimonyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiophyloparsimonyMatrix::transpose(self : BiophyloparsimonyMatrix) -> BiophyloparsimonyMatrix {
  let result = bio_phylo_parsimony_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiophyloparsimonyMatrix::add(self : BiophyloparsimonyMatrix, other : BiophyloparsimonyMatrix) -> BiophyloparsimonyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_phylo_parsimony_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiophyloparsimonyMatrix::scale(self : BiophyloparsimonyMatrix, s : Double) -> BiophyloparsimonyMatrix {
  let result = bio_phylo_parsimony_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiophyloparsimonyMatrix::multiply(self : BiophyloparsimonyMatrix, other : BiophyloparsimonyMatrix) -> BiophyloparsimonyMatrix {
  if self.cols != other.rows { return bio_phylo_parsimony_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_phylo_parsimony_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiophyloparsimonyMatrix::trace(self : BiophyloparsimonyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiophyloparsimonyMatrix::det(self : BiophyloparsimonyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiophyloparsimonyMatrix::norm(self : BiophyloparsimonyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiophyloparsimonyMatrix::to_string(self : BiophyloparsimonyMatrix) -> String {
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

pub(all) struct BiophyloparsimonyVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_parsimony_make_vector(comps : Array[Double]) -> BiophyloparsimonyVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_parsimony_vector_zero(dim : Int) -> BiophyloparsimonyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiophyloparsimonyVector::add(self : BiophyloparsimonyVector, other : BiophyloparsimonyVector) -> BiophyloparsimonyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloparsimonyVector::sub(self : BiophyloparsimonyVector, other : BiophyloparsimonyVector) -> BiophyloparsimonyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiophyloparsimonyVector::scale(self : BiophyloparsimonyVector, s : Double) -> BiophyloparsimonyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiophyloparsimonyVector::dot(self : BiophyloparsimonyVector, other : BiophyloparsimonyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiophyloparsimonyVector::norm(self : BiophyloparsimonyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiophyloparsimonyVector::normalize(self : BiophyloparsimonyVector) -> BiophyloparsimonyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiophyloparsimonyVector::dist(self : BiophyloparsimonyVector, other : BiophyloparsimonyVector) -> Double {
  self.sub(other).norm()
}

pub fn BiophyloparsimonyVector::to_string(self : BiophyloparsimonyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_parsimony_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_phylo_parsimony_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_phylo_parsimony_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_phylo_parsimony_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_phylo_parsimony_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_phylo_parsimony_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_phylo_parsimony_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_phylo_parsimony_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_phylo_parsimony_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_phylo_parsimony_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_phylo_parsimony_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_phylo_parsimony_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_phylo_parsimony_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_phylo_parsimony_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_phylo_parsimony_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_phylo_parsimony_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_phylo_parsimony_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_phylo_parsimony_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_phylo_parsimony_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_phylo_parsimony_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_phylo_parsimony_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_phylo_parsimony_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_phylo_parsimony_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_phylo_parsimony_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_phylo_parsimony_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_phylo_parsimony_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_phylo_parsimony_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_phylo_parsimony_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_phylo_parsimony_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiophyloparsimonyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_frame_make(size : Int) -> BiophyloparsimonyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_frame_len(s : BiophyloparsimonyFrame) -> Int { s.size }

pub fn bio_phylo_parsimony_frame_get(s : BiophyloparsimonyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_frame_set(s : BiophyloparsimonyFrame, i : Int, v : Double) -> BiophyloparsimonyFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_frame_sum(s : BiophyloparsimonyFrame) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_parsimony_frame_mean(s : BiophyloparsimonyFrame) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_parsimony_frame_scale(s : BiophyloparsimonyFrame, f : Double) -> BiophyloparsimonyFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_frame_add(a : BiophyloparsimonyFrame, b : BiophyloparsimonyFrame) -> BiophyloparsimonyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_parsimony_frame_copy(s : BiophyloparsimonyFrame) -> BiophyloparsimonyFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_frame_fill(s : BiophyloparsimonyFrame, v : Double) -> BiophyloparsimonyFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_frame_min(s : BiophyloparsimonyFrame) -> Double { @_common.min(s.data) }

pub fn bio_phylo_parsimony_frame_max(s : BiophyloparsimonyFrame) -> Double { @_common.max(s.data) }

pub fn bio_phylo_parsimony_frame_to_string(s : BiophyloparsimonyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_table_make(size : Int) -> BiophyloparsimonyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_table_len(s : BiophyloparsimonyTable) -> Int { s.size }

pub fn bio_phylo_parsimony_table_get(s : BiophyloparsimonyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_table_set(s : BiophyloparsimonyTable, i : Int, v : Double) -> BiophyloparsimonyTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_table_sum(s : BiophyloparsimonyTable) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_parsimony_table_mean(s : BiophyloparsimonyTable) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_parsimony_table_scale(s : BiophyloparsimonyTable, f : Double) -> BiophyloparsimonyTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_table_add(a : BiophyloparsimonyTable, b : BiophyloparsimonyTable) -> BiophyloparsimonyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_parsimony_table_copy(s : BiophyloparsimonyTable) -> BiophyloparsimonyTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_table_fill(s : BiophyloparsimonyTable, v : Double) -> BiophyloparsimonyTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_table_min(s : BiophyloparsimonyTable) -> Double { @_common.min(s.data) }

pub fn bio_phylo_parsimony_table_max(s : BiophyloparsimonyTable) -> Double { @_common.max(s.data) }

pub fn bio_phylo_parsimony_table_to_string(s : BiophyloparsimonyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_graphn_make(size : Int) -> BiophyloparsimonyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_graphn_len(s : BiophyloparsimonyGraphN) -> Int { s.size }

pub fn bio_phylo_parsimony_graphn_get(s : BiophyloparsimonyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_graphn_set(s : BiophyloparsimonyGraphN, i : Int, v : Double) -> BiophyloparsimonyGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_graphn_sum(s : BiophyloparsimonyGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_parsimony_graphn_mean(s : BiophyloparsimonyGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_parsimony_graphn_scale(s : BiophyloparsimonyGraphN, f : Double) -> BiophyloparsimonyGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_graphn_add(a : BiophyloparsimonyGraphN, b : BiophyloparsimonyGraphN) -> BiophyloparsimonyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_parsimony_graphn_copy(s : BiophyloparsimonyGraphN) -> BiophyloparsimonyGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_graphn_fill(s : BiophyloparsimonyGraphN, v : Double) -> BiophyloparsimonyGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_graphn_min(s : BiophyloparsimonyGraphN) -> Double { @_common.min(s.data) }

pub fn bio_phylo_parsimony_graphn_max(s : BiophyloparsimonyGraphN) -> Double { @_common.max(s.data) }

pub fn bio_phylo_parsimony_graphn_to_string(s : BiophyloparsimonyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_node_make(size : Int) -> BiophyloparsimonyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_node_len(s : BiophyloparsimonyNode) -> Int { s.size }

pub fn bio_phylo_parsimony_node_get(s : BiophyloparsimonyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_node_set(s : BiophyloparsimonyNode, i : Int, v : Double) -> BiophyloparsimonyNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_node_sum(s : BiophyloparsimonyNode) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_parsimony_node_mean(s : BiophyloparsimonyNode) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_parsimony_node_scale(s : BiophyloparsimonyNode, f : Double) -> BiophyloparsimonyNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_node_add(a : BiophyloparsimonyNode, b : BiophyloparsimonyNode) -> BiophyloparsimonyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_parsimony_node_copy(s : BiophyloparsimonyNode) -> BiophyloparsimonyNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_node_fill(s : BiophyloparsimonyNode, v : Double) -> BiophyloparsimonyNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_node_min(s : BiophyloparsimonyNode) -> Double { @_common.min(s.data) }

pub fn bio_phylo_parsimony_node_max(s : BiophyloparsimonyNode) -> Double { @_common.max(s.data) }

pub fn bio_phylo_parsimony_node_to_string(s : BiophyloparsimonyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_edge_make(size : Int) -> BiophyloparsimonyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_edge_len(s : BiophyloparsimonyEdge) -> Int { s.size }

pub fn bio_phylo_parsimony_edge_get(s : BiophyloparsimonyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_edge_set(s : BiophyloparsimonyEdge, i : Int, v : Double) -> BiophyloparsimonyEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_edge_sum(s : BiophyloparsimonyEdge) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_parsimony_edge_mean(s : BiophyloparsimonyEdge) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_parsimony_edge_scale(s : BiophyloparsimonyEdge, f : Double) -> BiophyloparsimonyEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_edge_add(a : BiophyloparsimonyEdge, b : BiophyloparsimonyEdge) -> BiophyloparsimonyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_parsimony_edge_copy(s : BiophyloparsimonyEdge) -> BiophyloparsimonyEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_edge_fill(s : BiophyloparsimonyEdge, v : Double) -> BiophyloparsimonyEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_edge_min(s : BiophyloparsimonyEdge) -> Double { @_common.min(s.data) }

pub fn bio_phylo_parsimony_edge_max(s : BiophyloparsimonyEdge) -> Double { @_common.max(s.data) }

pub fn bio_phylo_parsimony_edge_to_string(s : BiophyloparsimonyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_path_make(size : Int) -> BiophyloparsimonyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_path_len(s : BiophyloparsimonyPath) -> Int { s.size }

pub fn bio_phylo_parsimony_path_get(s : BiophyloparsimonyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_path_set(s : BiophyloparsimonyPath, i : Int, v : Double) -> BiophyloparsimonyPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_path_sum(s : BiophyloparsimonyPath) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_parsimony_path_mean(s : BiophyloparsimonyPath) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_parsimony_path_scale(s : BiophyloparsimonyPath, f : Double) -> BiophyloparsimonyPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_path_add(a : BiophyloparsimonyPath, b : BiophyloparsimonyPath) -> BiophyloparsimonyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_parsimony_path_copy(s : BiophyloparsimonyPath) -> BiophyloparsimonyPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_path_fill(s : BiophyloparsimonyPath, v : Double) -> BiophyloparsimonyPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_path_min(s : BiophyloparsimonyPath) -> Double { @_common.min(s.data) }

pub fn bio_phylo_parsimony_path_max(s : BiophyloparsimonyPath) -> Double { @_common.max(s.data) }

pub fn bio_phylo_parsimony_path_to_string(s : BiophyloparsimonyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_cluster_make(size : Int) -> BiophyloparsimonyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_cluster_len(s : BiophyloparsimonyCluster) -> Int { s.size }

pub fn bio_phylo_parsimony_cluster_get(s : BiophyloparsimonyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_cluster_set(s : BiophyloparsimonyCluster, i : Int, v : Double) -> BiophyloparsimonyCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_cluster_sum(s : BiophyloparsimonyCluster) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_parsimony_cluster_mean(s : BiophyloparsimonyCluster) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_parsimony_cluster_scale(s : BiophyloparsimonyCluster, f : Double) -> BiophyloparsimonyCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_cluster_add(a : BiophyloparsimonyCluster, b : BiophyloparsimonyCluster) -> BiophyloparsimonyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_parsimony_cluster_copy(s : BiophyloparsimonyCluster) -> BiophyloparsimonyCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_cluster_fill(s : BiophyloparsimonyCluster, v : Double) -> BiophyloparsimonyCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_cluster_min(s : BiophyloparsimonyCluster) -> Double { @_common.min(s.data) }

pub fn bio_phylo_parsimony_cluster_max(s : BiophyloparsimonyCluster) -> Double { @_common.max(s.data) }

pub fn bio_phylo_parsimony_cluster_to_string(s : BiophyloparsimonyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_model_make(size : Int) -> BiophyloparsimonyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_model_len(s : BiophyloparsimonyModel) -> Int { s.size }

pub fn bio_phylo_parsimony_model_get(s : BiophyloparsimonyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_model_set(s : BiophyloparsimonyModel, i : Int, v : Double) -> BiophyloparsimonyModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_model_sum(s : BiophyloparsimonyModel) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_parsimony_model_mean(s : BiophyloparsimonyModel) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_parsimony_model_scale(s : BiophyloparsimonyModel, f : Double) -> BiophyloparsimonyModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_model_add(a : BiophyloparsimonyModel, b : BiophyloparsimonyModel) -> BiophyloparsimonyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_parsimony_model_copy(s : BiophyloparsimonyModel) -> BiophyloparsimonyModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_model_fill(s : BiophyloparsimonyModel, v : Double) -> BiophyloparsimonyModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_model_min(s : BiophyloparsimonyModel) -> Double { @_common.min(s.data) }

pub fn bio_phylo_parsimony_model_max(s : BiophyloparsimonyModel) -> Double { @_common.max(s.data) }

pub fn bio_phylo_parsimony_model_to_string(s : BiophyloparsimonyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_layer_make(size : Int) -> BiophyloparsimonyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_layer_len(s : BiophyloparsimonyLayer) -> Int { s.size }

pub fn bio_phylo_parsimony_layer_get(s : BiophyloparsimonyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_layer_set(s : BiophyloparsimonyLayer, i : Int, v : Double) -> BiophyloparsimonyLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_layer_sum(s : BiophyloparsimonyLayer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_parsimony_layer_mean(s : BiophyloparsimonyLayer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_parsimony_layer_scale(s : BiophyloparsimonyLayer, f : Double) -> BiophyloparsimonyLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_layer_add(a : BiophyloparsimonyLayer, b : BiophyloparsimonyLayer) -> BiophyloparsimonyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_parsimony_layer_copy(s : BiophyloparsimonyLayer) -> BiophyloparsimonyLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_layer_fill(s : BiophyloparsimonyLayer, v : Double) -> BiophyloparsimonyLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_layer_min(s : BiophyloparsimonyLayer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_parsimony_layer_max(s : BiophyloparsimonyLayer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_parsimony_layer_to_string(s : BiophyloparsimonyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_buffer_make(size : Int) -> BiophyloparsimonyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_buffer_len(s : BiophyloparsimonyBuffer) -> Int { s.size }

pub fn bio_phylo_parsimony_buffer_get(s : BiophyloparsimonyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_buffer_set(s : BiophyloparsimonyBuffer, i : Int, v : Double) -> BiophyloparsimonyBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_buffer_sum(s : BiophyloparsimonyBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_parsimony_buffer_mean(s : BiophyloparsimonyBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_parsimony_buffer_scale(s : BiophyloparsimonyBuffer, f : Double) -> BiophyloparsimonyBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_buffer_add(a : BiophyloparsimonyBuffer, b : BiophyloparsimonyBuffer) -> BiophyloparsimonyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_parsimony_buffer_copy(s : BiophyloparsimonyBuffer) -> BiophyloparsimonyBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_buffer_fill(s : BiophyloparsimonyBuffer, v : Double) -> BiophyloparsimonyBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_buffer_min(s : BiophyloparsimonyBuffer) -> Double { @_common.min(s.data) }

pub fn bio_phylo_parsimony_buffer_max(s : BiophyloparsimonyBuffer) -> Double { @_common.max(s.data) }

pub fn bio_phylo_parsimony_buffer_to_string(s : BiophyloparsimonyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_cursor_make(size : Int) -> BiophyloparsimonyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_cursor_len(s : BiophyloparsimonyCursor) -> Int { s.size }

pub fn bio_phylo_parsimony_cursor_get(s : BiophyloparsimonyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_cursor_set(s : BiophyloparsimonyCursor, i : Int, v : Double) -> BiophyloparsimonyCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_cursor_sum(s : BiophyloparsimonyCursor) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_parsimony_cursor_mean(s : BiophyloparsimonyCursor) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_parsimony_cursor_scale(s : BiophyloparsimonyCursor, f : Double) -> BiophyloparsimonyCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_cursor_add(a : BiophyloparsimonyCursor, b : BiophyloparsimonyCursor) -> BiophyloparsimonyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_parsimony_cursor_copy(s : BiophyloparsimonyCursor) -> BiophyloparsimonyCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_cursor_fill(s : BiophyloparsimonyCursor, v : Double) -> BiophyloparsimonyCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_cursor_min(s : BiophyloparsimonyCursor) -> Double { @_common.min(s.data) }

pub fn bio_phylo_parsimony_cursor_max(s : BiophyloparsimonyCursor) -> Double { @_common.max(s.data) }

pub fn bio_phylo_parsimony_cursor_to_string(s : BiophyloparsimonyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_view_make(size : Int) -> BiophyloparsimonyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_view_len(s : BiophyloparsimonyView) -> Int { s.size }

pub fn bio_phylo_parsimony_view_get(s : BiophyloparsimonyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_view_set(s : BiophyloparsimonyView, i : Int, v : Double) -> BiophyloparsimonyView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_view_sum(s : BiophyloparsimonyView) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_parsimony_view_mean(s : BiophyloparsimonyView) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_parsimony_view_scale(s : BiophyloparsimonyView, f : Double) -> BiophyloparsimonyView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_view_add(a : BiophyloparsimonyView, b : BiophyloparsimonyView) -> BiophyloparsimonyView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_parsimony_view_copy(s : BiophyloparsimonyView) -> BiophyloparsimonyView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_view_fill(s : BiophyloparsimonyView, v : Double) -> BiophyloparsimonyView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_view_min(s : BiophyloparsimonyView) -> Double { @_common.min(s.data) }

pub fn bio_phylo_parsimony_view_max(s : BiophyloparsimonyView) -> Double { @_common.max(s.data) }

pub fn bio_phylo_parsimony_view_to_string(s : BiophyloparsimonyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_range_make(size : Int) -> BiophyloparsimonyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_range_len(s : BiophyloparsimonyRange) -> Int { s.size }

pub fn bio_phylo_parsimony_range_get(s : BiophyloparsimonyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_range_set(s : BiophyloparsimonyRange, i : Int, v : Double) -> BiophyloparsimonyRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_range_sum(s : BiophyloparsimonyRange) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_parsimony_range_mean(s : BiophyloparsimonyRange) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_parsimony_range_scale(s : BiophyloparsimonyRange, f : Double) -> BiophyloparsimonyRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_range_add(a : BiophyloparsimonyRange, b : BiophyloparsimonyRange) -> BiophyloparsimonyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_parsimony_range_copy(s : BiophyloparsimonyRange) -> BiophyloparsimonyRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_range_fill(s : BiophyloparsimonyRange, v : Double) -> BiophyloparsimonyRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_range_min(s : BiophyloparsimonyRange) -> Double { @_common.min(s.data) }

pub fn bio_phylo_parsimony_range_max(s : BiophyloparsimonyRange) -> Double { @_common.max(s.data) }

pub fn bio_phylo_parsimony_range_to_string(s : BiophyloparsimonyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_slice_make(size : Int) -> BiophyloparsimonySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_slice_len(s : BiophyloparsimonySlice) -> Int { s.size }

pub fn bio_phylo_parsimony_slice_get(s : BiophyloparsimonySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_slice_set(s : BiophyloparsimonySlice, i : Int, v : Double) -> BiophyloparsimonySlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_slice_sum(s : BiophyloparsimonySlice) -> Double { @_common.sum(s.data) }

pub fn bio_phylo_parsimony_slice_mean(s : BiophyloparsimonySlice) -> Double { @_common.mean(s.data) }

pub fn bio_phylo_parsimony_slice_scale(s : BiophyloparsimonySlice, f : Double) -> BiophyloparsimonySlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_slice_add(a : BiophyloparsimonySlice, b : BiophyloparsimonySlice) -> BiophyloparsimonySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_phylo_parsimony_slice_copy(s : BiophyloparsimonySlice) -> BiophyloparsimonySlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_slice_fill(s : BiophyloparsimonySlice, v : Double) -> BiophyloparsimonySlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_phylo_parsimony_slice_min(s : BiophyloparsimonySlice) -> Double { @_common.min(s.data) }

pub fn bio_phylo_parsimony_slice_max(s : BiophyloparsimonySlice) -> Double { @_common.max(s.data) }

pub fn bio_phylo_parsimony_slice_to_string(s : BiophyloparsimonySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

