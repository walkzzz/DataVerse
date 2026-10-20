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

pub fn OptgradadamFrame::len(self : OptgradadamFrame) -> Int { self.size }

pub fn OptgradadamFrame::get(self : OptgradadamFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamFrame::set(self : OptgradadamFrame, i : Int, v : Double) -> OptgradadamFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamFrame::sum(self : OptgradadamFrame) -> Double { @_common.sum(self.data) }

pub fn OptgradadamFrame::mean(self : OptgradadamFrame) -> Double { @_common.mean(self.data) }

pub fn OptgradadamFrame::scale(self : OptgradadamFrame, f : Double) -> OptgradadamFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamFrame::add(self : OptgradadamFrame, other : OptgradadamFrame) -> OptgradadamFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamFrame::copy(self : OptgradadamFrame) -> OptgradadamFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamFrame::fill(self : OptgradadamFrame, v : Double) -> OptgradadamFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamFrame::min(self : OptgradadamFrame) -> Double { @_common.min(self.data) }

pub fn OptgradadamFrame::max(self : OptgradadamFrame) -> Double { @_common.max(self.data) }

pub fn OptgradadamFrame::to_string(self : OptgradadamFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_table_make(size : Int) -> OptgradadamTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamTable::len(self : OptgradadamTable) -> Int { self.size }

pub fn OptgradadamTable::get(self : OptgradadamTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamTable::set(self : OptgradadamTable, i : Int, v : Double) -> OptgradadamTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamTable::sum(self : OptgradadamTable) -> Double { @_common.sum(self.data) }

pub fn OptgradadamTable::mean(self : OptgradadamTable) -> Double { @_common.mean(self.data) }

pub fn OptgradadamTable::scale(self : OptgradadamTable, f : Double) -> OptgradadamTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamTable::add(self : OptgradadamTable, other : OptgradadamTable) -> OptgradadamTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamTable::copy(self : OptgradadamTable) -> OptgradadamTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamTable::fill(self : OptgradadamTable, v : Double) -> OptgradadamTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamTable::min(self : OptgradadamTable) -> Double { @_common.min(self.data) }

pub fn OptgradadamTable::max(self : OptgradadamTable) -> Double { @_common.max(self.data) }

pub fn OptgradadamTable::to_string(self : OptgradadamTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_graphn_make(size : Int) -> OptgradadamGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamGraphN::len(self : OptgradadamGraphN) -> Int { self.size }

pub fn OptgradadamGraphN::get(self : OptgradadamGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamGraphN::set(self : OptgradadamGraphN, i : Int, v : Double) -> OptgradadamGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamGraphN::sum(self : OptgradadamGraphN) -> Double { @_common.sum(self.data) }

pub fn OptgradadamGraphN::mean(self : OptgradadamGraphN) -> Double { @_common.mean(self.data) }

pub fn OptgradadamGraphN::scale(self : OptgradadamGraphN, f : Double) -> OptgradadamGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamGraphN::add(self : OptgradadamGraphN, other : OptgradadamGraphN) -> OptgradadamGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamGraphN::copy(self : OptgradadamGraphN) -> OptgradadamGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamGraphN::fill(self : OptgradadamGraphN, v : Double) -> OptgradadamGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamGraphN::min(self : OptgradadamGraphN) -> Double { @_common.min(self.data) }

pub fn OptgradadamGraphN::max(self : OptgradadamGraphN) -> Double { @_common.max(self.data) }

pub fn OptgradadamGraphN::to_string(self : OptgradadamGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_node_make(size : Int) -> OptgradadamNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamNode::len(self : OptgradadamNode) -> Int { self.size }

pub fn OptgradadamNode::get(self : OptgradadamNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamNode::set(self : OptgradadamNode, i : Int, v : Double) -> OptgradadamNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamNode::sum(self : OptgradadamNode) -> Double { @_common.sum(self.data) }

pub fn OptgradadamNode::mean(self : OptgradadamNode) -> Double { @_common.mean(self.data) }

pub fn OptgradadamNode::scale(self : OptgradadamNode, f : Double) -> OptgradadamNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamNode::add(self : OptgradadamNode, other : OptgradadamNode) -> OptgradadamNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamNode::copy(self : OptgradadamNode) -> OptgradadamNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamNode::fill(self : OptgradadamNode, v : Double) -> OptgradadamNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamNode::min(self : OptgradadamNode) -> Double { @_common.min(self.data) }

pub fn OptgradadamNode::max(self : OptgradadamNode) -> Double { @_common.max(self.data) }

pub fn OptgradadamNode::to_string(self : OptgradadamNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_edge_make(size : Int) -> OptgradadamEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamEdge::len(self : OptgradadamEdge) -> Int { self.size }

pub fn OptgradadamEdge::get(self : OptgradadamEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamEdge::set(self : OptgradadamEdge, i : Int, v : Double) -> OptgradadamEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamEdge::sum(self : OptgradadamEdge) -> Double { @_common.sum(self.data) }

pub fn OptgradadamEdge::mean(self : OptgradadamEdge) -> Double { @_common.mean(self.data) }

pub fn OptgradadamEdge::scale(self : OptgradadamEdge, f : Double) -> OptgradadamEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamEdge::add(self : OptgradadamEdge, other : OptgradadamEdge) -> OptgradadamEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamEdge::copy(self : OptgradadamEdge) -> OptgradadamEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamEdge::fill(self : OptgradadamEdge, v : Double) -> OptgradadamEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamEdge::min(self : OptgradadamEdge) -> Double { @_common.min(self.data) }

pub fn OptgradadamEdge::max(self : OptgradadamEdge) -> Double { @_common.max(self.data) }

pub fn OptgradadamEdge::to_string(self : OptgradadamEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_path_make(size : Int) -> OptgradadamPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamPath::len(self : OptgradadamPath) -> Int { self.size }

pub fn OptgradadamPath::get(self : OptgradadamPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamPath::set(self : OptgradadamPath, i : Int, v : Double) -> OptgradadamPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamPath::sum(self : OptgradadamPath) -> Double { @_common.sum(self.data) }

pub fn OptgradadamPath::mean(self : OptgradadamPath) -> Double { @_common.mean(self.data) }

pub fn OptgradadamPath::scale(self : OptgradadamPath, f : Double) -> OptgradadamPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamPath::add(self : OptgradadamPath, other : OptgradadamPath) -> OptgradadamPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamPath::copy(self : OptgradadamPath) -> OptgradadamPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamPath::fill(self : OptgradadamPath, v : Double) -> OptgradadamPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamPath::min(self : OptgradadamPath) -> Double { @_common.min(self.data) }

pub fn OptgradadamPath::max(self : OptgradadamPath) -> Double { @_common.max(self.data) }

pub fn OptgradadamPath::to_string(self : OptgradadamPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_cluster_make(size : Int) -> OptgradadamCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamCluster::len(self : OptgradadamCluster) -> Int { self.size }

pub fn OptgradadamCluster::get(self : OptgradadamCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamCluster::set(self : OptgradadamCluster, i : Int, v : Double) -> OptgradadamCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamCluster::sum(self : OptgradadamCluster) -> Double { @_common.sum(self.data) }

pub fn OptgradadamCluster::mean(self : OptgradadamCluster) -> Double { @_common.mean(self.data) }

pub fn OptgradadamCluster::scale(self : OptgradadamCluster, f : Double) -> OptgradadamCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamCluster::add(self : OptgradadamCluster, other : OptgradadamCluster) -> OptgradadamCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamCluster::copy(self : OptgradadamCluster) -> OptgradadamCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamCluster::fill(self : OptgradadamCluster, v : Double) -> OptgradadamCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamCluster::min(self : OptgradadamCluster) -> Double { @_common.min(self.data) }

pub fn OptgradadamCluster::max(self : OptgradadamCluster) -> Double { @_common.max(self.data) }

pub fn OptgradadamCluster::to_string(self : OptgradadamCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_model_make(size : Int) -> OptgradadamModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamModel::len(self : OptgradadamModel) -> Int { self.size }

pub fn OptgradadamModel::get(self : OptgradadamModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamModel::set(self : OptgradadamModel, i : Int, v : Double) -> OptgradadamModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamModel::sum(self : OptgradadamModel) -> Double { @_common.sum(self.data) }

pub fn OptgradadamModel::mean(self : OptgradadamModel) -> Double { @_common.mean(self.data) }

pub fn OptgradadamModel::scale(self : OptgradadamModel, f : Double) -> OptgradadamModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamModel::add(self : OptgradadamModel, other : OptgradadamModel) -> OptgradadamModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamModel::copy(self : OptgradadamModel) -> OptgradadamModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamModel::fill(self : OptgradadamModel, v : Double) -> OptgradadamModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamModel::min(self : OptgradadamModel) -> Double { @_common.min(self.data) }

pub fn OptgradadamModel::max(self : OptgradadamModel) -> Double { @_common.max(self.data) }

pub fn OptgradadamModel::to_string(self : OptgradadamModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_layer_make(size : Int) -> OptgradadamLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamLayer::len(self : OptgradadamLayer) -> Int { self.size }

pub fn OptgradadamLayer::get(self : OptgradadamLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamLayer::set(self : OptgradadamLayer, i : Int, v : Double) -> OptgradadamLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamLayer::sum(self : OptgradadamLayer) -> Double { @_common.sum(self.data) }

pub fn OptgradadamLayer::mean(self : OptgradadamLayer) -> Double { @_common.mean(self.data) }

pub fn OptgradadamLayer::scale(self : OptgradadamLayer, f : Double) -> OptgradadamLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamLayer::add(self : OptgradadamLayer, other : OptgradadamLayer) -> OptgradadamLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamLayer::copy(self : OptgradadamLayer) -> OptgradadamLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamLayer::fill(self : OptgradadamLayer, v : Double) -> OptgradadamLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamLayer::min(self : OptgradadamLayer) -> Double { @_common.min(self.data) }

pub fn OptgradadamLayer::max(self : OptgradadamLayer) -> Double { @_common.max(self.data) }

pub fn OptgradadamLayer::to_string(self : OptgradadamLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_buffer_make(size : Int) -> OptgradadamBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamBuffer::len(self : OptgradadamBuffer) -> Int { self.size }

pub fn OptgradadamBuffer::get(self : OptgradadamBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamBuffer::set(self : OptgradadamBuffer, i : Int, v : Double) -> OptgradadamBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamBuffer::sum(self : OptgradadamBuffer) -> Double { @_common.sum(self.data) }

pub fn OptgradadamBuffer::mean(self : OptgradadamBuffer) -> Double { @_common.mean(self.data) }

pub fn OptgradadamBuffer::scale(self : OptgradadamBuffer, f : Double) -> OptgradadamBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamBuffer::add(self : OptgradadamBuffer, other : OptgradadamBuffer) -> OptgradadamBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamBuffer::copy(self : OptgradadamBuffer) -> OptgradadamBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamBuffer::fill(self : OptgradadamBuffer, v : Double) -> OptgradadamBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamBuffer::min(self : OptgradadamBuffer) -> Double { @_common.min(self.data) }

pub fn OptgradadamBuffer::max(self : OptgradadamBuffer) -> Double { @_common.max(self.data) }

pub fn OptgradadamBuffer::to_string(self : OptgradadamBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_cursor_make(size : Int) -> OptgradadamCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamCursor::len(self : OptgradadamCursor) -> Int { self.size }

pub fn OptgradadamCursor::get(self : OptgradadamCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamCursor::set(self : OptgradadamCursor, i : Int, v : Double) -> OptgradadamCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamCursor::sum(self : OptgradadamCursor) -> Double { @_common.sum(self.data) }

pub fn OptgradadamCursor::mean(self : OptgradadamCursor) -> Double { @_common.mean(self.data) }

pub fn OptgradadamCursor::scale(self : OptgradadamCursor, f : Double) -> OptgradadamCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamCursor::add(self : OptgradadamCursor, other : OptgradadamCursor) -> OptgradadamCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamCursor::copy(self : OptgradadamCursor) -> OptgradadamCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamCursor::fill(self : OptgradadamCursor, v : Double) -> OptgradadamCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamCursor::min(self : OptgradadamCursor) -> Double { @_common.min(self.data) }

pub fn OptgradadamCursor::max(self : OptgradadamCursor) -> Double { @_common.max(self.data) }

pub fn OptgradadamCursor::to_string(self : OptgradadamCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_view_make(size : Int) -> OptgradadamView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamView::len(self : OptgradadamView) -> Int { self.size }

pub fn OptgradadamView::get(self : OptgradadamView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamView::set(self : OptgradadamView, i : Int, v : Double) -> OptgradadamView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamView::sum(self : OptgradadamView) -> Double { @_common.sum(self.data) }

pub fn OptgradadamView::mean(self : OptgradadamView) -> Double { @_common.mean(self.data) }

pub fn OptgradadamView::scale(self : OptgradadamView, f : Double) -> OptgradadamView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamView::add(self : OptgradadamView, other : OptgradadamView) -> OptgradadamView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamView::copy(self : OptgradadamView) -> OptgradadamView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamView::fill(self : OptgradadamView, v : Double) -> OptgradadamView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamView::min(self : OptgradadamView) -> Double { @_common.min(self.data) }

pub fn OptgradadamView::max(self : OptgradadamView) -> Double { @_common.max(self.data) }

pub fn OptgradadamView::to_string(self : OptgradadamView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_range_make(size : Int) -> OptgradadamRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamRange::len(self : OptgradadamRange) -> Int { self.size }

pub fn OptgradadamRange::get(self : OptgradadamRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamRange::set(self : OptgradadamRange, i : Int, v : Double) -> OptgradadamRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamRange::sum(self : OptgradadamRange) -> Double { @_common.sum(self.data) }

pub fn OptgradadamRange::mean(self : OptgradadamRange) -> Double { @_common.mean(self.data) }

pub fn OptgradadamRange::scale(self : OptgradadamRange, f : Double) -> OptgradadamRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamRange::add(self : OptgradadamRange, other : OptgradadamRange) -> OptgradadamRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamRange::copy(self : OptgradadamRange) -> OptgradadamRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamRange::fill(self : OptgradadamRange, v : Double) -> OptgradadamRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamRange::min(self : OptgradadamRange) -> Double { @_common.min(self.data) }

pub fn OptgradadamRange::max(self : OptgradadamRange) -> Double { @_common.max(self.data) }

pub fn OptgradadamRange::to_string(self : OptgradadamRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptgradadamSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_adam_slice_make(size : Int) -> OptgradadamSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptgradadamSlice::len(self : OptgradadamSlice) -> Int { self.size }

pub fn OptgradadamSlice::get(self : OptgradadamSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptgradadamSlice::set(self : OptgradadamSlice, i : Int, v : Double) -> OptgradadamSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptgradadamSlice::sum(self : OptgradadamSlice) -> Double { @_common.sum(self.data) }

pub fn OptgradadamSlice::mean(self : OptgradadamSlice) -> Double { @_common.mean(self.data) }

pub fn OptgradadamSlice::scale(self : OptgradadamSlice, f : Double) -> OptgradadamSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptgradadamSlice::add(self : OptgradadamSlice, other : OptgradadamSlice) -> OptgradadamSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptgradadamSlice::copy(self : OptgradadamSlice) -> OptgradadamSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptgradadamSlice::fill(self : OptgradadamSlice, v : Double) -> OptgradadamSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptgradadamSlice::min(self : OptgradadamSlice) -> Double { @_common.min(self.data) }

pub fn OptgradadamSlice::max(self : OptgradadamSlice) -> Double { @_common.max(self.data) }

pub fn OptgradadamSlice::to_string(self : OptgradadamSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

