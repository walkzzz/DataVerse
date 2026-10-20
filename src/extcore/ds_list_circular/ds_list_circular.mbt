///===
/// extcore/ds_list_circular

pub(all) struct DslistcircularPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_circular_make_point(x : Double, y : Double) -> DslistcircularPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_circular_make_point3(x : Double, y : Double, z : Double) -> DslistcircularPoint {
  { x, y, z, label: 0 }
}

pub fn DslistcircularPoint::x(self : DslistcircularPoint) -> Double { self.x }

pub fn DslistcircularPoint::y(self : DslistcircularPoint) -> Double { self.y }

pub fn DslistcircularPoint::z(self : DslistcircularPoint) -> Double { self.z }

pub fn DslistcircularPoint::label(self : DslistcircularPoint) -> Int { self.label }

pub fn DslistcircularPoint::dist(self : DslistcircularPoint, other : DslistcircularPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistcircularPoint::add(self : DslistcircularPoint, other : DslistcircularPoint) -> DslistcircularPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistcircularPoint::sub(self : DslistcircularPoint, other : DslistcircularPoint) -> DslistcircularPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistcircularPoint::scale(self : DslistcircularPoint, s : Double) -> DslistcircularPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistcircularPoint::dot(self : DslistcircularPoint, other : DslistcircularPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistcircularPoint::cross(self : DslistcircularPoint, other : DslistcircularPoint) -> DslistcircularPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistcircularPoint::norm(self : DslistcircularPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistcircularPoint::normalize(self : DslistcircularPoint) -> DslistcircularPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistcircularPoint::negate(self : DslistcircularPoint) -> DslistcircularPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistcircularPoint::mid(self : DslistcircularPoint, other : DslistcircularPoint) -> DslistcircularPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistcircularPoint::lerp(self : DslistcircularPoint, other : DslistcircularPoint, t : Double) -> DslistcircularPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistcircularPoint::to_string(self : DslistcircularPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistcircularSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_circular_make_series(vals : Array[Double], name : String) -> DslistcircularSeries {
  { vals, name, meta: 0 }
}

pub fn DslistcircularSeries::len(self : DslistcircularSeries) -> Int { self.vals.length() }

pub fn DslistcircularSeries::sum(self : DslistcircularSeries) -> Double { @_common.sum(self.vals) }

pub fn DslistcircularSeries::mean(self : DslistcircularSeries) -> Double { @_common.mean(self.vals) }

pub fn DslistcircularSeries::min(self : DslistcircularSeries) -> Double { @_common.min(self.vals) }

pub fn DslistcircularSeries::max(self : DslistcircularSeries) -> Double { @_common.max(self.vals) }

pub fn DslistcircularSeries::range(self : DslistcircularSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistcircularSeries::variance(self : DslistcircularSeries) -> Double { @_common.variance(self.vals) }

pub fn DslistcircularSeries::std(self : DslistcircularSeries) -> Double { @_common.std(self.vals) }

pub fn DslistcircularSeries::median(self : DslistcircularSeries) -> Double { @_common.median(self.vals) }

pub fn DslistcircularSeries::scale(self : DslistcircularSeries, f : Double) -> DslistcircularSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistcircularSeries::add(self : DslistcircularSeries, other : DslistcircularSeries) -> DslistcircularSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistcircularSeries::sub(self : DslistcircularSeries, other : DslistcircularSeries) -> DslistcircularSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistcircularSeries::normalize(self : DslistcircularSeries) -> DslistcircularSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistcircularSeries::cumsum(self : DslistcircularSeries) -> DslistcircularSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistcircularSeries::to_string(self : DslistcircularSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistcircularMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_circular_make_matrix(rows : Int, cols : Int, val : Double) -> DslistcircularMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_circular_matrix_identity(n : Int) -> DslistcircularMatrix {
  let m = ds_list_circular_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistcircularMatrix::get(self : DslistcircularMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistcircularMatrix::transpose(self : DslistcircularMatrix) -> DslistcircularMatrix {
  let result = ds_list_circular_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistcircularMatrix::add(self : DslistcircularMatrix, other : DslistcircularMatrix) -> DslistcircularMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_circular_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistcircularMatrix::scale(self : DslistcircularMatrix, s : Double) -> DslistcircularMatrix {
  let result = ds_list_circular_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistcircularMatrix::multiply(self : DslistcircularMatrix, other : DslistcircularMatrix) -> DslistcircularMatrix {
  if self.cols != other.rows { return ds_list_circular_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_circular_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistcircularMatrix::trace(self : DslistcircularMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistcircularMatrix::det(self : DslistcircularMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistcircularMatrix::norm(self : DslistcircularMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistcircularMatrix::to_string(self : DslistcircularMatrix) -> String {
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

pub(all) struct DslistcircularVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_circular_make_vector(comps : Array[Double]) -> DslistcircularVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_circular_vector_zero(dim : Int) -> DslistcircularVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistcircularVector::add(self : DslistcircularVector, other : DslistcircularVector) -> DslistcircularVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistcircularVector::sub(self : DslistcircularVector, other : DslistcircularVector) -> DslistcircularVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistcircularVector::scale(self : DslistcircularVector, s : Double) -> DslistcircularVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistcircularVector::dot(self : DslistcircularVector, other : DslistcircularVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistcircularVector::norm(self : DslistcircularVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistcircularVector::normalize(self : DslistcircularVector) -> DslistcircularVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistcircularVector::dist(self : DslistcircularVector, other : DslistcircularVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistcircularVector::to_string(self : DslistcircularVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_circular_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_circular_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_circular_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_circular_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_circular_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_circular_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_circular_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_circular_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_circular_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_circular_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_circular_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_circular_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_circular_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_circular_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_circular_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_circular_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_circular_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_circular_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_circular_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_circular_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_circular_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_circular_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_circular_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_circular_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_circular_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_circular_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_circular_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_circular_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_circular_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistcircularFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_frame_make(size : Int) -> DslistcircularFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistcircularFrame::len(self : DslistcircularFrame) -> Int { self.size }

pub fn DslistcircularFrame::get(self : DslistcircularFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistcircularFrame::set(self : DslistcircularFrame, i : Int, v : Double) -> DslistcircularFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistcircularFrame::sum(self : DslistcircularFrame) -> Double { @_common.sum(self.data) }

pub fn DslistcircularFrame::mean(self : DslistcircularFrame) -> Double { @_common.mean(self.data) }

pub fn DslistcircularFrame::scale(self : DslistcircularFrame, f : Double) -> DslistcircularFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistcircularFrame::add(self : DslistcircularFrame, other : DslistcircularFrame) -> DslistcircularFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistcircularFrame::copy(self : DslistcircularFrame) -> DslistcircularFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistcircularFrame::fill(self : DslistcircularFrame, v : Double) -> DslistcircularFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistcircularFrame::min(self : DslistcircularFrame) -> Double { @_common.min(self.data) }

pub fn DslistcircularFrame::max(self : DslistcircularFrame) -> Double { @_common.max(self.data) }

pub fn DslistcircularFrame::to_string(self : DslistcircularFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistcircularTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_table_make(size : Int) -> DslistcircularTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistcircularTable::len(self : DslistcircularTable) -> Int { self.size }

pub fn DslistcircularTable::get(self : DslistcircularTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistcircularTable::set(self : DslistcircularTable, i : Int, v : Double) -> DslistcircularTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistcircularTable::sum(self : DslistcircularTable) -> Double { @_common.sum(self.data) }

pub fn DslistcircularTable::mean(self : DslistcircularTable) -> Double { @_common.mean(self.data) }

pub fn DslistcircularTable::scale(self : DslistcircularTable, f : Double) -> DslistcircularTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistcircularTable::add(self : DslistcircularTable, other : DslistcircularTable) -> DslistcircularTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistcircularTable::copy(self : DslistcircularTable) -> DslistcircularTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistcircularTable::fill(self : DslistcircularTable, v : Double) -> DslistcircularTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistcircularTable::min(self : DslistcircularTable) -> Double { @_common.min(self.data) }

pub fn DslistcircularTable::max(self : DslistcircularTable) -> Double { @_common.max(self.data) }

pub fn DslistcircularTable::to_string(self : DslistcircularTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistcircularGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_graphn_make(size : Int) -> DslistcircularGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistcircularGraphN::len(self : DslistcircularGraphN) -> Int { self.size }

pub fn DslistcircularGraphN::get(self : DslistcircularGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistcircularGraphN::set(self : DslistcircularGraphN, i : Int, v : Double) -> DslistcircularGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistcircularGraphN::sum(self : DslistcircularGraphN) -> Double { @_common.sum(self.data) }

pub fn DslistcircularGraphN::mean(self : DslistcircularGraphN) -> Double { @_common.mean(self.data) }

pub fn DslistcircularGraphN::scale(self : DslistcircularGraphN, f : Double) -> DslistcircularGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistcircularGraphN::add(self : DslistcircularGraphN, other : DslistcircularGraphN) -> DslistcircularGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistcircularGraphN::copy(self : DslistcircularGraphN) -> DslistcircularGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistcircularGraphN::fill(self : DslistcircularGraphN, v : Double) -> DslistcircularGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistcircularGraphN::min(self : DslistcircularGraphN) -> Double { @_common.min(self.data) }

pub fn DslistcircularGraphN::max(self : DslistcircularGraphN) -> Double { @_common.max(self.data) }

pub fn DslistcircularGraphN::to_string(self : DslistcircularGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistcircularNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_node_make(size : Int) -> DslistcircularNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistcircularNode::len(self : DslistcircularNode) -> Int { self.size }

pub fn DslistcircularNode::get(self : DslistcircularNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistcircularNode::set(self : DslistcircularNode, i : Int, v : Double) -> DslistcircularNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistcircularNode::sum(self : DslistcircularNode) -> Double { @_common.sum(self.data) }

pub fn DslistcircularNode::mean(self : DslistcircularNode) -> Double { @_common.mean(self.data) }

pub fn DslistcircularNode::scale(self : DslistcircularNode, f : Double) -> DslistcircularNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistcircularNode::add(self : DslistcircularNode, other : DslistcircularNode) -> DslistcircularNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistcircularNode::copy(self : DslistcircularNode) -> DslistcircularNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistcircularNode::fill(self : DslistcircularNode, v : Double) -> DslistcircularNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistcircularNode::min(self : DslistcircularNode) -> Double { @_common.min(self.data) }

pub fn DslistcircularNode::max(self : DslistcircularNode) -> Double { @_common.max(self.data) }

pub fn DslistcircularNode::to_string(self : DslistcircularNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistcircularEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_edge_make(size : Int) -> DslistcircularEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistcircularEdge::len(self : DslistcircularEdge) -> Int { self.size }

pub fn DslistcircularEdge::get(self : DslistcircularEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistcircularEdge::set(self : DslistcircularEdge, i : Int, v : Double) -> DslistcircularEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistcircularEdge::sum(self : DslistcircularEdge) -> Double { @_common.sum(self.data) }

pub fn DslistcircularEdge::mean(self : DslistcircularEdge) -> Double { @_common.mean(self.data) }

pub fn DslistcircularEdge::scale(self : DslistcircularEdge, f : Double) -> DslistcircularEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistcircularEdge::add(self : DslistcircularEdge, other : DslistcircularEdge) -> DslistcircularEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistcircularEdge::copy(self : DslistcircularEdge) -> DslistcircularEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistcircularEdge::fill(self : DslistcircularEdge, v : Double) -> DslistcircularEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistcircularEdge::min(self : DslistcircularEdge) -> Double { @_common.min(self.data) }

pub fn DslistcircularEdge::max(self : DslistcircularEdge) -> Double { @_common.max(self.data) }

pub fn DslistcircularEdge::to_string(self : DslistcircularEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistcircularPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_path_make(size : Int) -> DslistcircularPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistcircularPath::len(self : DslistcircularPath) -> Int { self.size }

pub fn DslistcircularPath::get(self : DslistcircularPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistcircularPath::set(self : DslistcircularPath, i : Int, v : Double) -> DslistcircularPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistcircularPath::sum(self : DslistcircularPath) -> Double { @_common.sum(self.data) }

pub fn DslistcircularPath::mean(self : DslistcircularPath) -> Double { @_common.mean(self.data) }

pub fn DslistcircularPath::scale(self : DslistcircularPath, f : Double) -> DslistcircularPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistcircularPath::add(self : DslistcircularPath, other : DslistcircularPath) -> DslistcircularPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistcircularPath::copy(self : DslistcircularPath) -> DslistcircularPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistcircularPath::fill(self : DslistcircularPath, v : Double) -> DslistcircularPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistcircularPath::min(self : DslistcircularPath) -> Double { @_common.min(self.data) }

pub fn DslistcircularPath::max(self : DslistcircularPath) -> Double { @_common.max(self.data) }

pub fn DslistcircularPath::to_string(self : DslistcircularPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistcircularCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_cluster_make(size : Int) -> DslistcircularCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistcircularCluster::len(self : DslistcircularCluster) -> Int { self.size }

pub fn DslistcircularCluster::get(self : DslistcircularCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistcircularCluster::set(self : DslistcircularCluster, i : Int, v : Double) -> DslistcircularCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistcircularCluster::sum(self : DslistcircularCluster) -> Double { @_common.sum(self.data) }

pub fn DslistcircularCluster::mean(self : DslistcircularCluster) -> Double { @_common.mean(self.data) }

pub fn DslistcircularCluster::scale(self : DslistcircularCluster, f : Double) -> DslistcircularCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistcircularCluster::add(self : DslistcircularCluster, other : DslistcircularCluster) -> DslistcircularCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistcircularCluster::copy(self : DslistcircularCluster) -> DslistcircularCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistcircularCluster::fill(self : DslistcircularCluster, v : Double) -> DslistcircularCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistcircularCluster::min(self : DslistcircularCluster) -> Double { @_common.min(self.data) }

pub fn DslistcircularCluster::max(self : DslistcircularCluster) -> Double { @_common.max(self.data) }

pub fn DslistcircularCluster::to_string(self : DslistcircularCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistcircularModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_model_make(size : Int) -> DslistcircularModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistcircularModel::len(self : DslistcircularModel) -> Int { self.size }

pub fn DslistcircularModel::get(self : DslistcircularModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistcircularModel::set(self : DslistcircularModel, i : Int, v : Double) -> DslistcircularModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistcircularModel::sum(self : DslistcircularModel) -> Double { @_common.sum(self.data) }

pub fn DslistcircularModel::mean(self : DslistcircularModel) -> Double { @_common.mean(self.data) }

pub fn DslistcircularModel::scale(self : DslistcircularModel, f : Double) -> DslistcircularModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistcircularModel::add(self : DslistcircularModel, other : DslistcircularModel) -> DslistcircularModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistcircularModel::copy(self : DslistcircularModel) -> DslistcircularModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistcircularModel::fill(self : DslistcircularModel, v : Double) -> DslistcircularModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistcircularModel::min(self : DslistcircularModel) -> Double { @_common.min(self.data) }

pub fn DslistcircularModel::max(self : DslistcircularModel) -> Double { @_common.max(self.data) }

pub fn DslistcircularModel::to_string(self : DslistcircularModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistcircularLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_layer_make(size : Int) -> DslistcircularLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistcircularLayer::len(self : DslistcircularLayer) -> Int { self.size }

pub fn DslistcircularLayer::get(self : DslistcircularLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistcircularLayer::set(self : DslistcircularLayer, i : Int, v : Double) -> DslistcircularLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistcircularLayer::sum(self : DslistcircularLayer) -> Double { @_common.sum(self.data) }

pub fn DslistcircularLayer::mean(self : DslistcircularLayer) -> Double { @_common.mean(self.data) }

pub fn DslistcircularLayer::scale(self : DslistcircularLayer, f : Double) -> DslistcircularLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistcircularLayer::add(self : DslistcircularLayer, other : DslistcircularLayer) -> DslistcircularLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistcircularLayer::copy(self : DslistcircularLayer) -> DslistcircularLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistcircularLayer::fill(self : DslistcircularLayer, v : Double) -> DslistcircularLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistcircularLayer::min(self : DslistcircularLayer) -> Double { @_common.min(self.data) }

pub fn DslistcircularLayer::max(self : DslistcircularLayer) -> Double { @_common.max(self.data) }

pub fn DslistcircularLayer::to_string(self : DslistcircularLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistcircularBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_buffer_make(size : Int) -> DslistcircularBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistcircularBuffer::len(self : DslistcircularBuffer) -> Int { self.size }

pub fn DslistcircularBuffer::get(self : DslistcircularBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistcircularBuffer::set(self : DslistcircularBuffer, i : Int, v : Double) -> DslistcircularBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistcircularBuffer::sum(self : DslistcircularBuffer) -> Double { @_common.sum(self.data) }

pub fn DslistcircularBuffer::mean(self : DslistcircularBuffer) -> Double { @_common.mean(self.data) }

pub fn DslistcircularBuffer::scale(self : DslistcircularBuffer, f : Double) -> DslistcircularBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistcircularBuffer::add(self : DslistcircularBuffer, other : DslistcircularBuffer) -> DslistcircularBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistcircularBuffer::copy(self : DslistcircularBuffer) -> DslistcircularBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistcircularBuffer::fill(self : DslistcircularBuffer, v : Double) -> DslistcircularBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistcircularBuffer::min(self : DslistcircularBuffer) -> Double { @_common.min(self.data) }

pub fn DslistcircularBuffer::max(self : DslistcircularBuffer) -> Double { @_common.max(self.data) }

pub fn DslistcircularBuffer::to_string(self : DslistcircularBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistcircularCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_cursor_make(size : Int) -> DslistcircularCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistcircularCursor::len(self : DslistcircularCursor) -> Int { self.size }

pub fn DslistcircularCursor::get(self : DslistcircularCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistcircularCursor::set(self : DslistcircularCursor, i : Int, v : Double) -> DslistcircularCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistcircularCursor::sum(self : DslistcircularCursor) -> Double { @_common.sum(self.data) }

pub fn DslistcircularCursor::mean(self : DslistcircularCursor) -> Double { @_common.mean(self.data) }

pub fn DslistcircularCursor::scale(self : DslistcircularCursor, f : Double) -> DslistcircularCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistcircularCursor::add(self : DslistcircularCursor, other : DslistcircularCursor) -> DslistcircularCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistcircularCursor::copy(self : DslistcircularCursor) -> DslistcircularCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistcircularCursor::fill(self : DslistcircularCursor, v : Double) -> DslistcircularCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistcircularCursor::min(self : DslistcircularCursor) -> Double { @_common.min(self.data) }

pub fn DslistcircularCursor::max(self : DslistcircularCursor) -> Double { @_common.max(self.data) }

pub fn DslistcircularCursor::to_string(self : DslistcircularCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistcircularView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_view_make(size : Int) -> DslistcircularView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistcircularView::len(self : DslistcircularView) -> Int { self.size }

pub fn DslistcircularView::get(self : DslistcircularView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistcircularView::set(self : DslistcircularView, i : Int, v : Double) -> DslistcircularView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistcircularView::sum(self : DslistcircularView) -> Double { @_common.sum(self.data) }

pub fn DslistcircularView::mean(self : DslistcircularView) -> Double { @_common.mean(self.data) }

pub fn DslistcircularView::scale(self : DslistcircularView, f : Double) -> DslistcircularView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistcircularView::add(self : DslistcircularView, other : DslistcircularView) -> DslistcircularView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistcircularView::copy(self : DslistcircularView) -> DslistcircularView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistcircularView::fill(self : DslistcircularView, v : Double) -> DslistcircularView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistcircularView::min(self : DslistcircularView) -> Double { @_common.min(self.data) }

pub fn DslistcircularView::max(self : DslistcircularView) -> Double { @_common.max(self.data) }

pub fn DslistcircularView::to_string(self : DslistcircularView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistcircularRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_range_make(size : Int) -> DslistcircularRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistcircularRange::len(self : DslistcircularRange) -> Int { self.size }

pub fn DslistcircularRange::get(self : DslistcircularRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistcircularRange::set(self : DslistcircularRange, i : Int, v : Double) -> DslistcircularRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistcircularRange::sum(self : DslistcircularRange) -> Double { @_common.sum(self.data) }

pub fn DslistcircularRange::mean(self : DslistcircularRange) -> Double { @_common.mean(self.data) }

pub fn DslistcircularRange::scale(self : DslistcircularRange, f : Double) -> DslistcircularRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistcircularRange::add(self : DslistcircularRange, other : DslistcircularRange) -> DslistcircularRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistcircularRange::copy(self : DslistcircularRange) -> DslistcircularRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistcircularRange::fill(self : DslistcircularRange, v : Double) -> DslistcircularRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistcircularRange::min(self : DslistcircularRange) -> Double { @_common.min(self.data) }

pub fn DslistcircularRange::max(self : DslistcircularRange) -> Double { @_common.max(self.data) }

pub fn DslistcircularRange::to_string(self : DslistcircularRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistcircularSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_circular_slice_make(size : Int) -> DslistcircularSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistcircularSlice::len(self : DslistcircularSlice) -> Int { self.size }

pub fn DslistcircularSlice::get(self : DslistcircularSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistcircularSlice::set(self : DslistcircularSlice, i : Int, v : Double) -> DslistcircularSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistcircularSlice::sum(self : DslistcircularSlice) -> Double { @_common.sum(self.data) }

pub fn DslistcircularSlice::mean(self : DslistcircularSlice) -> Double { @_common.mean(self.data) }

pub fn DslistcircularSlice::scale(self : DslistcircularSlice, f : Double) -> DslistcircularSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistcircularSlice::add(self : DslistcircularSlice, other : DslistcircularSlice) -> DslistcircularSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistcircularSlice::copy(self : DslistcircularSlice) -> DslistcircularSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistcircularSlice::fill(self : DslistcircularSlice, v : Double) -> DslistcircularSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistcircularSlice::min(self : DslistcircularSlice) -> Double { @_common.min(self.data) }

pub fn DslistcircularSlice::max(self : DslistcircularSlice) -> Double { @_common.max(self.data) }

pub fn DslistcircularSlice::to_string(self : DslistcircularSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

