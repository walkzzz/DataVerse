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

pub fn OptmetadifferentialFrame::len(self : OptmetadifferentialFrame) -> Int { self.size }

pub fn OptmetadifferentialFrame::get(self : OptmetadifferentialFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadifferentialFrame::set(self : OptmetadifferentialFrame, i : Int, v : Double) -> OptmetadifferentialFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialFrame::sum(self : OptmetadifferentialFrame) -> Double { @_common.sum(self.data) }

pub fn OptmetadifferentialFrame::mean(self : OptmetadifferentialFrame) -> Double { @_common.mean(self.data) }

pub fn OptmetadifferentialFrame::scale(self : OptmetadifferentialFrame, f : Double) -> OptmetadifferentialFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialFrame::add(self : OptmetadifferentialFrame, other : OptmetadifferentialFrame) -> OptmetadifferentialFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadifferentialFrame::copy(self : OptmetadifferentialFrame) -> OptmetadifferentialFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialFrame::fill(self : OptmetadifferentialFrame, v : Double) -> OptmetadifferentialFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialFrame::min(self : OptmetadifferentialFrame) -> Double { @_common.min(self.data) }

pub fn OptmetadifferentialFrame::max(self : OptmetadifferentialFrame) -> Double { @_common.max(self.data) }

pub fn OptmetadifferentialFrame::to_string(self : OptmetadifferentialFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_table_make(size : Int) -> OptmetadifferentialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadifferentialTable::len(self : OptmetadifferentialTable) -> Int { self.size }

pub fn OptmetadifferentialTable::get(self : OptmetadifferentialTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadifferentialTable::set(self : OptmetadifferentialTable, i : Int, v : Double) -> OptmetadifferentialTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialTable::sum(self : OptmetadifferentialTable) -> Double { @_common.sum(self.data) }

pub fn OptmetadifferentialTable::mean(self : OptmetadifferentialTable) -> Double { @_common.mean(self.data) }

pub fn OptmetadifferentialTable::scale(self : OptmetadifferentialTable, f : Double) -> OptmetadifferentialTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialTable::add(self : OptmetadifferentialTable, other : OptmetadifferentialTable) -> OptmetadifferentialTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadifferentialTable::copy(self : OptmetadifferentialTable) -> OptmetadifferentialTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialTable::fill(self : OptmetadifferentialTable, v : Double) -> OptmetadifferentialTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialTable::min(self : OptmetadifferentialTable) -> Double { @_common.min(self.data) }

pub fn OptmetadifferentialTable::max(self : OptmetadifferentialTable) -> Double { @_common.max(self.data) }

pub fn OptmetadifferentialTable::to_string(self : OptmetadifferentialTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_graphn_make(size : Int) -> OptmetadifferentialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadifferentialGraphN::len(self : OptmetadifferentialGraphN) -> Int { self.size }

pub fn OptmetadifferentialGraphN::get(self : OptmetadifferentialGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadifferentialGraphN::set(self : OptmetadifferentialGraphN, i : Int, v : Double) -> OptmetadifferentialGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialGraphN::sum(self : OptmetadifferentialGraphN) -> Double { @_common.sum(self.data) }

pub fn OptmetadifferentialGraphN::mean(self : OptmetadifferentialGraphN) -> Double { @_common.mean(self.data) }

pub fn OptmetadifferentialGraphN::scale(self : OptmetadifferentialGraphN, f : Double) -> OptmetadifferentialGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialGraphN::add(self : OptmetadifferentialGraphN, other : OptmetadifferentialGraphN) -> OptmetadifferentialGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadifferentialGraphN::copy(self : OptmetadifferentialGraphN) -> OptmetadifferentialGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialGraphN::fill(self : OptmetadifferentialGraphN, v : Double) -> OptmetadifferentialGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialGraphN::min(self : OptmetadifferentialGraphN) -> Double { @_common.min(self.data) }

pub fn OptmetadifferentialGraphN::max(self : OptmetadifferentialGraphN) -> Double { @_common.max(self.data) }

pub fn OptmetadifferentialGraphN::to_string(self : OptmetadifferentialGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_node_make(size : Int) -> OptmetadifferentialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadifferentialNode::len(self : OptmetadifferentialNode) -> Int { self.size }

pub fn OptmetadifferentialNode::get(self : OptmetadifferentialNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadifferentialNode::set(self : OptmetadifferentialNode, i : Int, v : Double) -> OptmetadifferentialNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialNode::sum(self : OptmetadifferentialNode) -> Double { @_common.sum(self.data) }

pub fn OptmetadifferentialNode::mean(self : OptmetadifferentialNode) -> Double { @_common.mean(self.data) }

pub fn OptmetadifferentialNode::scale(self : OptmetadifferentialNode, f : Double) -> OptmetadifferentialNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialNode::add(self : OptmetadifferentialNode, other : OptmetadifferentialNode) -> OptmetadifferentialNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadifferentialNode::copy(self : OptmetadifferentialNode) -> OptmetadifferentialNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialNode::fill(self : OptmetadifferentialNode, v : Double) -> OptmetadifferentialNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialNode::min(self : OptmetadifferentialNode) -> Double { @_common.min(self.data) }

pub fn OptmetadifferentialNode::max(self : OptmetadifferentialNode) -> Double { @_common.max(self.data) }

pub fn OptmetadifferentialNode::to_string(self : OptmetadifferentialNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_edge_make(size : Int) -> OptmetadifferentialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadifferentialEdge::len(self : OptmetadifferentialEdge) -> Int { self.size }

pub fn OptmetadifferentialEdge::get(self : OptmetadifferentialEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadifferentialEdge::set(self : OptmetadifferentialEdge, i : Int, v : Double) -> OptmetadifferentialEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialEdge::sum(self : OptmetadifferentialEdge) -> Double { @_common.sum(self.data) }

pub fn OptmetadifferentialEdge::mean(self : OptmetadifferentialEdge) -> Double { @_common.mean(self.data) }

pub fn OptmetadifferentialEdge::scale(self : OptmetadifferentialEdge, f : Double) -> OptmetadifferentialEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialEdge::add(self : OptmetadifferentialEdge, other : OptmetadifferentialEdge) -> OptmetadifferentialEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadifferentialEdge::copy(self : OptmetadifferentialEdge) -> OptmetadifferentialEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialEdge::fill(self : OptmetadifferentialEdge, v : Double) -> OptmetadifferentialEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialEdge::min(self : OptmetadifferentialEdge) -> Double { @_common.min(self.data) }

pub fn OptmetadifferentialEdge::max(self : OptmetadifferentialEdge) -> Double { @_common.max(self.data) }

pub fn OptmetadifferentialEdge::to_string(self : OptmetadifferentialEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_path_make(size : Int) -> OptmetadifferentialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadifferentialPath::len(self : OptmetadifferentialPath) -> Int { self.size }

pub fn OptmetadifferentialPath::get(self : OptmetadifferentialPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadifferentialPath::set(self : OptmetadifferentialPath, i : Int, v : Double) -> OptmetadifferentialPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialPath::sum(self : OptmetadifferentialPath) -> Double { @_common.sum(self.data) }

pub fn OptmetadifferentialPath::mean(self : OptmetadifferentialPath) -> Double { @_common.mean(self.data) }

pub fn OptmetadifferentialPath::scale(self : OptmetadifferentialPath, f : Double) -> OptmetadifferentialPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialPath::add(self : OptmetadifferentialPath, other : OptmetadifferentialPath) -> OptmetadifferentialPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadifferentialPath::copy(self : OptmetadifferentialPath) -> OptmetadifferentialPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialPath::fill(self : OptmetadifferentialPath, v : Double) -> OptmetadifferentialPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialPath::min(self : OptmetadifferentialPath) -> Double { @_common.min(self.data) }

pub fn OptmetadifferentialPath::max(self : OptmetadifferentialPath) -> Double { @_common.max(self.data) }

pub fn OptmetadifferentialPath::to_string(self : OptmetadifferentialPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_cluster_make(size : Int) -> OptmetadifferentialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadifferentialCluster::len(self : OptmetadifferentialCluster) -> Int { self.size }

pub fn OptmetadifferentialCluster::get(self : OptmetadifferentialCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadifferentialCluster::set(self : OptmetadifferentialCluster, i : Int, v : Double) -> OptmetadifferentialCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialCluster::sum(self : OptmetadifferentialCluster) -> Double { @_common.sum(self.data) }

pub fn OptmetadifferentialCluster::mean(self : OptmetadifferentialCluster) -> Double { @_common.mean(self.data) }

pub fn OptmetadifferentialCluster::scale(self : OptmetadifferentialCluster, f : Double) -> OptmetadifferentialCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialCluster::add(self : OptmetadifferentialCluster, other : OptmetadifferentialCluster) -> OptmetadifferentialCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadifferentialCluster::copy(self : OptmetadifferentialCluster) -> OptmetadifferentialCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialCluster::fill(self : OptmetadifferentialCluster, v : Double) -> OptmetadifferentialCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialCluster::min(self : OptmetadifferentialCluster) -> Double { @_common.min(self.data) }

pub fn OptmetadifferentialCluster::max(self : OptmetadifferentialCluster) -> Double { @_common.max(self.data) }

pub fn OptmetadifferentialCluster::to_string(self : OptmetadifferentialCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_model_make(size : Int) -> OptmetadifferentialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadifferentialModel::len(self : OptmetadifferentialModel) -> Int { self.size }

pub fn OptmetadifferentialModel::get(self : OptmetadifferentialModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadifferentialModel::set(self : OptmetadifferentialModel, i : Int, v : Double) -> OptmetadifferentialModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialModel::sum(self : OptmetadifferentialModel) -> Double { @_common.sum(self.data) }

pub fn OptmetadifferentialModel::mean(self : OptmetadifferentialModel) -> Double { @_common.mean(self.data) }

pub fn OptmetadifferentialModel::scale(self : OptmetadifferentialModel, f : Double) -> OptmetadifferentialModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialModel::add(self : OptmetadifferentialModel, other : OptmetadifferentialModel) -> OptmetadifferentialModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadifferentialModel::copy(self : OptmetadifferentialModel) -> OptmetadifferentialModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialModel::fill(self : OptmetadifferentialModel, v : Double) -> OptmetadifferentialModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialModel::min(self : OptmetadifferentialModel) -> Double { @_common.min(self.data) }

pub fn OptmetadifferentialModel::max(self : OptmetadifferentialModel) -> Double { @_common.max(self.data) }

pub fn OptmetadifferentialModel::to_string(self : OptmetadifferentialModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_layer_make(size : Int) -> OptmetadifferentialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadifferentialLayer::len(self : OptmetadifferentialLayer) -> Int { self.size }

pub fn OptmetadifferentialLayer::get(self : OptmetadifferentialLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadifferentialLayer::set(self : OptmetadifferentialLayer, i : Int, v : Double) -> OptmetadifferentialLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialLayer::sum(self : OptmetadifferentialLayer) -> Double { @_common.sum(self.data) }

pub fn OptmetadifferentialLayer::mean(self : OptmetadifferentialLayer) -> Double { @_common.mean(self.data) }

pub fn OptmetadifferentialLayer::scale(self : OptmetadifferentialLayer, f : Double) -> OptmetadifferentialLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialLayer::add(self : OptmetadifferentialLayer, other : OptmetadifferentialLayer) -> OptmetadifferentialLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadifferentialLayer::copy(self : OptmetadifferentialLayer) -> OptmetadifferentialLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialLayer::fill(self : OptmetadifferentialLayer, v : Double) -> OptmetadifferentialLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialLayer::min(self : OptmetadifferentialLayer) -> Double { @_common.min(self.data) }

pub fn OptmetadifferentialLayer::max(self : OptmetadifferentialLayer) -> Double { @_common.max(self.data) }

pub fn OptmetadifferentialLayer::to_string(self : OptmetadifferentialLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_buffer_make(size : Int) -> OptmetadifferentialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadifferentialBuffer::len(self : OptmetadifferentialBuffer) -> Int { self.size }

pub fn OptmetadifferentialBuffer::get(self : OptmetadifferentialBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadifferentialBuffer::set(self : OptmetadifferentialBuffer, i : Int, v : Double) -> OptmetadifferentialBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialBuffer::sum(self : OptmetadifferentialBuffer) -> Double { @_common.sum(self.data) }

pub fn OptmetadifferentialBuffer::mean(self : OptmetadifferentialBuffer) -> Double { @_common.mean(self.data) }

pub fn OptmetadifferentialBuffer::scale(self : OptmetadifferentialBuffer, f : Double) -> OptmetadifferentialBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialBuffer::add(self : OptmetadifferentialBuffer, other : OptmetadifferentialBuffer) -> OptmetadifferentialBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadifferentialBuffer::copy(self : OptmetadifferentialBuffer) -> OptmetadifferentialBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialBuffer::fill(self : OptmetadifferentialBuffer, v : Double) -> OptmetadifferentialBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialBuffer::min(self : OptmetadifferentialBuffer) -> Double { @_common.min(self.data) }

pub fn OptmetadifferentialBuffer::max(self : OptmetadifferentialBuffer) -> Double { @_common.max(self.data) }

pub fn OptmetadifferentialBuffer::to_string(self : OptmetadifferentialBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_cursor_make(size : Int) -> OptmetadifferentialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadifferentialCursor::len(self : OptmetadifferentialCursor) -> Int { self.size }

pub fn OptmetadifferentialCursor::get(self : OptmetadifferentialCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadifferentialCursor::set(self : OptmetadifferentialCursor, i : Int, v : Double) -> OptmetadifferentialCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialCursor::sum(self : OptmetadifferentialCursor) -> Double { @_common.sum(self.data) }

pub fn OptmetadifferentialCursor::mean(self : OptmetadifferentialCursor) -> Double { @_common.mean(self.data) }

pub fn OptmetadifferentialCursor::scale(self : OptmetadifferentialCursor, f : Double) -> OptmetadifferentialCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialCursor::add(self : OptmetadifferentialCursor, other : OptmetadifferentialCursor) -> OptmetadifferentialCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadifferentialCursor::copy(self : OptmetadifferentialCursor) -> OptmetadifferentialCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialCursor::fill(self : OptmetadifferentialCursor, v : Double) -> OptmetadifferentialCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialCursor::min(self : OptmetadifferentialCursor) -> Double { @_common.min(self.data) }

pub fn OptmetadifferentialCursor::max(self : OptmetadifferentialCursor) -> Double { @_common.max(self.data) }

pub fn OptmetadifferentialCursor::to_string(self : OptmetadifferentialCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_view_make(size : Int) -> OptmetadifferentialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadifferentialView::len(self : OptmetadifferentialView) -> Int { self.size }

pub fn OptmetadifferentialView::get(self : OptmetadifferentialView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadifferentialView::set(self : OptmetadifferentialView, i : Int, v : Double) -> OptmetadifferentialView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialView::sum(self : OptmetadifferentialView) -> Double { @_common.sum(self.data) }

pub fn OptmetadifferentialView::mean(self : OptmetadifferentialView) -> Double { @_common.mean(self.data) }

pub fn OptmetadifferentialView::scale(self : OptmetadifferentialView, f : Double) -> OptmetadifferentialView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialView::add(self : OptmetadifferentialView, other : OptmetadifferentialView) -> OptmetadifferentialView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadifferentialView::copy(self : OptmetadifferentialView) -> OptmetadifferentialView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialView::fill(self : OptmetadifferentialView, v : Double) -> OptmetadifferentialView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialView::min(self : OptmetadifferentialView) -> Double { @_common.min(self.data) }

pub fn OptmetadifferentialView::max(self : OptmetadifferentialView) -> Double { @_common.max(self.data) }

pub fn OptmetadifferentialView::to_string(self : OptmetadifferentialView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_range_make(size : Int) -> OptmetadifferentialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadifferentialRange::len(self : OptmetadifferentialRange) -> Int { self.size }

pub fn OptmetadifferentialRange::get(self : OptmetadifferentialRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadifferentialRange::set(self : OptmetadifferentialRange, i : Int, v : Double) -> OptmetadifferentialRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialRange::sum(self : OptmetadifferentialRange) -> Double { @_common.sum(self.data) }

pub fn OptmetadifferentialRange::mean(self : OptmetadifferentialRange) -> Double { @_common.mean(self.data) }

pub fn OptmetadifferentialRange::scale(self : OptmetadifferentialRange, f : Double) -> OptmetadifferentialRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialRange::add(self : OptmetadifferentialRange, other : OptmetadifferentialRange) -> OptmetadifferentialRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadifferentialRange::copy(self : OptmetadifferentialRange) -> OptmetadifferentialRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialRange::fill(self : OptmetadifferentialRange, v : Double) -> OptmetadifferentialRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialRange::min(self : OptmetadifferentialRange) -> Double { @_common.min(self.data) }

pub fn OptmetadifferentialRange::max(self : OptmetadifferentialRange) -> Double { @_common.max(self.data) }

pub fn OptmetadifferentialRange::to_string(self : OptmetadifferentialRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct OptmetadifferentialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_meta_differential_slice_make(size : Int) -> OptmetadifferentialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn OptmetadifferentialSlice::len(self : OptmetadifferentialSlice) -> Int { self.size }

pub fn OptmetadifferentialSlice::get(self : OptmetadifferentialSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn OptmetadifferentialSlice::set(self : OptmetadifferentialSlice, i : Int, v : Double) -> OptmetadifferentialSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialSlice::sum(self : OptmetadifferentialSlice) -> Double { @_common.sum(self.data) }

pub fn OptmetadifferentialSlice::mean(self : OptmetadifferentialSlice) -> Double { @_common.mean(self.data) }

pub fn OptmetadifferentialSlice::scale(self : OptmetadifferentialSlice, f : Double) -> OptmetadifferentialSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialSlice::add(self : OptmetadifferentialSlice, other : OptmetadifferentialSlice) -> OptmetadifferentialSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn OptmetadifferentialSlice::copy(self : OptmetadifferentialSlice) -> OptmetadifferentialSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialSlice::fill(self : OptmetadifferentialSlice, v : Double) -> OptmetadifferentialSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn OptmetadifferentialSlice::min(self : OptmetadifferentialSlice) -> Double { @_common.min(self.data) }

pub fn OptmetadifferentialSlice::max(self : OptmetadifferentialSlice) -> Double { @_common.max(self.data) }

pub fn OptmetadifferentialSlice::to_string(self : OptmetadifferentialSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

