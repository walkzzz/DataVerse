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

pub fn ChemdescfcfpFrame::len(self : ChemdescfcfpFrame) -> Int { self.size }

pub fn ChemdescfcfpFrame::get(self : ChemdescfcfpFrame, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfcfpFrame::set(self : ChemdescfcfpFrame, i : Int, v : Double) -> ChemdescfcfpFrame {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpFrame::sum(self : ChemdescfcfpFrame) -> Double { @_common.sum(self.data) }

pub fn ChemdescfcfpFrame::mean(self : ChemdescfcfpFrame) -> Double { @_common.mean(self.data) }

pub fn ChemdescfcfpFrame::scale(self : ChemdescfcfpFrame, f : Double) -> ChemdescfcfpFrame {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpFrame::add(self : ChemdescfcfpFrame, other : ChemdescfcfpFrame) -> ChemdescfcfpFrame {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfcfpFrame::copy(self : ChemdescfcfpFrame) -> ChemdescfcfpFrame {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpFrame::fill(self : ChemdescfcfpFrame, v : Double) -> ChemdescfcfpFrame {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpFrame::min(self : ChemdescfcfpFrame) -> Double { @_common.min(self.data) }

pub fn ChemdescfcfpFrame::max(self : ChemdescfcfpFrame) -> Double { @_common.max(self.data) }

pub fn ChemdescfcfpFrame::to_string(self : ChemdescfcfpFrame) -> String {
  "Frame[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_table_make(size : Int) -> ChemdescfcfpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfcfpTable::len(self : ChemdescfcfpTable) -> Int { self.size }

pub fn ChemdescfcfpTable::get(self : ChemdescfcfpTable, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfcfpTable::set(self : ChemdescfcfpTable, i : Int, v : Double) -> ChemdescfcfpTable {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpTable::sum(self : ChemdescfcfpTable) -> Double { @_common.sum(self.data) }

pub fn ChemdescfcfpTable::mean(self : ChemdescfcfpTable) -> Double { @_common.mean(self.data) }

pub fn ChemdescfcfpTable::scale(self : ChemdescfcfpTable, f : Double) -> ChemdescfcfpTable {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpTable::add(self : ChemdescfcfpTable, other : ChemdescfcfpTable) -> ChemdescfcfpTable {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfcfpTable::copy(self : ChemdescfcfpTable) -> ChemdescfcfpTable {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpTable::fill(self : ChemdescfcfpTable, v : Double) -> ChemdescfcfpTable {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpTable::min(self : ChemdescfcfpTable) -> Double { @_common.min(self.data) }

pub fn ChemdescfcfpTable::max(self : ChemdescfcfpTable) -> Double { @_common.max(self.data) }

pub fn ChemdescfcfpTable::to_string(self : ChemdescfcfpTable) -> String {
  "Table[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_graphn_make(size : Int) -> ChemdescfcfpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfcfpGraphN::len(self : ChemdescfcfpGraphN) -> Int { self.size }

pub fn ChemdescfcfpGraphN::get(self : ChemdescfcfpGraphN, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfcfpGraphN::set(self : ChemdescfcfpGraphN, i : Int, v : Double) -> ChemdescfcfpGraphN {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpGraphN::sum(self : ChemdescfcfpGraphN) -> Double { @_common.sum(self.data) }

pub fn ChemdescfcfpGraphN::mean(self : ChemdescfcfpGraphN) -> Double { @_common.mean(self.data) }

pub fn ChemdescfcfpGraphN::scale(self : ChemdescfcfpGraphN, f : Double) -> ChemdescfcfpGraphN {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpGraphN::add(self : ChemdescfcfpGraphN, other : ChemdescfcfpGraphN) -> ChemdescfcfpGraphN {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfcfpGraphN::copy(self : ChemdescfcfpGraphN) -> ChemdescfcfpGraphN {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpGraphN::fill(self : ChemdescfcfpGraphN, v : Double) -> ChemdescfcfpGraphN {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpGraphN::min(self : ChemdescfcfpGraphN) -> Double { @_common.min(self.data) }

pub fn ChemdescfcfpGraphN::max(self : ChemdescfcfpGraphN) -> Double { @_common.max(self.data) }

pub fn ChemdescfcfpGraphN::to_string(self : ChemdescfcfpGraphN) -> String {
  "GraphN[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_node_make(size : Int) -> ChemdescfcfpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfcfpNode::len(self : ChemdescfcfpNode) -> Int { self.size }

pub fn ChemdescfcfpNode::get(self : ChemdescfcfpNode, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfcfpNode::set(self : ChemdescfcfpNode, i : Int, v : Double) -> ChemdescfcfpNode {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpNode::sum(self : ChemdescfcfpNode) -> Double { @_common.sum(self.data) }

pub fn ChemdescfcfpNode::mean(self : ChemdescfcfpNode) -> Double { @_common.mean(self.data) }

pub fn ChemdescfcfpNode::scale(self : ChemdescfcfpNode, f : Double) -> ChemdescfcfpNode {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpNode::add(self : ChemdescfcfpNode, other : ChemdescfcfpNode) -> ChemdescfcfpNode {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfcfpNode::copy(self : ChemdescfcfpNode) -> ChemdescfcfpNode {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpNode::fill(self : ChemdescfcfpNode, v : Double) -> ChemdescfcfpNode {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpNode::min(self : ChemdescfcfpNode) -> Double { @_common.min(self.data) }

pub fn ChemdescfcfpNode::max(self : ChemdescfcfpNode) -> Double { @_common.max(self.data) }

pub fn ChemdescfcfpNode::to_string(self : ChemdescfcfpNode) -> String {
  "Node[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_edge_make(size : Int) -> ChemdescfcfpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfcfpEdge::len(self : ChemdescfcfpEdge) -> Int { self.size }

pub fn ChemdescfcfpEdge::get(self : ChemdescfcfpEdge, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfcfpEdge::set(self : ChemdescfcfpEdge, i : Int, v : Double) -> ChemdescfcfpEdge {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpEdge::sum(self : ChemdescfcfpEdge) -> Double { @_common.sum(self.data) }

pub fn ChemdescfcfpEdge::mean(self : ChemdescfcfpEdge) -> Double { @_common.mean(self.data) }

pub fn ChemdescfcfpEdge::scale(self : ChemdescfcfpEdge, f : Double) -> ChemdescfcfpEdge {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpEdge::add(self : ChemdescfcfpEdge, other : ChemdescfcfpEdge) -> ChemdescfcfpEdge {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfcfpEdge::copy(self : ChemdescfcfpEdge) -> ChemdescfcfpEdge {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpEdge::fill(self : ChemdescfcfpEdge, v : Double) -> ChemdescfcfpEdge {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpEdge::min(self : ChemdescfcfpEdge) -> Double { @_common.min(self.data) }

pub fn ChemdescfcfpEdge::max(self : ChemdescfcfpEdge) -> Double { @_common.max(self.data) }

pub fn ChemdescfcfpEdge::to_string(self : ChemdescfcfpEdge) -> String {
  "Edge[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_path_make(size : Int) -> ChemdescfcfpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfcfpPath::len(self : ChemdescfcfpPath) -> Int { self.size }

pub fn ChemdescfcfpPath::get(self : ChemdescfcfpPath, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfcfpPath::set(self : ChemdescfcfpPath, i : Int, v : Double) -> ChemdescfcfpPath {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpPath::sum(self : ChemdescfcfpPath) -> Double { @_common.sum(self.data) }

pub fn ChemdescfcfpPath::mean(self : ChemdescfcfpPath) -> Double { @_common.mean(self.data) }

pub fn ChemdescfcfpPath::scale(self : ChemdescfcfpPath, f : Double) -> ChemdescfcfpPath {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpPath::add(self : ChemdescfcfpPath, other : ChemdescfcfpPath) -> ChemdescfcfpPath {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfcfpPath::copy(self : ChemdescfcfpPath) -> ChemdescfcfpPath {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpPath::fill(self : ChemdescfcfpPath, v : Double) -> ChemdescfcfpPath {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpPath::min(self : ChemdescfcfpPath) -> Double { @_common.min(self.data) }

pub fn ChemdescfcfpPath::max(self : ChemdescfcfpPath) -> Double { @_common.max(self.data) }

pub fn ChemdescfcfpPath::to_string(self : ChemdescfcfpPath) -> String {
  "Path[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_cluster_make(size : Int) -> ChemdescfcfpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfcfpCluster::len(self : ChemdescfcfpCluster) -> Int { self.size }

pub fn ChemdescfcfpCluster::get(self : ChemdescfcfpCluster, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfcfpCluster::set(self : ChemdescfcfpCluster, i : Int, v : Double) -> ChemdescfcfpCluster {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpCluster::sum(self : ChemdescfcfpCluster) -> Double { @_common.sum(self.data) }

pub fn ChemdescfcfpCluster::mean(self : ChemdescfcfpCluster) -> Double { @_common.mean(self.data) }

pub fn ChemdescfcfpCluster::scale(self : ChemdescfcfpCluster, f : Double) -> ChemdescfcfpCluster {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpCluster::add(self : ChemdescfcfpCluster, other : ChemdescfcfpCluster) -> ChemdescfcfpCluster {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfcfpCluster::copy(self : ChemdescfcfpCluster) -> ChemdescfcfpCluster {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpCluster::fill(self : ChemdescfcfpCluster, v : Double) -> ChemdescfcfpCluster {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpCluster::min(self : ChemdescfcfpCluster) -> Double { @_common.min(self.data) }

pub fn ChemdescfcfpCluster::max(self : ChemdescfcfpCluster) -> Double { @_common.max(self.data) }

pub fn ChemdescfcfpCluster::to_string(self : ChemdescfcfpCluster) -> String {
  "Cluster[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_model_make(size : Int) -> ChemdescfcfpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfcfpModel::len(self : ChemdescfcfpModel) -> Int { self.size }

pub fn ChemdescfcfpModel::get(self : ChemdescfcfpModel, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfcfpModel::set(self : ChemdescfcfpModel, i : Int, v : Double) -> ChemdescfcfpModel {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpModel::sum(self : ChemdescfcfpModel) -> Double { @_common.sum(self.data) }

pub fn ChemdescfcfpModel::mean(self : ChemdescfcfpModel) -> Double { @_common.mean(self.data) }

pub fn ChemdescfcfpModel::scale(self : ChemdescfcfpModel, f : Double) -> ChemdescfcfpModel {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpModel::add(self : ChemdescfcfpModel, other : ChemdescfcfpModel) -> ChemdescfcfpModel {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfcfpModel::copy(self : ChemdescfcfpModel) -> ChemdescfcfpModel {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpModel::fill(self : ChemdescfcfpModel, v : Double) -> ChemdescfcfpModel {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpModel::min(self : ChemdescfcfpModel) -> Double { @_common.min(self.data) }

pub fn ChemdescfcfpModel::max(self : ChemdescfcfpModel) -> Double { @_common.max(self.data) }

pub fn ChemdescfcfpModel::to_string(self : ChemdescfcfpModel) -> String {
  "Model[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_layer_make(size : Int) -> ChemdescfcfpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfcfpLayer::len(self : ChemdescfcfpLayer) -> Int { self.size }

pub fn ChemdescfcfpLayer::get(self : ChemdescfcfpLayer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfcfpLayer::set(self : ChemdescfcfpLayer, i : Int, v : Double) -> ChemdescfcfpLayer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpLayer::sum(self : ChemdescfcfpLayer) -> Double { @_common.sum(self.data) }

pub fn ChemdescfcfpLayer::mean(self : ChemdescfcfpLayer) -> Double { @_common.mean(self.data) }

pub fn ChemdescfcfpLayer::scale(self : ChemdescfcfpLayer, f : Double) -> ChemdescfcfpLayer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpLayer::add(self : ChemdescfcfpLayer, other : ChemdescfcfpLayer) -> ChemdescfcfpLayer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfcfpLayer::copy(self : ChemdescfcfpLayer) -> ChemdescfcfpLayer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpLayer::fill(self : ChemdescfcfpLayer, v : Double) -> ChemdescfcfpLayer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpLayer::min(self : ChemdescfcfpLayer) -> Double { @_common.min(self.data) }

pub fn ChemdescfcfpLayer::max(self : ChemdescfcfpLayer) -> Double { @_common.max(self.data) }

pub fn ChemdescfcfpLayer::to_string(self : ChemdescfcfpLayer) -> String {
  "Layer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_buffer_make(size : Int) -> ChemdescfcfpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfcfpBuffer::len(self : ChemdescfcfpBuffer) -> Int { self.size }

pub fn ChemdescfcfpBuffer::get(self : ChemdescfcfpBuffer, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfcfpBuffer::set(self : ChemdescfcfpBuffer, i : Int, v : Double) -> ChemdescfcfpBuffer {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpBuffer::sum(self : ChemdescfcfpBuffer) -> Double { @_common.sum(self.data) }

pub fn ChemdescfcfpBuffer::mean(self : ChemdescfcfpBuffer) -> Double { @_common.mean(self.data) }

pub fn ChemdescfcfpBuffer::scale(self : ChemdescfcfpBuffer, f : Double) -> ChemdescfcfpBuffer {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpBuffer::add(self : ChemdescfcfpBuffer, other : ChemdescfcfpBuffer) -> ChemdescfcfpBuffer {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfcfpBuffer::copy(self : ChemdescfcfpBuffer) -> ChemdescfcfpBuffer {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpBuffer::fill(self : ChemdescfcfpBuffer, v : Double) -> ChemdescfcfpBuffer {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpBuffer::min(self : ChemdescfcfpBuffer) -> Double { @_common.min(self.data) }

pub fn ChemdescfcfpBuffer::max(self : ChemdescfcfpBuffer) -> Double { @_common.max(self.data) }

pub fn ChemdescfcfpBuffer::to_string(self : ChemdescfcfpBuffer) -> String {
  "Buffer[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_cursor_make(size : Int) -> ChemdescfcfpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfcfpCursor::len(self : ChemdescfcfpCursor) -> Int { self.size }

pub fn ChemdescfcfpCursor::get(self : ChemdescfcfpCursor, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfcfpCursor::set(self : ChemdescfcfpCursor, i : Int, v : Double) -> ChemdescfcfpCursor {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpCursor::sum(self : ChemdescfcfpCursor) -> Double { @_common.sum(self.data) }

pub fn ChemdescfcfpCursor::mean(self : ChemdescfcfpCursor) -> Double { @_common.mean(self.data) }

pub fn ChemdescfcfpCursor::scale(self : ChemdescfcfpCursor, f : Double) -> ChemdescfcfpCursor {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpCursor::add(self : ChemdescfcfpCursor, other : ChemdescfcfpCursor) -> ChemdescfcfpCursor {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfcfpCursor::copy(self : ChemdescfcfpCursor) -> ChemdescfcfpCursor {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpCursor::fill(self : ChemdescfcfpCursor, v : Double) -> ChemdescfcfpCursor {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpCursor::min(self : ChemdescfcfpCursor) -> Double { @_common.min(self.data) }

pub fn ChemdescfcfpCursor::max(self : ChemdescfcfpCursor) -> Double { @_common.max(self.data) }

pub fn ChemdescfcfpCursor::to_string(self : ChemdescfcfpCursor) -> String {
  "Cursor[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_view_make(size : Int) -> ChemdescfcfpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfcfpView::len(self : ChemdescfcfpView) -> Int { self.size }

pub fn ChemdescfcfpView::get(self : ChemdescfcfpView, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfcfpView::set(self : ChemdescfcfpView, i : Int, v : Double) -> ChemdescfcfpView {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpView::sum(self : ChemdescfcfpView) -> Double { @_common.sum(self.data) }

pub fn ChemdescfcfpView::mean(self : ChemdescfcfpView) -> Double { @_common.mean(self.data) }

pub fn ChemdescfcfpView::scale(self : ChemdescfcfpView, f : Double) -> ChemdescfcfpView {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpView::add(self : ChemdescfcfpView, other : ChemdescfcfpView) -> ChemdescfcfpView {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfcfpView::copy(self : ChemdescfcfpView) -> ChemdescfcfpView {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpView::fill(self : ChemdescfcfpView, v : Double) -> ChemdescfcfpView {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpView::min(self : ChemdescfcfpView) -> Double { @_common.min(self.data) }

pub fn ChemdescfcfpView::max(self : ChemdescfcfpView) -> Double { @_common.max(self.data) }

pub fn ChemdescfcfpView::to_string(self : ChemdescfcfpView) -> String {
  "View[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_range_make(size : Int) -> ChemdescfcfpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfcfpRange::len(self : ChemdescfcfpRange) -> Int { self.size }

pub fn ChemdescfcfpRange::get(self : ChemdescfcfpRange, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfcfpRange::set(self : ChemdescfcfpRange, i : Int, v : Double) -> ChemdescfcfpRange {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpRange::sum(self : ChemdescfcfpRange) -> Double { @_common.sum(self.data) }

pub fn ChemdescfcfpRange::mean(self : ChemdescfcfpRange) -> Double { @_common.mean(self.data) }

pub fn ChemdescfcfpRange::scale(self : ChemdescfcfpRange, f : Double) -> ChemdescfcfpRange {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpRange::add(self : ChemdescfcfpRange, other : ChemdescfcfpRange) -> ChemdescfcfpRange {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfcfpRange::copy(self : ChemdescfcfpRange) -> ChemdescfcfpRange {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpRange::fill(self : ChemdescfcfpRange, v : Double) -> ChemdescfcfpRange {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpRange::min(self : ChemdescfcfpRange) -> Double { @_common.min(self.data) }

pub fn ChemdescfcfpRange::max(self : ChemdescfcfpRange) -> Double { @_common.max(self.data) }

pub fn ChemdescfcfpRange::to_string(self : ChemdescfcfpRange) -> String {
  "Range[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_slice_make(size : Int) -> ChemdescfcfpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ChemdescfcfpSlice::len(self : ChemdescfcfpSlice) -> Int { self.size }

pub fn ChemdescfcfpSlice::get(self : ChemdescfcfpSlice, i : Int) -> Double {
  if i < 0 || i >= self.size { 0.0 } else { self.data[i] }
}

pub fn ChemdescfcfpSlice::set(self : ChemdescfcfpSlice, i : Int, v : Double) -> ChemdescfcfpSlice {
  let data = @_common.copy_arr(self.data)
  if i >= 0 && i < self.size { data[i] = v }
  { data, size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpSlice::sum(self : ChemdescfcfpSlice) -> Double { @_common.sum(self.data) }

pub fn ChemdescfcfpSlice::mean(self : ChemdescfcfpSlice) -> Double { @_common.mean(self.data) }

pub fn ChemdescfcfpSlice::scale(self : ChemdescfcfpSlice, f : Double) -> ChemdescfcfpSlice {
  { data: @_common.scale_arr(self.data, f), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpSlice::add(self : ChemdescfcfpSlice, other : ChemdescfcfpSlice) -> ChemdescfcfpSlice {
  let n = if self.size < other.size { self.size } else { other.size }
  { data: @_common.add_arr(self.data, other.data), size: n, tag: self.tag }
}

pub fn ChemdescfcfpSlice::copy(self : ChemdescfcfpSlice) -> ChemdescfcfpSlice {
  { data: @_common.copy_arr(self.data), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpSlice::fill(self : ChemdescfcfpSlice, v : Double) -> ChemdescfcfpSlice {
  { data: @_common.fill_arr(self.size, v), size: self.size, tag: self.tag }
}

pub fn ChemdescfcfpSlice::min(self : ChemdescfcfpSlice) -> Double { @_common.min(self.data) }

pub fn ChemdescfcfpSlice::max(self : ChemdescfcfpSlice) -> Double { @_common.max(self.data) }

pub fn ChemdescfcfpSlice::to_string(self : ChemdescfcfpSlice) -> String {
  "Slice[" + self.size.to_string() + ",tag=" + self.tag.to_string() + "]"
}

