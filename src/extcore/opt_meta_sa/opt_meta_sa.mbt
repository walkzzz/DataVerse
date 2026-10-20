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

pub fn OptmetasaFrame::len(self : OptmetasaFrame) -> Int { self.size }

pub fn OptmetasaFrame::get(self : OptmetasaFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetasaFrame::set(self : OptmetasaFrame, i : Int, v : Double) -> OptmetasaFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetasaFrame::sum(self : OptmetasaFrame) -> Double { @_common.sum(self.data) }

pub fn OptmetasaFrame::mean(self : OptmetasaFrame) -> Double { @_common.mean(self.data) }

pub fn OptmetasaFrame::scale(self : OptmetasaFrame, f : Double) -> OptmetasaFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetasaFrame::add(self : OptmetasaFrame, other : OptmetasaFrame) -> OptmetasaFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetasaFrame::copy(self : OptmetasaFrame) -> OptmetasaFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetasaFrame::fill(self : OptmetasaFrame, v : Double) -> OptmetasaFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetasaFrame::min(self : OptmetasaFrame) -> Double { @_common.min(self.data) }

pub fn OptmetasaFrame::max(self : OptmetasaFrame) -> Double { @_common.max(self.data) }

pub fn OptmetasaFrame::to_string(self : OptmetasaFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetasaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_table_make(size : Int) -> OptmetasaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetasaTable::len(self : OptmetasaTable) -> Int { self.size }

pub fn OptmetasaTable::get(self : OptmetasaTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetasaTable::set(self : OptmetasaTable, i : Int, v : Double) -> OptmetasaTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetasaTable::sum(self : OptmetasaTable) -> Double { @_common.sum(self.data) }

pub fn OptmetasaTable::mean(self : OptmetasaTable) -> Double { @_common.mean(self.data) }

pub fn OptmetasaTable::scale(self : OptmetasaTable, f : Double) -> OptmetasaTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetasaTable::add(self : OptmetasaTable, other : OptmetasaTable) -> OptmetasaTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetasaTable::copy(self : OptmetasaTable) -> OptmetasaTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetasaTable::fill(self : OptmetasaTable, v : Double) -> OptmetasaTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetasaTable::min(self : OptmetasaTable) -> Double { @_common.min(self.data) }

pub fn OptmetasaTable::max(self : OptmetasaTable) -> Double { @_common.max(self.data) }

pub fn OptmetasaTable::to_string(self : OptmetasaTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetasaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_graphn_make(size : Int) -> OptmetasaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetasaGraphN::len(self : OptmetasaGraphN) -> Int { self.size }

pub fn OptmetasaGraphN::get(self : OptmetasaGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetasaGraphN::set(self : OptmetasaGraphN, i : Int, v : Double) -> OptmetasaGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetasaGraphN::sum(self : OptmetasaGraphN) -> Double { @_common.sum(self.data) }

pub fn OptmetasaGraphN::mean(self : OptmetasaGraphN) -> Double { @_common.mean(self.data) }

pub fn OptmetasaGraphN::scale(self : OptmetasaGraphN, f : Double) -> OptmetasaGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetasaGraphN::add(self : OptmetasaGraphN, other : OptmetasaGraphN) -> OptmetasaGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetasaGraphN::copy(self : OptmetasaGraphN) -> OptmetasaGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetasaGraphN::fill(self : OptmetasaGraphN, v : Double) -> OptmetasaGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetasaGraphN::min(self : OptmetasaGraphN) -> Double { @_common.min(self.data) }

pub fn OptmetasaGraphN::max(self : OptmetasaGraphN) -> Double { @_common.max(self.data) }

pub fn OptmetasaGraphN::to_string(self : OptmetasaGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetasaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_node_make(size : Int) -> OptmetasaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetasaNode::len(self : OptmetasaNode) -> Int { self.size }

pub fn OptmetasaNode::get(self : OptmetasaNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetasaNode::set(self : OptmetasaNode, i : Int, v : Double) -> OptmetasaNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetasaNode::sum(self : OptmetasaNode) -> Double { @_common.sum(self.data) }

pub fn OptmetasaNode::mean(self : OptmetasaNode) -> Double { @_common.mean(self.data) }

pub fn OptmetasaNode::scale(self : OptmetasaNode, f : Double) -> OptmetasaNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetasaNode::add(self : OptmetasaNode, other : OptmetasaNode) -> OptmetasaNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetasaNode::copy(self : OptmetasaNode) -> OptmetasaNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetasaNode::fill(self : OptmetasaNode, v : Double) -> OptmetasaNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetasaNode::min(self : OptmetasaNode) -> Double { @_common.min(self.data) }

pub fn OptmetasaNode::max(self : OptmetasaNode) -> Double { @_common.max(self.data) }

pub fn OptmetasaNode::to_string(self : OptmetasaNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetasaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_edge_make(size : Int) -> OptmetasaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetasaEdge::len(self : OptmetasaEdge) -> Int { self.size }

pub fn OptmetasaEdge::get(self : OptmetasaEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetasaEdge::set(self : OptmetasaEdge, i : Int, v : Double) -> OptmetasaEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetasaEdge::sum(self : OptmetasaEdge) -> Double { @_common.sum(self.data) }

pub fn OptmetasaEdge::mean(self : OptmetasaEdge) -> Double { @_common.mean(self.data) }

pub fn OptmetasaEdge::scale(self : OptmetasaEdge, f : Double) -> OptmetasaEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetasaEdge::add(self : OptmetasaEdge, other : OptmetasaEdge) -> OptmetasaEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetasaEdge::copy(self : OptmetasaEdge) -> OptmetasaEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetasaEdge::fill(self : OptmetasaEdge, v : Double) -> OptmetasaEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetasaEdge::min(self : OptmetasaEdge) -> Double { @_common.min(self.data) }

pub fn OptmetasaEdge::max(self : OptmetasaEdge) -> Double { @_common.max(self.data) }

pub fn OptmetasaEdge::to_string(self : OptmetasaEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetasaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_path_make(size : Int) -> OptmetasaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetasaPath::len(self : OptmetasaPath) -> Int { self.size }

pub fn OptmetasaPath::get(self : OptmetasaPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetasaPath::set(self : OptmetasaPath, i : Int, v : Double) -> OptmetasaPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetasaPath::sum(self : OptmetasaPath) -> Double { @_common.sum(self.data) }

pub fn OptmetasaPath::mean(self : OptmetasaPath) -> Double { @_common.mean(self.data) }

pub fn OptmetasaPath::scale(self : OptmetasaPath, f : Double) -> OptmetasaPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetasaPath::add(self : OptmetasaPath, other : OptmetasaPath) -> OptmetasaPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetasaPath::copy(self : OptmetasaPath) -> OptmetasaPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetasaPath::fill(self : OptmetasaPath, v : Double) -> OptmetasaPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetasaPath::min(self : OptmetasaPath) -> Double { @_common.min(self.data) }

pub fn OptmetasaPath::max(self : OptmetasaPath) -> Double { @_common.max(self.data) }

pub fn OptmetasaPath::to_string(self : OptmetasaPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetasaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_cluster_make(size : Int) -> OptmetasaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetasaCluster::len(self : OptmetasaCluster) -> Int { self.size }

pub fn OptmetasaCluster::get(self : OptmetasaCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetasaCluster::set(self : OptmetasaCluster, i : Int, v : Double) -> OptmetasaCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetasaCluster::sum(self : OptmetasaCluster) -> Double { @_common.sum(self.data) }

pub fn OptmetasaCluster::mean(self : OptmetasaCluster) -> Double { @_common.mean(self.data) }

pub fn OptmetasaCluster::scale(self : OptmetasaCluster, f : Double) -> OptmetasaCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetasaCluster::add(self : OptmetasaCluster, other : OptmetasaCluster) -> OptmetasaCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetasaCluster::copy(self : OptmetasaCluster) -> OptmetasaCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetasaCluster::fill(self : OptmetasaCluster, v : Double) -> OptmetasaCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetasaCluster::min(self : OptmetasaCluster) -> Double { @_common.min(self.data) }

pub fn OptmetasaCluster::max(self : OptmetasaCluster) -> Double { @_common.max(self.data) }

pub fn OptmetasaCluster::to_string(self : OptmetasaCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetasaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_model_make(size : Int) -> OptmetasaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetasaModel::len(self : OptmetasaModel) -> Int { self.size }

pub fn OptmetasaModel::get(self : OptmetasaModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetasaModel::set(self : OptmetasaModel, i : Int, v : Double) -> OptmetasaModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetasaModel::sum(self : OptmetasaModel) -> Double { @_common.sum(self.data) }

pub fn OptmetasaModel::mean(self : OptmetasaModel) -> Double { @_common.mean(self.data) }

pub fn OptmetasaModel::scale(self : OptmetasaModel, f : Double) -> OptmetasaModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetasaModel::add(self : OptmetasaModel, other : OptmetasaModel) -> OptmetasaModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetasaModel::copy(self : OptmetasaModel) -> OptmetasaModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetasaModel::fill(self : OptmetasaModel, v : Double) -> OptmetasaModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetasaModel::min(self : OptmetasaModel) -> Double { @_common.min(self.data) }

pub fn OptmetasaModel::max(self : OptmetasaModel) -> Double { @_common.max(self.data) }

pub fn OptmetasaModel::to_string(self : OptmetasaModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetasaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_layer_make(size : Int) -> OptmetasaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetasaLayer::len(self : OptmetasaLayer) -> Int { self.size }

pub fn OptmetasaLayer::get(self : OptmetasaLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetasaLayer::set(self : OptmetasaLayer, i : Int, v : Double) -> OptmetasaLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetasaLayer::sum(self : OptmetasaLayer) -> Double { @_common.sum(self.data) }

pub fn OptmetasaLayer::mean(self : OptmetasaLayer) -> Double { @_common.mean(self.data) }

pub fn OptmetasaLayer::scale(self : OptmetasaLayer, f : Double) -> OptmetasaLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetasaLayer::add(self : OptmetasaLayer, other : OptmetasaLayer) -> OptmetasaLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetasaLayer::copy(self : OptmetasaLayer) -> OptmetasaLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetasaLayer::fill(self : OptmetasaLayer, v : Double) -> OptmetasaLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetasaLayer::min(self : OptmetasaLayer) -> Double { @_common.min(self.data) }

pub fn OptmetasaLayer::max(self : OptmetasaLayer) -> Double { @_common.max(self.data) }

pub fn OptmetasaLayer::to_string(self : OptmetasaLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetasaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_buffer_make(size : Int) -> OptmetasaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetasaBuffer::len(self : OptmetasaBuffer) -> Int { self.size }

pub fn OptmetasaBuffer::get(self : OptmetasaBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetasaBuffer::set(self : OptmetasaBuffer, i : Int, v : Double) -> OptmetasaBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetasaBuffer::sum(self : OptmetasaBuffer) -> Double { @_common.sum(self.data) }

pub fn OptmetasaBuffer::mean(self : OptmetasaBuffer) -> Double { @_common.mean(self.data) }

pub fn OptmetasaBuffer::scale(self : OptmetasaBuffer, f : Double) -> OptmetasaBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetasaBuffer::add(self : OptmetasaBuffer, other : OptmetasaBuffer) -> OptmetasaBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetasaBuffer::copy(self : OptmetasaBuffer) -> OptmetasaBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetasaBuffer::fill(self : OptmetasaBuffer, v : Double) -> OptmetasaBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetasaBuffer::min(self : OptmetasaBuffer) -> Double { @_common.min(self.data) }

pub fn OptmetasaBuffer::max(self : OptmetasaBuffer) -> Double { @_common.max(self.data) }

pub fn OptmetasaBuffer::to_string(self : OptmetasaBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetasaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_cursor_make(size : Int) -> OptmetasaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetasaCursor::len(self : OptmetasaCursor) -> Int { self.size }

pub fn OptmetasaCursor::get(self : OptmetasaCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetasaCursor::set(self : OptmetasaCursor, i : Int, v : Double) -> OptmetasaCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetasaCursor::sum(self : OptmetasaCursor) -> Double { @_common.sum(self.data) }

pub fn OptmetasaCursor::mean(self : OptmetasaCursor) -> Double { @_common.mean(self.data) }

pub fn OptmetasaCursor::scale(self : OptmetasaCursor, f : Double) -> OptmetasaCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetasaCursor::add(self : OptmetasaCursor, other : OptmetasaCursor) -> OptmetasaCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetasaCursor::copy(self : OptmetasaCursor) -> OptmetasaCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetasaCursor::fill(self : OptmetasaCursor, v : Double) -> OptmetasaCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetasaCursor::min(self : OptmetasaCursor) -> Double { @_common.min(self.data) }

pub fn OptmetasaCursor::max(self : OptmetasaCursor) -> Double { @_common.max(self.data) }

pub fn OptmetasaCursor::to_string(self : OptmetasaCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetasaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_view_make(size : Int) -> OptmetasaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetasaView::len(self : OptmetasaView) -> Int { self.size }

pub fn OptmetasaView::get(self : OptmetasaView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetasaView::set(self : OptmetasaView, i : Int, v : Double) -> OptmetasaView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetasaView::sum(self : OptmetasaView) -> Double { @_common.sum(self.data) }

pub fn OptmetasaView::mean(self : OptmetasaView) -> Double { @_common.mean(self.data) }

pub fn OptmetasaView::scale(self : OptmetasaView, f : Double) -> OptmetasaView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetasaView::add(self : OptmetasaView, other : OptmetasaView) -> OptmetasaView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetasaView::copy(self : OptmetasaView) -> OptmetasaView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetasaView::fill(self : OptmetasaView, v : Double) -> OptmetasaView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetasaView::min(self : OptmetasaView) -> Double { @_common.min(self.data) }

pub fn OptmetasaView::max(self : OptmetasaView) -> Double { @_common.max(self.data) }

pub fn OptmetasaView::to_string(self : OptmetasaView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetasaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_range_make(size : Int) -> OptmetasaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetasaRange::len(self : OptmetasaRange) -> Int { self.size }

pub fn OptmetasaRange::get(self : OptmetasaRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetasaRange::set(self : OptmetasaRange, i : Int, v : Double) -> OptmetasaRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetasaRange::sum(self : OptmetasaRange) -> Double { @_common.sum(self.data) }

pub fn OptmetasaRange::mean(self : OptmetasaRange) -> Double { @_common.mean(self.data) }

pub fn OptmetasaRange::scale(self : OptmetasaRange, f : Double) -> OptmetasaRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetasaRange::add(self : OptmetasaRange, other : OptmetasaRange) -> OptmetasaRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetasaRange::copy(self : OptmetasaRange) -> OptmetasaRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetasaRange::fill(self : OptmetasaRange, v : Double) -> OptmetasaRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetasaRange::min(self : OptmetasaRange) -> Double { @_common.min(self.data) }

pub fn OptmetasaRange::max(self : OptmetasaRange) -> Double { @_common.max(self.data) }

pub fn OptmetasaRange::to_string(self : OptmetasaRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetasaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_sa_slice_make(size : Int) -> OptmetasaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetasaSlice::len(self : OptmetasaSlice) -> Int { self.size }

pub fn OptmetasaSlice::get(self : OptmetasaSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetasaSlice::set(self : OptmetasaSlice, i : Int, v : Double) -> OptmetasaSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetasaSlice::sum(self : OptmetasaSlice) -> Double { @_common.sum(self.data) }

pub fn OptmetasaSlice::mean(self : OptmetasaSlice) -> Double { @_common.mean(self.data) }

pub fn OptmetasaSlice::scale(self : OptmetasaSlice, f : Double) -> OptmetasaSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetasaSlice::add(self : OptmetasaSlice, other : OptmetasaSlice) -> OptmetasaSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetasaSlice::copy(self : OptmetasaSlice) -> OptmetasaSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetasaSlice::fill(self : OptmetasaSlice, v : Double) -> OptmetasaSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetasaSlice::min(self : OptmetasaSlice) -> Double { @_common.min(self.data) }

pub fn OptmetasaSlice::max(self : OptmetasaSlice) -> Double { @_common.max(self.data) }

pub fn OptmetasaSlice::to_string(self : OptmetasaSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

