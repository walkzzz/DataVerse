///===
/// extcore/ds_list_persistent

pub(all) struct DslistpersistentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_persistent_make_point(x : Double, y : Double) -> DslistpersistentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_persistent_make_point3(x : Double, y : Double, z : Double) -> DslistpersistentPoint {
  { x, y, z, label: 0 }
}

pub fn DslistpersistentPoint::x(self : DslistpersistentPoint) -> Double { self.x }

pub fn DslistpersistentPoint::y(self : DslistpersistentPoint) -> Double { self.y }

pub fn DslistpersistentPoint::z(self : DslistpersistentPoint) -> Double { self.z }

pub fn DslistpersistentPoint::label(self : DslistpersistentPoint) -> Int { self.label }

pub fn DslistpersistentPoint::dist(self : DslistpersistentPoint, other : DslistpersistentPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn DslistpersistentPoint::add(self : DslistpersistentPoint, other : DslistpersistentPoint) -> DslistpersistentPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn DslistpersistentPoint::sub(self : DslistpersistentPoint, other : DslistpersistentPoint) -> DslistpersistentPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn DslistpersistentPoint::scale(self : DslistpersistentPoint, s : Double) -> DslistpersistentPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn DslistpersistentPoint::dot(self : DslistpersistentPoint, other : DslistpersistentPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn DslistpersistentPoint::cross(self : DslistpersistentPoint, other : DslistpersistentPoint) -> DslistpersistentPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn DslistpersistentPoint::norm(self : DslistpersistentPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn DslistpersistentPoint::normalize(self : DslistpersistentPoint) -> DslistpersistentPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistpersistentPoint::negate(self : DslistpersistentPoint) -> DslistpersistentPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn DslistpersistentPoint::mid(self : DslistpersistentPoint, other : DslistpersistentPoint) -> DslistpersistentPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn DslistpersistentPoint::lerp(self : DslistpersistentPoint, other : DslistpersistentPoint, t : Double) -> DslistpersistentPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn DslistpersistentPoint::to_string(self : DslistpersistentPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct DslistpersistentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_persistent_make_series(vals : Array[Double], name : String) -> DslistpersistentSeries {
  { vals, name, meta: 0 }
}

pub fn DslistpersistentSeries::len(self : DslistpersistentSeries) -> Int { self.vals.length() }

pub fn DslistpersistentSeries::sum(self : DslistpersistentSeries) -> Double { @_common.sum(self.vals) }

pub fn DslistpersistentSeries::mean(self : DslistpersistentSeries) -> Double { @_common.mean(self.vals) }

pub fn DslistpersistentSeries::min(self : DslistpersistentSeries) -> Double { @_common.min(self.vals) }

pub fn DslistpersistentSeries::max(self : DslistpersistentSeries) -> Double { @_common.max(self.vals) }

pub fn DslistpersistentSeries::range(self : DslistpersistentSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn DslistpersistentSeries::variance(self : DslistpersistentSeries) -> Double { @_common.variance(self.vals) }

pub fn DslistpersistentSeries::std(self : DslistpersistentSeries) -> Double { @_common.std(self.vals) }

pub fn DslistpersistentSeries::median(self : DslistpersistentSeries) -> Double { @_common.median(self.vals) }

pub fn DslistpersistentSeries::scale(self : DslistpersistentSeries, f : Double) -> DslistpersistentSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn DslistpersistentSeries::add(self : DslistpersistentSeries, other : DslistpersistentSeries) -> DslistpersistentSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn DslistpersistentSeries::sub(self : DslistpersistentSeries, other : DslistpersistentSeries) -> DslistpersistentSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn DslistpersistentSeries::normalize(self : DslistpersistentSeries) -> DslistpersistentSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn DslistpersistentSeries::cumsum(self : DslistpersistentSeries) -> DslistpersistentSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn DslistpersistentSeries::to_string(self : DslistpersistentSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistpersistentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_persistent_make_matrix(rows : Int, cols : Int, val : Double) -> DslistpersistentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_persistent_matrix_identity(n : Int) -> DslistpersistentMatrix {
  let m = ds_list_persistent_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn DslistpersistentMatrix::get(self : DslistpersistentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn DslistpersistentMatrix::transpose(self : DslistpersistentMatrix) -> DslistpersistentMatrix {
  let result = ds_list_persistent_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn DslistpersistentMatrix::add(self : DslistpersistentMatrix, other : DslistpersistentMatrix) -> DslistpersistentMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = ds_list_persistent_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn DslistpersistentMatrix::scale(self : DslistpersistentMatrix, s : Double) -> DslistpersistentMatrix {
  let result = ds_list_persistent_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn DslistpersistentMatrix::multiply(self : DslistpersistentMatrix, other : DslistpersistentMatrix) -> DslistpersistentMatrix {
  if self.cols != other.rows { return ds_list_persistent_make_matrix(self.rows, other.cols, 0.0) }
  let result = ds_list_persistent_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn DslistpersistentMatrix::trace(self : DslistpersistentMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn DslistpersistentMatrix::det(self : DslistpersistentMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn DslistpersistentMatrix::norm(self : DslistpersistentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn DslistpersistentMatrix::to_string(self : DslistpersistentMatrix) -> String {
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

pub(all) struct DslistpersistentVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_persistent_make_vector(comps : Array[Double]) -> DslistpersistentVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_persistent_vector_zero(dim : Int) -> DslistpersistentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn DslistpersistentVector::add(self : DslistpersistentVector, other : DslistpersistentVector) -> DslistpersistentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn DslistpersistentVector::sub(self : DslistpersistentVector, other : DslistpersistentVector) -> DslistpersistentVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn DslistpersistentVector::scale(self : DslistpersistentVector, s : Double) -> DslistpersistentVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn DslistpersistentVector::dot(self : DslistpersistentVector, other : DslistpersistentVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn DslistpersistentVector::norm(self : DslistpersistentVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn DslistpersistentVector::normalize(self : DslistpersistentVector) -> DslistpersistentVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn DslistpersistentVector::dist(self : DslistpersistentVector, other : DslistpersistentVector) -> Double {
  self.sub(other).norm()
}

pub fn DslistpersistentVector::to_string(self : DslistpersistentVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_persistent_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn ds_list_persistent_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn ds_list_persistent_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn ds_list_persistent_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn ds_list_persistent_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn ds_list_persistent_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn ds_list_persistent_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn ds_list_persistent_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn ds_list_persistent_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn ds_list_persistent_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn ds_list_persistent_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn ds_list_persistent_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn ds_list_persistent_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn ds_list_persistent_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn ds_list_persistent_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn ds_list_persistent_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn ds_list_persistent_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn ds_list_persistent_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn ds_list_persistent_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn ds_list_persistent_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn ds_list_persistent_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn ds_list_persistent_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn ds_list_persistent_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn ds_list_persistent_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn ds_list_persistent_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn ds_list_persistent_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn ds_list_persistent_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn ds_list_persistent_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn ds_list_persistent_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct DslistpersistentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_frame_make(size : Int) -> DslistpersistentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistpersistentFrame::len(self : DslistpersistentFrame) -> Int { self.size }

pub fn DslistpersistentFrame::get(self : DslistpersistentFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistpersistentFrame::set(self : DslistpersistentFrame, i : Int, v : Double) -> DslistpersistentFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistpersistentFrame::sum(self : DslistpersistentFrame) -> Double { @_common.sum(self.data) }

pub fn DslistpersistentFrame::mean(self : DslistpersistentFrame) -> Double { @_common.mean(self.data) }

pub fn DslistpersistentFrame::scale(self : DslistpersistentFrame, f : Double) -> DslistpersistentFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistpersistentFrame::add(self : DslistpersistentFrame, other : DslistpersistentFrame) -> DslistpersistentFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistpersistentFrame::copy(self : DslistpersistentFrame) -> DslistpersistentFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistpersistentFrame::fill(self : DslistpersistentFrame, v : Double) -> DslistpersistentFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistpersistentFrame::min(self : DslistpersistentFrame) -> Double { @_common.min(self.data) }

pub fn DslistpersistentFrame::max(self : DslistpersistentFrame) -> Double { @_common.max(self.data) }

pub fn DslistpersistentFrame::to_string(self : DslistpersistentFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistpersistentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_table_make(size : Int) -> DslistpersistentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistpersistentTable::len(self : DslistpersistentTable) -> Int { self.size }

pub fn DslistpersistentTable::get(self : DslistpersistentTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistpersistentTable::set(self : DslistpersistentTable, i : Int, v : Double) -> DslistpersistentTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistpersistentTable::sum(self : DslistpersistentTable) -> Double { @_common.sum(self.data) }

pub fn DslistpersistentTable::mean(self : DslistpersistentTable) -> Double { @_common.mean(self.data) }

pub fn DslistpersistentTable::scale(self : DslistpersistentTable, f : Double) -> DslistpersistentTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistpersistentTable::add(self : DslistpersistentTable, other : DslistpersistentTable) -> DslistpersistentTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistpersistentTable::copy(self : DslistpersistentTable) -> DslistpersistentTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistpersistentTable::fill(self : DslistpersistentTable, v : Double) -> DslistpersistentTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistpersistentTable::min(self : DslistpersistentTable) -> Double { @_common.min(self.data) }

pub fn DslistpersistentTable::max(self : DslistpersistentTable) -> Double { @_common.max(self.data) }

pub fn DslistpersistentTable::to_string(self : DslistpersistentTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistpersistentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_graphn_make(size : Int) -> DslistpersistentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistpersistentGraphN::len(self : DslistpersistentGraphN) -> Int { self.size }

pub fn DslistpersistentGraphN::get(self : DslistpersistentGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistpersistentGraphN::set(self : DslistpersistentGraphN, i : Int, v : Double) -> DslistpersistentGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistpersistentGraphN::sum(self : DslistpersistentGraphN) -> Double { @_common.sum(self.data) }

pub fn DslistpersistentGraphN::mean(self : DslistpersistentGraphN) -> Double { @_common.mean(self.data) }

pub fn DslistpersistentGraphN::scale(self : DslistpersistentGraphN, f : Double) -> DslistpersistentGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistpersistentGraphN::add(self : DslistpersistentGraphN, other : DslistpersistentGraphN) -> DslistpersistentGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistpersistentGraphN::copy(self : DslistpersistentGraphN) -> DslistpersistentGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistpersistentGraphN::fill(self : DslistpersistentGraphN, v : Double) -> DslistpersistentGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistpersistentGraphN::min(self : DslistpersistentGraphN) -> Double { @_common.min(self.data) }

pub fn DslistpersistentGraphN::max(self : DslistpersistentGraphN) -> Double { @_common.max(self.data) }

pub fn DslistpersistentGraphN::to_string(self : DslistpersistentGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistpersistentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_node_make(size : Int) -> DslistpersistentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistpersistentNode::len(self : DslistpersistentNode) -> Int { self.size }

pub fn DslistpersistentNode::get(self : DslistpersistentNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistpersistentNode::set(self : DslistpersistentNode, i : Int, v : Double) -> DslistpersistentNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistpersistentNode::sum(self : DslistpersistentNode) -> Double { @_common.sum(self.data) }

pub fn DslistpersistentNode::mean(self : DslistpersistentNode) -> Double { @_common.mean(self.data) }

pub fn DslistpersistentNode::scale(self : DslistpersistentNode, f : Double) -> DslistpersistentNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistpersistentNode::add(self : DslistpersistentNode, other : DslistpersistentNode) -> DslistpersistentNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistpersistentNode::copy(self : DslistpersistentNode) -> DslistpersistentNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistpersistentNode::fill(self : DslistpersistentNode, v : Double) -> DslistpersistentNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistpersistentNode::min(self : DslistpersistentNode) -> Double { @_common.min(self.data) }

pub fn DslistpersistentNode::max(self : DslistpersistentNode) -> Double { @_common.max(self.data) }

pub fn DslistpersistentNode::to_string(self : DslistpersistentNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistpersistentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_edge_make(size : Int) -> DslistpersistentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistpersistentEdge::len(self : DslistpersistentEdge) -> Int { self.size }

pub fn DslistpersistentEdge::get(self : DslistpersistentEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistpersistentEdge::set(self : DslistpersistentEdge, i : Int, v : Double) -> DslistpersistentEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistpersistentEdge::sum(self : DslistpersistentEdge) -> Double { @_common.sum(self.data) }

pub fn DslistpersistentEdge::mean(self : DslistpersistentEdge) -> Double { @_common.mean(self.data) }

pub fn DslistpersistentEdge::scale(self : DslistpersistentEdge, f : Double) -> DslistpersistentEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistpersistentEdge::add(self : DslistpersistentEdge, other : DslistpersistentEdge) -> DslistpersistentEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistpersistentEdge::copy(self : DslistpersistentEdge) -> DslistpersistentEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistpersistentEdge::fill(self : DslistpersistentEdge, v : Double) -> DslistpersistentEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistpersistentEdge::min(self : DslistpersistentEdge) -> Double { @_common.min(self.data) }

pub fn DslistpersistentEdge::max(self : DslistpersistentEdge) -> Double { @_common.max(self.data) }

pub fn DslistpersistentEdge::to_string(self : DslistpersistentEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistpersistentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_path_make(size : Int) -> DslistpersistentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistpersistentPath::len(self : DslistpersistentPath) -> Int { self.size }

pub fn DslistpersistentPath::get(self : DslistpersistentPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistpersistentPath::set(self : DslistpersistentPath, i : Int, v : Double) -> DslistpersistentPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistpersistentPath::sum(self : DslistpersistentPath) -> Double { @_common.sum(self.data) }

pub fn DslistpersistentPath::mean(self : DslistpersistentPath) -> Double { @_common.mean(self.data) }

pub fn DslistpersistentPath::scale(self : DslistpersistentPath, f : Double) -> DslistpersistentPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistpersistentPath::add(self : DslistpersistentPath, other : DslistpersistentPath) -> DslistpersistentPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistpersistentPath::copy(self : DslistpersistentPath) -> DslistpersistentPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistpersistentPath::fill(self : DslistpersistentPath, v : Double) -> DslistpersistentPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistpersistentPath::min(self : DslistpersistentPath) -> Double { @_common.min(self.data) }

pub fn DslistpersistentPath::max(self : DslistpersistentPath) -> Double { @_common.max(self.data) }

pub fn DslistpersistentPath::to_string(self : DslistpersistentPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistpersistentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_cluster_make(size : Int) -> DslistpersistentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistpersistentCluster::len(self : DslistpersistentCluster) -> Int { self.size }

pub fn DslistpersistentCluster::get(self : DslistpersistentCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistpersistentCluster::set(self : DslistpersistentCluster, i : Int, v : Double) -> DslistpersistentCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistpersistentCluster::sum(self : DslistpersistentCluster) -> Double { @_common.sum(self.data) }

pub fn DslistpersistentCluster::mean(self : DslistpersistentCluster) -> Double { @_common.mean(self.data) }

pub fn DslistpersistentCluster::scale(self : DslistpersistentCluster, f : Double) -> DslistpersistentCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistpersistentCluster::add(self : DslistpersistentCluster, other : DslistpersistentCluster) -> DslistpersistentCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistpersistentCluster::copy(self : DslistpersistentCluster) -> DslistpersistentCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistpersistentCluster::fill(self : DslistpersistentCluster, v : Double) -> DslistpersistentCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistpersistentCluster::min(self : DslistpersistentCluster) -> Double { @_common.min(self.data) }

pub fn DslistpersistentCluster::max(self : DslistpersistentCluster) -> Double { @_common.max(self.data) }

pub fn DslistpersistentCluster::to_string(self : DslistpersistentCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistpersistentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_model_make(size : Int) -> DslistpersistentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistpersistentModel::len(self : DslistpersistentModel) -> Int { self.size }

pub fn DslistpersistentModel::get(self : DslistpersistentModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistpersistentModel::set(self : DslistpersistentModel, i : Int, v : Double) -> DslistpersistentModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistpersistentModel::sum(self : DslistpersistentModel) -> Double { @_common.sum(self.data) }

pub fn DslistpersistentModel::mean(self : DslistpersistentModel) -> Double { @_common.mean(self.data) }

pub fn DslistpersistentModel::scale(self : DslistpersistentModel, f : Double) -> DslistpersistentModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistpersistentModel::add(self : DslistpersistentModel, other : DslistpersistentModel) -> DslistpersistentModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistpersistentModel::copy(self : DslistpersistentModel) -> DslistpersistentModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistpersistentModel::fill(self : DslistpersistentModel, v : Double) -> DslistpersistentModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistpersistentModel::min(self : DslistpersistentModel) -> Double { @_common.min(self.data) }

pub fn DslistpersistentModel::max(self : DslistpersistentModel) -> Double { @_common.max(self.data) }

pub fn DslistpersistentModel::to_string(self : DslistpersistentModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistpersistentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_layer_make(size : Int) -> DslistpersistentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistpersistentLayer::len(self : DslistpersistentLayer) -> Int { self.size }

pub fn DslistpersistentLayer::get(self : DslistpersistentLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistpersistentLayer::set(self : DslistpersistentLayer, i : Int, v : Double) -> DslistpersistentLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistpersistentLayer::sum(self : DslistpersistentLayer) -> Double { @_common.sum(self.data) }

pub fn DslistpersistentLayer::mean(self : DslistpersistentLayer) -> Double { @_common.mean(self.data) }

pub fn DslistpersistentLayer::scale(self : DslistpersistentLayer, f : Double) -> DslistpersistentLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistpersistentLayer::add(self : DslistpersistentLayer, other : DslistpersistentLayer) -> DslistpersistentLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistpersistentLayer::copy(self : DslistpersistentLayer) -> DslistpersistentLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistpersistentLayer::fill(self : DslistpersistentLayer, v : Double) -> DslistpersistentLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistpersistentLayer::min(self : DslistpersistentLayer) -> Double { @_common.min(self.data) }

pub fn DslistpersistentLayer::max(self : DslistpersistentLayer) -> Double { @_common.max(self.data) }

pub fn DslistpersistentLayer::to_string(self : DslistpersistentLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistpersistentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_buffer_make(size : Int) -> DslistpersistentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistpersistentBuffer::len(self : DslistpersistentBuffer) -> Int { self.size }

pub fn DslistpersistentBuffer::get(self : DslistpersistentBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistpersistentBuffer::set(self : DslistpersistentBuffer, i : Int, v : Double) -> DslistpersistentBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistpersistentBuffer::sum(self : DslistpersistentBuffer) -> Double { @_common.sum(self.data) }

pub fn DslistpersistentBuffer::mean(self : DslistpersistentBuffer) -> Double { @_common.mean(self.data) }

pub fn DslistpersistentBuffer::scale(self : DslistpersistentBuffer, f : Double) -> DslistpersistentBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistpersistentBuffer::add(self : DslistpersistentBuffer, other : DslistpersistentBuffer) -> DslistpersistentBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistpersistentBuffer::copy(self : DslistpersistentBuffer) -> DslistpersistentBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistpersistentBuffer::fill(self : DslistpersistentBuffer, v : Double) -> DslistpersistentBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistpersistentBuffer::min(self : DslistpersistentBuffer) -> Double { @_common.min(self.data) }

pub fn DslistpersistentBuffer::max(self : DslistpersistentBuffer) -> Double { @_common.max(self.data) }

pub fn DslistpersistentBuffer::to_string(self : DslistpersistentBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistpersistentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_cursor_make(size : Int) -> DslistpersistentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistpersistentCursor::len(self : DslistpersistentCursor) -> Int { self.size }

pub fn DslistpersistentCursor::get(self : DslistpersistentCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistpersistentCursor::set(self : DslistpersistentCursor, i : Int, v : Double) -> DslistpersistentCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistpersistentCursor::sum(self : DslistpersistentCursor) -> Double { @_common.sum(self.data) }

pub fn DslistpersistentCursor::mean(self : DslistpersistentCursor) -> Double { @_common.mean(self.data) }

pub fn DslistpersistentCursor::scale(self : DslistpersistentCursor, f : Double) -> DslistpersistentCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistpersistentCursor::add(self : DslistpersistentCursor, other : DslistpersistentCursor) -> DslistpersistentCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistpersistentCursor::copy(self : DslistpersistentCursor) -> DslistpersistentCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistpersistentCursor::fill(self : DslistpersistentCursor, v : Double) -> DslistpersistentCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistpersistentCursor::min(self : DslistpersistentCursor) -> Double { @_common.min(self.data) }

pub fn DslistpersistentCursor::max(self : DslistpersistentCursor) -> Double { @_common.max(self.data) }

pub fn DslistpersistentCursor::to_string(self : DslistpersistentCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistpersistentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_view_make(size : Int) -> DslistpersistentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistpersistentView::len(self : DslistpersistentView) -> Int { self.size }

pub fn DslistpersistentView::get(self : DslistpersistentView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistpersistentView::set(self : DslistpersistentView, i : Int, v : Double) -> DslistpersistentView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistpersistentView::sum(self : DslistpersistentView) -> Double { @_common.sum(self.data) }

pub fn DslistpersistentView::mean(self : DslistpersistentView) -> Double { @_common.mean(self.data) }

pub fn DslistpersistentView::scale(self : DslistpersistentView, f : Double) -> DslistpersistentView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistpersistentView::add(self : DslistpersistentView, other : DslistpersistentView) -> DslistpersistentView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistpersistentView::copy(self : DslistpersistentView) -> DslistpersistentView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistpersistentView::fill(self : DslistpersistentView, v : Double) -> DslistpersistentView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistpersistentView::min(self : DslistpersistentView) -> Double { @_common.min(self.data) }

pub fn DslistpersistentView::max(self : DslistpersistentView) -> Double { @_common.max(self.data) }

pub fn DslistpersistentView::to_string(self : DslistpersistentView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistpersistentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_range_make(size : Int) -> DslistpersistentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistpersistentRange::len(self : DslistpersistentRange) -> Int { self.size }

pub fn DslistpersistentRange::get(self : DslistpersistentRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistpersistentRange::set(self : DslistpersistentRange, i : Int, v : Double) -> DslistpersistentRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistpersistentRange::sum(self : DslistpersistentRange) -> Double { @_common.sum(self.data) }

pub fn DslistpersistentRange::mean(self : DslistpersistentRange) -> Double { @_common.mean(self.data) }

pub fn DslistpersistentRange::scale(self : DslistpersistentRange, f : Double) -> DslistpersistentRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistpersistentRange::add(self : DslistpersistentRange, other : DslistpersistentRange) -> DslistpersistentRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistpersistentRange::copy(self : DslistpersistentRange) -> DslistpersistentRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistpersistentRange::fill(self : DslistpersistentRange, v : Double) -> DslistpersistentRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistpersistentRange::min(self : DslistpersistentRange) -> Double { @_common.min(self.data) }

pub fn DslistpersistentRange::max(self : DslistpersistentRange) -> Double { @_common.max(self.data) }

pub fn DslistpersistentRange::to_string(self : DslistpersistentRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct DslistpersistentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_slice_make(size : Int) -> DslistpersistentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn DslistpersistentSlice::len(self : DslistpersistentSlice) -> Int { self.size }

pub fn DslistpersistentSlice::get(self : DslistpersistentSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn DslistpersistentSlice::set(self : DslistpersistentSlice, i : Int, v : Double) -> DslistpersistentSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn DslistpersistentSlice::sum(self : DslistpersistentSlice) -> Double { @_common.sum(self.data) }

pub fn DslistpersistentSlice::mean(self : DslistpersistentSlice) -> Double { @_common.mean(self.data) }

pub fn DslistpersistentSlice::scale(self : DslistpersistentSlice, f : Double) -> DslistpersistentSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn DslistpersistentSlice::add(self : DslistpersistentSlice, other : DslistpersistentSlice) -> DslistpersistentSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn DslistpersistentSlice::copy(self : DslistpersistentSlice) -> DslistpersistentSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn DslistpersistentSlice::fill(self : DslistpersistentSlice, v : Double) -> DslistpersistentSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn DslistpersistentSlice::min(self : DslistpersistentSlice) -> Double { @_common.min(self.data) }

pub fn DslistpersistentSlice::max(self : DslistpersistentSlice) -> Double { @_common.max(self.data) }

pub fn DslistpersistentSlice::to_string(self : DslistpersistentSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

