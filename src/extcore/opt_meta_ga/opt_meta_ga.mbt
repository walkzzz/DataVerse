///===
/// extcore/opt_meta_ga

pub(all) struct OptmetagaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_ga_make_point(x : Double, y : Double) -> OptmetagaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_ga_make_point3(x : Double, y : Double, z : Double) -> OptmetagaPoint {
  { x, y, z, label: 0 }
}

pub fn OptmetagaPoint::x(self : OptmetagaPoint) -> Double { self.x }

pub fn OptmetagaPoint::y(self : OptmetagaPoint) -> Double { self.y }

pub fn OptmetagaPoint::z(self : OptmetagaPoint) -> Double { self.z }

pub fn OptmetagaPoint::label(self : OptmetagaPoint) -> Int { self.label }

pub fn OptmetagaPoint::dist(self : OptmetagaPoint, other : OptmetagaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetagaPoint::add(self : OptmetagaPoint, other : OptmetagaPoint) -> OptmetagaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetagaPoint::sub(self : OptmetagaPoint, other : OptmetagaPoint) -> OptmetagaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetagaPoint::scale(self : OptmetagaPoint, s : Double) -> OptmetagaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetagaPoint::dot(self : OptmetagaPoint, other : OptmetagaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetagaPoint::cross(self : OptmetagaPoint, other : OptmetagaPoint) -> OptmetagaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetagaPoint::norm(self : OptmetagaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetagaPoint::normalize(self : OptmetagaPoint) -> OptmetagaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetagaPoint::negate(self : OptmetagaPoint) -> OptmetagaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetagaPoint::mid(self : OptmetagaPoint, other : OptmetagaPoint) -> OptmetagaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetagaPoint::lerp(self : OptmetagaPoint, other : OptmetagaPoint, t : Double) -> OptmetagaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetagaPoint::to_string(self : OptmetagaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetagaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_ga_make_series(vals : Array[Double], name : String) -> OptmetagaSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetagaSeries::len(self : OptmetagaSeries) -> Int { self.vals.length() }

pub fn OptmetagaSeries::sum(self : OptmetagaSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetagaSeries::mean(self : OptmetagaSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetagaSeries::min(self : OptmetagaSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetagaSeries::max(self : OptmetagaSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetagaSeries::range(self : OptmetagaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetagaSeries::variance(self : OptmetagaSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetagaSeries::std(self : OptmetagaSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetagaSeries::median(self : OptmetagaSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetagaSeries::scale(self : OptmetagaSeries, f : Double) -> OptmetagaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetagaSeries::add(self : OptmetagaSeries, other : OptmetagaSeries) -> OptmetagaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetagaSeries::sub(self : OptmetagaSeries, other : OptmetagaSeries) -> OptmetagaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetagaSeries::normalize(self : OptmetagaSeries) -> OptmetagaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetagaSeries::cumsum(self : OptmetagaSeries) -> OptmetagaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetagaSeries::to_string(self : OptmetagaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetagaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_ga_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetagaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_ga_matrix_identity(n : Int) -> OptmetagaMatrix {
  let m = opt_meta_ga_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetagaMatrix::get(self : OptmetagaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetagaMatrix::transpose(self : OptmetagaMatrix) -> OptmetagaMatrix {
  let result = opt_meta_ga_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetagaMatrix::add(self : OptmetagaMatrix, other : OptmetagaMatrix) -> OptmetagaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_ga_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetagaMatrix::scale(self : OptmetagaMatrix, s : Double) -> OptmetagaMatrix {
  let result = opt_meta_ga_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetagaMatrix::multiply(self : OptmetagaMatrix, other : OptmetagaMatrix) -> OptmetagaMatrix {
  if self.cols != other.rows { return opt_meta_ga_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_ga_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptmetagaMatrix::trace(self : OptmetagaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetagaMatrix::det(self : OptmetagaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetagaMatrix::norm(self : OptmetagaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetagaMatrix::to_string(self : OptmetagaMatrix) -> String {
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

pub(all) struct OptmetagaVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_ga_make_vector(comps : Array[Double]) -> OptmetagaVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_ga_vector_zero(dim : Int) -> OptmetagaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetagaVector::add(self : OptmetagaVector, other : OptmetagaVector) -> OptmetagaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetagaVector::sub(self : OptmetagaVector, other : OptmetagaVector) -> OptmetagaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetagaVector::scale(self : OptmetagaVector, s : Double) -> OptmetagaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetagaVector::dot(self : OptmetagaVector, other : OptmetagaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetagaVector::norm(self : OptmetagaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetagaVector::normalize(self : OptmetagaVector) -> OptmetagaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetagaVector::dist(self : OptmetagaVector, other : OptmetagaVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetagaVector::to_string(self : OptmetagaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_ga_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_ga_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_ga_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_ga_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_ga_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_ga_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_ga_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_ga_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_ga_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_ga_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_ga_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_ga_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_ga_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_ga_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_ga_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_ga_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_ga_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_ga_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_ga_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_ga_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_ga_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_ga_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_ga_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_ga_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_ga_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_ga_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_ga_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_ga_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_ga_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetagaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_frame_make(size : Int) -> OptmetagaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_frame_len(s : OptmetagaFrame) -> Int { s.size }

pub fn opt_meta_ga_frame_get(s : OptmetagaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_frame_set(s : OptmetagaFrame, i : Int, v : Double) -> OptmetagaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_frame_sum(s : OptmetagaFrame) -> Double { @_common.sum(s.data) }

pub fn opt_meta_ga_frame_mean(s : OptmetagaFrame) -> Double { @_common.mean(s.data) }

pub fn opt_meta_ga_frame_scale(s : OptmetagaFrame, f : Double) -> OptmetagaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_frame_add(a : OptmetagaFrame, b : OptmetagaFrame) -> OptmetagaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_ga_frame_copy(s : OptmetagaFrame) -> OptmetagaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_frame_fill(s : OptmetagaFrame, v : Double) -> OptmetagaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_frame_min(s : OptmetagaFrame) -> Double { @_common.min(s.data) }

pub fn opt_meta_ga_frame_max(s : OptmetagaFrame) -> Double { @_common.max(s.data) }

pub fn opt_meta_ga_frame_to_string(s : OptmetagaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_table_make(size : Int) -> OptmetagaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_table_len(s : OptmetagaTable) -> Int { s.size }

pub fn opt_meta_ga_table_get(s : OptmetagaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_table_set(s : OptmetagaTable, i : Int, v : Double) -> OptmetagaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_table_sum(s : OptmetagaTable) -> Double { @_common.sum(s.data) }

pub fn opt_meta_ga_table_mean(s : OptmetagaTable) -> Double { @_common.mean(s.data) }

pub fn opt_meta_ga_table_scale(s : OptmetagaTable, f : Double) -> OptmetagaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_table_add(a : OptmetagaTable, b : OptmetagaTable) -> OptmetagaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_ga_table_copy(s : OptmetagaTable) -> OptmetagaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_table_fill(s : OptmetagaTable, v : Double) -> OptmetagaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_table_min(s : OptmetagaTable) -> Double { @_common.min(s.data) }

pub fn opt_meta_ga_table_max(s : OptmetagaTable) -> Double { @_common.max(s.data) }

pub fn opt_meta_ga_table_to_string(s : OptmetagaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_graphn_make(size : Int) -> OptmetagaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_graphn_len(s : OptmetagaGraphN) -> Int { s.size }

pub fn opt_meta_ga_graphn_get(s : OptmetagaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_graphn_set(s : OptmetagaGraphN, i : Int, v : Double) -> OptmetagaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_graphn_sum(s : OptmetagaGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_meta_ga_graphn_mean(s : OptmetagaGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_meta_ga_graphn_scale(s : OptmetagaGraphN, f : Double) -> OptmetagaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_graphn_add(a : OptmetagaGraphN, b : OptmetagaGraphN) -> OptmetagaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_ga_graphn_copy(s : OptmetagaGraphN) -> OptmetagaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_graphn_fill(s : OptmetagaGraphN, v : Double) -> OptmetagaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_graphn_min(s : OptmetagaGraphN) -> Double { @_common.min(s.data) }

pub fn opt_meta_ga_graphn_max(s : OptmetagaGraphN) -> Double { @_common.max(s.data) }

pub fn opt_meta_ga_graphn_to_string(s : OptmetagaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_node_make(size : Int) -> OptmetagaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_node_len(s : OptmetagaNode) -> Int { s.size }

pub fn opt_meta_ga_node_get(s : OptmetagaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_node_set(s : OptmetagaNode, i : Int, v : Double) -> OptmetagaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_node_sum(s : OptmetagaNode) -> Double { @_common.sum(s.data) }

pub fn opt_meta_ga_node_mean(s : OptmetagaNode) -> Double { @_common.mean(s.data) }

pub fn opt_meta_ga_node_scale(s : OptmetagaNode, f : Double) -> OptmetagaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_node_add(a : OptmetagaNode, b : OptmetagaNode) -> OptmetagaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_ga_node_copy(s : OptmetagaNode) -> OptmetagaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_node_fill(s : OptmetagaNode, v : Double) -> OptmetagaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_node_min(s : OptmetagaNode) -> Double { @_common.min(s.data) }

pub fn opt_meta_ga_node_max(s : OptmetagaNode) -> Double { @_common.max(s.data) }

pub fn opt_meta_ga_node_to_string(s : OptmetagaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_edge_make(size : Int) -> OptmetagaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_edge_len(s : OptmetagaEdge) -> Int { s.size }

pub fn opt_meta_ga_edge_get(s : OptmetagaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_edge_set(s : OptmetagaEdge, i : Int, v : Double) -> OptmetagaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_edge_sum(s : OptmetagaEdge) -> Double { @_common.sum(s.data) }

pub fn opt_meta_ga_edge_mean(s : OptmetagaEdge) -> Double { @_common.mean(s.data) }

pub fn opt_meta_ga_edge_scale(s : OptmetagaEdge, f : Double) -> OptmetagaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_edge_add(a : OptmetagaEdge, b : OptmetagaEdge) -> OptmetagaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_ga_edge_copy(s : OptmetagaEdge) -> OptmetagaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_edge_fill(s : OptmetagaEdge, v : Double) -> OptmetagaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_edge_min(s : OptmetagaEdge) -> Double { @_common.min(s.data) }

pub fn opt_meta_ga_edge_max(s : OptmetagaEdge) -> Double { @_common.max(s.data) }

pub fn opt_meta_ga_edge_to_string(s : OptmetagaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_path_make(size : Int) -> OptmetagaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_path_len(s : OptmetagaPath) -> Int { s.size }

pub fn opt_meta_ga_path_get(s : OptmetagaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_path_set(s : OptmetagaPath, i : Int, v : Double) -> OptmetagaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_path_sum(s : OptmetagaPath) -> Double { @_common.sum(s.data) }

pub fn opt_meta_ga_path_mean(s : OptmetagaPath) -> Double { @_common.mean(s.data) }

pub fn opt_meta_ga_path_scale(s : OptmetagaPath, f : Double) -> OptmetagaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_path_add(a : OptmetagaPath, b : OptmetagaPath) -> OptmetagaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_ga_path_copy(s : OptmetagaPath) -> OptmetagaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_path_fill(s : OptmetagaPath, v : Double) -> OptmetagaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_path_min(s : OptmetagaPath) -> Double { @_common.min(s.data) }

pub fn opt_meta_ga_path_max(s : OptmetagaPath) -> Double { @_common.max(s.data) }

pub fn opt_meta_ga_path_to_string(s : OptmetagaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_cluster_make(size : Int) -> OptmetagaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_cluster_len(s : OptmetagaCluster) -> Int { s.size }

pub fn opt_meta_ga_cluster_get(s : OptmetagaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_cluster_set(s : OptmetagaCluster, i : Int, v : Double) -> OptmetagaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_cluster_sum(s : OptmetagaCluster) -> Double { @_common.sum(s.data) }

pub fn opt_meta_ga_cluster_mean(s : OptmetagaCluster) -> Double { @_common.mean(s.data) }

pub fn opt_meta_ga_cluster_scale(s : OptmetagaCluster, f : Double) -> OptmetagaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_cluster_add(a : OptmetagaCluster, b : OptmetagaCluster) -> OptmetagaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_ga_cluster_copy(s : OptmetagaCluster) -> OptmetagaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_cluster_fill(s : OptmetagaCluster, v : Double) -> OptmetagaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_cluster_min(s : OptmetagaCluster) -> Double { @_common.min(s.data) }

pub fn opt_meta_ga_cluster_max(s : OptmetagaCluster) -> Double { @_common.max(s.data) }

pub fn opt_meta_ga_cluster_to_string(s : OptmetagaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_model_make(size : Int) -> OptmetagaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_model_len(s : OptmetagaModel) -> Int { s.size }

pub fn opt_meta_ga_model_get(s : OptmetagaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_model_set(s : OptmetagaModel, i : Int, v : Double) -> OptmetagaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_model_sum(s : OptmetagaModel) -> Double { @_common.sum(s.data) }

pub fn opt_meta_ga_model_mean(s : OptmetagaModel) -> Double { @_common.mean(s.data) }

pub fn opt_meta_ga_model_scale(s : OptmetagaModel, f : Double) -> OptmetagaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_model_add(a : OptmetagaModel, b : OptmetagaModel) -> OptmetagaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_ga_model_copy(s : OptmetagaModel) -> OptmetagaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_model_fill(s : OptmetagaModel, v : Double) -> OptmetagaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_model_min(s : OptmetagaModel) -> Double { @_common.min(s.data) }

pub fn opt_meta_ga_model_max(s : OptmetagaModel) -> Double { @_common.max(s.data) }

pub fn opt_meta_ga_model_to_string(s : OptmetagaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_layer_make(size : Int) -> OptmetagaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_layer_len(s : OptmetagaLayer) -> Int { s.size }

pub fn opt_meta_ga_layer_get(s : OptmetagaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_layer_set(s : OptmetagaLayer, i : Int, v : Double) -> OptmetagaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_layer_sum(s : OptmetagaLayer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_ga_layer_mean(s : OptmetagaLayer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_ga_layer_scale(s : OptmetagaLayer, f : Double) -> OptmetagaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_layer_add(a : OptmetagaLayer, b : OptmetagaLayer) -> OptmetagaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_ga_layer_copy(s : OptmetagaLayer) -> OptmetagaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_layer_fill(s : OptmetagaLayer, v : Double) -> OptmetagaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_layer_min(s : OptmetagaLayer) -> Double { @_common.min(s.data) }

pub fn opt_meta_ga_layer_max(s : OptmetagaLayer) -> Double { @_common.max(s.data) }

pub fn opt_meta_ga_layer_to_string(s : OptmetagaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_buffer_make(size : Int) -> OptmetagaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_buffer_len(s : OptmetagaBuffer) -> Int { s.size }

pub fn opt_meta_ga_buffer_get(s : OptmetagaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_buffer_set(s : OptmetagaBuffer, i : Int, v : Double) -> OptmetagaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_buffer_sum(s : OptmetagaBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_ga_buffer_mean(s : OptmetagaBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_ga_buffer_scale(s : OptmetagaBuffer, f : Double) -> OptmetagaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_buffer_add(a : OptmetagaBuffer, b : OptmetagaBuffer) -> OptmetagaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_ga_buffer_copy(s : OptmetagaBuffer) -> OptmetagaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_buffer_fill(s : OptmetagaBuffer, v : Double) -> OptmetagaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_buffer_min(s : OptmetagaBuffer) -> Double { @_common.min(s.data) }

pub fn opt_meta_ga_buffer_max(s : OptmetagaBuffer) -> Double { @_common.max(s.data) }

pub fn opt_meta_ga_buffer_to_string(s : OptmetagaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_cursor_make(size : Int) -> OptmetagaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_cursor_len(s : OptmetagaCursor) -> Int { s.size }

pub fn opt_meta_ga_cursor_get(s : OptmetagaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_cursor_set(s : OptmetagaCursor, i : Int, v : Double) -> OptmetagaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_cursor_sum(s : OptmetagaCursor) -> Double { @_common.sum(s.data) }

pub fn opt_meta_ga_cursor_mean(s : OptmetagaCursor) -> Double { @_common.mean(s.data) }

pub fn opt_meta_ga_cursor_scale(s : OptmetagaCursor, f : Double) -> OptmetagaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_cursor_add(a : OptmetagaCursor, b : OptmetagaCursor) -> OptmetagaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_ga_cursor_copy(s : OptmetagaCursor) -> OptmetagaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_cursor_fill(s : OptmetagaCursor, v : Double) -> OptmetagaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_cursor_min(s : OptmetagaCursor) -> Double { @_common.min(s.data) }

pub fn opt_meta_ga_cursor_max(s : OptmetagaCursor) -> Double { @_common.max(s.data) }

pub fn opt_meta_ga_cursor_to_string(s : OptmetagaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_view_make(size : Int) -> OptmetagaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_view_len(s : OptmetagaView) -> Int { s.size }

pub fn opt_meta_ga_view_get(s : OptmetagaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_view_set(s : OptmetagaView, i : Int, v : Double) -> OptmetagaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_view_sum(s : OptmetagaView) -> Double { @_common.sum(s.data) }

pub fn opt_meta_ga_view_mean(s : OptmetagaView) -> Double { @_common.mean(s.data) }

pub fn opt_meta_ga_view_scale(s : OptmetagaView, f : Double) -> OptmetagaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_view_add(a : OptmetagaView, b : OptmetagaView) -> OptmetagaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_ga_view_copy(s : OptmetagaView) -> OptmetagaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_view_fill(s : OptmetagaView, v : Double) -> OptmetagaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_view_min(s : OptmetagaView) -> Double { @_common.min(s.data) }

pub fn opt_meta_ga_view_max(s : OptmetagaView) -> Double { @_common.max(s.data) }

pub fn opt_meta_ga_view_to_string(s : OptmetagaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_range_make(size : Int) -> OptmetagaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_range_len(s : OptmetagaRange) -> Int { s.size }

pub fn opt_meta_ga_range_get(s : OptmetagaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_range_set(s : OptmetagaRange, i : Int, v : Double) -> OptmetagaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_range_sum(s : OptmetagaRange) -> Double { @_common.sum(s.data) }

pub fn opt_meta_ga_range_mean(s : OptmetagaRange) -> Double { @_common.mean(s.data) }

pub fn opt_meta_ga_range_scale(s : OptmetagaRange, f : Double) -> OptmetagaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_range_add(a : OptmetagaRange, b : OptmetagaRange) -> OptmetagaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_ga_range_copy(s : OptmetagaRange) -> OptmetagaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_range_fill(s : OptmetagaRange, v : Double) -> OptmetagaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_range_min(s : OptmetagaRange) -> Double { @_common.min(s.data) }

pub fn opt_meta_ga_range_max(s : OptmetagaRange) -> Double { @_common.max(s.data) }

pub fn opt_meta_ga_range_to_string(s : OptmetagaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetagaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_ga_slice_make(size : Int) -> OptmetagaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_ga_slice_len(s : OptmetagaSlice) -> Int { s.size }

pub fn opt_meta_ga_slice_get(s : OptmetagaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_ga_slice_set(s : OptmetagaSlice, i : Int, v : Double) -> OptmetagaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_slice_sum(s : OptmetagaSlice) -> Double { @_common.sum(s.data) }

pub fn opt_meta_ga_slice_mean(s : OptmetagaSlice) -> Double { @_common.mean(s.data) }

pub fn opt_meta_ga_slice_scale(s : OptmetagaSlice, f : Double) -> OptmetagaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_slice_add(a : OptmetagaSlice, b : OptmetagaSlice) -> OptmetagaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_ga_slice_copy(s : OptmetagaSlice) -> OptmetagaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_slice_fill(s : OptmetagaSlice, v : Double) -> OptmetagaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_ga_slice_min(s : OptmetagaSlice) -> Double { @_common.min(s.data) }

pub fn opt_meta_ga_slice_max(s : OptmetagaSlice) -> Double { @_common.max(s.data) }

pub fn opt_meta_ga_slice_to_string(s : OptmetagaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

