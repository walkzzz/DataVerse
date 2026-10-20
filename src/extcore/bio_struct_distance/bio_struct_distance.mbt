///===
/// extcore/bio_struct_distance

pub(all) struct BiostructdistancePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_struct_distance_make_point(x : Double, y : Double) -> BiostructdistancePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_struct_distance_make_point3(x : Double, y : Double, z : Double) -> BiostructdistancePoint {
  { x, y, z, label: 0 }
}

pub fn BiostructdistancePoint::x(self : BiostructdistancePoint) -> Double { self.x }

pub fn BiostructdistancePoint::y(self : BiostructdistancePoint) -> Double { self.y }

pub fn BiostructdistancePoint::z(self : BiostructdistancePoint) -> Double { self.z }

pub fn BiostructdistancePoint::label(self : BiostructdistancePoint) -> Int { self.label }

pub fn BiostructdistancePoint::dist(self : BiostructdistancePoint, other : BiostructdistancePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn BiostructdistancePoint::add(self : BiostructdistancePoint, other : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn BiostructdistancePoint::sub(self : BiostructdistancePoint, other : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn BiostructdistancePoint::scale(self : BiostructdistancePoint, s : Double) -> BiostructdistancePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn BiostructdistancePoint::dot(self : BiostructdistancePoint, other : BiostructdistancePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn BiostructdistancePoint::cross(self : BiostructdistancePoint, other : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn BiostructdistancePoint::norm(self : BiostructdistancePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn BiostructdistancePoint::normalize(self : BiostructdistancePoint) -> BiostructdistancePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructdistancePoint::negate(self : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn BiostructdistancePoint::mid(self : BiostructdistancePoint, other : BiostructdistancePoint) -> BiostructdistancePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn BiostructdistancePoint::lerp(self : BiostructdistancePoint, other : BiostructdistancePoint, t : Double) -> BiostructdistancePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn BiostructdistancePoint::to_string(self : BiostructdistancePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct BiostructdistanceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_struct_distance_make_series(vals : Array[Double], name : String) -> BiostructdistanceSeries {
  { vals, name, meta: 0 }
}

pub fn BiostructdistanceSeries::len(self : BiostructdistanceSeries) -> Int { self.vals.length() }

pub fn BiostructdistanceSeries::sum(self : BiostructdistanceSeries) -> Double { @_common.sum(self.vals) }

pub fn BiostructdistanceSeries::mean(self : BiostructdistanceSeries) -> Double { @_common.mean(self.vals) }

pub fn BiostructdistanceSeries::min(self : BiostructdistanceSeries) -> Double { @_common.min(self.vals) }

pub fn BiostructdistanceSeries::max(self : BiostructdistanceSeries) -> Double { @_common.max(self.vals) }

pub fn BiostructdistanceSeries::range(self : BiostructdistanceSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn BiostructdistanceSeries::variance(self : BiostructdistanceSeries) -> Double { @_common.variance(self.vals) }

pub fn BiostructdistanceSeries::std(self : BiostructdistanceSeries) -> Double { @_common.std(self.vals) }

pub fn BiostructdistanceSeries::median(self : BiostructdistanceSeries) -> Double { @_common.median(self.vals) }

pub fn BiostructdistanceSeries::scale(self : BiostructdistanceSeries, f : Double) -> BiostructdistanceSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn BiostructdistanceSeries::add(self : BiostructdistanceSeries, other : BiostructdistanceSeries) -> BiostructdistanceSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn BiostructdistanceSeries::sub(self : BiostructdistanceSeries, other : BiostructdistanceSeries) -> BiostructdistanceSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn BiostructdistanceSeries::normalize(self : BiostructdistanceSeries) -> BiostructdistanceSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn BiostructdistanceSeries::cumsum(self : BiostructdistanceSeries) -> BiostructdistanceSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn BiostructdistanceSeries::to_string(self : BiostructdistanceSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiostructdistanceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_struct_distance_make_matrix(rows : Int, cols : Int, val : Double) -> BiostructdistanceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_struct_distance_matrix_identity(n : Int) -> BiostructdistanceMatrix {
  let m = bio_struct_distance_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn BiostructdistanceMatrix::get(self : BiostructdistanceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn BiostructdistanceMatrix::transpose(self : BiostructdistanceMatrix) -> BiostructdistanceMatrix {
  let result = bio_struct_distance_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn BiostructdistanceMatrix::add(self : BiostructdistanceMatrix, other : BiostructdistanceMatrix) -> BiostructdistanceMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = bio_struct_distance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn BiostructdistanceMatrix::scale(self : BiostructdistanceMatrix, s : Double) -> BiostructdistanceMatrix {
  let result = bio_struct_distance_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn BiostructdistanceMatrix::multiply(self : BiostructdistanceMatrix, other : BiostructdistanceMatrix) -> BiostructdistanceMatrix {
  if self.cols != other.rows { return bio_struct_distance_make_matrix(self.rows, other.cols, 0.0) }
  let result = bio_struct_distance_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn BiostructdistanceMatrix::trace(self : BiostructdistanceMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn BiostructdistanceMatrix::det(self : BiostructdistanceMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn BiostructdistanceMatrix::norm(self : BiostructdistanceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn BiostructdistanceMatrix::to_string(self : BiostructdistanceMatrix) -> String {
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

pub(all) struct BiostructdistanceVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_struct_distance_make_vector(comps : Array[Double]) -> BiostructdistanceVector {
  { comps, dim: comps.length() }
}

pub fn bio_struct_distance_vector_zero(dim : Int) -> BiostructdistanceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn BiostructdistanceVector::add(self : BiostructdistanceVector, other : BiostructdistanceVector) -> BiostructdistanceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructdistanceVector::sub(self : BiostructdistanceVector, other : BiostructdistanceVector) -> BiostructdistanceVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn BiostructdistanceVector::scale(self : BiostructdistanceVector, s : Double) -> BiostructdistanceVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn BiostructdistanceVector::dot(self : BiostructdistanceVector, other : BiostructdistanceVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn BiostructdistanceVector::norm(self : BiostructdistanceVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn BiostructdistanceVector::normalize(self : BiostructdistanceVector) -> BiostructdistanceVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn BiostructdistanceVector::dist(self : BiostructdistanceVector, other : BiostructdistanceVector) -> Double {
  self.sub(other).norm()
}

pub fn BiostructdistanceVector::to_string(self : BiostructdistanceVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_struct_distance_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn bio_struct_distance_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn bio_struct_distance_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn bio_struct_distance_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn bio_struct_distance_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn bio_struct_distance_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn bio_struct_distance_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn bio_struct_distance_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn bio_struct_distance_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn bio_struct_distance_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn bio_struct_distance_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn bio_struct_distance_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn bio_struct_distance_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn bio_struct_distance_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn bio_struct_distance_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn bio_struct_distance_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn bio_struct_distance_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn bio_struct_distance_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn bio_struct_distance_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn bio_struct_distance_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn bio_struct_distance_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn bio_struct_distance_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn bio_struct_distance_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn bio_struct_distance_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn bio_struct_distance_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn bio_struct_distance_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn bio_struct_distance_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn bio_struct_distance_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn bio_struct_distance_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct BiostructdistanceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_frame_make(size : Int) -> BiostructdistanceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_frame_len(s : BiostructdistanceFrame) -> Int { s.size }

pub fn bio_struct_distance_frame_get(s : BiostructdistanceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_frame_set(s : BiostructdistanceFrame, i : Int, v : Double) -> BiostructdistanceFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_frame_sum(s : BiostructdistanceFrame) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_frame_mean(s : BiostructdistanceFrame) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_frame_scale(s : BiostructdistanceFrame, f : Double) -> BiostructdistanceFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_frame_add(a : BiostructdistanceFrame, b : BiostructdistanceFrame) -> BiostructdistanceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_frame_copy(s : BiostructdistanceFrame) -> BiostructdistanceFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_frame_fill(s : BiostructdistanceFrame, v : Double) -> BiostructdistanceFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_frame_min(s : BiostructdistanceFrame) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_frame_max(s : BiostructdistanceFrame) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_frame_to_string(s : BiostructdistanceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_table_make(size : Int) -> BiostructdistanceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_table_len(s : BiostructdistanceTable) -> Int { s.size }

pub fn bio_struct_distance_table_get(s : BiostructdistanceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_table_set(s : BiostructdistanceTable, i : Int, v : Double) -> BiostructdistanceTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_table_sum(s : BiostructdistanceTable) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_table_mean(s : BiostructdistanceTable) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_table_scale(s : BiostructdistanceTable, f : Double) -> BiostructdistanceTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_table_add(a : BiostructdistanceTable, b : BiostructdistanceTable) -> BiostructdistanceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_table_copy(s : BiostructdistanceTable) -> BiostructdistanceTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_table_fill(s : BiostructdistanceTable, v : Double) -> BiostructdistanceTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_table_min(s : BiostructdistanceTable) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_table_max(s : BiostructdistanceTable) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_table_to_string(s : BiostructdistanceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_graphn_make(size : Int) -> BiostructdistanceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_graphn_len(s : BiostructdistanceGraphN) -> Int { s.size }

pub fn bio_struct_distance_graphn_get(s : BiostructdistanceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_graphn_set(s : BiostructdistanceGraphN, i : Int, v : Double) -> BiostructdistanceGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_graphn_sum(s : BiostructdistanceGraphN) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_graphn_mean(s : BiostructdistanceGraphN) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_graphn_scale(s : BiostructdistanceGraphN, f : Double) -> BiostructdistanceGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_graphn_add(a : BiostructdistanceGraphN, b : BiostructdistanceGraphN) -> BiostructdistanceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_graphn_copy(s : BiostructdistanceGraphN) -> BiostructdistanceGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_graphn_fill(s : BiostructdistanceGraphN, v : Double) -> BiostructdistanceGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_graphn_min(s : BiostructdistanceGraphN) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_graphn_max(s : BiostructdistanceGraphN) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_graphn_to_string(s : BiostructdistanceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_node_make(size : Int) -> BiostructdistanceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_node_len(s : BiostructdistanceNode) -> Int { s.size }

pub fn bio_struct_distance_node_get(s : BiostructdistanceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_node_set(s : BiostructdistanceNode, i : Int, v : Double) -> BiostructdistanceNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_node_sum(s : BiostructdistanceNode) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_node_mean(s : BiostructdistanceNode) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_node_scale(s : BiostructdistanceNode, f : Double) -> BiostructdistanceNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_node_add(a : BiostructdistanceNode, b : BiostructdistanceNode) -> BiostructdistanceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_node_copy(s : BiostructdistanceNode) -> BiostructdistanceNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_node_fill(s : BiostructdistanceNode, v : Double) -> BiostructdistanceNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_node_min(s : BiostructdistanceNode) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_node_max(s : BiostructdistanceNode) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_node_to_string(s : BiostructdistanceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_edge_make(size : Int) -> BiostructdistanceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_edge_len(s : BiostructdistanceEdge) -> Int { s.size }

pub fn bio_struct_distance_edge_get(s : BiostructdistanceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_edge_set(s : BiostructdistanceEdge, i : Int, v : Double) -> BiostructdistanceEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_edge_sum(s : BiostructdistanceEdge) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_edge_mean(s : BiostructdistanceEdge) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_edge_scale(s : BiostructdistanceEdge, f : Double) -> BiostructdistanceEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_edge_add(a : BiostructdistanceEdge, b : BiostructdistanceEdge) -> BiostructdistanceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_edge_copy(s : BiostructdistanceEdge) -> BiostructdistanceEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_edge_fill(s : BiostructdistanceEdge, v : Double) -> BiostructdistanceEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_edge_min(s : BiostructdistanceEdge) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_edge_max(s : BiostructdistanceEdge) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_edge_to_string(s : BiostructdistanceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistancePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_path_make(size : Int) -> BiostructdistancePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_path_len(s : BiostructdistancePath) -> Int { s.size }

pub fn bio_struct_distance_path_get(s : BiostructdistancePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_path_set(s : BiostructdistancePath, i : Int, v : Double) -> BiostructdistancePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_path_sum(s : BiostructdistancePath) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_path_mean(s : BiostructdistancePath) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_path_scale(s : BiostructdistancePath, f : Double) -> BiostructdistancePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_path_add(a : BiostructdistancePath, b : BiostructdistancePath) -> BiostructdistancePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_path_copy(s : BiostructdistancePath) -> BiostructdistancePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_path_fill(s : BiostructdistancePath, v : Double) -> BiostructdistancePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_path_min(s : BiostructdistancePath) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_path_max(s : BiostructdistancePath) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_path_to_string(s : BiostructdistancePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_cluster_make(size : Int) -> BiostructdistanceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_cluster_len(s : BiostructdistanceCluster) -> Int { s.size }

pub fn bio_struct_distance_cluster_get(s : BiostructdistanceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_cluster_set(s : BiostructdistanceCluster, i : Int, v : Double) -> BiostructdistanceCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_cluster_sum(s : BiostructdistanceCluster) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_cluster_mean(s : BiostructdistanceCluster) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_cluster_scale(s : BiostructdistanceCluster, f : Double) -> BiostructdistanceCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_cluster_add(a : BiostructdistanceCluster, b : BiostructdistanceCluster) -> BiostructdistanceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_cluster_copy(s : BiostructdistanceCluster) -> BiostructdistanceCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_cluster_fill(s : BiostructdistanceCluster, v : Double) -> BiostructdistanceCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_cluster_min(s : BiostructdistanceCluster) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_cluster_max(s : BiostructdistanceCluster) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_cluster_to_string(s : BiostructdistanceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_model_make(size : Int) -> BiostructdistanceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_model_len(s : BiostructdistanceModel) -> Int { s.size }

pub fn bio_struct_distance_model_get(s : BiostructdistanceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_model_set(s : BiostructdistanceModel, i : Int, v : Double) -> BiostructdistanceModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_model_sum(s : BiostructdistanceModel) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_model_mean(s : BiostructdistanceModel) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_model_scale(s : BiostructdistanceModel, f : Double) -> BiostructdistanceModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_model_add(a : BiostructdistanceModel, b : BiostructdistanceModel) -> BiostructdistanceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_model_copy(s : BiostructdistanceModel) -> BiostructdistanceModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_model_fill(s : BiostructdistanceModel, v : Double) -> BiostructdistanceModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_model_min(s : BiostructdistanceModel) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_model_max(s : BiostructdistanceModel) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_model_to_string(s : BiostructdistanceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_layer_make(size : Int) -> BiostructdistanceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_layer_len(s : BiostructdistanceLayer) -> Int { s.size }

pub fn bio_struct_distance_layer_get(s : BiostructdistanceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_layer_set(s : BiostructdistanceLayer, i : Int, v : Double) -> BiostructdistanceLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_layer_sum(s : BiostructdistanceLayer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_layer_mean(s : BiostructdistanceLayer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_layer_scale(s : BiostructdistanceLayer, f : Double) -> BiostructdistanceLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_layer_add(a : BiostructdistanceLayer, b : BiostructdistanceLayer) -> BiostructdistanceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_layer_copy(s : BiostructdistanceLayer) -> BiostructdistanceLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_layer_fill(s : BiostructdistanceLayer, v : Double) -> BiostructdistanceLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_layer_min(s : BiostructdistanceLayer) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_layer_max(s : BiostructdistanceLayer) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_layer_to_string(s : BiostructdistanceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_buffer_make(size : Int) -> BiostructdistanceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_buffer_len(s : BiostructdistanceBuffer) -> Int { s.size }

pub fn bio_struct_distance_buffer_get(s : BiostructdistanceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_buffer_set(s : BiostructdistanceBuffer, i : Int, v : Double) -> BiostructdistanceBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_buffer_sum(s : BiostructdistanceBuffer) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_buffer_mean(s : BiostructdistanceBuffer) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_buffer_scale(s : BiostructdistanceBuffer, f : Double) -> BiostructdistanceBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_buffer_add(a : BiostructdistanceBuffer, b : BiostructdistanceBuffer) -> BiostructdistanceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_buffer_copy(s : BiostructdistanceBuffer) -> BiostructdistanceBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_buffer_fill(s : BiostructdistanceBuffer, v : Double) -> BiostructdistanceBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_buffer_min(s : BiostructdistanceBuffer) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_buffer_max(s : BiostructdistanceBuffer) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_buffer_to_string(s : BiostructdistanceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_cursor_make(size : Int) -> BiostructdistanceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_cursor_len(s : BiostructdistanceCursor) -> Int { s.size }

pub fn bio_struct_distance_cursor_get(s : BiostructdistanceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_cursor_set(s : BiostructdistanceCursor, i : Int, v : Double) -> BiostructdistanceCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_cursor_sum(s : BiostructdistanceCursor) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_cursor_mean(s : BiostructdistanceCursor) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_cursor_scale(s : BiostructdistanceCursor, f : Double) -> BiostructdistanceCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_cursor_add(a : BiostructdistanceCursor, b : BiostructdistanceCursor) -> BiostructdistanceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_cursor_copy(s : BiostructdistanceCursor) -> BiostructdistanceCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_cursor_fill(s : BiostructdistanceCursor, v : Double) -> BiostructdistanceCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_cursor_min(s : BiostructdistanceCursor) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_cursor_max(s : BiostructdistanceCursor) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_cursor_to_string(s : BiostructdistanceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_view_make(size : Int) -> BiostructdistanceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_view_len(s : BiostructdistanceView) -> Int { s.size }

pub fn bio_struct_distance_view_get(s : BiostructdistanceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_view_set(s : BiostructdistanceView, i : Int, v : Double) -> BiostructdistanceView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_view_sum(s : BiostructdistanceView) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_view_mean(s : BiostructdistanceView) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_view_scale(s : BiostructdistanceView, f : Double) -> BiostructdistanceView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_view_add(a : BiostructdistanceView, b : BiostructdistanceView) -> BiostructdistanceView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_view_copy(s : BiostructdistanceView) -> BiostructdistanceView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_view_fill(s : BiostructdistanceView, v : Double) -> BiostructdistanceView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_view_min(s : BiostructdistanceView) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_view_max(s : BiostructdistanceView) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_view_to_string(s : BiostructdistanceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_range_make(size : Int) -> BiostructdistanceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_range_len(s : BiostructdistanceRange) -> Int { s.size }

pub fn bio_struct_distance_range_get(s : BiostructdistanceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_range_set(s : BiostructdistanceRange, i : Int, v : Double) -> BiostructdistanceRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_range_sum(s : BiostructdistanceRange) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_range_mean(s : BiostructdistanceRange) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_range_scale(s : BiostructdistanceRange, f : Double) -> BiostructdistanceRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_range_add(a : BiostructdistanceRange, b : BiostructdistanceRange) -> BiostructdistanceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_range_copy(s : BiostructdistanceRange) -> BiostructdistanceRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_range_fill(s : BiostructdistanceRange, v : Double) -> BiostructdistanceRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_range_min(s : BiostructdistanceRange) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_range_max(s : BiostructdistanceRange) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_range_to_string(s : BiostructdistanceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiostructdistanceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_struct_distance_slice_make(size : Int) -> BiostructdistanceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_struct_distance_slice_len(s : BiostructdistanceSlice) -> Int { s.size }

pub fn bio_struct_distance_slice_get(s : BiostructdistanceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_struct_distance_slice_set(s : BiostructdistanceSlice, i : Int, v : Double) -> BiostructdistanceSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_slice_sum(s : BiostructdistanceSlice) -> Double { @_common.sum(s.data) }

pub fn bio_struct_distance_slice_mean(s : BiostructdistanceSlice) -> Double { @_common.mean(s.data) }

pub fn bio_struct_distance_slice_scale(s : BiostructdistanceSlice, f : Double) -> BiostructdistanceSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_slice_add(a : BiostructdistanceSlice, b : BiostructdistanceSlice) -> BiostructdistanceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn bio_struct_distance_slice_copy(s : BiostructdistanceSlice) -> BiostructdistanceSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_slice_fill(s : BiostructdistanceSlice, v : Double) -> BiostructdistanceSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn bio_struct_distance_slice_min(s : BiostructdistanceSlice) -> Double { @_common.min(s.data) }

pub fn bio_struct_distance_slice_max(s : BiostructdistanceSlice) -> Double { @_common.max(s.data) }

pub fn bio_struct_distance_slice_to_string(s : BiostructdistanceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

