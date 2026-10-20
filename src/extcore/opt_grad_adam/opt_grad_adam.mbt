///===
/// extcore/opt_grad_adam

pub(all) struct OptgradadamPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_adam_make_point(x : Double, y : Double) -> OptgradadamPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_adam_make_point3(x : Double, y : Double, z : Double) -> OptgradadamPoint {
  { x, y, z, label: 0 }
}

pub fn OptgradadamPoint::x(self : OptgradadamPoint) -> Double { self.x }

pub fn OptgradadamPoint::y(self : OptgradadamPoint) -> Double { self.y }

pub fn OptgradadamPoint::z(self : OptgradadamPoint) -> Double { self.z }

pub fn OptgradadamPoint::label(self : OptgradadamPoint) -> Int { self.label }

pub fn OptgradadamPoint::dist(self : OptgradadamPoint, other : OptgradadamPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn OptgradadamPoint::add(self : OptgradadamPoint, other : OptgradadamPoint) -> OptgradadamPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn OptgradadamPoint::sub(self : OptgradadamPoint, other : OptgradadamPoint) -> OptgradadamPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn OptgradadamPoint::scale(self : OptgradadamPoint, s : Double) -> OptgradadamPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn OptgradadamPoint::dot(self : OptgradadamPoint, other : OptgradadamPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn OptgradadamPoint::cross(self : OptgradadamPoint, other : OptgradadamPoint) -> OptgradadamPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn OptgradadamPoint::norm(self : OptgradadamPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn OptgradadamPoint::normalize(self : OptgradadamPoint) -> OptgradadamPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradadamPoint::negate(self : OptgradadamPoint) -> OptgradadamPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn OptgradadamPoint::mid(self : OptgradadamPoint, other : OptgradadamPoint) -> OptgradadamPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn OptgradadamPoint::lerp(self : OptgradadamPoint, other : OptgradadamPoint, t : Double) -> OptgradadamPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn OptgradadamPoint::to_string(self : OptgradadamPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct OptgradadamSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_adam_make_series(vals : Array[Double], name : String) -> OptgradadamSeries {
  { vals, name, meta: 0 }
}

pub fn OptgradadamSeries::len(self : OptgradadamSeries) -> Int { self.vals.length() }

pub fn OptgradadamSeries::sum(self : OptgradadamSeries) -> Double { @_common.sum(self.vals) }

pub fn OptgradadamSeries::mean(self : OptgradadamSeries) -> Double { @_common.mean(self.vals) }

pub fn OptgradadamSeries::min(self : OptgradadamSeries) -> Double { @_common.min(self.vals) }

pub fn OptgradadamSeries::max(self : OptgradadamSeries) -> Double { @_common.max(self.vals) }

pub fn OptgradadamSeries::range(self : OptgradadamSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn OptgradadamSeries::variance(self : OptgradadamSeries) -> Double { @_common.variance(self.vals) }

pub fn OptgradadamSeries::std(self : OptgradadamSeries) -> Double { @_common.std(self.vals) }

pub fn OptgradadamSeries::median(self : OptgradadamSeries) -> Double { @_common.median(self.vals) }

pub fn OptgradadamSeries::scale(self : OptgradadamSeries, f : Double) -> OptgradadamSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn OptgradadamSeries::add(self : OptgradadamSeries, other : OptgradadamSeries) -> OptgradadamSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn OptgradadamSeries::sub(self : OptgradadamSeries, other : OptgradadamSeries) -> OptgradadamSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn OptgradadamSeries::normalize(self : OptgradadamSeries) -> OptgradadamSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn OptgradadamSeries::cumsum(self : OptgradadamSeries) -> OptgradadamSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn OptgradadamSeries::to_string(self : OptgradadamSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradadamMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_adam_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradadamMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_adam_matrix_identity(n : Int) -> OptgradadamMatrix {
  let m = opt_grad_adam_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn OptgradadamMatrix::get(self : OptgradadamMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn OptgradadamMatrix::transpose(self : OptgradadamMatrix) -> OptgradadamMatrix {
  let result = opt_grad_adam_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn OptgradadamMatrix::add(self : OptgradadamMatrix, other : OptgradadamMatrix) -> OptgradadamMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = opt_grad_adam_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn OptgradadamMatrix::scale(self : OptgradadamMatrix, s : Double) -> OptgradadamMatrix {
  let result = opt_grad_adam_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn OptgradadamMatrix::multiply(self : OptgradadamMatrix, other : OptgradadamMatrix) -> OptgradadamMatrix {
  if self.cols != other.rows { return opt_grad_adam_make_matrix(self.rows, other.cols, 0.0) }
  let result = opt_grad_adam_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn OptgradadamMatrix::trace(self : OptgradadamMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn OptgradadamMatrix::det(self : OptgradadamMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn OptgradadamMatrix::norm(self : OptgradadamMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn OptgradadamMatrix::to_string(self : OptgradadamMatrix) -> String {
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

pub(all) struct OptgradadamVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_adam_make_vector(comps : Array[Double]) -> OptgradadamVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_adam_vector_zero(dim : Int) -> OptgradadamVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn OptgradadamVector::add(self : OptgradadamVector, other : OptgradadamVector) -> OptgradadamVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradadamVector::sub(self : OptgradadamVector, other : OptgradadamVector) -> OptgradadamVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn OptgradadamVector::scale(self : OptgradadamVector, s : Double) -> OptgradadamVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn OptgradadamVector::dot(self : OptgradadamVector, other : OptgradadamVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn OptgradadamVector::norm(self : OptgradadamVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn OptgradadamVector::normalize(self : OptgradadamVector) -> OptgradadamVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn OptgradadamVector::dist(self : OptgradadamVector, other : OptgradadamVector) -> Double {
  self.sub(other).norm()
}

pub fn OptgradadamVector::to_string(self : OptgradadamVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_adam_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn opt_grad_adam_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn opt_grad_adam_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn opt_grad_adam_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn opt_grad_adam_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn opt_grad_adam_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn opt_grad_adam_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn opt_grad_adam_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn opt_grad_adam_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn opt_grad_adam_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn opt_grad_adam_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn opt_grad_adam_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn opt_grad_adam_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn opt_grad_adam_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn opt_grad_adam_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn opt_grad_adam_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn opt_grad_adam_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn opt_grad_adam_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn opt_grad_adam_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn opt_grad_adam_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn opt_grad_adam_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn opt_grad_adam_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn opt_grad_adam_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn opt_grad_adam_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn opt_grad_adam_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn opt_grad_adam_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn opt_grad_adam_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn opt_grad_adam_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn opt_grad_adam_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct OptgradadamFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_frame_make(size : Int) -> OptgradadamFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_frame_len(s : OptgradadamFrame) -> Int { s.size }

pub fn opt_grad_adam_frame_get(s : OptgradadamFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_frame_set(s : OptgradadamFrame, i : Int, v : Double) -> OptgradadamFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_frame_sum(s : OptgradadamFrame) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_frame_mean(s : OptgradadamFrame) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_frame_scale(s : OptgradadamFrame, f : Double) -> OptgradadamFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_frame_add(a : OptgradadamFrame, b : OptgradadamFrame) -> OptgradadamFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_frame_copy(s : OptgradadamFrame) -> OptgradadamFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_frame_fill(s : OptgradadamFrame, v : Double) -> OptgradadamFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_frame_min(s : OptgradadamFrame) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_frame_max(s : OptgradadamFrame) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_frame_to_string(s : OptgradadamFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_table_make(size : Int) -> OptgradadamTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_table_len(s : OptgradadamTable) -> Int { s.size }

pub fn opt_grad_adam_table_get(s : OptgradadamTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_table_set(s : OptgradadamTable, i : Int, v : Double) -> OptgradadamTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_table_sum(s : OptgradadamTable) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_table_mean(s : OptgradadamTable) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_table_scale(s : OptgradadamTable, f : Double) -> OptgradadamTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_table_add(a : OptgradadamTable, b : OptgradadamTable) -> OptgradadamTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_table_copy(s : OptgradadamTable) -> OptgradadamTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_table_fill(s : OptgradadamTable, v : Double) -> OptgradadamTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_table_min(s : OptgradadamTable) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_table_max(s : OptgradadamTable) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_table_to_string(s : OptgradadamTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_graphn_make(size : Int) -> OptgradadamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_graphn_len(s : OptgradadamGraphN) -> Int { s.size }

pub fn opt_grad_adam_graphn_get(s : OptgradadamGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_graphn_set(s : OptgradadamGraphN, i : Int, v : Double) -> OptgradadamGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_graphn_sum(s : OptgradadamGraphN) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_graphn_mean(s : OptgradadamGraphN) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_graphn_scale(s : OptgradadamGraphN, f : Double) -> OptgradadamGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_graphn_add(a : OptgradadamGraphN, b : OptgradadamGraphN) -> OptgradadamGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_graphn_copy(s : OptgradadamGraphN) -> OptgradadamGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_graphn_fill(s : OptgradadamGraphN, v : Double) -> OptgradadamGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_graphn_min(s : OptgradadamGraphN) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_graphn_max(s : OptgradadamGraphN) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_graphn_to_string(s : OptgradadamGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_node_make(size : Int) -> OptgradadamNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_node_len(s : OptgradadamNode) -> Int { s.size }

pub fn opt_grad_adam_node_get(s : OptgradadamNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_node_set(s : OptgradadamNode, i : Int, v : Double) -> OptgradadamNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_node_sum(s : OptgradadamNode) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_node_mean(s : OptgradadamNode) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_node_scale(s : OptgradadamNode, f : Double) -> OptgradadamNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_node_add(a : OptgradadamNode, b : OptgradadamNode) -> OptgradadamNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_node_copy(s : OptgradadamNode) -> OptgradadamNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_node_fill(s : OptgradadamNode, v : Double) -> OptgradadamNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_node_min(s : OptgradadamNode) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_node_max(s : OptgradadamNode) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_node_to_string(s : OptgradadamNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_edge_make(size : Int) -> OptgradadamEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_edge_len(s : OptgradadamEdge) -> Int { s.size }

pub fn opt_grad_adam_edge_get(s : OptgradadamEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_edge_set(s : OptgradadamEdge, i : Int, v : Double) -> OptgradadamEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_edge_sum(s : OptgradadamEdge) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_edge_mean(s : OptgradadamEdge) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_edge_scale(s : OptgradadamEdge, f : Double) -> OptgradadamEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_edge_add(a : OptgradadamEdge, b : OptgradadamEdge) -> OptgradadamEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_edge_copy(s : OptgradadamEdge) -> OptgradadamEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_edge_fill(s : OptgradadamEdge, v : Double) -> OptgradadamEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_edge_min(s : OptgradadamEdge) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_edge_max(s : OptgradadamEdge) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_edge_to_string(s : OptgradadamEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_path_make(size : Int) -> OptgradadamPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_path_len(s : OptgradadamPath) -> Int { s.size }

pub fn opt_grad_adam_path_get(s : OptgradadamPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_path_set(s : OptgradadamPath, i : Int, v : Double) -> OptgradadamPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_path_sum(s : OptgradadamPath) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_path_mean(s : OptgradadamPath) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_path_scale(s : OptgradadamPath, f : Double) -> OptgradadamPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_path_add(a : OptgradadamPath, b : OptgradadamPath) -> OptgradadamPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_path_copy(s : OptgradadamPath) -> OptgradadamPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_path_fill(s : OptgradadamPath, v : Double) -> OptgradadamPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_path_min(s : OptgradadamPath) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_path_max(s : OptgradadamPath) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_path_to_string(s : OptgradadamPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_cluster_make(size : Int) -> OptgradadamCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_cluster_len(s : OptgradadamCluster) -> Int { s.size }

pub fn opt_grad_adam_cluster_get(s : OptgradadamCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_cluster_set(s : OptgradadamCluster, i : Int, v : Double) -> OptgradadamCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cluster_sum(s : OptgradadamCluster) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_cluster_mean(s : OptgradadamCluster) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_cluster_scale(s : OptgradadamCluster, f : Double) -> OptgradadamCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cluster_add(a : OptgradadamCluster, b : OptgradadamCluster) -> OptgradadamCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_cluster_copy(s : OptgradadamCluster) -> OptgradadamCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cluster_fill(s : OptgradadamCluster, v : Double) -> OptgradadamCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cluster_min(s : OptgradadamCluster) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_cluster_max(s : OptgradadamCluster) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_cluster_to_string(s : OptgradadamCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_model_make(size : Int) -> OptgradadamModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_model_len(s : OptgradadamModel) -> Int { s.size }

pub fn opt_grad_adam_model_get(s : OptgradadamModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_model_set(s : OptgradadamModel, i : Int, v : Double) -> OptgradadamModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_model_sum(s : OptgradadamModel) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_model_mean(s : OptgradadamModel) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_model_scale(s : OptgradadamModel, f : Double) -> OptgradadamModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_model_add(a : OptgradadamModel, b : OptgradadamModel) -> OptgradadamModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_model_copy(s : OptgradadamModel) -> OptgradadamModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_model_fill(s : OptgradadamModel, v : Double) -> OptgradadamModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_model_min(s : OptgradadamModel) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_model_max(s : OptgradadamModel) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_model_to_string(s : OptgradadamModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_layer_make(size : Int) -> OptgradadamLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_layer_len(s : OptgradadamLayer) -> Int { s.size }

pub fn opt_grad_adam_layer_get(s : OptgradadamLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_layer_set(s : OptgradadamLayer, i : Int, v : Double) -> OptgradadamLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_layer_sum(s : OptgradadamLayer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_layer_mean(s : OptgradadamLayer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_layer_scale(s : OptgradadamLayer, f : Double) -> OptgradadamLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_layer_add(a : OptgradadamLayer, b : OptgradadamLayer) -> OptgradadamLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_layer_copy(s : OptgradadamLayer) -> OptgradadamLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_layer_fill(s : OptgradadamLayer, v : Double) -> OptgradadamLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_layer_min(s : OptgradadamLayer) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_layer_max(s : OptgradadamLayer) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_layer_to_string(s : OptgradadamLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_buffer_make(size : Int) -> OptgradadamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_buffer_len(s : OptgradadamBuffer) -> Int { s.size }

pub fn opt_grad_adam_buffer_get(s : OptgradadamBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_buffer_set(s : OptgradadamBuffer, i : Int, v : Double) -> OptgradadamBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_buffer_sum(s : OptgradadamBuffer) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_buffer_mean(s : OptgradadamBuffer) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_buffer_scale(s : OptgradadamBuffer, f : Double) -> OptgradadamBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_buffer_add(a : OptgradadamBuffer, b : OptgradadamBuffer) -> OptgradadamBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_buffer_copy(s : OptgradadamBuffer) -> OptgradadamBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_buffer_fill(s : OptgradadamBuffer, v : Double) -> OptgradadamBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_buffer_min(s : OptgradadamBuffer) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_buffer_max(s : OptgradadamBuffer) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_buffer_to_string(s : OptgradadamBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_cursor_make(size : Int) -> OptgradadamCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_cursor_len(s : OptgradadamCursor) -> Int { s.size }

pub fn opt_grad_adam_cursor_get(s : OptgradadamCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_cursor_set(s : OptgradadamCursor, i : Int, v : Double) -> OptgradadamCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cursor_sum(s : OptgradadamCursor) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_cursor_mean(s : OptgradadamCursor) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_cursor_scale(s : OptgradadamCursor, f : Double) -> OptgradadamCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cursor_add(a : OptgradadamCursor, b : OptgradadamCursor) -> OptgradadamCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_cursor_copy(s : OptgradadamCursor) -> OptgradadamCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cursor_fill(s : OptgradadamCursor, v : Double) -> OptgradadamCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_cursor_min(s : OptgradadamCursor) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_cursor_max(s : OptgradadamCursor) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_cursor_to_string(s : OptgradadamCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_view_make(size : Int) -> OptgradadamView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_view_len(s : OptgradadamView) -> Int { s.size }

pub fn opt_grad_adam_view_get(s : OptgradadamView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_view_set(s : OptgradadamView, i : Int, v : Double) -> OptgradadamView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_view_sum(s : OptgradadamView) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_view_mean(s : OptgradadamView) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_view_scale(s : OptgradadamView, f : Double) -> OptgradadamView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_view_add(a : OptgradadamView, b : OptgradadamView) -> OptgradadamView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_view_copy(s : OptgradadamView) -> OptgradadamView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_view_fill(s : OptgradadamView, v : Double) -> OptgradadamView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_view_min(s : OptgradadamView) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_view_max(s : OptgradadamView) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_view_to_string(s : OptgradadamView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_range_make(size : Int) -> OptgradadamRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_range_len(s : OptgradadamRange) -> Int { s.size }

pub fn opt_grad_adam_range_get(s : OptgradadamRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_range_set(s : OptgradadamRange, i : Int, v : Double) -> OptgradadamRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_range_sum(s : OptgradadamRange) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_range_mean(s : OptgradadamRange) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_range_scale(s : OptgradadamRange, f : Double) -> OptgradadamRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_range_add(a : OptgradadamRange, b : OptgradadamRange) -> OptgradadamRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_range_copy(s : OptgradadamRange) -> OptgradadamRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_range_fill(s : OptgradadamRange, v : Double) -> OptgradadamRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_range_min(s : OptgradadamRange) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_range_max(s : OptgradadamRange) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_range_to_string(s : OptgradadamRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradadamSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_slice_make(size : Int) -> OptgradadamSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_adam_slice_len(s : OptgradadamSlice) -> Int { s.size }

pub fn opt_grad_adam_slice_get(s : OptgradadamSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_adam_slice_set(s : OptgradadamSlice, i : Int, v : Double) -> OptgradadamSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_slice_sum(s : OptgradadamSlice) -> Double { @_common.sum(s.data) }

pub fn opt_grad_adam_slice_mean(s : OptgradadamSlice) -> Double { @_common.mean(s.data) }

pub fn opt_grad_adam_slice_scale(s : OptgradadamSlice, f : Double) -> OptgradadamSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_slice_add(a : OptgradadamSlice, b : OptgradadamSlice) -> OptgradadamSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn opt_grad_adam_slice_copy(s : OptgradadamSlice) -> OptgradadamSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_slice_fill(s : OptgradadamSlice, v : Double) -> OptgradadamSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn opt_grad_adam_slice_min(s : OptgradadamSlice) -> Double { @_common.min(s.data) }

pub fn opt_grad_adam_slice_max(s : OptgradadamSlice) -> Double { @_common.max(s.data) }

pub fn opt_grad_adam_slice_to_string(s : OptgradadamSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

