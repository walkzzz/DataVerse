///===
/// extcore/ds_heap_skew

pub(all) struct DsheapskewPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_heap_skew_make_point(x : Double, y : Double) -> DsheapskewPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_heap_skew_make_point3(x : Double, y : Double, z : Double) -> DsheapskewPoint {
  { x, y, z, label: 0 }
}

pub fn DsheapskewPoint::x(self : DsheapskewPoint) -> Double { self.x }

pub fn DsheapskewPoint::y(self : DsheapskewPoint) -> Double { self.y }

pub fn DsheapskewPoint::z(self : DsheapskewPoint) -> Double { self.z }

pub fn DsheapskewPoint::label(self : DsheapskewPoint) -> Int { self.label }

pub fn DsheapskewPoint::dist(self : DsheapskewPoint, other : DsheapskewPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DsheapskewPoint::add(self : DsheapskewPoint, other : DsheapskewPoint) -> DsheapskewPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DsheapskewPoint::sub(self : DsheapskewPoint, other : DsheapskewPoint) -> DsheapskewPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DsheapskewPoint::scale(self : DsheapskewPoint, s : Double) -> DsheapskewPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DsheapskewPoint::dot(self : DsheapskewPoint, other : DsheapskewPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DsheapskewPoint::cross(self : DsheapskewPoint, other : DsheapskewPoint) -> DsheapskewPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DsheapskewPoint::norm(self : DsheapskewPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DsheapskewPoint::normalize(self : DsheapskewPoint) -> DsheapskewPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapskewPoint::negate(self : DsheapskewPoint) -> DsheapskewPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DsheapskewPoint::mid(self : DsheapskewPoint, other : DsheapskewPoint) -> DsheapskewPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DsheapskewPoint::lerp(self : DsheapskewPoint, other : DsheapskewPoint, t : Double) -> DsheapskewPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DsheapskewPoint::to_string(self : DsheapskewPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DsheapskewSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_heap_skew_make_series(vals : Array[Double], name : String) -> DsheapskewSeries {
  { vals, name, meta: 0 }
}

pub fn DsheapskewSeries::len(self : DsheapskewSeries) -> Int { self.vals.length() }

pub fn DsheapskewSeries::sum(self : DsheapskewSeries) -> Double { @_common.sum(self.vals) }

pub fn DsheapskewSeries::mean(self : DsheapskewSeries) -> Double { @_common.mean(self.vals) }

pub fn DsheapskewSeries::min(self : DsheapskewSeries) -> Double { @_common.min(self.vals) }

pub fn DsheapskewSeries::max(self : DsheapskewSeries) -> Double { @_common.max(self.vals) }

pub fn DsheapskewSeries::range(self : DsheapskewSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DsheapskewSeries::variance(self : DsheapskewSeries) -> Double { @_common.variance(self.vals) }

pub fn DsheapskewSeries::std(self : DsheapskewSeries) -> Double { @_common.std(self.vals) }

pub fn DsheapskewSeries::median(self : DsheapskewSeries) -> Double { @_common.median(self.vals) }

pub fn DsheapskewSeries::scale(self : DsheapskewSeries, f : Double) -> DsheapskewSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DsheapskewSeries::add(self : DsheapskewSeries, other : DsheapskewSeries) -> DsheapskewSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DsheapskewSeries::sub(self : DsheapskewSeries, other : DsheapskewSeries) -> DsheapskewSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DsheapskewSeries::normalize(self : DsheapskewSeries) -> DsheapskewSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DsheapskewSeries::cumsum(self : DsheapskewSeries) -> DsheapskewSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DsheapskewSeries::to_string(self : DsheapskewSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsheapskewMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_heap_skew_make_matrix(rows : Int, cols : Int, val : Double) -> DsheapskewMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_heap_skew_matrix_identity(n : Int) -> DsheapskewMatrix {
  let m = ds_heap_skew_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DsheapskewMatrix::get(self : DsheapskewMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DsheapskewMatrix::transpose(self : DsheapskewMatrix) -> DsheapskewMatrix {
  let result = ds_heap_skew_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DsheapskewMatrix::add(self : DsheapskewMatrix, other : DsheapskewMatrix) -> DsheapskewMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_heap_skew_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DsheapskewMatrix::scale(self : DsheapskewMatrix, s : Double) -> DsheapskewMatrix {
  let result = ds_heap_skew_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DsheapskewMatrix::multiply(self : DsheapskewMatrix, other : DsheapskewMatrix) -> DsheapskewMatrix {
  if self.cols != other.rows { return ds_heap_skew_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_heap_skew_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DsheapskewMatrix::trace(self : DsheapskewMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DsheapskewMatrix::det(self : DsheapskewMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DsheapskewMatrix::norm(self : DsheapskewMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DsheapskewMatrix::to_string(self : DsheapskewMatrix) -> String {
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

pub(all) struct DsheapskewVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_heap_skew_make_vector(comps : Array[Double]) -> DsheapskewVector {
  { comps, dim: comps.length() }
}

pub fn ds_heap_skew_vector_zero(dim : Int) -> DsheapskewVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DsheapskewVector::add(self : DsheapskewVector, other : DsheapskewVector) -> DsheapskewVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapskewVector::sub(self : DsheapskewVector, other : DsheapskewVector) -> DsheapskewVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DsheapskewVector::scale(self : DsheapskewVector, s : Double) -> DsheapskewVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DsheapskewVector::dot(self : DsheapskewVector, other : DsheapskewVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DsheapskewVector::norm(self : DsheapskewVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DsheapskewVector::normalize(self : DsheapskewVector) -> DsheapskewVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DsheapskewVector::dist(self : DsheapskewVector, other : DsheapskewVector) -> Double {
  self.sub(other).norm()
}

pub fn DsheapskewVector::to_string(self : DsheapskewVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_heap_skew_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_heap_skew_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_heap_skew_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_heap_skew_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_heap_skew_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_heap_skew_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_heap_skew_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_heap_skew_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_heap_skew_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_heap_skew_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_heap_skew_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_heap_skew_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_heap_skew_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_heap_skew_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_heap_skew_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_heap_skew_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_heap_skew_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_heap_skew_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_heap_skew_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_heap_skew_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_heap_skew_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_heap_skew_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_heap_skew_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_heap_skew_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_heap_skew_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_heap_skew_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_heap_skew_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_heap_skew_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_heap_skew_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DsheapskewFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_frame_make(size : Int) -> DsheapskewFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapskewFrame::len(self : DsheapskewFrame) -> Int { self.size }

pub fn DsheapskewFrame::get(self : DsheapskewFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapskewFrame::set(self : DsheapskewFrame, i : Int, v : Double) -> DsheapskewFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapskewFrame::sum(self : DsheapskewFrame) -> Double { @_common.sum(self.data) }

pub fn DsheapskewFrame::mean(self : DsheapskewFrame) -> Double { @_common.mean(self.data) }

pub fn DsheapskewFrame::scale(self : DsheapskewFrame, f : Double) -> DsheapskewFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapskewFrame::add(self : DsheapskewFrame, other : DsheapskewFrame) -> DsheapskewFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapskewFrame::copy(self : DsheapskewFrame) -> DsheapskewFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapskewFrame::fill(self : DsheapskewFrame, v : Double) -> DsheapskewFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapskewFrame::min(self : DsheapskewFrame) -> Double { @_common.min(self.data) }

pub fn DsheapskewFrame::max(self : DsheapskewFrame) -> Double { @_common.max(self.data) }

pub fn DsheapskewFrame::to_string(self : DsheapskewFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapskewTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_table_make(size : Int) -> DsheapskewTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapskewTable::len(self : DsheapskewTable) -> Int { self.size }

pub fn DsheapskewTable::get(self : DsheapskewTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapskewTable::set(self : DsheapskewTable, i : Int, v : Double) -> DsheapskewTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapskewTable::sum(self : DsheapskewTable) -> Double { @_common.sum(self.data) }

pub fn DsheapskewTable::mean(self : DsheapskewTable) -> Double { @_common.mean(self.data) }

pub fn DsheapskewTable::scale(self : DsheapskewTable, f : Double) -> DsheapskewTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapskewTable::add(self : DsheapskewTable, other : DsheapskewTable) -> DsheapskewTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapskewTable::copy(self : DsheapskewTable) -> DsheapskewTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapskewTable::fill(self : DsheapskewTable, v : Double) -> DsheapskewTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapskewTable::min(self : DsheapskewTable) -> Double { @_common.min(self.data) }

pub fn DsheapskewTable::max(self : DsheapskewTable) -> Double { @_common.max(self.data) }

pub fn DsheapskewTable::to_string(self : DsheapskewTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapskewGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_graphn_make(size : Int) -> DsheapskewGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapskewGraphN::len(self : DsheapskewGraphN) -> Int { self.size }

pub fn DsheapskewGraphN::get(self : DsheapskewGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapskewGraphN::set(self : DsheapskewGraphN, i : Int, v : Double) -> DsheapskewGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapskewGraphN::sum(self : DsheapskewGraphN) -> Double { @_common.sum(self.data) }

pub fn DsheapskewGraphN::mean(self : DsheapskewGraphN) -> Double { @_common.mean(self.data) }

pub fn DsheapskewGraphN::scale(self : DsheapskewGraphN, f : Double) -> DsheapskewGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapskewGraphN::add(self : DsheapskewGraphN, other : DsheapskewGraphN) -> DsheapskewGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapskewGraphN::copy(self : DsheapskewGraphN) -> DsheapskewGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapskewGraphN::fill(self : DsheapskewGraphN, v : Double) -> DsheapskewGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapskewGraphN::min(self : DsheapskewGraphN) -> Double { @_common.min(self.data) }

pub fn DsheapskewGraphN::max(self : DsheapskewGraphN) -> Double { @_common.max(self.data) }

pub fn DsheapskewGraphN::to_string(self : DsheapskewGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapskewNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_node_make(size : Int) -> DsheapskewNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapskewNode::len(self : DsheapskewNode) -> Int { self.size }

pub fn DsheapskewNode::get(self : DsheapskewNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapskewNode::set(self : DsheapskewNode, i : Int, v : Double) -> DsheapskewNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapskewNode::sum(self : DsheapskewNode) -> Double { @_common.sum(self.data) }

pub fn DsheapskewNode::mean(self : DsheapskewNode) -> Double { @_common.mean(self.data) }

pub fn DsheapskewNode::scale(self : DsheapskewNode, f : Double) -> DsheapskewNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapskewNode::add(self : DsheapskewNode, other : DsheapskewNode) -> DsheapskewNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapskewNode::copy(self : DsheapskewNode) -> DsheapskewNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapskewNode::fill(self : DsheapskewNode, v : Double) -> DsheapskewNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapskewNode::min(self : DsheapskewNode) -> Double { @_common.min(self.data) }

pub fn DsheapskewNode::max(self : DsheapskewNode) -> Double { @_common.max(self.data) }

pub fn DsheapskewNode::to_string(self : DsheapskewNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapskewEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_edge_make(size : Int) -> DsheapskewEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapskewEdge::len(self : DsheapskewEdge) -> Int { self.size }

pub fn DsheapskewEdge::get(self : DsheapskewEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapskewEdge::set(self : DsheapskewEdge, i : Int, v : Double) -> DsheapskewEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapskewEdge::sum(self : DsheapskewEdge) -> Double { @_common.sum(self.data) }

pub fn DsheapskewEdge::mean(self : DsheapskewEdge) -> Double { @_common.mean(self.data) }

pub fn DsheapskewEdge::scale(self : DsheapskewEdge, f : Double) -> DsheapskewEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapskewEdge::add(self : DsheapskewEdge, other : DsheapskewEdge) -> DsheapskewEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapskewEdge::copy(self : DsheapskewEdge) -> DsheapskewEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapskewEdge::fill(self : DsheapskewEdge, v : Double) -> DsheapskewEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapskewEdge::min(self : DsheapskewEdge) -> Double { @_common.min(self.data) }

pub fn DsheapskewEdge::max(self : DsheapskewEdge) -> Double { @_common.max(self.data) }

pub fn DsheapskewEdge::to_string(self : DsheapskewEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapskewPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_path_make(size : Int) -> DsheapskewPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapskewPath::len(self : DsheapskewPath) -> Int { self.size }

pub fn DsheapskewPath::get(self : DsheapskewPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapskewPath::set(self : DsheapskewPath, i : Int, v : Double) -> DsheapskewPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapskewPath::sum(self : DsheapskewPath) -> Double { @_common.sum(self.data) }

pub fn DsheapskewPath::mean(self : DsheapskewPath) -> Double { @_common.mean(self.data) }

pub fn DsheapskewPath::scale(self : DsheapskewPath, f : Double) -> DsheapskewPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapskewPath::add(self : DsheapskewPath, other : DsheapskewPath) -> DsheapskewPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapskewPath::copy(self : DsheapskewPath) -> DsheapskewPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapskewPath::fill(self : DsheapskewPath, v : Double) -> DsheapskewPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapskewPath::min(self : DsheapskewPath) -> Double { @_common.min(self.data) }

pub fn DsheapskewPath::max(self : DsheapskewPath) -> Double { @_common.max(self.data) }

pub fn DsheapskewPath::to_string(self : DsheapskewPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapskewCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_cluster_make(size : Int) -> DsheapskewCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapskewCluster::len(self : DsheapskewCluster) -> Int { self.size }

pub fn DsheapskewCluster::get(self : DsheapskewCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapskewCluster::set(self : DsheapskewCluster, i : Int, v : Double) -> DsheapskewCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapskewCluster::sum(self : DsheapskewCluster) -> Double { @_common.sum(self.data) }

pub fn DsheapskewCluster::mean(self : DsheapskewCluster) -> Double { @_common.mean(self.data) }

pub fn DsheapskewCluster::scale(self : DsheapskewCluster, f : Double) -> DsheapskewCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapskewCluster::add(self : DsheapskewCluster, other : DsheapskewCluster) -> DsheapskewCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapskewCluster::copy(self : DsheapskewCluster) -> DsheapskewCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapskewCluster::fill(self : DsheapskewCluster, v : Double) -> DsheapskewCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapskewCluster::min(self : DsheapskewCluster) -> Double { @_common.min(self.data) }

pub fn DsheapskewCluster::max(self : DsheapskewCluster) -> Double { @_common.max(self.data) }

pub fn DsheapskewCluster::to_string(self : DsheapskewCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapskewModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_model_make(size : Int) -> DsheapskewModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapskewModel::len(self : DsheapskewModel) -> Int { self.size }

pub fn DsheapskewModel::get(self : DsheapskewModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapskewModel::set(self : DsheapskewModel, i : Int, v : Double) -> DsheapskewModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapskewModel::sum(self : DsheapskewModel) -> Double { @_common.sum(self.data) }

pub fn DsheapskewModel::mean(self : DsheapskewModel) -> Double { @_common.mean(self.data) }

pub fn DsheapskewModel::scale(self : DsheapskewModel, f : Double) -> DsheapskewModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapskewModel::add(self : DsheapskewModel, other : DsheapskewModel) -> DsheapskewModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapskewModel::copy(self : DsheapskewModel) -> DsheapskewModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapskewModel::fill(self : DsheapskewModel, v : Double) -> DsheapskewModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapskewModel::min(self : DsheapskewModel) -> Double { @_common.min(self.data) }

pub fn DsheapskewModel::max(self : DsheapskewModel) -> Double { @_common.max(self.data) }

pub fn DsheapskewModel::to_string(self : DsheapskewModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapskewLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_layer_make(size : Int) -> DsheapskewLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapskewLayer::len(self : DsheapskewLayer) -> Int { self.size }

pub fn DsheapskewLayer::get(self : DsheapskewLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapskewLayer::set(self : DsheapskewLayer, i : Int, v : Double) -> DsheapskewLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapskewLayer::sum(self : DsheapskewLayer) -> Double { @_common.sum(self.data) }

pub fn DsheapskewLayer::mean(self : DsheapskewLayer) -> Double { @_common.mean(self.data) }

pub fn DsheapskewLayer::scale(self : DsheapskewLayer, f : Double) -> DsheapskewLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapskewLayer::add(self : DsheapskewLayer, other : DsheapskewLayer) -> DsheapskewLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapskewLayer::copy(self : DsheapskewLayer) -> DsheapskewLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapskewLayer::fill(self : DsheapskewLayer, v : Double) -> DsheapskewLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapskewLayer::min(self : DsheapskewLayer) -> Double { @_common.min(self.data) }

pub fn DsheapskewLayer::max(self : DsheapskewLayer) -> Double { @_common.max(self.data) }

pub fn DsheapskewLayer::to_string(self : DsheapskewLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapskewBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_buffer_make(size : Int) -> DsheapskewBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapskewBuffer::len(self : DsheapskewBuffer) -> Int { self.size }

pub fn DsheapskewBuffer::get(self : DsheapskewBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapskewBuffer::set(self : DsheapskewBuffer, i : Int, v : Double) -> DsheapskewBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapskewBuffer::sum(self : DsheapskewBuffer) -> Double { @_common.sum(self.data) }

pub fn DsheapskewBuffer::mean(self : DsheapskewBuffer) -> Double { @_common.mean(self.data) }

pub fn DsheapskewBuffer::scale(self : DsheapskewBuffer, f : Double) -> DsheapskewBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapskewBuffer::add(self : DsheapskewBuffer, other : DsheapskewBuffer) -> DsheapskewBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapskewBuffer::copy(self : DsheapskewBuffer) -> DsheapskewBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapskewBuffer::fill(self : DsheapskewBuffer, v : Double) -> DsheapskewBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapskewBuffer::min(self : DsheapskewBuffer) -> Double { @_common.min(self.data) }

pub fn DsheapskewBuffer::max(self : DsheapskewBuffer) -> Double { @_common.max(self.data) }

pub fn DsheapskewBuffer::to_string(self : DsheapskewBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapskewCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_cursor_make(size : Int) -> DsheapskewCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapskewCursor::len(self : DsheapskewCursor) -> Int { self.size }

pub fn DsheapskewCursor::get(self : DsheapskewCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapskewCursor::set(self : DsheapskewCursor, i : Int, v : Double) -> DsheapskewCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapskewCursor::sum(self : DsheapskewCursor) -> Double { @_common.sum(self.data) }

pub fn DsheapskewCursor::mean(self : DsheapskewCursor) -> Double { @_common.mean(self.data) }

pub fn DsheapskewCursor::scale(self : DsheapskewCursor, f : Double) -> DsheapskewCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapskewCursor::add(self : DsheapskewCursor, other : DsheapskewCursor) -> DsheapskewCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapskewCursor::copy(self : DsheapskewCursor) -> DsheapskewCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapskewCursor::fill(self : DsheapskewCursor, v : Double) -> DsheapskewCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapskewCursor::min(self : DsheapskewCursor) -> Double { @_common.min(self.data) }

pub fn DsheapskewCursor::max(self : DsheapskewCursor) -> Double { @_common.max(self.data) }

pub fn DsheapskewCursor::to_string(self : DsheapskewCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapskewView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_view_make(size : Int) -> DsheapskewView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapskewView::len(self : DsheapskewView) -> Int { self.size }

pub fn DsheapskewView::get(self : DsheapskewView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapskewView::set(self : DsheapskewView, i : Int, v : Double) -> DsheapskewView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapskewView::sum(self : DsheapskewView) -> Double { @_common.sum(self.data) }

pub fn DsheapskewView::mean(self : DsheapskewView) -> Double { @_common.mean(self.data) }

pub fn DsheapskewView::scale(self : DsheapskewView, f : Double) -> DsheapskewView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapskewView::add(self : DsheapskewView, other : DsheapskewView) -> DsheapskewView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapskewView::copy(self : DsheapskewView) -> DsheapskewView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapskewView::fill(self : DsheapskewView, v : Double) -> DsheapskewView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapskewView::min(self : DsheapskewView) -> Double { @_common.min(self.data) }

pub fn DsheapskewView::max(self : DsheapskewView) -> Double { @_common.max(self.data) }

pub fn DsheapskewView::to_string(self : DsheapskewView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapskewRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_range_make(size : Int) -> DsheapskewRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapskewRange::len(self : DsheapskewRange) -> Int { self.size }

pub fn DsheapskewRange::get(self : DsheapskewRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapskewRange::set(self : DsheapskewRange, i : Int, v : Double) -> DsheapskewRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapskewRange::sum(self : DsheapskewRange) -> Double { @_common.sum(self.data) }

pub fn DsheapskewRange::mean(self : DsheapskewRange) -> Double { @_common.mean(self.data) }

pub fn DsheapskewRange::scale(self : DsheapskewRange, f : Double) -> DsheapskewRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapskewRange::add(self : DsheapskewRange, other : DsheapskewRange) -> DsheapskewRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapskewRange::copy(self : DsheapskewRange) -> DsheapskewRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapskewRange::fill(self : DsheapskewRange, v : Double) -> DsheapskewRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapskewRange::min(self : DsheapskewRange) -> Double { @_common.min(self.data) }

pub fn DsheapskewRange::max(self : DsheapskewRange) -> Double { @_common.max(self.data) }

pub fn DsheapskewRange::to_string(self : DsheapskewRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DsheapskewSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_heap_skew_slice_make(size : Int) -> DsheapskewSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DsheapskewSlice::len(self : DsheapskewSlice) -> Int { self.size }

pub fn DsheapskewSlice::get(self : DsheapskewSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DsheapskewSlice::set(self : DsheapskewSlice, i : Int, v : Double) -> DsheapskewSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DsheapskewSlice::sum(self : DsheapskewSlice) -> Double { @_common.sum(self.data) }

pub fn DsheapskewSlice::mean(self : DsheapskewSlice) -> Double { @_common.mean(self.data) }

pub fn DsheapskewSlice::scale(self : DsheapskewSlice, f : Double) -> DsheapskewSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DsheapskewSlice::add(self : DsheapskewSlice, other : DsheapskewSlice) -> DsheapskewSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DsheapskewSlice::copy(self : DsheapskewSlice) -> DsheapskewSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DsheapskewSlice::fill(self : DsheapskewSlice, v : Double) -> DsheapskewSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DsheapskewSlice::min(self : DsheapskewSlice) -> Double { @_common.min(self.data) }

pub fn DsheapskewSlice::max(self : DsheapskewSlice) -> Double { @_common.max(self.data) }

pub fn DsheapskewSlice::to_string(self : DsheapskewSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

