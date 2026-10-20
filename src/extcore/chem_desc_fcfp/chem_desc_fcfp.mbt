///===
/// extcore/chem_desc_fcfp

pub(all) struct ChemdescfcfpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_fcfp_make_point(x : Double, y : Double) -> ChemdescfcfpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_fcfp_make_point3(x : Double, y : Double, z : Double) -> ChemdescfcfpPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdescfcfpPoint::x(self : ChemdescfcfpPoint) -> Double { self.x }

pub fn ChemdescfcfpPoint::y(self : ChemdescfcfpPoint) -> Double { self.y }

pub fn ChemdescfcfpPoint::z(self : ChemdescfcfpPoint) -> Double { self.z }

pub fn ChemdescfcfpPoint::label(self : ChemdescfcfpPoint) -> Int { self.label }

pub fn ChemdescfcfpPoint::dist(self : ChemdescfcfpPoint, other : ChemdescfcfpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdescfcfpPoint::add(self : ChemdescfcfpPoint, other : ChemdescfcfpPoint) -> ChemdescfcfpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdescfcfpPoint::sub(self : ChemdescfcfpPoint, other : ChemdescfcfpPoint) -> ChemdescfcfpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdescfcfpPoint::scale(self : ChemdescfcfpPoint, s : Double) -> ChemdescfcfpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdescfcfpPoint::dot(self : ChemdescfcfpPoint, other : ChemdescfcfpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdescfcfpPoint::cross(self : ChemdescfcfpPoint, other : ChemdescfcfpPoint) -> ChemdescfcfpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdescfcfpPoint::norm(self : ChemdescfcfpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdescfcfpPoint::normalize(self : ChemdescfcfpPoint) -> ChemdescfcfpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescfcfpPoint::negate(self : ChemdescfcfpPoint) -> ChemdescfcfpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdescfcfpPoint::mid(self : ChemdescfcfpPoint, other : ChemdescfcfpPoint) -> ChemdescfcfpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdescfcfpPoint::lerp(self : ChemdescfcfpPoint, other : ChemdescfcfpPoint, t : Double) -> ChemdescfcfpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdescfcfpPoint::to_string(self : ChemdescfcfpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdescfcfpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_fcfp_make_series(vals : Array[Double], name : String) -> ChemdescfcfpSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdescfcfpSeries::len(self : ChemdescfcfpSeries) -> Int { self.vals.length() }

pub fn ChemdescfcfpSeries::sum(self : ChemdescfcfpSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdescfcfpSeries::mean(self : ChemdescfcfpSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdescfcfpSeries::min(self : ChemdescfcfpSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdescfcfpSeries::max(self : ChemdescfcfpSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdescfcfpSeries::range(self : ChemdescfcfpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdescfcfpSeries::variance(self : ChemdescfcfpSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdescfcfpSeries::std(self : ChemdescfcfpSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdescfcfpSeries::median(self : ChemdescfcfpSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdescfcfpSeries::scale(self : ChemdescfcfpSeries, f : Double) -> ChemdescfcfpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdescfcfpSeries::add(self : ChemdescfcfpSeries, other : ChemdescfcfpSeries) -> ChemdescfcfpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdescfcfpSeries::sub(self : ChemdescfcfpSeries, other : ChemdescfcfpSeries) -> ChemdescfcfpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdescfcfpSeries::normalize(self : ChemdescfcfpSeries) -> ChemdescfcfpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdescfcfpSeries::cumsum(self : ChemdescfcfpSeries) -> ChemdescfcfpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdescfcfpSeries::to_string(self : ChemdescfcfpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescfcfpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_fcfp_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescfcfpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_fcfp_matrix_identity(n : Int) -> ChemdescfcfpMatrix {
  let m = chem_desc_fcfp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdescfcfpMatrix::get(self : ChemdescfcfpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdescfcfpMatrix::transpose(self : ChemdescfcfpMatrix) -> ChemdescfcfpMatrix {
  let result = chem_desc_fcfp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdescfcfpMatrix::add(self : ChemdescfcfpMatrix, other : ChemdescfcfpMatrix) -> ChemdescfcfpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_fcfp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdescfcfpMatrix::scale(self : ChemdescfcfpMatrix, s : Double) -> ChemdescfcfpMatrix {
  let result = chem_desc_fcfp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdescfcfpMatrix::multiply(self : ChemdescfcfpMatrix, other : ChemdescfcfpMatrix) -> ChemdescfcfpMatrix {
  if self.cols != other.rows { return chem_desc_fcfp_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_fcfp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemdescfcfpMatrix::trace(self : ChemdescfcfpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdescfcfpMatrix::det(self : ChemdescfcfpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdescfcfpMatrix::norm(self : ChemdescfcfpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdescfcfpMatrix::to_string(self : ChemdescfcfpMatrix) -> String {
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

pub(all) struct ChemdescfcfpVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_fcfp_make_vector(comps : Array[Double]) -> ChemdescfcfpVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_fcfp_vector_zero(dim : Int) -> ChemdescfcfpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdescfcfpVector::add(self : ChemdescfcfpVector, other : ChemdescfcfpVector) -> ChemdescfcfpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescfcfpVector::sub(self : ChemdescfcfpVector, other : ChemdescfcfpVector) -> ChemdescfcfpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescfcfpVector::scale(self : ChemdescfcfpVector, s : Double) -> ChemdescfcfpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdescfcfpVector::dot(self : ChemdescfcfpVector, other : ChemdescfcfpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdescfcfpVector::norm(self : ChemdescfcfpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdescfcfpVector::normalize(self : ChemdescfcfpVector) -> ChemdescfcfpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescfcfpVector::dist(self : ChemdescfcfpVector, other : ChemdescfcfpVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdescfcfpVector::to_string(self : ChemdescfcfpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_fcfp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_fcfp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_fcfp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_fcfp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_fcfp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_fcfp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_fcfp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_fcfp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_fcfp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_fcfp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_fcfp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_fcfp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_fcfp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_fcfp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_fcfp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_fcfp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_fcfp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_fcfp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_fcfp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_fcfp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_fcfp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_fcfp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_fcfp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_fcfp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_fcfp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_fcfp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_fcfp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_fcfp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_fcfp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdescfcfpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_frame_make(size : Int) -> ChemdescfcfpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_frame_len(s : ChemdescfcfpFrame) -> Int { s.size }

pub fn chem_desc_fcfp_frame_get(s : ChemdescfcfpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_frame_set(s : ChemdescfcfpFrame, i : Int, v : Double) -> ChemdescfcfpFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_frame_sum(s : ChemdescfcfpFrame) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fcfp_frame_mean(s : ChemdescfcfpFrame) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fcfp_frame_scale(s : ChemdescfcfpFrame, f : Double) -> ChemdescfcfpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_frame_add(a : ChemdescfcfpFrame, b : ChemdescfcfpFrame) -> ChemdescfcfpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fcfp_frame_copy(s : ChemdescfcfpFrame) -> ChemdescfcfpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_frame_fill(s : ChemdescfcfpFrame, v : Double) -> ChemdescfcfpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_frame_min(s : ChemdescfcfpFrame) -> Double { @_common.min(s.data) }

pub fn chem_desc_fcfp_frame_max(s : ChemdescfcfpFrame) -> Double { @_common.max(s.data) }

pub fn chem_desc_fcfp_frame_to_string(s : ChemdescfcfpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_table_make(size : Int) -> ChemdescfcfpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_table_len(s : ChemdescfcfpTable) -> Int { s.size }

pub fn chem_desc_fcfp_table_get(s : ChemdescfcfpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_table_set(s : ChemdescfcfpTable, i : Int, v : Double) -> ChemdescfcfpTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_table_sum(s : ChemdescfcfpTable) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fcfp_table_mean(s : ChemdescfcfpTable) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fcfp_table_scale(s : ChemdescfcfpTable, f : Double) -> ChemdescfcfpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_table_add(a : ChemdescfcfpTable, b : ChemdescfcfpTable) -> ChemdescfcfpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fcfp_table_copy(s : ChemdescfcfpTable) -> ChemdescfcfpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_table_fill(s : ChemdescfcfpTable, v : Double) -> ChemdescfcfpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_table_min(s : ChemdescfcfpTable) -> Double { @_common.min(s.data) }

pub fn chem_desc_fcfp_table_max(s : ChemdescfcfpTable) -> Double { @_common.max(s.data) }

pub fn chem_desc_fcfp_table_to_string(s : ChemdescfcfpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_graphn_make(size : Int) -> ChemdescfcfpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_graphn_len(s : ChemdescfcfpGraphN) -> Int { s.size }

pub fn chem_desc_fcfp_graphn_get(s : ChemdescfcfpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_graphn_set(s : ChemdescfcfpGraphN, i : Int, v : Double) -> ChemdescfcfpGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_graphn_sum(s : ChemdescfcfpGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fcfp_graphn_mean(s : ChemdescfcfpGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fcfp_graphn_scale(s : ChemdescfcfpGraphN, f : Double) -> ChemdescfcfpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_graphn_add(a : ChemdescfcfpGraphN, b : ChemdescfcfpGraphN) -> ChemdescfcfpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fcfp_graphn_copy(s : ChemdescfcfpGraphN) -> ChemdescfcfpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_graphn_fill(s : ChemdescfcfpGraphN, v : Double) -> ChemdescfcfpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_graphn_min(s : ChemdescfcfpGraphN) -> Double { @_common.min(s.data) }

pub fn chem_desc_fcfp_graphn_max(s : ChemdescfcfpGraphN) -> Double { @_common.max(s.data) }

pub fn chem_desc_fcfp_graphn_to_string(s : ChemdescfcfpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_node_make(size : Int) -> ChemdescfcfpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_node_len(s : ChemdescfcfpNode) -> Int { s.size }

pub fn chem_desc_fcfp_node_get(s : ChemdescfcfpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_node_set(s : ChemdescfcfpNode, i : Int, v : Double) -> ChemdescfcfpNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_node_sum(s : ChemdescfcfpNode) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fcfp_node_mean(s : ChemdescfcfpNode) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fcfp_node_scale(s : ChemdescfcfpNode, f : Double) -> ChemdescfcfpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_node_add(a : ChemdescfcfpNode, b : ChemdescfcfpNode) -> ChemdescfcfpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fcfp_node_copy(s : ChemdescfcfpNode) -> ChemdescfcfpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_node_fill(s : ChemdescfcfpNode, v : Double) -> ChemdescfcfpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_node_min(s : ChemdescfcfpNode) -> Double { @_common.min(s.data) }

pub fn chem_desc_fcfp_node_max(s : ChemdescfcfpNode) -> Double { @_common.max(s.data) }

pub fn chem_desc_fcfp_node_to_string(s : ChemdescfcfpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_edge_make(size : Int) -> ChemdescfcfpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_edge_len(s : ChemdescfcfpEdge) -> Int { s.size }

pub fn chem_desc_fcfp_edge_get(s : ChemdescfcfpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_edge_set(s : ChemdescfcfpEdge, i : Int, v : Double) -> ChemdescfcfpEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_edge_sum(s : ChemdescfcfpEdge) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fcfp_edge_mean(s : ChemdescfcfpEdge) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fcfp_edge_scale(s : ChemdescfcfpEdge, f : Double) -> ChemdescfcfpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_edge_add(a : ChemdescfcfpEdge, b : ChemdescfcfpEdge) -> ChemdescfcfpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fcfp_edge_copy(s : ChemdescfcfpEdge) -> ChemdescfcfpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_edge_fill(s : ChemdescfcfpEdge, v : Double) -> ChemdescfcfpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_edge_min(s : ChemdescfcfpEdge) -> Double { @_common.min(s.data) }

pub fn chem_desc_fcfp_edge_max(s : ChemdescfcfpEdge) -> Double { @_common.max(s.data) }

pub fn chem_desc_fcfp_edge_to_string(s : ChemdescfcfpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_path_make(size : Int) -> ChemdescfcfpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_path_len(s : ChemdescfcfpPath) -> Int { s.size }

pub fn chem_desc_fcfp_path_get(s : ChemdescfcfpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_path_set(s : ChemdescfcfpPath, i : Int, v : Double) -> ChemdescfcfpPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_path_sum(s : ChemdescfcfpPath) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fcfp_path_mean(s : ChemdescfcfpPath) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fcfp_path_scale(s : ChemdescfcfpPath, f : Double) -> ChemdescfcfpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_path_add(a : ChemdescfcfpPath, b : ChemdescfcfpPath) -> ChemdescfcfpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fcfp_path_copy(s : ChemdescfcfpPath) -> ChemdescfcfpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_path_fill(s : ChemdescfcfpPath, v : Double) -> ChemdescfcfpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_path_min(s : ChemdescfcfpPath) -> Double { @_common.min(s.data) }

pub fn chem_desc_fcfp_path_max(s : ChemdescfcfpPath) -> Double { @_common.max(s.data) }

pub fn chem_desc_fcfp_path_to_string(s : ChemdescfcfpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_cluster_make(size : Int) -> ChemdescfcfpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_cluster_len(s : ChemdescfcfpCluster) -> Int { s.size }

pub fn chem_desc_fcfp_cluster_get(s : ChemdescfcfpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_cluster_set(s : ChemdescfcfpCluster, i : Int, v : Double) -> ChemdescfcfpCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_cluster_sum(s : ChemdescfcfpCluster) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fcfp_cluster_mean(s : ChemdescfcfpCluster) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fcfp_cluster_scale(s : ChemdescfcfpCluster, f : Double) -> ChemdescfcfpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_cluster_add(a : ChemdescfcfpCluster, b : ChemdescfcfpCluster) -> ChemdescfcfpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fcfp_cluster_copy(s : ChemdescfcfpCluster) -> ChemdescfcfpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_cluster_fill(s : ChemdescfcfpCluster, v : Double) -> ChemdescfcfpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_cluster_min(s : ChemdescfcfpCluster) -> Double { @_common.min(s.data) }

pub fn chem_desc_fcfp_cluster_max(s : ChemdescfcfpCluster) -> Double { @_common.max(s.data) }

pub fn chem_desc_fcfp_cluster_to_string(s : ChemdescfcfpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_model_make(size : Int) -> ChemdescfcfpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_model_len(s : ChemdescfcfpModel) -> Int { s.size }

pub fn chem_desc_fcfp_model_get(s : ChemdescfcfpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_model_set(s : ChemdescfcfpModel, i : Int, v : Double) -> ChemdescfcfpModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_model_sum(s : ChemdescfcfpModel) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fcfp_model_mean(s : ChemdescfcfpModel) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fcfp_model_scale(s : ChemdescfcfpModel, f : Double) -> ChemdescfcfpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_model_add(a : ChemdescfcfpModel, b : ChemdescfcfpModel) -> ChemdescfcfpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fcfp_model_copy(s : ChemdescfcfpModel) -> ChemdescfcfpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_model_fill(s : ChemdescfcfpModel, v : Double) -> ChemdescfcfpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_model_min(s : ChemdescfcfpModel) -> Double { @_common.min(s.data) }

pub fn chem_desc_fcfp_model_max(s : ChemdescfcfpModel) -> Double { @_common.max(s.data) }

pub fn chem_desc_fcfp_model_to_string(s : ChemdescfcfpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_layer_make(size : Int) -> ChemdescfcfpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_layer_len(s : ChemdescfcfpLayer) -> Int { s.size }

pub fn chem_desc_fcfp_layer_get(s : ChemdescfcfpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_layer_set(s : ChemdescfcfpLayer, i : Int, v : Double) -> ChemdescfcfpLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_layer_sum(s : ChemdescfcfpLayer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fcfp_layer_mean(s : ChemdescfcfpLayer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fcfp_layer_scale(s : ChemdescfcfpLayer, f : Double) -> ChemdescfcfpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_layer_add(a : ChemdescfcfpLayer, b : ChemdescfcfpLayer) -> ChemdescfcfpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fcfp_layer_copy(s : ChemdescfcfpLayer) -> ChemdescfcfpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_layer_fill(s : ChemdescfcfpLayer, v : Double) -> ChemdescfcfpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_layer_min(s : ChemdescfcfpLayer) -> Double { @_common.min(s.data) }

pub fn chem_desc_fcfp_layer_max(s : ChemdescfcfpLayer) -> Double { @_common.max(s.data) }

pub fn chem_desc_fcfp_layer_to_string(s : ChemdescfcfpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_buffer_make(size : Int) -> ChemdescfcfpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_buffer_len(s : ChemdescfcfpBuffer) -> Int { s.size }

pub fn chem_desc_fcfp_buffer_get(s : ChemdescfcfpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_buffer_set(s : ChemdescfcfpBuffer, i : Int, v : Double) -> ChemdescfcfpBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_buffer_sum(s : ChemdescfcfpBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fcfp_buffer_mean(s : ChemdescfcfpBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fcfp_buffer_scale(s : ChemdescfcfpBuffer, f : Double) -> ChemdescfcfpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_buffer_add(a : ChemdescfcfpBuffer, b : ChemdescfcfpBuffer) -> ChemdescfcfpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fcfp_buffer_copy(s : ChemdescfcfpBuffer) -> ChemdescfcfpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_buffer_fill(s : ChemdescfcfpBuffer, v : Double) -> ChemdescfcfpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_buffer_min(s : ChemdescfcfpBuffer) -> Double { @_common.min(s.data) }

pub fn chem_desc_fcfp_buffer_max(s : ChemdescfcfpBuffer) -> Double { @_common.max(s.data) }

pub fn chem_desc_fcfp_buffer_to_string(s : ChemdescfcfpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_cursor_make(size : Int) -> ChemdescfcfpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_cursor_len(s : ChemdescfcfpCursor) -> Int { s.size }

pub fn chem_desc_fcfp_cursor_get(s : ChemdescfcfpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_cursor_set(s : ChemdescfcfpCursor, i : Int, v : Double) -> ChemdescfcfpCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_cursor_sum(s : ChemdescfcfpCursor) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fcfp_cursor_mean(s : ChemdescfcfpCursor) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fcfp_cursor_scale(s : ChemdescfcfpCursor, f : Double) -> ChemdescfcfpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_cursor_add(a : ChemdescfcfpCursor, b : ChemdescfcfpCursor) -> ChemdescfcfpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fcfp_cursor_copy(s : ChemdescfcfpCursor) -> ChemdescfcfpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_cursor_fill(s : ChemdescfcfpCursor, v : Double) -> ChemdescfcfpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_cursor_min(s : ChemdescfcfpCursor) -> Double { @_common.min(s.data) }

pub fn chem_desc_fcfp_cursor_max(s : ChemdescfcfpCursor) -> Double { @_common.max(s.data) }

pub fn chem_desc_fcfp_cursor_to_string(s : ChemdescfcfpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_view_make(size : Int) -> ChemdescfcfpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_view_len(s : ChemdescfcfpView) -> Int { s.size }

pub fn chem_desc_fcfp_view_get(s : ChemdescfcfpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_view_set(s : ChemdescfcfpView, i : Int, v : Double) -> ChemdescfcfpView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_view_sum(s : ChemdescfcfpView) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fcfp_view_mean(s : ChemdescfcfpView) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fcfp_view_scale(s : ChemdescfcfpView, f : Double) -> ChemdescfcfpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_view_add(a : ChemdescfcfpView, b : ChemdescfcfpView) -> ChemdescfcfpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fcfp_view_copy(s : ChemdescfcfpView) -> ChemdescfcfpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_view_fill(s : ChemdescfcfpView, v : Double) -> ChemdescfcfpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_view_min(s : ChemdescfcfpView) -> Double { @_common.min(s.data) }

pub fn chem_desc_fcfp_view_max(s : ChemdescfcfpView) -> Double { @_common.max(s.data) }

pub fn chem_desc_fcfp_view_to_string(s : ChemdescfcfpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_range_make(size : Int) -> ChemdescfcfpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_range_len(s : ChemdescfcfpRange) -> Int { s.size }

pub fn chem_desc_fcfp_range_get(s : ChemdescfcfpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_range_set(s : ChemdescfcfpRange, i : Int, v : Double) -> ChemdescfcfpRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_range_sum(s : ChemdescfcfpRange) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fcfp_range_mean(s : ChemdescfcfpRange) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fcfp_range_scale(s : ChemdescfcfpRange, f : Double) -> ChemdescfcfpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_range_add(a : ChemdescfcfpRange, b : ChemdescfcfpRange) -> ChemdescfcfpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fcfp_range_copy(s : ChemdescfcfpRange) -> ChemdescfcfpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_range_fill(s : ChemdescfcfpRange, v : Double) -> ChemdescfcfpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_range_min(s : ChemdescfcfpRange) -> Double { @_common.min(s.data) }

pub fn chem_desc_fcfp_range_max(s : ChemdescfcfpRange) -> Double { @_common.max(s.data) }

pub fn chem_desc_fcfp_range_to_string(s : ChemdescfcfpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_slice_make(size : Int) -> ChemdescfcfpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_slice_len(s : ChemdescfcfpSlice) -> Int { s.size }

pub fn chem_desc_fcfp_slice_get(s : ChemdescfcfpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_slice_set(s : ChemdescfcfpSlice, i : Int, v : Double) -> ChemdescfcfpSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_slice_sum(s : ChemdescfcfpSlice) -> Double { @_common.sum(s.data) }

pub fn chem_desc_fcfp_slice_mean(s : ChemdescfcfpSlice) -> Double { @_common.mean(s.data) }

pub fn chem_desc_fcfp_slice_scale(s : ChemdescfcfpSlice, f : Double) -> ChemdescfcfpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_slice_add(a : ChemdescfcfpSlice, b : ChemdescfcfpSlice) -> ChemdescfcfpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_fcfp_slice_copy(s : ChemdescfcfpSlice) -> ChemdescfcfpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_slice_fill(s : ChemdescfcfpSlice, v : Double) -> ChemdescfcfpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_fcfp_slice_min(s : ChemdescfcfpSlice) -> Double { @_common.min(s.data) }

pub fn chem_desc_fcfp_slice_max(s : ChemdescfcfpSlice) -> Double { @_common.max(s.data) }

pub fn chem_desc_fcfp_slice_to_string(s : ChemdescfcfpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

