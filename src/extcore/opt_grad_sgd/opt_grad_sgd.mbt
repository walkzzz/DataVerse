///===
/// extcore/opt_grad_sgd

pub(all) struct OptgradsgdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_sgd_make_point(x : Double, y : Double) -> OptgradsgdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_sgd_make_point3(x : Double, y : Double, z : Double) -> OptgradsgdPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradsgdPoint::x(self : OptgradsgdPoint) -> Double { self.x }

pub fn OptgradsgdPoint::y(self : OptgradsgdPoint) -> Double { self.y }

pub fn OptgradsgdPoint::z(self : OptgradsgdPoint) -> Double { self.z }

pub fn OptgradsgdPoint::label(self : OptgradsgdPoint) -> Int { self.label }

pub fn OptgradsgdPoint::dist(self : OptgradsgdPoint, other : OptgradsgdPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradsgdPoint::add(self : OptgradsgdPoint, other : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradsgdPoint::sub(self : OptgradsgdPoint, other : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradsgdPoint::scale(self : OptgradsgdPoint, s : Double) -> OptgradsgdPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradsgdPoint::dot(self : OptgradsgdPoint, other : OptgradsgdPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradsgdPoint::cross(self : OptgradsgdPoint, other : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradsgdPoint::norm(self : OptgradsgdPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradsgdPoint::normalize(self : OptgradsgdPoint) -> OptgradsgdPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradsgdPoint::negate(self : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradsgdPoint::mid(self : OptgradsgdPoint, other : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradsgdPoint::lerp(self : OptgradsgdPoint, other : OptgradsgdPoint, t : Double) -> OptgradsgdPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradsgdPoint::to_string(self : OptgradsgdPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradsgdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_sgd_make_series(vals : Array[Double], name : String) -> OptgradsgdSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradsgdSeries::len(self : OptgradsgdSeries) -> Int { self.vals.length() }

pub fn OptgradsgdSeries::sum(self : OptgradsgdSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradsgdSeries::mean(self : OptgradsgdSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradsgdSeries::min(self : OptgradsgdSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradsgdSeries::max(self : OptgradsgdSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradsgdSeries::range(self : OptgradsgdSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradsgdSeries::variance(self : OptgradsgdSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradsgdSeries::std(self : OptgradsgdSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradsgdSeries::median(self : OptgradsgdSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradsgdSeries::scale(self : OptgradsgdSeries, f : Double) -> OptgradsgdSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradsgdSeries::add(self : OptgradsgdSeries, other : OptgradsgdSeries) -> OptgradsgdSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradsgdSeries::sub(self : OptgradsgdSeries, other : OptgradsgdSeries) -> OptgradsgdSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradsgdSeries::normalize(self : OptgradsgdSeries) -> OptgradsgdSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradsgdSeries::cumsum(self : OptgradsgdSeries) -> OptgradsgdSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradsgdSeries::to_string(self : OptgradsgdSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradsgdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_sgd_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradsgdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_sgd_matrix_identity(n : Int) -> OptgradsgdMatrix {
  let m = opt_grad_sgd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradsgdMatrix::get(self : OptgradsgdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradsgdMatrix::transpose(self : OptgradsgdMatrix) -> OptgradsgdMatrix {
  let result = opt_grad_sgd_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradsgdMatrix::add(self : OptgradsgdMatrix, other : OptgradsgdMatrix) -> OptgradsgdMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_sgd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradsgdMatrix::scale(self : OptgradsgdMatrix, s : Double) -> OptgradsgdMatrix {
  let result = opt_grad_sgd_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradsgdMatrix::multiply(self : OptgradsgdMatrix, other : OptgradsgdMatrix) -> OptgradsgdMatrix {
  if self.cols != other.rows { return opt_grad_sgd_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_sgd_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptgradsgdMatrix::trace(self : OptgradsgdMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradsgdMatrix::det(self : OptgradsgdMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradsgdMatrix::norm(self : OptgradsgdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradsgdMatrix::to_string(self : OptgradsgdMatrix) -> String {
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

pub(all) struct OptgradsgdVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_sgd_make_vector(comps : Array[Double]) -> OptgradsgdVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_sgd_vector_zero(dim : Int) -> OptgradsgdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradsgdVector::add(self : OptgradsgdVector, other : OptgradsgdVector) -> OptgradsgdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradsgdVector::sub(self : OptgradsgdVector, other : OptgradsgdVector) -> OptgradsgdVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradsgdVector::scale(self : OptgradsgdVector, s : Double) -> OptgradsgdVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradsgdVector::dot(self : OptgradsgdVector, other : OptgradsgdVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradsgdVector::norm(self : OptgradsgdVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradsgdVector::normalize(self : OptgradsgdVector) -> OptgradsgdVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradsgdVector::dist(self : OptgradsgdVector, other : OptgradsgdVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradsgdVector::to_string(self : OptgradsgdVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_sgd_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_grad_sgd_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_grad_sgd_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_grad_sgd_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_grad_sgd_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_grad_sgd_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_grad_sgd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_grad_sgd_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_grad_sgd_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_grad_sgd_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_grad_sgd_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_grad_sgd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_grad_sgd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_grad_sgd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_grad_sgd_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_grad_sgd_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_grad_sgd_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_grad_sgd_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_grad_sgd_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_grad_sgd_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_grad_sgd_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_grad_sgd_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_grad_sgd_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_grad_sgd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_grad_sgd_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_grad_sgd_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_grad_sgd_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_grad_sgd_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_grad_sgd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptgradsgdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_frame_make(size : Int) -> OptgradsgdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_frame_len(s : OptgradsgdFrame) -> Int { s.size }

pub fn opt_grad_sgd_frame_get(s : OptgradsgdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_frame_set(s : OptgradsgdFrame, i : Int, v : Double) -> OptgradsgdFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_frame_sum(s : OptgradsgdFrame) -> Double { @_common.sum(s.data) }

pub fn opt_grad_sgd_frame_mean(s : OptgradsgdFrame) -> Double { @_common.mean(s.data) }

pub fn opt_grad_sgd_frame_scale(s : OptgradsgdFrame, f : Double) -> OptgradsgdFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_frame_add(a : OptgradsgdFrame, b : OptgradsgdFrame) -> OptgradsgdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_sgd_frame_copy(s : OptgradsgdFrame) -> OptgradsgdFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_frame_fill(s : OptgradsgdFrame, v : Double) -> OptgradsgdFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_frame_min(s : OptgradsgdFrame) -> Double { @_common.min(s.data) }

pub fn opt_grad_sgd_frame_max(s : OptgradsgdFrame) -> Double { @_common.max(s.data) }

pub fn opt_grad_sgd_frame_to_string(s : OptgradsgdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_table_make(size : Int) -> OptgradsgdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_table_len(s : OptgradsgdTable) -> Int { s.size }

pub fn opt_grad_sgd_table_get(s : OptgradsgdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_table_set(s : OptgradsgdTable, i : Int, v : Double) -> OptgradsgdTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_table_sum(s : OptgradsgdTable) -> Double { @_common.sum(s.data) }

pub fn opt_grad_sgd_table_mean(s : OptgradsgdTable) -> Double { @_common.mean(s.data) }

pub fn opt_grad_sgd_table_scale(s : OptgradsgdTable, f : Double) -> OptgradsgdTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_table_add(a : OptgradsgdTable, b : OptgradsgdTable) -> OptgradsgdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_sgd_table_copy(s : OptgradsgdTable) -> OptgradsgdTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_table_fill(s : OptgradsgdTable, v : Double) -> OptgradsgdTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_table_min(s : OptgradsgdTable) -> Double { @_common.min(s.data) }

pub fn opt_grad_sgd_table_max(s : OptgradsgdTable) -> Double { @_common.max(s.data) }

pub fn opt_grad_sgd_table_to_string(s : OptgradsgdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_graphn_make(size : Int) -> OptgradsgdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_graphn_len(s : OptgradsgdGraphN) -> Int { s.size }

pub fn opt_grad_sgd_graphn_get(s : OptgradsgdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_graphn_set(s : OptgradsgdGraphN, i : Int, v : Double) -> OptgradsgdGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_graphn_sum(s : OptgradsgdGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_grad_sgd_graphn_mean(s : OptgradsgdGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_grad_sgd_graphn_scale(s : OptgradsgdGraphN, f : Double) -> OptgradsgdGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_graphn_add(a : OptgradsgdGraphN, b : OptgradsgdGraphN) -> OptgradsgdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_sgd_graphn_copy(s : OptgradsgdGraphN) -> OptgradsgdGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_graphn_fill(s : OptgradsgdGraphN, v : Double) -> OptgradsgdGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_graphn_min(s : OptgradsgdGraphN) -> Double { @_common.min(s.data) }

pub fn opt_grad_sgd_graphn_max(s : OptgradsgdGraphN) -> Double { @_common.max(s.data) }

pub fn opt_grad_sgd_graphn_to_string(s : OptgradsgdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_node_make(size : Int) -> OptgradsgdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_node_len(s : OptgradsgdNode) -> Int { s.size }

pub fn opt_grad_sgd_node_get(s : OptgradsgdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_node_set(s : OptgradsgdNode, i : Int, v : Double) -> OptgradsgdNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_node_sum(s : OptgradsgdNode) -> Double { @_common.sum(s.data) }

pub fn opt_grad_sgd_node_mean(s : OptgradsgdNode) -> Double { @_common.mean(s.data) }

pub fn opt_grad_sgd_node_scale(s : OptgradsgdNode, f : Double) -> OptgradsgdNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_node_add(a : OptgradsgdNode, b : OptgradsgdNode) -> OptgradsgdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_sgd_node_copy(s : OptgradsgdNode) -> OptgradsgdNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_node_fill(s : OptgradsgdNode, v : Double) -> OptgradsgdNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_node_min(s : OptgradsgdNode) -> Double { @_common.min(s.data) }

pub fn opt_grad_sgd_node_max(s : OptgradsgdNode) -> Double { @_common.max(s.data) }

pub fn opt_grad_sgd_node_to_string(s : OptgradsgdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_edge_make(size : Int) -> OptgradsgdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_edge_len(s : OptgradsgdEdge) -> Int { s.size }

pub fn opt_grad_sgd_edge_get(s : OptgradsgdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_edge_set(s : OptgradsgdEdge, i : Int, v : Double) -> OptgradsgdEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_edge_sum(s : OptgradsgdEdge) -> Double { @_common.sum(s.data) }

pub fn opt_grad_sgd_edge_mean(s : OptgradsgdEdge) -> Double { @_common.mean(s.data) }

pub fn opt_grad_sgd_edge_scale(s : OptgradsgdEdge, f : Double) -> OptgradsgdEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_edge_add(a : OptgradsgdEdge, b : OptgradsgdEdge) -> OptgradsgdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_sgd_edge_copy(s : OptgradsgdEdge) -> OptgradsgdEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_edge_fill(s : OptgradsgdEdge, v : Double) -> OptgradsgdEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_edge_min(s : OptgradsgdEdge) -> Double { @_common.min(s.data) }

pub fn opt_grad_sgd_edge_max(s : OptgradsgdEdge) -> Double { @_common.max(s.data) }

pub fn opt_grad_sgd_edge_to_string(s : OptgradsgdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_path_make(size : Int) -> OptgradsgdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_path_len(s : OptgradsgdPath) -> Int { s.size }

pub fn opt_grad_sgd_path_get(s : OptgradsgdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_path_set(s : OptgradsgdPath, i : Int, v : Double) -> OptgradsgdPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_path_sum(s : OptgradsgdPath) -> Double { @_common.sum(s.data) }

pub fn opt_grad_sgd_path_mean(s : OptgradsgdPath) -> Double { @_common.mean(s.data) }

pub fn opt_grad_sgd_path_scale(s : OptgradsgdPath, f : Double) -> OptgradsgdPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_path_add(a : OptgradsgdPath, b : OptgradsgdPath) -> OptgradsgdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_sgd_path_copy(s : OptgradsgdPath) -> OptgradsgdPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_path_fill(s : OptgradsgdPath, v : Double) -> OptgradsgdPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_path_min(s : OptgradsgdPath) -> Double { @_common.min(s.data) }

pub fn opt_grad_sgd_path_max(s : OptgradsgdPath) -> Double { @_common.max(s.data) }

pub fn opt_grad_sgd_path_to_string(s : OptgradsgdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_cluster_make(size : Int) -> OptgradsgdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_cluster_len(s : OptgradsgdCluster) -> Int { s.size }

pub fn opt_grad_sgd_cluster_get(s : OptgradsgdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_cluster_set(s : OptgradsgdCluster, i : Int, v : Double) -> OptgradsgdCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_cluster_sum(s : OptgradsgdCluster) -> Double { @_common.sum(s.data) }

pub fn opt_grad_sgd_cluster_mean(s : OptgradsgdCluster) -> Double { @_common.mean(s.data) }

pub fn opt_grad_sgd_cluster_scale(s : OptgradsgdCluster, f : Double) -> OptgradsgdCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_cluster_add(a : OptgradsgdCluster, b : OptgradsgdCluster) -> OptgradsgdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_sgd_cluster_copy(s : OptgradsgdCluster) -> OptgradsgdCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_cluster_fill(s : OptgradsgdCluster, v : Double) -> OptgradsgdCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_cluster_min(s : OptgradsgdCluster) -> Double { @_common.min(s.data) }

pub fn opt_grad_sgd_cluster_max(s : OptgradsgdCluster) -> Double { @_common.max(s.data) }

pub fn opt_grad_sgd_cluster_to_string(s : OptgradsgdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_model_make(size : Int) -> OptgradsgdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_model_len(s : OptgradsgdModel) -> Int { s.size }

pub fn opt_grad_sgd_model_get(s : OptgradsgdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_model_set(s : OptgradsgdModel, i : Int, v : Double) -> OptgradsgdModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_model_sum(s : OptgradsgdModel) -> Double { @_common.sum(s.data) }

pub fn opt_grad_sgd_model_mean(s : OptgradsgdModel) -> Double { @_common.mean(s.data) }

pub fn opt_grad_sgd_model_scale(s : OptgradsgdModel, f : Double) -> OptgradsgdModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_model_add(a : OptgradsgdModel, b : OptgradsgdModel) -> OptgradsgdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_sgd_model_copy(s : OptgradsgdModel) -> OptgradsgdModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_model_fill(s : OptgradsgdModel, v : Double) -> OptgradsgdModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_model_min(s : OptgradsgdModel) -> Double { @_common.min(s.data) }

pub fn opt_grad_sgd_model_max(s : OptgradsgdModel) -> Double { @_common.max(s.data) }

pub fn opt_grad_sgd_model_to_string(s : OptgradsgdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_layer_make(size : Int) -> OptgradsgdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_layer_len(s : OptgradsgdLayer) -> Int { s.size }

pub fn opt_grad_sgd_layer_get(s : OptgradsgdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_layer_set(s : OptgradsgdLayer, i : Int, v : Double) -> OptgradsgdLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_layer_sum(s : OptgradsgdLayer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_sgd_layer_mean(s : OptgradsgdLayer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_sgd_layer_scale(s : OptgradsgdLayer, f : Double) -> OptgradsgdLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_layer_add(a : OptgradsgdLayer, b : OptgradsgdLayer) -> OptgradsgdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_sgd_layer_copy(s : OptgradsgdLayer) -> OptgradsgdLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_layer_fill(s : OptgradsgdLayer, v : Double) -> OptgradsgdLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_layer_min(s : OptgradsgdLayer) -> Double { @_common.min(s.data) }

pub fn opt_grad_sgd_layer_max(s : OptgradsgdLayer) -> Double { @_common.max(s.data) }

pub fn opt_grad_sgd_layer_to_string(s : OptgradsgdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_buffer_make(size : Int) -> OptgradsgdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_buffer_len(s : OptgradsgdBuffer) -> Int { s.size }

pub fn opt_grad_sgd_buffer_get(s : OptgradsgdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_buffer_set(s : OptgradsgdBuffer, i : Int, v : Double) -> OptgradsgdBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_buffer_sum(s : OptgradsgdBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_sgd_buffer_mean(s : OptgradsgdBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_sgd_buffer_scale(s : OptgradsgdBuffer, f : Double) -> OptgradsgdBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_buffer_add(a : OptgradsgdBuffer, b : OptgradsgdBuffer) -> OptgradsgdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_sgd_buffer_copy(s : OptgradsgdBuffer) -> OptgradsgdBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_buffer_fill(s : OptgradsgdBuffer, v : Double) -> OptgradsgdBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_buffer_min(s : OptgradsgdBuffer) -> Double { @_common.min(s.data) }

pub fn opt_grad_sgd_buffer_max(s : OptgradsgdBuffer) -> Double { @_common.max(s.data) }

pub fn opt_grad_sgd_buffer_to_string(s : OptgradsgdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_cursor_make(size : Int) -> OptgradsgdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_cursor_len(s : OptgradsgdCursor) -> Int { s.size }

pub fn opt_grad_sgd_cursor_get(s : OptgradsgdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_cursor_set(s : OptgradsgdCursor, i : Int, v : Double) -> OptgradsgdCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_cursor_sum(s : OptgradsgdCursor) -> Double { @_common.sum(s.data) }

pub fn opt_grad_sgd_cursor_mean(s : OptgradsgdCursor) -> Double { @_common.mean(s.data) }

pub fn opt_grad_sgd_cursor_scale(s : OptgradsgdCursor, f : Double) -> OptgradsgdCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_cursor_add(a : OptgradsgdCursor, b : OptgradsgdCursor) -> OptgradsgdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_sgd_cursor_copy(s : OptgradsgdCursor) -> OptgradsgdCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_cursor_fill(s : OptgradsgdCursor, v : Double) -> OptgradsgdCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_cursor_min(s : OptgradsgdCursor) -> Double { @_common.min(s.data) }

pub fn opt_grad_sgd_cursor_max(s : OptgradsgdCursor) -> Double { @_common.max(s.data) }

pub fn opt_grad_sgd_cursor_to_string(s : OptgradsgdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_view_make(size : Int) -> OptgradsgdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_view_len(s : OptgradsgdView) -> Int { s.size }

pub fn opt_grad_sgd_view_get(s : OptgradsgdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_view_set(s : OptgradsgdView, i : Int, v : Double) -> OptgradsgdView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_view_sum(s : OptgradsgdView) -> Double { @_common.sum(s.data) }

pub fn opt_grad_sgd_view_mean(s : OptgradsgdView) -> Double { @_common.mean(s.data) }

pub fn opt_grad_sgd_view_scale(s : OptgradsgdView, f : Double) -> OptgradsgdView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_view_add(a : OptgradsgdView, b : OptgradsgdView) -> OptgradsgdView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_sgd_view_copy(s : OptgradsgdView) -> OptgradsgdView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_view_fill(s : OptgradsgdView, v : Double) -> OptgradsgdView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_view_min(s : OptgradsgdView) -> Double { @_common.min(s.data) }

pub fn opt_grad_sgd_view_max(s : OptgradsgdView) -> Double { @_common.max(s.data) }

pub fn opt_grad_sgd_view_to_string(s : OptgradsgdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_range_make(size : Int) -> OptgradsgdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_range_len(s : OptgradsgdRange) -> Int { s.size }

pub fn opt_grad_sgd_range_get(s : OptgradsgdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_range_set(s : OptgradsgdRange, i : Int, v : Double) -> OptgradsgdRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_range_sum(s : OptgradsgdRange) -> Double { @_common.sum(s.data) }

pub fn opt_grad_sgd_range_mean(s : OptgradsgdRange) -> Double { @_common.mean(s.data) }

pub fn opt_grad_sgd_range_scale(s : OptgradsgdRange, f : Double) -> OptgradsgdRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_range_add(a : OptgradsgdRange, b : OptgradsgdRange) -> OptgradsgdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_sgd_range_copy(s : OptgradsgdRange) -> OptgradsgdRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_range_fill(s : OptgradsgdRange, v : Double) -> OptgradsgdRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_range_min(s : OptgradsgdRange) -> Double { @_common.min(s.data) }

pub fn opt_grad_sgd_range_max(s : OptgradsgdRange) -> Double { @_common.max(s.data) }

pub fn opt_grad_sgd_range_to_string(s : OptgradsgdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_slice_make(size : Int) -> OptgradsgdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_slice_len(s : OptgradsgdSlice) -> Int { s.size }

pub fn opt_grad_sgd_slice_get(s : OptgradsgdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_slice_set(s : OptgradsgdSlice, i : Int, v : Double) -> OptgradsgdSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_slice_sum(s : OptgradsgdSlice) -> Double { @_common.sum(s.data) }

pub fn opt_grad_sgd_slice_mean(s : OptgradsgdSlice) -> Double { @_common.mean(s.data) }

pub fn opt_grad_sgd_slice_scale(s : OptgradsgdSlice, f : Double) -> OptgradsgdSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_slice_add(a : OptgradsgdSlice, b : OptgradsgdSlice) -> OptgradsgdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_sgd_slice_copy(s : OptgradsgdSlice) -> OptgradsgdSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_slice_fill(s : OptgradsgdSlice, v : Double) -> OptgradsgdSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_sgd_slice_min(s : OptgradsgdSlice) -> Double { @_common.min(s.data) }

pub fn opt_grad_sgd_slice_max(s : OptgradsgdSlice) -> Double { @_common.max(s.data) }

pub fn opt_grad_sgd_slice_to_string(s : OptgradsgdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

