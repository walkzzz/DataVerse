///===
/// extcore/bio_struct_domain

pub(all) struct BiostructdomainPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_domain_make_point(x : Double, y : Double) -> BiostructdomainPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_domain_make_point3(x : Double, y : Double, z : Double) -> BiostructdomainPoint {
  { x, y, z, label: 0 }
}

pub fn BiostructdomainPoint::x(self : BiostructdomainPoint) -> Double { self.x }

pub fn BiostructdomainPoint::y(self : BiostructdomainPoint) -> Double { self.y }

pub fn BiostructdomainPoint::z(self : BiostructdomainPoint) -> Double { self.z }

pub fn BiostructdomainPoint::label(self : BiostructdomainPoint) -> Int { self.label }

pub fn BiostructdomainPoint::dist(self : BiostructdomainPoint, other : BiostructdomainPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructdomainPoint::add(self : BiostructdomainPoint, other : BiostructdomainPoint) -> BiostructdomainPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructdomainPoint::sub(self : BiostructdomainPoint, other : BiostructdomainPoint) -> BiostructdomainPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructdomainPoint::scale(self : BiostructdomainPoint, s : Double) -> BiostructdomainPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructdomainPoint::dot(self : BiostructdomainPoint, other : BiostructdomainPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructdomainPoint::cross(self : BiostructdomainPoint, other : BiostructdomainPoint) -> BiostructdomainPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructdomainPoint::norm(self : BiostructdomainPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructdomainPoint::normalize(self : BiostructdomainPoint) -> BiostructdomainPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructdomainPoint::negate(self : BiostructdomainPoint) -> BiostructdomainPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructdomainPoint::mid(self : BiostructdomainPoint, other : BiostructdomainPoint) -> BiostructdomainPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructdomainPoint::lerp(self : BiostructdomainPoint, other : BiostructdomainPoint, t : Double) -> BiostructdomainPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructdomainPoint::to_string(self : BiostructdomainPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructdomainSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_domain_make_series(vals : Array[Double], name : String) -> BiostructdomainSeries {
  { vals, name, meta: 0 }
}

pub fn BiostructdomainSeries::len(self : BiostructdomainSeries) -> Int { self.vals.length() }

pub fn BiostructdomainSeries::sum(self : BiostructdomainSeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructdomainSeries::mean(self : BiostructdomainSeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructdomainSeries::min(self : BiostructdomainSeries) -> Double { @_common.min(self.vals) }

pub fn BiostructdomainSeries::max(self : BiostructdomainSeries) -> Double { @_common.max(self.vals) }

pub fn BiostructdomainSeries::range(self : BiostructdomainSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructdomainSeries::variance(self : BiostructdomainSeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructdomainSeries::std(self : BiostructdomainSeries) -> Double { @_common.std(self.vals) }

pub fn BiostructdomainSeries::median(self : BiostructdomainSeries) -> Double { @_common.median(self.vals) }

pub fn BiostructdomainSeries::scale(self : BiostructdomainSeries, f : Double) -> BiostructdomainSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructdomainSeries::add(self : BiostructdomainSeries, other : BiostructdomainSeries) -> BiostructdomainSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructdomainSeries::sub(self : BiostructdomainSeries, other : BiostructdomainSeries) -> BiostructdomainSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructdomainSeries::normalize(self : BiostructdomainSeries) -> BiostructdomainSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructdomainSeries::cumsum(self : BiostructdomainSeries) -> BiostructdomainSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructdomainSeries::to_string(self : BiostructdomainSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructdomainMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_domain_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructdomainMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_domain_matrix_identity(n : Int) -> BiostructdomainMatrix {
  let m = bio_struct_domain_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructdomainMatrix::get(self : BiostructdomainMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructdomainMatrix::transpose(self : BiostructdomainMatrix) -> BiostructdomainMatrix {
  let result = bio_struct_domain_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructdomainMatrix::add(self : BiostructdomainMatrix, other : BiostructdomainMatrix) -> BiostructdomainMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_domain_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructdomainMatrix::scale(self : BiostructdomainMatrix, s : Double) -> BiostructdomainMatrix {
  let result = bio_struct_domain_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructdomainMatrix::multiply(self : BiostructdomainMatrix, other : BiostructdomainMatrix) -> BiostructdomainMatrix {
  if self.cols != other.rows { return bio_struct_domain_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_domain_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiostructdomainMatrix::trace(self : BiostructdomainMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructdomainMatrix::det(self : BiostructdomainMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructdomainMatrix::norm(self : BiostructdomainMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructdomainMatrix::to_string(self : BiostructdomainMatrix) -> String {
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

pub(all) struct BiostructdomainVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_domain_make_vector(comps : Array[Double]) -> BiostructdomainVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_domain_vector_zero(dim : Int) -> BiostructdomainVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructdomainVector::add(self : BiostructdomainVector, other : BiostructdomainVector) -> BiostructdomainVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructdomainVector::sub(self : BiostructdomainVector, other : BiostructdomainVector) -> BiostructdomainVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructdomainVector::scale(self : BiostructdomainVector, s : Double) -> BiostructdomainVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructdomainVector::dot(self : BiostructdomainVector, other : BiostructdomainVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructdomainVector::norm(self : BiostructdomainVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructdomainVector::normalize(self : BiostructdomainVector) -> BiostructdomainVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructdomainVector::dist(self : BiostructdomainVector, other : BiostructdomainVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructdomainVector::to_string(self : BiostructdomainVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_domain_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_domain_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_domain_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_domain_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_domain_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_domain_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_domain_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_domain_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_domain_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_domain_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_domain_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_domain_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_domain_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_domain_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_domain_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_domain_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_domain_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_domain_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_domain_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_domain_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_domain_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_domain_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_domain_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_domain_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_domain_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_domain_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_domain_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_domain_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_domain_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructdomainFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_frame_make(size : Int) -> BiostructdomainFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_frame_len(s : BiostructdomainFrame) -> Int { s.size }

pub fn bio_struct_domain_frame_get(s : BiostructdomainFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_frame_set(s : BiostructdomainFrame, i : Int, v : Double) -> BiostructdomainFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_frame_sum(s : BiostructdomainFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_domain_frame_mean(s : BiostructdomainFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_domain_frame_scale(s : BiostructdomainFrame, f : Double) -> BiostructdomainFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_frame_add(a : BiostructdomainFrame, b : BiostructdomainFrame) -> BiostructdomainFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_domain_frame_copy(s : BiostructdomainFrame) -> BiostructdomainFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_frame_fill(s : BiostructdomainFrame, v : Double) -> BiostructdomainFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_frame_min(s : BiostructdomainFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_domain_frame_max(s : BiostructdomainFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_domain_frame_to_string(s : BiostructdomainFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_table_make(size : Int) -> BiostructdomainTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_table_len(s : BiostructdomainTable) -> Int { s.size }

pub fn bio_struct_domain_table_get(s : BiostructdomainTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_table_set(s : BiostructdomainTable, i : Int, v : Double) -> BiostructdomainTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_table_sum(s : BiostructdomainTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_domain_table_mean(s : BiostructdomainTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_domain_table_scale(s : BiostructdomainTable, f : Double) -> BiostructdomainTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_table_add(a : BiostructdomainTable, b : BiostructdomainTable) -> BiostructdomainTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_domain_table_copy(s : BiostructdomainTable) -> BiostructdomainTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_table_fill(s : BiostructdomainTable, v : Double) -> BiostructdomainTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_table_min(s : BiostructdomainTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_domain_table_max(s : BiostructdomainTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_domain_table_to_string(s : BiostructdomainTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_graphn_make(size : Int) -> BiostructdomainGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_graphn_len(s : BiostructdomainGraphN) -> Int { s.size }

pub fn bio_struct_domain_graphn_get(s : BiostructdomainGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_graphn_set(s : BiostructdomainGraphN, i : Int, v : Double) -> BiostructdomainGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_graphn_sum(s : BiostructdomainGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_domain_graphn_mean(s : BiostructdomainGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_domain_graphn_scale(s : BiostructdomainGraphN, f : Double) -> BiostructdomainGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_graphn_add(a : BiostructdomainGraphN, b : BiostructdomainGraphN) -> BiostructdomainGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_domain_graphn_copy(s : BiostructdomainGraphN) -> BiostructdomainGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_graphn_fill(s : BiostructdomainGraphN, v : Double) -> BiostructdomainGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_graphn_min(s : BiostructdomainGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_domain_graphn_max(s : BiostructdomainGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_domain_graphn_to_string(s : BiostructdomainGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_node_make(size : Int) -> BiostructdomainNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_node_len(s : BiostructdomainNode) -> Int { s.size }

pub fn bio_struct_domain_node_get(s : BiostructdomainNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_node_set(s : BiostructdomainNode, i : Int, v : Double) -> BiostructdomainNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_node_sum(s : BiostructdomainNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_domain_node_mean(s : BiostructdomainNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_domain_node_scale(s : BiostructdomainNode, f : Double) -> BiostructdomainNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_node_add(a : BiostructdomainNode, b : BiostructdomainNode) -> BiostructdomainNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_domain_node_copy(s : BiostructdomainNode) -> BiostructdomainNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_node_fill(s : BiostructdomainNode, v : Double) -> BiostructdomainNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_node_min(s : BiostructdomainNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_domain_node_max(s : BiostructdomainNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_domain_node_to_string(s : BiostructdomainNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_edge_make(size : Int) -> BiostructdomainEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_edge_len(s : BiostructdomainEdge) -> Int { s.size }

pub fn bio_struct_domain_edge_get(s : BiostructdomainEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_edge_set(s : BiostructdomainEdge, i : Int, v : Double) -> BiostructdomainEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_edge_sum(s : BiostructdomainEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_domain_edge_mean(s : BiostructdomainEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_domain_edge_scale(s : BiostructdomainEdge, f : Double) -> BiostructdomainEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_edge_add(a : BiostructdomainEdge, b : BiostructdomainEdge) -> BiostructdomainEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_domain_edge_copy(s : BiostructdomainEdge) -> BiostructdomainEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_edge_fill(s : BiostructdomainEdge, v : Double) -> BiostructdomainEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_edge_min(s : BiostructdomainEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_domain_edge_max(s : BiostructdomainEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_domain_edge_to_string(s : BiostructdomainEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_path_make(size : Int) -> BiostructdomainPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_path_len(s : BiostructdomainPath) -> Int { s.size }

pub fn bio_struct_domain_path_get(s : BiostructdomainPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_path_set(s : BiostructdomainPath, i : Int, v : Double) -> BiostructdomainPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_path_sum(s : BiostructdomainPath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_domain_path_mean(s : BiostructdomainPath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_domain_path_scale(s : BiostructdomainPath, f : Double) -> BiostructdomainPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_path_add(a : BiostructdomainPath, b : BiostructdomainPath) -> BiostructdomainPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_domain_path_copy(s : BiostructdomainPath) -> BiostructdomainPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_path_fill(s : BiostructdomainPath, v : Double) -> BiostructdomainPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_path_min(s : BiostructdomainPath) -> Double { @_common.min(s.data) }

pub fn bio_struct_domain_path_max(s : BiostructdomainPath) -> Double { @_common.max(s.data) }

pub fn bio_struct_domain_path_to_string(s : BiostructdomainPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_cluster_make(size : Int) -> BiostructdomainCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_cluster_len(s : BiostructdomainCluster) -> Int { s.size }

pub fn bio_struct_domain_cluster_get(s : BiostructdomainCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_cluster_set(s : BiostructdomainCluster, i : Int, v : Double) -> BiostructdomainCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_cluster_sum(s : BiostructdomainCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_domain_cluster_mean(s : BiostructdomainCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_domain_cluster_scale(s : BiostructdomainCluster, f : Double) -> BiostructdomainCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_cluster_add(a : BiostructdomainCluster, b : BiostructdomainCluster) -> BiostructdomainCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_domain_cluster_copy(s : BiostructdomainCluster) -> BiostructdomainCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_cluster_fill(s : BiostructdomainCluster, v : Double) -> BiostructdomainCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_cluster_min(s : BiostructdomainCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_domain_cluster_max(s : BiostructdomainCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_domain_cluster_to_string(s : BiostructdomainCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_model_make(size : Int) -> BiostructdomainModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_model_len(s : BiostructdomainModel) -> Int { s.size }

pub fn bio_struct_domain_model_get(s : BiostructdomainModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_model_set(s : BiostructdomainModel, i : Int, v : Double) -> BiostructdomainModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_model_sum(s : BiostructdomainModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_domain_model_mean(s : BiostructdomainModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_domain_model_scale(s : BiostructdomainModel, f : Double) -> BiostructdomainModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_model_add(a : BiostructdomainModel, b : BiostructdomainModel) -> BiostructdomainModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_domain_model_copy(s : BiostructdomainModel) -> BiostructdomainModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_model_fill(s : BiostructdomainModel, v : Double) -> BiostructdomainModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_model_min(s : BiostructdomainModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_domain_model_max(s : BiostructdomainModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_domain_model_to_string(s : BiostructdomainModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_layer_make(size : Int) -> BiostructdomainLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_layer_len(s : BiostructdomainLayer) -> Int { s.size }

pub fn bio_struct_domain_layer_get(s : BiostructdomainLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_layer_set(s : BiostructdomainLayer, i : Int, v : Double) -> BiostructdomainLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_layer_sum(s : BiostructdomainLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_domain_layer_mean(s : BiostructdomainLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_domain_layer_scale(s : BiostructdomainLayer, f : Double) -> BiostructdomainLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_layer_add(a : BiostructdomainLayer, b : BiostructdomainLayer) -> BiostructdomainLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_domain_layer_copy(s : BiostructdomainLayer) -> BiostructdomainLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_layer_fill(s : BiostructdomainLayer, v : Double) -> BiostructdomainLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_layer_min(s : BiostructdomainLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_domain_layer_max(s : BiostructdomainLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_domain_layer_to_string(s : BiostructdomainLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_buffer_make(size : Int) -> BiostructdomainBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_buffer_len(s : BiostructdomainBuffer) -> Int { s.size }

pub fn bio_struct_domain_buffer_get(s : BiostructdomainBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_buffer_set(s : BiostructdomainBuffer, i : Int, v : Double) -> BiostructdomainBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_buffer_sum(s : BiostructdomainBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_domain_buffer_mean(s : BiostructdomainBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_domain_buffer_scale(s : BiostructdomainBuffer, f : Double) -> BiostructdomainBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_buffer_add(a : BiostructdomainBuffer, b : BiostructdomainBuffer) -> BiostructdomainBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_domain_buffer_copy(s : BiostructdomainBuffer) -> BiostructdomainBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_buffer_fill(s : BiostructdomainBuffer, v : Double) -> BiostructdomainBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_buffer_min(s : BiostructdomainBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_domain_buffer_max(s : BiostructdomainBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_domain_buffer_to_string(s : BiostructdomainBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_cursor_make(size : Int) -> BiostructdomainCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_cursor_len(s : BiostructdomainCursor) -> Int { s.size }

pub fn bio_struct_domain_cursor_get(s : BiostructdomainCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_cursor_set(s : BiostructdomainCursor, i : Int, v : Double) -> BiostructdomainCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_cursor_sum(s : BiostructdomainCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_domain_cursor_mean(s : BiostructdomainCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_domain_cursor_scale(s : BiostructdomainCursor, f : Double) -> BiostructdomainCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_cursor_add(a : BiostructdomainCursor, b : BiostructdomainCursor) -> BiostructdomainCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_domain_cursor_copy(s : BiostructdomainCursor) -> BiostructdomainCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_cursor_fill(s : BiostructdomainCursor, v : Double) -> BiostructdomainCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_cursor_min(s : BiostructdomainCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_domain_cursor_max(s : BiostructdomainCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_domain_cursor_to_string(s : BiostructdomainCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_view_make(size : Int) -> BiostructdomainView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_view_len(s : BiostructdomainView) -> Int { s.size }

pub fn bio_struct_domain_view_get(s : BiostructdomainView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_view_set(s : BiostructdomainView, i : Int, v : Double) -> BiostructdomainView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_view_sum(s : BiostructdomainView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_domain_view_mean(s : BiostructdomainView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_domain_view_scale(s : BiostructdomainView, f : Double) -> BiostructdomainView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_view_add(a : BiostructdomainView, b : BiostructdomainView) -> BiostructdomainView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_domain_view_copy(s : BiostructdomainView) -> BiostructdomainView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_view_fill(s : BiostructdomainView, v : Double) -> BiostructdomainView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_view_min(s : BiostructdomainView) -> Double { @_common.min(s.data) }

pub fn bio_struct_domain_view_max(s : BiostructdomainView) -> Double { @_common.max(s.data) }

pub fn bio_struct_domain_view_to_string(s : BiostructdomainView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_range_make(size : Int) -> BiostructdomainRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_range_len(s : BiostructdomainRange) -> Int { s.size }

pub fn bio_struct_domain_range_get(s : BiostructdomainRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_range_set(s : BiostructdomainRange, i : Int, v : Double) -> BiostructdomainRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_range_sum(s : BiostructdomainRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_domain_range_mean(s : BiostructdomainRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_domain_range_scale(s : BiostructdomainRange, f : Double) -> BiostructdomainRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_range_add(a : BiostructdomainRange, b : BiostructdomainRange) -> BiostructdomainRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_domain_range_copy(s : BiostructdomainRange) -> BiostructdomainRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_range_fill(s : BiostructdomainRange, v : Double) -> BiostructdomainRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_range_min(s : BiostructdomainRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_domain_range_max(s : BiostructdomainRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_domain_range_to_string(s : BiostructdomainRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdomainSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_domain_slice_make(size : Int) -> BiostructdomainSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_domain_slice_len(s : BiostructdomainSlice) -> Int { s.size }

pub fn bio_struct_domain_slice_get(s : BiostructdomainSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_domain_slice_set(s : BiostructdomainSlice, i : Int, v : Double) -> BiostructdomainSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_slice_sum(s : BiostructdomainSlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_domain_slice_mean(s : BiostructdomainSlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_domain_slice_scale(s : BiostructdomainSlice, f : Double) -> BiostructdomainSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_slice_add(a : BiostructdomainSlice, b : BiostructdomainSlice) -> BiostructdomainSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_domain_slice_copy(s : BiostructdomainSlice) -> BiostructdomainSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_slice_fill(s : BiostructdomainSlice, v : Double) -> BiostructdomainSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_domain_slice_min(s : BiostructdomainSlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_domain_slice_max(s : BiostructdomainSlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_domain_slice_to_string(s : BiostructdomainSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

