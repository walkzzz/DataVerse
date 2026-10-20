///===
/// extcore/chem_desc_ecfp

pub(all) struct ChemdescecfpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_ecfp_make_point(x : Double, y : Double) -> ChemdescecfpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_ecfp_make_point3(x : Double, y : Double, z : Double) -> ChemdescecfpPoint {
  { x, y, z, label: 0 }
}

pub fn ChemdescecfpPoint::x(self : ChemdescecfpPoint) -> Double { self.x }

pub fn ChemdescecfpPoint::y(self : ChemdescecfpPoint) -> Double { self.y }

pub fn ChemdescecfpPoint::z(self : ChemdescecfpPoint) -> Double { self.z }

pub fn ChemdescecfpPoint::label(self : ChemdescecfpPoint) -> Int { self.label }

pub fn ChemdescecfpPoint::dist(self : ChemdescecfpPoint, other : ChemdescecfpPoint) -> Double {
  let dx = self.x - other.x
  let dy = self.y - other.y
  let dz = self.z - other.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ChemdescecfpPoint::add(self : ChemdescecfpPoint, other : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: self.x + other.x, y: self.y + other.y, z: self.z + other.z, label: self.label }
}

pub fn ChemdescecfpPoint::sub(self : ChemdescecfpPoint, other : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: self.x - other.x, y: self.y - other.y, z: self.z - other.z, label: self.label }
}

pub fn ChemdescecfpPoint::scale(self : ChemdescecfpPoint, s : Double) -> ChemdescecfpPoint {
  { x: self.x * s, y: self.y * s, z: self.z * s, label: self.label }
}

pub fn ChemdescecfpPoint::dot(self : ChemdescecfpPoint, other : ChemdescecfpPoint) -> Double {
  self.x * other.x + self.y * other.y + self.z * other.z
}

pub fn ChemdescecfpPoint::cross(self : ChemdescecfpPoint, other : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: self.y * other.z - self.z * other.y, y: self.z * other.x - self.x * other.z, z: self.x * other.y - self.y * other.x, label: 0 }
}

pub fn ChemdescecfpPoint::norm(self : ChemdescecfpPoint) -> Double {
  @_common.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
}

pub fn ChemdescecfpPoint::normalize(self : ChemdescecfpPoint) -> ChemdescecfpPoint {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescecfpPoint::negate(self : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: -self.x, y: -self.y, z: -self.z, label: self.label }
}

pub fn ChemdescecfpPoint::mid(self : ChemdescecfpPoint, other : ChemdescecfpPoint) -> ChemdescecfpPoint {
  { x: (self.x + other.x) / 2.0, y: (self.y + other.y) / 2.0, z: (self.z + other.z) / 2.0, label: self.label }
}

pub fn ChemdescecfpPoint::lerp(self : ChemdescecfpPoint, other : ChemdescecfpPoint, t : Double) -> ChemdescecfpPoint {
  { x: self.x + (other.x - self.x) * t, y: self.y + (other.y - self.y) * t, z: self.z + (other.z - self.z) * t, label: self.label }
}

pub fn ChemdescecfpPoint::to_string(self : ChemdescecfpPoint) -> String {
  "(" + @_common.dbl(self.x) + ", " + @_common.dbl(self.y) + ", " + @_common.dbl(self.z) + ")[" + self.label.to_string() + "]"
}

pub(all) struct ChemdescecfpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_ecfp_make_series(vals : Array[Double], name : String) -> ChemdescecfpSeries {
  { vals, name, meta: 0 }
}

pub fn ChemdescecfpSeries::len(self : ChemdescecfpSeries) -> Int { self.vals.length() }

pub fn ChemdescecfpSeries::sum(self : ChemdescecfpSeries) -> Double { @_common.sum(self.vals) }

pub fn ChemdescecfpSeries::mean(self : ChemdescecfpSeries) -> Double { @_common.mean(self.vals) }

pub fn ChemdescecfpSeries::min(self : ChemdescecfpSeries) -> Double { @_common.min(self.vals) }

pub fn ChemdescecfpSeries::max(self : ChemdescecfpSeries) -> Double { @_common.max(self.vals) }

