///===
/// extcore/ds_hash_linear

pub(all) struct DshashlinearPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_linear_make_point(x : Double, y : Double) -> DshashlinearPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_linear_make_point3(x : Double, y : Double, z : Double) -> DshashlinearPoint {
  { x, y, z, label: 0 }
}

pub fn DshashlinearPoint::x(self : DshashlinearPoint) -> Double { self.x }

pub fn DshashlinearPoint::y(self : DshashlinearPoint) -> Double { self.y }

pub fn DshashlinearPoint::z(self : DshashlinearPoint) -> Double { self.z }

pub fn DshashlinearPoint::label(self : DshashlinearPoint) -> Int { self.label }

pub fn DshashlinearPoint::dist(self : DshashlinearPoint, other : DshashlinearPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DshashlinearPoint::add(self : DshashlinearPoint, other : DshashlinearPoint) -> DshashlinearPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DshashlinearPoint::sub(self : DshashlinearPoint, other : DshashlinearPoint) -> DshashlinearPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DshashlinearPoint::scale(self : DshashlinearPoint, s : Double) -> DshashlinearPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DshashlinearPoint::dot(self : DshashlinearPoint, other : DshashlinearPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DshashlinearPoint::cross(self : DshashlinearPoint, other : DshashlinearPoint) -> DshashlinearPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DshashlinearPoint::norm(self : DshashlinearPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DshashlinearPoint::normalize(self : DshashlinearPoint) -> DshashlinearPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashlinearPoint::negate(self : DshashlinearPoint) -> DshashlinearPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DshashlinearPoint::mid(self : DshashlinearPoint, other : DshashlinearPoint) -> DshashlinearPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DshashlinearPoint::lerp(self : DshashlinearPoint, other : DshashlinearPoint, t : Double) -> DshashlinearPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DshashlinearPoint::to_string(self : DshashlinearPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DshashlinearSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_linear_make_series(vals : Array[Double], name : String) -> DshashlinearSeries {
  { vals, name, meta: 0 }
}

pub fn DshashlinearSeries::len(self : DshashlinearSeries) -> Int { self.vals.length() }

pub fn DshashlinearSeries::sum(self : DshashlinearSeries) -> Double { @_common.sum(self.vals) }

pub fn DshashlinearSeries::mean(self : DshashlinearSeries) -> Double { @_common.mean(self.vals) }

pub fn DshashlinearSeries::min(self : DshashlinearSeries) -> Double { @_common.min(self.vals) }

pub fn DshashlinearSeries::max(self : DshashlinearSeries) -> Double { @_common.max(self.vals) }

pub fn DshashlinearSeries::range(self : DshashlinearSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DshashlinearSeries::variance(self : DshashlinearSeries) -> Double { @_common.variance(self.vals) }

pub fn DshashlinearSeries::std(self : DshashlinearSeries) -> Double { @_common.std(self.vals) }

pub fn DshashlinearSeries::median(self : DshashlinearSeries) -> Double { @_common.median(self.vals) }

pub fn DshashlinearSeries::scale(self : DshashlinearSeries, f : Double) -> DshashlinearSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DshashlinearSeries::add(self : DshashlinearSeries, other : DshashlinearSeries) -> DshashlinearSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DshashlinearSeries::sub(self : DshashlinearSeries, other : DshashlinearSeries) -> DshashlinearSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DshashlinearSeries::normalize(self : DshashlinearSeries) -> DshashlinearSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DshashlinearSeries::cumsum(self : DshashlinearSeries) -> DshashlinearSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DshashlinearSeries::to_string(self : DshashlinearSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashlinearMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_linear_make_matrix(rows : Int, cols : Int, val : Double) -> DshashlinearMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_linear_matrix_identity(n : Int) -> DshashlinearMatrix {
  let m = ds_hash_linear_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DshashlinearMatrix::get(self : DshashlinearMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DshashlinearMatrix::transpose(self : DshashlinearMatrix) -> DshashlinearMatrix {
  let result = ds_hash_linear_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DshashlinearMatrix::add(self : DshashlinearMatrix, other : DshashlinearMatrix) -> DshashlinearMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_hash_linear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DshashlinearMatrix::scale(self : DshashlinearMatrix, s : Double) -> DshashlinearMatrix {
  let result = ds_hash_linear_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DshashlinearMatrix::multiply(self : DshashlinearMatrix, other : DshashlinearMatrix) -> DshashlinearMatrix {
  if self.cols != other.rows { return ds_hash_linear_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_hash_linear_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DshashlinearMatrix::trace(self : DshashlinearMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DshashlinearMatrix::det(self : DshashlinearMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DshashlinearMatrix::norm(self : DshashlinearMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DshashlinearMatrix::to_string(self : DshashlinearMatrix) -> String {
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

pub(all) struct DshashlinearVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_linear_make_vector(comps : Array[Double]) -> DshashlinearVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_linear_vector_zero(dim : Int) -> DshashlinearVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DshashlinearVector::add(self : DshashlinearVector, other : DshashlinearVector) -> DshashlinearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DshashlinearVector::sub(self : DshashlinearVector, other : DshashlinearVector) -> DshashlinearVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DshashlinearVector::scale(self : DshashlinearVector, s : Double) -> DshashlinearVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DshashlinearVector::dot(self : DshashlinearVector, other : DshashlinearVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DshashlinearVector::norm(self : DshashlinearVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DshashlinearVector::normalize(self : DshashlinearVector) -> DshashlinearVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DshashlinearVector::dist(self : DshashlinearVector, other : DshashlinearVector) -> Double {
  self.sub(other).norm()
}

pub fn DshashlinearVector::to_string(self : DshashlinearVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_linear_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_hash_linear_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_hash_linear_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_hash_linear_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_hash_linear_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_hash_linear_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_hash_linear_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_hash_linear_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_hash_linear_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_hash_linear_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_hash_linear_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_hash_linear_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_hash_linear_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_hash_linear_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_hash_linear_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_hash_linear_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_hash_linear_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_hash_linear_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_hash_linear_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_hash_linear_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_hash_linear_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_hash_linear_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_hash_linear_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_hash_linear_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_hash_linear_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_hash_linear_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_hash_linear_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_hash_linear_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_hash_linear_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DshashlinearFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_frame_make(size : Int) -> DshashlinearFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashlinearFrame::len(self : DshashlinearFrame) -> Int { self.size }

pub fn DshashlinearFrame::get(self : DshashlinearFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashlinearFrame::set(self : DshashlinearFrame, i : Int, v : Double) -> DshashlinearFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashlinearFrame::sum(self : DshashlinearFrame) -> Double { @_common.sum(self.data) }

pub fn DshashlinearFrame::mean(self : DshashlinearFrame) -> Double { @_common.mean(self.data) }

pub fn DshashlinearFrame::scale(self : DshashlinearFrame, f : Double) -> DshashlinearFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashlinearFrame::add(self : DshashlinearFrame, other : DshashlinearFrame) -> DshashlinearFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashlinearFrame::copy(self : DshashlinearFrame) -> DshashlinearFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashlinearFrame::fill(self : DshashlinearFrame, v : Double) -> DshashlinearFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashlinearFrame::min(self : DshashlinearFrame) -> Double { @_common.min(self.data) }

pub fn DshashlinearFrame::max(self : DshashlinearFrame) -> Double { @_common.max(self.data) }

pub fn DshashlinearFrame::to_string(self : DshashlinearFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashlinearTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_table_make(size : Int) -> DshashlinearTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashlinearTable::len(self : DshashlinearTable) -> Int { self.size }

pub fn DshashlinearTable::get(self : DshashlinearTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashlinearTable::set(self : DshashlinearTable, i : Int, v : Double) -> DshashlinearTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashlinearTable::sum(self : DshashlinearTable) -> Double { @_common.sum(self.data) }

pub fn DshashlinearTable::mean(self : DshashlinearTable) -> Double { @_common.mean(self.data) }

pub fn DshashlinearTable::scale(self : DshashlinearTable, f : Double) -> DshashlinearTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashlinearTable::add(self : DshashlinearTable, other : DshashlinearTable) -> DshashlinearTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashlinearTable::copy(self : DshashlinearTable) -> DshashlinearTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashlinearTable::fill(self : DshashlinearTable, v : Double) -> DshashlinearTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashlinearTable::min(self : DshashlinearTable) -> Double { @_common.min(self.data) }

pub fn DshashlinearTable::max(self : DshashlinearTable) -> Double { @_common.max(self.data) }

pub fn DshashlinearTable::to_string(self : DshashlinearTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashlinearGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_graphn_make(size : Int) -> DshashlinearGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashlinearGraphN::len(self : DshashlinearGraphN) -> Int { self.size }

pub fn DshashlinearGraphN::get(self : DshashlinearGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashlinearGraphN::set(self : DshashlinearGraphN, i : Int, v : Double) -> DshashlinearGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashlinearGraphN::sum(self : DshashlinearGraphN) -> Double { @_common.sum(self.data) }

pub fn DshashlinearGraphN::mean(self : DshashlinearGraphN) -> Double { @_common.mean(self.data) }

pub fn DshashlinearGraphN::scale(self : DshashlinearGraphN, f : Double) -> DshashlinearGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashlinearGraphN::add(self : DshashlinearGraphN, other : DshashlinearGraphN) -> DshashlinearGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashlinearGraphN::copy(self : DshashlinearGraphN) -> DshashlinearGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashlinearGraphN::fill(self : DshashlinearGraphN, v : Double) -> DshashlinearGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashlinearGraphN::min(self : DshashlinearGraphN) -> Double { @_common.min(self.data) }

pub fn DshashlinearGraphN::max(self : DshashlinearGraphN) -> Double { @_common.max(self.data) }

pub fn DshashlinearGraphN::to_string(self : DshashlinearGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashlinearNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_node_make(size : Int) -> DshashlinearNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashlinearNode::len(self : DshashlinearNode) -> Int { self.size }

pub fn DshashlinearNode::get(self : DshashlinearNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashlinearNode::set(self : DshashlinearNode, i : Int, v : Double) -> DshashlinearNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashlinearNode::sum(self : DshashlinearNode) -> Double { @_common.sum(self.data) }

pub fn DshashlinearNode::mean(self : DshashlinearNode) -> Double { @_common.mean(self.data) }

pub fn DshashlinearNode::scale(self : DshashlinearNode, f : Double) -> DshashlinearNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashlinearNode::add(self : DshashlinearNode, other : DshashlinearNode) -> DshashlinearNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashlinearNode::copy(self : DshashlinearNode) -> DshashlinearNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashlinearNode::fill(self : DshashlinearNode, v : Double) -> DshashlinearNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashlinearNode::min(self : DshashlinearNode) -> Double { @_common.min(self.data) }

pub fn DshashlinearNode::max(self : DshashlinearNode) -> Double { @_common.max(self.data) }

pub fn DshashlinearNode::to_string(self : DshashlinearNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashlinearEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_edge_make(size : Int) -> DshashlinearEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashlinearEdge::len(self : DshashlinearEdge) -> Int { self.size }

pub fn DshashlinearEdge::get(self : DshashlinearEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashlinearEdge::set(self : DshashlinearEdge, i : Int, v : Double) -> DshashlinearEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashlinearEdge::sum(self : DshashlinearEdge) -> Double { @_common.sum(self.data) }

pub fn DshashlinearEdge::mean(self : DshashlinearEdge) -> Double { @_common.mean(self.data) }

pub fn DshashlinearEdge::scale(self : DshashlinearEdge, f : Double) -> DshashlinearEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashlinearEdge::add(self : DshashlinearEdge, other : DshashlinearEdge) -> DshashlinearEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashlinearEdge::copy(self : DshashlinearEdge) -> DshashlinearEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashlinearEdge::fill(self : DshashlinearEdge, v : Double) -> DshashlinearEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashlinearEdge::min(self : DshashlinearEdge) -> Double { @_common.min(self.data) }

pub fn DshashlinearEdge::max(self : DshashlinearEdge) -> Double { @_common.max(self.data) }

pub fn DshashlinearEdge::to_string(self : DshashlinearEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashlinearPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_path_make(size : Int) -> DshashlinearPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashlinearPath::len(self : DshashlinearPath) -> Int { self.size }

pub fn DshashlinearPath::get(self : DshashlinearPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashlinearPath::set(self : DshashlinearPath, i : Int, v : Double) -> DshashlinearPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashlinearPath::sum(self : DshashlinearPath) -> Double { @_common.sum(self.data) }

pub fn DshashlinearPath::mean(self : DshashlinearPath) -> Double { @_common.mean(self.data) }

pub fn DshashlinearPath::scale(self : DshashlinearPath, f : Double) -> DshashlinearPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashlinearPath::add(self : DshashlinearPath, other : DshashlinearPath) -> DshashlinearPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashlinearPath::copy(self : DshashlinearPath) -> DshashlinearPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashlinearPath::fill(self : DshashlinearPath, v : Double) -> DshashlinearPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashlinearPath::min(self : DshashlinearPath) -> Double { @_common.min(self.data) }

pub fn DshashlinearPath::max(self : DshashlinearPath) -> Double { @_common.max(self.data) }

pub fn DshashlinearPath::to_string(self : DshashlinearPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashlinearCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_cluster_make(size : Int) -> DshashlinearCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashlinearCluster::len(self : DshashlinearCluster) -> Int { self.size }

pub fn DshashlinearCluster::get(self : DshashlinearCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashlinearCluster::set(self : DshashlinearCluster, i : Int, v : Double) -> DshashlinearCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashlinearCluster::sum(self : DshashlinearCluster) -> Double { @_common.sum(self.data) }

pub fn DshashlinearCluster::mean(self : DshashlinearCluster) -> Double { @_common.mean(self.data) }

pub fn DshashlinearCluster::scale(self : DshashlinearCluster, f : Double) -> DshashlinearCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashlinearCluster::add(self : DshashlinearCluster, other : DshashlinearCluster) -> DshashlinearCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashlinearCluster::copy(self : DshashlinearCluster) -> DshashlinearCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashlinearCluster::fill(self : DshashlinearCluster, v : Double) -> DshashlinearCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashlinearCluster::min(self : DshashlinearCluster) -> Double { @_common.min(self.data) }

pub fn DshashlinearCluster::max(self : DshashlinearCluster) -> Double { @_common.max(self.data) }

pub fn DshashlinearCluster::to_string(self : DshashlinearCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashlinearModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_model_make(size : Int) -> DshashlinearModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashlinearModel::len(self : DshashlinearModel) -> Int { self.size }

pub fn DshashlinearModel::get(self : DshashlinearModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashlinearModel::set(self : DshashlinearModel, i : Int, v : Double) -> DshashlinearModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashlinearModel::sum(self : DshashlinearModel) -> Double { @_common.sum(self.data) }

pub fn DshashlinearModel::mean(self : DshashlinearModel) -> Double { @_common.mean(self.data) }

pub fn DshashlinearModel::scale(self : DshashlinearModel, f : Double) -> DshashlinearModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashlinearModel::add(self : DshashlinearModel, other : DshashlinearModel) -> DshashlinearModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashlinearModel::copy(self : DshashlinearModel) -> DshashlinearModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashlinearModel::fill(self : DshashlinearModel, v : Double) -> DshashlinearModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashlinearModel::min(self : DshashlinearModel) -> Double { @_common.min(self.data) }

pub fn DshashlinearModel::max(self : DshashlinearModel) -> Double { @_common.max(self.data) }

pub fn DshashlinearModel::to_string(self : DshashlinearModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashlinearLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_layer_make(size : Int) -> DshashlinearLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashlinearLayer::len(self : DshashlinearLayer) -> Int { self.size }

pub fn DshashlinearLayer::get(self : DshashlinearLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashlinearLayer::set(self : DshashlinearLayer, i : Int, v : Double) -> DshashlinearLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashlinearLayer::sum(self : DshashlinearLayer) -> Double { @_common.sum(self.data) }

pub fn DshashlinearLayer::mean(self : DshashlinearLayer) -> Double { @_common.mean(self.data) }

pub fn DshashlinearLayer::scale(self : DshashlinearLayer, f : Double) -> DshashlinearLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashlinearLayer::add(self : DshashlinearLayer, other : DshashlinearLayer) -> DshashlinearLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashlinearLayer::copy(self : DshashlinearLayer) -> DshashlinearLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashlinearLayer::fill(self : DshashlinearLayer, v : Double) -> DshashlinearLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashlinearLayer::min(self : DshashlinearLayer) -> Double { @_common.min(self.data) }

pub fn DshashlinearLayer::max(self : DshashlinearLayer) -> Double { @_common.max(self.data) }

pub fn DshashlinearLayer::to_string(self : DshashlinearLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashlinearBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_buffer_make(size : Int) -> DshashlinearBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashlinearBuffer::len(self : DshashlinearBuffer) -> Int { self.size }

pub fn DshashlinearBuffer::get(self : DshashlinearBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashlinearBuffer::set(self : DshashlinearBuffer, i : Int, v : Double) -> DshashlinearBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashlinearBuffer::sum(self : DshashlinearBuffer) -> Double { @_common.sum(self.data) }

pub fn DshashlinearBuffer::mean(self : DshashlinearBuffer) -> Double { @_common.mean(self.data) }

pub fn DshashlinearBuffer::scale(self : DshashlinearBuffer, f : Double) -> DshashlinearBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashlinearBuffer::add(self : DshashlinearBuffer, other : DshashlinearBuffer) -> DshashlinearBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashlinearBuffer::copy(self : DshashlinearBuffer) -> DshashlinearBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashlinearBuffer::fill(self : DshashlinearBuffer, v : Double) -> DshashlinearBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashlinearBuffer::min(self : DshashlinearBuffer) -> Double { @_common.min(self.data) }

pub fn DshashlinearBuffer::max(self : DshashlinearBuffer) -> Double { @_common.max(self.data) }

pub fn DshashlinearBuffer::to_string(self : DshashlinearBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashlinearCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_cursor_make(size : Int) -> DshashlinearCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashlinearCursor::len(self : DshashlinearCursor) -> Int { self.size }

pub fn DshashlinearCursor::get(self : DshashlinearCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashlinearCursor::set(self : DshashlinearCursor, i : Int, v : Double) -> DshashlinearCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashlinearCursor::sum(self : DshashlinearCursor) -> Double { @_common.sum(self.data) }

pub fn DshashlinearCursor::mean(self : DshashlinearCursor) -> Double { @_common.mean(self.data) }

pub fn DshashlinearCursor::scale(self : DshashlinearCursor, f : Double) -> DshashlinearCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashlinearCursor::add(self : DshashlinearCursor, other : DshashlinearCursor) -> DshashlinearCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashlinearCursor::copy(self : DshashlinearCursor) -> DshashlinearCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashlinearCursor::fill(self : DshashlinearCursor, v : Double) -> DshashlinearCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashlinearCursor::min(self : DshashlinearCursor) -> Double { @_common.min(self.data) }

pub fn DshashlinearCursor::max(self : DshashlinearCursor) -> Double { @_common.max(self.data) }

pub fn DshashlinearCursor::to_string(self : DshashlinearCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashlinearView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_view_make(size : Int) -> DshashlinearView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashlinearView::len(self : DshashlinearView) -> Int { self.size }

pub fn DshashlinearView::get(self : DshashlinearView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashlinearView::set(self : DshashlinearView, i : Int, v : Double) -> DshashlinearView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashlinearView::sum(self : DshashlinearView) -> Double { @_common.sum(self.data) }

pub fn DshashlinearView::mean(self : DshashlinearView) -> Double { @_common.mean(self.data) }

pub fn DshashlinearView::scale(self : DshashlinearView, f : Double) -> DshashlinearView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashlinearView::add(self : DshashlinearView, other : DshashlinearView) -> DshashlinearView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashlinearView::copy(self : DshashlinearView) -> DshashlinearView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashlinearView::fill(self : DshashlinearView, v : Double) -> DshashlinearView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashlinearView::min(self : DshashlinearView) -> Double { @_common.min(self.data) }

pub fn DshashlinearView::max(self : DshashlinearView) -> Double { @_common.max(self.data) }

pub fn DshashlinearView::to_string(self : DshashlinearView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashlinearRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_range_make(size : Int) -> DshashlinearRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashlinearRange::len(self : DshashlinearRange) -> Int { self.size }

pub fn DshashlinearRange::get(self : DshashlinearRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashlinearRange::set(self : DshashlinearRange, i : Int, v : Double) -> DshashlinearRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashlinearRange::sum(self : DshashlinearRange) -> Double { @_common.sum(self.data) }

pub fn DshashlinearRange::mean(self : DshashlinearRange) -> Double { @_common.mean(self.data) }

pub fn DshashlinearRange::scale(self : DshashlinearRange, f : Double) -> DshashlinearRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashlinearRange::add(self : DshashlinearRange, other : DshashlinearRange) -> DshashlinearRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashlinearRange::copy(self : DshashlinearRange) -> DshashlinearRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashlinearRange::fill(self : DshashlinearRange, v : Double) -> DshashlinearRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashlinearRange::min(self : DshashlinearRange) -> Double { @_common.min(self.data) }

pub fn DshashlinearRange::max(self : DshashlinearRange) -> Double { @_common.max(self.data) }

pub fn DshashlinearRange::to_string(self : DshashlinearRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DshashlinearSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_linear_slice_make(size : Int) -> DshashlinearSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DshashlinearSlice::len(self : DshashlinearSlice) -> Int { self.size }

pub fn DshashlinearSlice::get(self : DshashlinearSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DshashlinearSlice::set(self : DshashlinearSlice, i : Int, v : Double) -> DshashlinearSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DshashlinearSlice::sum(self : DshashlinearSlice) -> Double { @_common.sum(self.data) }

pub fn DshashlinearSlice::mean(self : DshashlinearSlice) -> Double { @_common.mean(self.data) }

pub fn DshashlinearSlice::scale(self : DshashlinearSlice, f : Double) -> DshashlinearSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DshashlinearSlice::add(self : DshashlinearSlice, other : DshashlinearSlice) -> DshashlinearSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DshashlinearSlice::copy(self : DshashlinearSlice) -> DshashlinearSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DshashlinearSlice::fill(self : DshashlinearSlice, v : Double) -> DshashlinearSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DshashlinearSlice::min(self : DshashlinearSlice) -> Double { @_common.min(self.data) }

pub fn DshashlinearSlice::max(self : DshashlinearSlice) -> Double { @_common.max(self.data) }

pub fn DshashlinearSlice::to_string(self : DshashlinearSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

