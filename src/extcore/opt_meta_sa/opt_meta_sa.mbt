///===
/// extcore/opt_meta_sa

pub(all) struct OptmetasaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_meta_sa_make_point(x : Double, y : Double) -> OptmetasaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_meta_sa_make_point3(x : Double, y : Double, z : Double) -> OptmetasaPoint {
  { x, y, z, label: 0 }
}

pub fn OptmetasaPoint::x(self : OptmetasaPoint) -> Double { self.x }

pub fn OptmetasaPoint::y(self : OptmetasaPoint) -> Double { self.y }

pub fn OptmetasaPoint::z(self : OptmetasaPoint) -> Double { self.z }

pub fn OptmetasaPoint::label(self : OptmetasaPoint) -> Int { self.label }

pub fn OptmetasaPoint::dist(self : OptmetasaPoint, other : OptmetasaPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptmetasaPoint::add(self : OptmetasaPoint, other : OptmetasaPoint) -> OptmetasaPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptmetasaPoint::sub(self : OptmetasaPoint, other : OptmetasaPoint) -> OptmetasaPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptmetasaPoint::scale(self : OptmetasaPoint, s : Double) -> OptmetasaPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptmetasaPoint::dot(self : OptmetasaPoint, other : OptmetasaPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptmetasaPoint::cross(self : OptmetasaPoint, other : OptmetasaPoint) -> OptmetasaPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptmetasaPoint::norm(self : OptmetasaPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptmetasaPoint::normalize(self : OptmetasaPoint) -> OptmetasaPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetasaPoint::negate(self : OptmetasaPoint) -> OptmetasaPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptmetasaPoint::mid(self : OptmetasaPoint, other : OptmetasaPoint) -> OptmetasaPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptmetasaPoint::lerp(self : OptmetasaPoint, other : OptmetasaPoint, t : Double) -> OptmetasaPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptmetasaPoint::to_string(self : OptmetasaPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptmetasaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_meta_sa_make_series(vals : Array[Double], name : String) -> OptmetasaSeries {
  { vals, name, meta: 0 }
}

pub fn OptmetasaSeries::len(self : OptmetasaSeries) -> Int { self.vals.length() }

pub fn OptmetasaSeries::sum(self : OptmetasaSeries) -> Double { @_common.sum(self.vals) }

pub fn OptmetasaSeries::mean(self : OptmetasaSeries) -> Double { @_common.mean(self.vals) }

pub fn OptmetasaSeries::min(self : OptmetasaSeries) -> Double { @_common.min(self.vals) }

pub fn OptmetasaSeries::max(self : OptmetasaSeries) -> Double { @_common.max(self.vals) }

pub fn OptmetasaSeries::range(self : OptmetasaSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptmetasaSeries::variance(self : OptmetasaSeries) -> Double { @_common.variance(self.vals) }

pub fn OptmetasaSeries::std(self : OptmetasaSeries) -> Double { @_common.std(self.vals) }

pub fn OptmetasaSeries::median(self : OptmetasaSeries) -> Double { @_common.median(self.vals) }

pub fn OptmetasaSeries::scale(self : OptmetasaSeries, f : Double) -> OptmetasaSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptmetasaSeries::add(self : OptmetasaSeries, other : OptmetasaSeries) -> OptmetasaSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptmetasaSeries::sub(self : OptmetasaSeries, other : OptmetasaSeries) -> OptmetasaSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptmetasaSeries::normalize(self : OptmetasaSeries) -> OptmetasaSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptmetasaSeries::cumsum(self : OptmetasaSeries) -> OptmetasaSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptmetasaSeries::to_string(self : OptmetasaSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptmetasaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_meta_sa_make_matrix(rows : Int, cols : Int, val : Double) -> OptmetasaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_meta_sa_matrix_identity(n : Int) -> OptmetasaMatrix {
  let m = opt_meta_sa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptmetasaMatrix::get(self : OptmetasaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptmetasaMatrix::transpose(self : OptmetasaMatrix) -> OptmetasaMatrix {
  let result = opt_meta_sa_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptmetasaMatrix::add(self : OptmetasaMatrix, other : OptmetasaMatrix) -> OptmetasaMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_meta_sa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptmetasaMatrix::scale(self : OptmetasaMatrix, s : Double) -> OptmetasaMatrix {
  let result = opt_meta_sa_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptmetasaMatrix::multiply(self : OptmetasaMatrix, other : OptmetasaMatrix) -> OptmetasaMatrix {
  if self.cols != other.rows { return opt_meta_sa_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_meta_sa_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptmetasaMatrix::trace(self : OptmetasaMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptmetasaMatrix::det(self : OptmetasaMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptmetasaMatrix::norm(self : OptmetasaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptmetasaMatrix::to_string(self : OptmetasaMatrix) -> String {
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

pub(all) struct OptmetasaVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_meta_sa_make_vector(comps : Array[Double]) -> OptmetasaVector {
  { comps, dim: comps.length() }
}

pub fn opt_meta_sa_vector_zero(dim : Int) -> OptmetasaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptmetasaVector::add(self : OptmetasaVector, other : OptmetasaVector) -> OptmetasaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetasaVector::sub(self : OptmetasaVector, other : OptmetasaVector) -> OptmetasaVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptmetasaVector::scale(self : OptmetasaVector, s : Double) -> OptmetasaVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptmetasaVector::dot(self : OptmetasaVector, other : OptmetasaVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptmetasaVector::norm(self : OptmetasaVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptmetasaVector::normalize(self : OptmetasaVector) -> OptmetasaVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptmetasaVector::dist(self : OptmetasaVector, other : OptmetasaVector) -> Double {
  self.sub(other).norm()
}

pub fn OptmetasaVector::to_string(self : OptmetasaVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_meta_sa_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_meta_sa_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_meta_sa_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_meta_sa_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_meta_sa_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_meta_sa_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_meta_sa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_meta_sa_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_meta_sa_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_meta_sa_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_meta_sa_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_meta_sa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_meta_sa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_meta_sa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_meta_sa_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_meta_sa_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_meta_sa_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_meta_sa_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_meta_sa_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_meta_sa_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_meta_sa_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_meta_sa_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_meta_sa_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_meta_sa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_meta_sa_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_meta_sa_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_meta_sa_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_meta_sa_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_meta_sa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptmetasaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_frame_make(size : Int) -> OptmetasaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_frame_len(s : OptmetasaFrame) -> Int { s.size }

pub fn opt_meta_sa_frame_get(s : OptmetasaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_frame_set(s : OptmetasaFrame, i : Int, v : Double) -> OptmetasaFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_frame_sum(s : OptmetasaFrame) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_frame_mean(s : OptmetasaFrame) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_frame_scale(s : OptmetasaFrame, f : Double) -> OptmetasaFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_frame_add(a : OptmetasaFrame, b : OptmetasaFrame) -> OptmetasaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_sa_frame_copy(s : OptmetasaFrame) -> OptmetasaFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_frame_fill(s : OptmetasaFrame, v : Double) -> OptmetasaFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_frame_min(s : OptmetasaFrame) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_frame_max(s : OptmetasaFrame) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_frame_to_string(s : OptmetasaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_table_make(size : Int) -> OptmetasaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_table_len(s : OptmetasaTable) -> Int { s.size }

pub fn opt_meta_sa_table_get(s : OptmetasaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_table_set(s : OptmetasaTable, i : Int, v : Double) -> OptmetasaTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_table_sum(s : OptmetasaTable) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_table_mean(s : OptmetasaTable) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_table_scale(s : OptmetasaTable, f : Double) -> OptmetasaTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_table_add(a : OptmetasaTable, b : OptmetasaTable) -> OptmetasaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_sa_table_copy(s : OptmetasaTable) -> OptmetasaTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_table_fill(s : OptmetasaTable, v : Double) -> OptmetasaTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_table_min(s : OptmetasaTable) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_table_max(s : OptmetasaTable) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_table_to_string(s : OptmetasaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_graphn_make(size : Int) -> OptmetasaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_graphn_len(s : OptmetasaGraphN) -> Int { s.size }

pub fn opt_meta_sa_graphn_get(s : OptmetasaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_graphn_set(s : OptmetasaGraphN, i : Int, v : Double) -> OptmetasaGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_graphn_sum(s : OptmetasaGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_graphn_mean(s : OptmetasaGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_graphn_scale(s : OptmetasaGraphN, f : Double) -> OptmetasaGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_graphn_add(a : OptmetasaGraphN, b : OptmetasaGraphN) -> OptmetasaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_sa_graphn_copy(s : OptmetasaGraphN) -> OptmetasaGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_graphn_fill(s : OptmetasaGraphN, v : Double) -> OptmetasaGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_graphn_min(s : OptmetasaGraphN) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_graphn_max(s : OptmetasaGraphN) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_graphn_to_string(s : OptmetasaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_node_make(size : Int) -> OptmetasaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_node_len(s : OptmetasaNode) -> Int { s.size }

pub fn opt_meta_sa_node_get(s : OptmetasaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_node_set(s : OptmetasaNode, i : Int, v : Double) -> OptmetasaNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_node_sum(s : OptmetasaNode) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_node_mean(s : OptmetasaNode) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_node_scale(s : OptmetasaNode, f : Double) -> OptmetasaNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_node_add(a : OptmetasaNode, b : OptmetasaNode) -> OptmetasaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_sa_node_copy(s : OptmetasaNode) -> OptmetasaNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_node_fill(s : OptmetasaNode, v : Double) -> OptmetasaNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_node_min(s : OptmetasaNode) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_node_max(s : OptmetasaNode) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_node_to_string(s : OptmetasaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_edge_make(size : Int) -> OptmetasaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_edge_len(s : OptmetasaEdge) -> Int { s.size }

pub fn opt_meta_sa_edge_get(s : OptmetasaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_edge_set(s : OptmetasaEdge, i : Int, v : Double) -> OptmetasaEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_edge_sum(s : OptmetasaEdge) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_edge_mean(s : OptmetasaEdge) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_edge_scale(s : OptmetasaEdge, f : Double) -> OptmetasaEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_edge_add(a : OptmetasaEdge, b : OptmetasaEdge) -> OptmetasaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_sa_edge_copy(s : OptmetasaEdge) -> OptmetasaEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_edge_fill(s : OptmetasaEdge, v : Double) -> OptmetasaEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_edge_min(s : OptmetasaEdge) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_edge_max(s : OptmetasaEdge) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_edge_to_string(s : OptmetasaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_path_make(size : Int) -> OptmetasaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_path_len(s : OptmetasaPath) -> Int { s.size }

pub fn opt_meta_sa_path_get(s : OptmetasaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_path_set(s : OptmetasaPath, i : Int, v : Double) -> OptmetasaPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_path_sum(s : OptmetasaPath) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_path_mean(s : OptmetasaPath) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_path_scale(s : OptmetasaPath, f : Double) -> OptmetasaPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_path_add(a : OptmetasaPath, b : OptmetasaPath) -> OptmetasaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_sa_path_copy(s : OptmetasaPath) -> OptmetasaPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_path_fill(s : OptmetasaPath, v : Double) -> OptmetasaPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_path_min(s : OptmetasaPath) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_path_max(s : OptmetasaPath) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_path_to_string(s : OptmetasaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_cluster_make(size : Int) -> OptmetasaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_cluster_len(s : OptmetasaCluster) -> Int { s.size }

pub fn opt_meta_sa_cluster_get(s : OptmetasaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_cluster_set(s : OptmetasaCluster, i : Int, v : Double) -> OptmetasaCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_cluster_sum(s : OptmetasaCluster) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_cluster_mean(s : OptmetasaCluster) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_cluster_scale(s : OptmetasaCluster, f : Double) -> OptmetasaCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_cluster_add(a : OptmetasaCluster, b : OptmetasaCluster) -> OptmetasaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_sa_cluster_copy(s : OptmetasaCluster) -> OptmetasaCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_cluster_fill(s : OptmetasaCluster, v : Double) -> OptmetasaCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_cluster_min(s : OptmetasaCluster) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_cluster_max(s : OptmetasaCluster) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_cluster_to_string(s : OptmetasaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_model_make(size : Int) -> OptmetasaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_model_len(s : OptmetasaModel) -> Int { s.size }

pub fn opt_meta_sa_model_get(s : OptmetasaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_model_set(s : OptmetasaModel, i : Int, v : Double) -> OptmetasaModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_model_sum(s : OptmetasaModel) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_model_mean(s : OptmetasaModel) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_model_scale(s : OptmetasaModel, f : Double) -> OptmetasaModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_model_add(a : OptmetasaModel, b : OptmetasaModel) -> OptmetasaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_sa_model_copy(s : OptmetasaModel) -> OptmetasaModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_model_fill(s : OptmetasaModel, v : Double) -> OptmetasaModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_model_min(s : OptmetasaModel) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_model_max(s : OptmetasaModel) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_model_to_string(s : OptmetasaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_layer_make(size : Int) -> OptmetasaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_layer_len(s : OptmetasaLayer) -> Int { s.size }

pub fn opt_meta_sa_layer_get(s : OptmetasaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_layer_set(s : OptmetasaLayer, i : Int, v : Double) -> OptmetasaLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_layer_sum(s : OptmetasaLayer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_layer_mean(s : OptmetasaLayer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_layer_scale(s : OptmetasaLayer, f : Double) -> OptmetasaLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_layer_add(a : OptmetasaLayer, b : OptmetasaLayer) -> OptmetasaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_sa_layer_copy(s : OptmetasaLayer) -> OptmetasaLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_layer_fill(s : OptmetasaLayer, v : Double) -> OptmetasaLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_layer_min(s : OptmetasaLayer) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_layer_max(s : OptmetasaLayer) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_layer_to_string(s : OptmetasaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_buffer_make(size : Int) -> OptmetasaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_buffer_len(s : OptmetasaBuffer) -> Int { s.size }

pub fn opt_meta_sa_buffer_get(s : OptmetasaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_buffer_set(s : OptmetasaBuffer, i : Int, v : Double) -> OptmetasaBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_buffer_sum(s : OptmetasaBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_buffer_mean(s : OptmetasaBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_buffer_scale(s : OptmetasaBuffer, f : Double) -> OptmetasaBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_buffer_add(a : OptmetasaBuffer, b : OptmetasaBuffer) -> OptmetasaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_sa_buffer_copy(s : OptmetasaBuffer) -> OptmetasaBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_buffer_fill(s : OptmetasaBuffer, v : Double) -> OptmetasaBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_buffer_min(s : OptmetasaBuffer) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_buffer_max(s : OptmetasaBuffer) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_buffer_to_string(s : OptmetasaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_cursor_make(size : Int) -> OptmetasaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_cursor_len(s : OptmetasaCursor) -> Int { s.size }

pub fn opt_meta_sa_cursor_get(s : OptmetasaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_cursor_set(s : OptmetasaCursor, i : Int, v : Double) -> OptmetasaCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_cursor_sum(s : OptmetasaCursor) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_cursor_mean(s : OptmetasaCursor) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_cursor_scale(s : OptmetasaCursor, f : Double) -> OptmetasaCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_cursor_add(a : OptmetasaCursor, b : OptmetasaCursor) -> OptmetasaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_sa_cursor_copy(s : OptmetasaCursor) -> OptmetasaCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_cursor_fill(s : OptmetasaCursor, v : Double) -> OptmetasaCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_cursor_min(s : OptmetasaCursor) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_cursor_max(s : OptmetasaCursor) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_cursor_to_string(s : OptmetasaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_view_make(size : Int) -> OptmetasaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_view_len(s : OptmetasaView) -> Int { s.size }

pub fn opt_meta_sa_view_get(s : OptmetasaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_view_set(s : OptmetasaView, i : Int, v : Double) -> OptmetasaView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_view_sum(s : OptmetasaView) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_view_mean(s : OptmetasaView) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_view_scale(s : OptmetasaView, f : Double) -> OptmetasaView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_view_add(a : OptmetasaView, b : OptmetasaView) -> OptmetasaView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_sa_view_copy(s : OptmetasaView) -> OptmetasaView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_view_fill(s : OptmetasaView, v : Double) -> OptmetasaView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_view_min(s : OptmetasaView) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_view_max(s : OptmetasaView) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_view_to_string(s : OptmetasaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_range_make(size : Int) -> OptmetasaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_range_len(s : OptmetasaRange) -> Int { s.size }

pub fn opt_meta_sa_range_get(s : OptmetasaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_range_set(s : OptmetasaRange, i : Int, v : Double) -> OptmetasaRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_range_sum(s : OptmetasaRange) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_range_mean(s : OptmetasaRange) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_range_scale(s : OptmetasaRange, f : Double) -> OptmetasaRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_range_add(a : OptmetasaRange, b : OptmetasaRange) -> OptmetasaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_sa_range_copy(s : OptmetasaRange) -> OptmetasaRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_range_fill(s : OptmetasaRange, v : Double) -> OptmetasaRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_range_min(s : OptmetasaRange) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_range_max(s : OptmetasaRange) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_range_to_string(s : OptmetasaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptmetasaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_slice_make(size : Int) -> OptmetasaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_meta_sa_slice_len(s : OptmetasaSlice) -> Int { s.size }

pub fn opt_meta_sa_slice_get(s : OptmetasaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_meta_sa_slice_set(s : OptmetasaSlice, i : Int, v : Double) -> OptmetasaSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_slice_sum(s : OptmetasaSlice) -> Double { @_common.sum(s.data) }

pub fn opt_meta_sa_slice_mean(s : OptmetasaSlice) -> Double { @_common.mean(s.data) }

pub fn opt_meta_sa_slice_scale(s : OptmetasaSlice, f : Double) -> OptmetasaSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_slice_add(a : OptmetasaSlice, b : OptmetasaSlice) -> OptmetasaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_meta_sa_slice_copy(s : OptmetasaSlice) -> OptmetasaSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_slice_fill(s : OptmetasaSlice, v : Double) -> OptmetasaSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_meta_sa_slice_min(s : OptmetasaSlice) -> Double { @_common.min(s.data) }

pub fn opt_meta_sa_slice_max(s : OptmetasaSlice) -> Double { @_common.max(s.data) }

pub fn opt_meta_sa_slice_to_string(s : OptmetasaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

