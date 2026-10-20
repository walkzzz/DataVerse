///===
/// extcore/ds_list_unrolled

pub(all) struct DslistunrolledPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_unrolled_make_point(x : Double, y : Double) -> DslistunrolledPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_unrolled_make_point3(x : Double, y : Double, z : Double) -> DslistunrolledPoint {
  { x, y, z, label: 0 }
}

pub fn DslistunrolledPoint::x(self : DslistunrolledPoint) -> Double { self.x }

pub fn DslistunrolledPoint::y(self : DslistunrolledPoint) -> Double { self.y }

pub fn DslistunrolledPoint::z(self : DslistunrolledPoint) -> Double { self.z }

pub fn DslistunrolledPoint::label(self : DslistunrolledPoint) -> Int { self.label }

pub fn DslistunrolledPoint::dist(self : DslistunrolledPoint, other : DslistunrolledPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistunrolledPoint::add(self : DslistunrolledPoint, other : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistunrolledPoint::sub(self : DslistunrolledPoint, other : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistunrolledPoint::scale(self : DslistunrolledPoint, s : Double) -> DslistunrolledPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistunrolledPoint::dot(self : DslistunrolledPoint, other : DslistunrolledPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistunrolledPoint::cross(self : DslistunrolledPoint, other : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistunrolledPoint::norm(self : DslistunrolledPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistunrolledPoint::normalize(self : DslistunrolledPoint) -> DslistunrolledPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistunrolledPoint::negate(self : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistunrolledPoint::mid(self : DslistunrolledPoint, other : DslistunrolledPoint) -> DslistunrolledPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistunrolledPoint::lerp(self : DslistunrolledPoint, other : DslistunrolledPoint, t : Double) -> DslistunrolledPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistunrolledPoint::to_string(self : DslistunrolledPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistunrolledSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_unrolled_make_series(vals : Array[Double], name : String) -> DslistunrolledSeries {
  { vals, name, meta: 0 }
}

pub fn DslistunrolledSeries::len(self : DslistunrolledSeries) -> Int { self.vals.length() }

pub fn DslistunrolledSeries::sum(self : DslistunrolledSeries) -> Double { @_common.sum(self.vals) }

pub fn DslistunrolledSeries::mean(self : DslistunrolledSeries) -> Double { @_common.mean(self.vals) }

pub fn DslistunrolledSeries::min(self : DslistunrolledSeries) -> Double { @_common.min(self.vals) }

pub fn DslistunrolledSeries::max(self : DslistunrolledSeries) -> Double { @_common.max(self.vals) }

pub fn DslistunrolledSeries::range(self : DslistunrolledSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistunrolledSeries::variance(self : DslistunrolledSeries) -> Double { @_common.variance(self.vals) }

pub fn DslistunrolledSeries::std(self : DslistunrolledSeries) -> Double { @_common.std(self.vals) }

pub fn DslistunrolledSeries::median(self : DslistunrolledSeries) -> Double { @_common.median(self.vals) }

pub fn DslistunrolledSeries::scale(self : DslistunrolledSeries, f : Double) -> DslistunrolledSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistunrolledSeries::add(self : DslistunrolledSeries, other : DslistunrolledSeries) -> DslistunrolledSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistunrolledSeries::sub(self : DslistunrolledSeries, other : DslistunrolledSeries) -> DslistunrolledSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistunrolledSeries::normalize(self : DslistunrolledSeries) -> DslistunrolledSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistunrolledSeries::cumsum(self : DslistunrolledSeries) -> DslistunrolledSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistunrolledSeries::to_string(self : DslistunrolledSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistunrolledMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_unrolled_make_matrix(rows : Int, cols : Int, val : Double) -> DslistunrolledMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_unrolled_matrix_identity(n : Int) -> DslistunrolledMatrix {
  let m = ds_list_unrolled_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistunrolledMatrix::get(self : DslistunrolledMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistunrolledMatrix::transpose(self : DslistunrolledMatrix) -> DslistunrolledMatrix {
  let result = ds_list_unrolled_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistunrolledMatrix::add(self : DslistunrolledMatrix, other : DslistunrolledMatrix) -> DslistunrolledMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_unrolled_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistunrolledMatrix::scale(self : DslistunrolledMatrix, s : Double) -> DslistunrolledMatrix {
  let result = ds_list_unrolled_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistunrolledMatrix::multiply(self : DslistunrolledMatrix, other : DslistunrolledMatrix) -> DslistunrolledMatrix {
  if self.cols != other.rows { return ds_list_unrolled_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_unrolled_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistunrolledMatrix::trace(self : DslistunrolledMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistunrolledMatrix::det(self : DslistunrolledMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistunrolledMatrix::norm(self : DslistunrolledMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistunrolledMatrix::to_string(self : DslistunrolledMatrix) -> String {
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

pub(all) struct DslistunrolledVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_unrolled_make_vector(comps : Array[Double]) -> DslistunrolledVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_unrolled_vector_zero(dim : Int) -> DslistunrolledVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistunrolledVector::add(self : DslistunrolledVector, other : DslistunrolledVector) -> DslistunrolledVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistunrolledVector::sub(self : DslistunrolledVector, other : DslistunrolledVector) -> DslistunrolledVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistunrolledVector::scale(self : DslistunrolledVector, s : Double) -> DslistunrolledVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistunrolledVector::dot(self : DslistunrolledVector, other : DslistunrolledVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistunrolledVector::norm(self : DslistunrolledVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistunrolledVector::normalize(self : DslistunrolledVector) -> DslistunrolledVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistunrolledVector::dist(self : DslistunrolledVector, other : DslistunrolledVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistunrolledVector::to_string(self : DslistunrolledVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_unrolled_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_unrolled_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_unrolled_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_unrolled_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_unrolled_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_unrolled_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_unrolled_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_unrolled_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_unrolled_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_unrolled_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_unrolled_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_unrolled_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_unrolled_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_unrolled_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_unrolled_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_unrolled_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_unrolled_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_unrolled_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_unrolled_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_unrolled_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_unrolled_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_unrolled_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_unrolled_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_unrolled_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_unrolled_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_unrolled_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_unrolled_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_unrolled_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_unrolled_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistunrolledFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_frame_make(size : Int) -> DslistunrolledFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistunrolledFrame::len(self : DslistunrolledFrame) -> Int { self.size }

pub fn DslistunrolledFrame::get(self : DslistunrolledFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistunrolledFrame::set(self : DslistunrolledFrame, i : Int, v : Double) -> DslistunrolledFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistunrolledFrame::sum(self : DslistunrolledFrame) -> Double { @_common.sum(self.data) }

pub fn DslistunrolledFrame::mean(self : DslistunrolledFrame) -> Double { @_common.mean(self.data) }

pub fn DslistunrolledFrame::scale(self : DslistunrolledFrame, f : Double) -> DslistunrolledFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistunrolledFrame::add(self : DslistunrolledFrame, other : DslistunrolledFrame) -> DslistunrolledFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistunrolledFrame::copy(self : DslistunrolledFrame) -> DslistunrolledFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistunrolledFrame::fill(self : DslistunrolledFrame, v : Double) -> DslistunrolledFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistunrolledFrame::min(self : DslistunrolledFrame) -> Double { @_common.min(self.data) }

pub fn DslistunrolledFrame::max(self : DslistunrolledFrame) -> Double { @_common.max(self.data) }

pub fn DslistunrolledFrame::to_string(self : DslistunrolledFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistunrolledTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_table_make(size : Int) -> DslistunrolledTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistunrolledTable::len(self : DslistunrolledTable) -> Int { self.size }

pub fn DslistunrolledTable::get(self : DslistunrolledTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistunrolledTable::set(self : DslistunrolledTable, i : Int, v : Double) -> DslistunrolledTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistunrolledTable::sum(self : DslistunrolledTable) -> Double { @_common.sum(self.data) }

pub fn DslistunrolledTable::mean(self : DslistunrolledTable) -> Double { @_common.mean(self.data) }

pub fn DslistunrolledTable::scale(self : DslistunrolledTable, f : Double) -> DslistunrolledTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistunrolledTable::add(self : DslistunrolledTable, other : DslistunrolledTable) -> DslistunrolledTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistunrolledTable::copy(self : DslistunrolledTable) -> DslistunrolledTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistunrolledTable::fill(self : DslistunrolledTable, v : Double) -> DslistunrolledTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistunrolledTable::min(self : DslistunrolledTable) -> Double { @_common.min(self.data) }

pub fn DslistunrolledTable::max(self : DslistunrolledTable) -> Double { @_common.max(self.data) }

pub fn DslistunrolledTable::to_string(self : DslistunrolledTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistunrolledGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_graphn_make(size : Int) -> DslistunrolledGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistunrolledGraphN::len(self : DslistunrolledGraphN) -> Int { self.size }

pub fn DslistunrolledGraphN::get(self : DslistunrolledGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistunrolledGraphN::set(self : DslistunrolledGraphN, i : Int, v : Double) -> DslistunrolledGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistunrolledGraphN::sum(self : DslistunrolledGraphN) -> Double { @_common.sum(self.data) }

pub fn DslistunrolledGraphN::mean(self : DslistunrolledGraphN) -> Double { @_common.mean(self.data) }

pub fn DslistunrolledGraphN::scale(self : DslistunrolledGraphN, f : Double) -> DslistunrolledGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistunrolledGraphN::add(self : DslistunrolledGraphN, other : DslistunrolledGraphN) -> DslistunrolledGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistunrolledGraphN::copy(self : DslistunrolledGraphN) -> DslistunrolledGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistunrolledGraphN::fill(self : DslistunrolledGraphN, v : Double) -> DslistunrolledGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistunrolledGraphN::min(self : DslistunrolledGraphN) -> Double { @_common.min(self.data) }

pub fn DslistunrolledGraphN::max(self : DslistunrolledGraphN) -> Double { @_common.max(self.data) }

pub fn DslistunrolledGraphN::to_string(self : DslistunrolledGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistunrolledNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_node_make(size : Int) -> DslistunrolledNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistunrolledNode::len(self : DslistunrolledNode) -> Int { self.size }

pub fn DslistunrolledNode::get(self : DslistunrolledNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistunrolledNode::set(self : DslistunrolledNode, i : Int, v : Double) -> DslistunrolledNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistunrolledNode::sum(self : DslistunrolledNode) -> Double { @_common.sum(self.data) }

pub fn DslistunrolledNode::mean(self : DslistunrolledNode) -> Double { @_common.mean(self.data) }

pub fn DslistunrolledNode::scale(self : DslistunrolledNode, f : Double) -> DslistunrolledNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistunrolledNode::add(self : DslistunrolledNode, other : DslistunrolledNode) -> DslistunrolledNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistunrolledNode::copy(self : DslistunrolledNode) -> DslistunrolledNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistunrolledNode::fill(self : DslistunrolledNode, v : Double) -> DslistunrolledNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistunrolledNode::min(self : DslistunrolledNode) -> Double { @_common.min(self.data) }

pub fn DslistunrolledNode::max(self : DslistunrolledNode) -> Double { @_common.max(self.data) }

pub fn DslistunrolledNode::to_string(self : DslistunrolledNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistunrolledEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_edge_make(size : Int) -> DslistunrolledEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistunrolledEdge::len(self : DslistunrolledEdge) -> Int { self.size }

pub fn DslistunrolledEdge::get(self : DslistunrolledEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistunrolledEdge::set(self : DslistunrolledEdge, i : Int, v : Double) -> DslistunrolledEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistunrolledEdge::sum(self : DslistunrolledEdge) -> Double { @_common.sum(self.data) }

pub fn DslistunrolledEdge::mean(self : DslistunrolledEdge) -> Double { @_common.mean(self.data) }

pub fn DslistunrolledEdge::scale(self : DslistunrolledEdge, f : Double) -> DslistunrolledEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistunrolledEdge::add(self : DslistunrolledEdge, other : DslistunrolledEdge) -> DslistunrolledEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistunrolledEdge::copy(self : DslistunrolledEdge) -> DslistunrolledEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistunrolledEdge::fill(self : DslistunrolledEdge, v : Double) -> DslistunrolledEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistunrolledEdge::min(self : DslistunrolledEdge) -> Double { @_common.min(self.data) }

pub fn DslistunrolledEdge::max(self : DslistunrolledEdge) -> Double { @_common.max(self.data) }

pub fn DslistunrolledEdge::to_string(self : DslistunrolledEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistunrolledPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_path_make(size : Int) -> DslistunrolledPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistunrolledPath::len(self : DslistunrolledPath) -> Int { self.size }

pub fn DslistunrolledPath::get(self : DslistunrolledPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistunrolledPath::set(self : DslistunrolledPath, i : Int, v : Double) -> DslistunrolledPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistunrolledPath::sum(self : DslistunrolledPath) -> Double { @_common.sum(self.data) }

pub fn DslistunrolledPath::mean(self : DslistunrolledPath) -> Double { @_common.mean(self.data) }

pub fn DslistunrolledPath::scale(self : DslistunrolledPath, f : Double) -> DslistunrolledPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistunrolledPath::add(self : DslistunrolledPath, other : DslistunrolledPath) -> DslistunrolledPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistunrolledPath::copy(self : DslistunrolledPath) -> DslistunrolledPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistunrolledPath::fill(self : DslistunrolledPath, v : Double) -> DslistunrolledPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistunrolledPath::min(self : DslistunrolledPath) -> Double { @_common.min(self.data) }

pub fn DslistunrolledPath::max(self : DslistunrolledPath) -> Double { @_common.max(self.data) }

pub fn DslistunrolledPath::to_string(self : DslistunrolledPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistunrolledCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_cluster_make(size : Int) -> DslistunrolledCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistunrolledCluster::len(self : DslistunrolledCluster) -> Int { self.size }

pub fn DslistunrolledCluster::get(self : DslistunrolledCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistunrolledCluster::set(self : DslistunrolledCluster, i : Int, v : Double) -> DslistunrolledCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistunrolledCluster::sum(self : DslistunrolledCluster) -> Double { @_common.sum(self.data) }

pub fn DslistunrolledCluster::mean(self : DslistunrolledCluster) -> Double { @_common.mean(self.data) }

pub fn DslistunrolledCluster::scale(self : DslistunrolledCluster, f : Double) -> DslistunrolledCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistunrolledCluster::add(self : DslistunrolledCluster, other : DslistunrolledCluster) -> DslistunrolledCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistunrolledCluster::copy(self : DslistunrolledCluster) -> DslistunrolledCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistunrolledCluster::fill(self : DslistunrolledCluster, v : Double) -> DslistunrolledCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistunrolledCluster::min(self : DslistunrolledCluster) -> Double { @_common.min(self.data) }

pub fn DslistunrolledCluster::max(self : DslistunrolledCluster) -> Double { @_common.max(self.data) }

pub fn DslistunrolledCluster::to_string(self : DslistunrolledCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistunrolledModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_model_make(size : Int) -> DslistunrolledModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistunrolledModel::len(self : DslistunrolledModel) -> Int { self.size }

pub fn DslistunrolledModel::get(self : DslistunrolledModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistunrolledModel::set(self : DslistunrolledModel, i : Int, v : Double) -> DslistunrolledModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistunrolledModel::sum(self : DslistunrolledModel) -> Double { @_common.sum(self.data) }

pub fn DslistunrolledModel::mean(self : DslistunrolledModel) -> Double { @_common.mean(self.data) }

pub fn DslistunrolledModel::scale(self : DslistunrolledModel, f : Double) -> DslistunrolledModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistunrolledModel::add(self : DslistunrolledModel, other : DslistunrolledModel) -> DslistunrolledModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistunrolledModel::copy(self : DslistunrolledModel) -> DslistunrolledModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistunrolledModel::fill(self : DslistunrolledModel, v : Double) -> DslistunrolledModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistunrolledModel::min(self : DslistunrolledModel) -> Double { @_common.min(self.data) }

pub fn DslistunrolledModel::max(self : DslistunrolledModel) -> Double { @_common.max(self.data) }

pub fn DslistunrolledModel::to_string(self : DslistunrolledModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistunrolledLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_layer_make(size : Int) -> DslistunrolledLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistunrolledLayer::len(self : DslistunrolledLayer) -> Int { self.size }

pub fn DslistunrolledLayer::get(self : DslistunrolledLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistunrolledLayer::set(self : DslistunrolledLayer, i : Int, v : Double) -> DslistunrolledLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistunrolledLayer::sum(self : DslistunrolledLayer) -> Double { @_common.sum(self.data) }

pub fn DslistunrolledLayer::mean(self : DslistunrolledLayer) -> Double { @_common.mean(self.data) }

pub fn DslistunrolledLayer::scale(self : DslistunrolledLayer, f : Double) -> DslistunrolledLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistunrolledLayer::add(self : DslistunrolledLayer, other : DslistunrolledLayer) -> DslistunrolledLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistunrolledLayer::copy(self : DslistunrolledLayer) -> DslistunrolledLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistunrolledLayer::fill(self : DslistunrolledLayer, v : Double) -> DslistunrolledLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistunrolledLayer::min(self : DslistunrolledLayer) -> Double { @_common.min(self.data) }

pub fn DslistunrolledLayer::max(self : DslistunrolledLayer) -> Double { @_common.max(self.data) }

pub fn DslistunrolledLayer::to_string(self : DslistunrolledLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistunrolledBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_buffer_make(size : Int) -> DslistunrolledBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistunrolledBuffer::len(self : DslistunrolledBuffer) -> Int { self.size }

pub fn DslistunrolledBuffer::get(self : DslistunrolledBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistunrolledBuffer::set(self : DslistunrolledBuffer, i : Int, v : Double) -> DslistunrolledBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistunrolledBuffer::sum(self : DslistunrolledBuffer) -> Double { @_common.sum(self.data) }

pub fn DslistunrolledBuffer::mean(self : DslistunrolledBuffer) -> Double { @_common.mean(self.data) }

pub fn DslistunrolledBuffer::scale(self : DslistunrolledBuffer, f : Double) -> DslistunrolledBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistunrolledBuffer::add(self : DslistunrolledBuffer, other : DslistunrolledBuffer) -> DslistunrolledBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistunrolledBuffer::copy(self : DslistunrolledBuffer) -> DslistunrolledBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistunrolledBuffer::fill(self : DslistunrolledBuffer, v : Double) -> DslistunrolledBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistunrolledBuffer::min(self : DslistunrolledBuffer) -> Double { @_common.min(self.data) }

pub fn DslistunrolledBuffer::max(self : DslistunrolledBuffer) -> Double { @_common.max(self.data) }

pub fn DslistunrolledBuffer::to_string(self : DslistunrolledBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistunrolledCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_cursor_make(size : Int) -> DslistunrolledCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistunrolledCursor::len(self : DslistunrolledCursor) -> Int { self.size }

pub fn DslistunrolledCursor::get(self : DslistunrolledCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistunrolledCursor::set(self : DslistunrolledCursor, i : Int, v : Double) -> DslistunrolledCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistunrolledCursor::sum(self : DslistunrolledCursor) -> Double { @_common.sum(self.data) }

pub fn DslistunrolledCursor::mean(self : DslistunrolledCursor) -> Double { @_common.mean(self.data) }

pub fn DslistunrolledCursor::scale(self : DslistunrolledCursor, f : Double) -> DslistunrolledCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistunrolledCursor::add(self : DslistunrolledCursor, other : DslistunrolledCursor) -> DslistunrolledCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistunrolledCursor::copy(self : DslistunrolledCursor) -> DslistunrolledCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistunrolledCursor::fill(self : DslistunrolledCursor, v : Double) -> DslistunrolledCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistunrolledCursor::min(self : DslistunrolledCursor) -> Double { @_common.min(self.data) }

pub fn DslistunrolledCursor::max(self : DslistunrolledCursor) -> Double { @_common.max(self.data) }

pub fn DslistunrolledCursor::to_string(self : DslistunrolledCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistunrolledView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_view_make(size : Int) -> DslistunrolledView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistunrolledView::len(self : DslistunrolledView) -> Int { self.size }

pub fn DslistunrolledView::get(self : DslistunrolledView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistunrolledView::set(self : DslistunrolledView, i : Int, v : Double) -> DslistunrolledView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistunrolledView::sum(self : DslistunrolledView) -> Double { @_common.sum(self.data) }

pub fn DslistunrolledView::mean(self : DslistunrolledView) -> Double { @_common.mean(self.data) }

pub fn DslistunrolledView::scale(self : DslistunrolledView, f : Double) -> DslistunrolledView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistunrolledView::add(self : DslistunrolledView, other : DslistunrolledView) -> DslistunrolledView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistunrolledView::copy(self : DslistunrolledView) -> DslistunrolledView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistunrolledView::fill(self : DslistunrolledView, v : Double) -> DslistunrolledView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistunrolledView::min(self : DslistunrolledView) -> Double { @_common.min(self.data) }

pub fn DslistunrolledView::max(self : DslistunrolledView) -> Double { @_common.max(self.data) }

pub fn DslistunrolledView::to_string(self : DslistunrolledView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistunrolledRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_range_make(size : Int) -> DslistunrolledRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistunrolledRange::len(self : DslistunrolledRange) -> Int { self.size }

pub fn DslistunrolledRange::get(self : DslistunrolledRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistunrolledRange::set(self : DslistunrolledRange, i : Int, v : Double) -> DslistunrolledRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistunrolledRange::sum(self : DslistunrolledRange) -> Double { @_common.sum(self.data) }

pub fn DslistunrolledRange::mean(self : DslistunrolledRange) -> Double { @_common.mean(self.data) }

pub fn DslistunrolledRange::scale(self : DslistunrolledRange, f : Double) -> DslistunrolledRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistunrolledRange::add(self : DslistunrolledRange, other : DslistunrolledRange) -> DslistunrolledRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistunrolledRange::copy(self : DslistunrolledRange) -> DslistunrolledRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistunrolledRange::fill(self : DslistunrolledRange, v : Double) -> DslistunrolledRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistunrolledRange::min(self : DslistunrolledRange) -> Double { @_common.min(self.data) }

pub fn DslistunrolledRange::max(self : DslistunrolledRange) -> Double { @_common.max(self.data) }

pub fn DslistunrolledRange::to_string(self : DslistunrolledRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistunrolledSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_unrolled_slice_make(size : Int) -> DslistunrolledSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistunrolledSlice::len(self : DslistunrolledSlice) -> Int { self.size }

pub fn DslistunrolledSlice::get(self : DslistunrolledSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistunrolledSlice::set(self : DslistunrolledSlice, i : Int, v : Double) -> DslistunrolledSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistunrolledSlice::sum(self : DslistunrolledSlice) -> Double { @_common.sum(self.data) }

pub fn DslistunrolledSlice::mean(self : DslistunrolledSlice) -> Double { @_common.mean(self.data) }

pub fn DslistunrolledSlice::scale(self : DslistunrolledSlice, f : Double) -> DslistunrolledSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistunrolledSlice::add(self : DslistunrolledSlice, other : DslistunrolledSlice) -> DslistunrolledSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistunrolledSlice::copy(self : DslistunrolledSlice) -> DslistunrolledSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistunrolledSlice::fill(self : DslistunrolledSlice, v : Double) -> DslistunrolledSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistunrolledSlice::min(self : DslistunrolledSlice) -> Double { @_common.min(self.data) }

pub fn DslistunrolledSlice::max(self : DslistunrolledSlice) -> Double { @_common.max(self.data) }

pub fn DslistunrolledSlice::to_string(self : DslistunrolledSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

