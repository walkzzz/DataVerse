///===
/// extcore/opt_meta_differential

pub(all) struct OptmetadifferentialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_differential_make_point(x : Double, y : Double) -> OptmetadifferentialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_differential_make_point3(x : Double, y : Double, z : Double) -> OptmetadifferentialPoint {
  { x, y, z, label: 0 }
}

pub fn OptmetadifferentialPoint::x(self : OptmetadifferentialPoint) -> Double { self.x }

pub fn OptmetadifferentialPoint::y(self : OptmetadifferentialPoint) -> Double { self.y }

pub fn OptmetadifferentialPoint::z(self : OptmetadifferentialPoint) -> Double { self.z }

pub fn OptmetadifferentialPoint::label(self : OptmetadifferentialPoint) -> Int { self.label }

pub fn OptmetadifferentialPoint::dist(self : OptmetadifferentialPoint, other : OptmetadifferentialPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetadifferentialPoint::add(self : OptmetadifferentialPoint, other : OptmetadifferentialPoint) -> OptmetadifferentialPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetadifferentialPoint::sub(self : OptmetadifferentialPoint, other : OptmetadifferentialPoint) -> OptmetadifferentialPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetadifferentialPoint::scale(self : OptmetadifferentialPoint, s : Double) -> OptmetadifferentialPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetadifferentialPoint::dot(self : OptmetadifferentialPoint, other : OptmetadifferentialPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetadifferentialPoint::cross(self : OptmetadifferentialPoint, other : OptmetadifferentialPoint) -> OptmetadifferentialPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetadifferentialPoint::norm(self : OptmetadifferentialPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetadifferentialPoint::normalize(self : OptmetadifferentialPoint) -> OptmetadifferentialPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetadifferentialPoint::negate(self : OptmetadifferentialPoint) -> OptmetadifferentialPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetadifferentialPoint::mid(self : OptmetadifferentialPoint, other : OptmetadifferentialPoint) -> OptmetadifferentialPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetadifferentialPoint::lerp(self : OptmetadifferentialPoint, other : OptmetadifferentialPoint, t : Double) -> OptmetadifferentialPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetadifferentialPoint::to_string(self : OptmetadifferentialPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetadifferentialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_differential_make_series(vals : Array[Double], name : String) -> OptmetadifferentialSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetadifferentialSeries::len(self : OptmetadifferentialSeries) -> Int { self.vals.length() }

pub fn OptmetadifferentialSeries::sum(self : OptmetadifferentialSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetadifferentialSeries::mean(self : OptmetadifferentialSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetadifferentialSeries::min(self : OptmetadifferentialSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetadifferentialSeries::max(self : OptmetadifferentialSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetadifferentialSeries::range(self : OptmetadifferentialSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetadifferentialSeries::variance(self : OptmetadifferentialSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetadifferentialSeries::std(self : OptmetadifferentialSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetadifferentialSeries::median(self : OptmetadifferentialSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetadifferentialSeries::scale(self : OptmetadifferentialSeries, f : Double) -> OptmetadifferentialSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetadifferentialSeries::add(self : OptmetadifferentialSeries, other : OptmetadifferentialSeries) -> OptmetadifferentialSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetadifferentialSeries::sub(self : OptmetadifferentialSeries, other : OptmetadifferentialSeries) -> OptmetadifferentialSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetadifferentialSeries::normalize(self : OptmetadifferentialSeries) -> OptmetadifferentialSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetadifferentialSeries::cumsum(self : OptmetadifferentialSeries) -> OptmetadifferentialSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetadifferentialSeries::to_string(self : OptmetadifferentialSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetadifferentialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_differential_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetadifferentialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_differential_matrix_identity(n : Int) -> OptmetadifferentialMatrix {
  let m = opt_meta_differential_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetadifferentialMatrix::get(self : OptmetadifferentialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetadifferentialMatrix::transpose(self : OptmetadifferentialMatrix) -> OptmetadifferentialMatrix {
  let result = opt_meta_differential_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetadifferentialMatrix::add(self : OptmetadifferentialMatrix, other : OptmetadifferentialMatrix) -> OptmetadifferentialMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_differential_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetadifferentialMatrix::scale(self : OptmetadifferentialMatrix, s : Double) -> OptmetadifferentialMatrix {
  let result = opt_meta_differential_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetadifferentialMatrix::multiply(self : OptmetadifferentialMatrix, other : OptmetadifferentialMatrix) -> OptmetadifferentialMatrix {
  if self.cols != other.rows { return opt_meta_differential_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_differential_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptmetadifferentialMatrix::trace(self : OptmetadifferentialMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetadifferentialMatrix::det(self : OptmetadifferentialMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetadifferentialMatrix::norm(self : OptmetadifferentialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetadifferentialMatrix::to_string(self : OptmetadifferentialMatrix) -> String {
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

pub(all) struct OptmetadifferentialVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_differential_make_vector(comps : Array[Double]) -> OptmetadifferentialVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_differential_vector_zero(dim : Int) -> OptmetadifferentialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetadifferentialVector::add(self : OptmetadifferentialVector, other : OptmetadifferentialVector) -> OptmetadifferentialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetadifferentialVector::sub(self : OptmetadifferentialVector, other : OptmetadifferentialVector) -> OptmetadifferentialVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetadifferentialVector::scale(self : OptmetadifferentialVector, s : Double) -> OptmetadifferentialVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetadifferentialVector::dot(self : OptmetadifferentialVector, other : OptmetadifferentialVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetadifferentialVector::norm(self : OptmetadifferentialVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetadifferentialVector::normalize(self : OptmetadifferentialVector) -> OptmetadifferentialVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetadifferentialVector::dist(self : OptmetadifferentialVector, other : OptmetadifferentialVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetadifferentialVector::to_string(self : OptmetadifferentialVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_differential_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_differential_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_differential_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_differential_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_differential_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_differential_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_differential_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_differential_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_differential_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_differential_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_differential_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_differential_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_differential_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_differential_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_differential_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_differential_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_differential_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_differential_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_differential_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_differential_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_differential_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_differential_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_differential_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_differential_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_differential_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_differential_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_differential_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_differential_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_differential_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetadifferentialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_frame_make(size : Int) -> OptmetadifferentialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_frame_len(s : OptmetadifferentialFrame) -> Int { s.size }

pub fn opt_meta_differential_frame_get(s : OptmetadifferentialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_frame_set(s : OptmetadifferentialFrame, i : Int, v : Double) -> OptmetadifferentialFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_frame_sum(s : OptmetadifferentialFrame) -> Double { @_common.sum(s.data) }

pub fn opt_meta_differential_frame_mean(s : OptmetadifferentialFrame) -> Double { @_common.mean(s.data) }

pub fn opt_meta_differential_frame_scale(s : OptmetadifferentialFrame, f : Double) -> OptmetadifferentialFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_frame_add(a : OptmetadifferentialFrame, b : OptmetadifferentialFrame) -> OptmetadifferentialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_differential_frame_copy(s : OptmetadifferentialFrame) -> OptmetadifferentialFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_frame_fill(s : OptmetadifferentialFrame, v : Double) -> OptmetadifferentialFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_frame_min(s : OptmetadifferentialFrame) -> Double { @_common.min(s.data) }

pub fn opt_meta_differential_frame_max(s : OptmetadifferentialFrame) -> Double { @_common.max(s.data) }

pub fn opt_meta_differential_frame_to_string(s : OptmetadifferentialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_table_make(size : Int) -> OptmetadifferentialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_table_len(s : OptmetadifferentialTable) -> Int { s.size }

pub fn opt_meta_differential_table_get(s : OptmetadifferentialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_table_set(s : OptmetadifferentialTable, i : Int, v : Double) -> OptmetadifferentialTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_table_sum(s : OptmetadifferentialTable) -> Double { @_common.sum(s.data) }

pub fn opt_meta_differential_table_mean(s : OptmetadifferentialTable) -> Double { @_common.mean(s.data) }

pub fn opt_meta_differential_table_scale(s : OptmetadifferentialTable, f : Double) -> OptmetadifferentialTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_table_add(a : OptmetadifferentialTable, b : OptmetadifferentialTable) -> OptmetadifferentialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_differential_table_copy(s : OptmetadifferentialTable) -> OptmetadifferentialTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_table_fill(s : OptmetadifferentialTable, v : Double) -> OptmetadifferentialTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_table_min(s : OptmetadifferentialTable) -> Double { @_common.min(s.data) }

pub fn opt_meta_differential_table_max(s : OptmetadifferentialTable) -> Double { @_common.max(s.data) }

pub fn opt_meta_differential_table_to_string(s : OptmetadifferentialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_graphn_make(size : Int) -> OptmetadifferentialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_graphn_len(s : OptmetadifferentialGraphN) -> Int { s.size }

pub fn opt_meta_differential_graphn_get(s : OptmetadifferentialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_graphn_set(s : OptmetadifferentialGraphN, i : Int, v : Double) -> OptmetadifferentialGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_graphn_sum(s : OptmetadifferentialGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_meta_differential_graphn_mean(s : OptmetadifferentialGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_meta_differential_graphn_scale(s : OptmetadifferentialGraphN, f : Double) -> OptmetadifferentialGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_graphn_add(a : OptmetadifferentialGraphN, b : OptmetadifferentialGraphN) -> OptmetadifferentialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_differential_graphn_copy(s : OptmetadifferentialGraphN) -> OptmetadifferentialGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_graphn_fill(s : OptmetadifferentialGraphN, v : Double) -> OptmetadifferentialGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_graphn_min(s : OptmetadifferentialGraphN) -> Double { @_common.min(s.data) }

pub fn opt_meta_differential_graphn_max(s : OptmetadifferentialGraphN) -> Double { @_common.max(s.data) }

pub fn opt_meta_differential_graphn_to_string(s : OptmetadifferentialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_node_make(size : Int) -> OptmetadifferentialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_node_len(s : OptmetadifferentialNode) -> Int { s.size }

pub fn opt_meta_differential_node_get(s : OptmetadifferentialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_node_set(s : OptmetadifferentialNode, i : Int, v : Double) -> OptmetadifferentialNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_node_sum(s : OptmetadifferentialNode) -> Double { @_common.sum(s.data) }

pub fn opt_meta_differential_node_mean(s : OptmetadifferentialNode) -> Double { @_common.mean(s.data) }

pub fn opt_meta_differential_node_scale(s : OptmetadifferentialNode, f : Double) -> OptmetadifferentialNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_node_add(a : OptmetadifferentialNode, b : OptmetadifferentialNode) -> OptmetadifferentialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_differential_node_copy(s : OptmetadifferentialNode) -> OptmetadifferentialNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_node_fill(s : OptmetadifferentialNode, v : Double) -> OptmetadifferentialNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_node_min(s : OptmetadifferentialNode) -> Double { @_common.min(s.data) }

pub fn opt_meta_differential_node_max(s : OptmetadifferentialNode) -> Double { @_common.max(s.data) }

pub fn opt_meta_differential_node_to_string(s : OptmetadifferentialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_edge_make(size : Int) -> OptmetadifferentialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_edge_len(s : OptmetadifferentialEdge) -> Int { s.size }

pub fn opt_meta_differential_edge_get(s : OptmetadifferentialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_edge_set(s : OptmetadifferentialEdge, i : Int, v : Double) -> OptmetadifferentialEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_edge_sum(s : OptmetadifferentialEdge) -> Double { @_common.sum(s.data) }

pub fn opt_meta_differential_edge_mean(s : OptmetadifferentialEdge) -> Double { @_common.mean(s.data) }

pub fn opt_meta_differential_edge_scale(s : OptmetadifferentialEdge, f : Double) -> OptmetadifferentialEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_edge_add(a : OptmetadifferentialEdge, b : OptmetadifferentialEdge) -> OptmetadifferentialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_differential_edge_copy(s : OptmetadifferentialEdge) -> OptmetadifferentialEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_edge_fill(s : OptmetadifferentialEdge, v : Double) -> OptmetadifferentialEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_edge_min(s : OptmetadifferentialEdge) -> Double { @_common.min(s.data) }

pub fn opt_meta_differential_edge_max(s : OptmetadifferentialEdge) -> Double { @_common.max(s.data) }

pub fn opt_meta_differential_edge_to_string(s : OptmetadifferentialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_path_make(size : Int) -> OptmetadifferentialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_path_len(s : OptmetadifferentialPath) -> Int { s.size }

pub fn opt_meta_differential_path_get(s : OptmetadifferentialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_path_set(s : OptmetadifferentialPath, i : Int, v : Double) -> OptmetadifferentialPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_path_sum(s : OptmetadifferentialPath) -> Double { @_common.sum(s.data) }

pub fn opt_meta_differential_path_mean(s : OptmetadifferentialPath) -> Double { @_common.mean(s.data) }

pub fn opt_meta_differential_path_scale(s : OptmetadifferentialPath, f : Double) -> OptmetadifferentialPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_path_add(a : OptmetadifferentialPath, b : OptmetadifferentialPath) -> OptmetadifferentialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_differential_path_copy(s : OptmetadifferentialPath) -> OptmetadifferentialPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_path_fill(s : OptmetadifferentialPath, v : Double) -> OptmetadifferentialPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_path_min(s : OptmetadifferentialPath) -> Double { @_common.min(s.data) }

pub fn opt_meta_differential_path_max(s : OptmetadifferentialPath) -> Double { @_common.max(s.data) }

pub fn opt_meta_differential_path_to_string(s : OptmetadifferentialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_cluster_make(size : Int) -> OptmetadifferentialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_cluster_len(s : OptmetadifferentialCluster) -> Int { s.size }

pub fn opt_meta_differential_cluster_get(s : OptmetadifferentialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_cluster_set(s : OptmetadifferentialCluster, i : Int, v : Double) -> OptmetadifferentialCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_cluster_sum(s : OptmetadifferentialCluster) -> Double { @_common.sum(s.data) }

pub fn opt_meta_differential_cluster_mean(s : OptmetadifferentialCluster) -> Double { @_common.mean(s.data) }

pub fn opt_meta_differential_cluster_scale(s : OptmetadifferentialCluster, f : Double) -> OptmetadifferentialCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_cluster_add(a : OptmetadifferentialCluster, b : OptmetadifferentialCluster) -> OptmetadifferentialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_differential_cluster_copy(s : OptmetadifferentialCluster) -> OptmetadifferentialCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_cluster_fill(s : OptmetadifferentialCluster, v : Double) -> OptmetadifferentialCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_cluster_min(s : OptmetadifferentialCluster) -> Double { @_common.min(s.data) }

pub fn opt_meta_differential_cluster_max(s : OptmetadifferentialCluster) -> Double { @_common.max(s.data) }

pub fn opt_meta_differential_cluster_to_string(s : OptmetadifferentialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_model_make(size : Int) -> OptmetadifferentialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_model_len(s : OptmetadifferentialModel) -> Int { s.size }

pub fn opt_meta_differential_model_get(s : OptmetadifferentialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_model_set(s : OptmetadifferentialModel, i : Int, v : Double) -> OptmetadifferentialModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_model_sum(s : OptmetadifferentialModel) -> Double { @_common.sum(s.data) }

pub fn opt_meta_differential_model_mean(s : OptmetadifferentialModel) -> Double { @_common.mean(s.data) }

pub fn opt_meta_differential_model_scale(s : OptmetadifferentialModel, f : Double) -> OptmetadifferentialModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_model_add(a : OptmetadifferentialModel, b : OptmetadifferentialModel) -> OptmetadifferentialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_differential_model_copy(s : OptmetadifferentialModel) -> OptmetadifferentialModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_model_fill(s : OptmetadifferentialModel, v : Double) -> OptmetadifferentialModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_model_min(s : OptmetadifferentialModel) -> Double { @_common.min(s.data) }

pub fn opt_meta_differential_model_max(s : OptmetadifferentialModel) -> Double { @_common.max(s.data) }

pub fn opt_meta_differential_model_to_string(s : OptmetadifferentialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_layer_make(size : Int) -> OptmetadifferentialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_layer_len(s : OptmetadifferentialLayer) -> Int { s.size }

pub fn opt_meta_differential_layer_get(s : OptmetadifferentialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_layer_set(s : OptmetadifferentialLayer, i : Int, v : Double) -> OptmetadifferentialLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_layer_sum(s : OptmetadifferentialLayer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_differential_layer_mean(s : OptmetadifferentialLayer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_differential_layer_scale(s : OptmetadifferentialLayer, f : Double) -> OptmetadifferentialLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_layer_add(a : OptmetadifferentialLayer, b : OptmetadifferentialLayer) -> OptmetadifferentialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_differential_layer_copy(s : OptmetadifferentialLayer) -> OptmetadifferentialLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_layer_fill(s : OptmetadifferentialLayer, v : Double) -> OptmetadifferentialLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_layer_min(s : OptmetadifferentialLayer) -> Double { @_common.min(s.data) }

pub fn opt_meta_differential_layer_max(s : OptmetadifferentialLayer) -> Double { @_common.max(s.data) }

pub fn opt_meta_differential_layer_to_string(s : OptmetadifferentialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_buffer_make(size : Int) -> OptmetadifferentialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_buffer_len(s : OptmetadifferentialBuffer) -> Int { s.size }

pub fn opt_meta_differential_buffer_get(s : OptmetadifferentialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_buffer_set(s : OptmetadifferentialBuffer, i : Int, v : Double) -> OptmetadifferentialBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_buffer_sum(s : OptmetadifferentialBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_differential_buffer_mean(s : OptmetadifferentialBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_differential_buffer_scale(s : OptmetadifferentialBuffer, f : Double) -> OptmetadifferentialBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_buffer_add(a : OptmetadifferentialBuffer, b : OptmetadifferentialBuffer) -> OptmetadifferentialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_differential_buffer_copy(s : OptmetadifferentialBuffer) -> OptmetadifferentialBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_buffer_fill(s : OptmetadifferentialBuffer, v : Double) -> OptmetadifferentialBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_buffer_min(s : OptmetadifferentialBuffer) -> Double { @_common.min(s.data) }

pub fn opt_meta_differential_buffer_max(s : OptmetadifferentialBuffer) -> Double { @_common.max(s.data) }

pub fn opt_meta_differential_buffer_to_string(s : OptmetadifferentialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_cursor_make(size : Int) -> OptmetadifferentialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_cursor_len(s : OptmetadifferentialCursor) -> Int { s.size }

pub fn opt_meta_differential_cursor_get(s : OptmetadifferentialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_cursor_set(s : OptmetadifferentialCursor, i : Int, v : Double) -> OptmetadifferentialCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_cursor_sum(s : OptmetadifferentialCursor) -> Double { @_common.sum(s.data) }

pub fn opt_meta_differential_cursor_mean(s : OptmetadifferentialCursor) -> Double { @_common.mean(s.data) }

pub fn opt_meta_differential_cursor_scale(s : OptmetadifferentialCursor, f : Double) -> OptmetadifferentialCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_cursor_add(a : OptmetadifferentialCursor, b : OptmetadifferentialCursor) -> OptmetadifferentialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_differential_cursor_copy(s : OptmetadifferentialCursor) -> OptmetadifferentialCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_cursor_fill(s : OptmetadifferentialCursor, v : Double) -> OptmetadifferentialCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_cursor_min(s : OptmetadifferentialCursor) -> Double { @_common.min(s.data) }

pub fn opt_meta_differential_cursor_max(s : OptmetadifferentialCursor) -> Double { @_common.max(s.data) }

pub fn opt_meta_differential_cursor_to_string(s : OptmetadifferentialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_view_make(size : Int) -> OptmetadifferentialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_view_len(s : OptmetadifferentialView) -> Int { s.size }

pub fn opt_meta_differential_view_get(s : OptmetadifferentialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_view_set(s : OptmetadifferentialView, i : Int, v : Double) -> OptmetadifferentialView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_view_sum(s : OptmetadifferentialView) -> Double { @_common.sum(s.data) }

pub fn opt_meta_differential_view_mean(s : OptmetadifferentialView) -> Double { @_common.mean(s.data) }

pub fn opt_meta_differential_view_scale(s : OptmetadifferentialView, f : Double) -> OptmetadifferentialView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_view_add(a : OptmetadifferentialView, b : OptmetadifferentialView) -> OptmetadifferentialView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_differential_view_copy(s : OptmetadifferentialView) -> OptmetadifferentialView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_view_fill(s : OptmetadifferentialView, v : Double) -> OptmetadifferentialView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_view_min(s : OptmetadifferentialView) -> Double { @_common.min(s.data) }

pub fn opt_meta_differential_view_max(s : OptmetadifferentialView) -> Double { @_common.max(s.data) }

pub fn opt_meta_differential_view_to_string(s : OptmetadifferentialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_range_make(size : Int) -> OptmetadifferentialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_range_len(s : OptmetadifferentialRange) -> Int { s.size }

pub fn opt_meta_differential_range_get(s : OptmetadifferentialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_range_set(s : OptmetadifferentialRange, i : Int, v : Double) -> OptmetadifferentialRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_range_sum(s : OptmetadifferentialRange) -> Double { @_common.sum(s.data) }

pub fn opt_meta_differential_range_mean(s : OptmetadifferentialRange) -> Double { @_common.mean(s.data) }

pub fn opt_meta_differential_range_scale(s : OptmetadifferentialRange, f : Double) -> OptmetadifferentialRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_range_add(a : OptmetadifferentialRange, b : OptmetadifferentialRange) -> OptmetadifferentialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_differential_range_copy(s : OptmetadifferentialRange) -> OptmetadifferentialRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_range_fill(s : OptmetadifferentialRange, v : Double) -> OptmetadifferentialRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_range_min(s : OptmetadifferentialRange) -> Double { @_common.min(s.data) }

pub fn opt_meta_differential_range_max(s : OptmetadifferentialRange) -> Double { @_common.max(s.data) }

pub fn opt_meta_differential_range_to_string(s : OptmetadifferentialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_slice_make(size : Int) -> OptmetadifferentialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_differential_slice_len(s : OptmetadifferentialSlice) -> Int { s.size }

pub fn opt_meta_differential_slice_get(s : OptmetadifferentialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_differential_slice_set(s : OptmetadifferentialSlice, i : Int, v : Double) -> OptmetadifferentialSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_slice_sum(s : OptmetadifferentialSlice) -> Double { @_common.sum(s.data) }

pub fn opt_meta_differential_slice_mean(s : OptmetadifferentialSlice) -> Double { @_common.mean(s.data) }

pub fn opt_meta_differential_slice_scale(s : OptmetadifferentialSlice, f : Double) -> OptmetadifferentialSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_slice_add(a : OptmetadifferentialSlice, b : OptmetadifferentialSlice) -> OptmetadifferentialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_differential_slice_copy(s : OptmetadifferentialSlice) -> OptmetadifferentialSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_slice_fill(s : OptmetadifferentialSlice, v : Double) -> OptmetadifferentialSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_differential_slice_min(s : OptmetadifferentialSlice) -> Double { @_common.min(s.data) }

pub fn opt_meta_differential_slice_max(s : OptmetadifferentialSlice) -> Double { @_common.max(s.data) }

pub fn opt_meta_differential_slice_to_string(s : OptmetadifferentialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

