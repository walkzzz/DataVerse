///===
/// extcore/geo_proj_albers

pub(all) struct GeoprojalbersPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_albers_make_point(x : Double, y : Double) -> GeoprojalbersPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_albers_make_point3(x : Double, y : Double, z : Double) -> GeoprojalbersPoint {
  { x, y, z, label: 0 }
}

pub fn GeoprojalbersPoint::x(self : GeoprojalbersPoint) -> Double { self.x }

pub fn GeoprojalbersPoint::y(self : GeoprojalbersPoint) -> Double { self.y }

pub fn GeoprojalbersPoint::z(self : GeoprojalbersPoint) -> Double { self.z }

pub fn GeoprojalbersPoint::label(self : GeoprojalbersPoint) -> Int { self.label }

pub fn GeoprojalbersPoint::dist(self : GeoprojalbersPoint, other : GeoprojalbersPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeoprojalbersPoint::add(self : GeoprojalbersPoint, other : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeoprojalbersPoint::sub(self : GeoprojalbersPoint, other : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeoprojalbersPoint::scale(self : GeoprojalbersPoint, s : Double) -> GeoprojalbersPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeoprojalbersPoint::dot(self : GeoprojalbersPoint, other : GeoprojalbersPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeoprojalbersPoint::cross(self : GeoprojalbersPoint, other : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeoprojalbersPoint::norm(self : GeoprojalbersPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeoprojalbersPoint::normalize(self : GeoprojalbersPoint) -> GeoprojalbersPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojalbersPoint::negate(self : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeoprojalbersPoint::mid(self : GeoprojalbersPoint, other : GeoprojalbersPoint) -> GeoprojalbersPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeoprojalbersPoint::lerp(self : GeoprojalbersPoint, other : GeoprojalbersPoint, t : Double) -> GeoprojalbersPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeoprojalbersPoint::to_string(self : GeoprojalbersPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeoprojalbersSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_albers_make_series(vals : Array[Double], name : String) -> GeoprojalbersSeries {
  { vals, name, meta: 0 }
}

pub fn GeoprojalbersSeries::len(self : GeoprojalbersSeries) -> Int { self.vals.length() }

pub fn GeoprojalbersSeries::sum(self : GeoprojalbersSeries) -> Double { @_common.sum(self.vals) }

pub fn GeoprojalbersSeries::mean(self : GeoprojalbersSeries) -> Double { @_common.mean(self.vals) }

pub fn GeoprojalbersSeries::min(self : GeoprojalbersSeries) -> Double { @_common.min(self.vals) }

pub fn GeoprojalbersSeries::max(self : GeoprojalbersSeries) -> Double { @_common.max(self.vals) }

pub fn GeoprojalbersSeries::range(self : GeoprojalbersSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeoprojalbersSeries::variance(self : GeoprojalbersSeries) -> Double { @_common.variance(self.vals) }

pub fn GeoprojalbersSeries::std(self : GeoprojalbersSeries) -> Double { @_common.std(self.vals) }

pub fn GeoprojalbersSeries::median(self : GeoprojalbersSeries) -> Double { @_common.median(self.vals) }

pub fn GeoprojalbersSeries::scale(self : GeoprojalbersSeries, f : Double) -> GeoprojalbersSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeoprojalbersSeries::add(self : GeoprojalbersSeries, other : GeoprojalbersSeries) -> GeoprojalbersSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeoprojalbersSeries::sub(self : GeoprojalbersSeries, other : GeoprojalbersSeries) -> GeoprojalbersSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeoprojalbersSeries::normalize(self : GeoprojalbersSeries) -> GeoprojalbersSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeoprojalbersSeries::cumsum(self : GeoprojalbersSeries) -> GeoprojalbersSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeoprojalbersSeries::to_string(self : GeoprojalbersSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojalbersMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_albers_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojalbersMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_albers_matrix_identity(n : Int) -> GeoprojalbersMatrix {
  let m = geo_proj_albers_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeoprojalbersMatrix::get(self : GeoprojalbersMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeoprojalbersMatrix::transpose(self : GeoprojalbersMatrix) -> GeoprojalbersMatrix {
  let result = geo_proj_albers_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeoprojalbersMatrix::add(self : GeoprojalbersMatrix, other : GeoprojalbersMatrix) -> GeoprojalbersMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_proj_albers_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeoprojalbersMatrix::scale(self : GeoprojalbersMatrix, s : Double) -> GeoprojalbersMatrix {
  let result = geo_proj_albers_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeoprojalbersMatrix::multiply(self : GeoprojalbersMatrix, other : GeoprojalbersMatrix) -> GeoprojalbersMatrix {
  if self.cols != other.rows { return geo_proj_albers_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_proj_albers_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeoprojalbersMatrix::trace(self : GeoprojalbersMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeoprojalbersMatrix::det(self : GeoprojalbersMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeoprojalbersMatrix::norm(self : GeoprojalbersMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeoprojalbersMatrix::to_string(self : GeoprojalbersMatrix) -> String {
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

pub(all) struct GeoprojalbersVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_albers_make_vector(comps : Array[Double]) -> GeoprojalbersVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_albers_vector_zero(dim : Int) -> GeoprojalbersVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeoprojalbersVector::add(self : GeoprojalbersVector, other : GeoprojalbersVector) -> GeoprojalbersVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojalbersVector::sub(self : GeoprojalbersVector, other : GeoprojalbersVector) -> GeoprojalbersVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeoprojalbersVector::scale(self : GeoprojalbersVector, s : Double) -> GeoprojalbersVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeoprojalbersVector::dot(self : GeoprojalbersVector, other : GeoprojalbersVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeoprojalbersVector::norm(self : GeoprojalbersVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeoprojalbersVector::normalize(self : GeoprojalbersVector) -> GeoprojalbersVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeoprojalbersVector::dist(self : GeoprojalbersVector, other : GeoprojalbersVector) -> Double {
  self.sub(other).norm()
}

pub fn GeoprojalbersVector::to_string(self : GeoprojalbersVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_albers_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_proj_albers_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_proj_albers_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_proj_albers_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_proj_albers_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_proj_albers_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_proj_albers_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_proj_albers_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_proj_albers_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_proj_albers_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_proj_albers_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_proj_albers_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_proj_albers_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_proj_albers_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_proj_albers_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_proj_albers_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_proj_albers_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_proj_albers_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_proj_albers_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_proj_albers_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_proj_albers_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_proj_albers_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_proj_albers_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_proj_albers_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_proj_albers_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_proj_albers_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_proj_albers_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_proj_albers_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_proj_albers_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeoprojalbersFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_frame_make(size : Int) -> GeoprojalbersFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_frame_len(s : GeoprojalbersFrame) -> Int { s.size }

pub fn geo_proj_albers_frame_get(s : GeoprojalbersFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_frame_set(s : GeoprojalbersFrame, i : Int, v : Double) -> GeoprojalbersFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_frame_sum(s : GeoprojalbersFrame) -> Double { @_common.sum(s.data) }

pub fn geo_proj_albers_frame_mean(s : GeoprojalbersFrame) -> Double { @_common.mean(s.data) }

pub fn geo_proj_albers_frame_scale(s : GeoprojalbersFrame, f : Double) -> GeoprojalbersFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_frame_add(a : GeoprojalbersFrame, b : GeoprojalbersFrame) -> GeoprojalbersFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_albers_frame_copy(s : GeoprojalbersFrame) -> GeoprojalbersFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_frame_fill(s : GeoprojalbersFrame, v : Double) -> GeoprojalbersFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_frame_min(s : GeoprojalbersFrame) -> Double { @_common.min(s.data) }

pub fn geo_proj_albers_frame_max(s : GeoprojalbersFrame) -> Double { @_common.max(s.data) }

pub fn geo_proj_albers_frame_to_string(s : GeoprojalbersFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_table_make(size : Int) -> GeoprojalbersTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_table_len(s : GeoprojalbersTable) -> Int { s.size }

pub fn geo_proj_albers_table_get(s : GeoprojalbersTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_table_set(s : GeoprojalbersTable, i : Int, v : Double) -> GeoprojalbersTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_table_sum(s : GeoprojalbersTable) -> Double { @_common.sum(s.data) }

pub fn geo_proj_albers_table_mean(s : GeoprojalbersTable) -> Double { @_common.mean(s.data) }

pub fn geo_proj_albers_table_scale(s : GeoprojalbersTable, f : Double) -> GeoprojalbersTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_table_add(a : GeoprojalbersTable, b : GeoprojalbersTable) -> GeoprojalbersTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_albers_table_copy(s : GeoprojalbersTable) -> GeoprojalbersTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_table_fill(s : GeoprojalbersTable, v : Double) -> GeoprojalbersTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_table_min(s : GeoprojalbersTable) -> Double { @_common.min(s.data) }

pub fn geo_proj_albers_table_max(s : GeoprojalbersTable) -> Double { @_common.max(s.data) }

pub fn geo_proj_albers_table_to_string(s : GeoprojalbersTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_graphn_make(size : Int) -> GeoprojalbersGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_graphn_len(s : GeoprojalbersGraphN) -> Int { s.size }

pub fn geo_proj_albers_graphn_get(s : GeoprojalbersGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_graphn_set(s : GeoprojalbersGraphN, i : Int, v : Double) -> GeoprojalbersGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_graphn_sum(s : GeoprojalbersGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_proj_albers_graphn_mean(s : GeoprojalbersGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_proj_albers_graphn_scale(s : GeoprojalbersGraphN, f : Double) -> GeoprojalbersGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_graphn_add(a : GeoprojalbersGraphN, b : GeoprojalbersGraphN) -> GeoprojalbersGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_albers_graphn_copy(s : GeoprojalbersGraphN) -> GeoprojalbersGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_graphn_fill(s : GeoprojalbersGraphN, v : Double) -> GeoprojalbersGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_graphn_min(s : GeoprojalbersGraphN) -> Double { @_common.min(s.data) }

pub fn geo_proj_albers_graphn_max(s : GeoprojalbersGraphN) -> Double { @_common.max(s.data) }

pub fn geo_proj_albers_graphn_to_string(s : GeoprojalbersGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_node_make(size : Int) -> GeoprojalbersNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_node_len(s : GeoprojalbersNode) -> Int { s.size }

pub fn geo_proj_albers_node_get(s : GeoprojalbersNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_node_set(s : GeoprojalbersNode, i : Int, v : Double) -> GeoprojalbersNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_node_sum(s : GeoprojalbersNode) -> Double { @_common.sum(s.data) }

pub fn geo_proj_albers_node_mean(s : GeoprojalbersNode) -> Double { @_common.mean(s.data) }

pub fn geo_proj_albers_node_scale(s : GeoprojalbersNode, f : Double) -> GeoprojalbersNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_node_add(a : GeoprojalbersNode, b : GeoprojalbersNode) -> GeoprojalbersNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_albers_node_copy(s : GeoprojalbersNode) -> GeoprojalbersNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_node_fill(s : GeoprojalbersNode, v : Double) -> GeoprojalbersNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_node_min(s : GeoprojalbersNode) -> Double { @_common.min(s.data) }

pub fn geo_proj_albers_node_max(s : GeoprojalbersNode) -> Double { @_common.max(s.data) }

pub fn geo_proj_albers_node_to_string(s : GeoprojalbersNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_edge_make(size : Int) -> GeoprojalbersEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_edge_len(s : GeoprojalbersEdge) -> Int { s.size }

pub fn geo_proj_albers_edge_get(s : GeoprojalbersEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_edge_set(s : GeoprojalbersEdge, i : Int, v : Double) -> GeoprojalbersEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_edge_sum(s : GeoprojalbersEdge) -> Double { @_common.sum(s.data) }

pub fn geo_proj_albers_edge_mean(s : GeoprojalbersEdge) -> Double { @_common.mean(s.data) }

pub fn geo_proj_albers_edge_scale(s : GeoprojalbersEdge, f : Double) -> GeoprojalbersEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_edge_add(a : GeoprojalbersEdge, b : GeoprojalbersEdge) -> GeoprojalbersEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_albers_edge_copy(s : GeoprojalbersEdge) -> GeoprojalbersEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_edge_fill(s : GeoprojalbersEdge, v : Double) -> GeoprojalbersEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_edge_min(s : GeoprojalbersEdge) -> Double { @_common.min(s.data) }

pub fn geo_proj_albers_edge_max(s : GeoprojalbersEdge) -> Double { @_common.max(s.data) }

pub fn geo_proj_albers_edge_to_string(s : GeoprojalbersEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_path_make(size : Int) -> GeoprojalbersPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_path_len(s : GeoprojalbersPath) -> Int { s.size }

pub fn geo_proj_albers_path_get(s : GeoprojalbersPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_path_set(s : GeoprojalbersPath, i : Int, v : Double) -> GeoprojalbersPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_path_sum(s : GeoprojalbersPath) -> Double { @_common.sum(s.data) }

pub fn geo_proj_albers_path_mean(s : GeoprojalbersPath) -> Double { @_common.mean(s.data) }

pub fn geo_proj_albers_path_scale(s : GeoprojalbersPath, f : Double) -> GeoprojalbersPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_path_add(a : GeoprojalbersPath, b : GeoprojalbersPath) -> GeoprojalbersPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_albers_path_copy(s : GeoprojalbersPath) -> GeoprojalbersPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_path_fill(s : GeoprojalbersPath, v : Double) -> GeoprojalbersPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_path_min(s : GeoprojalbersPath) -> Double { @_common.min(s.data) }

pub fn geo_proj_albers_path_max(s : GeoprojalbersPath) -> Double { @_common.max(s.data) }

pub fn geo_proj_albers_path_to_string(s : GeoprojalbersPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_cluster_make(size : Int) -> GeoprojalbersCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_cluster_len(s : GeoprojalbersCluster) -> Int { s.size }

pub fn geo_proj_albers_cluster_get(s : GeoprojalbersCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_cluster_set(s : GeoprojalbersCluster, i : Int, v : Double) -> GeoprojalbersCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_cluster_sum(s : GeoprojalbersCluster) -> Double { @_common.sum(s.data) }

pub fn geo_proj_albers_cluster_mean(s : GeoprojalbersCluster) -> Double { @_common.mean(s.data) }

pub fn geo_proj_albers_cluster_scale(s : GeoprojalbersCluster, f : Double) -> GeoprojalbersCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_cluster_add(a : GeoprojalbersCluster, b : GeoprojalbersCluster) -> GeoprojalbersCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_albers_cluster_copy(s : GeoprojalbersCluster) -> GeoprojalbersCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_cluster_fill(s : GeoprojalbersCluster, v : Double) -> GeoprojalbersCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_cluster_min(s : GeoprojalbersCluster) -> Double { @_common.min(s.data) }

pub fn geo_proj_albers_cluster_max(s : GeoprojalbersCluster) -> Double { @_common.max(s.data) }

pub fn geo_proj_albers_cluster_to_string(s : GeoprojalbersCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_model_make(size : Int) -> GeoprojalbersModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_model_len(s : GeoprojalbersModel) -> Int { s.size }

pub fn geo_proj_albers_model_get(s : GeoprojalbersModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_model_set(s : GeoprojalbersModel, i : Int, v : Double) -> GeoprojalbersModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_model_sum(s : GeoprojalbersModel) -> Double { @_common.sum(s.data) }

pub fn geo_proj_albers_model_mean(s : GeoprojalbersModel) -> Double { @_common.mean(s.data) }

pub fn geo_proj_albers_model_scale(s : GeoprojalbersModel, f : Double) -> GeoprojalbersModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_model_add(a : GeoprojalbersModel, b : GeoprojalbersModel) -> GeoprojalbersModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_albers_model_copy(s : GeoprojalbersModel) -> GeoprojalbersModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_model_fill(s : GeoprojalbersModel, v : Double) -> GeoprojalbersModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_model_min(s : GeoprojalbersModel) -> Double { @_common.min(s.data) }

pub fn geo_proj_albers_model_max(s : GeoprojalbersModel) -> Double { @_common.max(s.data) }

pub fn geo_proj_albers_model_to_string(s : GeoprojalbersModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_layer_make(size : Int) -> GeoprojalbersLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_layer_len(s : GeoprojalbersLayer) -> Int { s.size }

pub fn geo_proj_albers_layer_get(s : GeoprojalbersLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_layer_set(s : GeoprojalbersLayer, i : Int, v : Double) -> GeoprojalbersLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_layer_sum(s : GeoprojalbersLayer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_albers_layer_mean(s : GeoprojalbersLayer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_albers_layer_scale(s : GeoprojalbersLayer, f : Double) -> GeoprojalbersLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_layer_add(a : GeoprojalbersLayer, b : GeoprojalbersLayer) -> GeoprojalbersLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_albers_layer_copy(s : GeoprojalbersLayer) -> GeoprojalbersLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_layer_fill(s : GeoprojalbersLayer, v : Double) -> GeoprojalbersLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_layer_min(s : GeoprojalbersLayer) -> Double { @_common.min(s.data) }

pub fn geo_proj_albers_layer_max(s : GeoprojalbersLayer) -> Double { @_common.max(s.data) }

pub fn geo_proj_albers_layer_to_string(s : GeoprojalbersLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_buffer_make(size : Int) -> GeoprojalbersBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_buffer_len(s : GeoprojalbersBuffer) -> Int { s.size }

pub fn geo_proj_albers_buffer_get(s : GeoprojalbersBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_buffer_set(s : GeoprojalbersBuffer, i : Int, v : Double) -> GeoprojalbersBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_buffer_sum(s : GeoprojalbersBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_proj_albers_buffer_mean(s : GeoprojalbersBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_proj_albers_buffer_scale(s : GeoprojalbersBuffer, f : Double) -> GeoprojalbersBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_buffer_add(a : GeoprojalbersBuffer, b : GeoprojalbersBuffer) -> GeoprojalbersBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_albers_buffer_copy(s : GeoprojalbersBuffer) -> GeoprojalbersBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_buffer_fill(s : GeoprojalbersBuffer, v : Double) -> GeoprojalbersBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_buffer_min(s : GeoprojalbersBuffer) -> Double { @_common.min(s.data) }

pub fn geo_proj_albers_buffer_max(s : GeoprojalbersBuffer) -> Double { @_common.max(s.data) }

pub fn geo_proj_albers_buffer_to_string(s : GeoprojalbersBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_cursor_make(size : Int) -> GeoprojalbersCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_cursor_len(s : GeoprojalbersCursor) -> Int { s.size }

pub fn geo_proj_albers_cursor_get(s : GeoprojalbersCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_cursor_set(s : GeoprojalbersCursor, i : Int, v : Double) -> GeoprojalbersCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_cursor_sum(s : GeoprojalbersCursor) -> Double { @_common.sum(s.data) }

pub fn geo_proj_albers_cursor_mean(s : GeoprojalbersCursor) -> Double { @_common.mean(s.data) }

pub fn geo_proj_albers_cursor_scale(s : GeoprojalbersCursor, f : Double) -> GeoprojalbersCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_cursor_add(a : GeoprojalbersCursor, b : GeoprojalbersCursor) -> GeoprojalbersCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_albers_cursor_copy(s : GeoprojalbersCursor) -> GeoprojalbersCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_cursor_fill(s : GeoprojalbersCursor, v : Double) -> GeoprojalbersCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_cursor_min(s : GeoprojalbersCursor) -> Double { @_common.min(s.data) }

pub fn geo_proj_albers_cursor_max(s : GeoprojalbersCursor) -> Double { @_common.max(s.data) }

pub fn geo_proj_albers_cursor_to_string(s : GeoprojalbersCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_view_make(size : Int) -> GeoprojalbersView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_view_len(s : GeoprojalbersView) -> Int { s.size }

pub fn geo_proj_albers_view_get(s : GeoprojalbersView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_view_set(s : GeoprojalbersView, i : Int, v : Double) -> GeoprojalbersView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_view_sum(s : GeoprojalbersView) -> Double { @_common.sum(s.data) }

pub fn geo_proj_albers_view_mean(s : GeoprojalbersView) -> Double { @_common.mean(s.data) }

pub fn geo_proj_albers_view_scale(s : GeoprojalbersView, f : Double) -> GeoprojalbersView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_view_add(a : GeoprojalbersView, b : GeoprojalbersView) -> GeoprojalbersView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_albers_view_copy(s : GeoprojalbersView) -> GeoprojalbersView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_view_fill(s : GeoprojalbersView, v : Double) -> GeoprojalbersView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_view_min(s : GeoprojalbersView) -> Double { @_common.min(s.data) }

pub fn geo_proj_albers_view_max(s : GeoprojalbersView) -> Double { @_common.max(s.data) }

pub fn geo_proj_albers_view_to_string(s : GeoprojalbersView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_range_make(size : Int) -> GeoprojalbersRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_range_len(s : GeoprojalbersRange) -> Int { s.size }

pub fn geo_proj_albers_range_get(s : GeoprojalbersRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_range_set(s : GeoprojalbersRange, i : Int, v : Double) -> GeoprojalbersRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_range_sum(s : GeoprojalbersRange) -> Double { @_common.sum(s.data) }

pub fn geo_proj_albers_range_mean(s : GeoprojalbersRange) -> Double { @_common.mean(s.data) }

pub fn geo_proj_albers_range_scale(s : GeoprojalbersRange, f : Double) -> GeoprojalbersRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_range_add(a : GeoprojalbersRange, b : GeoprojalbersRange) -> GeoprojalbersRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_albers_range_copy(s : GeoprojalbersRange) -> GeoprojalbersRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_range_fill(s : GeoprojalbersRange, v : Double) -> GeoprojalbersRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_range_min(s : GeoprojalbersRange) -> Double { @_common.min(s.data) }

pub fn geo_proj_albers_range_max(s : GeoprojalbersRange) -> Double { @_common.max(s.data) }

pub fn geo_proj_albers_range_to_string(s : GeoprojalbersRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojalbersSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_albers_slice_make(size : Int) -> GeoprojalbersSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_albers_slice_len(s : GeoprojalbersSlice) -> Int { s.size }

pub fn geo_proj_albers_slice_get(s : GeoprojalbersSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_albers_slice_set(s : GeoprojalbersSlice, i : Int, v : Double) -> GeoprojalbersSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_slice_sum(s : GeoprojalbersSlice) -> Double { @_common.sum(s.data) }

pub fn geo_proj_albers_slice_mean(s : GeoprojalbersSlice) -> Double { @_common.mean(s.data) }

pub fn geo_proj_albers_slice_scale(s : GeoprojalbersSlice, f : Double) -> GeoprojalbersSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_slice_add(a : GeoprojalbersSlice, b : GeoprojalbersSlice) -> GeoprojalbersSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_proj_albers_slice_copy(s : GeoprojalbersSlice) -> GeoprojalbersSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_slice_fill(s : GeoprojalbersSlice, v : Double) -> GeoprojalbersSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_proj_albers_slice_min(s : GeoprojalbersSlice) -> Double { @_common.min(s.data) }

pub fn geo_proj_albers_slice_max(s : GeoprojalbersSlice) -> Double { @_common.max(s.data) }

pub fn geo_proj_albers_slice_to_string(s : GeoprojalbersSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

