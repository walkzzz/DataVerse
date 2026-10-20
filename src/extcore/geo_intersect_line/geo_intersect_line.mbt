///===
/// extcore/geo_intersect_line

pub(all) struct GeointersectlinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_line_make_point(x : Double, y : Double) -> GeointersectlinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_line_make_point3(x : Double, y : Double, z : Double) -> GeointersectlinePoint {
  { x, y, z, label: 0 }
}

pub fn GeointersectlinePoint::x(self : GeointersectlinePoint) -> Double { self.x }

pub fn GeointersectlinePoint::y(self : GeointersectlinePoint) -> Double { self.y }

pub fn GeointersectlinePoint::z(self : GeointersectlinePoint) -> Double { self.z }

pub fn GeointersectlinePoint::label(self : GeointersectlinePoint) -> Int { self.label }

pub fn GeointersectlinePoint::dist(self : GeointersectlinePoint, other : GeointersectlinePoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn GeointersectlinePoint::add(self : GeointersectlinePoint, other : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn GeointersectlinePoint::sub(self : GeointersectlinePoint, other : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn GeointersectlinePoint::scale(self : GeointersectlinePoint, s : Double) -> GeointersectlinePoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn GeointersectlinePoint::dot(self : GeointersectlinePoint, other : GeointersectlinePoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn GeointersectlinePoint::cross(self : GeointersectlinePoint, other : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn GeointersectlinePoint::norm(self : GeointersectlinePoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn GeointersectlinePoint::normalize(self : GeointersectlinePoint) -> GeointersectlinePoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectlinePoint::negate(self : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn GeointersectlinePoint::mid(self : GeointersectlinePoint, other : GeointersectlinePoint) -> GeointersectlinePoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn GeointersectlinePoint::lerp(self : GeointersectlinePoint, other : GeointersectlinePoint, t : Double) -> GeointersectlinePoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn GeointersectlinePoint::to_string(self : GeointersectlinePoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct GeointersectlineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_line_make_series(vals : Array[Double], name : String) -> GeointersectlineSeries {
  { vals, name, meta: 0 }
}

pub fn GeointersectlineSeries::len(self : GeointersectlineSeries) -> Int { self.vals.length() }

pub fn GeointersectlineSeries::sum(self : GeointersectlineSeries) -> Double { @_common.sum(self.vals) }

pub fn GeointersectlineSeries::mean(self : GeointersectlineSeries) -> Double { @_common.mean(self.vals) }

pub fn GeointersectlineSeries::min(self : GeointersectlineSeries) -> Double { @_common.min(self.vals) }

pub fn GeointersectlineSeries::max(self : GeointersectlineSeries) -> Double { @_common.max(self.vals) }

pub fn GeointersectlineSeries::range(self : GeointersectlineSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn GeointersectlineSeries::variance(self : GeointersectlineSeries) -> Double { @_common.variance(self.vals) }

pub fn GeointersectlineSeries::std(self : GeointersectlineSeries) -> Double { @_common.std(self.vals) }

pub fn GeointersectlineSeries::median(self : GeointersectlineSeries) -> Double { @_common.median(self.vals) }

pub fn GeointersectlineSeries::scale(self : GeointersectlineSeries, f : Double) -> GeointersectlineSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn GeointersectlineSeries::add(self : GeointersectlineSeries, other : GeointersectlineSeries) -> GeointersectlineSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn GeointersectlineSeries::sub(self : GeointersectlineSeries, other : GeointersectlineSeries) -> GeointersectlineSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn GeointersectlineSeries::normalize(self : GeointersectlineSeries) -> GeointersectlineSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn GeointersectlineSeries::cumsum(self : GeointersectlineSeries) -> GeointersectlineSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn GeointersectlineSeries::to_string(self : GeointersectlineSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectlineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_line_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectlineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_line_matrix_identity(n : Int) -> GeointersectlineMatrix {
  let m = geo_intersect_line_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn GeointersectlineMatrix::get(self : GeointersectlineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn GeointersectlineMatrix::transpose(self : GeointersectlineMatrix) -> GeointersectlineMatrix {
  let result = geo_intersect_line_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn GeointersectlineMatrix::add(self : GeointersectlineMatrix, other : GeointersectlineMatrix) -> GeointersectlineMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = geo_intersect_line_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn GeointersectlineMatrix::scale(self : GeointersectlineMatrix, s : Double) -> GeointersectlineMatrix {
  let result = geo_intersect_line_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn GeointersectlineMatrix::multiply(self : GeointersectlineMatrix, other : GeointersectlineMatrix) -> GeointersectlineMatrix {
  if self.cols != other.rows { return geo_intersect_line_make_matrix(self.rows, other.cols, 0.0) }
  let result = geo_intersect_line_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn GeointersectlineMatrix::trace(self : GeointersectlineMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn GeointersectlineMatrix::det(self : GeointersectlineMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn GeointersectlineMatrix::norm(self : GeointersectlineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn GeointersectlineMatrix::to_string(self : GeointersectlineMatrix) -> String {
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

pub(all) struct GeointersectlineVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_line_make_vector(comps : Array[Double]) -> GeointersectlineVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_line_vector_zero(dim : Int) -> GeointersectlineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn GeointersectlineVector::add(self : GeointersectlineVector, other : GeointersectlineVector) -> GeointersectlineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectlineVector::sub(self : GeointersectlineVector, other : GeointersectlineVector) -> GeointersectlineVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn GeointersectlineVector::scale(self : GeointersectlineVector, s : Double) -> GeointersectlineVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn GeointersectlineVector::dot(self : GeointersectlineVector, other : GeointersectlineVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn GeointersectlineVector::norm(self : GeointersectlineVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn GeointersectlineVector::normalize(self : GeointersectlineVector) -> GeointersectlineVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn GeointersectlineVector::dist(self : GeointersectlineVector, other : GeointersectlineVector) -> Double {
  self.sub(other).norm()
}

pub fn GeointersectlineVector::to_string(self : GeointersectlineVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_line_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn geo_intersect_line_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn geo_intersect_line_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn geo_intersect_line_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn geo_intersect_line_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn geo_intersect_line_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn geo_intersect_line_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn geo_intersect_line_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn geo_intersect_line_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn geo_intersect_line_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn geo_intersect_line_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn geo_intersect_line_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn geo_intersect_line_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn geo_intersect_line_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn geo_intersect_line_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn geo_intersect_line_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn geo_intersect_line_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn geo_intersect_line_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn geo_intersect_line_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn geo_intersect_line_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn geo_intersect_line_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn geo_intersect_line_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn geo_intersect_line_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn geo_intersect_line_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn geo_intersect_line_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn geo_intersect_line_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn geo_intersect_line_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn geo_intersect_line_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn geo_intersect_line_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct GeointersectlineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_frame_make(size : Int) -> GeointersectlineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_frame_len(s : GeointersectlineFrame) -> Int { s.size }

pub fn geo_intersect_line_frame_get(s : GeointersectlineFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_frame_set(s : GeointersectlineFrame, i : Int, v : Double) -> GeointersectlineFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_frame_sum(s : GeointersectlineFrame) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_line_frame_mean(s : GeointersectlineFrame) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_line_frame_scale(s : GeointersectlineFrame, f : Double) -> GeointersectlineFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_frame_add(a : GeointersectlineFrame, b : GeointersectlineFrame) -> GeointersectlineFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_line_frame_copy(s : GeointersectlineFrame) -> GeointersectlineFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_frame_fill(s : GeointersectlineFrame, v : Double) -> GeointersectlineFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_frame_min(s : GeointersectlineFrame) -> Double { @_common.min(s.data) }

pub fn geo_intersect_line_frame_max(s : GeointersectlineFrame) -> Double { @_common.max(s.data) }

pub fn geo_intersect_line_frame_to_string(s : GeointersectlineFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_table_make(size : Int) -> GeointersectlineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_table_len(s : GeointersectlineTable) -> Int { s.size }

pub fn geo_intersect_line_table_get(s : GeointersectlineTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_table_set(s : GeointersectlineTable, i : Int, v : Double) -> GeointersectlineTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_table_sum(s : GeointersectlineTable) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_line_table_mean(s : GeointersectlineTable) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_line_table_scale(s : GeointersectlineTable, f : Double) -> GeointersectlineTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_table_add(a : GeointersectlineTable, b : GeointersectlineTable) -> GeointersectlineTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_line_table_copy(s : GeointersectlineTable) -> GeointersectlineTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_table_fill(s : GeointersectlineTable, v : Double) -> GeointersectlineTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_table_min(s : GeointersectlineTable) -> Double { @_common.min(s.data) }

pub fn geo_intersect_line_table_max(s : GeointersectlineTable) -> Double { @_common.max(s.data) }

pub fn geo_intersect_line_table_to_string(s : GeointersectlineTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_graphn_make(size : Int) -> GeointersectlineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_graphn_len(s : GeointersectlineGraphN) -> Int { s.size }

pub fn geo_intersect_line_graphn_get(s : GeointersectlineGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_graphn_set(s : GeointersectlineGraphN, i : Int, v : Double) -> GeointersectlineGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_graphn_sum(s : GeointersectlineGraphN) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_line_graphn_mean(s : GeointersectlineGraphN) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_line_graphn_scale(s : GeointersectlineGraphN, f : Double) -> GeointersectlineGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_graphn_add(a : GeointersectlineGraphN, b : GeointersectlineGraphN) -> GeointersectlineGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_line_graphn_copy(s : GeointersectlineGraphN) -> GeointersectlineGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_graphn_fill(s : GeointersectlineGraphN, v : Double) -> GeointersectlineGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_graphn_min(s : GeointersectlineGraphN) -> Double { @_common.min(s.data) }

pub fn geo_intersect_line_graphn_max(s : GeointersectlineGraphN) -> Double { @_common.max(s.data) }

pub fn geo_intersect_line_graphn_to_string(s : GeointersectlineGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_node_make(size : Int) -> GeointersectlineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_node_len(s : GeointersectlineNode) -> Int { s.size }

pub fn geo_intersect_line_node_get(s : GeointersectlineNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_node_set(s : GeointersectlineNode, i : Int, v : Double) -> GeointersectlineNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_node_sum(s : GeointersectlineNode) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_line_node_mean(s : GeointersectlineNode) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_line_node_scale(s : GeointersectlineNode, f : Double) -> GeointersectlineNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_node_add(a : GeointersectlineNode, b : GeointersectlineNode) -> GeointersectlineNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_line_node_copy(s : GeointersectlineNode) -> GeointersectlineNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_node_fill(s : GeointersectlineNode, v : Double) -> GeointersectlineNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_node_min(s : GeointersectlineNode) -> Double { @_common.min(s.data) }

pub fn geo_intersect_line_node_max(s : GeointersectlineNode) -> Double { @_common.max(s.data) }

pub fn geo_intersect_line_node_to_string(s : GeointersectlineNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_edge_make(size : Int) -> GeointersectlineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_edge_len(s : GeointersectlineEdge) -> Int { s.size }

pub fn geo_intersect_line_edge_get(s : GeointersectlineEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_edge_set(s : GeointersectlineEdge, i : Int, v : Double) -> GeointersectlineEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_edge_sum(s : GeointersectlineEdge) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_line_edge_mean(s : GeointersectlineEdge) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_line_edge_scale(s : GeointersectlineEdge, f : Double) -> GeointersectlineEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_edge_add(a : GeointersectlineEdge, b : GeointersectlineEdge) -> GeointersectlineEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_line_edge_copy(s : GeointersectlineEdge) -> GeointersectlineEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_edge_fill(s : GeointersectlineEdge, v : Double) -> GeointersectlineEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_edge_min(s : GeointersectlineEdge) -> Double { @_common.min(s.data) }

pub fn geo_intersect_line_edge_max(s : GeointersectlineEdge) -> Double { @_common.max(s.data) }

pub fn geo_intersect_line_edge_to_string(s : GeointersectlineEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_path_make(size : Int) -> GeointersectlinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_path_len(s : GeointersectlinePath) -> Int { s.size }

pub fn geo_intersect_line_path_get(s : GeointersectlinePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_path_set(s : GeointersectlinePath, i : Int, v : Double) -> GeointersectlinePath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_path_sum(s : GeointersectlinePath) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_line_path_mean(s : GeointersectlinePath) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_line_path_scale(s : GeointersectlinePath, f : Double) -> GeointersectlinePath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_path_add(a : GeointersectlinePath, b : GeointersectlinePath) -> GeointersectlinePath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_line_path_copy(s : GeointersectlinePath) -> GeointersectlinePath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_path_fill(s : GeointersectlinePath, v : Double) -> GeointersectlinePath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_path_min(s : GeointersectlinePath) -> Double { @_common.min(s.data) }

pub fn geo_intersect_line_path_max(s : GeointersectlinePath) -> Double { @_common.max(s.data) }

pub fn geo_intersect_line_path_to_string(s : GeointersectlinePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_cluster_make(size : Int) -> GeointersectlineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_cluster_len(s : GeointersectlineCluster) -> Int { s.size }

pub fn geo_intersect_line_cluster_get(s : GeointersectlineCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_cluster_set(s : GeointersectlineCluster, i : Int, v : Double) -> GeointersectlineCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_cluster_sum(s : GeointersectlineCluster) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_line_cluster_mean(s : GeointersectlineCluster) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_line_cluster_scale(s : GeointersectlineCluster, f : Double) -> GeointersectlineCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_cluster_add(a : GeointersectlineCluster, b : GeointersectlineCluster) -> GeointersectlineCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_line_cluster_copy(s : GeointersectlineCluster) -> GeointersectlineCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_cluster_fill(s : GeointersectlineCluster, v : Double) -> GeointersectlineCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_cluster_min(s : GeointersectlineCluster) -> Double { @_common.min(s.data) }

pub fn geo_intersect_line_cluster_max(s : GeointersectlineCluster) -> Double { @_common.max(s.data) }

pub fn geo_intersect_line_cluster_to_string(s : GeointersectlineCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_model_make(size : Int) -> GeointersectlineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_model_len(s : GeointersectlineModel) -> Int { s.size }

pub fn geo_intersect_line_model_get(s : GeointersectlineModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_model_set(s : GeointersectlineModel, i : Int, v : Double) -> GeointersectlineModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_model_sum(s : GeointersectlineModel) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_line_model_mean(s : GeointersectlineModel) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_line_model_scale(s : GeointersectlineModel, f : Double) -> GeointersectlineModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_model_add(a : GeointersectlineModel, b : GeointersectlineModel) -> GeointersectlineModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_line_model_copy(s : GeointersectlineModel) -> GeointersectlineModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_model_fill(s : GeointersectlineModel, v : Double) -> GeointersectlineModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_model_min(s : GeointersectlineModel) -> Double { @_common.min(s.data) }

pub fn geo_intersect_line_model_max(s : GeointersectlineModel) -> Double { @_common.max(s.data) }

pub fn geo_intersect_line_model_to_string(s : GeointersectlineModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_layer_make(size : Int) -> GeointersectlineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_layer_len(s : GeointersectlineLayer) -> Int { s.size }

pub fn geo_intersect_line_layer_get(s : GeointersectlineLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_layer_set(s : GeointersectlineLayer, i : Int, v : Double) -> GeointersectlineLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_layer_sum(s : GeointersectlineLayer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_line_layer_mean(s : GeointersectlineLayer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_line_layer_scale(s : GeointersectlineLayer, f : Double) -> GeointersectlineLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_layer_add(a : GeointersectlineLayer, b : GeointersectlineLayer) -> GeointersectlineLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_line_layer_copy(s : GeointersectlineLayer) -> GeointersectlineLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_layer_fill(s : GeointersectlineLayer, v : Double) -> GeointersectlineLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_layer_min(s : GeointersectlineLayer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_line_layer_max(s : GeointersectlineLayer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_line_layer_to_string(s : GeointersectlineLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_buffer_make(size : Int) -> GeointersectlineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_buffer_len(s : GeointersectlineBuffer) -> Int { s.size }

pub fn geo_intersect_line_buffer_get(s : GeointersectlineBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_buffer_set(s : GeointersectlineBuffer, i : Int, v : Double) -> GeointersectlineBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_buffer_sum(s : GeointersectlineBuffer) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_line_buffer_mean(s : GeointersectlineBuffer) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_line_buffer_scale(s : GeointersectlineBuffer, f : Double) -> GeointersectlineBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_buffer_add(a : GeointersectlineBuffer, b : GeointersectlineBuffer) -> GeointersectlineBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_line_buffer_copy(s : GeointersectlineBuffer) -> GeointersectlineBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_buffer_fill(s : GeointersectlineBuffer, v : Double) -> GeointersectlineBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_buffer_min(s : GeointersectlineBuffer) -> Double { @_common.min(s.data) }

pub fn geo_intersect_line_buffer_max(s : GeointersectlineBuffer) -> Double { @_common.max(s.data) }

pub fn geo_intersect_line_buffer_to_string(s : GeointersectlineBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_cursor_make(size : Int) -> GeointersectlineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_cursor_len(s : GeointersectlineCursor) -> Int { s.size }

pub fn geo_intersect_line_cursor_get(s : GeointersectlineCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_cursor_set(s : GeointersectlineCursor, i : Int, v : Double) -> GeointersectlineCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_cursor_sum(s : GeointersectlineCursor) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_line_cursor_mean(s : GeointersectlineCursor) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_line_cursor_scale(s : GeointersectlineCursor, f : Double) -> GeointersectlineCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_cursor_add(a : GeointersectlineCursor, b : GeointersectlineCursor) -> GeointersectlineCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_line_cursor_copy(s : GeointersectlineCursor) -> GeointersectlineCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_cursor_fill(s : GeointersectlineCursor, v : Double) -> GeointersectlineCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_cursor_min(s : GeointersectlineCursor) -> Double { @_common.min(s.data) }

pub fn geo_intersect_line_cursor_max(s : GeointersectlineCursor) -> Double { @_common.max(s.data) }

pub fn geo_intersect_line_cursor_to_string(s : GeointersectlineCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_view_make(size : Int) -> GeointersectlineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_view_len(s : GeointersectlineView) -> Int { s.size }

pub fn geo_intersect_line_view_get(s : GeointersectlineView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_view_set(s : GeointersectlineView, i : Int, v : Double) -> GeointersectlineView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_view_sum(s : GeointersectlineView) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_line_view_mean(s : GeointersectlineView) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_line_view_scale(s : GeointersectlineView, f : Double) -> GeointersectlineView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_view_add(a : GeointersectlineView, b : GeointersectlineView) -> GeointersectlineView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_line_view_copy(s : GeointersectlineView) -> GeointersectlineView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_view_fill(s : GeointersectlineView, v : Double) -> GeointersectlineView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_view_min(s : GeointersectlineView) -> Double { @_common.min(s.data) }

pub fn geo_intersect_line_view_max(s : GeointersectlineView) -> Double { @_common.max(s.data) }

pub fn geo_intersect_line_view_to_string(s : GeointersectlineView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_range_make(size : Int) -> GeointersectlineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_range_len(s : GeointersectlineRange) -> Int { s.size }

pub fn geo_intersect_line_range_get(s : GeointersectlineRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_range_set(s : GeointersectlineRange, i : Int, v : Double) -> GeointersectlineRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_range_sum(s : GeointersectlineRange) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_line_range_mean(s : GeointersectlineRange) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_line_range_scale(s : GeointersectlineRange, f : Double) -> GeointersectlineRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_range_add(a : GeointersectlineRange, b : GeointersectlineRange) -> GeointersectlineRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_line_range_copy(s : GeointersectlineRange) -> GeointersectlineRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_range_fill(s : GeointersectlineRange, v : Double) -> GeointersectlineRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_range_min(s : GeointersectlineRange) -> Double { @_common.min(s.data) }

pub fn geo_intersect_line_range_max(s : GeointersectlineRange) -> Double { @_common.max(s.data) }

pub fn geo_intersect_line_range_to_string(s : GeointersectlineRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectlineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_line_slice_make(size : Int) -> GeointersectlineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_line_slice_len(s : GeointersectlineSlice) -> Int { s.size }

pub fn geo_intersect_line_slice_get(s : GeointersectlineSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_line_slice_set(s : GeointersectlineSlice, i : Int, v : Double) -> GeointersectlineSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_slice_sum(s : GeointersectlineSlice) -> Double { @_common.sum(s.data) }

pub fn geo_intersect_line_slice_mean(s : GeointersectlineSlice) -> Double { @_common.mean(s.data) }

pub fn geo_intersect_line_slice_scale(s : GeointersectlineSlice, f : Double) -> GeointersectlineSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_slice_add(a : GeointersectlineSlice, b : GeointersectlineSlice) -> GeointersectlineSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn geo_intersect_line_slice_copy(s : GeointersectlineSlice) -> GeointersectlineSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_slice_fill(s : GeointersectlineSlice, v : Double) -> GeointersectlineSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn geo_intersect_line_slice_min(s : GeointersectlineSlice) -> Double { @_common.min(s.data) }

pub fn geo_intersect_line_slice_max(s : GeointersectlineSlice) -> Double { @_common.max(s.data) }

pub fn geo_intersect_line_slice_to_string(s : GeointersectlineSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

