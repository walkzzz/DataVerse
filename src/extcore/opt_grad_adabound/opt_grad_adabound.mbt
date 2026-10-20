///===
/// extcore/opt_grad_adabound

pub(all) struct OptgradadaboundPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_adabound_make_point(x : Double, y : Double) -> OptgradadaboundPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_adabound_make_point3(x : Double, y : Double, z : Double) -> OptgradadaboundPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradadaboundPoint::x(self : OptgradadaboundPoint) -> Double { self.x }

pub fn OptgradadaboundPoint::y(self : OptgradadaboundPoint) -> Double { self.y }

pub fn OptgradadaboundPoint::z(self : OptgradadaboundPoint) -> Double { self.z }

pub fn OptgradadaboundPoint::label(self : OptgradadaboundPoint) -> Int { self.label }

pub fn OptgradadaboundPoint::dist(self : OptgradadaboundPoint, other : OptgradadaboundPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradadaboundPoint::add(self : OptgradadaboundPoint, other : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradadaboundPoint::sub(self : OptgradadaboundPoint, other : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradadaboundPoint::scale(self : OptgradadaboundPoint, s : Double) -> OptgradadaboundPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradadaboundPoint::dot(self : OptgradadaboundPoint, other : OptgradadaboundPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradadaboundPoint::cross(self : OptgradadaboundPoint, other : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradadaboundPoint::norm(self : OptgradadaboundPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradadaboundPoint::normalize(self : OptgradadaboundPoint) -> OptgradadaboundPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradadaboundPoint::negate(self : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradadaboundPoint::mid(self : OptgradadaboundPoint, other : OptgradadaboundPoint) -> OptgradadaboundPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradadaboundPoint::lerp(self : OptgradadaboundPoint, other : OptgradadaboundPoint, t : Double) -> OptgradadaboundPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradadaboundPoint::to_string(self : OptgradadaboundPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradadaboundSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_adabound_make_series(vals : Array[Double], name : String) -> OptgradadaboundSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradadaboundSeries::len(self : OptgradadaboundSeries) -> Int { self.vals.length() }

pub fn OptgradadaboundSeries::sum(self : OptgradadaboundSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradadaboundSeries::mean(self : OptgradadaboundSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradadaboundSeries::min(self : OptgradadaboundSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradadaboundSeries::max(self : OptgradadaboundSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradadaboundSeries::range(self : OptgradadaboundSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradadaboundSeries::variance(self : OptgradadaboundSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradadaboundSeries::std(self : OptgradadaboundSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradadaboundSeries::median(self : OptgradadaboundSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradadaboundSeries::scale(self : OptgradadaboundSeries, f : Double) -> OptgradadaboundSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradadaboundSeries::add(self : OptgradadaboundSeries, other : OptgradadaboundSeries) -> OptgradadaboundSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradadaboundSeries::sub(self : OptgradadaboundSeries, other : OptgradadaboundSeries) -> OptgradadaboundSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradadaboundSeries::normalize(self : OptgradadaboundSeries) -> OptgradadaboundSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradadaboundSeries::cumsum(self : OptgradadaboundSeries) -> OptgradadaboundSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradadaboundSeries::to_string(self : OptgradadaboundSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradadaboundMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_adabound_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradadaboundMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_adabound_matrix_identity(n : Int) -> OptgradadaboundMatrix {
  let m = opt_grad_adabound_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradadaboundMatrix::get(self : OptgradadaboundMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradadaboundMatrix::transpose(self : OptgradadaboundMatrix) -> OptgradadaboundMatrix {
  let result = opt_grad_adabound_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradadaboundMatrix::add(self : OptgradadaboundMatrix, other : OptgradadaboundMatrix) -> OptgradadaboundMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_adabound_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradadaboundMatrix::scale(self : OptgradadaboundMatrix, s : Double) -> OptgradadaboundMatrix {
  let result = opt_grad_adabound_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradadaboundMatrix::multiply(self : OptgradadaboundMatrix, other : OptgradadaboundMatrix) -> OptgradadaboundMatrix {
  if self.cols != other.rows { return opt_grad_adabound_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_adabound_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptgradadaboundMatrix::trace(self : OptgradadaboundMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradadaboundMatrix::det(self : OptgradadaboundMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradadaboundMatrix::norm(self : OptgradadaboundMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradadaboundMatrix::to_string(self : OptgradadaboundMatrix) -> String {
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

pub(all) struct OptgradadaboundVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_adabound_make_vector(comps : Array[Double]) -> OptgradadaboundVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_adabound_vector_zero(dim : Int) -> OptgradadaboundVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradadaboundVector::add(self : OptgradadaboundVector, other : OptgradadaboundVector) -> OptgradadaboundVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradadaboundVector::sub(self : OptgradadaboundVector, other : OptgradadaboundVector) -> OptgradadaboundVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradadaboundVector::scale(self : OptgradadaboundVector, s : Double) -> OptgradadaboundVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradadaboundVector::dot(self : OptgradadaboundVector, other : OptgradadaboundVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradadaboundVector::norm(self : OptgradadaboundVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradadaboundVector::normalize(self : OptgradadaboundVector) -> OptgradadaboundVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradadaboundVector::dist(self : OptgradadaboundVector, other : OptgradadaboundVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradadaboundVector::to_string(self : OptgradadaboundVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_adabound_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_grad_adabound_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_grad_adabound_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_grad_adabound_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_grad_adabound_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_grad_adabound_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_grad_adabound_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_grad_adabound_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_grad_adabound_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_grad_adabound_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_grad_adabound_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_grad_adabound_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_grad_adabound_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_grad_adabound_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_grad_adabound_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_grad_adabound_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_grad_adabound_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_grad_adabound_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_grad_adabound_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_grad_adabound_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_grad_adabound_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_grad_adabound_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_grad_adabound_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_grad_adabound_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_grad_adabound_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_grad_adabound_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_grad_adabound_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_grad_adabound_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_grad_adabound_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptgradadaboundFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_frame_make(size : Int) -> OptgradadaboundFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_frame_len(s : OptgradadaboundFrame) -> Int { s.size }

pub fn opt_grad_adabound_frame_get(s : OptgradadaboundFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_frame_set(s : OptgradadaboundFrame, i : Int, v : Double) -> OptgradadaboundFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_frame_sum(s : OptgradadaboundFrame) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adabound_frame_mean(s : OptgradadaboundFrame) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adabound_frame_scale(s : OptgradadaboundFrame, f : Double) -> OptgradadaboundFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_frame_add(a : OptgradadaboundFrame, b : OptgradadaboundFrame) -> OptgradadaboundFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adabound_frame_copy(s : OptgradadaboundFrame) -> OptgradadaboundFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_frame_fill(s : OptgradadaboundFrame, v : Double) -> OptgradadaboundFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_frame_min(s : OptgradadaboundFrame) -> Double { @_common.min(s.data) }

pub fn opt_grad_adabound_frame_max(s : OptgradadaboundFrame) -> Double { @_common.max(s.data) }

pub fn opt_grad_adabound_frame_to_string(s : OptgradadaboundFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_table_make(size : Int) -> OptgradadaboundTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_table_len(s : OptgradadaboundTable) -> Int { s.size }

pub fn opt_grad_adabound_table_get(s : OptgradadaboundTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_table_set(s : OptgradadaboundTable, i : Int, v : Double) -> OptgradadaboundTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_table_sum(s : OptgradadaboundTable) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adabound_table_mean(s : OptgradadaboundTable) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adabound_table_scale(s : OptgradadaboundTable, f : Double) -> OptgradadaboundTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_table_add(a : OptgradadaboundTable, b : OptgradadaboundTable) -> OptgradadaboundTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adabound_table_copy(s : OptgradadaboundTable) -> OptgradadaboundTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_table_fill(s : OptgradadaboundTable, v : Double) -> OptgradadaboundTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_table_min(s : OptgradadaboundTable) -> Double { @_common.min(s.data) }

pub fn opt_grad_adabound_table_max(s : OptgradadaboundTable) -> Double { @_common.max(s.data) }

pub fn opt_grad_adabound_table_to_string(s : OptgradadaboundTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_graphn_make(size : Int) -> OptgradadaboundGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_graphn_len(s : OptgradadaboundGraphN) -> Int { s.size }

pub fn opt_grad_adabound_graphn_get(s : OptgradadaboundGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_graphn_set(s : OptgradadaboundGraphN, i : Int, v : Double) -> OptgradadaboundGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_graphn_sum(s : OptgradadaboundGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adabound_graphn_mean(s : OptgradadaboundGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adabound_graphn_scale(s : OptgradadaboundGraphN, f : Double) -> OptgradadaboundGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_graphn_add(a : OptgradadaboundGraphN, b : OptgradadaboundGraphN) -> OptgradadaboundGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adabound_graphn_copy(s : OptgradadaboundGraphN) -> OptgradadaboundGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_graphn_fill(s : OptgradadaboundGraphN, v : Double) -> OptgradadaboundGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_graphn_min(s : OptgradadaboundGraphN) -> Double { @_common.min(s.data) }

pub fn opt_grad_adabound_graphn_max(s : OptgradadaboundGraphN) -> Double { @_common.max(s.data) }

pub fn opt_grad_adabound_graphn_to_string(s : OptgradadaboundGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_node_make(size : Int) -> OptgradadaboundNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_node_len(s : OptgradadaboundNode) -> Int { s.size }

pub fn opt_grad_adabound_node_get(s : OptgradadaboundNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_node_set(s : OptgradadaboundNode, i : Int, v : Double) -> OptgradadaboundNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_node_sum(s : OptgradadaboundNode) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adabound_node_mean(s : OptgradadaboundNode) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adabound_node_scale(s : OptgradadaboundNode, f : Double) -> OptgradadaboundNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_node_add(a : OptgradadaboundNode, b : OptgradadaboundNode) -> OptgradadaboundNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adabound_node_copy(s : OptgradadaboundNode) -> OptgradadaboundNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_node_fill(s : OptgradadaboundNode, v : Double) -> OptgradadaboundNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_node_min(s : OptgradadaboundNode) -> Double { @_common.min(s.data) }

pub fn opt_grad_adabound_node_max(s : OptgradadaboundNode) -> Double { @_common.max(s.data) }

pub fn opt_grad_adabound_node_to_string(s : OptgradadaboundNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_edge_make(size : Int) -> OptgradadaboundEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_edge_len(s : OptgradadaboundEdge) -> Int { s.size }

pub fn opt_grad_adabound_edge_get(s : OptgradadaboundEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_edge_set(s : OptgradadaboundEdge, i : Int, v : Double) -> OptgradadaboundEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_edge_sum(s : OptgradadaboundEdge) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adabound_edge_mean(s : OptgradadaboundEdge) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adabound_edge_scale(s : OptgradadaboundEdge, f : Double) -> OptgradadaboundEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_edge_add(a : OptgradadaboundEdge, b : OptgradadaboundEdge) -> OptgradadaboundEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adabound_edge_copy(s : OptgradadaboundEdge) -> OptgradadaboundEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_edge_fill(s : OptgradadaboundEdge, v : Double) -> OptgradadaboundEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_edge_min(s : OptgradadaboundEdge) -> Double { @_common.min(s.data) }

pub fn opt_grad_adabound_edge_max(s : OptgradadaboundEdge) -> Double { @_common.max(s.data) }

pub fn opt_grad_adabound_edge_to_string(s : OptgradadaboundEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_path_make(size : Int) -> OptgradadaboundPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_path_len(s : OptgradadaboundPath) -> Int { s.size }

pub fn opt_grad_adabound_path_get(s : OptgradadaboundPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_path_set(s : OptgradadaboundPath, i : Int, v : Double) -> OptgradadaboundPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_path_sum(s : OptgradadaboundPath) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adabound_path_mean(s : OptgradadaboundPath) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adabound_path_scale(s : OptgradadaboundPath, f : Double) -> OptgradadaboundPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_path_add(a : OptgradadaboundPath, b : OptgradadaboundPath) -> OptgradadaboundPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adabound_path_copy(s : OptgradadaboundPath) -> OptgradadaboundPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_path_fill(s : OptgradadaboundPath, v : Double) -> OptgradadaboundPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_path_min(s : OptgradadaboundPath) -> Double { @_common.min(s.data) }

pub fn opt_grad_adabound_path_max(s : OptgradadaboundPath) -> Double { @_common.max(s.data) }

pub fn opt_grad_adabound_path_to_string(s : OptgradadaboundPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_cluster_make(size : Int) -> OptgradadaboundCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_cluster_len(s : OptgradadaboundCluster) -> Int { s.size }

pub fn opt_grad_adabound_cluster_get(s : OptgradadaboundCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_cluster_set(s : OptgradadaboundCluster, i : Int, v : Double) -> OptgradadaboundCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_cluster_sum(s : OptgradadaboundCluster) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adabound_cluster_mean(s : OptgradadaboundCluster) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adabound_cluster_scale(s : OptgradadaboundCluster, f : Double) -> OptgradadaboundCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_cluster_add(a : OptgradadaboundCluster, b : OptgradadaboundCluster) -> OptgradadaboundCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adabound_cluster_copy(s : OptgradadaboundCluster) -> OptgradadaboundCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_cluster_fill(s : OptgradadaboundCluster, v : Double) -> OptgradadaboundCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_cluster_min(s : OptgradadaboundCluster) -> Double { @_common.min(s.data) }

pub fn opt_grad_adabound_cluster_max(s : OptgradadaboundCluster) -> Double { @_common.max(s.data) }

pub fn opt_grad_adabound_cluster_to_string(s : OptgradadaboundCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_model_make(size : Int) -> OptgradadaboundModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_model_len(s : OptgradadaboundModel) -> Int { s.size }

pub fn opt_grad_adabound_model_get(s : OptgradadaboundModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_model_set(s : OptgradadaboundModel, i : Int, v : Double) -> OptgradadaboundModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_model_sum(s : OptgradadaboundModel) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adabound_model_mean(s : OptgradadaboundModel) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adabound_model_scale(s : OptgradadaboundModel, f : Double) -> OptgradadaboundModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_model_add(a : OptgradadaboundModel, b : OptgradadaboundModel) -> OptgradadaboundModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adabound_model_copy(s : OptgradadaboundModel) -> OptgradadaboundModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_model_fill(s : OptgradadaboundModel, v : Double) -> OptgradadaboundModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_model_min(s : OptgradadaboundModel) -> Double { @_common.min(s.data) }

pub fn opt_grad_adabound_model_max(s : OptgradadaboundModel) -> Double { @_common.max(s.data) }

pub fn opt_grad_adabound_model_to_string(s : OptgradadaboundModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_layer_make(size : Int) -> OptgradadaboundLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_layer_len(s : OptgradadaboundLayer) -> Int { s.size }

pub fn opt_grad_adabound_layer_get(s : OptgradadaboundLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_layer_set(s : OptgradadaboundLayer, i : Int, v : Double) -> OptgradadaboundLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_layer_sum(s : OptgradadaboundLayer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adabound_layer_mean(s : OptgradadaboundLayer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adabound_layer_scale(s : OptgradadaboundLayer, f : Double) -> OptgradadaboundLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_layer_add(a : OptgradadaboundLayer, b : OptgradadaboundLayer) -> OptgradadaboundLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adabound_layer_copy(s : OptgradadaboundLayer) -> OptgradadaboundLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_layer_fill(s : OptgradadaboundLayer, v : Double) -> OptgradadaboundLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_layer_min(s : OptgradadaboundLayer) -> Double { @_common.min(s.data) }

pub fn opt_grad_adabound_layer_max(s : OptgradadaboundLayer) -> Double { @_common.max(s.data) }

pub fn opt_grad_adabound_layer_to_string(s : OptgradadaboundLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_buffer_make(size : Int) -> OptgradadaboundBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_buffer_len(s : OptgradadaboundBuffer) -> Int { s.size }

pub fn opt_grad_adabound_buffer_get(s : OptgradadaboundBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_buffer_set(s : OptgradadaboundBuffer, i : Int, v : Double) -> OptgradadaboundBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_buffer_sum(s : OptgradadaboundBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adabound_buffer_mean(s : OptgradadaboundBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adabound_buffer_scale(s : OptgradadaboundBuffer, f : Double) -> OptgradadaboundBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_buffer_add(a : OptgradadaboundBuffer, b : OptgradadaboundBuffer) -> OptgradadaboundBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adabound_buffer_copy(s : OptgradadaboundBuffer) -> OptgradadaboundBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_buffer_fill(s : OptgradadaboundBuffer, v : Double) -> OptgradadaboundBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_buffer_min(s : OptgradadaboundBuffer) -> Double { @_common.min(s.data) }

pub fn opt_grad_adabound_buffer_max(s : OptgradadaboundBuffer) -> Double { @_common.max(s.data) }

pub fn opt_grad_adabound_buffer_to_string(s : OptgradadaboundBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_cursor_make(size : Int) -> OptgradadaboundCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_cursor_len(s : OptgradadaboundCursor) -> Int { s.size }

pub fn opt_grad_adabound_cursor_get(s : OptgradadaboundCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_cursor_set(s : OptgradadaboundCursor, i : Int, v : Double) -> OptgradadaboundCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_cursor_sum(s : OptgradadaboundCursor) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adabound_cursor_mean(s : OptgradadaboundCursor) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adabound_cursor_scale(s : OptgradadaboundCursor, f : Double) -> OptgradadaboundCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_cursor_add(a : OptgradadaboundCursor, b : OptgradadaboundCursor) -> OptgradadaboundCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adabound_cursor_copy(s : OptgradadaboundCursor) -> OptgradadaboundCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_cursor_fill(s : OptgradadaboundCursor, v : Double) -> OptgradadaboundCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_cursor_min(s : OptgradadaboundCursor) -> Double { @_common.min(s.data) }

pub fn opt_grad_adabound_cursor_max(s : OptgradadaboundCursor) -> Double { @_common.max(s.data) }

pub fn opt_grad_adabound_cursor_to_string(s : OptgradadaboundCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_view_make(size : Int) -> OptgradadaboundView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_view_len(s : OptgradadaboundView) -> Int { s.size }

pub fn opt_grad_adabound_view_get(s : OptgradadaboundView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_view_set(s : OptgradadaboundView, i : Int, v : Double) -> OptgradadaboundView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_view_sum(s : OptgradadaboundView) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adabound_view_mean(s : OptgradadaboundView) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adabound_view_scale(s : OptgradadaboundView, f : Double) -> OptgradadaboundView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_view_add(a : OptgradadaboundView, b : OptgradadaboundView) -> OptgradadaboundView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adabound_view_copy(s : OptgradadaboundView) -> OptgradadaboundView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_view_fill(s : OptgradadaboundView, v : Double) -> OptgradadaboundView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_view_min(s : OptgradadaboundView) -> Double { @_common.min(s.data) }

pub fn opt_grad_adabound_view_max(s : OptgradadaboundView) -> Double { @_common.max(s.data) }

pub fn opt_grad_adabound_view_to_string(s : OptgradadaboundView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_range_make(size : Int) -> OptgradadaboundRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_range_len(s : OptgradadaboundRange) -> Int { s.size }

pub fn opt_grad_adabound_range_get(s : OptgradadaboundRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_range_set(s : OptgradadaboundRange, i : Int, v : Double) -> OptgradadaboundRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_range_sum(s : OptgradadaboundRange) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adabound_range_mean(s : OptgradadaboundRange) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adabound_range_scale(s : OptgradadaboundRange, f : Double) -> OptgradadaboundRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_range_add(a : OptgradadaboundRange, b : OptgradadaboundRange) -> OptgradadaboundRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adabound_range_copy(s : OptgradadaboundRange) -> OptgradadaboundRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_range_fill(s : OptgradadaboundRange, v : Double) -> OptgradadaboundRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_range_min(s : OptgradadaboundRange) -> Double { @_common.min(s.data) }

pub fn opt_grad_adabound_range_max(s : OptgradadaboundRange) -> Double { @_common.max(s.data) }

pub fn opt_grad_adabound_range_to_string(s : OptgradadaboundRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadaboundSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adabound_slice_make(size : Int) -> OptgradadaboundSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adabound_slice_len(s : OptgradadaboundSlice) -> Int { s.size }

pub fn opt_grad_adabound_slice_get(s : OptgradadaboundSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adabound_slice_set(s : OptgradadaboundSlice, i : Int, v : Double) -> OptgradadaboundSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_slice_sum(s : OptgradadaboundSlice) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adabound_slice_mean(s : OptgradadaboundSlice) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adabound_slice_scale(s : OptgradadaboundSlice, f : Double) -> OptgradadaboundSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_slice_add(a : OptgradadaboundSlice, b : OptgradadaboundSlice) -> OptgradadaboundSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adabound_slice_copy(s : OptgradadaboundSlice) -> OptgradadaboundSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_slice_fill(s : OptgradadaboundSlice, v : Double) -> OptgradadaboundSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adabound_slice_min(s : OptgradadaboundSlice) -> Double { @_common.min(s.data) }

pub fn opt_grad_adabound_slice_max(s : OptgradadaboundSlice) -> Double { @_common.max(s.data) }

pub fn opt_grad_adabound_slice_to_string(s : OptgradadaboundSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

