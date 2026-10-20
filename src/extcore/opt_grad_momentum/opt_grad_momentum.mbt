///===
/// extcore/opt_grad_momentum

pub(all) struct OptgradmomentumPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_momentum_make_point(x : Double, y : Double) -> OptgradmomentumPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_momentum_make_point3(x : Double, y : Double, z : Double) -> OptgradmomentumPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradmomentumPoint::x(self : OptgradmomentumPoint) -> Double { self.x }

pub fn OptgradmomentumPoint::y(self : OptgradmomentumPoint) -> Double { self.y }

pub fn OptgradmomentumPoint::z(self : OptgradmomentumPoint) -> Double { self.z }

pub fn OptgradmomentumPoint::label(self : OptgradmomentumPoint) -> Int { self.label }

pub fn OptgradmomentumPoint::dist(self : OptgradmomentumPoint, other : OptgradmomentumPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradmomentumPoint::add(self : OptgradmomentumPoint, other : OptgradmomentumPoint) -> OptgradmomentumPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradmomentumPoint::sub(self : OptgradmomentumPoint, other : OptgradmomentumPoint) -> OptgradmomentumPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradmomentumPoint::scale(self : OptgradmomentumPoint, s : Double) -> OptgradmomentumPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradmomentumPoint::dot(self : OptgradmomentumPoint, other : OptgradmomentumPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradmomentumPoint::cross(self : OptgradmomentumPoint, other : OptgradmomentumPoint) -> OptgradmomentumPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradmomentumPoint::norm(self : OptgradmomentumPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradmomentumPoint::normalize(self : OptgradmomentumPoint) -> OptgradmomentumPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradmomentumPoint::negate(self : OptgradmomentumPoint) -> OptgradmomentumPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradmomentumPoint::mid(self : OptgradmomentumPoint, other : OptgradmomentumPoint) -> OptgradmomentumPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradmomentumPoint::lerp(self : OptgradmomentumPoint, other : OptgradmomentumPoint, t : Double) -> OptgradmomentumPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradmomentumPoint::to_string(self : OptgradmomentumPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradmomentumSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_momentum_make_series(vals : Array[Double], name : String) -> OptgradmomentumSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradmomentumSeries::len(self : OptgradmomentumSeries) -> Int { self.vals.length() }

pub fn OptgradmomentumSeries::sum(self : OptgradmomentumSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradmomentumSeries::mean(self : OptgradmomentumSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradmomentumSeries::min(self : OptgradmomentumSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradmomentumSeries::max(self : OptgradmomentumSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradmomentumSeries::range(self : OptgradmomentumSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradmomentumSeries::variance(self : OptgradmomentumSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradmomentumSeries::std(self : OptgradmomentumSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradmomentumSeries::median(self : OptgradmomentumSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradmomentumSeries::scale(self : OptgradmomentumSeries, f : Double) -> OptgradmomentumSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradmomentumSeries::add(self : OptgradmomentumSeries, other : OptgradmomentumSeries) -> OptgradmomentumSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradmomentumSeries::sub(self : OptgradmomentumSeries, other : OptgradmomentumSeries) -> OptgradmomentumSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradmomentumSeries::normalize(self : OptgradmomentumSeries) -> OptgradmomentumSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradmomentumSeries::cumsum(self : OptgradmomentumSeries) -> OptgradmomentumSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradmomentumSeries::to_string(self : OptgradmomentumSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradmomentumMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_momentum_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradmomentumMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_momentum_matrix_identity(n : Int) -> OptgradmomentumMatrix {
  let m = opt_grad_momentum_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradmomentumMatrix::get(self : OptgradmomentumMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradmomentumMatrix::transpose(self : OptgradmomentumMatrix) -> OptgradmomentumMatrix {
  let result = opt_grad_momentum_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradmomentumMatrix::add(self : OptgradmomentumMatrix, other : OptgradmomentumMatrix) -> OptgradmomentumMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_momentum_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradmomentumMatrix::scale(self : OptgradmomentumMatrix, s : Double) -> OptgradmomentumMatrix {
  let result = opt_grad_momentum_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradmomentumMatrix::multiply(self : OptgradmomentumMatrix, other : OptgradmomentumMatrix) -> OptgradmomentumMatrix {
  if self.cols != other.rows { return opt_grad_momentum_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_momentum_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptgradmomentumMatrix::trace(self : OptgradmomentumMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradmomentumMatrix::det(self : OptgradmomentumMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradmomentumMatrix::norm(self : OptgradmomentumMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradmomentumMatrix::to_string(self : OptgradmomentumMatrix) -> String {
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

pub(all) struct OptgradmomentumVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_momentum_make_vector(comps : Array[Double]) -> OptgradmomentumVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_momentum_vector_zero(dim : Int) -> OptgradmomentumVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradmomentumVector::add(self : OptgradmomentumVector, other : OptgradmomentumVector) -> OptgradmomentumVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradmomentumVector::sub(self : OptgradmomentumVector, other : OptgradmomentumVector) -> OptgradmomentumVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradmomentumVector::scale(self : OptgradmomentumVector, s : Double) -> OptgradmomentumVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradmomentumVector::dot(self : OptgradmomentumVector, other : OptgradmomentumVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradmomentumVector::norm(self : OptgradmomentumVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradmomentumVector::normalize(self : OptgradmomentumVector) -> OptgradmomentumVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradmomentumVector::dist(self : OptgradmomentumVector, other : OptgradmomentumVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradmomentumVector::to_string(self : OptgradmomentumVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_momentum_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_grad_momentum_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_grad_momentum_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_grad_momentum_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_grad_momentum_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_grad_momentum_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_grad_momentum_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_grad_momentum_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_grad_momentum_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_grad_momentum_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_grad_momentum_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_grad_momentum_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_grad_momentum_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_grad_momentum_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_grad_momentum_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_grad_momentum_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_grad_momentum_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_grad_momentum_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_grad_momentum_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_grad_momentum_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_grad_momentum_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_grad_momentum_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_grad_momentum_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_grad_momentum_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_grad_momentum_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_grad_momentum_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_grad_momentum_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_grad_momentum_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_grad_momentum_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptgradmomentumFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_frame_make(size : Int) -> OptgradmomentumFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_frame_len(s : OptgradmomentumFrame) -> Int { s.size }

pub fn opt_grad_momentum_frame_get(s : OptgradmomentumFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_frame_set(s : OptgradmomentumFrame, i : Int, v : Double) -> OptgradmomentumFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_frame_sum(s : OptgradmomentumFrame) -> Double { @_common.sum(s.data) }

pub fn opt_grad_momentum_frame_mean(s : OptgradmomentumFrame) -> Double { @_common.mean(s.data) }

pub fn opt_grad_momentum_frame_scale(s : OptgradmomentumFrame, f : Double) -> OptgradmomentumFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_frame_add(a : OptgradmomentumFrame, b : OptgradmomentumFrame) -> OptgradmomentumFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_momentum_frame_copy(s : OptgradmomentumFrame) -> OptgradmomentumFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_frame_fill(s : OptgradmomentumFrame, v : Double) -> OptgradmomentumFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_frame_min(s : OptgradmomentumFrame) -> Double { @_common.min(s.data) }

pub fn opt_grad_momentum_frame_max(s : OptgradmomentumFrame) -> Double { @_common.max(s.data) }

pub fn opt_grad_momentum_frame_to_string(s : OptgradmomentumFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_table_make(size : Int) -> OptgradmomentumTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_table_len(s : OptgradmomentumTable) -> Int { s.size }

pub fn opt_grad_momentum_table_get(s : OptgradmomentumTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_table_set(s : OptgradmomentumTable, i : Int, v : Double) -> OptgradmomentumTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_table_sum(s : OptgradmomentumTable) -> Double { @_common.sum(s.data) }

pub fn opt_grad_momentum_table_mean(s : OptgradmomentumTable) -> Double { @_common.mean(s.data) }

pub fn opt_grad_momentum_table_scale(s : OptgradmomentumTable, f : Double) -> OptgradmomentumTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_table_add(a : OptgradmomentumTable, b : OptgradmomentumTable) -> OptgradmomentumTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_momentum_table_copy(s : OptgradmomentumTable) -> OptgradmomentumTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_table_fill(s : OptgradmomentumTable, v : Double) -> OptgradmomentumTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_table_min(s : OptgradmomentumTable) -> Double { @_common.min(s.data) }

pub fn opt_grad_momentum_table_max(s : OptgradmomentumTable) -> Double { @_common.max(s.data) }

pub fn opt_grad_momentum_table_to_string(s : OptgradmomentumTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_graphn_make(size : Int) -> OptgradmomentumGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_graphn_len(s : OptgradmomentumGraphN) -> Int { s.size }

pub fn opt_grad_momentum_graphn_get(s : OptgradmomentumGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_graphn_set(s : OptgradmomentumGraphN, i : Int, v : Double) -> OptgradmomentumGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_graphn_sum(s : OptgradmomentumGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_grad_momentum_graphn_mean(s : OptgradmomentumGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_grad_momentum_graphn_scale(s : OptgradmomentumGraphN, f : Double) -> OptgradmomentumGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_graphn_add(a : OptgradmomentumGraphN, b : OptgradmomentumGraphN) -> OptgradmomentumGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_momentum_graphn_copy(s : OptgradmomentumGraphN) -> OptgradmomentumGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_graphn_fill(s : OptgradmomentumGraphN, v : Double) -> OptgradmomentumGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_graphn_min(s : OptgradmomentumGraphN) -> Double { @_common.min(s.data) }

pub fn opt_grad_momentum_graphn_max(s : OptgradmomentumGraphN) -> Double { @_common.max(s.data) }

pub fn opt_grad_momentum_graphn_to_string(s : OptgradmomentumGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_node_make(size : Int) -> OptgradmomentumNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_node_len(s : OptgradmomentumNode) -> Int { s.size }

pub fn opt_grad_momentum_node_get(s : OptgradmomentumNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_node_set(s : OptgradmomentumNode, i : Int, v : Double) -> OptgradmomentumNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_node_sum(s : OptgradmomentumNode) -> Double { @_common.sum(s.data) }

pub fn opt_grad_momentum_node_mean(s : OptgradmomentumNode) -> Double { @_common.mean(s.data) }

pub fn opt_grad_momentum_node_scale(s : OptgradmomentumNode, f : Double) -> OptgradmomentumNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_node_add(a : OptgradmomentumNode, b : OptgradmomentumNode) -> OptgradmomentumNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_momentum_node_copy(s : OptgradmomentumNode) -> OptgradmomentumNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_node_fill(s : OptgradmomentumNode, v : Double) -> OptgradmomentumNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_node_min(s : OptgradmomentumNode) -> Double { @_common.min(s.data) }

pub fn opt_grad_momentum_node_max(s : OptgradmomentumNode) -> Double { @_common.max(s.data) }

pub fn opt_grad_momentum_node_to_string(s : OptgradmomentumNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_edge_make(size : Int) -> OptgradmomentumEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_edge_len(s : OptgradmomentumEdge) -> Int { s.size }

pub fn opt_grad_momentum_edge_get(s : OptgradmomentumEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_edge_set(s : OptgradmomentumEdge, i : Int, v : Double) -> OptgradmomentumEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_edge_sum(s : OptgradmomentumEdge) -> Double { @_common.sum(s.data) }

pub fn opt_grad_momentum_edge_mean(s : OptgradmomentumEdge) -> Double { @_common.mean(s.data) }

pub fn opt_grad_momentum_edge_scale(s : OptgradmomentumEdge, f : Double) -> OptgradmomentumEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_edge_add(a : OptgradmomentumEdge, b : OptgradmomentumEdge) -> OptgradmomentumEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_momentum_edge_copy(s : OptgradmomentumEdge) -> OptgradmomentumEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_edge_fill(s : OptgradmomentumEdge, v : Double) -> OptgradmomentumEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_edge_min(s : OptgradmomentumEdge) -> Double { @_common.min(s.data) }

pub fn opt_grad_momentum_edge_max(s : OptgradmomentumEdge) -> Double { @_common.max(s.data) }

pub fn opt_grad_momentum_edge_to_string(s : OptgradmomentumEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_path_make(size : Int) -> OptgradmomentumPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_path_len(s : OptgradmomentumPath) -> Int { s.size }

pub fn opt_grad_momentum_path_get(s : OptgradmomentumPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_path_set(s : OptgradmomentumPath, i : Int, v : Double) -> OptgradmomentumPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_path_sum(s : OptgradmomentumPath) -> Double { @_common.sum(s.data) }

pub fn opt_grad_momentum_path_mean(s : OptgradmomentumPath) -> Double { @_common.mean(s.data) }

pub fn opt_grad_momentum_path_scale(s : OptgradmomentumPath, f : Double) -> OptgradmomentumPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_path_add(a : OptgradmomentumPath, b : OptgradmomentumPath) -> OptgradmomentumPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_momentum_path_copy(s : OptgradmomentumPath) -> OptgradmomentumPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_path_fill(s : OptgradmomentumPath, v : Double) -> OptgradmomentumPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_path_min(s : OptgradmomentumPath) -> Double { @_common.min(s.data) }

pub fn opt_grad_momentum_path_max(s : OptgradmomentumPath) -> Double { @_common.max(s.data) }

pub fn opt_grad_momentum_path_to_string(s : OptgradmomentumPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_cluster_make(size : Int) -> OptgradmomentumCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_cluster_len(s : OptgradmomentumCluster) -> Int { s.size }

pub fn opt_grad_momentum_cluster_get(s : OptgradmomentumCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_cluster_set(s : OptgradmomentumCluster, i : Int, v : Double) -> OptgradmomentumCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_cluster_sum(s : OptgradmomentumCluster) -> Double { @_common.sum(s.data) }

pub fn opt_grad_momentum_cluster_mean(s : OptgradmomentumCluster) -> Double { @_common.mean(s.data) }

pub fn opt_grad_momentum_cluster_scale(s : OptgradmomentumCluster, f : Double) -> OptgradmomentumCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_cluster_add(a : OptgradmomentumCluster, b : OptgradmomentumCluster) -> OptgradmomentumCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_momentum_cluster_copy(s : OptgradmomentumCluster) -> OptgradmomentumCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_cluster_fill(s : OptgradmomentumCluster, v : Double) -> OptgradmomentumCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_cluster_min(s : OptgradmomentumCluster) -> Double { @_common.min(s.data) }

pub fn opt_grad_momentum_cluster_max(s : OptgradmomentumCluster) -> Double { @_common.max(s.data) }

pub fn opt_grad_momentum_cluster_to_string(s : OptgradmomentumCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_model_make(size : Int) -> OptgradmomentumModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_model_len(s : OptgradmomentumModel) -> Int { s.size }

pub fn opt_grad_momentum_model_get(s : OptgradmomentumModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_model_set(s : OptgradmomentumModel, i : Int, v : Double) -> OptgradmomentumModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_model_sum(s : OptgradmomentumModel) -> Double { @_common.sum(s.data) }

pub fn opt_grad_momentum_model_mean(s : OptgradmomentumModel) -> Double { @_common.mean(s.data) }

pub fn opt_grad_momentum_model_scale(s : OptgradmomentumModel, f : Double) -> OptgradmomentumModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_model_add(a : OptgradmomentumModel, b : OptgradmomentumModel) -> OptgradmomentumModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_momentum_model_copy(s : OptgradmomentumModel) -> OptgradmomentumModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_model_fill(s : OptgradmomentumModel, v : Double) -> OptgradmomentumModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_model_min(s : OptgradmomentumModel) -> Double { @_common.min(s.data) }

pub fn opt_grad_momentum_model_max(s : OptgradmomentumModel) -> Double { @_common.max(s.data) }

pub fn opt_grad_momentum_model_to_string(s : OptgradmomentumModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_layer_make(size : Int) -> OptgradmomentumLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_layer_len(s : OptgradmomentumLayer) -> Int { s.size }

pub fn opt_grad_momentum_layer_get(s : OptgradmomentumLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_layer_set(s : OptgradmomentumLayer, i : Int, v : Double) -> OptgradmomentumLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_layer_sum(s : OptgradmomentumLayer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_momentum_layer_mean(s : OptgradmomentumLayer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_momentum_layer_scale(s : OptgradmomentumLayer, f : Double) -> OptgradmomentumLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_layer_add(a : OptgradmomentumLayer, b : OptgradmomentumLayer) -> OptgradmomentumLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_momentum_layer_copy(s : OptgradmomentumLayer) -> OptgradmomentumLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_layer_fill(s : OptgradmomentumLayer, v : Double) -> OptgradmomentumLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_layer_min(s : OptgradmomentumLayer) -> Double { @_common.min(s.data) }

pub fn opt_grad_momentum_layer_max(s : OptgradmomentumLayer) -> Double { @_common.max(s.data) }

pub fn opt_grad_momentum_layer_to_string(s : OptgradmomentumLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_buffer_make(size : Int) -> OptgradmomentumBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_buffer_len(s : OptgradmomentumBuffer) -> Int { s.size }

pub fn opt_grad_momentum_buffer_get(s : OptgradmomentumBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_buffer_set(s : OptgradmomentumBuffer, i : Int, v : Double) -> OptgradmomentumBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_buffer_sum(s : OptgradmomentumBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_momentum_buffer_mean(s : OptgradmomentumBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_momentum_buffer_scale(s : OptgradmomentumBuffer, f : Double) -> OptgradmomentumBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_buffer_add(a : OptgradmomentumBuffer, b : OptgradmomentumBuffer) -> OptgradmomentumBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_momentum_buffer_copy(s : OptgradmomentumBuffer) -> OptgradmomentumBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_buffer_fill(s : OptgradmomentumBuffer, v : Double) -> OptgradmomentumBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_buffer_min(s : OptgradmomentumBuffer) -> Double { @_common.min(s.data) }

pub fn opt_grad_momentum_buffer_max(s : OptgradmomentumBuffer) -> Double { @_common.max(s.data) }

pub fn opt_grad_momentum_buffer_to_string(s : OptgradmomentumBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_cursor_make(size : Int) -> OptgradmomentumCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_cursor_len(s : OptgradmomentumCursor) -> Int { s.size }

pub fn opt_grad_momentum_cursor_get(s : OptgradmomentumCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_cursor_set(s : OptgradmomentumCursor, i : Int, v : Double) -> OptgradmomentumCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_cursor_sum(s : OptgradmomentumCursor) -> Double { @_common.sum(s.data) }

pub fn opt_grad_momentum_cursor_mean(s : OptgradmomentumCursor) -> Double { @_common.mean(s.data) }

pub fn opt_grad_momentum_cursor_scale(s : OptgradmomentumCursor, f : Double) -> OptgradmomentumCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_cursor_add(a : OptgradmomentumCursor, b : OptgradmomentumCursor) -> OptgradmomentumCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_momentum_cursor_copy(s : OptgradmomentumCursor) -> OptgradmomentumCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_cursor_fill(s : OptgradmomentumCursor, v : Double) -> OptgradmomentumCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_cursor_min(s : OptgradmomentumCursor) -> Double { @_common.min(s.data) }

pub fn opt_grad_momentum_cursor_max(s : OptgradmomentumCursor) -> Double { @_common.max(s.data) }

pub fn opt_grad_momentum_cursor_to_string(s : OptgradmomentumCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_view_make(size : Int) -> OptgradmomentumView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_view_len(s : OptgradmomentumView) -> Int { s.size }

pub fn opt_grad_momentum_view_get(s : OptgradmomentumView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_view_set(s : OptgradmomentumView, i : Int, v : Double) -> OptgradmomentumView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_view_sum(s : OptgradmomentumView) -> Double { @_common.sum(s.data) }

pub fn opt_grad_momentum_view_mean(s : OptgradmomentumView) -> Double { @_common.mean(s.data) }

pub fn opt_grad_momentum_view_scale(s : OptgradmomentumView, f : Double) -> OptgradmomentumView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_view_add(a : OptgradmomentumView, b : OptgradmomentumView) -> OptgradmomentumView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_momentum_view_copy(s : OptgradmomentumView) -> OptgradmomentumView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_view_fill(s : OptgradmomentumView, v : Double) -> OptgradmomentumView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_view_min(s : OptgradmomentumView) -> Double { @_common.min(s.data) }

pub fn opt_grad_momentum_view_max(s : OptgradmomentumView) -> Double { @_common.max(s.data) }

pub fn opt_grad_momentum_view_to_string(s : OptgradmomentumView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_range_make(size : Int) -> OptgradmomentumRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_range_len(s : OptgradmomentumRange) -> Int { s.size }

pub fn opt_grad_momentum_range_get(s : OptgradmomentumRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_range_set(s : OptgradmomentumRange, i : Int, v : Double) -> OptgradmomentumRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_range_sum(s : OptgradmomentumRange) -> Double { @_common.sum(s.data) }

pub fn opt_grad_momentum_range_mean(s : OptgradmomentumRange) -> Double { @_common.mean(s.data) }

pub fn opt_grad_momentum_range_scale(s : OptgradmomentumRange, f : Double) -> OptgradmomentumRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_range_add(a : OptgradmomentumRange, b : OptgradmomentumRange) -> OptgradmomentumRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_momentum_range_copy(s : OptgradmomentumRange) -> OptgradmomentumRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_range_fill(s : OptgradmomentumRange, v : Double) -> OptgradmomentumRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_range_min(s : OptgradmomentumRange) -> Double { @_common.min(s.data) }

pub fn opt_grad_momentum_range_max(s : OptgradmomentumRange) -> Double { @_common.max(s.data) }

pub fn opt_grad_momentum_range_to_string(s : OptgradmomentumRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradmomentumSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_momentum_slice_make(size : Int) -> OptgradmomentumSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_momentum_slice_len(s : OptgradmomentumSlice) -> Int { s.size }

pub fn opt_grad_momentum_slice_get(s : OptgradmomentumSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_momentum_slice_set(s : OptgradmomentumSlice, i : Int, v : Double) -> OptgradmomentumSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_slice_sum(s : OptgradmomentumSlice) -> Double { @_common.sum(s.data) }

pub fn opt_grad_momentum_slice_mean(s : OptgradmomentumSlice) -> Double { @_common.mean(s.data) }

pub fn opt_grad_momentum_slice_scale(s : OptgradmomentumSlice, f : Double) -> OptgradmomentumSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_slice_add(a : OptgradmomentumSlice, b : OptgradmomentumSlice) -> OptgradmomentumSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_momentum_slice_copy(s : OptgradmomentumSlice) -> OptgradmomentumSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_slice_fill(s : OptgradmomentumSlice, v : Double) -> OptgradmomentumSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_momentum_slice_min(s : OptgradmomentumSlice) -> Double { @_common.min(s.data) }

pub fn opt_grad_momentum_slice_max(s : OptgradmomentumSlice) -> Double { @_common.max(s.data) }

pub fn opt_grad_momentum_slice_to_string(s : OptgradmomentumSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

