///===
/// extcore/opt_grad_adagrad

pub(all) struct OptgradadagradPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_adagrad_make_point(x : Double, y : Double) -> OptgradadagradPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_adagrad_make_point3(x : Double, y : Double, z : Double) -> OptgradadagradPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradadagradPoint::x(self : OptgradadagradPoint) -> Double { self.x }

pub fn OptgradadagradPoint::y(self : OptgradadagradPoint) -> Double { self.y }

pub fn OptgradadagradPoint::z(self : OptgradadagradPoint) -> Double { self.z }

pub fn OptgradadagradPoint::label(self : OptgradadagradPoint) -> Int { self.label }

pub fn OptgradadagradPoint::dist(self : OptgradadagradPoint, other : OptgradadagradPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradadagradPoint::add(self : OptgradadagradPoint, other : OptgradadagradPoint) -> OptgradadagradPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradadagradPoint::sub(self : OptgradadagradPoint, other : OptgradadagradPoint) -> OptgradadagradPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradadagradPoint::scale(self : OptgradadagradPoint, s : Double) -> OptgradadagradPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradadagradPoint::dot(self : OptgradadagradPoint, other : OptgradadagradPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradadagradPoint::cross(self : OptgradadagradPoint, other : OptgradadagradPoint) -> OptgradadagradPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradadagradPoint::norm(self : OptgradadagradPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradadagradPoint::normalize(self : OptgradadagradPoint) -> OptgradadagradPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradadagradPoint::negate(self : OptgradadagradPoint) -> OptgradadagradPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradadagradPoint::mid(self : OptgradadagradPoint, other : OptgradadagradPoint) -> OptgradadagradPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradadagradPoint::lerp(self : OptgradadagradPoint, other : OptgradadagradPoint, t : Double) -> OptgradadagradPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradadagradPoint::to_string(self : OptgradadagradPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradadagradSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_adagrad_make_series(vals : Array[Double], name : String) -> OptgradadagradSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradadagradSeries::len(self : OptgradadagradSeries) -> Int { self.vals.length() }

pub fn OptgradadagradSeries::sum(self : OptgradadagradSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradadagradSeries::mean(self : OptgradadagradSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradadagradSeries::min(self : OptgradadagradSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradadagradSeries::max(self : OptgradadagradSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradadagradSeries::range(self : OptgradadagradSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradadagradSeries::variance(self : OptgradadagradSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradadagradSeries::std(self : OptgradadagradSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradadagradSeries::median(self : OptgradadagradSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradadagradSeries::scale(self : OptgradadagradSeries, f : Double) -> OptgradadagradSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradadagradSeries::add(self : OptgradadagradSeries, other : OptgradadagradSeries) -> OptgradadagradSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradadagradSeries::sub(self : OptgradadagradSeries, other : OptgradadagradSeries) -> OptgradadagradSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradadagradSeries::normalize(self : OptgradadagradSeries) -> OptgradadagradSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradadagradSeries::cumsum(self : OptgradadagradSeries) -> OptgradadagradSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradadagradSeries::to_string(self : OptgradadagradSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradadagradMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_adagrad_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradadagradMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_adagrad_matrix_identity(n : Int) -> OptgradadagradMatrix {
  let m = opt_grad_adagrad_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradadagradMatrix::get(self : OptgradadagradMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradadagradMatrix::transpose(self : OptgradadagradMatrix) -> OptgradadagradMatrix {
  let result = opt_grad_adagrad_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradadagradMatrix::add(self : OptgradadagradMatrix, other : OptgradadagradMatrix) -> OptgradadagradMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_adagrad_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradadagradMatrix::scale(self : OptgradadagradMatrix, s : Double) -> OptgradadagradMatrix {
  let result = opt_grad_adagrad_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradadagradMatrix::multiply(self : OptgradadagradMatrix, other : OptgradadagradMatrix) -> OptgradadagradMatrix {
  if self.cols != other.rows { return opt_grad_adagrad_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_adagrad_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptgradadagradMatrix::trace(self : OptgradadagradMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradadagradMatrix::det(self : OptgradadagradMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradadagradMatrix::norm(self : OptgradadagradMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradadagradMatrix::to_string(self : OptgradadagradMatrix) -> String {
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

pub(all) struct OptgradadagradVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_adagrad_make_vector(comps : Array[Double]) -> OptgradadagradVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_adagrad_vector_zero(dim : Int) -> OptgradadagradVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradadagradVector::add(self : OptgradadagradVector, other : OptgradadagradVector) -> OptgradadagradVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradadagradVector::sub(self : OptgradadagradVector, other : OptgradadagradVector) -> OptgradadagradVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradadagradVector::scale(self : OptgradadagradVector, s : Double) -> OptgradadagradVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradadagradVector::dot(self : OptgradadagradVector, other : OptgradadagradVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradadagradVector::norm(self : OptgradadagradVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradadagradVector::normalize(self : OptgradadagradVector) -> OptgradadagradVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradadagradVector::dist(self : OptgradadagradVector, other : OptgradadagradVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradadagradVector::to_string(self : OptgradadagradVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_adagrad_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_grad_adagrad_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_grad_adagrad_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_grad_adagrad_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_grad_adagrad_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_grad_adagrad_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_grad_adagrad_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_grad_adagrad_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_grad_adagrad_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_grad_adagrad_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_grad_adagrad_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_grad_adagrad_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_grad_adagrad_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_grad_adagrad_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_grad_adagrad_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_grad_adagrad_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_grad_adagrad_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_grad_adagrad_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_grad_adagrad_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_grad_adagrad_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_grad_adagrad_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_grad_adagrad_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_grad_adagrad_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_grad_adagrad_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_grad_adagrad_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_grad_adagrad_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_grad_adagrad_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_grad_adagrad_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_grad_adagrad_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptgradadagradFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_frame_make(size : Int) -> OptgradadagradFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_frame_len(s : OptgradadagradFrame) -> Int { s.size }

pub fn opt_grad_adagrad_frame_get(s : OptgradadagradFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_frame_set(s : OptgradadagradFrame, i : Int, v : Double) -> OptgradadagradFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_frame_sum(s : OptgradadagradFrame) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adagrad_frame_mean(s : OptgradadagradFrame) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adagrad_frame_scale(s : OptgradadagradFrame, f : Double) -> OptgradadagradFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_frame_add(a : OptgradadagradFrame, b : OptgradadagradFrame) -> OptgradadagradFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adagrad_frame_copy(s : OptgradadagradFrame) -> OptgradadagradFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_frame_fill(s : OptgradadagradFrame, v : Double) -> OptgradadagradFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_frame_min(s : OptgradadagradFrame) -> Double { @_common.min(s.data) }

pub fn opt_grad_adagrad_frame_max(s : OptgradadagradFrame) -> Double { @_common.max(s.data) }

pub fn opt_grad_adagrad_frame_to_string(s : OptgradadagradFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_table_make(size : Int) -> OptgradadagradTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_table_len(s : OptgradadagradTable) -> Int { s.size }

pub fn opt_grad_adagrad_table_get(s : OptgradadagradTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_table_set(s : OptgradadagradTable, i : Int, v : Double) -> OptgradadagradTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_table_sum(s : OptgradadagradTable) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adagrad_table_mean(s : OptgradadagradTable) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adagrad_table_scale(s : OptgradadagradTable, f : Double) -> OptgradadagradTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_table_add(a : OptgradadagradTable, b : OptgradadagradTable) -> OptgradadagradTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adagrad_table_copy(s : OptgradadagradTable) -> OptgradadagradTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_table_fill(s : OptgradadagradTable, v : Double) -> OptgradadagradTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_table_min(s : OptgradadagradTable) -> Double { @_common.min(s.data) }

pub fn opt_grad_adagrad_table_max(s : OptgradadagradTable) -> Double { @_common.max(s.data) }

pub fn opt_grad_adagrad_table_to_string(s : OptgradadagradTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_graphn_make(size : Int) -> OptgradadagradGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_graphn_len(s : OptgradadagradGraphN) -> Int { s.size }

pub fn opt_grad_adagrad_graphn_get(s : OptgradadagradGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_graphn_set(s : OptgradadagradGraphN, i : Int, v : Double) -> OptgradadagradGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_graphn_sum(s : OptgradadagradGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adagrad_graphn_mean(s : OptgradadagradGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adagrad_graphn_scale(s : OptgradadagradGraphN, f : Double) -> OptgradadagradGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_graphn_add(a : OptgradadagradGraphN, b : OptgradadagradGraphN) -> OptgradadagradGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adagrad_graphn_copy(s : OptgradadagradGraphN) -> OptgradadagradGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_graphn_fill(s : OptgradadagradGraphN, v : Double) -> OptgradadagradGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_graphn_min(s : OptgradadagradGraphN) -> Double { @_common.min(s.data) }

pub fn opt_grad_adagrad_graphn_max(s : OptgradadagradGraphN) -> Double { @_common.max(s.data) }

pub fn opt_grad_adagrad_graphn_to_string(s : OptgradadagradGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_node_make(size : Int) -> OptgradadagradNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_node_len(s : OptgradadagradNode) -> Int { s.size }

pub fn opt_grad_adagrad_node_get(s : OptgradadagradNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_node_set(s : OptgradadagradNode, i : Int, v : Double) -> OptgradadagradNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_node_sum(s : OptgradadagradNode) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adagrad_node_mean(s : OptgradadagradNode) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adagrad_node_scale(s : OptgradadagradNode, f : Double) -> OptgradadagradNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_node_add(a : OptgradadagradNode, b : OptgradadagradNode) -> OptgradadagradNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adagrad_node_copy(s : OptgradadagradNode) -> OptgradadagradNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_node_fill(s : OptgradadagradNode, v : Double) -> OptgradadagradNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_node_min(s : OptgradadagradNode) -> Double { @_common.min(s.data) }

pub fn opt_grad_adagrad_node_max(s : OptgradadagradNode) -> Double { @_common.max(s.data) }

pub fn opt_grad_adagrad_node_to_string(s : OptgradadagradNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_edge_make(size : Int) -> OptgradadagradEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_edge_len(s : OptgradadagradEdge) -> Int { s.size }

pub fn opt_grad_adagrad_edge_get(s : OptgradadagradEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_edge_set(s : OptgradadagradEdge, i : Int, v : Double) -> OptgradadagradEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_edge_sum(s : OptgradadagradEdge) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adagrad_edge_mean(s : OptgradadagradEdge) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adagrad_edge_scale(s : OptgradadagradEdge, f : Double) -> OptgradadagradEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_edge_add(a : OptgradadagradEdge, b : OptgradadagradEdge) -> OptgradadagradEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adagrad_edge_copy(s : OptgradadagradEdge) -> OptgradadagradEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_edge_fill(s : OptgradadagradEdge, v : Double) -> OptgradadagradEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_edge_min(s : OptgradadagradEdge) -> Double { @_common.min(s.data) }

pub fn opt_grad_adagrad_edge_max(s : OptgradadagradEdge) -> Double { @_common.max(s.data) }

pub fn opt_grad_adagrad_edge_to_string(s : OptgradadagradEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_path_make(size : Int) -> OptgradadagradPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_path_len(s : OptgradadagradPath) -> Int { s.size }

pub fn opt_grad_adagrad_path_get(s : OptgradadagradPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_path_set(s : OptgradadagradPath, i : Int, v : Double) -> OptgradadagradPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_path_sum(s : OptgradadagradPath) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adagrad_path_mean(s : OptgradadagradPath) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adagrad_path_scale(s : OptgradadagradPath, f : Double) -> OptgradadagradPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_path_add(a : OptgradadagradPath, b : OptgradadagradPath) -> OptgradadagradPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adagrad_path_copy(s : OptgradadagradPath) -> OptgradadagradPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_path_fill(s : OptgradadagradPath, v : Double) -> OptgradadagradPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_path_min(s : OptgradadagradPath) -> Double { @_common.min(s.data) }

pub fn opt_grad_adagrad_path_max(s : OptgradadagradPath) -> Double { @_common.max(s.data) }

pub fn opt_grad_adagrad_path_to_string(s : OptgradadagradPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_cluster_make(size : Int) -> OptgradadagradCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_cluster_len(s : OptgradadagradCluster) -> Int { s.size }

pub fn opt_grad_adagrad_cluster_get(s : OptgradadagradCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_cluster_set(s : OptgradadagradCluster, i : Int, v : Double) -> OptgradadagradCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_cluster_sum(s : OptgradadagradCluster) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adagrad_cluster_mean(s : OptgradadagradCluster) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adagrad_cluster_scale(s : OptgradadagradCluster, f : Double) -> OptgradadagradCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_cluster_add(a : OptgradadagradCluster, b : OptgradadagradCluster) -> OptgradadagradCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adagrad_cluster_copy(s : OptgradadagradCluster) -> OptgradadagradCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_cluster_fill(s : OptgradadagradCluster, v : Double) -> OptgradadagradCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_cluster_min(s : OptgradadagradCluster) -> Double { @_common.min(s.data) }

pub fn opt_grad_adagrad_cluster_max(s : OptgradadagradCluster) -> Double { @_common.max(s.data) }

pub fn opt_grad_adagrad_cluster_to_string(s : OptgradadagradCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_model_make(size : Int) -> OptgradadagradModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_model_len(s : OptgradadagradModel) -> Int { s.size }

pub fn opt_grad_adagrad_model_get(s : OptgradadagradModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_model_set(s : OptgradadagradModel, i : Int, v : Double) -> OptgradadagradModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_model_sum(s : OptgradadagradModel) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adagrad_model_mean(s : OptgradadagradModel) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adagrad_model_scale(s : OptgradadagradModel, f : Double) -> OptgradadagradModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_model_add(a : OptgradadagradModel, b : OptgradadagradModel) -> OptgradadagradModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adagrad_model_copy(s : OptgradadagradModel) -> OptgradadagradModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_model_fill(s : OptgradadagradModel, v : Double) -> OptgradadagradModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_model_min(s : OptgradadagradModel) -> Double { @_common.min(s.data) }

pub fn opt_grad_adagrad_model_max(s : OptgradadagradModel) -> Double { @_common.max(s.data) }

pub fn opt_grad_adagrad_model_to_string(s : OptgradadagradModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_layer_make(size : Int) -> OptgradadagradLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_layer_len(s : OptgradadagradLayer) -> Int { s.size }

pub fn opt_grad_adagrad_layer_get(s : OptgradadagradLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_layer_set(s : OptgradadagradLayer, i : Int, v : Double) -> OptgradadagradLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_layer_sum(s : OptgradadagradLayer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adagrad_layer_mean(s : OptgradadagradLayer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adagrad_layer_scale(s : OptgradadagradLayer, f : Double) -> OptgradadagradLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_layer_add(a : OptgradadagradLayer, b : OptgradadagradLayer) -> OptgradadagradLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adagrad_layer_copy(s : OptgradadagradLayer) -> OptgradadagradLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_layer_fill(s : OptgradadagradLayer, v : Double) -> OptgradadagradLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_layer_min(s : OptgradadagradLayer) -> Double { @_common.min(s.data) }

pub fn opt_grad_adagrad_layer_max(s : OptgradadagradLayer) -> Double { @_common.max(s.data) }

pub fn opt_grad_adagrad_layer_to_string(s : OptgradadagradLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_buffer_make(size : Int) -> OptgradadagradBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_buffer_len(s : OptgradadagradBuffer) -> Int { s.size }

pub fn opt_grad_adagrad_buffer_get(s : OptgradadagradBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_buffer_set(s : OptgradadagradBuffer, i : Int, v : Double) -> OptgradadagradBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_buffer_sum(s : OptgradadagradBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adagrad_buffer_mean(s : OptgradadagradBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adagrad_buffer_scale(s : OptgradadagradBuffer, f : Double) -> OptgradadagradBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_buffer_add(a : OptgradadagradBuffer, b : OptgradadagradBuffer) -> OptgradadagradBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adagrad_buffer_copy(s : OptgradadagradBuffer) -> OptgradadagradBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_buffer_fill(s : OptgradadagradBuffer, v : Double) -> OptgradadagradBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_buffer_min(s : OptgradadagradBuffer) -> Double { @_common.min(s.data) }

pub fn opt_grad_adagrad_buffer_max(s : OptgradadagradBuffer) -> Double { @_common.max(s.data) }

pub fn opt_grad_adagrad_buffer_to_string(s : OptgradadagradBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_cursor_make(size : Int) -> OptgradadagradCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_cursor_len(s : OptgradadagradCursor) -> Int { s.size }

pub fn opt_grad_adagrad_cursor_get(s : OptgradadagradCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_cursor_set(s : OptgradadagradCursor, i : Int, v : Double) -> OptgradadagradCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_cursor_sum(s : OptgradadagradCursor) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adagrad_cursor_mean(s : OptgradadagradCursor) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adagrad_cursor_scale(s : OptgradadagradCursor, f : Double) -> OptgradadagradCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_cursor_add(a : OptgradadagradCursor, b : OptgradadagradCursor) -> OptgradadagradCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adagrad_cursor_copy(s : OptgradadagradCursor) -> OptgradadagradCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_cursor_fill(s : OptgradadagradCursor, v : Double) -> OptgradadagradCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_cursor_min(s : OptgradadagradCursor) -> Double { @_common.min(s.data) }

pub fn opt_grad_adagrad_cursor_max(s : OptgradadagradCursor) -> Double { @_common.max(s.data) }

pub fn opt_grad_adagrad_cursor_to_string(s : OptgradadagradCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_view_make(size : Int) -> OptgradadagradView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_view_len(s : OptgradadagradView) -> Int { s.size }

pub fn opt_grad_adagrad_view_get(s : OptgradadagradView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_view_set(s : OptgradadagradView, i : Int, v : Double) -> OptgradadagradView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_view_sum(s : OptgradadagradView) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adagrad_view_mean(s : OptgradadagradView) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adagrad_view_scale(s : OptgradadagradView, f : Double) -> OptgradadagradView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_view_add(a : OptgradadagradView, b : OptgradadagradView) -> OptgradadagradView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adagrad_view_copy(s : OptgradadagradView) -> OptgradadagradView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_view_fill(s : OptgradadagradView, v : Double) -> OptgradadagradView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_view_min(s : OptgradadagradView) -> Double { @_common.min(s.data) }

pub fn opt_grad_adagrad_view_max(s : OptgradadagradView) -> Double { @_common.max(s.data) }

pub fn opt_grad_adagrad_view_to_string(s : OptgradadagradView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_range_make(size : Int) -> OptgradadagradRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_range_len(s : OptgradadagradRange) -> Int { s.size }

pub fn opt_grad_adagrad_range_get(s : OptgradadagradRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_range_set(s : OptgradadagradRange, i : Int, v : Double) -> OptgradadagradRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_range_sum(s : OptgradadagradRange) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adagrad_range_mean(s : OptgradadagradRange) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adagrad_range_scale(s : OptgradadagradRange, f : Double) -> OptgradadagradRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_range_add(a : OptgradadagradRange, b : OptgradadagradRange) -> OptgradadagradRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adagrad_range_copy(s : OptgradadagradRange) -> OptgradadagradRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_range_fill(s : OptgradadagradRange, v : Double) -> OptgradadagradRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_range_min(s : OptgradadagradRange) -> Double { @_common.min(s.data) }

pub fn opt_grad_adagrad_range_max(s : OptgradadagradRange) -> Double { @_common.max(s.data) }

pub fn opt_grad_adagrad_range_to_string(s : OptgradadagradRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadagradSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adagrad_slice_make(size : Int) -> OptgradadagradSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adagrad_slice_len(s : OptgradadagradSlice) -> Int { s.size }

pub fn opt_grad_adagrad_slice_get(s : OptgradadagradSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adagrad_slice_set(s : OptgradadagradSlice, i : Int, v : Double) -> OptgradadagradSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_slice_sum(s : OptgradadagradSlice) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adagrad_slice_mean(s : OptgradadagradSlice) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adagrad_slice_scale(s : OptgradadagradSlice, f : Double) -> OptgradadagradSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_slice_add(a : OptgradadagradSlice, b : OptgradadagradSlice) -> OptgradadagradSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adagrad_slice_copy(s : OptgradadagradSlice) -> OptgradadagradSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_slice_fill(s : OptgradadagradSlice, v : Double) -> OptgradadagradSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adagrad_slice_min(s : OptgradadagradSlice) -> Double { @_common.min(s.data) }

pub fn opt_grad_adagrad_slice_max(s : OptgradadagradSlice) -> Double { @_common.max(s.data) }

pub fn opt_grad_adagrad_slice_to_string(s : OptgradadagradSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

