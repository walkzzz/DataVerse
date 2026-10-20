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

pub fn ds_list_persistent_frame_len(s : DslistpersistentFrame) -> Int { s.size }

pub fn ds_list_persistent_frame_get(s : DslistpersistentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_frame_set(s : DslistpersistentFrame, i : Int, v : Double) -> DslistpersistentFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_frame_sum(s : DslistpersistentFrame) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_frame_mean(s : DslistpersistentFrame) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_frame_scale(s : DslistpersistentFrame, f : Double) -> DslistpersistentFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_frame_add(a : DslistpersistentFrame, b : DslistpersistentFrame) -> DslistpersistentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_frame_copy(s : DslistpersistentFrame) -> DslistpersistentFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_frame_fill(s : DslistpersistentFrame, v : Double) -> DslistpersistentFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_frame_min(s : DslistpersistentFrame) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_frame_max(s : DslistpersistentFrame) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_frame_to_string(s : DslistpersistentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_table_make(size : Int) -> DslistpersistentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_table_len(s : DslistpersistentTable) -> Int { s.size }

pub fn ds_list_persistent_table_get(s : DslistpersistentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_table_set(s : DslistpersistentTable, i : Int, v : Double) -> DslistpersistentTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_table_sum(s : DslistpersistentTable) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_table_mean(s : DslistpersistentTable) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_table_scale(s : DslistpersistentTable, f : Double) -> DslistpersistentTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_table_add(a : DslistpersistentTable, b : DslistpersistentTable) -> DslistpersistentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_table_copy(s : DslistpersistentTable) -> DslistpersistentTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_table_fill(s : DslistpersistentTable, v : Double) -> DslistpersistentTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_table_min(s : DslistpersistentTable) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_table_max(s : DslistpersistentTable) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_table_to_string(s : DslistpersistentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_graphn_make(size : Int) -> DslistpersistentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_graphn_len(s : DslistpersistentGraphN) -> Int { s.size }

pub fn ds_list_persistent_graphn_get(s : DslistpersistentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_graphn_set(s : DslistpersistentGraphN, i : Int, v : Double) -> DslistpersistentGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_graphn_sum(s : DslistpersistentGraphN) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_graphn_mean(s : DslistpersistentGraphN) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_graphn_scale(s : DslistpersistentGraphN, f : Double) -> DslistpersistentGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_graphn_add(a : DslistpersistentGraphN, b : DslistpersistentGraphN) -> DslistpersistentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_graphn_copy(s : DslistpersistentGraphN) -> DslistpersistentGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_graphn_fill(s : DslistpersistentGraphN, v : Double) -> DslistpersistentGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_graphn_min(s : DslistpersistentGraphN) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_graphn_max(s : DslistpersistentGraphN) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_graphn_to_string(s : DslistpersistentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_node_make(size : Int) -> DslistpersistentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_node_len(s : DslistpersistentNode) -> Int { s.size }

pub fn ds_list_persistent_node_get(s : DslistpersistentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_node_set(s : DslistpersistentNode, i : Int, v : Double) -> DslistpersistentNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_node_sum(s : DslistpersistentNode) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_node_mean(s : DslistpersistentNode) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_node_scale(s : DslistpersistentNode, f : Double) -> DslistpersistentNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_node_add(a : DslistpersistentNode, b : DslistpersistentNode) -> DslistpersistentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_node_copy(s : DslistpersistentNode) -> DslistpersistentNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_node_fill(s : DslistpersistentNode, v : Double) -> DslistpersistentNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_node_min(s : DslistpersistentNode) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_node_max(s : DslistpersistentNode) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_node_to_string(s : DslistpersistentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_edge_make(size : Int) -> DslistpersistentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_edge_len(s : DslistpersistentEdge) -> Int { s.size }

pub fn ds_list_persistent_edge_get(s : DslistpersistentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_edge_set(s : DslistpersistentEdge, i : Int, v : Double) -> DslistpersistentEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_edge_sum(s : DslistpersistentEdge) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_edge_mean(s : DslistpersistentEdge) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_edge_scale(s : DslistpersistentEdge, f : Double) -> DslistpersistentEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_edge_add(a : DslistpersistentEdge, b : DslistpersistentEdge) -> DslistpersistentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_edge_copy(s : DslistpersistentEdge) -> DslistpersistentEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_edge_fill(s : DslistpersistentEdge, v : Double) -> DslistpersistentEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_edge_min(s : DslistpersistentEdge) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_edge_max(s : DslistpersistentEdge) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_edge_to_string(s : DslistpersistentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_path_make(size : Int) -> DslistpersistentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_path_len(s : DslistpersistentPath) -> Int { s.size }

pub fn ds_list_persistent_path_get(s : DslistpersistentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_path_set(s : DslistpersistentPath, i : Int, v : Double) -> DslistpersistentPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_path_sum(s : DslistpersistentPath) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_path_mean(s : DslistpersistentPath) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_path_scale(s : DslistpersistentPath, f : Double) -> DslistpersistentPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_path_add(a : DslistpersistentPath, b : DslistpersistentPath) -> DslistpersistentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_path_copy(s : DslistpersistentPath) -> DslistpersistentPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_path_fill(s : DslistpersistentPath, v : Double) -> DslistpersistentPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_path_min(s : DslistpersistentPath) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_path_max(s : DslistpersistentPath) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_path_to_string(s : DslistpersistentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_cluster_make(size : Int) -> DslistpersistentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_cluster_len(s : DslistpersistentCluster) -> Int { s.size }

pub fn ds_list_persistent_cluster_get(s : DslistpersistentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_cluster_set(s : DslistpersistentCluster, i : Int, v : Double) -> DslistpersistentCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cluster_sum(s : DslistpersistentCluster) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_cluster_mean(s : DslistpersistentCluster) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_cluster_scale(s : DslistpersistentCluster, f : Double) -> DslistpersistentCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cluster_add(a : DslistpersistentCluster, b : DslistpersistentCluster) -> DslistpersistentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_cluster_copy(s : DslistpersistentCluster) -> DslistpersistentCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cluster_fill(s : DslistpersistentCluster, v : Double) -> DslistpersistentCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cluster_min(s : DslistpersistentCluster) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_cluster_max(s : DslistpersistentCluster) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_cluster_to_string(s : DslistpersistentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_model_make(size : Int) -> DslistpersistentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_model_len(s : DslistpersistentModel) -> Int { s.size }

pub fn ds_list_persistent_model_get(s : DslistpersistentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_model_set(s : DslistpersistentModel, i : Int, v : Double) -> DslistpersistentModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_model_sum(s : DslistpersistentModel) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_model_mean(s : DslistpersistentModel) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_model_scale(s : DslistpersistentModel, f : Double) -> DslistpersistentModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_model_add(a : DslistpersistentModel, b : DslistpersistentModel) -> DslistpersistentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_model_copy(s : DslistpersistentModel) -> DslistpersistentModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_model_fill(s : DslistpersistentModel, v : Double) -> DslistpersistentModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_model_min(s : DslistpersistentModel) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_model_max(s : DslistpersistentModel) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_model_to_string(s : DslistpersistentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_layer_make(size : Int) -> DslistpersistentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_layer_len(s : DslistpersistentLayer) -> Int { s.size }

pub fn ds_list_persistent_layer_get(s : DslistpersistentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_layer_set(s : DslistpersistentLayer, i : Int, v : Double) -> DslistpersistentLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_layer_sum(s : DslistpersistentLayer) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_layer_mean(s : DslistpersistentLayer) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_layer_scale(s : DslistpersistentLayer, f : Double) -> DslistpersistentLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_layer_add(a : DslistpersistentLayer, b : DslistpersistentLayer) -> DslistpersistentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_layer_copy(s : DslistpersistentLayer) -> DslistpersistentLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_layer_fill(s : DslistpersistentLayer, v : Double) -> DslistpersistentLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_layer_min(s : DslistpersistentLayer) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_layer_max(s : DslistpersistentLayer) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_layer_to_string(s : DslistpersistentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_buffer_make(size : Int) -> DslistpersistentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_buffer_len(s : DslistpersistentBuffer) -> Int { s.size }

pub fn ds_list_persistent_buffer_get(s : DslistpersistentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_buffer_set(s : DslistpersistentBuffer, i : Int, v : Double) -> DslistpersistentBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_buffer_sum(s : DslistpersistentBuffer) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_buffer_mean(s : DslistpersistentBuffer) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_buffer_scale(s : DslistpersistentBuffer, f : Double) -> DslistpersistentBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_buffer_add(a : DslistpersistentBuffer, b : DslistpersistentBuffer) -> DslistpersistentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_buffer_copy(s : DslistpersistentBuffer) -> DslistpersistentBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_buffer_fill(s : DslistpersistentBuffer, v : Double) -> DslistpersistentBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_buffer_min(s : DslistpersistentBuffer) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_buffer_max(s : DslistpersistentBuffer) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_buffer_to_string(s : DslistpersistentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_cursor_make(size : Int) -> DslistpersistentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_cursor_len(s : DslistpersistentCursor) -> Int { s.size }

pub fn ds_list_persistent_cursor_get(s : DslistpersistentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_cursor_set(s : DslistpersistentCursor, i : Int, v : Double) -> DslistpersistentCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cursor_sum(s : DslistpersistentCursor) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_cursor_mean(s : DslistpersistentCursor) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_cursor_scale(s : DslistpersistentCursor, f : Double) -> DslistpersistentCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cursor_add(a : DslistpersistentCursor, b : DslistpersistentCursor) -> DslistpersistentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_cursor_copy(s : DslistpersistentCursor) -> DslistpersistentCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cursor_fill(s : DslistpersistentCursor, v : Double) -> DslistpersistentCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_cursor_min(s : DslistpersistentCursor) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_cursor_max(s : DslistpersistentCursor) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_cursor_to_string(s : DslistpersistentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_view_make(size : Int) -> DslistpersistentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_view_len(s : DslistpersistentView) -> Int { s.size }

pub fn ds_list_persistent_view_get(s : DslistpersistentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_view_set(s : DslistpersistentView, i : Int, v : Double) -> DslistpersistentView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_view_sum(s : DslistpersistentView) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_view_mean(s : DslistpersistentView) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_view_scale(s : DslistpersistentView, f : Double) -> DslistpersistentView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_view_add(a : DslistpersistentView, b : DslistpersistentView) -> DslistpersistentView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_view_copy(s : DslistpersistentView) -> DslistpersistentView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_view_fill(s : DslistpersistentView, v : Double) -> DslistpersistentView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_view_min(s : DslistpersistentView) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_view_max(s : DslistpersistentView) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_view_to_string(s : DslistpersistentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_range_make(size : Int) -> DslistpersistentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_range_len(s : DslistpersistentRange) -> Int { s.size }

pub fn ds_list_persistent_range_get(s : DslistpersistentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_range_set(s : DslistpersistentRange, i : Int, v : Double) -> DslistpersistentRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_range_sum(s : DslistpersistentRange) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_range_mean(s : DslistpersistentRange) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_range_scale(s : DslistpersistentRange, f : Double) -> DslistpersistentRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_range_add(a : DslistpersistentRange, b : DslistpersistentRange) -> DslistpersistentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_range_copy(s : DslistpersistentRange) -> DslistpersistentRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_range_fill(s : DslistpersistentRange, v : Double) -> DslistpersistentRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_range_min(s : DslistpersistentRange) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_range_max(s : DslistpersistentRange) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_range_to_string(s : DslistpersistentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistpersistentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_persistent_slice_make(size : Int) -> DslistpersistentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_persistent_slice_len(s : DslistpersistentSlice) -> Int { s.size }

pub fn ds_list_persistent_slice_get(s : DslistpersistentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_persistent_slice_set(s : DslistpersistentSlice, i : Int, v : Double) -> DslistpersistentSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_slice_sum(s : DslistpersistentSlice) -> Double { @_common.sum(s.data) }

pub fn ds_list_persistent_slice_mean(s : DslistpersistentSlice) -> Double { @_common.mean(s.data) }

pub fn ds_list_persistent_slice_scale(s : DslistpersistentSlice, f : Double) -> DslistpersistentSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_slice_add(a : DslistpersistentSlice, b : DslistpersistentSlice) -> DslistpersistentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn ds_list_persistent_slice_copy(s : DslistpersistentSlice) -> DslistpersistentSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_slice_fill(s : DslistpersistentSlice, v : Double) -> DslistpersistentSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn ds_list_persistent_slice_min(s : DslistpersistentSlice) -> Double { @_common.min(s.data) }

pub fn ds_list_persistent_slice_max(s : DslistpersistentSlice) -> Double { @_common.max(s.data) }

pub fn ds_list_persistent_slice_to_string(s : DslistpersistentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