pub fn ChemdescecfpSeries::range(self : ChemdescecfpSeries) -> Double {
  @_common.max(self.vals) - @_common.min(self.vals)
}

pub fn ChemdescecfpSeries::variance(self : ChemdescecfpSeries) -> Double { @_common.variance(self.vals) }

pub fn ChemdescecfpSeries::std(self : ChemdescecfpSeries) -> Double { @_common.std(self.vals) }

pub fn ChemdescecfpSeries::median(self : ChemdescecfpSeries) -> Double { @_common.median(self.vals) }

pub fn ChemdescecfpSeries::scale(self : ChemdescecfpSeries, f : Double) -> ChemdescecfpSeries {
  { vals: @_common.scale_arr(self.vals, f), name: self.name, meta: self.meta }
}

pub fn ChemdescecfpSeries::add(self : ChemdescecfpSeries, other : ChemdescecfpSeries) -> ChemdescecfpSeries {
  { vals: @_common.add_arr(self.vals, other.vals), name: self.name + "+" + other.name, meta: self.meta }
}

pub fn ChemdescecfpSeries::sub(self : ChemdescecfpSeries, other : ChemdescecfpSeries) -> ChemdescecfpSeries {
  { vals: @_common.sub_arr(self.vals, other.vals), name: self.name + "-" + other.name, meta: self.meta }
}

pub fn ChemdescecfpSeries::normalize(self : ChemdescecfpSeries) -> ChemdescecfpSeries {
  let mn = self.min()
  let mx = self.max()
  let r = mx - mn
  if r < 0.0000001 { self } else {
    let result = []
    for i in 0..<self.vals.length() { result.push((self.vals[i] - mn) / r) }
    { vals: result, name: self.name, meta: self.meta }
  }
}

pub fn ChemdescecfpSeries::cumsum(self : ChemdescecfpSeries) -> ChemdescecfpSeries {
  { vals: @_common.cumsum(self.vals), name: self.name + "_cumsum", meta: self.meta }
}

pub fn ChemdescecfpSeries::to_string(self : ChemdescecfpSeries) -> String {
  let mut result = self.name + "["
  let n = self.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescecfpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_ecfp_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescecfpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_ecfp_matrix_identity(n : Int) -> ChemdescecfpMatrix {
  let m = chem_desc_ecfp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ChemdescecfpMatrix::get(self : ChemdescecfpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= self.rows || j < 0 || j >= self.cols { 0.0 } else { self.data[i][j] }
}

pub fn ChemdescecfpMatrix::transpose(self : ChemdescecfpMatrix) -> ChemdescecfpMatrix {
  let result = chem_desc_ecfp_make_matrix(self.cols, self.rows, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[j][i] = self.data[i][j] } }
  result
}

pub fn ChemdescecfpMatrix::add(self : ChemdescecfpMatrix, other : ChemdescecfpMatrix) -> ChemdescecfpMatrix {
  if self.rows != other.rows || self.cols != other.cols { return self }
  let result = chem_desc_ecfp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] + other.data[i][j] } }
  result
}

pub fn ChemdescecfpMatrix::scale(self : ChemdescecfpMatrix, s : Double) -> ChemdescecfpMatrix {
  let result = chem_desc_ecfp_make_matrix(self.rows, self.cols, 0.0)
  for i in 0..<self.rows { for j in 0..<self.cols { result.data[i][j] = self.data[i][j] * s } }
  result
}

