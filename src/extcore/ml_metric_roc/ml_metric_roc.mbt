///===
/// extcore/ml_metric_roc

pub(all) struct MlmetricrocPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_metric_roc_make_point(x : Double, y : Double) -> MlmetricrocPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_metric_roc_make_point3(x : Double, y : Double, z : Double) -> MlmetricrocPoint {
  { x, y, z, label: 0 }
}

pub fn MlmetricrocPoint::x(self : MlmetricrocPoint) -> Double { self.x }

pub fn MlmetricrocPoint::y(self : MlmetricrocPoint) -> Double { self.y }

pub fn MlmetricrocPoint::z(self : MlmetricrocPoint) -> Double { self.z }

pub fn MlmetricrocPoint::label(self : MlmetricrocPoint) -> Int { self.label }

pub fn MlmetricrocPoint::dist(self : MlmetricrocPoint, other : MlmetricrocPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn MlmetricrocPoint::add(self : MlmetricrocPoint, other : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn MlmetricrocPoint::sub(self : MlmetricrocPoint, other : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn MlmetricrocPoint::scale(self : MlmetricrocPoint, s : Double) -> MlmetricrocPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn MlmetricrocPoint::dot(self : MlmetricrocPoint, other : MlmetricrocPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn MlmetricrocPoint::cross(self : MlmetricrocPoint, other : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn MlmetricrocPoint::norm(self : MlmetricrocPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn MlmetricrocPoint::normalize(self : MlmetricrocPoint) -> MlmetricrocPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricrocPoint::negate(self : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn MlmetricrocPoint::mid(self : MlmetricrocPoint, other : MlmetricrocPoint) -> MlmetricrocPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn MlmetricrocPoint::lerp(self : MlmetricrocPoint, other : MlmetricrocPoint, t : Double) -> MlmetricrocPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn MlmetricrocPoint::to_string(self : MlmetricrocPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct MlmetricrocSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_metric_roc_make_series(vals : Array[Double], name : String) -> MlmetricrocSeries {
  { vals, name, meta: 0 }
}

pub fn MlmetricrocSeries::len(self : MlmetricrocSeries) -> Int { self.vals.length() }

pub fn MlmetricrocSeries::sum(self : MlmetricrocSeries) -> Double { @_common.sum(self.vals) }

pub fn MlmetricrocSeries::mean(self : MlmetricrocSeries) -> Double { @_common.mean(self.vals) }

pub fn MlmetricrocSeries::min(self : MlmetricrocSeries) -> Double { @_common.min(self.vals) }

pub fn MlmetricrocSeries::max(self : MlmetricrocSeries) -> Double { @_common.max(self.vals) }

pub fn MlmetricrocSeries::range(self : MlmetricrocSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn MlmetricrocSeries::variance(self : MlmetricrocSeries) -> Double { @_common.variance(self.vals) }

pub fn MlmetricrocSeries::std(self : MlmetricrocSeries) -> Double { @_common.std(self.vals) }

pub fn MlmetricrocSeries::median(self : MlmetricrocSeries) -> Double { @_common.median(self.vals) }

pub fn MlmetricrocSeries::scale(self : MlmetricrocSeries, f : Double) -> MlmetricrocSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn MlmetricrocSeries::add(self : MlmetricrocSeries, other : MlmetricrocSeries) -> MlmetricrocSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn MlmetricrocSeries::sub(self : MlmetricrocSeries, other : MlmetricrocSeries) -> MlmetricrocSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn MlmetricrocSeries::normalize(self : MlmetricrocSeries) -> MlmetricrocSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn MlmetricrocSeries::cumsum(self : MlmetricrocSeries) -> MlmetricrocSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn MlmetricrocSeries::to_string(self : MlmetricrocSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlmetricrocMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_metric_roc_make_matrix(rows : Int, cols : Int, val : Double) -> MlmetricrocMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_metric_roc_matrix_identity(n : Int) -> MlmetricrocMatrix {
  let m = ml_metric_roc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn MlmetricrocMatrix::get(self : MlmetricrocMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn MlmetricrocMatrix::transpose(self : MlmetricrocMatrix) -> MlmetricrocMatrix {
  let result = ml_metric_roc_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn MlmetricrocMatrix::add(self : MlmetricrocMatrix, other : MlmetricrocMatrix) -> MlmetricrocMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ml_metric_roc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn MlmetricrocMatrix::scale(self : MlmetricrocMatrix, s : Double) -> MlmetricrocMatrix {
  let result = ml_metric_roc_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn MlmetricrocMatrix::multiply(self : MlmetricrocMatrix, other : MlmetricrocMatrix) -> MlmetricrocMatrix {
  if self.cols != other.rows { return ml_metric_roc_make_matrix(self.rows, other.cols, 0.0) }
  let result = ml_metric_roc_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn MlmetricrocMatrix::trace(self : MlmetricrocMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn MlmetricrocMatrix::det(self : MlmetricrocMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn MlmetricrocMatrix::norm(self : MlmetricrocMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn MlmetricrocMatrix::to_string(self : MlmetricrocMatrix) -> String {
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

pub(all) struct MlmetricrocVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_metric_roc_make_vector(comps : Array[Double]) -> MlmetricrocVector {
  { comps, dim: comps.length() }
}

pub fn ml_metric_roc_vector_zero(dim : Int) -> MlmetricrocVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn MlmetricrocVector::add(self : MlmetricrocVector, other : MlmetricrocVector) -> MlmetricrocVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricrocVector::sub(self : MlmetricrocVector, other : MlmetricrocVector) -> MlmetricrocVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn MlmetricrocVector::scale(self : MlmetricrocVector, s : Double) -> MlmetricrocVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn MlmetricrocVector::dot(self : MlmetricrocVector, other : MlmetricrocVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn MlmetricrocVector::norm(self : MlmetricrocVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn MlmetricrocVector::normalize(self : MlmetricrocVector) -> MlmetricrocVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn MlmetricrocVector::dist(self : MlmetricrocVector, other : MlmetricrocVector) -> Double {
  self.sub(other).norm()
}

pub fn MlmetricrocVector::to_string(self : MlmetricrocVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_metric_roc_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ml_metric_roc_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ml_metric_roc_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ml_metric_roc_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ml_metric_roc_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ml_metric_roc_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ml_metric_roc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ml_metric_roc_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ml_metric_roc_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ml_metric_roc_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ml_metric_roc_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ml_metric_roc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ml_metric_roc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ml_metric_roc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ml_metric_roc_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ml_metric_roc_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ml_metric_roc_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ml_metric_roc_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ml_metric_roc_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ml_metric_roc_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ml_metric_roc_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ml_metric_roc_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ml_metric_roc_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ml_metric_roc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ml_metric_roc_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ml_metric_roc_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ml_metric_roc_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ml_metric_roc_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ml_metric_roc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct MlmetricrocFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_frame_make(size : Int) -> MlmetricrocFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrocFrame::len(self : MlmetricrocFrame) -> Int { self.size }

pub fn MlmetricrocFrame::get(self : MlmetricrocFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrocFrame::set(self : MlmetricrocFrame, i : Int, v : Double) -> MlmetricrocFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrocFrame::sum(self : MlmetricrocFrame) -> Double { @_common.sum(self.data) }

pub fn MlmetricrocFrame::mean(self : MlmetricrocFrame) -> Double { @_common.mean(self.data) }

pub fn MlmetricrocFrame::scale(self : MlmetricrocFrame, f : Double) -> MlmetricrocFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrocFrame::add(self : MlmetricrocFrame, other : MlmetricrocFrame) -> MlmetricrocFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrocFrame::copy(self : MlmetricrocFrame) -> MlmetricrocFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrocFrame::fill(self : MlmetricrocFrame, v : Double) -> MlmetricrocFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrocFrame::min(self : MlmetricrocFrame) -> Double { @_common.min(self.data) }

pub fn MlmetricrocFrame::max(self : MlmetricrocFrame) -> Double { @_common.max(self.data) }

pub fn MlmetricrocFrame::to_string(self : MlmetricrocFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrocTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_table_make(size : Int) -> MlmetricrocTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrocTable::len(self : MlmetricrocTable) -> Int { self.size }

pub fn MlmetricrocTable::get(self : MlmetricrocTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrocTable::set(self : MlmetricrocTable, i : Int, v : Double) -> MlmetricrocTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrocTable::sum(self : MlmetricrocTable) -> Double { @_common.sum(self.data) }

pub fn MlmetricrocTable::mean(self : MlmetricrocTable) -> Double { @_common.mean(self.data) }

pub fn MlmetricrocTable::scale(self : MlmetricrocTable, f : Double) -> MlmetricrocTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrocTable::add(self : MlmetricrocTable, other : MlmetricrocTable) -> MlmetricrocTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrocTable::copy(self : MlmetricrocTable) -> MlmetricrocTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrocTable::fill(self : MlmetricrocTable, v : Double) -> MlmetricrocTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrocTable::min(self : MlmetricrocTable) -> Double { @_common.min(self.data) }

pub fn MlmetricrocTable::max(self : MlmetricrocTable) -> Double { @_common.max(self.data) }

pub fn MlmetricrocTable::to_string(self : MlmetricrocTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrocGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_graphn_make(size : Int) -> MlmetricrocGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrocGraphN::len(self : MlmetricrocGraphN) -> Int { self.size }

pub fn MlmetricrocGraphN::get(self : MlmetricrocGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrocGraphN::set(self : MlmetricrocGraphN, i : Int, v : Double) -> MlmetricrocGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrocGraphN::sum(self : MlmetricrocGraphN) -> Double { @_common.sum(self.data) }

pub fn MlmetricrocGraphN::mean(self : MlmetricrocGraphN) -> Double { @_common.mean(self.data) }

pub fn MlmetricrocGraphN::scale(self : MlmetricrocGraphN, f : Double) -> MlmetricrocGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrocGraphN::add(self : MlmetricrocGraphN, other : MlmetricrocGraphN) -> MlmetricrocGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrocGraphN::copy(self : MlmetricrocGraphN) -> MlmetricrocGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrocGraphN::fill(self : MlmetricrocGraphN, v : Double) -> MlmetricrocGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrocGraphN::min(self : MlmetricrocGraphN) -> Double { @_common.min(self.data) }

pub fn MlmetricrocGraphN::max(self : MlmetricrocGraphN) -> Double { @_common.max(self.data) }

pub fn MlmetricrocGraphN::to_string(self : MlmetricrocGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrocNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_node_make(size : Int) -> MlmetricrocNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrocNode::len(self : MlmetricrocNode) -> Int { self.size }

pub fn MlmetricrocNode::get(self : MlmetricrocNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrocNode::set(self : MlmetricrocNode, i : Int, v : Double) -> MlmetricrocNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrocNode::sum(self : MlmetricrocNode) -> Double { @_common.sum(self.data) }

pub fn MlmetricrocNode::mean(self : MlmetricrocNode) -> Double { @_common.mean(self.data) }

pub fn MlmetricrocNode::scale(self : MlmetricrocNode, f : Double) -> MlmetricrocNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrocNode::add(self : MlmetricrocNode, other : MlmetricrocNode) -> MlmetricrocNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrocNode::copy(self : MlmetricrocNode) -> MlmetricrocNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrocNode::fill(self : MlmetricrocNode, v : Double) -> MlmetricrocNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrocNode::min(self : MlmetricrocNode) -> Double { @_common.min(self.data) }

pub fn MlmetricrocNode::max(self : MlmetricrocNode) -> Double { @_common.max(self.data) }

pub fn MlmetricrocNode::to_string(self : MlmetricrocNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrocEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_edge_make(size : Int) -> MlmetricrocEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrocEdge::len(self : MlmetricrocEdge) -> Int { self.size }

pub fn MlmetricrocEdge::get(self : MlmetricrocEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrocEdge::set(self : MlmetricrocEdge, i : Int, v : Double) -> MlmetricrocEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrocEdge::sum(self : MlmetricrocEdge) -> Double { @_common.sum(self.data) }

pub fn MlmetricrocEdge::mean(self : MlmetricrocEdge) -> Double { @_common.mean(self.data) }

pub fn MlmetricrocEdge::scale(self : MlmetricrocEdge, f : Double) -> MlmetricrocEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrocEdge::add(self : MlmetricrocEdge, other : MlmetricrocEdge) -> MlmetricrocEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrocEdge::copy(self : MlmetricrocEdge) -> MlmetricrocEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrocEdge::fill(self : MlmetricrocEdge, v : Double) -> MlmetricrocEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrocEdge::min(self : MlmetricrocEdge) -> Double { @_common.min(self.data) }

pub fn MlmetricrocEdge::max(self : MlmetricrocEdge) -> Double { @_common.max(self.data) }

pub fn MlmetricrocEdge::to_string(self : MlmetricrocEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrocPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_path_make(size : Int) -> MlmetricrocPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrocPath::len(self : MlmetricrocPath) -> Int { self.size }

pub fn MlmetricrocPath::get(self : MlmetricrocPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrocPath::set(self : MlmetricrocPath, i : Int, v : Double) -> MlmetricrocPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrocPath::sum(self : MlmetricrocPath) -> Double { @_common.sum(self.data) }

pub fn MlmetricrocPath::mean(self : MlmetricrocPath) -> Double { @_common.mean(self.data) }

pub fn MlmetricrocPath::scale(self : MlmetricrocPath, f : Double) -> MlmetricrocPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrocPath::add(self : MlmetricrocPath, other : MlmetricrocPath) -> MlmetricrocPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrocPath::copy(self : MlmetricrocPath) -> MlmetricrocPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrocPath::fill(self : MlmetricrocPath, v : Double) -> MlmetricrocPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrocPath::min(self : MlmetricrocPath) -> Double { @_common.min(self.data) }

pub fn MlmetricrocPath::max(self : MlmetricrocPath) -> Double { @_common.max(self.data) }

pub fn MlmetricrocPath::to_string(self : MlmetricrocPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrocCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_cluster_make(size : Int) -> MlmetricrocCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrocCluster::len(self : MlmetricrocCluster) -> Int { self.size }

pub fn MlmetricrocCluster::get(self : MlmetricrocCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrocCluster::set(self : MlmetricrocCluster, i : Int, v : Double) -> MlmetricrocCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrocCluster::sum(self : MlmetricrocCluster) -> Double { @_common.sum(self.data) }

pub fn MlmetricrocCluster::mean(self : MlmetricrocCluster) -> Double { @_common.mean(self.data) }

pub fn MlmetricrocCluster::scale(self : MlmetricrocCluster, f : Double) -> MlmetricrocCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrocCluster::add(self : MlmetricrocCluster, other : MlmetricrocCluster) -> MlmetricrocCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrocCluster::copy(self : MlmetricrocCluster) -> MlmetricrocCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrocCluster::fill(self : MlmetricrocCluster, v : Double) -> MlmetricrocCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrocCluster::min(self : MlmetricrocCluster) -> Double { @_common.min(self.data) }

pub fn MlmetricrocCluster::max(self : MlmetricrocCluster) -> Double { @_common.max(self.data) }

pub fn MlmetricrocCluster::to_string(self : MlmetricrocCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrocModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_model_make(size : Int) -> MlmetricrocModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrocModel::len(self : MlmetricrocModel) -> Int { self.size }

pub fn MlmetricrocModel::get(self : MlmetricrocModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrocModel::set(self : MlmetricrocModel, i : Int, v : Double) -> MlmetricrocModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrocModel::sum(self : MlmetricrocModel) -> Double { @_common.sum(self.data) }

pub fn MlmetricrocModel::mean(self : MlmetricrocModel) -> Double { @_common.mean(self.data) }

pub fn MlmetricrocModel::scale(self : MlmetricrocModel, f : Double) -> MlmetricrocModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrocModel::add(self : MlmetricrocModel, other : MlmetricrocModel) -> MlmetricrocModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrocModel::copy(self : MlmetricrocModel) -> MlmetricrocModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrocModel::fill(self : MlmetricrocModel, v : Double) -> MlmetricrocModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrocModel::min(self : MlmetricrocModel) -> Double { @_common.min(self.data) }

pub fn MlmetricrocModel::max(self : MlmetricrocModel) -> Double { @_common.max(self.data) }

pub fn MlmetricrocModel::to_string(self : MlmetricrocModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrocLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_layer_make(size : Int) -> MlmetricrocLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrocLayer::len(self : MlmetricrocLayer) -> Int { self.size }

pub fn MlmetricrocLayer::get(self : MlmetricrocLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrocLayer::set(self : MlmetricrocLayer, i : Int, v : Double) -> MlmetricrocLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrocLayer::sum(self : MlmetricrocLayer) -> Double { @_common.sum(self.data) }

pub fn MlmetricrocLayer::mean(self : MlmetricrocLayer) -> Double { @_common.mean(self.data) }

pub fn MlmetricrocLayer::scale(self : MlmetricrocLayer, f : Double) -> MlmetricrocLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrocLayer::add(self : MlmetricrocLayer, other : MlmetricrocLayer) -> MlmetricrocLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrocLayer::copy(self : MlmetricrocLayer) -> MlmetricrocLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrocLayer::fill(self : MlmetricrocLayer, v : Double) -> MlmetricrocLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrocLayer::min(self : MlmetricrocLayer) -> Double { @_common.min(self.data) }

pub fn MlmetricrocLayer::max(self : MlmetricrocLayer) -> Double { @_common.max(self.data) }

pub fn MlmetricrocLayer::to_string(self : MlmetricrocLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrocBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_buffer_make(size : Int) -> MlmetricrocBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrocBuffer::len(self : MlmetricrocBuffer) -> Int { self.size }

pub fn MlmetricrocBuffer::get(self : MlmetricrocBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrocBuffer::set(self : MlmetricrocBuffer, i : Int, v : Double) -> MlmetricrocBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrocBuffer::sum(self : MlmetricrocBuffer) -> Double { @_common.sum(self.data) }

pub fn MlmetricrocBuffer::mean(self : MlmetricrocBuffer) -> Double { @_common.mean(self.data) }

pub fn MlmetricrocBuffer::scale(self : MlmetricrocBuffer, f : Double) -> MlmetricrocBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrocBuffer::add(self : MlmetricrocBuffer, other : MlmetricrocBuffer) -> MlmetricrocBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrocBuffer::copy(self : MlmetricrocBuffer) -> MlmetricrocBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrocBuffer::fill(self : MlmetricrocBuffer, v : Double) -> MlmetricrocBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrocBuffer::min(self : MlmetricrocBuffer) -> Double { @_common.min(self.data) }

pub fn MlmetricrocBuffer::max(self : MlmetricrocBuffer) -> Double { @_common.max(self.data) }

pub fn MlmetricrocBuffer::to_string(self : MlmetricrocBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrocCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_cursor_make(size : Int) -> MlmetricrocCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrocCursor::len(self : MlmetricrocCursor) -> Int { self.size }

pub fn MlmetricrocCursor::get(self : MlmetricrocCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrocCursor::set(self : MlmetricrocCursor, i : Int, v : Double) -> MlmetricrocCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrocCursor::sum(self : MlmetricrocCursor) -> Double { @_common.sum(self.data) }

pub fn MlmetricrocCursor::mean(self : MlmetricrocCursor) -> Double { @_common.mean(self.data) }

pub fn MlmetricrocCursor::scale(self : MlmetricrocCursor, f : Double) -> MlmetricrocCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrocCursor::add(self : MlmetricrocCursor, other : MlmetricrocCursor) -> MlmetricrocCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrocCursor::copy(self : MlmetricrocCursor) -> MlmetricrocCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrocCursor::fill(self : MlmetricrocCursor, v : Double) -> MlmetricrocCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrocCursor::min(self : MlmetricrocCursor) -> Double { @_common.min(self.data) }

pub fn MlmetricrocCursor::max(self : MlmetricrocCursor) -> Double { @_common.max(self.data) }

pub fn MlmetricrocCursor::to_string(self : MlmetricrocCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrocView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_view_make(size : Int) -> MlmetricrocView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrocView::len(self : MlmetricrocView) -> Int { self.size }

pub fn MlmetricrocView::get(self : MlmetricrocView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrocView::set(self : MlmetricrocView, i : Int, v : Double) -> MlmetricrocView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrocView::sum(self : MlmetricrocView) -> Double { @_common.sum(self.data) }

pub fn MlmetricrocView::mean(self : MlmetricrocView) -> Double { @_common.mean(self.data) }

pub fn MlmetricrocView::scale(self : MlmetricrocView, f : Double) -> MlmetricrocView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrocView::add(self : MlmetricrocView, other : MlmetricrocView) -> MlmetricrocView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrocView::copy(self : MlmetricrocView) -> MlmetricrocView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrocView::fill(self : MlmetricrocView, v : Double) -> MlmetricrocView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrocView::min(self : MlmetricrocView) -> Double { @_common.min(self.data) }

pub fn MlmetricrocView::max(self : MlmetricrocView) -> Double { @_common.max(self.data) }

pub fn MlmetricrocView::to_string(self : MlmetricrocView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrocRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_range_make(size : Int) -> MlmetricrocRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrocRange::len(self : MlmetricrocRange) -> Int { self.size }

pub fn MlmetricrocRange::get(self : MlmetricrocRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrocRange::set(self : MlmetricrocRange, i : Int, v : Double) -> MlmetricrocRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrocRange::sum(self : MlmetricrocRange) -> Double { @_common.sum(self.data) }

pub fn MlmetricrocRange::mean(self : MlmetricrocRange) -> Double { @_common.mean(self.data) }

pub fn MlmetricrocRange::scale(self : MlmetricrocRange, f : Double) -> MlmetricrocRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrocRange::add(self : MlmetricrocRange, other : MlmetricrocRange) -> MlmetricrocRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrocRange::copy(self : MlmetricrocRange) -> MlmetricrocRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrocRange::fill(self : MlmetricrocRange, v : Double) -> MlmetricrocRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrocRange::min(self : MlmetricrocRange) -> Double { @_common.min(self.data) }

pub fn MlmetricrocRange::max(self : MlmetricrocRange) -> Double { @_common.max(self.data) }

pub fn MlmetricrocRange::to_string(self : MlmetricrocRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct MlmetricrocSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_metric_roc_slice_make(size : Int) -> MlmetricrocSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn MlmetricrocSlice::len(self : MlmetricrocSlice) -> Int { self.size }

pub fn MlmetricrocSlice::get(self : MlmetricrocSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn MlmetricrocSlice::set(self : MlmetricrocSlice, i : Int, v : Double) -> MlmetricrocSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn MlmetricrocSlice::sum(self : MlmetricrocSlice) -> Double { @_common.sum(self.data) }

pub fn MlmetricrocSlice::mean(self : MlmetricrocSlice) -> Double { @_common.mean(self.data) }

pub fn MlmetricrocSlice::scale(self : MlmetricrocSlice, f : Double) -> MlmetricrocSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn MlmetricrocSlice::add(self : MlmetricrocSlice, other : MlmetricrocSlice) -> MlmetricrocSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn MlmetricrocSlice::copy(self : MlmetricrocSlice) -> MlmetricrocSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn MlmetricrocSlice::fill(self : MlmetricrocSlice, v : Double) -> MlmetricrocSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn MlmetricrocSlice::min(self : MlmetricrocSlice) -> Double { @_common.min(self.data) }

pub fn MlmetricrocSlice::max(self : MlmetricrocSlice) -> Double { @_common.max(self.data) }

pub fn MlmetricrocSlice::to_string(self : MlmetricrocSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

