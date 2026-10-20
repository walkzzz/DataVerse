///===
/// extcore/ds_heap_lazy

pub(all) struct DsheaplazyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_lazy_make_point(x : Double, y : Double) -> DsheaplazyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_lazy_make_point3(x : Double, y : Double, z : Double) -> DsheaplazyPoint {
  { x, y, z, label: 0 }
}

pub fn DsheaplazyPoint::x(self : DsheaplazyPoint) -> Double { self.x }

pub fn DsheaplazyPoint::y(self : DsheaplazyPoint) -> Double { self.y }

pub fn DsheaplazyPoint::z(self : DsheaplazyPoint) -> Double { self.z }

pub fn DsheaplazyPoint::label(self : DsheaplazyPoint) -> Int { self.label }

pub fn DsheaplazyPoint::dist(self : DsheaplazyPoint, other : DsheaplazyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheaplazyPoint::add(self : DsheaplazyPoint, other : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheaplazyPoint::sub(self : DsheaplazyPoint, other : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheaplazyPoint::scale(self : DsheaplazyPoint, s : Double) -> DsheaplazyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheaplazyPoint::dot(self : DsheaplazyPoint, other : DsheaplazyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheaplazyPoint::cross(self : DsheaplazyPoint, other : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheaplazyPoint::norm(self : DsheaplazyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheaplazyPoint::normalize(self : DsheaplazyPoint) -> DsheaplazyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheaplazyPoint::negate(self : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheaplazyPoint::mid(self : DsheaplazyPoint, other : DsheaplazyPoint) -> DsheaplazyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheaplazyPoint::lerp(self : DsheaplazyPoint, other : DsheaplazyPoint, t : Double) -> DsheaplazyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheaplazyPoint::to_string(self : DsheaplazyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheaplazySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_lazy_make_series(vals : Array[Double], name : String) -> DsheaplazySeries {
  { vals, name, meta: 0 }
}

pub fn DsheaplazySeries::len(self : DsheaplazySeries) -> Int { self.vals.length() }

pub fn DsheaplazySeries::sum(self : DsheaplazySeries) -> Double { @_common.sum(self.vals) }

pub fn DsheaplazySeries::mean(self : DsheaplazySeries) -> Double { @_common.mean(self.vals) }

pub fn DsheaplazySeries::min(self : DsheaplazySeries) -> Double { @_common.min(self.vals) }

pub fn DsheaplazySeries::max(self : DsheaplazySeries) -> Double { @_common.max(self.vals) }

pub fn DsheaplazySeries::range(self : DsheaplazySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheaplazySeries::variance(self : DsheaplazySeries) -> Double { @_common.variance(self.vals) }

pub fn DsheaplazySeries::std(self : DsheaplazySeries) -> Double { @_common.std(self.vals) }

pub fn DsheaplazySeries::median(self : DsheaplazySeries) -> Double { @_common.median(self.vals) }

pub fn DsheaplazySeries::scale(self : DsheaplazySeries, f : Double) -> DsheaplazySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheaplazySeries::add(self : DsheaplazySeries, other : DsheaplazySeries) -> DsheaplazySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheaplazySeries::sub(self : DsheaplazySeries, other : DsheaplazySeries) -> DsheaplazySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheaplazySeries::normalize(self : DsheaplazySeries) -> DsheaplazySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheaplazySeries::cumsum(self : DsheaplazySeries) -> DsheaplazySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheaplazySeries::to_string(self : DsheaplazySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheaplazyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_lazy_make_matrix(rows : Int, cols : Int, val : Double) -> DsheaplazyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_lazy_matrix_identity(n : Int) -> DsheaplazyMatrix {
  let m = ds_heap_lazy_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheaplazyMatrix::get(self : DsheaplazyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheaplazyMatrix::transpose(self : DsheaplazyMatrix) -> DsheaplazyMatrix {
  let result = ds_heap_lazy_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheaplazyMatrix::add(self : DsheaplazyMatrix, other : DsheaplazyMatrix) -> DsheaplazyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_lazy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheaplazyMatrix::scale(self : DsheaplazyMatrix, s : Double) -> DsheaplazyMatrix {
  let result = ds_heap_lazy_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheaplazyMatrix::multiply(self : DsheaplazyMatrix, other : DsheaplazyMatrix) -> DsheaplazyMatrix {
  if self.cols != other.rows { return ds_heap_lazy_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_lazy_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsheaplazyMatrix::trace(self : DsheaplazyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheaplazyMatrix::det(self : DsheaplazyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheaplazyMatrix::norm(self : DsheaplazyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheaplazyMatrix::to_string(self : DsheaplazyMatrix) -> String {
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

pub(all) struct DsheaplazyVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_lazy_make_vector(comps : Array[Double]) -> DsheaplazyVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_lazy_vector_zero(dim : Int) -> DsheaplazyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheaplazyVector::add(self : DsheaplazyVector, other : DsheaplazyVector) -> DsheaplazyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheaplazyVector::sub(self : DsheaplazyVector, other : DsheaplazyVector) -> DsheaplazyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheaplazyVector::scale(self : DsheaplazyVector, s : Double) -> DsheaplazyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheaplazyVector::dot(self : DsheaplazyVector, other : DsheaplazyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheaplazyVector::norm(self : DsheaplazyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheaplazyVector::normalize(self : DsheaplazyVector) -> DsheaplazyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheaplazyVector::dist(self : DsheaplazyVector, other : DsheaplazyVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheaplazyVector::to_string(self : DsheaplazyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_lazy_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_lazy_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_lazy_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_lazy_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_lazy_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_lazy_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_lazy_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_lazy_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_lazy_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_lazy_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_lazy_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_lazy_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_lazy_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_lazy_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_lazy_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_lazy_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_lazy_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_lazy_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_lazy_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_lazy_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_lazy_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_lazy_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_lazy_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_lazy_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_lazy_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_lazy_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_lazy_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_lazy_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_lazy_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheaplazyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_frame_make(size : Int) -> DsheaplazyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheaplazyFrame::len(self : DsheaplazyFrame) -> Int { self.size }

pub fn DsheaplazyFrame::get(self : DsheaplazyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheaplazyFrame::set(self : DsheaplazyFrame, i : Int, v : Double) -> DsheaplazyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheaplazyFrame::sum(self : DsheaplazyFrame) -> Double { @_common.sum(self.data) }

pub fn DsheaplazyFrame::mean(self : DsheaplazyFrame) -> Double { @_common.mean(self.data) }

pub fn DsheaplazyFrame::scale(self : DsheaplazyFrame, f : Double) -> DsheaplazyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheaplazyFrame::add(self : DsheaplazyFrame, other : DsheaplazyFrame) -> DsheaplazyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheaplazyFrame::copy(self : DsheaplazyFrame) -> DsheaplazyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheaplazyFrame::fill(self : DsheaplazyFrame, v : Double) -> DsheaplazyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheaplazyFrame::min(self : DsheaplazyFrame) -> Double { @_common.min(self.data) }

pub fn DsheaplazyFrame::max(self : DsheaplazyFrame) -> Double { @_common.max(self.data) }

pub fn DsheaplazyFrame::to_string(self : DsheaplazyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheaplazyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_table_make(size : Int) -> DsheaplazyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheaplazyTable::len(self : DsheaplazyTable) -> Int { self.size }

pub fn DsheaplazyTable::get(self : DsheaplazyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheaplazyTable::set(self : DsheaplazyTable, i : Int, v : Double) -> DsheaplazyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheaplazyTable::sum(self : DsheaplazyTable) -> Double { @_common.sum(self.data) }

pub fn DsheaplazyTable::mean(self : DsheaplazyTable) -> Double { @_common.mean(self.data) }

pub fn DsheaplazyTable::scale(self : DsheaplazyTable, f : Double) -> DsheaplazyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheaplazyTable::add(self : DsheaplazyTable, other : DsheaplazyTable) -> DsheaplazyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheaplazyTable::copy(self : DsheaplazyTable) -> DsheaplazyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheaplazyTable::fill(self : DsheaplazyTable, v : Double) -> DsheaplazyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheaplazyTable::min(self : DsheaplazyTable) -> Double { @_common.min(self.data) }

pub fn DsheaplazyTable::max(self : DsheaplazyTable) -> Double { @_common.max(self.data) }

pub fn DsheaplazyTable::to_string(self : DsheaplazyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheaplazyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_graphn_make(size : Int) -> DsheaplazyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheaplazyGraphN::len(self : DsheaplazyGraphN) -> Int { self.size }

pub fn DsheaplazyGraphN::get(self : DsheaplazyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheaplazyGraphN::set(self : DsheaplazyGraphN, i : Int, v : Double) -> DsheaplazyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheaplazyGraphN::sum(self : DsheaplazyGraphN) -> Double { @_common.sum(self.data) }

pub fn DsheaplazyGraphN::mean(self : DsheaplazyGraphN) -> Double { @_common.mean(self.data) }

pub fn DsheaplazyGraphN::scale(self : DsheaplazyGraphN, f : Double) -> DsheaplazyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheaplazyGraphN::add(self : DsheaplazyGraphN, other : DsheaplazyGraphN) -> DsheaplazyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheaplazyGraphN::copy(self : DsheaplazyGraphN) -> DsheaplazyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheaplazyGraphN::fill(self : DsheaplazyGraphN, v : Double) -> DsheaplazyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheaplazyGraphN::min(self : DsheaplazyGraphN) -> Double { @_common.min(self.data) }

pub fn DsheaplazyGraphN::max(self : DsheaplazyGraphN) -> Double { @_common.max(self.data) }

pub fn DsheaplazyGraphN::to_string(self : DsheaplazyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheaplazyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_node_make(size : Int) -> DsheaplazyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheaplazyNode::len(self : DsheaplazyNode) -> Int { self.size }

pub fn DsheaplazyNode::get(self : DsheaplazyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheaplazyNode::set(self : DsheaplazyNode, i : Int, v : Double) -> DsheaplazyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheaplazyNode::sum(self : DsheaplazyNode) -> Double { @_common.sum(self.data) }

pub fn DsheaplazyNode::mean(self : DsheaplazyNode) -> Double { @_common.mean(self.data) }

pub fn DsheaplazyNode::scale(self : DsheaplazyNode, f : Double) -> DsheaplazyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheaplazyNode::add(self : DsheaplazyNode, other : DsheaplazyNode) -> DsheaplazyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheaplazyNode::copy(self : DsheaplazyNode) -> DsheaplazyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheaplazyNode::fill(self : DsheaplazyNode, v : Double) -> DsheaplazyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheaplazyNode::min(self : DsheaplazyNode) -> Double { @_common.min(self.data) }

pub fn DsheaplazyNode::max(self : DsheaplazyNode) -> Double { @_common.max(self.data) }

pub fn DsheaplazyNode::to_string(self : DsheaplazyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheaplazyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_edge_make(size : Int) -> DsheaplazyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheaplazyEdge::len(self : DsheaplazyEdge) -> Int { self.size }

pub fn DsheaplazyEdge::get(self : DsheaplazyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheaplazyEdge::set(self : DsheaplazyEdge, i : Int, v : Double) -> DsheaplazyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheaplazyEdge::sum(self : DsheaplazyEdge) -> Double { @_common.sum(self.data) }

pub fn DsheaplazyEdge::mean(self : DsheaplazyEdge) -> Double { @_common.mean(self.data) }

pub fn DsheaplazyEdge::scale(self : DsheaplazyEdge, f : Double) -> DsheaplazyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheaplazyEdge::add(self : DsheaplazyEdge, other : DsheaplazyEdge) -> DsheaplazyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheaplazyEdge::copy(self : DsheaplazyEdge) -> DsheaplazyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheaplazyEdge::fill(self : DsheaplazyEdge, v : Double) -> DsheaplazyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheaplazyEdge::min(self : DsheaplazyEdge) -> Double { @_common.min(self.data) }

pub fn DsheaplazyEdge::max(self : DsheaplazyEdge) -> Double { @_common.max(self.data) }

pub fn DsheaplazyEdge::to_string(self : DsheaplazyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheaplazyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_path_make(size : Int) -> DsheaplazyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheaplazyPath::len(self : DsheaplazyPath) -> Int { self.size }

pub fn DsheaplazyPath::get(self : DsheaplazyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheaplazyPath::set(self : DsheaplazyPath, i : Int, v : Double) -> DsheaplazyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheaplazyPath::sum(self : DsheaplazyPath) -> Double { @_common.sum(self.data) }

pub fn DsheaplazyPath::mean(self : DsheaplazyPath) -> Double { @_common.mean(self.data) }

pub fn DsheaplazyPath::scale(self : DsheaplazyPath, f : Double) -> DsheaplazyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheaplazyPath::add(self : DsheaplazyPath, other : DsheaplazyPath) -> DsheaplazyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheaplazyPath::copy(self : DsheaplazyPath) -> DsheaplazyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheaplazyPath::fill(self : DsheaplazyPath, v : Double) -> DsheaplazyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheaplazyPath::min(self : DsheaplazyPath) -> Double { @_common.min(self.data) }

pub fn DsheaplazyPath::max(self : DsheaplazyPath) -> Double { @_common.max(self.data) }

pub fn DsheaplazyPath::to_string(self : DsheaplazyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheaplazyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_cluster_make(size : Int) -> DsheaplazyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheaplazyCluster::len(self : DsheaplazyCluster) -> Int { self.size }

pub fn DsheaplazyCluster::get(self : DsheaplazyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheaplazyCluster::set(self : DsheaplazyCluster, i : Int, v : Double) -> DsheaplazyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheaplazyCluster::sum(self : DsheaplazyCluster) -> Double { @_common.sum(self.data) }

pub fn DsheaplazyCluster::mean(self : DsheaplazyCluster) -> Double { @_common.mean(self.data) }

pub fn DsheaplazyCluster::scale(self : DsheaplazyCluster, f : Double) -> DsheaplazyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheaplazyCluster::add(self : DsheaplazyCluster, other : DsheaplazyCluster) -> DsheaplazyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheaplazyCluster::copy(self : DsheaplazyCluster) -> DsheaplazyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheaplazyCluster::fill(self : DsheaplazyCluster, v : Double) -> DsheaplazyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheaplazyCluster::min(self : DsheaplazyCluster) -> Double { @_common.min(self.data) }

pub fn DsheaplazyCluster::max(self : DsheaplazyCluster) -> Double { @_common.max(self.data) }

pub fn DsheaplazyCluster::to_string(self : DsheaplazyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheaplazyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_model_make(size : Int) -> DsheaplazyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheaplazyModel::len(self : DsheaplazyModel) -> Int { self.size }

pub fn DsheaplazyModel::get(self : DsheaplazyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheaplazyModel::set(self : DsheaplazyModel, i : Int, v : Double) -> DsheaplazyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheaplazyModel::sum(self : DsheaplazyModel) -> Double { @_common.sum(self.data) }

pub fn DsheaplazyModel::mean(self : DsheaplazyModel) -> Double { @_common.mean(self.data) }

pub fn DsheaplazyModel::scale(self : DsheaplazyModel, f : Double) -> DsheaplazyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheaplazyModel::add(self : DsheaplazyModel, other : DsheaplazyModel) -> DsheaplazyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheaplazyModel::copy(self : DsheaplazyModel) -> DsheaplazyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheaplazyModel::fill(self : DsheaplazyModel, v : Double) -> DsheaplazyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheaplazyModel::min(self : DsheaplazyModel) -> Double { @_common.min(self.data) }

pub fn DsheaplazyModel::max(self : DsheaplazyModel) -> Double { @_common.max(self.data) }

pub fn DsheaplazyModel::to_string(self : DsheaplazyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheaplazyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_layer_make(size : Int) -> DsheaplazyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheaplazyLayer::len(self : DsheaplazyLayer) -> Int { self.size }

pub fn DsheaplazyLayer::get(self : DsheaplazyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheaplazyLayer::set(self : DsheaplazyLayer, i : Int, v : Double) -> DsheaplazyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheaplazyLayer::sum(self : DsheaplazyLayer) -> Double { @_common.sum(self.data) }

pub fn DsheaplazyLayer::mean(self : DsheaplazyLayer) -> Double { @_common.mean(self.data) }

pub fn DsheaplazyLayer::scale(self : DsheaplazyLayer, f : Double) -> DsheaplazyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheaplazyLayer::add(self : DsheaplazyLayer, other : DsheaplazyLayer) -> DsheaplazyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheaplazyLayer::copy(self : DsheaplazyLayer) -> DsheaplazyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheaplazyLayer::fill(self : DsheaplazyLayer, v : Double) -> DsheaplazyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheaplazyLayer::min(self : DsheaplazyLayer) -> Double { @_common.min(self.data) }

pub fn DsheaplazyLayer::max(self : DsheaplazyLayer) -> Double { @_common.max(self.data) }

pub fn DsheaplazyLayer::to_string(self : DsheaplazyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheaplazyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_buffer_make(size : Int) -> DsheaplazyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheaplazyBuffer::len(self : DsheaplazyBuffer) -> Int { self.size }

pub fn DsheaplazyBuffer::get(self : DsheaplazyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheaplazyBuffer::set(self : DsheaplazyBuffer, i : Int, v : Double) -> DsheaplazyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheaplazyBuffer::sum(self : DsheaplazyBuffer) -> Double { @_common.sum(self.data) }

pub fn DsheaplazyBuffer::mean(self : DsheaplazyBuffer) -> Double { @_common.mean(self.data) }

pub fn DsheaplazyBuffer::scale(self : DsheaplazyBuffer, f : Double) -> DsheaplazyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheaplazyBuffer::add(self : DsheaplazyBuffer, other : DsheaplazyBuffer) -> DsheaplazyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheaplazyBuffer::copy(self : DsheaplazyBuffer) -> DsheaplazyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheaplazyBuffer::fill(self : DsheaplazyBuffer, v : Double) -> DsheaplazyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheaplazyBuffer::min(self : DsheaplazyBuffer) -> Double { @_common.min(self.data) }

pub fn DsheaplazyBuffer::max(self : DsheaplazyBuffer) -> Double { @_common.max(self.data) }

pub fn DsheaplazyBuffer::to_string(self : DsheaplazyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheaplazyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_cursor_make(size : Int) -> DsheaplazyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheaplazyCursor::len(self : DsheaplazyCursor) -> Int { self.size }

pub fn DsheaplazyCursor::get(self : DsheaplazyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheaplazyCursor::set(self : DsheaplazyCursor, i : Int, v : Double) -> DsheaplazyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheaplazyCursor::sum(self : DsheaplazyCursor) -> Double { @_common.sum(self.data) }

pub fn DsheaplazyCursor::mean(self : DsheaplazyCursor) -> Double { @_common.mean(self.data) }

pub fn DsheaplazyCursor::scale(self : DsheaplazyCursor, f : Double) -> DsheaplazyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheaplazyCursor::add(self : DsheaplazyCursor, other : DsheaplazyCursor) -> DsheaplazyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheaplazyCursor::copy(self : DsheaplazyCursor) -> DsheaplazyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheaplazyCursor::fill(self : DsheaplazyCursor, v : Double) -> DsheaplazyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheaplazyCursor::min(self : DsheaplazyCursor) -> Double { @_common.min(self.data) }

pub fn DsheaplazyCursor::max(self : DsheaplazyCursor) -> Double { @_common.max(self.data) }

pub fn DsheaplazyCursor::to_string(self : DsheaplazyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheaplazyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_view_make(size : Int) -> DsheaplazyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheaplazyView::len(self : DsheaplazyView) -> Int { self.size }

pub fn DsheaplazyView::get(self : DsheaplazyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheaplazyView::set(self : DsheaplazyView, i : Int, v : Double) -> DsheaplazyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheaplazyView::sum(self : DsheaplazyView) -> Double { @_common.sum(self.data) }

pub fn DsheaplazyView::mean(self : DsheaplazyView) -> Double { @_common.mean(self.data) }

pub fn DsheaplazyView::scale(self : DsheaplazyView, f : Double) -> DsheaplazyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheaplazyView::add(self : DsheaplazyView, other : DsheaplazyView) -> DsheaplazyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheaplazyView::copy(self : DsheaplazyView) -> DsheaplazyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheaplazyView::fill(self : DsheaplazyView, v : Double) -> DsheaplazyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheaplazyView::min(self : DsheaplazyView) -> Double { @_common.min(self.data) }

pub fn DsheaplazyView::max(self : DsheaplazyView) -> Double { @_common.max(self.data) }

pub fn DsheaplazyView::to_string(self : DsheaplazyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheaplazyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_range_make(size : Int) -> DsheaplazyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheaplazyRange::len(self : DsheaplazyRange) -> Int { self.size }

pub fn DsheaplazyRange::get(self : DsheaplazyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheaplazyRange::set(self : DsheaplazyRange, i : Int, v : Double) -> DsheaplazyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheaplazyRange::sum(self : DsheaplazyRange) -> Double { @_common.sum(self.data) }

pub fn DsheaplazyRange::mean(self : DsheaplazyRange) -> Double { @_common.mean(self.data) }

pub fn DsheaplazyRange::scale(self : DsheaplazyRange, f : Double) -> DsheaplazyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheaplazyRange::add(self : DsheaplazyRange, other : DsheaplazyRange) -> DsheaplazyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheaplazyRange::copy(self : DsheaplazyRange) -> DsheaplazyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheaplazyRange::fill(self : DsheaplazyRange, v : Double) -> DsheaplazyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheaplazyRange::min(self : DsheaplazyRange) -> Double { @_common.min(self.data) }

pub fn DsheaplazyRange::max(self : DsheaplazyRange) -> Double { @_common.max(self.data) }

pub fn DsheaplazyRange::to_string(self : DsheaplazyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheaplazySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_lazy_slice_make(size : Int) -> DsheaplazySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheaplazySlice::len(self : DsheaplazySlice) -> Int { self.size }

pub fn DsheaplazySlice::get(self : DsheaplazySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheaplazySlice::set(self : DsheaplazySlice, i : Int, v : Double) -> DsheaplazySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheaplazySlice::sum(self : DsheaplazySlice) -> Double { @_common.sum(self.data) }

pub fn DsheaplazySlice::mean(self : DsheaplazySlice) -> Double { @_common.mean(self.data) }

pub fn DsheaplazySlice::scale(self : DsheaplazySlice, f : Double) -> DsheaplazySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheaplazySlice::add(self : DsheaplazySlice, other : DsheaplazySlice) -> DsheaplazySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheaplazySlice::copy(self : DsheaplazySlice) -> DsheaplazySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheaplazySlice::fill(self : DsheaplazySlice, v : Double) -> DsheaplazySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheaplazySlice::min(self : DsheaplazySlice) -> Double { @_common.min(self.data) }

pub fn DsheaplazySlice::max(self : DsheaplazySlice) -> Double { @_common.max(self.data) }

pub fn DsheaplazySlice::to_string(self : DsheaplazySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