pub fn ChemdescecfpMatrix::multiply(self : ChemdescecfpMatrix, other : ChemdescecfpMatrix) -> ChemdescecfpMatrix {
  if self.cols != other.rows { return chem_desc_ecfp_make_matrix(self.rows, other.cols, 0.0) }
  let result = chem_desc_ecfp_make_matrix(self.rows, other.cols, 0.0)
  for i in 0..<self.rows {
    for j in 0..<other.cols {
      let mut sum = 0.0
      for k in 0..<self.cols { sum = sum + self.data[i][k] * other.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ChemdescecfpMatrix::trace(self : ChemdescecfpMatrix) -> Double {
  let n = if self.rows < self.cols { self.rows } else { self.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.data[i][i] }
  sum
}

pub fn ChemdescecfpMatrix::det(self : ChemdescecfpMatrix) -> Double {
  if self.rows != self.cols { 0.0 } else if self.rows == 1 { self.data[0][0] } else if self.rows == 2 {
    self.data[0][0] * self.data[1][1] - self.data[0][1] * self.data[1][0]
  } else if self.rows == 3 {
    let a = self.data[0][0] * (self.data[1][1] * self.data[2][2] - self.data[1][2] * self.data[2][1])
    let b = self.data[0][1] * (self.data[1][0] * self.data[2][2] - self.data[1][2] * self.data[2][0])
    let c = self.data[0][2] * (self.data[1][0] * self.data[2][1] - self.data[1][1] * self.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ChemdescecfpMatrix::norm(self : ChemdescecfpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<self.rows { for j in 0..<self.cols { sum = sum + self.data[i][j] * self.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ChemdescecfpMatrix::to_string(self : ChemdescecfpMatrix) -> String {
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

pub(all) struct ChemdescecfpVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_ecfp_make_vector(comps : Array[Double]) -> ChemdescecfpVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_ecfp_vector_zero(dim : Int) -> ChemdescecfpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ChemdescecfpVector::add(self : ChemdescecfpVector, other : ChemdescecfpVector) -> ChemdescecfpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.add_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescecfpVector::sub(self : ChemdescecfpVector, other : ChemdescecfpVector) -> ChemdescecfpVector {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  { comps: @_common.sub_arr(self.comps, other.comps), dim: n }
}

pub fn ChemdescecfpVector::scale(self : ChemdescecfpVector, s : Double) -> ChemdescecfpVector {
  { comps: @_common.scale_arr(self.comps, s), dim: self.dim }
}

pub fn ChemdescecfpVector::dot(self : ChemdescecfpVector, other : ChemdescecfpVector) -> Double {
  let n = if self.dim < other.dim { self.dim } else { other.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + self.comps[i] * other.comps[i] }
  sum
}

pub fn ChemdescecfpVector::norm(self : ChemdescecfpVector) -> Double { self.dot(self) |> @_common.sqrt }

pub fn ChemdescecfpVector::normalize(self : ChemdescecfpVector) -> ChemdescecfpVector {
  let n = self.norm()
  if n < 0.0000001 { self } else { self.scale(1.0 / n) }
}

pub fn ChemdescecfpVector::dist(self : ChemdescecfpVector, other : ChemdescecfpVector) -> Double {
  self.sub(other).norm()
}

pub fn ChemdescecfpVector::to_string(self : ChemdescecfpVector) -> String {
  let mut result = "["
  let lim = if self.dim < 10 { self.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(self.comps[i]) }
  if self.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_ecfp_mean(data : Array[Double]) -> Double { @_common.mean(data) }

pub fn chem_desc_ecfp_var(data : Array[Double]) -> Double { @_common.variance(data) }

pub fn chem_desc_ecfp_std(data : Array[Double]) -> Double { @_common.std(data) }

pub fn chem_desc_ecfp_cov(a : Array[Double], b : Array[Double]) -> Double { @_common.cov(a, b) }

pub fn chem_desc_ecfp_corr(a : Array[Double], b : Array[Double]) -> Double { @_common.corr(a, b) }

pub fn chem_desc_ecfp_median(data : Array[Double]) -> Double { @_common.median(data) }

pub fn chem_desc_ecfp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double { @_common.accuracy(pred, labels) }

pub fn chem_desc_ecfp_mse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mse(pred, labels) }

pub fn chem_desc_ecfp_rmse(pred : Array[Double], labels : Array[Double]) -> Double { @_common.rmse(pred, labels) }

pub fn chem_desc_ecfp_mae(pred : Array[Double], labels : Array[Double]) -> Double { @_common.mae(pred, labels) }

pub fn chem_desc_ecfp_r2(pred : Array[Double], labels : Array[Double]) -> Double { @_common.r2(pred, labels) }

pub fn chem_desc_ecfp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.precision(pred, labels, pos) }

pub fn chem_desc_ecfp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.recall(pred, labels, pos) }

pub fn chem_desc_ecfp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double { @_common.f1(pred, labels, pos) }

pub fn chem_desc_ecfp_sort(arr : Array[Double]) -> Array[Double] { @_common.sort(arr) }

pub fn chem_desc_ecfp_sort_desc(arr : Array[Double]) -> Array[Double] { @_common.sort_desc(arr) }

pub fn chem_desc_ecfp_factorial(n : Int) -> Double { @_common.factorial(n) }

pub fn chem_desc_ecfp_gcd(a : Int, b : Int) -> Int { @_common.gcd(a, b) }

pub fn chem_desc_ecfp_lcm(a : Int, b : Int) -> Int { @_common.lcm(a, b) }

pub fn chem_desc_ecfp_is_prime(n : Int) -> Bool { @_common.is_prime(n) }

pub fn chem_desc_ecfp_fibonacci(n : Int) -> Int { @_common.fibonacci(n) }

pub fn chem_desc_ecfp_normalize(data : Array[Double]) -> Array[Double] { @_common.normalize(data) }

pub fn chem_desc_ecfp_standardize(data : Array[Double]) -> Array[Double] { @_common.standardize(data) }

pub fn chem_desc_ecfp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] { @_common.clip(data, lo, hi) }

pub fn chem_desc_ecfp_min(data : Array[Double]) -> Double { @_common.min(data) }

pub fn chem_desc_ecfp_max(data : Array[Double]) -> Double { @_common.max(data) }

pub fn chem_desc_ecfp_cumsum(data : Array[Double]) -> Array[Double] { @_common.cumsum(data) }

pub fn chem_desc_ecfp_reverse(data : Array[Double]) -> Array[Double] { @_common.reverse(data) }

pub fn chem_desc_ecfp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] { @_common.concat(a, b) }

pub(all) struct ChemdescecfpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_frame_make(size : Int) -> ChemdescecfpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_frame_len(s : ChemdescecfpFrame) -> Int { s.size }

pub fn chem_desc_ecfp_frame_get(s : ChemdescecfpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_frame_set(s : ChemdescecfpFrame, i : Int, v : Double) -> ChemdescecfpFrame {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_frame_sum(s : ChemdescecfpFrame) -> Double { @_common.sum(s.data) }

pub fn chem_desc_ecfp_frame_mean(s : ChemdescecfpFrame) -> Double { @_common.mean(s.data) }

pub fn chem_desc_ecfp_frame_scale(s : ChemdescecfpFrame, f : Double) -> ChemdescecfpFrame {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_frame_add(a : ChemdescecfpFrame, b : ChemdescecfpFrame) -> ChemdescecfpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_ecfp_frame_copy(s : ChemdescecfpFrame) -> ChemdescecfpFrame {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_frame_fill(s : ChemdescecfpFrame, v : Double) -> ChemdescecfpFrame {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_frame_min(s : ChemdescecfpFrame) -> Double { @_common.min(s.data) }

pub fn chem_desc_ecfp_frame_max(s : ChemdescecfpFrame) -> Double { @_common.max(s.data) }

pub fn chem_desc_ecfp_frame_to_string(s : ChemdescecfpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_table_make(size : Int) -> ChemdescecfpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_table_len(s : ChemdescecfpTable) -> Int { s.size }

pub fn chem_desc_ecfp_table_get(s : ChemdescecfpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_table_set(s : ChemdescecfpTable, i : Int, v : Double) -> ChemdescecfpTable {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_table_sum(s : ChemdescecfpTable) -> Double { @_common.sum(s.data) }

pub fn chem_desc_ecfp_table_mean(s : ChemdescecfpTable) -> Double { @_common.mean(s.data) }

pub fn chem_desc_ecfp_table_scale(s : ChemdescecfpTable, f : Double) -> ChemdescecfpTable {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_table_add(a : ChemdescecfpTable, b : ChemdescecfpTable) -> ChemdescecfpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_ecfp_table_copy(s : ChemdescecfpTable) -> ChemdescecfpTable {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_table_fill(s : ChemdescecfpTable, v : Double) -> ChemdescecfpTable {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_table_min(s : ChemdescecfpTable) -> Double { @_common.min(s.data) }

pub fn chem_desc_ecfp_table_max(s : ChemdescecfpTable) -> Double { @_common.max(s.data) }

pub fn chem_desc_ecfp_table_to_string(s : ChemdescecfpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_graphn_make(size : Int) -> ChemdescecfpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_graphn_len(s : ChemdescecfpGraphN) -> Int { s.size }

pub fn chem_desc_ecfp_graphn_get(s : ChemdescecfpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_graphn_set(s : ChemdescecfpGraphN, i : Int, v : Double) -> ChemdescecfpGraphN {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_graphn_sum(s : ChemdescecfpGraphN) -> Double { @_common.sum(s.data) }

pub fn chem_desc_ecfp_graphn_mean(s : ChemdescecfpGraphN) -> Double { @_common.mean(s.data) }

pub fn chem_desc_ecfp_graphn_scale(s : ChemdescecfpGraphN, f : Double) -> ChemdescecfpGraphN {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_graphn_add(a : ChemdescecfpGraphN, b : ChemdescecfpGraphN) -> ChemdescecfpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_ecfp_graphn_copy(s : ChemdescecfpGraphN) -> ChemdescecfpGraphN {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_graphn_fill(s : ChemdescecfpGraphN, v : Double) -> ChemdescecfpGraphN {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_graphn_min(s : ChemdescecfpGraphN) -> Double { @_common.min(s.data) }

pub fn chem_desc_ecfp_graphn_max(s : ChemdescecfpGraphN) -> Double { @_common.max(s.data) }

pub fn chem_desc_ecfp_graphn_to_string(s : ChemdescecfpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_node_make(size : Int) -> ChemdescecfpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_node_len(s : ChemdescecfpNode) -> Int { s.size }

pub fn chem_desc_ecfp_node_get(s : ChemdescecfpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_node_set(s : ChemdescecfpNode, i : Int, v : Double) -> ChemdescecfpNode {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_node_sum(s : ChemdescecfpNode) -> Double { @_common.sum(s.data) }

pub fn chem_desc_ecfp_node_mean(s : ChemdescecfpNode) -> Double { @_common.mean(s.data) }

pub fn chem_desc_ecfp_node_scale(s : ChemdescecfpNode, f : Double) -> ChemdescecfpNode {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_node_add(a : ChemdescecfpNode, b : ChemdescecfpNode) -> ChemdescecfpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_ecfp_node_copy(s : ChemdescecfpNode) -> ChemdescecfpNode {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_node_fill(s : ChemdescecfpNode, v : Double) -> ChemdescecfpNode {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_node_min(s : ChemdescecfpNode) -> Double { @_common.min(s.data) }

pub fn chem_desc_ecfp_node_max(s : ChemdescecfpNode) -> Double { @_common.max(s.data) }

pub fn chem_desc_ecfp_node_to_string(s : ChemdescecfpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_edge_make(size : Int) -> ChemdescecfpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_edge_len(s : ChemdescecfpEdge) -> Int { s.size }

pub fn chem_desc_ecfp_edge_get(s : ChemdescecfpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_edge_set(s : ChemdescecfpEdge, i : Int, v : Double) -> ChemdescecfpEdge {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_edge_sum(s : ChemdescecfpEdge) -> Double { @_common.sum(s.data) }

pub fn chem_desc_ecfp_edge_mean(s : ChemdescecfpEdge) -> Double { @_common.mean(s.data) }

pub fn chem_desc_ecfp_edge_scale(s : ChemdescecfpEdge, f : Double) -> ChemdescecfpEdge {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_edge_add(a : ChemdescecfpEdge, b : ChemdescecfpEdge) -> ChemdescecfpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_ecfp_edge_copy(s : ChemdescecfpEdge) -> ChemdescecfpEdge {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_edge_fill(s : ChemdescecfpEdge, v : Double) -> ChemdescecfpEdge {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_edge_min(s : ChemdescecfpEdge) -> Double { @_common.min(s.data) }

pub fn chem_desc_ecfp_edge_max(s : ChemdescecfpEdge) -> Double { @_common.max(s.data) }

pub fn chem_desc_ecfp_edge_to_string(s : ChemdescecfpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_path_make(size : Int) -> ChemdescecfpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_path_len(s : ChemdescecfpPath) -> Int { s.size }

pub fn chem_desc_ecfp_path_get(s : ChemdescecfpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_path_set(s : ChemdescecfpPath, i : Int, v : Double) -> ChemdescecfpPath {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_path_sum(s : ChemdescecfpPath) -> Double { @_common.sum(s.data) }

pub fn chem_desc_ecfp_path_mean(s : ChemdescecfpPath) -> Double { @_common.mean(s.data) }

pub fn chem_desc_ecfp_path_scale(s : ChemdescecfpPath, f : Double) -> ChemdescecfpPath {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_path_add(a : ChemdescecfpPath, b : ChemdescecfpPath) -> ChemdescecfpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_ecfp_path_copy(s : ChemdescecfpPath) -> ChemdescecfpPath {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_path_fill(s : ChemdescecfpPath, v : Double) -> ChemdescecfpPath {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_path_min(s : ChemdescecfpPath) -> Double { @_common.min(s.data) }

pub fn chem_desc_ecfp_path_max(s : ChemdescecfpPath) -> Double { @_common.max(s.data) }

pub fn chem_desc_ecfp_path_to_string(s : ChemdescecfpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_cluster_make(size : Int) -> ChemdescecfpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_cluster_len(s : ChemdescecfpCluster) -> Int { s.size }

pub fn chem_desc_ecfp_cluster_get(s : ChemdescecfpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_cluster_set(s : ChemdescecfpCluster, i : Int, v : Double) -> ChemdescecfpCluster {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_cluster_sum(s : ChemdescecfpCluster) -> Double { @_common.sum(s.data) }

pub fn chem_desc_ecfp_cluster_mean(s : ChemdescecfpCluster) -> Double { @_common.mean(s.data) }

pub fn chem_desc_ecfp_cluster_scale(s : ChemdescecfpCluster, f : Double) -> ChemdescecfpCluster {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_cluster_add(a : ChemdescecfpCluster, b : ChemdescecfpCluster) -> ChemdescecfpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_ecfp_cluster_copy(s : ChemdescecfpCluster) -> ChemdescecfpCluster {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_cluster_fill(s : ChemdescecfpCluster, v : Double) -> ChemdescecfpCluster {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_cluster_min(s : ChemdescecfpCluster) -> Double { @_common.min(s.data) }

pub fn chem_desc_ecfp_cluster_max(s : ChemdescecfpCluster) -> Double { @_common.max(s.data) }

pub fn chem_desc_ecfp_cluster_to_string(s : ChemdescecfpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_model_make(size : Int) -> ChemdescecfpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_model_len(s : ChemdescecfpModel) -> Int { s.size }

pub fn chem_desc_ecfp_model_get(s : ChemdescecfpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_model_set(s : ChemdescecfpModel, i : Int, v : Double) -> ChemdescecfpModel {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_model_sum(s : ChemdescecfpModel) -> Double { @_common.sum(s.data) }

pub fn chem_desc_ecfp_model_mean(s : ChemdescecfpModel) -> Double { @_common.mean(s.data) }

pub fn chem_desc_ecfp_model_scale(s : ChemdescecfpModel, f : Double) -> ChemdescecfpModel {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_model_add(a : ChemdescecfpModel, b : ChemdescecfpModel) -> ChemdescecfpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_ecfp_model_copy(s : ChemdescecfpModel) -> ChemdescecfpModel {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_model_fill(s : ChemdescecfpModel, v : Double) -> ChemdescecfpModel {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_model_min(s : ChemdescecfpModel) -> Double { @_common.min(s.data) }

pub fn chem_desc_ecfp_model_max(s : ChemdescecfpModel) -> Double { @_common.max(s.data) }

pub fn chem_desc_ecfp_model_to_string(s : ChemdescecfpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_layer_make(size : Int) -> ChemdescecfpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_layer_len(s : ChemdescecfpLayer) -> Int { s.size }

pub fn chem_desc_ecfp_layer_get(s : ChemdescecfpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_layer_set(s : ChemdescecfpLayer, i : Int, v : Double) -> ChemdescecfpLayer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_layer_sum(s : ChemdescecfpLayer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_ecfp_layer_mean(s : ChemdescecfpLayer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_ecfp_layer_scale(s : ChemdescecfpLayer, f : Double) -> ChemdescecfpLayer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_layer_add(a : ChemdescecfpLayer, b : ChemdescecfpLayer) -> ChemdescecfpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_ecfp_layer_copy(s : ChemdescecfpLayer) -> ChemdescecfpLayer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_layer_fill(s : ChemdescecfpLayer, v : Double) -> ChemdescecfpLayer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_layer_min(s : ChemdescecfpLayer) -> Double { @_common.min(s.data) }

pub fn chem_desc_ecfp_layer_max(s : ChemdescecfpLayer) -> Double { @_common.max(s.data) }

pub fn chem_desc_ecfp_layer_to_string(s : ChemdescecfpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_buffer_make(size : Int) -> ChemdescecfpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_buffer_len(s : ChemdescecfpBuffer) -> Int { s.size }

pub fn chem_desc_ecfp_buffer_get(s : ChemdescecfpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_buffer_set(s : ChemdescecfpBuffer, i : Int, v : Double) -> ChemdescecfpBuffer {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_buffer_sum(s : ChemdescecfpBuffer) -> Double { @_common.sum(s.data) }

pub fn chem_desc_ecfp_buffer_mean(s : ChemdescecfpBuffer) -> Double { @_common.mean(s.data) }

pub fn chem_desc_ecfp_buffer_scale(s : ChemdescecfpBuffer, f : Double) -> ChemdescecfpBuffer {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_buffer_add(a : ChemdescecfpBuffer, b : ChemdescecfpBuffer) -> ChemdescecfpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_ecfp_buffer_copy(s : ChemdescecfpBuffer) -> ChemdescecfpBuffer {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_buffer_fill(s : ChemdescecfpBuffer, v : Double) -> ChemdescecfpBuffer {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_buffer_min(s : ChemdescecfpBuffer) -> Double { @_common.min(s.data) }

pub fn chem_desc_ecfp_buffer_max(s : ChemdescecfpBuffer) -> Double { @_common.max(s.data) }

pub fn chem_desc_ecfp_buffer_to_string(s : ChemdescecfpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_cursor_make(size : Int) -> ChemdescecfpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_cursor_len(s : ChemdescecfpCursor) -> Int { s.size }

pub fn chem_desc_ecfp_cursor_get(s : ChemdescecfpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_cursor_set(s : ChemdescecfpCursor, i : Int, v : Double) -> ChemdescecfpCursor {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_cursor_sum(s : ChemdescecfpCursor) -> Double { @_common.sum(s.data) }

pub fn chem_desc_ecfp_cursor_mean(s : ChemdescecfpCursor) -> Double { @_common.mean(s.data) }

pub fn chem_desc_ecfp_cursor_scale(s : ChemdescecfpCursor, f : Double) -> ChemdescecfpCursor {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_cursor_add(a : ChemdescecfpCursor, b : ChemdescecfpCursor) -> ChemdescecfpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_ecfp_cursor_copy(s : ChemdescecfpCursor) -> ChemdescecfpCursor {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_cursor_fill(s : ChemdescecfpCursor, v : Double) -> ChemdescecfpCursor {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_cursor_min(s : ChemdescecfpCursor) -> Double { @_common.min(s.data) }

pub fn chem_desc_ecfp_cursor_max(s : ChemdescecfpCursor) -> Double { @_common.max(s.data) }

pub fn chem_desc_ecfp_cursor_to_string(s : ChemdescecfpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_view_make(size : Int) -> ChemdescecfpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_view_len(s : ChemdescecfpView) -> Int { s.size }

pub fn chem_desc_ecfp_view_get(s : ChemdescecfpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_view_set(s : ChemdescecfpView, i : Int, v : Double) -> ChemdescecfpView {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_view_sum(s : ChemdescecfpView) -> Double { @_common.sum(s.data) }

pub fn chem_desc_ecfp_view_mean(s : ChemdescecfpView) -> Double { @_common.mean(s.data) }

pub fn chem_desc_ecfp_view_scale(s : ChemdescecfpView, f : Double) -> ChemdescecfpView {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_view_add(a : ChemdescecfpView, b : ChemdescecfpView) -> ChemdescecfpView {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_ecfp_view_copy(s : ChemdescecfpView) -> ChemdescecfpView {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_view_fill(s : ChemdescecfpView, v : Double) -> ChemdescecfpView {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_view_min(s : ChemdescecfpView) -> Double { @_common.min(s.data) }

pub fn chem_desc_ecfp_view_max(s : ChemdescecfpView) -> Double { @_common.max(s.data) }

pub fn chem_desc_ecfp_view_to_string(s : ChemdescecfpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_range_make(size : Int) -> ChemdescecfpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_range_len(s : ChemdescecfpRange) -> Int { s.size }

pub fn chem_desc_ecfp_range_get(s : ChemdescecfpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_range_set(s : ChemdescecfpRange, i : Int, v : Double) -> ChemdescecfpRange {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_range_sum(s : ChemdescecfpRange) -> Double { @_common.sum(s.data) }

pub fn chem_desc_ecfp_range_mean(s : ChemdescecfpRange) -> Double { @_common.mean(s.data) }

pub fn chem_desc_ecfp_range_scale(s : ChemdescecfpRange, f : Double) -> ChemdescecfpRange {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_range_add(a : ChemdescecfpRange, b : ChemdescecfpRange) -> ChemdescecfpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_ecfp_range_copy(s : ChemdescecfpRange) -> ChemdescecfpRange {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_range_fill(s : ChemdescecfpRange, v : Double) -> ChemdescecfpRange {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_range_min(s : ChemdescecfpRange) -> Double { @_common.min(s.data) }

pub fn chem_desc_ecfp_range_max(s : ChemdescecfpRange) -> Double { @_common.max(s.data) }

pub fn chem_desc_ecfp_range_to_string(s : ChemdescecfpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescecfpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_ecfp_slice_make(size : Int) -> ChemdescecfpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_ecfp_slice_len(s : ChemdescecfpSlice) -> Int { s.size }

pub fn chem_desc_ecfp_slice_get(s : ChemdescecfpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_ecfp_slice_set(s : ChemdescecfpSlice, i : Int, v : Double) -> ChemdescecfpSlice {
  let data = @_common.copy_arr(s.data)
  if i >= 0 && i < s.size { data[i] = v }
  { data, size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_slice_sum(s : ChemdescecfpSlice) -> Double { @_common.sum(s.data) }

pub fn chem_desc_ecfp_slice_mean(s : ChemdescecfpSlice) -> Double { @_common.mean(s.data) }

pub fn chem_desc_ecfp_slice_scale(s : ChemdescecfpSlice, f : Double) -> ChemdescecfpSlice {
  { data: @_common.scale_arr(s.data, f), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_slice_add(a : ChemdescecfpSlice, b : ChemdescecfpSlice) -> ChemdescecfpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  { data: @_common.add_arr(a.data, b.data), size: n, tag: a.tag }
}

pub fn chem_desc_ecfp_slice_copy(s : ChemdescecfpSlice) -> ChemdescecfpSlice {
  { data: @_common.copy_arr(s.data), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_slice_fill(s : ChemdescecfpSlice, v : Double) -> ChemdescecfpSlice {
  { data: @_common.fill_arr(s.size, v), size: s.size, tag: s.tag }
}

pub fn chem_desc_ecfp_slice_min(s : ChemdescecfpSlice) -> Double { @_common.min(s.data) }

pub fn chem_desc_ecfp_slice_max(s : ChemdescecfpSlice) -> Double { @_common.max(s.data) }

pub fn chem_desc_ecfp_slice_to_string(s : ChemdescecfpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

