///===
/// extcore/ds_list_doubly

pub(all) struct DslistdoublyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_doubly_make_point(x : Double, y : Double) -> DslistdoublyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_doubly_make_point3(x : Double, y : Double, z : Double) -> DslistdoublyPoint {
  { x, y, z, label: 0 }
}

pub fn DslistdoublyPoint::x(self : DslistdoublyPoint) -> Double { self.x }

pub fn DslistdoublyPoint::y(self : DslistdoublyPoint) -> Double { self.y }

pub fn DslistdoublyPoint::z(self : DslistdoublyPoint) -> Double { self.z }

pub fn DslistdoublyPoint::label(self : DslistdoublyPoint) -> Int { self.label }

pub fn DslistdoublyPoint::dist(self : DslistdoublyPoint, other : DslistdoublyPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistdoublyPoint::add(self : DslistdoublyPoint, other : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistdoublyPoint::sub(self : DslistdoublyPoint, other : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistdoublyPoint::scale(self : DslistdoublyPoint, s : Double) -> DslistdoublyPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistdoublyPoint::dot(self : DslistdoublyPoint, other : DslistdoublyPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistdoublyPoint::cross(self : DslistdoublyPoint, other : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistdoublyPoint::norm(self : DslistdoublyPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistdoublyPoint::normalize(self : DslistdoublyPoint) -> DslistdoublyPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistdoublyPoint::negate(self : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistdoublyPoint::mid(self : DslistdoublyPoint, other : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistdoublyPoint::lerp(self : DslistdoublyPoint, other : DslistdoublyPoint, t : Double) -> DslistdoublyPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistdoublyPoint::to_string(self : DslistdoublyPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistdoublySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_doubly_make_series(vals : Array[Double], name : String) -> DslistdoublySeries {
  { vals, name, meta: 0 }
}

pub fn DslistdoublySeries::len(self : DslistdoublySeries) -> Int { self.vals.length() }

pub fn DslistdoublySeries::sum(self : DslistdoublySeries) -> Double { @_common.sum(self.vals) }

pub fn DslistdoublySeries::mean(self : DslistdoublySeries) -> Double { @_common.mean(self.vals) }

pub fn DslistdoublySeries::min(self : DslistdoublySeries) -> Double { @_common.min(self.vals) }

pub fn DslistdoublySeries::max(self : DslistdoublySeries) -> Double { @_common.max(self.vals) }

pub fn DslistdoublySeries::range(self : DslistdoublySeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistdoublySeries::variance(self : DslistdoublySeries) -> Double { @_common.variance(self.vals) }

pub fn DslistdoublySeries::std(self : DslistdoublySeries) -> Double { @_common.std(self.vals) }

pub fn DslistdoublySeries::median(self : DslistdoublySeries) -> Double { @_common.median(self.vals) }

pub fn DslistdoublySeries::scale(self : DslistdoublySeries, f : Double) -> DslistdoublySeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistdoublySeries::add(self : DslistdoublySeries, other : DslistdoublySeries) -> DslistdoublySeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistdoublySeries::sub(self : DslistdoublySeries, other : DslistdoublySeries) -> DslistdoublySeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistdoublySeries::normalize(self : DslistdoublySeries) -> DslistdoublySeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistdoublySeries::cumsum(self : DslistdoublySeries) -> DslistdoublySeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistdoublySeries::to_string(self : DslistdoublySeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistdoublyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_doubly_make_matrix(rows : Int, cols : Int, val : Double) -> DslistdoublyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_doubly_matrix_identity(n : Int) -> DslistdoublyMatrix {
  let m = ds_list_doubly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistdoublyMatrix::get(self : DslistdoublyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistdoublyMatrix::transpose(self : DslistdoublyMatrix) -> DslistdoublyMatrix {
  let result = ds_list_doubly_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistdoublyMatrix::add(self : DslistdoublyMatrix, other : DslistdoublyMatrix) -> DslistdoublyMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_doubly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistdoublyMatrix::scale(self : DslistdoublyMatrix, s : Double) -> DslistdoublyMatrix {
  let result = ds_list_doubly_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistdoublyMatrix::multiply(self : DslistdoublyMatrix, other : DslistdoublyMatrix) -> DslistdoublyMatrix {
  if self.cols != other.rows { return ds_list_doubly_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_doubly_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistdoublyMatrix::trace(self : DslistdoublyMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistdoublyMatrix::det(self : DslistdoublyMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistdoublyMatrix::norm(self : DslistdoublyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistdoublyMatrix::to_string(self : DslistdoublyMatrix) -> String {
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

pub(all) struct DslistdoublyVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_doubly_make_vector(comps : Array[Double]) -> DslistdoublyVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_doubly_vector_zero(dim : Int) -> DslistdoublyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistdoublyVector::add(self : DslistdoublyVector, other : DslistdoublyVector) -> DslistdoublyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistdoublyVector::sub(self : DslistdoublyVector, other : DslistdoublyVector) -> DslistdoublyVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistdoublyVector::scale(self : DslistdoublyVector, s : Double) -> DslistdoublyVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistdoublyVector::dot(self : DslistdoublyVector, other : DslistdoublyVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistdoublyVector::norm(self : DslistdoublyVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistdoublyVector::normalize(self : DslistdoublyVector) -> DslistdoublyVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistdoublyVector::dist(self : DslistdoublyVector, other : DslistdoublyVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistdoublyVector::to_string(self : DslistdoublyVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_doubly_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_doubly_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_doubly_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_doubly_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_doubly_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_doubly_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_doubly_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_doubly_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_doubly_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_doubly_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_doubly_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_doubly_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_doubly_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_doubly_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_doubly_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_doubly_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_doubly_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_doubly_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_doubly_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_doubly_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_doubly_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_doubly_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_doubly_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_doubly_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_doubly_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_doubly_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_doubly_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_doubly_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_doubly_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistdoublyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_frame_make(size : Int) -> DslistdoublyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistdoublyFrame::len(self : DslistdoublyFrame) -> Int { self.size }

pub fn DslistdoublyFrame::get(self : DslistdoublyFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistdoublyFrame::set(self : DslistdoublyFrame, i : Int, v : Double) -> DslistdoublyFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistdoublyFrame::sum(self : DslistdoublyFrame) -> Double { @_common.sum(self.data) }

pub fn DslistdoublyFrame::mean(self : DslistdoublyFrame) -> Double { @_common.mean(self.data) }

pub fn DslistdoublyFrame::scale(self : DslistdoublyFrame, f : Double) -> DslistdoublyFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistdoublyFrame::add(self : DslistdoublyFrame, other : DslistdoublyFrame) -> DslistdoublyFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistdoublyFrame::copy(self : DslistdoublyFrame) -> DslistdoublyFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistdoublyFrame::fill(self : DslistdoublyFrame, v : Double) -> DslistdoublyFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistdoublyFrame::min(self : DslistdoublyFrame) -> Double { @_common.min(self.data) }

pub fn DslistdoublyFrame::max(self : DslistdoublyFrame) -> Double { @_common.max(self.data) }

pub fn DslistdoublyFrame::to_string(self : DslistdoublyFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistdoublyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_table_make(size : Int) -> DslistdoublyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistdoublyTable::len(self : DslistdoublyTable) -> Int { self.size }

pub fn DslistdoublyTable::get(self : DslistdoublyTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistdoublyTable::set(self : DslistdoublyTable, i : Int, v : Double) -> DslistdoublyTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistdoublyTable::sum(self : DslistdoublyTable) -> Double { @_common.sum(self.data) }

pub fn DslistdoublyTable::mean(self : DslistdoublyTable) -> Double { @_common.mean(self.data) }

pub fn DslistdoublyTable::scale(self : DslistdoublyTable, f : Double) -> DslistdoublyTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistdoublyTable::add(self : DslistdoublyTable, other : DslistdoublyTable) -> DslistdoublyTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistdoublyTable::copy(self : DslistdoublyTable) -> DslistdoublyTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistdoublyTable::fill(self : DslistdoublyTable, v : Double) -> DslistdoublyTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistdoublyTable::min(self : DslistdoublyTable) -> Double { @_common.min(self.data) }

pub fn DslistdoublyTable::max(self : DslistdoublyTable) -> Double { @_common.max(self.data) }

pub fn DslistdoublyTable::to_string(self : DslistdoublyTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistdoublyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_graphn_make(size : Int) -> DslistdoublyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistdoublyGraphN::len(self : DslistdoublyGraphN) -> Int { self.size }

pub fn DslistdoublyGraphN::get(self : DslistdoublyGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistdoublyGraphN::set(self : DslistdoublyGraphN, i : Int, v : Double) -> DslistdoublyGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistdoublyGraphN::sum(self : DslistdoublyGraphN) -> Double { @_common.sum(self.data) }

pub fn DslistdoublyGraphN::mean(self : DslistdoublyGraphN) -> Double { @_common.mean(self.data) }

pub fn DslistdoublyGraphN::scale(self : DslistdoublyGraphN, f : Double) -> DslistdoublyGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistdoublyGraphN::add(self : DslistdoublyGraphN, other : DslistdoublyGraphN) -> DslistdoublyGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistdoublyGraphN::copy(self : DslistdoublyGraphN) -> DslistdoublyGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistdoublyGraphN::fill(self : DslistdoublyGraphN, v : Double) -> DslistdoublyGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistdoublyGraphN::min(self : DslistdoublyGraphN) -> Double { @_common.min(self.data) }

pub fn DslistdoublyGraphN::max(self : DslistdoublyGraphN) -> Double { @_common.max(self.data) }

pub fn DslistdoublyGraphN::to_string(self : DslistdoublyGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistdoublyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_node_make(size : Int) -> DslistdoublyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistdoublyNode::len(self : DslistdoublyNode) -> Int { self.size }

pub fn DslistdoublyNode::get(self : DslistdoublyNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistdoublyNode::set(self : DslistdoublyNode, i : Int, v : Double) -> DslistdoublyNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistdoublyNode::sum(self : DslistdoublyNode) -> Double { @_common.sum(self.data) }

pub fn DslistdoublyNode::mean(self : DslistdoublyNode) -> Double { @_common.mean(self.data) }

pub fn DslistdoublyNode::scale(self : DslistdoublyNode, f : Double) -> DslistdoublyNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistdoublyNode::add(self : DslistdoublyNode, other : DslistdoublyNode) -> DslistdoublyNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistdoublyNode::copy(self : DslistdoublyNode) -> DslistdoublyNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistdoublyNode::fill(self : DslistdoublyNode, v : Double) -> DslistdoublyNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistdoublyNode::min(self : DslistdoublyNode) -> Double { @_common.min(self.data) }

pub fn DslistdoublyNode::max(self : DslistdoublyNode) -> Double { @_common.max(self.data) }

pub fn DslistdoublyNode::to_string(self : DslistdoublyNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistdoublyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_edge_make(size : Int) -> DslistdoublyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistdoublyEdge::len(self : DslistdoublyEdge) -> Int { self.size }

pub fn DslistdoublyEdge::get(self : DslistdoublyEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistdoublyEdge::set(self : DslistdoublyEdge, i : Int, v : Double) -> DslistdoublyEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistdoublyEdge::sum(self : DslistdoublyEdge) -> Double { @_common.sum(self.data) }

pub fn DslistdoublyEdge::mean(self : DslistdoublyEdge) -> Double { @_common.mean(self.data) }

pub fn DslistdoublyEdge::scale(self : DslistdoublyEdge, f : Double) -> DslistdoublyEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistdoublyEdge::add(self : DslistdoublyEdge, other : DslistdoublyEdge) -> DslistdoublyEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistdoublyEdge::copy(self : DslistdoublyEdge) -> DslistdoublyEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistdoublyEdge::fill(self : DslistdoublyEdge, v : Double) -> DslistdoublyEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistdoublyEdge::min(self : DslistdoublyEdge) -> Double { @_common.min(self.data) }

pub fn DslistdoublyEdge::max(self : DslistdoublyEdge) -> Double { @_common.max(self.data) }

pub fn DslistdoublyEdge::to_string(self : DslistdoublyEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistdoublyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_path_make(size : Int) -> DslistdoublyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistdoublyPath::len(self : DslistdoublyPath) -> Int { self.size }

pub fn DslistdoublyPath::get(self : DslistdoublyPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistdoublyPath::set(self : DslistdoublyPath, i : Int, v : Double) -> DslistdoublyPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistdoublyPath::sum(self : DslistdoublyPath) -> Double { @_common.sum(self.data) }

pub fn DslistdoublyPath::mean(self : DslistdoublyPath) -> Double { @_common.mean(self.data) }

pub fn DslistdoublyPath::scale(self : DslistdoublyPath, f : Double) -> DslistdoublyPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistdoublyPath::add(self : DslistdoublyPath, other : DslistdoublyPath) -> DslistdoublyPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistdoublyPath::copy(self : DslistdoublyPath) -> DslistdoublyPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistdoublyPath::fill(self : DslistdoublyPath, v : Double) -> DslistdoublyPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistdoublyPath::min(self : DslistdoublyPath) -> Double { @_common.min(self.data) }

pub fn DslistdoublyPath::max(self : DslistdoublyPath) -> Double { @_common.max(self.data) }

pub fn DslistdoublyPath::to_string(self : DslistdoublyPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistdoublyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_cluster_make(size : Int) -> DslistdoublyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistdoublyCluster::len(self : DslistdoublyCluster) -> Int { self.size }

pub fn DslistdoublyCluster::get(self : DslistdoublyCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistdoublyCluster::set(self : DslistdoublyCluster, i : Int, v : Double) -> DslistdoublyCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistdoublyCluster::sum(self : DslistdoublyCluster) -> Double { @_common.sum(self.data) }

pub fn DslistdoublyCluster::mean(self : DslistdoublyCluster) -> Double { @_common.mean(self.data) }

pub fn DslistdoublyCluster::scale(self : DslistdoublyCluster, f : Double) -> DslistdoublyCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistdoublyCluster::add(self : DslistdoublyCluster, other : DslistdoublyCluster) -> DslistdoublyCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistdoublyCluster::copy(self : DslistdoublyCluster) -> DslistdoublyCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistdoublyCluster::fill(self : DslistdoublyCluster, v : Double) -> DslistdoublyCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistdoublyCluster::min(self : DslistdoublyCluster) -> Double { @_common.min(self.data) }

pub fn DslistdoublyCluster::max(self : DslistdoublyCluster) -> Double { @_common.max(self.data) }

pub fn DslistdoublyCluster::to_string(self : DslistdoublyCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistdoublyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_model_make(size : Int) -> DslistdoublyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistdoublyModel::len(self : DslistdoublyModel) -> Int { self.size }

pub fn DslistdoublyModel::get(self : DslistdoublyModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistdoublyModel::set(self : DslistdoublyModel, i : Int, v : Double) -> DslistdoublyModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistdoublyModel::sum(self : DslistdoublyModel) -> Double { @_common.sum(self.data) }

pub fn DslistdoublyModel::mean(self : DslistdoublyModel) -> Double { @_common.mean(self.data) }

pub fn DslistdoublyModel::scale(self : DslistdoublyModel, f : Double) -> DslistdoublyModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistdoublyModel::add(self : DslistdoublyModel, other : DslistdoublyModel) -> DslistdoublyModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistdoublyModel::copy(self : DslistdoublyModel) -> DslistdoublyModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistdoublyModel::fill(self : DslistdoublyModel, v : Double) -> DslistdoublyModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistdoublyModel::min(self : DslistdoublyModel) -> Double { @_common.min(self.data) }

pub fn DslistdoublyModel::max(self : DslistdoublyModel) -> Double { @_common.max(self.data) }

pub fn DslistdoublyModel::to_string(self : DslistdoublyModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistdoublyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_layer_make(size : Int) -> DslistdoublyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistdoublyLayer::len(self : DslistdoublyLayer) -> Int { self.size }

pub fn DslistdoublyLayer::get(self : DslistdoublyLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistdoublyLayer::set(self : DslistdoublyLayer, i : Int, v : Double) -> DslistdoublyLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistdoublyLayer::sum(self : DslistdoublyLayer) -> Double { @_common.sum(self.data) }

pub fn DslistdoublyLayer::mean(self : DslistdoublyLayer) -> Double { @_common.mean(self.data) }

pub fn DslistdoublyLayer::scale(self : DslistdoublyLayer, f : Double) -> DslistdoublyLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistdoublyLayer::add(self : DslistdoublyLayer, other : DslistdoublyLayer) -> DslistdoublyLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistdoublyLayer::copy(self : DslistdoublyLayer) -> DslistdoublyLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistdoublyLayer::fill(self : DslistdoublyLayer, v : Double) -> DslistdoublyLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistdoublyLayer::min(self : DslistdoublyLayer) -> Double { @_common.min(self.data) }

pub fn DslistdoublyLayer::max(self : DslistdoublyLayer) -> Double { @_common.max(self.data) }

pub fn DslistdoublyLayer::to_string(self : DslistdoublyLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistdoublyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_buffer_make(size : Int) -> DslistdoublyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistdoublyBuffer::len(self : DslistdoublyBuffer) -> Int { self.size }

pub fn DslistdoublyBuffer::get(self : DslistdoublyBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistdoublyBuffer::set(self : DslistdoublyBuffer, i : Int, v : Double) -> DslistdoublyBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistdoublyBuffer::sum(self : DslistdoublyBuffer) -> Double { @_common.sum(self.data) }

pub fn DslistdoublyBuffer::mean(self : DslistdoublyBuffer) -> Double { @_common.mean(self.data) }

pub fn DslistdoublyBuffer::scale(self : DslistdoublyBuffer, f : Double) -> DslistdoublyBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistdoublyBuffer::add(self : DslistdoublyBuffer, other : DslistdoublyBuffer) -> DslistdoublyBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistdoublyBuffer::copy(self : DslistdoublyBuffer) -> DslistdoublyBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistdoublyBuffer::fill(self : DslistdoublyBuffer, v : Double) -> DslistdoublyBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistdoublyBuffer::min(self : DslistdoublyBuffer) -> Double { @_common.min(self.data) }

pub fn DslistdoublyBuffer::max(self : DslistdoublyBuffer) -> Double { @_common.max(self.data) }

pub fn DslistdoublyBuffer::to_string(self : DslistdoublyBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistdoublyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_cursor_make(size : Int) -> DslistdoublyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistdoublyCursor::len(self : DslistdoublyCursor) -> Int { self.size }

pub fn DslistdoublyCursor::get(self : DslistdoublyCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistdoublyCursor::set(self : DslistdoublyCursor, i : Int, v : Double) -> DslistdoublyCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistdoublyCursor::sum(self : DslistdoublyCursor) -> Double { @_common.sum(self.data) }

pub fn DslistdoublyCursor::mean(self : DslistdoublyCursor) -> Double { @_common.mean(self.data) }

pub fn DslistdoublyCursor::scale(self : DslistdoublyCursor, f : Double) -> DslistdoublyCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistdoublyCursor::add(self : DslistdoublyCursor, other : DslistdoublyCursor) -> DslistdoublyCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistdoublyCursor::copy(self : DslistdoublyCursor) -> DslistdoublyCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistdoublyCursor::fill(self : DslistdoublyCursor, v : Double) -> DslistdoublyCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistdoublyCursor::min(self : DslistdoublyCursor) -> Double { @_common.min(self.data) }

pub fn DslistdoublyCursor::max(self : DslistdoublyCursor) -> Double { @_common.max(self.data) }

pub fn DslistdoublyCursor::to_string(self : DslistdoublyCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistdoublyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_view_make(size : Int) -> DslistdoublyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistdoublyView::len(self : DslistdoublyView) -> Int { self.size }

pub fn DslistdoublyView::get(self : DslistdoublyView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistdoublyView::set(self : DslistdoublyView, i : Int, v : Double) -> DslistdoublyView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistdoublyView::sum(self : DslistdoublyView) -> Double { @_common.sum(self.data) }

pub fn DslistdoublyView::mean(self : DslistdoublyView) -> Double { @_common.mean(self.data) }

pub fn DslistdoublyView::scale(self : DslistdoublyView, f : Double) -> DslistdoublyView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistdoublyView::add(self : DslistdoublyView, other : DslistdoublyView) -> DslistdoublyView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistdoublyView::copy(self : DslistdoublyView) -> DslistdoublyView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistdoublyView::fill(self : DslistdoublyView, v : Double) -> DslistdoublyView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistdoublyView::min(self : DslistdoublyView) -> Double { @_common.min(self.data) }

pub fn DslistdoublyView::max(self : DslistdoublyView) -> Double { @_common.max(self.data) }

pub fn DslistdoublyView::to_string(self : DslistdoublyView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistdoublyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_range_make(size : Int) -> DslistdoublyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistdoublyRange::len(self : DslistdoublyRange) -> Int { self.size }

pub fn DslistdoublyRange::get(self : DslistdoublyRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistdoublyRange::set(self : DslistdoublyRange, i : Int, v : Double) -> DslistdoublyRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistdoublyRange::sum(self : DslistdoublyRange) -> Double { @_common.sum(self.data) }

pub fn DslistdoublyRange::mean(self : DslistdoublyRange) -> Double { @_common.mean(self.data) }

pub fn DslistdoublyRange::scale(self : DslistdoublyRange, f : Double) -> DslistdoublyRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistdoublyRange::add(self : DslistdoublyRange, other : DslistdoublyRange) -> DslistdoublyRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistdoublyRange::copy(self : DslistdoublyRange) -> DslistdoublyRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistdoublyRange::fill(self : DslistdoublyRange, v : Double) -> DslistdoublyRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistdoublyRange::min(self : DslistdoublyRange) -> Double { @_common.min(self.data) }

pub fn DslistdoublyRange::max(self : DslistdoublyRange) -> Double { @_common.max(self.data) }

pub fn DslistdoublyRange::to_string(self : DslistdoublyRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistdoublySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_slice_make(size : Int) -> DslistdoublySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistdoublySlice::len(self : DslistdoublySlice) -> Int { self.size }

pub fn DslistdoublySlice::get(self : DslistdoublySlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistdoublySlice::set(self : DslistdoublySlice, i : Int, v : Double) -> DslistdoublySlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistdoublySlice::sum(self : DslistdoublySlice) -> Double { @_common.sum(self.data) }

pub fn DslistdoublySlice::mean(self : DslistdoublySlice) -> Double { @_common.mean(self.data) }

pub fn DslistdoublySlice::scale(self : DslistdoublySlice, f : Double) -> DslistdoublySlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistdoublySlice::add(self : DslistdoublySlice, other : DslistdoublySlice) -> DslistdoublySlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistdoublySlice::copy(self : DslistdoublySlice) -> DslistdoublySlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistdoublySlice::fill(self : DslistdoublySlice, v : Double) -> DslistdoublySlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistdoublySlice::min(self : DslistdoublySlice) -> Double { @_common.min(self.data) }

pub fn DslistdoublySlice::max(self : DslistdoublySlice) -> Double { @_common.max(self.data) }

pub fn DslistdoublySlice::to_string(self : DslistdoublySlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

